/*********************************************************************
*  
*   IAR PowerPac
*
*   (c) Copyright IAR Systems 2009.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File    : USB_Conf.h
Purpose : Config file. Modify to reflect your configuration
--------  END-OF-HEADER  ---------------------------------------------
*/


#ifndef USB_CONF_H           /* Avoid multiple inclusion */
#define USB_CONF_H

#ifdef USB_IS_HIGH_SPEED
  #define USB_MAX_PACKET_SIZE     512
#endif

#define USB_VENDOR_ID           0x8765
#define USB_PRODUCT_ID          0x1234

#define USB_STRING_PRODUCT      "Product"
#define USB_STRING_MANUFACTURER "Manufacturer"
#define USB_STRING_SERIAL_NUMBER "12345678"

#endif     /* Avoid multiple inclusion */
