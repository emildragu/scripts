#!/bin/bash
#
# Remove old kernels on Ubuntu/Debian systems
#
#
#

EMAIL=$1

export PATH="/sbin:/usr/sbin:/bin:/usr/bin:$PATH"
KERNELS=$(/bin/ls -tr /boot/vmlinuz-* | grep -v `uname -r` | head -n -2 | cut -d- -f2- | awk '{print "linux-image-" $0 " linux-headers-" $0}')

if [ "$KERNELS" == "" ]; then
    exit 0
else
    echo "$KERNELS" | mail -s "Removing kernels from `hostname`" $EMAIL
    echo $KERNELS |  xargs apt-get -y remove --purge
    apt-get -y autoremove --purge
fi

