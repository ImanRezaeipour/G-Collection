unit CoCars;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS, Keyboard, DosMove;

type
  TfrmCoCars = class(TForm)
    grpAll: TGroupBox;
    dbgCoCars: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaCoCars: TDataSource;
    tblCoCars: TAdoTable;
    tblCoCarsCo_BarCode: TStringField;
    tblCoCarsCo_CarNumber: TStringField;
    tblCoCarsCo_City: TStringField;
    tblCoCarsCo_Serial: TStringField;
    tblCoCarsCo_Name: TStringField;
    tblCoCarsCo_Color: TStringField;
    Label10: TLabel;
    Label17: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    txtSerial: TEdit;
    cmbCarColor: TComboBox;
    cmbCarCity: TComboBox;
    cmbCarName: TComboBox;
    txtCarNumber: TEdit;
    cmbBarCode: TComboBox;
    grpSearch: TGroupBox;
    rdoBarCode: TRadioButton;
    rdoSerial: TRadioButton;
    rdoNumber: TRadioButton;
    txtSearch: TEdit;
    Label3: TLabel;
    Label19: TLabel;
    txtCardID: TEdit;
    DosMove1: TDosMove;
    Label18: TLabel;
    cmbDepartment: TComboBox;
    cmbDepartmentCode: TComboBox;
    tblCoCarsCo_Depart: TIntegerField;
    chkAllDeparts: TCheckBox;
    tblCoCarsCo_AllDeparts: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgCoCarsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchChange(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarNameEnter(Sender: TObject);
    procedure cmbCarNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarColorKeyPress(Sender: TObject; var Key: Char);
    procedure txtCarNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure tblCoCarsCalcFields(DataSet: TDataSet);
    procedure dbgCoCarsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgCoCarsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgCoCarsTitleClick(Column: TColumn);
    procedure cmbDepartmentChange(Sender: TObject);
  private
    { Private declarations }
    Flag : Byte;
    SrchStr : String;

    procedure FormInEdit(vis : Boolean);
    procedure FillBarCode;
    function  AreValidFields : Boolean;
    procedure ClearFields;
    procedure SetFields;
    procedure SetWinF;
    procedure SearchData(ColumnT: TColumn; DESC: Boolean);
    
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmCoCars.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  Label3.Caption := (Label3.Caption);
  Label2.Caption := (Label2.Caption);
  Label9.Caption := (Label9.Caption);
  Label8.Caption := (Label8.Caption);
  Label1.Caption := (Label1.Caption);
  Label17.Caption := (Label17.Caption);
  Label10.Caption := (Label10.Caption);
  rdoBarCode.Caption := (rdoBarCode.Caption);
//  rdoName.Caption := (rdoName.Caption);
  rdoNumber.Caption := (rdoNumber.Caption);
//kaveh  tblCoCarsCarNumber.DisplayLabel := (tblCoCarsCarNumber.DisplayLabel);
  tblCoCarsCo_Name.DisplayLabel := (tblCoCarsCo_Name.DisplayLabel);
  tblCoCarsCo_BarCode.DisplayLabel := (tblCoCarsCo_BarCode.DisplayLabel);
end;

procedure TfrmCoCars.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;

//kaveh  if vis then
//kaveh    FillBarCode;
end;

procedure TfrmCoCars.FillBarCode;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  
  cmbBarCode.Clear;
  with qry do
  begin
    SQL.Clear;
    SQL.Add('SELECT Card_Code FROM BarCodes WHERE Card_State = ' + IntToSTR(MB_COCAR));
    SQL.Add('AND Card_Code NOT IN (SELECT Co_BarCode FROM CoCars)');
    Open;
    while not EOF do
    begin
      cmbBarCode.Items.Add(FieldByName('Card_Code').AsString);
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure TfrmCoCars.ClearFields;
begin
  cmbBarCode.Text := '';
  cmbCarName.Text := '';
  cmbCarName.ItemIndex := -1;
  cmbCarColor.Text := '';
  cmbCarColor.ItemIndex := -1;
  txtCarNumber.Text := '';
  cmbCarCity.Text := '';
  txtSerial.Text := '';
  txtCardID.Text := ''; //kaveh
  chkAllDeparts.Checked := True;
  SrchStr := '';
//kaveh  cmbBarCode.SetFocus;
  txtCarNumber.SetFocus;
  if cmbDepartment.ItemIndex = -1 then
  begin
    cmbDepartmentCode.ItemIndex := cmbDepartmentCode.Items.IndexOf(IntToStr(g_Options.Department));
    cmbDepartment.ItemIndex := cmbDepartmentCode.ItemIndex;
  end;  
end;

procedure TfrmCoCars.SetFields;
begin
//kaveh  cmbBarCode.Text := tblCoCars.FieldByName('Co_BarCode').AsString;
  txtCardID.Text := tblCoCars.FieldByName('Co_BarCode').AsString;
  cmbCarName.ItemIndex := cmbCarName.Items.IndexOf(tblCoCars.FieldByName('Co_Name').AsString);
  //kaveh tblCoCars.FieldByName('Co_Name').AsString;
  cmbCarColor.ItemIndex := cmbCarColor.Items.IndexOf(tblCoCars.FieldByName('Co_Color').AsString);
  //kaveh tblCoCars.FieldByName('Co_Color').AsString;
  txtCarNumber.Text := tblCoCars.FieldByName('Co_CarNumber').AsString;
//kaveh  cmbCarCity.Text := tblCoCars.FieldByName('Co_City').AsString;
  txtSerial.Text := tblCoCars.FieldByName('Co_Serial').AsString;

  cmbDepartmentCode.ItemIndex := cmbDepartmentCode.Items.IndexOf(tblCoCars.FieldByName('Co_Depart').AsString);
  cmbDepartment.ItemIndex := cmbDepartmentCode.ItemIndex;

  if tblCoCars.FieldByName('Co_AllDeparts').AsBoolean then
    chkAllDeparts.Checked := True
  else
    chkAllDeparts.Checked := False;

  SrchStr := '';
//  cmbBarCode.SetFocus;
  txtCarNumber.SetFocus;
end;

function TfrmCoCars.AreValidFields : Boolean;
begin
{kaveh  if cmbBarCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره كارت مشخص نشده است.');
//    cmbBarCode.SetFocus;
    txtCardID.SetFocus;
  end
  else }if txtCarNumber.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره خودرو وارد نشده است.');
    txtCarNumber.SetFocus;
  end
  else if txtSerial.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('سریال پلاک خودرو وارد نشده است.');
    txtSerial.SetFocus;
  end
{  else if cmbCarName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('نام خودرو وارد نشده است.');
    cmbCarName.SetFocus;
  end
  else if cmbCarColor.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('رنگ خودرو وارد نشده است.');
    cmbCarColor.SetFocus;
  end }
  else if IsExistsRec_Str('CoCars', 'Co_BarCode', txtCardID.Text{cmbBarCode.Text}) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblCoCars.FieldByName('Co_BarCode').AsString <> txtCardID.Text{cmbBarCode.Text}))) then
  begin
    AreValidFields := False;
    ErrorMessage('اين باركد قبلا تعريف شده است.');
    txtCardID.SetFocus;
