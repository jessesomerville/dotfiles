#!/bin/zsh
#
# Assertion helpers.

test -n "${CFGLIB_ASSERT_ZSH__:-}" || declare -i CFGLIB_ASSERT_ZSH__=0

if (( CFGLIB_ASSERT_ZSH__++ == 0 )); then

source ${HOME}/.zsh/lib/log.zsh      || exit
source ${HOME}/.zsh/lib/internal.zsh || exit

# Check if the left hand number is == the right hand number.
#
# @param {int} lhs
#   Left hand side operand.
# @param {int} rhs
#   Right hand side operand.
# @optparam {string} message
#   The message to print if the check fails. 
function lib::assert::EQ() {
  lib::internal::CHECK "$# >= 2" "requires at least 2 parameters"
  local -i lhs="${1}"
  local -i rhs="${2}"

  if (( ! (lhs == rhs) )); then
    lib::LOG ERROR "[Failure] ${lhs} == ${rhs}"
    shift 2
    if (( $# )); then
      LOG ERROR "Message: $*"
    fi
    lib::internal::die_quiet
  fi
}

# Check if the left hand number is >= the right hand number.
#
# @param {int} lhs
#   Left hand side operand.
# @param {int} rhs
#   Right hand side operand.
# @optparam {string} message
#   The message to print if the check fails. 
function lib::assert::GE() {
  lib::internal::CHECK "$# >= 2" "requires at least 2 parameters"
  local -i lhs="${1}"
  local -i rhs="${2}"

  if (( ! (lhs >= rhs) )); then
    lib::LOG ERROR "[Failure] ${lhs} >= ${rhs}"
    shift 2
    if (( $# )); then
      lib::LOG ERROR "Message: $*"
    fi
    lib::internal::die_quiet
  fi
}

function lib::internal::CHECK() {
  if (( $# < 1 || ($1) == 0 )); then
    lib::LOG ERROR "[Failure] check $1"
    shift 1
    if (( $# )); then
      typeset caller_func="$(lib::internal::get_caller_name)"
      lib::LOG FATAL "[Message] ${caller_func} $*"
    fi
    lib::internal::die_quiet
  fi
}

fi  # include guard