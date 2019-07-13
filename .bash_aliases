alias gish="gitsh" # https://github.com/thoughtbot/gitsh
alias sorbet="sb"
alias sl='serverless'
alias ccat='ccat -G String="_brown_" -G Plaintext="overline" -G Punctuation="darkteal" -G Decimal="darkgreen" -G Keyword="green" -G Comment="darkgray" -G Tag="faint"'
# eg. retab spaces_and_tabs_mixture_indented.txt
alias retab='vim -s <(echo -e "gg=G\n:retab\n:wqa")'
alias less="less -R"
alias grep="grep --color"
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias ls='ls -G'
# alias l='ls -CF'

alias composer="php ~/.local/bin/composer.phar"

# Colored diff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

alias fig=docker-compose

if [[ `which ccat` ]]
then
  alias cat=ccat
fi

# Load xdebug Zend extension with php command
alias php='php -dzend_extension=xdebug.so'

# PHPUnit needs xdebug for coverage. In this case, just make an alias with php command prefix.
alias phpunit='php $(which phpunit)'

if [[ $(uname -s) -eq 'Darwin' && $(which free.py) ]]; then
  # Ref :
  # * [memory - Is there a Mac OS X Terminal version of the "free" command in Linux systems? - Ask Different](http://apple.stackexchange.com/questions/4286/is-there-a-mac-os-x-terminal-version-of-the-free-command-in-linux-systems)
  # And copy free.py to /usr/local/bin
  alias free="free.py"
fi

alias bfg='java -jar $HOME/bfg-1.12.5-unknown.jar'

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
