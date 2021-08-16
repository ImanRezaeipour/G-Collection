unit DelRec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, DateProc,
  FarsiApi, DBS, Keyboard, MSGs, DosMove, ExtCtrls, ComCtrls;

type
  TfrmDelete = class(TForm)
    grpView: TGroupBox;
    grpSearch: TGroupBox;
    GroupBox1: TGroupBox;
    rdoArival: TRadioButton;
    rdoExit: TRadioButton;
    cmdDelete: TBitBtn;
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
    dtaDelete: TDataSource;
    tblDelete: TAdoTable;
    tblDeleteM_BarCode: TStringField;
    tblDeleteM_CarName: TStringField;
    tblDeleteM_Number: TStringField;
    tblDeleteM_CityName: TStringField;
    tblDeleteM_Serial: TStringField;
    tblDeleteM_Color: TStringField;
    tblDeleteM_IDate: TStringField;
    tblDeleteM_ITime: TStringField;
    tblDeleteM_ODate: TStringField;
    tblDeleteM_OTime: TStringField;
    tblDeleteM_Kind: TSmallintField;
    tblDeleteM_IDoor: TSmallintField;
    tblDeleteM_ODoor: TSmallintField;
    tblDeleteM_IPerson: TStringField;
    tblDeleteM_OPerson: TStringField;
    tblDeleteM_Price: TCurrencyField;
    tblDeleteM_PayAble: TCurrencyField;
    tblDeleteM_IsPark: TBooleanField;
    tblDeleteNumber: TStringField;
    tblDeleteCitySerial: TStringField;
    tblDeleteM_Karshenasi: TBooleanField;
    tblDeleteM_Gholnameh: TBooleanField;
    tblDeleteM_ExitValid: TBooleanField;
    tblDeleteM_IsDeleted: TBooleanField;
    DosMove1: TDosMove;
    Panel1: TPanel;
    dbgDelete: TDBGrid;
    StatusBar1: TStatusBar;
    cmdCancelFilter: TBitBtn;
    tblDeleteM_DUserName: TWideStringField;
    tblDeleteM_DDate: TWideStringField;
    tblDeleteM_DTime: TWideStringField;
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
    procedure tblDeleteCalcFields(DataSet: TDataSet);
    procedure rdoArivalClick(Sender: TObject);
    procedure txtIDateExit(Sender: TObject);
    procedure txtITimeExit(Sender: TObject);
    procedure txtODateExit(Sender: TObject);
    procedure txtOTimeExit(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure dbgDeleteDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDeleteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDeleteTitleClick(Column: TColumn);
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
  private
    { Private declarations }
    SrchStr : String;

    procedure ReadData;
    procedure SetWinF;
    
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmDelete.SetWinF;
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
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  tblDeleteM_BarCode.DisplayLabel := (tblDeleteM_BarCode.DisplayLabel);
  tblDeleteM_CarName.DisplayLabel := (tblDeleteM_CarName.DisplayLabel);
  tblDeleteM_Color.DisplayLabel := (tblDeleteM_Color.DisplayLabel);
  tblDeleteNumber.DisplayLabel := (tblDeleteNumber.DisplayLabel);
  tblDeleteCitySerial.DisplayLabel := (tblDeleteCitySerial.DisplayLabel);
  tblDeleteM_IDate.DisplayLabel := (tblDeleteM_IDate.DisplayLabel);
  tblDeleteM_ITime.DisplayLabel := (tblDeleteM_ITime.DisplayLabel);
  tblDeleteM_ODate.DisplayLabel := (tblDeleteM_ODate.DisplayLabel);
  tblDeleteM_OTime.DisplayLabel := (tblDeleteM_OTime.DisplayLabel);
end;

procedure TfrmDelete.ReadData;
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
  tblDelete.Filtered := False;
  tblDelete.Filter := s;
  tblDelete.Filtered := True;
end;

procedure TfrmDelete.FormCreate(Sender: TObject);
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

  tblDelete.connection := frmDBS.adoConnect;
  tblDelete.TableName := 'InputCar';
  tblDelete.Open;
  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
  ReadData;
end;

procedure TfrmDelete.FormResize(Sender: TObject);
var
  w : Integer;
  i : Byte;
begin
  w := (dbgDelete.Width-40) div 7;
  for i := 0 to dbgDelete.Columns.Count-1 do
    dbgDelete.Columns[i].Width := w;

{  edlblCardCode.Left := grpSearch.Width - 140;
  edlblNumber.Left := (grpSearch.Width div 2) - 50;

  edlblFromDate.Left := edlblCardCode.Left;
  edlblToDate.Left := edlblNumber.Left; }
end;

procedure TfrmDelete.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblDelete.Close;
end;

procedure TfrmDelete.rdoArivalClick(Sender: TObject);
var lastSort : string;
begin
  lastSort := tblDelete.Sort;
  tblDelete.Close;
  if rdoArival.Checked then
    begin
      tblDelete.TableName := 'InputCar';
      dbgDelete.Hint := '«ÿ·«⁄«  „—»Êÿ »Â Ê—Êœ ŒÊœ—ÊÂ«';
    end
  else
    begin
      tblDelete.TableName := 'Machines';
      dbgDelete.Hint := '«ÿ·«⁄«  „—»Êÿ »Â Œ—ÊÃ ŒÊœ—ÊÂ«';
    end;
  tblDelete.Open;
  tblDelete.Sort := lastSort;
  ReadData;
end;

procedure TfrmDelete.cmbBarCodeChange(Sender: TObject);
begin
  ReadData;
end;

procedure TfrmDelete.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    Key := #0;
    cmbName.SetFocus;
  end
  else kaveh}
    Keyboard_Hex(Key);
