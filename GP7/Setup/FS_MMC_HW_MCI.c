/*********************************************************************
*  
*   IAR PowerPac
*
*   (c) Copyright IAR Systems 2009.  All rights reserved.
*
**********************************************************************
----------------------------------------------------------------------
----------------------------------------------------------------------
File        : MMC_CM_HW.c
Purpose     : Low level MMC/SD driver for the NXP LPC23xx/24xx
---------------------------END-OF-HEADER------------------------------
*/

/*********************************************************************
*
*       Includes
*
**********************************************************************
*/
#include "FS_Int.h"
#include "MMC_SD_CardMode_X_HW.h"


/*********************************************************************
*
*       Defines configurable
*
**********************************************************************
*/
#define FSYS                 (48000000uL)  /* may depend on PLL            */
#define PCLK_SDCLOCK         (FSYS / 4)    /* defaults to CPU clock / 4    */

/*********************************************************************
*
*       Defines non configurable
*
**********************************************************************
*/
#define MCB2300_VERSION_0                    0
#define MCI_TEMP_BUFFER_ADDR_RX     0x7FD00000  // Used as temporary buffer for receiving data from Card thru DMA
#define MCI_TEMP_BUFFER_ADDR_TX     0x7FD01000  // Used as temporary buffer for sending   data to   Card thru DMA

/*********************************************************************
*
*       Local defines (sfrs)
*
**********************************************************************
*/
#define MCI_BASE_ADDR		0xE008C000
#define MCI_POWER      (*(volatile U32 *)(MCI_BASE_ADDR + 0x00))
#define MCI_CLOCK      (*(volatile U32 *)(MCI_BASE_ADDR + 0x04))
#define MCI_ARGUMENT   (*(volatile U32 *)(MCI_BASE_ADDR + 0x08))
#define MCI_COMMAND    (*(volatile U32 *)(MCI_BASE_ADDR + 0x0C))
#define MCI_RESP_CMD   (*(volatile U32 *)(MCI_BASE_ADDR + 0x10))
#define MCI_RESP0      (*(volatile U32 *)(MCI_BASE_ADDR + 0x14))
#define MCI_RESP1      (*(volatile U32 *)(MCI_BASE_ADDR + 0x18))
#define MCI_RESP2      (*(volatile U32 *)(MCI_BASE_ADDR + 0x1C))
#define MCI_RESP3      (*(volatile U32 *)(MCI_BASE_ADDR + 0x20))
#define MCI_DATA_TMR   (*(volatile U32 *)(MCI_BASE_ADDR + 0x24))
#define MCI_DATA_LEN   (*(volatile U32 *)(MCI_BASE_ADDR + 0x28))
#define MCI_DATA_CTRL  (*(volatile U32 *)(MCI_BASE_ADDR + 0x2C))
#define MCI_DATA_CNT   (*(volatile U32 *)(MCI_BASE_ADDR + 0x30))
#define MCI_STATUS     (*(volatile U32 *)(MCI_BASE_ADDR + 0x34))
#define MCI_CLEAR      (*(volatile U32 *)(MCI_BASE_ADDR + 0x38))
#define MCI_MASK0      (*(volatile U32 *)(MCI_BASE_ADDR + 0x3C))
#define MCI_MASK1      (*(volatile U32 *)(MCI_BASE_ADDR + 0x40))
#define MCI_FIFO_CNT   (*(volatile U32 *)(MCI_BASE_ADDR + 0x48))
#define MCI_FIFO       (*(volatile U32 *)(MCI_BASE_ADDR + 0x80))
#define MCI_FIFO_ADDR  ( (volatile U32 *)(MCI_BASE_ADDR + 0x80))

