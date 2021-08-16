#include "UTILITY.H"
#include "RTOS.H"
#include "LCD.H"
#include "DATETIME.H"
#include "FS.H"

Utility::Utility(void)
{
}

Utility::~Utility()
{
}

void	Utility::Delay_ms(int Delay)
{
  Delay_us(Delay*1000);
}


void    Utility::Delay_ms(void)
{
  Delay_ms(1);
}

void    Utility::Delay_us(int  Delay)
{
  int ctr;
  for (ctr=0;ctr<Delay;ctr++)
    Delay_us();
  //OS_U32  temp1;
  //unsigned long int temp=0;

  //for(temp=0;temp<10;temp++);
  /*while(100)
  {
    OS_Timing_Start(&temp1);
    OS_Timing_End(&temp1);
    temp+=OS_Timing_Getus(&temp1);
    if (temp>=Delay)
      break;
  }*/
}

void    Utility::Delay_us(void)
{
  int ctr;
  for (ctr=0;ctr<1;ctr++);
  //Delay_us(1);
}

void    Utility::Delay_s(int  Delay)
{
  int temp;
  for(temp=0;temp<Delay;temp++)
    Delay_s();
}

void    Utility::Delay_s(void)
{
  Delay_ms(1000);
}

void    Utility::Delay(ConstantTime  CTime)
{
  if(CTime == MicroSecond)
    Delay_us();

  if(CTime == MiliSecond)
    Delay_ms();

  if(CTime == Second)
    Delay_s();

  if(CTime == Minute)
    Delay_s(60);

  if(CTime == Hour)
    Delay_s(3600);
}

bool  Utility::strn_cmp  (char *chr,const char *cst,int lenght)       //kkk
{
  int i;
    
  for(i=0;i<lenght;i++)
  {
    if(chr[i] != cst[i]) return false;
  }
  return true;
}

void  Utility::SafeCallHandler(void(*handler)(void))
{
  if (handler)
    handler();
}

void Utility::BigCenterMessage(string String)
{
  Utility util;
  string str;
  LCD lcd(Large, Farsi);

  lcd.Clear(2,Black);
  lcd.Write(A_Center, 2,String);

  util.Delay_s(2);

  str.clear();
  lcd.Clear(2,Black);

  str+=Utility::ToString(DateTime::Now().RTC_Hour,2);

  str+=":";

  str+=Utility::ToString(DateTime::Now().RTC_Min,2);

  lcd.Write(A_Center,2,str);
}

void  Utility::Inform(string Title,string Message1,string Message2, int IconIndex)
{
  LCD lcd(Small,English);
  lcd.Clear();
  lcd.font.SetSize(Large);
  lcd.DrawIcon(A_Right,0,IconIndex);
  Title+=':';
  lcd.font.SetSize(Small);
  lcd.Write(2,Title);
  lcd.Write(4,Message1);
  lcd.Write(6,Message2);
}

void Utility::ShortMessage(string ShortMessage)
{
   LCD lcd(Small,Farsi);
   lcd.Clear(6);
   lcd.Write(A_Center,6,ShortMessage);
}


string Utility::ToString(unsigned long int Number)
{
  string str;

  str.clear();

  if (Number == 0)
  {
    str+="0";
    return str;
  }

  while(Number>0)
  {
    str += ToChar(Number%10);
    Number/=10;
  }
  ReverseString(str);

  return str;
}

string Utility::ToString(unsigned long int Number, int Length)
{
  string str;

  str.clear();

  int ctr;

  if (Number == 0)
  {
    str+="0";
  }

  while(Number>0)
  {
    str += ToChar(Number%10);
    Number/=10;
  }

  if (str.length()<Length)
    for (ctr=str.length();ctr != Length;ctr++)
      str+='0';

  ReverseString(str);

  return  str;
}


string Utility::ToHexString(DWORD HexNumber)
{
  string str;
  str.clear();

  if (HexNumber == 0)
  {
    str+="0";
    return str;
  }

while(HexNumber>0)
{
  str += ToHexChar(HexNumber%16);
  HexNumber/=16;
}

    ReverseString(str);

return str;
}

void Utility::ReverseString(string &String)
{
  int ctr;
  char ch;
  for(ctr=0;ctr<String.size()/2;ctr++)
{
  ch = String[ctr];
  String[ctr] = String[String.size()-ctr-1];
  String[String.size()-ctr-1] = ch;
}
}

char Utility::ToHexChar(int HexNumber)
{
  if (HexNumber>=0 && HexNumber<=9)
    return HexNumber+'0';
  if (HexNumber>=10 && HexNumber<=15)
    return HexNumber-10+'A';
  return '-';
}

char Utility::ToChar(int Number)
{
  if (Number>9 || Number<0)
    return '0';
  return '0'+Number;
}

void  Utility::ToCharArray(string String, char CharArray[])
{
    int ctr;
    for (ctr=0;ctr<String.size();ctr++)
      CharArray[ctr] = String[ctr];
    CharArray[ctr]=0;
}

void  Utility::TrimStarsFromRight(char  str[])
{
    int counter;
    for (counter = 0; counter <strlen(str) ; counter ++)
        if (str[counter] == '*')
        {
            str[counter] = 0;
            return;
        }
}




/*void     Utility::SafeCreateTimer(OS_TIMER* Timer, void (*TimerEventFunction)(void), OS_TIME Timeout )
{
  if (OS_GetTimerStatus(Timer))
    OS_DeleteTimer(Timer);

  OS_CreateTimer(Timer,TimerEventFunction,Timeout);
  OS_StartTimer(Timer);
}*/


unsigned long int Utility::ToU32(char  Number[])
{
  int   counter;
    unsigned long int temp=0;

  for (counter =0;counter<strlen(Number);counter++)
  {
    temp *=10;
    temp += Number[counter]-'0';
  }
    return  temp;
}

unsigned long int Utility::ToU32(string Number)
{
  int   counter;
    unsigned long int temp=0;

  for (counter =0;counter<Number.size();counter++)
  {
    temp *=10;
    temp += Number[counter]-'0';
  }
    return  temp;
}

BOOL    Utility::IsFileValid(char    FullFilePath[])
{
    FS_FILE     *fp;
    BOOL        validation = false;

    fp = FS_FOpen(FullFilePath,"r");

    if (fp != NULL)
        validation = true;

    FS_FClose(fp);

    return validation;
}

void     Utility::ToString(unsigned long int Number, char *Str)
{
    char  ch;
    unsigned long int temp,ctr,len=0;
    temp = Number;
    ctr=0;

    while(temp>0)
    {
        len++;
        temp/=10;
    }

    //Str = new char(len+1);
    Str[len]=0;

    for(ctr=0;ctr<len;ctr++)
    {
        Str[ctr] = Number %10+'0';
        Number /= 10;
    }

    for(ctr=0;ctr<len/2;ctr++)
    {
        ch = Str[len-ctr-1];
        Str[len-ctr-1] = Str[ctr];
        Str[ctr] = ch;
    }
}

int     Utility::GetDigitsCount(unsigned int Number)
{
    int len=0;

    while(Number>0)
    {
        len++;
        Number/=10;
    }
    return len;
}


void     Utility::SafeCreateTask(OS_TASK* TCB, char const* TaskName, unsigned char Periority,void (*TaskFunction)(void),  void* Stack, unsigned StackSize, unsigned char TimeSlice )
{
  if (OS_IsTask(TCB))
    //OS_Terminate(TCB);
    return;

  OS_CreateTask(TCB, TaskName, Periority, TaskFunction, Stack, StackSize, TimeSlice);
}

