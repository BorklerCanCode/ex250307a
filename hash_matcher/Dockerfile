# Use a base image with build tools
FROM ubuntu:latest

# Install cross-compilers and other tools
RUN apt-get update && apt-get install -y \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    gcc-x86-64-linux-gnu \
    g++-x86-64-linux-gnu \
    cmake \
    make \
    && rm -rf /var/lib/apt/lists/*

# Define a build script that handles both architectures
COPY build.sh /build.sh
RUN chmod +x /build.sh

# Set the entry point to the build script
ENTRYPOINT ["/build.sh"]

