#include 	"CONTROL.H"

#define CRP1  0x12345678
#define CRP2  0x87654321
//#define CRP3  0x43218765
#define NOCRP 0x11223344

#pragma section="CRP_Pattern"
#pragma location="CRP_Pattern"
__root const unsigned long CRP = NOCRP;


void main(void) 
{
  	Control system;
        
  	system.Initial();
  	system.Run(); 
}
