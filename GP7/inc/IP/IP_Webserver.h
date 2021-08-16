/*********************************************************************
*  
*   IAR PowerPac - TCP/IP Stack
*
*   (c) Copyright IAR Systems 2008.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File        : IP_WebServer.h
Purpose     : Publics for the WebServer
---------------------------END-OF-HEADER------------------------------

Attention : Do not modify this file !
*/

#ifndef  IP_WEBS_H
#define  IP_WEBS_H

#include "IP_FS.h"
#include "WEBS_Conf.h"

/*********************************************************************
*
*       Defaults for config values
*
**********************************************************************
*/
#ifndef   WEBS_IN_BUFFER_SIZE
  #define WEBS_IN_BUFFER_SIZE    512
#endif

#ifndef   WEBS_OUT_BUFFER_SIZE
  #define WEBS_OUT_BUFFER_SIZE   512
#endif

#ifndef   WEBS_TEMP_BUFFER_SIZE
  #define WEBS_TEMP_BUFFER_SIZE  256         // Used as file input buffer and for form parameters
#endif

#ifndef   WEBS_ERR_BUFFER_SIZE
  #define WEBS_ERR_BUFFER_SIZE   128         // Used in case of connection limit only
#endif

#ifndef   WEBS_AUTH_BUFFER_SIZE
  #define WEBS_AUTH_BUFFER_SIZE  32
#endif

#ifndef   WEBS_FILENAME_BUFFER_SIZE
  #define WEBS_FILENAME_BUFFER_SIZE  32
#endif

#define WEBS_STACK_SIZE_CHILD   (1200 + WEBS_IN_BUFFER_SIZE + WEBS_OUT_BUFFER_SIZE + WEBS_TEMP_BUFFER_SIZE)    // This size can not be guaranteed on all systems. Actual size depends on CPU & compiler

#if defined(__cplusplus)
extern "C" {     /* Make sure we have C-declarations in C++ programs */
#endif

/*********************************************************************
*
*       Types
*
**********************************************************************
*/

typedef int (*IP_WEBS_tSend)   (const unsigned char * pData, int len, void* pConnectInfo);
typedef int (*IP_WEBS_tReceive)(      unsigned char * pData, int len, void* pConnectInfo);

typedef void* WEBS_OUTPUT;
typedef struct {
  const char * sName;   // e.g. "Counter" or "Counter.pl"
  void  (*pf)(WEBS_OUTPUT * pOutput, const char * sParameters, const char * sValue);
} WEBS_CGI;

typedef struct {
  const char * sPath;
  const char * sRealm;
  const char * sUserPass;
} WEBS_ACCESS_CONTROL;

typedef struct {
  const WEBS_CGI      * paCGI;
  WEBS_ACCESS_CONTROL * paAccess;
  void  (*pfHandleParameter)(WEBS_OUTPUT * pOutput, const char * sPara, const char * sValue);
} WEBS_APPLICATION;



/*********************************************************************
*
*       Functions
*
**********************************************************************
*/

extern const IP_FS_API IP_FS_ReadOnly;

int  IP_WEBS_Process           (IP_WEBS_tSend pfSend, IP_WEBS_tReceive pfReceive, void* pConnectInfo, const IP_FS_API * pFS_API, const WEBS_APPLICATION * pApplication);
void IP_WEBS_OnConnectionLimit (IP_WEBS_tSend pfSend, IP_WEBS_tReceive pfReceive, void* pConnectInfo);

int  IP_WEBS_SendMem      (WEBS_OUTPUT * pOutput, const char * s, unsigned NumBytes);
int  IP_WEBS_SendString   (WEBS_OUTPUT * pOutput, const char * s);
int  IP_WEBS_SendStringEnc(WEBS_OUTPUT * pOutput, const char * s);
int  IP_WEBS_SendUnsigned(WEBS_OUTPUT * pOutput, unsigned v, unsigned Base, int NumDigits);

#if defined(__cplusplus)
  }
#endif


#endif   /* Avoid multiple inclusion */

/*************************** End of file ****************************/




