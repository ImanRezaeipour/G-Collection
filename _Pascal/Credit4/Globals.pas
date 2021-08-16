unit Globals;
{$I Features}
interface



uses
  Forms, SysUtils, Controls, StdCtrls, Code_Sys, Funcs, RunCmnds, Types, classes, WideStrings;


const
  {$ifdef  Network}
  version  = '6.0';
  {$else }
  {$ifdef FreeVersion}
  version = '1.5';
  {$else }
  version = '4.0';
  {$endif FreeVersion}
  {$Endif Network}

  softwarecode  = 1;
  refreshpriod  = 5;

var
  maxusers:byte = 3;
  lastrefresh : integer;
  logocode    : string[4];
  islogo      : boolean = false;

  FullScreen  : boolean ;
const
  Prison        : Boolean = False;
  NetAavailable : Boolean = False;
  IsMargarin    : Boolean = False;
  CanEditResult : Boolean = True;
  IsMes         : Boolean = False;
  isAnsar       : Boolean = False;
  IsFalat       : Boolean = false;

  ISDemo        : Boolean = False;

  {IsKharrazi    : Boolean = False;}
  {IsKeshtirani  : Boolean = False;}

const
  MNU_BASE      = 0;
  MNU_REPORT    = 1;
  MNU_SETUP     = 2;
  MNU_RELATION  = 3;
  MNU_TOOLS     = 4;


  RDR_TEST      = 1;
  RDR_RESTART   = 2;
  RDR_VER       = 3;
  RDR_DATETIME  = 4;
  RDR_LIMITTIME = 5;
  RDR_CARDMSG   = 6;
  RDR_DOORS     = 7;
  RDR_COLLECT   = 8;
  RDR_RECOVERY  = 9;
  RDR_VIEWREC   = 10;
  RDR_INITIAL   = 11;
  RDR_MSG       = 12;
  RDR_Authority = 13;
  RDR_FingerPrg = 14;

  CNST_TRUE     = 1;

  MONTH_PATH    = 'Month';
  PICTURE_PATH  = 'Pictures';

  ADMIN_NAME    = 'ADMIN';

  CNST_MAX_READER = 100;


  MaxPishCard = 50;
  MaxWorkstat   = 8;

  {$ifdef Network}
  upper_case = 'Upper';
  boolvalue : array[boolean] of integer = (0,1);
  boolst : array[boolean] of string = ('0','1');
  {$else}
  upper_case = 'UCase';
  boolvalue : array[boolean] of integer = (0,-1);
  boolst : array[boolean] of string = ('0','-1');
  {$endif}

var
  //CONNECTION_STR = 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=clock;'; //by MKN
  //by MKN
  {$ifdef Network}
  CONNECTION_STR:string = 'Provider=SQLOLEDB.1;'
                   +'Persist Security Info=True;'
                   +'Initial Catalog=Clock;';
  CONNECTION_STR1:string = 'Provider=SQLOLEDB.1;'
                   +'Persist Security Info=True;';

  {$else}
  CONNECTION_STR:string = 'Provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;';
  CONNECTION_STR1:string = 'Provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;';

  {$endif}


