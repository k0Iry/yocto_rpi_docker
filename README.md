# yocto_container
Docker for yocto build of my raspberrypi 4 board

```
docker run -v /local/volume:/home/yocto/build -t -i kljsandjb/yocto_pi:latest
```

If you want to deal with the build configuration, you can change the start.sh as needed or run:

```
docker run -v /local/volume:/home/yocto/build -t -i kljsandjb/yocto_pi:latest /bin/bash
```

interactively changing the meta-layers or configurations.

Check the raspberrypi's bsp layer for more information, decide whatever features you want to enable. 

Refer to Yocto Project websiet for more guide. I recommend [Quick Build](https://www.yoctoproject.org/docs/3.1/brief-yoctoprojectqs/brief-yoctoprojectqs.html) to get started.

Check images built up here: https://hub.docker.com/repository/docker/kljsandjb/yocto_pi
