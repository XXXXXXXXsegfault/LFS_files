#!/bin/bash
echo "Are you sure you want to clean up? (y/N)"
read S
if [ $S != y ] && [ $S != Y ]
then
	exit 1
fi
rm -rf ./lfs
rm -f scripts/lfswd tmp
