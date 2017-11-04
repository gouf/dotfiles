all: apt_update git wget tree ruby php composer vim dotfiles anyenv golang hub bashmarks platinum_searcher heroku docker_ce git_flow postgresql

apt_update:
	sudo apt update

git:
	sudo apt install -y git

wget:
	sudo apt install -y wget tree

tree:
	sudo apt install -y tree

ruby: apt_update
	# Ruby dep
	sudo apt install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs ruby-dev \
	&& sudo apt install -y ruby

php:
	# PHP (Not work perfectly after installation. maybe not enough list of dependencies)
	sudo apt install -y php php-xdebug bison re2c bzip2

composer: php
	# Composer
	mkdir -p ~/.local/bin \
	&& cd ~/.local/bin \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& cd

vim: ruby
	# Vim plugin dep
	# (if not enabled clipboard function)
	sudo apt install -y vim vim-gtk \
	&& sudo gem install flog flay bundler \
	&& sudo apt install -y ctags
	## Vim plugin manager
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

dotfiles: git
	# Dotfiles
	git clone https://github.com/gouf/dotfiles.git ~/.dotfiles \
	&& cd ~/.dotfiles \
	&& rm -f ~/.bashrc ~/.bash_profile \
	&& ln -s $(pwd)/.bashrc ~/.bashrc \
	&& ln -s $(pwd)/.bash_aliases ~/.bash_aliases \
	&& ln -s $(pwd)/.gitconfig ~/.gitconfig \
	&& ln -s $(pwd)/.railsrc ~/.railsrc \
	&& ln -s $(pwd)/.vimrc ~/.vimrc \

anyenv: git
	# anyenv
	git clone https://github.com/riywo/anyenv ~/.anyenv \
	&& . ~/.bashrc \
	&& anyenv install pyenv \
	&& anyenv install rbenv \
	&& anyenv install nodenv \
	&& anyenv install phpenv \
	&& . ~/.bashrc
	## anyenv update
	mkdir -p $(anyenv root)/plugins \
	&& git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

golang:
	sudo apt install -y golang

hub: golang git
	# hub
	cd \
	&& git clone https://github.com/github/hub.git \
	&& cd hub \
	&& make install prefix=$(HOME)/.local \
	&& cd \
	&& rm -rf hub

bashmarks: git ruby
	# bashmarks
	cd \
	&& git clone git://github.com/huyng/bashmarks.git \
	&& cd bashmarks \
	&& make install \
	&& cd \
	&& rm -rf bashmarks

platinum_searcher: golang
	# The Platinum Searcher
	go get -u github.com/monochromegane/the_platinum_searcher/...

heroku: wget
	# heroku
	wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

docker_ce:
	# Docker CE (Comunity Edition)
	sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual \
	&& sudo apt install -y apt-transport-https ca-certificates software-properties-common \
	&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
	&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
	&& sudo apt update \
	&& sudo apt install docker-ce \
	## docker gets control without sudo
	sudo groupadd docker \
	&& sudo gpasswd -a $(USER) docker

git_flow: wget
	# git-flow
	cd \
	&& curl -OL https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh \
	&& chmod +x gitflow-installer.sh \
	&& INSTALL_PREFIX=$(HOME)/.local/bin ./gitflow-installer.sh \
	&& rm -f gitflow-installer.sh \
	&& rm -rf gitflow
	## git-flow bash completion
	sudo wget https://github.com/bobthecow/git-flow-completion/raw/master/git-flow-completion.bash

postgresql:
	# PostgreSQL
	sudo apt install -y postgresql
