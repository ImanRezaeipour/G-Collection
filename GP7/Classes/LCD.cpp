#include "STRING"
#include "RTOS.H"
#include "LCD.H"
#include "HARDWARE.H"
#include "UTILITY.H"
//#include "FONT.H"
#include "MATH.H"
#include "Font2.h"

LCD::LCD ()
{
	format = PF_Normal;
	//is_animate = false;
	font.SetSize(Small);
	font.NumberRepresentation(English);
}

LCD::LCD (Language DigitLang)
{
	format = PF_Normal;
	//is_animate = false;
	font.SetSize(Small);
	font.NumberRepresentation(DigitLang);
}

LCD::LCD (Size S, Language DigitLang)
{
	format = PF_Normal;
	//is_animate = false;
	font.SetSize(S);
	font.NumberRepresentation(DigitLang);
}

LCD::~LCD ()
{
	
}

void LCD::PowerMode (Power Mode)
{
	if (Mode == On)
		send_command(0x3f);
	if (Mode == Off)
		send_command(0x3e);
}

void LCD::Clear (void)
{
	Clear(Black);
}

void LCD::Clear (Color C)
{
	Clear(0,0,127,7,C);
}

void    LCD::Clear(int Line)
{
	Clear(0,Line,127,Line+font.GetFontHeight()/8-1,Black);
}

void    LCD::ClearSmallest(int Line, Color C)
{
	ClearS(0,Line,127,Line,C);
}

void LCD::Clear (int Line, Color C)
{
	Clear(0,Line,127,Line+font.GetFontHeight()/8-1,C);
}

void LCD::Clear (int x1, int y1, int x2, int y2, Color C)
{
	for(int y=y1;y<=y2;y++)
	{
		gotoxy(x1,y);
		for(int x=x1;x<=x2;x++)
		{
			if (x==64)
			gotoxy(64,y);
			lcd_send(C==Black?0:0xff,Data);
		}
	}
}

void LCD::ClearS (int x1, int y1, int x2, int y2, Color C)
{
	for(int y=y1;y<=y2;y++)
	{
		gotoxy(x1,y);
		for(int x=x1;x<=x2;x++)
		{
			if (x==64)
			gotoxy(64,y);
			lcd_send(C==Black?0xf0:0x0f,Data);
		}
	}
}

void LCD::Write (string String)
{
	Write(A_Center,String);
}

void LCD::Write (int Line, string String)
{
	Write(0,Line,String);
}
/*
void LCD::Write(int x, int y, string String) //major
{
	int ctr, ch_length,ch_height,dis;
	char ch;
	BYTE * ch_add;
	Utility u;

	if (is_persian(String))
		Utility::ReverseString(String);

	ch_height = font.GetFontHeight();

	for (ctr=0;ctr<String.length();ctr++)
	{
		ch = String[ctr];

		dis = font.GetDisplacement(ctr<1?' ':String[ctr-1],ch, ctr<(String.length()-1)?String[ctr+1]:' ');

		ch_add = font.GetStartAddress(ch,dis);
		ch_length = font.GetCharacterLength(ch,dis);

		draw_symbol(x,y,ch_length,ch_height,ch_add);
		x+=ch_length;
	}
}
*/
void LCD::Write(int x, int y, string String) //major
{
	int ctr, ch_length,ch_height,index,length;
        BYTE *bTable;
        bool  fa=FALSE,st=FALSE;
        Font2 fnt;
	//BYTE * ch_add;
	//Utility u;

	if (is_persian(String))
          st=TRUE;
		//Utility::ReverseString(String);
	ch_height = font.GetFontHeight();
        length=font.GetFontLengh();
        
        if(font.Get_LanguageNum() == Farsi)
          fa=TRUE;
	for (ctr=0;ctr<String.length();ctr++)
	{
		//ch = String[ctr];
                index=fnt.GetIndex(String,ctr,fa); 
                bTable=font.find_table(String[ctr]);
                ch_length = bTable[index*length];
		//dis = font.GetDisplacement(ctr<1?' ':String[ctr-1],ch, ctr<(String.length()-1)?String[ctr+1]:' ');

		//ch_add = font.GetStartAddress(ch,dis);
		//ch_length = font.GetCharacterLength(ch,dis);
                lcd_putchar(String[ctr],index*length,x,y,ch_height,ch_length,st);
		//draw_symbol(x,y,ch_length,ch_height,ch_add);
                if(st)
		  x-=ch_length;
                else
                  x+=ch_length;
	}
}

