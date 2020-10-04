#!/usr/bin/env python3

import urllib.request
import sys
import os
import json
from pathlib import Path

access_token = ""
asset_path = "build/tmp/deploy/images/raspberrypi4-64/rpilinux-image-raspberrypi4-64.rpi-sdimg"

def create_release(tag_name, body, name):
    release_url = "https://api.github.com/repos/k0Iry/yocto_rpi_docker/releases"
    # encode the parameters
    request_body = {"tag_name": tag_name, "body": body, "name": name}
    # a POST request
    request = urllib.request.Request(release_url)
    # request header for auth
    request.add_header("Authorization", "token {}".format(access_token))
    # request for newly added release
    response = urllib.request.urlopen(request, data=json.dumps(request_body).encode())
    
    if response.getcode() != 201:
        print("create release failed, HTTP Code: {}".format(response.getcode()))
        exit(1)
    string = response.read().decode('utf-8')
    json_obj = json.loads(string)

    if "upload_url" in json_obj:
        return json_obj["upload_url"]
    else:
        print("missing upload url")
        exit(1)

def upload_asset(tag_name, body, name):
    upload_url = create_release(tag_name, body, name)
    image = Path(asset_path)
    upload_url = upload_url.replace("{?name,label}", "?name={}".format(os.path.basename(asset_path)))
    if not image.exists():
        print("missing asset")
        exit(1)
    binary = open(asset_path, "rb")
    request = urllib.request.Request(upload_url)
    request.add_header("Authorization", "token {}".format(access_token))
    request.add_header("Content-Type", "application/octet-stream")
    # start to upload the asset to the release
    print("Asset is uploading...")
    response = urllib.request.urlopen(request, data=binary.read())
    binary.close()

    if response.getcode() != 201:
        print("upload asset failed, HTTP Code: {}".format(response.getcode()))
        exit(1)
    print("Asset has been successfully upload!")

def main():
    if len(sys.argv) != 4:
        print("Please specify:\n\tThe name of the tag.(tag_name) \
        \n\tText describing the contents of the tag.(body) \
        \n\tThe name of the release.(name)\n")
        exit(1)
    upload_asset(sys.argv[1], sys.argv[2], sys.argv[3])

if __name__ == "__main__":
    main()
