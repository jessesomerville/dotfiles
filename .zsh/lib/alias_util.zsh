#!/bin/zsh
#
# Convenience helpers for aliases.

test -n "${CFGLIB_ALIAS_UTIL_ZSH__:-}" || declare -i CFGLIB_ALIAS_UTIL_ZSH__=0

if (( CFGLIB_ALIAS_UTIL_ZSH__++ == 0 )); then

source ${HOME}/.zsh/lib/assert.zsh || exit


function ralias() {
  lib::assert::EQ $# 2 "requires exactly 2 args"
  local alias_id="${1}"
  shift
  declare -a alias_cmd_args=( ${=1} )

  if  ! lib::internal::check_cmd ${=1}; then
    lib::LOG ERROR "Failed to register alias \"${alias_id}\": command not found"
    return
  fi
  alias "${alias_id}"="$@"
}

function lib::internal::check_cmd() {
  lib::assert::GE $# 1 "lib::internal::check_cmd requires at least one arg"
  if ! command -v "${1}" 2>&1 >/dev/null; then
    return 1
  fi
  return 0
}

fi  #include guard