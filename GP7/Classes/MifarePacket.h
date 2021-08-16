#ifndef		__MIFAREPACKET__
#define 	__MIFAREPACKET__

#include 	"PACKET.H"

class MifarePacket : public Packet
{
public:
	MifarePacket ();
	~MifarePacket ();

	bool IsValid (void);

	void Make (void);
        void MakeEx(BYTE* data, BYTE LenData);
	
	BYTE GetCommand (void);
	void SetCommand (BYTE Command);

	BYTE GetStationID (void);
	void SetStationID (BYTE Flag);
        
        void SetParam (BYTE Param);

private:
  	BYTE calculate_checksum (int first_location, int last_location);

	const BYTE STX;
	const BYTE ETX;
};
#endif