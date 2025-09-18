FROM debian:12

# Add user.
ARG USERNAME=test
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    apt update -y && \
    apt install -y sudo && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Install compilation dependencies.
RUN apt update -y && \
    apt install -y build-essential gfortran ninja-build lld mold cmake ccache \
    git python3-pip python3-venv libxml2-dev libtinfo-dev wget doxygen

# Create a Python virtual environment.
COPY ./setup_venv.sh /tmp/
RUN chmod +x /tmp/setup_venv.sh && /tmp/setup_venv.sh

# Install LLVM.
ARG LLVM_PARALLEL_COMPILE_JOBS=10
ARG LLVM_PARALLEL_LINK_JOBS=1
ARG LLVM_BUILD_TYPE=Release
ARG LLVM_ENABLE_ASSERTIONS=ON

COPY ./install_llvm.sh /tmp/

RUN chmod +x /tmp/install_llvm.sh && \
    cd /root && \
    /tmp/install_llvm.sh

RUN apt update -y && \
    apt install -y libasan6
