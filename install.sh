#! /bin/bash

git checkout master
git submodule update --init --recursive

docker pull mikexyliu/rlgpu:latest
