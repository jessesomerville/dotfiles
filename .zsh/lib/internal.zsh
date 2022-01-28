#!/bin/zsh
#
# Utility functions.

test -n "${CFGLIB_UTIL_ZSH__:-}" || declare -i CFGLIB_UTIL_ZSH__=0

if (( CFGLIB_UTIL_ZSH__++ == 0 )); then

# If an exit code is specified, this function will exit with it; otherwise,
# it will exit with 1.
#
# @optparam exit_code Exit code.
function lib::internal::die_quiet() {
  exit "${1:-1}"
}

# If an exit code is specified, this function will exit with it; otherwise,
# it will exit with 1.
#
# @param    message   Message to print on exit.
# @optparam exit_code Exit code.
function lib::internal::die() {
  echo "${1:-}"
  exit "${2:-1}"
}

# Print the call stack as "/path/to/file.zsh:12 func_name"
# WRONG
function lib::internal::get_func_trace() {
  declare -a file_trace=( ${funcfiletrace[2,-1]} )
  declare -a func_trace=( ${funcstack[2,-1]} )
  print -rC2 -- "${file_trace[@]}" "${func_trace[@]}"
}

function lib::internal::get_caller_name() {
  declare -a func_trace=( ${funcstack} )
  print -- "${func_trace[3]}"
}

fi