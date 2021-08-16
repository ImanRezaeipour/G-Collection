#include "COMPACKET.H"

COMPacket::COMPacket()
:Buffer(50)
{
}

COMPacket::~COMPacket()
{
}

bool COMPacket::IsValid(void)
{
  return true;
}
