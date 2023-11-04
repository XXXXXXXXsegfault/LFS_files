if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/libcap-2.63.tar.xz
cd libcap-2.63
sed -i '/install -m.*STA/d' libcap/Makefile
make prefix=/usr lib=lib -j$CPUS
make prefix=/usr lib=lib install
cd ..
rm -rf libcap-2.63
