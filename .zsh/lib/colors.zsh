#!/bin/zsh
#
# Utilities for printing colored output.

test -n "${CFGLIB_COLORS_ZSH__:-}" || declare -i CFGLIB_COLORS_ZSH__=0

if (( CFGLIB_COLORS_ZSH__++ == 0 )); then

source ${HOME}/.zsh/lib/assert.zsh || exit
source ${HOME}/.zsh/lib/log.zsh  || exit

declare LIB_LOG_COLORS_STDOUT_IS_TTY=0

# Check if the fd is a terminal.
#
# @param {int} fd 
#   The fd being written to.
# @return {int}
#   0 if fd is a terminal, otherwise 1.
function colors::is_tty() {
  if [[ "$1" == "1" ]] && (( LIB_LOG_COLORS_STDOUT_IS_TTY )) \
    || [[ -t "$1" ]]; then
    return 0
  else
    return 1
  fi
}

# Return the color code for the given keywords, or nothing if colors
# are disabled.
#
# @param colors...
#   can be colors or modes (bold etc)
# @param fd
#   a file descriptor to test for being a terminal.
function colors::get_color() {
  local escape=$'\033['
  local fd_to_test=
  local code=""
  local sep=""
  local item
  for item in "$@"; do
    local val=0
    case "${item}" in
      reset|off|end|endcolor|resetbg) val=0 ;;
      bold)    val=1 ;;
      dim)     val=2 ;;
      italic)  val=3 ;;
      underline) val=4 ;;
      blink)   val=5 ;; # slow blink
      blink2)  val=6 ;; # fast blink
      reverse) val=7 ;;
      hidden)  val=8 ;;
      underline2) val=21 ;;

      # foreground colors
      black)   val=30 ;;
      red)     val=31 ;;
      green)   val=32 ;;
      yellow)  val=33 ;;
      blue)    val=34 ;;
      magenta) val=35 ;;
      cyan)    val=36 ;;
      white)   val=37 ;;

      # background colors
      blackbg)   val=40 ;;
      redbg)     val=41 ;;
      greenbg)   val=42 ;;
      yellowbg)  val=43 ;;
      bluebg)    val=44 ;;
      magentabg) val=45 ;;
      cyanbg)    val=46 ;;
      whitebg)   val=47 ;;

      # intense foreground colors
      iblack)   val=90 ;;
      ired)     val=91 ;;
      igreen)   val=92 ;;
      iyellow)  val=93 ;;
      iblue)    val=94 ;;
      imagenta) val=95 ;;
      icyan)    val=96 ;;
      iwhite)   val=97 ;;

      # intense background colors
      iblackbg)   val=100 ;;
      iredbg)     val=101 ;;
      igreenbg)   val=102 ;;
      iyellowbg)  val=103 ;;
      ibluebg)    val=104 ;;
      imagentabg) val=105 ;;
      icyanbg)    val=106 ;;
      iwhitebg)   val=107 ;;

      [0-9]|[0-9][0-9]|[0-9][0-9][0-9]) # assume file descriptor
        [[ -z "${fd_to_test}" ]] \
          || lib::LOG ERROR "Can't specify multiple file descriptors to check"
        fd_to_test="${item}"
        ;;

      *) lib::LOG ERROR "unknown color attribute: ${item}" ; continue ;;
    esac

    # always put reset first
    if [[ "${val}" == "0" ]]; then
      code="${val}${sep}${code}"
    else
      code="${code}${sep}${val}"
    fi
    sep=";"
  done

  if ! colors::is_tty "${fd_to_test:-1}"; then
    return
  fi

  if [[ -n "${code}" ]]; then
    echo "${escape}${code}m"
  fi
}

# Special echo function when using colors.
#
# Every odd argument is a color, the others are the strings to print.
# Arguments to echo can be given in a single argument at the beginning.
function colors::echo() {
  local string=""
  while (( $# > 0 )); do
    string="${string}$(colors::get_color $1)${2:-}"
    shift
    ! shift
  done
  echo "${string}$(colors::get_color endcolor)"
}


# Add a %C to printf semantics. It prints the matching color code for
# that argument. Remember to %C with "endcolor" after your block of color.
#
# For instance:
#   colors::printf "%C%s World%C\n" red Hello endcolor
# will print a red "Hello World"
#
# @param format
#   The printf format, see man printf.
# @param arguments
#   Format %'s are replaced with these.
function colors::printf() {
  # We need to go through the format, replacing %C with the matching code.
  # Hopefully the below suits for counting printf arguments!
  lib::assert::GE $# 1

  # Go through the format, using up an argument for every non-escaped %.
  local format="${1:-}"
  local to_process="${format}"
  local processed=""
  shift

  local -a printf_args
  while true; do
    # Find the next %
    local next="${to_process#*%}"
    local cutoff="${to_process%%%*}"
    if [[ "${next}" == "${to_process}" ]]; then
      processed="${processed}${to_process}"
      break
    fi

    to_process="${next}"
    processed="${processed}${cutoff}"
    # TODO: May be able to use the (r) or (i) flag
    # https://zsh.sourceforge.io/Guide/zshguide05.html
    case "${to_process}" in
      %*) # escaped %
        processed="${processed}%%"
        to_process="${to_process#%}"
        continue
        ;;
      C*) # %C !!
        processed="${processed}%s"
        # chop off the C
        to_process="${to_process:1}"
        if (( $# == 0 )); then
          lib::LOG ERROR "%C with no matching argument"
          return
        fi
        # Don't quote $1 here so it expands to the different attributes
        # shellcheck disable=SC2086
        printf_args+=( "$(colors::get_color $1)" )
        shift
        ;;
      *) # Some other % arg, so use up an arg
        if (( $# == 0 )); then
          lib::LOG ERROR "no matching argument for % at ${to_process}"
          return
        fi
        processed="${processed}%"
        printf_args+=( "$1" )
        shift
        ;;
    esac
  done

  printf "${processed}" ${printf_args[@]+"${printf_args[@]}"}
}


# Print the available color modifiers.
function colors::show_colors() {
  local var
  for var in {,i}{black,red,green,yellow,blue,magenta,cyan,white}; do
    colors::printf "%C%-15s%C" "${var}" "${var}" endcolor
    colors::printf "%C%-15s%C" "bold ${var}" "bold ${var}" endcolor
    colors::printf "%C%-15s%C" "dim ${var}" "dim ${var}" endcolor
    colors::printf "%C%-15s%C\n" "dim black ${var}bg" "${var}bg" endcolor
  done
  echo
  for var in italic underline underline2 blink blink2 reverse; do
    colors::echo "${var}" "${var}"
  done
  colors::echo hidden "hidden" endcolor "(hidden)"
}


function colors::init() {
  if [[ -t 1 ]]; then
    LIB_LOG_COLORS_STDOUT_IS_TTY=1
  else
    LIB_LOG_COLORS_STDOUT_IS_TTY=0
  fi
}
colors::init

fi  # include guard