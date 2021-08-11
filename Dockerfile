FROM ubuntu:20.04

RUN mkdir /tools/

RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt -y install tzdata
RUN apt install -y gdb wget curl software-properties-common python2 python2-dev python3 python3-dev python3-pip binutils
RUN pip install --upgrade pip
RUN pip install setuptools
RUN apt -y install --no-install-recommends gcc-multilib g++-multilib \
    && apt clean
RUN dpkg --add-architecture i386 \
    && apt update \
    && apt -y install --no-install-recommends xz-utils libc6-dbg libc6-dbg:i386 libc6:i386 glibc-source \
    && apt clean \
    && tar -C /usr/src/glibc/ -xf /usr/src/glibc/glibc-*.tar.xz
RUN apt install git-all -y
RUN apt-get install unzip -y
RUN apt-get install ruby ruby-dev -y 
RUN apt-get install libcapstone-dev -y 
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
RUN cd /tools \
    && git clone https://github.com/JonathanSalwan/ROPgadget \
    && cd ROPgadget \
    && python3 setup.py install --user
RUN pip3 install prompt_toolkit
RUN cd /tools \
    && git clone https://github.com/Boyan-MILANOV/ropium \
    && cd ropium \
    && make \
    && make test \
    && make install
RUN apt install -y vim tmux zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN chsh -s $(which zsh)
RUN apt install -y sudo
RUN cd /tools \
    && git clone https://github.com/mavam/dotfiles.git ~/.dotfiles \
    && cd ~/.dotfiles \
    && ./bootstrap dotfiles \
    && ./bootstrap zsh vim tmux

WORKDIR /