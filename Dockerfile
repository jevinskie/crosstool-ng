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
 && apt-get clean

# Fetch the kernel
ENV CCACHE_DIR=/ccache          \
    CCACHE_MAXSIZE=16G          \
    SRC_DIR=/usr/src/ctng
RUN mkdir -p ${SRC_DIR} ${CCACHE_DIR} \
 && cd /usr/local/bin           \
 && ln -s /usr/bin/ccache cc    \
 && ln -s /usr/bin/ccache c++   \
 && ln -s /usr/bin/ccache gcc   \
 && ln -s /usr/bin/ccache g++   \
 && cd ${SRC_DIR}               \
 && ./configure                 \
 && make install                \
 && ct-ng oldconfig             \
 && ct-ng sources
WORKDIR ${SRC_DIR}
