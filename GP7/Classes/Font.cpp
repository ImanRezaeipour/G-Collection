#include 	"FONT.H"

Font::Font ()
{   
	
}

Font::~Font ()
{  
	
}

void Font::NumberRepresentation (Language L)
{
	number_representation = L;
}

void Font::SetSize (Size S)
{
	size = S;
}

int Font::GetFontHeight ()
{
	if (size == Small)
		return 16;
	if (size == Medium)
		return 24;
	if (size == Large)
		return 32; 
  
	return 16; 
}

int Font::GetFontLengh ()
{
	if (size == Small)
		return 31;
	if (size == Medium)
		return 55;
	if (size == Large)
		return 101; 
  
	return 31; 
}

int Font::GetCharacterLength (char Character)
{
	return *(find_internal_address_in_table(find_table(Character), find_internal_address(Character)));
}

int Font::GetCharacterLength (char Character, int Displacement)
{
	BYTE * temp;
	int t;

	temp = find_table(Character);
	
	t = find_internal_address(Character)+Displacement;
	
	return *find_internal_address_in_table(temp, t);  
	// return *(find_internal_address_in_table(find_table(Character), find_internal_address(Character)+Displacement));
}

int   Font::GetIconLenght (int Index)
{
	if (size==Small)
		return *(find_internal_address_in_table((BYTE*)s_icons,Index));
	if (size==Medium)
		return *(find_internal_address_in_table((BYTE*)m_icons,Index));
	if (size==Large)
		return *(find_internal_address_in_table((BYTE*)b_icons,Index));   

	return 0;
}

int Font::GetStringLength (string String)       //is disable
{
	int ctr,len=0,dis, ch_length;
  
	for (ctr=0;ctr<String.length();ctr++)    
	{
		dis = GetDisplacement(ctr<1?' ':String[ctr-1],String[ctr], ctr<(String.length()-1)?String[ctr+1]:' ');
        
		ch_length = GetCharacterLength(String[ctr],dis);  
        
		len+=ch_length;
	}  

	return len;
}

BYTE* Font::GetStartAddress (char Character)
{
	return find_internal_address_in_table(find_table(Character), find_internal_address(Character))+1;
}

BYTE* Font::GetStartAddress (char Character, int Displacement)
{
	BYTE * temp;
	int t;
	
	temp = find_table(Character);
	t = find_internal_address(Character)+Displacement;

	return find_internal_address_in_table(temp, t)+1;
}  

BYTE* Font::GetIconStart (int Index)
{
	if (size==Small)
		return find_internal_address_in_table((BYTE*)s_icons,Index)+1; 
	if (size==Medium)
		return find_internal_address_in_table((BYTE*)m_icons,Index)+1;
	if (size==Large)
	return find_internal_address_in_table((BYTE*)b_icons,Index)+1;   

	return 0;
}

BYTE* Font::GetStartLogoArray (void)
{
	return (BYTE*)logo;
}

int Font::GetDisplacement (char Char2, char Char1, char Char0)
{
	int start=1,end=1; //0 лог 
      
	if (Char0 ==' ' )
	{
		start =0;
	}

	if (Char2 ==' ' )
	{
		end =0;
	}
    
	if (Char1<=0x80)
	{
		start=0;
		end=0;
	}
           
	if (Char0 == 0xbf || 
        Char0 >= 0xc1 && Char0 <= 0xc7 ||
        Char0 >= 0xcf && Char0 <= 0xd2 ||
        Char0 == 0x8e ||
        Char0 == 0xe6)
		start =0;
    
	if (Char2 == 0xbf || 
        Char2 >= 0xc1 && Char2 <= 0xc6)
		end =0;
     
	/*if (Char0 !=' ' && Char2 == ' ')
		return 1;
  
	if (Char0 ==' ' && Char2 != ' ')
		return 3;
 
	if (Char0 !=' ' && Char2 != ' ')
		return 2;  */

	if (start ==0 && end ==0) return 0;
	if (start ==1 && end ==0) return 3;
	if (start ==0 && end ==1) return 1;
	if (start ==1 && end ==1) return 2;

	return 0;
}
 
int Font::find_internal_address (char Character)
{  
	if (Character == 0x20)
		return 0;
  
	if (Character >= '0' && Character <= '9' && number_representation == Farsi)
		return Character - 0x30;  
  
	if (Character < 0x80)
		return Character - 0x21;
    
	if (Character == 0x81)
		return 39*4;
  
	if (Character == 0x8d)
		return 38*4;

	if (Character == 0x8e)
		return 41*4;

	if (Character == 0x90)
		return 40*4;

	if (Character == 0x98)
		return  31*4;
  
	if (Character == 0xe1)
		return  32*4;
  
	if (Character == 0xe3)
		return  33*4;
  
	if (Character == 0xe4)
		return  34*4;
  
	if (Character == 0xe5)
		return  35*4;
  
	if (Character == 0xe6)
		return  36*4;
  
	if (Character == 0xec)
		return  37*4;

	if (Character == 0xed)
		return 37*4;  
  
	if (Character > 0x80 )
		return (Character - 0xbf-1)*4;

	return 0;
}

BYTE* Font::find_table (char Character)
{
/*
       if (Character == 0x20 && size == Small)
		return (BYTE*) s_space;
  
	if (Character == 0x20 && size == Medium)
		return (BYTE*) m_space;

	if (Character == 0x20 && size == Large)
		return (BYTE*) b_space;
*/
	if (Character >= '0' && Character <= '9' && number_representation == Farsi && size == Small)
		return (BYTE*) s_f_n_chars;
	if (Character >= '0' && Character <= '9' && number_representation == Farsi && size == Medium)
		return (BYTE*) m_f_n_chars;
	if (Character >= '0' && Character <= '9' && number_representation == Farsi && size == Large)
		return (BYTE*) b_f_n_chars;  

	if (Character <= 0x80 && size == Small)
		return (BYTE*) s_e_chars;
	if (Character <= 0x80 && size == Medium)
		return (BYTE*) m_e_chars;
	if (Character <= 0x80 && size == Large)
		return (BYTE*) b_e_chars;

	if (Character >= 0x80 && size == Small)
		return (BYTE*) s_f_chars;
	if (Character >= 0x80 && size == Medium)
		return (BYTE*) m_f_chars;
	if (Character >= 0x80 && size == Large)
		return (BYTE*) b_f_chars;
  
	/*if (Character >= '0' && Character <= '9' && number_representation == English && size == Small)
		return (BYTE*) s_e_chars;
	if (Character >= '0' && Character <= '9' && number_representation == English && size == Large)
		return (BYTE*) b_e_chars;*/

	return 0;
}

BYTE* Font::find_internal_address_in_table(BYTE* table, int internal_address)
{  
	int ctr;
	
	for (ctr=0;ctr<internal_address;ctr++)
		table = table + *(table)*GetFontHeight()/8+1;

	return table;  
}

Language Font::Get_LanguageNum(void)
{
 return number_representation; 
} 
