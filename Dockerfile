FROM alpine:3.20

# Metadata
LABEL name="tftpd"
LABEL authors="iKono Telecomunicaciones"

# Install tftp-hpa and tzdata
RUN apk --no-cache add tftp-hpa tzdata

# Create tftpd user and group
RUN <<EOF
    set -eux
    mkdir /tftpboot
    addgroup -S -g 101 tftpd
    adduser -s /bin/false -S -D -H -h /tftpboot -G tftpd -u 100 tftpd
EOF

# Set working directory
WORKDIR /app

# Copy start.sh script
COPY start.sh .

# Set volume
VOLUME /tftpboot

# Expose tftp port
EXPOSE 69/udp

# Start configuration
ENTRYPOINT ["/app/start.sh"]

# Start tftpd
CMD /usr/sbin/in.tftpd -L -v -s -u tftpd /tftpboot & tail -f /var/log/messages.log