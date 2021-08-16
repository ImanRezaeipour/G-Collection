#ifndef 	__LOGDEVICE__
#define 	__LOGDEVICE__

#include 	"RTOS.H"
#include 	"DATATYPE.H"
#include	"LOG.H"


class LogDevice : public Log
{
public:  
	LogDevice();
	~LogDevice();

	void Finger (DWORD ID);
	void Mifare (DWORD ID);

	//void Key (string Str);
	
	//void System (SystemEvent SE);
	
	//void LogCommunicationReceivedCommand (); 
};
#endif
  