#!/usr/bin/env zsh

alias f1aliases="nvim $0"

typeset info_icon=$(print -P "%B%F{12}[+]%f%b")
typeset warn_icon=$(print -P "%B%F{9}[!]%f%b")

function tablecols() {
  typeset -a table_name=( ${(s:.:)1} )
  if [[ "${#table_name}" -ne 2 ]]; then
    echo "table name '${table_name}' is invalid"
    return 1
  fi

  cat $HOME/.zsh/f1/table_column_info.sql \
    | TABLE_NS="${table_name[1]}" TABLE_NAME="${table_name[2]}" envsubst \
    | f1-sql --print_queries=false --csv_output \
    | tidy-viewer -u 50 -n 50
}

f1q () {
  local opt querystr infile importpath format numrows

  typeset -A help
  help=(
    '-h' 'print this help message'
    '-f' 'path to the file containing the F1 query'
    '-q' 'query to execute'
    '-m' 'import path for GoogleSQL modules'
    '-p' 'output format [tidy, csv, raw]'
    '-n' 'number of rows to include in the tidy output [default: 50]'
  )

  while getopts f:q:m:p:n:h opt
  do
    case $opt in
      (f)
        if [[ -f $OPTARG ]]; then
          infile=$OPTARG 
        else
          echoerr "no such file $OPTARG"
          return 1
        fi
        ;;
      (q) querystr=$(echo $OPTARG | sd -p '^(.*[^;]);*\n' '$1;\n') ;;
      (m) importpath=$OPTARG ;;
      (p) format=$OPTARG ;;
      (n) numrows=$OPTARG ;;
      (h)
        print -P "\n%B%F{11}f1q%f%b - execute an F1 query\n"
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
    
  if [[ ( -z $infile && -z $querystr ) ]]; then
    echoerr "neither '-f INPUT_FILE' or '-q QUERY' were provided"
    return 1
  fi

  if [[ -n $infile ]]; then
    querystr="$(cat $infile)"
  fi

  typeset -a f1args=(
    '--print_queries=false'
  )

  if [[ -n $importpath ]]; then
    f1args=(--prefix_commands "SET module.global_import_path = ${importpath:-$PWD};" $f1args)
  fi

  case $format in
    (tidy) f1args=('--csv_output' --csv_delimiter ';' $f1args) ;;
    (csv) f1args=('--csv_output' $f1args) ;;
    (raw) f1args=('--raw_output' $f1args) ;;
  esac
  
  if [[ $format =~ 'tidy' ]]; then
    echo "${querystr}" | f1-sql ${f1args[@]} \
      | tidy-viewer -u=50 -s=';' -n=${numrows:-50} -a
    return $?
  fi

  echo "${querystr}" | f1-sql ${f1args[@]}
}

# Execute the input string as an F1 query.
#   $ sql "SELECT * FROM tpsi.entries"
function sql() {
  local query="${1:-}"
  if [[ -z $query ]]; then
    echoerr "missing query string"
    return 1
  fi
  f1q =(echo "${query}" | sd -p '^(.*[^;]);*\n' '$1;\n')
}

