FROM archlinux:latest

# Install necessary packages (including base-devel for build tools)
RUN pacman -Syu --noconfirm base-devel sudo git cmake wget

# Install LLVM (choose your desired version, e.g., 16, 17, or llvm-git for latest)
# For a specific release version (e.g. 16):
RUN pacman -Syu --noconfirm llvm16 clang16 lld16

# OR for the latest development version from git (more involved, use with caution):
# RUN pacman -Syu --noconfirm git
# RUN git clone https://gitlab.com/llvm/llvm.git /tmp/llvm
# RUN cd /tmp/llvm && mkdir build && cd build && \
#     cmake -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS="clang;lld" ../ && \
#     make -j$(nproc) && make install

# Create a non-root user (recommended for security)
RUN useradd -m gitpod
USER gitpod
WORKDIR /home/gitpod/workspace

# Copy your project files
COPY . /home/gitpod/workspace

# Example build command (adjust as needed)
# RUN cmake -B build && cmake --build build

# Set up environment variables (if needed, adjust paths for llvm-git)
# ENV AR /usr/bin/llvm-ar-16 #For release version
# ENV LD /usr/bin/ld.lld-16 #For release version
# ENV CC /usr/bin/clang-16 #For release version
# ENV CXX /usr/bin/clang++-16 #For release version
# or for llvm-git
# ENV AR /usr/local/bin/llvm-ar
# ENV LD /usr/local/bin/ld.lld
# ENV CC /usr/local/bin/clang
# ENV CXX /usr/local/bin/clang++

# Example command to run on workspace start
# CMD ["./build/your-executable"]
