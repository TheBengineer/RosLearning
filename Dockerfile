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
        byobu 

# Install apt sources needed for ROS 
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# install ros 
RUN set -o nounset -o errexit \
    && apt-get update -qq \
    && apt-get install -q -y --no-install-suggests \
        ros-noetic-ros-base 


RUN echo "source /opt/ros/noetic/setup.sh" >> .bashrc

# setup catkin workspace:
RUN mkdir -p ~/catkin_ws/src
RUN cd ~/catkin_ws/ && catkin_make