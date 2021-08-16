unit Calendar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, AdoDB, Buttons, MSGs, Globals;

type
  TfrmCalendar = class(TForm)
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Panel2: TPanel;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit40: TEdit;
    Edit41: TEdit;
    Edit42: TEdit;
    Edit43: TEdit;
    Edit44: TEdit;
    Edit45: TEdit;
    Edit46: TEdit;
    Edit47: TEdit;
    Edit48: TEdit;
    Edit49: TEdit;
    Edit50: TEdit;
    Edit51: TEdit;
    Edit52: TEdit;
    Edit53: TEdit;
    Edit54: TEdit;
    Edit55: TEdit;
    Edit56: TEdit;
    Edit57: TEdit;
    Edit58: TEdit;
    Edit59: TEdit;
    Edit60: TEdit;
    Edit61: TEdit;
    Edit62: TEdit;
    Panel3: TPanel;
    Edit63: TEdit;
    Edit64: TEdit;
    Edit65: TEdit;
    Edit66: TEdit;
    Edit67: TEdit;
    Edit68: TEdit;
    Edit69: TEdit;
    Edit70: TEdit;
    Edit71: TEdit;
    Edit72: TEdit;
    Edit73: TEdit;
    Edit74: TEdit;
    Edit75: TEdit;
    Edit76: TEdit;
    Edit77: TEdit;
    Edit78: TEdit;
    Edit79: TEdit;
    Edit80: TEdit;
    Edit81: TEdit;
    Edit82: TEdit;
    Edit83: TEdit;
    Edit84: TEdit;
    Edit85: TEdit;
    Edit86: TEdit;
    Edit87: TEdit;
    Edit88: TEdit;
    Edit89: TEdit;
    Edit90: TEdit;
    Edit91: TEdit;
    Edit92: TEdit;
    Edit93: TEdit;
    Panel4: TPanel;
    Edit94: TEdit;
    Edit95: TEdit;
    Edit96: TEdit;
    Edit97: TEdit;
    Edit98: TEdit;
    Edit99: TEdit;
    Edit100: TEdit;
    Edit101: TEdit;
    Edit102: TEdit;
    Edit103: TEdit;
    Edit104: TEdit;
    Edit105: TEdit;
    Edit106: TEdit;
    Edit107: TEdit;
    Edit108: TEdit;
    Edit109: TEdit;
    Edit110: TEdit;
    Edit111: TEdit;
    Edit112: TEdit;
    Edit113: TEdit;
    Edit114: TEdit;
    Edit115: TEdit;
    Edit116: TEdit;
    Edit117: TEdit;
    Edit118: TEdit;
    Edit119: TEdit;
    Edit120: TEdit;
    Edit121: TEdit;
    Edit122: TEdit;
    Edit123: TEdit;
    Edit124: TEdit;
    Panel5: TPanel;
    Edit125: TEdit;
    Edit126: TEdit;
    Edit127: TEdit;
    Edit128: TEdit;
    Edit129: TEdit;
    Edit130: TEdit;
    Edit131: TEdit;
    Edit132: TEdit;
    Edit133: TEdit;
    Edit134: TEdit;
    Edit135: TEdit;
    Edit136: TEdit;
    Edit137: TEdit;
    Edit138: TEdit;
    Edit139: TEdit;
    Edit140: TEdit;
    Edit141: TEdit;
    Edit142: TEdit;
    Edit143: TEdit;
    Edit144: TEdit;
    Edit145: TEdit;
    Edit146: TEdit;
    Edit147: TEdit;
    Edit148: TEdit;
    Edit149: TEdit;
    Edit150: TEdit;
    Edit151: TEdit;
    Edit152: TEdit;
    Edit153: TEdit;
    Edit154: TEdit;
    Edit155: TEdit;
    Panel6: TPanel;
    Edit156: TEdit;
    Edit157: TEdit;
    Edit158: TEdit;
    Edit159: TEdit;
    Edit160: TEdit;
    Edit161: TEdit;
    Edit162: TEdit;
    Edit163: TEdit;
    Edit164: TEdit;
    Edit165: TEdit;
    Edit166: TEdit;
    Edit167: TEdit;
    Edit168: TEdit;
    Edit169: TEdit;
    Edit170: TEdit;
    Edit171: TEdit;
    Edit172: TEdit;
    Edit173: TEdit;
    Edit174: TEdit;
    Edit175: TEdit;
    Edit176: TEdit;
    Edit177: TEdit;
    Edit178: TEdit;
    Edit179: TEdit;
    Edit180: TEdit;
    Edit181: TEdit;
    Edit182: TEdit;
    Edit183: TEdit;
    Edit184: TEdit;
    Edit185: TEdit;
    Edit186: TEdit;
    Panel7: TPanel;
    Edit187: TEdit;
    Edit188: TEdit;
    Edit189: TEdit;
    Edit190: TEdit;
    Edit191: TEdit;
    Edit192: TEdit;
    Edit193: TEdit;
    Edit194: TEdit;
    Edit195: TEdit;
    Edit196: TEdit;
    Edit197: TEdit;
    Edit198: TEdit;
    Edit199: TEdit;
    Edit200: TEdit;
    Edit201: TEdit;
    Edit202: TEdit;
    Edit203: TEdit;
    Edit204: TEdit;
    Edit205: TEdit;
    Edit206: TEdit;
    Edit207: TEdit;
    Edit208: TEdit;
    Edit209: TEdit;
    Edit210: TEdit;
    Edit211: TEdit;
    Edit212: TEdit;
    Edit213: TEdit;
    Edit214: TEdit;
    Edit215: TEdit;
    Edit216: TEdit;
    Edit217: TEdit;
    Panel8: TPanel;
    Edit218: TEdit;
    Edit219: TEdit;
    Edit220: TEdit;
    Edit221: TEdit;
    Edit222: TEdit;
    Edit223: TEdit;
    Edit224: TEdit;
    Edit225: TEdit;
    Edit226: TEdit;
    Edit227: TEdit;
    Edit228: TEdit;
    Edit229: TEdit;
    Edit230: TEdit;
    Edit231: TEdit;
    Edit232: TEdit;
    Edit233: TEdit;
    Edit234: TEdit;
    Edit235: TEdit;
    Edit236: TEdit;
    Edit237: TEdit;
    Edit238: TEdit;
    Edit239: TEdit;
    Edit240: TEdit;
    Edit241: TEdit;
    Edit242: TEdit;
    Edit243: TEdit;
    Edit244: TEdit;
    Edit245: TEdit;
    Edit246: TEdit;
    Edit247: TEdit;
    Edit248: TEdit;
    Panel9: TPanel;
    Edit249: TEdit;
    Edit250: TEdit;
    Edit251: TEdit;
    Edit252: TEdit;
    Edit253: TEdit;
    Edit254: TEdit;
    Edit255: TEdit;
    Edit256: TEdit;
    Edit257: TEdit;
    Edit258: TEdit;
    Edit259: TEdit;
    Edit260: TEdit;
    Edit261: TEdit;
    Edit262: TEdit;
    Edit263: TEdit;
    Edit264: TEdit;
    Edit265: TEdit;
    Edit266: TEdit;
    Edit267: TEdit;
    Edit268: TEdit;
    Edit269: TEdit;
    Edit270: TEdit;
    Edit271: TEdit;
    Edit272: TEdit;
    Edit273: TEdit;
    Edit274: TEdit;
    Edit275: TEdit;
    Edit276: TEdit;
    Edit277: TEdit;
    Edit278: TEdit;
    Edit279: TEdit;
    Panel10: TPanel;
    Edit280: TEdit;
    Edit281: TEdit;
    Edit282: TEdit;
    Edit283: TEdit;
    Edit284: TEdit;
    Edit285: TEdit;
    Edit286: TEdit;
    Edit287: TEdit;
    Edit288: TEdit;
    Edit289: TEdit;
    Edit290: TEdit;
    Edit291: TEdit;
    Edit292: TEdit;
    Edit293: TEdit;
    Edit294: TEdit;
    Edit295: TEdit;
    Edit296: TEdit;
    Edit297: TEdit;
    Edit298: TEdit;
    Edit299: TEdit;
    Edit300: TEdit;
    Edit301: TEdit;
    Edit302: TEdit;
    Edit303: TEdit;
    Edit304: TEdit;
    Edit305: TEdit;
    Edit306: TEdit;
    Edit307: TEdit;
    Edit308: TEdit;
    Edit309: TEdit;
    Edit310: TEdit;
    Panel11: TPanel;
    Edit311: TEdit;
    Edit312: TEdit;
    Edit313: TEdit;
    Edit314: TEdit;
    Edit315: TEdit;
    Edit316: TEdit;
    Edit317: TEdit;
    Edit318: TEdit;
    Edit319: TEdit;
    Edit320: TEdit;
    Edit321: TEdit;
    Edit322: TEdit;
    Edit323: TEdit;
    Edit324: TEdit;
    Edit325: TEdit;
    Edit326: TEdit;
    Edit327: TEdit;
    Edit328: TEdit;
    Edit329: TEdit;
    Edit330: TEdit;
    Edit331: TEdit;
    Edit332: TEdit;
    Edit333: TEdit;
    Edit334: TEdit;
    Edit335: TEdit;
    Edit336: TEdit;
    Edit337: TEdit;
    Edit338: TEdit;
    Edit339: TEdit;
    Edit340: TEdit;
    Edit341: TEdit;
    Panel12: TPanel;
    Edit342: TEdit;
    Edit343: TEdit;
    Edit344: TEdit;
    Edit345: TEdit;
    Edit346: TEdit;
    Edit347: TEdit;
    Edit348: TEdit;
    Edit349: TEdit;
    Edit350: TEdit;
    Edit351: TEdit;
    Edit352: TEdit;
    Edit353: TEdit;
    Edit354: TEdit;
    Edit355: TEdit;
    Edit356: TEdit;
    Edit357: TEdit;
    Edit358: TEdit;
    Edit359: TEdit;
    Edit360: TEdit;
    Edit361: TEdit;
    Edit362: TEdit;
    Edit363: TEdit;
    Edit364: TEdit;
    Edit365: TEdit;
    Edit366: TEdit;
    Edit367: TEdit;
    Edit368: TEdit;
    Edit369: TEdit;
    Edit370: TEdit;
    Edit371: TEdit;
    Edit372: TEdit;
    Label1: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Query1: TAdoQuery;
    cmdSave: TBitBtn;
    cmdExit: TBitBtn;
    adoqryDtl: TADOQuery;
    Label38: TLabel;
    Label41: TLabel;
    Label39: TLabel;
    Label37: TLabel;
    Label36: TLabel;
    Label35: TLabel;
    Label34: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Label40: TLabel;
    Shape6: TShape;
    Shape7: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdSaveClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cmdExitClick(Sender: TObject);
  private
    { Private declarations }
    Edits : array[1..12,1..31] of TEdit;
    MahWeek : array[1..12] of Byte;
    MahRooz : array[1..12] of Byte;
    Vadeh : array[1..12,1..31] of Byte;
    Group_Name : String;
    C_Month, C_Day : Integer;

    procedure Initial_Edits;
    function  YearWeek(Y : Byte) : Byte;
    procedure MakeMahWeek(Y : Byte);
    procedure GoField(M, D : Integer);
    procedure FindField;
    procedure SaveColors;

  public
    { Public declarations }
    C_Year : Integer;
    Group_Code : Integer;
  end;


