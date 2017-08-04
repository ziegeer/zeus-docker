FROM centos
MAINTAINER sidler-mozilla <sidler@mozilla.com>

ARG zeus_ver

EXPOSE 9070 9090

ENV zeus_dir="ZeusTM_${zeus_ver}_Linux-x86_64"
ENV zeus_tar="${zeus_dir}.tgz"
RUN echo "building with tarfile ${zeus_tar}"

RUN yum -y install epel-release && yum -y update && yum clean all
RUN yum -y install \
    java-1.8.0-openjdk \
    net-tools \
    iproute \
    which \
    perl \
    wget \
    vim \
    && yum clean all

ADD $zeus_tar /tmp
ADD saved.answers tmp/$zeus_dir

RUN cd /tmp/$zeus_dir && ./zinstall --replay-from=saved.answers

CMD /usr/local/zeus/start-zeus
ENTRYPOINT /bin/bash
