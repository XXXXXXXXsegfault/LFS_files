if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/sysvinit-3.01.tar.xz
cd sysvinit-3.01
patch -Np1 -i ../11.1/sysvinit-3.01-consolidated-1.patch
make -j$CPUS
make install
cd ..
rm -rf sysvinit-3.01