void    LCD::Write(Alignment Align, string String)
{
	int height = font.GetFontHeight();

	height = 8 - height/8;
	height = (height/2 + height%2);
	
	Write(Align,height, String);
}

void LCD::Write (Alignment Align, int Line, string String)
{
	string str_temp;
        Font2 fnt;
	str_temp = String;

	//if (is_persian(str_temp))
		//Utility::ReverseString(str_temp);

	int len = Get_Length(str_temp);

	if (Align == A_Center)
	{
		//len = 127 - len;
		//len/=2;
          if (is_persian(str_temp))
              len = 128/2 +len/2;
          else
              len = 128/2 - len/2;
         //   len/=2;
        //  }    
	}

	if (Align == A_Left)
	{
		//len=0;
          if (! is_persian(str_temp))
            len=0;
	}

	if (Align == A_Right)
	{
          if (is_persian(str_temp))
      	    len = 127 ;//- len;
          else
            len = 127 - len;
	}

	Write(len,Line,String);
}

void LCD::DrawIcon (int Line, int Index)
{
	DrawIcon(0,Line,Index);
}

void LCD::DrawIcon (int X, int Y, int index)
{
	int ch_length,ch_height;
	BYTE * ch_add;

	ch_height = font.GetFontHeight();
	ch_add = font.GetIconStart(index);
	ch_length = font.GetIconLenght(index);

	draw_symbol(X,Y,ch_length,ch_height,ch_add);
}

void LCD::DrawIcon (Alignment Align, int Line, int Index)
{
	int len = font.GetIconLenght(Index);

	if (Align == A_Center)
	{
		len = 128 - len;
		len/=2;
	}

	if (Align == A_Left)
	{
		len=0;
	}

	if (Align == A_Right)
	{
		len = 128 - len;
	}

	DrawIcon(len,Line,Index);
}

void LCD::DrawEntireScreen (BYTE * BitmapStartAddress)
{
	BYTE * temp;
	int x,y;

	temp = BitmapStartAddress;

	for(y=0;y<8;y++)
	{
		gotoxy(0,y);
		for(x=0;x<128;x++)
		{
			if (x==64)
				gotoxy(64,y);
			lcd_send(* temp ^ 0xff,Data);
			temp++;
		}
	}
}

void LCD::SetPixelFormat (PixelFormat Format)
{
	format = Format;
}

void LCD::initial_hardware (void)
{
	Hardware h;

	Utility u;

	h.LCDPortInit();

	h.LCDReset(0);
	u.Delay_ms();
	h.LCDReset(1);

	h.LCDEnable(0);
	h.LCDDI(0);
  	h.LCDCS1(0);
	h.LCDCS2(0);
}

void LCD::initial_members (void)
{
	format = PF_Normal;
}

void LCD::create_timers (void)
{
	//
}

BOOL LCD::is_persian (string String)
{
	BOOL flag;
	int ctr1;

	flag = false;
	for (ctr1=0;ctr1<String.length();ctr1++)
	{
		/*
		if (String[ctr1]>='0' && String[ctr1]<='9')
			continue;
		if (String[ctr1] == 0x20)
			continue;
		if (String[ctr1]<0x80)
			flag = 0;*/
		if (String[ctr1]>0x80)
			flag = true;
	}

	return flag;
}