end;

procedure TfrmDelete.cmbNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmDelete.cmbNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbColor.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbName, Key);
end;

procedure TfrmDelete.cmbColorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtNumber.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbColor, Key);
end;

procedure TfrmDelete.txtNumberExit(Sender: TObject);
begin
  ReadData;
end;

procedure TfrmDelete.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
    cmbCity.SetFocus
  else  kaveh}
    txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmDelete.cmbCityKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtSerial.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCity, Key);
end;

procedure TfrmDelete.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    txtIDate.SetFocus;
    Key := #0;
  end; kaveh}
  Keyboard_Integer(Key);
end;

procedure TfrmDelete.txtIDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtIDate.Text := CurrentDate;
  end;
end;

procedure TfrmDelete.txtIDateKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    txtITime.SetFocus;
    Key := #0;
  end
  else  kaveh}
    Keyboard_Date(Key);
end;

procedure TfrmDelete.txtIDateExit(Sender: TObject);
begin
  if txtIDate.Text <> '' then
    txtIDate.Text := BeautifulDate(txtIDate.Text);
  ReadData;
end;

procedure TfrmDelete.txtITimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtITime.Text := CurrentTime;
  end;
end;

procedure TfrmDelete.txtITimeKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    cmbIDoor.SetFocus;
    Key := #0;
  end
  else  kaveh}
    Keyboard_Time(Key);
end;

procedure TfrmDelete.txtITimeExit(Sender: TObject);
begin
  if txtITime.Text <> '' then
    txtITime.Text := BeautifulTime(txtITime.Text);
  ReadData;
end;

procedure TfrmDelete.cmbIPersonKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtODate.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmDelete.txtODateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtODate.Text := CurrentDate;
  end;
end;

procedure TfrmDelete.txtODateKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    txtOTime.SetFocus;
    Key := #0;
  end
  else kaveh}
    Keyboard_Date(Key);
end;

procedure TfrmDelete.txtODateExit(Sender: TObject);
begin
  if txtODate.Text <> '' then
    txtODate.Text := BeautifulDate(txtODate.Text);
  ReadData;
end;

procedure TfrmDelete.cmbIDoorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbIPerson.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmDelete.txtOTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtOTime.Text := CurrentTime;
  end;
end;

procedure TfrmDelete.txtOTimeKeyPress(Sender: TObject; var Key: Char);
begin
{kaveh  if Key = #13 then
  begin
    cmbODoor.SetFocus;
    Key := #0;
  end
  else kaveh}
    Keyboard_Time(Key);
end;

procedure TfrmDelete.txtOTimeExit(Sender: TObject);
begin
  if txtOTime.Text <> '' then
    txtOTime.Text := BeautifulTime(txtOTime.Text);
  ReadData;
end;

procedure TfrmDelete.cmbODoorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbOPerson.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmDelete.cmbOPersonKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmdDelete.SetFocus;
    Key := #0;
  end;
end;


procedure TfrmDelete.tblDeleteCalcFields(DataSet: TDataSet);
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


procedure TfrmDelete.cmdCancelFilterClick(Sender: TObject);
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

