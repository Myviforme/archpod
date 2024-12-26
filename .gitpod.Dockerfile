FROM archlinux:latest

# Install basic utilities and Gitpod tools
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    git \
    base-devel \
    wget \
    curl \
    vim \
    sudo \
    python \
    nodejs \
    npm \
    openssh \
    tar \
    gzip \
    unzip \
    gitpod-cli

# Add a non-root user for Gitpod
RUN useradd -ms /bin/bash gitpod && echo "gitpod:gitpod" | chpasswd && adduser gitpod sudo

USER gitpod
WORKDIR /workspace

# Set up default shell
CMD ["/bin/bash"]
