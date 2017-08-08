FROM centos
LABEL maintainer=sidler-mozilla \
      email=sidler@mozilla.com

ARG ZEUS_TAR

EXPOSE 9070 9080 9090 9090/udp 80 443

ENV ZEUS_DIR=/usr/local/zeus
ENV ZEUS_SRC=$ZEUS_DIR/src
ENV ZEUS_HOSTNAME=zeus
ENV ZEUS_ADMIN_PASS=zeus
ENV ZEUS_UNIX_USER=zeus
ENV ZEUS_UNIX_GROUP=zeus

RUN yum -y update && yum clean all
RUN yum -y install \
    java-1.8.0-openjdk \
    net-tools \
    iproute \
    which \
    perl \
    && yum clean all

COPY $ZEUS_TAR zinstall.txt zconfig.txt entrypoint $ZEUS_DIR/
RUN chmod +x $ZEUS_DIR/entrypoint
RUN mkdir -p $ZEUS_SRC \
    && tar -xf $ZEUS_DIR/$ZEUS_TAR -C $ZEUS_SRC --strip-components=1 \
    && rm -rf $ZEUS_DIR/$ZEUS_TAR

RUN cd $ZEUS_SRC && ./zinstall --replay-from=../zinstall.txt

CMD $ZEUS_DIR/entrypoint
