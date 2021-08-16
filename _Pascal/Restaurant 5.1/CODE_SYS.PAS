unit Code_Sys;

interface


const
  WIN_SINA_SYS      = 1;
  WIN_MICROSOFT_SYS = 2;
  DOS_IR_SYS        = 3;
  DOS_SAYEH_SYS     = 4;
  DOS_DP_SYS        = 5;
  CodePageName : array[WIN_SINA_SYS..DOS_DP_SYS] of String =
    ('Sina System (Windows)', 'Microsoft Code Page (Windows)', 'Iran System (DOS)', 'Sina System (DOS)', 'DP System DOS)');


function ChangeFromWin(s : String; WinType, OtherType : Byte) : String;
function ChangeFromDos(s : String; DosType, OtherType : Byte) : String;

function WinToDos(s : String; WinType, DosType : Byte) : String;
function DosToWin(s : String; DosType, WinType : Byte) : String;

function WinSina_To_Microsoft(s : String) : String;
function Microsoft_To_WinSina(s : String) : String;


(*************** Convert Functions ***************)
function IR_To_Win(WinType : Byte; s : String) : String;
function Win_To_IR(WinType : Byte; s : String) : String;
function IR_To_WinSina(s : String) : String;
function IR_To_Microsoft(s : String) : String;
function WinSina_To_IR(s : String) : String;
function Microsoft_To_IR(s : String) : String;

function Sayeh_To_Win(WinType : Byte; s : String) : String;
function Win_To_Sayeh(WinType : Byte; s : String) : String;
function Sayeh_To_WinSina(s : String) : String;
function Sayeh_To_Microsoft(s : String) : String;
function WinSina_To_Sayeh(s : String) : String;
function Microsoft_To_Sayeh(s : String) : String;

function DP_To_Win(WinType : Byte; s : String) : String;
function Win_To_DP(WinType : Byte; s : String) : String;
function DP_To_WinSina(s : String) : String;
function DP_To_Microsoft(s : String) : String;
function WinSina_To_DP(s : String) : String;
function Microsoft_To_DP(s : String) : String;






implementation


