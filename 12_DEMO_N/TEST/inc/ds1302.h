/*
 * =====================================================================================
 *
 *       Filename:  ds1302.h
 *
 *    Description:  
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

#ifndef DS1302_H_
#define DS1302_H_

/*-----------------------------------------------------------------------------
 * Include 
 *-----------------------------------------------------------------------------*/
#include "../inc/sopc.h"

/*-----------------------------------------------------------------------------
 * Define 
 *-----------------------------------------------------------------------------*/
#define RTC_DATA_OUT     RTC_DATA->DIRECTION = 1
#define RTC_DATA_IN      RTC_DATA->DIRECTION = 0

/*-----------------------------------------------------------------------------
 * Struct 
 *-----------------------------------------------------------------------------*/
typedef struct{
        void (* set_time)(unsigned char *ti);
        void (* get_time)(char * ti);
}DS1302;

/*-----------------------------------------------------------------------------
 * Extern Variable 
 *-----------------------------------------------------------------------------*/
extern DS1302 ds1302;

#endif /*DS1302_H_*/
