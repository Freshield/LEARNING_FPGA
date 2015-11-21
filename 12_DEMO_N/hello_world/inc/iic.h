/*
 * =====================================================================================
 *
 *       Filename:  iic.h
 *
 *    Description:  
 *
 *        Version:  1.0.0
 *        Created:  2010.4.16
 *       Revision:  none
 *       Compiler:  Nios II 9.0 IDE
 *
 *         Author:  ÂíÈð (AVIC)
 *          Email:  avic633@gmail.com  
 *
 * =====================================================================================
 */
 
#ifndef IIC_H_
#define IIC_H_

#define   OUT     1
#define   IN      0

typedef struct{
    void (* write_byte)(unsigned short addr, unsigned char dat);
    unsigned char (* read_byte)(unsigned short addr);
}IIC;

extern IIC iic;

#endif /*IIC_H_*/
