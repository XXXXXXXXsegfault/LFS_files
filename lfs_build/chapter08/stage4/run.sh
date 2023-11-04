if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/grep.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/bash.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/libtool.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/gdbm.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/gperf.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/expat.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/inetutils.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/less.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/perl.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage4/xmlparser.sh
