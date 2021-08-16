unit DelRecit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, Grids, DBGrids, ADODB, DosMove;

type
  TfrmDelRecit = class(TForm)
    grpReceipt: TGroupBox;
    lbl2: TLabel;
    txtFishNo: TEdit;
    lbl3: TLabel;
    txtDate: TEdit;
    grd1: TDBGrid;
    grd2: TDBGrid;
    dta1: TDataSource;
    dta2: TDataSource;
    cmdCancel: TBitBtn;
    cmdHelp: TBitBtn;
    cmdDelAll: TBitBtn;
    cmdDel: TBitBtn;
    atbl1: TADOTable;
    atbl2: TADOTable;
    DosMove1: TDosMove;
    lbl1: TLabel;
    cmbCardCode: TComboBox;
    cmbCardName: TComboBox;
    atbl1Recit1_Date: TWideStringField;
    atbl1Recit1_No: TIntegerField;
    atbl1Recit1_EmplNo: TWideStringField;
    atbl1Recit1_Time: TWideStringField;
    atbl1Recit1_Rdr: TIntegerField;
    atbl1Recit1_TotalPrice: TBCDField;
    atbl1Recit1_Credit: TBCDField;
    atbl1Recit1_Cash: TBCDField;
    atbl1Recit1_PayType: TIntegerField;
    atbl1FamilyName: TStringField;
    atbl2Recit2_Date: TWideStringField;
    atbl2Recit2_No: TIntegerField;
    atbl2Recit2_EmplNo: TWideStringField;
    atbl2Recit2_Srvc: TIntegerField;
    atbl2Recit2_SrvcNo: TIntegerField;
    atbl2Recit2_Price: TBCDField;
    atbl2Recit2_PrcType: TIntegerField;
    atbl2Recit2_Time: TWideStringField;
    atbl2Service: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure atbl1CalcFields(DataSet: TDataSet);
    procedure atbl2CalcFields(DataSet: TDataSet);
    procedure cmbCardCodeClick(Sender: TObject);
    procedure cmbCardCodeExit(Sender: TObject);
    procedure cmbCardNameExit(Sender: TObject);
    procedure cmbCardNameClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtFishNoExit(Sender: TObject);
    procedure txtDateExit(Sender: TObject);
    procedure cmdDelClick(Sender: TObject);
    procedure cmbCardNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
    procedure FilterData;
  public
    { Public declarations }
  end;


var
  frmDelRecit : TfrmDelRecit;


implementation

uses
  DBS, Globals, Funcs, DateProc, MSGs, Keyboard, FntSel;

{$R *.dfm}

procedure TfrmDelRecit.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmDelRecit));
  
  Caption := (Caption);
  grpReceipt.Caption := (grpReceipt.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  for i := 0 to grd1.Columns.Count-1 do
    grd1.Columns[i].Title.Caption := (grd1.Columns[i].Title.Caption);
  for i := 0 to grd2.Columns.Count-1 do
    grd2.Columns[i].Title.Caption := (grd2.Columns[i].Title.Caption);

  cmdDel.Caption := (cmdDel.Caption);
  cmdDelAll.Caption := (cmdDelAll.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmDelRecit.FilterData;
var s : String;
begin
  if cmbCardCode.Text <> '' then
    s := 'Recit1_EmplNo = ''' + cmbCardCode.Text + '''';

  if txtDate.Text <> '' then
  begin
    if s <> '' then
      s := s + ' AND ';
    s := s + 'Recit1_Date = ''' + txtDate.Text + '''';
  end;

  if txtFishNo.Text <> '' then
  begin
    if s <> '' then
      s := s + ' AND ';
    s := s + 'Recit1_No = ''' + txtFishNo.Text + '''';
  end;
  atbl1.Filtered := False;
  atbl1.Filter := s;
  atbl1.Filtered := True;
end;

procedure TfrmDelRecit.FormCreate(Sender: TObject);
begin
  SetWinF;
  atbl1.Connection := frmDBS.adoConnect;
  atbl2.Connection := frmDBS.adoConnect;
  txtDate.Text := CurrentDate;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee');
    SQL.Add('WHERE Empl_Active <> 0');
    SQL.Add('ORDER BY Empl_Family, Empl_Name');
    Open;
    while not Eof do
    begin
      cmbCardCode.Items.Add(FieldByName('Empl_No').AsString);
      if FieldByName('Empl_Name').AsString <> '' then
        cmbCardName.Items.Add(FieldByName('Empl_Family').AsString + '-' +
                              FieldByName('Empl_Name').AsString)
      else
        cmbCardName.Items.Add(FieldByName('Empl_Family').AsString);
      Next;
    end;
    Close;
  end;

  atbl1.Open;
  atbl2.Open;
  FilterData;
end;

procedure TfrmDelRecit.atbl1CalcFields(DataSet: TDataSet);
begin
  atbl1.FieldByName('FamilyName').AsString := GetFamilyName(atbl1.FieldByName('Recit1_EmplNo').AsString);
end;

procedure TfrmDelRecit.atbl2CalcFields(DataSet: TDataSet);
begin
  atbl2.FieldByName('Service').AsString := GetServiceName(atbl2.FieldByName('Recit2_Srvc').AsInteger);
end;

procedure TfrmDelRecit.cmbCardCodeClick(Sender: TObject);
begin
  cmbCardName.ItemIndex := cmbCardCode.ItemIndex;
  FilterData;
end;

procedure TfrmDelRecit.cmbCardCodeExit(Sender: TObject);
begin
  if (cmbCardCode.Text <> '') and (cmbCardCode.ItemIndex = -1) then
    cmbCardCode.ItemIndex := cmbCardCode.Items.IndexOf(cmbCardCode.Text);

  if cmbCardName.ItemIndex <> cmbCardCode.ItemIndex then
  begin
    cmbCardName.ItemIndex := cmbCardCode.ItemIndex;
    FilterData;
  end;
end;

procedure TfrmDelRecit.cmbCardNameExit(Sender: TObject);
begin
  if (cmbCardName.Text <> '') and (cmbCardName.ItemIndex = -1) then
    cmbCardName.ItemIndex := cmbCardName.Items.IndexOf(cmbCardName.Text);

  if cmbCardCode.ItemIndex <> cmbCardName.ItemIndex then
  begin
    cmbCardCode.ItemIndex := cmbCardName.ItemIndex;
    FilterData;
  end;
end;

procedure TfrmDelRecit.cmbCardNameClick(Sender: TObject);
begin
  cmbCardCode.ItemIndex := cmbCardName.ItemIndex;
  FilterData;
end;


procedure TfrmDelRecit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  atbl1.Close;
  atbl2.Close;
end;

procedure TfrmDelRecit.txtFishNoExit(Sender: TObject);
begin
  FilterData;
end;

procedure TfrmDelRecit.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
  FilterData;
end;

procedure TfrmDelRecit.cmdDelClick(Sender: TObject);
begin
  if atbl1.RecordCount > 0 then
    if ConfirmMessage('¬Ì« »—«Ì Õ–› ›Ì‘ «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      while not atbl2.Eof do
        atbl2.Delete;

      atbl1.Delete;
    end;
end;

procedure TfrmDelRecit.cmbCardNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
