/*********************************************************************
*  
*   IAR PowerPac - TCP/IP Stack
*
*   (c) Copyright IAR Systems 2008.  All rights reserved.
*
**********************************************************************
--------  END-OF-HEADER  ---------------------------------------------
*/

#ifndef _IP_CONF_H_
#define _IP_CONF_H_ 1



#ifdef __ICCARM__
  #if __CORE__ != __ARM7M__      // Cortex-M3
    #include "Util.h"
    #define IP_MEMCPY(pDest, pSrc, NumBytes) ARM_memcpy(pDest, pSrc, NumBytes)    // Speed optimization: Our memcopy is much faster!
    U16 ARM_IP_cksum(void * ptr, unsigned NumHWords);
    #define IP_CKSUM(p, NumItems) ARM_IP_cksum((p), (NumItems))
  //  #define IP_OPTIMIZE __arm __ramfunc __interwork
    #define IP_IS_BIG_ENDIAN (1 - __LITTLE_ENDIAN__)
  #endif
#endif

#ifdef DEBUG
  #if DEBUG
    #define IP_DEBUG        2   // Debug level: 1: Support "Panic" checks, 2: Support warn & log
  #endif
#endif

#endif     // Avoid multiple inclusion


