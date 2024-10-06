# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables to non-interactive for automated install
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME /root

# Update and install basic tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    zip \
    vim \
    nano \
    ca-certificates \
    software-properties-common \
    apt-transport-https \
    lsb-release \
    build-essential \
    python3 \
    python3-pip \
    php \
    docker.io \
    bash-completion \
    sudo \
    tmux


# Install other build tools (as required)
RUN apt-get install -y \
    cmake \
    automake \
    libtool \
    pkg-config \
    gdb \
    g++

# Clean up apt cache and unnecessary files
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Oh My Bash
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" || true

# Install Node Version Manager (NVM)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Set up NVM in the environment
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install --lts && nvm use --lts


# Install Docker
RUN curl -fsSL https://get.docker.com | sh
RUN usermod -aG docker root
# Install Docker
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
#     add-apt-repository \
#     "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
#     apt-get update && \
#     apt-get install -y docker-ce docker-ce-cli containerd.io


# rust
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -y
RUN curl --proto '=https' --tlsv1.2 -sSf -o rustup-init.sh https://sh.rustup.rs \
    && sh rustup-init.sh -y \
    && rm rustup-init.sh
# RUN source ~/.bashrc
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install bottom tealdeer 


# Copy the tmux configuration file
COPY .tmux.conf /root/.tmux.conf

RUN apt install duf

ENV DEBIAN_FRONTEND=dialog
# Optional: Clean up the home directory and only keep the required files
# RUN rm -rf /root/* && \
#     cp /etc/skel/.bashrc /root/.bashrc && \
#     cp /etc/skel/.profile /root/.profile && \
#     cp /etc/skel/.bash_logout /root/.bash_logout

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# Start a long-running process (like tmux)
# CMD ["tmux", "new", "-s", "my_session"]

CMD ["sleep", "infinity"]