if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/shadow-4.11.1.tar.xz
cd shadow-4.11.1
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD SHA512:' \
-e 's:/var/spool/mail:/var/mail:'                 \
-e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                \
-i etc/login.defs
touch /usr/bin/passwd
./configure --sysconfdir=/etc \
     --disable-static  \
     --with-group-name-max-length=32
make -j$CPUS
make exec_prefix=/usr install
make -C man install-man
pwconv
grpconv
mkdir -p /etc/default
useradd -D --gid 999
sed -i '/MAIL/s/yes/no/' /etc/default/useradd
passwd -d root
cd ..
rm -rf shadow-4.11.1
