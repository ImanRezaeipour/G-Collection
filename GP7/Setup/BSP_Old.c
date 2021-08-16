/*********************************************************************
*  
*   IAR PowerPac
*
*   (c) Copyright IAR Systems 2008.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File    : BSP.c
Purpose : BSP interface for Keil LPC2378 eval board
--------  END-OF-HEADER  ---------------------------------------------
*/

#include "BSP.h"
#include "RTOS.h"
#include "board.h"
#include <nxp/iolpc2378.h>

/*********************************************************************
*
*       Defines
*
**********************************************************************
*/
/*
#define FIO2DIR0 *(volatile unsigned char*)(0x3FFFC040)
#define FIO2SET0 *(volatile unsigned char*)(0x3FFFC058)
#define FIO2CLR0 *(volatile unsigned char*)(0x3FFFC05C)
#define FIO2PIN0 *(volatile unsigned char*)(0x3FFFC054)
*/
#define MAC_MODULEID  *(volatile unsigned int*)(0xFFE00FFC) // MAC ID register

// Pin Connect Block Registers
#define PINSEL_BASE_ADDR	0xE002C000
#define PINSEL2       *(volatile unsigned long *)(PINSEL_BASE_ADDR + 0x08)
#define PINSEL3       *(volatile unsigned long *)(PINSEL_BASE_ADDR + 0x0C)

#define INT_INDEX_MAC  21

/*********************************************************************
*
*       Global functions
*
**********************************************************************
*/

/*********************************************************************
*
*       BSP_Init()
*/
void BSP_Init(void) {
  
  //FIO2DIR0 = 0xFF;      // P2 (0..7) output
  // Set to inputs
  IO0DIR  = \
  IO1DIR  = \
  FIO0DIR = \
  FIO1DIR = \
  FIO2DIR = \
  FIO3DIR = \
  FIO4DIR = 0;

  // Enable Fast GPIO0,1
  SCS_bit.GPIOM = 1;

  // clear mask registers
  FIO0MASK =\
  FIO1MASK =\
  FIO2MASK =\
  FIO3MASK =\
  FIO4MASK = 0;
/*
  // Reset all GPIO pins to default primary function
  PINSEL0 =\
  PINSEL1 =\
  PINSEL2 =\
  PINSEL3 =\
  PINSEL4 =\
  PINSEL5 =\
  PINSEL6 =\
  PINSEL7 =\
  PINSEL8 =\
  PINSEL9 =\
  PINSEL10= 0;
  */
  USB_LINK_LED_FDIR = USB_LINK_LED_MASK;
  USB_LINK_LED_FSET = USB_LINK_LED_MASK;
  
  LCD_BL_FDIR = LCD_BL_MASK;
  LCD_BL_FSET = LCD_BL_MASK;
}

/*********************************************************************
*
*       ETH_Init
*/
//extern "C" void BSP_ETH_Init(unsigned Unit);
void BSP_ETH_Init(unsigned Unit) {

  /*------------------------------------------------------------------------------
  * write to PINSEL2/3 to select the PHY functions on P1[17:0]
  *-----------------------------------------------------------------------------*/
  /* P1.6, ENET-TX_CLK, has to be set for EMAC to address a BUG in
  the rev"xx-X" or "xx-Y" silicon(see errata). On the new rev.(xxAY, released
  on 06/22/2007), P1.6 should NOT be set. */
  if (MAC_MODULEID == 0x39022000) {     // Older chip ?
    PINSEL2 = 0x50151105;	/* selects P1[0,1,4,6,8,9,10,14,15] */
  } else {
    PINSEL2 = 0x50150105;	/* selects P1[0,1,4,8,9,10,14,15] */
  }
  PINSEL3 = (PINSEL3 & ~0x0000000f) | 0x5;
}


/*********************************************************************
*
*       BSP_ETH_InstallISR
*/
//extern "C" void BSP_ETH_InstallISR(void (*pfISR)(void));
void BSP_ETH_InstallISR(void (*pfISR)(void)) {
  OS_ARM_InstallISRHandler(INT_INDEX_MAC, pfISR);     // Timer/counter interrupt vector.
  OS_ARM_EnableISR(INT_INDEX_MAC);                    // Enable timer/counter 0 interrupt.
  OS_ARM_ISRSetPrio(INT_INDEX_MAC, 15);               // lowest priority
}

/*********************************************************************
*
*       LED switching routines
*/

void BSP_SetLED(int Index) {
  FIO2SET0 = 1 << Index;
}

void BSP_ClrLED(int Index) {
  FIO2CLR0 = 1 << Index;

}

void BSP_ToggleLED(int Index) {
  if(Index == 1)
    USB_LINK_LED_FIO ^= USB_LINK_LED_MASK;
  else if(Index == 0)
    LCD_BL_FIO ^= LCD_BL_MASK;
}

/****** EOF *********************************************************/

