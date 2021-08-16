// GP7-dll.cpp : Defines the exported functions for the DLL application.
//
#include <math.h>
#include "stdafx.h"
#include "GP7_dll.h"
#include "TSERIAL.h"
//#include <conio.h>
#include <sstream>
#include <iostream>
//#include <Windows.h>
using namespace std;

//int rte()
//{     
//	WORD ver = MAKEWORD(2,2);    
//	WSADATA wsaData;    
//	int retVal=0;     
//	WSAStartup(ver,(LPWSADATA)&wsaData);     
//	LPHOSTENT hostEnt;     /// Collect information of the server    
//	hostEnt = gethostbyname("Myxp");     
//	if(!hostEnt)    
//	{        
//		MessageBox(NULL,(LPCWSTR) "Unable to collect gethostbyname()", (LPCWSTR)"ERROR", MB_OK);        
//		WSACleanup();        
//		return 1;    
//	}     
//	/// Creating a socket    
//	SOCKET clientSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);     
//	if(clientSock == SOCKET_ERROR)    
//	{        
//		MessageBox(NULL, (LPCWSTR)"Unable to create socket", (LPCWSTR)"ERROR", MB_OK);        
//		WSACleanup();        
//		return 1;    
//	}     
//	SOCKADDR_IN serverInfo;     
//	serverInfo.sin_family = PF_INET;    
//	serverInfo.sin_addr = *((LPIN_ADDR)*hostEnt->h_addr_list);     
//	serverInfo.sin_port = htons(1111);     
//	retVal=connect(clientSock,(LPSOCKADDR)&serverInfo, sizeof(serverInfo));    
//	if(retVal==SOCKET_ERROR)    
//	{        
//		MessageBox(NULL, (LPCWSTR)"Unable to connect()", (LPCWSTR)"ERROR", MB_OK);        
//		WSACleanup();        
//		return 1;    
//	}     
//	MessageBox(NULL, (LPCWSTR)"Connection made sucessfully", (LPCWSTR)"SUCCESS", MB_OK);     
//	char *pBuf = "Request";
//	
//	MessageBox(NULL, (LPCWSTR)"Sending request from client", (LPCWSTR)"SENDING....", MB_OK);    
//	retVal = send(clientSock, pBuf, strlen(pBuf), 0);     
//	if(retVal == SOCKET_ERROR)    
//	{        
//		MessageBox(NULL, (LPCWSTR)"Unable to send()", (LPCWSTR)"ERROR", MB_OK);        
//		WSACleanup();        
//		return 1;    
//	}      
//	char szResponse[9];    
//	retVal = recv(clientSock, szResponse, 9, 0);     
//	if(retVal == SOCKET_ERROR)    
//	{        
//		MessageBox(NULL, (LPCWSTR)"Unable to recv()", (LPCWSTR)"SOCKET ERROR", MB_OK);        
//		WSACleanup();        
//		return 1;    
//	}     
//	MessageBox(NULL, (LPCWSTR)szResponse, (LPCWSTR)"Got the response from server", MB_OK);     
//	closesocket(clientSock);    
//	WSACleanup();        
//	return 0;
//}

//GP():MaxSizePacket(128),STX(0xA0),ETX(0x05)
//{
//	Clear(Packet, 128);
//}
//
//~GP()
//{
//
//}

void Clear(char* Str)
{
	memset(Str,0,strlen(Str));
}

void Clear(BYTE* Str)
{
	memset(Str,0,str_len(Str));
}

void Clear(char* Str, int Size)
{
	memset(Str,0,Size);
}

void Clear(BYTE* Str, int Size)
{
	memset(Str,0,Size);
}

//char operator[](int i)
//{
//	if(i >= MaxSizePacket)
//		return 0;
//	return Packet[i];
//}
//
//void operator+(BYTE byte)
//{
//	strncat(Packet,(char*)byte,1);
//}
//
//void operator+(char byte)
//{
//	strncat(Packet,(char*)byte,1);
//}
//
//void operator+(char* s)
//{
//	strcat(Packet,s);
//}

