if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/lfs-bootscripts-20210608.tar.xz
cd lfs-bootscripts-20210608
make install
cd ..
rm -rf lfs-bootscripts-20210608
cat >> /etc/rc.d/init.d/rc << "EOF"
if [ -r /etc/rc.local ]
then
	source /etc/rc.local
fi
EOF

sed -i 's/LOGLEVEL:-7/LOGLEVEL:-4/' /etc/rc.d/init.d/rc
