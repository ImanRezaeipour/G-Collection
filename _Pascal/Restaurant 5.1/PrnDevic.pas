unit PrnDevic;

interface

const
  PRN_OK         = 0;
  PRN_NOTREADY   = 1;
  PRN_OUTOFPAPER = 2;

function PrinterInitial : Byte;
function PrinterReady : Byte;
function PrintChar(c : Byte) : Byte;
function PrintString(ST : String) : Byte;
function DownLoadFarsiPrint : Boolean;

implementation

uses
  SysUtils, Globals, DateProc,Printers;


function PrinterInitial : Byte;
begin
{  asm
    mov ah, $1
    mov dx, $0
    int $17
  end;
}
  Delay(2000);
  PrinterInitial := PrinterReady;
end;

function PrinterReady : Byte;
var c : Byte;
begin

  asm
    mov ah, $2
    mov dx, $0
    int $17
    mov c, ah
  end;


  if (c AND $9) <> 0 then
    PrinterReady := PRN_NOTREADY
  else if (c AND $20) <> 0 then
    PrinterReady := PRN_OUTOFPAPER
  else if (c AND $90) <> 0 then
    PrinterReady := PRN_OK
  else
    PrinterReady := PRN_NOTREADY;
end;

function PrintChar(c : Byte) : Byte;
begin
  asm
    mov ah, $0
    mov al, c
    mov dx, $0
    int $17
    mov c, ah
  end;
  if (c AND $9) <> 0 then
    PrintChar := PRN_NOTREADY
  else if (c AND $20) <> 0 then
    PrintChar := PRN_OUTOFPAPER
  else if (c AND $90) <> 0 then
    PrintChar := PRN_OK
  else
    PrintChar := PRN_NOTREADY;
end;

function PrintString(ST : String) : Byte;
var
  i, c : Byte;
begin
  PrintString := PRN_OK;
  for i := 1 to Length(ST) do
  begin
    c := PrintChar(Ord(ST[i]));
    if c <> PRN_OK then
    begin
      PrintString := c;
      Break;
    end
  end;
end;

function DownLoadFarsiPrint : Boolean;
const
  Initial   = #27#64;
  LQFont    = #27#120#1;
  RomToRam  = #27#58#0#0#0;
  SetUser   = #27#37#1;
  RemoveUp  = #27#116#2;
  Beep3     = #7#7#7;
  SetNormal = #27#37#0;
  LineSpc   = #27#51#24;
  TypeStyle = #27#107#0;
  CPI       = #27#80;
var
  f : file of char;
  c : Char;
begin
  DownLoadFarsiPrint := True;
  if (PrinterReady = PRN_OK) and
     FileExists(g_options.ProgramPath + 'PrnIrFnt.Fnt') then
  begin
    // Initialize Printer     (Esc @)
    if PrintString(Initial) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    // Select LQ Font         (Esc x1)
    if PrintString(LQFont) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    // Copy ROM To RAM        (Esc :000)
    if PrintString(RomToRam) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    // Select User-define set (Esc %1)
    if PrintString(SetUser) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    AssignFile(f, g_options.ProgramPath + 'PrnIrFnt.Fnt');
    ReSet(f);
    while not Eof(f) do
    begin
      Read(f, c);
      if PrintChar(Ord(c)) <> PRN_OK then
      begin
        DownLoadFarsiPrint := False;
        CloseFile(f);
        Exit;
      end;
    end;
    CloseFile(f);


    // Copy user define font to 128...256 (Esc t2)
    if PrintString(RemoveUp) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    // Beep
    if PrintString(Beep3) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    // Select Normal set       (Esc %0)
    if PrintString(SetNormal) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    // Line spacing       (Esc +0)
    if PrintString(LineSpc) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    if PrintString(TypeStyle) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;

    if PrintString(CPI) <> PRN_OK then
    begin
      DownLoadFarsiPrint := False;
      Exit;
    end;
  end
  else
    DownLoadFarsiPrint := False;
end;


end.
