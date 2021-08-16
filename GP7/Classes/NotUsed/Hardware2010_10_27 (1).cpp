#include "hardWare.h"
#include "RTOS.h"
#include "BSP.h"
#include "utility.h"

/*****************************************************************************/
Hardware::Hardware()
{
}
/*****************************************************************************/
Hardware::~Hardware()
{
}
/*****************************************************************************/
/*PINFUNC*********************************************************************/
/*****************************************************************************/
void Hardware::InitPinFunction(void)
{
/*********************************************************************
*   Unused Pins
*   
*   P0.29
*   P1.18
*   P1.19
*   P1.22
*   P2.9
*   P4.30
*********************************************************************/
  PINSEL1_bit.P0_29=0;
  PINSEL3_bit.P1_18=0;
  PINSEL3_bit.P1_19=0;
  PINSEL3_bit.P1_22=0;
  PINSEL4_bit.P2_9=0;
  PINSEL9_bit.P4_30=0;
/*********************************************************************
*   UART0
*   
*   TXD0  P0.2  PINSEL0 01
*   RXD0  P0.3  PINSEL0 01
*********************************************************************/
  PINSEL0_bit.P0_2=1;
  PINSEL0_bit.P0_3=1;
/*********************************************************************
*   UART1
*   
*   TXD1  P2.0  PINSEL4 10
*   RXD1  P2.1  PINSEL4 10
*   CTS1  P2.2  PINSEL4 10
*   DCD1  P2.3  PINSEL4 10
*   DSR1  P2.4  PINSEL4 10
*   DTR1  P2.5  PINSEL4 10
*   RI1   P2.6  PINSEL4 10
*   RTS1  P2.7  PINSEL4 10
*********************************************************************/
  PINSEL4_bit.P2_0=2;
  PINSEL4_bit.P2_1=2;
  PINSEL4_bit.P2_2=2;
  PINSEL4_bit.P2_3=2;
  PINSEL4_bit.P2_4=2;
  PINSEL4_bit.P2_5=2;
  PINSEL4_bit.P2_6=2;
  PINSEL4_bit.P2_7=2;
/*********************************************************************
*   UART2
*   
*   TXD2  P0.10 PINSEL0 01
*   RXD2  P0.11 PINSEL0 01
*********************************************************************/
  PINSEL0_bit.P0_10=1;
  PINSEL0_bit.P0_11=1;
/*********************************************************************
*   UART3
*   
*   TXD3  P4.28 PINSEL9 11
*   RXD3  P4.29 PINSEL9 11
*********************************************************************/
  PINSEL9_bit.P4_28=3;
  PINSEL9_bit.P4_29=3;
/*********************************************************************
*   GPIO
*   
*   GPIO.2  P1.25 PINSEL3 00
*   GPIO.3  P1.26 PINSEL3 00
*   GPIO.4  P1.27 PINSEL3 00
*   GPIO.5  P1.28 PINSEL3 00
*   GPIO.6  P1.29 PINSEL3 00
*   GPIO.7  P3.23 PINSEL7 00
*   GPIO.8  P3.24 PINSEL7 00
*   GPIO.9  P3.25 PINSEL7 00
*********************************************************************/
  PINSEL3_bit.P1_25=0;
  PINSEL3_bit.P1_26=0;
  PINSEL3_bit.P1_27=0;
  PINSEL3_bit.P1_28=0;
  PINSEL3_bit.P1_29=0;
  PINSEL7_bit.P3_23=0;
  PINSEL7_bit.P3_24=0;
  PINSEL7_bit.P3_25=0;
/*********************************************************************
*   Interrupt
*   
*   INT.0  P0.23 PINSEL1 00
*   INT.1  P1.24 PINSEL1 00
*   INT.2  P0.25 PINSEL1 00
*   INT.3  P0.12 PINSEL0 00
*********************************************************************/
  PINSEL1_bit.P0_23=0;
  PINSEL1_bit.P0_24=0;
  PINSEL1_bit.P0_25=0;
  PINSEL0_bit.P0_12=0;
/*********************************************************************
*   I2C
*   
*   SDA0  P0.27 PINSEL1 01
*   SCL0  P0.28 PINSEL1 01
*********************************************************************/
  PINSEL1_bit.P0_27=1;
  PINSEL1_bit.P0_28=1;
/*********************************************************************
*   SPI
*   
*   SCK   P0.15 PINSEL0 11
*   SSEL  P0.16 PINSEL1 11
*   MISO  P0.17 PINSEL1 11
*   MOSI  P0.18 PINSEL1 11
*********************************************************************/
  PINSEL0_bit.P0_15=3;
  PINSEL1_bit.P0_16=3;
  PINSEL1_bit.P0_17=3;
  PINSEL1_bit.P0_18=3;
/*********************************************************************
*   SSP0
*   
*   SCK0    P1.20 PINSEL3 11
*   SSEL0   P1.21 PINSEL3 11
*   MISO0   P1.23 PINSEL3 11
*   MOSI0   P1.24 PINSEL3 11
*   CP_ISP  P0.0  PINSEL0 00
*********************************************************************/
  PINSEL3_bit.P1_20=3;
  PINSEL3_bit.P1_21=3;
  PINSEL3_bit.P1_23=3;
  PINSEL3_bit.P1_24=3;
  PINSEL0_bit.P0_0=0;
/*********************************************************************
*   DAC
*   
*   AOUT  P0.26 PINSEL1 10
*********************************************************************/
  PINSEL1_bit.P0_26=2;
/*********************************************************************
*   ADC
*   
*   AD0.5 P1.31 PINSEL3 11
*********************************************************************/
  PINSEL3_bit.P1_31=3;
/*********************************************************************
*   USB
*   
*   USB_D+2     P0.31 PINSEL1 01
*   USB_D-2     Pin37 ------- --
*   USB_UP_LED2 P0.13 PINSEL0 01
*   USB_CONNEC  P0.14 PINSEL0 10
*   VBUS        P1.30 PINSEL3 10
*********************************************************************/
  PINSEL1_bit.P0_31=1;
  PINSEL0_bit.P0_13=1;
  PINSEL0_bit.P0_14=2;
  PINSEL3_bit.P1_30=2;
/*********************************************************************
*   MCI
*   
*   MCICLK  P0.19 PINSEL1 10
*   MCICMD  P0.20 PINSEL1 10
*   MCIPWR  P0.21 PINSEL1 10
*   MCIDAT0 P0.22 PINSEL1 10
*   MCIDAT1 P2.11 PINSEL4 10
*   MCIDAT2 P2.12 PINSEL4 10
*   MCIDAT3 P2.13 PINSEL4 10
*   CP      P0.1  PINSEL0 00
*********************************************************************/
  PINSEL1_bit.P0_19=2;
  PINSEL1_bit.P0_20=2;
  PINSEL1_bit.P0_21=2;
  PINSEL1_bit.P0_22=2;
  PINSEL4_bit.P2_11=2;
  PINSEL4_bit.P2_12=2;
  PINSEL4_bit.P2_13=2;
  PINSEL0_bit.P0_1=0;
/*********************************************************************
*   ETHERNET
*   
*   ENET_TXD0     P1.0  PINSEL2 01
*   ENET_TXD1     P1.1  PINSEL2 01
*   ENET_TX_EN    P1.4  PINSEL2 01
*   ENET_CRS      P1.8  PINSEL2 01
*   ENET_RXD0     P1.9  PINSEL2 01
*   ENET_RXD1     P1.10 PINSEL2 01
*   ENET_RX_ER    P1.14 PINSEL2 01
*   ENET_REF_CLK  P1.15 PINSEL2 01
*   ENET_MDC      P1.16 PINSEL3 01
*   ENET_MDIO     P1.17 PINSEL3 01
*   PHY_INT       P0.30 PINSEL1 00
*********************************************************************/
  PINSEL2_bit.P1_0=1;
  PINSEL2_bit.P1_1=1;
  PINSEL2_bit.P1_4=1;
  PINSEL2_bit.P1_8=1;
  PINSEL2_bit.P1_9=1;
  PINSEL2_bit.P1_10=1;
  PINSEL2_bit.P1_14=1;
  PINSEL2_bit.P1_15=1;
  PINSEL3_bit.P1_16=1;
  PINSEL3_bit.P1_17=1;
  PINSEL1_bit.P0_30=0;
/*********************************************************************
*   KEYBOARD
*   
*   ROW0          P4.14 PINSEL8 00
*   ROW1          P4.15 PINSEL8 00
*   ROW2          P4.24 PINSEL9 00
*   ROW3          P4.25 PINSEL9 00
*   COL0          P0.6  PINSEL0 00
*   COL1          P0.7  PINSEL0 00
*   COL2          P0.8  PINSEL0 00
*   COL3          P0.9  PINSEL0 00
*********************************************************************/
  PINSEL8_bit.P4_14=0;
  PINSEL8_bit.P4_15=0;
  PINSEL9_bit.P4_24=0;
  PINSEL9_bit.P4_25=0;
  PINSEL0_bit.P0_6=0;
  PINSEL0_bit.P0_7=0;
  PINSEL0_bit.P0_8=0;
  PINSEL0_bit.P0_9=0;
/*********************************************************************
*   LCD
*   
*   DB0 P4.0  PINSEL8 00
*   DB0 P4.1  PINSEL8 00
*   DB0 P4.2  PINSEL8 00
*   DB0 P4.3  PINSEL8 00
*   DB0 P4.4  PINSEL8 00
*   DB0 P4.5  PINSEL8 00
*   DB0 P4.6  PINSEL8 00
*   DB0 P4.7  PINSEL8 00
*  
*   E   P4.8  PINSEL8 00
*   DI  P4.9  PINSEL8 00
*   RW  P4.10 PINSEL8 00
*   RST P4.11 PINSEL8 00
*   CS1 P4.12 PINSEL8 00
*   CS2 P4.13 PINSEL8 00
  
*   BL  P3.26 PINSEL7 00  GPIO
*********************************************************************/
  PINSEL8_bit.P4_0=0;
  PINSEL8_bit.P4_1=0;
  PINSEL8_bit.P4_2=0;
  PINSEL8_bit.P4_3=0;
  PINSEL8_bit.P4_4=0;
  PINSEL8_bit.P4_5=0;
  PINSEL8_bit.P4_6=0;
  PINSEL8_bit.P4_7=0;
  PINSEL8_bit.P4_8=0;
  PINSEL8_bit.P4_9=0;
  PINSEL8_bit.P4_10=0;
  PINSEL8_bit.P4_11=0;
  PINSEL8_bit.P4_12=0;
  PINSEL8_bit.P4_13=0;
  PINSEL7_bit.P3_26=0;
/*********************************************************************
*   LED
*   
*   LED.0 P3.0  PINSEL6 00
*   LED.1 P3.1  PINSEL6 00
*   LED.2 P3.2  PINSEL6 00
*   LED.3 P3.3  PINSEL6 00
*   LED.4 P3.4  PINSEL6 00
*   LED.5 P3.5  PINSEL6 00
*   LED.6 P3.6  PINSEL6 00
*   LED.7 P3.7  PINSEL6 00
*********************************************************************/
  PINSEL6_bit.P3_0=0;
  PINSEL6_bit.P3_1=0;
  PINSEL6_bit.P3_2=0;
  PINSEL6_bit.P3_3=0;
  PINSEL6_bit.P3_4=0;
  PINSEL6_bit.P3_5=0;
  PINSEL6_bit.P3_6=0;
  PINSEL6_bit.P3_7=0;
/*********************************************************************
*   Wiegand
*   
*   WD0 P0.4  PINSEL0 00
*   WD1 P0.5  PINSEL0 00
*********************************************************************/
  PINSEL0_bit.P0_5=0;
  PINSEL0_bit.P0_6=0;
/*********************************************************************
*   Buzzer
*   
*   BUZ P4.31 PINSEL9 00
*********************************************************************/
  PINSEL9_bit.P4_31=0;
}
/*****************************************************************************/
void Hardware::Init(void)
{
  PCONP_bit.PCUART0=0;      //must be defined in a function
  PCONP_bit.PCUART1=0;      //---
  
  PINSEL0_bit.P0_13=0;
  //PINSEL0_bit.P0_14=0;
  USB_LINK_LED_FDIR |= USB_LINK_LED_MASK;
  USB_LINK_LED_FSET |= USB_LINK_LED_MASK;
  USB_CONN_LED_FDIR |= USB_CONN_LED_MASK;
  USB_CONN_LED_FCLR |= USB_CONN_LED_MASK;
  // Enable Fast GPIO0,1
  SCS_bit.GPIOM = 1;
  FIO3DIR |= 0x000000FF;
  FIO3SET |= 0x000000FF;
  BuzzerOFF();
}
/*****************************************************************************/
/*DAC*************************************************************************/
/*****************************************************************************/
void Hardware::InitDAC(void)
{                             /* setup the related pin to DAC output */
  //PINSEL1_bit.P0_26 = 2;      /* set p0.26 to DAC output */
  T1MR0 = Fpclk/100000 - 1;   /* 57600000/2/100000 = 288 for 10 us*/
  T1MCR = 3;                  /* Interrupt and Reset on MR0 */
}
/*****************************************************************************/
void Hardware::DispatchDAC(WORD data_in)
{
  DWORD data = data_in & 0x000003FF;
  DACR = (data << 6) | 0x00010000;
}
/*****************************************************************************/
void Hardware::StartDACTimer(void)
{
  T1TCR = 1;
}
/*****************************************************************************/
void Hardware::StopDACTimer(void)
{
  T1TCR = 0;
}
/*****************************************************************************/
void Hardware::SetDACTimerPeriod(DWORD Period)  // 10micro second
{
  if(Period > 12000000)
    Period = 12000000;
  T1MR0 = (Fpclk/100000)*Period - 1;
}
/*****************************************************************************/
void Hardware::SetDACTimerEvent(void (*HandlerAddr)())
{
  OS_ARM_InstallISRHandler(TIMER1_INT,HandlerAddr); 
  OS_ARM_ISRSetPrio(TIMER1_INT, HIGHEST_PRIORITY);
  OS_ARM_EnableISR(TIMER1_INT);
}
/*****************************************************************************/
void Hardware::DACTimerReTrig(void)
{
  T1IR = 1;
}
/*****************************************************************************/
/*UART0***********************************************************************/
/*****************************************************************************/
void Hardware::UART0Init(void)
{
  //PINSEL0_bit.P0_2=1;
  //PINSEL0_bit.P0_3=1;  
  PCONP_bit.PCUART0 = 1; // Enable UART0 clk
  
  U0LCR |= 0x80;
  U0FCR = 0x07;   /* Enable and reset TX and RX FIFO. */
  //U0FCR = 0xC7;   /* Enable and reset TX and RX FIFO. Trigger level3 (14chars)*/
  U0LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART0SetBaud(Baudrate baudrate)
{    
  DWORD Fdiv,baud;
  switch (baudrate) 
  {
    case B110     : baud = 110;     break;
    case B300     : baud = 300;     break;
    case B1200    : baud = 1200;    break;
    case B2400    : baud = 2400;    break;
    case B4800    : baud = 4800;    break;
    case B9600    : baud = 9600;    break;
    case B19200   : baud = 19200;   break;
    case B38400   : baud = 38400;   break;
    case B57600   : baud = 57600;   break;
    case B115200  : baud = 115200;  break;
    case B230400  : baud = 230400;  break;
    case B460800  : baud = 460800;  break;
    case B921600  : baud = 921600;  break;
    default       : baud = 9600;
  }
  U0LCR |= 0x80;
  Fdiv = ( Fpclk / 16 ) / baud ;  /*baud rate */
  U0DLM = Fdiv / 256;
  U0DLL = Fdiv % 256;
  U0LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART0SetParity(Parity parity)
{
  U0LCR |= 0x80;
  U0LCR &= ~(0x38);
  switch (parity)
  {
    case Even           : U0LCR |= 0x18;break;
    case Odd            : U0LCR |= 0x08;break;
    case None           : U0LCR |= 0x00;break;
    case Forced_1_stick : U0LCR |= 0x28;break;
    case Forced_0_stick : U0LCR |= 0x38;break;
    default             : U0LCR |= 0x00;    //no Parity
  }
  U0LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART0SetLength(UART_Character_Length bits)
{
  U0LCR |= 0x80;
  U0LCR &= ~(0x03);
  switch (bits)
  {
    case B5 : U0LCR |= 0x00;break;
    case B6 : U0LCR |= 0x01;break;
    case B7 : U0LCR |= 0x02;break;
    case B8 : U0LCR |= 0x03;break;
    default : U0LCR |= 0x03;    //8 bits
  }
  U0LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART0SetStop(StopBits stop)
{
  U0LCR |= 0x80;
  U0LCR &= ~(0x04);
  switch (stop)
  {
    case One : U0LCR |= 0x00;break;
    case Two : U0LCR |= 0x04;break;
    default  : U0LCR |= 0x00;    //1 Stop bit
  }
  U0LCR &= ~(0x80);
}
/*****************************************************************************/
BOOL Hardware::UART0SendReady (void)
{
  return U0LSR & LSR_THRE;
}
/*****************************************************************************/
void Hardware::UART0SendByte (BYTE data)
{
  while(!UART0SendReady());
  U0THR = data;
}
/*****************************************************************************/
BOOL Hardware::UART0RecvReady (void)
{
  return U0LSR & LSR_RDR;
}
/*****************************************************************************/
BYTE Hardware::UART0RecvByte (void)
{
  return U0RBR;
}
/*****************************************************************************/
void Hardware::UART0SendHex(BYTE data)
{
  BYTE data2;
  data2 = (data & 0xf0) >>4;
  if(data2 > 9) data2 += '7'; else data2 += '0';
  UART0SendByte(data2);
  data2 = (data & 0xf);
  if(data2 > 9) data2 += '7'; else data2 += '0';
  UART0SendByte(data2);
}
/*****************************************************************************/
void Hardware::UART0SendHex32(DWORD data)
{
  Hardware h;
  UART0SendHex((data>>24)&0xff);
  UART0SendHex((data>>16)&0xff);
  UART0SendHex((data>>8)&0xff);
  UART0SendHex(data&0xff);
}
/*****************************************************************************/
void Hardware::UART0SendStr(BYTE *str)
{
  while(*str)
  {
    while(UART0SendReady())
      UART0SendByte(*str++);
  }
}
/*****************************************************************************/
void Hardware::UART0SetInterrupt(void (*HandlerAddr)(void), DWORD Priority)
{
  OS_ARM_InstallISRHandler(UART0_INT,HandlerAddr); 
  OS_ARM_ISRSetPrio(UART0_INT, Priority);
  OS_ARM_EnableISR(UART0_INT);

  //UART0EnableInterrupt();
}
/*****************************************************************************/
BYTE Hardware::UART0CheckStatus(void)
{
  BYTE IIRValue, LSRValue;
  volatile BYTE Dummy;

  IIRValue = U0IIR;
  IIRValue >>= 1;     /* skip pending bit in IIR */
  IIRValue &= 0x07;     /* check bit 1~3, interrupt identification */
  if ( IIRValue == IIR_RLS )    /* Receive Line Status */
  {
    LSRValue = U0LSR;
    /* Receive Line Status */
    if ( LSRValue & (LSR_OE|LSR_PE|LSR_FE|LSR_RXFE|LSR_BI) )
    {
      /* There are errors or break interrupt */
      /* Read LSR will clear the interrupt */
      Dummy = LSRValue;
      Dummy = U0RBR;    /* Dummy read on RX to clear interrupt, then bail out */
      return UART_ERROR;
    }
    if ( LSRValue & LSR_RDR ) /* Receive Data Ready */
    {
      /* If no error on RLS, normal ready, save into the data buffer. */
      /* Note: read RBR will clear the interrupt */
      return UART_RECV_RDR;
    }
  }
    
  else if ( IIRValue == IIR_RDA ) /* Receive Data Available */
  {/* Receive Data Available */
    return UART_RECV_RDA;
  }
  else if ( IIRValue == IIR_CTI ) /* Character timeout indicator */
  {
    /* Character Time-out indicator */
    return UART_Time_out; /* CTI error */
  }
  else if ( IIRValue == IIR_THRE )  /* THRE, transmit holding register empty */
  {
    /* THRE interrupt */
    LSRValue = U0LSR; /* Check status in the LSR to see if valid data in U0THR or not */
    if ( LSRValue & LSR_THRE )
    {
      return UART_SEND_READY;
    }
    else
    {
      return UART_SEND_BUSY;
    }
  }
  LSRValue = U0LSR;
  if ( LSRValue & LSR_RDR ) /* Receive Data Ready */
    {
      /* If no error on RLS, normal ready, save into the data buffer. */
      /* Note: read RBR will clear the interrupt */
      return UART_RECV_RDR;
    }
  return UART_UNKNOWN;
}
/*****************************************************************************/
void Hardware::UART0EnableInterrupt(void)
{
  U0IER = IER_THRE | IER_RLS | IER_RBR;
}
/*****************************************************************************/
void Hardware::UART0DisableInterrupt(void)
{
  U0IER = IER_THRE | IER_RLS;
}
/*****************************************************************************/
/*UART2***********************************************************************/
/*****************************************************************************/
void Hardware::UART2Init(void)
{
  //PINSEL0_bit.P0_10=1;
  //PINSEL0_bit.P0_11=1;
  
  PCONP_bit.PCUART2 = 1; // Enable UART2 clk
  
  U2LCR |= 0x80;
  U2FCR = 0x07;   /* Enable and reset TX and RX FIFO. */
  //U2FCR = 0xC7;   /* Enable and reset TX and RX FIFO. Trigger level3 (14chars)*/
  U2LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART2SetBaud(Baudrate baudrate)
{    
  DWORD Fdiv,baud;
  switch (baudrate) 
  {
    case B110     : baud = 110;     break;
    case B300     : baud = 300;     break;
    case B1200    : baud = 1200;    break;
    case B2400    : baud = 2400;    break;
    case B4800    : baud = 4800;    break;
    case B9600    : baud = 9600;    break;
    case B19200   : baud = 19200;   break;
    case B38400   : baud = 38400;   break;
    case B57600   : baud = 57600;   break;
    case B115200  : baud = 115200;  break;
    case B230400  : baud = 230400;  break;
    case B460800  : baud = 460800;  break;
    case B921600  : baud = 921600;  break;
    default       : baud = 9600;
  }
  U2LCR |= 0x80;
  Fdiv = ( Fpclk / 16 ) / baud ;  /*baud rate */
  U2DLM = Fdiv / 256;
  U2DLL = Fdiv % 256;
  U2LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART2SetParity(Parity parity)
{
  U2LCR |= 0x80;
  U2LCR &= ~(0x38);
  switch (parity)
  {
    case Even           : U2LCR |= 0x18;break;
    case Odd            : U2LCR |= 0x08;break;
    case None           : U2LCR |= 0x00;break;
    case Forced_1_stick : U2LCR |= 0x28;break;
    case Forced_0_stick : U2LCR |= 0x38;break;
    default             : U2LCR |= 0x00;    //no Parity
  }
  U2LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART2SetLength(UART_Character_Length bits)
{
  U2LCR |= 0x80;
  U2LCR &= ~(0x03);
  switch (bits)
  {
    case B5 : U2LCR |= 0x00;break;
    case B6 : U2LCR |= 0x01;break;
    case B7 : U2LCR |= 0x02;break;
    case B8 : U2LCR |= 0x03;break;
    default : U2LCR |= 0x03;    //8 bits
  }
  U2LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART2SetStop(StopBits stop)
{
  U2LCR |= 0x80;
  U2LCR &= ~(0x04);
  switch (stop)
  {
    case One : U2LCR |= 0x00;break;
    case Two : U2LCR |= 0x04;break;
    default  : U2LCR |= 0x00;    //1 Stop bit
  }
  U2LCR &= ~(0x80);
}
/*****************************************************************************/
BOOL Hardware::UART2SendReady (void)
{
  return U2LSR & LSR_THRE;
}
/*****************************************************************************/
void Hardware::UART2SendByte (BYTE data)
{
  while(!UART2SendReady());
  U2THR = data;
}
/*****************************************************************************/
BOOL Hardware::UART2RecvReady (void)
{
  return U2LSR & LSR_RDR;
}
/*****************************************************************************/
BYTE Hardware::UART2RecvByte (void)
{
  return U2RBR;
}
/*****************************************************************************/
void Hardware::UART2SendHex(BYTE data)
{
  BYTE data2;
  data2 = (data & 0xf0) >>4;
  if(data2 > 9) data2 += '7'; else data2 += '0';
  UART2SendByte(data2);
  data2 = (data & 0xf);
  if(data2 > 9) data2 += '7'; else data2 += '0';
  UART2SendByte(data2);
}
/*****************************************************************************/
void Hardware::UART2SendStr(BYTE *str)
{
  while(*str)
  {
    UART2SendByte(*str++);
  }
}
/*****************************************************************************/
void Hardware::UART2SetInterrupt(void (*HandlerAddr)(void), DWORD Priority)
{
  OS_ARM_InstallISRHandler(UART2_INT,HandlerAddr); 
  OS_ARM_ISRSetPrio(UART2_INT, Priority);
  OS_ARM_EnableISR(UART2_INT);

  //UART2EnableInterrupt();
}
/*****************************************************************************/
BYTE Hardware::UART2CheckStatus(void)
{
  BYTE IIRValue, LSRValue;
  volatile BYTE Dummy;

  IIRValue = U2IIR;
  IIRValue >>= 1;     /* skip pending bit in IIR */
  IIRValue &= 0x07;     /* check bit 1~3, interrupt identification */
  if ( IIRValue == IIR_RLS )    /* Receive Line Status */
  {
    LSRValue = U2LSR;
    /* Receive Line Status */
    if ( LSRValue & (LSR_OE|LSR_PE|LSR_FE|LSR_RXFE|LSR_BI) )
    {
      /* There are errors or break interrupt */
      /* Read LSR will clear the interrupt */
      Dummy = LSRValue;
      Dummy = U2RBR;    /* Dummy read on RX to clear interrupt, then bail out */
      VICADDRESS = 0; /* Acknowledge Interrupt */
      return UART_ERROR;
    }
    if ( LSRValue & LSR_RDR ) /* Receive Data Ready */
    {
      /* If no error on RLS, normal ready, save into the data buffer. */
      /* Note: read RBR will clear the interrupt */
      return UART_RECV_RDR;
    }
  }
  else if ( IIRValue == IIR_RDA ) /* Receive Data Available */
  {
    /* Receive Data Available */
    return UART_RECV_RDA;
  }
  else if ( IIRValue == IIR_CTI ) /* Character timeout indicator */
  {
    /* Character Time-out indicator */
    return UART_Time_out; /* CTI error */
  }
  else if ( IIRValue == IIR_THRE )  /* THRE, transmit holding register empty */
  {
    /* THRE interrupt */
    LSRValue = U2LSR; /* Check status in the LSR to see if valid data in U0THR or not */
    if ( LSRValue & LSR_THRE )
    {
      return UART_SEND_READY;
    }
    else
    {
      return UART_SEND_BUSY;
    }
  }
  LSRValue = U2LSR;
  if ( LSRValue & LSR_RDR ) /* Receive Data Ready */
    {
      /* If no error on RLS, normal ready, save into the data buffer. */
      /* Note: read RBR will clear the interrupt */
      return UART_RECV_RDR;
    }
  return UART_UNKNOWN;
}
/*****************************************************************************/
void Hardware::UART2EnableInterrupt(void)
{
  U2IER = IER_THRE | IER_RLS | IER_RBR;
}
/*****************************************************************************/
void Hardware::UART2DisableInterrupt(void)
{
  U2IER = IER_THRE | IER_RLS;
}
/*****************************************************************************/
/*UART3***********************************************************************/
/*****************************************************************************/
void Hardware::UART3Init(void)
{
  //PINSEL9_bit.P4_28=3;
  //PINSEL9_bit.P4_29=3;
  
  PCONP_bit.PCUART3 = 1; // Enable UART3 clk
  
  U3LCR |= 0x80;
  U3FCR = 0x07;   /* Enable and reset TX and RX FIFO. */
  //U3FCR = 0xC7;   /* Enable and reset TX and RX FIFO. Trigger level3 (14chars)*/
  U3LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART3SetBaud(Baudrate baudrate)
{    
  DWORD Fdiv,baud;
  switch (baudrate) 
  {
    case B110     : baud = 110;     break;
    case B300     : baud = 300;     break;
    case B1200    : baud = 1200;    break;
    case B2400    : baud = 2400;    break;
    case B4800    : baud = 4800;    break;
    case B9600    : baud = 9600;    break;
    case B19200   : baud = 19200;   break;
    case B38400   : baud = 38400;   break;
    case B57600   : baud = 57600;   break;
    case B115200  : baud = 115200;  break;
    case B230400  : baud = 230400;  break;
    case B460800  : baud = 460800;  break;
    case B921600  : baud = 921600;  break;
    default       : baud = 9600;
  }
  U3LCR |= 0x80;
  Fdiv = ( Fpclk / 16 ) / baud ;  /*baud rate */
  U3DLM = Fdiv / 256;
  U3DLL = Fdiv % 256;
  U3LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART3SetParity(Parity parity)
{
  U3LCR |= 0x80;
  U3LCR &= ~(0x38);
  switch (parity)
  {
    case Even           : U3LCR |= 0x18;break;
    case Odd            : U3LCR |= 0x08;break;
    case None           : U3LCR |= 0x00;break;
    case Forced_1_stick : U3LCR |= 0x28;break;
    case Forced_0_stick : U3LCR |= 0x38;break;
    default             : U3LCR |= 0x00;    //no Parity
  }
  U3LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART3SetLength(UART_Character_Length bits)
{
  U3LCR |= 0x80;
  U3LCR &= ~(0x03);
  switch (bits)
  {
    case B5 : U3LCR |= 0x00;break;
    case B6 : U3LCR |= 0x01;break;
    case B7 : U3LCR |= 0x02;break;
    case B8 : U3LCR |= 0x03;break;
    default : U3LCR |= 0x03;    //8 bits
  }
  U3LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART3SetStop(StopBits stop)
{
  U3LCR |= 0x80;
  U3LCR &= ~(0x04);
  switch (stop)
  {
    case One : U3LCR |= 0x00;break;
    case Two : U3LCR |= 0x04;break;
    default  : U3LCR |= 0x00;    //1 Stop bit
  }
  U3LCR &= ~(0x80);
}
/*****************************************************************************/
BOOL Hardware::UART3SendReady (void)
{
  return U3LSR & LSR_THRE;
}
/*****************************************************************************/
void Hardware::UART3SendByte (BYTE data)
{
  while(!UART3SendReady());
  U3THR = data;
}
/*****************************************************************************/
BOOL Hardware::UART3RecvReady (void)
{
  return U3LSR & LSR_RDR;
}
/*****************************************************************************/
BYTE Hardware::UART3RecvByte (void)
{
  return U3RBR;
}
/*****************************************************************************/
void Hardware::UART3SendHex(BYTE data)
{
  BYTE data2;
  data2 = (data & 0xf0) >>4;
  if(data2 > 9) data2 += '7'; else data2 += '0';
  UART3SendByte(data2);
  data2 = (data & 0xf);
  if(data2 > 9) data2 += '7'; else data2 += '0';
  UART3SendByte(data2);
}
/*****************************************************************************/
void Hardware::UART3SendStr(BYTE *str)
{
  while(*str)
  {
    UART3SendByte(*str++);
  }
}
/*****************************************************************************/
void Hardware::UART3SetInterrupt(void (*HandlerAddr)(void), DWORD Priority)
{
  OS_ARM_InstallISRHandler(UART3_INT,HandlerAddr); 
  OS_ARM_ISRSetPrio(UART3_INT, Priority);
  OS_ARM_EnableISR(UART3_INT);

  //UART3EnableInterrupt();
}
/*****************************************************************************/
BYTE Hardware::UART3CheckStatus(void)
{
  BYTE IIRValue, LSRValue;
  volatile BYTE Dummy;

  IIRValue = U3IIR;
  IIRValue >>= 1;     /* skip pending bit in IIR */
  IIRValue &= 0x07;     /* check bit 1~3, interrupt identification */
  if ( IIRValue == IIR_RLS )    /* Receive Line Status */
  {
    LSRValue = U3LSR;
    /* Receive Line Status */
    if ( LSRValue & (LSR_OE|LSR_PE|LSR_FE|LSR_RXFE|LSR_BI) )
    {
      /* There are errors or break interrupt */
      /* Read LSR will clear the interrupt */
      Dummy = LSRValue;
      Dummy = U3RBR;    /* Dummy read on RX to clear interrupt, then bail out */
      VICADDRESS = 0; /* Acknowledge Interrupt */
      return UART_ERROR;
    }
    if ( LSRValue & LSR_RDR ) /* Receive Data Ready */
    {
      /* If no error on RLS, normal ready, save into the data buffer. */
      /* Note: read RBR will clear the interrupt */
      return UART_RECV_RDR;
    }
  }
  else if ( IIRValue == IIR_RDA ) /* Receive Data Available */
  {
    /* Receive Data Available */
    return UART_RECV_RDA;
  }
  else if ( IIRValue == IIR_CTI ) /* Character timeout indicator */
  {
    /* Character Time-out indicator */
    return UART_Time_out; /* CTI error */
  }
  else if ( IIRValue == IIR_THRE )  /* THRE, transmit holding register empty */
  {
    /* THRE interrupt */
    LSRValue = U3LSR; /* Check status in the LSR to see if valid data in U0THR or not */
    if ( LSRValue & LSR_THRE )
    {
      return UART_SEND_READY;
    }
    else
    {
      return UART_SEND_BUSY;
    }
  }
  LSRValue = U3LSR;
  if ( LSRValue & LSR_RDR ) /* Receive Data Ready */
    {
      /* If no error on RLS, normal ready, save into the data buffer. */
      /* Note: read RBR will clear the interrupt */
      return UART_RECV_RDR;
    }
  return UART_UNKNOWN;
}
/*****************************************************************************/
void Hardware::UART3EnableInterrupt(void)
{
  U3IER = IER_THRE | IER_RLS | IER_RBR;
}
/*****************************************************************************/
void Hardware::UART3DisableInterrupt(void)
{
  U3IER = IER_THRE | IER_RLS;
}
/*****************************************************************************/
/*UART1***********************************************************************/
/*****************************************************************************/
void Hardware::UART1Init(void)
{
  //PINSEL4_bit.P2_0=2;
  //PINSEL4_bit.P2_1=2;
  PCONP_bit.PCUART1 = 1; // Enable UART1 clk
  
  U1LCR |= 0x80;
  //U1FCR = 0x07;   /* Enable and reset TX and RX FIFO. */
  U1FCR = 0xC7;   /* Enable and reset TX and RX FIFO. Trigger level3 (14chars)*/
  U1LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART1SetBaud(Baudrate baudrate)
{    
  DWORD Fdiv,baud;
  switch (baudrate) 
  {
    case B110     : baud = 110;     break;
    case B300     : baud = 300;     break;
    case B1200    : baud = 1200;    break;
    case B2400    : baud = 2400;    break;
    case B4800    : baud = 4800;    break;
    case B9600    : baud = 9600;    break;
    case B19200   : baud = 19200;   break;
    case B38400   : baud = 38400;   break;
    case B57600   : baud = 57600;   break;
    case B115200  : baud = 115200;  break;
    case B230400  : baud = 230400;  break;
    case B460800  : baud = 460800;  break;
    case B921600  : baud = 921600;  break;
    default       : baud = 9600;
  }
  U1LCR |= 0x80;
  Fdiv = ( Fpclk / 16 ) / baud ;  /*baud rate */
  U1DLM = Fdiv / 256;
  U1DLL = Fdiv % 256;
  U1LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART1SetParity(Parity parity)
{
  U1LCR |= 0x80;
  U1LCR &= ~(0x38);
  switch (parity)
  {
    case Even           : U1LCR |= 0x18;break;
    case Odd            : U1LCR |= 0x08;break;
    case None           : U1LCR |= 0x00;break;
    case Forced_1_stick : U1LCR |= 0x28;break;
    case Forced_0_stick : U1LCR |= 0x38;break;
    default             : U1LCR |= 0x00;    //no Parity
  }
  U1LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART1SetLength(UART_Character_Length bits)
{
  U1LCR |= 0x80;
  U1LCR &= ~(0x03);
  switch (bits)
  {
    case B5 : U1LCR |= 0x00;break;
    case B6 : U1LCR |= 0x01;break;
    case B7 : U1LCR |= 0x02;break;
    case B8 : U1LCR |= 0x03;break;
    default : U1LCR |= 0x03;    //8 bits
  }
  U1LCR &= ~(0x80);
}
/*****************************************************************************/
void Hardware::UART1SetStop(StopBits stop)
{
  U1LCR |= 0x80;
  U1LCR &= ~(0x04);
  switch (stop)
  {
    case One : U1LCR |= 0x00;break;
    case Two : U1LCR |= 0x04;break;
    default  : U1LCR |= 0x00;    //1 Stop bit
  }
  U1LCR &= ~(0x80);
}
/*****************************************************************************/
BOOL Hardware::UART1SendReady (void)
{
  return U1LSR & LSR_THRE;
}
/*****************************************************************************/
void Hardware::UART1SendByte (BYTE data)
{
  while(!UART1SendReady());
  U1THR = data;
}
/*****************************************************************************/
BOOL Hardware::UART1RecvReady (void)
{
  return U1LSR & LSR_RDR;
}
/*****************************************************************************/
BYTE Hardware::UART1RecvByte (void)
{
  return U1RBR;
}
/*****************************************************************************/
void Hardware::UART1SendHex(BYTE data)
{
  BYTE data2;
  data2 = (data & 0xf0) >>4;
  if(data2 > 9) data2 += '7'; else data2 += '0';
  UART1SendByte(data2);
  data2 = (data & 0xf);
  if(data2 > 9) data2 += '7'; else data2 += '0';
  UART1SendByte(data2);
}
/*****************************************************************************/
void Hardware::UART1SendStr(BYTE *str)
{
  while(*str)
  {
    UART1SendByte(*str++);
  }
}
/*****************************************************************************/
void Hardware::UART1SetInterrupt(void (*HandlerAddr)(void), DWORD Priority)
{
  OS_ARM_InstallISRHandler(UART1_INT,HandlerAddr); 
  OS_ARM_ISRSetPrio(UART1_INT, Priority);
  OS_ARM_EnableISR(UART1_INT);

  //UART1EnableInterrupt();
}
/*****************************************************************************/
BYTE Hardware::UART1CheckStatus(void)
{
  BYTE IIRValue, LSRValue;
  volatile BYTE Dummy;

  IIRValue = U1IIR;
  IIRValue >>= 1;     /* skip pending bit in IIR */
  IIRValue &= 0x07;     /* check bit 1~3, interrupt identification */
  if ( IIRValue == IIR_RLS )    /* Receive Line Status */
  {
    LSRValue = U1LSR;
    /* Receive Line Status */
    if ( LSRValue & (LSR_OE|LSR_PE|LSR_FE|LSR_RXFE|LSR_BI) )
    {
      /* There are errors or break interrupt */
      /* Read LSR will clear the interrupt */
      Dummy = LSRValue;
      Dummy = U1RBR;    /* Dummy read on RX to clear interrupt, then bail out */
      return UART_ERROR;
    }
    if ( LSRValue & LSR_RDR ) /* Receive Data Ready */
    {
      /* If no error on RLS, normal ready, save into the data buffer. */
      /* Note: read RBR will clear the interrupt */
      return UART_RECV_RDR;
    }
  }
    
  else if ( IIRValue == IIR_RDA ) /* Receive Data Available */
  {/* Receive Data Available */
    return UART_RECV_RDA;
  }
  else if ( IIRValue == IIR_CTI ) /* Character timeout indicator */
  {
    /* Character Time-out indicator */
    return UART_Time_out; /* CTI error */
  }
  else if ( IIRValue == IIR_THRE )  /* THRE, transmit holding register empty */
  {
    /* THRE interrupt */
    LSRValue = U1LSR; /* Check status in the LSR to see if valid data in U0THR or not */
    if ( LSRValue & LSR_THRE )
    {
      return UART_SEND_READY;
    }
    else
    {
      return UART_SEND_BUSY;
    }
  }
  LSRValue = U1LSR;
  if ( LSRValue & LSR_RDR ) /* Receive Data Ready */
    {
      /* If no error on RLS, normal ready, save into the data buffer. */
      /* Note: read RBR will clear the interrupt */
      return UART_RECV_RDR;
    }
  return UART_UNKNOWN;
}
/*****************************************************************************/
void Hardware::UART1EnableInterrupt(void)
{
  U1IER = IER_THRE | IER_RLS | IER_RBR;
}
/*****************************************************************************/
void Hardware::UART1DisableInterrupt(void)
{
  U1IER = IER_THRE | IER_RLS;
}
/*****************************************************************************/
/*RTC*************************************************************************/
/*****************************************************************************/
void Hardware::RTCInit(void)
{

//  Enable power for RTC
        PCONP |= 0x00000200;
//  Clear RTC interrupt register
        ILR = 0xFF;
//  Dasable all the alrams.
        AMR = 0xFF;
//  Enable only second count interrupt.
//        CIIR = 0x01;            // minute
//  Disable all subsecond interrupts.
        CISS = 0;
//  Enable RTC
        CCR = CCR_CLKSRC;
PREINT = 0;
PREFRAC = 0;

/*
  AMR = 0;
    CIIR = 0;
    CCR = 0;
    PREINT = PREINT_RTC;
    PREFRAC = PREFRAC_RTC;
*/
}
/*****************************************************************************/
void Hardware::RTCSetTime(RTCTime Time)
{
    SEC = Time.RTC_Sec;
    MIN = Time.RTC_Min;
    HOUR = Time.RTC_Hour;
    DOM = Time.RTC_Mday;
    DOW = Time.RTC_Wday;
    DOY = Time.RTC_Yday;
    MONTH = Time.RTC_Mon;
    YEAR = Time.RTC_Year;
}

/*****************************************************************************/
RTCTime Hardware::RTCGetTime(void)
{
    RTCTime LocalTime;

    LocalTime.RTC_Sec = SEC;
    LocalTime.RTC_Min = MIN;
    LocalTime.RTC_Hour = HOUR;
    LocalTime.RTC_Mday = DOM;
    LocalTime.RTC_Wday = DOW;
    LocalTime.RTC_Yday = DOY;
    LocalTime.RTC_Mon = MONTH;
    LocalTime.RTC_Year = YEAR;
    return ( LocalTime );
}
/*****************************************************************************/
void Hardware::RTCStart(void)
{
    CCR |= CCR_CLKEN;
}
/*****************************************************************************/
/*KEYBOARD********************************************************************/
/*****************************************************************************/
void Hardware::InitKeyPins(void)
{
  /*
  PINSEL8_bit.P4_14=0;
  PINSEL8_bit.P4_15=0;
  PINSEL9_bit.P4_24=0;
  PINSEL9_bit.P4_25=0;
  PINSEL0_bit.P0_6=0;
  PINSEL0_bit.P0_7=0;
  PINSEL0_bit.P0_8=0;
  PINSEL0_bit.P0_9=0;
  */
  KB_Col_In();
  KB_Row_Out();
  KB_Clr_Row();
  FIO4MASK &= ~KB_Row_MASK;
  FIO0MASK &= ~KB_Col_MASK;
  KB_COL_IntE = KB_Col_MASK;        /* interrupt by falling edge. */
}
/*****************************************************************************/
void Hardware::SetPinsInterrupt (void (*HandlerAddr)(void))
{
  OS_ARM_InstallISRHandler(EINT3_INT,HandlerAddr); 
  OS_ARM_ISRSetPrio(EINT3_INT, LOWEST_PRIORITY);
  OS_ARM_EnableISR(EINT3_INT);
}
/*****************************************************************************/
BYTE Hardware::GetPhysicalKey(void)
{
  Utility u;
  BYTE Key;//COL-ROW pressed key => 1
  DWORD port_r,port_c;
  Key=0;
  
  u.Delay_ms(1);
  port_c = KB_COL_FIO;
  u.Delay_ms(1);
  KB_Row_In();
  KB_Col_Out();
  KB_Clr_Col();
  
  u.Delay_ms(1);
  port_r = KB_ROW_FIO;
  u.Delay_ms(1);
  KB_Row_Out();
  KB_Clr_Row();
  KB_Col_In();
  u.Delay_ms(1);
  if(port_r & KB_Row_0)
    Key |= 0x01;
  if(port_r & KB_Row_1)
    Key |= 0x02;
  if(port_r & KB_Row_2)
    Key |= 0x04;
  if(port_r & KB_Row_3)
    Key |= 0x08;
  
  if(port_c & KB_Col_0)
    Key |= 0x10;
  if(port_c & KB_Col_1)
    Key |= 0x20;
  if(port_c & KB_Col_2)
    Key |= 0x40;
  if(port_c & KB_Col_3)
    Key |= 0x80;
  
  if((!(Key & 0x0F)) || (!(Key & 0xF0)))
    Key=0xFF;
  
  return ~Key;
}
/*****************************************************************************/
void Hardware::EnableKeyInterrupt(void)
{
  OS_ARM_EnableISR(EINT3_INT);
}
/*****************************************************************************/
void Hardware::DisableKeyInterrupt(void)
{
  OS_ARM_DisableISR(EINT3_INT);
}
/*****************************************************************************/
void Hardware::KeyClearInterrupt(void)
{
  IO0INTCLR |= KB_Int_MASK;        /* clear interrupt */
}
/*****************************************************************************/
/*LCD*************************************************************************/
/*****************************************************************************/
void Hardware::LCDPortInit(void)
{
  /*
  PINSEL8_bit.P4_0=0;
  PINSEL8_bit.P4_1=0;
  PINSEL8_bit.P4_2=0;
  PINSEL8_bit.P4_3=0;
  PINSEL8_bit.P4_4=0;
  PINSEL8_bit.P4_5=0;
  PINSEL8_bit.P4_6=0;
  PINSEL8_bit.P4_7=0;
  PINSEL8_bit.P4_8=0;
  PINSEL8_bit.P4_9=0;
  PINSEL8_bit.P4_10=0;
  PINSEL8_bit.P4_11=0;
  PINSEL8_bit.P4_12=0;
  PINSEL8_bit.P4_13=0;
  PINSEL7_bit.P3_26=0;
  */
  FIO3DIR |= (1UL<<26); //Backlight Output
  //FIO3SET |= (1UL<<26); //Backlight = 1
  FIO3CLR |= (1UL<<26); //Backlight = 0
  ////////////////////3FFF
  FIO4DIR |= 0x00003FFF;  //Output
  FIO4CLR |= 0x00003FFF;  //Low
}
/*****************************************************************************/
void Hardware::LCDDispatchData(BYTE data)
{
  FIO4CLR |= 0x000000FF;  //Low
  FIO4SET |= (DWORD)data;
}
/*****************************************************************************/
void Hardware::LCDCS1(bool cs1)
{
  if(cs1)
    FIO4SET |= (1UL<<12);
  else
    FIO4CLR |= (1UL<<12);
}
/*****************************************************************************/
void Hardware::LCDCS2(bool cs2)
{
  if(cs2)
    FIO4SET |= (1UL<<13);
  else
    FIO4CLR |= (1UL<<13);
}
/*****************************************************************************/
void Hardware::LCDEnable(bool en)
{
  if(en)
    FIO4SET |= (1UL<<8);
  else
    FIO4CLR |= (1UL<<8);
}
/*****************************************************************************/
void Hardware::LCDDI(bool di)
{
  if(di)
    FIO4SET |= (1UL<<9);
  else
    FIO4CLR |= (1UL<<9);
}
/*****************************************************************************/
void Hardware::LCDReset(bool rst)
{
  if(rst)
    FIO4SET |= (1UL<<11);
  else
    FIO4CLR |= (1UL<<11);
}
/*****************************************************************************/
void Hardware::LCDRW(bool rw)
{
  if(rw)
    FIO4SET |= (1UL<<10);
  else
    FIO4CLR |= (1UL<<10);
}
/*****************************************************************************/
/*PWM*************************************************************************/
/*****************************************************************************/
void Hardware::PWMPortInit(void)
{
  PINSEL7_bit.P3_26=3;      // assign P3.26 to PWM1
  PCONP_bit.PCPWM1 = 1;     // enable clock of PWM1
  PWM1TCR_bit.PWMEN = 0;    // enable PWM function
  PWM1TCR_bit.CE = 0;       // disable counting
  PWM1TCR_bit.CR = 1;       // reset
  PWM1CTCR_bit.CM = 0;      // from prescaler
  PWM1MCR = 2;              // Reset on PWMMR0
  PWM1PCR_bit.PWMSEL3 = 0;  // Selects single edge controlled mode for PWM3
  PWM1PCR_bit.PWMENA3 = 1;  // The PWM3 output enabled
  PWM1PR = 0;
  PWM1MR0 = 0xFF;           // 8bit resolution
  PWM1LER_bit.EM0L = 1;
  PWM1MR3 = 0;
  PWM1LER_bit.EM3L = 1;
  PWM1TCR_bit.PWMEN = 1;    // enable PWM function
  PWM1TCR_bit.CR = 0;       // release reset
  PWM1TCR_bit.CE = 1;       // enable counting
}
/*****************************************************************************/
void Hardware::PWMSetDutyCycle(BYTE DutyCycle)
{
  PWM1MR3 = DutyCycle;
  PWM1LER_bit.EM3L = 1;
}
/*****************************************************************************/
/*LED*************************************************************************/
/*****************************************************************************/
void Hardware::InitLED(void)
{
  FIO3DIR |= 0x000000FF;
}
/*****************************************************************************/
void Hardware::SetLED(BYTE data)
{
  FIO3PIN &= 0;
  FIO3PIN |= ~(data);
}
/*****************************************************************************/
/*Buzzer**********************************************************************/
/*****************************************************************************/
void Hardware::InitBuzzer(void)
{
  FIO4DIR |= 0x80000000;
}
/*****************************************************************************/
void Hardware::BuzzerON(void)
{
  FIO4CLR |= 0x80000000;
}
/*****************************************************************************/
void Hardware::BuzzerOFF(void)
{
  FIO4SET |= 0x80000000;
}
/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/