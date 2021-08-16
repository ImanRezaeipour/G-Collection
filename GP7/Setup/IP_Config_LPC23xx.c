/*********************************************************************
*
*   IAR PowerPac
*
*   (c) Copyright IAR Systems 2008.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
File        : IP_Config_LPC23xx.c
Purpose     : Configuration file for TCP/IP with NXP LPC23xx
---------------------------END-OF-HEADER------------------------------
*/

#include <stdio.h>
#include "IP.h"
#include "Setting.h"
/*********************************************************************
*
*       Defines, configurable
*
*       This section is normaly the only section which requires changes.
*       on most embedded systems
*
**********************************************************************
*/
#define ALLOC_SIZE                 0x4000      // Size of memory dedicated to the stack in bytes

/*********************************************************************
*
*       Static data
*
**********************************************************************
*/
U32 _aPool[ALLOC_SIZE / 4];                    // This is the memory area used by the stack.

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
*       IP_X_Config
*
*  Function description
*    This function is called by the IP stack during IP_Init().
*    It is supposed to add all devices, using primarily FS_AddDevice().
*
*/
void IP_X_Config(void) {
  Setting set;
  unsigned char ba[7];
  ba[0] = 0;
  ba[1] = 0x3C;
  ba[2] = (unsigned char)(set.GetSettings().DeviceID >> 24)+ 4;
  ba[3] = (unsigned char)(set.GetSettings().DeviceID >> 16)+ 3;
  ba[4] = (unsigned char)(set.GetSettings().DeviceID >> 8)+ 2;
  ba[5] = (unsigned char)set.GetSettings().DeviceID + 1;
  ba[6] = 0; 
  IP_AssignMemory(_aPool, sizeof(_aPool));
  IP_AddEtherInterface(&IP_Driver_LPC24xx);
  IP_SetHWAddr(ba);
  IP_SetAddrMask(0xC0A80105, 0xFFFFFF00);
  //IP_DNS_SetServer(0xCC98B84C);               // Set DNS server, for example 204.152.184.76
  IP_SetGWAddr(0, 0xC0A80A01);                // Set gateway address, for example 192.168.10.1
  //IP_DHCPC_SetCallback(0, DHCPC_Callback);
  //IP_DHCPC_Activate(0, "LPC2378STK", NULL, NULL);
  IP_AddBuffers(6, 256);
  IP_AddBuffers(6, 1536);
  IP_ConfTCPSpace(4 * 1024, 4 * 1024);
  /*IP_AddBuffers(1, 256);
  IP_AddBuffers(1, 1536);
  IP_ConfTCPSpace(1 * 1024, 1 * 1024); */
  IP_SetWarnFilter(0xFFFFFFFF);
  IP_SetLogFilter( IP_MTYPE_INIT | IP_MTYPE_LINK_CHANGE | IP_MTYPE_DHCP );
}
/*void IP_X_Config(void) {
  IP_AssignMemory(_aPool, sizeof(_aPool));    // Assigning memory should be the first thing
  IP_AddEtherInterface(&IP_Driver_LPC24xx);     // Add ethernet driver for your hardware
  IP_SetHWAddr("\x00\x22\x33\x44\x55\x66");   // MAC addr: Needs to be unique for production units
  //
  // Use DHCP client or define IP address, subnet mask,
  // gateway address and DNS server according to the
  // requirements of your application.
  //
  IP_DHCPC_Activate(0, "TARGET", NULL, NULL);
//  IP_SetAddrMask(0xC0A805E6, 0xFFFF0000);     // Assign IP addr. and subnet mask
//  IP_SetGWAddr(0, 0xC0A80201);                // Set gateway address, for example 192.168.5.1
//  IP_DNS_SetServer(0xCC98B84C);               // Set DNS server, for example 204.152.184.76
  //
  // Run-time configure buffers.
  // The default setup will do for most cases.
  //
  IP_AddBuffers(6, 256);                      // Small buffers.
  IP_AddBuffers(8, 1536);                     // Big buffers. Size should be 1536 to allow a full ether packet to fit.
  IP_ConfTCPSpace(6 * 1024, 6 * 1024);        // Define the TCP Tx and Rx window size
  //
  // Define log and warn filter
  // Note: The terminal I/O emulation affects the timing
  // of your communication, since the debugger stops the target
  // for every terminal I/O output unless you use DCC!
  //
  IP_SetWarnFilter(0xFFFFFFFF);               // 0xFFFFFFFF: Do not filter: Output all warnings.
  IP_SetLogFilter(IP_MTYPE_INIT               // Output all messages from init
                | IP_MTYPE_LINK_CHANGE        // Output a message if link status changes
                | IP_MTYPE_DHCP               // Output general DHCP status messages
//                | IP_MTYPE_DHCP_EXT           // Output additional DHCP messages
//                | IP_MTYPE_CORE               // Output log messages from core module
//                | IP_MTYPE_ALLOC              // Output log messages for memory allocation
//                | IP_MTYPE_DRIVER             // Output log messages from driver
//                | IP_MTYPE_ARP                // Output log messages from ARP layer
//                | IP_MTYPE_IP                 // Output log messages from IP layer
//                | IP_MTYPE_TCP_CLOSE          // Output a log messages if a TCP conenction has been closed
//                | IP_MTYPE_TCP_OPEN           // Output a log messages if a TCP conenction has been opened
//                | IP_MTYPE_TCP_IN             // Output TCP input logs
//                | IP_MTYPE_TCP_OUT            // Output TCP output logs
//                | IP_MTYPE_TCP_RTT            // Output TCP round trip time (RTT) logs
//                | IP_MTYPE_TCP_RXWIN          // Output TCP RX window related log messages
//                | IP_MTYPE_TCP                // Output all TCP related log messages
//                | IP_MTYPE_UDP_IN             // Output UDP input logs
//                | IP_MTYPE_UDP_OUT            // Output UDP output logs
//                | IP_MTYPE_UDP                // Output all UDP related messages
//                | IP_MTYPE_ICMP               // Output ICMP related log messages
//                | IP_MTYPE_NET_IN             // Output network input related messages
//                | IP_MTYPE_NET_OUT            // Output network output related messages
//                | IP_MTYPE_DNS                // Output all DNS related messages
//                | IP_MTYPE_SOCKET_STATE       // Output socket status messages
//                | IP_MTYPE_SOCKET_READ        // Output socket read related messages
//                | IP_MTYPE_SOCKET_WRITE       // Output socket write related messages
//                | IP_MTYPE_SOCKET             // Output all socket related messages
                );
}*/

/*************************** End of file ****************************/
