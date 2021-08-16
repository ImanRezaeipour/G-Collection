unit Relation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, DBTables, ExtCtrls, Mask, CPortCtl,
  RunCmnds, Menus, DosMove, ADODB, DBCtrls;

type
  TfrmRelations = class(TForm)
    tmrTime: TTimer;
    grdRdrs: TStringGrid;
    grpSendGetDT: TGroupBox;
    lblDate: TLabel;
    lblTime: TLabel;
    txtDate: TEdit;
    cmbDT: TComboBox;
    txtTime: TEdit;
    grpLimit: TGroupBox;
    lbl1: TLabel;
    txtFromT1: TEdit;
    txtToT1: TEdit;
    lbl2: TLabel;
    txtToT2: TEdit;
    lbl4: TLabel;
    txtFromT2: TEdit;
    lbl3: TLabel;
    txtToT3: TEdit;
    lbl6: TLabel;
    txtFromT3: TEdit;
    lbl5: TLabel;
    cmbLimit: TComboBox;
    grpBtns: TGroupBox;
    cmdTic: TBitBtn;
    cmdExit: TBitBtn;
    cmdRun: TBitBtn;
    cmdHelp: TBitBtn;
    cmdInvert: TBitBtn;
    DosMove1: TDosMove;
    grpChangeBaud: TGroupBox;
    lbl7: TLabel;
    cmbBaud: TComboBox;
    grpAuthority: TGroupBox;
    cmbOperate: TComboBox;
    adoQryPersons: TADOQuery;
    Label1: TLabel;
    grpRecovery: TGroupBox;
    lblRecovery: TLabel;
    Label2: TLabel;
    lbl8: TLabel;
    txtRecoveryFDate: TEdit;
    cmbRecovery: TComboBox;
    txtRecoveryTDate: TEdit;
    cmbParts: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    ADOTable1: TADOTable;
    ADOTable1te: TStringField;
    ADOTable1Empl_No: TWideStringField;
    ADOTable1Empl_ID: TWideStringField;
    ADOTable1Empl_Name: TWideStringField;
    ADOTable1Empl_Family: TWideStringField;
    ADOTable1Empl_Active: TBooleanField;
    ADOTable1Empl_Department: TIntegerField;
    ADOTable1Empl_CoPost: TIntegerField;
    ADOTable1Empl_Part: TIntegerField;
    ADOTable1Empl_Dscnt: TIntegerField;
    ADOTable1Empl_ExpDate: TWideStringField;
    ADOTable1Empl_Balance: TBCDField;
    DataSource1: TDataSource;
    ADOTable2: TADOTable;
    ADOTable2te: TStringField;
    ADOTable2Empl_No: TWideStringField;
    ADOTable2Empl_ID: TWideStringField;
    ADOTable2Empl_Name: TWideStringField;
    ADOTable2Empl_Family: TWideStringField;
    ADOTable2Empl_Active: TBooleanField;
    ADOTable2Empl_Department: TIntegerField;
    ADOTable2Empl_CoPost: TIntegerField;
    ADOTable2Empl_Part: TIntegerField;
    ADOTable2Empl_Dscnt: TIntegerField;
    ADOTable2Empl_ExpDate: TWideStringField;
    ADOTable2Empl_Balance: TBCDField;
    DataSource2: TDataSource;
    cmbEmplCode: TDBLookupComboBox;
    cmbEmplName: TDBLookupComboBox;
    grpLostCard: TGroupBox;
    Label5: TLabel;
    cmbLostOperate: TComboBox;
    btn_select: TBitBtn;
    chkMoRange: TCheckBox;
    procedure btn_selectClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbEmplNameClick(Sender: TObject);
    procedure cmbEmplNameExit(Sender: TObject);
    procedure cmbEmplCodeClick(Sender: TObject);
    procedure cmbEmplCodeExit(Sender: TObject);
    procedure ADOTable2CalcFields(DataSet: TDataSet);
    procedure ADOTable1CalcFields(DataSet: TDataSet);
    procedure cmbOperateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdRunClick(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure tmrTimeTimer(Sender: TObject);
    procedure cmdInvertClick(Sender: TObject);
    procedure cmdTicClick(Sender: TObject);
    procedure grdRdrsDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtFromT1Exit(Sender: TObject);
    procedure txtFromT1KeyPress(Sender: TObject; var Key: Char);
    procedure txtToT1Exit(Sender: TObject);
    procedure txtToT1KeyPress(Sender: TObject; var Key: Char);
    procedure txtFromT2Exit(Sender: TObject);
    procedure txtFromT2KeyPress(Sender: TObject; var Key: Char);
    procedure txtToT2Exit(Sender: TObject);
    procedure txtToT2KeyPress(Sender: TObject; var Key: Char);
    procedure txtFromT3Exit(Sender: TObject);
    procedure txtFromT3KeyPress(Sender: TObject; var Key: Char);
    procedure txtToT3Exit(Sender: TObject);
    procedure txtToT3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
    procedure InitialGridCels;
    procedure FillGrid;
    procedure ClearGridMessage;
    function  IsReaderSelected : Boolean;
    function  Z84AllCollect(rdrInf : TReaders; aDate : String; rType, i : Byte; var RecNo, ErrRecNo : Integer) : Boolean;
    function  Z84GetAllRecord(rdrInf : TReaders; FDate, TDate : String; rType, i : Byte) : Boolean;
    function  Z84_AnalizeData(Data : String; var ErrData : Boolean) : TTerminalRec;
    function SetCharge(rdrInfo : TReaders; lst : Tdataset ; idx : integer;var SendCount : integer ; flag : char) : Boolean;
    function  GetChargeCount(rdrInfo : TReaders) : integer;
    function SetLostCard(rdrInfo : TReaders; lst : Tdataset ; idx : integer;var SendCount : integer ; flag : char) : Boolean;
    function  GetLostCardCount(rdrInfo : TReaders) : integer;
  public
    departSelected :string; { Public declarations }
    ActionType : Byte;
  end;


var
  frmRelations : TfrmRelations;

const
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
  RDR_CHNGBAUD  = 13;
  RDR_CHARGE    = 14;
  RDR_DIAL      = 15;
  RDR_LOSTCARD  = 16;
implementation

uses
  Funcs, Globals, MSGs, ComTools, DateProc, FarsiApi, Keyboard, DBS,
  Z80_CMD, Z84_CMD, Code_Sys, TimeTool, FntSel,TCP_UDP,modem, Select;

{$R *.DFM}

const
  MB_SEND_DT    = 0;
  MB_GET_DT     = 1;
  MB_SEND_LIMIT = 0;
  MB_GET_LIMIT  = 1;



procedure TfrmRelations.SetWinF;
begin
  SetFontColor(TForm(frmRelations));

  Caption := (Caption);

  grpSendGetDT.Caption := (grpSendGetDT.Caption);
  lblDate.Caption := (lblDate.Caption);
  lblTime.Caption := (lblTime.Caption);

  grpLimit.Caption := (grpLimit.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);

  grpChangeBaud.Caption := (grpChangeBaud.Caption);
  lbl7.Caption := (lbl7.Caption);

  cmdTic.Caption := (cmdTic.Caption);
  cmdInvert.Caption := (cmdInvert.Caption);
  cmdRun.Caption := (cmdRun.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmRelations.InitialGridCels;
begin
  if rdrCount = 0 then
  begin
    grdRdrs.FixedRows := 0;
    grdRdrs.RowCount := 1;
  end
  else
  begin
    grdRdrs.FixedRows := 1;
    grdRdrs.RowCount := rdrCount + 1;
  end;
  grdRdrs.FixedCols := 0;
  grdRdrs.ColCount := 4;

  grdRdrs.Cols[0].Add(' ');
  grdRdrs.ColWidths[0] := 30;

  grdRdrs.Cols[1].Add(('كد دستگاه'));
  grdRdrs.ColWidths[1] := 55;

  grdRdrs.Cols[2].Add(('نام دستگاه'));
  grdRdrs.ColWidths[2] := 155;

  grdRdrs.Cols[3].Add(('نتيجه'));
  grdRdrs.ColWidths[3] := grdRdrs.Width -
                          grdRdrs.ColWidths[2] -
                          grdRdrs.ColWidths[1] -
                          grdRdrs.ColWidths[0] - 10;
end;

procedure TfrmRelations.FillGrid;
var i : Byte;
begin
  if rdrCount > 0 then
    for i := 0 to rdrCount-1 do
    begin
      grdRdrs.Cells[0, i+1] := '';
      grdRdrs.Cells[1, i+1] := IntToStr(Readers[i].R_Code);
      grdRdrs.Cells[2, i+1] := Readers[i].R_Name;
      grdRdrs.Cells[3, i+1] := '';
    end;
end;

procedure TfrmRelations.ADOTable1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmRelations.ADOTable2CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmRelations.btn_selectClick(Sender: TObject);
begin
  cmbParts.ItemIndex := -1;
  frmSelect.selType := SEL_khed;
  if frmSelect.ShowModal = mrOK then
    departSelected := frmSelect.dataSelected
  else
    departSelected := '';
end;

procedure TfrmRelations.ClearGridMessage;
var i : Byte;
begin
  for i := 1 to grdRdrs.RowCount do grdRdrs.Cells[3, i] := '';
  grdRdrs.Refresh;
end;

function TfrmRelations.IsReaderSelected : Boolean;
var i : Byte;
begin
  Result := False;
  for i := 1 to grdRdrs.RowCount do
    if grdRdrs.Cells[0, i] = 'X' then
    begin
      Result := True;
      Break;
    end;
end;


procedure TfrmRelations.FormActivate(Sender: TObject);
begin
  if ActionType = RDR_CHARGE then
  begin
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM Parts');
      SQL.Add('ORDER BY Part_Name');
      Open;
      while not Eof do
      begin
        cmbParts.Items.Add(FieldByName('Part_Code').AsString + '-' +
                           FieldByName('Part_Name').AsString);
        Next;
      end;
      Close;

      SQL.Clear;
      SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee');
      if gOptions.UserDepart <> 0 then
        SQL.Add('WHERE Empl_Department = ' + IntToStr(gOptions.UserDepart));
      SQL.Add('ORDER BY Empl_Family, Empl_Name, Empl_No');
      Open;
    { while not Eof do
      begin
        cmbEmplCode.Items.Add(FieldByName('Empl_No').AsString);
        cmbEmplName.Items.Add(FieldByName('Empl_Family').AsString + '-' +
                              FieldByName('Empl_Name').AsString);
        Next;
      end;
      Close;}
    end;
  end;
end;

procedure TfrmRelations.FormCreate(Sender: TObject);
begin
  InitialGridCels;
  FillGrid;
   Application.CreateForm(TfrmSelect, frmSelect);
end;

procedure TfrmRelations.FormShow(Sender: TObject);
var i : Byte;
begin
ADOTable1.Connection:=frmDBS.adoConnect ;
ADOTable2.Connection:=frmDBS.adoConnect ;
ADOTable1.Open;
ADOTable2.Open ;

  case ActionType of
    RDR_TEST:
    begin
      cmdRun.Caption := 'ت&ست ارتباط';
      Caption := 'تست ارتباط با دستگاهها';
      HelpContext := 61;
      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_RESTART:
    begin
      cmdRun.Caption := 'راه اندازي &مجدد';
      Caption := 'راه اندازي مجدد دستگاهها';
      HelpContext := 62;
      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_VER:
    begin
      cmdRun.Caption := 'خواندن ن&سخه';
      Caption := 'خواندن نسخه دستگاهها';
      HelpContext := 63;
      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_DATETIME:
    begin
      txtDate.Text := CurrentDate;
      txtTime.Text := CurrentTime;
      cmbDT.Clear;
      cmbDT.Items.Add(('ارسال تاريخ و زمان'));
      cmbDT.Items.Add(('خواندن تاريخ و زمان'));
      cmbDT.ItemIndex := 1;
      cmdRun.Caption := 'ا&جرا';
      Caption := 'ارسال و دريافت تاريخ و زمان دستگاهها';
      tmrTime.Enabled := True;
      HelpContext := 64;

      grpSendGetDT.Visible := True;
      grdRdrs.Align := alTop;
      grpSendGetDT.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_LIMITTIME:
    begin
      cmbLimit.Clear;
      cmbLimit.Items.Add(('ارسال محدوده'));
      cmbLimit.Items.Add(('خواندن محدوده'));
      cmbLimit.ItemIndex := 0;
      cmdRun.Caption := 'ا&جرا';
      Caption := 'ارسال و دريافت محدوده زماني فعاليت كارتخوان';
      HelpContext := 68;

      grpLimit.Visible := True;
      grdRdrs.Align := alTop;
      grpLimit.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;


    RDR_INITIAL:
    begin
      cmdRun.Caption := '&پيكربندي';
      Caption := 'پيكربندي مجدد كارتخوان';
      HelpContext := 67;

      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;

    RDR_CHNGBAUD:
    begin
      for i := 0 to MaxBaudIndex do
        cmbBaud.Items.Add(IntToStr(BAUDRATES[i]));
      cmbBaud.ItemIndex := 2;
      cmdRun.Caption := '&تغيير سرعت';
      Caption := 'تغيير سرعت ارتباط';
      HelpContext := 67;

      grpChangeBaud.Visible := True;
      grdRdrs.Align := alTop;
      grpChangeBaud.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;
    RDR_COLLECT:
    begin
      cmdRun.Caption := '&جمع آوري';
      Caption := 'جمع آوري جديد اطلاعات از دستگاهها';
      HelpContext := 77;

      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;
    RDR_RECOVERY:
    begin
      txtRecoveryFDate.Text := CurrentDate;
      txtRecoveryTDate.Text := CurrentDate;
      cmdRun.Caption := '&بازيابي';
      Caption := 'بازيابي اطلاعات از دستگاهها';
      HelpContext := 78;

      grpRecovery.Visible := True;
      grdRdrs.Align := alTop;
      grpRecovery.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;
    RDR_CHARGE:
    begin
      cmdRun.Caption := 'اجرا';
      Caption := 'جدول شارژ';
      cmbOperate.ItemIndex := 0;
//      HelpContext := 67;

      grpAuthority.Visible := True;
      grdRdrs.Align := alTop;
      grpAuthority.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;
    RDR_DIAL:
    begin
      cmdRun.Caption := 'شماره گیری';
      Caption := ' برقراری ارتباط مودمی';
      cmbOperate.ItemIndex := 0;
//      HelpContext := 67;

      grdRdrs.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;
    RDR_LOSTCARD:
    begin
      cmdRun.Caption := 'اجرا';
      Caption := 'کارتهاي مفقودي و افراد غير مجاز';
      cmbOperate.ItemIndex := 0;
//      HelpContext := 67;
      grpLostCard.Visible := True;
      grdRdrs.Align := alTop;
      grpLostCard.Align := alTop;
      grpBtns.Align := alTop;
      AutoSize := True;
    end;
  end;
  SetWinF;
end;

procedure TfrmRelations.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmRelations.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
   if Key in ['0'..'9', #8] then
     tmrTime.Enabled := False
   else
   begin
     Keyboard_Time(Key);
   end;
end;

procedure TfrmRelations.tmrTimeTimer(Sender: TObject);
begin
  txtTime.Text := CurrentTimes;
end;


procedure TfrmRelations.grdRdrsDblClick(Sender: TObject);
begin
  cmdTicClick(Sender);
end;

procedure TfrmRelations.txtFromT1Exit(Sender: TObject);
begin
  if txtFromT1.Text <> '' then txtFromT1.Text := BeautifulTime(txtFromT1.Text);
end;

procedure TfrmRelations.txtFromT1KeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtToT1Exit(Sender: TObject);
begin
  if txtToT1.Text <> '' then txtToT1.Text := BeautifulTime(txtToT1.Text);
end;

procedure TfrmRelations.txtToT1KeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtFromT2Exit(Sender: TObject);
begin
  if txtFromT2.Text <> '' then txtFromT2.Text := BeautifulTime(txtFromT2.Text);
end;

procedure TfrmRelations.txtFromT2KeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtToT2Exit(Sender: TObject);
begin
  if txtToT2.Text <> '' then txtToT2.Text := BeautifulTime(txtToT2.Text);
end;

procedure TfrmRelations.txtToT2KeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtFromT3Exit(Sender: TObject);
begin
  if txtFromT3.Text <> '' then txtFromT3.Text := BeautifulTime(txtFromT3.Text);
end;

procedure TfrmRelations.txtFromT3KeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmRelations.txtToT3Exit(Sender: TObject);
begin
  if txtToT3.Text <> '' then txtToT3.Text := BeautifulTime(txtToT3.Text);
end;

procedure TfrmRelations.txtToT3KeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmRelations.cmdTicClick(Sender: TObject);
begin
  if grdRdrs.Row > 0 then
  begin
    if grdRdrs.Cells[0, grdRdrs.Row] = 'X' then
      grdRdrs.Cells[0, grdRdrs.Row] := ''
    else
      grdRdrs.Cells[0, grdRdrs.Row] := 'X';
  end;
end;

procedure TfrmRelations.cmbEmplCodeClick(Sender: TObject);
begin
 // cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure TfrmRelations.cmbEmplCodeExit(Sender: TObject);
begin
 {if (cmbEmplCode.Text <> '') and (cmbEmplCode.ItemIndex = -1) then
    cmbEmplCode.ItemIndex := cmbEmplCode.Items.IndexOf(cmbEmplCode.Text);
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;}
end;

procedure TfrmRelations.cmbOperateChange(Sender: TObject);
begin
  Label3.Visible :=    (cmbOperate.ItemIndex = 1);
  cmbParts.Visible :=  (cmbOperate.ItemIndex = 1);
  btn_select.Visible:= (cmbOperate.ItemIndex = 1);
  Label4.Visible := ((cmbOperate.ItemIndex = 2) or (cmbOperate.ItemIndex = 3));
  cmbEmplCode.Visible := ((cmbOperate.ItemIndex = 2) or (cmbOperate.ItemIndex = 3));
  cmbEmplName.Visible := ((cmbOperate.ItemIndex = 2) or (cmbOperate.ItemIndex = 3));
end;

procedure TfrmRelations.cmdInvertClick(Sender: TObject);
var
  i : Byte;
begin
  for i := 1 to grdRdrs.RowCount do
    if grdRdrs.Cells[0, i] = 'X' then
      grdRdrs.Cells[0, i] := ''
    else
      grdRdrs.Cells[0, i] := 'X';
end;

procedure TfrmRelations.cmdRunClick(Sender: TObject);
var
  Good : Boolean;
  i, j : Byte;
  ST1, ST2, ST3 : String;
  grec, brec : Integer;
  lst : TStringList;
  k : integer;
  frmModem : TfrmModem;
  charged : integer;
  cnt: Integer;
  flag: char;
  DayOfChangeType : Smallint; //kaveh
begin
  if not IsReaderSelected then
    ErrorMessage('دستگاهي انتخاب نشده است')
  else
  begin
    ClearGridMessage;
    for i := 1 to grdRdrs.RowCount-1 do
      if grdRdrs.Cells[0, i] = 'X' then
      begin
        Application.ProcessMessages;
        Mouse_Wait;
        CurrRdr := Readers[i-1];
        case ActionType of
          RDR_TEST:
          begin
            grdRdrs.Cells[3, i] := ('در حال تست ارتباط...');
            grdRdrs.Refresh;
            if LinkTest(Readers[i-1]) then
              grdRdrs.Cells[3, i] := 'ارتباط برقرار است'
            else
              grdRdrs.Cells[3, i] := 'ارتباط قطع مي باشد';
          end;//END OF RDR_TEST:

          RDR_VER:
          begin
            grdRdrs.Cells[3, i] := ('در حال خواندن نسخه دستگاه...');
            grdRdrs.Refresh;
            if ReadVersion(Readers[i-1], ST1) then
            begin
              Sleep(500);
              if ReadReaderErrors(Readers[i-1], ST2) then
                ST1 := ST1 + ST2;
              grdRdrs.Cells[3, i] := ST1;
            end
            else
              grdRdrs.Cells[3, i] := 'خواندن نسخه دستگاه ناموفق بود';
          end;//END OF RDR_VER:

          RDR_RESTART:
          begin
            grdRdrs.Cells[3, i] := ('در حال راه اندازي مجدد...');
            grdRdrs.Refresh;
            if ReStart(Readers[i-1]) then
              grdRdrs.Cells[3, i] := 'دستگاه راه اندازي شد.'
            else
              grdRdrs.Cells[3, i] := 'راه اندازي دستگاه ناموفق بود';
          end;//END OF RDR_RESTART:

          RDR_INITIAL:
          begin
            if ConfirmMessage('با پيكربندي مجدد، كليه اطلاعات ترمينال از بين خواهد رفت. ادامه ميدهيد؟') then
            begin
              grdRdrs.Cells[3, i] := ('در حال پيكربندي كارتخوان...');
              grdRdrs.Refresh;
              if ReaderInitial(Readers[i-1]) then
                grdRdrs.Cells[3, i] := 'پيكربندي مجدد ترمينال انجام شد.'
              else
                grdRdrs.Cells[3, i] := 'پيكربندي مجدد ترمينال ناموفق بود';
            end;
          end;//END OF RDR_INITIAL:

          RDR_DATETIME:
          begin
            if cmbDT.ItemIndex = MB_SEND_DT then
            begin
              ST1 := txtDate.Text;
              ST2 := txtTime.Text;
              good := True;
              j := StrToInt(Copy(ST2, 1, 2));
              if not (j in [0..23]) then good := False;
              j := StrToInt(Copy(ST2, 4, 2));
              if not (j in [0..59]) then good := False;
              j := StrToInt(Copy(ST2, 7, 2));
              if not (j in [0..59]) then good := False;

              if not good then
              begin
                ErrorMessage('زمان اشتباه است');
                Exit;
              end;
              if IsTrueDate(ST1) then
              begin
                ST1 := BeautifulDate(ST1);
                txtDate.Text := ST1;
              end
              else
              begin
                ErrorMessage('تاريخ اشتباه است');
                Exit;
              end;
              grdRdrs.Cells[3, i] := ('در حال ارسال تاريخ و زمان...');
              grdRdrs.Refresh;
              if SendDateTime(Readers[i-1], ST1, ST2) then
                grdRdrs.Cells[3, i] := 'تاريخ و زمان ارسال شد'
              else
                grdRdrs.Cells[3, i] := 'ارسال تاريخ و زمان ناموفق بود';
            end
            else if cmbDT.ItemIndex = MB_GET_DT then                               
            begin
              grdRdrs.Cells[3, i] := ('در حال خواندن تاريخ و زمان...');
              grdRdrs.Refresh;
              if GetDateTime(Readers[i-1], ST1, ST2) then
                grdRdrs.Cells[3, i] := 'تاريخ = ' + ST1 + '      زمان = ' + ST2
              else
                grdRdrs.Cells[3, i] := 'خواندن تاريخ و زمان ناموفق بود';
            end;
          end;//END OF RDR_DATETIME:

          RDR_LIMITTIME:
          begin
            if cmbLimit.ItemIndex = MB_SEND_LIMIT then
            begin
              grdRdrs.Cells[3, i] := ('در حال ارسال محدوده...');
              grdRdrs.Refresh;
              if txtFromT1.Text <> '' then ST1 := txtFromT1.Text
              else                         ST1 := '00:00';
              if txtToT1.Text <> '' then ST1 := ST1 + txtToT1.Text
              else                       ST1 := ST1 + '00:00';

              if txtFromT2.Text <> '' then ST2 := txtFromT2.Text
              else                         ST2 := '00:00';
              if txtToT2.Text <> '' then ST2 := ST2 + txtToT2.Text
              else                       ST2 := ST2 + '00:00';

              if txtFromT3.Text <> '' then ST3 := txtFromT3.Text
              else                         ST3 := '00:00';
              if txtToT3.Text <> '' then ST3 := ST3 + txtToT3.Text
              else                       ST3 := ST3 + '00:00';
              if SendLimitTime(Readers[i-1], ST1, ST2, ST3) then
                grdRdrs.Cells[3, i] := 'محدوده زماني ارسال شد'
              else
                grdRdrs.Cells[3, i] := 'ارسال محدوده زماني ناموفق بود';
            end
            else if cmbLimit.ItemIndex = MB_GET_LIMIT then
            begin
              grdRdrs.Cells[3, i] := ('در حال خواندن محدوده...');
              grdRdrs.Refresh;
              if GetLimitTime(Readers[i-1], ST1, ST2, ST3) then
                grdRdrs.Cells[3, i] := ST1 + ' و ' + ST2 + ' و ' + ST3
              else
                grdRdrs.Cells[3, i] := 'خواندن محدوده زماني ناموفق بود';
            end;
          end;

          RDR_CHNGBAUD:
          begin
            grdRdrs.Cells[3, i] := ('در حال تغيير سرعت ارتباط...');
            grdRdrs.Refresh;
            if ChangeBaudRate(Readers[i-1], cmbBaud.ItemIndex+7) then
            begin
              with frmDBS.adoQryG do
              begin
                SQL.Clear;
                SQL.Add('UPDATE Readers SET Rdr_BaudRate = ' + IntToStr(cmbBaud.ItemIndex));
                SQL.Add('WHERE Rdr_Code = ' + IntToStr(Readers[i-1].R_Code));
                ExecSQL;
                Readers[i-1].R_BaudNo := cmbBaud.ItemIndex;
              end;
              grdRdrs.Cells[3, i] := 'تغيير سرعت ارتباط انجام شد.';
            end
            else
              grdRdrs.Cells[3, i] := 'تغيير سرعت امكان پذير نيست.';
          end;//END OF RDR_RESTART:

          RDR_COLLECT:
          begin
            Mouse_Wait;
            Application.ProcessMessages;
            MSG_Wait('درحال جمع آوري ركوردهاي جديد...');
            ClearGridMessage;
            with Readers[i-1] do
            begin
               grec := 0;
               brec := 0;
               Z84AllCollect(Readers[i-1], '', ALL_COLLECTION, i , grec, brec);
            end;
            Mouse_NoWait;
            MSG_NoWait;
          end;
          RDR_RECOVERY:
          begin
            if cmbRecovery.Text = '' then
            begin
              ErrorMessage('نوع بازيابي مشخص نشده است.');
              cmbRecovery.SetFocus;
            end
            else if txtRecoveryFDate.Text = '' then
            begin
              ErrorMessage('تاريخ شروع بازيابي وارد نشده است.');
              txtRecoveryFDate.SetFocus;
            end
            else if txtRecoveryTDate.Text = '' then
            begin
              ErrorMessage('تاريخ پايان بازيابي وارد نشده است.');
              txtRecoveryTDate.SetFocus;
            end
            else if not IsTrueDate(txtRecoveryFDate.Text) then
            begin
              ErrorMessage('تاريخ شروع بازيابي نادرست است.');
              txtRecoveryFDate.SetFocus;
            end
            else if not IsTrueDate(txtRecoveryTDate.Text) then
            begin
              ErrorMessage('تاريخ پايان بازيابي نادرست است.');
              txtRecoveryTDate.SetFocus;
            end
            else if txtRecoveryTDate.Text < txtRecoveryFDate.Text then
            begin
              ErrorMessage('تاريخ پايان از تاريخ ابتدا كوچكتر است.');
              txtRecoveryTDate.SetFocus;
            end
            else
            begin
             Application.ProcessMessages;  
              Mouse_Wait;
              ClearGridMessage;
              if cmbRecovery.ItemIndex = 0 then
                j := ALL_RECOVERY
              else
                j := NEW_RECOVERY;
              with Readers[i-1] do
                Z84GetAllRecord(Readers[i-1], txtRecoveryFDate.Text, txtRecoveryTDate.Text, j, i);
              Mouse_NoWait;
            end;
          end;
          RDR_Charge:
          begin
            if (cmbOperate.ItemIndex = 0) or (cmbOperate.ItemIndex = 1) or (cmbOperate.ItemIndex = 2) or (cmbOperate.ItemIndex = 3) then
            {$REGION 'Send All or Some Parts'}
            begin
              ClearGridMessage;
              with adoQryPersons do
              begin
                close;
                Connection := frmDBS.adoConnect;
                SQL.Clear;
{kaveh
                sql.add('SELECT Employee.Empl_ID AS empl_id, Min(CHARGEGRP./Grp DATE) AS firstChargeDate, Max(CHARGEGRP./Grp DATE) AS lastChargeDate, Sum(CHARGEGRP.GRPPRICE) AS Credit '+
                      'FROM CHARGEGRP INNER JOIN (Employee INNER JOIN CHARGEDTL ON Employee.Empl_No = CHARGEDTL.DTLEMPLNO) ON CHARGEGRP.GRPCODE = CHARGEDTL.DTLCODE '+
                      'GROUP BY Employee.Empl_ID, Employee.Empl_Active, Employee.Empl_No, CHARGEDTL.DTLMOVED ,Employee.Empl_part '+
                      'HAVING (((Employee.Empl_Active)<>' + IntToSTr(MB_false) +  ') ' +
                       'AND ((CHARGEDTL.DTLMOVED)<>' + IntToSTr(MB_true) +  ')) ');
kaveh}

                //kaveh is

                SQL.Clear;
                SQL.Add('SELECT * FROM Params');
                SQL.Add('Where Params_Code = 1');
                Open;

                if FieldByName('Params_Code').AsString = '1' then
                  if (FieldByName('Params_DayOfChangeType').AsString = '0') or (FieldByName('Params_DayOfChangeType').AsString = '1') then
                    DayOfChangeType := FieldByName('Params_DayOfChangeType').AsInteger
                  else
                    DayOfChangeType := 0
                else
                  DayOfChangeType := 0;

                SQL.Clear;
                sql.add('SELECT ' +
                        'case when Empl_ID is null then Empl_ID2 else Empl_ID end Empl_ID, ' +
                        'case when firstChargeDate is null then ''1111/11/11'' else firstChargeDate end firstChargeDate, ' +
                        'case when firstChargeCode is null then 0 else firstChargeCode end firstChargeCode, ' +
                        'case when lastChargeDate is null then ''1111/11/11'' else lastChargeDate end lastChargeDate, ' +
                        'case when lastChargeCode is null then 0 else lastChargeCode end lastChargeCode, ' +
                        'case when Credit is null then 2147483647 else Credit end Credit, ' +
                        'case when morange_price is null then 2147483647 else morange_price end morange_price, ' +
                        'CASE WHEN MoRange_Day IS NULL THEN 1 ELSE MoRange_Day END morange_day, ' +
                        'CASE WHEN MoRange_DelRemain IS NULL THEN 0 ELSE MoRange_DelRemain END morange_delremain ' +

                        'FROM ( ' +
                        'SELECT l1.empl_id, l1.firstChargeDate, l1.firstChargeCode, l1.lastChargeDate, l1.lastChargeCode, l1.Credit, l4.Empl_ID AS Empl_ID2, l4.MoRange_Price, l4.MoRange_Day, l4.MoRange_DelRemain ' +
                        'FROM (SELECT Employee.Empl_ID AS empl_id, MIN(CHARGEGRP.GrpDATE) AS firstChargeDate, MIN(CHARGEGRP.GrpCode) AS firstChargeCode, MAX(CHARGEGRP.GrpDATE) AS lastChargeDate, MAX(CHARGEGRP.GrpCode) AS lastChargeCode, SUM(CHARGEGRP.GRPPRICE) AS Credit ' +
                        'FROM CHARGEGRP INNER JOIN (Employee INNER JOIN CHARGEDTL ON Employee.Empl_No = CHARGEDTL.DTLEMPLNO) ON CHARGEGRP.GRPCODE = CHARGEDTL.DTLCODE ' +
                        'GROUP BY Employee.Empl_ID, Employee.Empl_Active, Employee.Empl_No, CHARGEDTL.DTLMOVED, Employee.Empl_part ' +
                        'HAVING (((Employee.Empl_Active) <> ' + IntToSTr(MB_false) +  ') AND ((CHARGEDTL.DTLMOVED) <> ' + IntToSTr(MB_true) +  ')) ');
                //kaveh ie

                if cmbOperate.ItemIndex = 1 then
                begin
                  if cmbParts.Text <> ''  then
                  begin
                    sql.add('AND (Employee.Empl_part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1) + ') ')
                  end
                  else
                  begin
                    sql.add('AND (Employee.Empl_part = ' + departSelected + ') ')
                  end;
                end
                else
                  if (cmbOperate.ItemIndex = 2) or (cmbOperate.ItemIndex = 3) then
                    sql.add('AND (Employee.Empl_No = ''' + fixleft(cmbEmplCode.Text,'0',8) + ''') ');

                //kaveh is
                if chkMoRange.Checked then
                  sql.add(') l1 FULL OUTER JOIN ')
                else
                  sql.add(') l1 LEFT OUTER JOIN ');
                sql.add('(SELECT * FROM ');

                case DayOfChangeType of
                  0:
                  begin
                    sql.add('(SELECT Employee.Empl_ID, MoRanges.MoRange_Price, MoRanges.MoRange_Day, MoRanges.MoRange_DelRemain ' +
                            'FROM Employee LEFT OUTER JOIN ' +
                            'MoRanges ON Employee.Empl_MoRange = MoRanges.MoRange_Code) l2) ');
                  end;
                  1:
                  begin
                    sql.add('(SELECT Employee.Empl_ID, MoRanges.MoRange_Price, Parts.Part_Day as MoRange_Day, Parts.Part_DelRemain as MoRange_DelRemain ' +
                            'FROM Employee LEFT OUTER JOIN Parts ON Employee.Empl_Part = Parts.Part_Code LEFT OUTER JOIN ' +
                            'MoRanges ON Employee.Empl_MoRange = MoRanges.MoRange_Code) l2) ');
                  end;
                end;

                sql.add('l4 ON ' +
                        'l1.empl_id = l4.Empl_ID ' +
                        ') l3 ' +
                        'order by l3.Empl_ID ');



{
SELECT case when Empl_ID is null then Empl_ID2 else Empl_ID end Empl_ID, case when firstChargeDate is null then '1111/11/11' else firstChargeDate end firstChargeDate, case when lastChargeDate is null then '1111/11/11' else lastChargeDate end lastChargeDate, case when Credit is null then 2147483647 else Credit end Credit, case when morange_price is null then
2147483647 else morange_price end morange_price, CASE WHEN MoRange_Day IS NULL THEN 1 ELSE MoRange_Day END morange_day, CASE WHEN MoRange_DelRemain IS NULL THEN 0 ELSE MoRange_DelRemain END morange_delremain FROM ( SELECT l1.empl_id, l1.firstChargeDate, l1.lastChargeDate, l1.Credit, l4.Empl_ID AS Empl_ID2, l4.MoRange_Price, l4.MoRange_Day, l4.MoRange_DelRemain
FROM (SELECT Employee.Empl_ID AS empl_id, MIN(CHARGEGRP./Grp DATE) AS firstChargeDate, MAX(CHARGEGRP./Grp DATE) AS lastChargeDate, SUM(CHARGEGRP.GRPPRICE) AS Credit FROM CHARGEGRP INNER JOIN (Employee INNER JOIN CHARGEDTL ON Employee.Empl_No = CHARGEDTL.DTLEMPLNO) ON CHARGEGRP.GRPCODE = CHARGEDTL.DTLCODE GROUP BY Employee.Empl_ID, Employee.Empl_Active, Employee.Empl_No,
CHARGEDTL.DTLMOVED, Employee.Empl_part HAVING (((Employee.Empl_Active) <> 0) AND ((CHARGEDTL.DTLMOVED) <> 1))

) l1 FULL OUTER JOIN
(SELECT * FROM (SELECT Employee.Empl_ID, MoRanges.MoRange_Price, Parts.Part_Day as MoRange_Day, Parts.Part_DelRemain as MoRange_DelRemain FROM Employee LEFT OUTER JOIN Parts ON Employee.Empl_Part = Parts.Part_Code LEFT OUTER JOIN MoRanges ON Employee.Empl_MoRange = MoRanges.MoRange_Code) l2) l4 ON l1.empl_id = l4.Empl_ID ) l3 order by l3.Empl_ID 

}
                        
                      {  '(SELECT dbo.Employee.Empl_ID, dbo.MoRanges.MoRange_Price, dbo.MoRanges.MoRange_Day, dbo.MoRanges.MoRange_DelRemain ' +
                        'FROM dbo.Employee LEFT OUTER JOIN ' +
                        'dbo.MoRanges ON dbo.Employee.Empl_MoRange = dbo.MoRanges.MoRange_Code) l2) l4 ON ' +
                        'l1.empl_id = l4.Empl_ID ' +
                        ') l3 ' +
                        'order by l3.Empl_ID '); }

                //kaveh ie

//kaveh                sql.add('order by Employee.Empl_ID');


/////////////
//                //kaveh is
//                SQL.Clear;
//                sql.add('SELECT ' +
//                        'case when Empl_ID is null then Empl_ID2 else Empl_ID end Empl_ID, ' +
//                        'case when firstChargeDate is null then ''1111/11/11'' else firstChargeDate end firstChargeDate, ' +
//                        'case when lastChargeDate is null then ''1111/11/11'' else lastChargeDate end lastChargeDate, ' +
//                        'case when Credit is null then 2147483647 else Credit end Credit, ' +
//                        'case when morange_price is null then 2147483647 else morange_price end morange_price ' +
//
//
//
//                        'FROM ( ' +
//                        'SELECT l1.empl_id, l1.firstChargeDate, l1.lastChargeDate, l1.Credit, l4.Empl_ID AS Empl_ID2, l4.MoRange_Price ' +
//                        'FROM (SELECT Employee.Empl_ID AS empl_id, MIN(CHARGEGRP./Grp DATE) AS firstChargeDate, MAX(CHARGEGRP./Grp DATE) AS lastChargeDate, SUM(CHARGEGRP.GRPPRICE) AS Credit ' +
//                        'FROM CHARGEGRP INNER JOIN (Employee INNER JOIN CHARGEDTL ON Employee.Empl_No = CHARGEDTL.DTLEMPLNO) ON CHARGEGRP.GRPCODE = CHARGEDTL.DTLCODE ' +
//                        'GROUP BY Employee.Empl_ID, Employee.Empl_Active, Employee.Empl_No, CHARGEDTL.DTLMOVED, Employee.Empl_part ' +
//                        'HAVING (((Employee.Empl_Active) <> ' + IntToSTr(MB_false) +  ') AND ((CHARGEDTL.DTLMOVED) <> ' + IntToSTr(MB_true) +  ')) ');
//                //kaveh ie
//
//                if cmbOperate.ItemIndex = 1 then
//                begin
//                  if cmbParts.Text <> ''  then
//                  begin
//                    sql.add('AND (Employee.Empl_part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1) + ') ')
//                  end
//                  else
//                  begin
//                    sql.add('AND (Employee.Empl_part = ' + departSelected + ') ')
//                  end;
//                end
//                else
//                  if (cmbOperate.ItemIndex = 2) or (cmbOperate.ItemIndex = 3) then
//                    sql.add('AND (Employee.Empl_No = ''' + fixleft(cmbEmplCode.Text,'0',8) + ''') ');
//
//                //kaveh is
//                if chkMoRange.Checked then
//                  sql.add(') l1 FULL OUTER JOIN ')
//                else
//                  sql.add(') l1 LEFT OUTER JOIN ');
//                sql.add('(SELECT * FROM ' +
//                        '(SELECT dbo.Employee.Empl_ID, dbo.MoRanges.MoRange_Price ' +
//                        'FROM dbo.Employee LEFT OUTER JOIN ' +
//                        'dbo.MoRanges ON dbo.Employee.Empl_MoRange = dbo.MoRanges.MoRange_Code) l2) l4 ON ' +
//                        'l1.empl_id = l4.Empl_ID ' +
//                        ') l3 ' +
//                        'order by l3.Empl_ID ');
//                //kaveh ie

/////////////
/////////////
/////////////


/////////////////////////
/////////////////////////

//                SQL.Clear;
//                sql.add('SELECT Employee.Empl_ID AS empl_id, Min(CHARGEGRP./Grp DATE) AS firstChargeDate, Max(CHARGEGRP./Grp DATE) AS lastChargeDate, Sum(CHARGEGRP.GRPPRICE) AS Credit '+
//                      'FROM CHARGEGRP INNER JOIN (Employee INNER JOIN CHARGEDTL ON Employee.Empl_No = CHARGEDTL.DTLEMPLNO) ON CHARGEGRP.GRPCODE = CHARGEDTL.DTLCODE '+
//                      'GROUP BY Employee.Empl_ID, Employee.Empl_Active, Employee.Empl_No, CHARGEDTL.DTLMOVED ,Employee.Empl_part '+
//                      'HAVING (((Employee.Empl_Active)<>' + IntToSTr(MB_false) +  ') ' +
//                       'AND ((CHARGEDTL.DTLMOVED)<>' + IntToSTr(MB_true) +  ')) ');
//              if cmbOperate.ItemIndex = 1 then
//               begin
//                  if cmbParts.Text <> ''  then
//                  begin
//                  sql.add('AND (Employee.Empl_part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1) + ')')
//                  end
//                  else
//                  begin
//                  sql.add('AND (Employee.Empl_part = ' + departSelected + ')')
//                  end;
//                end else
//                if (cmbOperate.ItemIndex = 2) or (cmbOperate.ItemIndex = 3) then
//                  sql.add('AND (Employee.Empl_No = ''' + fixleft(cmbEmplCode.Text,'0',8) + ''')');
//                sql.add('order by Employee.Empl_ID');


/////////////////////////
/////////////////////////






//                ST3 := SQL.Text;

                Open;
                SaveToFile('ab.xml' , pfXML);
              end;
              Application.ProcessMessages;
              Mouse_Wait;
              MSG_Wait('در حال ارسال جدول شارژ ...' + '  تعداد : ' + IntToStr(adoQryPersons.RecordCount));

              if (cmbOperate.ItemIndex = 0) or (cmbOperate.ItemIndex = 1) then
                flag := 'A' // A for Append
              else
              if (cmbOperate.ItemIndex = 2) then
                flag := 'I' // I for Insert One Redord
              else
              if (cmbOperate.ItemIndex = 3) then
                flag := 'd'; // d for DELETE one record


              if SetCharge(Readers[i-1], adoqryPersons,i,charged,flag) then
                grdRdrs.Cells[3, i] := 'ارسال لیست با موفقیت انجام شد . تعداد = ' + IntToStr(adoQryPersons.RecordCount)
              else
                grdRdrs.Cells[3, i] := 'ارسال لیست ناموفق بود . تعداد = '  + IntToStr(charged) + ' از ' + IntToStr(adoQryPersons.RecordCount);
              grdRdrs.Refresh;
              Mouse_NoWait;
              MSG_NoWait;
            end
            {$ENDREGION}
            else
            if cmbOperate.ItemIndex = 4 then
            {$REGION 'Delete All'}
            begin
              Application.ProcessMessages;
              Mouse_Wait;
              MSG_Wait('در حال غیر فعال کردن لیست افراد مجاز به تردد ... ');
              ClearGridMessage;
              if SetCharge(Readers[i-1], nil,i,charged , 'D' ) then   //D fro Delete All Records
                grdRdrs.Cells[3, i] := 'لیست افراد مجاز به تردد غیر فعال شد.'
              else
                grdRdrs.Cells[3, i] := 'ناموفق';
              grdRdrs.Refresh;
              Mouse_NoWait;
              MSG_NoWait;
            end
            {$ENDREGION}
            else
            if cmbOperate.ItemIndex = 5 then
            {$REGION 'Get Count'}
            begin
                Application.ProcessMessages;  
                Mouse_Wait;
                MSG_Wait('در حال خواندن لیست افراد مجاز به تردد...');
                ClearGridMessage;
                cnt := GetChargeCount(Readers[i-1]);
                if cnt <> -1 then
                  grdRdrs.Cells[3, i] := 'تعداد = ' + inttostr(cnt) //(lst.Count)
                else
                  grdRdrs.Cells[3, i] := 'خواندن لیست افراد مجاز به تردد ناموفق بود .';
                grdRdrs.Refresh;
                Mouse_NoWait;
                MSG_NoWait;

            end;
            {$ENDREGION}
          end;
          RDR_DIAL :
          begin
            Application.CreateForm(TfrmModem, frmModem);
            frmModem.txtTel.Text :=  Readers[i-1].R_Tel;
            frmModem.cmbPort.Text := 'com' + inttostr(Readers[i-1].R_Port);
            frmModem.cmbBaud.ItemIndex := Readers[i-1].R_BaudNo;
            frmModem.ShowModal;
//            grdRdrs.Cells[3, i] := frmModem.lblTest.Caption;
            frmModem.Free;
          end;
          RDR_LostCard:
          begin
            case cmbLostOperate.ItemIndex of
              0 :
                {$REGION 'Send All'}
                begin
                  ClearGridMessage;
                  with adoQryPersons do
                  begin
                    close;
                    Connection := frmDBS.adoConnect;
                    SQL.Clear;
                    sql.add(' select * from' +
                            ' (    SELECT lost_EmplId AS Empl_ID ,1 AS EMPL_STATUS ' +
                            '      FROM LostCard WHERE (lost_RemoveDate Is Null or lost_RemoveDate='''') ' +
                            '   union ' +
                            '      SELECT empl_Id ,0 AS EMPL_STATUS ' +
                            '      FROM Employee WHERE empl_Active = 0' +
                            ' ) a' +
                            ' order by empl_Id');
                    Open;
                    SaveToFile('LostCard.xml' , pfXML);
                  end;
                  Mouse_Wait;
                  Application.ProcessMessages;
                  MSG_Wait('در حال ارسال جدول کارتهاي مفقودي و افراد غيرمجاز ...' + '  تعداد : ' + IntToStr(adoQryPersons.RecordCount));

                  if SetLostCard(Readers[i-1], adoqryPersons,i,charged,'A') then
                    grdRdrs.Cells[3, i] := 'ارسال لیست با موفقیت انجام شد . تعداد = ' + IntToStr(adoQryPersons.RecordCount)
                  else
                    grdRdrs.Cells[3, i] := 'ارسال لیست ناموفق بود . تعداد = '  + IntToStr(charged) + ' از ' + IntToStr(adoQryPersons.RecordCount);
                  grdRdrs.Refresh;
                  Mouse_NoWait;
                  MSG_NoWait;
                end;
                {$ENDREGION}
              1 :
                {$REGION 'Delete All'}
                begin
                 Application.ProcessMessages;
                  Mouse_Wait;
                  MSG_Wait('در حال غیر فعال کردن لیست افراد مجاز به تردد ... ');
                  ClearGridMessage;
                  if SetLostCard(Readers[i-1], nil,i,charged , 'D' ) then   //D fro Delete All Records
                    grdRdrs.Cells[3, i] := 'لیست افراد مجاز به تردد غیر فعال شد.'
                  else
                    grdRdrs.Cells[3, i] := 'ناموفق';
                  grdRdrs.Refresh;
                  Mouse_NoWait;
                  MSG_NoWait;
                end;
                {$ENDREGION}
              2 :
                {$REGION 'Get Count'}
                begin
                    Application.ProcessMessages;  
                    Mouse_Wait;
                    MSG_Wait('در حال خواندن لیست افراد مجاز به تردد...');
                    ClearGridMessage;
                    cnt := GetLostCardCount(Readers[i-1]);
                    if cnt <> -1 then
                      grdRdrs.Cells[3, i] := 'تعداد = ' + inttostr(cnt) //(lst.Count)
                    else
                      grdRdrs.Cells[3, i] := 'خواندن لیست افراد مجاز به تردد ناموفق بود .';
                    grdRdrs.Refresh;
                    Mouse_NoWait;
                    MSG_NoWait;

                end;
                {$ENDREGION}
            end;
          end;
        end;//END OF case ActionType of

        Mouse_NoWait;
        grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
        grdRdrs.Refresh;

      end;//END OF if grdRdrs.Cells[0, i] = 'X' then
  end;
end;

function TfrmRelations.Z84GetAllRecord(rdrInf : TReaders; FDate, TDate : String; rType, i : Byte) : Boolean;
var
  GoodRec, BadRec : Integer;
begin
  Z84GetAllRecord := True;
  GoodRec := 0;
  BadRec := 0;
  if FDate = '' then FDate := CurrentDate;
  if TDate = '' then TDate := FDate;

  while FDate <= TDate do
  begin
    Msg_Wait('بازيابي ركوردهاي تاريخ : ' + FDate);
    if not Z84AllCollect(rdrInf, FDate, rType, i, GoodRec, BadRec) then
    begin
      Z84GetAllRecord := False;
      MSG_NoWait;
      Break;
    end;
    FDate := AddDate(FDate, 1);
    MSG_NoWait;
  end;
end;

function TfrmRelations.Z84AllCollect(rdrInf : TReaders; aDate : String; rType, i : Byte; var RecNo, ErrRecNo : Integer) : Boolean;
var
  n, retVal, getVal : Byte;
  S_PK, G_PK : String;
  {ClkRec,} befRec : TTerminalRec;
  ClkRecs : array of TTerminalRec;
  j, PacketRecCount : integer;
  ErrRec : Boolean;
  empl : TEmployee;
  mustsave : boolean;
begin
  Z84AllCollect := False;
  befRec.rdrCode := 0;
  mustsave:=false;
  if rdrInf.R_IsCom and not ComPortInitial(rdrInf) then
    Exit;

  {$region 'get first Record'}
  case rType of
    ALL_COLLECTION: Z84_MakePOcket(S_PK, rdrInf.r_Code, $02, $55 , '');
    ALL_RECOVERY  : Z84_MakePOcket(S_PK, rdrInf.R_Code, $2E, $55, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
    NEW_RECOVERY  : Z84_MakePOcket(S_PK, rdrInf.R_Code, $30, $55, Copy(aDate, 3, 2)+Copy(aDate, 6, 2)+Copy(aDate, 9, 2));
  end;

  if rdrInf.r_IsCom and not SendPocket(S_PK) then
    retVal := ERR_OFF
  else if not rdrInf.r_IsCom and rdrInf.r_TCP and not TCPSendData(S_PK, rdrInf.r_IP) then
    retVal := ERR_OFF
  else if not rdrInf.r_IsCom and not rdrInf.r_TCP and not UDPSendData(S_PK, rdrInf.r_IP) then
    retVal := ERR_OFF
  else
  begin
    if rdrInf.r_IsCom then
      Z84_GetPocket(G_PK, 0 , 500, getVal)
    else if rdrInf.r_TCP then
      TCPReadData(G_PK, getVal)
    else
      UDPReadData(G_PK, getVal);

    if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.R_Code) then
    begin
      case Ord(G_PK[4]) of
        $03: //Buffer Empty
          retVal := MB_BUFFEMPTY;

        $5A: //Record Exists
        begin
          {$region 'multiple Record in One Packet'}
          retVal := MB_TRUEREC;
          SetLength(ClkRecs,20);
          PacketRecCount := (Ord(G_PK[2])-4) div 14;
          for j :=0 to PacketRecCount-1 do
          begin
            ClkRecs[j] := Z84_AnalizeData(copy(G_PK,6+(j*14),14), ErrRec);
            empl := GetEmployee(ClkRecs[j].rdrCardCode, True);
            if ClkRecs[j].rdrStatus <>8 then //lost Cards must identify by cardNo
              if empl.EmplCode <> '' then
                ClkRecs[j].rdrCardCode := empl.EmplCode;

            mustsave:=true;

            if (befRec.rdrCode <> ClkRecs[j].rdrCode) or
               (befRec.rdrCardCode <> ClkRecs[j].rdrCardCode) or
               (befRec.rdrDate <> ClkRecs[j].rdrDate) or
               (befRec.rdrTime <> ClkRecs[j].rdrTime) or
               (befRec.rdrPayment <> ClkRecs[j].rdrPayment) then //or
//               (befRec.rdrStatus <> ClkRecs[j].rdrStatus) then //kaveh
            begin
              befRec := ClkRecs[i];
              if not ErrRec then
                Inc(RecNo)
              else
                Inc(ErrRecNo);
            end;
            grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
            grdRdrs.Refresh;
          end;
          {$endregion 'multiple Record in One Packet'}
        end;
        {$region 'other'}
        $15:
          retVal := MB_TRUEREC;
        else //Error in read data
          retVal := MB_BADREC;
        {$endregion 'other'}
      end;
    end
    else if getVal = ERR_OFF then
      retVal := ERR_OFF
    else
      retVal := MB_BADREC;
  end;
  {$endregion 'get first Record'}
  n := 0;
  while (retVal <> MB_BUFFEMPTY) and (n <= 3) do
  begin
    {$region 'get other Record'}
    if retVal = MB_TRUEREC then
    begin
      Z84_MakePocket(S_PK, rdrInf.r_Code, $06, 0, '');
      n := 0;
    end
    else if retVal = MB_BADREC then
      Z84_MakePocket(S_PK, rdrInf.r_Code, $15,0{ $55}, '')
    else if retVal = ERR_OFF then
    begin
      if (n > 1) and (rType = ALL_COLLECTION) then
        //Z84AllCollect(rdrInf, aDate, rType, i, RecNo, ErrRecNo)
        Z84_Makepocket(S_PK, rdrInf.r_Code, $02,0{ $55}, '')
      else
        S_PK := '';
    end;


    if rdrInf.r_IsCom and not SendPocket(S_PK) then
      retVal := ERR_OFF
    else if (S_PK <> '') and not rdrInf.r_IsCom and rdrInf.r_TCP and not TCPSendData(S_PK, rdrInf.r_IP) then
      retVal := ERR_OFF
    else if (S_PK <> '') and not rdrInf.r_IsCom and not rdrInf.r_TCP and not UDPSendData(S_PK, rdrInf.r_IP) then
      retVal := ERR_OFF
    else
    begin

      if mustsave then
      for j := 0 to PacketRecCount-1 do
      begin
        case ClkRecs[j].rdrStatus of
          8 : SaveLostCardRecord(ClkRecs[j]);
          5,10 : SaveChargeRecord(ClkRecs[j]);
        else
          SaveRecord(ClkRecs[j]);
        end;
      end;
//      TSaveRecordThread.Create(false,ClkRecs);
      mustsave:=false;
      if rdrInf.r_IsCom then
        Z84_Getpocket(G_PK, 0, 500, getVal)
      else if rdrInf.r_TCP then
        TCPReadData(G_PK, getVal)
      else
        UDPReadData(G_PK, getVal);

      if (getVal = ERR_NONE) and (Ord(G_PK[3]) = rdrInf.r_Code) then
      begin
        case Ord(G_PK[4]) of
          $03: //Buffer Empty
            retVal := MB_BUFFEMPTY;

          $5A: //Record Exists
          begin
            {$region 'multiple Record in One Packet'}
            retVal := MB_TRUEREC;
            PacketRecCount := (Ord(G_PK[2])-4) div 14;
            for j := 0 to PacketRecCount-1 do
            begin
              ClkRecs[j] := Z84_AnalizeData(copy(G_PK,6+(j*14),14), ErrRec);
              empl := GetEmployee(ClkRecs[j].rdrCardCode, True);
              if empl.EmplCode <> '' then
                ClkRecs[j].rdrCardCode := empl.EmplCode;
              mustsave:=true;

              if (befRec.rdrCode <> ClkRecs[j].rdrCode) or
                 (befRec.rdrCardCode <> ClkRecs[j].rdrCardCode) or
                 (befRec.rdrDate <> ClkRecs[j].rdrDate) or
                 (befRec.rdrTime <> ClkRecs[j].rdrTime) then
              begin
                befRec := ClkRecs[i];
                if not ErrRec then
                  Inc(RecNo)
                else
                  Inc(ErrRecNo);
              end;
              grdRdrs.Cells[3, i] := IntToStr(RecNo) + '   ' + IntToStr(ErrRecNo);
              grdRdrs.Refresh;
            end;
            {$endregion 'multiple Record in One Packet'}
          end;
          $15:
            retVal := MB_TRUEREC;


          else //Error in read data
            retVal := MB_BADREC;
        end;
      end
      else if getVal = ERR_OFF then
        retVal := ERR_OFF
      else
        retVal := MB_BADREC;
    end;
    if retVal in [ERR_OFF, MB_BADREC] then
    begin
      Inc(n);
//      if rType = ALL_RECOVERY then
        Sleep(300);
    end;
    {$endregion 'get other Record'}
    Application.ProcessMessages;
  end;
  {$region 'view Opreration'}
  if RecNo > 0 then
  begin
    if retVal = MB_BUFFEMPTY then
    begin
      if ErrRecNo > 0 then
      begin
        Z84AllCollect := True;
        if rType = ALL_COLLECTION then
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور كامل جمع آوري شد'
        else
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور كامل بازيابي شد';
      end
      else
      begin
        Z84AllCollect := True;
        if rType = ALL_COLLECTION then
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد بطور كامل جمع آوري شد'
        else
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد بطور كامل بازيابي شد';
      end;
    end
    else
    begin
      if ErrRecNo > 0 then
      begin
        if rType = ALL_COLLECTION then
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور ناقص جمع آوري شد'
        else
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح و ' +
                                 IntToStr(ErrRecNo) + ' ركورد خطا بطور ناقص بازيابي شد';
      end
      else
        if rType = ALL_COLLECTION then
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح بطور ناقص جمع آوري شد'
        else
        begin
          //Z84AllCollect := True;
          grdRdrs.Cells[3, i] := IntToStr(RecNo) + ' ركورد صحيح بطور ناقص بازيابي شد';
        end;
    end;
  end
  else if retVal = MB_BUFFEMPTY then
  begin
    Z84AllCollect := True;
    if rType <> ALL_RECOVERY then
      grdRdrs.Cells[3, i] := 'هيچ ركورد جديدي وجود ندارد'
    else
      grdRdrs.Cells[3, i] := 'ركوردي براي بازيابي وجود ندارد';
  end
  else
    grdRdrs.Cells[3, i] := 'ارتباط قطع مي باشد';

  grdRdrs.Cells[3, i] := (grdRdrs.Cells[3, i]);
  grdRdrs.Refresh;
  {$endregion 'view Opreration'}
end;

function TfrmRelations.Z84_AnalizeData(Data : String; var ErrData : Boolean) : TTerminalRec;
var
  rdrRecord : TTerminalRec;
  s : String;
begin
  ErrData := False;
  with rdrRecord do
  begin
    rdrCode := curRdrCode; //Reader Code

//    s := Data[1]; //record status
//    if IsNumeric(s) then
//      rdrStatus := StrToInt(s)
//    else if s[1] <> #0 then
//      ErrData := True;
    rdrStatus := ord(Data[1]);

    s := inttostr(ord(Data[2])) + '/' + inttostr(ord(Data[3])) + '/' + inttostr(ord(Data[4]));
    rdrDate := BeautifulDate(s);
    if not IsTrueDate(rdrDate) then
      ErrData := True;

    s := inttostr(ord(Data[5])) + ':' + inttostr(ord(Data[6]));
    s := BeautifulTime(s);
    if IsTrueTime(s) then
      rdrTime := TimeToInt(s)
    else
      ErrData := True;

    rdrCardCode := PBCD_Str(Copy(Data, 7, 4),8); //card number
    if rdrStatus in [5,10] then
    begin
{//kaveh
      s := inttostr(ord(Data[11])) + '/' + inttostr(ord(Data[12])) + '/' + inttostr(ord(Data[13]));
      rdrBDate := BeautifulDate(s); //LastChargeDate
      if not IsTrueDate(rdrBDate) then
        ErrData := True;
//kaveh}
      rdrPayment := ord(Data[12])* 100 + ord(Data[13]);//LastChargeCode //kaveh
    end
    else
      rdrPayment := StrToInt64('$' + PBCD2Str(StrRev(Copy(Data, 11, 4))));//Payment
  end;

  Z84_AnalizeData := rdrRecord;


end;


function TfrmRelations.SetCharge(rdrInfo : TReaders; lst : Tdataset ; idx : integer;var SendCount : integer ; flag : char) : Boolean;
var
  i,j,k : integer;
  dta : string;
  Ok: Boolean;

  function send(ST : string;status :char) : boolean;
  begin
    case rdrInfo.R_Type of
      RDR_VEGA9300:
      begin
        if rdrInfo.r_IsCom then
        begin
          if not ComPortInitial(rdrInfo) then
            Result := False
          else
            Result := Z84_SetChargeList(ST,ord(Status));
        end
        else
          Result := TCP_UDP_SetChargeList(rdrInfo, ST,ord(Status));
      end;
    else
      Result := False;
    end;
  end;

begin
  with lst do
  begin
    result := True;
    if (flag = 'A') then
    begin
      dta := IntToHex(7,2) + IntToHex(strtoint(copy(CurrentDate,3,2)),2) + IntToHex(strtoint(copy(CurrentDate,6,2)),2)+IntToHex(strtoint(copy(CurrentDate,9,2)),2);
      dta := dta + IntToHex(strtoint(copy(CurrentTime,1,2)),2) + IntToHex(strtoint(copy(CurrentTime,4,2)),2);
      dta := dta + IntToHex(20,2);//kaveh (14,2);
    end;
    j := 0;
    k := 0;
    if (flag = 'd') or (flag = 'I') then
      Ok := true
    else
      Ok := send('FFFFFFFF','D');
    if Ok then
    begin
      if (lst = nil) then
      begin
        result := True;
        SendCount := k;
        exit;
      end;
      First;
      while not lst.Eof do
      begin
        dta := dta + fixleft(lst.FieldByName('empl_id').AsString,'0',8);
//        dta := dta + IntToHex(strtoint(copy(lst.FieldByName('firstChargeDate').AsString,3,2)),2)+IntToHex(strtoint(copy(lst.FieldByName('firstChargeDate').AsString,6,2)),2)+IntToHex(strtoint(copy(lst.FieldByName('firstChargeDate').AsString,9,2)),2);
//        dta := dta + IntToHex(strtoint(copy(lst.FieldByName('lastChargeDate' ).AsString,3,2)),2)+IntToHex(strtoint(copy(lst.FieldByName('lastChargeDate' ).AsString,6,2)),2) +IntToHex(strtoint(copy(lst.FieldByName('lastChargeDate' ).AsString,9,2)),2);
        dta := dta + IntToHex(0, 2) + IntToHex(lst.FieldByName('firstChargeCode').AsInteger div 100, 2) + IntToHex(lst.FieldByName('firstChargeCode').AsInteger mod 100, 2); //kaveh
        dta := dta + IntToHex(0, 2) + IntToHex(lst.FieldByName('lastChargeCode').AsInteger div 100, 2) + IntToHex(lst.FieldByName('lastChargeCode').AsInteger mod 100, 2); //kaveh

//        test := IntToHex(0, 2) + IntToHex(1053 div 100, 2) + IntToHex(1053 mod 100, 2); //kaveh
//        test := IntToHex(0, 2) + IntToHex(5432 div 100, 2) + IntToHex(5432 mod 100, 2); //kaveh


        dta := dta + IntToHex(strtoint(CurrToStr(lst.FieldByName('credit' ).AsCurrency)),8);
        dta := dta + IntToHex(strtoint(CurrToStr(lst.FieldByName('morange_price' ).AsCurrency)),8); //kaveh
        dta := dta + IntToHex(lst.FieldByName('MoRange_Day').AsInteger,2); //kaveh
        dta := dta + fixleft(lst.FieldByName('MoRange_DelRemain').AsString,'0',2); //kaveh
//        dta := dta + IntToHex(strtoint('1000000'),8); //kaveh
        inc(j);
        inc(k);
        if (j = 12) then
        begin
          j := 0;
          if not send(dta,flag) then
          begin
            Result := False;
            SendCount := k;
            Exit;
          end;
          dta := '';
        end
        else
        if (lst.RecNo = lst.RecordCount) then
        begin
        if not send(dta,flag) then
        begin
          Result := False;
          SendCount := k;
          Exit;
        end;
        end;
        grdRdrs.Cells[3, idx] := IntToStr(lst.RecNo) + ' از ' + IntToStr(lst.RecordCount);
        Next;
        Application.ProcessMessages;
      end;
    end
    else
      Result := False;
  end;
  grdRdrs.Cells[3, idx] := IntToStr(lst.RecNo) + ' از ' + IntToStr(lst.RecordCount);
  SendCount := k;
end;
function  TfrmRelations.GetChargeCount(rdrInfo : TReaders) : integer;
var
  i,j : integer;
  _cnt : integer;

  function Get(var cnt : integer) : boolean;
  begin
    case rdrInfo.R_Type of
      RDR_VEGA9300 :
      begin
        if rdrInfo.r_IsCom then
        begin
          if not ComPortInitial(rdrInfo) then
            Result := false
          else
          begin
            Result := true;
            cnt := Z84_GetChargeCount;
          end;
        end
        else
        begin
          Result := true;
          cnt := TCP_UDP_GetChargeCount(rdrInfo);
        end;
      end;
    else
      Result := False;
    end;
  end;

begin
  if get(_cnt) then
    result := _cnt
  else
    result := -1;
end;
function TfrmRelations.SetLostCard(rdrInfo : TReaders; lst : Tdataset ; idx : integer;var SendCount : integer ; flag : char) : Boolean;
var
  i,j,k : integer;
  dta : string;
  function send(ST : string;status :char) : boolean;
  begin
    case rdrInfo.R_Type of
      RDR_VEGA9300:
      begin
        if rdrInfo.r_IsCom then
        begin
          if not ComPortInitial(rdrInfo) then
            Result := False
          else
            Result := Z84_SetLostCardList(ST,ord(Status));
        end
        else
          Result := TCP_UDP_SetLostCardList(rdrInfo, ST,ord(Status));
      end;
    else
      Result := False;
    end;
  end;
begin
  with lst do
  begin
    result := True;
    dta := IntToHex(7,2) + IntToHex(strtoint(copy(CurrentDate,3,2)),2) + IntToHex(strtoint(copy(CurrentDate,6,2)),2)+IntToHex(strtoint(copy(CurrentDate,9,2)),2);
    dta := dta + IntToHex(strtoint(copy(CurrentTime,1,2)),2) + IntToHex(strtoint(copy(CurrentTime,4,2)),2);
    dta := dta + IntToHex(5,2);
    j := 0;
    k := 0;
    if send('','D') then
    begin
      if (lst = nil) then
      begin
        result := True;
        SendCount := k;
        exit;
      end;
      First;
      while not lst.Eof do
      begin
        dta := dta + fixleft(lst.FieldByName('empl_id').AsString,'0',8);
        dta := dta + IntToHex(lst.FieldByName('empl_Status').AsInteger,2);
        inc(j);
        inc(k);
        if (j = 45) then
        begin
          j := 0;
          if not send(dta,flag) then
          begin
            Result := False;
            SendCount := k;
            Exit;
          end;
          dta := '';
        end
        else
        if (lst.RecNo = lst.RecordCount) then
        begin
        if not send(dta,flag) then
        begin
          Result := False;
          SendCount := k;
          Exit;
        end;
        end;
        grdRdrs.Cells[3, idx] := IntToStr(lst.RecNo) + ' از ' + IntToStr(lst.RecordCount);
        Next;
        Application.ProcessMessages;
      end;
    end
    else
      Result := False;
  end;
  grdRdrs.Cells[3, idx] := IntToStr(lst.RecNo) + ' از ' + IntToStr(lst.RecordCount);
  SendCount := k;
end;
function  TfrmRelations.GetLostCardCount(rdrInfo : TReaders) : integer;
var
  i,j : integer;
  _cnt : integer;

  function Get(var cnt : integer) : boolean;
  begin
    case rdrInfo.R_Type of
      RDR_VEGA9300 :
      begin
        if rdrInfo.r_IsCom then
        begin
          if not ComPortInitial(rdrInfo) then
            Result := false
          else
          begin
            Result := true;
            cnt := Z84_GetLostCardCount;
          end;
        end
        else
        begin
          Result := true;
          cnt := TCP_UDP_GetLostCardCount(rdrInfo);
        end;
      end;
    else
      Result := False;
    end;
  end;

begin
  if get(_cnt) then
    result := _cnt
  else
    result := -1;
end;
procedure TfrmRelations.cmbEmplNameClick(Sender: TObject);
begin
  //cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;
procedure TfrmRelations.cmbEmplNameExit(Sender: TObject);
begin
{  if (cmbEmplName.Text <> '') and (cmbEmplName.ItemIndex = -1) then
    cmbEmplName.ItemIndex := cmbEmplName.Items.IndexOf(cmbEmplName.Text);
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;}
end;

end.
{
SELECT Employee.Empl_ID AS empl_id, Min(CHARGEGRP./Grp DATE) AS firstChargeDate, Max(CHARGEGRP./Grp DATE) AS lastChargeDate, Sum(CHARGEGRP.GRPPRICE) AS Credit
FROM CHARGEGRP INNER JOIN (Employee INNER JOIN CHARGEDTL
ON Employee.Empl_No = CHARGEDTL.DTLEMPLNO)
ON CHARGEGRP.GRPCODE = CHARGEDTL.DTLCODE
GROUP BY Employee.Empl_ID, Employee.Empl_Active, Employee.Empl_No, CHARGEDTL.DTLMOVED ,Employee.Empl_part
order by Employee.Empl_ID
HAVING (((Employee.Empl_Active)<>0) AND ((CHARGEDTL.DTLMOVED)<>-1))
}
