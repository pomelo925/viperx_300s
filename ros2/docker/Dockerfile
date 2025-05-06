################################################################################################
# - Base stage
#   - This stage serves as the foundational stage for all other stages.
#   - Base image: Ubuntu 22.04
################################################################################################

FROM ubuntu:22.04 AS base

LABEL org.opencontainers.image.title="Docker Image of Interbotix ROS XSarms (Ubuntu 22.04)"
LABEL org.opencontainers.image.authors="yoseph.huang@gmail.com"
LABEL org.opencontainers.image.licenses="MIT"

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]


################################################################################################
# - User stage
#   - Add a non-root user with sudo privileges.
################################################################################################

FROM base AS user

ARG USERNAME=hrc
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    apt-get update && \
    apt-get install -y sudo && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    rm -rf /var/lib/apt/lists/*


################################################################################################
# - Tool stage
#   - Install required tools and clean up.
################################################################################################

FROM user AS tool

# ref: https://docs.trossenrobotics.com/interbotix_xsarms_docs/ros_interface/ros2/software_setup.html#amd64-architecture
# original script: https://raw.githubusercontent.com/Interbotix/interbotix_ros_manipulators/main/interbotix_ros_xsarms/install/amd64/xsarm_amd64_install.sh
COPY ./xsarm_amd64_install.sh /root/xsarm_amd64_install.sh

RUN chmod +x /root/xsarm_amd64_install.sh && \
    /root/xsarm_amd64_install.sh -d humble && \
    rm /root/xsarm_amd64_install.sh && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*


################################################################################################
# - Release stage
#   - Set working directory and switch to non-root user.
################################################################################################

FROM tool AS release

USER $USERNAME
WORKDIR /interbotix_ros_xsarms

CMD ["bash"]