BYTE Make_BCC (int first_location, int last_location)
{
	char temp=0;

	for (int ctr=first_location;ctr<last_location;ctr++)
		temp ^= Packet[ctr];

  return temp;
}

void SetCommand (BYTE Command)
{
	Packet[8] = Command;
}

void SetConditionBits(BYTE chr)
{
	Packet[1] = chr;
}

void SetErrFlag(BYTE Err)
{
	Packet[9] = Err;
}

BYTE GetCommand (void)
{
        return Packet[8];	
}

BYTE GetError (void)
{
        return Packet[9];	
}

char GetDataLength (void)
{
        return Packet[14];	
}

int  Str_toInt(BYTE* str)
{
	int temp = 0;

	//temp = ((int)str[0] & 0xff) | ((int) str[1] << 8 & 0xff00) | ((int) str[2] << 8*2 & 0xff0000) 
	//	| ((int) str[3] << 8*3 & 0xff000000);
	for(int i=0; i < str_len(str); i++)
	{
		temp += (BYTE)str[i] * pow(256.0, i);
	}
	return temp;    
}

DWORD  Str_toLong(BYTE* str, int n)
{
	DWORD temp = 0;

	for(int i=0; i < n; i++)
	{
		temp += (BYTE)str[i] * pow(256.0, i);
	}
	return temp;    
}

void  Int_toStr(BYTE* str,int in)
{
	int mod = in;
	for(int i=0; i<4;i++)
		str[i] = 0 ; 
	for(int i=0; i<4;i++)
	{
		str[i] = mod % 256;
		mod /= 256;
		if(mod < 256)
		{
			str[i+1] = mod;
			str[i+2] = 0;
			break;
		}
	}

}

void  Int_toStr(BYTE* str,DWORD in)
{
	DWORD mod = in;
	for(int i=0; i<4;i++)
		str[i] = 0; 
	for(int i=0; i<4;i++)
	{
		str[i] = mod % 256;
		mod /= 256;
		if(mod < 256)
		{
			str[i+1] = mod;
			str[i+2] = 0;
			break;
		}
	}

}

bool IsValid (void)
{
	int bcc_loc;
	bcc_loc = GetDataLength() +15;
	
	if (Packet[0] != STX)
		return false;

	if (Packet[bcc_loc+1] != ETX)
		return false;
	
	if (Packet[bcc_loc] != Make_BCC(1,bcc_loc))
		return false;
	
	return true;
}

void SetFrameNumber (int PacketNumber)
{
	BYTE chr[4];
	Int_toStr(chr, PacketNumber);
	Packet[2] = chr[0];
	Packet[3] = chr[1];
}

void SetDestinationID (int DestinationID)
{
	BYTE chr[4];
	Int_toStr(chr, DestinationID);
	Packet[6] = chr[0];
	Packet[7] = chr[1];
}

void SetExtraData (int EXData)
{
	BYTE str[6];
	Int_toStr(str,EXData);
	Packet[10] = str[0];
	Packet[11] = str[1];
	Packet[12] = str[2];
	Packet[13] = str[3];
}

void SetExtraData (BYTE* EXData)
{
	Packet[10] = EXData[0];
	Packet[11] = EXData[1];
	Packet[12] = EXData[2];
	Packet[13] = EXData[3];
}

void SetData (BYTE* Data)
{
	int len = str_len(Data);
	Packet[14] = len;
	
	for(int i=0; i < len; i++)
		Packet[i+15] = Data[i];

}

void SetData (BYTE* Data, int len)
{
	Packet[14] = len;
	
	for(int i=0; i < len; i++)
		Packet[i+15] = Data[i];

}

void SetNotData (void)
{
	Packet[14] = 0;
}

