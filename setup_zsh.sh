sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
echo "function prompt_device_info() { p10k segment -t 'server_info: $SERVER_NAME ($SERVER_INFO)]' -b 4 -f 'black'}" >> ~/.zshrc \
&& echo "POWERLEVEL9K_MODE='nerdfont-complete'" >> ~/.zshrc \
&& echo "POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'" >> ~/.zshrc \
&& echo "POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)" >> ~/.zshrc \
&& echo "POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(device_info time)" >> ~/.zshrc
