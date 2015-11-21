/*
 * =====================================================================================
 *
 *       Filename:  iic.c
 *
 *    Description:  
 *
 *        Version:  1.0.0
 *        Created:  2010.4.16
 *       Revision:  none
 *       Compiler:  Nios II 9.0 IDE
 *
 *         Author:  马瑞 (AVIC)
 *          Email:  avic633@gmail.com  
 *
 * =====================================================================================
 */
 
/*-----------------------------------------------------------------------------
 *  Include
 *-----------------------------------------------------------------------------*/
#include <stdio.h>
#include <sys/unistd.h>
#include <io.h>

#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include "../inc/iic.h"

/*-----------------------------------------------------------------------------
 *  Variable
 *-----------------------------------------------------------------------------*/
static alt_u8 read_byte(alt_u16 addr);
static void write_byte(alt_u16 addr, alt_u8 dat);

IIC iic ={
    .write_byte = write_byte,
    .read_byte = read_byte
};


/* 
 * ===  FUNCTION  ===================================================
 *         Name:  start
 *  Description:  IIC启动
 * =================================================================
 */
static void start(void)    
{
    IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, OUT);
    IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, 1);
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1);
    usleep(10);
    IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, 0);
    usleep(5);
}
/* 
 * ===  FUNCTION  ===================================================
 *         Name:  uart_send_byte
 *  Description:  IIC停止
 * ==================================================================
 */
static void stop(void)     
{
    IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, OUT);
    IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, 0);
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0);
    usleep(10);
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1);
    usleep(5);
    IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, 1);
    usleep(10);
}
/* 
 * ===  FUNCTION  ===================================================
 *         Name:  ack
 *  Description:  IIC应答
 * =================================================================
 */
static void ack(void)     
{
    alt_u8 tmp;
    
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0);
    IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, IN);
    usleep(10);
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1);
    usleep(5);
    tmp = IORD_ALTERA_AVALON_PIO_DATA(SDA_BASE);
    usleep(5);
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0);
    usleep(10);
    
    while(tmp);
}
/* 
 * ===  FUNCTION  ===================================================
 *         Name:  iic_write
 *  Description:  IIC写一个字节
 * =================================================================
 */
void iic_write(alt_u8 dat)    
{
    alt_u8 i, tmp;
    
    IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, OUT);
    
    for(i=0; i<8; i++){
        IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0);
        usleep(5);
        tmp = (dat & 0x80) ? 1 : 0;
        dat <<= 1;
        IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, tmp);
        usleep(5);
        IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1);
        usleep(10);
    }
}
/* 
 * ===  FUNCTION  ===================================================
 *         Name:  read
 *  Description:  IIC读一个字节
 * ==================================================================
 */
static alt_u8 iic_read(void)    
{
    alt_u8 i, dat = 0;
    
    IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, IN);
 
    for(i=0; i<8; i++){
        IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0);
        usleep(10);
        IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1);
        usleep(5);
        dat <<= 1;
        dat |= IORD_ALTERA_AVALON_PIO_DATA(SDA_BASE);
        usleep(5);
    }
  
    usleep(5);
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0);
    usleep(10);
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1);
    usleep(10);
    IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0);
    
    return dat;
}

/* 
 * ===  FUNCTION  ===================================================
 *         Name:  write_byte
 *  Description:  向EEPROM写一个字节
 * =================================================================
 */
static void write_byte(alt_u16 addr, alt_u8 dat) 
{
    alt_u8 cmd;
    cmd = (0xa0 | (addr >> 7)) & 0xfe;
    
    start();
    iic_write(cmd);
    ack();
    iic_write(addr);
    ack();
    iic_write(dat);
    ack();
    stop();   
}
/* 
 * ===  FUNCTION  ===================================================
 *         Name:  read_byte
 *  Description:  从EEPROM读一个字节
 * =================================================================
 */
static alt_u8 read_byte(alt_u16 addr) 
{
    alt_u8 cmd, dat;
    cmd = (0xa0 | (addr >> 7)) & 0xfe;
    
    start();
    iic_write(cmd);
    ack();
    iic_write(addr);
    ack();
    start();
    cmd |= 0x01;
    start();
    iic_write(cmd);
    ack();
    dat = iic_read();
    stop();   
    
    return dat;
}