procedure TfrmDelete.cmdDeleteClick(Sender: TObject);
var tbl : TAdoTable;
begin
  if (tblDelete.RecordCount > 0) and
     ConfirmMessage('¬Ì« »—«Ì Õ–› —ﬂÊ—œ «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
{    tblDelete.Close;
    if rdoArival.Checked then
      tblDelete.TableName := 'InputCar'
    else
      tblDelete.TableName := 'Machines';
    tblDelete.Open; }
    tblDelete.Edit;
    tblDelete.FieldByName('M_IsDeleted').AsBoolean := True;
//kaveh880312 is
    tblDelete.FieldByName('M_DUserName').AsString := g_options.UserName;
    tblDelete.FieldByName('M_DDate').AsString := CurrentDate;
    tblDelete.FieldByName('M_DTime').AsString := CurrentTime;
//kaveh880312 ie
    tblDelete.Post;
    tblDelete.Close;
    if rdoArival.Checked then
      tblDelete.TableName := 'InputCar'
    else
      tblDelete.TableName := 'Machines';
    tblDelete.Open;

{kaveh
    tbl := TAdoTable.Create(Application);
    tbl.connection := frmDBS.adoConnect;
    tbl.TableName := 'Deleted';
    tbl.Open;
    tbl.Append;

    tbl.FieldByName('D_BarCode').AsString := tblDelete.FieldByName('M_BarCode').AsString;
    tbl.FieldByName('D_CarName').AsString := tblDelete.FieldByName('M_CarName').AsString;
    tbl.FieldByName('D_Number').AsString := tblDelete.FieldByName('M_Number').AsString;
    tbl.FieldByName('D_CityName').AsString := tblDelete.FieldByName('M_CityName').AsString;
    tbl.FieldByName('D_Serial').AsString := tblDelete.FieldByName('M_Serial').AsString;
    tbl.FieldByName('D_Color').AsString := tblDelete.FieldByName('M_Color').AsString;
    tbl.FieldByName('D_IDate').AsString := tblDelete.FieldByName('M_IDate').AsString;
    tbl.FieldByName('D_ITime').AsString := tblDelete.FieldByName('M_ITime').AsString;
    tbl.FieldByName('D_IDoor').AsInteger := tblDelete.FieldByName('M_IDoor').AsInteger;
    tbl.FieldByName('D_IPerson').AsString := tblDelete.FieldByName('M_IPerson').AsString;
    tbl.FieldByName('D_ODate').AsString := tblDelete.FieldByName('M_ODate').AsString;
    tbl.FieldByName('D_OTime').AsString := tblDelete.FieldByName('M_OTime').AsString;
    tbl.FieldByName('D_ODoor').AsInteger := tblDelete.FieldByName('M_ODoor').AsInteger;
    tbl.FieldByName('D_OPerson').AsString := tblDelete.FieldByName('M_OPerson').AsString;
    tbl.FieldByName('D_Kind').AsInteger := tblDelete.FieldByName('M_Kind').AsInteger;
    tbl.FieldByName('D_Price').AsCurrency := tblDelete.FieldByName('M_Price').AsCurrency;
    tbl.FieldByName('D_Payable').AsCurrency := tblDelete.FieldByName('M_Payable').AsCurrency;
    tbl.FieldByName('D_IsPark').AsBoolean := tblDelete.FieldByName('M_IsPark').AsBoolean;
    tbl.FieldByName('D_Karshenasi').AsBoolean := tblDelete.FieldByName('M_Karshenasi').AsBoolean;
    tbl.FieldByName('D_Gholnameh').AsBoolean := tblDelete.FieldByName('M_Gholnameh').AsBoolean;
    tbl.FieldByName('D_ExitValid').AsBoolean := tblDelete.FieldByName('M_ExitValid').AsBoolean;
    tbl.FieldByName('D_UserName').AsString := g_options.UserName;
    tbl.FieldByName('D_Date').AsString := CurrentDate;
    tbl.FieldByName('D_Time').AsString := CurrentTime;
    tbl.Post;
    tbl.Close;

    if rdoExit.Checked then
    begin
      with tblDelete do
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

    tblDelete.Delete;
    tblDelete.Refresh;
    tbl.Free; kaveh}
  end;
end;

//kaveh is
procedure TfrmDelete.dbgDeleteDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  iValue:Byte;
begin
    iValue := dbgDelete.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgDelete.canvas.brush.color :=ClBlue;
      dbgDelete.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgDelete.Canvas.Brush.Color := $00D1D9DC;
      0: dbgDelete.Canvas.Brush.Color := clWhite;
    end;
    dbgDelete.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end; //kaveh ie

//kaveh is
procedure TfrmDelete.dbgDeleteMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const selectedTitelColor = clWindow;
var
  pt: TGridcoord;
  columensLeft : Integer;
  function clbtncol():Boolean;
  begin
    TDBGrid(dbgDelete).Columns[6].Title.Color := clBtnFace;
    TDBGrid(dbgDelete).Columns[5].Title.Color := clBtnFace;
    TDBGrid(dbgDelete).Columns[4].Title.Color := clBtnFace;
    TDBGrid(dbgDelete).Columns[3].Title.Color := clBtnFace;
    TDBGrid(dbgDelete).Columns[2].Title.Color := clBtnFace;
    TDBGrid(dbgDelete).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgDelete).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgDelete.MouseCoord(x, y);
  if pt.y=0 then
   begin
    columensLeft := dbgDelete.Width - (TDBGrid(dbgDelete).Columns[6].Width + TDBGrid(dbgDelete).Columns[5].Width +
                                       TDBGrid(dbgDelete).Columns[4].Width + TDBGrid(dbgDelete).Columns[3].Width +
                                       TDBGrid(dbgDelete).Columns[2].Width + TDBGrid(dbgDelete).Columns[1].Width +
                                       TDBGrid(dbgDelete).Columns[0].Width + 39);
