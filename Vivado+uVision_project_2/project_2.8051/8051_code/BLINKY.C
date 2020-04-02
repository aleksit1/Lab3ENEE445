#include <reg51.h>		/* Include x51 header file */
#include <stdio.h>
#include "i2c.h"
//void UART_Init()
//{

//}

//void Transmit_data(char tx_data)
//{
//	SBUF = tx_data;		/* Load char in SBUF register */
//	while (TI==0);		/* Wait until stop bit transmit */
//	TI = 0;			/* Clear TI flag */
//}

//void String(char *str)
//{
	//int i;
	//for(i=0;str[i]!=0;i++)	/* Send each char of string till the NULL */
	//{
	//	Transmit_data(str[i]);	/* Call transmit data function */
//}
//}	

void main()
{
	unsigned char aaa='X';
	//int i;
	SCON  = 0x50;				/* SCON: mode 1, 8-bit UART, enable rcvr    */
	TMOD |= 0x20;				/* TMOD: timer 1, mode 2, 8-bit reload      */
	TH1   = 253;				/* TH1:  reload value for 9600 baud (see _readme_setting_8051_serial_baud rate.txt)        */
	// !! PCON |= 0x80;	/* SMOD=1 doubles baud rate (see +Intel_mcs8051_users_manual_8051.pdf page 50)
	TR1   = 1;					/* TR1:  timer 1 run                        */
	TI    = 1;	
	I2C_Start();
		aaa = I2C_Read(1);
		//I2C_Stop();
		
		putchar(aaa);

	while (1) {
			I2C_Start();
		aaa = I2C_Read(1);
		//I2C_Stop();
		
		putchar(aaa);
		
		//aaa = _getkey();
		//if (aaa >= 97 && aaa <= 122) {
			//aaa = aaa - 32;
			//for(i = 0; i < 1000; i++);
			
			//putchar(aaa);	
		//}
	}
}