implementation

uses DBS_Proc,DateProc;

{$R *.DFM}

const
  Colors : array[0..7] of TColor =
           (clWhite, clLime, clYellow, clAqua, clFuchsia, clMoneyGreen, clSkyBlue, clRed);



procedure TfrmCalendar.Initial_Edits;
var
  M, D, K, Line, Col, S : Integer;
  stm : String[31];
  function MakeCode(sh : shiftrec) : integer;
  var
    a,b,c,d : boolean;
  begin
    with sh do
    begin
      a := shiftSobhaneh;
      b := shiftNahar;
      c := shiftSham;
//      d := shiftnextSobhaneh;
    end;

    if a
    then if DayGroup.shdirooz
    then if not d
    then a:=false;

    result := 0;
    if a then result := 1;
    if b then result := 2;
    if c then result := 3;
    if a and b then result := 4;
    if b and c then result := 5;
    if a and c then result := 6;
    if a and b and c then result := 7;
//    if d then result:=result+8;
  end;
begin
  Edits[ 1, 1] := Edit1;
  Edits[ 1, 2] := Edit2;
  Edits[ 1, 3] := Edit3;
  Edits[ 1, 4] := Edit4;
  Edits[ 1, 5] := Edit5;
  Edits[ 1, 6] := Edit6;
  Edits[ 1, 7] := Edit7;
  Edits[ 1, 8] := Edit8;
  Edits[ 1, 9] := Edit9;
  Edits[ 1,10] := Edit10;
  Edits[ 1,11] := Edit11;
  Edits[ 1,12] := Edit12;
  Edits[ 1,13] := Edit13;
  Edits[ 1,14] := Edit14;
  Edits[ 1,15] := Edit15;
  Edits[ 1,16] := Edit16;
  Edits[ 1,17] := Edit17;
  Edits[ 1,18] := Edit18;
  Edits[ 1,19] := Edit19;
  Edits[ 1,20] := Edit20;
  Edits[ 1,21] := Edit21;
  Edits[ 1,22] := Edit22;
  Edits[ 1,23] := Edit23;
  Edits[ 1,24] := Edit24;
  Edits[ 1,25] := Edit25;
  Edits[ 1,26] := Edit26;
  Edits[ 1,27] := Edit27;
  Edits[ 1,28] := Edit28;
  Edits[ 1,29] := Edit29;
  Edits[ 1,30] := Edit30;
  Edits[ 1,31] := Edit31;
  Edits[ 2, 1] := Edit32;
  Edits[ 2, 2] := Edit33;
  Edits[ 2, 3] := Edit34;
  Edits[ 2, 4] := Edit35;
  Edits[ 2, 5] := Edit36;
  Edits[ 2, 6] := Edit37;
  Edits[ 2, 7] := Edit38;
  Edits[ 2, 8] := Edit39;
  Edits[ 2, 9] := Edit40;
  Edits[ 2,10] := Edit41;
  Edits[ 2,11] := Edit42;
  Edits[ 2,12] := Edit43;
  Edits[ 2,13] := Edit44;
  Edits[ 2,14] := Edit45;
  Edits[ 2,15] := Edit46;
  Edits[ 2,16] := Edit47;
  Edits[ 2,17] := Edit48;
  Edits[ 2,18] := Edit49;
  Edits[ 2,19] := Edit50;
  Edits[ 2,20] := Edit51;
  Edits[ 2,21] := Edit52;
  Edits[ 2,22] := Edit53;
  Edits[ 2,23] := Edit54;
  Edits[ 2,24] := Edit55;
  Edits[ 2,25] := Edit56;
  Edits[ 2,26] := Edit57;
  Edits[ 2,27] := Edit58;
  Edits[ 2,28] := Edit59;
  Edits[ 2,29] := Edit60;
  Edits[ 2,30] := Edit61;
  Edits[ 2,31] := Edit62;
  Edits[ 3, 1] := Edit63;
  Edits[ 3, 2] := Edit64;
  Edits[ 3, 3] := Edit65;
  Edits[ 3, 4] := Edit66;
  Edits[ 3, 5] := Edit67;
  Edits[ 3, 6] := Edit68;
  Edits[ 3, 7] := Edit69;
  Edits[ 3, 8] := Edit70;
  Edits[ 3, 9] := Edit71;
  Edits[ 3,10] := Edit72;
  Edits[ 3,11] := Edit73;
  Edits[ 3,12] := Edit74;
  Edits[ 3,13] := Edit75;
  Edits[ 3,14] := Edit76;
  Edits[ 3,15] := Edit77;
  Edits[ 3,16] := Edit78;
  Edits[ 3,17] := Edit79;
  Edits[ 3,18] := Edit80;
  Edits[ 3,19] := Edit81;
  Edits[ 3,20] := Edit82;
  Edits[ 3,21] := Edit83;
  Edits[ 3,22] := Edit84;
  Edits[ 3,23] := Edit85;
  Edits[ 3,24] := Edit86;
  Edits[ 3,25] := Edit87;
  Edits[ 3,26] := Edit88;
  Edits[ 3,27] := Edit89;
  Edits[ 3,28] := Edit90;
  Edits[ 3,29] := Edit91;
  Edits[ 3,30] := Edit92;
  Edits[ 3,31] := Edit93;
  Edits[ 4, 1] := Edit94;
  Edits[ 4, 2] := Edit95;
  Edits[ 4, 3] := Edit96;
  Edits[ 4, 4] := Edit97;
  Edits[ 4, 5] := Edit98;
  Edits[ 4, 6] := Edit99;
  Edits[ 4, 7] := Edit100;
  Edits[ 4, 8] := Edit101;
  Edits[ 4, 9] := Edit102;
  Edits[ 4,10] := Edit103;
  Edits[ 4,11] := Edit104;
  Edits[ 4,12] := Edit105;
  Edits[ 4,13] := Edit106;
  Edits[ 4,14] := Edit107;
  Edits[ 4,15] := Edit108;
  Edits[ 4,16] := Edit109;
  Edits[ 4,17] := Edit110;
  Edits[ 4,18] := Edit111;
  Edits[ 4,19] := Edit112;
  Edits[ 4,20] := Edit113;
  Edits[ 4,21] := Edit114;
  Edits[ 4,22] := Edit115;
  Edits[ 4,23] := Edit116;
  Edits[ 4,24] := Edit117;
  Edits[ 4,25] := Edit118;
  Edits[ 4,26] := Edit119;
  Edits[ 4,27] := Edit120;
  Edits[ 4,28] := Edit121;
  Edits[ 4,29] := Edit122;
  Edits[ 4,30] := Edit123;
  Edits[ 4,31] := Edit124;
  Edits[ 5, 1] := Edit125;
  Edits[ 5, 2] := Edit126;
  Edits[ 5, 3] := Edit127;
  Edits[ 5, 4] := Edit128;
  Edits[ 5, 5] := Edit129;
  Edits[ 5, 6] := Edit130;
  Edits[ 5, 7] := Edit131;
  Edits[ 5, 8] := Edit132;
  Edits[ 5, 9] := Edit133;
  Edits[ 5,10] := Edit134;
  Edits[ 5,11] := Edit135;
  Edits[ 5,12] := Edit136;
  Edits[ 5,13] := Edit137;
  Edits[ 5,14] := Edit138;
  Edits[ 5,15] := Edit139;
  Edits[ 5,16] := Edit140;
  Edits[ 5,17] := Edit141;
  Edits[ 5,18] := Edit142;
  Edits[ 5,19] := Edit143;
  Edits[ 5,20] := Edit144;
  Edits[ 5,21] := Edit145;
  Edits[ 5,22] := Edit146;
  Edits[ 5,23] := Edit147;
  Edits[ 5,24] := Edit148;
  Edits[ 5,25] := Edit149;
  Edits[ 5,26] := Edit150;
  Edits[ 5,27] := Edit151;
  Edits[ 5,28] := Edit152;
  Edits[ 5,29] := Edit153;
  Edits[ 5,30] := Edit154;
  Edits[ 5,31] := Edit155;
  Edits[ 6, 1] := Edit156;
  Edits[ 6, 2] := Edit157;
  Edits[ 6, 3] := Edit158;
  Edits[ 6, 4] := Edit159;
  Edits[ 6, 5] := Edit160;
  Edits[ 6, 6] := Edit161;
  Edits[ 6, 7] := Edit162;
  Edits[ 6, 8] := Edit163;
  Edits[ 6, 9] := Edit164;
  Edits[ 6,10] := Edit165;
  Edits[ 6,11] := Edit166;
  Edits[ 6,12] := Edit167;
  Edits[ 6,13] := Edit168;
  Edits[ 6,14] := Edit169;
  Edits[ 6,15] := Edit170;
  Edits[ 6,16] := Edit171;
  Edits[ 6,17] := Edit172;
  Edits[ 6,18] := Edit173;
  Edits[ 6,19] := Edit174;
  Edits[ 6,20] := Edit175;
  Edits[ 6,21] := Edit176;
  Edits[ 6,22] := Edit177;
  Edits[ 6,23] := Edit178;
  Edits[ 6,24] := Edit179;
  Edits[ 6,25] := Edit180;
  Edits[ 6,26] := Edit181;
  Edits[ 6,27] := Edit182;
  Edits[ 6,28] := Edit183;
  Edits[ 6,29] := Edit184;
  Edits[ 6,30] := Edit185;
  Edits[ 6,31] := Edit186;
  Edits[ 7, 1] := Edit187;
  Edits[ 7, 2] := Edit188;
  Edits[ 7, 3] := Edit189;
  Edits[ 7, 4] := Edit190;
  Edits[ 7, 5] := Edit191;
  Edits[ 7, 6] := Edit192;
  Edits[ 7, 7] := Edit193;
  Edits[ 7, 8] := Edit194;
  Edits[ 7, 9] := Edit195;
  Edits[ 7,10] := Edit196;
  Edits[ 7,11] := Edit197;
  Edits[ 7,12] := Edit198;
  Edits[ 7,13] := Edit199;
  Edits[ 7,14] := Edit200;
  Edits[ 7,15] := Edit201;
  Edits[ 7,16] := Edit202;
  Edits[ 7,17] := Edit203;
  Edits[ 7,18] := Edit204;
  Edits[ 7,19] := Edit205;
  Edits[ 7,20] := Edit206;
  Edits[ 7,21] := Edit207;
  Edits[ 7,22] := Edit208;
  Edits[ 7,23] := Edit209;
  Edits[ 7,24] := Edit210;
  Edits[ 7,25] := Edit211;
  Edits[ 7,26] := Edit212;
  Edits[ 7,27] := Edit213;
  Edits[ 7,28] := Edit214;
  Edits[ 7,29] := Edit215;
  Edits[ 7,30] := Edit216;
  Edits[ 7,31] := Edit217;
  Edits[ 8, 1] := Edit218;
  Edits[ 8, 2] := Edit219;
  Edits[ 8, 3] := Edit220;
  Edits[ 8, 4] := Edit221;
  Edits[ 8, 5] := Edit222;
  Edits[ 8, 6] := Edit223;
  Edits[ 8, 7] := Edit224;
  Edits[ 8, 8] := Edit225;
  Edits[ 8, 9] := Edit226;
  Edits[ 8,10] := Edit227;
  Edits[ 8,11] := Edit228;
  Edits[ 8,12] := Edit229;
  Edits[ 8,13] := Edit230;
  Edits[ 8,14] := Edit231;
  Edits[ 8,15] := Edit232;
  Edits[ 8,16] := Edit233;
  Edits[ 8,17] := Edit234;
  Edits[ 8,18] := Edit235;
  Edits[ 8,19] := Edit236;
  Edits[ 8,20] := Edit237;
  Edits[ 8,21] := Edit238;
  Edits[ 8,22] := Edit239;
  Edits[ 8,23] := Edit240;
  Edits[ 8,24] := Edit241;
  Edits[ 8,25] := Edit242;
  Edits[ 8,26] := Edit243;
  Edits[ 8,27] := Edit244;
  Edits[ 8,28] := Edit245;
  Edits[ 8,29] := Edit246;
  Edits[ 8,30] := Edit247;
  Edits[ 8,31] := Edit248;
  Edits[ 9, 1] := Edit249;
  Edits[ 9, 2] := Edit250;
  Edits[ 9, 3] := Edit251;
  Edits[ 9, 4] := Edit252;
  Edits[ 9, 5] := Edit253;
  Edits[ 9, 6] := Edit254;
  Edits[ 9, 7] := Edit255;
  Edits[ 9, 8] := Edit256;
  Edits[ 9, 9] := Edit257;
  Edits[ 9,10] := Edit258;
  Edits[ 9,11] := Edit259;
  Edits[ 9,12] := Edit260;
  Edits[ 9,13] := Edit261;
  Edits[ 9,14] := Edit262;
  Edits[ 9,15] := Edit263;
  Edits[ 9,16] := Edit264;
  Edits[ 9,17] := Edit265;
  Edits[ 9,18] := Edit266;
  Edits[ 9,19] := Edit267;
  Edits[ 9,20] := Edit268;
  Edits[ 9,21] := Edit269;
  Edits[ 9,22] := Edit270;
  Edits[ 9,23] := Edit271;
  Edits[ 9,24] := Edit272;
  Edits[ 9,25] := Edit273;
  Edits[ 9,26] := Edit274;
  Edits[ 9,27] := Edit275;
  Edits[ 9,28] := Edit276;
  Edits[ 9,29] := Edit277;
  Edits[ 9,30] := Edit278;
  Edits[ 9,31] := Edit279;
  Edits[10, 1] := Edit280;
  Edits[10, 2] := Edit281;
  Edits[10, 3] := Edit282;
  Edits[10, 4] := Edit283;
  Edits[10, 5] := Edit284;
  Edits[10, 6] := Edit285;
  Edits[10, 7] := Edit286;
  Edits[10, 8] := Edit287;
  Edits[10, 9] := Edit288;
  Edits[10,10] := Edit289;
  Edits[10,11] := Edit290;
  Edits[10,12] := Edit291;
  Edits[10,13] := Edit292;
  Edits[10,14] := Edit293;
  Edits[10,15] := Edit294;
  Edits[10,16] := Edit295;
  Edits[10,17] := Edit296;
  Edits[10,18] := Edit297;
  Edits[10,19] := Edit298;
  Edits[10,20] := Edit299;
  Edits[10,21] := Edit300;
  Edits[10,22] := Edit301;
  Edits[10,23] := Edit302;
  Edits[10,24] := Edit303;
  Edits[10,25] := Edit304;
  Edits[10,26] := Edit305;
  Edits[10,27] := Edit306;
  Edits[10,28] := Edit307;
  Edits[10,29] := Edit308;
  Edits[10,30] := Edit309;
  Edits[10,31] := Edit310;
  Edits[11, 1] := Edit311;
  Edits[11, 2] := Edit312;
  Edits[11, 3] := Edit313;
  Edits[11, 4] := Edit314;
  Edits[11, 5] := Edit315;
  Edits[11, 6] := Edit316;
  Edits[11, 7] := Edit317;
  Edits[11, 8] := Edit318;
  Edits[11, 9] := Edit319;
  Edits[11,10] := Edit320;
  Edits[11,11] := Edit321;
  Edits[11,12] := Edit322;
  Edits[11,13] := Edit323;
  Edits[11,14] := Edit324;
  Edits[11,15] := Edit325;
  Edits[11,16] := Edit326;
  Edits[11,17] := Edit327;
  Edits[11,18] := Edit328;
  Edits[11,19] := Edit329;
  Edits[11,20] := Edit330;
  Edits[11,21] := Edit331;
  Edits[11,22] := Edit332;
  Edits[11,23] := Edit333;
  Edits[11,24] := Edit334;
  Edits[11,25] := Edit335;
  Edits[11,26] := Edit336;
  Edits[11,27] := Edit337;
  Edits[11,28] := Edit338;
  Edits[11,29] := Edit339;
  Edits[11,30] := Edit340;
  Edits[11,31] := Edit341;
  Edits[12, 1] := Edit342;
  Edits[12, 2] := Edit343;
  Edits[12, 3] := Edit344;
  Edits[12, 4] := Edit345;
  Edits[12, 5] := Edit346;
  Edits[12, 6] := Edit347;
  Edits[12, 7] := Edit348;
  Edits[12, 8] := Edit349;
  Edits[12, 9] := Edit350;
  Edits[12,10] := Edit351;
  Edits[12,11] := Edit352;
  Edits[12,12] := Edit353;
  Edits[12,13] := Edit354;
  Edits[12,14] := Edit355;
  Edits[12,15] := Edit356;
  Edits[12,16] := Edit357;
  Edits[12,17] := Edit358;
  Edits[12,18] := Edit359;
  Edits[12,19] := Edit360;
  Edits[12,20] := Edit361;
  Edits[12,21] := Edit362;
  Edits[12,22] := Edit363;
  Edits[12,23] := Edit364;
  Edits[12,24] := Edit365;
  Edits[12,25] := Edit366;
  Edits[12,26] := Edit367;
  Edits[12,27] := Edit368;
  Edits[12,28] := Edit369;
  Edits[12,29] := Edit370;
  Edits[12,30] := Edit371;
  Edits[12,31] := Edit372;

  MakeMahWeek(C_Year);

  with query1 do
  begin
    Close;
    with SQL do
    begin
      Clear;
      Add('SELECT * FROM Groups');
      Add('WHERE Grp_Code = ' + IntToStr(Group_Code));
    end;
    Open;
    Group_Name := FieldByName('Grp_Name').AsString;
    Caption := (' ‰„«Ì‘  ﬁÊÌ„ ”«·«‰Â ')+ IntTostr(C_Year) + (' ê—ÊÂ ') + Group_Name;
    {zamani ke linke beyne Clock va Resturan bargharar bashe , dar banke Resturan
     bejaye tabelhaye Group va grp_dtl 2 ta View ba hamin namha az rouye banke clock
     sakhte khahad shod va dar sooraty ke link bargharar nabashe tabele group dar
     banke resturant sakhte mishavad.
     farghe tabele group v view'ye group dar in ast ke dar view , fildhaye Grp_mXX
     nyst va az rooye in fargh mishavad fahmid ke link hast ya na.
    }
    Linked_To_Clock := (FindField('Grp_M1') = nil);
    if not Linked_To_Clock then
    begin
      for M := 1 to 12 do
      begin
        stm := FieldByName('Grp_M' + IntToStr(M)).AsString;
        if stm = '' then
          for D := 1 to 31 do Vadeh[M, D] := 0
        else
          for D := 1 to 31 do Vadeh[M, D] := Ord(stm[D])-48;
      end;
    end
    else if Linked_To_Clock then
    begin
      LoadShifts;
      WITH adoqryDtl do
      begin
        with SQL DO
        BEGIN
           CLEAR;
           ADD('select * from grp_Dtl');
           add('where Grd_code ='+inttostr(group_code));
           add('and Grd_year ='+inttostr(c_year))
        END;
        open;
        if eof
        then begin
          for m:=1 to 12 do
             for d:=1 to 31 do
                Vadeh[M, D] := 0
        end
        else begin
          for m:=1 to 12 do
          begin
             stm:=fieldbyname('Grd_M'+inttostr(m)).asstring;
             if stm=''
             then for d:=1 to 31 do
                Vadeh[M, D] := 0
             else
                for d:=1 to 31 do
                  Vadeh[M, D] := MakeCode(shifts[ord(stm[d])-1]);
          end;
        end;
      end;
    end;
    Close;
  end;

  for M := 1 to 12 do
    for D := 1 to 31 do
      with Edits[M, D] do
      begin
        K := D + MahWeek[M] - 1;
        S := K mod 7;
        Line := S * 16 + 1;
        Col := 23 * (5 - (K div 7)) + 1;
        Top := Line;
        Left := Col;
        if k < 7 then Width := 20
        else          Width := 23;
        Height := 17;
        MaxLength := 2;
        ReadOnly := True;
        Visible := D <= MahRooz[M];
        Text := Inttostr(D);
        Color := Colors[Vadeh[M, D]];
      end;

  GoField(1, 1);
