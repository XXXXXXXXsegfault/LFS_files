#!/bin/sh
cp linux.config linux/arch/x86/configs/a_defconfig
cd linux
make distclean
make a_defconfig
rm arch/x86/configs/a_defconfig
make -j4
cd ..
cp linux/arch/x86/boot/bzImage vmlinuz
