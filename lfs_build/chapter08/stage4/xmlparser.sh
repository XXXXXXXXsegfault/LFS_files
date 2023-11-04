if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/XML-Parser-2.46.tar.gz
cd XML-Parser-2.46
perl Makefile.PL
make -j$CPUS
make install
cd ..
rm -rf XML-Parser-2.46