//kaveh    cmbBarCode.SetFocus;
  end

  else if IsExistsTwoRec_Str('CoCars', 'Co_CarNumber', 'Co_Serial', txtCarNumber.Text, txtSerial.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and ((tblCoCars.FieldByName('Co_CarNumber').AsString <> txtCarNumber.Text)OR(tblCoCars.FieldByName('Co_Serial').AsString <> txtSerial.Text) ))) then
  begin
    AreValidFields := False;
    ErrorMessage('شماره و سریال خودرو تكراري است.');
    txtCarNumber.SetFocus;
  end

  else if IsExistsTwoRec_Str('NewPersons', 'P_CarNumber', 'P_CarSerial', txtCarNumber.Text, txtSerial.Text) then {and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and ((tblNewPersons.FieldByName('P_CarNumber').AsString <> txtCarNumber.Text)OR(tblNewPersons.FieldByName('P_CarSerial').AsString <> txtSerial.Text) ))) then}
  begin
    AreValidFields := False;
    ErrorMessage('شماره و سریال خودرو در قسمت معرفی پرسنل استفاده شده است.');
    txtCarNumber.SetFocus;
  end

  else
    AreValidFields := True;
end;


procedure TfrmCoCars.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtSearch.Handle);
  SetDirectionFarsi(txtCarNumber.Handle);
  SetDirectionFarsi(txtSerial.Handle);
  SetDirectionFarsi(cmbCarName.Handle);
  SetDirectionFarsi(cmbCarColor.Handle);
  SetDirectionFarsi(cmbCarCity.Handle);

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cars ORDER BY Car_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarName.Items.Add(qry.FieldByName('Car_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Colors ORDER BY Clr_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarColor.Items.Add(qry.FieldByName('Clr_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Department ORDER BY Depart_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDepartment.Items.Add(qry.FieldByName('Depart_Name').AsString);
    cmbDepartmentCode.Items.Add(qry.FieldByName('Depart_Code').AsString);
    qry.Next;
  end;
  qry.Close;
  
{kaveh
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarCity.Items.Add(qry.FieldByName('City_Name').AsString);
    qry.Next;
  end;
  qry.Close;
}

  qry.Free;

  tblCoCars.connection := frmDBS.adoConnect;
  tblCoCars.Open;
end;

procedure TfrmCoCars.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmCoCars.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblCoCars.Close;
end;

procedure TfrmCoCars.tblCoCarsCalcFields(DataSet: TDataSet);
begin
//kaveh  DataSet.FieldByName('CarNumber').AsString := ConvertToFarsi(DataSet.FieldByName('Co_CarNumber').AsString);
end;

procedure TfrmCoCars.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    dbgCoCars.SetFocus;
  end
  else if rdoNumber.Checked then
  begin
    txtSearch.MaxLength := 6;
    txtSearch.Text := Key_CarNumber(txtSearch.Text, Key, txtSearch.SelLength);
    Key := #0;
  end
  else if rdoSerial.Checked then
  begin
    txtSearch.MaxLength := 2;
    Keyboard_Integer(Key);
//    txtSearch.Text := Key_CarNumber(txtSearch.Text, Key, txtSearch.SelLength);
  end
  else if rdoBarCode.Checked then
  begin
    txtSearch.MaxLength := 8;
  end;  

end;

procedure TfrmCoCars.txtSearchChange(Sender: TObject);
begin
  tblCoCars.Filtered := False;
  if txtSearch.Text = '' then
    tblCoCars.Filter := ''
  else if rdoNumber.Checked then
    tblCoCars.Filter := 'Co_CarNumber LIKE ''' + txtSearch.Text + '%'''
  else if rdoSerial.Checked then
    tblCoCars.Filter := 'Co_Serial LIKE ''' + txtSearch.Text + '%'''
  else if rdoBarCode.Checked then
    tblCoCars.Filter := 'Co_BarCode LIKE ''' + txtSearch.Text + '%''';

  tblCoCars.Filtered := True;
end;

procedure TfrmCoCars.dbgCoCarsDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  iValue:Byte;
begin
    iValue :=dbgCoCars.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgCoCars.canvas.brush.color :=ClBlue;
      dbgCoCars.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgCoCars.Canvas.Brush.Color := $00D1D9DC;
      0: dbgCoCars.Canvas.Brush.Color := clWhite;
    end;
    dbgCoCars.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCoCars.dbgCoCarsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmCoCars.dbgCoCarsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const selectedTitelColor = clWindow;
var
  pt: TGridcoord;
  x2 : Integer;
  function clbtncol():Boolean;
  begin
//    TDBGrid(dbgCoCars).Columns[5].Title.Color := clBtnFace;
    TDBGrid(dbgCoCars).Columns[4].Title.Color := clBtnFace;
    TDBGrid(dbgCoCars).Columns[3].Title.Color := clBtnFace;
    TDBGrid(dbgCoCars).Columns[2].Title.Color := clBtnFace;
    TDBGrid(dbgCoCars).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgCoCars).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgCoCars.MouseCoord(x, y);
  x2 := x - 30;
  if pt.y=0 then
   begin
//    dbgEdit.Cursor:=crHandPoint;
{    if (x2 > 0) and (x2 < TDBGrid(dbgCoCars).Columns[5].Width) then
     begin
       clbtncol();
       TDBGrid(dbgCoCars).Columns[5].Title.Color := selectedTitelColor;
     end
    else} if (x2 > 0{TDBGrid(dbgCoCars).Columns[5].Width}) and (x2 < {TDBGrid(dbgCoCars).Columns[5].Width +} TDBGrid(dbgCoCars).Columns[4].Width) then
     begin
       clbtncol();
       TDBGrid(dbgCoCars).Columns[4].Title.Color := selectedTitelColor;
     end

    else if (x2 > TDBGrid(dbgCoCars).Columns[4].Width) and (x2 < {TDBGrid(dbgCoCars).Columns[5].Width +} TDBGrid(dbgCoCars).Columns[4].Width + TDBGrid(dbgCoCars).Columns[3].Width) then
     begin
       clbtncol();
       TDBGrid(dbgCoCars).Columns[3].Title.Color := selectedTitelColor;
    end

    else if (x2 > TDBGrid(dbgCoCars).Columns[3].Width) and (x2 < {TDBGrid(dbgCoCars).Columns[5].Width +} TDBGrid(dbgCoCars).Columns[4].Width + TDBGrid(dbgCoCars).Columns[3].Width + TDBGrid(dbgCoCars).Columns[2].Width) then
     begin
       clbtncol();
       TDBGrid(dbgCoCars).Columns[2].Title.Color := selectedTitelColor;
     end
    else if (x2 > TDBGrid(dbgCoCars).Columns[2].Width) and (x2 < {TDBGrid(dbgCoCars).Columns[5].Width +} TDBGrid(dbgCoCars).Columns[4].Width + TDBGrid(dbgCoCars).Columns[3].Width + TDBGrid(dbgCoCars).Columns[2].Width + TDBGrid(dbgCoCars).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgCoCars).Columns[1].Title.Color := selectedTitelColor;
     end
    else if (x2 > TDBGrid(dbgCoCars).Columns[1].Width) and (x2 < {TDBGrid(dbgCoCars).Columns[5].Width +} TDBGrid(dbgCoCars).Columns[4].Width + TDBGrid(dbgCoCars).Columns[3].Width + TDBGrid(dbgCoCars).Columns[2].Width + TDBGrid(dbgCoCars).Columns[1].Width + TDBGrid(dbgCoCars).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgCoCars).Columns[0].Title.Color := selectedTitelColor;
     end;
   end
  else
   begin
    dbgCoCars.Cursor:=crDefault;
    clbtncol();
   end;
end;

procedure TfrmCoCars.dbgCoCarsTitleClick(Column: TColumn);
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

procedure TfrmCoCars.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearFields;
end;

procedure TfrmCoCars.cmdEditClick(Sender: TObject);
begin
  if not tblCoCars.EOF then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetFields;
  end;
end;

procedure TfrmCoCars.cmdDeleteClick(Sender: TObject);
begin
  if not tblCoCars.EOF then
  begin
    if not InCircleCoCar(tblCoCars.FieldByName('Co_CarNumber').AsString,tblCoCars.FieldByName('Co_Serial').AsString) then
//kaveh    if not IsExistsRec_Str('InOutCo', 'IO_BarCode', tblCoCars.FieldByName('Co_BarCode').AsString) then
    begin
      if ConfirmMessage('آيا براي حذف خودروی سازمانی اطمينان داريد؟') then
      begin
        tblCoCars.Delete;
//kaveh        tblCoCars.Refresh;
      end;
    end
    else
      InformationMessage('اين خودروی سازمانی ‏در گردش بوده و حذف آن امكان پذير نيست.');
  end;
end;

procedure TfrmCoCars.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmbCarName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCoCars.cmbCarNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmCoCars.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
//    cmbCarColor.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmCoCars.cmbDepartmentChange(Sender: TObject);
begin
  cmbDepartmentCode.ItemIndex := cmbDepartment.ItemIndex;
end;

procedure TfrmCoCars.cmbCarColorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
//    txtCarNumber.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCarColor, Key);
end;

procedure TfrmCoCars.txtCarNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0
//    cmbCarCity.SetFocus
  else
    txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);

  Key := #0;
