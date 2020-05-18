FROM debian:9

SHELL ["/bin/bash", "-c"]

RUN useradd -u 1000 --create-home --shell /bin/bash yocto && \
    apt-get clean && \
    apt-get update && \
    apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat libsdl1.2-dev xterm cpio -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install locales -y && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    git clone git://git.yoctoproject.org/poky /home/yocto/poky && \
    git clone git://git.yoctoproject.org/meta-raspberrypi /home/yocto/meta-raspberrypi && \
    git clone https://github.com/openembedded/meta-openembedded.git /home/yocto/meta-openembedded && \
    git clone https://github.com/k0Iry/meta-rpilinux.git /home/yocto/meta-rpilinux

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /home/yocto
USER yocto

COPY start.sh /home/yocto/

VOLUME /home/yocto/build

CMD ["./start.sh"]
