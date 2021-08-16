#include	"LOGDEVICE.H"
#include 	"LOG.H"
#include	"BUFFER.H"
#include	"DIGITALDATA.H"


LogDevice::LogDevice ()
:Log(true, true, true, true)
{

}

LogDevice::~LogDevice ()
{

}

void LogDevice::Finger (DWORD ID)
{
	Buffer b(10);
	DigitalData d;	
	
	d.SetDword (ID);
	
	b += d.GetByte(0);	
	b += d.GetByte(1);	
	b += d.GetByte(2);	
	b += d.GetByte(3);	
	
	LogData("\\Finger.INF", &b);  
}

void LogDevice::Mifare (DWORD ID)
{
	Buffer b(10);
	DigitalData d; 	

	d.SetDword (ID);
	
	b += d.GetByte(0);	
	b += d.GetByte(1);	
	b += d.GetByte(2);	
	b += d.GetByte(3);	
	
	LogData("\\Mifare.INF", &b);  
}

