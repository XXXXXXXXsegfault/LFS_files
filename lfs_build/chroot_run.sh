#!/bin/bash -v
if [ ! $1 ]
then
	exit 1
fi
if [ ! $LFS ]
then
	exit 1
fi
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
if [ -h $LFS/dev/shm ]; then
mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
cp $1 $LFS/sources/run.sh
RET=0
if ! /sbin/chroot "$LFS" /usr/bin/env -i   \
HOME=/root                  \
TERM="$TERM"                \
PS1='(lfs chroot) \u:\w\$ ' \
PATH=/usr/bin:/usr/sbin     \
LFS_CHROOT=LFS_CHROOT \
CPUS=$($LFS/../cpu_cores.sh) \
/bin/bash --login -ev /sources/run.sh 
then
	RET=1
fi
umount $LFS/run
umount $LFS/sys
umount $LFS/proc
umount $LFS/dev/pts
umount $LFS/dev
exit $RET
