#ifndef __HARDWARE_H__
#define __HARDWARE_H__

#include <nxp/iolpc2388.h>
#include "DataType.h"
#include "board.h"
#include "target.h"

//******************
//
// CLASS: Hardware
//
// DESCRIPTION:
//  --
//
class Hardware
{
public:
  Hardware();
  ~Hardware();

  void InitPinFunction(void);
  void Init(void);

  void InitDAC(void);
  void DispatchDAC(WORD data_in);
  void StartDACTimer(void);
  void StopDACTimer(void);
  void SetDACTimerPeriod(DWORD Period);  // 10micro second
  void SetDACTimerEvent(void (*HandlerAddr)());
  void DACTimerReTrig(void);

  void UART0Init(void);
  void UART0SetBaud(Baudrate baudrate);
  void UART0SetParity(Parity parity);
  void UART0SetLength(UART_Character_Length bits);
  void UART0SetStop(StopBits stop);
  BOOL UART0SendReady (void);
  void UART0SendByte (BYTE data);
  BOOL UART0RecvReady (void);
  BYTE UART0RecvByte (void);
  void UART0SendHex(BYTE data);
  void UART0SendHex32(DWORD data);
  void UART0SendStr(BYTE *str);
  void UART0SetInterrupt(void (*HandlerAddr)(void), DWORD Priority);
  BYTE UART0CheckStatus(void);
  void UART0EnableInterrupt(void);
  void UART0DisableInterrupt(void);

  void UART2Init(void);
  void UART2SetBaud(Baudrate baudrate);
  void UART2SetParity(Parity parity);
  void UART2SetLength(UART_Character_Length bits);
  void UART2SetStop(StopBits stop);
  BOOL UART2SendReady (void);
  void UART2SendByte (BYTE data);
  BOOL UART2RecvReady (void);
  BYTE UART2RecvByte (void);
  void UART2SendHex(BYTE data);
  void UART2SendStr(BYTE *str);
  void UART2SetInterrupt(void (*HandlerAddr)(void), DWORD Priority);
  BYTE UART2CheckStatus(void);
  void UART2EnableInterrupt(void);
  void UART2DisableInterrupt(void);

  void UART3Init(void);
  void UART3SetBaud(Baudrate baudrate);
  void UART3SetParity(Parity parity);
  void UART3SetLength(UART_Character_Length bits);
  void UART3SetStop(StopBits stop);
  BOOL UART3SendReady (void);
  void UART3SendByte (BYTE data);
  BOOL UART3RecvReady (void);
  BYTE UART3RecvByte (void);
  void UART3SendHex(BYTE data);
  void UART3SendStr(BYTE *str);
  void UART3SetInterrupt(void (*HandlerAddr)(void), DWORD Priority);
  BYTE UART3CheckStatus(void);
  void UART3EnableInterrupt(void);
  void UART3DisableInterrupt(void);

  void UART1Init(void);
  void UART1SetBaud(Baudrate baudrate);
  void UART1SetParity(Parity parity);
  void UART1SetLength(UART_Character_Length bits);
  void UART1SetStop(StopBits stop);
  BOOL UART1SendReady (void);
  void UART1SendByte (BYTE data);
  BOOL UART1RecvReady (void);
  BYTE UART1RecvByte (void);
  void UART1SendHex(BYTE data);
  void UART1SendStr(BYTE *str);
  void UART1SetInterrupt(void (*HandlerAddr)(void), DWORD Priority);
  BYTE UART1CheckStatus(void);
  void UART1EnableInterrupt(void);
  void UART1DisableInterrupt(void);
  void ModemInitial(void);
  void Com1Enable(bool EN);

  void RTCInit(void);
  void RTCSetTime(RTCTime Time);
  RTCTime RTCGetTime(void);
  void RTCStart(void);

  void InitKeyPins(void);
  void SetPinsInterrupt (void (*HandlerAddr)(void));
  WORD GetPhysicalKey(void);
  void EnableKeyInterrupt(void);
  void DisableKeyInterrupt(void);
  void KeyClearInterrupt(void);

  void LCDPortInit(void);
  void LCDDispatchData(BYTE);
  void LCDCS1(bool);
  void LCDCS2(bool);
  void LCDEnable(bool);
  void LCDDI(bool);
  void LCDReset(bool);
  void LCDRW(bool);

  void PWMPortInit(void);
  void PWMSetDutyCycle(BYTE DutyCycle);//0 ~ 255

  void InitLED(void);
  void SetLED(BYTE);

  void InitBuzzer(void);
  void BuzzerON(void);
  void BuzzerOFF(void);

  void InitSPI(void);
  void SPI( char *buf, int Length );

private:

};

/*****************************************************************************/
/*UART************************************************************************/
/*****************************************************************************/
#define IER_RBR   0x01
#define IER_THRE  0x02
#define IER_RLS   0x04
#define IER_MDM   0x08

#define IIR_PEND  0x01
#define IIR_RLS   0x03
#define IIR_RDA   0x02
#define IIR_CTI   0x06
#define IIR_THRE  0x01
#define IIR_MDM   0x00

#define LSR_RDR   0x01
#define LSR_OE    0x02
#define LSR_PE    0x04
#define LSR_FE    0x08
#define LSR_BI    0x10
#define LSR_THRE  0x20
#define LSR_TEMT  0x40
#define LSR_RXFE  0x80

#define UART_ERROR        0
#define UART_RECV_RDR     1
#define UART_RECV_RDA     2
#define UART_Time_out     3
#define UART_SEND_READY   4
#define UART_SEND_BUSY    5
#define UART_UNKNOWN      6
#define UART_Modem        7

