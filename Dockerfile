FROM ubuntu:rolling

MAINTAINER Jevin Sweval (@jevinskie)

# Install dependencies
RUN apt update                   \
 && apt -y -q upgrade            \
 && apt-get clean

RUN apt -y -q install            \
    software-properties-common   \
 && add-apt-repository -y -s     \
    ppa:ubuntu-toolchain-r/test  \
 && apt-get clean

RUN apt update                   \
 && apt -y -q upgrade            \
 && apt -y -q install            \
    autoconf                     \
    automake                     \
    bison                        \
    build-essential              \
    ccache                       \
    nano                         \
    file                         \
    flex                         \
    gawk                         \
    gcc                          \
    g++                          \
    gperf                        \
    gdb                          \
    git                          \
    help2man                     \
    libncurses-dev               \
    libssl-dev                   \
    pkg-config                   \
    texinfo                      \
    vim                          \
    wget                         \
    xz-utils                     \
    zsh                          \
 && apt-get clean

SHELL ["/bin/zsh", "-c"]

# Fetch the kernel
ENV CCACHE_DIR=/ccache          \
    CCACHE_MAXSIZE=16G          \
    PATH=${PATH}:/tmp/ctng/dotbuild/mipsel-unknown-linux-gnu/build/build-libc-startfiles/multilib \
    SRC_DIR=/usr/src/ctng

RUN mkdir -p ${SRC_DIR} ${CCACHE_DIR} \
 && cd /usr/local/bin           \
 && ln -s /usr/bin/ccache cc    \
 && ln -s /usr/bin/ccache c++   \
 && ln -s /usr/bin/ccache gcc   \
 && ln -s /usr/bin/ccache g++   \
 && cd ~                        \
 && git clone https://github.com/jevinskie/oh-my-zsh .oh-my-zsh \
 && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
 && touch ~/.my_rc              \
 && chsh -s /bin/zsh            \
 && git clone -b jevmaster https://github.com/jevinskie/crosstool-ng ${SRC_DIR}

WORKDIR ${SRC_DIR}

ADD mah-config ${SRC_DIR}/.config

RUN ./bootstrap             \
 && ./configure             \
 && make install

# RUN ct-ng oldconfig
