#ifndef 	__LCD__
#define 	__LCD__

#include 	"DATATYPE.H"
#include 	"STRING"
#include 	"FONT.H"
#include	"HRESOURCE.H"

class LCD : public HardwareResource
{
public:
	LCD ();
	LCD (Language DigitLang);
        LCD (Size S, Language DigitLang);
        ~LCD ();

 	void PowerMode(Power Mode);

	void Clear (void);
	void Clear (Color C);
	void Clear (int Line);
	void Clear (int Line, Color C);
	void Clear (int x1, int y1, int x2, int y2, Color C);
        void ClearSmallest(int Line, Color C);
	
	void Write (string String);
	void Write (int Line, string String);
	void Write (int x, int y, string String);
	void Write (Alignment Align, string String);
	void Write (Alignment Align, int Line, string String);

	void DrawIcon (int Line, int Index);
	void DrawIcon (int X, int Y, int index);
	void DrawIcon (Alignment Align, int Line, int Index);

	void DrawEntireScreen (BYTE * BitmapStartAddress);
	
	void SetPixelFormat(PixelFormat Format);
	
	Font font;
	
private:
	void initial_hardware (void);
	void initial_members (void);	

	void create_timers (void);
	
	BOOL is_persian(string String);
	
	void draw_symbol (int x, int y, int w, int h, BYTE* start_address);
        
        void ClearS (int x1, int y1, int x2, int y2, Color C);

	void chip_enable (Direction chip, Activity activity);

	void lcd_send (BYTE data, DataType type);

	void send_data (BYTE data, int x, int y);
	void send_data (BYTE data);

	void send_command (BYTE command);

	void gotoxy (int x, int y);
	
	void set_x (int loc);
	void set_y (int loc);
        
        void lcd_putchar(char character,int index,int x,int y,int h,int w,bool st);    //kkk
        
        int  Get_Length (string String);
	PixelFormat format;
};


#endif
