unit FingerPrg2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, globals, Buttons, MSGs, Funcs, RunCmnds,
  ExtCtrls, ComTools, math, DBS, DB, ADODB, wwDataInspector, Grids,
  Wwdbigrd, Wwdbgrid, wwcheckbox, DBGrids, VrControls, VrButtons,
  VrScrollText, VrAudio , printers,dbTables;

type
  TFpAck = record
    Param1       : string;
    Param2       : string;
    lwExtra      : string;
    hwExtra      : string;
    ErrorCode    : integer;
end;
  TFingerTemplate = class(Tobject)
    Id : string;
    SubIndex : integer;
    AdminLevel : integer;
    Template : ansistring;
  end;


  TfrmFingerPrg2 = class(TForm)
    grpBtns: TGroupBox;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    dtaFinger: TDataSource;
    adoQryFinger: TADOQuery;
    adoQryFingername: TStringField;
    adoQryFingerFamily: TStringField;
    adoQryFingerBarCode: TStringField;
    adoQryFingermaster: TBooleanField;
    adoQryFingerProxi: TWideStringField;
    adoQryFingerSample: TWideStringField;
    adoTblFinger: TADOTable;
    adoTblPersons: TADOTable;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    pgMove: TTabSheet;
    statusTo: TStatusBar;
    GroupBox3: TGroupBox;
    cmbFromMoveAll: TComboBox;
    grpSelectScop: TGroupBox;
    btnMoveOne: TBitBtn;
    GroupBox5: TGroupBox;
    Label14: TLabel;
    GroupBox6: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    cmbRdrDelete: TComboBox;
    btnGetAllDelete: TBitBtn;
    grdFpDelete: TStringGrid;
    btnDeleteAll: TBitBtn;
    btnNone: TBitBtn;
    btnAll: TBitBtn;
    btnDeleteSelected: TBitBtn;
    statusDelete: TStatusBar;
    lblMsg: TLabel;
    GroupBox7: TGroupBox;
    txtCode: TEdit;
    btnDelete: TButton;
    statusFrom: TStatusBar;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    cmbRdrView: TComboBox;
    btnGetAllView: TBitBtn;
    grdFpView: TStringGrid;
    statusView: TStatusBar;
    grpDB: TGroupBox;
    Shape3: TShape;
    Label6: TLabel;
    grpDBSearch: TGroupBox;
    lblSearch: TLabel;
    Label1: TLabel;
    txtDbCode: TEdit;
    txtDbName: TEdit;
    DBGrid1: TDBGrid;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    rdoFromTerminal: TRadioButton;
    rdoFromFile: TRadioButton;
    txtFromFile: TEdit;
    btnFromFile: TButton;
    GroupBox8: TGroupBox;
    rdoToTerminal: TRadioButton;
    rdoToFile: TRadioButton;
    txtToFile: TEdit;
    btnToFile: TButton;
    cmbToMoveAll: TComboBox;
    chkUpdate: TCheckBox;
    chkFormatMoveAll: TCheckBox;
    rdoMoveAll: TRadioButton;
    rdoMoveOne: TRadioButton;
    grpSelectOne: TGroupBox;
    cmbNameMoveOne: TComboBox;
    cmbCodeMoveOne: TComboBox;
    cmbProxiMoveOne: TComboBox;
    chkFormatOne: TCheckBox;
    Label7: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    chkDeleteName: TCheckBox;
    chkViewName: TCheckBox;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    btnMove: TBitBtn;
    procedure rdoToFileClick(Sender: TObject);
    procedure btnToFileClick(Sender: TObject);
    procedure btnFromFileClick(Sender: TObject);
    procedure rdoMoveAllClick(Sender: TObject);
    procedure rdoMoveOneClick(Sender: TObject);
    procedure btnNoneClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure rdoFromTerminalClick(Sender: TObject);
    procedure rdoToTerminalClick(Sender: TObject);
    procedure rdoFromFileClick(Sender: TObject);
//    procedure cmdRunClick(Sender: TObject);
    Function  MakeFpPocket(cmd : ansiString) : AnsiString;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeleteAllClick(Sender: TObject);
    procedure btnAllClick(Sender: TObject);
//    procedure btnMoveToDBClick(Sender: TObject);
    procedure btnDelSelectedClick(Sender: TObject);
    procedure adoQryFingerCalcFields(DataSet: TDataSet);
    procedure btnMoveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
//    procedure btnLinkTestDeleteClick(Sender: TObject);
    procedure btnGetAllDeleteClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure grdFpDeleteMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
//    procedure btnMoveOneClick(Sender: TObject);
    procedure cmbProxiMoveOneChange(Sender: TObject);
