#!/bin/zsh
#
# Utilities for logging output.

test -n "${CFGLIB_LOG_ZSH__:-}" || declare -i CFGLIB_LOG_ZSH__=0

if (( CFGLIB_LOG_ZSH__++ == 0 )); then

source ${HOME}/.zsh/lib/colors.zsh     || exit
source ${HOME}/.zsh/lib/internal.zsh   || exit

declare -i LOG_INCLUDE_TIMESTAMP=0

# Log a message, and die if it's a FATAL message.
#
# @env {int} LOG_INCLUDE_TIMESTAMP
#   If set to 1, a timestamp will be included in the log.
# @param {string} severity
#   The log level. INFO, WARN, ERROR, or FATAL
# @optparam message
#   The message to log.
function lib::LOG() {
  local severity="${1:-}"
  shift 1
  local log_time
  if (( ${LOG_INCLUDE_TIMESTAMP} )); then
    printf -v log_time " %(%F %T)T" -1
  fi

  local log_color
  case "${severity}" in
    INFO)  log_color=blue   ;;
    WARN)  log_color=yellow ;;
    ERROR) log_color=red    ;;
    FATAL) log_color=red    ;;
    *)
      log_color=endcolor
      severity="UNKNOWN"
      ;;
  esac

  colors::echo "" "[" "${log_color}" "${severity}" reset "${log_time}] $*"

  if [[ "${severity}" == "FATAL" ]]; then
    lib::internal::die_quiet
  fi
}

fi