end;

function TfrmCalendar.YearWeek(Y : Byte) : Byte;
begin
  Y := Y - 1300;
  YearWeek := (Y + Y div 4 - 89) mod 7;
end;

procedure TfrmCalendar.MakeMahWeek(Y : Byte);
var
  M, S : Byte;
begin
  S := YearWeek(y);
  for M := 1 to 12 do
    if M < 7 then
    begin
      MahWeek[M] := (S+3 * M-3) mod 7;
      MahRooz[M] := 31
    end
    else
    begin
      MahWeek[M] := (S+2 * M-10) mod 7;
      MahRooz[M]:=30;
      if Y mod 4 <> 3 then MahRooz[12] := 29;
    end;
end;

procedure TfrmCalendar.GoField(M, D : Integer);
begin
  Edits[M, D].SetFocus;
  C_Month := M;
  C_Day := D;
end;

procedure TfrmCalendar.FindField;
var
  M, D : Integer;
begin
  if Edits[C_Month, C_Day] = ActiveControl then
    Exit;

  for M := 1 to 12 do
  begin
    for D := 1 to 31 do
    begin
      if Edits[M, D] = ActiveControl then
      begin
        C_Month := M;
        C_Day := D;
        Exit;
      end;
    end;
  end;
end;

procedure TfrmCalendar.SaveColors;
var
  stm : String[31];
  M, D : Integer;