end;

procedure TfrmCoCars.cmbCarCityKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  fnd : Boolean;
begin
  fnd := False;
  if Key = #8 then
    Delete(SrchStr, Length(SrchStr), 1)
  else if Key = #27 then
    SrchStr := ''
  else if Key <> #13 then
    SrchStr := SrchStr + Key
  else
  begin
//    txtSerial.SetFocus;
    Key := #0;
    Exit;
  end;

  Key := #0;

  for i := 0 to cmbCarCity.Items.Count do
  begin
    if Pos(SrchStr, Copy(cmbCarCity.Items.Strings[i], 1, Length(SrchStr))) <> 0 then
    begin
      cmbCarCity.ItemIndex := i;
      fnd := True;
      break;
    end;
  end;

  if not fnd then
    cmbCarCity.Text := SrchStr;
end;

procedure TfrmCoCars.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmdSave.SetFocus;
  end;
  Keyboard_Integer(Key);  
end;

procedure TfrmCoCars.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblCoCars.Append
    else if Flag = MB_EDIT then
      tblCoCars.Edit;

    tblCoCars.FieldByName('Co_BarCode').AsString := txtCardID.Text; //kaveh cmbBarCode.Text;
    tblCoCars.FieldByName('Co_CarNumber').AsString := txtCarNumber.Text;
