#include 	"FINGERPACKET.H"
#include 	"DIGITALDATA.H"

FingerPacket::FingerPacket ()
:STX(0x40)
,ETX(0x0a)
{
	
}

FingerPacket::~FingerPacket ()
{
	
}

bool FingerPacket::IsValid (void)
{
	if ((*this)[0]  == STX &&
	(*this)[12] == ETX &&
	calculate_checksum(0,11) == (*this)[11])
		return true;
	else
		return false;
}


void FingerPacket::Make (void)
{
	Fill(STX,0);
	Fill(ETX,12);

	Fill(calculate_checksum(0,11),11);
}


DWORD FingerPacket::GetParameter (void)
{
	DigitalData temp;

	temp.SetByte(0,(*this)[2]);
	temp.SetByte(1,(*this)[3]);
	temp.SetByte(2,(*this)[4]);
	temp.SetByte(3,(*this)[5]);

	return temp.GetDword();
}

void FingerPacket::SetParameter (DWORD Param)
{
	DigitalData temp(Param);

	Fill(temp.GetByte(0),2);
	Fill(temp.GetByte(1),3);
	Fill(temp.GetByte(2),4);
	Fill(temp.GetByte(3),5);
}

DWORD FingerPacket::GetSize (void)
{
	DigitalData temp;

	temp.SetByte(0,(*this)[6]);
	temp.SetByte(1,(*this)[7]);
	temp.SetByte(2,(*this)[8]);
	temp.SetByte(3,(*this)[9]);

	return temp.GetDword();
}

void FingerPacket::SetSize (DWORD Param)
{
	DigitalData temp(Param);

	Fill(temp.GetByte(0),6);
	Fill(temp.GetByte(1),7);
	Fill(temp.GetByte(2),8);
	Fill(temp.GetByte(3),9);
}

BYTE FingerPacket::GetCommand (void)
{
	return (*this)[1];
}

void FingerPacket::SetCommand (BYTE Command)
{
	Fill(Command,1);
}

BYTE FingerPacket::GetError (void)
{
	return (*this)[10];
}

void FingerPacket::SetFlag (BYTE Flag)
{
	Fill(Flag, 10);
}

void FingerPacket::SetNumOfdataPacket (WORD num)
{
	DigitalData temp(num);

	Fill(temp.GetByte(0),2);
	Fill(temp.GetByte(1),3);
}

void FingerPacket::SetIndexOfdataPacket (WORD index)
{
	DigitalData temp(index);

	Fill(temp.GetByte(0),4);
	Fill(temp.GetByte(1),5);
}

DWORD FingerPacket::calculate_checksum_databody (BYTE* databody, int size)
{
	DWORD temp=0;
	
	for (int ctr=0; ctr < size; ctr++)
		temp += databody[ctr];

	return temp;
}

void FingerPacket::DWORDtoStr(BYTE* str, DWORD num)
{
        DigitalData temp(num);

	str[0] = temp.GetByte(0);
	str[1] = temp.GetByte(1);
	str[2] = temp.GetByte(2);
	str[3] = temp.GetByte(3);
        str[4] = 0;
}

BYTE FingerPacket::calculate_checksum (int first_location, int last_location)
{
	BYTE temp=0;
	
	for (int ctr=first_location;ctr<last_location;ctr++)
		temp += (*this)[ctr];

	return temp;
}

