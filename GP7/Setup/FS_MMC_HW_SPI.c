/*********************************************************************
*  
*   IAR PowerPac
*
*   (c) Copyright IAR Systems 2009.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File        : MMC_HW_SPI.c
Purpose     : Sample MMC hardware layer for NXP LPC21xx/22xx series
---------------------------END-OF-HEADER------------------------------
*/

#include "FS.h"
#include "MMC_X_HW.h"

#include <nxp/iolpc2388.h>
#include "target.h"

#define _CRYSTAL_CLOCK          12000000

/*********************************************************************
*
*       Defines
*
**********************************************************************
*/

/* Pin Connect Block */
//#define PCONP          *(volatile U32 *)(0xE01FC0C4)
#define VPBDIV         *(volatile U32 *)(0xE01FC100)
#define PLLSTAT        *(volatile U32 *)(0xE01FC088)

#define MMC_DEFAULTSUPPLYVOLTAGE  3300 /* in mV, example means 3.3V */

/*********************************************************************
*
*       Static data
*
**********************************************************************
*/
static char _IsInited;
/*********************************************************************
*
*       Static code
*
**********************************************************************
*/

/*********************************************************************
*
*       _Init
*
*/
static void _Init(void) {
  if (_IsInited == 0) {
    U8  i, Dummy;
    PINSEL0_bit.P0_15=3;
    PINSEL1_bit.P0_16=0;
    PINSEL1_bit.P0_17=3;
    PINSEL1_bit.P0_18=3;
    
    PCONP_bit.PCSPI = 1;
    
//    SSP0CR1      = 0x00;                      // SSP master (off) in normal mode
    FIO0DIR |= (1UL<<16);
    FIO0SET |= (1UL<<16);
//    SSP0CR0 = 0x0007;                    // Set data to 8-bit, Frame format SPI, CPOL = 0, CPHA = 0 and SCR is 0
//    SSP0CPSR = 0x2;                       // SSPCPSR clock prescale register, master mode, minimum divisor is 0x02
    S0SPCCR = 8;
    //
    // Device select as master, SSP Enabled, normal operational mode
    //
//    SSP0CR1 = 0x02;
    S0SPCR = 0x0820;
      for ( i = 0; i < 8; i++ ) {
        Dummy = S0SPDR;                         // Flush RxFIFO
        FS_USE_PARA(Dummy);
      }
      _IsInited = 1;
  }
}

/*********************************************************************
*
*       FS_MMC_HW_X_EnableCS
*
*/
void FS_MMC_HW_X_EnableCS(U8 Unit) {
  //IOCLR0 = (1 << 20);
  FIO0CLR |= (1UL<<16);
}


/*********************************************************************
*
*       FS_MMC_HW_X_DisableCS
*
*/
void FS_MMC_HW_X_DisableCS(U8 Unit) {
  //IOSET0 = (1 << 20);
  FIO0SET |= (1UL<<16);
}


/*********************************************************************
*
*       FS_MMC_HW_X_IsPresent
*
*/
int FS_MMC_HW_X_IsPresent(U8 Unit) {
  _Init();
  return 1;
}

/*********************************************************************
*
*       FS_MMC_HW_X_IsWriteProtected
*
*/
int FS_MMC_HW_X_IsWriteProtected(U8 Unit) {
  return 0;
}


/*********************************************************************
*
*       FS_MMC_HW_X_SetMaxSpeed
*
*/
U16 FS_MMC_HW_X_SetMaxSpeed(U8 Unit, U16 MaxFreq) {
  unsigned Prescaler;
  U32      PeriphalClock;
  _Init();
  PeriphalClock = Fpclk;//Fcclk;
  // Calc prescaler value.
  Prescaler = ((PeriphalClock / 1000) + MaxFreq - 1) / MaxFreq;
  Prescaler = ((Prescaler + 1) >> 1) << 1;
  if (Prescaler < 8) {
    Prescaler = 8;
  }
//  SSP0CPSR = Prescaler;
  S0SPCCR =  Prescaler;
  return (PeriphalClock / 1000) / Prescaler;
}

/*********************************************************************
*
*       FS_MMC_HW_X_SetVoltage
*
*/
int FS_MMC_HW_X_SetVoltage(U8 Unit, U16 Vmin, U16 Vmax) {
  return 1;
}


/*********************************************************************
*
*       FS_MMC_HW_X_Read
*
*/
void FS_MMC_HW_X_Read(U8 Unit, U8 * pData, int NumBytes) {
  int i;
  
  for (i = 0; i < NumBytes; i++) {
    // Wrtie dummy byte out to generate clock 
    // to read data from MISO
    S0SPDR = 0xFF;
    // Wait until the Busy bit is cleared
//    while ( SSP0SR & (1 << 4));
    while (!(S0SPSR & (1 << 0x07)));
    *pData++ = S0SPDR;
  }
}

/*********************************************************************
*
*       FS_MMC_HW_X_Write
*
*/
void FS_MMC_HW_X_Write(U8 Unit, const U8 * pData, int NumBytes) {
  U8 Dummy;
  
  do {
    //
    // As long as TNF bit is set, 
    // TxFIFO is not full -> writing to the FIFO allowed
    //
//    while ((SSP0SR & (1 << 1)) == 0);
    S0SPDR = *pData;
    // Wait until the Busy bit is cleared
//    while ((SSP0SR & (1 << 0x04)));
    while (!(S0SPSR & (1 << 0x07)));
    Dummy = S0SPDR; /* Flush the RxFIFO */
    FS_USE_PARA(Dummy);
    pData++;
  } while (--NumBytes);
}
/*************************** End of file ****************************/
