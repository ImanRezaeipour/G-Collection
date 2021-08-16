#ifndef 	__CODING__
#define		__COGING__

#include	"DATATYPE.H"
#include	"BUFFER.H"

class Coding
{
public:
	Coding();
	~Coding();
	
	void SetValue (BYTE V);
	
	BYTE GetValue (void);
	
	void DoCoding (void); 	
	BYTE DoCoding (BYTE Value);
	void DoCoding (Buffer * B);
	
	void DoEncoding (void);
	BYTE DoEncoding (BYTE Value);
	void DoEncoding (Buffer * B);
	
private:
        void permutation (void);
	void substitution (void);
	
	BYTE value;
};
#endif


	