#include 	"COMMUNICATIONPACKET.H"
#include        "DIGITALDATA.H"
#include        "SETTING.H"

CommunicationPacket::CommunicationPacket ()
{
        STX = 0x50;
        ETX = 0x0A;
}

CommunicationPacket::~CommunicationPacket ()
{

}

void CommunicationPacket::SetBroadCastFlag (bool Flag)
{
       	DigitalData d;
	
	d.SetByte(0,(*this)[1]);
	
	d.SetBit(0, Flag);
	
	Fill(d.GetByte(0), 0);		
}

void CommunicationPacket::SetAcknowledgeRequestFlag (bool Flag)
{
       	DigitalData d;
	
	d.SetByte(0,(*this)[1]);
	
	d.SetBit(1, Flag);
	
	Fill(d.GetByte(0), 0);		
}

void CommunicationPacket::SetMultiPacketFlag (bool Flag)
{
	DigitalData d;
	
	d.SetByte(0,(*this)[1]);
	
	d.SetBit(2, Flag);
	
	Fill(d.GetByte(0), 0);		
}

void CommunicationPacket::SetLastPacketFlag (bool Flag)
{
        DigitalData d;
	
	d.SetByte(0,(*this)[1]);
	
	d.SetBit(3, Flag);
	
	Fill(d.GetByte(0), 0);		
}

void CommunicationPacket::SetSecurityFlag (bool Flag)
{
        DigitalData d;
	
	d.SetByte(0,(*this)[1]);
	
	d.SetBit(4, Flag);
	
	Fill(d.GetByte(0), 0);		
}

void CommunicationPacket::SetResponseRequest (bool Flag)
{
        DigitalData d;
	
	d.SetByte(0,(*this)[1]);
	
	d.SetBit(6, Flag);
	
	Fill(d.GetByte(0), 0);		
}

void CommunicationPacket::SetFrameNumber (unsigned short int PacketNumber)
{
        DigitalData d(PacketNumber);
	
	Fill(d.GetByte(0), 2);
	Fill(d.GetByte(1), 3);
}

void CommunicationPacket::SetDestinationID (unsigned short int DestinationID)
{
        DigitalData d(DestinationID);
	
	Fill(d.GetByte(0), 6);
	Fill(d.GetByte(1), 7);
}

void CommunicationPacket::SetCommand (COMMCommand C)
{
        Fill((BYTE) C, 8);	
}

void CommunicationPacket::SetFlag (COMMFlag F)
{
        Fill((BYTE)F, 9);	
}

void CommunicationPacket::SetExtraData (DWORD EXData)
{
        DigitalData d(EXData);
	
	Fill(d.GetByte(0), 10);
	Fill(d.GetByte(1), 11);
	Fill(d.GetByte(2), 12);
	Fill(d.GetByte(3), 13);
}

void CommunicationPacket::SetData (Buffer * Data)
{
	Fill((BYTE) Data->Size(), 14);
	
	Fill(Data->GetStartAddress(), 15, Data->Size());		
}

void CommunicationPacket::AddData (Buffer * Data)
{
	Fill(Data->GetStartAddress() , 15 + GetDataLength() , Data->Size());		

	Fill((BYTE) Data->Size() + GetDataLength(), 14);
}

void CommunicationPacket::AddData (void * Data, int Size)
{
	Fill((BYTE*)Data , 15 + GetDataLength() , Size);		

	Fill((BYTE) Size + GetDataLength(), 14);
}

void CommunicationPacket::DeleteData (void)
{
        Fill((BYTE) 0, 14);
}

bool CommunicationPacket::GetBroadCastFlag (void)
{
        DigitalData d;
	d.SetByte(0, (*this)[1]);
	
	return d.GetBit(0);	
}

bool CommunicationPacket::GetAcknowledgeRequestFlag (void)
{
        DigitalData d;
	d.SetByte(0, (*this)[1]);
	
	return d.GetBit(1);	
}

bool CommunicationPacket::GetMultiPacketFlag (void)
{
        DigitalData d;
	d.SetByte(0, (*this)[1]);
	
	return d.GetBit(2);	
}

bool CommunicationPacket::GetLastPacketFlag (void)
{
        DigitalData d;
	d.SetByte(0, (*this)[1]);
	
	return d.GetBit(3);	
}

bool CommunicationPacket::GetSecurityFlag (void)
{
        DigitalData d;
	d.SetByte(0, (*this)[1]);
	
	return d.GetBit(4);	
}

bool CommunicationPacket::GetSenderFlag (void)
{
        DigitalData d;
	d.SetByte(0, (*this)[1]);
	
	return d.GetBit(5);	
}

bool CommunicationPacket::GetResponseRequest (void)
{
        DigitalData d;
	d.SetByte(0, (*this)[1]);
	
	return d.GetBit(6);	
}

unsigned short CommunicationPacket::GetFrameNumber (void)
{
	DigitalData d;

	d.SetByte(0,(*this)[2]);
	d.SetByte(1,(*this)[3]);
	
	return d.GetWord(0);	
}

