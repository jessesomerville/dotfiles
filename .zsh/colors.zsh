export LS_COLORS="$(vivid generate glacier)"

hexcolor() {
  setopt localoptions extendedglob

  local args=${1:-}
  if [[ -z $args ]]; then
    echoerr "Missing color argument"
    return 1
  fi

  local colorstr="#${(S)$(echo $args | rg -o '[[:xdigit:]]{6}')%\#*}"
  if [[ -z $colorstr ]]; then
    echoerr "$colorstr is not a hex color"
    return 1
  fi

  print -P "%B%F{$colorstr} $colorstr %f%K{$colorstr} $colorstr %k%b"
}

colors16() {
  local fgc bgc
  for i in {0..15}; do
    fgc="${fgc} %F{$i}${(l:3:: ::0:)i}%f "
    bgc="${bgc}%K{$i}${(l:5:)}%k"
    if (( (i + 1) % 8 == 0 )); then
      print -lP $fgc $bgc
      fgc='' bgc=''
    fi
  done
  print -lP $fgc $bgc
}


colorcube() {
  local -a cubeidx=( {0..5}' + (6 * '{0..5}') + (36 * '{0..5}') + 16' )
  for exp in "${cubeidx[@]}"; do
    local -i i=$(( exp ))
    print -P "%F{$i}${(l:3:)i}%f %K{%i}${(l:3:)}%k"
  done
}

# 196 = 16 + (36 * r) + (6 * g) + b
