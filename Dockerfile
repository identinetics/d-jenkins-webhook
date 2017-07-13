FROM centos:centos7
MAINTAINER Rainer Hörbe <r2h2@hoerbe.at>

# Generic Python3.4 image

RUN yum -y update \
 && yum -y install bind-utils curl iproute lsof net-tools telnet unzip wget which \
# Install Python3 interpreter
# while the SCL version of python 3.4 has the advantage of redhat's blessing, it is more
# difficult to handle because it requires `scl enable`. For remote debugging with pycharm
# the EPEL or IUS versions are preferred. EPEL does not have tkinter.
# SCL version
 && yum -y install centos-release-scl \
 && yum -y install rh-python34 rh-python34-python-pip \
 && yum clean all \
 && source /opt/rh/rh-python34/enable \
 && echo "source /opt/rh/rh-python34/enable" > /etc/profile.d/setpython \
 && echo "export PYTHON=python" >> /etc/profile.d/setpython
ENV PYTHON3='scl enable rh-python34 -- python'

ENV USERNAME=gh2jenkins
ARG CONTAINERUID=343042
ARG CONTAINERGID=$CONTAINERUID
RUN groupadd --non-unique -g $CONTAINERGID $USERNAME \
 && useradd  --non-unique --gid $CONTAINERGID --uid $CONTAINERUID $USERNAME

COPY install/scripts/* /scripts/
COPY install/tests/* /tests/
COPY install/opt/jenkins-webhook/src/* /scripts/
COPY install/opt/jenkins-webhook/tests/* /tests/
RUN $PYTHON3 -m pip install werkzeug \
 && chmod +x /scripts/*

VOLUME /data
USER $USERNAME
