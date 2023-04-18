#! /bin/bash

git clone https://github.com/LXYYY/rlgpu_docker.git && cd rlgpu_docker
git checkout master
git submodule update --init --recursive

docker pull mikexyliu/rlgpu:latest