int GetFrameNumber (void)
{
	BYTE Str[4];

	Clear(Str, 4);
	Str[0] = Packet[2];
	Str[1] = Packet[3];
	Str[2] = 0;
	
	return Str_toInt(Str);	
}

int GetSourceID (void)
{
	BYTE Str[4];

	Clear(Str, 4);
	Str[0] = Packet[4];
	Str[1] = Packet[5];
	Str[2] = 0;
	
	return Str_toInt(Str);		
}

int GetExtraData (void)
{
	BYTE Str[6];

	Clear(Str, 4);
	Str[0] = Packet[10];
	Str[1] = Packet[11];
	Str[2] = Packet[12];
	Str[3] = Packet[13];
	Str[4] = 0;
	
	return Str_toInt(Str);
}

void GetExtraData (BYTE* str)
{
	str[0] = Packet[10];
	str[1] = Packet[11];
	str[2] = Packet[12];
	str[3] = Packet[13];
	str[4] = 0;
}

void GetData(BYTE* str, int DataLength)
{
	int i=0;
	for(i=0; i < DataLength; i++)
		str[i] = Packet[i+15];
	str[i] = 0;
}

void GetData(BYTE* str)
{
	int i=0, len = GetDataLength();
	for(i=0; i < len; i++)
		str[i] = Packet[i+15];
	str[i] = 0;
}

void Make_Packet(void)
{
	int BccLoc;

	Packet[0] = STX;

	Packet[4] = 0;
	Packet[5] = 0;

	//Packet[9] = 0;

	BccLoc = GetDataLength() + 15;
	Packet[BccLoc] = Make_BCC(1, BccLoc);

	Packet[BccLoc + 1] = ETX;
}

void Swap_String (BYTE *p) 
{   
	BYTE *q = p;   
	while(q && *q) ++q; /* find eos */   
	for(--q; p < q; ++p, --q) 
		swap(*p, *q); 
} 

void Splite_ChartoDecimal (BYTE* str, BYTE* result, char splite)
{
	Swap_String(str);
	int j = 0;
	for(int i=0; i < str_len(str); i++)
	{
		int k = 0 , sum = 0;
		while(str[i] != splite && str[i] != 0)
		{
			sum += (str[i]-'0') * pow(10.0, k);
			k++;
			i++;
		}
		if(sum > 255)
		{
			result[j] = sum % 256;
			j++;
			result[j] = sum / 256;
			j++;
		}
		else
		{
			result[j] = sum;
			j++;
		}
		result[j] = 0;
	}
}

int str_len(BYTE* str)
{
	int i = 0;
	while(str[i])
		i++;
	return i;
}

void str_cpy(BYTE* Dest, BYTE* Source)
{
	int j = 0;
	while(Source[j])
		Dest[j] = Source[j++];
}

void strn_cpy(BYTE* Dest, BYTE* Source, int n)
{
	int j = 0;
	for(int j = 0; j < n; j++)
		Dest[j] = Source[j];
}

void str_cat(BYTE* Dest, BYTE* Source)
{
	int i = str_len(Dest), j = 0;
	while(Source[j])
		Dest[i++] = Source[j++];
}

void strn_cat(BYTE* Dest, BYTE* Source, int n)
{
	int i = str_len(Dest);
	for(int j = 0; j < n; j++)
		Dest[i++] = Source[j];
}

int APIENTRY Open_Serial(char* Port, int Buadrate, int& Handle)
{
	 //com = new Tserial();
	int ErrFlg = 1;
    //if (com!=0)
    //{
	   ErrFlg = Serial_connect(Port, Buadrate, spNONE) ;
       if(ErrFlg == d_OK)
		   Handle = Serial;
	//}
	return ErrFlg;
}

void APIENTRY Close_Serial(int Handle)
{
	if(Handle == (int) Serial);
		Serial_disconnect();
}