//    procedure btnLinkTestViewClick(Sender: TObject);
    procedure btnGetAllViewClick(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure TabSheet3Enter(Sender: TObject);
    procedure chkFormatMoveAllClick(Sender: TObject);
    procedure chkUpdateClick(Sender: TObject);
    procedure cmbCodeMoveOneChange(Sender: TObject);
    procedure cmbNameMoveOneChange(Sender: TObject);
  private
//    procedure InsertFPtoDB(s : ansiString);
    Function  HexToInt(s : string) : integer;
    function isMaster(rdr: TReaders;proxi: string): boolean;

    function SendFPCommand(rdr: TReaders; _CommandNo , _Param , _size ,_flag : string; ExtraData : AnsiString): TFpAck;
    Function SendFPDBCommand(rdr : TReaders ;cmnd : ansiString) : boolean;
    function GetFPExtra(rdr: TReaders; size: integer): AnsiString;

    function GetFpCount(rdr : TReaders):integer;
    procedure MakeCodeList(str : AnsiString ;lst: TStringList);

    function SendFp(rdr: TReaders ; fgr : TFingerTemplate): boolean;
    Function GetFpList(rdr : TReaders) : AnsiString;

    Function GetFp(rdr : TReaders ; Proxi : string) : AnsiString;
    Function isFpEnrolled(rdr : TReaders ; Proxi : string) : Boolean;
    Function DeleteFp(rdr : TReaders ; Proxi : string) : Boolean;
    Function DeleteAllFps(rdr : TReaders) : Boolean;


//    Function GetFpFromList(SrcFile :  TStringList; Proxi : string) : AnsiString;

    function swap(str : string) : string;
    function ChangeMode(rdr :treaders;Mode : integer) : boolean;

    procedure WaitFor(reason : string);
    procedure DontWait;
    function getCodeOfCombo(cmb : TComboBox): integer;
    procedure SaveFinger(tbl : TTable ; fgr : AnsiString);
    function LoadFinger(tbl : TTable) : AnsiString;
    function calculFpCount(lst : TStringList) : integer;
  public
    rdrIdxSet  : Set of 0..255;
    procedure ChangeModeAll(Mode : integer);
  end;


Const
  fpTimeOut               = 1000;
  tryCount                =1;

  msg_SUCCESS             = $61;
  msg_DataOk              = $83;
  msg_InvalidID           = $76;

  M2ERROR_USER_NOT_FOUND  = 6 ;  //0x06
  M2ERROR_DB_WRONG_USERID = 10;  //0x0a
  M2ERROR_DB_NO_DATA      = 11;  //0x0b

  Direct_Mode             =90;
  Normal_Mode             =91;
var
  TCP_UDP_ExtraData : ansistring;
  canceled : boolean;
  a : AnsiString;
  test , test1,test2 : ansistring;
  ln : integer;
  fpList : AnsiString;
  jjj : integer;
implementation

uses DateUtils, TCP_UDP;

{$R *.dfm}
function TfrmFingerPrg2.calculFpCount(lst : TStringList) : integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to lst.Count-1 do
    if lst.IndexOf(lst[i]) = i then
      result := result + 1;
end;

function TfrmFingerPrg2.getCodeOfCombo(cmb : TComboBox): integer;
begin
  result := StrToInt(copy(cmb.Text , 1 ,pos('-' , cmb.Text)-1));
end;

procedure TfrmFingerPrg2.FormCreate(Sender: TObject);
var i : Byte;
begin
{
  adoTblFinger.Connection := frmDBS.DBConnection;
  adoTblFinger.Open;

  adoTblPersons.Connection := frmDBS.DBConnection;
  adoTblPersons.Open;
}
{  with adoQryFinger do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * from finger');  // where f.proxi = p.p_proxi
    Open;
  end;
}
end;

procedure TfrmFingerPrg2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
  done : boolean;

begin
  done := true;
  adoTblFinger.Close;
  for i := 1 to TotalReader do
    if i in rdrIdxSet then
      if not ChangeMode(Readers[i],Normal_Mode) then
        Done := false;
  if not done then
    InformationMessage(' ⁄œ«œÌ «“ œ” ê«ÂÂ« «“ Õ«·  «‰ ﬁ«· «À— «‰ê‘  Œ«—Ã ‰‘œ‰œ ' + #13
    + '»—«Ì «‰Ã«„ «Ì‰ ò«— »«Ìœ œ” ê«ÂÂ« —«“ «“ ÿ—Ìﬁ —ò„Â —Ì”  “Ì— œ” ê«Â „Ãœœ«  —«Â «‰œ«“Ì ‰„«ÌÌœ .');
end;

function TfrmFingerPrg2.HexToInt(s: string): integer;
var
  i : integer;
begin
  s := DelLeftZero(s);
  result := 0;
  for i:=1 to length(s) do
  begin
    if s[i] in ['A'..'F'] then s[i] := chr(ord(s[i])-7);
    if s[i] in ['a'..'f'] then s[i] := chr(ord(s[i])-39);
    result := result * 16 + (ord(s[i])-48);
  end;
end;

procedure TfrmFingerPrg2.btnAllClick(Sender: TObject);
var
  i : integer;
begin
  for i := 1 to grdFpDelete.RowCount - 1 do
  begin
    grdFpDelete.Cells[0 , i] := 'X';
  end;
end;

procedure TfrmFingerPrg2.btnNoneClick(Sender: TObject);
var
  i : integer;
begin
  for i := 1 to grdFpDelete.RowCount - 1 do
  begin
    grdFpDelete.Cells[0 , i] := '';
  end;
end;

procedure TfrmFingerPrg2.WaitFor(reason: string);
begin
  Mouse_Wait;
  lblMsg.Caption := reason + #254;
end;

procedure TfrmFingerPrg2.DontWait;
begin
  lblMsg.Caption := '';
  Mouse_NoWait;
end;

procedure TfrmFingerPrg2.adoQryFingerCalcFields(DataSet: TDataSet);
var
  found : Boolean;
begin
  found := adoTblPersons.Locate('p_Proxi' , adoQryFinger.FieldByName('proxi').AsString ,[]);
  if found then
  begin
    adoQryFinger.FieldByName('BarCode').AsString := adoTblPersons.FieldByName('P_Code').AsString;
    adoQryFinger.FieldByName('Name').AsString := adoTblPersons.FieldByName('P_name').AsString;
    adoQryFinger.FieldByName('Family').AsString := adoTblPersons.FieldByName('P_family').AsString;
  end;
end;

procedure TfrmFingerPrg2.FormShow(Sender: TObject);
var
  i : integer;
  adoQry : TADOQuery;
begin
////////////////////////////////Page : MOVE ////////////////////////////////////
  ChangeModeAll(Direct_Mode);

  cmbFromMoveAll.ItemIndex := 0;
  cmbToMoveAll.ItemIndex := 0;

  cmbProxiMoveOne.Items.Clear;
  cmbCodeMoveOne.Items.Clear;
  adoQry := TADOQuery.Create(Application);

  with adoQry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * from persons');
    open;
    first;
    while not eof do
    begin
      cmbProxiMoveOne.Items.Add(DelLeftZero(fieldByName('P_Proxi').AsString));
      cmbCodeMoveOne.Items.Add(DelLeftZero(fieldByName('P_Code').AsString));
      cmbNameMoveOne.Items.Add(fieldByName('P_Family').AsString + ' - ' + fieldByName('P_Name').AsString);
      Next;
    end;
  end;


////////////////////////////////Page : DELETE ////////////////////////////////////

  cmbRdrDelete.Items.Clear;
  cmbRdrDelete.Items := cmbFromMoveAll.Items;
  cmbRdrDelete.ItemIndex := 0;
  with grdFpDelete do
  begin
    Cells[1 , 0] := '—œÌ›';
    Cells[2 , 0] := 'òœ ò«— ';
    Cells[3 , 0] := '„œÌ—';
    Cells[4 , 0] := '‰«„ Œ«‰Ê«œêÌ - ‰«„';
    Cells[5 , 0] := '‘„«—Â ';
  end;

////////////////////////////////Page : View ////////////////////////////////////

  cmbRdrView.Items.Clear;
  cmbRdrView.Items := cmbFromMoveAll.Items;
  cmbRdrView.ItemIndex := 0;
  with grdFpView do
  begin
    Cells[1 , 0] := '—œÌ›';
    Cells[2 , 0] := 'òœ ò«— ';
    Cells[3 , 0] := '„œÌ—';
    Cells[4 , 0] := '‰«„ Œ«‰Ê«œêÌ - ‰«„';
    Cells[5 , 0] := '‘„«—Â ';
  end;
end;

procedure TfrmFingerPrg2.grdFpDeleteMouseUp(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cl, Rw: Longint;
begin
  with grdFpDelete do
  begin
   MouseToCell(X, Y, Cl, Rw);
    if (cl <> -1) and (rw <> -1) then
     if Cells[0, Rw] = 'X' then
        Cells[0, Rw] := ''
      else
        Cells[0, Rw] := 'X';
  end;
end;

procedure TfrmFingerPrg2.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnDelete.Click;
end;

procedure TfrmFingerPrg2.cmbProxiMoveOneChange(Sender: TObject);
begin
  cmbCodeMoveOne.ItemIndex := cmbProxiMoveOne.ItemIndex;
  cmbNameMoveOne.ItemIndex := cmbProxiMoveOne.ItemIndex;
end;

procedure TfrmFingerPrg2.rdoFromFileClick(Sender: TObject);
begin
  rdoToTerminal.Checked := true;
  rdoToFile.Enabled := false;
  txtFromFile.Enabled := True;
  btnFromFile.Enabled := True;
  cmbFromMoveAll.Enabled := false;
end;

procedure TfrmFingerPrg2.rdoToTerminalClick(Sender: TObject);
begin
  txtToFile.Enabled := not txtToFile.Enabled;
  btnToFile.Enabled := not btnToFile.Enabled;
  cmbToMoveAll.Enabled := not cmbToMoveAll.Enabled;
end;

procedure TfrmFingerPrg2.rdoFromTerminalClick(Sender: TObject);
begin
  rdoToFile.Enabled := true;
  txtFromFile.Enabled := false;
  btnFromFile.Enabled := false;
  cmbFromMoveAll.Enabled := true;
end;

procedure TfrmFingerPrg2.cmdExitClick(Sender: TObject);
begin
  canceled := true;
end;

procedure TfrmFingerPrg2.TabSheet2Enter(Sender: TObject);
begin
  grdFpView.RowCount := 2;
  grdFpView.Rows[1].Clear;
end;

procedure TfrmFingerPrg2.TabSheet3Enter(Sender: TObject);
begin
  grdFpDelete.RowCount := 2;
  grdFpDelete.Rows[1].Clear;
end;

procedure TfrmFingerPrg2.chkFormatMoveAllClick(Sender: TObject);
begin
  chkUpdate.Checked := not chkFormatMoveAll.Checked;
end;

procedure TfrmFingerPrg2.chkUpdateClick(Sender: TObject);
begin
  chkFormatMoveAll.Checked := not chkUpdate.Checked;
end;


procedure TfrmFingerPrg2.cmbCodeMoveOneChange(Sender: TObject);
begin
  cmbProxiMoveOne.ItemIndex := cmbCodeMoveOne.ItemIndex;
  cmbNameMoveOne.ItemIndex := cmbCodeMoveOne.ItemIndex;
end;

procedure TfrmFingerPrg2.cmbNameMoveOneChange(Sender: TObject);
begin
  cmbProxiMoveOne.ItemIndex := cmbCodeMoveOne.ItemIndex;
  cmbNameMoveOne.ItemIndex := cmbCodeMoveOne.ItemIndex;
end;

procedure TfrmFingerPrg2.Button1Click(Sender: TObject);
var
  i : integer;
begin
  canceled := true;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.MakeFpPocket(cmd: ansiString): AnsiString;
var
  i : integer;
  S : string;
  extra  : ansistring;
  ch1,ch2 : byte;
  checkSum : integer;
begin
  s := '';
  for i:= 1 to 13 do
    s := s + '0';
  checkSum := 0;
  for i:= 1 to 13 do
  begin
    if cmd[i*2-1] in ['A'..'F'] then cmd[i*2-1] := chr(ord(cmd[i*2-1])-7);
    if cmd[i*2] in ['A'..'F'] then cmd[i*2] := chr(ord(cmd[i*2])-7);

    if cmd[i*2-1] in ['a'..'f'] then cmd[i*2-1] := chr(ord(cmd[i*2-1])-39);
    if cmd[i*2] in ['a'..'f'] then cmd[i*2] := chr(ord(cmd[i*2])-39);

    ch1 := (ord(cmd[i*2-1]) - 48) *16;
    ch2 := ord(cmd[i*2]) - 48;
    S[i] := chr(ch1 + ch2 {+ 48});
    if i < 12 then
        checkSum := checkSum + ch1 + ch2;
  end;
  checkSum := checkSum mod 256;
  s[12] := chr(checkSum {+ 48});
  extra := copy(cmd , 27 ,length(cmd)-26);
  if Length(extra) >0 then
    Result := s + Extra //+ S[13]
  else
    Result := s;
end;

procedure Suprema_GetPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);
var
  L : Byte;
  SSS : String;
begin

  if TimeOut = 0 then
  begin
    frmComTools.ComPort.Timeouts.ReadTotalMultiplier := 5;
    frmComTools.ComPort.Timeouts.ReadTotalConstant := 5;
  end
  else
  begin
    frmComTools.ComPort.Timeouts.ReadTotalMultiplier := TimeOut;
    frmComTools.ComPort.Timeouts.ReadTotalConstant := TimeOut;
  end;

  retVal := ERR_NONE;
  frmComTools.ComPort.ReadStr(PK, Len);

  L := Length(PK);
  if L = Len then
    retVal := ERR_OFF;

  TestTest('G: ', PK);
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.SendFPCommand(rdr: TReaders; _CommandNo , _Param , _size ,_flag : string; ExtraData : AnsiString): TFpAck;
var
  PK : ansiString;
  getVal : Byte;
  isTrue : boolean;
  isSent: Boolean;
  cmnd : AnsiString;
  h , chk : integer;
begin
  if rdr.r_IsCom then
  begin
    if  ComPortInitial(rdr) then
      isTrue := true
    else
      isTrue := false;
  end
  else
    isTrue := true;
  if not isTrue then
    lblMsg.Caption := '«— »«ÿ »—ﬁ—«— ‰Ì” .'
  else
  begin
    cmnd := '40' + _CommandNo + Swap(FixLeft(_param,'0',8)) + Swap(FixLeft(_size,'0',8)) + _flag + '00' + '0A';
    pk := MakeFpPocket(cmnd);

    chk := 0;
    for h:=1 to Length(ExtraData) do
      chk := chk + ord(ExtraData[h]);
    if ExtraData <> '' then
      pk := pk + ExtraData + Str2PBCD(fixRight(swap(IntToHex(chk,4)),'0',8));

    if rdr.r_IsCom then
      isSent := SendPocket(PK)
    else if not rdr.r_IsCom and rdr.r_TCP then
      isSent := TCPSendData(pk, rdr.r_IP)
    else if not rdr.r_IsCom and not rdr.r_TCP then
      isSent := UDPSendData(pk, rdr.r_IP)
    else
      isSent := False;
    if not isSent then
      lblMsg.Caption := '«— »«ÿ »—ﬁ—«— ‰Ì” .'
    else
    begin
      pk := '';
      Sleep(700);
      if rdr.r_IsCom then
        Suprema_GetPocket(PK, 13, fpTimeOut , getVal)
      else if not rdr.r_IsCom and rdr.r_TCP then
        TCPReadData(pk, getVal)
      else if not rdr.r_IsCom and not rdr.r_TCP then
        UDPReadData(pk, getVal)
      else
        getVal := ERR_OFF;
      if length(pk) >= 13 then
      begin
        TCP_UDP_ExtraData := copy(pk , 14, length(pk)-14+1);
        with Result do
        begin
          Param1    := StrRev(copy(pk,3 ,4));
          Param2    := StrRev(copy(pk,7,4));
          ErrorCode := ord(pk[11]);
        end
      end
      else
        Result.ErrorCode := 255;
    end;
  end;
end;

//NOT ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.SendFPDBCommand(rdr: TReaders;cmnd: ansiString): boolean;
var
  PK : ansiString;
  getVal : Byte;
  isTrue: Boolean;
  isSent: Boolean;
begin
  if rdr.r_IsCom then
  begin
    if  ComPortInitial(rdr) then
      isTrue := true
    else
      isTrue := false;
  end
  else
    isTrue := true;
  if not isTrue then
    lblMsg.Caption := '«— »«ÿ »—ﬁ—«— ‰Ì” .'
  else
  begin
    cmnd := MakeFpPocket(cmnd);

    Z84_MakePocket(PK, rdr.R_Code , $3B, 0,'0'+ cmnd);

    if rdr.r_IsCom then
      isSent := SendPocket(pk)
    else if not rdr.r_IsCom and rdr.r_TCP then
      isSent := TCPSendData(pk, rdr.r_IP)
    else if not rdr.r_IsCom and not rdr.r_TCP then
      isSent := UDPSendData(pk, rdr.r_IP)
    else
      isSent := False;

    if not isSent then
      lblMsg.Caption := '«— »«ÿ »—ﬁ—«— ‰Ì” .'
    else
    begin
      if rdr.r_IsCom then
        Suprema_GetPocket(PK, 7, fpTimeOut , getVal)
      else if not rdr.r_IsCom and rdr.r_TCP then
        TCPReadData(pk, getVal)
      else if not rdr.r_IsCom and not rdr.r_TCP then
        UDPReadData(pk, getVal)
      else
        getVal := ERR_OFF;

      result := ((getVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = RDR.R_Code));
    end;
  end;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.GetFpCount(rdr: TReaders): integer;
var
  ack : TFpAck;
  i : integer;
begin
  i := 0;
  repeat
    ack := SendFPCommand(rdr , '03' , '00000000' , '00000000' , '73' , '');
    inc(i);
  until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);
  Result := HexToInt(PBCD2Str(ack.Param2)) div 2;
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg2.MakeCodeList(str : AnsiString ;lst: TStringList);
var
  i , j : integer;
  s : string;
  _Add : boolean;
  tmpl : TFingerTemplate;
