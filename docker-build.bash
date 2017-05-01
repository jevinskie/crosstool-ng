#!/usr/bin/env bash

docker build -t ctng .

docker run -v $(PWD)/:/usr/src/ctng -it ctng
