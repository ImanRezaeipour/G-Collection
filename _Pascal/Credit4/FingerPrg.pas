unit FingerPrg;

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


  TfrmFingerPrg = class(TForm)
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

    function isMaster(proxi: string; masters: AnsiString): boolean;
    function SendFPCommand(rdr: TReaders; cmnd: ansiString): TFpAck;
    Function SendFPDBCommand(rdr : TReaders ;cmnd : ansiString) : boolean;
    function GetFPExtra(rdr: TReaders; size: integer): AnsiString;
    Function SendFPExtra(rdr : TReaders ;cmnd : ansiString) : boolean;

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
  end;


Const
  fpTimeOut               = 1000;
  tryCount                =1;

  msg_SUCCESS             = $61;
  msg_DataOk              = $83;
  msg_InvalidID           = $76;

  M2ERROR_NONE            = 0 ;  //0x00
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
function TfrmFingerPrg.calculFpCount(lst : TStringList) : integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to lst.Count-1 do
    if lst.IndexOf(lst[i]) = i then
      result := result + 1;
end;

function TfrmFingerPrg.getCodeOfCombo(cmb : TComboBox): integer;
begin
  result := StrToInt(copy(cmb.Text , 1 ,pos('-' , cmb.Text)-1));
end;

procedure TfrmFingerPrg.FormCreate(Sender: TObject);
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

procedure TfrmFingerPrg.FormClose(Sender: TObject; var Action: TCloseAction);
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
    InformationMessage('������ �� ��ʐ���� �� ���� ������ ��� ���� ���� ����� ' + #13
    + '���� ����� ��� ��� ���� ��ʐ���� ��� �� ���� ј�� ���� ��� ��ʐ�� �����  ��� ������ ������ .');
end;

function TfrmFingerPrg.HexToInt(s: string): integer;
var
  i : integer;
begin
  DelLeftZero(s);
  result := 0;
  for i:=1 to length(s) do
  begin
    if s[i] in ['A'..'F'] then s[i] := chr(ord(s[i])-7);
    if s[i] in ['a'..'f'] then s[i] := chr(ord(s[i])-39);
    result := result * 16 + (ord(s[i])-48);
  end;
end;

procedure TfrmFingerPrg.btnAllClick(Sender: TObject);
var
  i : integer;
begin
  for i := 1 to grdFpDelete.RowCount - 1 do
  begin
    grdFpDelete.Cells[0 , i] := 'X';
  end;
end;

procedure TfrmFingerPrg.btnNoneClick(Sender: TObject);
var
  i : integer;
begin
  for i := 1 to grdFpDelete.RowCount - 1 do
  begin
    grdFpDelete.Cells[0 , i] := '';
  end;
end;

procedure TfrmFingerPrg.WaitFor(reason: string);
begin
  Mouse_Wait;
  lblMsg.Caption := reason + #254;
end;

procedure TfrmFingerPrg.DontWait;
begin
  lblMsg.Caption := '';
  Mouse_NoWait;
end;

procedure TfrmFingerPrg.adoQryFingerCalcFields(DataSet: TDataSet);
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

procedure TfrmFingerPrg.FormShow(Sender: TObject);
var
  i : integer;
  adoQry : TADOQuery;
begin
////////////////////////////////Page : MOVE ////////////////////////////////////

  cmbFromMoveAll.Items.Clear;
  cmbToMoveAll.Items.Clear;

  for i := 1 to TotalReader do
    if i in rdrIdxSet then
    begin
      cmbFromMoveAll.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);
      cmbToMoveAll.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);
      ChangeMode(Readers[i],Direct_Mode);
    end;

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
      cmbProxiMoveOne.Items.Add(DelLeftZero(copy(fieldByName('P_Proxi').AsString,length(fieldByName('P_Proxi').AsString)-3 , 4)));
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
    Cells[1 , 0] := '����';
    Cells[2 , 0] := '�� ����';
    Cells[3 , 0] := '����';
    Cells[4 , 0] := '��� �����ϐ� - ���';
    Cells[5 , 0] := '�����';
  end;

////////////////////////////////Page : View ////////////////////////////////////

  cmbRdrView.Items.Clear;
  cmbRdrView.Items := cmbFromMoveAll.Items;
  cmbRdrView.ItemIndex := 0;
  with grdFpView do
  begin
    Cells[1 , 0] := '����';
    Cells[2 , 0] := '�� ����';
    Cells[3 , 0] := '����';
    Cells[4 , 0] := '��� �����ϐ� - ���';
    Cells[5 , 0] := '����� ';
  end;
