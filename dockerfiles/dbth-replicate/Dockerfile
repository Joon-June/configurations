FROM nvidia/cuda:12.0.1-cudnn8-devel-ubuntu22.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


# Packages
RUN apt-get update -y
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y sudo
RUN apt-get install -y python3.10
RUN apt-get install -y python3-distutils
RUN apt-get install -y libglib2.0-0 libsm6 libxext6 libxrender-dev bmon iotop g++
RUN apt-get install -y git ca-certificates htop curl wget net-tools zsh ssh openssh-server fonts-powerline vim zip ffmpeg


# Use python instead of python3 for simplicity
RUN ln -sv /usr/bin/python3.10 /usr/bin/python
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN rm get-pip.py


# Install Python libraries
ARG PIP_INSTALL="python -m pip --no-cache-dir install"

RUN $PIP_INSTALL black isort flake8 autoflake add-trailing-comma
RUN $PIP_INSTALL numpy
RUN $PIP_INSTALL torch==1.13.0+cu116 torchvision==0.14.0+cu116 torchaudio==0.13.0 --extra-index-url https://download.pytorch.org/whl/cu116
RUN $PIP_INSTALL setuptools==59.6.0
RUN $PIP_INSTALL albumentations==1.1.0 opencv-python==4.7.0.72
RUN $PIP_INSTALL tensorboard==2.11.0
RUN $PIP_INSTALL pytorch-lightning==1.8.6
RUN $PIP_INSTALL diffusers==0.10.0
RUN $PIP_INSTALL ftfy==6.1.1
RUN $PIP_INSTALL scipy==1.9.3
RUN $PIP_INSTALL transformers==4.25.1
RUN $PIP_INSTALL accelerate==0.14.0
RUN $PIP_INSTALL bitsandbytes==0.35.4
RUN $PIP_INSTALL omegaconf==2.3.0


# Install oh-my-zsh & p10k
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN chsh -s $(which zsh)
RUN git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
RUN echo "POWERLEVEL9K_MODE='nerdfont-complete'" >> ~/.zshrc \
    && echo "POWERLEVEL9K_CUSTOM_INFO='echo server_info: 161-dbth'" >> ~/.zshrc \
    && echo "POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)" >> ~/.zshrc \
    && echo "POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_info)" >> ~/.zshrc \
    && echo "POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'" >> ~/.zshrc


# SSH Settings
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g"  /etc/ssh/sshd_config
RUN sed -i "s/#Port 22/Port 4009/g" /etc/ssh/sshd_config
RUN echo "root:PASSWD" | chpasswd


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

