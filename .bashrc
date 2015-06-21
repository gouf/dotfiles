HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

# bashmarks - https://github.com/huyng/bashmarks
source ~/.local/bin/bashmarks.sh

# git - https://github.com/git/git/tree/master/contrib/completion
GIT_PS1_SHOWDIRTYSTATE=true
source ~/.gitcompletion/git-prompt.sh
source ~/.gitcompletion/git-completion.bash
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# hub - https://github.com/github/hub/
source ~/.hub/hub.bash_completion.sh

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

# Git Ignore Request
function gi() { curl -s https://www.gitignore.io/api/$@ ;}

# Rails i18n locale xx.yml
function lo() { curl -s https://cdn.rawgit.com/svenfuchs/rails-i18n/master/rails/locale//$@.yml ;}

# License file
# apache, artistic, cc0, eclipse, affero, gpl2, gpl3, lgpl2, lgpl3, isc, mit, mozilla, nbsd, unlicense, sbsd
function li() { curl -L -s https://licensedownload.herokuapp.com/$@ ;}

if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

export EDITOR="vim"
export MAKE_OPTS=-j12

# Colored diff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
