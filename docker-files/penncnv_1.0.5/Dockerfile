FROM ubuntu:24.04

# install system libraries
RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y \
    build-essential \
    libperl-dev \
    r-base \
    curl

# install PennCNV
RUN curl -LJO https://github.com/WGLab/PennCNV/archive/refs/tags/v1.0.5.tar.gz
COPY PennCNV-1.0.5.tar.gz /opt/PennCNV-1.0.5.tar.gz
RUN cd /opt && \
  tar xzf PennCNV-1.0.5.tar.gz && \
  rm PennCNV-1.0.5.tar.gz
ENV PATH="/opt/PennCNV-1.0.5:${PATH}"
RUN cd /opt/PennCNV-1.0.5/kext && \
  make

RUN apt-get install -y ghostscript

# Source: https://github.com/romanhaa/docker-containers/blob/master/PennCNV/1.0.5/Dockerfile