#include 	"DIGITALDATA.H"
#include 	"MATH.H"

DigitalData::DigitalData ()
{
	SetDword(0); 
}

DigitalData::DigitalData (BYTE Value)
{
	SetDword(0);
	SetByte(0,Value);  
}

DigitalData::DigitalData (WORD Value)
{
	SetDword(0);
	SetWord(0,Value);  
}

DigitalData::DigitalData (DWORD Value)
{
	SetDword(Value);  
}

DWORD DigitalData::SetBit (unsigned short Location, BOOL Value)
{
	DWORD temp;

	temp = (DWORD)pow(2.0f,Location);
	
	if (Value)
	{
		data |= temp;
	}
	else
	{
		temp = ~temp;
		data &= temp;
	}

	return data;
}

DWORD DigitalData::SetByte (unsigned short Location, BOOL Value)
{
	unsigned short ctr;
	DWORD mask,temp;
	
	temp=Value; 
	mask=0xffffff00;
	
	for (ctr=0;ctr<Location;ctr++)
	{
		temp<<=8;
		mask<<=8;
		mask|=0xff;
	}

	data &=mask;
	data|=temp;

	return data;
}
  
DWORD DigitalData::SetWord (unsigned short Location, WORD Value)
{
	WORD temp1;
	BYTE temp2;
  
	temp1=Value;  
	temp2=temp1;
  
	SetByte(Location*2,temp2);
	temp1>>=8;
	
	temp2=temp1;
	SetByte(Location*2+1,temp2);
  
	return data;
}

void DigitalData::SetDword (DWORD Value)
{
	data = Value;
}

DWORD DigitalData::ToggleBit (unsigned short Location)
{
	DWORD temp;
	
	temp = (DWORD)pow(2.0f,Location);
	data ^=temp;

	return data;
} 

DWORD DigitalData::ToggleBits (unsigned short StartLocation, unsigned short Count)
{
	for (int temp=StartLocation;temp<StartLocation+Count;temp++)
		ToggleBit(temp);

	return data;
}

DWORD DigitalData::ToggleByte (unsigned short Location)
{
	ToggleBits(Location*8,8);

	return data;
}

DWORD DigitalData::ToggleWord (unsigned short Location)
{
	ToggleBits(Location*16,16);

	return data;
}

DWORD DigitalData::ToggleDword ()
{
	ToggleWord(0);
	ToggleWord(1);

	return data;
}

DWORD DigitalData::RiseBit (unsigned short Location)
{
	SetBit(Location,1);  

	return data;
}

DWORD DigitalData::RiseBits (unsigned short StartLocation, unsigned short Count)
{
	for (int temp=StartLocation;temp<StartLocation+Count;temp++)
		SetBit(temp,1);

	return data;
}

DWORD DigitalData::RiseByte (unsigned short Location)
{ 
	SetByte(Location,0xff);

	return data;
}

DWORD DigitalData::RiseWord (unsigned short Location)
{  
	SetWord(Location,0xffff);

	return data;
}

DWORD DigitalData::FallBit (unsigned short Location)
{
	SetBit(Location,0);

	return data;
}

DWORD DigitalData::FallBits (unsigned short StartLocation, unsigned short Count)
{
	for (int temp=StartLocation;temp<StartLocation+Count;temp++)
		SetBit(temp,0);

	return data;
}

DWORD DigitalData::FallByte (unsigned short Location)
{  
	SetByte(Location,0);

	return data;
}

DWORD DigitalData::FallWord (unsigned short Location)
{
	SetWord(Location,0);

	return data;
}

BOOL DigitalData::GetBit (unsigned short Location)
{
	DWORD temp;

	temp = (DWORD)pow(2.0,Location);
	temp = temp & data;

	if (temp)
		return 1;
	else
		return 0;
}

BYTE DigitalData::GetByte (unsigned short Location)
{
	BYTE temp1;
	DWORD temp2=0xff;;

	temp2<<=(Location*8);
	temp2 = temp2 & data;
	temp2>>=(Location*8);
	temp1 = temp2;

	return temp1;
}

WORD  DigitalData::GetWord (unsigned short Location)
{
	WORD temp1;
	DWORD temp2=0xffff;;

	temp2<<=(Location*16);
	temp2 = temp2 & data;
	temp2>>=(Location*16);
	temp1 = temp2;

	return temp1;    
}

DWORD DigitalData::GetDword (void)
{
	return data;
}

void DigitalData::SwapBits (int Loc1, int Loc2)
{
	BOOL temp;
	
	temp = GetBit(Loc1);
	SetBit(Loc1, GetBit(Loc2));
	SetBit(Loc2, temp);
}
	
