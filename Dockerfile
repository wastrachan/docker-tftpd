FROM alpine:latest

LABEL org.opencontainers.image.title="tftpd"
LABEL org.opencontainers.image.description="tftpd on alpine linux"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Winston Astrachan"

RUN apk --no-cache add tftp-hpa
RUN <<EOF
    set -eux
    mkdir /data
    addgroup -S -g 101 tftpd
    adduser -s /bin/false -S -D -H -h /data -G tftpd -u 100 tftpd
EOF

COPY overlay/ /
VOLUME /data
EXPOSE 69/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/in.tftpd", "-L", "-v", "-s", "-u", "tftpd", "/data"]
