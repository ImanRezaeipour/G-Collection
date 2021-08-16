/*********************************************************************
*  
*   IAR PowerPac
*
*   (c) Copyright IAR Systems 2009.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
----------------------------------------------------------------------
File        : ConfigMMC_CardMode.c
Purpose     : Configuration functions for FS with MMC/SD card mode driver
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
#define ALLOC_SIZE                 0x2200      // Size defined in bytes

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
  FS_AddDevice(&FS_MMC_CardMode_Driver);
  FS_MMC_CM_Allow4bitMode(0, 1);
  FS_WriteUpdateDir(0);
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
  Hardware h;
  RTCTime rtc;
  h.RTCInit();
  h.RTCStart();
  rtc=h.RTCGetTime();
  r   = rtc.RTC_Sec / 2 + (rtc.RTC_Min << 5) + (rtc.RTC_Hour  << 11);
  r  |= (U32)(rtc.RTC_Mday + (rtc.RTC_Mon << 5) + ((rtc.RTC_Year-1980)  << 9)) << 16;
  return r;
}

/*************************** End of file ****************************/
