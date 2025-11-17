FROM ubuntu:22.04

RUN apt update && apt install -y \
    git \
    openjdk-11-jre-headless \
    maven \
    python-is-python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    libssl-dev \
    libffi-dev \
    flex \
    bison \
    build-essential \
    cmake \
    libboost-all-dev \
    curl \
    libcurl4-openssl-dev

RUN python3 -m pip install dxpy