#define CTS_STATE   0x01
#define DSR_STATE   0x02
#define RI_STATE    0x04
#define DCD_STATE   0x08
/*****************************************************************************/
/*IRQ*************************************************************************/
/*****************************************************************************/
#define I_Bit     0x80
#define F_Bit     0x40

#define SYS32Mode   0x1F
#define IRQ32Mode   0x12
#define FIQ32Mode   0x11

#define HIGHEST_PRIORITY  0x01
#define LOWEST_PRIORITY   0x0F

#define WDT_INT     0
#define SWI_INT     1
#define ARM_CORE0_INT   2
#define ARM_CORE1_INT   3
#define TIMER0_INT    4
#define TIMER1_INT    5
#define UART0_INT   6
#define UART1_INT   7
#define PWM0_1_INT    8
#define I2C0_INT    9
#define SPI0_INT    10      /* SPI and SSP0 share VIC slot */
#define SSP0_INT    10
#define SSP1_INT    11
#define PLL_INT     12
#define RTC_INT     13
#define EINT0_INT   14
#define EINT1_INT   15
#define EINT2_INT   16
#define EINT3_INT   17
#define ADC0_INT    18
#define I2C1_INT    19
#define BOD_INT     20
#define EMAC_INT    21
#define USB_INT     22
#define CAN_INT     23
#define MCI_INT     24
#define GPDMA_INT   25
#define TIMER2_INT    26
#define TIMER3_INT    27
#define UART2_INT   28
#define UART3_INT   29
#define I2C2_INT    30
#define I2S_INT     31

#define VIC_SIZE    32

#define VIC_BASE_ADDR ((unsigned int)&VICIRQSTATUS)

#define VECT_ADDR_INDEX 0x100
#define VECT_CNTL_INDEX 0x200
/*****************************************************************************/
/*RTC*************************************************************************/
/*****************************************************************************/
#define IMSEC     0x00000001
#define IMMIN     0x00000002
#define IMHOUR    0x00000004
#define IMDOM     0x00000008
#define IMDOW     0x00000010
#define IMDOY     0x00000020
#define IMMON     0x00000040
#define IMYEAR    0x00000080

#define AMRSEC    0x00000001  /* Alarm mask for Seconds */
#define AMRMIN    0x00000002  /* Alarm mask for Minutes */
#define AMRHOUR   0x00000004  /* Alarm mask for Hours */
#define AMRDOM    0x00000008  /* Alarm mask for Day of Month */
#define AMRDOW    0x00000010  /* Alarm mask for Day of Week */
#define AMRDOY    0x00000020  /* Alarm mask for Day of Year */
#define AMRMON    0x00000040  /* Alarm mask for Month */
#define AMRYEAR   0x00000080  /* Alarm mask for Year */

#define PREINT_RTC  0x0000036D+1  /* Prescaler value, integer portion*/
#define PREFRAC_RTC 0x00007400-32768  /* Prescaler value, fraction portion*/

#define ILR_RTCCIF  0x01
#define ILR_RTCALF  0x02

#define CCR_CLKEN   0x01
#define CCR_CTCRST  0x02
#define CCR_CLKSRC  0x10
/*****************************************************************************/
/*KEYPAD**********************************************************************/
/*****************************************************************************/
#define KB_Row_0          (1UL<<25)     //
#define KB_Row_1          (1UL<<26)     //
#define KB_Row_2          (1UL<<27)     //
#define KB_Row_3          (1UL<<28)     //
#define KB_Row_4          (1UL<<29)     //Add to new KeyPad

#define KB_Col_0          (1UL<<5)
#define KB_Col_1          (1UL<<6)
#define KB_Col_2          (1UL<<7)
#define KB_Col_3          (1UL<<8)
#define KB_Col_4          (1UL<<9)      //Add to new KeyPad

#define KB_Row_MASK       KB_Row_0 | KB_Row_1 | KB_Row_2 | KB_Row_3 | KB_Row_4
#define KB_Col_MASK       KB_Col_0 | KB_Col_1 | KB_Col_2 | KB_Col_3 | KB_Col_4

#define KB_Int_MASK       KB_Col_MASK | KB_Row_MASK

#define KB_ROW_DIR        IO1DIR
#define KB_ROW_FDIR       FIO1DIR
#define KB_ROW_SET        IO1SET
#define KB_ROW_FSET       FIO1SET
#define KB_ROW_CLR        IO1CLR
#define KB_ROW_FCLR       FIO1CLR
//#define KB_ROW_IO         IO4PIN
#define KB_ROW_FIO        FIO1PIN
//#define KB_ROW_IntE       IO4INTENF

#define KB_COL_DIR        IO0DIR
#define KB_COL_FDIR       FIO0DIR
#define KB_COL_SET        IO0SET
#define KB_COL_FSET       FIO0SET
#define KB_COL_CLR        IO0CLR
#define KB_COL_FCLR       FIO0CLR
//#define KB_COL_IO         IO0PIN
#define KB_COL_FIO        FIO0PIN
#define KB_COL_IntE       IO0INTENF

#define KB_Col_In()       KB_COL_FDIR &= ~(KB_Col_MASK)
#define KB_Col_Out()      KB_COL_FDIR |= KB_Col_MASK
#define KB_Row_In()       KB_ROW_FDIR &= ~(KB_Row_MASK)
#define KB_Row_Out()      KB_ROW_FDIR |= KB_Row_MASK

#define KB_Set_Col()      KB_COL_FSET |= KB_Col_MASK
#define KB_Clr_Col()      KB_COL_FCLR |= KB_Col_MASK
#define KB_Set_Row()      KB_ROW_FSET |= KB_Row_MASK
#define KB_Clr_Row()      KB_ROW_FCLR |= KB_Row_MASK
/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
#endif