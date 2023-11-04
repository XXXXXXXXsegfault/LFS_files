if [ ! $LFS_CHROOT ]
then
	exit 1
fi
rm -rf /tmp/*
find /usr/lib /usr/libexec -name \*.la -delete
find /usr -depth -name x86_64-lfs-linux-gnu\* | xargs rm -rf
