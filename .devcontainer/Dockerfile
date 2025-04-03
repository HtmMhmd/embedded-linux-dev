FROM ubuntu:20.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages for Yocto Dunfell
RUN apt-get update && apt-get install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio \
    python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git \
    python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit \
    mesa-common-dev zstd liblz4-tool file locales

# Set the locale to avoid issues
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a non-root user
RUN groupadd --gid 1000 yoctouser \
    && useradd --uid 1000 --gid yoctouser --shell /bin/bash --create-home yoctouser \
    && echo "yoctouser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install additional tools for development
RUN apt-get install -y \
    vim nano curl tmux \
    gcc-multilib g++-multilib \
    cmake ninja-build pkg-config \
    autoconf automake libtool

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch to non-root user
USER yoctouser
WORKDIR /home/yoctouser

# Setup Yocto environment variables
RUN echo 'export TEMPLATECONF=${TEMPLATECONF:-meta-poky/conf}' >> ~/.bashrc \
    && echo 'export BB_ENV_PASSTHROUGH_ADDITIONS="TEMPLATECONF"' >> ~/.bashrc
