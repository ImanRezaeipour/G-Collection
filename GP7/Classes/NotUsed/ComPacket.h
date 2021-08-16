#ifndef _COMPACKET_
#define _COMPACKET_

#include <BUFFER.H>

class COMPacket : public Buffer
{
public:
  COMPacket();
  ~COMPacket();
  
   bool IsValid(void);
};
#endif