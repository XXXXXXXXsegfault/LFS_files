#!/bin/sh
if [ ! $1 ]
then
	exit 1
fi
IS_BLFS=LFS
_PATH=/lfs-packages/11.1/lfs-bootscripts-20210608.tar.xz
SITE_SPEED=X
URL=X
for U in `cat ./lfs_mirrors`
do
	if [ $U == __BLFS__ ]
	then
		IS_BLFS=BLFS
		_PATH=/conglomeration/which/which-2.21.tar.gz
	elif [ $U == __KERNEL__ ]
	then
		IS_BLFS=KERNEL
		_PATH=/tools/perf/v4.19.0/perf-4.19.0.tar.gz
	else
		if [ $1 == $IS_BLFS ]
		then
			SPEED=$(./site_speed.sh $U$_PATH)
			if [ $SITE_SPEED == X ] || [ $(($SITE_SPEED>$SPEED)) == 1 ]
			then
				SITE_SPEED=$SPEED
				URL=$U
			fi
		fi
	fi
done
rm -f tmp
echo $URL
