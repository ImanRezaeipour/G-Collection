#ifndef		__PACKET__
#define		__PACKET__

#include	"BUFFER.H"
#include	"DATATYPE.H"

class Packet : public Buffer
{
public:
	Packet ();
	~Packet ();
	
	virtual bool IsValid () = 0;
	virtual void Make (void) = 0;	

protected:
	virtual BYTE calculate_checksum(int first_location, int last_location) = 0; 	
};

#endif
