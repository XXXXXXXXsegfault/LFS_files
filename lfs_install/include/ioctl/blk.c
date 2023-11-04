#ifndef _IOCTL__BLK_C_
#define _IOCTL__BLK_C_
struct hd_geometry
{
	unsigned char heads;
	unsigned char sectors;
	unsigned short cylinders;
	unsigned int pad;
	unsigned long start;
};
#define HDIO_GETGEO 0x0301
#endif
