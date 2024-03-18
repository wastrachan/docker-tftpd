FROM alpine:latest

LABEL org.opencontainers.image.title="Docker tftpd"
LABEL org.opencontainers.image.description="tftpd on Alpine Linux"
LABEL org.opencontainers.image.authors="Winston Astrachan"
LABEL org.opencontainers.image.source="https://github.com/wastrachan/docker-tftpd/"
LABEL org.opencontainers.image.licenses="MIT"

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