void LCD::draw_symbol (int x, int y, int w, int h, BYTE* start_address)
{
	int ctr1, ctr2;
	BYTE  data;
	Utility u;

	for(ctr1=0 ; ctr1<w ; ctr1++)
	{
		//if (is_animate)
		//	u.Delay_ms(30);
	
		for (ctr2=0 ; ctr2<ceil(h/8.0) ; ctr2++)
		{
			data=*(start_address + ctr1 + w*ctr2);

			if (format == PF_Invert)
				data ^=0xff;

			send_data(data,x+ctr1,y+ctr2);
		}
	}
}

int LCD::Get_Length (string String)       //kkk
{
	int ctr,len=0,dis, ch_length,length;
        BYTE *bTable;
        Font2 fnt;
        bool fa;
 
        //font.SetSize(Small);
        //font.NumberRepresentation(Farsi);
        //ch_height = font.GetFontHeight();
        length=font.GetFontLengh();
        
        if(font.Get_LanguageNum() == Farsi)
          fa=TRUE;
        for (ctr=0;ctr<String.length();ctr++)
        {
         dis=fnt.GetIndex(String,ctr,fa); 
         bTable=font.find_table(String[ctr]);
         ch_length = bTable[dis*length]; 
         len+=ch_length;
        } 
	return len;
}

void LCD::lcd_putchar(char character,int index,int x,int y,int h,int w,bool st)   //kkk
{  
    int width_counter,ch_height,i;
    BYTE *bTable;
    //Font f;
    BYTE data;
    
    if(st)
      i=x-w;
    else
      i=x;
    //x -=w;
    bTable=font.find_table(character);
    
    for(width_counter=0; width_counter<w; width_counter++)
     {
      for(ch_height=0; ch_height< h/8; ch_height++)
      { 
       data=bTable[++index]; 
       if (format == PF_Invert)
	data ^=0xff; 
       send_data(data, i+width_counter,y+ch_height);
      }
     }    
} 

void LCD::chip_enable (Direction chip, Activity activity)
{
	Hardware h;

	if (chip == Left)
		if (activity == A_Enable)
			h.LCDCS1(1);
		else
			h.LCDCS1(0);

	if (chip == Right)
		if (activity == A_Enable)
			h.LCDCS2(1);
		else
			h.LCDCS2(0);
}

void LCD::lcd_send (BYTE data, DataType type)
{
	Hardware h;
	Utility u;

        h.LCDEnable(0);
        h.LCDRW(0);
        //u.Delay_us(1);
	
	if(type == Command)
		h.LCDDI(0);
	else if (type == Data)
		h.LCDDI(1);
        h.LCDDispatchData(data);

        u.Delay_us(1);
	h.LCDEnable(1);

        u.Delay_us(1);

	h.LCDEnable(0);
}

void LCD::send_data (BYTE data, int x, int y)
{
	gotoxy(x,y);
	lcd_send(data, Data);
}

void LCD::send_data (BYTE data)
{
        chip_enable(Left, A_Enable);
        chip_enable(Right, A_Enable);
	lcd_send(data, Data);
}

void LCD::send_command (BYTE command)
{
	chip_enable(Left, A_Enable);
        chip_enable(Right, A_Enable);
	lcd_send(command, Command );
}

void    LCD::gotoxy(int x, int y)
{
	set_x(y);

	if (x<64)
	{
		set_y(x);
		
		chip_enable(Left,A_Enable);
		chip_enable(Right,A_Disable);
	}
	else
	{
		set_y(x-64);
		
		chip_enable(Left,A_Disable);
		chip_enable(Right,A_Enable);
	}
}

void LCD::set_x (int loc)  //0-127
{
	if (loc > 7)
		loc = 7;
	
	BYTE temp;
	temp=loc;
	temp|=0xb8;
	
	send_command(temp);
}

void LCD::set_y (int loc)  //0-63
{
	if (loc > 63)
		loc = 63;
	
	BYTE temp;
  	temp=loc;
  	temp|=0x40;

	send_command(temp);
}

/*void LCD::ScrollUp (int Line)
{
	if (Line>63)
		return;

	BYTE cmd =0;
	cmd |= 0xc0;
	cmd |= (BYTE) Line;

	send_command(cmd);
} */
	
	

