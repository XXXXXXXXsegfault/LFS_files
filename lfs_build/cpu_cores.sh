#!/bin/bash
for s in $(cat /proc/cpuinfo | grep cpu\ cores)
do
	if [ "$s" != ":" ] && [ "$s" != cpu ] && [ "$s" != cores ]
	then
		echo $s
		exit 0
	fi
done
echo 1
exit 0
