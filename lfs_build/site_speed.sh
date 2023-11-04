#!/bin/sh
if [ ! $1 ]
then
	exit 1
fi
TIME=$(date +%s%N)
if ! wget -q -T 2 -t 1 $1 -O tmp
then
	echo 10000000000000000
	exit 0
fi
TIME2=$(date +%s%N)
echo $((($TIME2-$TIME)))
exit 0
