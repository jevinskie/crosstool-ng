#!/usr/bin/env bash

docker build -t ctng .

docker run --rm -v $(PWD)/:/usr/src/ctng -it ctng bash
