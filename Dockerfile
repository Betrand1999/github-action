# Use the official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to non-interactive to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    --no-install-recommends && \
    apt-get clean

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    apt-get clean

# Install JFrog CLI
RUN curl -fL https://getcli.jfrog.io | sh && \
    mv jfrog /usr/local/bin/

# Add a non-root user
RUN useradd -m -d /home/runner -s /bin/bash runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user
USER runner
WORKDIR /home/runner

# Download and install GitHub Actions runner
RUN RUNNER_VERSION="2.283.3" && \
    RUNNER_HOME="/home/runner/actions-runner" && \
    mkdir -p $RUNNER_HOME && \
    cd $RUNNER_HOME && \
    curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm -f actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    sudo ./bin/installdependencies.sh

# Define entrypoint
ENTRYPOINT ["/bin/bash"]
