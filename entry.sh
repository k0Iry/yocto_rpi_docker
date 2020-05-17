#!/bin/bash

chown -R yocto:yocto /home/yocto/build
exec runuser -u yocto "$@"
