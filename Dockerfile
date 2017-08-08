FROM centos
LABEL maintainer=sidler-mozilla \
      email=sidler@mozilla.com

ARG ZEUS_TAR

EXPOSE 9070 9080 9090 9090/udp 80 443

ENV ZEUS_HOSTNAME=zeus
ENV ZEUS_ADMIN_PASS=zeus
ENV ZEUS_UNIX_USER=zeus
ENV ZEUS_UNIX_GROUP=zeus

#RUN yum -y install epel-release && yum -y update && yum clean all
RUN yum -y update && yum clean all
RUN yum -y install \
    java-1.8.0-openjdk \
    net-tools \
    iproute \
    which \
    perl \
    #vim \
    && yum clean all

COPY $ZEUS_TAR zinstall.txt zconfig.txt entrypoint /usr/local/zeus/
RUN chmod +x /usr/local/zeus/entrypoint
RUN mkdir -p /usr/local/zeus/src \
    && tar -xf /usr/local/zeus/$ZEUS_TAR -C /usr/local/zeus/src --strip-components=1 \
    && rm -rf /usr/local/zeus/$ZEUS_TAR

RUN cd /usr/local/zeus/src && ./zinstall --replay-from=../zinstall.txt

CMD /usr/local/zeus/entrypoint
