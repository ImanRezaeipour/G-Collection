#ifndef		__DIGITALDATA__
#define		__DIGITALDATA__

#include 	"DATATYPE.H"

class 	DigitalData
{
public:
	DigitalData();
	DigitalData(BYTE Value);
	DigitalData(WORD Value);
	DigitalData(DWORD Value);  
  
	DWORD SetBit(unsigned short Location, BOOL Value);
	DWORD SetByte(unsigned short Location, BYTE Value);
	DWORD SetWord(unsigned short Location, WORD Value);
	void  SetDword(DWORD Value);
  
	DWORD ToggleBit(unsigned short Location);
	DWORD ToggleBits(unsigned short StartLocation,unsigned short Count);
	DWORD ToggleByte(unsigned short Location);
	DWORD ToggleWord(unsigned short Location);
	DWORD ToggleDword(void);
  
	DWORD RiseBit(unsigned short Location);
	DWORD RiseBits(unsigned short StartLocation, unsigned short Count);
	DWORD RiseByte(unsigned short Location);
	DWORD RiseWord(unsigned short Location);
  
	DWORD FallBit(unsigned short Location);
	DWORD FallBits(unsigned short StartLocation, unsigned short Count);
	DWORD FallByte(unsigned short Location);
	DWORD FallWord(unsigned short Location);  

	BOOL  GetBit(unsigned short Location);
	BYTE  GetByte(unsigned short Location);
	WORD  GetWord(unsigned short Location);
	DWORD GetDword(void);
	
	void SwapBits (int Loc1, int Loc2);
  
private: 
  	DWORD data;   
};
#endif
