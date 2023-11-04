int mode2_stage;
char mode2_buf[32];
long part_start,free_space_size,part_size,part_type;
int get_part_start(int n)
{
	long pos,p_end;
	int s;
	char buf[70];
	pos=2048;
	p_end=pt_next_pos(pos,&s);
	while(n)
	{
		pos=p_end;
		if(pos==-1)
		{
			return -1;
		}
		p_end=pt_next_pos(pos,&s);
		--n;
	}
	if(p_end==-1)
	{
		p_end=(selected_dev_size>>9)-33;
	}
	if(s)
	{
		return -1;
	}
	free_space_size=p_end-pos>>11;
	part_start=pos>>11;
	return 0;
}
int create_partition(void)
{
	int x;
	x=0;
	if(part_type==2&&part_size<5120)
	{
		write(1,"\nRoot partition should be at least 5 GB",39);
		return 1;
	}
	while(x<128)
	{
		if(!memcmp(gentries[x].type,"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",16))
		{
			break;
		}
		++x;
	}
	if(x==128)
	{
		write(1,"\nToo many partitions on disk",28);
		return 1;
	}
	if(part_type==0)
	{
		memcpy(gentries[x].type,EFI_PART,16);
		memcpy(gentries[x].name,"E\0F\0I\0 \0S\0y\0s\0t\0e\0m\0 \0P\0a\0r\0t\0i\0t\0i\0o\0n\0",40);
	}
	else
	{
		memcpy(gentries[x].type,MSDATA_PART,16);
		memcpy(gentries[x].name,"D\0a\0t\0a\0",8);
	}
	getrandom(gentries[x].guid,16,1);
	gentries[x].start=part_start<<11;
	gentries[x].end=(part_start+part_size<<11)-1;
	if(part_type==0)
	{
		efi_p=x;
	}
	else if(part_type==1)
	{
		boot_p=x;
	}
	else if(part_type==2)
	{
		root_p=x;
	}
	return 0;
}
void mode2_exit(void);
void mode2_key_handler(int c)
{
	int l;
	long val;
	l=strlen(mode2_buf);
	if(c>='0'&&c<='9')
	{
		if(l!=31)
		{
			mode2_buf[l]=c;
			mode2_buf[l+1]=0;
			write(1,&c,1);
		}
	}
	if(c==127)
	{
		if(l)
		{
			mode2_buf[l-1]=0;
			write(1,"\033[D \033[D",7);
		}
	}
	if(c=='\n'&&mode2_stage==2)
	{
		mode2_exit();
	}
	if(c=='\n'&&l)
	{
		val=0;
		sinputi(mode2_buf,&val);
		if(mode2_stage==0)
		{
			if(val>=40&&val<=free_space_size)
			{
				part_size=val;
				mode2_stage=1;
				write(1,"\nPartition Type (0 - EFI, 1 - Boot, 2 - Root, 3 - Other): ",58);
				mode2_buf[0]=0;
			}
			else
			{
				write(1,"\nInvalid Size",13);
				mode2_stage=2;
				write(1,"\nPress ENTER to continue",24);
			}
		}
		else if(mode2_stage==1)
		{
			if(val>=0&&val<=3)
			{
				part_type=val;
				if(create_partition())
				{
					mode2_stage=2;
					write(1,"\nPress ENTER to continue",24);
				}
				else
				{
					mode2_exit();
				}
			}
			else
			{
				write(1,"\nInvalid Type",13);
				mode2_stage=2;
				write(1,"\nPress ENTER to continue",24);
			}
		}
	}
}
int mode2_init(void)
{
	char buf[32];
	if(get_part_start(selected-1))
	{
		return 1;
	}
	ioctl(0,KDSKBMODE,3);
	write(1,"\033[?25l\033[2J\033[1;1H\033[?25h",22);
	write(1,"Create Partition\n",17);
	write(1,"Free Space Size (MB): ",22);
	buf[0]=0;
	sprinti(buf,free_space_size,1);
	write(1,buf,strlen(buf));
	write(1,"\nPartition Size (MB): ",22);
	mode2_stage=0;
	mode2_buf[0]=0;
	mode=2;
	return 0;
}
void mode2_exit(void)
{
	ioctl(0,KDSKBMODE,2);
	mode=1;
	selected=0;
	write(1,"\033[?25l\033[2J",10);
}
