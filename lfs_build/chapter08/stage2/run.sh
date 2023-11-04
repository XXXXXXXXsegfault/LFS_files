if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/bc.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/flex.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/tcl.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/expect.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/dejagnu.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/binutils.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/gmp.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/mpfr.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/mpc.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage2/attr.sh
