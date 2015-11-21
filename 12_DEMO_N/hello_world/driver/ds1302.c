/*
 * =====================================================================================
 *
 *       Filename:  ds1302.c
 *
 *    Description:  DS1302驱动
 *
 *        Version:  1.0.0
 *        Created:  2010.4.16
 *       Revision:  none
 *       Compiler:  Nios II 9.0 IDE
 *
 *         Author:  马瑞 (AVIC)
 *			Email:  avic633@gmail.com  
 *
 * =====================================================================================
 */

/*-----------------------------------------------------------------------------
 * Include 
 *-----------------------------------------------------------------------------*/
#include "../inc/ds1302.h"
#include "../inc/sopc.h"

/*-----------------------------------------------------------------------------
 * Function Prototype 
 *-----------------------------------------------------------------------------*/
static void delay(unsigned int dly);
static void write_1byte_to_ds1302(unsigned char da);
static unsigned char read_1byte_from_ds1302(void);
static void write_data_to_ds1302(unsigned char addr, unsigned char da);
static unsigned char read_data_from_ds1302(unsigned char addr); 
static void set_time(unsigned char *ti);
static void get_time(char *ti);

/*-----------------------------------------------------------------------------
 * Struct Initialize 
 *-----------------------------------------------------------------------------*/
DS1302 ds1302 = {
	.set_time = set_time,
	.get_time = get_time
};

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  delay
 *  Description:  延时 
 * =====================================================================================
 */ 
void delay(unsigned int dly) 
{   
	for(;dly>0;dly--); 
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  write_1byte_to_ds1302
 *  Description:  向ds1302写入1 byte数据 
 * =====================================================================================
 */ 
void write_1byte_to_ds1302(unsigned char da) 
{ 
	unsigned int i;

	RTC_DATA_OUT;

	for(i=8; i>0; i--){ 
		if((da&0x01)!= 0) 
			RTC_DATA->DATA = 1; 
		else 
			RTC_DATA->DATA = 0; 

		delay(10); 
		RTC_SCLK->DATA = 1; 
		delay(20); 
		RTC_SCLK->DATA = 0;
		delay(10);

		da >>= 1; //相当于汇编中的 RRC 
	} 
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  read_1byte_from_ds1302
 *  Description:  从ds1302读取1 byte数据
 * =====================================================================================
 */ 
unsigned char read_1byte_from_ds1302(void) 
{ 
	unsigned char i; 
	unsigned char da = 0; 

	RTC_DATA_IN;

	for(i=8; i>0; i--){ 
		delay(10); 
		da >>= 1; //相当于汇编中的 RRC 
		if(RTC_DATA->DATA !=0 )
			da += 0x80;

		RTC_SCLK->DATA = 1; 
		delay(20); 
		RTC_SCLK->DATA = 0; 
		delay(10); 
	}

	RTC_DATA_OUT;

	return(da); 
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  write_data_to_ds1302
 *  Description:  向ds1302写入数据 
 * =====================================================================================
 */ 
void write_data_to_ds1302(unsigned char addr, unsigned char da) 
{ 
	RTC_DATA_OUT;
	RTC_RST->DATA = 0;//复位，低电平有效
	RTC_SCLK->DATA = 0;
	
	delay(40); 

	RTC_RST->DATA = 1;

	write_1byte_to_ds1302(addr); // 地址，命令 
	write_1byte_to_ds1302(da); // 写1Byte数据

	RTC_SCLK->DATA = 1;
	RTC_RST->DATA = 0;

	delay(40); 
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  read_data_from_ds1302
 *  Description:  从ds1302读取数据 
 * =====================================================================================
 */
unsigned char read_data_from_ds1302(unsigned char addr) 
{ 
	unsigned char da;

	RTC_RST->DATA = 0;
	RTC_SCLK->DATA = 0;

	delay(40);

	RTC_RST->DATA = 1;

	write_1byte_to_ds1302(addr);
	da = read_1byte_from_ds1302();

	RTC_SCLK->DATA = 1;
	RTC_RST->DATA = 0;

	delay(40);

	return(da); 
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  set_time
 *  Description:  设置时间  
 * =====================================================================================
 */
void set_time(unsigned char *ti) 
{ 
	unsigned char i; 
	unsigned char addr = 0x80; 

	write_data_to_ds1302(0x8e,0x00); // 控制命令,WP=0,写操作

	for(i =7;i>0;i--){ 
		write_data_to_ds1302(addr,*ti); // 秒 分 时 日 月 星期 年

		ti++; 
		addr += 2; 
	} 

	write_data_to_ds1302(0x8e,0x80); // 控制命令,WP=1,写保护
}
/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  get_time
 *  Description:  获取时间 ,读取的时间为BCD码，需要转换成十进制
 * =====================================================================================
 */
void get_time(char *ti) 
{ 
	unsigned char i; 
	unsigned char addr = 0x81; 
	char time;

	for (i=0;i<7;i++){ 
		time=read_data_from_ds1302(addr);//读取的时间为BCD码
		ti[i] = time/16*10+time%16;//格式为: 秒 分 时 日 月 星期 年
		addr += 2; 
	}
}  