// System Control Block(SCB)
#define SCB_BASE_ADDR	0xE01FC000
/* Power Control */
#define PCON           (*(volatile U32 *)(SCB_BASE_ADDR + 0x0C0))
#define PCONP          (*(volatile U32 *)(SCB_BASE_ADDR + 0x0C4))
/* Clock Divider */
#define CLKSRCSEL      (*(volatile U32 *)(SCB_BASE_ADDR + 0x10C))
#define PCLKSEL0       (*(volatile U32 *)(SCB_BASE_ADDR + 0x1A8))
#define PCLKSEL1       (*(volatile U32 *)(SCB_BASE_ADDR + 0x1AC))

// General Purpose Input/Output (GPIO)
#define GPIO_BASE_ADDR		0xE0028000
#define IOPIN0         (*(volatile U32 *)(GPIO_BASE_ADDR + 0x00))
#define IOSET0         (*(volatile U32 *)(GPIO_BASE_ADDR + 0x04))
#define IODIR0         (*(volatile U32 *)(GPIO_BASE_ADDR + 0x08))
#define IOCLR0         (*(volatile U32 *)(GPIO_BASE_ADDR + 0x0C))
#define IOPIN1         (*(volatile U32 *)(GPIO_BASE_ADDR + 0x10))
#define IOSET1         (*(volatile U32 *)(GPIO_BASE_ADDR + 0x14))
#define IODIR1         (*(volatile U32 *)(GPIO_BASE_ADDR + 0x18))
#define IOCLR1         (*(volatile U32 *)(GPIO_BASE_ADDR + 0x1C))

// Pin Connect Block
#define PINSEL_BASE_ADDR	0xE002C000
#define PINSEL0        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x00))
#define PINSEL1        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x04))
#define PINSEL2        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x08))
#define PINSEL3        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x0C))
#define PINSEL4        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x10))
#define PINSEL5        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x14))
#define PINSEL6        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x18))
#define PINSEL7        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x1C))
#define PINSEL8        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x20))
#define PINSEL9        (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x24))
#define PINSEL10       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x28))
#define PINSEL11       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x2C))

#define PINMODE0       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x40))
#define PINMODE1       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x44))
#define PINMODE2       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x48))
#define PINMODE3       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x4C))
#define PINMODE4       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x50))
#define PINMODE5       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x54))
#define PINMODE6       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x58))
#define PINMODE7       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x5C))
#define PINMODE8       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x60))
#define PINMODE9       (*(volatile U32 *)(PINSEL_BASE_ADDR + 0x64))

// General-purpose DMA Controller
#define GPDMA_BASE_ADDR   0xFFE04000
#define GPDMA_INT_STAT         (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x000))
#define GPDMA_INT_TCSTAT       (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x004))
#define GPDMA_INT_TCCLR        (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x008))
#define GPDMA_INT_ERR_STAT     (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x00C))
#define GPDMA_INT_ERR_CLR      (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x010))
#define GPDMA_RAW_INT_TCSTAT   (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x014))
#define GPDMA_RAW_INT_ERR_STAT (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x018))
#define GPDMA_ENABLED_CHNS     (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x01C))
#define GPDMA_SOFT_BREQ        (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x020))
#define GPDMA_SOFT_SREQ        (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x024))
#define GPDMA_SOFT_LBREQ       (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x028))
#define GPDMA_SOFT_LSREQ       (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x02C))
#define GPDMA_CONFIG           (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x030))
#define GPDMA_SYNC             (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x034))
#define GPDMA_CH0_SRC          (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x100))
#define GPDMA_CH0_DEST         (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x104))
#define GPDMA_CH0_LLI          (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x108))
#define GPDMA_CH0_CTRL         (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x10C))
#define GPDMA_CH0_CFG          (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x110))
#define GPDMA_CH1_SRC          (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x120))
#define GPDMA_CH1_DEST         (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x124))
#define GPDMA_CH1_LLI          (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x128))
#define GPDMA_CH1_CTRL         (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x12C))
#define GPDMA_CH1_CFG          (*(volatile U32 *)(GPDMA_BASE_ADDR + 0x130))

#define PERIPHAL_TO_MEMORY              0
#define MEMORY_TO_PERIPHAL              1


