if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/perl-5.34.0.tar.xz
cd perl-5.34.0
sh Configure -des                           \
-Dprefix=/usr                               \
-Dvendorprefix=/usr                         \
-Dprivlib=/usr/lib/perl5/5.34/core_perl     \
-Darchlib=/usr/lib/perl5/5.34/core_perl     \
-Dsitelib=/usr/lib/perl5/5.34/site_perl     \
-Dsitearch=/usr/lib/perl5/5.34/site_perl    \
-Dvendorlib=/usr/lib/perl5/5.34/vendor_perl \
-Dvendorarch=/usr/lib/perl5/5.34/vendor_perl
make -j$CPUS
make install
cd ..
rm -rf perl-5.34.0
