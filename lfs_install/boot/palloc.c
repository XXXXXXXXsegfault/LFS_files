void *palloc(unsigned long pages)
{
	void *ptr;
	ptr=(void *)0x1000000;
	do
	{
		if((long)ptr>0x100000000)
		{
			return 0;
		}
		ptr=(char *)ptr+0x1000;
		efipush(2);
		efipush(2);
		efipush(pages);
		efipush(&ptr);
		eficall(efitab->boot_services->alloc_pages);
	}
	while(efi_error);
	return ptr;
}
void prelease(void *ptr,int pages)
{
	efipush(ptr);
	efipush(pages);
	eficall(efitab->boot_services->free_pages);
}
