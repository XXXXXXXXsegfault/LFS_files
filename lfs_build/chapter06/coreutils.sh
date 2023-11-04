if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/coreutils-9.0.tar.xz
cd coreutils-9.0
./configure --prefix=/usr         \
--host=$LFS_TGT                   \
--build=$(build-aux/config.guess) \
--enable-install-program=hostname \
--enable-no-install-program=kill,uptime
make -j$CPUS
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8
cd ..
rm -rf coreutils-9.0
