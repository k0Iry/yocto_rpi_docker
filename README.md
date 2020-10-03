# yocto_container

Build image by Yocto for Raspberrypi 4 board.

## How to use?
### For docker CLI:

```
docker run -v /local/volume:/home/yocto/build -t -i kljsandjb/yocto_pi:latest
```

If you want to deal with the build configuration, you can change the start.sh as needed or run:

```
docker run -v /local/volume:/home/yocto/build -t -i kljsandjb/yocto_pi:latest /bin/bash
```

to interactively changing the meta-layers or configurations.

### For docker compose with file server(Nginx) built in:

```
docker-compose up -d

docker exec -it yocto_pi bash

.... # make some changes on your own

./start.sh
```

Open your browser and navigate to http://localhost:8080 to see your results and download the files you need.

## Tips:

Check the raspberrypi's bsp layer for more information, decide whatever features you want to enable. 

Refer to Yocto Project websiet for more guide. I recommend [Quick Build](https://www.yoctoproject.org/docs/3.1/brief-yoctoprojectqs/brief-yoctoprojectqs.html) to get started.

Check docker image here: https://hub.docker.com/repository/docker/kljsandjb/yocto_pi

## Release

Use python script to create the release and upload the file to it, need to fetch your own access token at first.
