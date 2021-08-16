#include 	"MIFAREPACKET.H"
#include 	"DIGITALDATA.H"
#include        "Device.h"

MifarePacket::MifarePacket ()
:STX(0x02)
,ETX(0x03)
{
	
}

MifarePacket::~MifarePacket ()
{
}

bool MifarePacket::IsValid (void)
{
	int len;
       if(Device::TypeDevice.Mifare)            //D.k
       {
	len = (*this)[2];
	if ((*this)[0] == STX &&
	(*this)[1] == 0 &&
	calculate_checksum(1,len+3) == (*this)[len+3]
#ifdef REM130
         )
#else          
          && (*this)[len+4] == ETX)
#endif
		return true;
	else
		return false;
      }
      else if(Device::TypeDevice.GP8)                 //D.k
      {
       if ((*this)[0] == STX &&  (*this)[11] == 0x0D && (*this)[12] == 0x0A && (*this)[13] == ETX )
         return true;
       else
         return false;
      }
      return false;
}

void MifarePacket::Make(void)
{
	Fill(STX,0);
#ifdef REM130
        Fill(2,2);
        Fill(calculate_checksum(1,5),5);
#else        
	Fill(1,2);
	Fill(ETX,5);
	Fill(calculate_checksum(1,4),4);
#endif        
}

void MifarePacket::MakeEx(BYTE* data, BYTE LenData)
{
	Fill(STX, 0);
        //Fill(0, 1);                         //Adrress
        Fill(LenData + 1, 2);               //LEN
        for(BYTE i = 0; i < LenData; i++)
          Fill(data[i], 4+i);               //Data
        Fill(calculate_checksum(1,LenData+4),LenData+4);     
}

void MifarePacket::SetParam (BYTE Param)
{
	Fill (Param,4);
}

BYTE MifarePacket::GetCommand (void)
{
  	return (*this)[3];
}

void MifarePacket::SetCommand (BYTE Command)
{
	Fill (Command,3);
}

BYTE MifarePacket::GetStationID (void)
{
	return (*this)[1];
}

void MifarePacket::SetStationID (BYTE StationID)
{
	Fill(StationID, 1);
}

BYTE MifarePacket::calculate_checksum (int first_location, int last_location)
{
	BYTE temp=0;

	for (int ctr=first_location;ctr<last_location;ctr++)
		temp ^= (*this)[ctr];

  return temp;
}

