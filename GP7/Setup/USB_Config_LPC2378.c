/*********************************************************************
*  
*   IAR PowerPac
*
*   (c) Copyright IAR Systems 2008.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File    : Config_LPC23xx.c
Purpose : Config file for NXP 23xx.
--------  END-OF-HEADER  ---------------------------------------------
*/

#include "USB.h"

/*********************************************************************
*
*       Defines
*
**********************************************************************
*/
/****** Vectored interrupt controller (VIC) *************************/

#define __VIC_BASE_ADDR  0xFFFFF000

#define __VIC_IRQSTATUS       *(volatile U32*)(__VIC_BASE_ADDR + 0x000)
#define __VIC_FIQSTATUS       *(volatile U32*)(__VIC_BASE_ADDR + 0x004)
#define __VIC_RAWINTERRUPT    *(volatile U32*)(__VIC_BASE_ADDR + 0x008)
#define __VIC_INTSELECT       *(volatile U32*)(__VIC_BASE_ADDR + 0x00C)
#define __VIC_INTENABLE       *(volatile U32*)(__VIC_BASE_ADDR + 0x010)
#define __VIC_INTENABLECLEAR  *(volatile U32*)(__VIC_BASE_ADDR + 0x014)
#define __VIC_SOFTINT         *(volatile U32*)(__VIC_BASE_ADDR + 0x018)
#define __VIC_SOFTINTCLEAR    *(volatile U32*)(__VIC_BASE_ADDR + 0x01C)

#define __VIC_PRIO_0          *(volatile U32*)(__VIC_BASE_ADDR + 0x200)
#define __VIC_VECTORADDR      *(volatile U32*)(__VIC_BASE_ADDR + 0xF00)

#define __VIC_VECT_0          *(volatile U32*)(__VIC_BASE_ADDR + 0x100)
#define __VIC_VECT_BASE_ADDR  (__VIC_BASE_ADDR + 0x100)
#define __VIC_PRIO_BASE_ADDR  (__VIC_BASE_ADDR + 0x200)

#ifndef   _NUM_INT_VECTORS
  #define _NUM_INT_VECTORS     32
#endif

#define USB_INT_INDEX          22

#define _NUM_INT_PRIORITIES   (16)
#define _INT_PRIORITY_MASK    (_NUM_INT_PRIORITIES - 1)


#define __USB_PORT_SEL    (*(volatile U32*)(0xFFE0C110))


/*********************************************************************
*
*       Public code
*
**********************************************************************
*/

/*********************************************************************
*
*       USB_X_HWAttach
*/
void USB_X_HWAttach(void) {
#define __FIO0DIR        (*(volatile unsigned long *)(0x3FFFC000)) 
#define __FIO0CLR        (*(volatile unsigned long *)(0xE002800C))
  
  __USB_PORT_SEL = 3;
  __FIO0DIR |= (1 << 14);
  __FIO0CLR |= (1 << 14);
}

/*********************************************************************
*
*       Setup which target USB driver shall be used
*/


/*********************************************************************
*
*       USB_X_AddDriver
*/
void USB_X_AddDriver(void) {
  USB_AddDriver(&USB_Driver_NXPLPC23xx);
}


/*********************************************************************
*
*       OS_ARM_InstallISRHandler
*
*/
static USB_ISR_HANDLER* _InstallISRHandler(int ISRIndex, USB_ISR_HANDLER* pISRHandler) {
  USB_ISR_HANDLER*  pfOldHandler;
  USB_ISR_HANDLER** papfISR;

  pfOldHandler = NULL;
  USB_OS_IncDI();
  papfISR = (USB_ISR_HANDLER**) &__VIC_VECT_0;
  if (ISRIndex < _NUM_INT_VECTORS) {
    pfOldHandler          = *(papfISR + ISRIndex);
    *(papfISR + ISRIndex) = pISRHandler;
  }
  USB_OS_DecRI();
  return pfOldHandler;
}

/*********************************************************************
*
*       _EnableISR
*
*/
static void _EnableISR(int ISRIndex) {
  if (ISRIndex < _NUM_INT_VECTORS) {
    USB_OS_IncDI();
    __VIC_INTENABLE = (1UL << ISRIndex);
    USB_OS_DecRI();
  }
}

/*********************************************************************
*
*       _ISRSetPrio
*/
static int _ISRSetPrio(int ISRIndex, int Prio) {
  U32   * pPrio;
  int     OldPrio;

  USB_OS_IncDI();
  pPrio = (U32*) __VIC_PRIO_BASE_ADDR;
  OldPrio = pPrio[ISRIndex];
  pPrio[ISRIndex] = (OldPrio & ~_INT_PRIORITY_MASK) | (Prio & _INT_PRIORITY_MASK);
  USB_OS_DecRI();
  return OldPrio & _INT_PRIORITY_MASK;
}

/*********************************************************************
*
*       USB_X_EnableISR
*
*/
void USB_X_EnableISR(USB_ISR_HANDLER * pfISRHandler) {
  _InstallISRHandler(USB_INT_INDEX, pfISRHandler);
  _EnableISR(USB_INT_INDEX);                       
  _ISRSetPrio(USB_INT_INDEX, 15);                  
}


/**************************** end of file ***************************/