/*********************************************************************
*
*       Static data
*
**********************************************************************
*/
static U32  _BlockSize;
static char _IgnoreCRC;
static U32  _DataControlReg;
/*********************************************************************
*
*       Static code
*
**********************************************************************
*/

/*********************************************************************
*
*       _Delayus
*/
static void _Delayus(unsigned us) {
  volatile unsigned Time;

  Time = us * 70;
  do {} while(--Time);
}

/*********************************************************************
*
*       _ld
*/
static U16 _ld(U32 Value) {
  U16 i;
  for (i = 0; i < 16; i++) {
    if ((1UL << i) == Value) {
      break;
    }
  }
  return i;
}

/*********************************************************************
*
*       _WriteControlReg
*
*  Function description
*    This fucntion writes the MCI data control registers,
*    and initiates thus the data transfer.
*    The information how to set the register is done in FS_MMC_HW_X_SendCmd().
*/
static void _WriteControlReg(U8 Unit) {
  MCI_DATA_LEN  = _BlockSize;
  MCI_DATA_CTRL = _DataControlReg;
}

/*********************************************************************
*
*       _DMAInit
*
*  Function description
*    Initialize the DMA.
*    This is necessary since data tranfer thru polling does not work correctly.
*/
static void _DMAInit(void) {
  //
  //  Enable GPDMA clock
  //
  PCONP |= (1 << 29);
  //
  //  Clear interrupts on DMA channel 0 and 1
  //
  GPDMA_INT_TCCLR   = 0x03;
  GPDMA_INT_ERR_CLR = 0x03;
  //
  //  Enable DMA controller, AHB Master is little endian
  //
  GPDMA_CONFIG      = 0x01;
  while ((GPDMA_CONFIG & 0x01) == 0);
}

/*********************************************************************
*
*       _DMAStart
*
*  Function description
*    Before starting any data tranfers from or to the card,
*    we need to program the DMA in order to let the DMA do the work for us.
*/
static void _DMAStart(U32 * pDest, U32 * pSrc, U32 NumBytes, U8 Direction) {
  //
  //
  //
  if (Direction == PERIPHAL_TO_MEMORY) {
    GPDMA_CH1_SRC  = (U32)pSrc;
    GPDMA_CH1_DEST = (U32)pDest;
    GPDMA_CH1_CTRL = ((_BlockSize >> 2) & 0x0FFF)
                   | (0x02   << 12)
                   | (0x02   << 15)
                   | (0x02   << 18)
                   | (0x02   << 21)
                   | (0x01   << 27)
                   | (0x01UL << 31);
    GPDMA_CH1_CFG = 0x10001 | (0x04 << 1) | (0x00 << 6) | (0x06 << 11);
  } else {
    GPDMA_CH0_SRC  = (U32)pSrc;
    GPDMA_CH0_DEST = (U32)pDest;
    GPDMA_CH0_CTRL = ((_BlockSize >> 2) & 0x0FFF)
                   | (0x02   << 12)
                   | (0x02   << 15)
                   | (0x02   << 18)
                   | (0x02   << 21)
                   | (0x01   << 26)
                   | (0x01UL << 31);
    GPDMA_CH0_CFG = 0x10001 | (0x00 << 1) | (0x04 << 6) | (0x05 << 11);
  }
}

/*********************************************************************
*
*       Public code
*
**********************************************************************
*/

/*********************************************************************
*
*       FS_MMC_HW_X_SetHWNumBlocks
*
*  Function description
*    Sets the number of block (sectors) to be transferred.
*
*/
void FS_MMC_HW_X_SetHWNumBlocks(U8 Unit, U16 NumBlocks) {
}

/*********************************************************************
*
*       FS_MMC_HW_X_SetHWBlockLen
*
*  Function description
*    Sets the block size (sector size) that shall be transferred.
*/
void FS_MMC_HW_X_SetHWBlockLen(U8 Unit, U16 BlockSize) {
  _BlockSize = BlockSize;
}

