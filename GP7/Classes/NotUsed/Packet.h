#ifndef __PACKET__
#define __PACKET__

#include "DATATYPE.H"
#include "DEQUE"

class Packet
{
public:
Packet();
~Packet();

void  	Clear(void);

int   	GetLenght(void);

void   	Append(BYTE Data);
void   	Append(char Data);
void   	Append(BYTE Data[],int Len);
void   	Append(string Data);

deque <BYTE>    GetAllData(void);
void            GetAllData(BYTE *Data);

BYTE	GetAt(int Location);

void	        GetData(BYTE Data[], int FirstLocation, int LastLocation);

void  SetPacketData(BYTE Data[], int Len);
void  SetPacketData(deque <BYTE> Data);

private:
  deque <BYTE> p;  
};

#endif 
