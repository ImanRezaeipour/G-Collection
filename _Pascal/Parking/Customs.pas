unit Customs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, DBCtrls, Globals,
  FarsiApi, MSGs, Keyboard, DBS, DateProc, ExtCtrls;

type
  TfrmCustoms = class(TForm)
    grpAll: TGroupBox;
    dbgCustoms: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    txtCode: TEdit;
    txtName: TEdit;
    Label2: TLabel;
    txtCarNumber: TEdit;
    Label3: TLabel;
    txtTel: TEdit;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaCustoms: TDataSource;
    tblCustoms: TAdoTable;
    txtSerial: TEdit;
    Label8: TLabel;
    Label5: TLabel;
    txtDate: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    txtPrice: TEdit;
    tblCustomsCust_Code: TSmallintField;
    tblCustomsCust_Name: TStringField;
    tblCustomsCust_Remain: TCurrencyField;
    Label17: TLabel;
    tblCustomsCust_Tel: TStringField;
    tblCustomsCust_CarNumber: TStringField;
    tblCustomsCust_CarCity: TStringField;
    tblCustomsCust_CarSerial: TStringField;
    tblCustomsCust_CarColor: TStringField;
    tblCustomsCust_CarName: TStringField;
    tblCustomsCust_Date: TStringField;
    tblCustomsCust_Valid: TBooleanField;
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
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtTelKeyPress(Sender: TObject; var Key: Char);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtPriceKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgCustomsKeyDown(Sender: TObject; var Key: Word;
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
  private
    { Private declarations }
    Flag : Byte;
    SrchStr : String;
    BefPrc : Currency;

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

procedure TfrmCustoms.SetWinF;
begin
  Caption := (Caption);
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
  tblTamdidPay_Price.DisplayLabel := (tblTamdidPay_Price.DisplayLabel);
end;

procedure TfrmCustoms.FormInEdit(vis : Boolean);
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

procedure TfrmCustoms.FormInTamdid(vis : Boolean);
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
    pnlCode.Caption := tblCustoms.FieldByName('Cust_Code').AsString;
    pnlName.Caption := tblCustoms.FieldByName('Cust_Name').AsString;
    tblTamdid.Filtered := False;
    tblTamdid.Filter := 'Pay_CustCode = ' + pnlCode.Caption +
                        ' AND Pay_Date <> ''' + tblCustoms.FieldByName('Cust_Date').AsString + '''' +
                        ' AND Pay_IsPay = ' + IntToStr(CNST_TRUE);
    tblTamdid.Filtered := True;
  end;
  tblTamdid.Active := vis;
end;

procedure TfrmCustoms.ClearScrFields;
begin
  txtCode.Text := '';
  txtName.Text := '';
  txtTel.Text := '';
  txtCarNumber.Text := '';
  txtSerial.Text := '';
  cmbCarName.Text := '';
  cmbCarCity.Text := '';
  cmbCarColor.Text := '';
  txtDate.Text := CurrentDate;
  txtPrice.Text := '';
  SrchStr := '';
end;

function TfrmCustoms.GetFirstPrice(CustCode : Integer) : Currency;
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

function TfrmCustoms.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ «‘ —«ﬂ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ „‘ —ﬂ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if cmbCarName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ ŒÊœ—Ê Ê«—œ ‰‘œÂ «” .');
    cmbCarName.SetFocus;
  end
  else if cmbCarColor.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('—‰ê ŒÊœ—Ê Ê«—œ ‰‘œÂ «” .');
    cmbCarColor.SetFocus;
  end
  else if txtCarNumber.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‘„«—Â ŒÊœ—Ê Ê«—œ ‰‘œÂ «” .');
    txtCarNumber.SetFocus;
  end
  else if cmbCarCity.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‘Â— ŒÊœ—Ê Ê«—œ ‰‘œÂ «” .');
    cmbCarCity.SetFocus;
  end
  else if txtDate.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage(' «—ÌŒ «‘ —«ﬂ Ê«—œ ‰‘œÂ «” .');
    txtDate.SetFocus;
  end
  else if txtPrice.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('„»·€ «‘ —«ﬂ Ê«—œ ‰‘œÂ «” .');
    txtPrice.SetFocus;
  end
  else if IsExistsRec_Num('Customs.Db', 'Cust_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblCustoms.FieldByName('Cust_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ «‘ —«ﬂ  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmCustoms.ActionPayCust(CustCode : Integer; BefDate, NewDate : String;
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

procedure TfrmCustoms.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  SetDirectionFarsi(txtCarNumber.Handle);
  SetDirectionFarsi(txtSerial.Handle);
  SetDirectionFarsi(cmbCarName.Handle);
  SetDirectionFarsi(cmbCarColor.Handle);
  SetDirectionFarsi(cmbCarCity.Handle);
  tblCustoms.connection := frmDBS.adoConnect;
  tblTamdid.connection := frmDBS.adoConnect;
  FormInEdit(False);
  Top := 80;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cars ORDER BY Car_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarName.Items.Add(qry.FieldByName('Car_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Colors ORDER BY Clr_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarColor.Items.Add(qry.FieldByName('Clr_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
  qry.Open;
  while not qry.EOF do
  begin
    cmbCarCity.Items.Add(qry.FieldByName('City_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.Free;

  tblCustoms.Filtered := False;
  tblCustoms.Filter := 'Cust_Valid = ' + IntToStr(CNST_TRUE);
  tblCustoms.Filtered := True;
  tblCustoms.Open;

end;

procedure TfrmCustoms.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblCustoms.Close;
end;

procedure TfrmCustoms.dbgCustomsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmCustoms.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  BefPrc := 0;
  Flag := MB_NEW;
  ClearScrFields;
  txtCode.Text := IntToStr(GetNewNumber('Customs', 'Cust_Code'));
  txtCode.SetFocus;
end;

procedure TfrmCustoms.cmdEditClick(Sender: TObject);
begin
  if tblCustoms.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(tblCustoms.FieldByName('Cust_Code').AsInteger);
    txtName.Text := tblCustoms.FieldByName('Cust_Name').AsString;
    txtTel.Text := tblCustoms.FieldByName('Cust_Tel').AsString;
    cmbCarName.Text := tblCustoms.FieldByName('Cust_CarName').AsString;
    cmbCarColor.Text := tblCustoms.FieldByName('Cust_CarColor').AsString;
    txtCarNumber.Text := tblCustoms.FieldByName('Cust_CarNumber').AsString;
    cmbCarCity.Text := tblCustoms.FieldByName('Cust_CarCity').AsString;
    txtSerial.Text := tblCustoms.FieldByName('Cust_CarSerial').AsString;
    txtDate.Text := tblCustoms.FieldByName('Cust_Date').AsString;
    BefPrc := GetFirstPrice(tblCustoms.FieldByName('Cust_Code').AsInteger);
    txtPrice.Text := FloatToStr(BefPrc);
    txtCode.SetFocus;
  end;
end;

procedure TfrmCustoms.cmdDeleteClick(Sender: TObject);
begin
  if tblCustoms.RecordCount > 0 then
  begin
    if not InCircleCustoms(tblCustoms.FieldByName('Cust_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› „‘ —ﬂ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        ActionPayCust(tblCustoms.FieldByName('Cust_Code').AsInteger, '', tblCustoms.FieldByName('Cust_Date').AsString, 0.0, True, MB_DELETE);
        tblCustoms.Delete;
      end;
    end
    else
      InformationMessage('«Ì‰ „‘ —ﬂ œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmCustoms.cmdTamdidClick(Sender: TObject);
begin
  if tblCustoms.RecordCount > 0 then
  begin
    FormInTamdid(True);
    txtTamdidDate.Text := CurrentDate;
    txtTamdidPrice.Text := '';
    txtTamdidDate.SetFocus;
  end;
end;

procedure TfrmCustoms.cmdEndCustClick(Sender: TObject);
begin
  if (tblCustoms.RecordCount > 0) and
      ConfirmMessage('¬Ì« „ÌùŒÊ«ÂÌœ »« „‘ —ﬂ „Ê—œ ‰Ÿ—  ”ÊÌÂ Õ”«» ‰„«ÌÌœø') then
  begin
    tblTamdid.Open;
    tblTamdid.Append;
    tblTamdid.FieldByName('Pay_CustCode').AsInteger := tblCustoms.FieldByName('Cust_Code').AsInteger;
    tblTamdid.FieldByName('Pay_Date').AsString := CurrentDate;
    tblTamdid.FieldByName('Pay_Price').AsCurrency := tblCustoms.FieldByName('Cust_Remain').AsCurrency;
    tblTamdid.FieldByName('Pay_IsPay').AsBoolean := False;
    tblTamdid.Post;
    tblTamdid.Close;

    tblCustoms.Edit;
    tblCustoms.FieldByName('Cust_Remain').AsCurrency := 0;
    tblCustoms.FieldByName('Cust_Valid').AsBoolean := False;
    tblCustoms.Post;
  end;
end;

procedure TfrmCustoms.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCustoms.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtTel.SetFocus;
  end;
end;

procedure TfrmCustoms.txtTelKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbCarName.SetFocus;
  end;
end;

procedure TfrmCustoms.cmbCarNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmCustoms.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbCarColor.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmCustoms.cmbCarColorEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmCustoms.cmbCarColorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtCarNumber.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCarColor, Key);

end;

procedure TfrmCustoms.txtCarNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    cmbCarCity.SetFocus
  else
    txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);

  Key := #0;
end;

procedure TfrmCustoms.cmbCarCityEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmCustoms.cmbCarCityKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCustoms.txtSerialKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtDate.SetFocus;
  end;
end;

procedure TfrmCustoms.txtDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPrice.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmCustoms.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmCustoms.txtPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end
  else
    Keyboard_Number(Key, txtPrice.Text);
end;

procedure TfrmCustoms.cmdSaveClick(Sender: TObject);
var
  qry : TAdoQuery;
  knd : Byte;
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
    begin
      qry := TAdoQuery.Create(Application);
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
      tblCustoms.Append;
    end
    else if Flag = MB_EDIT then
    begin
      if tblCustoms.FieldByName('Cust_Code').AsInteger <> StrToInt(txtCode.Text) then
        ChangeDBSNum('PayCust', 'Pay_CustCode', tblCustoms.FieldByName('Cust_Code').AsInteger, StrToInt(txtCode.Text));
      ActionPayCust(StrToInt(txtCode.Text), tblCustoms.FieldByName('Cust_Date').AsString, txtDate.Text, StrToFloat(txtPrice.Text), True, MB_EDIT);
      tblCustoms.Edit;
    end;
    tblCustoms.FieldByName('Cust_Code').AsInteger := StrToInt(txtCode.Text);
    tblCustoms.FieldByName('Cust_Name').AsString := txtName.Text;
    tblCustoms.FieldByName('Cust_Tel').AsString := txtTel.Text;
    tblCustoms.FieldByName('Cust_CarName').AsString := cmbCarName.Text;
    tblCustoms.FieldByName('Cust_CarColor').AsString := cmbCarColor.Text;
    tblCustoms.FieldByName('Cust_CarNumber').AsString := txtCarNumber.Text;
    tblCustoms.FieldByName('Cust_CarCity').AsString := cmbCarCity.Text;
    tblCustoms.FieldByName('Cust_CarSerial').AsString := txtSerial.Text;
    tblCustoms.FieldByName('Cust_Date').AsString := BeautifulDate(txtDate.Text);
    tblCustoms.FieldByName('Cust_Remain').AsCurrency := tblCustoms.FieldByName('Cust_Remain').AsCurrency + StrToFloat(txtPrice.Text) - BefPrc;
    {if Flag = MB_NEW then}
      tblCustoms.FieldByName('Cust_Valid').AsBoolean := True;
    tblCustoms.Post;

    if Flag = MB_NEW then
    begin
      ClearScrFields;
      txtCode.Text := IntToStr(GetNewNumber('Customs', 'Cust_Code'));
      txtCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgCustoms.SetFocus;
    end;
  end;
end;

procedure TfrmCustoms.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCustoms.SetFocus;
end;







procedure TfrmCustoms.cmdTamdidSaveClick(Sender: TObject);
begin
  if txtTamdidDate.Text = '' then
  begin
    ErrorMessage(' «—ÌŒ  „œÌœ „‘Œ’ ‰‘œÂ «” .');
    txtTamdidDate.SetFocus;
  end
  else if txtTamdidDate.Text <= tblCustoms.FieldByName('Cust_Date').AsString then
  begin
    ErrorMessage(' «—ÌŒ  „œÌœ «“  «—ÌŒ ‘—Ê⁄ «‘ —«ﬂ Ã·Ê — «” .');
    txtTamdidDate.SetFocus;
  end
  else if txtTamdidPrice.Text = '' then
  begin
    ErrorMessage('„»·€  „œÌœ „‘Œ’ ‰‘œÂ «” .');
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
    tblCustoms.Edit;
    tblCustoms.FieldByName('Cust_Remain').AsCurrency := tblCustoms.FieldByName('Cust_Remain').AsCurrency + StrToFloat(txtTamdidPrice.Text);
    tblCustoms.Post;
    FormInTamdid(False);
  end;
end;

procedure TfrmCustoms.cmdTamdidExitClick(Sender: TObject);
begin
  FormInTamdid(False);
  dbgCustoms.SetFocus;
end;







procedure TfrmCustoms.txtTamdidDateKeyPress(Sender: TObject;
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

procedure TfrmCustoms.txtTamdidDateExit(Sender: TObject);
begin
  if txtTamdidDate.Text <> '' then
    txtTamdidDate.Text := BeautifulDate(txtTamdidDate.Text);
end;

procedure TfrmCustoms.txtTamdidPriceKeyPress(Sender: TObject;
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

procedure TfrmCustoms.dbgTamdidKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmdTamdidDelClick(Sender)
  else if Key = 13 then
    txtTamdidDate.SetFocus;
end;

procedure TfrmCustoms.cmdTamdidDelClick(Sender: TObject);
begin
  if tblTamdid.RecordCount > 0 then
  begin
    if tblTamdid.FieldByName('Pay_Price').AsCurrency > tblCustoms.FieldByName('Cust_Remain').AsCurrency then
      InformationMessage('Õ–›  „œÌœ «‘ —«ﬂ „Ì”— ‰Ì” . “Ì—« „»«·€Ì «“ ¬‰ «” ›«œÂ ‘œÂ «” .')
    else if ConfirmMessage('¬Ì« „ÌùŒÊ«ÂÌœ —ﬂÊ—œ „Ê—œ ‰Ÿ— —« Õ–› ‰„«ÌÌœø') then
    begin
      tblCustoms.Edit;
      tblCustoms.FieldByName('Cust_Remain').AsCurrency := tblCustoms.FieldByName('Cust_Remain').AsCurrency -
                                                          tblTamdid.FieldByName('Pay_Price').AsCurrency;
      tblCustoms.Post;
      tblTamdid.Delete;
    end;
  end;
end;



end.
