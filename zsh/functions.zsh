# original: https://github.com/spicycode/ze-best-zsh-config/blob/master/.zsh/functions.zsh

function zsh_recompile {
  autoload -U zrecompile
  rm -f ~/.zsh/*.zwc
  [[ -f ~/.zshrc ]] && zrecompile -p ~/.zshrc
  [[ -f ~/.zshrc.zwc.old ]] && rm -f ~/.zshrc.zwc.old

  for f in ~/.zsh/**/*.zsh; do
    [[ -f $f ]] && zrecompile -p $f
    [[ -f $f.zwc.old ]] && rm -f $f.zwc.old
  done

  [[ -f ~/.cache/zsh/compdump ]] && zrecompile -p ~/.cache/zsh/compdump
  [[ -f ~/.cache/zsh/compdump.zwc.old ]] && rm -f ~/.cache/zsh/compdump.zwc.old

  source ~/.zshrc
}

function extract {
  echo Extracting $1 ...
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1  ;;
      *.tar.gz)    tar xzf $1  ;;
      *.bz2)       bunzip2 $1  ;;
      *.rar)       unrar x $1    ;;
      *.gz)        gunzip $1   ;;
      *.tar)       tar xf $1   ;;
      *.tbz2)      tar xjf $1  ;;
      *.tgz)       tar xzf $1  ;;
      *.zip)       unzip $1   ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1  ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Detect empty enter, execute git status if in git dir
function magic-enter {
  if [[ -z $BUFFER ]]; then
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
      echo -ne '\n'
      git status -sb
    fi
  elif [[ $BUFFER == "man "* ]]; then
    print -S "$BUFFER"
    BUFFER="${BUFFER//\'/}"
    BUFFER=" nvim -c 'ViewDocMan ${BUFFER#* }' -c 1bd"
  elif [[ $BUFFER == "info "* ]]; then
    print -S "$BUFFER"
    BUFFER="${BUFFER//\'/}"
    BUFFER=" nvim -c 'ViewDocInfo ${BUFFER#* }' -c 1bd"
  fi
  zle accept-line
}
zle -N magic-enter

function mkcd {
  if [[ "$#" != 1 ]]; then
    echo "Expects exactly one argument; provided $#" >&2
    return 1
  fi
  mkdir "$1" && cd "$1"
}
