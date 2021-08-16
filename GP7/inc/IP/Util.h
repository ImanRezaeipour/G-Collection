/*********************************************************************
*  
*   IAR PowerPac - TCP/IP Stack
*
*   (c) Copyright IAR Systems 2008.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File    : UTIL.h
Purpose : Declares general purpose utility functions
---------------------------END-OF-HEADER------------------------------
*/

#ifndef UTIL_H            // Guard against multiple inclusion
#define UTIL_H

#include <Global.h>

void ARM_memcpy(void * pDest, const void * pSrc, int NumBytes);
void UTIL_memcpy(void * pDest, const void * pSrc, int NumBytes);

#endif                      // Avoid multiple inclusion

/*************************** End of file ****************************/