var
  Month   : array [0..11] of string =
  ('01',
   '02',
   '03',
   '04',
   '05',
   '06',
   '07',
   '08',
   '09',
   '10',
   '11',
   '12');
    Days : array [1..9] of string =
     ('01', '02', '03', '04',
      '05', '06', '07', '08',
      '09'
     );

  PishCard_No : array[1..MaxPishCard] of Byte =
            (01,                 //Takhir Movajah
             02,                 //Tajil Movajah
             03,                 //Add Work Movajah
             04,05,              // 4 , 5 for pure in and out
             06,                 //show last inout of barcode
                                 // 7 for holliday off and work day off ( holliday work intead of workday)
             10,                 // 10 is equal 0 , normal
             11, 12, 13, 14, 15, //Hour Morakhasi Without Price
             21, 22, 23, 24, 25, //Hour Morakhasi With Price
             28,                 //add work continued
             31, 32, 33, 34, 35, //Day Morakhasi Without Price
             41, 42, 43, 44, 45, //Day Morakhasi With Price
             50,                 //work out of organization
             51, 52, 53, 54, 55, //Hour Mamoriat
             61, 62, 63, 64, 65, //Day Mamoriat
             71, 72, 73, 74, 75, //Allday Mamoriat
             81, 82, 83, 84, 85, //Takhir Service
             91);                //Gheibat Movajah
  PishCard_Name : array[1..MaxPishCard] of String[30] =
            ('تاخير موجه',
             'تعجيل موجه',
             'اضافه كاري موجه',
             'ورود','خروج',
             'نمايش آخرين تردد',
             '-',
             'مرخصي ساعتي بي حقوق بيماري', 'مرخصي ساعتي بدون حقوق', 'مرخصي ساعتي بدون حقوق', 'مرخصي ساعتي بدون حقوق', 'مرخصي ساعتي بدون حقوق',
             'مرخصي ساعتي استحقاقي ', 'مرخصي ساعتي استعلاجي ', 'مرخصي ساعتي با حقوق', 'مرخصي ساعتي با حقوق', 'مرخصي ساعتي با حقوق',
             'اضافه كاري ممتد',
             'مرخصي روزانه بي حقوق بيماري', 'مرخصي روزانه بدون حقوق', 'مرخصي روزانه بدون حقوق', 'مرخصي روزانه بدون حقوق', 'مرخصي روزانه بدون حقوق',
             'مرخصي روزانه استحقاقي ', 'مرخصي روزانه استعلاجي ', 'مرخصي روزانه با حقوق', 'مرخصي روزانه با حقوق', 'مرخصي روزانه با حقوق',
             'کارخارج اداره',
             'ماموريت ساعتي', 'ماموريت ساعتي', 'ماموريت ساعتي', 'ماموريت ساعتي', 'ماموريت ساعتي',
             'ماموريت روزانه', 'ماموريت روزانه', 'ماموريت روزانه', 'ماموريت روزانه', 'ماموريت روزانه',
             'ماموريت شبانه روزي', 'ماموريت شبانه روزي', 'ماموريت شبانه روزي', 'ماموريت شبانه روزي', 'ماموريت شبانه روزي',
             'تاخير سرويس', 'تاخير سرويس', 'تاخير سرويس', 'تاخير سرويس', 'تاخير سرويس',
             'غيبت روزانه');
  PishCard_ShortName : array[1..MaxPishCard] of String[10] =
            ('تا مو',
             'تع مو',
             'اض مو',
             'ورود','خروج',
             'آخرين',
             '-',
             'س بيمار', 'مرس بي12', 'مرس بي13', 'مرس بي14', 'مرس بي15',
             'مرس حق', 'مرس عل', 'مرس با23', 'مرس با24', 'مرس با25',
             'اض ممتد',
             'ر بيمار', 'مرر بي32', 'مرر بي33', 'مرر بي34', 'مرر بي35',
             'مرر حق', 'مرر عل', 'مرر با43', 'مرر با44', 'مرر با45',
             'کارخارج',
             'ما س51', 'ما س52', 'ما س53', 'ما س54', 'ما س55',
             'ما ر61', 'ما ر62', 'ما ر63', 'ما ر64', 'ما ر65',
             'ما ش71', 'ما ش72', 'ما ش73', 'ما ش74', 'ما ش75',
             'تاسر81', 'تاسر82', 'تاسر83', 'تاسر84', 'تاسر85',
             'غ روز');
  PishCard_Active : array[1..MaxPishCard] of Byte =
            (CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE,
             CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE, CNST_TRUE);

  PishCard_LastName : array[1..MaxPishCard] of String[30] =
            ('', '', '', '', '', '', '', '', '', '',
             '', '', '', '', '', '', '', '', '', '',
             '', '', '', '', '', '', '', '', '', '',
             '', '', '', '', '', '', '', '', '', '',
             '', '', '', '', '', '', '', '', '', '');

  Workstat_No : array[1..MaxWorkstat] of Byte =
            (92,                 //Takhir
             93,                 //gheibat bein vaght
             94,                 //taajil
             101,                //work
             109,                //esterahat
             111,                //add work before time
             112,                //add work after time
             113);               //add work holliday
  Workstat_Name : array[1..MaxWorkstat] of String[30] =
            ('تاخير ',              // 92
             'غيبت بين وقت',        // 93
             'تعجيل ',              // 94
             'كار',                 // 101
             'استراحت',             // 109
             'اضافه كار قبل وقت',   // 111
             'اضافه كار بعد وقت',   // 112
             'اضافه كار تعطيل');    // 113


   shiftkindname : array[0..5] of string =('','نوبت كاري A','نوبت كاري B','نوبت كاري C','نوبت كاري D','نوبت كاري E');


type TOptions = Record
  ProgramPath  : String;
  DataBasePath : String;
  ClockDBS     : String;
  CoName       : String;
  Shobeh       : String;
  UserName     : String;
  AcesPrint    : Boolean;
{ $IFDEF TreePart}          //finalize needed-
  userPart1    : Integer;
  userPart2    : Integer;
  userPart3    : Integer;
  userPart4    : Integer;
{ $ELSE}                    //finalize needed-
  userParts    : String;
  userStations : integer;
{ $ENDIF}                   //finalize needed-
end;


type TPerson = Record
  P_Code            : String[8];
  p_Proxi           : String[8];
  P_Name            : String[50];
  P_Family          : String[50];
  P_Picture         : String;
//  P_V1Name          : String;
//  P_V1Family        : String;
//  P_V1Picture       : String;
//  P_V2Name          : String;
//  P_V2Family        : String;
//  P_V2Picture       : String;
  P_ContractNo      : String[20];
  P_ContractDate    : String[10];
  P_ContractEndDate : String[10];
  P_Box             : string;
  P_IDNO            : string;
  P_FatherName      : STRING;
  p_BirthDate       : string;
  P_IsBlocked       : boolean;
  P_SignPicture     : string; //kaveh
//  P_VakilSignPicture: string; //kaveh
//  P_Vakil2SignPicture:string; //kaveh
  P_IsProvisionalBlocked: boolean; //kaveh

//  P_NameSec         : String[50]; //kaveh
//  P_FamilySec       : String[50]; //kaveh
//  P_PictureSec      : String; //kaveh
//  P_SignPictureSec  : string; //kaveh
  P_IsCommonBox     : boolean; //kaveh

  P_CommonBoxType   : Smallint; //kaveh
  P_IsLegalCustomer : Boolean; //kaveh
  p_CoName          : string[50]; //kaveh
  P_IsMemberCommonBoxType3 : Boolean;
