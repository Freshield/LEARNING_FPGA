/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <unistd.h>
#include "../inc/ds1302.h"
#include "../inc/iic.h"
#include "../inc/uart.h"    
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"
#include "alt_types.h"
#include "sys/alt_irq.h"


#define BUZZER *(volatile long int *)BUZZER_BASE

unsigned char time[7] = {0x00,0x19,0x14,0x17,0x03,0x17,0x10};//格式为: 秒 分 时 日 月 星期 年

alt_u8 segtab[10]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90};  //0~9
unsigned char led_buffer[8]={0};
unsigned char bittab[6]={0xfe,0xfd,0xfb,0xf7,0xef,0xdf};
static unsigned char cnt=0; 

unsigned char ti[][7]={"一","二","三","四","五","六","日"}; 
 
static void timer_init(void);  

int main()
{
     printf("-1\n");   
    int i;
    unsigned char buffer[100] = "Hello FPGA!\n";
    unsigned char buf[20]="\0";
    int j=0;
    unsigned char write_buffer[512], read_buffer[512];
    
 printf("0\n");     
    BUZZER = 1;
 printf("1\n");   
    uart.init();
     printf("2\n");   
    ds1302.set_time(time);  
     printf("3\n");     
    timer_init();
/*
    unsigned char dat,err;
    printf("\nWriting data to EEPROM!\n");
    //写入512btye的数据，前256个数字为0到255，后256个数据为1
    for(i=0; i<512; i++){
        if(i<256)
            dat = i;
        else
            dat = 1;

        iic.write_byte(i, dat);
        write_buffer[i] = dat;

        usleep(10000);
    }

    printf("\nReading data from EEPROM!\n");

    //将512byte数据读出来并打印

    for(i=0; i<512; i++){
        read_buffer[i] = iic.read_byte(i);

        usleep(1000);
    }

    uart.send_string(sizeof(read_buffer),read_buffer);

    err = 0;

    printf("\nVerifing data!\n");

    //对比数据是否相同，如果有不同，说明读写过程有错误

    for(i=0; i<512; i++){
        if(read_buffer[i] != write_buffer[i])
        err ++;
    }
    
    printf("err = %d\n",err);

    if(err == 0)
        printf("\nData write and read successfully!\n");
    else
        printf("\nData write and read failed!--%d errors\n", err);
*/
    /*----------------------------The End of IIC-----------------------*/


    while(1){ 
        
        for(i=0;i<6;i++){
            LED->DATA = 1<<i;
            usleep(100000);
        }     
        
        ds1302.get_time(time);          //采集时       
         
        sprintf(buffer,"20%d-%d-%d %d:%d:%d\n",time[6],time[4],time[3],time[2],time[1],time[0]);        

        uart.send_string(sizeof(buffer),buffer);     
        sprintf(buf,"%02u%02u%02u",time[2],time[1],time[0]); 
        
        sprintf(buf,"%06u",j++);
        
        for(i=0;i<6;i++){
            led_buffer[i] = buf[i]-'0';
        }       
    }
    
    return 0;
}
/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  timer_handler
 *  Description:  
 * =====================================================================================
 */
static void timer_handler(void *context, alt_u32 id)
{
    IOWR_ALTERA_AVALON_PIO_DATA(SEL_BASE, 0xff);
    IOWR_ALTERA_AVALON_PIO_DATA(SEL_BASE, bittab[cnt]);

    IOWR_ALTERA_AVALON_PIO_DATA(DIG_BASE, segtab[led_buffer[cnt]]); 

    cnt++;
    if(cnt==6)
        cnt=0;   
    
    IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_BASE, 0);
}

/* 
 * ===  FUNCTION  ======================================================================
 *         Name:  timer_init
 *  Description:  
 * =====================================================================================
 */
static void timer_init(void)   
{
    IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_BASE, 0);

    IOWR_ALTERA_AVALON_TIMER_PERIODL(TIMER_BASE,200000);
    IOWR_ALTERA_AVALON_TIMER_PERIODH(TIMER_BASE,200000 >> 16);
    IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_BASE, 0x07);

    alt_irq_register(TIMER_IRQ, NULL, timer_handler); 
}
