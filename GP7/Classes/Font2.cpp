
/*********************************************************************
*
*      GUI_FARSI 
*
**********************************************************************
*/
#include "Font2.h"
#include "type.h"
#include "Font.h"
//extern Font font;
/*********************************************************************
*
*     data 
*
*********************************************************************/

Font2::Font2 ()
{   
	
}

Font2::~Font2 ()
{  
	
}

/*********************************************************************
*
*       GetTableIndex
*********************************************************************/
char Font2::GetTableIndex(char c) 
{
    
  if (c < 0x81) {
    return 0;
  }
  if (c > 0xED) {
    return 0;
  }
  if ((c >= 0xC2) && (c <= 0xD6)) {
    return c - 0xC1;
  }
  if ((c >= 0xD8) && (c <= 0xDB)) {
    return c - 0xD8 + 22;
  }
  if ((c >= 0xDD) && (c <= 0xDE)) {
    return c - 0xDD + 26;
  }
  if ((c >= 0xE3) && (c <= 0xE6)) {
    return c - 0xE3 + 30;
  }
  if (c == 0xE1) {
    return 29;
  }
  if (c == 0x81) {
    return 36;
  }
  if (c == 0x8D) {
    return 37;
  }
  if (c == 0x8E) {
    return 38;
  }
  if (c == 0x98) {
    return 39;
  }
  if (c == 0x90) {
    return 40;
  }  
  if (c == 0xED) {
    return 41;  
  }
  return 0;
}
/*********************************************************************
*
*       GetTableUnicode
*********************************************************************/
int Font2::GetTableUnicode(string str,int i)
{
int next,previous,index;

index=GetTableIndex(str[i]);

if(index==0) return 0;

if(i==0) 		
  previous=0;
else
  previous=str[i-1];

if(i==(str.length()-1))	
  next=0;
else
  next=str[i+1];

if((previous>=0x20 && previous<=0x7E)|| previous==0 ||  previous=='Â' ||  previous=='Ž' || previous=='Ç' || previous=='æ' || previous=='Ò' || previous=='Ñ' || previous=='Ï' || previous=='Ð' || previous==' '|| previous=='¡'|| previous=='º'|| previous=='¿'|| previous=='Á' )
  previous=0;

if((previous>=0x20 && previous<=0x7E)|| next==0 || next==' ' || next=='¡'|| next=='º'|| next=='¿'|| next=='Á')
  next=0;

if(previous ==0 && next ==0)
  return aKeyInfo[index].Isolated;

if(previous !=0 && next ==0)
  return aKeyInfo[index].Final;

if(previous ==0 && next !=0)
  return aKeyInfo[index].Initial;

if(previous !=0 && next !=0)
  return aKeyInfo[index].Medial;

  return 0;

}
/*********************************************************************
*
*       GetIndex
*********************************************************************/
int Font2::GetIndex(string str,int i,bool fa)
 {
      int ch;
      int mid,tmp;
            
      if (str[i] == 0xA1) {
        return 0;  
      }
     // if (str[i] == 0xBA) {
     //   return 1;  
     // }
      if (str[i] == 0xBF) {
        return 1;  
      }
      //if (str[i] == 0xC1) {
     //   return 3+0xEF;  
     // }
      if(str[i] >= 0x30 && str[i] <= 0x39 && fa == TRUE) {
         return str[i] - 0x30;
      }
        
      if(str[i] >= 0x20 && str[i] <= 0x7E) {
        return str[i] - 0x20;
      }
      
      ch=GetTableUnicode(str,i);
      
      if(ch==0) return 0;
      
        int left = 0, right = sizeof(index_table)/sizeof(int);
        while (left <= right) {
            mid = (right + left) / 2;
            tmp = index_table[mid];
            if (tmp == ch)
                return mid+2;//+0x5F;

            if (ch < tmp)
                right = mid - 1;
            else
                left = mid + 1;
        }

        return 0;   // not found, return the first character
 }
/*********************************************************************
*
*       GetStringLength
*********************************************************************/

/*********************************************************************
*
*       GetTableIndex
*********************************************************************/
  /*  
void Font2::lcd_writechar(WORD index,int x,int y,int forground_color,int background_color,int transparent_mode)
    {  
    int width_counter,length_counter;
    int character_segment_data;
#ifdef LANDSCAPE 
    y=240-y;
#else
    y=320-y;
#endif    
    
    for(width_counter=1;width_counter<=B_Sina15x14[index*16];width_counter++)
        {
        character_segment_data=B_Sina15x14[index*16+width_counter];
        for(length_counter=0;length_counter<16;length_counter++)
            {
            if(character_segment_data & (1<<length_counter)) 
              //tftlcd_write_pixel((x_text*8)+width_counter,(y_text*16)+length_counter,forground_color);
              tftlcd_write_pixel(x+width_counter,y-length_counter,forground_color);
	    else
	      {
		if(!transparent_mode)
                  tftlcd_write_pixel(x+width_counter,y-length_counter,background_color);
		  //tftlcd_write_pixel((x_text*8)+width_counter,(y_text*16)+length_counter,background_color);
		//else
                  //tftlcd_write_pixel((x_text*8)+width_counter,(y_text*16)+length_counter,tftlcd_read_pixel((x_text*8)+width_counter,(y_text*16)+length_counter));
		};
	    };
        };
    
    if(++x_text>40)
        {            
        x_text=0;
        if(++y_text>15) y_text=0;
        };
    
    }*/
