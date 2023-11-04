if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/ncurses-6.3.tar.gz
cd ncurses-6.3
./configure --prefix=/usr           \
     --mandir=/usr/share/man \
     --with-shared           \
     --without-debug         \
     --without-normal        \
     --enable-pc-files       \
     --enable-widec          \
     --with-pkg-config-libdir=/usr/lib/pkgconfig
make -j$CPUS
make DESTDIR=$PWD/dest install
install -vm755 dest/usr/lib/libncursesw.so.6.3 /usr/lib
rm -v  dest/usr/lib/{libncursesw.so.6.3,libncurses++w.a}
cp -av dest/* /
for lib in ncurses form panel menu ; do
rm -vf                    /usr/lib/lib${lib}.so
echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done
rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so
mkdir -pv      /usr/share/doc/ncurses-6.3
cp -v -R doc/* /usr/share/doc/ncurses-6.3
cd ..
rm -rf ncurses-6.3