int APIENTRY Open_Ehternet(char* IP, int Port, int& Handle)
{
	//MessageBox(NULL, L"Unable to connect()1", L"ERROR", MB_OK); 
	WORD ver = MAKEWORD(2,2);    
	WSADATA wsaData;    
	int retVal=0;     
	char* host_name =IP;
	struct timeval tv;

	//strncpy(host_name, IP, 15);
	WSAStartup(ver,(LPWSADATA)&wsaData);
	LPHOSTENT hostEnt;     /// Collect information of the server    
	hostEnt = gethostbyname(host_name);     
	if(!hostEnt)    
	{        
		//MessageBox(NULL,(LPCWSTR) "Unable to collect gethostbyname()", (LPCWSTR)"ERROR", MB_OK);        
		WSACleanup();        
		return 1;    
	} 

	//LPHOSTENT hostEnt;     /// Collect information of the server    
	//hostEnt->h_addr_list = &IP;
	/// Creating a socket    
	clientSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);     
	if(clientSock == SOCKET_ERROR)    
	{        
		//MessageBox(NULL, L"Unable to create socket", L"ERROR", MB_OK);        
		WSACleanup();        
		return 1;    
	} 
	tv.tv_sec = 10000;  /* 10 Secs Timeout */
	setsockopt(clientSock, SOL_SOCKET, SO_RCVTIMEO,(char *)&tv,sizeof(struct timeval));
	setsockopt(clientSock, SOL_SOCKET, SO_SNDTIMEO,(char *)&tv,sizeof(struct timeval));

	SOCKADDR_IN serverInfo;     
	serverInfo.sin_family = PF_INET;    
	serverInfo.sin_addr = *((LPIN_ADDR)*hostEnt->h_addr_list);     
	serverInfo.sin_port = htons(Port);     
	retVal=connect(clientSock,(LPSOCKADDR)&serverInfo, sizeof(serverInfo));    
	if(retVal==SOCKET_ERROR)    
	{        
		//MessageBox(NULL, L"Unable to connect()", L"ERROR", MB_OK);        
		WSACleanup();        
		return 2;    
	}
	Handle = Ethernet;
	return d_OK;
}

void APIENTRY Close_Ehternet(int Handle)
{
	if(Handle == (int) Ethernet && clientSock)
		closesocket(clientSock); 
}

int APIENTRY Open_Usb(int& Handle)
{
	return true;
}

void APIENTRY Close_Usb(int Handle)
{

}

void APIENTRY CLOSE(int Handle)
{
	if(Handle == (int) Ethernet && clientSock)
	{
		closesocket(clientSock);
	}
	else if (Handle == (int) Serial)
	{
		Serial_disconnect();
	}
	else if (Handle == (int) Usb)
	{
	}

}

bool APIENTRY Test_Connect(int Handle, int DeviceID)
{
	Clear(Packet, 128);
	SetCommand(CC_TestConnect);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	SetExtraData(0);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
			return true;
	return false;
} 

//Time == HHMMSS
bool APIENTRY Set_Time(int Handle, char* Time, int DeviceID)
{
	Clear(Packet, 128);
	SetCommand(CC_SetTime);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	BYTE str[6];
	Splite_ChartoDecimal((BYTE*)Time, str, ':');
	if(str[0] >= 60 || str[1] >= 60 || str[2] >= 24)
		return false;
	SetExtraData(str);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
			return true;
	return false;
}

bool APIENTRY Get_Time(int Handle, char* Time, int DeviceID)
{
	Clear(Packet, 128);
	SetCommand(CC_GetTime);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	SetExtraData(0);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
		{
			char str[16];
			int temp[4];
			GetExtraData((BYTE*)str);
			temp[0] = (BYTE)str[0];
			temp[1] = (BYTE)str[1];
			temp[2] = (BYTE)str[2];
			temp[3] = 0;
			Clear(Time, 16);
			Clear(str, 16);
			itoa(temp[2],str,10);
			strcat(Time, str);
			strcat(Time, ":");
			itoa(temp[1],str,10);
			strcat(Time, str);
			strcat(Time, ":");
			itoa(temp[0],str,10);
			strcat(Time, str);
			return true;
		}
	return false;
}

