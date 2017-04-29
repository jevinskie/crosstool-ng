FROM ubuntu:rolling

MAINTAINER Jevin Sweval (@jevinskie)

# Install dependencies
RUN apt update                   \
 && apt -y -q install            \
    software-properties-common   \
 && add-apt-repository -y -s     \
    ppa:ubuntu-toolchain-r/test  \
 && apt update                   \
 && apt -y -q upgrade            \
 && apt -y -q install            \
    autoconf                     \
    automake                     \
    bison                        \
    build-essential              \
    ccache                       \
    clang                        \
    nano                         \
    file                         \
    flex                         \
    gawk                         \
    gcc                          \
    g++                          \
    gcc-6                        \
    g++-6                        \
    gperf                        \
    gdb                          \
    git                          \
    help2man                     \
    lldb                         \
    llvm                         \
    libncurses-dev               \
    libssl-dev                   \
    pkg-config                   \
    texinfo                      \
    vim                          \
    wget                         \
    xz-utils                     \
 && apt-get clean

# Fetch the kernel
ENV CCACHE_DIR=/ccache          \
    SRC_DIR=/usr/src/ctng
RUN mkdir -p ${SRC_DIR} ${CCACHE_DIR} \
 && cd ${SRC_DIR}
WORKDIR ${SRC_DIR}
