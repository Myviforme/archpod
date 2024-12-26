FROM archlinux:latest

# Clear database lock if exists and set a reliable mirror
RUN rm -f /var/lib/pacman/db.lck && \
    echo "Server = https://mirror.rackspace.com/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

# Update the system and install required packages
RUN pacman -Sy --noconfirm && \
    pacman -S --noconfirm archlinux-keyring reflector && \
    reflector --country "US" --latest 10 --sort rate --save /etc/pacman.d/mirrorlist && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    git base-devel wget curl vim sudo python nodejs npm openssh tar gzip unzip gitpod-cli

# Add a non-root user for Gitpod
RUN useradd -ms /bin/bash gitpod && echo "gitpod:gitpod" | chpasswd && usermod -aG wheel gitpod

# Allow the 'gitpod' user to use sudo without a password
RUN echo "gitpod ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set the workspace directory
USER gitpod
WORKDIR /workspace

# Ensure bash is the default shell
CMD ["/bin/bash"]
