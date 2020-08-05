# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ $(uname -s) -eq 'Darwin' ]]; then
  export LSCOLORS=gxfxcxdxbxegedabagacad
  export LS_COLORS="di=36;40:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=36;42:ow=30;43"
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
SAVEHIST=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# functions type commands
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# git - https://github.com/git/git/tree/master/contrib/completion
GIT_PS1_SHOWDIRTYSTATE=true
if [[ $(uname -s) -eq 'Darwin' ]]; then
  export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
else
  export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
fi

# hub - https://github.com/github/hub/
export PATH=~/.local/bin:$PATH
eval "$(hub alias -s)"

if [ $(uname -s) == "Darwin" ]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

if [ -f $HOME/git-prompt.sh ]; then
  source $HOME/git-prompt.sh
fi

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export EDITOR="vim"
export MAKE_OPTS=-j4

source ~/.anyenv/completions/anyenv.bash

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Load pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

export GOPATH="$HOME/.golang"
export GOBIN="$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"

export PATH="~/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin:$PATH"
export PATH="~/.terraform:$PATH"
export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export PATH="$HOME/swift-2.2-SNAPSHOT-2015-12-21-a-ubuntu15.10/usr/bin:$PATH"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

export ANDROID_HOME="/usr/local/Cellar/android-sdk/24.4.1_1/"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export GRADLE_USER_HOME="/usr/local/opt/gradle/libexec"

export PATH="$HOME/.chefdk/gem/ruby/2.3.0/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# bashmarks - https://github.com/huyng/bashmarks
# bash directory bookmark
if [ -f ~/.local/bin/bashmarks.sh ]; then
  source ~/.local/bin/bashmarks.sh
fi

if [ -f ~/.homebrew_github_api_token ]; then
  source ~/.homebrew_github_api_token
fi

export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export GPG_TTY=$(tty)

eval "$(pipenv --completion)"

# heroku autocomplete setup
CLI_ENGINE_AC_BASH_SETUP_PATH=$HOME/.cache/heroku/completions/bash_setup && test -f $CLI_ENGINE_AC_BASH_SETUP_PATH && source $CLI_ENGINE_AC_BASH_SETUP_PATH;

#
# enhancd settings
# Ref: https://github.com/b4b4r07/enhancd
#
if [ -f ~/.enhancd/init.sh ]; then
  # export ENHANCD_COMMAND=ecd # Default command modification
  export ENHANCD_FILTER="peco"
  export ENHANCD_DOT_SHOW_FULLPATH=1
  export ENHANCD_DISABLE_DOT=0 # Default: 0
  export ENHANCD_DISABLE_HYPHEN=0 # Default: 0
  export ENHANCD_DISABLE_HOME=0 # Default: 0
  export ENHANCD_DOT_ARG=".." # Default: "..", If set, that behavior same act as original cd
  export ENHANCD_HYPHEN_ARG="-" # Default: "-", If set, that behavior same act as original cd
  export ENHANCD_HOME_ARG="" # Default: ""
  export ENHANCD_HOOK_AFTER_CD="ls" # Default: ""
  export ENHANCD_USE_FUZZY_MATCH=1 # Default: 1
  source ~/.enhancd/init.sh
fi

# Overwrite Ctrl-R key map
[[ "$(uname -s)" = 'Linux' ]] && bind -x '"\C-r":peco-select-history-linux'
[[ "$(uname -s)" = 'Darwin' ]] && bind -x '"\C-r":peco-select-history-mac'
