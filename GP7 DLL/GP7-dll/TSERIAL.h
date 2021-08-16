
#ifndef TSERIAL_H
#define TSERIAL_H

#include <stdio.h>
#include <windows.h>

enum serial_parity  { spNONE,    spODD, spEVEN };
/* -------------------------------------------------------------------- */
/* -----------------------------  Tserial  ---------------------------- */
/* -------------------------------------------------------------------- */
//class Tserial
//{
    // -------------------------------------------------------- //
//protected:

    // ++++++++++++++++++++++++++++++++++++++++++++++
    // .................. EXTERNAL VIEW .............
    // ++++++++++++++++++++++++++++++++++++++++++++++
//public:
//                  Tserial();
//                 ~Tserial();
    int           Serial_connect          (char *port_arg, int rate_arg,
											serial_parity parity_arg);
    void          Serial_sendChar         (BYTE c);
    void          Serial_sendArray        (BYTE *buffer, int len);
    char          Serial_getChar          (void);
    int           Serial_getArray         (BYTE *buffer, int len);
    int           Serial_getNbrOfBytes    (void);
    void          Serial_disconnect       (void);
//};
/* -------------------------------------------------------------------- */

#endif TSERIAL_H
