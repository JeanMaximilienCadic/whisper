FROM pytorch/pytorch:1.13.0-cuda11.6-cudnn8-devel

# Install dependencies
USER root
RUN apt update && \
    apt install \
    openssh-server \
    nano \
    sudo \
    rsync \
    git \
    nano \
    wget \
    make \
    -y

## Add foo user
RUN adduser --disabled-password --gecos '' foo
RUN adduser foo sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'export PYTHONPATH=/workspace' >> /home/foo/.bashrc
