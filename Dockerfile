# Use your existing Isaac Gym base image
FROM isaacgym

# Set environment variables
ENV PATH /opt/conda/bin:$PATH
ENV CONDA_DIR /opt/conda
ENV ENV_DIR /workspace/env

USER root
RUN apt-get update \
  && apt-get install -y ssh \
      build-essential \
      gcc \
      g++ \
      gdb \
      clang-8 \
      cmake \
      rsync \
      tar \
      python \
  && apt-get clean

RUN mkdir -p /run/sshd

# Configure SSH
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# Set the working directory
WORKDIR /workspace/src

CMD ["/usr/sbin/sshd", "-D"]

