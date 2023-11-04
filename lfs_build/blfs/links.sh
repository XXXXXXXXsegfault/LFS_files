if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf links-2.25.tar.bz2
cd links-2.25
./configure --prefix=/usr --mandir=/usr/share/man &&
make -j$CPUS
make install &&
install -v -d -m755 /usr/share/doc/links-2.25 &&
install -v -m644 doc/links_cal/* KEYS BRAILLE_HOWTO \
/usr/share/doc/links-2.25
cd ..
rm -rf links-2.25
