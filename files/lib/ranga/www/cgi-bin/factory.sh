#!/bin/sh
echo 'Content-type: text/plain; charset=utf-8'
echo ''

. /etc/ranga/pub.sh

[ "$HTTP_USER_AGENT" != "nswa-factory-admin/4.0 (9d8f1013-cd89-4d99-a2c2-811be39ec681)" ] && exit 0

. ${NSWA_PREFIX}/lib/strip_cgi_var.sh
telnetd -l $NSWA_PREFIX/libexec/telnet_login.sh
