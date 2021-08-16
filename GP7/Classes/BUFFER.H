#ifndef   	__BUFFER__
#define		__BUFFER__

#include 	"DATATYPE.H"
#include 	"STRING"

class Buffer
{
public:
  	Buffer ();
	~Buffer ();
	
	void Fill (BYTE *Data, int Size);
	void Fill (BYTE* Data, int FirstLocation, int Size);

  	void Fill (BYTE Data, int Location);
	
	void Insert (BYTE Data, int Location);
	void Delete (int Location);
	void DeleteLastCell (void);
	void DeleteFirstCell (void);
		
	void Clear (void);

  	int Size (void);  	
	int EmptySpace (void);
       	bool IsBufferFull (void);	
	
  	BYTE* GetStartAddress (void);

  	BYTE operator[] (int Index);
  	void operator+= (BYTE B);
  	void operator+= (char C);
  	void operator+= (string S);
  	void operator= (Buffer B);
	bool operator== (Buffer B);
	bool operator== (string S);

       	void SetBufferFullEvent (EventPointer EP);	
	
	string GetString (int FirstLocation, int LastLocation);
	double GetValue (int FirstLocation, int LastLocation);

	string GetString (void);
	double GetValue (void);
	
private:
	void disable_events (void);
	
	void append (BYTE b);
	
	void safe_call_handler (EventPointer EP);
	
  	const int max_len;
  	int index;

	EventPointer ep_buffer_full;
	
  	BYTE p[128];
};
#endif