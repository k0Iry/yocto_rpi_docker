#!/bin/bash

git clone git://git.yoctoproject.org/poky
git clone git://git.yoctoproject.org/meta-raspberrypi
git clone git://git.yoctoproject.org/meta-virtualization
git clone https://github.com/openembedded/meta-openembedded.git
git clone https://github.com/k0Iry/meta-rpilinux.git

read -p "Are you sure you want to clean the build?[y/n] " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    rm -rf build/*
fi

source poky/oe-init-build-env

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    # bitbake-layers is not very reliable for adding layers
    # we do it so manually
    cat >> "conf/bblayers.conf" << EOF
    BBLAYERS += " $PWD/../meta-raspberrypi "
    BBLAYERS += " $PWD/../meta-rpilinux "
    BBLAYERS += " $PWD/../meta-virtualization "
    BBLAYERS += " $PWD/../meta-openembedded/meta-networking "
    BBLAYERS += " $PWD/../meta-openembedded/meta-filesystems "
    BBLAYERS += " $PWD/../meta-openembedded/meta-python "
    BBLAYERS += " $PWD/../meta-openembedded/meta-oe "
    EOF

    # override variable MACHINE if you want to
    # build another target, e.g. you don't want 64 bits
    # then you define MACHINE = raspberrypi4,
    # find machines supported here: 
    # https://github.com/agherzan/meta-raspberrypi/tree/master/conf/machine
    cat >> "conf/local.conf" << EOF
    DISTRO_FEATURES_append += "virtualization bluetooth wifi"
    MACHINE = "raspberrypi4-64"
    IMAGE_FSTYPES = "tar.xz ext3 rpi-sdimg"
    ENABLE_UART = "1"
    EOF
fi

bitbake rpilinux-image

status=$?

if test $status -eq 0
then
    echo "start to clean up..."
    ls | grep -v tmp | xargs rm -rf
    cd tmp
    ls | grep -v deploy | xargs rm -rf
fi
