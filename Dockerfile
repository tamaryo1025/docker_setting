FROM ubuntu:20.04

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
USER root

# update and install
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    wget \
    curl \
    git \
    python-openssl \
    xvfb \
    python-opengl \
    node-gyp \
    icewm \
    python3 \
    python3-pip
RUN apt-get install -y software-properties-common

# install jupyter lab
RUN apt-get update -y && apt-get install -y \
    libgl1-mesa-glx wget curl git tmux imagemagick htop libsndfile1\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip install jupyterlab

# install nodejs
RUN wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && \
    exec bash && \
    . ~/.bashrc && \
    nvm install v14.17.0

# install code server
RUN pip install jupyter-server-proxy
RUN pip install jupyter-vscode-proxy
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server \
    --install-extension ms-python.python \
    --install-extension ms-ceintl.vscode-language-pack-ja


# install R 
RUN apt-get update -y && \
    apt-get install -y \
    r-base libzmq3-dev libcurl4-openssl-dev libssl-dev
RUN Rscript -e "install.packages(c('repr', 'IRdisplay', 'IRkernel'), type = 'source')"

# # inport python library
# RUN pip install \
#     opencv-python \
#     numpy \
#     pandas \
#     matplotlib \
#     scipy \
#     beautifulsoup4 \
#     scikit-learn

RUN pip install jupyterlab-novnc

# matplotlib日本語化
RUN pip install japanize-matplotlib

RUN apt-get update -y && \
    apt-get install -y \
    screen

#要変更 idコマンドでローカルの値確認が必要、ユーザー名もリモート登録名に変更
ARG USER_ID=1007
ARG GROUP_ID=1008
ENV USER_NAME=tamaki

RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -d /home/${USER_NAME} -m -s /bin/bash -u ${USER_ID} -g ${GROUP_ID} ${USER_NAME}
WORKDIR /home/${USER_NAME}

USER ${USER_NAME}
ENV HOME /home/${USER_NAME}

# anaconda
RUN set -x && \
    wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh && \
    bash Anaconda3-2019.10-Linux-x86_64.sh -b && \
    rm Anaconda3-2019.10-Linux-x86_64.sh

# path setteing
ENV PATH $PATH:/home/${USER_NAME}/anaconda3/bin
RUN mkdir workdir

RUN touch setup.R & \
    echo "IRkernel::installspec()" > setup.R

# ENV NB_PREFIX /
ENV DISPLAY=":1.0"


