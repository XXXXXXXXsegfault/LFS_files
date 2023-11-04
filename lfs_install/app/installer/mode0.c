void mode1_init(void);
void mode3_init(void);
void mode0_key_handler(int code)
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
			if(config_state==1)
			{
				mode3_init();
			}
		}
		else if(selected==0)
		{
			mode1_init();
		}
	}
}
void mode0_pscreen(void)
{
	write(1,"\033[?25l",6);
	write(1,"\033[1;1H",6);
	if((config_state&1)==0)
	{
		write(1,"[\033[31m!\033[0m] ",13);
	}
	else
	{
		write(1,"[\033[32m*\033[0m] ",13);
	}
	if(selected==0)
	{
		write(1,"\033[30m\033[47m",10);
	}
	write(1,"Installation Position",21);
	write(1,"\033[0m\n",5);
	if(config_state==1)
	{
		write(1,"[ ] ",4);
	}
	else
	{
		write(1,"    ",4);
	}
	if(selected==1)
	{
		write(1,"\033[30m\033[47m",10);
	}
	write(1,"Start Installing",16);
	write(1,"\033[0m\n",5);
	if(selected==0)
	{
		write(1,"\033[1;2H",6);
	}
	else if(selected==1)
	{
		write(1,"\033[2;2H",6);
	}
	write(1,"\033[?25h",6);
}
void mode0_init(void)
{
	selected=0;
	mode=0;
	write(1,"\033[?25l\033[2J",10);
}
