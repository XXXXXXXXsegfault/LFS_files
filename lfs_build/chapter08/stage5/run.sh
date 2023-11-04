if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/intltool.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/autoconf.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/automake.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/openssl.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/kmod.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/libelf.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/libffi.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/python.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/ninja.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage5/meson.sh
