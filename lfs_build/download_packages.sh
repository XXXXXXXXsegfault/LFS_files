#!/bin/bash
if [ ! $LFS ]
then
	exit 1
fi
LFS_URL=$(./best_mirror.sh LFS)
BLFS_URL=$(./best_mirror.sh BLFS)/11.1
KERNEL_URL=$(./best_mirror.sh KERNEL)
wget -T 8 $LFS_URL/lfs-packages/lfs-packages-11.1.tar -O $LFS/sources/lfs.tar
wget -T 8 $BLFS_URL/l/libtasn1-4.18.0.tar.gz -O $LFS/sources/libtasn1-4.18.0.tar.gz
wget -T 8 $BLFS_URL/p/p11-kit-0.24.1.tar.xz -O $LFS/sources/p11-kit-0.24.1.tar.xz
wget -T 8 $BLFS_URL/m/make-ca-1.10.tar.xz -O $LFS/sources/make-ca-1.10.tar.xz
wget -T 8 $BLFS_URL/w/wget-1.21.2.tar.gz -O $LFS/sources/wget-1.21.2.tar.gz
wget -T 8 $BLFS_URL/d/dhcp-4.4.2-P1.tar.gz -O $LFS/sources/dhcp-4.4.2-P1.tar.gz
wget -T 8 $BLFS_URL/c/cpio-2.13.tar.bz2 -O $LFS/sources/cpio-2.13.tar.bz2
wget -T 8 $BLFS_URL/d/dosfstools-4.2.tar.gz -O $LFS/sources/dosfstools-4.2.tar.gz
wget -T 8 $BLFS_URL/l/links-2.25.tar.bz2 -O $LFS/sources/links-2.25.tar.bz2
wget -T 8 https://linuxfromscratch.org/blfs/downloads/11.1/blfs-book-11.1-html.tar.xz -O $LFS/sources/blfs-book-11.1-html.tar.xz
wget -T 8 $KERNEL_URL/firmware/linux-firmware-20220209.tar.xz -O $LFS/sources/linux-firmware-20220209.tar.xz
sha256sum -c SHA256SUM
