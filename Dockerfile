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
RUN apt-get update -qq && apt-get -y install unzip erlang build-essential libc6-dev-i386 git autoconf libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev wget

# Install Riak
RUN curl --output /riak_${RIAK_VERSION}-1_amd64.deb http://s3.amazonaws.com/downloads.basho.com/riak/${RIAK_SHORT_VERSION}/${RIAK_VERSION}/ubuntu/precise/riak_${RIAK_VERSION}-1_amd64.deb
RUN (cd / && dpkg -i "riak_${RIAK_VERSION}-1_amd64.deb")

# Install Stanchion
RUN curl --output /stanchion_${STANCHION_VERSION}-1_amd64.deb http://s3.amazonaws.com/downloads.basho.com/stanchion/${STANCHION_SHORT_VERSION}/${STANCHION_VERSION}/ubuntu/trusty/stanchion_${STANCHION_VERSION}-1_amd64.deb
RUN (cd / && dpkg -i "stanchion_${STANCHION_VERSION}-1_amd64.deb")

ADD bin/startup.sh /bin/startup.sh

# Tune Riak and Riak CS configuration settings for the container
ADD etc/riak.conf /etc/riak/riak.conf
ADD etc/riak-advanced.config /etc/riak/advanced.config

RUN git clone https://github.com/basho/riak_cs.git /app
WORKDIR /app
RUN make -j 20 rel

# Open the HTTP port for Riak and Riak CS (S3)
EXPOSE 8098 8080 22

# Leverage the baseimage-docker init system
CMD bash
