if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/kmod-29.tar.xz
cd kmod-29
./configure --prefix=/usr          \
     --sysconfdir=/etc      \
     --with-openssl         \
     --with-xz              \
     --with-zstd            \
     --with-zlib
make -j$CPUS
make install
for target in depmod insmod modinfo modprobe rmmod; do
ln -sfv ../bin/kmod /usr/sbin/$target
done
ln -sfv kmod /usr/bin/lsmod
cd ..
rm -rf kmod-29
