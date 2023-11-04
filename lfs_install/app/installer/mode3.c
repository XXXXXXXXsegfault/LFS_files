void do_install(void);
void mode3_key_handler(int code)
{
	if(code==103)
	{
		selected=0;
	}
	else if(code==108)
	{
		selected=1;
	}
	else if(code==28)
	{
		if(selected==1)
		{
#ifndef DEBUG
			do_install();
#endif
		}
		else if(selected==0)
		{
			mode0_init();
		}
	}
}
void mode3_pscreen(void)
{
	write(1,"\033[?25l",6);
	write(1,"\033[1;1H",6);
	if(selected==0)
	{
		write(1,"\033[30m\033[47m",10);
	}
	write(1,"Exit",4);
	write(1,"\033[0m    \033[31m",13);
	write(1,"WARNING\033[0m\n",12);
	write(1,"    About to write change to your disk\n",39);
	write(1,"    All data on partitions to delete\n",37);
	write(1,"    will be lost!\n",18);
	write(1,"\n        ",9);
	if(selected==1)
	{
		write(1,"\033[30m\033[47m",10);
	}
	write(1,"Continue",8);
	write(1,"\033[0m",4);
	if(selected==0)
	{
		cursor_move(1,1);
	}
	else if(selected==1)
	{
		cursor_move(9,6);
	}
	write(1,"\033[?25h",6);
}
void mode3_init(void)
{
	selected=0;
	mode=3;
	write(1,"\033[?25l\033[2J",10);
}
