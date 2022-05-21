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
      if (read -q "?$info_icon Sync first? "); then
        echo "\n$info_icon Syncing to head"
        /usr/bin/hg sync --all
      fi
      printf "\n"
      ;;
  esac
  /usr/bin/hg "$@"
}

function hg_precommit() {
  echo "$info_icon Running linters"
  #/usr/bin/hg fixwdir

  typeset -a modified_files=( $(hg status --no-status -a -m | grep -Ev "plx/.*\.textproto") )
  /usr/bin/hg fix -w ${modified_files}

  if [[ ${modified_files[(i)*.go]} -le ${#modified_files} ]]; then
    typeset -a go_files=( $(print -l ${modified_files} | grep ".go$") )
    typeset -U glaze_paths=( ${go_files:h} )
    echo "$info_icon Running glaze"
    glaze -p ${glaze_paths/#///}
  fi

  if [[ ${modified_files[(i)*.md]} -le ${#modified_files} ]]; then
    typeset -a md_files=( $(print -l ${modified_files} | grep ".md$") )
    echo "$info_icon Running mdformat"
    mdformat --in_place ${md_files}
  fi
}

# Change directory to a given CITC workspace.
function fcd() {
  typeset workspace="${1:-$(hg citc --list | fzf --print0 -0 -1)}"
  if [[ -z "${workspace}" ]] || (! hg citc --list | grep -q "${workspace}"); then
    echo "$warn_icon Invalid CITC name: ${workspace}"
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
    echo "$warn_icon No files were found to scan"
    return 1
  fi

  echo "$info_icon Scanning the following files:"
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
    echo "$warn_icon blazet requires 2 arguments"
    return 1
  fi

  typeset pattern="-test.run=${1}"
  typeset build_rule="${2}"
  blaze test --test_arg=$pattern $build_rule
}

# Sync to head without committing changes.
function hgsyncd() {
  echo "$info_icon Creating temp commit"
  /usr/bin/hg commit -m "sync"
  if (( $? != 0 )); then
    echo "$warn_icon Failed to create empty commit"
  fi

  echo "$info_icon Syncing to head"
  /usr/bin/hg sync --all
  if (( $? != 0 )); then
    echo "$warn_icon Failed to sync to head"
  fi

  echo "$info_icon Removing temp commit"
  /usr/bin/hg uncommit --no-keep
  if (( $? != 0 )); then
    echo "$warn_icon Failed to remove temp commit"
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

function f1q() {
  typeset infile="${1:-}"
  if [[ -z $infile ]]; then
    echo "$warn_icon you must provide the query file path"
    return 1
  fi
  typeset log_file="/tmp/f1q_${infile:t}_$(date --iso-8601=seconds).log"
  f1-sql --input_file="${infile}" --session_log_file="${log_file}" \
    --f1_sql_show_query_progress --f1_sql_force_output_profile_link
    
}
