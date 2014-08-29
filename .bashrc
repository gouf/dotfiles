HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

# bashmarks - https://github.com/huyng/bashmarks
source ~/.local/bin/bashmarks.sh

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
function gi() { curl http://www.gitignore.io/api/$@ ;}

export EDITOR="vim"
export MAKE_OPTS=-j12
