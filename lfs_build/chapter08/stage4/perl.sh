if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/perl-5.34.0.tar.xz
cd perl-5.34.0
patch -Np1 -i ../11.1/perl-5.34.0-upstream_fixes-1.patch
export BUILD_ZLIB=False
export BUILD_BZIP2=0
sh Configure -des                                         \
      -Dprefix=/usr                                \
      -Dvendorprefix=/usr                          \
      -Dprivlib=/usr/lib/perl5/5.34/core_perl      \
      -Darchlib=/usr/lib/perl5/5.34/core_perl      \
      -Dsitelib=/usr/lib/perl5/5.34/site_perl      \
      -Dsitearch=/usr/lib/perl5/5.34/site_perl     \
      -Dvendorlib=/usr/lib/perl5/5.34/vendor_perl  \
      -Dvendorarch=/usr/lib/perl5/5.34/vendor_perl \
      -Dman1dir=/usr/share/man/man1                \
      -Dman3dir=/usr/share/man/man3                \
      -Dpager="/usr/bin/less -isR"                 \
      -Duseshrplib                                 \
      -Dusethreads
make -j$CPUS
make install
unset BUILD_ZLIB BUILD_BZIP2
cd ..
rm -rf perl-5.34.0
