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

# install Letsencrypt intermediate cert (in case it is not served by the httpd)
COPY install/etc/pki/letsencryptx3.pem /etc/pki/ca-trust/source/anchors/letsencryptx3.pem
RUN update-ca-trust

RUN $PYTHON3 -m pip install requests werkzeug
COPY install/scripts/* /scripts/
COPY install/tests/* /tests/
COPY install/opt/jenkins_webhook/src/* /scripts/
COPY install/opt/jenkins_webhook/tests/* /tests/
RUN chmod +x /scripts/* \
 && mkdir /data \
 && chown $CONTAINERUID:$CONTAINERGID /data

VOLUME /data
USER $USERNAME