unsigned short CommunicationPacket::GetDestinationID (void)
{
        DigitalData d;

	d.SetByte(0,(*this)[6]);
	d.SetByte(1,(*this)[7]);
	
	return d.GetWord(0);	
}

unsigned short CommunicationPacket::GetSourceID (void)
{
        DigitalData d;

	d.SetByte(0,(*this)[4]);
	d.SetByte(1,(*this)[5]);
	
	return d.GetWord(0);	
}

BYTE CommunicationPacket::GetCommand (void)
{
        return (*this)[8];	
}

BYTE CommunicationPacket::GetError (void)
{
        return (*this)[9];	
}

DWORD CommunicationPacket::GetExtraData (void)
{
       	DigitalData d;

	d.SetByte(0,(*this)[10]);
	d.SetByte(1,(*this)[11]);
	d.SetByte(2,(*this)[12]);
	d.SetByte(3,(*this)[13]);
	
	return d.GetDword();	
}

BYTE CommunicationPacket::GetDataLength (void)
{
        return (*this)[14];	
}

BYTE* CommunicationPacket::GetStartAddressofData (void)
{        
        return GetStartAddress() + 15;
}

bool CommunicationPacket::IsValid (void)
{
	int bcc_loc;
        Setting set;
	
	if ((*this)[0] != STX)
		return false;

	bcc_loc = GetDataLength() +15;

	if ((*this)[bcc_loc+1] != ETX)
		return false;
	
	if ((*this)[bcc_loc] != calculate_checksum(1,bcc_loc))
		return false;
        
        if(set.GetSettings().DeviceID != GetDestinationID())
                return false;
	
	return true;
}

void CommunicationPacket::Make (void)
{
	int bcc_loc;
       	DigitalData d;	
        Setting set;

	Fill(STX,0);

	d.SetByte(0,(*this)[1]);
	
	d.SetBit(5, 0);
	d.SetBit(7, 0);

	Fill(d.GetByte(0), 1);		

        d.SetDword(set.GetSettings().DeviceID);
	
	Fill(d.GetByte(0), 4);
	Fill(d.GetByte(1), 5);
	
	bcc_loc = GetDataLength() + 15;
	
	Fill (calculate_checksum(1,bcc_loc), bcc_loc);

	Fill (ETX, bcc_loc+1);	
}

BYTE CommunicationPacket::calculate_checksum (int first_location, int last_location)
{
	BYTE bcc = 0;
	int ctr;
	
	for (ctr=first_location;ctr<last_location;ctr++)
		bcc ^= (*this)[ctr];
		
	return bcc;
}

IDType CommunicationPacket::CheckIdentityPerson(void)
{
        DigitalData d;
        DWORD fi,card;

	d.SetByte(0,(*this)[15 + 8]);
	d.SetByte(1,(*this)[15 + 9]);
	d.SetByte(2,(*this)[15 + 10]);
	d.SetByte(3,(*this)[15 + 11]);
        fi = d.GetDword();
        
        d.SetByte(0,(*this)[15 + 12]);
	d.SetByte(1,(*this)[15 + 13]);
	d.SetByte(2,(*this)[15 + 14]);
	d.SetByte(3,(*this)[15 + 15]);
        card = d.GetDword();
        
         if(fi && card)
           return IT_FingerCard;
         if(fi)
           return IT_Finger;
         if(card)
           return IT_Card;
         
         return IT_None;
}

PersonInformation CommunicationPacket::GetPersonInfoWithConvertFingerIDtoUserID(void)
{
         PersonInformation PI;
         DigitalData d;
         
         d.SetByte(0,(*this)[15 + 0]);
	 d.SetByte(1,(*this)[15 + 1]);
	 d.SetByte(2,(*this)[15 + 2]);
	 d.SetByte(3,(*this)[15 + 3]); 
         PI.PersonNumber = d.GetDword();
         PI.FingerID = d.GetDword();
         
         d.SetByte(0,(*this)[15 + 4]);
	 d.SetByte(1,(*this)[15 + 5]);
	 d.SetByte(2,(*this)[15 + 6]);
	 d.SetByte(3,(*this)[15 + 7]);
         PI.Password = d.GetDword();
         
         /*d.SetByte(0,(*this)[15 + 8]);
	 d.SetByte(1,(*this)[15 + 9]);
	 d.SetByte(2,(*this)[15 + 10]);
	 d.SetByte(3,(*this)[15 + 11]); 
         PI.FingerID = d.GetDword();*/
         
         d.SetByte(0,(*this)[15 + 12]);
	 d.SetByte(1,(*this)[15 + 13]);
	 d.SetByte(2,(*this)[15 + 14]);
	 d.SetByte(3,(*this)[15 + 15]); 
         PI.CardID = d.GetDword();
         
         PI.PIS = (*this)[15 + 16];
         PI.PAR = (*this)[15 + 17];
         PI.FingerTemplateNumber = (*this)[15 + 18];
         
         return PI;
}
