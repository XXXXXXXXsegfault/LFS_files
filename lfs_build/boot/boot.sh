if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf linux-firmware-20220209.tar.xz
cd linux-firmware-20220209
make install
cd ..
rm -rf linux-firmware-20220209
mkdir -p /usr/src/blfs-11.1
cd /usr/src/blfs-11.1
tar -xf /sources/blfs-book-11.1-html.tar.xz
install -dv -m 0750 /root
tar -cf /lfs-system.tar /bin /boot /etc /home /lib /lib64 /media /opt /sbin /srv /usr /var /root
