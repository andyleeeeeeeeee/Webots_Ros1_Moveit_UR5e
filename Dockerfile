# ==================================================================
# Maintainer: Andylee, Email: 1155135230@link.cuhk.edu.hk
# ------------------------------------------------------------------


# ==================================================================
# Install ubuntu18.04, nvidia/cudagl and webots
# ------------------------------------------------------------------
ARG BASE_IMAGE=nvidia/cudagl:10.0-devel-ubuntu18.04
FROM ${BASE_IMAGE}

# Disable dpkg/gdebi interactive dialogs
ENV DEBIAN_FRONTEND=noninteractive

# Determine Webots version to be used and set default argument
ARG WEBOTS_VERSION=R2021a
ARG WEBOTS_PACKAGE_PREFIX=_ubuntu-18.04

# Install Webots runtime dependencies
RUN apt update && apt install --yes wget && rm -rf /var/lib/apt/lists/
RUN wget https://raw.githubusercontent.com/cyberbotics/webots/master/scripts/install/linux_runtime_dependencies.sh
RUN chmod +x linux_runtime_dependencies.sh && ./linux_runtime_dependencies.sh && rm ./linux_runtime_dependencies.sh && rm -rf /var/lib/apt/lists/

# Install X virtual framebuffer to be able to use Webots without GPU and GUI (e.g. CI)
RUN apt update && apt install --yes xvfb && rm -rf /var/lib/apt/lists/

# Install Webots
WORKDIR /usr/local
RUN wget https://github.com/cyberbotics/webots/releases/download/$WEBOTS_VERSION/webots-$WEBOTS_VERSION-x86-64$WEBOTS_PACKAGE_PREFIX.tar.bz2
RUN tar xjf webots-*.tar.bz2 && rm webots-*.tar.bz2
ENV QTWEBENGINE_DISABLE_SANDBOX=1
ENV WEBOTS_HOME /usr/local/webots
ENV PATH /usr/local/webots:${PATH}

# ==================================================================
# Install ros melodic with moveit
# ------------------------------------------------------------------
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && apt update && apt install ros-melodic-desktop-full -y
WORKDIR /root

RUN apt-get update && apt-get install -y \
    ros-melodic-moveit \
    ros-melodic-actionlib \
    ros-melodic-actionlib-tutorials \
    ros-melodic-control-msgs \
    ros-melodic-roscpp \    
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/catkin_ws/src && cd /root/catkin_ws

COPY src /root/catkin_ws/src

# ==================================================================
# Install the ROS packages
# ------------------------------------------------------------------
SHELL ["/bin/bash", "-c"]
RUN source /opt/ros/melodic/setup.bash \
    && cd /root/catkin_ws && catkin_make
    
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

EXPOSE 11311

WORKDIR /root
