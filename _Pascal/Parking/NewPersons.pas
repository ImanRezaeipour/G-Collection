unit NewPersons;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, DBCtrls, Globals,
  FarsiApi, MSGs, Keyboard, DBS, DateProc, ExtCtrls, DosMove;

type
  TfrmNewPersons = class(TForm)
    grpAll: TGroupBox;
    dbgNewPersons: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    txtPCode: TEdit;
    txtFamily: TEdit;
    Label2: TLabel;
    txtCarNumber: TEdit;
    Label3: TLabel;
    txtName: TEdit;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaNewPersons: TDataSource;
    txtSerial: TEdit;
    Label8: TLabel;
    Label5: TLabel;
    txtDate: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    txtPrice: TEdit;
    Label17: TLabel;
    cmbCarName: TComboBox;
    cmbCarColor: TComboBox;
    cmbCarCity: TComboBox;
    cmdTamdid: TBitBtn;
    grpTamdid: TGroupBox;
    cmdTamdidSave: TBitBtn;
    cmdTamdidExit: TBitBtn;
    Label6: TLabel;
    Label7: TLabel;
    pnlCode: TPanel;
    pnlName: TPanel;
    dbgTamdid: TDBGrid;
    Label13: TLabel;
    txtTamdidDate: TEdit;
    Label14: TLabel;
    txtTamdidPrice: TEdit;
    Label15: TLabel;
    cmdTamdidDel: TBitBtn;
    tblTamdid: TAdoTable;
    dtaTamdid: TDataSource;
    tblTamdidPay_CustCode: TSmallintField;
    tblTamdidPay_Date: TStringField;
    tblTamdidPay_Price: TCurrencyField;
    tblTamdidPay_IsPay: TBooleanField;
    cmdEndCust: TBitBtn;
    tblNewPersons: TADOTable;
    tblNewPersonsP_Code: TWideStringField;
    tblNewPersonsP_Name: TWideStringField;
    tblNewPersonsP_Family: TWideStringField;
    tblNewPersonsP_Tel: TWideStringField;
    tblNewPersonsP_CarNumber: TWideStringField;
    tblNewPersonsP_CarSerial: TWideStringField;
    tblNewPersonsP_CarColor: TSmallintField;
    tblNewPersonsP_CarName: TSmallintField;
    tblNewPersonsP_Date: TWideStringField;
    tblNewPersonsP_Remain: TFloatField;
    tblNewPersonsP_Valid: TBooleanField;
    tblNewPersonsP_Depart: TIntegerField;
    tblNewPersonsP_IsCustomer: TBooleanField;
    DosMove1: TDosMove;
    Label16: TLabel;
    txtTel: TEdit;
    chkIsCustomer: TCheckBox;
    cmbCarNameCode: TComboBox;
    cmbCarColorCode: TComboBox;
    Label18: TLabel;
    cmbDepartment: TComboBox;
    cmbDepartmentCode: TComboBox;
    Label19: TLabel;
    txtCardID: TEdit;
    tblNewPersonsP_CardID: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtPCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtPriceKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgNewPersonsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure txtDateExit(Sender: TObject);
    procedure cmbCarNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarNameEnter(Sender: TObject);
    procedure cmbCarColorKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarColorEnter(Sender: TObject);
    procedure cmbCarCityEnter(Sender: TObject);
    procedure cmbCarCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtCarNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmdTamdidClick(Sender: TObject);
    procedure cmdTamdidSaveClick(Sender: TObject);
    procedure cmdTamdidExitClick(Sender: TObject);
    procedure txtTamdidDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTamdidDateExit(Sender: TObject);
    procedure txtTamdidPriceKeyPress(Sender: TObject; var Key: Char);
    procedure dbgTamdidKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdTamdidDelClick(Sender: TObject);
    procedure cmdEndCustClick(Sender: TObject);
    procedure cmbCarNameChange(Sender: TObject);
    procedure cmbCarColorChange(Sender: TObject);
    procedure cmbDepartmentChange(Sender: TObject);
    procedure cmbDepartmentEnter(Sender: TObject);
    procedure cmbDepartmentKeyPress(Sender: TObject; var Key: Char);
    procedure chkIsCustomerClick(Sender: TObject);
    procedure dbgNewPersonsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgNewPersonsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgNewPersonsTitleClick(Column: TColumn);
    procedure cmbCarNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbCarColorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Flag : Byte;
    SrchStr : String;
    BefPrc : Currency;


    procedure SearchData(ColumnT: TColumn; DESC: Boolean);
    procedure FormInEdit(vis : Boolean);
    procedure FormInTamdid(vis : Boolean);
    procedure ClearScrFields;
    function  GetFirstPrice(CustCode : Integer) : Currency;
    function  AreValidFields : Boolean;
    procedure ActionPayCust(CustCode : Integer; BefDate, NewDate : String; Price : Currency;
                            IsPay : Boolean; ActionType : Byte);
    procedure SetWinF;
                            
  public
    { Public declarations }
  end;




