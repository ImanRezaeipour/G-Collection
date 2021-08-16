#include	"CODING.H"
#include	"DIGITALDATA.H"

Coding::Coding ()
{
	value = 0;
}

Coding::~Coding ()
{
	
}

void Coding::SetValue (BYTE V)
{
	value = V;
}

BYTE Coding::GetValue (void)
{
	return value;
}

void Coding::DoCoding (void)
{
	permutation();
	substitution();
}

BYTE Coding::DoCoding (BYTE Value)
{
	value = Value;
	
	DoCoding();
	
	return value;
}

void Coding::DoCoding (Buffer * B)
{
	int ctr;
	BYTE* base;

	base = B->GetStartAddress();		
	
	for (ctr = 0; ctr < B->Size(); ctr ++)
	{
		value = base[ctr];
		
		DoCoding();
		
		base[ctr] = value;
	}
}

void Coding::DoEncoding (void)
{       
	substitution();
	permutation();	
}

BYTE Coding::DoEncoding (BYTE Value)
{
	value = Value;
	
	DoEncoding();
	
	return value;
}

void Coding::DoEncoding (Buffer * B)
{
	int ctr;
	BYTE* base;

	base = B->GetStartAddress();		
	
	for (ctr = 0; ctr < B->Size(); ctr ++)
	{
		value = base[ctr];
		
		DoEncoding();
		
		base[ctr] = value;
	}
}

void Coding::permutation (void)
{
	DigitalData d(value);
	
	d.SwapBits(4,7);
	d.SwapBits(1,5);
	d.SwapBits(2,3);
	d.SwapBits(0,6);	
	
	value = d.GetByte(0);
}

void Coding::substitution (void)
{
	DigitalData d(value);
	
	d.ToggleBit(0);
	d.ToggleBit(2);
	d.ToggleBit(6);
	d.ToggleBit(7);
	
	value = d.GetByte(0);
}



