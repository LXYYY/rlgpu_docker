# Use your existing Isaac Gym base image
FROM isaacgym

# Set environment variables
ENV PATH /opt/conda/bin:$PATH
ENV CONDA_DIR /opt/conda
ENV ENV_DIR /workspace/env

# Copy the requirements file
COPY air_hockey_rlgpu_requirement.yml /tmp/air_hockey_rlgpu_environment.yml

# Create Conda environment from YAML file
RUN echo "source $CONDA_DIR/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate $ENV_DIR/air_hockey_rlgpu" >> ~/.bashrc && \
    conda env create -f /tmp/air_hockey_rlgpu_environment.yml -p $ENV_DIR/air_hockey_rlgpu && \
    conda clean -tipsy

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
WORKDIR /workspace

CMD ["/usr/sbin/sshd", "-D"]