implementation

{$R *.DFM}

procedure TfrmNewPersons.SetWinF;
begin
{  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdTamdid.Caption := (cmdTamdid.Caption);
  cmdEndCust.Caption := (cmdEndCust.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
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
  Label17.Caption := (Label17.Caption);
  cmdTamdidDel.Caption := (cmdTamdidDel.Caption);
  cmdTamdidExit.Caption := (cmdTamdidExit.Caption);
  cmdTamdidSave.Caption := (cmdTamdidSave.Caption);
  tblCustomsCust_Code.DisplayLabel := (tblCustomsCust_Code.DisplayLabel);
  tblCustomsCust_Name.DisplayLabel := (tblCustomsCust_Name.DisplayLabel);
  tblCustomsCust_Remain.DisplayLabel := (tblCustomsCust_Remain.DisplayLabel);
  tblTamdidPay_Date.DisplayLabel := (tblTamdidPay_Date.DisplayLabel);
  tblTamdidPay_Price.DisplayLabel := (tblTamdidPay_Price.DisplayLabel);}
end;

procedure TfrmNewPersons.FormInEdit(vis : Boolean);
begin
  grpAll.Visible := not vis;
  grpEdit.Visible := vis;
  grpTamdid.Visible := False;
  if vis then
    Height := grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

procedure TfrmNewPersons.FormInTamdid(vis : Boolean);
begin
  grpAll.Visible := not vis;
  grpTamdid.Visible := vis;
  grpEdit.Visible := False;
  if vis then
    Height := grpTamdid.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;

  if vis then
  begin
    pnlCode.Caption := tblNewPersons.FieldByName('Cust_Code').AsString;
    pnlName.Caption := tblNewPersons.FieldByName('Cust_Name').AsString;
    tblTamdid.Filtered := False;
    tblTamdid.Filter := 'Pay_CustCode = ' + pnlCode.Caption +
                        ' AND Pay_Date <> ''' + tblNewPersons.FieldByName('Cust_Date').AsString + '''' +
                        ' AND Pay_IsPay = ' + IntToStr(CNST_TRUE);
    tblTamdid.Filtered := True;
  end;
  tblTamdid.Active := vis;
end;

procedure TfrmNewPersons.ClearScrFields;
begin
  txtPCode.Text := '';
  txtFamily.Text := '';
  txtName.Text := '';
  txtCarNumber.Text := '';
  txtSerial.Text := '';
  txtTel.Text := '';
  cmbCarName.Text := '';
  cmbCarName.ItemIndex := -1; //kaveh
  cmbCarNameCode.ItemIndex := -1;
  cmbCarCity.Text := '';
  cmbCarCity.ItemIndex := -1; //kaveh
  cmbCarColor.Text := '';
  cmbCarColor.ItemIndex := -1; //kaveh
  txtCardID.Text := ''; //kaveh
  cmbCarColorCode.ItemIndex := -1;
  if cmbDepartment.ItemIndex = -1 then
  begin
    cmbDepartmentCode.ItemIndex := cmbDepartmentCode.Items.IndexOf(IntToStr(g_Options.Department));
    cmbDepartment.ItemIndex := cmbDepartmentCode.ItemIndex;
  end;
  chkIsCustomer.Checked := False;
  txtDate.Text := CurrentDate;
  Label5.Enabled := False;
  txtDate.Enabled := False;
  txtPrice.Text := '';
  Label11.Enabled := False;
  txtPrice.Enabled := False;
  Label12.Enabled := False;
  SrchStr := '';
end;

function TfrmNewPersons.GetFirstPrice(CustCode : Integer) : Currency;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Pay_Price, Pay_Date FROM PayCust');
  qry.SQL.Add('WHERE Pay_CustCode = ' + IntToStr(CustCode));
  qry.SQL.Add('ORDER BY Pay_Date');
  qry.Open;
  GetFirstPrice := qry.FieldByName('Pay_Price').AsCurrency;
  qry.Close;
  qry.Free;
end;

function TfrmNewPersons.AreValidFields : Boolean;
begin
  if txtPCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('كد پرسنلی وارد نشده است.');
    txtPCode.SetFocus;
  end
  else if txtFamily.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('نام خانوادگی وارد نشده است.');
    txtFamily.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('نام وارد نشده است.');
    txtName.SetFocus;
  end
{  else if cmbCarName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('نام خودرو وارد نشده است.');
    cmbCarName.SetFocus;
  end }
{  else if cmbCarColor.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('رنگ خودرو وارد نشده است.');
    cmbCarColor.SetFocus;
  end  }
{  else if txtCarNumber.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره خودرو وارد نشده است.');
    txtCarNumber.SetFocus;
  end }
{  else if cmbCarCity.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شهر خودرو وارد نشده است.');
    cmbCarCity.SetFocus;
  end  }
{  else if txtDate.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ اشتراك وارد نشده است.');
    txtDate.SetFocus;
  end  }
{  else if txtPrice.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('مبلغ اشتراك وارد نشده است.');
    txtPrice.SetFocus;
  end  }
  else if IsExistsRec_Num('NewPersons', 'P_Code', StrToInt(txtPCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblNewPersons.FieldByName('P_Code').AsString <> txtPCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('كد پرسنلی تكراري است.');
    txtPCode.SetFocus;
  end

{  else if IsExistsRec_Str('NewPersons', 'P_CarNumber', txtCarNumber.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblNewPersons.FieldByName('P_CarNumber').AsString <> txtCarNumber.Text))) then
  begin
    if IsExistsRec_Str('NewPersons', 'P_CarSerial', txtSerial.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblNewPersons.FieldByName('P_CarSerial').AsString <> txtSerial.Text))) then
    begin
      AreValidFields := False;
      ErrorMessage('شماره و سریال خودرو تكراري است.');
      txtCarNumber.SetFocus;
    end;
  end  }

  else if IsExistsTwoRec_Str('NewPersons', 'P_CarNumber', 'P_CarSerial', txtCarNumber.Text, txtSerial.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and ((tblNewPersons.FieldByName('P_CarNumber').AsString <> txtCarNumber.Text)OR(tblNewPersons.FieldByName('P_CarSerial').AsString <> txtSerial.Text) ))) then
  begin
    AreValidFields := False;
    ErrorMessage('شماره و سریال خودرو تكراري است.');
    txtCarNumber.SetFocus;
  end

  else if IsExistsTwoRec_Str('CoCars', 'Co_CarNumber', 'Co_Serial', txtCarNumber.Text, txtSerial.Text) then {and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and ((tblCoCars.FieldByName('Co_CarNumber').AsString <> txtCarNumber.Text)OR(tblCoCars.FieldByName('Co_Serial').AsString <> txtSerial.Text) ))) then}
  begin
    AreValidFields := False;
    ErrorMessage('شماره و سریال خودرو در قسمت معرفی خودروهای سازمانی استفاده شده است.');
    txtCarNumber.SetFocus;
  end
    
//IsExistsRec_Str
  else
    AreValidFields := True;
end;

procedure TfrmNewPersons.chkIsCustomerClick(Sender: TObject);
begin
  if chkIsCustomer.Checked then
  begin
      Label5.Enabled := True;
      txtDate.Enabled := True;
  end
  else
  begin
      Label5.Enabled := False;
      txtDate.Enabled := False;
  end;
end;

procedure TfrmNewPersons.ActionPayCust(CustCode : Integer; BefDate, NewDate : String;
                                    Price : Currency; IsPay : Boolean; ActionType : Byte);
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  case ActionType of
    MB_NEW:
    begin
      qry.SQL.Add('INSERT INTO PayCust (Pay_CustCode, Pay_Date, Pay_Price, Pay_IsPay)');
      qry.SQL.Add('VALUES(' + IntToStr(CustCode) + ', ''' + NewDate + '''');
      qry.SQL.Add(', ' + FloatToStr(Price));
      if IsPay then
        qry.SQL.Add(', ' + IntToStr(CNST_TRUE) + ' )')
      else
        qry.SQL.Add(', ' + IntToStr(CNST_FALSE) + ')');
      qry.ExecSQL;
    end;

    MB_EDIT:
    begin
      qry.SQL.Add('UPDATE PayCust SET Pay_Date = ''' + NewDate + '''');
      qry.SQL.Add(', Pay_Price = ' + FloatToStr(Price));
      qry.SQL.Add('WHERE Pay_CustCode = ' + IntToStr(CustCode));
      qry.SQL.Add('AND Pay_Date = ''' + BefDate + '''');
      qry.ExecSQL;
    end;

    MB_DELETE:
    begin
      qry.SQL.Add('DELETE FROM PayCust WHERE Pay_CustCode = ' + IntToStr(CustCode));
      qry.SQL.Add('AND Pay_Date = ''' + NewDate + '''');
      qry.ExecSQL;
    end;
  end;
  qry.Free;
end;

procedure TfrmNewPersons.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  SetDirectionFarsi(txtCarNumber.Handle);
  SetDirectionFarsi(txtSerial.Handle);
  SetDirectionFarsi(cmbCarName.Handle);
  SetDirectionFarsi(cmbCarColor.Handle);
  SetDirectionFarsi(cmbCarCity.Handle);
  tblNewPersons.connection := frmDBS.adoConnect;
  tblTamdid.connection := frmDBS.adoConnect;
  FormInEdit(False);
  Top := 80;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cars ORDER BY Car_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarName.Items.Add(qry.FieldByName('Car_Name').AsString);
    cmbCarNameCode.Items.Add(qry.FieldByName('Car_Code').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Colors ORDER BY Clr_Name');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarColor.Items.Add(qry.FieldByName('Clr_Name').AsString);
    cmbCarColorCode.Items.Add(qry.FieldByName('Clr_Code').AsString);
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

{  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarCity.Items.Add(qry.FieldByName('City_Name').AsString);
    qry.Next;
  end;
  qry.Close;}

  qry.Free;

  tblNewPersons.Filtered := False;
  tblNewPersons.Filter := 'P_Valid = ' + IntToStr(CNST_TRUE);
  tblNewPersons.Filtered := True;
  tblNewPersons.Open;
  tblNewPersons.Sort := 'P_Family ASC, P_Name ASC, P_CarNumber ASC';

end;

procedure TfrmNewPersons.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblNewPersons.Close;
end;

procedure TfrmNewPersons.dbgNewPersonsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  iValue:Byte;
begin
    iValue :=dbgNewPersons.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgNewPersons.canvas.brush.color :=ClBlue;
      dbgNewPersons.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgNewPersons.Canvas.Brush.Color := $00D1D9DC;
      0: dbgNewPersons.Canvas.Brush.Color := clWhite;
    end;
    dbgNewPersons.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmNewPersons.dbgNewPersonsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmNewPersons.dbgNewPersonsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
const selectedTitelColor = clWindow;
var
  pt: TGridcoord;
  x2 : Integer;
  function clbtncol():Boolean;
  begin
    TDBGrid(dbgNewPersons).Columns[5].Title.Color := clBtnFace;
    TDBGrid(dbgNewPersons).Columns[4].Title.Color := clBtnFace;
    TDBGrid(dbgNewPersons).Columns[3].Title.Color := clBtnFace;
    TDBGrid(dbgNewPersons).Columns[2].Title.Color := clBtnFace;
    TDBGrid(dbgNewPersons).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgNewPersons).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgNewPersons.MouseCoord(x, y);
  x2 := x - 10;
  if pt.y=0 then
   begin
//    dbgEdit.Cursor:=crHandPoint;
    if (x2 > 0) and (x2 < TDBGrid(dbgNewPersons).Columns[5].Width) then
     begin
       clbtncol();
       TDBGrid(dbgNewPersons).Columns[5].Title.Color := selectedTitelColor;
     end
    else if (x2 > TDBGrid(dbgNewPersons).Columns[5].Width) and (x2 < TDBGrid(dbgNewPersons).Columns[5].Width + TDBGrid(dbgNewPersons).Columns[4].Width) then
     begin
       clbtncol();
       TDBGrid(dbgNewPersons).Columns[4].Title.Color := selectedTitelColor;
     end

    else if (x2 > TDBGrid(dbgNewPersons).Columns[4].Width) and (x2 < TDBGrid(dbgNewPersons).Columns[5].Width + TDBGrid(dbgNewPersons).Columns[4].Width + TDBGrid(dbgNewPersons).Columns[3].Width) then
     begin
       clbtncol();
       TDBGrid(dbgNewPersons).Columns[3].Title.Color := selectedTitelColor;
    end

    else if (x2 > TDBGrid(dbgNewPersons).Columns[3].Width) and (x2 < TDBGrid(dbgNewPersons).Columns[5].Width + TDBGrid(dbgNewPersons).Columns[4].Width + TDBGrid(dbgNewPersons).Columns[3].Width + TDBGrid(dbgNewPersons).Columns[2].Width) then
     begin
       clbtncol();
       TDBGrid(dbgNewPersons).Columns[2].Title.Color := selectedTitelColor;
     end
    else if (x2 > TDBGrid(dbgNewPersons).Columns[2].Width) and (x2 < TDBGrid(dbgNewPersons).Columns[5].Width + TDBGrid(dbgNewPersons).Columns[4].Width + TDBGrid(dbgNewPersons).Columns[3].Width + TDBGrid(dbgNewPersons).Columns[2].Width + TDBGrid(dbgNewPersons).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgNewPersons).Columns[1].Title.Color := selectedTitelColor;
     end
    else if (x2 > TDBGrid(dbgNewPersons).Columns[1].Width) and (x2 < TDBGrid(dbgNewPersons).Columns[5].Width + TDBGrid(dbgNewPersons).Columns[4].Width + TDBGrid(dbgNewPersons).Columns[3].Width + TDBGrid(dbgNewPersons).Columns[2].Width + TDBGrid(dbgNewPersons).Columns[1].Width + TDBGrid(dbgNewPersons).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgNewPersons).Columns[0].Title.Color := selectedTitelColor;
     end;
   end
  else
   begin
    dbgNewPersons.Cursor:=crDefault;
    clbtncol();
   end;
end;

procedure TfrmNewPersons.dbgNewPersonsTitleClick(Column: TColumn);
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

procedure TfrmNewPersons.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  BefPrc := 0;
  Flag := MB_NEW;
  ClearScrFields;
  txtPCode.Text := IntToStr(GetNewNumber('NewPersons', 'P_Code'));
  txtPCode.SetFocus;
end;

procedure TfrmNewPersons.cmdEditClick(Sender: TObject);
begin
  if tblNewPersons.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtPCode.Text := IntToStr(tblNewPersons.FieldByName('P_Code').AsInteger);
    txtFamily.Text := tblNewPersons.FieldByName('P_Family').AsString; 
    txtName.Text := tblNewPersons.FieldByName('P_Name').AsString;
    txtCarNumber.Text := tblNewPersons.FieldByName('P_CarNumber').AsString;
    txtSerial.Text := tblNewPersons.FieldByName('P_CarSerial').AsString;
    txtCardID.Text := tblNewPersons.FieldByName('P_CardID').AsString;
    txtTel.Text := tblNewPersons.FieldByName('P_Tel').AsString;
    cmbCarNameCode.ItemIndex := cmbCarNameCode.Items.IndexOf(tblNewPersons.FieldByName('P_CarName').AsString);
    cmbCarName.ItemIndex := cmbCarNameCode.ItemIndex;
    cmbCarColorCode.ItemIndex := cmbCarColorCode.Items.IndexOf(tblNewPersons.FieldByName('P_CarColor').AsString);
    cmbCarColor.ItemIndex := cmbCarColorCode.ItemIndex;
    cmbDepartmentCode.ItemIndex := cmbDepartmentCode.Items.IndexOf(tblNewPersons.FieldByName('P_Depart').AsString);
    cmbDepartment.ItemIndex := cmbDepartmentCode.ItemIndex;
//    cmbCarCity.Text := tblNewPersons.FieldByName('Cust_CarCity').AsString;
    if tblNewPersons.FieldByName('P_IsCustomer').AsBoolean then
    begin
      chkIsCustomer.Checked := True;
      Label5.Enabled := True;
      txtDate.Enabled := True;
      txtDate.Text := tblNewPersons.FieldByName('P_Date').AsString;
      BefPrc := GetFirstPrice(tblNewPersons.FieldByName('P_Remain').AsInteger);
      txtPrice.Text := FloatToStr(BefPrc);
    end
    else
    begin
      chkIsCustomer.Checked := False;
      Label5.Enabled := False;
      txtDate.Enabled := False;
    end;
    txtPCode.SetFocus;
  end;
end;

procedure TfrmNewPersons.cmdDeleteClick(Sender: TObject);
begin
  if tblNewPersons.RecordCount > 0 then
  begin
    if not InCircleNewPersons(tblNewPersons.FieldByName('P_Code').AsInteger) then
    begin
      if ConfirmMessage('آيا براي حذف پرسنل اطمينان داريد؟') then
      begin
        //ActionPayCust(tblNewPersons.FieldByName('P_Code').AsInteger, '', tblNewPersons.FieldByName('P_Date').AsString, 0.0, True, MB_DELETE);
        tblNewPersons.Delete;
      end;
    end
    else
      InformationMessage('اين پرسنل در گردش بوده و حذف آن امكان پذير نيست.');
  end;
end;

procedure TfrmNewPersons.cmdTamdidClick(Sender: TObject);
begin
  if tblNewPersons.RecordCount > 0 then
  begin
    FormInTamdid(True);
    txtTamdidDate.Text := CurrentDate;
    txtTamdidPrice.Text := '';
    txtTamdidDate.SetFocus;
  end;
end;

procedure TfrmNewPersons.cmdEndCustClick(Sender: TObject);
begin
  if (tblNewPersons.RecordCount > 0) and
      ConfirmMessage('آيا مي‌خواهيد با مشترك مورد نظر تسويه حساب نماييد؟') then
  begin
    tblTamdid.Open;
    tblTamdid.Append;
    tblTamdid.FieldByName('Pay_CustCode').AsInteger := tblNewPersons.FieldByName('Cust_Code').AsInteger;
    tblTamdid.FieldByName('Pay_Date').AsString := CurrentDate;
    tblTamdid.FieldByName('Pay_Price').AsCurrency := tblNewPersons.FieldByName('Cust_Remain').AsCurrency;
    tblTamdid.FieldByName('Pay_IsPay').AsBoolean := False;
    tblTamdid.Post;
    tblTamdid.Close;

    tblNewPersons.Edit;
    tblNewPersons.FieldByName('Cust_Remain').AsCurrency := 0;
    tblNewPersons.FieldByName('Cust_Valid').AsBoolean := False;
    tblNewPersons.Post;
  end;
end;

procedure TfrmNewPersons.txtPCodeKeyPress(Sender: TObject; var Key: Char);
begin
{  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else }
  Keyboard_Integer(Key);
end;

procedure TfrmNewPersons.txtFamilyKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtTel.SetFocus;
  end;
end;

procedure TfrmNewPersons.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmbCarName.SetFocus;
  end;
end;

procedure TfrmNewPersons.cmbCarNameChange(Sender: TObject);
begin
  cmbCarNameCode.ItemIndex := cmbCarName.ItemIndex;
end;

procedure TfrmNewPersons.cmbCarNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmNewPersons.cmbCarNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Shift = []) then
    begin
      cmbCarNameCode.ItemIndex := -1;
      cmbCarName.ItemIndex := -1;
    end;
end;

procedure TfrmNewPersons.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
//    cmbCarColor.SetFocus;
    Key := #0;
  end
  else
//    SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmNewPersons.cmbDepartmentChange(Sender: TObject);
begin
  cmbDepartmentCode.ItemIndex := cmbDepartment.ItemIndex;
end;

procedure TfrmNewPersons.cmbDepartmentEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmNewPersons.cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Shift = []) then
    begin
      cmbDepartment.ItemIndex := -1;
      cmbDepartmentCode.ItemIndex := -1;
    end;
end;

procedure TfrmNewPersons.cmbDepartmentKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
//    txtCarNumber.SetFocus;
    Key := #0;
  end
  else
//    SrchNearst(SrchStr, cmbCarColor, Key);
end;

procedure TfrmNewPersons.cmbCarColorChange(Sender: TObject);
begin
  cmbCarColorCode.ItemIndex := cmbCarColor.ItemIndex;
end;

procedure TfrmNewPersons.cmbCarColorEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmNewPersons.cmbCarColorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Shift = []) then
    begin
      cmbCarColorCode.ItemIndex := -1;
      cmbCarColor.ItemIndex := -1;
    end;
end;

procedure TfrmNewPersons.cmbCarColorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
//    txtCarNumber.SetFocus;
    Key := #0;
  end
  else
//    SrchNearst(SrchStr, cmbCarColor, Key);

end;

procedure TfrmNewPersons.txtCarNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);
{  if Key = #13 then
    cmbCarCity.SetFocus
  else
    txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);
}
  Key := #0;
end;

procedure TfrmNewPersons.cmbCarCityEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmNewPersons.cmbCarCityKeyPress(Sender: TObject; var Key: Char);
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
    txtSerial.SetFocus;
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

procedure TfrmNewPersons.txtSerialKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtDate.SetFocus;
  end;
  Keyboard_Integer(Key);
end;

procedure TfrmNewPersons.txtDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    txtPrice.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmNewPersons.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmNewPersons.txtPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
//    cmdSave.SetFocus;
  end
  else
    Keyboard_Number(Key, txtPrice.Text);
end;

procedure TfrmNewPersons.cmdSaveClick(Sender: TObject);
var
  qry : TAdoQuery;
  knd : Byte;
begin
  if AreValidFields then
  begin

    if Flag = MB_NEW then
    begin
      {qry := TAdoQuery.Create(Application);
      with qry do
      begin
        connection := frmDBS.adoConnect;
        SQL.Clear;
        SQL.Add('SELECT M_Kind FROM Machines ');
        SQL.Add('WHERE M_Number = ''' + txtCarNumber.Text + '''');
        SQL.Add('AND M_CityName = ''' + cmbCarCity.Text + '''');
        if txtSerial.Text <> '' then
          SQL.Add('AND M_Serial = ''' + txtSerial.Text + '''');
        SQL.Add('AND M_IsPark = ' + IntToStr(CNST_TRUE));
        Open;
        if not EOF then
          knd := FieldByname('M_Kind').AsInteger
        else
          knd := 0;
        Close;

        SQL.Clear;
        SQL.Add('UPDATE Machines SET M_Kind = ' + IntToStr(knd or MB_CUSTOMS));
        SQL.Add('WHERE M_Number = ''' + txtCarNumber.Text + '''');
        SQL.Add('AND M_CityName = ''' + cmbCarCity.Text + '''');
        if txtSerial.Text <> '' then
          SQL.Add('AND M_Serial = ''' + txtSerial.Text + '''');
        SQL.Add('AND M_IsPark = ' + IntToStr(CNST_TRUE));
        ExecSQL;
        Free;
      end;
      ActionPayCust(StrToInt(txtCode.Text), '', txtDate.Text, StrToFloat(txtPrice.Text), True, MB_NEW);
      }
      tblNewPersons.Append;
    end
    else if Flag = MB_EDIT then
    begin
      {if tblNewPersons.FieldByName('Cust_Code').AsInteger <> StrToInt(txtCode.Text) then
        ChangeDBSNum('PayCust', 'Pay_CustCode', tblNewPersons.FieldByName('Cust_Code').AsInteger, StrToInt(txtCode.Text));
      ActionPayCust(StrToInt(txtCode.Text), tblNewPersons.FieldByName('Cust_Date').AsString, txtDate.Text, StrToFloat(txtPrice.Text), True, MB_EDIT);
      }
      tblNewPersons.Edit;
    end;

    tblNewPersons.FieldByName('P_Code').AsInteger := StrToInt(txtPCode.Text);
    tblNewPersons.FieldByName('P_Family').AsString := txtFamily.Text;
    tblNewPersons.FieldByName('P_Name').AsString := txtName.Text;
    tblNewPersons.FieldByName('P_CarNumber').AsString := txtCarNumber.Text;
//    tblNewPersons.FieldByName('Cust_CarCity').AsString := cmbCarCity.Text;
    tblNewPersons.FieldByName('P_CarSerial').AsString := txtSerial.Text;
    tblNewPersons.FieldByName('P_CardID').AsString := txtCardID.Text;
    tblNewPersons.FieldByName('P_Tel').AsString := txtTel.Text;
    if cmbCarNameCode.Text <> '' then
      tblNewPersons.FieldByName('P_CarName').AsInteger := StrToInt(cmbCarNameCode.Text)
    else
      tblNewPersons.FieldByName('P_CarName').AsInteger := -1;
    if cmbCarColorCode.Text <> '' then
      tblNewPersons.FieldByName('P_CarColor').AsInteger := StrToInt(cmbCarColorCode.Text)
    else
      tblNewPersons.FieldByName('P_CarColor').AsInteger := -1;
    if cmbDepartmentCode.Text <> '' then
      tblNewPersons.FieldByName('P_Depart').AsInteger := StrToInt(cmbDepartmentCode.Text)
    else
      tblNewPersons.FieldByName('P_Depart').AsInteger := -1;
    {if Flag = MB_NEW then}
    tblNewPersons.FieldByName('P_Valid').AsBoolean := True;
    if chkIsCustomer.Checked then
    begin
      tblNewPersons.FieldByName('P_IsCustomer').AsBoolean := True;
      tblNewPersons.FieldByName('P_Date').AsString := BeautifulDate(txtDate.Text);
      tblNewPersons.FieldByName('P_Remain').AsCurrency := 0;//tblNewPersons.FieldByName('P_Remain').AsCurrency + StrToFloat(txtPrice.Text) - BefPrc;
    end
    else
    begin
      tblNewPersons.FieldByName('P_IsCustomer').AsBoolean := False;
//      tblNewPersons.FieldByName('P_Date').AsString := BeautifulDate(txtDate.Text);
//      tblNewPersons.FieldByName('P_Remain').AsCurrency := tblNewPersons.FieldByName('P_Remain').AsCurrency + StrToFloat(txtPrice.Text) - BefPrc;
    end;

    tblNewPersons.Post;

    if Flag = MB_NEW then
    begin
      ClearScrFields;
      txtPCode.Text := IntToStr(GetNewNumber('NewPersons', 'P_Code'));
      txtPCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgNewPersons.SetFocus;
    end;
  end;
end;

procedure TfrmNewPersons.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgNewPersons.SetFocus;
end;

procedure TfrmNewPersons.cmdTamdidSaveClick(Sender: TObject);
begin
  if txtTamdidDate.Text = '' then
  begin
    ErrorMessage('تاريخ تمديد مشخص نشده است.');
    txtTamdidDate.SetFocus;
  end
  else if txtTamdidDate.Text <= tblNewPersons.FieldByName('Cust_Date').AsString then
  begin
    ErrorMessage('تاريخ تمديد از تاريخ شروع اشتراك جلوتر است.');
    txtTamdidDate.SetFocus;
  end
  else if txtTamdidPrice.Text = '' then
  begin
    ErrorMessage('مبلغ تمديد مشخص نشده است.');
    txtTamdidPrice.SetFocus;
  end
  else
  begin
    tblTamdid.Append;
    tblTamdid.FieldByName('Pay_CustCode').AsInteger := StrToInt(pnlCode.Caption);
    tblTamdid.FieldByName('Pay_Date').AsString := BeautifulDate(txtTamdidDate.Text);
    tblTamdid.FieldByName('Pay_Price').AsCurrency := StrToFloat(txtTamdidPrice.Text);
    tblTamdid.FieldByName('Pay_IsPay').AsBoolean := True;
    tblTamdid.Post;
    tblNewPersons.Edit;
    tblNewPersons.FieldByName('Cust_Remain').AsCurrency := tblNewPersons.FieldByName('Cust_Remain').AsCurrency + StrToFloat(txtTamdidPrice.Text);
    tblNewPersons.Post;
    FormInTamdid(False);
  end;
end;

procedure TfrmNewPersons.cmdTamdidExitClick(Sender: TObject);
begin
  FormInTamdid(False);
  dbgNewPersons.SetFocus;
end;







procedure TfrmNewPersons.txtTamdidDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtTamdidPrice.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmNewPersons.txtTamdidDateExit(Sender: TObject);
begin
  if txtTamdidDate.Text <> '' then
    txtTamdidDate.Text := BeautifulDate(txtTamdidDate.Text);
end;

procedure TfrmNewPersons.txtTamdidPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdTamdidSave.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmNewPersons.dbgTamdidKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmdTamdidDelClick(Sender)
  else if Key = 13 then
    txtTamdidDate.SetFocus;
end;

procedure TfrmNewPersons.cmdTamdidDelClick(Sender: TObject);
begin
  if tblTamdid.RecordCount > 0 then
  begin
    if tblTamdid.FieldByName('Pay_Price').AsCurrency > tblNewPersons.FieldByName('Cust_Remain').AsCurrency then
      InformationMessage('حذف تمديد اشتراك ميسر نيست. زيرا مبالغي از آن استفاده شده است.')
    else if ConfirmMessage('آيا مي‌خواهيد ركورد مورد نظر را حذف نماييد؟') then
    begin
      tblNewPersons.Edit;
      tblNewPersons.FieldByName('Cust_Remain').AsCurrency := tblNewPersons.FieldByName('Cust_Remain').AsCurrency -
                                                          tblTamdid.FieldByName('Pay_Price').AsCurrency;
      tblNewPersons.Post;
      tblTamdid.Delete;
    end;
  end;
end;

procedure TfrmNewPersons.SearchData(ColumnT: TColumn; DESC: Boolean);
begin
  with tblNewPersons do//qryInput do
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
