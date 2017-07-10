FROM centos:centos7
MAINTAINER Rainer Hörbe <r2h2@hoerbe.at>

# Generic Python3.4 image

RUN yum -y update \
 && yum -y install epel-release \
 && yum -y install git python34-devel \
 && curl https://bootstrap.pypa.io/get-pip.py | python3.4

ENV USERNAME=gh2jenkins
ENV CONTAINERUID=343042
ENV CONTAINERGID=343042
RUN groupadd --non-unique -g $CONTAINERGID $USERNAME \
 && useradd  --non-unique --gid $CONTAINERGID --uid $CONTAINERUID $USERNAME

RUN cd /opt \
 && git clone https://github.com/identinetics/jenkins-webhook

USER $USERNAME