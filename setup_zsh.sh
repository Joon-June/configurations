#!/bin/bash
# This script automates setting up zsh and related utility tools
# ./setup_zsh.sh

sudo apt install -y zsh
echo "DONE installing zsh!"

[[ -e ~/.oh-my-zsh ]] | rm -r ~/.oh-my-zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "DONE installing oh-my-zsh!"

sudo chsh -s $(which zsh)
echo "DONE changing to zsh!"

git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
echo "DONE downloading p10k!"

SERVER_NAME="please fill"
SERVER_INFO="please fill"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
echo "function prompt_device_info() { p10k segment -t 'server_info: $SERVER_NAME ($SERVER_INFO)]' -b 4 -f 'black'}" >> ~/.zshrc \
&& echo "POWERLEVEL9K_MODE='nerdfont-complete'" >> ~/.zshrc \
&& echo "POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'" >> ~/.zshrc \
&& echo "POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)" >> ~/.zshrc \
&& echo "POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(device_info time)" >> ~/.zshrc \
&& echo "POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT=true" >> ~/.zshrc
echo "DONE setting up p10k variables!"
