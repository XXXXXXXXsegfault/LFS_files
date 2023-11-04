if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/readline-8.1.2.tar.gz
cd readline-8.1.2
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
./configure --prefix=/usr    \
     --disable-static \
     --with-curses    \
     --docdir=/usr/share/doc/readline-8.1.2
make SHLIB_LIBS="-lncursesw" -j$CPUS
make SHLIB_LIBS="-lncursesw" install
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.1.2
cd ..
rm -rf readline-8.1.2
