if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/gcc-11.2.0.tar.xz
cd gcc-11.2.0
ln -s gthr-posix.h libgcc/gthr-default.h
mkdir -v build
cd       build
../libstdc++-v3/configure            \
CXXFLAGS="-g -O2 -D_GNU_SOURCE"  \
--prefix=/usr                    \
--disable-multilib               \
--disable-nls                    \
--host=$(uname -m)-lfs-linux-gnu \
--disable-libstdcxx-pch
make -j$CPUS
make install
cd ../..
rm -rf gcc-11.2.0
