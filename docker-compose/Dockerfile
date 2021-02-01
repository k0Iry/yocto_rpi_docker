FROM debian:latest

RUN useradd -u 1000 --create-home --shell /bin/bash yocto && \
    apt-get clean && \
    apt-get update && \
    apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat python3 python3-distutils cpio vim -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install locales -y && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

WORKDIR /home/yocto
USER yocto

COPY start.sh /home/yocto/
COPY github-release.py /home/yocto/

VOLUME /home/yocto/build

CMD ["./start.sh"]
