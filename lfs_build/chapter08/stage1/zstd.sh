if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/zstd-1.5.2.tar.gz
cd zstd-1.5.2
make -j$CPUS
make prefix=/usr install
rm -v /usr/lib/libzstd.a
cd ..
rm -rf zstd-1.5.2
