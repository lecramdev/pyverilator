FROM python:3

WORKDIR /workspace/pyverilator

ENV SHELL=/bin/bash

RUN apt-get update
RUN apt-get install -y verilator
RUN pip install ipython
RUN pip install pytest
RUN pip install pytest-xdist[psutil]

COPY . .
RUN pip install -e .
