#!/usr/bin/env bash
echo "Creating four 20G block devices named /dev/loop3, /dev/loop4, etc."
sudo yum localinstall -y http://download.lab.bos.redhat.com/rcm-guest/puddles/OpenStack/rhos-release/rhos-release-latest.noarch.rpm
rhos-release 13
command -v losetup >/dev/null 2>&1 || { yum -y install util-linux; }

for i in $(seq 3 6); do
    BLOB=ceph-osd-$i.img
    DEV=loop$i
    echo "Creating /dev/$DEV on /var/lib/$BLOB"
    if [[ ! -e /dev/${DEV} ]]; then
        dd if=/dev/zero of=/var/lib/${BLOB} bs=1 count=0 seek=20G
        losetup /dev/${DEV} /var/lib/${BLOB}
        pvcreate /dev/${DEV}
        vgcreate  ceph_vg_${i} /dev/${DEV}
        lvcreate -n  ceph_lv_wal_${i}  -L 1G  ceph_vg_${i}
        lvcreate -n  ceph_lv_db_${i}  -L 2G  ceph_vg_${i}
        lvcreate -n  ceph_lv_data_${i}  -L 16G  ceph_vg_${i}
    else
        echo "ERROR: /dev/${DEV} already exists, not using it with losetup"
        exit 1
    fi
done
partprobe
echo "Output of lsblk"
lsblk