end;

procedure TfrmFingerPrg.grdFpDeleteMouseUp(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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

procedure TfrmFingerPrg.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnDelete.Click;
end;

procedure TfrmFingerPrg.cmbProxiMoveOneChange(Sender: TObject);
begin
  cmbCodeMoveOne.ItemIndex := cmbProxiMoveOne.ItemIndex;
  cmbNameMoveOne.ItemIndex := cmbProxiMoveOne.ItemIndex;
end;

procedure TfrmFingerPrg.rdoFromFileClick(Sender: TObject);
begin
  rdoToTerminal.Checked := true;
  rdoToFile.Enabled := false;
  txtFromFile.Enabled := True;
  btnFromFile.Enabled := True;
  cmbFromMoveAll.Enabled := false;
end;

procedure TfrmFingerPrg.rdoToTerminalClick(Sender: TObject);
begin
  txtToFile.Enabled := not txtToFile.Enabled;
  btnToFile.Enabled := not btnToFile.Enabled;
  cmbToMoveAll.Enabled := not cmbToMoveAll.Enabled;
end;

procedure TfrmFingerPrg.rdoFromTerminalClick(Sender: TObject);
begin
  rdoToFile.Enabled := true;
  txtFromFile.Enabled := false;
  btnFromFile.Enabled := false;
  cmbFromMoveAll.Enabled := true;
end;

procedure TfrmFingerPrg.cmdExitClick(Sender: TObject);
begin
  canceled := true;
end;

procedure TfrmFingerPrg.TabSheet2Enter(Sender: TObject);
begin
  grdFpView.RowCount := 2;
  grdFpView.Rows[1].Clear;
end;

procedure TfrmFingerPrg.TabSheet3Enter(Sender: TObject);
begin
  grdFpDelete.RowCount := 2;
  grdFpDelete.Rows[1].Clear;
end;

procedure TfrmFingerPrg.chkFormatMoveAllClick(Sender: TObject);
begin
  chkUpdate.Checked := not chkFormatMoveAll.Checked;
end;

procedure TfrmFingerPrg.chkUpdateClick(Sender: TObject);
begin
  chkFormatMoveAll.Checked := not chkUpdate.Checked;
end;


procedure TfrmFingerPrg.cmbCodeMoveOneChange(Sender: TObject);
begin
  cmbProxiMoveOne.ItemIndex := cmbCodeMoveOne.ItemIndex;
  cmbNameMoveOne.ItemIndex := cmbCodeMoveOne.ItemIndex;
end;

procedure TfrmFingerPrg.cmbNameMoveOneChange(Sender: TObject);
begin
  cmbProxiMoveOne.ItemIndex := cmbCodeMoveOne.ItemIndex;
  cmbNameMoveOne.ItemIndex := cmbCodeMoveOne.ItemIndex;
end;

procedure TfrmFingerPrg.Button1Click(Sender: TObject);
var
  i : integer;
begin
  canceled := true;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.MakeFpPocket(cmd: ansiString): AnsiString;
var
  i : integer;
  S : string;
  ch1,ch2 : byte;
  checkSum : integer;
begin
  S := '000000000000';
  checkSum := 0;
  for i:= 1 to 12 do
  begin
    if cmd[i*2-1] in ['A'..'F'] then cmd[i*2-1] := chr(ord(cmd[i*2-1])-7);
    if cmd[i*2] in ['A'..'F'] then cmd[i*2] := chr(ord(cmd[i*2])-7);

    if cmd[i*2-1] in ['a'..'f'] then cmd[i*2-1] := chr(ord(cmd[i*2-1])-39);
    if cmd[i*2] in ['a'..'f'] then cmd[i*2] := chr(ord(cmd[i*2])-39);

    ch1 := (ord(cmd[i*2-1]) - 48) *16;
    ch2 := ord(cmd[i*2]) - 48;
    S[i] :=  chr(ch1 + ch2);
    checkSum := checkSum + ch1 + ch2;
  end;
  checkSum := checkSum mod 256;
  s[12] := chr(checkSum);
  Result := s;
end;

procedure Secugen_GetPocket(var PK : String; Len, TimeOut : Integer; var retVal : Byte);
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
function TfrmFingerPrg.SendFPCommand(rdr: TReaders; cmnd: ansiString): TFpAck;
var
  PK : ansiString;
  getVal : Byte;
  isTrue : boolean;
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
    lblMsg.Caption := '������ ������ ����.'
  else
  begin
    cmnd := MakeFpPocket(cmnd);
    PK := CMND;
//    Z84_MakePocket(PK, RDR.R_Code , $3B, 0,'0'+ cmnd);

    if rdr.r_IsCom then
      isSent := SendPocket(pk)
    else if not rdr.r_IsCom and rdr.r_TCP then
      isSent := TCPSendData(pk, rdr.r_IP)
    else if not rdr.r_IsCom and not rdr.r_TCP then
      isSent := UDPSendData(pk, rdr.r_IP)
    else
      isSent := False;

    if not isSent then
      lblMsg.Caption := '������ ������ ����.'
    else
    begin
      Sleep(700);
      pk := '';
      if rdr.r_IsCom then
        Secugen_GetPocket(PK, 12, fpTimeOut , getVal)
      else if not rdr.r_IsCom and rdr.r_TCP then
        TCPReadData(pk, getVal)
      else if not rdr.r_IsCom and not rdr.r_TCP then
        UDPReadData(pk, getVal)
      else
        getVal := ERR_OFF;

      if length(pk) >= 12 then
      begin
        TCP_UDP_ExtraData := copy(pk , 13, length(pk)-13+1);
        with Result do
        begin
          Param1    := StrRev(copy(pk,3 ,2));
          Param2    := StrRev(copy(pk,5,2));
          lwExtra   := StrRev(copy(pk,7,2));
          hwExtra   := StrRev(copy(pk,9,2));
          ErrorCode := ord(pk[11]);
        end;
      end
      else
        Result.ErrorCode := 255;
    end;
  end;
end;

//NOT ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.SendFPDBCommand(rdr: TReaders;cmnd: ansiString): boolean;
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
    lblMsg.Caption := '������ ������ ����.'
  else
  begin
    cmnd := MakeFpPocket(cmnd);

//    Z84_MakePocket(PK, rdr.R_Code , $3B, 0,'0'+ cmnd);
    PK := CMND;
    if rdr.r_IsCom then
      isSent := SendPocket(pk)
    else if not rdr.r_IsCom and rdr.r_TCP then
      isSent := TCPSendData(pk, rdr.r_IP)
    else if not rdr.r_IsCom and not rdr.r_TCP then
      isSent := UDPSendData(pk, rdr.r_IP)
    else
      isSent := False;

    result := false;
    if not isSent then
      lblMsg.Caption := '������ ������ ����.'
    else
      result := true;
  end;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.GetFpCount(rdr: TReaders): integer;
var
  ack : TFpAck;
  i : integer;
begin
  i := 0;
  repeat
    ack := SendFPCommand(rdr , '007000000000000000000');
    inc(i);
  until (ack.ErrorCode=0) or (i>=5);
  Result := HexToInt(PBCD2Str(ack.Param1));
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg.MakeCodeList(str : AnsiString ;lst: TStringList);
var
  i , j : integer;
  s : string;
  _Add : boolean;
  tmpl : TFingerTemplate;
begin
  for i := 1 to (Length(str) div 2)  do
  begin
    tmpl := TFingerTemplate.Create;
    tmpl.Id := PBCD_Str(StrRev(copy(str,(2*i)-1 , 2)),4);
    lst.AddObject(tmpl.Id , tmpl);
    tmpl := nil;
    tmpl.Free;
  end;
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg.btnGetAllViewClick(Sender: TObject);
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

  WaitFor('�� ��� ������ ��� ������� ��ʐ�� . (���� ��� ��� ������...)');
  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrView))];
  fpList := GetFpList(rdr);

  TemplateCnt := length(fpList) div 2;
  CodeList := TStringList.Create;
  MakeCodeList(fpList,CodeList);

  statusView.Panels[0].Text := '����� �� ����� : ' + IntToStr(calculFpCount(CodeList));
  with grdFpView do
  begin
    RowCount := 2;
    Cells[0 , 1] := '';
    Cells[1 , 1] := '';
    Cells[2 , 1] := '';
    Cells[3 , 1] := '';
    Cells[4 , 1] := '';
    Cells[5 , 1] := '';
    Cells[1 , 0] := '����';
    Cells[2 , 0] := '�� ����';
    Cells[3 , 0] := '�����'{'����� ����'};
    Cells[4 , 0] := '��� �����ϐ� - ���';
    Cells[5 , 0] := '����� ';
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
          Cells[3 , RowCount-1] := {Cells[3 , RowCount] + '-' + }'����';

        if chkViewName.Checked then
        begin
          with adoQry do
          begin
            close;
            SQL.Clear;
            sql.Add('select * from persons where p_proxi like ''%' + code + '''');
            Open;
            first;
          end;
          if not adoQry.Eof then
            prsn := GetPerson(FixLeft(adoQry.fieldByName('P_Proxi').AsString , '0' , 8) , true)
          else
            prsn := GetPerson(FixLeft('' , '0' , 8) , false);

          Cells[4 , RowCount-1] := prsn.P_Family + ' - ' + prsn.P_Name;
          Cells[5 , RowCount-1] := prsn.P_Code;
          lblMsg.Caption :=  FloatToStrF((RowCount-1)/(calculFpCount(CodeList))*100 , ffGeneral , 3 , 3) + ' ���� ';
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
function TfrmFingerPrg.GetFPExtra(rdr: TReaders; size: integer): AnsiString;
var
  getVal : Byte;
begin
  result := '';
  if rdr.r_IsCom then
    Secugen_GetPocket(Result , size , 800 , GetVal)
  else
  if TCP_UDP_ExtraData <> '' then
  begin
    result := copy(TCP_UDP_ExtraData,1,size);
    TCP_UDP_ExtraData := copy(TCP_UDP_ExtraData , size +1 , length(TCP_UDP_ExtraData) - size);
  end
  else
    getVal := ERR_OFF;
end;
////////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.SendFPExtra(rdr: TReaders;cmnd: ansiString): boolean;
var
  i ,iMax : integer;
  pk,data : ansistring;
  len : byte;
  getVal : Byte;
  tmp : ansistring;
  PKNo : char;
  isSent: Boolean;
begin
    PK := cmnd;
    if rdr.r_IsCom then
      isSent := SendPocket(pk)
    else if not rdr.r_IsCom and rdr.r_TCP then
      isSent := TCPSendData(pk, rdr.r_IP)
    else if not rdr.r_IsCom and not rdr.r_TCP then
      isSent := UDPSendData(pk, rdr.r_IP)
    else
      isSent := False;
    result := issent;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.SendFp(rdr: TReaders ; fgr : TFingerTemplate): boolean;
var
  ack : Boolean;
  ack2 :Boolean;
  i : integer;
begin
  Result := false;
  i := 0;
  repeat
    ack := SendFPDBCommand(rdr ,'0071000000003003000000');
    inc(i);
  until ack or (i>=5);
  if ack then
  begin
    ack2 := SendFPExtra(rdr , COPY(fgr.Template,1,816));
    if ack2 then
      Result := true;
  end;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.GetFpList(rdr: TReaders): AnsiString;
var
  ack : TFpAck;
  i : integer;
begin
  i := 0;
  repeat
    ACK := SendFPCommand(rdr , '007d000000000000000000') ;
    inc(i);
  until (ack.ErrorCode = 0) or (i>=5);

  if ack.ErrorCode = 0 then
  begin
    sleep(500);
    result := GetFPExtra(rdr, 2 * HexToInt(PBCD2Str(ack.Param1)));
  end;
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg.btnDeleteAllClick(Sender: TObject);
var
  ack : TFpAck;
  rdr :  TReaders;
  i   : integer;
begin
  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrDelete))];
  WaitFor('�� ��� ��� ���� ��� ������ ( ���� ��� ��� ������ ...)');
  if ConfirmMessage('��� ���� ��� ���� ��� ������ ������� ����Ͽ') then
  begin
    i := 0;
    repeat
      ack := SendFPCommand(rdr ,'0076000000000000000000');
      inc(i);
    until (ack.ErrorCode = 0) or (i>=5);

    If ack.ErrorCode = M2ERROR_NONE then
    begin
      grdFpDelete.RowCount := 2;
      grdFpDelete.Rows[1].Clear;
    end;

  end;
  DontWait;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.GetFp(rdr: TReaders; Proxi: string): AnsiString;
var
  ACK : TFpAck;
  code : string;
  i : integer;
begin
  code := Proxi;
  code := copy(code,3,2)+copy(code,1,2);
  i := 0;
  repeat
  ACK := SendFPCommand(rdr , '0073' + code + '00000000000000') ;
    inc(i);
  until (ack.ErrorCode = 0) or (i>=5);

  if ack.ErrorCode = 0 then
    Result := GetFPExtra(rdr,816);
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg.btnDelSelectedClick(Sender: TObject);
VAR
  i , rowNo: integer;
  s : TStringList;
  rdr : TReaders;
begin
  if not ConfirmMessage('������� ��� ����� ����� �') then
    exit;
  WaitFor('�� ��� ��� ��� ���� ������ �ϐ�� ...');

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
    grdFpDelete.Cells[3,rowNo] := '��� �� .';
    lblMsg.Caption := FloatToStrF((i+1)/s.Count*100 , ffGeneral , 3 , 3) + ' ���� ';
  end;
  DontWait;
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.DeleteFp(rdr: TReaders; Proxi: string): Boolean;
var
  code : string;
  Ack  : TFpAck;
  i : integer;
begin
  Result := false;
{
  code := StrRev(copy(StrRev(GetPerson(FixLeft(txtPerCode.Text,'0',8) , false).P_Proxi) , 1,4));
  code := copy(code,3,2)+copy(code,1,2);
}
  proxi := copy(proxi,3,2)+copy(proxi,1,2);
  i := 0;
  repeat
  Ack := SendFPCommand(rdr , '0072' + proxi  + '00000000000000');
    inc(i);
  until (ack.ErrorCode = 0) or (i>=5);

  If (Ack.ErrorCode = M2ERROR_NONE) then
  begin
//    InformationMessage('��� �� ������ ����� �� .');
    result := true;
  end
  else if (Ack.ErrorCode = M2ERROR_DB_NO_DATA) or (Ack.ErrorCode = M2ERROR_DB_WRONG_USERID) then
    InformationMessage('��� ���� ��� �� �����  ' + Proxi + '��� ��� ��ʐ�� ���� ��� .')
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.isMaster(proxi: string; masters: AnsiString): boolean;
var
  i : integer;
  m : string;
begin
  result := false;
  m := chr(HexToint(copy(proxi,3,2)))   + chr(HexToint(copy(proxi,1,2)));
  if pos(m , masters) <> 0 then
    Result := true
  else
    Result := false;
end;

//ok////////////////////////////////////////////////////////////////////////////
procedure TfrmFingerPrg.btnGetAllDeleteClick(Sender: TObject);
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

  WaitFor('�� ��� ������ ��� ������� ��ʐ�� . (���� ��� ��� ������...)');
  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrDelete))];
  fpList := GetFpList(rdr);

  TemplateCnt := length(fpList) div 2;
  CodeList := TStringList.Create;
  MakeCodeList(fpList,CodeList);

  statusDelete.Panels[0].Text := '����� �� ����� : ' + IntToStr(calculFpCount(CodeList));
  with grdFpDelete do
  begin
    RowCount := 2;
    Cells[0 , 1] := '';
    Cells[1 , 1] := '';
    Cells[2 , 1] := '';
    Cells[3 , 1] := '';
    Cells[4 , 1] := '';
    Cells[5 , 1] := '';
    Cells[1 , 0] := '����';
    Cells[2 , 0] := '�� ����';
    Cells[3 , 0] := '�����'{'����� ����'};
    Cells[4 , 0] := '��� �����ϐ� - ���';
    Cells[5 , 0] := '����� ';
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
          Cells[3 , RowCount-1] := {Cells[3 , RowCount] + '-' + }'����';

        if chkDeleteName.Checked then
        begin
          with adoQry do
          begin
            close;
            SQL.Clear;
            sql.Add('select * from persons where p_proxi like ''%' + code + '''');
            Open;
            first;
          end;
          if not adoQry.Eof then
            prsn := GetPerson(FixLeft(adoQry.fieldByName('P_Proxi').AsString , '0' , 8) , true)
          else
            prsn := GetPerson(FixLeft('' , '0' , 8) , false);

          Cells[4 , RowCount-1] := prsn.P_Family + ' - ' + prsn.P_Name;
          Cells[5 , RowCount-1] := prsn.P_Code;
          lblMsg.Caption :=  FloatToStrF((RowCount-1)/(calculFpCount(CodeList))*100 , ffGeneral , 3 , 3) + ' ���� ';
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
procedure TfrmFingerPrg.btnDeleteClick(Sender: TObject);
var
  code : string;
  Ack  : TFpAck;
  rdr : TReaders;
  i : integer;
begin
  If txtCode.Text = '' then
  begin
    InformationMessage('�� ���� ���� ��� .');
    exit;
  end;
  rdr := Readers[FindReaderCodeIdx(getCodeOfCombo(cmbRdrDelete))];
  i := 0;
  if DeleteFp(rdr , txtCode.text) then
    lblMsg.Caption := '��� �� ������ ����� �� .'
  else
    lblMsg.Caption := '��� ����  ��� ���� ��� ��� ��� ��ʐ�� ���� ��� .';
end;

//ok////////////////////////////////////////////////////////////////////////////
function TfrmFingerPrg.DeleteAllFps(rdr: TReaders): Boolean;
var
  ack : TFpAck;
  fpCnt : integer;
  i : integer;
begin
  Result := False;
  fpCnt := GetFpCount(rdr);
  if ConfirmMessage('��� ���� ��� ���� ��� ������ ������� ����Ͽ' + #13 + '����� ��� ������� ����� :' + IntToStr(fpCnt)) then
  begin
    i := 0;
    repeat
      ack := SendFPCommand(rdr , '0076000000000000000000');
      inc(i);
    until (ack.ErrorCode = 0) or (i>=5);
    If ack.ErrorCode = M2ERROR_NONE then
      Result := true;
  end;
end;
//ok////////////////////////////////////////////////////////////////////////////
Function TfrmFingerPrg.isFpEnrolled(rdr : TReaders ; Proxi : string) : Boolean;
var
  code : string;
  Ack  : TFpAck;
  i : integer;
begin
  Result := false;
  proxi := copy(proxi,3,2)+copy(proxi,1,2);
  i := 0;
  repeat
  Ack := SendFPCommand(rdr , '0060' + proxi  + '00000000000000');
    inc(i);
  until (ack.ErrorCode = M2ERROR_NONE) or (ack.ErrorCode = M2ERROR_USER_NOT_FOUND) or (i>=5);

  If (Ack.ErrorCode = M2ERROR_NONE) then
    result := true
  else if (Ack.ErrorCode = M2ERROR_USER_NOT_FOUND) then
    result := false;
end;

procedure TfrmFingerPrg.btnMoveClick(Sender: TObject);
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
    hhh : integer;
    i  , jj , cnt : integer;
    addList : TStringList;
    issent: Boolean;
    fgrtmpl :AnsiString;
  begin
    addList := TStringList.Create;
    addList.Clear;

    for i := 0 to (fpFromList.Count)-1 do
      if (chkUpdate.Checked and (fpToList.IndexOf(fpFromList[i]) = -1)) or chkFormatMoveAll.Checked then
        if addList.IndexOf(fpFromList[i]) = -1 then
          if (rdoMoveAll.Checked) or ((rdoMoveOne.Checked) and (fixleft(cmbProxiMoveOne.Text,'0',8) = fixleft(fpFromList[i],'0',8))) then
          addList.AddObject(fpFromList[i],fpFromList.Objects[i]);

    Cnt := addlist.Count;
    if cnt = 0 then
    begin
      InformationMessage('���� ����� ���� ����� ��� ��� .');
      exit;
    end;
    statusFrom.Panels[0].Text := '0 �� ' + inttostr(cnt);
    statusTo.Panels[0].Text := FloatToStrF((0/addList.Count)*100 , ffGeneral , 3 , 3) + '  ���� ';
    for i := 0 to cnt - 1 do
    {$region ' Copy ALL '}
    begin
      if Canceled then exit;
      if rdoFromTerminal.Checked then
        (addList.Objects[i] as TFingerTemplate).Template := GetFp(rdrFrom , addList[i]);
      Sleep(400);
      issent := false;
      if (rdoToTerminal.Checked) then
          issent := SendFp(rdrTo , addList.Objects[i] as TFingerTemplate)
      else
        with tblTo do
        begin
          append;
          fieldByName('Code').AsString := (addList.Objects[i] as TFingerTemplate).Id;
          fieldByName('AdminLevel').AsInteger := (addList.Objects[i] as TFingerTemplate).AdminLevel;
          fgrtmpl := (addList.Objects[i] as TFingerTemplate).Template;
          for jj := 0 to 20 do
            tblTo.FieldByName('fgr' + IntToStr(jj)).AsString := copy(fgrtmpl , (jj*200)+1 , 200);

          Post;
          issent := true;
        end;
      if isSent then
      begin
        statusFrom.Panels[0].Text := inttostr(i+1) + ' �� ' + inttostr(addList.Count);
        statusTo.Panels[0].Text :=  FloatToStrF((i+1)/addList.Count*100 , ffGeneral , 3 , 3) + ' ���� ';
      end;
      Sleep(400);
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
        InformationMessage('��ʐ�� ���� ����� ����� ���� ����� .');
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
        ErrorMessage('���� ���� ���� ����.');
        txtToFile.SetFocus;
        exit;
      end
      else
      if FileExists(txtToFile.Text) then
      begin
        if chkFormatMoveAll.Checked then
        begin
          if not ConfirmMessage('���� ������ ��� ���� ����. ��� �� ������ ��� �� �������� �����Ͽ') then
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
          ErrorMessage('��� �� ����� ����');
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
      ErrorMessage('���� ����� ���� ����.');
      txtFromFile.SetFocus;
      Exit;
    end
    else if not FileExists(txtFromFile.Text) then
    begin
      ErrorMessage('���� ����� ���� �����.');
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
    Panels[1].Text := '����� �� : ' + IntToStr(calculFpCount(fpFromList));
    Panels[2].Text := ' ���� : ' + rdrFrom.R_Name;
   end;
  with statusTo do
  begin
    Panels[1].Text := '����� �� : ' + IntToStr(calculFpCount(fpToList));
    Panels[2].Text := ' ���� : ' + rdrTo.R_Name;
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
//    InformationMessage('��ʐ�� ���� ����� ����� ���� ����� .')
//  else
//  begin
//    if cmbProxiMoveOne.Text = '' then
//      ErrorMessage('����� ���� ������ ���� ��� .')
//    else
//    begin
//      WaitFor('�� ��� ������ ...');
//      fp.Id := cmbProxiMoveOne.Text;
//      fp.Template := GetFp(rdrFrom , );
////      sleep(800);
//      if Length(fp) <> 0 then
//      begin
//
//        if SendFp(rdrTo , cmbProxiMoveOne.Text , fp) then
//        begin
//          InformationMessage('����� �� ������ ����� �� .');
//          if chkFormatOne.Checked then
//            DeleteFp(rdrFrom,cmbProxiMoveOne.Text)
//        end
//        else
//        begin
//          DontWait;
//          ErrorMessage('����� ����� ���.');
//          exit;
//        end;
//      end
//      else
//      begin
//        DontWait;
//        ErrorMessage('��� ���� ��� ���� ��� �� ��ʐ�� ���� ���� �����.');
//        exit;
//      end;
//      DontWait;
//    end;
//  end;
//end;



function TfrmFingerPrg.swap(str : string) : string;
begin
  result := copy(str,7,2)+ copy(str,5,2)+ copy(str,3,2)+copy(str,1,2);
end;
function TfrmFingerPrg.ChangeMode(rdr : treaders ; Mode: integer): boolean;
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
            Secugen_GetPocket(PK, 1, 2000, getVal)
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
procedure TfrmFingerPrg.SaveFinger(tbl : TTable ; fgr : AnsiString);
var
  i : integer;
begin
end;
function TfrmFingerPrg.LoadFinger(tbl : TTable) : AnsiString;
var
  i : integer;
begin
  result := '';
  for i := 0 to 15 do
    result := result + tbl.FieldByName('fgr' + IntToStr(i)).AsString;
end;


procedure TfrmFingerPrg.rdoMoveOneClick(Sender: TObject);
begin
  grpSelectOne.Enabled := true;
end;

procedure TfrmFingerPrg.rdoMoveAllClick(Sender: TObject);
begin
  grpSelectOne.Enabled := false;
end;

procedure TfrmFingerPrg.btnFromFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    txtFromFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TfrmFingerPrg.btnToFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    txtToFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TfrmFingerPrg.rdoToFileClick(Sender: TObject);
begin
  txtToFile.Enabled := not txtToFile.Enabled;
  btnToFile.Enabled := not btnToFile.Enabled;
  cmbToMoveAll.Enabled := not cmbToMoveAll.Enabled;
end;

end.


