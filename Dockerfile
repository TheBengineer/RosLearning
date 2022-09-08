FROM ubuntu:20.04

WORKDIR /root/

# Install packages
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
RUN set -o nounset -o errexit \
    && apt-get update -qq \
    && apt-get install -q -y --no-install-suggests \
        curl \
        sudo \
        git \
        nano \
        gnupg \
        byobu \
        build-essential

# Install apt sources needed for ROS 
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# install ros 
RUN set -o nounset -o errexit \
    && apt-get update -qq \
    && apt-get install -q -y --no-install-suggests \
        git \
        nano \
        ros-noetic-ros-base 


RUN echo "source /opt/ros/noetic/setup.sh" >> .bashrc

# setup catkin workspace:
RUN /bin/bash -c "source /opt/ros/noetic/setup.sh \
    && mkdir -p ~/ros-build/src \
    && cd ~/ros-build/ \   
    && catkin_make "