begin
  for i := 1 to (Length(str) div 8)  do
  begin
    tmpl := TFingerTemplate.Create;
    tmpl.Id := PBCD2Str(StrRev(copy(str,(8*i)-7 , 4)));
//    tmpl.Id := IntToStr(hextoint(PBCD2Str(StrRev(copy(str,(8*i)-7 , 4)))));
    tmpl.AdminLevel := hextoint(PBCD2Str(StrRev(copy(str,(8*i)-2 , 1)))) div 16;
    tmpl.SubIndex := hextoint(PBCD2Str(StrRev(copy(str,(8*i)-2 , 1)))) mod 16;
    lst.AddObject(tmpl.Id , tmpl);
    tmpl := nil;
    tmpl.Free;
  end;
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg2.btnGetAllViewClick(Sender: TObject);
var
  adoQry : TADOQuery;
  code , oldCode : string;
  i , TemplateCnt  : integer;
  prsn : TPerson;
  myRow : TStrings;
  rdr : TReaders;
  CodeList : TStringList;

begin
  adoQry := TADOQuery.Create(Application);
  adoQry.Connection := frmDBS.DBConnection;

  WaitFor('œ— Õ«· ŒÊ«‰œ‰ «À— «‰ê‘ Â«Ì œ” ê«Â . (·ÿ›« ò„Ì ’»— ‰„«ÌÌœ...)');
  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrView))];
  fpList := GetFpList(rdr);

  TemplateCnt := length(fpList) div 8;
  CodeList := TStringList.Create;
  MakeCodeList(fpList,CodeList);

  statusView.Panels[0].Text := ' ⁄œ«œ ò· «›—«œ : ' + IntToStr(calculFpCount(CodeList));
  with grdFpView do
  begin
    RowCount := 2;
    Cells[0 , 1] := '';
    Cells[1 , 1] := '';
    Cells[2 , 1] := '';
    Cells[3 , 1] := '';
    Cells[4 , 1] := '';
    Cells[5 , 1] := '';
    Cells[1 , 0] := '—œÌ›';
    Cells[2 , 0] := 'òœ ò«— ';
    Cells[3 , 0] := 'Ê÷⁄Ì '{' ⁄œ«œ «‰ê‘ '};
    Cells[4 , 0] := '‰«„ Œ«‰Ê«œêÌ - ‰«„';
    Cells[5 , 0] := '‘„«—Â ';
    oldCode := '';
    for i := 0 to (CodeList.Count) - 1 do
    begin
      code := (CodeList.Objects[i] as TFingerTemplate).Id;
      if CodeList.IndexOf(code) = i then
      begin
        if i <> 0 then
          RowCount := RowCount + 1;
        Cells[1 , RowCount-1] := IntToStr(RowCount-1);
        Cells[2 , RowCount-1] := code;
