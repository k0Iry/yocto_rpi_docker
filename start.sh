#!/bin/bash

git clone git://git.yoctoproject.org/poky
git clone git://git.yoctoproject.org/meta-raspberrypi
git clone git://git.yoctoproject.org/meta-virtualization
git clone https://github.com/openembedded/meta-openembedded.git
git clone https://github.com/k0Iry/meta-rpilinux.git

rm -rf build/*
source poky/oe-init-build-env

# bitbake-layers is not very reliable for adding layers
# we do it so manually
cat >> "conf/bblayers.conf" << EOF
BBLAYERS += " /home/yocto/meta-raspberrypi "
BBLAYERS += " /home/yocto/meta-rpilinux "
BBLAYERS += " /home/yocto/meta-virtualization "
BBLAYERS += " /home/yocto/meta-openembedded/meta-networking "
BBLAYERS += " /home/yocto/meta-openembedded/meta-python "
BBLAYERS += " /home/yocto/meta-openembedded/meta-oe "
EOF

# override variable MACHINE if you want to
# build another target, e.g. you don't want 64 bits
# then you define MACHINE = raspberrypi4,
# find machines supported here: 
# https://github.com/agherzan/meta-raspberrypi/tree/master/conf/machine
cat >> "conf/local.conf" << EOF
MACHINE = "raspberrypi4-64"
IMAGE_FSTYPES = "tar.xz ext3 rpi-sdimg"
ENABLE_UART = "1"
EOF

bitbake rpilinux-image

# cleaning
ls | grep -v tmp | xargs rm -rf
cd tmp
ls | grep -v deploy | xargs rm -rf