//kaveh    tblCoCars.FieldByName('Co_City').AsString := cmbCarCity.Text;
    tblCoCars.FieldByName('Co_Serial').AsString := txtSerial.Text;
    tblCoCars.FieldByName('Co_Name').AsString := cmbCarName.Text;
    tblCoCars.FieldByName('Co_Color').AsString := cmbCarColor.Text;
    if cmbDepartmentCode.Text <> '' then
      tblCoCars.FieldByName('Co_Depart').AsInteger := StrToInt(cmbDepartmentCode.Text);

    if chkAllDeparts.Checked then
      tblCoCars.FieldByName('Co_AllDeparts').AsBoolean := True
    else
      tblCoCars.FieldByName('Co_AllDeparts').AsBoolean := False;

    tblCoCars.Post;


    if Flag = MB_NEW then
    begin
      ClearFields;
//kaveh      FillBarCode;
//kaveh      cmbBarCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgCoCars.SetFocus;
    end;
  end;
end;

procedure TfrmCoCars.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCoCars.SetFocus;
end;

procedure TfrmCoCars.SearchData(ColumnT: TColumn; DESC: Boolean);
begin
  with tblCoCars do//qryInput do
  begin
//    if Active then
//      Close;
    //SQL.Clear;
    //SQL.Add('SELECT M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_IsPark FROM InputCar');
    if DESC then
      Sort := ColumnT.FieldName  + ' DESC'
//      SQL.Add('ORDER BY ' + ColumnT.FieldName + ' desc')
    else
      Sort := ColumnT.FieldName + ' ASC';
//      SQL.Add('ORDER BY ' + ColumnT.FieldName);
//    Open;
  end;
end;


end.