//        Cells[3 , RowCount-1] := IntToStr((CodeList.Objects[i] as TFingerTemplate).SubIndex);
        if (CodeList.Objects[i] as TFingerTemplate).AdminLevel = 3 then
          Cells[3 , RowCount-1] := {Cells[3 , RowCount] + '-' + }'„œÌ—';

        if chkViewName.Checked then
        begin
          with adoQry do
          begin
            close;
            SQL.Clear;
            sql.Add('select * from persons where p_proxi like ''' + fixleft(code,'0',8) + '''');
            Open;
            first;
          end;
          if not adoQry.Eof then
            prsn := GetPerson(FixLeft(adoQry.fieldByName('P_Proxi').AsString , '0' , 8) , true)
          else
            prsn := GetPerson(FixLeft('' , '0' , 8) , false);

          Cells[4 , RowCount-1] := prsn.P_Family + ' - ' + prsn.P_Name;
          Cells[5 , RowCount-1] := prsn.P_Code;
          lblMsg.Caption :=  FloatToStrF((RowCount-1)/(calculFpCount(CodeList))*100 , ffGeneral , 3 , 3) + ' œ—’œ ';
        end;
      end;
      Application.ProcessMessages;
    end;
  end;
  adoQry.Free;
  CodeList.Free;
  DontWait;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.GetFPExtra(rdr: TReaders; size: integer): AnsiString;
var
  getVal : Byte;
begin
  result := '';
  if rdr.r_IsCom then
    Suprema_GetPocket(Result , size , 400 , GetVal)
  else
  if TCP_UDP_ExtraData <> '' then
  begin
    result := copy(TCP_UDP_ExtraData,1,size);
    TCP_UDP_ExtraData := copy(TCP_UDP_ExtraData , size +1 , length(TCP_UDP_ExtraData) - size);
  end
  else
    getVal := ERR_OFF;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.SendFp(rdr: TReaders ; fgr : TFingerTemplate): boolean;
var
  ack : TFpAck;
  i , j : integer;
  fgrCnt : integer;
begin
  Result := false;
  fgrCnt := LENGTH(FGR.Template) DIV 384;
  i := 0;
  repeat
//    ack := SendFPCommand(rdr , '87' , IntToHex(StrToInt(fgr.Id),8) , IntToHex(fgrCnt,2)+ '000180' , '71' , '');
    ack := SendFPCommand(rdr , '87' , fgr.Id , IntToHex(fgrCnt,2)+ '000180' , '71' , '');
    inc(i);
  until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);
  if (ack.ErrorCode = msg_SUCCESS) then
  begin
    for j:= 0 to fgrCnt-1 do
    begin
      ack.ErrorCode := 0;
      repeat
        ack := SendFPCommand(rdr , '87' , IntToHex(fgrcnt,4)+IntToHex(j,4) , IntToHex(384,8) , '00' , copy(fgr.Template , 1+(j*384),384));
        sleep(100);
        inc(i);
      until (ack.ErrorCode = msg_DataOk) or (i>=TryCount);
      if (ack.ErrorCode <> msg_DataOk) then
      begin
        result := false;
        exit;
      end;
    end;
    repeat
      ack := SendFPCommand(rdr , '65' , fgr.Id , IntToHex(fgr.AdminLevel , 8) , '00' , '');
      inc(i);
    until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);
    if (ack.ErrorCode = msg_SUCCESS) then
      Result := true;
  end;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.GetFpList(rdr: TReaders): AnsiString;
var
  ACK : TFpAck;
  tmp : string;
  i , j : integer;
  DataSize : integer;
  TemplateCount : integer;
  PacketCount , PacketSize : integer;
begin
  i := 0;
  PacketSize := 400;
  repeat
    ACK := SendFPCommand(rdr , '86' , '0000000' , IntToHex(PacketSize , 8)  , '00' , '');
    inc(i);
  until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);
  if ack.ErrorCode = msg_SUCCESS then
  begin
    TemplateCount := HexToInt(PBCD2Str(ack.Param1));
    DataSize  := HexToInt(PBCD2Str(ack.Param2));
    PacketCount  := (DataSize div PacketSize);
    if (DataSize mod PacketSize) <> 0 then
      inc(PacketCount);
//    sleep(700);
    tmp    := GetFPExtra(rdr, 13);
    if PacketSize < DataSize then
      result := result + GetFPExtra(rdr, PacketSize)
    else
      result := result + GetFPExtra(rdr, DataSize);
    tmp    := GetFPExtra(rdr, 4);

    for j:=1 to PacketCount -1 do
    begin
      repeat
        ACK := SendFPCommand(rdr , '86' , '0000000' , '00000000'  , '83' , '');
        inc(i);
      until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);
      if j <> (PacketCount -1) then
        result := result + GetFPExtra(rdr, PacketSize)
      else
        result := result + GetFPExtra(rdr, (DataSize mod PacketSize));
      tmp    := GetFPExtra(rdr, 4);
//      sleep(700);
    end;
  end;
//  if length(result) <> DataSize then
//    Result := '';
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg2.btnDeleteAllClick(Sender: TObject);
var
  ack : TFpAck;
  rdr :  TReaders;
  i   : integer;
begin
  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrDelete))];
  WaitFor('œ— Õ«· Õ–› ò·ÌÂ «À— «‰ê‘ Â« ( ·ÿ›« ò„Ì ’»— ‰„«ÌÌœ ...)');
  if ConfirmMessage('¬Ì« »—«Ì Õ–› ò·ÌÂ «À— «‰ê‘ Â« «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    i := 0;
    repeat
      ack := SendFPCommand(rdr ,'17' , '00000000' , '00000000' , '00' , '');
      inc(i);
    until (ack.ErrorCode = 0) or (i>=TryCount);

    If ack.ErrorCode = msg_SUCCESS then
    begin
//      grdFpList.RowCount := 2;
//      grdFpList.Rows[1].Clear;
    end;

  end;
  DontWait;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.GetFp(rdr: TReaders; Proxi: string): AnsiString;
var
  ACK : TFpAck;
  tmp : string;
  i : integer;
  TemplateSize , TemplateCount : integer;
begin
  Proxi := IntToStr(HexToInt(Proxi));
  i := 0;
  repeat
    ACK := SendFPCommand(rdr , '89' , inttohex(StrToInt(Proxi),8) ,'00000F00' , '00' , '');
    inc(i);
  until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);
  if ack.ErrorCode = msg_SUCCESS then
  begin
    TemplateCount := HexToInt(PBCD2Str(copy(ack.Param2,1,2)));
    TemplateSize  := HexToInt(PBCD2Str(copy(ack.Param2,3,2)));
    ln := TemplateSize * TemplateCount;
    sleep(400);
    tmp    := GetFPExtra(rdr, 13);
    result := GetFPExtra(rdr, ln);
    tmp    := GetFPExtra(rdr, 4);
  end;
  if length(result) <> ln then
    Result := '';
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg2.btnDelSelectedClick(Sender: TObject);
VAR
  i , rowNo: integer;
  s : TStringList;
  rdr : TReaders;
begin
  if not ConfirmMessage('¬Ì«»—«Ì Õ–› „ÿ„∆‰ Â” Ìœ ø') then
    exit;
  WaitFor('œ— Õ«· Õ–› «À— «‰ê‘  «‰ Œ«» ‘œê«‰ ...');

  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrDelete))];
  s := TStringList.Create;
  s.Clear;
  for i:= 1 to grdFpDelete.RowCount + 1 do
    if grdFpDelete.Cells[0,i] = 'X' then
      s.add(IntToStr(i));

  for i:= 0 to s.Count-1 do
  begin
    rowNo := strtoint(s.Strings[i]);
    DeleteFp(rdr , grdFpDelete.Cells[2,rowNo]);
    grdFpDelete.Cells[0,rowNo] := '';
    grdFpDelete.Cells[3,rowNo] := 'Õ–› ‘œ .';
    lblMsg.Caption := FloatToStrF((i+1)/s.Count*100 , ffGeneral , 3 , 3) + ' œ—’œ ';
  end;
  DontWait;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.DeleteFp(rdr: TReaders; Proxi: string): Boolean;
var
  code : string;
  Ack  : TFpAck;
  i : integer;
begin
  Result := false;
  i := 0;
  repeat
  Ack := SendFPCommand(rdr , '16' , proxi , '00000000' , '00' , '');
    inc(i);
  until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);

  If (Ack.ErrorCode = msg_SUCCESS) then
  begin
    InformationMessage('Õ–› »« „Ê›ﬁÌ  «‰Ã«„ ‘œ .');
    result := true;
  end
  else
    InformationMessage('«À— «‰ê‘  ›—œ »« ‘„«—Â  ' + Proxi + '—ÊÌ «Ì‰ œ” ê«Â Ì«›  ‰‘œ .')
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.isMaster(rdr: TReaders;proxi: string): boolean;
var
  ack : TFpAck;
  i : integer;
begin
  i := 0;
  repeat
      ACK := SendFPCommand(rdr , '66' , Proxi , '00000000' , '00' , '');
    inc(i);
  until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);
  if ack.ErrorCode = msg_SUCCESS then
    result := (ack.Param2[4] = #3);
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg2.btnGetAllDeleteClick(Sender: TObject);
var
  adoQry : TADOQuery;
  code , oldCode : string;
  i , TemplateCnt  : integer;
  prsn : TPerson;
  myRow : TStrings;
  rdr : TReaders;
  CodeList : TStringList;

begin
  adoQry := TADOQuery.Create(Application);
  adoQry.Connection := frmDBS.DBConnection;

  WaitFor('œ— Õ«· ŒÊ«‰œ‰ «À— «‰ê‘ Â«Ì œ” ê«Â . (·ÿ›« ò„Ì ’»— ‰„«ÌÌœ...)');
  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrDelete))];
  fpList := GetFpList(rdr);

  TemplateCnt := length(fpList) div 8;
  CodeList := TStringList.Create;
  MakeCodeList(fpList,CodeList);

  statusDelete.Panels[0].Text := ' ⁄œ«œ ò· «›—«œ : ' + IntToStr(calculFpCount(CodeList));
  with grdFpDelete do
  begin
    RowCount := 2;
    Cells[0 , 1] := '';
    Cells[1 , 1] := '';
    Cells[2 , 1] := '';
    Cells[3 , 1] := '';
    Cells[4 , 1] := '';
    Cells[5 , 1] := '';
    Cells[1 , 0] := '—œÌ›';
    Cells[2 , 0] := 'òœ ò«— ';
    Cells[3 , 0] := 'Ê÷⁄Ì '{' ⁄œ«œ «‰ê‘ '};
    Cells[4 , 0] := '‰«„ Œ«‰Ê«œêÌ - ‰«„';
    Cells[5 , 0] := '‘„«—Â ';
    oldCode := '';
    for i := 0 to (CodeList.Count) - 1 do
    begin
      code := (CodeList.Objects[i] as TFingerTemplate).Id;
      if CodeList.IndexOf(code) = i then
      begin
        if i <> 0 then
          RowCount := RowCount + 1;
        Cells[1 , RowCount-1] := IntToStr(RowCount-1);
        Cells[2 , RowCount-1] := code;
//        Cells[3 , RowCount-1] := IntToStr((CodeList.Objects[i] as TFingerTemplate).SubIndex);
        if (CodeList.Objects[i] as TFingerTemplate).AdminLevel = 3 then
          Cells[3 , RowCount-1] := {Cells[3 , RowCount] + '-' + }'„œÌ—';

        if chkDeleteName.Checked then
        begin
          with adoQry do
          begin
            close;
            SQL.Clear;
            sql.Add('select * from persons where p_proxi like ''' + fixleft(code,'0',8) + '''');
            Open;
            first;
          end;
          if not adoQry.Eof then
            prsn := GetPerson(FixLeft(adoQry.fieldByName('P_Proxi').AsString , '0' , 8) , true)
          else
            prsn := GetPerson(FixLeft('' , '0' , 8) , false);

          Cells[4 , RowCount-1] := prsn.P_Family + ' - ' + prsn.P_Name;
          Cells[5 , RowCount-1] := prsn.P_Code;
          lblMsg.Caption :=  FloatToStrF((RowCount-1)/(calculFpCount(CodeList))*100 , ffGeneral , 3 , 3) + ' œ—’œ ';
        end;
      end;
      Application.ProcessMessages;
    end;
  end;
  adoQry.Free;
  CodeList.Free;
  DontWait;
end;


//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg2.btnDeleteClick(Sender: TObject);
var
  code : string;
  Ack  : TFpAck;
  rdr : TReaders;
  i : integer;
begin
  If txtCode.Text = '' then
  begin
    InformationMessage('òœ Ê«—œ ‰‘œÂ «”  .');
    exit;
  end;
  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrDelete))];
  i := 0;
  if DeleteFp(rdr , txtCode.text) then
    lblMsg.Caption := 'Õ–› »« „Ê›ﬁÌ  «‰Ã«„ ‘œ .'
  else
    lblMsg.Caption := '«À— «‰ê‘   ›—œ „Ê—œ ‰Ÿ— —ÊÌ «Ì‰ œ” ê«Â Ì«›  ‰‘œ .';
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg2.DeleteAllFps(rdr: TReaders): Boolean;
  var
    ack : TFpAck;
    fpCnt : integer;
    i : integer;
  begin
    Result := False;
    fpCnt := GetFpCount(rdr);    if ConfirmMessage('¬Ì« »—«Ì Õ–› ò·ÌÂ «À— «‰ê‘ Â« «ÿ„Ì‰«‰ œ«—Ìœø' + #13 + ' ⁄œ«œ «À— «‰ê‘ Â«Ì „ÊÃÊœ :' + IntToStr(fpCnt)) then
    begin
      i := 0;
      repeat
        ack := SendFPCommand(rdr ,'17' , '00000000' , '00000000' , '00' , '');
        inc(i);
      until (ack.ErrorCode = 0) or (i>=TryCount);
      If ack.ErrorCode = msg_SUCCESS then
        Result := true;
    end;
  end;

//ok////////////////////////////////////////////////////////////////////////////
Function TfrmFingerPrg2.isFpEnrolled(rdr : TReaders ; Proxi : string) : Boolean;
var
  code : string;
  Ack  : TFpAck;
  i : integer;
begin
  Result := false;
  proxi := copy(proxi,3,2)+copy(proxi,1,2);
  i := 0;
  repeat
  Ack := SendFPCommand(rdr , '19' , proxi  , '00000000' , '00' , '');
    inc(i);
  until (ack.ErrorCode = msg_SUCCESS) or (i>=TryCount);

  If (Ack.ErrorCode = msg_SUCCESS) then
    result := true
  else if (Ack.ErrorCode = M2ERROR_USER_NOT_FOUND) then
    result := false;
end;

procedure TfrmFingerPrg2.btnMoveClick(Sender: TObject);
{$region ' variables '}
var
  i , jj, g , h , l       : integer;
  slFrom , slTo       : integer;
  chh                 : char;
  tmp                 : ansistring;
  rdrFrom , rdrTo     : TReaders;
  tblFrom , tblTo     : TTable;
  srcFile, DestFile   : file of char;
  kst                 : array[1..4] of char;
  k                   : integer absolute kst;
  fpFromList,fpToList : TStringList;
  fingerRec           : TFingerTemplate;
  blobF : TBlobField;
  bs : TStream;

{$endregion ' variables '}
  procedure CopyFps;
  var
    i  , jj , cnt : integer;
    addList : TStringList;
    issent: Boolean;
    fgrtmpl :AnsiString;
    FoundInSrc , existInDest : Boolean;
  begin
    addList := TStringList.Create;
    addList.Clear;
    FoundInSrc := false;
    existInDest := false;
    for i := 0 to (fpFromList.Count)-1 do
      if (chkUpdate.Checked and (fpToList.IndexOf(fpFromList[i]) = -1)) or chkFormatMoveAll.Checked then
      begin
        if addList.IndexOf(fpFromList[i]) = -1 then
          if (rdoMoveAll.Checked) or ((rdoMoveOne.Checked) and (fixleft(cmbProxiMoveOne.Text,'0',8) = fixleft(fpFromList[i],'0',8))) then
          begin
            addList.AddObject(fpFromList[i],fpFromList.Objects[i]);
            FoundInSrc := true;
          end;
      end
      else
        existInDest := True;

    Cnt := addlist.Count;
    if cnt = 0 then
    begin
      if (rdoMoveOne.Checked) and not existInDest and FoundInSrc then
        InformationMessage('«À— «‰ê‘  ›—œ „Ê—œ ‰Ÿ— œ— „»œ« „ÊÃÊœ ‰„Ì »«‘œ .')
      else
        InformationMessage('»—Ê“ —”«‰Ì ﬁ»·« «‰Ã«„ ‘œÂ «”  .');
      exit;
    end;
    statusFrom.Panels[0].Text := '0 «“ ' + inttostr(cnt);
    statusTo.Panels[0].Text := FloatToStrF((0/addList.Count)*100 , ffGeneral , 3 , 3) + '  œ—’œ ';
    for i := 0 to cnt - 1 do
    {$region ' Copy ALL '}
    begin
      if Canceled then exit;
      if rdoFromTerminal.Checked then
        (addList.Objects[i] as TFingerTemplate).Template := GetFp(rdrFrom , addList[i]);
      Sleep(700);
      issent := false;
      if (rdoToTerminal.Checked) then
          issent := SendFp(rdrTo , addList.Objects[i] as TFingerTemplate)
      else
        with tblTo do
        begin
          append;
          fieldByName('Code').AsString := (addList.Objects[i] as TFingerTemplate).Id;
//          fieldByName('Code').AsString := inttostr(hextoint((addList.Objects[i] as TFingerTemplate).Id));
//        fieldByName('Code').AsString := IntToHex(StrToInt((addList.Objects[i] as TFingerTemplate).Id),8);
          fieldByName('AdminLevel').AsInteger := (addList.Objects[i] as TFingerTemplate).AdminLevel;
          fgrtmpl := (addList.Objects[i] as TFingerTemplate).Template;
          for jj := 0 to 20 do
            tblTo.FieldByName('fgr' + IntToStr(jj)).AsString := copy(fgrtmpl , (jj*200)+1 , 200);

          Post;
          issent := true;
        end;
      if isSent then
      begin
        statusFrom.Panels[0].Text := inttostr(i+1) + ' «“ ' + inttostr(addList.Count);
        statusTo.Panels[0].Text := FloatToStrF((i+1)/addList.Count*100 , ffGeneral , 3 , 3) + ' œ—’œ ';
      end;
      Sleep(500);
      Application.ProcessMessages;
    end;
    {$endregion ' Copy ALL '}
  end;
  Function MakeFgrTbl(tblName : string): boolean;
  var i,jj : integer;
  begin
    with TTable.Create(Application) do
    begin
      Active := False;
      DatabaseName := ExtractFilePath(tblName);
      TableType := ttParadox;
      TableName := ExtractFileName(tblName);
      FieldDefs.Clear;
      IndexDefs.Clear;

      with FieldDefs.AddFieldDef do
      begin
        Name := 'Code';
        DataType := ftString;
        Size := 8;
      end;

      with FieldDefs.AddFieldDef do
      begin
        Name := 'AdminLevel';
        DataType := ftInteger;
        Size := 0;
      end;

      for jj:= 0 to 20 do
        with FieldDefs.AddFieldDef do
        begin
          Name := 'Fgr' + IntToStr(jj);
          DataType := ftBytes;
          Size := 200;
        end;

      try
        CreateTable;
        Result := True;
      except
        Result := False;
      end;
      Free;
    end;
  end;
begin
  canceled := false;
  fpFromList := TStringList.Create;
  fpToList   := TStringList.Create;

  tblFrom := TTable.Create(Application);
  tblTo   := TTable.Create(Application);

  if rdoFromTerminal.Checked then
  begin
    rdrFrom := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbFromMoveAll))];
    MakeCodeList(GetFpList(rdrFrom) , fpFromList);
    sleep(500);
    {$region ' Terminal To Terminal '}
    if rdoToTerminal.Checked then
    begin
      if cmbFromMoveAll.ItemIndex = cmbToMoveAll.ItemIndex then
      begin
        InformationMessage('œ” ê«Â „ﬁ’œ Ê„»œ« ‰»«Ìœ Ìò”«‰ »«‘‰œ .');
        exit;
      end;
      rdrTo := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbToMoveAll))];
      MakeCodeList(GetFpList(rdrTo),fpToList);
    end
    {$Endregion ' Terminal To Terminal '}
    {$region ' Terminal To File  '}
    else if rdoToFile.Checked then
    begin
      if txtToFile.Text = '' then
      begin
        ErrorMessage('›«Ì· „ﬁ’œ „‘Œ’ ‰Ì” .');
        txtToFile.SetFocus;
        exit;
      end
      else
      if FileExists(txtToFile.Text) then
      begin
        if chkFormatMoveAll.Checked then
        begin
          if not ConfirmMessage('›«Ì· «‰ Œ«» ‘œÂ ÊÃÊœ œ«—œ. ¬Ì« „Ì ŒÊ«ÂÌœ —ÊÌ ¬‰ »«“‰ÊÌ”Ì ‰„«ÌÌœø') then
            Exit
          else
          begin
//            qryTo.SQL.Clear;
//            qryTo.SQL.Add('Delete * from ' + txtToFile.Text);
//            qryTo.ExecSQL;
          end;
        end;
      end
      else
        if not MakeFgrTbl(txtToFile.Text) then
        begin
          ErrorMessage('Œÿ« œ— «ÌÃ«œ ›«Ì·');
          exit;
        end;

      with tblTo do
      begin
        Active := False;
//        ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\test.mdb;';
        DatabaseName := ExtractFilePath(txtToFile.Text);
        TableType := ttParadox;
        TableName := ExtractFileName(txtToFile.Text);
        Open;
      end;

      while not tblTo.Eof do
      begin
        if fpToList.IndexOf(tblTo.fieldByName('Code').AsString) = -1 then
        begin
          fingerRec := TFingerTemplate.Create;
          fingerRec.Id := tblTo.fieldByName('Code').AsString;
          fingerRec.AdminLevel := tblTo.fieldByName('AdminLevel').AsInteger;
          fingerRec.Template := '';
          for jj := 0 to 20 do
            fingerRec.Template := fingerRec.Template + tblTo.FieldByName('fgr' + IntToStr(jj)).AsString;
          fpToList.AddObject(fingerRec.Id , fingerRec);
          fingerRec := nil;
          fingerRec.Free;
        end;
        tblTo.Next;
      end;
    end;
    {$endregion ' Terminal To File  '}
  end
  {$region ' File To Terminal '}
  else if rdoFromFile.Checked then
  begin
    if txtFromFile.Text = '' then
    begin
      ErrorMessage('›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
      txtFromFile.SetFocus;
      Exit;
    end
    else if not FileExists(txtFromFile.Text) then
    begin
      ErrorMessage('›«Ì· Ê—ÊœÌ ÊÃÊœ ‰œ«—œ.');
      txtFromFile.SetFocus;
      exit;
    end;
    with tblFrom do
    begin
      Active := False;
//      ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\test.mdb;';
        DatabaseName := ExtractFilePath(txtFromFile.Text);
      TableType := ttParadox;
      TableName := ExtractFileName(txtFromFile.Text);
      Open;
    end;

    while not tblFrom.Eof do
    begin
      if fpFromList.IndexOf(tblFrom.fieldByName('Code').AsString) = -1 then
      begin
        fingerRec := TFingerTemplate.Create;
        fingerRec.Id := tblFrom.fieldByName('Code').AsString;
        fingerRec.AdminLevel := tblFrom.fieldByName('AdminLevel').AsInteger;
        fingerRec.Template := '';
        for jj := 0 to 20 do
          fingerRec.Template := fingerRec.Template + tblFrom.FieldByName('fgr' + IntToStr(jj)).AsString;

        fpFromList.AddObject(fingerRec.Id , fingerRec);
        fingerRec := nil;
        fingerRec.Free;
      end;
      tblFrom.Next;
    end;

    rdrTo := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbToMoveAll))];
    MakeCodeList(GetFpList(rdrTo),fpToList);
  end;
  {$endregion ' File To Terminal '}

  with statusFrom do
  begin
    Panels[1].Text := ' ⁄œ«œ ò· : ' + IntToStr(calculFpCount(fpFromList));
    Panels[2].Text := ' „»œ« : ' + rdrFrom.R_Name;
   end;
  with statusTo do
  begin
    Panels[1].Text := ' ⁄œ«œ ò· : ' + IntToStr(calculFpCount(fpToList));
    Panels[2].Text := ' „ﬁ’œ : ' + rdrTo.R_Name;
  end;

  if rdoToTerminal.Checked then
  begin
    if chkFormatMoveAll.Checked then
    begin
      if not DeleteAllFps(rdrTo) then
        exit;
      sleep(1000);
    end;
    CopyFps;
  end
  else if rdoToFile.Checked then
  begin
    CopyFps;
  end;
  tblTo.Close  ; tblTo.free;
  tblFrom.Close; tblFrom.free;
end;

//procedure TfrmFingerPrg.btnMoveOneClick(Sender: TObject);
//var
//  i : integer;
//  rdrFrom , rdrTo : TReaders;
//  fp : TFingerTemplate;
//  slFrom , slTo : integer;
//begin
//  rdrFrom := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbFromMoveAll)];
//  rdrTo := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbToMoveAll)];
//  fp := TFingerTemplate.Create;
//  if cmbFromMoveAll.ItemIndex = cmbToMoveAll.ItemIndex then
//    InformationMessage('œ” ê«Â „ﬁ’œ Ê„»œ« ‰»«Ìœ Ìò”«‰ »«‘‰œ .')
//  else
//  begin
//    if cmbProxiMoveOne.Text = '' then
//      ErrorMessage('‘„«—Â ò«—  «‰ Œ«» ‰‘œÂ «”  .')
//    else
//    begin
//      WaitFor('œ— Õ«· «‰ ﬁ«· ...');
//      fp.Id := cmbProxiMoveOne.Text;
//      fp.Template := GetFp(rdrFrom , );
////      sleep(800);
//      if Length(fp) <> 0 then
//      begin
//
//        if SendFp(rdrTo , cmbProxiMoveOne.Text , fp) then
//        begin
//          InformationMessage('«—”«· »« „Ê›ﬁÌ  «‰Ã«„ ‘œ .');
//          if chkFormatOne.Checked then
//            DeleteFp(rdrFrom,cmbProxiMoveOne.Text)
//        end
//        else
//        begin
//          DontWait;
//          ErrorMessage('«—”«· «‰Ã«„ ‰‘œ.');
//          exit;
//        end;
//      end
//      else
//      begin
//        DontWait;
//        ErrorMessage('«À— «‰ê‘  ›—œ „Ê—œ ‰Ÿ— œ— œ” ê«Â „»œ« ÊÃÊœ ‰œ«—œ.');
//        exit;
//      end;
//      DontWait;
//    end;
//  end;
//end;



function TfrmFingerPrg2.swap(str : string) : string;
begin
  result := copy(str,7,2)+ copy(str,5,2)+ copy(str,3,2)+copy(str,1,2);
end;
function TfrmFingerPrg2.ChangeMode(rdr : treaders ; Mode: integer): boolean;
var
  i : integer;
  pk,s : string;
  getVal : byte;
  isSent: Boolean;
begin
  case mode of
    Direct_Mode :
      begin
        Z84_MakePocket(pk,rdr.R_Code , $1D, 0,'');
        if rdr.r_IsCom then
        begin
          if ComPortInitial(rdr) then
            isSent := SendPocket(PK)
          else
            isSent := False;
        end
        else if not rdr.r_IsCom and rdr.r_TCP then
          isSent := TCPSendData(pk, rdr.r_IP)
        else if not rdr.r_IsCom and not rdr.r_TCP then
          isSent := UDPSendData(pk, rdr.r_IP)
        else
          isSent := False;

        if not isSent then
          Result := False
        else
        begin
          if rdr.r_IsCom then
            Suprema_GetPocket(PK, 1, 2000, getVal)
          else if not rdr.r_IsCom and rdr.r_TCP then
            TCPReadData(pk, getVal)
          else if not rdr.r_IsCom and not rdr.r_TCP then
            UDPReadData(pk, getVal);
          Result := (pk = #$55);
        end;
      end;
    Normal_Mode :
      begin
        Result := true;
        for i:=1 to 100 do
          pk := pk + '0';
        if rdr.r_IsCom then
        begin
          if ComPortInitial(rdr) then
            isSent := SendPocket(PK)
          else
            isSent := False;
        end
        else if not rdr.r_IsCom and rdr.r_TCP then
          isSent := TCPSendData(PK, rdr.r_IP)
        else if not rdr.r_IsCom and not rdr.r_TCP then
          isSent := UDPSendData(PK, rdr.r_IP);
        Result := isSent;
      end;
  end;
end;
procedure TfrmFingerPrg2.SaveFinger(tbl : TTable ; fgr : AnsiString);
var
  i : integer;
begin
end;
function TfrmFingerPrg2.LoadFinger(tbl : TTable) : AnsiString;
var
  i : integer;
begin
  result := '';
  for i := 0 to 15 do
    result := result + tbl.FieldByName('fgr' + IntToStr(i)).AsString;
end;


procedure TfrmFingerPrg2.rdoMoveOneClick(Sender: TObject);
begin
  grpSelectOne.Enabled := true;
end;

procedure TfrmFingerPrg2.rdoMoveAllClick(Sender: TObject);
begin
  grpSelectOne.Enabled := false;
end;

procedure TfrmFingerPrg2.btnFromFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    txtFromFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TfrmFingerPrg2.btnToFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    txtToFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TfrmFingerPrg2.rdoToFileClick(Sender: TObject);
begin
  txtToFile.Enabled := not txtToFile.Enabled;
  btnToFile.Enabled := not btnToFile.Enabled;
  cmbToMoveAll.Enabled := not cmbToMoveAll.Enabled;
end;

procedure TfrmFingerPrg2.ChangeModeAll(Mode : integer);
var
  i: integer;
begin
  cmbFromMoveAll.Items.Clear;
  cmbToMoveAll.Items.Clear;

  for i := 1 to TotalReader do
    if i in rdrIdxSet then
    begin
      cmbFromMoveAll.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);
      cmbToMoveAll.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);
      ChangeMode(Readers[i],Mode);
    end;
end;

end.


