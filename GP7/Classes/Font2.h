#ifndef 	__FONT2__
#define 	__FONT2__

#include  	"STRING"
#include        "DataType.h"
//#include  	"RTOS.H"
//#include	"MRESOURCE.H"

class Font2
{
public:
	Font2 ();
	~Font2 ();
        int  GetIndex(string str,int i,bool fa);
        
private:
    
        char  GetTableIndex(char c);
        int  GetTableUnicode(string str,int i);
	
};
#endif

typedef struct {
  WORD Isolated;
  WORD Final;
  WORD Initial;
  WORD Medial;
} KEY_INFO;

const KEY_INFO aKeyInfo[] = {

/*        Base      Isol.   Final   Initial Medial */

  { /* 0  0x0621 */ 0xFE80, 0x0000, 0x0000, 0x0000 /* Arabic letter Hamza                 */ },
  { /* 1  0x0622 */ 0xFE81, 0xFE82, 0xFE81, 0xFE82 /* Arabic letter Alef with Madda above */ },
  { /* 2  0x0623 */ 0xFE83, 0xFE84, 0x0000, 0x0000 /* Arabic letter Alef with Hamza above */ },
  { /* 3  0x0624 */ 0xFE85, 0xFE86, 0x0000, 0x0000 /* Arabic letter Waw with Hamza above  */ },
  { /* 4  0x0625 */ 0xFE87, 0xFE88, 0x0000, 0x0000 /* Arabic letter Alef with Hamza below */ },
  { /* 5  0x0626 */ 0xFE89, 0xFE8A, 0xFE8B, 0xFE8C /* Arabic letter Yeh with Hamza above  */ },
  { /* 6  0x0627 */ 0xFE8D, 0xFE8E, 0xFE8D, 0xFE8E /* Arabic letter Alef                  */ },
  { /* 7  0x0628 */ 0xFE8F, 0xFE90, 0xFE91, 0xFE92 /* Arabic letter Beh                   */ },
  { /* 8  0x0629 */ 0xFE93, 0xFE94, 0xFE93, 0xFE94 /* Arabic letter Teh Marbuta           */ },
  { /* 9  0x062A */ 0xFE95, 0xFE96, 0xFE97, 0xFE98 /* Arabic letter Teh                   */ },
  { /* 10 0x062B */ 0xFE99, 0xFE9A, 0xFE9B, 0xFE9C /* Arabic letter Theh                  */ },
  { /* 11 0x062C */ 0xFE9D, 0xFE9E, 0xFE9F, 0xFEA0 /* Arabic letter Jeem                  */ },
  { /* 12 0x062D */ 0xFEA1, 0xFEA2, 0xFEA3, 0xFEA4 /* Arabic letter Hah                   */ },
  { /* 13 0x062E */ 0xFEA5, 0xFEA6, 0xFEA7, 0xFEA8 /* Arabic letter Khah                  */ },
  { /* 14 0x062F */ 0xFEA9, 0xFEAA, 0xFEA9, 0xFEAA /* Arabic letter Dal                   */ },
  { /* 15 0x0630 */ 0xFEAB, 0xFEAC, 0xFEAB, 0xFEAC /* Arabic letter Thal                  */ },
  { /* 16 0x0631 */ 0xFEAD, 0xFEAE, 0xFEAD, 0xFEAE /* Arabic letter Reh                   */ },
  { /* 17 0x0632 */ 0xFEAF, 0xFEB0, 0xFEAF, 0xFEB0 /* Arabic letter Zain                  */ },
  { /* 18 0x0633 */ 0xFEB1, 0xFEB2, 0xFEB3, 0xFEB4 /* Arabic letter Seen                  */ },
  { /* 19 0x0634 */ 0xFEB5, 0xFEB6, 0xFEB7, 0xFEB8 /* Arabic letter Sheen                 */ },
  { /* 20 0x0635 */ 0xFEB9, 0xFEBA, 0xFEBB, 0xFEBC /* Arabic letter Sad                   */ },
  { /* 21 0x0636 */ 0xFEBD, 0xFEBE, 0xFEBF, 0xFEC0 /* Arabic letter Dad                   */ },
  { /* 22 0x0637 */ 0xFEC1, 0xFEC2, 0xFEC3, 0xFEC4 /* Arabic letter Tah                   */ },
  { /* 23 0x0638 */ 0xFEC5, 0xFEC6, 0xFEC7, 0xFEC8 /* Arabic letter Zah                   */ },
  { /* 24 0x0639 */ 0xFEC9, 0xFECA, 0xFECB, 0xFECC /* Arabic letter Ain                   */ },
  { /* 25 0x063A */ 0xFECD, 0xFECE, 0xFECF, 0xFED0 /* Arabic letter Ghain                 */ },
  { /* 26 0x0641 */ 0xFED1, 0xFED2, 0xFED3, 0xFED4 /* Arabic letter Feh                   */ },
  { /* 27 0x0642 */ 0xFED5, 0xFED6, 0xFED7, 0xFED8 /* Arabic letter Qaf                   */ },
  { /* 28 0x0643 */ 0xFED9, 0xFEDA, 0xFEDB, 0xFEDC /* Arabic letter Kaf                   */ },
  { /* 29 0x0644 */ 0xFEDD, 0xFEDE, 0xFEDF, 0xFEE0 /* Arabic letter Lam                   */ },
  { /* 30 0x0645 */ 0xFEE1, 0xFEE2, 0xFEE3, 0xFEE4 /* Arabic letter Meem                  */ },
  { /* 31 0x0646 */ 0xFEE5, 0xFEE6, 0xFEE7, 0xFEE8 /* Arabic letter Noon                  */ },
  { /* 32 0x0647 */ 0xFEE9, 0xFEEA, 0xFEEB, 0xFEEC /* Arabic letter Heh                   */ },
  { /* 33 0x0648 */ 0xFEED, 0xFEEE, 0xFEED, 0xFEEE /* Arabic letter Waw                   */ },
  { /* 34 0x0649 */ 0xFEEF, 0xFEF0, 0xFEEF, 0xFEF0 /* Arabic letter Alef Maksura          */ },
  { /* 35 0x064A */ 0xFEF1, 0xFEF2, 0xFEF3, 0xFEF4 /* Arabic letter Yeh                   */ },
  { /* 36 0x067E */ 0xFB56, 0xFB57, 0xFB58, 0xFB59 /* Eastern arabic letter Peh           */ },
  { /* 37 0x0686 */ 0xFB7A, 0xFB7B, 0xFB7C, 0xFB7D /* Eastern arabic letter Tcheh         */ },
  { /* 38 0x0698 */ 0xFB8A, 0xFB8B, 0xFB8A, 0xFB8B /* Eastern arabic letter Jeh           */ },
  { /* 39 0x06A9 */ 0xFB8E, 0xFB8F, 0xFB90, 0xFB91 /* Eastern arabic letter Keheh         */ },
  { /* 40 0x06AF */ 0xFB92, 0xFB93, 0xFB94, 0xFB95 /* Eastern arabic letter Gaf           */ },
  { /* 41 0x06CC */ 0xFEF1, 0xFEF2, 0xFEF3, 0xFEF4 /* Eastern arabic letter Farsi Yeh     */ },
};
/*********************************************************************
*
*     data 
*
**********************************************************************
*/
const int index_table[] = {
/*		index   decimal  char */
/*		=====   =======  ==== */  
//      0x0020, /*  32    space */
  
//      0x0030, /*  1776    0  */
//      0x0031, /*  1777    1  */
//      0x0032, /*  1778    2  */
//      0x0033, /*  1779    3  */
//      0x0034, /*  1780    4  */
//      0x0035, /*  1781    5  */
//      0x0036, /*  1782    6  */
//      0x0037, /*  1783    7  */
//      0x0038, /*  1784    8  */
//      0x0039, /*  1785    9  */
     

////////////////////////////////////////////////////////////////////////    
      0xFB56, /* 64342    ?  */
      0xFB57, /* 64343    ?  */			/////////////								
      0xFB58, /* 64344    ?  */			//
      0xFB59, /* 64345    ?  */			//
      						//
      0xFB7A, /* 64378    ?  */			/////////
      0xFB7B, /* 64379    ?  */			//
      0xFB7C, /* 64380    ?  */			//
      0xFB7D, /* 64381    ?  */			//
      						//
      0xFB8A, /* 64394    ?  */			//
      0xFB8B, /* 64395    ?  */			//
      0xFB8C, /* 64396    ?  */			//
      0xFB8D, /* 64397    ?  */
      0xFB8E, /* 64398    ?  */
      0xFB8F, /* 64399    ?  */
      0xFB90, /* 64400    ?  */
      0xFB91, /* 64401    ?  */
      0xFB92, /* 64402    ?  */
      0xFB93, /* 64403    ?  */
      0xFB94, /* 64404    ?  */
      0xFB95, /* 64405    ?  */

////////////////////////////////////////////////////////////////////////      
      0xFE81, /* 65153    ?  */
      0xFE82, /* 65154    ?  */
      0xFE83, /* 65155    ?  */			////////////
      0xFE84, /* 65156    ?  */			//
      0xFE85, /* 65157    ?  */			//
      0xFE86, /* 65158    ?  */			//
      0xFE87, /* 65159    ?  */			////////
      0xFE88, /* 65160    ?  */			//
      0xFE89, /* 65161    ?  */			//
      0xFE8A, /* 65162    ?  */			//
      0xFE8B, /* 65163    ?  */			//
      0xFE8C, /* 65164    ?  */			//
      0xFE8D, /* 65165    ?  */			//
      0xFE8E, /* 65166    ?  */			//
      0xFE8F, /* 65167    ?  */
      0xFE90, /* 65168    ?  */
      0xFE91, /* 65169    ?  */
      0xFE92, /* 65170    ?  */
      0xFE93, /* 65171    ?  */
      0xFE94, /* 65172    ?  */
      0xFE95, /* 65173    ?  */
      0xFE96, /* 65174    ?  */
      0xFE97, /* 65175    ?  */
      0xFE98, /* 65176    ?  */
      0xFE99, /* 65177    ?  */
      0xFE9A, /* 65178    ?  */
      0xFE9B, /* 65179    ?  */
      0xFE9C, /* 65180    ?  */
      0xFE9D, /* 65181    ?  */
      0xFE9E, /* 65182    ?  */
      0xFE9F, /* 65183    ?  */
      0xFEA0, /* 65184    ?  */
      0xFEA1, /* 65185    ?  */
      0xFEA2, /* 65186    ?  */
      0xFEA3, /* 65187    ?  */
      0xFEA4, /* 65188    ?  */
      0xFEA5, /* 65189    ?  */
      0xFEA6, /* 65190    ?  */
      0xFEA7, /* 65191    ?  */
      0xFEA8, /* 65192    ?  */
      0xFEA9, /* 65193    ?  */
      0xFEAA, /* 65194    ?  */
      0xFEAB, /* 65195    ?  */
      0xFEAC, /* 65196    ?  */
      0xFEAD, /* 65197    ?  */
      0xFEAE, /* 65198    ?  */
      0xFEAF, /* 65199    ?  */
      0xFEB0, /* 65200    ?  */
      0xFEB1, /* 65201    ?  */
      0xFEB2, /* 65202    ?  */
      0xFEB3, /* 65203    ?  */
      0xFEB4, /* 65204    ?  */
      0xFEB5, /* 65205    ?  */
      0xFEB6, /* 65206    ?  */
      0xFEB7, /* 65207    ?  */
      0xFEB8, /* 65208    ?  */
      0xFEB9, /* 65209    ?  */
      0xFEBA, /* 65210    ?  */
      0xFEBB, /* 65211    ?  */
      0xFEBC, /* 65212    ?  */
      0xFEBD, /* 65213    ?  */
      0xFEBE, /* 65214    ?  */
      0xFEBF, /* 65215    ?  */
      0xFEC0, /* 65216    ?  */
      0xFEC1, /* 65217    ?  */
      0xFEC2, /* 65218    ?  */
      0xFEC3, /* 65219    ?  */
      0xFEC4, /* 65220    ?  */
      0xFEC5, /* 65221    ?  */
      0xFEC6, /* 65222    ?  */
      0xFEC7, /* 65223    ?  */
      0xFEC8, /* 65224    ?  */
      0xFEC9, /* 65225    ?  */
      0xFECA, /* 65226    ?  */
      0xFECB, /* 65227    ?  */
      0xFECC, /* 65228    ?  */
      0xFECD, /* 65229    ?  */
      0xFECE, /* 65230    ?  */
      0xFECF, /* 65231    ?  */
      0xFED0, /* 65232    ?  */
      0xFED1, /* 65233    ?  */
      0xFED2, /* 65234    ?  */
      0xFED3, /* 65235    ?  */
      0xFED4, /* 65236    ?  */
      0xFED5, /* 65237    ?  */
      0xFED6, /* 65238    ?  */
      0xFED7, /* 65239    ?  */
      0xFED8, /* 65240    ?  */
      0xFED9, /* 65241    ?  */
      0xFEDA, /* 65242    ?  */
      0xFEDB, /* 65243    ?  */
      0xFEDC, /* 65244    ?  */
      0xFEDD, /* 65245    ?  */
      0xFEDE, /* 65246    ?  */
      0xFEDF, /* 65247    ?  */
      0xFEE0, /* 65248    ?  */
      0xFEE1, /* 65249    ?  */
      0xFEE2, /* 65250    ?  */
      0xFEE3, /* 65251    ?  */
      0xFEE4, /* 65252    ?  */
      0xFEE5, /* 65253    ?  */
      0xFEE6, /* 65254    ?  */
      0xFEE7, /* 65255    ?  */
      0xFEE8, /* 65256    ?  */
      0xFEE9, /* 65257    ?  */
      0xFEEA, /* 65258    ?  */
      0xFEEB, /* 65259    ?  */
      0xFEEC, /* 65260    ?  */
      0xFEED, /* 65261    ?  */
      0xFEEE, /* 65262    ?  */
      0xFEEF, /* 65263    ?  */
      0xFEF0, /* 65264    ?  */
      0xFEF1, /* 65265    ?  */
      0xFEF2, /* 65266    ?  */
      0xFEF3, /* 65267    ?  */
      0xFEF4, /* 65268    ?  */
      0xFEF5, /* 65269    ?  */
      0xFEF6, /* 65270    ?  */
      0xFEF7, /* 65271    ?  */
      0xFEF8, /* 65272    ?  */
      0xFEF9, /* 65273    ?  */
      0xFEFA, /* 65274    ?  */
      0xFEFB, /* 65275    ?  */
      0xFEFC, /* 65276    ?  */
};