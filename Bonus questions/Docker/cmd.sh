#!/bin/bash
export DOCKER_CLI_EXPERIMENTAL=enabled
docker build --platform darwin -t your_image_name:tag .