//Date YYYYMMDD
bool APIENTRY Set_Date(int Handle, char* Date, int DeviceID)
{
	Clear(Packet, 128);
	SetCommand(CC_SetDate);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	BYTE str[6];
	Splite_ChartoDecimal((BYTE*)Date, str, '/');
	SetExtraData(str);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
			return true;
	return false;
}

void APIENTRY ConvertToShamsi (char* Date)
{
	float j_day;
	int temp;
	BYTE str[8];
	char chr[16];

	Splite_ChartoDecimal((BYTE*)Date, str, '/');
	int year = Str_toInt(&str[2]);
	int mon = str[1];
	int day = str[0];
	
	j_day = 367 * year - floorf(7.0 * ( year + floorf ( ( mon + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * mon / 9 ) + day + 1721015 ;

	j_day -= 1948320;

	year = (int) ( ( 33 * j_day - 30 ) / 12053 + 1 );

	temp = (int) ( j_day - 365 * ( year - 1 ) - ( 8 * year + 21) / 33 - 1 );

	if (temp > 186)
	{
		mon = ( temp - 186 ) / 30 + 7;
		day = ( temp - 186 ) % 30 + 1 ;
	}
	else
	{
		mon = ( temp / 31 ) + 1;
		day = temp % 31 + 1;
	}

	Clear(Date, 16);
	Clear(chr, 16);
	itoa(year,chr,10);
	strcat(Date, chr);
	strcat(Date, "/");
	itoa(mon,chr,10);
	strcat(Date, chr);
	strcat(Date, "/");
	itoa(day,chr,10);
	strcat(Date, chr);

}

bool APIENTRY Get_Date(int Handle, char* Date, int DeviceID)
{
	Clear(Packet, 128);
	SetCommand(CC_GetDate);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	SetExtraData(0);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
		{
			BYTE str[8];
			char chr[16];
			int temp[5];
			GetExtraData(str);
			temp[0] = (BYTE)str[0];
			temp[1] = (BYTE)str[1];
			temp[2] = (BYTE)str[2];
			temp[3] = (BYTE)str[3];
			temp[4] = 0;
			int year = Str_toInt(&str[2]);
			Clear(Date, 16);
			Clear(chr, 16);
			itoa(year,chr,10);
			strcat(Date, chr);
			strcat(Date, "/");
			itoa(temp[1],chr,10);
			strcat(Date, chr);
			strcat(Date, "/");
			itoa(temp[0],chr,10);
			strcat(Date, chr);
			return true;
		}
	return false;
} 

bool Send_Command(int Handle)
{
	bool	bln = false;
	int		retVal;

	switch (Handle)
	{
	case Serial:
		Serial_sendArray(Packet, GetDataLength() + 17);
		Clear(Packet);
		Sleep(50);
		if(Serial_getArray(Packet, MaxSizePacket) == 0)
			bln = false; 
		else
			bln = true;
		break;
	case Ethernet:
		retVal = send(clientSock, (char*)Packet, GetDataLength() + 17, 0);     
		if(retVal == SOCKET_ERROR)    
		{        
			//MessageBox(NULL, L"Unable to send()", L"ERROR", MB_OK);        
			WSACleanup();        
			bln = false;    
		} 
		Clear(Packet);
		retVal = recv(clientSock, (char*)Packet, 128, 0);     
		if(retVal == SOCKET_ERROR)    
		{        
			//MessageBox(NULL, L"Unable to recv()", L"SOCKET ERROR", MB_OK);        
			WSACleanup();        
			bln = false;    
		} 
		bln = true;
		break;
	case Usb:

		break;
	}
	return bln;
}

void GetRealDateTime (BYTE* DateTime, DWORD JulianDay)
{
	float j_day, a, b, c, d, e, m;


    j_day = 367 * 2000 - floorf(7.0 * ( 2000 + floorf ( ( 1 + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * 1 / 9 ) + 1 + 1721014 ;

	j_day += JulianDay/(24*60*60);

    a = j_day + 32044;
	b = floorf ((4 * a + 3) / 146097);
	c = a - floorf((146097 * b) / 4);
	d = floorf((4 * c + 3) / 1461);
	e = c - floorf((1461 * d) / 4);
	m = floorf((5 * e + 2) / 153);
		
	DateTime[0] = (BYTE) (JulianDay % 60);							//Sec
	DateTime[1] = (BYTE) ((JulianDay % (60*60))/60) ;				//Min
	DateTime[2] = (BYTE) ((JulianDay % (24*60*60))/3600);			//Hour

	DateTime[3] = (BYTE) (e - floorf((153 * m + 2) / 5) + 1);		//day
	DateTime[4] = (BYTE) (m + 3 - 12 * floorf(m / 10));				//Month
	DateTime[5] = (BYTE) ( 100 * b + d - 4800 + floorf(m / 10));	//Year
	DateTime[6] = (BYTE) ((WORD)( 100 * b + d - 4800 + floorf(m / 10)) >> 8);	//Year
}

DWORD GetPackedDateTime (BYTE* DT)
{
        float j_day_1, j_day_2;

		WORD year = Str_toInt(&DT[5]);

       	j_day_1 = 367 * 2000 - floorf(7.0 * ( 2000 + floorf ( ( 1 + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * 1 / 9 ) + 1 + 1721015 ;

        j_day_2 = 367 * year - floorf(7.0 * ( year + floorf ( ( (WORD)DT[4] + 9 ) / 12.0 ) ) / 4)
		   + floorf ( 275.0 * (WORD)DT[4] / 9 ) + (WORD)DT[3] + 1721015 ;

        return ((DWORD) (j_day_2 - j_day_1) * 24*60*60 + (WORD)DT[2] * 60*60 + (WORD)DT[1] * 60 + (WORD)DT[0]);
}	

void StrToPacketDateTime(char* inDateTime, BYTE* outDateTime, char Splite)
{
	BYTE str[16];
	Splite_ChartoDecimal((BYTE*)inDateTime, str, Splite);
	if(Splite == '/')
	{
		outDateTime[0] = (BYTE)str[0];
		outDateTime[1] = (BYTE)str[1];
		outDateTime[2] = (BYTE)str[2];
		outDateTime[3] = (BYTE)str[3];
		outDateTime[4] = 0;
	}
	else if(Splite == ':')
	{
		outDateTime[0] = (BYTE)str[0];
		outDateTime[1] = (BYTE)str[1];
		outDateTime[2] = (BYTE)str[2];
		outDateTime[3] = 0;

	}
}

int APIENTRY Collect_Record(int Handle, char* fromDate, char* toDate, char* fromTime, char* toTime, int DeviceID, TrafficRecord* TF)
{
	BYTE str[8], DateTime[16], Rec[128],RecTemp[16];
	DWORD fromDateTime, toDateTime, DateT;
	TrafficRecord tfTemp;
	BYTE bFromDate[8], bToDate[8], bFromTime[8], bToTime[8];
	int i = 0;

	Clear(Packet, 128);
	SetCommand(CC_Collect);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);

	StrToPacketDateTime(fromDate, bFromDate, '/');
	StrToPacketDateTime(toDate, bToDate, '/');
	StrToPacketDateTime(fromTime, bFromTime, ':');
	StrToPacketDateTime(toTime, bToTime, ':');
	Clear(str, 8);
	strn_cpy(str, bFromTime, 3);
	strn_cpy(&str[3], bFromDate, 4);
	fromDateTime = GetPackedDateTime(str);
	Clear(str, 8);
	strn_cpy(str, bToTime, 3);
	strn_cpy(&str[3], bToDate, 4);
	toDateTime = GetPackedDateTime(str);
	Clear(DateTime, 16);
	Int_toStr(str, fromDateTime);
	strn_cpy(DateTime, str, 4);
	Int_toStr(str, toDateTime);
	strn_cpy(&DateTime[4], str, 4);
	SetData(DateTime, 8);

	SetExtraData(0);
	Make_Packet();

	tfTemp.UserID = 0;
	memset(tfTemp.DateTime, 0, 7);
	tfTemp.PC = 0;
	tfTemp.PIS = 0;
	TF[0] = tfTemp;
	if(Send_Command(Handle))
	{
		if(IsValid() && GetError() == CF_CollectionFinish)
			return 0;
		while(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
		{
			GetData(Rec);
			int rec_len = GetDataLength()/GetExtraData();
			for(int n = 0; n < GetExtraData(); n++)
			{
				strn_cpy(RecTemp,&Rec[n * rec_len + 4], rec_len - 4);
				DateT = Str_toLong(&Rec[n * rec_len], 4);
				GetRealDateTime(str, DateT);
				strn_cpy(&RecTemp[rec_len - 4], str, 7);			//DateTime = 7 byte
				strn_cpy((BYTE*)&TF[i+n], RecTemp, rec_len + 3);		//Time append to last record
			}
			i += GetExtraData();
			Clear(Packet, 128);
			SetCommand(CC_Collect);
			SetConditionBits(2);
			SetErrFlag(CF_CollectionAcknowledge);
			SetFrameNumber(0);
			SetDestinationID(DeviceID);
			SetNotData();
			SetExtraData(0);
			Make_Packet();
			Send_Command(Handle);
			//return true;
		}
		if(IsValid() && GetError() == CF_CollectionFinish)
			return i;

		return -1;
	}

	return -1;
}

CommunicationFlag  APIENTRY  Enroll_User(int Handle, int DeviceID, PersonInformation PI, FingerTemplate* FingerPrintTemplate, int NumOfFPtemplate)
{
	BYTE bBuff[64];
	Clear(Packet, 128);
	SetCommand(CC_SetPersonInfo);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetData((BYTE*)&PI, sizeof(PersonInformation));
	SetExtraData(NumOfFPtemplate);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CollectionAcknowledge)
		{
			for(int j = 0; j < NumOfFPtemplate; j++)
			{
				int TemplatSize = FP_size;
				for(int i = 0; i < 4; i++)
				{
					SetCommand(CC_SetPersonInfo);
					SetConditionBits(2);
					SetFrameNumber(0);
					SetDestinationID(DeviceID);
					SetExtraData(NumOfFPtemplate);
					if(TemplatSize > 100)
					{
						SetData(&FingerPrintTemplate[j].Template[100*i], 100);
						TemplatSize -=100;
						SetErrFlag(CF_CollectionAcknowledge);
					}
					else
					{
						SetData(&FingerPrintTemplate[j].Template[100*i], TemplatSize);
						SetErrFlag(CF_CollectionFinish);
					}
					Make_Packet();
					if(Send_Command(Handle))
					{
						if(!IsValid() || (GetError() != CF_CollectionAcknowledge && GetError() != CF_CommandExecuteSuccessfully))
							return (CommunicationFlag)GetError();
					}
					else
						return CF_PacketError;
				}
			}
			return (CommunicationFlag)GetError();
		}
		else if(IsValid())
				return (CommunicationFlag)GetError();				

	return CF_PacketError;
}

int  APIENTRY  Get_UserInfo(int Handle, int DeviceID, PersonInformation &PI, FingerTemplate* FingerPrintTemplate)
{
	int NumFingerTemp, index = 0;
	BYTE buff[128];

	Clear(Packet, 128);
	SetCommand(CC_GetPersonInfo);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	SetExtraData(PI.PersonNumber);
	Make_Packet();
	Clear((BYTE*)&PI, sizeof(PersonInformation));
	if(Send_Command(Handle))
	{
		if(IsValid() && GetError() == CF_CollectionFinish)
		{
			GetData((BYTE*)&PI);
			return d_OK;
		}
		else if(IsValid() && GetError() == CF_CollectionAcknowledge)
		{
			GetData((BYTE*)&PI);
			NumFingerTemp = GetExtraData();
			for(int i = 0; i < NumFingerTemp; i++)
			{
				index = 0;
				Clear(FingerPrintTemplate[i].Template, 512);
				//Sleep(300);
				do
				{
					SetConditionBits(2);
					SetFrameNumber(0);
					SetDestinationID(DeviceID);
					SetNotData();
					SetExtraData(i);
					SetErrFlag(CF_CollectionAcknowledge);
					Make_Packet();
					//Sleep(10);
					if(Send_Command(Handle))
						if(IsValid() && GetError() == CF_CollectionAcknowledge)
						{
							GetData(buff);
							memcpy(&FingerPrintTemplate[i].Template[index], buff, GetDataLength());
							index+= GetDataLength();
						}
						else if(IsValid() && GetError() == CF_CollectionFinish)
						{
							GetData(buff);
							memcpy(&FingerPrintTemplate[i].Template[index], buff, GetDataLength());
							break;
						}
						else
							return d_Err;
					else
						return d_Err;
				}while(GetError() != CF_CollectionFinish);
			}
			return NumFingerTemp;
		}
		else
			return d_Err;
	}
	return d_Err;
}

bool APIENTRY  Delete_Person(int Handle, unsigned int UserID, int DeviceID)
{
	Clear(Packet, 128);
	SetCommand(CC_DeletePerson);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	SetExtraData(UserID);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
			return true;

	return false;
}

bool APIENTRY  Delete_AllPerson(int Handle, int DeviceID)
{
	Clear(Packet, 128);
	SetCommand(CC_DeleteAllPerson);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	SetExtraData(0);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
			return true;

	return false;
}

int APIENTRY  Get_NumPerson(int Handle, int DeviceID)
{
	Clear(Packet, 128);
	SetCommand(CC_GetPersonalCnt);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	SetExtraData(0);
	Make_Packet();
	if(Send_Command(Handle))
		if(IsValid() && GetError() == CF_CommandExecuteSuccessfully)
			return GetExtraData();

	return d_Err;
}

int  APIENTRY  Get_AllPerson(int Handle, int DeviceID, PersonInformation *PI)
{
	int index = 0;
	BYTE buff[128];

	Clear(Packet, 128);
	SetCommand(CC_GetPersonInfo);
	SetConditionBits(2);
	SetErrFlag(CF_None);
	SetFrameNumber(0);
	SetDestinationID(DeviceID);
	SetNotData();
	SetExtraData(0);
	Make_Packet();
	Clear((BYTE*)&PI, sizeof(PersonInformation));
	if(Send_Command(Handle))
	{
		if(IsValid() && GetError() == CF_CollectionFinish)
		{
			//GetData((BYTE*)&PI[index]);
			return index;
		}
		else if(IsValid() && GetError() == CF_CollectionAcknowledge)
		{
			GetData((BYTE*)&PI[index]);
			index ++;
				do
				{
					SetConditionBits(2);
					SetFrameNumber(0);
					SetDestinationID(DeviceID);
					SetNotData();
					SetExtraData(0);
					SetErrFlag(CF_CollectionAcknowledge);
					Make_Packet();
					//Sleep(10);
					if(Send_Command(Handle))
						if(IsValid() && GetError() == CF_CollectionAcknowledge)
						{
							GetData((BYTE*)&PI[index]);
							index++;
						}
						else if(IsValid() && GetError() == CF_CollectionFinish)
						{
							return index;
						}
						else
							return d_Err;
					else
						return d_Err;
				}while(GetError() != CF_CollectionFinish);
		}
		else
			return d_Err;
	}
	return d_Err;
}