/*********************************************************************
*
*       FS_MMC_HW_X_SetMaxSpeed
*
*  Function description
*    Sets the frequency of the MMC/SD card controller.
*    The frequency is given in kHz.
*    It is called 2 times:
*     1. During card initialization
*        Initialize the frequency to not more than 400kHz.
*
*     2. After card initialization
*        The CSD register of card is read and the max frequency
*        the card can operate is determined.
*        [In most cases: MMC cards 20MHz, SD cards 25MHz]
*
*/
U16 FS_MMC_HW_X_SetMaxSpeed(U8 Unit, U16 Freq) {
  U32 SDClock;
  int Div;
  int i;

  //
  // Formula: MCLCLK frequency = PCLK_SDCLOCK / [2×(ClkDiv+1)].
  //
  SDClock = PCLK_SDCLOCK / 1000 /20;
  Div     = SDClock / (2 * Freq) - 1;
  if (Div < 0) {
    Div = 0;
  }
  MCI_CLOCK  = (1 << 8) | (1 << 9) | Div;
  Freq = SDClock / (2 * (Div + 1));
  MCI_POWER |= 0x01;    /* bit 1 is set already, from power up to power on */
  for ( i = 0; i < 0x2000; i++ );

  return Freq;
}

/*********************************************************************
*
*       FS_MMC_HW_X_IsPresent
*
*    Returns the state of the media. If you do not know the state, return
*    FS_MEDIA_STATE_UNKNOWN and the higher layer will try to figure out if
*    a media is present.
*
*  Parameters:
*    Unit                 - Device Index
*
*  Return value:
*    FS_MEDIA_STATE_UNKNOWN      - the state of the media is unkown
*    FS_MEDIA_NOT_PRESENT        - no card is present
*    FS_MEDIA_IS_PRESENT         - a card is present
*/
int FS_MMC_HW_X_IsPresent(U8 Unit) {
  return FS_MEDIA_IS_PRESENT;
}

/*********************************************************************
*
*       FS_MMC_HW_X_IsWriteProtected
*
*  Function description
*    Returns wheter card is write protected or not.
*
*  Return value:
*    0 - Is not write protected
*    1 - Is write protected
*/
int    FS_MMC_HW_X_IsWriteProtected  (U8 Unit) {
  return 0;
}

/*********************************************************************
*
*       FS_MMC_HW_X_SetResponseTimeOut
*
*  Function description
*    Sets the reponse time out value given in MMC/SD card cycles.
*
*/
void FS_MMC_HW_X_SetResponseTimeOut(U8 Unit, U32 Value) {
}

/*********************************************************************
*
*       FS_MMC_HW_X_SetReadDataTimeOut
*
*  Function description
*    Sets the read data time out value given in MMC/SD card cycles.
*/
void FS_MMC_HW_X_SetReadDataTimeOut(U8 Unit, U32 Value) {
  MCI_DATA_TMR = Value;
}

