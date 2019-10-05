#
# Cookbook:: dotfiles
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

target_files = %w[
  .bashrc
  .bash_functions
  .bash_aliases
  .gitconfig
  .vimrc
  .tmux.conf
  .rubocop.yml
  .pryrc
]

target_files.each do |file_name|
  link "#{ENV['HOME']}/#{file_name}" do
    to "#{ENV['HOME']}/.dotfiles/#{file_name}"
    link_type :symbolic
  end
end

gem_package 'pry-theme'

brew_packages = %w[
  adns
  angular-cli
  ascii
  asciinema
  aspell
  autoconf
  automake
  azure-cli
  bash
  bash-completion
  bat
  berkeley-db
  bison
  brotli
  c-ares
  cairo
  ccat
  cfitsio
  clamav
  cmake
  colordiff
  composer
  coreutils
  ctags
  curl
  curl-openssl
  direnv
  docker
  docker-compose
  fd
  fftw
  fish
  fontconfig
  freetype
  fribidi
  gcc
  gdbm
  gdk-pixbuf
  gettext
  ghostscript
  giflib
  git
  gitsh
  glib
  gmp
  gnu-sed
  gnupg
  gnutls
  go
  gradle
  graphite2
  harfbuzz
  haskell-stack
  hdf5
  heroku
  heroku-node
  hub
  hwloc
  icu4c
  ilmbase
  imagemagick
  isl
  jansson
  jemalloc
  jpeg
  jq
  json-c
  kubernetes-cli
  libarchive
  libassuan
  libcroco
  libde265
  libev
  libevent
  libexif
  libffi
  libgcrypt
  libgpg-error
  libgsf
  libheif
  libidn
  libidn2
  libksba
  libmagic
  libmatio
  libmetalink
  libmpc
  libomp
  libpng
  librsvg
  libscrypt
  libssh2
  libtasn1
  libtiff
  libtool
  libunistring
  libusb
  libxml2
  libyaml
  libzip
  little-cms2
  lua
  lua@5.1
  luarocks
  lynx
  lzo
  mecab
  mecab-ipadic
  mpfr
  mysql
  ncurses
  netlify-cli
  nettle
  nghttp2
  nginx
  node
  npth
  nspr
  nss
  oniguruma
  open-mpi
  openexr
  openjpeg
  openldap
  openslide
  openssl
  openssl@1.1
  orc
  p11-kit
  packer
  pango
  pcre
  pcre2
  peco
  perl
  pinentry
  pixman
  pkg-config
  poppler
  popt
  postgresql
  protobuf
  protoc-gen-go
  pulumi
  python
  python@2
  qt
  re2c
  readline
  rpm
  rtmpdump
  ruby
  rust
  rustc-completion
  sbt
  shared-mime-info
  sqlite
  starship
  szip
  terminal-notifier
  terraform
  the_platinum_searcher
  thefuck
  tmux
  topgrade
  tor
  tree
  trivy
  unbound
  vim
  vips
  watch
  webp
  weechat
  wget
  wp-cli
  x265
  xz
  yara
  youtube-dl
  z
  zlib
  zstd
]

brew_packages.each do |package_name|
  homebrew_package package_name
end

#   chef/chef/chefdk
#   chef/chef/inspec
#   chef/chef/chef-workstation
brew_cask_packages = %w[
  1password
  alfred
  android-ndk
  atom
  cyberduck
  dash
  docker
  dotnet-sdk
  evernote
  google-japanese-ime
  growlnotify
  gyazo
  java
  julia
  keycastr
  latexit
  local-by-flywheel
  mactex-no-gui
  minikube
  ngrok
  notion
  oracle-jdk
  slack
  teamviewer
  tex-live-utility
  tor-browser
  tunnelbear
  vagrant
  virtualbox
  virtualbox-extension-pack
  visual-studio-code
  xmind
]

brew_cask_packages.each do |package_name|
  homebrew_cask package_name
end
