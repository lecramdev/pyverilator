FROM ubuntu:20.04

ARG VERILATOR_VERSION="v4.224"
WORKDIR /workspace/pyverilator

ENV SHELL=/bin/bash

# install Verilator from source to get the right version
RUN apt-get update && apt-get install -y git perl python3 make autoconf g++ flex bison ccache libgoogle-perftools-dev numactl perl-doc libfl2 libfl-dev zlibc zlib1g zlib1g-dev
RUN git clone https://github.com/verilator/verilator
RUN cd verilator && \
    git checkout $VERILATOR_VERSION && \
    autoconf && \
    ./configure && \
    make -j4 && \
    make install

RUN apt-get update && apt-get install -y python3-pip

RUN pip3 install ipython
RUN pip3 install pytest
RUN pip3 install pytest-xdist[psutil]
RUN pip3 install numpy

COPY . .
RUN pip3 install -e .
