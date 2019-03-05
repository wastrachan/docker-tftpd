#!/usr/bin/env sh
set -e

PUID="${PUID:-100}"
PGID="${PGID:-101}"

echo ""
echo "----------------------------------------"
echo " Starting tftpd, using the following:   "
echo "                                        "
echo "     UID: $PUID                         "
echo "     GID: $PGID                         "
echo "----------------------------------------"
echo ""

# Set UID/GID of tftpd user
sed -i "s/^tftpd\:x\:100\:101/tftpd\:x\:$PUID\:$PGID/" /etc/passwd
sed -i "s/^tftpd\:x\:101/tftpd\:x\:$PGID/" /etc/group

# Set permissions
chown -R $PUID:$PGID /data

exec "$@"
