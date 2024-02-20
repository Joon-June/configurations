FROM nvidia/cuda:12.0.1-cudnn8-devel-ubuntu22.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


# Packages
RUN apt-get update -y
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y sudo
RUN apt-get install -y python3.10
RUN apt-get install -y python3.10-distutils
RUN apt-get install -y libglib2.0-0 libsm6 libxext6 libxrender-dev bmon iotop g++
RUN apt-get install -y git ca-certificates htop curl wget net-tools zsh ssh openssh-server fonts-powerline vim zip ffmpeg


# Use python instead of python3 for simplicity
RUN ln -sv /usr/bin/python3.10 /usr/bin/python
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN rm get-pip.py


# Install Python libraries
ARG PIP_INSTALL="python -m pip --no-cache-dir install"

RUN $PIP_INSTALL ruff 
RUN $PIP_INSTALL numpy
RUN $PIP_INSTALL torch torchvision torchaudio
RUN $PIP_INSTALL setuptools==59.6.0
RUN $PIP_INSTALL albumentations==1.1.0 opencv-python==4.7.0.72


# Install oh-my-zsh & p10k
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN chsh -s $(which zsh)
RUN git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
RUN echo "POWERLEVEL9K_MODE='nerdfont-complete'" >> ~/.zshrc \
    && echo "POWERLEVEL9K_CUSTOM_INFO='echo server_info: [SERVER_INFO]'" >> ~/.zshrc \
    && echo "POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)" >> ~/.zshrc \
    && echo "POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_info time)" >> ~/.zshrc \
    && echo "POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'" >> ~/.zshrc


# SSH Settings
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g"  /etc/ssh/sshd_config
RUN sed -i "s/#Port 22/Port 4009/g" /etc/ssh/sshd_config
RUN echo "root:[PASSWD]" | chpasswd


# ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc > /dev/null 
RUN echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list 
RUN sudo apt update
RUN sudo apt install ngrok

# vim settings
RUN mkdir -p /root/.vim/colors
WORKDIR /root/.vim/colors
RUN curl -sO https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
WORKDIR /root
RUN curl -o .vimrc https://raw.githubusercontent.com/Joon-June/configurations/master/my_vimrc

# Extra settings
WORKDIR /root
# ENTRYPOINT service ssh restart - TODO...

