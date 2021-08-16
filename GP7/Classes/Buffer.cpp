#include	"BUFFER.H"
#include 	"UTILITY.H"

Buffer::Buffer ()
:max_len(128)
{
	disable_events();

  	Clear();
}

Buffer::~Buffer ()
{
  	
}

void Buffer::Fill (BYTE *Data, int Size)
{
 	Fill (Data, 0, Size);
}

void Buffer::Fill (BYTE* Data, int FirstLocation, int Size)
{
	int ctr;
	
	for (ctr = 0;ctr <Size; ctr++)
		Fill(Data[ctr], FirstLocation+ctr);
}

void Buffer::Fill (BYTE Data, int Location)
{
  	int ctr;

  	if (Location >= Size())
  	{
   		for (ctr=Size();ctr<Location;ctr++)
      			append((BYTE)0);

      		append(Data);
  	}
  	else
     		p[Location] = Data;
}

void Buffer::Insert (BYTE Data, int Location)
{
	
}

void Buffer::Delete (int Location)
{
	if (Location > index)
		return;

	for (int ctr = Location ; ctr<index ; ctr++)
		p[ctr] = p[ctr+1];
	
	p[index] = 0;

	index--;	
}

void Buffer::DeleteLastCell (void)
{
	Delete(Size()-1);
}

void Buffer::DeleteFirstCell (void)
{
	Delete(0);
}

void Buffer::Clear (void)
{
  	int ctr=0;

  	for (ctr=0;ctr<max_len;ctr++)
    		p[ctr]=0;

  	index = 0;
}

int Buffer::Size (void)
{
  	return index;
}

int Buffer::EmptySpace (void)
{
  	return max_len - index;
}

bool Buffer::IsBufferFull (void)
{
	if (index == max_len-1)
		return true;
	else
		return false;
}

BYTE* Buffer::GetStartAddress (void)
{
   	return p;
}

BYTE Buffer::operator[] (int Index)
{
	if (Index >= Size() || Index>=max_len)
    		return 0;

  	return p[Index];
}

void Buffer::operator+= (BYTE Data)
{
  	append(Data);
}

void Buffer:: operator+= (char Data)
{
  	append((BYTE) Data);
}

void Buffer::operator+= (string Data)
{
  	int ctr;

  	for (ctr=0;ctr<Data.length();ctr++)
    		append((char)Data[ctr]);
}

void Buffer::operator= (Buffer Buf)
{
  	Clear();

  	int ctr;

  	for (ctr=0;ctr<Buf.Size();ctr++)
    		append(Buf[ctr]);
}

bool Buffer::operator== (Buffer B)
{
	if (Size() != B.Size())
		return false;
	
	for (int ctr = 0; ctr<Size(); ctr++)
		if ((*this)[ctr] != B[ctr])
			return false;
	
	return true;
}

bool Buffer::operator== (string S)
{
	if (Size() != S.size())
		return false;
	
	for (int ctr = 0; ctr<Size(); ctr++)
		if ((*this)[ctr] != S[ctr])
			return false;
	
	return true;
}


void Buffer::disable_events (void)
{
	ep_buffer_full = NULL;
}

void Buffer::SetBufferFullEvent (EventPointer EP)
{
  	ep_buffer_full = EP;
}

void Buffer::append (BYTE data)
{
  	if (index == max_len-1)
	{  		
		Utility::SafeCallHandler(ep_buffer_full);
		return;
	}

  	p[index] = (BYTE) data;
  	index++;
}

string Buffer::GetString (int FirstLocation, int LastLocation)
{
	string str;
	int ctr;
	
	str = "";
	
	for (ctr = FirstLocation; ctr <= LastLocation && ctr < Size() ; ctr++)
		str += Utility::ToChar((*this)[ctr]);
	
	return str;	
}

double Buffer::GetValue (int FirstLocation, int LastLocation)
{
	double value;
	int ctr;
	
	value = 0;
	
	for (ctr = FirstLocation; ctr <= LastLocation && ctr < Size() ; ctr++)
		value = value*10 + (*this)[ctr];
	
	return value;
}

string Buffer::GetString (void)
{
	return GetString (0, Size()-1);	
}

double Buffer::GetValue (void)
{
	return GetValue (0, Size()-1);
}

void Buffer::safe_call_handler (EventPointer EP)
{
  if (EP)
    EP();
}



