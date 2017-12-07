#!/bin/sh

# Deploy this file where to own domain, like ubuntu.example.com/setup.sh

sudo apt update && sudo apt upgrade -y \
  && sudo apt install -y make \
  && curl https://raw.githubusercontent.com/gouf/dotfiles/master/Makefile > Makefile \
  && make \
  && rm Makefile
