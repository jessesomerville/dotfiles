alias aliases="nvim $0"
alias cat="bat"
alias ccat="command cat"
alias cdgo="cd $(go env GOPATH)/src/github.com/jessesomerville"
alias config="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"
alias hist="history -fD 0"  # Show history with time, date, and command runtime
alias la="ls -lAh --color=auto"
alias ls="ls --color=auto"
alias rg="rg --hidden"
alias rgi="rg -i"
alias top="btm -b"
alias vim="nvim"
alias lines="echo ${(l:80::─:)}"
alias envs="env | rg -v '^LS_COLORS' | sort"
alias tv="tidy-viewer"

randstr() { print -r -- $(tr -dc A-Za-z0-9 </dev/urandom | head -c ${1:-64}); }
echoinfo() { print -P "%B%F{12}[+]%f%b" $@ >&2; }
echoerr() { print -P "%B%F{9}[!]%f%b" $@ >&2; }

mkcd() {
  local pathname="${1:-}"
  if [[ -z $pathname ]]; then
    echoerr "missing required path argument"
    return 1
  fi
  mkdir -p "${pathname}"
  (( $? == 0 )) || return 1
  cd "${pathname}"
}

capture() {
  local opt log_file args
  while getopts o: opt; do
    case $opt in
      (o)
        log_file=$OPTARG
        ;;
      (\?)
        echoerr "bad option provided"
        return 1
        ;;
    esac
  done
  (( OPTIND > 1 )) && shift $(( OPTIND - 1 ))
  args=$*

  if [[ -z $log_file ]]; then
    echoerr "missing required '-o LOG_FILE' option"
    return 1
  fi
  
  if [[ -f $log_file ]] && (read -q "?Append to existing log file $log_file? "); then
    CAPTURE_SESSION_LOG_FILE__=$log_file script -a $log_file
  else
    CAPTURE_SESSION_LOG_FILE__=$log_file script $log_file
  fi
}
