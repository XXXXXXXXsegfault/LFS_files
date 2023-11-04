if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/linux-5.16.9.tar.xz
cd linux-5.16.9
make mrproper
cp ../linux.config arch/x86/configs/LFS_defconfig
make LFS_defconfig
make -j$CPUS
make modules_install
cp arch/x86/boot/bzImage /boot/vmlinuz-5.16.9
cp System.map /boot/System.map-5.16.9
cp .config /boot/config-5.16.9
install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF
cd ..
rm -rf linux-5.16.9
