if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf cpio-2.13.tar.bz2
cd cpio-2.13
sed -i '/The name/,+2 d' src/global.c
./configure --prefix=/usr \
     --enable-mt   \
     --with-rmt=/usr/libexec/rmt &&
make -j$CPUS &&
makeinfo --html            -o doc/html      doc/cpio.texi &&
makeinfo --html --no-split -o doc/cpio.html doc/cpio.texi &&
makeinfo --plaintext       -o doc/cpio.txt  doc/cpio.texi
make install &&
install -v -m755 -d /usr/share/doc/cpio-2.13/html &&
install -v -m644    doc/html/* \
	     /usr/share/doc/cpio-2.13/html &&
install -v -m644    doc/cpio.{html,txt} \
	     /usr/share/doc/cpio-2.13
cd ..
rm -rf cpio-2.13
