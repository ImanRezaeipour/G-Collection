#ifndef		__FINGERPACKET__
#define 	__FINGERPACKET__

#include 	"PACKET.H"

class FingerPacket : public Packet
{
public:
  	FingerPacket();
	~FingerPacket();

	bool IsValid(void);

	void Make(void);

	DWORD GetParameter(void);
	void  SetParameter(DWORD Param);

	DWORD GetSize(void);
	void  SetSize(DWORD Param);

	BYTE GetCommand(void);
	void SetCommand(BYTE Command);

	BYTE GetError(void);
	void SetFlag(BYTE Flag);
        
        void SetNumOfdataPacket (WORD num);                                 //Transmit
        void SetIndexOfdataPacket (WORD index);
        void DWORDtoStr(BYTE* str, DWORD num);
        DWORD calculate_checksum_databody (BYTE* databody, int size);       //Transmit
private:
	BYTE calculate_checksum(int first_location, int last_location);

	const BYTE STX;
	const BYTE ETX;
};
#endif