/*
 * =====================================================================================
 *
 *       Filename:  sopc.h
 *
 *    Description:  
 *
 *        Version:  1.0.0
 *        Created:  2010.4.16
 *       Revision:  none
 *       Compiler:  Nios II 9.0 IDE
 *
 *         Author:  ���� (AVIC)
 *			Email:  avic633@gmail.com  
 *
 * =====================================================================================
 */

#ifndef SOPC_H_
#define SOPC_H_

/*-----------------------------------------------------------------------------
 *  Include
 *-----------------------------------------------------------------------------*/
#include "system.h"

/*-----------------------------------------------------------------------------
 *  Define
 *-----------------------------------------------------------------------------*/  
#define _UART
#define _LAN
#define _RTC
#define _LED

/*-----------------------------------------------------------------------------
 *  Peripheral registers structures  
 *-----------------------------------------------------------------------------*/

/*-------------------------------UART------------------------------------------*/
typedef struct
{
	union{
		struct{
			volatile unsigned long int RECEIVE_DATA		:8;
			//volatile unsigned long int IF_EXIST		    :2;
			volatile unsigned long int NC			        :24;           
		}BITS;
		volatile unsigned long int WORD;
	}RXDATA;

	union{
		struct{
			volatile unsigned long int TRANSMIT_DATA	    :8;
			//volatile unsigned long int if_exist		    :2;
			volatile unsigned long int NC			        :24;            
		}BITS;
		volatile unsigned long int WORD;
	}TXDATA;

	union{
		struct{
			volatile unsigned long int PE		    :1;
			volatile unsigned long int FE		    :1;
			volatile unsigned long int BRK		:1;
			volatile unsigned long int ROE		:1;
			volatile unsigned long int TOE		:1;
			volatile unsigned long int TMT		:1;
			volatile unsigned long int TRDY		:1;
			volatile unsigned long int RRDY		:1;
			volatile unsigned long int E		    :1;
			volatile unsigned long int NC		    :1;
			volatile unsigned long int DCTS		:1;
			volatile unsigned long int CTS		:1;
			volatile unsigned long int EOP		:1;
			volatile unsigned long int NC1		:19;            
		} BITS;
		volatile unsigned long int WORD;
	}STATUS;

	union{
		struct{
			volatile unsigned long int IPE		:1;
			volatile unsigned long int IFE		:1;
			volatile unsigned long int IBRK		:1;
			volatile unsigned long int IROE		:1;
			volatile unsigned long int ITOE		:1;
			volatile unsigned long int ITMT		:1;
			volatile unsigned long int ITRDY	    :1;
			volatile unsigned long int IRRDY	    :1;
			volatile unsigned long int IE		    :1;
			volatile unsigned long int TRBK		:1;
			volatile unsigned long int IDCTS	    :1;
			volatile unsigned long int RTS		:1;
			volatile unsigned long int IEOP		:1;
			volatile unsigned long int NC		    :19;            
		}BITS;
		volatile unsigned long int WORD;
	}CONTROL;

	union{
		struct{
			volatile unsigned long int BAUD_RATE_DIVISOR	:16;
			volatile unsigned long int NC                   :16;           
		}BITS;
		volatile unsigned  int WORD;
	}DIVISOR;

}UART_STR;

typedef struct{

    volatile unsigned long int RXDATA;

    volatile unsigned long int TXDATA;

    union{
        struct{
            volatile unsigned long int NC           :3;
            volatile unsigned long int ROE      :1;
            volatile unsigned long int TOE      :1;
            volatile unsigned long int TMT      :1;
            volatile unsigned long int TRDY     :1;
            volatile unsigned long int RRDY     :1;
            volatile unsigned long int E            :1;
            volatile unsigned long int NC1      :23;        
        }BITS;
        volatile unsigned long int WORD;
    }STATUS;

    union{
        struct{
            volatile unsigned long int NC           :3;
            volatile unsigned long int IROE     :1;
            volatile unsigned long int ITOE     :1;
            volatile unsigned long int NC1      :1;
            volatile unsigned long int ITRDY        :1;
            volatile unsigned long int IRRDY        :1;
            volatile unsigned long int IE           :1;
            volatile unsigned long int NC2      :1;
            volatile unsigned long int SSO      :21;
        }BITS;
        volatile unsigned long int CONTROL;
    }CONTROL;

    unsigned long int RESERVED0;
    unsigned long int SLAVE_SELECT;

}SPI_STR;

typedef struct
{
    unsigned long int DATA;
    unsigned long int DIRECTION;
    unsigned long int INTERRUPT_MASK;
    unsigned long int EDGE_CAPTURE;
    
}PIO_STR;


/*-----------------------------------------------------------------------------
 *  Peripheral declaration
 *-----------------------------------------------------------------------------*/
#ifdef _UART
#define UART              ((UART_STR *) UART_BASE)
#endif /*_UART */

#ifdef _RTC
#define RTC_SCLK          ((PIO_STR *) RTC_SCLK_BASE)
#define RTC_DATA          ((PIO_STR *) RTC_DATA_BASE)
#define RTC_RST           ((PIO_STR *) RTC_RST_N_BASE)
#endif /* _RTC */

#ifdef _IIC
#define IIC_SCL           ((PIO_STR *) SCL_BASE)
#define IIC_SDA           ((PIO_STR *) SDA_BASE)
#endif /* _IIC */

#ifdef _LED
#define LED               ((PIO_STR *) LED_BASE)
#endif /* _LED */

#endif /*SOPC_H_*/

