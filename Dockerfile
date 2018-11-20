# Rappel-docker
#
# Run: 
#   docker run -ti --cap-add=SYS_PTRACE --security-opt seccomp=unconfined alanvivona/rappel-docker
# 
# This will disable security features but will allow rappel to run in interactive mode. 
#

# Using Ubuntu latest as base image.
FROM ubuntu:latest

# Label base
LABEL rappel-docker latest

# Build and install radare2 on master branch
RUN apt-get update

# Dependencies
RUN apt-get install -y \
  gcc \
  git \
  make \
  sudo \
  build-essential \
  libedit-dev \
  nasm \
  binutils

# Extras
RUN apt-get install -y \
  curl \
  vim

# Create non-root user
RUN useradd -m rappel && adduser rappel sudo && echo "rappel:rappel" | chpasswd

# Initilise base user
USER rappel
WORKDIR /home/rappel
ENV HOME /home/rappel

# Rappel
USER rappel
RUN git clone -q https://github.com/yrp604/rappel.git
WORKDIR /home/rappel/rappel
RUN make
ENV PATH="/home/rappel/rappel/bin:${PATH}"

# Cleanup
USER root
RUN apt-get autoremove --purge -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Base command for container
USER rappel
ENTRYPOINT rappel
