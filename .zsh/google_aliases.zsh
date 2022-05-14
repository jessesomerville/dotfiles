#!/bin/zsh
#
# Aliases specific to Google Cloudtop.

alias galiases="nvim $0"

alias bluze=/google/bin/releases/blueprint-bluze/public/bluze
alias get_mint=/google/data/ro/projects/gaiamint/bin/get_mint
alias lbresolve=/google/data/ro/teams/youtube-legos/bin/lbresolve
alias mdformat=/google/data/ro/teams/g3doc/mdformat
alias perf5=/google/bin/releases/kernel-tools/perf5/usr/bin/perf5
alias tricorder=/google/data/ro/teams/tricorder/tricorder

alias figls="hg citc --list"
alias hgst="hg diff --stat"

typeset info_icon=$(print -P "%B%F{12}[+]%f%b")
typeset warn_icon=$(print -P "%B%F{9}[!]%f%b")

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
  typeset -a modified_files=( $(hg status --no-status -a -m) )

  if [[ ${modified_files[(i)*.go]} -le ${#modified_files} ]]; then
    typeset -U glaze_paths=( ${modified_files:h} )
    echo "$info_icon Running glaze"
    glaze -p ${glaze_paths/#///}
  fi

  if [[ ${modified_files[(i)*.md]} -le ${#modified_files} ]]; then
    typeset -a md_files=( $(print -l ${modified_files} | grep ".md") )
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
