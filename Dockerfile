# Riak CS Source
#
# VERSION       0.1.0

FROM phusion/baseimage:0.9.15
# Original MAINTAINER Hector Castro hectcastro@gmail.com
MAINTAINER Jason Stillwell dragonfax@gmail.com

# Environmental variables
ENV DEBIAN_FRONTEND noninteractive
ENV RIAK_VERSION 2.0.5
ENV RIAK_SHORT_VERSION 2.0
ENV RIAK_CS_VERSION 2.0.1
ENV RIAK_CS_SHORT_VERSION 2.0
ENV STANCHION_VERSION 2.0.0
ENV STANCHION_SHORT_VERSION 2.0

# Install dependencies
RUN apt-get update -qq && apt-get install unzip -y

# Install Riak
RUN curl --output /riak_${RIAK_VERSION}-1_amd64.deb http://s3.amazonaws.com/downloads.basho.com/riak/${RIAK_SHORT_VERSION}/${RIAK_VERSION}/ubuntu/precise/riak_${RIAK_VERSION}-1_amd64.deb
RUN (cd / && dpkg -i "riak_${RIAK_VERSION}-1_amd64.deb")

# Install Riak CS
RUN curl --output /riak-cs_${RIAK_CS_VERSION}-1_amd64.deb http://s3.amazonaws.com/downloads.basho.com/riak-cs/${RIAK_CS_SHORT_VERSION}/${RIAK_CS_VERSION}/ubuntu/trusty/riak-cs_${RIAK_CS_VERSION}-1_amd64.deb
RUN (cd / && dpkg -i "riak-cs_${RIAK_CS_VERSION}-1_amd64.deb")

# Install Stanchion
RUN curl --output /stanchion_${STANCHION_VERSION}-1_amd64.deb http://s3.amazonaws.com/downloads.basho.com/stanchion/${STANCHION_SHORT_VERSION}/${STANCHION_VERSION}/ubuntu/trusty/stanchion_${STANCHION_VERSION}-1_amd64.deb
RUN (cd / && dpkg -i "stanchion_${STANCHION_VERSION}-1_amd64.deb")

ADD bin/startup.sh /bin/startup.sh

# Tune Riak and Riak CS configuration settings for the container
ADD etc/riak.conf /etc/riak/riak.conf
ADD etc/riak-advanced.config /etc/riak/advanced.config

# Install dependencies
RUN apt-get update -qq && apt-get install -y unzip build-essential libc6-dev-i386 git

RUN git clone https://github.com/basho/riak_cs.git /app

# Open the HTTP port for Riak and Riak CS (S3)
EXPOSE 8098 8080 22

# Leverage the baseimage-docker init system
CMD bash
