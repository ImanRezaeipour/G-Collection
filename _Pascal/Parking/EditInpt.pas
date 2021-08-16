unit EditInpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, DateProc,
  FarsiApi, DBS, Keyboard, MSGs, DosMove;

type
  TfrmEditInput = class(TForm)
    grpView: TGroupBox;
    grpEdit: TGroupBox;
    dbgEdit: TDBGrid;
    cmdEdit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    Label1: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    txtNumber: TEdit;
    txtSerial: TEdit;
    txtIDate: TEdit;
    txtITime: TEdit;
    dtaInput: TDataSource;
    tblInput: TAdoTable;
    tblInputM_BarCode: TStringField;
    tblInputM_CarName: TStringField;
    tblInputM_Number: TStringField;
    tblInputM_CityName: TStringField;
    tblInputM_Serial: TStringField;
    tblInputM_Color: TStringField;
    tblInputM_IDate: TStringField;
    tblInputM_ITime: TStringField;
    tblInputM_IsPark: TBooleanField;
    cmbBarCode: TComboBox;
    txtSName: TEdit;
    txtSNumber: TEdit;
    txtSCity: TEdit;
    txtSSerial: TEdit;
    txtSDate: TEdit;
    txtSTime: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    cmbName: TComboBox;
    Label3: TLabel;
    cmbColor: TComboBox;
    Label4: TLabel;
    cmbCity: TComboBox;
    Label6: TLabel;
    txtSColor: TEdit;
    DosMove1: TDosMove;
    qryInput: TAdoQuery;
    dtaInput2: TDataSource;
    lbl2: TLabel;
    cmdCancelFilter: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbNameEnter(Sender: TObject);
    procedure cmbNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbColorKeyPress(Sender: TObject; var Key: Char);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtIDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtITimeKeyPress(Sender: TObject; var Key: Char);
    procedure tblInputCalcFields(DataSet: TDataSet);
    procedure txtIDateExit(Sender: TObject);
    procedure txtITimeExit(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure txtSNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtSNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBarCodeClick(Sender: TObject);
    procedure cmbBarCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtSDateExit(Sender: TObject);
    procedure txtSTimeExit(Sender: TObject);
    procedure dbgEditKeyPress(Sender: TObject; var Key: Char);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtIDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtITimeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgEditDblClick(Sender: TObject);
    procedure dbgEditDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgEditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgEditTitleClick(Column: TColumn);
    procedure FormDestroy(Sender: TObject);
    procedure cmdCancelFilterClick(Sender: TObject);
  private
    { Private declarations }
    SrchStr : String;
//kaveh i
    procedure SearchData(ColumnT: TColumn; DESC: Boolean);

    procedure FormInEdit(vis : Boolean);
    procedure SendTab(var Key : Char);
    procedure ReadData;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmEditInput.SearchData(ColumnT: TColumn; DESC: Boolean);
begin
  with qryInput do
  begin
    if Active then
      Close;

//k    AddRecToMachine;
{  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM InputCar WHERE M_Ispark = True');
  qry.Open;
  while not qry.EOF do
  begin
    cmbBarCode.Items.Add(qry.FieldByName('M_BarCode').AsString);
    qry.Next;
  end;
  qry.Close; }

    SQL.Clear;
    SQL.Add('SELECT M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_IsPark FROM InputCar');
    if DESC then
     SQL.Add('ORDER BY ' + ColumnT.FieldName + ' desc')
    else
     SQL.Add('ORDER BY ' + ColumnT.FieldName);
    Open;
//k    TADOQuery(Column.Grid.DataSource.DataSet).Sort:='['+Column.FieldName+']' ;
{    case cmbStatus.ItemIndex of
      0: SQL.Add('WHERE (M_IsPark = True OR M_IsPark = False)');
      1: SQL.Add('WHERE M_IsPark = True');
      2: SQL.Add('WHERE M_IsPark = False');
    end; }

{    if edlblCardCode.Text <> '' then
      SQL.Add('AND M_BarCode = ''' + edlblCardCode.Text + '''');
    if edlblNumber.Text <> '' then
      SQL.Add('AND M_Number = ''' + edlblNumber.Text + '''');
    if edlblFromDate.Text <> '' then
      SQL.Add('AND (M_IDate >= ''' + edlblFromDate.Text + ''' OR M_ODate >= ''' + edlblFromDate.Text + ''')');
    if edlblToDate.Text <> '' then
      SQL.Add('AND (M_IDate <= ''' + edlblToDate.Text + ''' OR M_ODate <= ''' + edlblToDate.Text + ''')');

    case cmbSort.ItemIndex of
      1 : SQL.Add('ORDER BY M_BarCode, M_IDate, M_ITime');
      2 : SQL.Add('ORDER BY M_Number, M_IDate, M_ITime');
      3 : SQL.Add('ORDER BY M_IDate, M_ITime');
      4 : SQL.Add('ORDER BY M_ODate, M_OTime');
    end;
    Open;

    if (edlblNumber.Text = '') and (edlblCardCode.Text = '') then
      pnlStatus.Caption := (' ⁄œ«œ ŒÊœ—ÊÂ« = ') + IntToStr(RecordCount)
    else if RecordCount > 0 then
    begin
      Last;
      if FieldByName('M_IsPark').AsBoolean then
        pnlStatus.Caption := ('ŒÊœ—Ê œ— Å«—ﬂÌ‰ê „Ìù»«‘œ')
      else
        pnlStatus.Caption := ('ŒÊœ—Ê Œ«—Ã ‘œÂ «” ');

    end
    else
      pnlStatus.Caption := ('ŒÊœ—ÊÌÌ ÊÃÊœ ‰œ«—œ');  }
  end;
end;


procedure TfrmEditInput.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label7.Caption := (Label7.Caption);
  Label8.Caption := (Label8.Caption);
  Label9.Caption := (Label9.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdExit.Caption := (cmdExit.Caption);
{kaveh
  tblInputM_BarCode.DisplayLabel := (tblInputM_BarCode.DisplayLabel);
  tblInputM_CarName.DisplayLabel := (tblInputM_CarName.DisplayLabel);
  tblInputM_Number.DisplayLabel := (tblInputM_Number.DisplayLabel);
  tblInputM_CityName.DisplayLabel := (tblInputM_CityName.DisplayLabel);
  tblInputM_Serial.DisplayLabel := (tblInputM_Serial.DisplayLabel);
  tblInputM_Color.DisplayLabel := (tblInputM_Color.DisplayLabel);
  tblInputM_IDate.DisplayLabel := (tblInputM_IDate.DisplayLabel);
  tblInputM_ITime.DisplayLabel := (tblInputM_ITime.DisplayLabel);
kaveh}
end;

procedure TfrmEditInput.FormInEdit(vis : Boolean);
begin
  grpView.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpView.Height + grpEdit.Height
  else
    Height := grpView.Height;
  Height := Height + 25;
end;

procedure TfrmEditInput.SendTab(var Key : Char);
var t : TWinControl;
begin
//  if Key = #13 then
//  begin
//    Key := #0;
//    t := FindNextControl(ActiveControl, True, True, False);
//    t.SetFocus;
//  end;
end;

procedure TfrmEditInput.ReadData;
var s : String;
begin
  s := 'M_IsPark = ' + IntToStr(CNST_TRUE);

  if cmbBarCode.Text <> '' then
    s := s + ' AND M_BarCode = ''' + cmbBarCode.Text + '''';

  if txtSName.Text <> '' then
    s := s + ' AND M_CarName = ''' + txtSName.Text + '''';

  if txtSNumber.Text <> '' then
    s := s + ' AND M_Number = ''' + txtSNumber.Text + '''';

  if txtSCity.Text <> '' then
    s := s + ' AND M_CityName = ''' + txtSCity.Text + '''';

  if txtSSerial.Text <> '' then
    s := s + ' AND M_Serial = ''' + txtSSerial.Text + '''';

  if txtSColor.Text <> '' then
    s := s + ' AND M_Color = ''' + txtSColor.Text + '''';

  if txtSDate.Text <> '' then
    s := s + ' AND M_IDate = ''' + txtSDate.Text + '''';

  if txtSTime.Text <> '' then
    s := s + ' AND M_ITime = ''' + txtSTime.Text + '''';

//kaveh is
  qryInput.Filtered := False;
  qryInput.Filter := s;
  qryInput.Filtered := True;
//kaveh ie
//kaveh  tblInput.Filtered := False;
//kaveh  tblInput.Filter := s;
//kaveh  tblInput.Filtered := True;
end;

procedure TfrmEditInput.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  FormInEdit(False);
  SetDirectionFarsi(cmbName.Handle);
  SetDirectionFarsi(cmbColor.Handle);
  SetDirectionFarsi(txtNumber.Handle);
  SetDirectionFarsi(cmbCity.Handle);

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT M_BarCode FROM InputCar WHERE M_Ispark = ' + IntToStr(CNST_TRUE));
  qry.Open;
  while not qry.EOF do
  begin
    cmbBarCode.Items.Add(qry.FieldByName('M_BarCode').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cars ORDER BY Car_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbName.Items.Add(qry.FieldByName('Car_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Colors ORDER BY Clr_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbColor.Items.Add(qry.FieldByName('Clr_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCity.Items.Add(qry.FieldByName('City_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.Free;

//kaveh is
  qryInput.connection := frmDBS.adoConnect;
  qryInput.Active := True;
//kaveh  edlblFromDate.Text := CurrentDate;
//kaveh  edlblToDate.Text := CurrentDate;
//kaveh  SearchData;

//kaveh ie
//kaveh  tblInput.connection := frmDBS.adoConnect;
//kaveh  tblInput.TableName := 'InputCar';
//kaveh  tblInput.Open;
  ReadData;
end;

procedure TfrmEditInput.FormDestroy(Sender: TObject);
begin
  qryInput.Close;
end;

procedure TfrmEditInput.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//kaveh i
  qryInput.Close;
//kaveh  tblInput.Close;
end;

procedure TfrmEditInput.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmEditInput.cmbNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmEditInput.cmbNameKeyPress(Sender: TObject; var Key: Char);
begin
    SrchNearst(SrchStr, cmbName, Key);
end;

procedure TfrmEditInput.cmbColorKeyPress(Sender: TObject; var Key: Char);
begin
    SrchNearst(SrchStr, cmbColor, Key);
end;

procedure TfrmEditInput.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmEditInput.cmbCityKeyPress(Sender: TObject; var Key: Char);
begin
    SrchNearst(SrchStr, cmbCity, Key);
end;

procedure TfrmEditInput.txtIDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) and (Shift = [ssCtrl]) then
    txtIDate.Text := CurrentDate
end;

procedure TfrmEditInput.txtIDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmEditInput.txtIDateExit(Sender: TObject);
begin
  if txtIDate.Text <> '' then
    txtIDate.Text := BeautifulDate(txtIDate.Text);
  if txtIDate.Text = '//' then
    txtIDate.Text := '';
end;

procedure TfrmEditInput.txtITimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) and (Shift = [ssCtrl]) then
    txtITime.Text := CurrentTime;
end;

procedure TfrmEditInput.txtITimeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmEditInput.txtITimeExit(Sender: TObject);
begin
  if txtITime.Text <> '' then
    txtITime.Text := BeautifulTime(txtITime.Text);
end;

procedure TfrmEditInput.tblInputCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('Number').AsString := ConvertToFarsi(FieldByName('M_Number').AsString);
    if FieldByName('M_Serial').AsString <> '' then
      FieldByName('CitySerial').AsString := FieldByName('M_CityName').AsString + '-' + FieldByName('M_Serial').AsString
    else
      FieldByName('CitySerial').AsString := FieldByName('M_CityName').AsString;
  end;
end;

procedure TfrmEditInput.txtSNameKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmEditInput.txtSNumberKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  txtSNumber.Text := Key_CarNumber(txtSNumber.Text, Key, txtSNumber.SelLength);
  Key := #0;
end;

procedure TfrmEditInput.cmbBarCodeClick(Sender: TObject);
begin
  ReadData;
end;

procedure TfrmEditInput.cmbBarCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbBarCode.ItemIndex := -1;
    ReadData;
  end;
end;

procedure TfrmEditInput.txtSDateExit(Sender: TObject);
begin
  with txtSDate do
    if Text <> '' then Text := BeautifulDate(Text);

  ReadData;
end;

procedure TfrmEditInput.txtSTimeExit(Sender: TObject);
begin
  with txtSTime do
    if Text <> '' then Text := BeautifulTime(Text);

  ReadData;
end;

//kaveh is
procedure TfrmEditInput.dbgEditDblClick(Sender: TObject);
begin
//  cmdEditClick(Sender);
end;
//kaveh ie

//kaveh is
procedure TfrmEditInput.dbgEditDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  iValue:Byte;
begin
    iValue :=dbgEdit.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgEdit.canvas.brush.color :=ClBlue;
      dbgEdit.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgEdit.Canvas.Brush.Color := $00D1D9DC;
      0: dbgEdit.Canvas.Brush.Color := clWhite;
    end;
    dbgEdit.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
//kaveh ie

procedure TfrmEditInput.dbgEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdEditClick(Sender);
  end;
end;

//kaveh is
procedure TfrmEditInput.dbgEditMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const selectedTitelColor = clWindow;
var
  pt: TGridcoord;
  function clbtncol():Boolean;
  begin
    TDBGrid(dbgEdit).Columns[4].Title.Color := clBtnFace;
    TDBGrid(dbgEdit).Columns[3].Title.Color := clBtnFace;
    TDBGrid(dbgEdit).Columns[2].Title.Color := clBtnFace;
    TDBGrid(dbgEdit).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgEdit).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgEdit.MouseCoord(x, y);
  if pt.y=0 then
   begin
//    dbgEdit.Cursor:=crHandPoint;
    if (x > 0) and (x < TDBGrid(dbgEdit).Columns[4].Width) then
     begin
       clbtncol();
       TDBGrid(dbgEdit).Columns[4].Title.Color := selectedTitelColor;
     end
    else if (x > TDBGrid(dbgEdit).Columns[4].Width) and (x < TDBGrid(dbgEdit).Columns[4].Width + TDBGrid(dbgEdit).Columns[3].Width) then
     begin
       clbtncol();
       TDBGrid(dbgEdit).Columns[3].Title.Color := selectedTitelColor;
    end
    else if (x > TDBGrid(dbgEdit).Columns[3].Width) and (x < TDBGrid(dbgEdit).Columns[4].Width + TDBGrid(dbgEdit).Columns[3].Width + TDBGrid(dbgEdit).Columns[2].Width) then
     begin
       clbtncol();
       TDBGrid(dbgEdit).Columns[2].Title.Color := selectedTitelColor;
     end
    else if (x > TDBGrid(dbgEdit).Columns[2].Width) and (x < TDBGrid(dbgEdit).Columns[4].Width + TDBGrid(dbgEdit).Columns[3].Width + TDBGrid(dbgEdit).Columns[2].Width + TDBGrid(dbgEdit).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgEdit).Columns[1].Title.Color := selectedTitelColor;
     end
    else if (x > TDBGrid(dbgEdit).Columns[1].Width) and (x < TDBGrid(dbgEdit).Columns[4].Width + TDBGrid(dbgEdit).Columns[3].Width + TDBGrid(dbgEdit).Columns[2].Width + TDBGrid(dbgEdit).Columns[1].Width + TDBGrid(dbgEdit).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgEdit).Columns[0].Title.Color := selectedTitelColor;
     end;
   end
  else
   begin
    dbgEdit.Cursor:=crDefault;
    clbtncol();
   end;
end;
//kaveh ie

//kaveh is
procedure TfrmEditInput.dbgEditTitleClick(Column: TColumn);
var i: integer;
begin
  SearchData(Column,True);
 if (Column.Title.Font.Style = [fsbold]) and (Column.Title.Font.Color = clBlue)then
  begin
   SearchData(Column,True);
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
   SearchData(Column,False);
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

procedure TfrmEditInput.cmdEditClick(Sender: TObject);
begin
//kaveh  if tblInput.RecordCount > 0 then
// kaveh i
  if qryInput.RecordCount > 0 then
  begin
    FormInEdit(True);
//kaveh is
//kaveh    cmbName.Text := qryInput.FieldByName('M_CarName').AsString;
//kaveh    cmbColor.Text := qryInput.FieldByName('M_Color').AsString;
    txtNumber.Text := qryInput.FieldByName('M_Number').AsString;
//kaveh    cmbCity.Text := qryInput.FieldByName('M_CityName').AsString;
    txtSerial.Text := qryInput.FieldByName('M_Serial').AsString;
    txtIDate.Text := qryInput.FieldByName('M_IDate').AsString;
    txtITime.Text := qryInput.FieldByName('M_ITime').AsString;
//kaveh ie
{kaveh
    cmbName.Text := tblInput.FieldByName('M_CarName').AsString;
    cmbColor.Text := tblInput.FieldByName('M_Color').AsString;
    txtNumber.Text := tblInput.FieldByName('M_Number').AsString;
    cmbCity.Text := tblInput.FieldByName('M_CityName').AsString;
    txtSerial.Text := tblInput.FieldByName('M_Serial').AsString;
    txtIDate.Text := tblInput.FieldByName('M_IDate').AsString;
    txtITime.Text := tblInput.FieldByName('M_ITime').AsString;
kaveh}
//kaveh    cmbName.SetFocus;
//kaveh i
    txtNumber.SetFocus;
  end;
end;

procedure TfrmEditInput.cmdSaveClick(Sender: TObject);
var qry : TAdoQuery;
begin
//kaveh is
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('update InputCar');
  qry.SQL.Add('set M_Number = ''' + txtNumber.Text + ''', M_Serial = ''' + txtSerial.Text + ''', M_IDate = ''' + txtIDate.Text  + ''', M_ITime = ''' + txtITime.Text + '''');
  qry.SQL.Add('where M_Number = ''' + qryInput.FieldByName('M_Number').AsString + ''' and '
                  + 'M_Serial = ''' + qryInput.FieldByName('M_Serial').AsString + ''' and '
                  + 'M_IDate = ''' + qryInput.FieldByName('M_IDate').AsString + ''' and '
                  + 'M_ITime = ''' + qryInput.FieldByName('M_ITime').AsString + '''');
  qry.ExecSQL;
  qry.Close;
  qryInput.Close;
  qryInput.Open;
//kaveh ie

//  qryInput.ExecSQL;
//  qry.Open;
//  qry.Close;

//  qryInput.DataSource.DataSet.Edit;
//  qryInput.FieldByName('M_CarName').AsString := cmbName.Text;
//  qryInput.FieldByName('M_Color').AsString := cmbColor.Text;
//  qryInput.FieldByName('M_Number').AsString := txtNumber.Text;
//  qryInput.FieldByName('M_CityName').AsString := cmbCity.Text;
//  qryInput.FieldByName('M_Serial').AsString := txtSerial.Text;
//  qryInput.FieldByName('M_IDate').AsString := txtIDate.Text;
//  qryInput.FieldByName('M_ITime').AsString := txtITime.Text;
//  qryInput.Post;

//kaveh ie

{kaveh  tblInput.Edit;
  tblInput.FieldByName('M_CarName').AsString := cmbName.Text;
  tblInput.FieldByName('M_Color').AsString := cmbColor.Text;
  tblInput.FieldByName('M_Number').AsString := txtNumber.Text;
  tblInput.FieldByName('M_CityName').AsString := cmbCity.Text;
  tblInput.FieldByName('M_Serial').AsString := txtSerial.Text;
  tblInput.FieldByName('M_IDate').AsString := txtIDate.Text;
  tblInput.FieldByName('M_ITime').AsString := txtITime.Text;
  tblInput.Post;
kaveh}
  FormInEdit(False);
  dbgEdit.SetFocus;
end;

procedure TfrmEditInput.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgEdit.SetFocus;
end;


procedure TfrmEditInput.cmdCancelFilterClick(Sender: TObject);
begin
    if (cmbBarCode.ItemIndex > -1) or (txtSNumber.Text <> '') or (txtSSerial.Text <> '') or (txtSDate.Text <> '') or (txtSTime.Text <> '') then
     begin
      cmbBarCode.ItemIndex := -1;
      txtSNumber.Text := '';
      txtSSerial.Text := '';
      txtSDate.Text := '';
      txtSTime.Text := '';
      ReadData;
     end;
end;

end.

