alias mdformat=/google/data/ro/teams/g3doc/mdformat
alias tricorder=/google/data/ro/teams/tricorder/tricorder

alias figls="hg citc --list"
alias hgst="hg diff --stat"

hg() {
    # If the command is amend or commit, format the files first.
    if [[ "$1" == "amend" || "$1" == "commit" ]]; then
        printf "[+] Running 'hg fixwdir'\n\n"
        /usr/bin/hg fixwdir
    # If the command is upload, ask if the commits should be synced first.
    elif [[ "$1" == "upload" ]]; then
        read -q "REPLY?[+] Sync first? "
        echo
        if [[ $REPLY == y ]]; then
            printf "[+] Running 'hg sync --all'\n\n"
            /usr/bin/hg sync --all
        fi
    fi
    /usr/bin/hg "$@"
}

# Rebase first arg to second arg.
hgrb() {
    if [[ "$#" -ne 2 ]]; then
        printf '[!] Usage: hgrb $SRC $DEST'
        return 1
    fi
    /usr/bin/hg rebase --source $1 --dest $2
}

# Change directory to a given CITC workspace.
fcd() {
    if [[ "$#" -ne 0 ]]; then
        if hg citc --list | grep -q "$1"; then
            hgd "$1"
        else
            echo "No workspace named '$1' was found"
        fi
    else
        citc=$(hg citc --list | fzf --ansi -0 -1 | tr -d '\n')
        if [[ -z "$citc" ]]; then
            echo "None active"
        else
            hgd "$citc"
        fi
    fi
}

# Print an array in the same format as the tree command.
printastree() {
    items=($(echo $@ | xargs -n1 | sort | xargs))
    pos=$(( ${#items[*]} ))
    last=${items[$pos]}
    for i in ${items[@]}; do
        if [[ $i == $last ]]; then
            printf "└── $i\n"
        else
            printf "├── $i\n"
        fi
    done
}

# Run Golang Tricorder scanners on a set of files.
scango() {
    if [[ ! "$(pwd)" == *"/google/src/cloud/jsomerville"* ]]; then
        printf "[!] Working directory does not appear to be a CITC workspace\n"
        return 1
    fi

    # If no args were supplied, scan the files with changes.
    if [[ "$#" -eq 0 ]]; then
        files_to_scan=($(/usr/bin/hg st | cut -d' ' -f2 | grep "go"))
        if [[ "${#files_to_scan[@]}" -eq 0 ]]; then
            printf "[!] No files were found to scan\n"
        fi
    # If `-a` is supplied, scan every golang file in the tpsi directory.
    elif [[ "$1" == "-a" ]]; then
        files_to_scan=($( find ops/security/saas/tpsi -type f -name "*.go" ))
    # If other args are supplied, use them as the files to scan.
    else
        files_to_scan=$@
    fi

    printf "[+] Scanning the following files\n"
    printastree $files_to_scan
    echo
    tricorder analyze -categories GoBugs,GoDeprecated,GoStaticCheck,GoVet \
        "${files_to_scan[@]}"
}

# Get the number of records in a given Capacitor file.
crc() {
    if [[ "$#" -ne 1 ]]; then
        printf "Usage:\n  crc (test|prod)\n  OR\n  crc \$PATH_TO_FILE\n"
    elif [[ "$1" =~ ^("prod"|"test")$ ]]; then
        cap_path=$(get_placer_path "$1")
        if [[ -z $cap_path ]]; then; return 1; fi
    else
        cap_path="$1"
    fi
    printf "[+] Querying ${cap_path}\n"
    gqui from "${cap_path}" "select count(*)"
}

cquery() {
    if [[ "$#" -ne 2 ]]; then
        printf "Usage:\n  cquery (test|prod) \$QUERY\n  OR\n  cquery \$PATH_TO_FILE \$QUERY\n"
    elif [[ "$1" =~ ^("prod"|"test")$ ]]; then
        cap_path=$(get_placer_path "$1")
        if [[ -z $cap_path ]]; then; return 1; fi
    else
        cap_path="$1"
    fi
    printf "[+] Running query '$2' on ${cap_path}\n"
    gqui from "${cap_path}" "$2"
}

# Interactively select a file from Placer.
get_placer_path() {
    if [[ "$1" == "prod" ]]; then
        base_path="/placer/prod/home/tpsi-placer"
    elif [[ "$1" == "test" ]]; then
        base_path="/placer/test/home/jsomerville"
    else
        printf "Usage:\n  crcplacer [prod|test]\n" >&2
        return 1
    fi
    printf "[+] Select a file set:\n" >&2
    file_set=$(placer list_filesets "${base_path}" | fzf --ansi -0 -1 | tr -d '\n')
    if [[ -z $file_set ]]; then; printf "[!] No file sets were found in ${base_path}\n" >&2; return 1; fi
    printf "[+] Looking for files in ${file_set}...\n" >&2
    cap_file=$(fileutil ls -R -F "${file_set}" | grep -v "/$" | fzf --ansi -0 -1 | tr -d '\n')
    if [[ -z $cap_file ]]; then; printf "[!] No files were found in ${file_set}\n" >&2; return 1; fi
    echo "${cap_file}"
}

# Essentially strings.Join() where the first param is the sep and the second
# is the list to join. Separator can only be a single character.
join_by() { local IFS="$1"; shift; echo "$*"; }

# Run a TPSI Flume pipeline.
runpipeline() {
    if [[ "$#" -lt 2 ]] || [[ ! "$2" =~ ^(filter|nofilter)$ ]]; then
        printf "Usage:\n  runpipeline \$PIPELINE_NAME (filter|nofilter) \$EXTRA_OPTS\n\n"
        printf "Example:\n  runpipeline spur_questionnaires filter --output_path=/tmp/foo\n"
        return 1
    elif [[ ! "$(pwd)" == *"/google/src/cloud/jsomerville"* ]]; then
        printf "[!] Working directory does not appear to be a CITC workspace\n"
        return 1
    fi

    extra_ops=(${@:3})
    build_target="//ops/security/saas/tpsi/pipelines:$1"
    base_cmd="blaze run $build_target -- --flume_exec_mode=LOCAL_PROCESSES ${extra_ops[@]}"

    table_fields=("Blaze target" "${build_target}")
    for o in "${extra_ops[@]}"; do
        table_fields+=("Option" "${o}")
    done
    python3 ${HOME}/.local/bin/print_table.py "${table_fields[@]}"

    if ( ! confirm "[+] Proceed?" ); then
        printf "[!] Exiting\n"
        return 0
    fi

    python3 -c "print('─'*$(tput cols))"
    if [[ "$2" == "filter" ]]; then
        printf "[+] Logging to stderr and only showing TPSI logs\n"
        base_cmd+=" --logtostderr"
        tpsi_paths=($( find ops/security/saas/tpsi -type f -name "*.go" -not -name "*test.go" ))
        for f in "${tpsi_paths[@]}"; do
            tpsi_files+=($(basename "$f"))
        done
        grep_pattern=$(join_by '|' $tpsi_files)
        eval "${base_cmd}" |& grep -E "${grep_pattern}"
    else
        eval "${base_cmd}"
    fi
}

# Ask for confirmation. First arg will be the question, second will 
confirm() {
    echo
    read -q "REPLY?$1 "
    echo
    if [[ $REPLY == y ]]; then
        return 0
    fi
    return 1
}

