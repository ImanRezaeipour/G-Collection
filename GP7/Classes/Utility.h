#ifndef __UTILITY__
#define __UTILITY__

#include "DATATYPE.H"
#include "STRING"
#include "RTOS.H"

class Utility
{
public:
        Utility   (void);
        ~Utility  ();
  void  Delay_ms  (int Delay);
  void  Delay_ms  (void);
  void  Delay_us  (int  Delay);
  void  Delay_us  (void);
  void  Delay_s   (int Delay);
  void  Delay_s   (void);
  void  Delay     (ConstantTime CTime);
  bool  strn_cmp  (char *chr,const char *cst,int lenght);
  //static void     SafeCreateTimer   (OS_TIMER* Timer, void (*TimerEventFunction)(void), OS_TIME Timeout );

  static void     SafeCallHandler   (void(*handler)(void));
	static void     SafeCreateTask(OS_TASK* TCB, char const* TaskName, unsigned char Periority,void (*TaskFunction)(void),  void* Stack, unsigned StackSize, unsigned char TimeSlice );
  static void     Inform(string Title, string Message1, string Message2,int IconIndex);
  static void     ShortMessage(string ShortMessage);
  static void     BigCenterMessage(string String);

  static string   ToHexString(DWORD HexNumber);
  static char     ToHexChar(int HexNumber);

  static void     ReverseString(string &String);

  static string   ToString(unsigned long int Number);
  static string   ToString(unsigned long int Number, int Length);
  static char     ToChar(int Number);
  static void     ToCharArray(string String, char CharArray[]);
  static void     ToString(unsigned long int Number, char *Str);
  static    void  TrimStarsFromRight(char  str[]);
  static    unsigned long int ToU32(char  Number[]);
  static    unsigned long int ToU32(string  str);
  static    int     GetDigitsCount(unsigned int Number);

  static    BOOL    IsFileValid(char    FullFilePath[]);
	

private:

  static void timer_elapse(void);
  static BOOL elapse;

};
#endif

