#!/bin/bash

rm -rf build/*
rm -f entry.sh
source poky/oe-init-build-env

cat >> "conf/bblayers.conf" << EOF
BBLAYERS += " /home/yocto/meta-raspberrypi "
BBLAYERS += " /home/yocto/meta-rpilinux "
BBLAYERS += " /home/yocto/meta-openembedded/meta-networking "
BBLAYERS += " /home/yocto/meta-openembedded/meta-python "
BBLAYERS += " /home/yocto/meta-openembedded/meta-oe "
EOF

cat >> "conf/local.conf" << EOF
MACHINE = "raspberrypi4-64"
IMAGE_FSTYPES = "tar.xz ext3 rpi-sdimg"
ENABLE_UART = "1"
EOF

bitbake rpilinux-image
rm -rf build/downloads build/sstate-cache
