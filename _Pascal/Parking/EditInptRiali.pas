unit EditInptRiali;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, DateProc,
  FarsiApi, DBS, Keyboard, MSGs, DosMove, ExtCtrls, ComCtrls;

type
  TfrmEditInputRiali = class(TForm)
    grpView: TGroupBox;
    grpSearch: TGroupBox;
    GroupBox1: TGroupBox;
    rdoArival: TRadioButton;
    rdoExit: TRadioButton;
    cmdEdit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    cmbBarCode: TComboBox;
    cmbName: TComboBox;
    cmbColor: TComboBox;
    cmbCity: TComboBox;
    cmbIDoor: TComboBox;
    cmbIPerson: TComboBox;
    cmbODoor: TComboBox;
    cmbOPerson: TComboBox;
    txtNumber: TEdit;
    txtSerial: TEdit;
    txtIDate: TEdit;
    txtITime: TEdit;
    txtODate: TEdit;
    txtOTime: TEdit;
    dtaMachines: TDataSource;
    tblMachines: TADOTable;
    DosMove1: TDosMove;
    Panel1: TPanel;
    dbgMachines: TDBGrid;
    StatusBar1: TStatusBar;
    cmdCancelFilter: TBitBtn;
    tblMachinesM_rdrCode: TSmallintField;
    tblMachinesM_BarCode: TWideStringField;
    tblMachinesM_CarName: TWideStringField;
    tblMachinesM_Number: TWideStringField;
    tblMachinesM_CityName: TWideStringField;
    tblMachinesM_Serial: TWideStringField;
    tblMachinesM_PlaqueType: TSmallintField;
    tblMachinesM_PlaqueAppliance: TSmallintField;
    tblMachinesM_CitySerial: TIntegerField;
    tblMachinesM_Color: TWideStringField;
    tblMachinesM_IDate: TWideStringField;
    tblMachinesM_ITime: TWideStringField;
    tblMachinesM_ODate: TWideStringField;
    tblMachinesM_OTime: TWideStringField;
    tblMachinesM_Kind: TSmallintField;
    tblMachinesM_IDoor: TSmallintField;
    tblMachinesM_ODoor: TSmallintField;
    tblMachinesM_IPerson: TWideStringField;
    tblMachinesM_OPerson: TWideStringField;
    tblMachinesM_OperatorCode: TWideStringField;
    tblMachinesM_Price: TBCDField;
    tblMachinesM_PayAble: TBCDField;
    tblMachinesM_IsPark: TBooleanField;
    tblMachinesM_Karshenasi: TBooleanField;
    tblMachinesM_Gholnameh: TBooleanField;
    tblMachinesM_ExitValid: TBooleanField;
    tblMachinesM_IsDeleted: TBooleanField;
    tblMachinesM_BPayAble: TBCDField;
    grpEdit: TGroupBox;
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    Label16: TLabel;
    firstPayAble: TEdit;
    Label17: TLabel;
    newPayAble: TEdit;
    Label18: TLabel;
    currentPayAble: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbNameEnter(Sender: TObject);
    procedure cmbNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbColorKeyPress(Sender: TObject; var Key: Char);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure txtIDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtITimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbIDoorKeyPress(Sender: TObject; var Key: Char);
    procedure cmbIPersonKeyPress(Sender: TObject; var Key: Char);
    procedure txtODateKeyPress(Sender: TObject; var Key: Char);
    procedure txtOTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbODoorKeyPress(Sender: TObject; var Key: Char);
    procedure cmbOPersonKeyPress(Sender: TObject; var Key: Char);
    procedure tblMachinesCalcFields(DataSet: TDataSet);
    procedure rdoArivalClick(Sender: TObject);
    procedure txtIDateExit(Sender: TObject);
    procedure txtITimeExit(Sender: TObject);
    procedure txtODateExit(Sender: TObject);
    procedure txtOTimeExit(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgMachinesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgMachinesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgMachinesTitleClick(Column: TColumn);
    procedure txtIDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtODateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtITimeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtOTimeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure cmdCancelFilterClick(Sender: TObject);
    procedure cmbBarCodeChange(Sender: TObject);
    procedure txtNumberExit(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure newPayAbleKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    SrchStr : String;

    procedure ReadData;
    procedure SetWinF;
    procedure FormInEdit(vis : Boolean);

    
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmEditInputRiali.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label7.Caption := (Label7.Caption);
  Label8.Caption := (Label8.Caption);
  Label9.Caption := (Label9.Caption);
  Label10.Caption := (Label10.Caption);
  Label11.Caption := (Label11.Caption);
  Label12.Caption := (Label12.Caption);
  Label13.Caption := (Label13.Caption);
  Label14.Caption := (Label14.Caption);
  Label15.Caption := (Label15.Caption);
  rdoExit.Caption := (rdoExit.Caption);
  rdoArival.Caption := (rdoArival.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
//  tblMachinesM_BarCode.DisplayLabel := (tblMachinesM_BarCode.DisplayLabel);
//  tblMachinesM_CarName.DisplayLabel := (tblMachinesM_CarName.DisplayLabel);
//  tblMachinesM_Color.DisplayLabel := (tblMachinesM_Color.DisplayLabel);
//  tblMachinesNumber.DisplayLabel := (tblMachinesNumber.DisplayLabel);
//  tblMachinesCitySerial.DisplayLabel := (tblMachinesCitySerial.DisplayLabel);
//  tblMachinesM_IDate.DisplayLabel := (tblMachinesM_IDate.DisplayLabel);
//  tblMachinesM_ITime.DisplayLabel := (tblMachinesM_ITime.DisplayLabel);
//  tblMachinesM_ODate.DisplayLabel := (tblMachinesM_ODate.DisplayLabel);
//  tblMachinesM_OTime.DisplayLabel := (tblMachinesM_OTime.DisplayLabel);
end;

procedure TfrmEditInputRiali.ReadData;
var s : String;
begin
  if rdoArival.Checked then
    s := {kaveh 'M_IsPark = '  + IntToStr(CNST_TRUE) + ' AND kaveh}'M_IsDeleted = ' + IntToStr(CNST_FALSE)
  else
    s := {kaveh 'M_IsPark = ' + IntToStr(CNST_FALSE) + ' AND kaveh}'M_IsDeleted = ' + IntToStr(CNST_FALSE);

  if cmbBarCode.Text <> '' then
    s := s + ' AND M_BarCode = ''' + cmbBarCode.Text + '''';

  if cmbName.Text <> '' then
    s := s + ' AND M_CarName = ''' + cmbName.Text + '''';

  if cmbColor.Text <> '' then
    s := s + ' AND M_Color = ''' + cmbColor.Text + '''';

  if txtNumber.Text <> '' then
    s := s + ' AND M_Number = ''' + txtNumber.Text + '''';

  if cmbCity.Text <> '' then
    s := s + ' AND M_CityName = ''' + cmbCity.Text + '''';

  if txtSerial.Text <> '' then
    s := s + ' AND M_Serial = ''' + txtSerial.Text + '''';

  if txtIDate.Text <> '' then
    s := s + ' AND M_IDate = ''' + txtIDate.Text + '''';

  if txtITime.Text <> '' then
    s := s + ' AND M_ITime = ''' + txtITime.Text + '''';

  if cmbIDoor.Text <> '' then
    s := s + ' AND M_IDoor = ' + IntToStr(GetDoorCode(cmbIDoor.Text));

  if cmbIPerson.Text <> '' then
    s := s + ' AND M_IPerson = ''' + GetPersonCode(cmbIPerson.Text) + '''';

  if txtODate.Text <> '' then
    s := s + ' AND M_ODate = ''' + txtODate.Text + '''';

  if txtOTime.Text <> '' then
    s := s + ' AND M_OTime = ''' + txtOTime.Text + '''';

  if cmbODoor.Text <> '' then
    s := s + ' AND M_ODoor = ' + IntToStr(GetDoorCode(cmbODoor.Text));

  if cmbOPerson.Text <> '' then
    s := s + ' AND M_OPerson = ''' + GetPersonCode(cmbOPerson.Text) + '''';
  tblMachines.Filtered := False;
  tblMachines.Filter := s;
  tblMachines.Filtered := True;
end;

procedure TfrmEditInputRiali.FormInEdit(vis : Boolean);
begin
  grpView.Enabled := not vis;
  grpSearch.Visible := not vis;
  if vis then
    grpEdit.Align := alBottom
  else
    grpEdit.Align := alNone;
  grpEdit.Visible := vis;
end;

procedure TfrmEditInputRiali.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  Height := grpView.Height + grpSearch.Height + 25;
  SetDirectionFarsi(cmbName.Handle);
  SetDirectionFarsi(cmbColor.Handle);
  SetDirectionFarsi(txtNumber.Handle);
  SetDirectionFarsi(cmbCity.Handle);
  SetDirectionFarsi(cmbIDoor.Handle);
  SetDirectionFarsi(cmbIPerson.Handle);
  SetDirectionFarsi(cmbODoor.Handle);
  SetDirectionFarsi(cmbOPerson.Handle);

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT Card_Code FROM BarCodes WHERE Card_State = ' + IntToStr(MB_NORMAL));
  qry.Open;
  while not qry.EOF do
  begin
    cmbBarCode.Items.Add((qry.FieldByName('Card_Code').AsString));
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cars ORDER BY Car_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbName.Items.Add((qry.FieldByName('Car_Name').AsString));
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Colors ORDER BY Clr_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbColor.Items.Add((qry.FieldByName('Clr_Name').AsString));
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCity.Items.Add((qry.FieldByName('City_Name').AsString));
    qry.Next;
  end;
  qry.Close;

{kaveh  qry.SQL.Clear;
  qry.SQL.Add('SELECT R_Name FROM Readers WHERE R_Kind IN (' + IntToStr(MB_IN) + ', ' + IntToStr(MB_INOUT) + ')');
  qry.Open;
  while not qry.EOF do
  begin
    cmbIDoor.Items.Add((qry.FieldByName('R_Name').AsString));
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT R_Name FROM Readers WHERE R_Kind IN (' + IntToStr(MB_OUT) + ', ' + IntToStr(MB_INOUT) + ')');
  qry.Open;
  while not qry.EOF do
  begin
    cmbODoor.Items.Add((qry.FieldByName('R_Name').AsString));
    qry.Next;
  end;
  qry.Close; kaveh}

  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_Name FROM Persons');
  qry.Open;
  while not qry.EOF do
  begin
    cmbIPerson.Items.Add((qry.FieldByName('P_Name').AsString));
    cmbOPerson.Items.Add((qry.FieldByName('P_Name').AsString));
    qry.Next;
  end;
  qry.Close;

  qry.Free;

  tblMachines.connection := frmDBS.adoConnect;
  tblMachines.TableName := 'Machines';
  tblMachines.Open;
  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
  ReadData;
end;

procedure TfrmEditInputRiali.FormResize(Sender: TObject);
var
  w : Integer;
  i : Byte;
begin
  w := (dbgMachines.Width-40) div 7;
  for i := 0 to dbgMachines.Columns.Count-1 do
    dbgMachines.Columns[i].Width := w;

{  edlblCardCode.Left := grpSearch.Width - 140;
  edlblNumber.Left := (grpSearch.Width div 2) - 50;

  edlblFromDate.Left := edlblCardCode.Left;
  edlblToDate.Left := edlblNumber.Left; }
end;

procedure TfrmEditInputRiali.newPayAbleKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmEditInputRiali.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblMachines.Close;
end;

procedure TfrmEditInputRiali.rdoArivalClick(Sender: TObject);
var lastSort : string;
begin
  lastSort := tblMachines.Sort;
  tblMachines.Close;
  if rdoArival.Checked then
    begin
      tblMachines.TableName := 'Machines';
      dbgMachines.Hint := 'اطلاعات مربوط به ورود خودروها';
    end
  else
    begin
      tblMachines.TableName := 'Machines';
      dbgMachines.Hint := 'اطلاعات مربوط به خروج خودروها';
    end;
  tblMachines.Open;
  tblMachines.Sort := lastSort;
  ReadData;
end;

procedure TfrmEditInputRiali.cmbBarCodeChange(Sender: TObject);
begin
  ReadData;
end;

procedure TfrmEditInputRiali.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    Key := #0;
    cmbName.SetFocus;
  end
  else kaveh}
    Keyboard_Hex(Key);
end;

procedure TfrmEditInputRiali.cmbNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmEditInputRiali.cmbNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbColor.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbName, Key);
end;

procedure TfrmEditInputRiali.cmbColorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtNumber.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbColor, Key);
end;

procedure TfrmEditInputRiali.txtNumberExit(Sender: TObject);
begin
  ReadData;
end;

procedure TfrmEditInputRiali.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
    cmbCity.SetFocus
  else  kaveh}
    txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmEditInputRiali.cmbCityKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtSerial.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCity, Key);
end;

procedure TfrmEditInputRiali.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    txtIDate.SetFocus;
    Key := #0;
  end; kaveh}
  Keyboard_Integer(Key);
end;

procedure TfrmEditInputRiali.txtIDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtIDate.Text := CurrentDate;
  end;
end;

procedure TfrmEditInputRiali.txtIDateKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    txtITime.SetFocus;
    Key := #0;
  end
  else  kaveh}
    Keyboard_Date(Key);
end;

procedure TfrmEditInputRiali.txtIDateExit(Sender: TObject);
begin
  if txtIDate.Text <> '' then
    txtIDate.Text := BeautifulDate(txtIDate.Text);
  ReadData;
end;

procedure TfrmEditInputRiali.txtITimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtITime.Text := CurrentTime;
  end;
end;

procedure TfrmEditInputRiali.txtITimeKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    cmbIDoor.SetFocus;
    Key := #0;
  end
  else  kaveh}
    Keyboard_Time(Key);
end;

procedure TfrmEditInputRiali.txtITimeExit(Sender: TObject);
begin
  if txtITime.Text <> '' then
    txtITime.Text := BeautifulTime(txtITime.Text);
  ReadData;
end;

procedure TfrmEditInputRiali.cmbIPersonKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtODate.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmEditInputRiali.txtODateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtODate.Text := CurrentDate;
  end;
end;

procedure TfrmEditInputRiali.txtODateKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    txtOTime.SetFocus;
    Key := #0;
  end
  else kaveh}
    Keyboard_Date(Key);
end;

procedure TfrmEditInputRiali.txtODateExit(Sender: TObject);
begin
  if txtODate.Text <> '' then
    txtODate.Text := BeautifulDate(txtODate.Text);
  ReadData;
end;

procedure TfrmEditInputRiali.cmbIDoorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbIPerson.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmEditInputRiali.txtOTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtOTime.Text := CurrentTime;
  end;
end;

procedure TfrmEditInputRiali.txtOTimeKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    cmbODoor.SetFocus;
    Key := #0;
  end
  else kaveh}
    Keyboard_Time(Key);
end;

procedure TfrmEditInputRiali.txtOTimeExit(Sender: TObject);
begin
  if txtOTime.Text <> '' then
    txtOTime.Text := BeautifulTime(txtOTime.Text);
  ReadData;
end;

procedure TfrmEditInputRiali.cmbODoorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbOPerson.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmEditInputRiali.cmbOPersonKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmdEdit.SetFocus;
    Key := #0;
  end;
end;


procedure TfrmEditInputRiali.tblMachinesCalcFields(DataSet: TDataSet);
begin
{kaveh new 871203  with DataSet do
  begin
    FieldByName('Number').AsString := ConvertToFarsi(FieldByName('M_Number').AsString);
    if FieldByName('M_Serial').AsString <> '' then
      FieldByName('CitySerial').AsString := FieldByName('M_CityName').AsString + '-' + FieldByName('M_Serial').AsString
    else
      FieldByName('CitySerial').AsString := FieldByName('M_CityName').AsString;
  end;  kaveh}
end;


procedure TfrmEditInputRiali.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgMachines.SetFocus;
end;

procedure TfrmEditInputRiali.cmdCancelFilterClick(Sender: TObject);
begin
    if (cmbBarCode.ItemIndex > -1) or (txtNumber.Text <> '') or (txtSerial.Text <> '') or (txtIDate.Text <> '') or (txtODate.Text <> '') or (txtITime.Text <> '')or (txtOTime.Text <> '') then
     begin
      cmbBarCode.ItemIndex := -1;
      txtNumber.Text := '';
      txtSerial.Text := '';
      txtIDate.Text := '';
      txtODate.Text := '';
      txtITime.Text := '';
      txtOTime.Text := '';
      ReadData;
     end;
end;

procedure TfrmEditInputRiali.cmdEditClick(Sender: TObject);
var tbl : TAdoTable;
begin
  if (tblMachines.RecordCount > 0) {and ConfirmMessage('آيا براي حذف ركورد اطمينان داريد؟')} then
  begin
{    tblMachines.Close;
    if rdoArival.Checked then
      tblMachines.TableName := 'InputCar'
    else
      tblMachines.TableName := 'Machines';
    tblMachines.Open; }

    if  (tblMachines.FieldByName('M_BPayAble').AsString = '') or (tblMachines.FieldByName('M_BPayAble').AsString = '0') then
      firstPayAble.Text := tblMachines.FieldByName('M_PayAble').AsString
    else
      firstPayAble.Text := tblMachines.FieldByName('M_BPayAble').AsString;
    currentPayAble.Text := tblMachines.FieldByName('M_PayAble').AsString;  
    newPayAble.Text := '';
    FormInEdit(True);

    newPayAble.SetFocus;

{alan    tblMachines.Edit;
    tblMachines.FieldByName('M_IsDeleted').AsBoolean := True;
    tblMachines.Post;
    tblMachines.Close;
    if rdoArival.Checked then
      tblMachines.TableName := 'InputCar'
    else
      tblMachines.TableName := 'Machines';
    tblMachines.Open;

 alan}



{kaveh
    tbl := TAdoTable.Create(Application);
    tbl.connection := frmDBS.adoConnect;
    tbl.TableName := 'Deleted';
    tbl.Open;
    tbl.Append;

    tbl.FieldByName('D_BarCode').AsString := tblMachines.FieldByName('M_BarCode').AsString;
    tbl.FieldByName('D_CarName').AsString := tblMachines.FieldByName('M_CarName').AsString;
    tbl.FieldByName('D_Number').AsString := tblMachines.FieldByName('M_Number').AsString;
    tbl.FieldByName('D_CityName').AsString := tblMachines.FieldByName('M_CityName').AsString;
    tbl.FieldByName('D_Serial').AsString := tblMachines.FieldByName('M_Serial').AsString;
    tbl.FieldByName('D_Color').AsString := tblMachines.FieldByName('M_Color').AsString;
    tbl.FieldByName('D_IDate').AsString := tblMachines.FieldByName('M_IDate').AsString;
    tbl.FieldByName('D_ITime').AsString := tblMachines.FieldByName('M_ITime').AsString;
    tbl.FieldByName('D_IDoor').AsInteger := tblMachines.FieldByName('M_IDoor').AsInteger;
    tbl.FieldByName('D_IPerson').AsString := tblMachines.FieldByName('M_IPerson').AsString;
    tbl.FieldByName('D_ODate').AsString := tblMachines.FieldByName('M_ODate').AsString;
    tbl.FieldByName('D_OTime').AsString := tblMachines.FieldByName('M_OTime').AsString;
    tbl.FieldByName('D_ODoor').AsInteger := tblMachines.FieldByName('M_ODoor').AsInteger;
    tbl.FieldByName('D_OPerson').AsString := tblMachines.FieldByName('M_OPerson').AsString;
    tbl.FieldByName('D_Kind').AsInteger := tblMachines.FieldByName('M_Kind').AsInteger;
    tbl.FieldByName('D_Price').AsCurrency := tblMachines.FieldByName('M_Price').AsCurrency;
    tbl.FieldByName('D_Payable').AsCurrency := tblMachines.FieldByName('M_Payable').AsCurrency;
    tbl.FieldByName('D_IsPark').AsBoolean := tblMachines.FieldByName('M_IsPark').AsBoolean;
    tbl.FieldByName('D_Karshenasi').AsBoolean := tblMachines.FieldByName('M_Karshenasi').AsBoolean;
    tbl.FieldByName('D_Gholnameh').AsBoolean := tblMachines.FieldByName('M_Gholnameh').AsBoolean;
    tbl.FieldByName('D_ExitValid').AsBoolean := tblMachines.FieldByName('M_ExitValid').AsBoolean;
    tbl.FieldByName('D_UserName').AsString := g_options.UserName;
    tbl.FieldByName('D_Date').AsString := CurrentDate;
    tbl.FieldByName('D_Time').AsString := CurrentTime;
    tbl.Post;
    tbl.Close;

    if rdoExit.Checked then
    begin
      with tblMachines do
      begin
        if (FieldByName('M_Kind').AsInteger and MB_CUSTOMS) <> 0 then
          UpdateCustomsRemain(FieldByName('M_Number').AsString,
                              FieldByName('M_CityName').AsString,
                              FieldByName('M_Serial').AsString,
                              FieldByName('M_Price').AsCurrency-FieldByName('M_Payable').AsCurrency);

        tbl.TableName := 'InputCar';
        tbl.Open;
        tbl.Append;
        tbl.FieldByName('M_BarCode').AsString := FieldByName('M_BarCode').AsString;
        tbl.FieldByName('M_CarName').AsString := FieldByName('M_CarName').AsString;
        tbl.FieldByName('M_Number').AsString := FieldByName('M_Number').AsString;
        tbl.FieldByName('M_CityName').AsString := FieldByName('M_CityName').AsString;
        tbl.FieldByName('M_Serial').AsString := FieldByName('M_Serial').AsString;
        tbl.FieldByName('M_Color').AsString := FieldByName('M_Color').AsString;
        tbl.FieldByName('M_IDate').AsString := FieldByName('M_IDate').AsString;
        tbl.FieldByName('M_ITime').AsString := FieldByName('M_ITime').AsString;
        tbl.FieldByName('M_IPerson').AsString := FieldByName('M_IPerson').AsString;
        tbl.FieldByName('M_Karshenasi').AsBoolean := FieldByName('M_Karshenasi').AsBoolean;
        tbl.FieldByName('M_Gholnameh').AsBoolean := FieldByName('M_Gholnameh').AsBoolean;
        tbl.FieldByName('M_ExitValid').AsBoolean := FieldByName('M_ExitValid').AsBoolean;
        tbl.FieldByName('M_Kind').AsInteger := FieldByName('M_Kind').AsInteger;
        tbl.FieldByName('M_IsPark').AsBoolean := True;
        tbl.Post;
      end;
    end;

    tblMachines.Delete;
    tblMachines.Refresh;
    tbl.Free; kaveh}
  end;
end;

procedure TfrmEditInputRiali.cmdSaveClick(Sender: TObject);
begin
  if (newPayAble.Text <> '0') and (newPayAble.Text <> '') then
   begin
    tblMachines.Edit;
    if  (tblMachines.FieldByName('M_BPayAble').AsString = '') or (tblMachines.FieldByName('M_BPayAble').AsString = '0') then
     begin
      tblMachines.FieldByName('M_BPayAble').AsString := tblMachines.FieldByName('M_PayAble').AsString;
      tblMachines.FieldByName('M_PayAble').AsString := newPayAble.Text;
     end
    else
     begin
      tblMachines.FieldByName('M_PayAble').AsString := newPayAble.Text;
     end;
    tblMachines.Post;
    tblMachines.Close;
    tblMachines.TableName := 'Machines';
    tblMachines.Open;
    newPayAble.Text := '';
    FormInEdit(False);
    dbgMachines.SetFocus;
   end
  else
   begin
    ErrorMessage('مقدار صفر یا تهی برای مبلغ جدید غیر مجاز است.');
    newPayAble.SetFocus;                     
   end;
end;

//kaveh is
procedure TfrmEditInputRiali.dbgMachinesDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  iValue:Byte;
begin
    iValue := dbgMachines.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgMachines.canvas.brush.color :=ClBlue;
      dbgMachines.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgMachines.Canvas.Brush.Color := $00D1D9DC;
      0: dbgMachines.Canvas.Brush.Color := clWhite;
    end;
    dbgMachines.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
//kaveh ie

//kaveh is
procedure TfrmEditInputRiali.dbgMachinesMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const selectedTitelColor = clWindow;
var
  pt: TGridcoord;
  columensLeft : Integer;
  function clbtncol():Boolean;
  begin
    TDBGrid(dbgMachines).Columns[6].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[5].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[4].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[3].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[2].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgMachines.MouseCoord(x, y);
  if pt.y=0 then
   begin
    columensLeft := dbgMachines.Width - (TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width +
                                       TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width +
                                       TDBGrid(dbgMachines).Columns[2].Width + TDBGrid(dbgMachines).Columns[1].Width +
                                       TDBGrid(dbgMachines).Columns[0].Width + 39);
//    dbgMachines.Cursor:=crHandPoint;
    if (x > columensLeft) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[6].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[6].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[5].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[5].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[4].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[4].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[3].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[3].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width + TDBGrid(dbgMachines).Columns[2].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[2].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[2].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width + TDBGrid(dbgMachines).Columns[2].Width + TDBGrid(dbgMachines).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[1].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[1].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width + TDBGrid(dbgMachines).Columns[2].Width + TDBGrid(dbgMachines).Columns[1].Width + TDBGrid(dbgMachines).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[0].Title.Color := selectedTitelColor;
     end;

   end
  else
   begin
    dbgMachines.Cursor:=crDefault;
    clbtncol();
   end;
end;
//kaveh ie

//kaveh is
procedure TfrmEditInputRiali.dbgMachinesTitleClick(Column: TColumn);
var i: integer;
begin
{ with qryInput do
 begin
   if Active then
    Close;

   SQL.Clear;
   SQL.Add('SELECT M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_IsPark FROM InputCar');
   if DESC then
    SQL.Add('ORDER BY ' + ColumnT.FieldName + ' desc')
   else
    SQL.Add('ORDER BY ' + ColumnT.FieldName);
   Open;
 end;   }

//kaveh new  SearchData(Column,True);
 if (Column.Title.Font.Style = [fsbold]) and (Column.Title.Font.Color = clBlue)then
  begin
   tblMachines.Sort := Column.FieldName + ' DESC';
//   SearchData(Column,True);
   for i:=0 to TDBGrid(Column.Grid).Columns.Count-1 do
    begin
     TDBGrid(Column.Grid).Columns[i].Title.Font.Style:=[];
     TDBGrid(Column.Grid).Columns[i].Title.Font.Color:= clWindowText;
    end;
   Column.Title.Font.Style:=[fsbold];
   Column.Title.Font.Color:= clred;
  end
 else
  begin
   tblMachines.Sort := Column.FieldName + ' ASC';
//   SearchData(Column,False);
   for i:=0 to TDBGrid(Column.Grid).Columns.Count-1 do
    begin
      TDBGrid(Column.Grid).Columns[i].Title.Font.Style:=[];
      TDBGrid(Column.Grid).Columns[i].Title.Font.Color:= clWindowText;
    end;
   Column.Title.Font.Style:=[fsbold];
   Column.Title.Font.Color:= clBlue;
  end;
end;
//kaveh ie

end.