/*********************************************************************
*
*       FS_MMC_HW_X_SendCmd
*
*  Function description
*    Sends a command to the MMC/SD card.
*/
void FS_MMC_HW_X_SendCmd(U8 Unit, unsigned Cmd, unsigned CmdFlags, unsigned ResponseType, U32 Arg) {
  unsigned ResponseFormat;
  unsigned ldBlockLength;
  volatile int i;

  switch (ResponseType) {
  //
  //  No response is expected
  //
  case FS_MMC_RESPONSE_FORMAT_NONE:
  default:
    ResponseFormat = 0;
    break;
  //
  //  Short response is expected (48bit)
  //
  case FS_MMC_RESPONSE_FORMAT_R1:
  case FS_MMC_RESPONSE_FORMAT_R3:
     ResponseFormat = 1;
    break;
  //
  //  Long response is expected (136bit)
  //
  case FS_MMC_RESPONSE_FORMAT_R2:
    ResponseFormat = 3;
    break;
  }
  if (ResponseType == FS_MMC_RESPONSE_FORMAT_R3) {
    _IgnoreCRC = 1;
  } else {
    _IgnoreCRC = 0;
  }
  ldBlockLength   = _ld(_BlockSize);
  _DataControlReg = (ldBlockLength << 4);
  //
  // Handle the flags;
  //
  if (CmdFlags & FS_MMC_CMD_FLAG_DATATRANSFER) { /* If data transfer */
    _DataControlReg |= (1 << 0)
                    |  (1 << 1)
                    |  (1 << 3)
                    ;
  }
  if (CmdFlags & FS_MMC_CMD_FLAG_WRITETRANSFER) {   /* Write transfer ? */
    _DataControlReg &= ~(1 << 1);   // Set WRITE bit
  }
  if (CmdFlags & FS_MMC_CMD_FLAG_USE_SD4MODE) {   /* 4 bit mode ? */
    MCI_CLOCK |=  (1 << 11);   // Set WIDE bit
  } else {
    MCI_CLOCK &= ~(1 << 11);   // Clear WIDE bit
  }
  MCI_CLEAR     = 0xFFFFFFFF;
  MCI_ARGUMENT  = Arg;
  MCI_COMMAND   = (Cmd & 0x3F)              // Command[0:5]
                | (ResponseFormat << 6)   // ResponseFormat [6:7]
                | (1 << 10)               // Enable controller [10]
                ;
  for ( i = 0; i < 0x10; i++ );
}

/*********************************************************************
*
*       FS_MMC_HW_X_GetResponse
*
*  Function description
*    Receives the reponses that was sent by the card after
*    a command was sent to the card.
*/
int FS_MMC_HW_X_GetResponse(U8 Unit, void *pBuffer, U32 Size) {
  unsigned  Status;
  U8      * p;
  int       r;
  int       NumBytes;

  p        = (U8 *)pBuffer;
  NumBytes = Size;
  r        = 0;    // No error so far
  //
  // Wait until command processing is finished
  //
  while (MCI_STATUS & (1 << 11));
  MCI_CLEAR = (1 << 11) | (1 << 7);
  do {
    Status = MCI_STATUS;
    if (Status & (1 << 0) && (_IgnoreCRC == 0)) {
      r = FS_MMC_CARD_RESPONSE_CRC_ERROR;
      MCI_CLEAR = (1 << 0);
      break;
    }
    if (Status & (1 << 2)) {
      r = FS_MMC_CARD_RESPONSE_TIMEOUT;
      MCI_CLEAR = (1 << 2);
      break;
    }
    if (Status & (1 << 6) || _IgnoreCRC) {
      volatile U32 * pReg;

      MCI_CLEAR = (1 << 6) | (1 << 0);
      *p++ = MCI_RESP_CMD;
      NumBytes--;
      pReg = (volatile U32 *)(&MCI_RESP0);
      do {
        U32 Data32;
        Data32 = FS_LoadU32BE((const U8 *)pReg);
        FS_StoreU32LE(p, Data32);
        NumBytes -= 4;
        pReg++;
        p += 4;
      } while (NumBytes >= 4);
      break;
    }
    if (Status & (1 << 7)) {
      MCI_CLEAR = (1 << 7);
      break;
    }
  } while (1);
  return r;
}

