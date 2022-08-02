#!/usr/bin/env zsh
#
# Aliases specific to Google Cloudtop.

alias galiases="nvim $0"

alias bluze=/google/bin/releases/blueprint-bluze/public/bluze
alias ganpaticfg=/google/bin/releases/ganpaticfg/public/ganpaticfg
alias get_mint=/google/data/ro/projects/gaiamint/bin/get_mint
alias lbresolve=/google/data/ro/teams/youtube-legos/bin/lbresolve
alias mdformat=/google/data/ro/teams/g3doc/mdformat
alias perf5=/google/bin/releases/kernel-tools/perf5/usr/bin/perf5
alias plxutil=/google/data/ro/teams/plx/plxutil
alias sqlfmt=/google/data/ro/teams/googlesql-formatter/fmt
alias tricorder=/google/data/ro/teams/tricorder/tricorder
alias prodfs=/google/bin/users/catalinp/prodfs/prodfs.sh
alias datahub=/google/bin/releases/datahub/datahub_util

alias figls="hg citc --list"
alias hgst="hg diff --stat"

typeset info_icon=$(print -P "%B%F{12}[+]%f%b")
typeset warn_icon=$(print -P "%B%F{9}[!]%f%b")

function precmd() {
  if [[ -n $G3DIR ]]; then
    fig_status_parts=("${(@f)$( get_fig_prompt )}")
    export FIG_CL=$fig_status_parts[1]
    export FIG_MODIFIED=$fig_status_parts[2]
  fi
}

function hg() {
  typeset subcmd="${1:-}"
  case "${subcmd}" in
    amend|commit) hg_precommit ;;
    upload)
      if (read -q "?$(echoinfo) Sync first? "); then
        echo; echoinfo "Syncing to head"
        /usr/bin/hg sync --all
      fi
      printf "\n"
      ;;
  esac
  /usr/bin/hg "$@"
}

function hg_precommit() {
  echoinfo "Running linters"
  #/usr/bin/hg fixwdir

  typeset -a modified_files=( $(hg status --no-status -a -m | grep -Ev "plx/.*\.textproto") )
  /usr/bin/hg fix -w ${modified_files}

  if [[ ${modified_files[(i)*.go]} -le ${#modified_files} ]]; then
    typeset -a go_files=( $(print -l ${modified_files} | grep ".go$") )
    typeset -U glaze_paths=( ${go_files:h} )
    echoinfo "Running glaze"
    glaze -p ${glaze_paths/#///}
  fi

  if [[ ${modified_files[(i)*.md]} -le ${#modified_files} ]]; then
    typeset -a md_files=( $(print -l ${modified_files} | grep ".md$") )
    echoinfo "Running mdformat"
    mdformat --in_place ${md_files}
  fi
}

# Change directory to a given CITC workspace.
function fcd() {
  typeset workspace="${1:-$(hg citc --list | fzf --print0 -0 -1)}"
  if [[ -z "${workspace}" ]] || (! hg citc --list | grep -q "${workspace}"); then
    echoerr "Invalid CITC name: ${workspace}"
    return 1
  fi
  hgd "${workspace}"
}

# Run Golang Tricorder scanners on a set of files.
function scango() {
  typeset -a files_to_scan=( $@ )
  if (( $# )); then
    files_to_scan=( $(hg st | cut -d' ' -f2 | grep "*.go") )
  fi

  if (( ${#files_to_scan} )); then
    echoerr "No files were found to scan"
    return 1
  fi

  echoinfo "Scanning the following files:"
  print -l ${files_to_scan/#/  - }
  tricorder analyze -categories GoBugs,GoDeprecated,GoStaticCheck,GoVet ${files_to_scan}
}

# Run specific Go tests with Blaze.
function blazet() {
  if [[ ${1:-} == "help" ]]; then
    echo 'blazet $TEST_PATTERN $TEST_TARGET'
    echo '  EXAMPLE:'
    echo '  blazet TestMyFunc //ops/security/foo:bar_test'
    return 0
  fi

  if (( $# != 2 )); then
    echoerr "blazet requires 2 arguments"
    return 1
  fi

  typeset pattern="-test.run=${1}"
  typeset build_rule="${2}"
  blaze test --test_arg=$pattern $build_rule
}

# Sync to head without committing changes.
function hgsyncd() {
  echoinfo "Creating temp commit"
  /usr/bin/hg commit -m "sync"
  if (( $? != 0 )); then
    echoerr "Failed to create empty commit"
  fi

  echoinfo "Syncing to head"
  /usr/bin/hg sync --all
  if (( $? != 0 )); then
    echoerr "Failed to sync to head"
  fi

  echoinfo "Removing temp commit"
  /usr/bin/hg uncommit --no-keep
  if (( $? != 0 )); then
    echoerr "Failed to remove temp commit"
  fi
}

function whichtests() {
  typeset -a changed_files=( $(hg st | cut -d' ' -f2) )
  typeset -U uniq_paths=( ${changed_files:h} )
  typeset -U test_rules
  for p in "${uniq_paths[@]}"; do
    test_rules=( $(blaze query "tests(${p}:all)" 2> /dev/null) $test_rules)
  done
  if (( ${#test_rules} )); then
    echo "[+] The following tests will be executed:"
    print -l ${test_rules/#/   }
  else
    echo "[+] No tests will be executed"
  fi
}

function vsasearch() {
  local opt search

  typeset -A help
  help=(
    '-s' 'the term to search for'
  )

  while getopts s:h opt
  do
    case $opt in
      (s) search=$OPTARG ;;
      (h)
        print -P "\n%B%F{11}vsasearch%f%b - search for VSAs\n"
        for k in "${(k)help[@]}"; do
          print -P "  %F{2}$k%f  %F{7}$help[$k]%f"
        done
        return 0
        ;;
      (\?)
        echoerr "invalid option provided"
        return 1
        ;;
    esac
  done
  (( OPTIND > 1 )) && shift $(( OPTIND - 1 ))

  if [[ -z $search ]]; then
    echoerr "you must provide a search term with -s"
    return 1
  fi

  echoinfo "Searching for '${search}'"

  typeset -a query=(
    "SELECT title, FORMAT('http://b/%d', issue_id) AS bug,"
    "FROM buganizer.issuestatsfresh.live"
    "WHERE"
    "  component_id = 873039"
    "  AND REGEXP_CONTAINS(LOWER(title), 'vendor security assessment')"
    "  AND REGEXP_CONTAINS(LOWER(title), LOWER('${search}'));"
  )

  f1q -f =(print -l $query)
}
