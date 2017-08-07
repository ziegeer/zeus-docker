FROM centos
MAINTAINER sidler-mozilla <sidler@mozilla.com>

ARG zeus_ver

EXPOSE 9070 9080 9090 9090/udp 80 443

ENV zeus_dir="ZeusTM_${zeus_ver}_Linux-x86_64"
ENV zeus_tar="${zeus_dir}.tgz"

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

RUN mkdir -p /usr/local/zeus
ADD $zeus_tar /usr/local/zeus

ADD zinstall.txt zconfig.txt entrypoint /usr/local/zeus/
RUN chmod +x /usr/local/zeus/entrypoint

RUN cd /usr/local/zeus/$zeus_dir && ./zinstall --replay-from=../zinstall.txt

CMD /usr/local/zeus/entrypoint