/*********************************************************************
*
*       FS_MMC_HW_X_ReadData
*
*  Function description
*    Reads data from MMC/SD card tru the MMC/SD card controller.
*
*  Notes:
*   (1)   When reading the data from MMC/SD card thru the FIFO sfrs in SD-4 mode,
*         MCI controller reports an RX overflow.
*         To solve this the DMA is used and facilate this.
*         To read the data thru DMA, a temporary buffer is needed since
*         the DMA cannot write data directly to the internal SRAM.
*         This temporary buffer is located in the USB RAM, since
*         this USB RAM is not used in most cases.
*/
int FS_MMC_HW_X_ReadData(U8 Unit, void * pBuffer, unsigned NumBytes, unsigned NumBlocks) {
  U8       * p;
  int        r;
  U32      * pTempBuffer;
  U32      * pFifoReg;

  p           = (U8 *)pBuffer;
  pFifoReg    = (U32 *)/*(void *)*/MCI_FIFO_ADDR;
  pTempBuffer = (U32 *)MCI_TEMP_BUFFER_ADDR_RX;
  do {
    _DMAStart(pTempBuffer, pFifoReg, NumBytes, PERIPHAL_TO_MEMORY);
    _WriteControlReg(Unit);
    r        = 0;    // No error so far
    do {
      if (MCI_STATUS & (1 << 1)) {
        r = FS_MMC_CARD_READ_CRC_ERROR;
        MCI_CLEAR = (1 << 1);
        break;
      }
      if (MCI_STATUS & (1 << 3)) {
        r = FS_MMC_CARD_READ_TIMEOUT;
        MCI_CLEAR = (1 << 3);
        break;
      }
      if (MCI_STATUS & (1 << 5)) {
        r = FS_MMC_CARD_READ_CRC_ERROR;
        MCI_CLEAR = (1 << 5);
        break;
      }
      if (MCI_DATA_CNT == 0) {
        while ((GPDMA_RAW_INT_TCSTAT & 0x02) == 0);
        GPDMA_INT_TCCLR = 0x02;
        break;
      }
    } while (1);
    while ((MCI_STATUS & (1 << 10)) == 0);
    MCI_CLEAR = (1 << 10);
    while ((MCI_STATUS & (1 << 8)) == 0);
    MCI_CLEAR = (1 << 8);
    FS_MEMCPY(p, pTempBuffer, NumBytes);
    p += NumBytes;
  } while (--NumBlocks);
  return r;
}

/*********************************************************************
*
*       FS_MMC_HW_X_WriteData
*
*  Function description
*    Writes the data to MMC/SD card tru the MMC/SD card controller.
*
*  Notes:
*   (1)   When writing the data to the MCI controller thru the FIFO sfrs,
*         it is not guaranteed that this works correctly,
*         especially in SD-4 mode.
*         To facilate this, the DMA is used to send the data to the MMC/SD card.
*         Since the DMA cannot transfer data from the internal SRAM to the
*         MCI FIFO, the data are copied initally to the USB RAM since
*         in most cases this USB RAM is not used.
*
*/
int FS_MMC_HW_X_WriteData(U8 Unit, const void * pBuffer, unsigned NumBytes, unsigned NumBlocks) {
  U8       * p;
  int        r;
  U32      * pFifoReg;
  U32      * pTempBuffer;

  p           = (U8 *)pBuffer;
  pFifoReg    = (U32 *)/*(void *)*/MCI_FIFO_ADDR;
  pTempBuffer = (U32 *)MCI_TEMP_BUFFER_ADDR_TX;
  do {
    FS_MEMCPY(pTempBuffer, p, NumBytes);     // Note (1)
    _DMAStart(pFifoReg, pTempBuffer, NumBytes, MEMORY_TO_PERIPHAL);
    _WriteControlReg(Unit);
    r        = 0;    // No error so far
    while ((GPDMA_RAW_INT_TCSTAT & 0x01) == 0);
    GPDMA_INT_TCCLR = 1;
    if (MCI_STATUS & (1 << 1)) {
      MCI_CLEAR = (1 << 1);
      return FS_MMC_CARD_WRITE_CRC_ERROR;
    }
    if (MCI_STATUS & (1 << 4)) {
      MCI_CLEAR = (1 << 4);
      return FS_MMC_CARD_WRITE_CRC_ERROR;
    }
    while((MCI_STATUS & (1 << 10)) == 0);
    MCI_CLEAR = (1 << 10);
    while((MCI_STATUS & (1 << 8)) == 0);
    MCI_CLEAR = (1 << 8);
    p += NumBytes;

  } while (--NumBlocks);
  return r;
}