//    dbgDelete.Cursor:=crHandPoint;
    if (x > columensLeft) and (x < columensLeft + TDBGrid(dbgDelete).Columns[6].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDelete).Columns[6].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgDelete).Columns[6].Width) and (x < columensLeft + TDBGrid(dbgDelete).Columns[6].Width + TDBGrid(dbgDelete).Columns[5].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDelete).Columns[5].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgDelete).Columns[5].Width) and (x < columensLeft + TDBGrid(dbgDelete).Columns[6].Width + TDBGrid(dbgDelete).Columns[5].Width + TDBGrid(dbgDelete).Columns[4].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDelete).Columns[4].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgDelete).Columns[4].Width) and (x < columensLeft + TDBGrid(dbgDelete).Columns[6].Width + TDBGrid(dbgDelete).Columns[5].Width + TDBGrid(dbgDelete).Columns[4].Width + TDBGrid(dbgDelete).Columns[3].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDelete).Columns[3].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgDelete).Columns[3].Width) and (x < columensLeft + TDBGrid(dbgDelete).Columns[6].Width + TDBGrid(dbgDelete).Columns[5].Width + TDBGrid(dbgDelete).Columns[4].Width + TDBGrid(dbgDelete).Columns[3].Width + TDBGrid(dbgDelete).Columns[2].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDelete).Columns[2].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgDelete).Columns[2].Width) and (x < columensLeft + TDBGrid(dbgDelete).Columns[6].Width + TDBGrid(dbgDelete).Columns[5].Width + TDBGrid(dbgDelete).Columns[4].Width + TDBGrid(dbgDelete).Columns[3].Width + TDBGrid(dbgDelete).Columns[2].Width + TDBGrid(dbgDelete).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDelete).Columns[1].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgDelete).Columns[1].Width) and (x < columensLeft + TDBGrid(dbgDelete).Columns[6].Width + TDBGrid(dbgDelete).Columns[5].Width + TDBGrid(dbgDelete).Columns[4].Width + TDBGrid(dbgDelete).Columns[3].Width + TDBGrid(dbgDelete).Columns[2].Width + TDBGrid(dbgDelete).Columns[1].Width + TDBGrid(dbgDelete).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDelete).Columns[0].Title.Color := selectedTitelColor;
     end;

   end
  else
   begin
    dbgDelete.Cursor:=crDefault;
    clbtncol();
   end;
end; //kaveh ie

//kaveh is
procedure TfrmDelete.dbgDeleteTitleClick(Column: TColumn);
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
   tblDelete.Sort := Column.FieldName + ' DESC';
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
   tblDelete.Sort := Column.FieldName + ' ASC';
//   SearchData(Column,False);
   for i:=0 to TDBGrid(Column.Grid).Columns.Count-1 do
    begin
      TDBGrid(Column.Grid).Columns[i].Title.Font.Style:=[];
      TDBGrid(Column.Grid).Columns[i].Title.Font.Color:= clWindowText;
    end;
   Column.Title.Font.Style:=[fsbold];
   Column.Title.Font.Color:= clBlue;
  end;
end; //kaveh ie

end.
