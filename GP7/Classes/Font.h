#ifndef   	__FONT__
#define   	__FONT__

#include 	"STRING"
#include 	"FONT.D"

class Font
{
public:
	Font ();
	~Font ();

	void NumberRepresentation (Language L);
  
	void SetSize (Size S);
  
	int GetFontHeight (void);
	int GetFontLengh  (void);
	int GetCharacterLength (char Character);
	int GetCharacterLength (char Character, int Displacement);
	int GetIconLenght (int Index);  
	int GetStringLength (string String);

	BYTE* GetStartAddress (char Character);  
	BYTE* GetStartAddress (char Character, int Displacement);
	BYTE* GetIconStart (int Index);
	BYTE* GetStartLogoArray (void);
	BYTE* find_table (char Character);
	int GetDisplacement (char Char0, char Char1, char Char2); 
	Language Get_LanguageNum(void);	
private :
	int find_internal_address (char Character);
//	BYTE* find_table (char Character);
	BYTE* find_internal_address_in_table (BYTE* table, int internal_address);
	
	Language number_representation;

	Size size;
};
#endif