begin
  with query1 do
  begin
    Close;
//    RequestLive := True;
    with SQL do
    begin
      Clear;
      Add('SELECT * FROM Groups');
      Add('WHERE Grp_Code = ' + IntToStr(Group_Code));
    end;
    Open;
    Edit;
    for M := 1 to 12 do
    begin
      stm := '';
      for D := 1 to 31 do
        stm := stm + Chr(Vadeh[M, D] + 48);
      Fieldbyname('Grp_M' + IntToStr(m)).AsString := stm;
    end;
    Post;
    Close;
  end;
end;


procedure TfrmCalendar.FormShow(Sender: TObject);
begin
  Query1.Connection := frmDBS.DBConnection;
  adoqryDtl.Connection := frmDBS.DBConnection;
  Initial_Edits;
//  MSG_NoWait;
  Mouse_NoWait;
  cmdSave.Visible := not Linked_To_Clock;
end;

procedure TfrmCalendar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FindField;

  case Key of
    33: {Page Up}
    begin
      if C_Month > 1 then
      begin
        Dec(C_Month);
        GoField(C_Month, C_Day);
      end;
    end;

    34: {Page Down}
    begin
      if C_Month < 12 then
      begin
        Inc(C_Month);
        if C_Day > MahRooz[C_Month] then
          C_Day := MahRooz[C_Month];

        GoField(C_Month, C_Day);
      end;
    end;

    37: {Left Arrow}
    begin
      Key := 0;
      if C_Day+7 <= MahRooz[C_Month] then
        GoField(C_Month, C_Day+7)
      else if C_Month < 12 then
      begin
        C_Day := C_Day + 7 - MahRooz[C_Month];
        Inc(C_Month);
        GoField(C_Month, C_Day);
      end;
    end;


    39: {Right Arrow}
    begin
      Key := 0;
      if C_Day > 7 then
        GoField(C_Month, C_Day-7)
      else if C_Month > 1 then
      begin
        Dec(C_Month);
        C_Day := C_Day + MahRooz[C_Month] - 7;
        GoField(C_Month, C_Day);
      end;
    end;

    38: {Up Arrow}
    begin
      Key := 0;
      if C_Day > 1 then
        GoField(C_Month, C_Day-1)
      else if C_Month > 1 then
        GoField(C_Month-1, MahRooz[C_Month-1]);
    end;

    40: {Down Arrow}
    begin
      Key := 0;
      if C_Day < MahRooz[C_Month] then
        GoField(C_Month, C_Day+1)
      else if C_Month < 12 then
        GoField(C_Month+1, 1);
    end;

    48..55:
    begin
      with Edits[C_Month, C_Day] do
      begin
        Color := Colors[key-48];
        Vadeh[C_Month, C_Day] := key-48;
      end;

      Key := 0;
      if C_Day < MahRooz[C_Month] then
        GoField(C_Month, C_Day+1)
      else if C_Month < 12 then
        GoField(C_Month+1, 1);
    end;

    96..103:
    begin
      with Edits[C_Month, C_Day] do
      begin
        Color := Colors[key-96];
        Vadeh[C_Month, C_Day] := key-96;
      end;

      Key := 0;
      if C_Day < MahRooz[C_Month] then
        GoField(C_Month, C_Day+1)
      else if C_Month < 12 then
        GoField(C_Month+1, 1);
    end;

  end; {end of case}
end;

procedure TfrmCalendar.FormClick(Sender: TObject);
begin
   FindField;
end;

procedure TfrmCalendar.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  FindField;
end;

procedure TfrmCalendar.cmdSaveClick(Sender: TObject);
begin
  if not Linked_To_Clock then
  begin
    SaveColors;
    InformationMessage('⁄„·Ì«  À»  «‰Ã«„ ‘œ.');
  end
  else
    ErrorMessage('«ÿ·«⁄«  ê—ÊÂÂ« «“ ‰—„ «›“«— Õ÷Ê—Ê€Ì«» ê—› Â „Ì‘Êœ Ê ﬁ«»· «’·«Õ ‰„Ì»«‘œ .');
end;

procedure TfrmCalendar.cmdExitClick(Sender: TObject);
begin
  Close;
end;

end.
