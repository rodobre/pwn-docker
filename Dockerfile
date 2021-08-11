FROM ubuntu:20.04

RUN mkdir /tools/

RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt -y install tzdata
RUN apt update && apt install -y gdb wget curl software-properties-common python2 python2-dev python3 python3-dev python3-pip binutils
RUN pip install --upgrade pip
RUN pip install setuptools
RUN apt update \
    && apt -y install --no-install-recommends gcc-multilib g++-multilib \
    && apt clean
RUN dpkg --add-architecture i386 \
    && apt update \
    && apt -y install --no-install-recommends xz-utils libc6-dbg libc6-dbg:i386 libc6:i386 glibc-source \
    && apt clean \
    && tar -C /usr/src/glibc/ -xf /usr/src/glibc/glibc-*.tar.xz
RUN apt install git-all -y \
    && apt-get update
RUN apt-get install unzip -y
RUN apt-get install -y ruby ruby-dev \
    && apt-get update
RUN apt-get install nasm
RUN pip install pwntools
RUN pip install ropper
RUN pip install one_gadget
RUN gem install one_gadget
RUN cd /tools \
    && git clone --depth 1 https://github.com/devttys0/binwalk && cd binwalk \
    && python3 setup.py install
RUN apt-get install patchelf
RUN apt-get install -y strace ltrace
RUN apt-get install -y netcat socat
RUN apt-get install -y libseccomp-dev 
RUN gem install seccomp-tools
RUN cd /tools \
    && git clone https://github.com/pwndbg/pwndbg && cd /tools/pwndbg \
    && ./setup.sh
RUN pip install https://github.com/fireeye/flare-floss/zipball/master

WORKDIR /