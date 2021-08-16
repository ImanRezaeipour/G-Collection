unit BarcodeRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBTables, ExtCtrls, db,RpBarcode, MPlayer, ADODB, DBCtrls;


type
  TfrmBarcodeRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdPrint: TBitBtn;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cmdSelect: TBitBtn;
    cmbName: TDBLookupComboBox;
    cmbFamily: TDBLookupComboBox;
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
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    cmbBarCode: TDBLookupComboBox;
    SpeedButton1: TSpeedButton;
    procedure cmbBarCodeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ADOTable1CalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure cmdSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmbBarCode1Exit(Sender: TObject);
    procedure cmbBarCode1KeyPress(Sender: TObject; var Key: Char);
    procedure cmbName1Exit(Sender: TObject);
    procedure cmbName1KeyPress(Sender: TObject; var Key: Char);
    procedure cmbFamily2Exit(Sender: TObject);
    procedure cmbFamily2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    procedure SendTab(var Key : Char);

  public
    { Public declarations }
    emplSelected : String;
  end;


implementation

uses
  Globals, DateProc, MSGs, Keyboard, Printers, DBS, Select, Funcs;


{$R *.DFM}


procedure CreateRepDBS(n:integer;fdate:string);
var
   adoTbl : TADOTable;
   i   : integer;

begin
  adoTbl := TADOTable.Create(Application);
  adoTbl.Connection := frmDBS.adoConnect;
  adoTbl.TableName := 'rep_num';
  if not tblExists('rep_num') then
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE rep_num(');
      SQL.Add('rep_date NVarChar(10))');
      ExecSQL;
    end
  else
    with frmDBS.adoQryG do
    begin
      Close;
      SQL.Clear;
      SQL.Add('delete from rep_num');
      ExecSQL;
    end;

  with adoTbl do
  begin
    open;
    for i:=1 to n do
    begin
       append;
       fieldbyname('rep_date').asstring:=fdate;
       post;
       fdate:=adddate(fdate,1);
    end;
    close;
    Free;
  end;
end;


procedure TfrmBarcodeRpt.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;


procedure TfrmBarcodeRpt.SpeedButton1Click(Sender: TObject);
begin
ADOTable1.Close;
ADOTable2.close;

end;

procedure TfrmBarcodeRpt.FormCreate(Sender: TObject);
var
   adoQry : TADOQuery;
begin
ADOTable1.Connection:=frmDBS.adoConnect;
ADOTable2.Connection:=frmDBS.adoConnect;
ADOTable1.Open;
ADOTable2.Open;
  Application.CreateForm(TfrmSelect, frmSelect);
  adoQry := TADOQuery.Create(Application);
  with adoQry do
  begin
    Connection := frmDBS.adoConnect;
    SQL.Clear;
    SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Empl_Department = ' + IntToStr(gOptions.UserDepart));
    SQL.Add('ORDER BY Empl_Family, Empl_Name, Empl_No');
    Open;
   { while not Eof do
    begin
      cmbBarCode.Items.Add(FieldByName('Empl_No').AsString);
      cmbName.Items.Add(FieldByName('Empl_Name').AsString);
      cmbFamily.Items.Add(FieldByName('Empl_Family').AsString);
      Next;
    end;
    Close;}
    Free;
  end;

end;

procedure TfrmBarcodeRpt.cmdPrintClick(Sender: TObject);
var
   qrptBarcode : TqrptBarcode;
   cardno : string;
   i:integer;
begin
  cardno:=cmbBarCode.text;
  Mouse_Wait;
  Application.CreateForm(TqrptBarcode, qrptBarcode);
  with qrptBarcode do
  begin
    RPTSetWinF;

    adoQryPersons.Connection := frmDBS.adoConnect;
    adoQryPersons.SQL.Clear;
    adoQryPersons.SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee');

    if cmbBarCode.Text <> '' then
      adoQryPersons.SQL.Add('where Empl_No = ''' + cmbBarCode.Text + '''')
    else if emplSelected <> '' then
      adoQryPersons.SQL.Add('where Empl_No IN (' + emplSelected + ')');

    adoQryPersons.SQL.Add('ORDER BY Empl_No');
    Mouse_NoWait;
    adoQryPersons.open;
    if adoQryPersons.RecordCount > 0 then
    begin
      if rdoScreen.Checked then
        Preview
      else
          Print
    end
    else
      InformationMessage('ê“«—‘  ÂÌ «”  .');
    adoQryPersons.Close;
  end;
  qrptBarcode.Free;

end;

procedure TfrmBarcodeRpt.ADOTable1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;

end;

procedure TfrmBarcodeRpt.cmbBarCode1Exit(Sender: TObject);
begin
  with cmbBarCode do
  begin
    if Text <> '' then
//      ItemIndex := Items.IndexOf(FixLeft(Text, '0', 8))
//    else
//      ItemIndex := -1;

//      cmbName.ItemIndex := ItemIndex;
//      cmbFamily.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmBarcodeRpt.cmbBarCode1KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmBarcodeRpt.cmbBarCodeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ADOTable1.open;
ADOTable2.open;
end;

procedure TfrmBarcodeRpt.cmbName1Exit(Sender: TObject);
begin
  with cmbName do
  begin
    if Text <> '' then
    begin
//      if ItemIndex = -1 then
//        ItemIndex := Items.IndexOf(Text);
    end
    else
//      ItemIndex := -1;
//
//      cmbBarCode.ItemIndex := ItemIndex;
//      cmbFamily.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmBarcodeRpt.cmbName1KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmBarcodeRpt.cmbFamily2Exit(Sender: TObject);
begin
  with cmbFamily do
  begin
    if Text <> '' then
    begin
//      if ItemIndex = -1 then
//        ItemIndex := Items.IndexOf(Text);
//    end
//    else
//      ItemIndex := -1;
//
//      cmbBarCode.ItemIndex := ItemIndex;
//      cmbName.ItemIndex := ItemIndex;
  end;
  end;
end;

procedure TfrmBarcodeRpt.cmbFamily2KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmBarcodeRpt.cmdSelectClick(Sender: TObject);
begin
//  if cmbBarCode.Items.Count > 0 then
//  begin
    frmSelect.selType := SEL_PRS;
    if frmSelect.ShowModal = mrOK then
      emplSelected := frmSelect.dataSelected
//    else
//      emplSelected := '';
//  end;
end;

procedure TfrmBarcodeRpt.FormDestroy(Sender: TObject);
begin
  frmSelect.Free;
end;

end.
