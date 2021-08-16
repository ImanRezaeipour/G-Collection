Readme.txt for BSP for LPC2378

Supported hardware:
===================
The sample project for NXP LPC2378 is prepared
to run on an KEIL MCB2300 eval board,
but may be used on other target hardware as well.

Configurations
==============
- Debug_RAM:
  This configuration is prepared for download into
  internal RAM using J-Link and CSpy. A call of
  LPC2xxx_RAM.mac ensures that internal RAM
  is mapped at 0x00.

  Note: Not all sample applications can be used with
  the DEBUG_RAM configuration. Check the memory requirements
  of the application to be sure that there is enough RAM
  for the application to launch.

- Debug_FLASH:
  This configuration is prepared for debugging and
  can be downloaded into internal FLASH using J-Link
  and CSpy.
  A call of LPC2xxx_FLASH.mac ensures that
  FLASH is mapped at 0x00.

- Release_FLASH:
  This configuration is prepared to build a "release"
  output which can be downloaded into FLASH
  using CSPy and IAR Flashloader.
  A call of LPC2xxx_FLASH.mac ensures that FLASH
  is mapped at 0x00.
  Contains no debug information.
