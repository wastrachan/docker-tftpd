FROM alpine:latest
LABEL maintainer="Winston Astrachan"
LABEL description="tftpd on Alpine Linux"

RUN apk --no-cache add tftp-hpa
RUN mkdir /data && \
    addgroup -S tftpd && \
    adduser -s /bin/false -S -D -H -h /data -G tftpd tftpd

COPY overlay/ /
VOLUME /data
EXPOSE 69/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/in.tftpd", "-L", "-v", "-s", "-u", "tftpd", "/data"]
