alias ls='ls --color'
alias ll='ls -lAh'
alias cp="cp --reflink=auto"
[ -z "$NVIM_LISTEN_ADDRESS" ] || alias :="${HOME}/.local/bin/nvimex.py"

#export TERM=xterm-256color
export EDITOR='nvim'
export HISTSIZE=1024
export SAVEHIST=2048
export HISTFILE=~/.cache/zsh/history
export PATH=$PATH:${HOME}/.local/bin
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # doesn't include '/'