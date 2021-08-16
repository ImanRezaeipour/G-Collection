#include "PACKET.H"

Packet::Packet()
{
  Clear();  
}

Packet::~Packet()
{
  
}

void Packet::Clear(void)
{
  p.clear();
}

int Packet::GetLenght(void)
{ 
  return  p.size(); 
}

void Packet::Append(BYTE Data)
{
  p.push_back(Data);
}

void Packet::Append(char Data)
{
  p.push_back((BYTE)Data);
}

void Packet::Append(BYTE Data[], int Len)
{
int ctr;
for(ctr=0;ctr<Len;ctr++)
  p.push_back(Data[ctr]);
}

void Packet::Append(string Data)
{
int ctr;
for(ctr=0;ctr<Data.size();ctr++)
  p.push_back(Data[ctr]);
}

deque <BYTE>    Packet::GetAllData(void)
{
  return p;
}

void Packet::GetAllData(BYTE *Data)
{
  GetData(Data, 0, GetLenght());
}

BYTE	Packet::GetAt(int Location)
{
  return p[Location];
}

void Packet::GetData(BYTE Data[], int FirstLocation, int LastLocation)
{
  if (FirstLocation<0 || LastLocation>p.size())
    return;
  int ctr;
  for (ctr=FirstLocation;ctr<LastLocation;ctr++)
    Data[ctr] = p[ctr];  
}

void  Packet::SetPacketData(BYTE Data[], int Len)
{
  Clear();
  Append(Data,Len);
}

void  Packet::SetPacketData(deque <BYTE> Data)
{
  Clear();
  p = Data;
}







  







