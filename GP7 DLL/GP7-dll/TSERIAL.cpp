//#define STRICT
#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <process.h>
#include <conio.h>

#include "Tserial.h"

	char              Serial_port[10]={0} ;                      // port name "com1",...
    int               Serial_rate = 0;                          // baudrate
    serial_parity     parityMode = spNONE;
    HANDLE            serial_handle = INVALID_HANDLE_VALUE;                 // ...

/* -------------------------------------------------------------------- */
/* -------------------------    Tserial   ----------------------------- */
/* -------------------------------------------------------------------- */
//Tserial()
//{
//    parityMode       = spNONE;
//    port[0]          = 0;
//    rate             = 0;
//    serial_handle    = INVALID_HANDLE_VALUE;
//}

/* -------------------------------------------------------------------- */
/* --------------------------    ~Tserial     ------------------------- */
/* -------------------------------------------------------------------- */
//~Tserial()
//{
//    if (serial_handle!=INVALID_HANDLE_VALUE)
//        CloseHandle(serial_handle);
//    serial_handle = INVALID_HANDLE_VALUE;
//}
/* -------------------------------------------------------------------- */
/* --------------------------    disconnect   ------------------------- */
/* -------------------------------------------------------------------- */
void Serial_disconnect(void)
{
    if (serial_handle!=INVALID_HANDLE_VALUE)
        CloseHandle(serial_handle);
    serial_handle = INVALID_HANDLE_VALUE;
}
/* -------------------------------------------------------------------- */
/* --------------------------    connect      ------------------------- */
/* -------------------------------------------------------------------- */
int  Serial_connect(char *port_arg, int rate_arg, serial_parity parity_arg)
{
    int erreur;
    DCB  dcb;
    COMMTIMEOUTS cto = { 0, 0, 0, 0, 0 };

    /* --------------------------------------------- */
    if (serial_handle!=INVALID_HANDLE_VALUE)
        CloseHandle(serial_handle);
    serial_handle = INVALID_HANDLE_VALUE;

    erreur = 0;

    if (port_arg!=0)
    {
        strncpy(Serial_port, port_arg, 10);
        Serial_rate      = rate_arg;
        parityMode= parity_arg;
        memset(&dcb,0,sizeof(dcb));

        /* -------------------------------------------------------------------- */
        // set DCB to configure the serial port
        dcb.DCBlength       = sizeof(dcb);                   
        
        /* ---------- Serial Port Config ------- */
        dcb.BaudRate        = Serial_rate;

        switch(parityMode)
        {
            case spNONE:
                            dcb.Parity      = NOPARITY;
                            dcb.fParity     = 0;
                            break;
            case spEVEN:
                            dcb.Parity      = EVENPARITY;
                            dcb.fParity     = 1;
                            break;
            case spODD:
                            dcb.Parity      = ODDPARITY;
                            dcb.fParity     = 1;
                            break;
        }


        dcb.StopBits        = ONESTOPBIT;
        dcb.ByteSize        = 8;
        
        dcb.fOutxCtsFlow    = 0;
        dcb.fOutxDsrFlow    = 0;
        dcb.fDtrControl     = DTR_CONTROL_DISABLE;
        dcb.fDsrSensitivity = 0;
        dcb.fRtsControl     = RTS_CONTROL_DISABLE;
        dcb.fOutX           = 0;
        dcb.fInX            = 0;
        
        /* ----------------- misc parameters ----- */
        dcb.fErrorChar      = 0;
        dcb.fBinary         = 1;
        dcb.fNull           = 0;
        dcb.fAbortOnError   = 0;
        dcb.wReserved       = 0;
        dcb.XonLim          = 2;
        dcb.XoffLim         = 4;
        dcb.XonChar         = 0x13;
        dcb.XoffChar        = 0x19;
        dcb.EvtChar         = 0;
        
        /* -------------------------------------------------------------------- */
        /*serial_handle    = CreateFile((LPCWSTR)Serial_port, GENERIC_READ | GENERIC_WRITE,
                               0, NULL, OPEN_EXISTING,NULL,NULL);*/
                   // opening serial port
		WCHAR    str3[10]; 
		MultiByteToWideChar( 0,0, Serial_port, 10, str3, 10); 
		LPCWSTR cstr4 = str3; 
		serial_handle = CreateFile(cstr4, GENERIC_READ | GENERIC_WRITE,  0,  NULL,  OPEN_EXISTING, 0, NULL); // default.

        if (serial_handle    != INVALID_HANDLE_VALUE)
        {
            if(!SetCommMask(serial_handle, 0))
                erreur = 1;

            // set timeouts
            if(!SetCommTimeouts(serial_handle,&cto))
                erreur = 2;

            // set DCB
            if(!SetCommState(serial_handle,&dcb))
                erreur = 4;
        }
        else
            erreur = 8;
    }
    else
        erreur = 16;


		COMMTIMEOUTS timeouts={0};
		timeouts.ReadIntervalTimeout=50;
		timeouts.ReadTotalTimeoutConstant=5000;
		timeouts.ReadTotalTimeoutMultiplier=10;
		timeouts.WriteTotalTimeoutConstant=5000;
		timeouts.WriteTotalTimeoutMultiplier=10;
		if(!SetCommTimeouts(serial_handle, &timeouts)){
		//error occureed. Inform user
			erreur = 32;
		}
    /* --------------------------------------------- */
    if (erreur!=0)
    {
        CloseHandle(serial_handle);
        serial_handle = INVALID_HANDLE_VALUE;
    }
    return(erreur);
}


/* -------------------------------------------------------------------- */
/* --------------------------    sendChar     ------------------------- */
/* -------------------------------------------------------------------- */
void Serial_sendChar(BYTE data)
{
    Serial_sendArray(&data, 1);
}

/* -------------------------------------------------------------------- */
/* --------------------------    sendArray    ------------------------- */
/* -------------------------------------------------------------------- */
void Serial_sendArray(BYTE *buffer, int len)
{
    unsigned long result;

    if (serial_handle!=INVALID_HANDLE_VALUE)
        WriteFile(serial_handle, buffer, len, &result, NULL);
}

/* -------------------------------------------------------------------- */
/* --------------------------    getChar      ------------------------- */
/* -------------------------------------------------------------------- */
char Serial_getChar(void)
{
    BYTE c;
    Serial_getArray(&c, 1);
    return(c);
}

/* -------------------------------------------------------------------- */
/* --------------------------    getArray     ------------------------- */
/* -------------------------------------------------------------------- */
int  Serial_getArray         (BYTE *buffer, int len)
{
    unsigned long read_nbr;

    read_nbr = 0;
    if (serial_handle!=INVALID_HANDLE_VALUE)
    {
        ReadFile(serial_handle, buffer, len, &read_nbr, NULL);
    }
    return((int) read_nbr);
}
/* -------------------------------------------------------------------- */
/* --------------------------    getNbrOfBytes ------------------------ */
/* -------------------------------------------------------------------- */
int Serial_getNbrOfBytes    (void)
{
    struct _COMSTAT status;
    int             n;
    unsigned long   etat;

    n = 0;

    if (serial_handle!=INVALID_HANDLE_VALUE)
    {
        ClearCommError(serial_handle, &etat, &status);
        n = status.cbInQue;
    }


    return(n);
}
