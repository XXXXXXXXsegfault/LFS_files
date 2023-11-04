if [ ! $LFS ]
then
	exit 1
fi

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
for i in bin lib sbin; do
	ln -sv usr/$i $LFS/$i
done
mkdir -pv $LFS/lib64