/*********************************************************************
*
*       FS_MMC_HW_X_Delay
*
*  Function description
*    Waits for a certain time given by the parameter.
*
*/
void FS_MMC_HW_X_Delay(int ms) {
  _Delayus(ms * 1000);
}

/*********************************************************************
*
*       FS_MMC_HW_X_InitHW
*
*  Function description
*    Initialize the MMC/SD card controller.
*/
void FS_MMC_HW_X_InitHW(U8 Unit) {
  volatile int i;

  if (MCI_CLOCK & (1 << 8)) {
    MCI_CLOCK &= ~(1 << 8);
  }
  if (MCI_POWER & 0x02) {
    MCI_POWER = 0x00;
  }
  for (i = 0; i < 0x1000; i++);
  PCONP |= ( 1 << 28 );     // Enable clock to the MCI block
  //
  // Disable all interrupts for now
  //
  MCI_MASK0 = 0;
  MCI_MASK1 = MCI_MASK0;
  //
  // Connect MCI signals to P1.02, P1.03, P1.06, P1.07, P1.11 and P1.12
  //
  PINSEL1 &= ~((0x3 <<  6) |
               (0x3 <<  8) |
               (0x3 << 12))
           ;
  PINSEL1 |=   (0x2 <<  6) |  // MCICLK
               (0x2 <<  8) |  // MCICMD
               (0x2 << 12)    // MCIDAT0
           ;
  PINSEL4 &= ~((0x3 << 22) |
               (0x3 << 24) |
               (0x3 << 26))
           ;
  PINSEL4 |=   (0x2 << 22) |  // MCIDAT1
               (0x2 << 24) |  // MCIDAT2
               (0x2 << 26)    // MCIDAT3
           ;
  //
  // Setup P1.5 as GPIO and set as out put and set to low.
  // This will then enable the MCI Power on board.
  //
  PINSEL1 &= ~(3 << 10);
  IODIR0  |=  (1 << 21);
  IOSET0   =  (1 << 21);
  //
  // Set up clocking default mode, clear any registers as needed
  //
  MCI_COMMAND = 0;
  MCI_DATA_CTRL = 0;
  MCI_CLEAR = 0x7FF;    // Clear all pending interrupts
  MCI_POWER = 0x02;     // Power up
  while ((MCI_POWER & 0x02) == 0);
  _DMAInit();
  for ( i = 0; i < 0x1000; i++ );
}

/*********************************************************************
*
*       FS_MMC_HW_X_GetMaxReadBurst
*
*  Function description
*    Returns the number of block (sectors)
*    that can be read at once with a single
*    READ_MULTIPLE_SECTORS.
*
*/
U16 FS_MMC_HW_X_GetMaxReadBurst(U8 Unit) {
  //
  // The NXP LPC 23xx/24xx MCI controller does not
  // handle read burst (read multiple sectors at once)
  // correctly. On newer SD card as well as SD HC card,
  // the controller reports either DATA CRC error or
  // Startbit on all data lines not received.
  // Returning 1 will tell the driver to avoid
  // read burst access and read data sector by sector.
  //
  return 1;
}

/*********************************************************************
*
*       FS_MMC_HW_X_GetMaxWriteBurst
*
*  Function description
*    Returns the number of block (sectors)
*    that can be written at once with a single
*    WRITE_MULTIPLE_SECTORS.
*/
U16 FS_MMC_HW_X_GetMaxWriteBurst(U8 Unit) {
  //
  // The NXP LPC 23xx/24xx MCI controller does not
  // handle write burst (write multiple sectors at once)
  // correctly.
  // During a write burst operation the
  // communication breaks up.
  // The MCI controller does not report any error.
  // Returning 1 will tell the driver to avoid
  // write burst access and write data sector by sector.
  //
  return 1;
}

/*************************** End of file ****************************/
