if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../blfs/dhcp.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../blfs/libtasn1.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../blfs/p11_kit.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../blfs/make_ca.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../blfs/wget.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../blfs/cpio.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../blfs/dosfstools.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../blfs/links.sh
