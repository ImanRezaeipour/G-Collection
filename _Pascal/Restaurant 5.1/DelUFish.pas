unit DelUFish;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, Grids, DBGrids;

type
  TfrmDelUnitFish = class(TForm)
    Label1: TLabel;
    cmbType: TComboBox;
    Label2: TLabel;
    txtDate: TEdit;
    Label3: TLabel;
    txtFishNo: TEdit;
    dbgFish: TDBGrid;
    cmdDel: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    dtaFish: TDataSource;
    tblFish: TAdoTable;
    tblFishFish_Date: TStringField;
    tblFishFish_Type: TSmallintField;
    tblFishFish_No: TSmallintField;
    Label4: TLabel;
    lblRecCount: TLabel;
    tblFishFish_UCode: TSmallintField;
    tblFishUnitName: TStringField;
    cmbUnits: TComboBox;
    tblFishFish_Time: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure cmbTypeClick(Sender: TObject);
    procedure cmbTypeKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure tblFishCalcFields(DataSet: TDataSet);
    procedure cmdDelClick(Sender: TObject);
    procedure txtDateExit(Sender: TObject);
    procedure cmbUnitsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    procedure SendTab(var Key : Char);
    procedure ReadData;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

uses
  Globals, DateProc, Keyboard, DBS_Proc, MSGs;

procedure TfrmDelUnitFish.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  tblFishFish_Type.DisplayLabel := (tblFishFish_Type.DisplayLabel);
  tblFishFish_No.DisplayLabel := (tblFishFish_No.DisplayLabel);
  tblFishFish_UCode.DisplayLabel := (tblFishFish_UCode.DisplayLabel);
  tblFishUnitName.DisplayLabel := (tblFishUnitName.DisplayLabel);
  tblFishFish_Time.DisplayLabel := (tblFishFish_Time.DisplayLabel);
  cmdDel.Caption := (cmdDel.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

procedure TfrmDelUnitFish.ReadData;
var s : String;
begin
  s := 'Fish_Date = ''' + txtDate.Text + ''' AND Fish_Type = ' + IntToStr(cmbType.ItemIndex + 1);
  if txtFishNo.Text <> '' then
    s := s + ' AND Fish_No = ' + txtFishNo.Text;

  if cmbUnits.Text <> '' then
    s := s + ' AND Fish_UCode = ' + Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1)
  else
    s := s + ' AND Fish_UCode <> 0';
  tblFish.Filtered := False;
  tblFish.Filter := s;
  tblFish.Filtered := True;
  lblRecCount.Caption := (' ⁄œ«œ ›Ì‘Â« = ') + IntToStr(tblFish.RecordCount);
end;

procedure TfrmDelUnitFish.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;


procedure TfrmDelUnitFish.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
  i : Byte;
begin
  SetWinF;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM Units');
    Open;
    cmbUnits.Clear;
    while not Eof do
    begin
      cmbUnits.Items.Add(FieldByName('Unit_Code').AsString + '-' +
                         FieldByName('Unit_Name').AsString);
      Next;
    end;
    Close;
    Free;
  end;
  tblFish.connection := frmDBS.DBConnection;
  txtDate.Text := CurrentDate;
  for i := MB_SOBH to MB_SHAM do cmbType.Items.Add((FoodName[i]));
  cmbType.ItemIndex := 0;
  tblFish.Open;
  ReadData;
end;

procedure TfrmDelUnitFish.FormDeactivate(Sender: TObject);
begin
  tblFish.Close;
end;

procedure TfrmDelUnitFish.cmbTypeClick(Sender: TObject);
begin
  ReadData;
end;

procedure TfrmDelUnitFish.cmbTypeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmDelUnitFish.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmDelUnitFish.txtDateExit(Sender: TObject);
begin
  with txtDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
  ReadData;
end;

procedure TfrmDelUnitFish.cmbUnitsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbUnits.ItemIndex := -1;
    ReadData;
  end;
end;

procedure TfrmDelUnitFish.tblFishCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('UnitName'). AsString := GetUnitName(DataSet.FieldByName('Fish_UCode').AsInteger);
end;

procedure TfrmDelUnitFish.cmdDelClick(Sender: TObject);
var
  qry : TAdoQuery;
  fish_no : Integer;
begin
  if tblFish.RecordCount > 0 then
  begin
    if txtDate.Text <> '' then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ›Ì‘ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        fish_no := tblFish.FieldByName('Fish_No').AsInteger;
        qry := TAdoQuery.Create(Application);
        qry.connection := frmDBS.DBConnection;
        qry.SQL.Add('DELETE FROM FishFood WHERE FF_FishNo = ' + IntToStr(fish_no));
        qry.SQL.Add('AND FF_Date = ''' + txtDate.Text + '''');
        qry.SQL.Add('AND FF_Type = ' + IntToStr(cmbType.ItemIndex + 1));
        qry.ExecSQL;
        qry.Free;
        tblFish.Delete;
        LoadFishsNo(txtDate.Text);
      end;
    end
    else
      ErrorMessage(' «—ÌŒ „‘Œ’ ‰Ì” .');
  end;
end;

end.
