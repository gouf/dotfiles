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
fi
# Git Ignore Request
function gi() { curl -s https://www.gitignore.io/api/$@ ; }

# License file
# apache, artistic, cc0, eclipse, affero, gpl2, gpl3, lgpl2, lgpl3, isc, mit, mozilla, nbsd, unlicense, sbsd
function li() { curl -s https://licensedownload.herokuapp.com/$@ ; }

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
# alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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
export PATH=~/hub:$PATH
eval "$(hub alias -s)"

# Print some docker containers IP address
function printip {
 id="$*" # container id
 docker inspect $id |grep IPAddress|sed -e "s/^[ \t ]*\"IPAddress\":\s\"//g"|sed -e "s/\",$//g"
}

function mkcd {
 dir="$*";
 mkdir -p "$dir" && cd "$dir";
}

function mvcd {
  file_name="$1";
  file_path="$2";

  if [ $# -gt 2 ]; then
    echo 'Err: the parameter is too much.';
    return 1;
  fi
  mv "$file_name" "$file_path" && cd "$file_path";
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Rails i18n locale xx.yml
function lo() { curl -s https://cdn.rawgit.com/svenfuchs/rails-i18n/master/rails/locale//$@.yml ;}
source $HOME/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

alias composer="php ~/.composer/composer.phar"


export EDITOR="vim"
export MAKE_OPTS=-j4

alias la="ls -a"
alias ll="ls -l"

# Colored diff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

source ~/.anyenv/envs/phpenv/completions/rbenv.bash
source ~/.anyenv/completions/anyenv.bash

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Load pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="$HOME/.composer:$PATH"

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/golang
export PATH=$GOPATH/bin:$PATH

export PATH="$PATH:$HOME/.composer/vendor/bin"

export PATH="~/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin:$PATH"
export PATH="~/.terraform:$PATH"

alias fig=docker-compose

export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

function gitsb {
  exp="$*";

  git br|egrep $exp|cut -c 3-100|xargs git show-branch

}

function update_terraform {
  ARCH=linux_amd64
  VERSION=$(terraform version | tail -n 1 | cut -c 4-8)

  URL="https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_${ARCH}.zip"

  if [[ -z "$VERSION" ]]; then
    echo "Nothing to do."
  else
    cd /tmp
    wget $URL
    unzip terraform_${VERSION}_${ARCH}.zip -d ~/.terraform
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

if [[ `which ccat` ]]
then
  alias cat=ccat
fi

# Load xdebug Zend extension with php command
alias php='php -dzend_extension=xdebug.so'

# PHPUnit needs xdebug for coverage. In this case, just make an alias with php command prefix.
alias phpunit='php $(which phpunit)'

export PATH="$HOME/swift-2.2-SNAPSHOT-2015-12-21-a-ubuntu15.10/usr/bin:$PATH"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

function switch_git_config () {
  name=$1
  email=$2

  git config --global user.name $name
  git config --global user.email $email
  echo "Configuration has changed:"
  echo "git config user.name: $(git config user.name)"
  echo "git config user.email: $(git config user.email)"
}

function gouf () {
  switch_git_config "gouf" "innocent.zero@gmail.com"
}

function init_plane_java_project() {
  mkdir -p src/{main,test}/{resorces,java}
  touch src/{main,test}/{resorces,java}/.gitkeep
  gradle init
}

export ANDROID_HOME="/usr/local/Cellar/android-sdk/24.4.1_1/"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export GRADLE_USER_HOME="/usr/local/opt/gradle/libexec"

export PATH="$HOME/.chefdk/gem/ruby/2.3.0/bin:$PATH"

# bashmarks - https://github.com/huyng/bashmarks
# bash directory bookmark
if [ -f ~/.local/bin/bashmarks.sh ]; then
  source ~/.local/bin/bashmarks.sh
fi

if [[ $(uname -s) -eq 'Darwin' && $(which free.py) ]]; then
  # Ref :
  # * [memory - Is there a Mac OS X Terminal version of the "free" command in Linux systems? - Ask Different](http://apple.stackexchange.com/questions/4286/is-there-a-mac-os-x-terminal-version-of-the-free-command-in-linux-systems)
  # And copy free.py to /usr/local/bin
  alias free="free.py"
fi
