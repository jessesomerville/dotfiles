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

function hg() {
  typeset subcmd="${1:-}"
  case "${subcmd}" in
    amend|commit)
      typeset -a modified_files=( $(hg st | cut -d' ' -f2) )
      typeset -U paths=( ${modified_files:h} )
      if (( ${#paths} )); then
        echo "[+] Running glaze"
        glaze -p ${paths/#///}
      fi
      ;;

    upload)
      if read -q "?[+] Sync first? "; then
        echo "[+] Syncing to head"
        /usr/bin/hg sync --all
      fi
      ;;
  esac
  /usr/bin/hg "$@"
}

# Change directory to a given CITC workspace.
function fcd() {
  typeset workspace="${1:-$(hg citc --list | fzf --print0 -0 -1)}"
  if hg citc --list | grep -q "${workspace}"; then
    echo "[!] Invalid CITC name: ${workspace}"
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
    echo "[!] No files were found to scan"
    return 1
  fi

  echo "[+] Scanning the following files:"
  print -l ${files_to_scan/#/  - }
  tricorder analyze -categories GoBugs,GoDeprecated,GoStaticCheck,GoVet ${files_to_scan}
}
