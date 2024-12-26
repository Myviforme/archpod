FROM ubuntu:latest

# Install dependencies needed for building
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    ca-certificates \
    software-properties-common

# Add the LLVM APT repository
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh

# Install LLVM 19 (or your desired version)
RUN apt-get update && \
    apt-get install -y llvm-19 clang-19 lld-19

# Set alternatives (important)
RUN update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-19 190 && \
    update-alternatives --install /usr/bin/ld.lld ld.lld /usr/bin/ld.lld-19 190 && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 190 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-19 190 && \
    update-alternatives --install /usr/bin/llvm-objdump llvm-objdump /usr/bin/llvm-objdump-19 190 && \
    update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-19 190

# Set default alternatives
RUN update-alternatives --set llvm-ar /usr/bin/llvm-ar-19 && \
    update-alternatives --set ld.lld /usr/bin/ld.lld-19 && \
    update-alternatives --set clang /usr/bin/clang-19 && \
    update-alternatives --set clang++ /usr/bin/clang++-19 && \
    update-alternatives --set llvm-objdump /usr/bin/llvm-objdump-19 && \
    update-alternatives --set llvm-nm /usr/bin/llvm-nm-19

# Set environment variables (for CMake and other build systems)
ENV AR /usr/bin/llvm-ar-19
ENV LD /usr/bin/ld.lld-19
ENV CC /usr/bin/clang-19
ENV CXX /usr/bin/clang++-19

# Set the working directory
WORKDIR /workspace

# Copy your project files
COPY . /workspace
