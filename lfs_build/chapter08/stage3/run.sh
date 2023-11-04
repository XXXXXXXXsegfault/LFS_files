if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/acl.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/libcap.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/shadow.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/gcc.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/pkgconfig.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/ncurses.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/sed.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/psmisc.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/gettext.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage3/bison.sh
