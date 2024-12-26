FROM archlinux:latest

# Clear database locks, update keyring, and refresh mirrors
RUN rm -f /var/lib/pacman/db.lck && \
    pacman -Syu --noconfirm --disable-landlock && \
    pacman -S --noconfirm archlinux-keyring reflector && \
    reflector --country "US" --latest 10 --sort rate --save /etc/pacman.d/mirrorlist && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    git base-devel wget curl vim sudo python nodejs npm openssh tar gzip unzip gitpod-cli

# Add a non-root user for Gitpod
RUN useradd -ms /bin/bash gitpod && echo "gitpod:gitpod" | chpasswd && adduser gitpod sudo

USER gitpod
WORKDIR /workspace

# Set default shell
CMD ["/bin/bash"]
