/*********************************************************************
*  
*   IAR PowerPac - TCP/IP Stack
*
*   (c) Copyright IAR Systems 2008.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File    : WEBS_Conf.h
Purpose : Webserver add-on.
---------------------------END-OF-HEADER------------------------------
*/

#ifndef _WEBS_CONF_H_
#define _WEBS_CONF_H_ 1

#ifdef DEBUG
  #define WEBS_WARN(p)
  #define WEBS_LOG(p)
#else
  #define WEBS_WARN(p)
  #define WEBS_LOG(p)
#endif

#define WEBS_IN_BUFFER_SIZE   256      // Buffer size should be at least 256 bytes
#define WEBS_OUT_BUFFER_SIZE  512      // Buffer size can be decreased. To small buffers will result in a lack of performance and decreases the quality of service.
//
// CGI start and end strings
//
#define WEBS_CGI_START_STRING "<!--#exec cgi=\""
#define WEBS_CGI_END_STRING   "\"-->"

#endif     // Avoid multiple inclusion




