(*************** Win Sina & Iran System ***************)
const
  WinSina_FarsiSet : set of Char = [#193..#214,#216..#234];
  WinSina_NachasbSet : set of Char = [#193,#194,#196,#197,#198,#203,#209,#210,#211,#212,#213,#231];

var
  WinSina_ChasbanSet : set of Char;



(********** Convert From Win to Other Code Page **********)
function ChangeFromWin(s : String; WinType, OtherType : Byte) : String;
begin
  if OtherType in [DOS_IR_SYS, DOS_SAYEH_SYS, DOS_DP_SYS] then
    ChangeFromWin := WinToDos(s, WinType, OtherType)
  else if (WinType = WIN_SINA_SYS) and (OtherType = WIN_MICROSOFT_SYS) then
    ChangeFromWin := Microsoft_To_WinSina(s)
  else if (WinType = WIN_MICROSOFT_SYS) and (OtherType = WIN_SINA_SYS) then
    ChangeFromWin := WinSina_To_Microsoft(s)
  else
    ChangeFromWin := s;
end;

(********** Convert From Dos to Other Code Page **********)
function ChangeFromDos(s : String; DosType, OtherType : Byte) : String;
begin
  if OtherType in [WIN_SINA_SYS, WIN_MICROSOFT_SYS] then
    ChangeFromDos := DosToWin(s, DosType, OtherType)
  else
  begin
    s := DosToWin(s, OtherType, WIN_SINA_SYS);
    ChangeFromDos := WinToDos(s, WIN_SINA_SYS, DosType);
  end;
end;

(********** Convert From Win to Dos **********)
function WinToDos(s : String; WinType, DosType : Byte) : String;
begin
  if WinType = WIN_SINA_SYS then
  begin
    if DosType = DOS_IR_SYS then
      s := WinSina_To_IR(s)
    else if DosType = DOS_SAYEH_SYS then
      s := WinSina_To_Sayeh(s)
    else if DosType = DOS_DP_SYS then
      s := WinSina_To_Dp(s)
  end
  else if WinType = WIN_MICROSOFT_SYS then
  begin
    if DosType = DOS_IR_SYS then
      s := MicroSoft_To_IR(s)
    else if DosType = DOS_SAYEH_SYS then
      s := MicroSoft_To_Sayeh(s)
    else if DosType = DOS_DP_SYS then
      s := MicroSoft_To_Dp(s)
  end;

  WinToDos := s;
end;

(********** Convert From Dos to Win **********)
function DosToWin(s : String; DosType, WinType : Byte) : String;
begin
  if WinType = WIN_SINA_SYS then
  begin
    if DosType = DOS_IR_SYS then
      s := IR_To_WinSina(s)
    else if DosType = DOS_SAYEH_SYS then
      s := Sayeh_To_WinSina(s)
    else if DosType = DOS_DP_SYS then
      s := DP_To_WinSina(s)
  end
  else if WinType = WIN_MICROSOFT_SYS then
  begin
    if DosType = DOS_IR_SYS then
      s := IR_To_MicroSoft(s)
    else if DosType = DOS_SAYEH_SYS then
      s := Sayeh_To_MicroSoft(s)
    else if DosType = DOS_DP_SYS then
      s := DP_To_MicroSoft(s)
  end;

  DosToWin := s;
end;

(********** Convert From Sina Win to Microsoft Win **********)
function WinSina_To_Microsoft(s : String) : String;
const
  WinSina_Microsoft : array[193..234] of Char =
    (#194,#199,#193,#195,#196,#197,#198,#200,           //200
     #129,#202,#201,#203,#204,#141,#205,#206,#207,#208, //210
     #209,#210,#142,#211,#215,#212,#213,#214,#216,#220, //220
     #217,#218,#219,#221,#222,#223,#144,#225,#227,#228, //230
     #230,#229,#237,#236);                              //234

var
  i : Byte;
begin
  for i := 1 to Length(s) do
    if Ord(s[i]) in [193..234] then
      s[i] := WinSina_Microsoft[Ord(s[i])];
  WinSina_To_Microsoft := s;
end;


(********** Convert From Microsoft Win to Sina Win **********)
function Microsoft_To_WinSina(s : String) : String;
const
  Microsoft_WinSina : array[193..237] of Char =
    (#195,#193,#196,#197,#198,#199,#194,#200,           //200
     #203,#202,#204,#205,#207,#208,#209,#210,#211,#212, //210
     #214,#216,#217,#218,#215,#219,#221,#222,#223,#220, //220
     #224,#225,#226,#000,#228,#000,#229,#230,#232,#231, //230
     #000,#000,#000,#000,#235,#234,#233);               //237

var
  i : Byte;
begin
  for i := 1 to Length(s) do
    if Ord(s[i]) in [193..237] then
      s[i] := Microsoft_WinSina[Ord(s[i])]
    else if Ord(s[i]) = 129 then
      s[i] := #201
    else if Ord(s[i]) = 141 then
      s[i] := #206
    else if Ord(s[i]) = 142 then
      s[i] := #213
    else if Ord(s[i]) = 144 then
      s[i] := #227;

  Microsoft_To_WinSina := s;
end;


(*************** Iran Systems Convertor ***************)
function IR_To_Win(WinType : Byte; s : String) : String;
begin
  if WinType = WIN_SINA_SYS then
    IR_To_Win := IR_To_WinSina(s)
  else
    IR_To_Win := IR_To_Microsoft(s);
end;

function Win_To_IR(WinType : Byte; s : String) : String;
begin
  if WinType = WIN_SINA_SYS then
    Win_To_IR := WinSina_To_IR(s)
  else
    Win_To_IR := Microsoft_To_IR(s);
end;

(********** Convert From Iran System to Sina Win **********)
function IR_To_WinSina(s : String) : String;
const
  IR_WinSina : array[#128..#255] of Char =
    (#48,#49,#50,#51,#52,#53,#54,#55,#56,#57,#161,#220,#191 //140
         ,#193,#199,#195,#194,#194,#200,#200,#201,#201,#202 //150
         ,#202,#204,#204,#205,#205,#206,#206,#207,#207,#208 //160
         ,#208,#209,#210,#211,#212,#213,#214,#214,#216,#216 //170
         ,#217,#217,#218,#218,#219                          //175
         ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //185
         ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //195
         ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //205
         ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //215
         ,#0,#0,#0,#0,#0,#0,#0,#0                           //223

         ,#221,#222,#222,#222,#222,#223,#223                //230
         ,#223,#223,#224,#224,#225,#225,#226,#226,#227,#227 //240
         ,#228,#228,#228,#229,#229,#230,#230,#231,#232,#232 //250
         ,#232,#233,#233,#233,#255);                        //255

var
  i : Byte;
  ch : Char;
  s1 : String;
begin
  s1 := '';
  for i := 1 to Length(s) DO
  begin
    ch := s[i];
    if ch = #242 then
    begin
      Insert('Ç', s1, i);
      ch := IR_WinSina[ch];
    end
    else if ch >= #128 then ch := IR_WinSina[ch];
    if ch <> #0 then s1 := s1 + ch;
  end;
  IR_To_WinSina := s1;
end;

(********** Convert From Iran System to Microsoft **********)
function IR_To_Microsoft(s : String) : String;
begin
  s := IR_To_WinSina(s);
  IR_To_Microsoft := WinSina_To_Microsoft(s);
end;

(********** Convert From Sina Win to Iran System **********)
function WinSina_To_IR(s : String) : String;
const
  WinSina_IRSmall : array[#193..#234] of Char =
    (          #141,#144,#143,#144,#248,#144,#142,#147 //200
    ,#149,#151,#249,#153,#155,#157,#159,#161,#162,#163 //210
    ,#164,#165,#166,#168,#120,#170,#172,#174,#175,#139 //220
    ,#224,#228,#232,#234,#236,#238,#240,#243,#245,#247 //230
    ,#248,#251,#254,#253);                             //234
  WinSina_IRBig : array[#193..#234] of Char =
    (          #141,#144,#143,#144,#248,#144,#253,#146 //200
    ,#148,#150,#249,#152,#154,#156,#158,#160,#162,#163 //210
    ,#164,#165,#166,#167,#120,#169,#171,#173,#175,#139 //220
    ,#224,#225,#229,#233,#235,#237,#239,#241,#244,#246 //230
    ,#248,#249,#253,#253);                             //234

var
  i, j : Byte;
  ch : Char;
  s1 : String;
begin
  WinSina_ChasbanSet := WinSina_FarsiSet - WinSina_NachasbSet;
  s1 := s;
  j := 1;
  for i := 1 to Length(s) DO
  begin
    ch := S[i];
    if ch in WinSina_FarsiSet then
    begin
      if s[i+1] in WinSina_FarsiSet then
        s1[j] := WinSina_IRSmall[ch]
      else
        s1[j] := WinSina_IRBig[ch];

      case ch of
        #194:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then s1[j] := #145
            else                               s1[j] := #145
          else if s[i+1] in WinSina_FarsiSet then s1[j] := #144
          else                                    s1[j] := #144;

        #222:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then s1[j] := #227
            else                               s1[j] := #226
          else if s[i+1] in WinSina_FarsiSet then s1[j] := #228
          else s1[j] := #225;

        #223:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then s1[j] := #231
            else                               s1[j] := #230
          else if s[i+1] in WinSina_FarsiSet then s1[j] := #232
          else                                    s1[j] := #229;

        #232:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then s1[j] := #250
            else                               s1[j] := #249
          else if s[i+1] in WinSina_FarsiSet then s1[j] := #251
          else                                    s1[j] := #249;

        #233:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then s1[j] := #254
            else                               s1[j] := #252
          else if s[i+1] in WinSina_FarsiSet then s1[j] := #254
          else                                    s1[j] := #253;
      end;
    end
    else if ch in [#145, #161] then s1[j] := #138
    else if ch = #191 then s1[j] := #140
    else if ch in [#48..#57] then s1[j] :=  Chr(Ord(ch) + 80)
    else if ch <> #157 then s1[j] := ch
    else Dec(j);
    Inc(j);
  end;
  Delete(s1, j, 10);
  WinSina_To_IR := s1;
end;

(********** Convert From Microsoft Win to Iran System **********)
function Microsoft_To_IR(s : String) : String;
begin
  s := Microsoft_To_WinSina(s);
  Microsoft_To_IR := WinSina_To_IR(s);
end;

(*************** Sayeh System Convertor ***************)
function Sayeh_To_Win(WinType : Byte; s : String) : String;
begin
  if WinType = WIN_SINA_SYS then
    Sayeh_To_Win := Sayeh_To_WinSina(s)
  else
    Sayeh_To_Win := Sayeh_To_Microsoft(s);
end;

function Win_To_Sayeh(WinType : Byte; s : String) : String;
begin
  if WinType = WIN_SINA_SYS then
    Win_To_Sayeh := WinSina_To_Sayeh(s)
  else
    Win_To_Sayeh := Microsoft_To_Sayeh(s);
end;

(********** Convert From Sayeh to Sina Win **********)
function Sayeh_To_WinSina(s : String) : String;
const
  Sayeh_IranSys : array[#128..#255] of Char =
    (#33,#34,#35                                       //130
    ,#139,#37,#58,#140,#138,#47,#141,#144,#144,#145    //140
    ,#143,#145,#248,#0,#142,#146,#147,#148,#149,#150   //150
    ,#151,#152,#153,#154,#155,#156,#157,#158,#159,#0   //160
    ,#160,#161,#162,#163,#164,#165,#166,#167,#168,#169 //170
    ,#170,#171,#172,#173,#174                          //175
    ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //185
    ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //195
    ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //205
    ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //215
    ,#0,#0,#0,#0,#0,#0,#0,#0                           //223
    ,#175,#224,#225,#226,#227,#228,#229                //230
    ,#230,#231,#232,#234,#235,#236,#238,#240,#241,#242 //240
    ,#243,#244,#245,#246,#247,#248,#249,#249,#251,#250 //250
    ,#253,#252,#254,#254,#255);                        //255
var
  i : Byte;
  s1 : String;
  ch : Char;
begin
  s1 := '';
  for i := 1 to Length(s) do
  begin
    ch := s[i];
    if ch >= #128 then
      ch := Sayeh_IranSys[ch];
    if ch <> #0 then s1 := s1 + ch;
  end;
  Sayeh_To_WinSina := IR_To_WinSina(s1);
end;

(********** Convert From Sayeh to Microsoft **********)
function Sayeh_To_Microsoft(s : String) : String;
begin
  s := Sayeh_To_WinSina(s);
  Sayeh_To_Microsoft := WinSina_To_Microsoft(s);
end;

(********** Convert From Sina Win to Sayeh System **********)
function WinSina_To_Sayeh(s : String) : String;
const
  WinSina_SayehSmall : array[#193..#234] of Char =
    (#137,#139,#141,#139,#246,#139,#145,#147,           //200
     #149,#151,#247,#153,#155,#157,#159,#162,#163,#164, //210
     #165,#166,#167,#169,#120,#171,#173,#175,#224,#131, //220
     #225,#229,#232,#234,#236,#237,#238,#241,#243,#245, //230
     #246,#250,#253,#251);                              //234
  WinSina_SayehBig : array[#193..#234] of Char =
    (#137,#139,#141,#139,#246,#139,#251,#146,           //200
     #148,#150,#247,#152,#154,#156,#158,#161,#163,#164, //210
     #165,#166,#167,#168,#120,#170,#172,#174,#224,#131, //220
     #225,#226,#230,#234,#235,#237,#238,#239,#242,#244, //230
     #246,#247,#251,#251);                              //234

var
  i : Byte;
  ch: Char;
  ST: String;
  c : String[2];
begin
  WinSina_ChasbanSet := WinSina_FarsiSet - WinSina_NachasbSet;
  ST := '';
  for i := 1 to Length(s) do
  begin
    ch := s[i];
    if ch in WinSina_FarsiSet then
    begin
      if s[i+1] in WinSina_FarsiSet then
        c := WinSina_SayehSmall[ch]
      else
      begin
        c := WinSina_SayehBig[ch];
        if ch in [#200..#202,#204,#224,#226,#227] then
          c := c + #144
        else if ch in [#214, #216..#218] then
          c := c + #160;
      end;

      case ch of
        #194:
          if s[i-1] in WinSina_ChasbanSet then
            c := #140
          else
            c := #139;

        #222:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then
              c := #228
            else
              c := #227
          else if s[i+1] in WinSina_FarsiSet then
            c := #229
          else
            c := #226;

        #223:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then
              c := #233
            else
              c := #231
          else if s[i+1] in WinSina_FarsiSet then
            c := #233
          else
            c := #230;

        #232:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then
              c := #249
            else
              c := #248
          else if s[i+1] in WinSina_FarsiSet then
            c := #250
          else
            c := #247;

        #233:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then
              c := #253
            else
              c := #252
          else if s[i+1] in WinSina_FarsiSet then
            c := #254
          else
            c := #251;
      end;
      ST := ST + c;
    end
    else if ch = #145 then
      ST := ST + #135
    else if ch = #191 then
      ST := ST + #134
    else if ch = #157 then
      ST := ST + #32
    else
      ST := ST + ch;
  end;
  WinSina_To_Sayeh := ST;
end;

(********** Convert From Microsoft to Sayeh System **********)
function Microsoft_To_Sayeh(s : String) : String;
begin
  s := MicroSoft_To_WinSina(s);
  Microsoft_To_Sayeh := Winsina_To_Sayeh(s);
end;


(*************** DP System Convertor ***************)
function DP_To_Win(WinType : Byte; s : String) : String;
begin
  if WinType = WIN_SINA_SYS then
    DP_To_Win := DP_To_WinSina(s)
  else
    DP_To_Win := DP_To_Microsoft(s);
end;

function Win_To_DP(WinType : Byte; s : String) : String;
begin
  if WinType = WIN_SINA_SYS then
    Win_To_DP := WinSina_To_DP(s)
  else
    Win_To_DP := Microsoft_To_DP(s);
end;

(********** Convert From DP System to Sina Win **********)
function DP_To_WinSina(s : String) : String;
const   DP_IranSys : array[#128..#255] of Char =
    (#128,#129,#42                                     //130
    ,#139,#130,#131,#140,#138,#132,#141,#144,#144,#145 //140
    ,#143,#145,#248,#0,#142,#146,#147,#148,#149,#150   //150
    ,#151,#152,#153,#154,#155,#156,#157,#158,#159,#0   //160
    ,#160,#161,#162,#163,#164,#165,#166,#167,#168,#169 //170
    ,#170,#171,#172,#173,#174,#133,#135,#136           //178
    ,#0,#0,#0,#0,#0,#0,#0                              //185
    ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //195
    ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //205
    ,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0                     //215
    ,#0,#0,#0,#0,#134                                  //220
    ,#0,#0,#137,#175,#224,#225,#226,#228,#227,#229     //230
    ,#230,#232,#231,#234,#235,#236,#238,#240,#241,#242 //240
    ,#243,#244,#245,#246,#247,#248,#249,#249,#251,#250 //250
    ,#253,#252,#254,#254,#255);                        //255

var
  i : Byte;
  s1 : String;
  ch : Char;
begin
  s1 := '';
  for i := 1 to Length(s) do
  begin
    ch := s[i];
    if ch >= #128 then
      ch := DP_IranSys[ch];
    if ch <> #0 then s1 := s1 + ch;
  end;
  DP_To_WinSina := IR_To_WinSina(s1);
end;

(********** Convert From DP System to Microsoft **********)
function DP_To_Microsoft(s : String) : String;
begin
  s := DP_To_WinSina(s);
  DP_To_Microsoft := WinSina_To_Microsoft(s);
end;

(********** Convert From Sina Win to DP System **********)
function WinSina_To_DP(s : String) : String;
const
  DP_Num : ARRAY['0'..'9'] OF CHAR =(#128,#129,#132,#133,#136,#176,#220,#177,#178,#223);
  WinSina_DPSmall : array[#193..#234] of Char =
    (#137,#139,#141,#139,#246,#139,#145,#147,           //200
     #149,#151,#247,#153,#155,#157,#159,#162,#163,#164, //210
     #165,#166,#167,#169,#120,#171,#173,#175,#224,#131, //220
     #225,#228,#232,#234,#236,#237,#238,#241,#243,#245, //230
     #246,#249,#253,#251);                              //234
  WinSina_DPBig : array[#193..#234] of Char =
    (#137,#139,#141,#139,#246,#139,#251,#146,           //200
     #148,#150,#247,#152,#154,#156,#158,#161,#163,#164, //210
     #165,#166,#167,#168,#120,#170,#172,#174,#224,#131, //220
     #225,#226,#230,#234,#235,#237,#238,#239,#242,#244, //230
     #246,#247,#251,#251);                              //234

var
  i : Byte;
  ch: Char;
  ST: String;
  c : String[2];
begin
  WinSina_ChasbanSet := WinSina_FarsiSet - WinSina_NachasbSet;
  ST := '';
  for i := 1 to Length(s) do
  begin
    ch := s[i];
    if ch in WinSina_FarsiSet then
    begin
      if s[i+1] in WinSina_FarsiSet then
        c := WinSina_DPSmall[ch]
      else
      begin
        c := WinSina_DPBig[ch];
        if ch in [#200..#202,#204,#224,#226,#227] then
          c := c + #144
        else if ch in [#214, #216..#218] then
          c := c + #160;
      end;

      case ch of
        #194:
          if s[i-1] in WinSina_ChasbanSet then
            c := #140
          else
            c := #139;

        #222:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then
              c := #229
            else
              c := #227
          else if s[i+1] in WinSina_FarsiSet then
            c := #228
          else
            c := #226;

        #223:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then
              c := #233
            else
              c := #231
          else if s[i+1] in WinSina_FarsiSet then
            c := #232
          else
            c := #230;

        #232:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then
              c := #250
            else
              c := #248
          else if s[i+1] in WinSina_FarsiSet then
            c := #249
          else
            c := #247;

        #233:
          if s[i-1] in WinSina_ChasbanSet then
            if s[i+1] in WinSina_FarsiSet then
              c := #254
            else
              c := #252
          else if s[i+1] in WinSina_FarsiSet then
            c := #253
          else
            c := #251;
      end;
      ST := ST + c;
    end
    else if ch = #145 then
      ST := ST + #135
    else if ch = #191 then
      ST := ST + #134
    else if ch in ['0'..'9'] then
      ST := ST + DP_Num[ch]
    else if ch = #157 then
      ST := ST + #32
    else
      ST := ST + ch;
  end;
  WinSina_To_DP := ST;
end;

(********** Convert From DP System to Sina Win **********)
function Microsoft_To_DP(s : String) : String;
begin
  s := MicroSoft_To_WinSina(s);
  Microsoft_To_DP := WinSina_To_DP(s);
end;




end.
