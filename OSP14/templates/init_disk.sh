#!/usr/bin/env bash
echo "Creating four 20G block devices named /dev/loop3, /dev/loop4, etc."
sudo yum localinstall -y http://download.lab.bos.redhat.com/rcm-guest/puddles/OpenStack/rhos-release/rhos-release-latest.noarch.rpm
rhos-release 14
command -v losetup >/dev/null 2>&1 || { yum -y install util-linux; }
command -v sgdisk >/dev/null 2>&1 || { yum -y install gdisk; }

for i in $(seq 3 5); do
    BLOB=ceph-osd-$i.img
    DEV=loop$i
    echo "Creating /dev/$DEV on /var/lib/$BLOB"
    if [[ ! -e /dev/${DEV} ]]; then
        dd if=/dev/zero of=/var/lib/${BLOB} bs=1 count=0 seek=20G
        losetup /dev/${DEV} /var/lib/${BLOB}
        #sgdisk -Z /dev/${DEV}
        sgdisk -g /dev/${DEV}
    else
        echo "ERROR: /dev/${DEV} already exists, not using it with losetup"
        exit 1
    fi
done
partprobe
echo "Output of lsblk"
lsblk