end;

type TParams = Record

  Part1         : String[15];
  Part2         : String[15];
  Part3         : String[15];
  Part4         : String[15];

  EndRep01      : String[50];
  EndRep02      : String[50];
  EndRep03      : String[50];
  EndRep04      : String[50];
  EndRep05      : String[50];
  IsWin2000     : Byte;
  TimeOut2000   : Integer;
  FastCollect   : integer;

  ServerName    : string;//by MKN
  sqlUseName    : string;
  sqlPassword   : string;
  DataBaseName  : string;

  fldRezerv1    : String[15];
  fldRezerv2    : String[15];
  fldRezerv3    : String[15];
  fldRezerv4    : String[15];
  fldRezerv5    : String[15];
  fldRezerv6    : String[15];
  fldRezerv7    : String[15];
  fldRezerv8    : String[15];

  RptTitleFont  : String[30];
  RptTitleFntSize : Integer;
  RptFont       : String[30];
  RptFntSize    : Integer;
  Admin_User    : String[8];

  BranchCode   : string; //kaveh
  BranchName   : string; //kaveh
  
end;




var
  g_Options     : TOptions;
  Readers       : array[1..CNST_MAX_READER] of TReaders;
  TotalActvRdr,
  TotalOnLineRdr,
  TotalReader   : Byte;
  F_Params      : TParams;
  G_FromDate    : String ;
  G_ToDate      : String ;

  startday,startnight,timenight,startDayNight : integer;
  archiveday    : integer;

  PrsRptSetST   : String;
  LhzRptSetST   : String;

  SelFlag       : Boolean;

  MonthNormal   : Boolean;
  MonthEnds     : array[1..12] of byte;
  {variables that configure view of uPersonelScope Form}
  viewTime : boolean = false;
  viewDateTime : boolean = true;



   { CUSTOM REPORTS }
type
    customreptype =
       record
          repname: string[40];
          reppaper: byte;
          repsize : byte;
          fieldcount:byte;
          repfields   : array[1..100] of integer;
          isprevmonth : array[1..100] of boolean;
       end;
    mktextreptype =
       record
          repname: string[40];
          fieldcount: byte;
          delimiter : string[3];
          repfields : array[1..100] of byte;
          replens   : array[1..100] of byte;
          repdbfname: array[1..100] of string[10];
       end;

       shartkindtype = (isnumber,istime,isstring);
var
    customfname: string;
    customrepcount: byte;
    customreps:array[1..100] of customreptype;
    ccustomrep:byte;

    tcustomfield: byte;
    customdepth : array[1..100] of byte;
    customnames : array[1..100] of string;

    tshart: byte;
    shartand : boolean;
    shartrec : array [1..100] of
        record
           isbish:boolean;
           shartptr:byte;
           shartval:integer;
        end;

    mktextfname: string;
    mktextrepcount: byte;
    mktextreps:array[1..10] of mktextreptype;
    cmktextrep:byte;

type
    newreptype =
       record
          r_code     : integer;
          r_mashrooh : boolean;
          r_kholaseh : boolean;
          r_prev     : boolean;
          r_shartkind: shartkindtype;
          r_title    : string[100];
          r_len      : byte;
          r_ctitle   : string[100];
          r_clen     : byte;
       end;
const
    maxreptypes = 125;
