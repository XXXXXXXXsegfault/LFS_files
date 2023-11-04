#!/bin/bash -ev
if ! ./check_env.sh
then
	echo "LFS cannot be built on this system."
	exit 1
fi
gcc ./scripts/lfswd.c -o ./scripts/lfswd
LFS=$(./scripts/lfswd || exit 1)
LFS_TGT=x86_64-lfs-linux-gnu
LC_ALL=POSIX
PATH=$LFS/tools/bin:/bin:/usr/bin
CONFIG_SITE=$LFS/usr/share/config.site
CPUS=$(./cpu_cores.sh)
export NINJAJOBS=$CPUS
umask 022
mkdir $LFS
mkdir $LFS/sources
mkdir $LFS/tools
source ./download_packages.sh
if [ -f /etc/bash.bashrc ]
then
	echo "NOTE!!! /etc/bash.bashrc will be moved to /etc/bash.bashrc.NOUSE"
	echo "Please press ENTER to continue"
	read
	mv -f /etc/bash.bashrc /etc/bash.bashrc.NOUSE
fi
cd $LFS/sources
tar -xf lfs.tar
source ../../chapter04/run.sh
source ../../chapter05/run.sh
source ../../chapter06/run.sh
source ../../chapter07/run.sh
source ../../chapter08/run.sh
source ../../chapter09/run.sh
source ../../blfs/run.sh
source ../../boot/run.sh

#################################################
#                                               #
# COMPLETE!!!                                   #
# The file "lfs/lfs-system.tar" is now          #
# available.                                    #
#                                               #
#################################################
