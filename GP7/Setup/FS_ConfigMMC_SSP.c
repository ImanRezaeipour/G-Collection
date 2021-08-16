/*********************************************************************
*  
*   IAR PowerPac
*
*   (c) Copyright IAR Systems 2009.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
----------------------------------------------------------------------
File        : ConfigMMC_SPI.c
Purpose     : Configuration file for FS with MMC SPI mode driver
---------------------------END-OF-HEADER------------------------------
*/


#include <stdio.h>
#include "FS.h"
#include "hardware.h"

/*********************************************************************
*
*       Defines, configurable
*
*       This section is the only section which requires changes 
*       using the MMC/SD card mode disk driver as a single device.
*
**********************************************************************
*/
#define ALLOC_SIZE                 0x1000      // Size defined in bytes

/*********************************************************************
*
*       Static data
*
**********************************************************************
*/
static U32   _aMemBlock[ALLOC_SIZE / 4];      // Memory pool used for semi-dynamic allocation.

/*********************************************************************
*
*       Public code
*
*       This section does not require modifications in most systems.
*
**********************************************************************
*/

/*********************************************************************
*
*       FS_X_AddDevices
*
*  Function description
*    This function is called by the FS during FS_Init().
*    It is supposed to add all devices, using primarily FS_AddDevice().
*    
*  Note
*    (1) Other API functions
*        Other API functions may NOT be called, since this function is called
*        during initialization. The devices are not yet ready at this point.
*/
void FS_X_AddDevices(void) {
  FS_AssignMemory(&_aMemBlock[0], sizeof(_aMemBlock));
  FS_AddDevice(&FS_MMC_SPI_Driver);
}

/*********************************************************************
*
*       FS_X_GetTimeDate
*
*  Description:
*    Current time and date in a format suitable for the file system.
*
*    Bit 0-4:   2-second count (0-29)
*    Bit 5-10:  Minutes (0-59)
*    Bit 11-15: Hours (0-23)
*    Bit 16-20: Day of month (1-31)
*    Bit 21-24: Month of year (1-12)
*    Bit 25-31: Count of years from 1980 (0-127)
*
*/
U32 FS_X_GetTimeDate(void) {
  U32 r;
  U16 Sec, Min, Hour;
  U16 Day, Month, Year;
/*
  Sec   = 0;        // 0 based.  Valid range: 0..59
  Min   = 0;        // 0 based.  Valid range: 0..59
  Hour  = 0;        // 0 based.  Valid range: 0..23
  Day   = 1;        // 1 based.    Means that 1 is 1. Valid range is 1..31 (depending on month)
  Month = 1;        // 1 based.    Means that January is 1. Valid range is 1..12.
  Year  = 0;        // 1980 based. Means that 2007 would be 27.
*/
  Hardware h;
  RTCTime rtc;
  h.RTCInit();
  h.RTCStart();
  rtc=h.RTCGetTime();
  Sec   = rtc.RTC_Sec;
  Min   = rtc.RTC_Min;
  Hour  = rtc.RTC_Hour;
  Day   = rtc.RTC_Mday;
  Month = rtc.RTC_Mon;
  Year  = rtc.RTC_Year-1980;
  r   = Sec / 2 + (Min << 5) + (Hour  << 11);
  r  |= (U32)(Day + (Month << 5) + (Year  << 9)) << 16;
  return r;
}

/*************************** End of file ****************************/