var
    reptypes : ARRAY [1..maxreptypes] of newreptype
    =(
        (r_code:1010;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'رديف';r_len:10)
       ,(r_code:1020;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : isstring ; r_title:'روز هفته';r_len:15)
       ,(r_code:1030;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : isstring ; r_title:'تاريخ';r_len:15)
       ,(r_code:1040;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'نام';r_len:15)
       ,(r_code:1050;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'نام خانوادگي';r_len:20)
       ,(r_code:1060;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'شماره ';r_len:15)
       ,(r_code:1070;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'شماره كارت';r_len:15)
       ,(r_code:1080;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'شماره استخدامي';r_len:20)
       ,(r_code:1090;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'مدرك تحصيلي';r_len:20)
       ,(r_code:1100;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'نوع استخدام';r_len:20)
       ,(r_code:1110;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'بخش';r_len:30)
       ,(r_code:1120;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 1 پرسنلي';r_len:20)
       ,(r_code:1130;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 2 پرسنلي';r_len:20)
       ,(r_code:1140;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 3 پرسنلي';r_len:20)
       ,(r_code:1150;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 4 پرسنلي';r_len:20)
       ,(r_code:1160;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 5 پرسنلي';r_len:20)
       ,(r_code:1170;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 6 پرسنلي';r_len:20)
       ,(r_code:1180;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 7 پرسنلي';r_len:20)
       ,(r_code:1190;r_mashrooh:false; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 8 پرسنلي';r_len:20)

       ,(r_code:1700;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'ورود اول';r_len:12)
       ,(r_code:1710;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'خروج اول';r_len:12)
       ,(r_code:1720;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'ورود دوم';r_len:12)
       ,(r_code:1730;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'خروج دوم';r_len:12)
       ,(r_code:1740;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'ورود سوم';r_len:12)
       ,(r_code:1750;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'خروج سوم';r_len:12)
       ,(r_code:1760;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'ورود چهارم';r_len:12)
       ,(r_code:1770;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'خروج چهارم';r_len:12)
       ,(r_code:1780;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'ورود پنجم';r_len:12)
       ,(r_code:1790;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'خروج پنجم';r_len:12)
       ,(r_code:1900;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'ورود آخر';r_len:12)
       ,(r_code:1910;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'خروج آخر';r_len:12)
       ,(r_code:1920;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : istime   ; r_title:'تردد آخر';r_len:12)

       ,(r_code:2010;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'كاركرد لازم';r_len:12)
       ,(r_code:2020;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'كاركرد لازم روزانه';r_len:10)
       ,(r_code:2025;r_mashrooh:False; r_kholaseh:true ; r_prev:False; r_shartkind : isnumber ; r_title:'تعداد روز کاري';r_len:10)
       ,(r_code:2030;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'حضور كاري';r_len:12)
       ,(r_code:2040;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'حضور كاري روزانه';r_len:10)
       ,(r_code:2050;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'حضور تعطيل روزانه';r_len:10)
       ,(r_code:2060;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'اياب و ذهاب';r_len:10)
       ,(r_code:2062;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'حق غذا';r_len:10)
       ,(r_code:2070;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'كاركرد خالص ساعتي';r_len:12)
       ,(r_code:2072;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'كاركرد خالص ساعتي خام';r_len:12)
       ,(r_code:2080;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'كاركرد خالص روزانه';r_len:10)
       ,(r_code:2090;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'كاركرد ناخالص';r_len:12)
       ,(r_code:2100;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'مدت كار رسمي';r_len:12)
       ,(r_code:2110;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'مدت كار شب';r_len:12)
       ,(r_code:2120;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'تعداد شب كاري';r_len:10)
       ,(r_code:2130;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'كاركرد خالص ماهانه';r_len:12)
       ,(r_code:2140;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'تعداد حمعه ';r_len:12)
       ,(r_code:2142;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'حضور حمعه';r_len:12)
       ,(r_code:2144;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'حمعه کاري' ;r_len:12)
       ,(r_code:2150;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'نوبت كاري 10 درصد'{shiftkindname[]};r_len:10)
       ,(r_code:2160;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'نوبت كاري 15 درصد'{shiftkindname[]};r_len:10)
       ,(r_code:2170;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'نوبت كاري 20 درصد'{shiftkindname[]};r_len:10)
       ,(r_code:2180;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'نوبت كاري 25 درصد'{shiftkindname[]};r_len:10)
       ,(r_code:2190;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'نوبت كاري 35 درصد'{shiftkindname[]};r_len:10)

       ,(r_code:3010;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار مجاز';r_len:12)
       ,(r_code:3020;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار غيرمجاز';r_len:12)
       ,(r_code:3030;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار شب';r_len:12)
       ,(r_code:3040;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار تعطيل';r_len:12)
       ,(r_code:3050;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'اضافه كار غير تعطيل';r_len:12)
       ,(r_code:3060;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'اضافه كار دستوري';r_len:12)
       ,(r_code:3070;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'اضافه كار غير دستوري';r_len:12)
       ,(r_code:3080;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'تعداد اضافه کار غيرکاري روزانه';r_len:10)
       ,(r_code:3090;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'مجوز اضافه كار';r_len:12)
       ,(r_code:3100;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'اضافه كار قبل وقت';r_len:12)
       ,(r_code:3110;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'اضافه كار بعد وقت';r_len:12)
       ,(r_code:3120;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار جمعه';r_len:12)
       ,(r_code:3130;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار غیرمجاز جمعه';r_len:12)
       ,(r_code:3140;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار تعطیل غیرجمعه';r_len:12)
       ,(r_code:3150;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار غیرمجاز تعطیل غیرجمعه';r_len:12)
       ,(r_code:3160;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'اضافه كار روز غیر کاری ';r_len:12)

       ,(r_code:4010;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'غيبت مجاز';r_len:12)
       ,(r_code:4020;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'غيبت غير مجاز';r_len:12)
       ,(r_code:4030;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'مجموع غيبت به ساعت';r_len:12)
       ,(r_code:4040;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'غيبت به روز';r_len:10)
       ,(r_code:4050;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'غيبت خالص روزانه';r_len:10)
       ,(r_code:4054;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'غيبت خالص ساعتي';r_len:10)
       ,(r_code:4060;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'تاخير';r_len:12)
       ,(r_code:4070;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'تعجيل';r_len:12)
       ,(r_code:4080;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isstring ; r_title:'تعداد تاخير';r_len:10)
       ,(r_code:4090;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isstring ; r_title:'جمع تاخير غير مجاز';r_len:12)
       ,(r_code:4100;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'جمع جريمه تاخير غيرمجاز';r_len:12)
       ,(r_code:4110;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'تردد ناقص';r_len:10)

       ,(r_code:5010;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'مرخصي باحقوق ساعتي';r_len:12)
       ,(r_code:5020;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'مرخصي باحقوق روزانه';r_len:10)
       ,(r_code:5030;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'مرخصي استحقاقي ساعتي';r_len:12)
       ,(r_code:5040;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'مرخصي استحقاقي روزانه';r_len:10)
       ,(r_code:5050;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'مرخصي استعلاجي ساعتي';r_len:12)
       ,(r_code:5060;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'مرخصي استعلاجي روزانه';r_len:10)
       ,(r_code:5070;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'مرخصي بي حقوق ساعتي';r_len:12)
       ,(r_code:5080;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'مرخصي بي حقوق روزانه';r_len:10)
       ,(r_code:5090;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'مرخصي بي حقوق استعلاجي ساعتي';r_len:12)
       ,(r_code:5100;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'مرخصي بي حقوق استعلاجي روزانه';r_len:10)
       ,(r_code:5110;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'مرخصي بي حقوق به ساعت';r_len:12)
       ,(r_code:5120;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'مرخصي بيماري به ساعت';r_len:12)
       ,(r_code:5130;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring   ; r_title:'مانده مرخصي ساعتي';r_len:12)
       ,(r_code:5140;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'مانده مرخصي روزانه';r_len:10)
       ,(r_code:5150;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'تعدادمرخصي ساعتي استحقاقي';r_len:10)
       ,(r_code:5160;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : istime   ; r_title:'جمع مرخصي ساعتي استحقاقي';r_len:10)

       ,(r_code:6010;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'ماموريت ساعتي';r_len:12)
       ,(r_code:6020;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'ماموريت روزانه';r_len:10)
       ,(r_code:6030;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'ماموريت شبانه روزي';r_len:10)
       ,(r_code:6051;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'ماموريت ساعتي 51';r_len:12)
       ,(r_code:6052;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : istime   ; r_title:'ماموريت ساعتي 52';r_len:12)
       ,(r_code:6061;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'ماموريت روزانه 61';r_len:10)
       ,(r_code:6062;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'ماموريت روزانه 62';r_len:10)
       ,(r_code:6071;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'ماموريت شبانه روزي 71';r_len:10)
       ,(r_code:6072;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isnumber ; r_title:'ماموريت شبانه روزي 72';r_len:10)

       ,(r_code:7010;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'كد';r_len:5)
       ,(r_code:7020;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيحات';r_len:30)
       ,(r_code:7030;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 1';r_len:20)
       ,(r_code:7031;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 2';r_len:20)
       ,(r_code:7032;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 3';r_len:20)
       ,(r_code:7033;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 4';r_len:20)
       ,(r_code:7034;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 5';r_len:20)
       ,(r_code:7035;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 6';r_len:20)
       ,(r_code:7036;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 7';r_len:20)
       ,(r_code:7037;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 8';r_len:20)
       ,(r_code:7038;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 9';r_len:20)
       ,(r_code:7039;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 10';r_len:20)
       ,(r_code:7040;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'توضيح 11';r_len:20)
       ,(r_code:7050;r_mashrooh:true ; r_kholaseh:true ; r_prev:true ; r_shartkind : isstring ; r_title:'كشيك';r_len:10)
       ,(r_code:7060;r_mashrooh:true ; r_kholaseh:false; r_prev:false; r_shartkind : isstring ; r_title:'شماره برگه';r_len:15)
       ,(r_code:7070;r_mashrooh:true ; r_kholaseh:true ; r_prev:false; r_shartkind : isstring ; r_title:'شيفت';r_len:30)

     );

var
   maxshart:integer;
   sharts  :array[1..maxreptypes]
             of record
                shartname : string;
                shartkind : shartkindtype;
                shartcode : integer;
             end;
var

    current_rule: byte;




function checkpass(pass:string):boolean;

function  SelectCodeFromAll(s, sep : string) : Integer;

procedure LoadPishCard;
procedure SavePishCard;
function  GetPishCardIdx(PishCardCode : Byte) : Byte;
function  GetActivePishCardIdx(PishCardCode : Byte) : Byte;
function  GetPishCardNameIdx(PishCardName : String) : Byte;
function  GetPishCardShortName(PishCardCode : Byte) : String;
function  GetPishCardName(PishCardCode : Byte) : String;
function  GetPishCardLastName(PishCardCode : Byte) : String;
function  GetPishCardFullName(PishCardCode : Byte) : String;
function  IsPishCardDaily(PishCardCode : Byte) : Boolean;

function  GetworkstatName(workstatCode : Byte) : String;


function  Z80_AnalizeData(Data : String; var p : TPerson; var ErrData : Boolean): TTerminalRec;
//function  Z84_AnalizeData(Data : String; var p : TPerson; var ErrData : Boolean) : TTerminalRec;


procedure LoadDBIniFile;
procedure SaveDBIniFile;

function customindex(code:integer):integer;
procedure loadcustomreps;
procedure savecustomreps;
procedure loadcustomdepth;
procedure savecustomdepth;
procedure loadmktextreps;
procedure savemktextreps;


function GetComputerNetName: string; //by MKN
function GetConnectionString : string; //by MKN

procedure addUserLimit(sql : TWideStrings);

function accessPrintAction(var cntr : integer):boolean;

function caneditdate(dt:string):boolean;
function canedityearmonth(yr,mn:integer):boolean;

function checklogo:boolean;

implementation

uses
  TimeTool,DateProc, DBS, ComTools, Windows, MSGs;

procedure addUserLimit(SQL : TWideStrings);
var
  i : Integer;
begin
  if g_Options.userParts <> '' then
    SQL.Add('AND P_Parts LIKE ''' + GetPartCode(g_Options.userParts) + '%''');
  if g_Options.userStations <> -1 then
    SQL.Add('AND P_station = ' + IntToStr(g_Options.userStations));
end;



function SelectCodeFromAll(s, sep : string) : Integer;
var p : Byte;
begin
  SelectCodeFromAll := 0;
  p := Pos(sep, s);
  if p <> 0 then
  begin
    if IsNumeric(Copy(s, 1, p-1)) then
      SelectCodeFromAll := StrToInt(Copy(s, 1, p-1));
  end;
end;



procedure LoadPishCard;
var
  f : TextFile;
  i : Byte;
begin
  if FileExists(g_options.ProgramPath + 'PishCard.Dta') then
  begin
    AssignFile(f, g_options.ProgramPath + 'PishCard.Dta');
    Reset(f);
    for i := 1 to MaxPishCard do
    begin
      ReadLn(f, PishCard_LastName[i]);
      ReadLn(f, PishCard_Active[i]);
    end;
    CloseFile(f);
  end;
end;

procedure SavePishCard;
var
  f : TextFile;
  i : Byte;
begin
  AssignFile(f, g_options.ProgramPath + 'PishCard.Dta');
  ReWrite(f);
  for i := 1 to MaxPishCard do
  begin
    WriteLn(f, PishCard_LastName[i]);
    WriteLn(f, PishCard_Active[i]);
  end;
  CloseFile(f);
end;

function GetPishCardIdx(PishCardCode : Byte) : Byte;
var i : Byte;
begin
  GetPishCardIdx := 0;
  for i := 1 to MaxPishCard do
    if PishCard_No[i] = PishCardCode then
    begin
      GetPishCardIdx := i;
      Break;
    end;
end;

function GetActivePishCardIdx(PishCardCode : Byte) : Byte;
var
  i, j : Byte;
begin
  j := 0;
  GetActivePishCardIdx := 0;
  for i := 1 to MaxPishCard do
    if PishCard_Active[i] = CNST_TRUE then
    begin
      Inc(j);
      if PishCard_No[i] = PishCardCode then
      begin
        GetActivePishCardIdx := j;
        Break;
      end;
    end;
end;

function GetPishCardNameIdx(PishCardName : String) : Byte;
var i : Byte;
begin
  GetPishCardNameIdx := 0;
  for i := 1 to MaxPishCard do
    if PishCard_Name[i] = PishCardName then
    begin
      GetPishCardNameIdx:= i;
      Break;
    end;
end;

function GetPishCardName(PishCardCode : Byte) : String;
var i : Byte;
begin
  i := GetPishCardIdx(PishCardCode);
  if i > 0 then
    GetPishCardName := (PishCard_Name[i])
  else if  PishCardCode= 97 then
    GetPishCardName := ('تردد ناقص')
  else if i = 0 then
    GetPishCardName := ('عادي')
  else
    GetPishCardName := '';
end;

function GetPishCardShortName(PishCardCode : Byte) : String;
var i : Byte;
begin
  i := GetPishCardIdx(PishCardCode);
  if i > 0 then
    GetPishCardShortName := (PishCard_ShortName[i])
  else if  PishCardCode= 97 then
    GetPishCardShortName := ('ناقص')
  else if i = 0 then
    GetPishCardShortName := ('عادي')
  else
    GetPishCardShortName := '';
end;


function GetPishCardLastName(PishCardCode : Byte) : String;
var i : Byte;
begin
  i := GetPishCardIdx(PishCardCode);
  if i > 0 then
    GetPishCardLastName := PishCard_LastName[i]
  else if  PishCardCode= 97 then
    GetPishCardLastName := ('تردد ناقص')
  else if i = 0 then
    GetPishCardLastName := 'عادي'
  else
    GetPishCardLastName := '';
end;

function GetPishCardFullName(PishCardCode : Byte) : String;
var i : Byte;
begin
  i := GetPishCardIdx(PishCardCode);
  if i > 0 then
    GetPishCardFullName := (PishCard_Name[i]) + ' ' + PishCard_LastName[i]
  else if  PishCardCode= 97 then
    GetPishCardFullName := ('تردد ناقص')
  else if i = 0 then
    GetPishCardFullName := ('عادي')
  else
    GetPishCardFullName := '';
end;

function IsPishCardDaily(PishCardCode : Byte) : Boolean;
begin
  if PishCardCode in [31..35, 41..45, 61..65, 71..75, 91] then
    IsPishCardDaily := True
  else
    IsPishCardDaily := False;
end;


function GetworkstatIdx(workstatCode : Byte) : Byte;
var i : Byte;
begin
  GetworkstatIdx := 0;
  for i := 1 to Maxworkstat do
    if workstat_No[i] = workstatCode then
    begin
      GetworkstatIdx := i;
      Break;
    end;
end;

function GetworkstatName(workstatCode : Byte) : String;
var i : Byte;
begin
  i := Getworkstatidx(workstatCode);
  if i > 0 then
    Getworkstatname := (workstat_Name[i])
  else
    Getworkstatname := GetPishCardName(workstatCode);
end;


function checkpass(pass:string):boolean;
const
//   ADMIN_PASS = 'DPSOFTWARE';
   sub_pass1  = 'SALAMAN';
   sub_pass2  = 'MAN';
var
   tt,t,code:integer;
   hour,min,sec,msec:word;
   st:string;
begin
    pass:=UpperCase(pass);
    result:=true;
    if pos(sub_pass1,pass)=0  then result:=false;
    if pos(sub_pass2,pass)=0  then result:=false;
    st:=copy(pass,length(pass)-1,2);
    val(st,tt,code);
    decodetime(time,hour,min,sec,msec);
    t:=hour+min;
    if abs(t-tt)>=2 then result:=false;
end;

function CodingPass(st:string):string;
var
   i,j: byte;
   st1:string;
begin
   st1:='';
   for i:=1 to length(st) do
   begin
       j:=ord(st[i]);
       j:=j xor 118;
       st1:=st1+chr(j mod 16 +200)+chr(j div 16 +200)
   end;
   codingpass:=st1;
end;

function DeCodingPass(st:string):string;
var
   i,j,k: byte;
   st1:string;
begin
   st1:='';
   if odd(length(st)) then st:=st+#200;
   for i:=1 to length(st) div 2 do
   begin
       j:=ord(st[i+i-1])-200;
       k:=ord(st[i+i])-200;
       st1:=st1+chr((j + k*16) xor 118);
   end;
   decodingpass:=st1;
end;

procedure LoadDBIniFile;
var
   f : Text;
   temp: integer;
   st:string[30];
function readtitle:string;
var
   st:string;
   ch:char;
   endwork:boolean;
begin
   endwork:=false;
   st:='';
   repeat
      read(f,ch);
      if eof(f) or eoln(f) or (ch='=')
      then endwork:=true
      else st:=st+ch;
   until endwork;
   result:=st;
end;
begin
  if FileExists(g_options.ProgramPath + 'Clock.Ini') then
  begin
    Assign(f, g_options.ProgramPath + 'Clock.Ini');
    Reset(f);
    readln(f,st);
    if st<>'clock_2.33'
    then begin
        close(f);
        ErrorMessage('پارامترهاي سيستم را مجددا تنظيم نماييد.');
        exit;
    end;
    repeat
      st:=readtitle;
      if      st = 'ServerName' then readln(f,F_Params.ServerName)
      else if st = 'sqlUseName' then readln(f,F_Params.sqlUseName)
      else if st = 'sqlPassword'
      then begin
           readln(f,F_Params.sqlPassword);
           F_Params.sqlPassword:=DeCodingPass(F_Params.sqlPassword);
      end
      else if st = 'DataBaseName'
      then begin
           readln(f,F_Params.DataBaseName);
      end
      else readln(F);
    until eof(f);
    Close(f);
  end;
end;

procedure SaveDBIniFile;
var
   f : Text;
   temp : integer;
begin
  Assign(f, g_options.ProgramPath + 'Clock.Ini');
  ReWrite(f);
  writeln(f, 'clock_2.33');
  WriteLn(f, 'ServerName=',F_Params.ServerName); // by MKN
  WriteLn(f, 'sqlUseName=',F_Params.sqlUseName); // by MKN
  WriteLn(f, 'sqlPassword=',CodingPass(F_Params.sqlPassword)); // by MKN
  WriteLn(f, 'DataBaseName=',F_Params.DataBaseName); // by MKN
  Close(f);
end;



function customindex(code:integer):integer;
var
   i:integer;
begin
   customindex:=0;
   for i:=1 to maxreptypes do
   if reptypes[i].r_code=code
   then begin
        customindex:=i;
        break;
   end;
end;

procedure loadcustomreps;
var
   f:file of customreptype;
   i:integer;
begin
   customrepcount:=0;
   customfname:='custom.rep';
   if fileexists(g_options.ProgramPath + customfname)
   then begin
        assignfile(f,g_options.ProgramPath + customfname);
        reset(f);
        while not eof(f) do
        begin
            inc(customrepcount);
            read(f,customreps[customrepcount]);
            with customreps[customrepcount] do
            for i:=1 to fieldcount do repfields[i]:=customindex(repfields[i]);
        end;
        closefile(f);
   end;
end;

procedure savecustomreps;
var
   f:file of customreptype;
   rec:customreptype;
   i,j:integer;
begin
   customfname:='custom.rep';
   assignfile(f,g_options.ProgramPath + customfname);
   rewrite(f);
   for i:= 1 to customrepcount do
   begin
      rec:=customreps[i];
      with rec do
       for j:=1 to fieldcount do repfields[j]:=reptypes[repfields[j]].r_code;
      write(f,rec);
   end;
   closefile(f);
end;

procedure loadcustomdepth;
var
   f:text;
   n:integer;
begin
   if fileexists(g_options.ProgramPath + 'customs.dep')
   then begin
        assignfile(f,g_options.ProgramPath + 'customs.dep');
        reset(f);
        while not eof(f) do
        begin
            readln(f,n);
            n:=customindex(n);
            readln(f,reptypes[n].r_clen);
            readln(f,reptypes[n].r_ctitle);
        end;
        closefile(f);
   end
   else for n:=1 to maxreptypes do
   with reptypes[n] do
   begin
        r_clen:=r_len;
        r_ctitle:=r_title;
   end;
end;

procedure savecustomdepth;
var
   f:text;
   i:integer;
begin
    assignfile(f,g_options.ProgramPath + 'customs.dep');
    rewrite(f);
    for i:=1 to maxreptypes do
    begin
        writeln(f,reptypes[i].r_code);
        writeln(f,reptypes[i].r_clen);
        writeln(f,reptypes[i].r_ctitle);
    end;
    closefile(f);
end;

procedure loadmktextreps;
var
   f:file of mktextreptype;
begin
   mktextrepcount:=0;
   mktextfname:='mktext.rep';
   if fileexists(g_options.ProgramPath + mktextfname)
   then begin
        assignfile(f,g_options.ProgramPath + mktextfname);
        reset(f);
        while not eof(f) do
        begin
            inc(mktextrepcount);
            read(f,mktextreps[mktextrepcount]);
        end;
        closefile(f);
   end;
end;

procedure savemktextreps;
var
   f:file of mktextreptype;
   i:byte;
begin
   mktextfname:='mktext.rep';
   assignfile(f,g_options.ProgramPath + mktextfname);
   rewrite(f);
   for i:= 1 to mktextrepcount do
      write(f,mktextreps[i]);
   closefile(f);
end;

function Z80_AnalizeData(Data : String; var p : TPerson; var ErrData : Boolean) : TTerminalRec;
var
  ClkRec : TTerminalRec;
  s : String;
begin
  ErrData := False;

  s := Copy(Data, 1, 2);
  if IsNumeric(s) then
    ClkRec.rdrCode := StrToInt(s)
  else
    ErrData := True;

  s := Copy(Data, 3, 2);
  if IsNumeric(s) then
    ClkRec.rdrStatus := StrToInt(s)
  else
    ErrData := True;

  s := Copy(Data, 5, 2) + '/' +
       Copy(Data, 7, 2) + '/' +
       Copy(Data, 9, 2);
  if IsTrueDate(s) then
    ClkRec.rdrDate := BeautifulDate(s)
  else
    ErrData := True;

  s := BeautifulTime(Copy(Data, 11, 2) + ':' +
                     Copy(Data, 13, 2));
  if IsTrueTime(s) then
    ClkRec.rdrTime := TimeToInt(s)
  else
    ErrData := True;

  ClkRec.rdrCardCode := Copy(Data, 15, 8);
  p := GetPerson(ClkRec.rdrCardCode, True);
  if p.P_Code <> '' then
    ClkRec.rdrCardCode := p.p_Code;
  Z80_AnalizeData := ClkRec;
end;


function GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;

function GetConnectionString : string;
begin
  {$ifdef Network}
  result := CONNECTION_STR1 +
            'Initial Catalog=' + F_Params.DataBaseName +
            ';Data Source=' + F_Params.ServerName +
            ';User ID=' + F_Params.sqlUseName +
            ';Password=' + F_Params.sqlPassword ;
  {$else}
  result := CONNECTION_STR1 + 'Data Source ='+g_options.DataBasePath+'clock.mdb;'{+F_Params.DataBaseName+'.mdb;'};

  {$endif}
end;

function accessPrintAction(var cntr : integer):boolean;
begin
  result := true;
  if g_Options.AcesPrint or (LowerCase(g_Options.UserName) = 'admin') then
    exit;
  if cntr > 0 then
  begin
    InformationMessage('امکان چاپ گزارشات توسط مدير سيستم محدوده گشته است .');
    result := false;
  end;
  cntr := cntr + 1;
end;

function caneditdate(dt:string):boolean;
var
   d: byte;
   date1:string;
   canedit: boolean;
begin
   canedit:=false;
   if (LowerCase(g_Options.UserName) = 'admin') or (archiveday=0)
   then begin
        canedit:=true;
   end
   else begin
       date1:=currentdate;
       d:=strtoint(copy(date1,9,2));
       if d>=archiveday
       then begin
            date1:=adddate(date1,-d);
       end
       else begin
            date1:=adddate(date1,-30-d);
       end;
       canedit:=(dt>=date1);
   end;
   if not canedit then errormessage('ويرايش براي اين تاريخ بسته شده است');
   result:=canedit;
end;

function canedityearmonth(yr,mn:integer):boolean;
var
   dt:string;
begin
   dt:=inttostr(yr)+'/'+inttostr(mn)+'/'+'15';
   dt:=beautifuldate(dt);
   result:=caneditdate(dt);
end;

function checklogo:boolean;
var
   f : file of char;
   logo : string[4];
   ch,ch1,ch2:char;
   n:byte;
begin
   result:=false;
   ASSIGN(F,g_options.ProgramPath + 'logo.jpg');
   {$i-}
   reset(f);
   {$i+}
   if ioresult=0
   then begin
        logo:='';
        seek(f,1000);
        read(f,ch);
        n:=ord(ch);
        ch1:=chr(n div 16 + 70);
        ch2:=chr(n mod 16 + 70);
        logo:=logo+ch1+ch2;
        seek(f,2000);
        read(f,ch);
        n:=ord(ch);
        ch1:=chr(n div 16 + 70);
        ch2:=chr(n mod 16 + 70);
        logo:=logo+ch1+ch2;
        close(f);
        result:=(logo=logocode);
   end
end;

end.
