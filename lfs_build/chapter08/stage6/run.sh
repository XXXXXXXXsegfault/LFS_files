if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/coreutils.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/check.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/diffutils.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/gawk.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/findutils.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/groff.sh
# GRUB is not used in this system
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/gzip.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/iproute2.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/kbd.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage6/libpipeline.sh
