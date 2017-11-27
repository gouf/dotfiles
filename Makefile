# first command:
# sudo apt install -y make curl && curl https://raw.githubusercontent.com/gouf/dotfiles/master/Makefile > Makefile && make

all: apt_update git wget tree ruby php composer vim dotfiles anyenv golang hub bashmarks platinum_searcher haskell_stack heroku docker_ce git_flow postgresql

universe:
	sudo add-apt-repository universe
	sudo apt update

apt_update:
	sudo apt update

git:
	sudo apt install -y git

git_completion:
	cd /etc/bash_completion.d \
	&& sudo wget https://github.com/git/git/raw/master/contrib/completion/git-completion.bash \
	&& sudo wget https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh

wget:
	sudo apt install -y wget

curl:
	suto apt install -y curl

tree: universe
	sudo apt install -y tree

ruby: apt_update
	sudo apt install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs ruby-dev \
	&& sudo apt install -y ruby

php:
	# (Not work perfectly after installation. maybe not enough list of dependencies)
	sudo apt install -y php php-xdebug bison re2c bzip2

composer: php
	# Composer
	if [ ! -x ~/.local/bin/composer.phar ]; then \
	mkdir -p ~/.local/bin \
	&& cd ~/.local/bin \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& cd; \
	fi

wp_cli: php
	cd ~ && \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mkdir -p ~/.local/bin && \
	mv wp-cli.phar ~/.local/bin/wp

vim: ruby dotfiles
	# Vim plugin dep
	sudo apt install -y vim vim-gtk libgnome2-bin\
	&& sudo gem install flog flay bundler \
	&& sudo apt install -y ctags
	## Vim plugin manager
	if [ ! -e ~/.vim/bundle/Vundle.vim ]; then \
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; \
	vim +BundleInstall +qall; \
	cd ~/.vim/bundle/vimproc/; \
	make; \
	cd; \
	fi

dotfiles: git
	if [ ! -e ~/.dotfiles ]; then \
	git clone https://github.com/gouf/dotfiles.git ~/.dotfiles \
	&& rm -f ~/.bashrc ~/.bash_profile \
	&& ln -s $(HOME)/.dotfiles/.bashrc ~/.bashrc \
	&& ln -s $(HOME)/.dotfiles/.bash_aliases ~/.bash_aliases \
	&& ln -s $(HOME)/.dotfiles/.gitconfig ~/.gitconfig \
	&& ln -s $(HOME)/.dotfiles/.railsrc ~/.railsrc \
	&& ln -s $(HOME)/.dotfiles/.vimrc ~/.vimrc; \
	fi

anyenv: git
	if [ ! -d ~/.anyenv ]; then \
	git clone https://github.com/riywo/anyenv ~/.anyenv \
	&& $(HOME)/.anyenv/libexec/anyenv install pyenv \
	&& $(HOME)/.anyenv/libexec/anyenv install rbenv \
	&& $(HOME)/.anyenv/libexec/anyenv install nodenv \
	&& $(HOME)/.anyenv/libexec/anyenv install phpenv; \
	fi

anyenv_update: anyenv
	## anyenv update
	if [ ! -e ~/.anyenv/plugins/anyenv-update ]; then \
	mkdir -p $(anyenv root)/plugins \
	&& git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update; \
	fi

golang:
	sudo apt install -y golang

hub: golang git ruby
	cd \
	&& git clone https://github.com/github/hub.git \
	&& cd hub \
	&& make install prefix=$(HOME)/.local \
	&& cd \
	&& rm -rf hub

bashmarks: git ruby
	cd \
	&& git clone git://github.com/huyng/bashmarks.git \
	&& cd bashmarks \
	&& make install \
	&& cd \
	&& rm -rf bashmarks

platinum_searcher: golang
	go get -u github.com/monochromegane/the_platinum_searcher/...

heroku: wget
	wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

uname = `uname -r`
lsb_release = `lsb_release -cs`

docker_ce:
	# (arch == amd64)
	sudo apt-get install -y linux-image-extra-$(uname) linux-image-extra-virtual \
	&& sudo apt install -y apt-transport-https ca-certificates software-properties-common \
	&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
	&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release) stable" \
	&& sudo apt update \
	&& sudo apt install docker \
	## docker gets control without sudo
	sudo groupadd docker \
	&& sudo gpasswd -a $(USER) docker

git_flow: wget curl
	cd \
	&& curl -OL https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh \
	&& chmod +x gitflow-installer.sh \
	&& INSTALL_PREFIX=$(HOME)/.local/bin ./gitflow-installer.sh \
	&& rm -f gitflow-installer.sh \
	&& rm -rf gitflow
	## git-flow bash completion
	cd /etc/bash_completion.d \
	&& sudo wget https://github.com/bobthecow/git-flow-completion/raw/master/git-flow-completion.bash

postgresql:
	sudo apt install -y postgresql

haskell_stack:
	sudo apt install -y haskell-stack \
	&& stack setup
