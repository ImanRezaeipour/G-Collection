unit Specials;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, DBCtrls, Globals,
  FarsiApi, MSGs, Keyboard, DBS, DateProc, ExtCtrls, Variants;

type
  TfrmSpecials = class(TForm)
    grpAll: TGroupBox;
    dbgSpc: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    txtCarNumber: TEdit;
    Label3: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    dtaSpc: TDataSource;
    tblSpc: TAdoTable;
    txtSerial: TEdit;
    Label8: TLabel;
    Label17: TLabel;
    cmbCarName: TComboBox;
    cmbCarColor: TComboBox;
    cmbCarCity: TComboBox;
    pnlTakhfif: TPanel;
    Label1: TLabel;
    rdoTakhfif: TRadioButton;
    rdoRaygan: TRadioButton;
    txtPercent: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    pnlSpc: TPanel;
    Label2: TLabel;
    txtDescribe: TEdit;
    tblSpcSpc_Number: TStringField;
    tblSpcSpc_City: TStringField;
    tblSpcSpc_Serial: TStringField;
    tblSpcSpc_Name: TStringField;
    tblSpcSpc_Color: TStringField;
    tblSpcSpc_NotExit: TBooleanField;
    tblSpcSpc_Motavari: TBooleanField;
    tblSpcSpc_Takhfif: TBooleanField;
    tblSpcSpc_Percent: TSmallintField;
    tblSpcSpc_Debtor: TCurrencyField;
    tblSpcSpc_DescribeNotExit: TStringField;
    tblSpcSpc_DescribeMotavari: TStringField;
    tblSpcNumber: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgSpcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmbCarNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarNameEnter(Sender: TObject);
    procedure cmbCarColorKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarColorEnter(Sender: TObject);
    procedure cmbCarCityEnter(Sender: TObject);
    procedure cmbCarCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtCarNumberKeyPress(Sender: TObject; var Key: Char);
    procedure rdoTakhfifClick(Sender: TObject);
    procedure rdoTakhfifKeyPress(Sender: TObject; var Key: Char);
    procedure rdoRayganKeyPress(Sender: TObject; var Key: Char);
    procedure txtPercentKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure tblSpcCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    Flag : Byte;
    SrchStr : String;

    procedure FormInEdit(vis : Boolean);
    procedure ClearScrFields;
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
    SpcType : Byte;
  end;




implementation

{$R *.DFM}

procedure TfrmSpecials.SetWinF;
begin
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  Label1.Caption := (Label1.Caption);
  Label9.Caption := (Label9.Caption);
  Label17.Caption := (Label17.Caption);
  Label8.Caption := (Label8.Caption);
  Label3.Caption := (Label3.Caption);
  Label10.Caption := (Label10.Caption);
  rdoTakhfif.Caption := (rdoTakhfif.Caption);
  rdoRaygan.Caption := (rdoRaygan.Caption);
  tblSpcSpc_Name.DisplayLabel := (tblSpcSpc_Name.DisplayLabel);
  tblSpcNumber.DisplayLabel := (tblSpcNumber.DisplayLabel);
  tblSpcSpc_City.DisplayLabel := (tblSpcSpc_City.DisplayLabel);
  tblSpcSpc_Serial.DisplayLabel := (tblSpcSpc_Serial.DisplayLabel);
  Label2.Caption := (Label2.Caption);
end;

procedure TfrmSpecials.FormInEdit(vis : Boolean);
begin
  grpAll.Visible := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;

  case SpcType of
    MB_TAKHFIF :
    begin
      pnlTakhfif.Visible := vis;
      pnlSpc.Visible := not vis;
    end;
    else
    begin
      pnlTakhfif.Visible := not vis;
      pnlSpc.Visible := vis;
    end;
  end;
end;


procedure TfrmSpecials.ClearScrFields;
begin
  cmbCarName.Text := '';
  cmbCarColor.Text := '';
  txtCarNumber.Text := '';
  cmbCarCity.Text := '';
  txtSerial.Text := '';
  txtDescribe.Text := '';
  rdoTakhfif.Checked := True; 
  txtPercent.Text := '';
  SrchStr := '';
end;

function TfrmSpecials.AreValidFields : Boolean;
begin
  if cmbCarName.Text = '' then
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
  else if (SpcType = MB_TAKHFIF) and rdoTakhfif.Checked and (txtPercent.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('œ—’œ  Œ›Ì› Ê«—œ ‰‘œÂ «” .');
    txtPercent.SetFocus;
  end
  else
    AreValidFields := True;
end;


procedure TfrmSpecials.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtCarNumber.Handle);
  SetDirectionFarsi(txtSerial.Handle);
  SetDirectionFarsi(cmbCarName.Handle);
  SetDirectionFarsi(cmbCarColor.Handle);
  SetDirectionFarsi(cmbCarCity.Handle);
  SetDirectionFarsi(txtDescribe.Handle);
  tblSpc.connection := frmDBS.adoConnect;
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
end;

procedure TfrmSpecials.FormActivate(Sender: TObject);
begin
  tblSpc.Filtered := False;
  case SpcType of
    MB_TAKHFIF :
    begin
      Caption := ('„⁄—›Ì ŒÊœ—ÊÂ«Ì ÊÌéÂ');
      tblSpc.Filter := 'Spc_Takhfif = ' + IntToStr(CNST_TRUE);
      HelpContext := 110;
    end;

    MB_NOTEXIT :
    begin
      Caption := ('„⁄—›Ì ŒÊœ—ÊÂ«Ì „„„‰Ê⁄ù«·Œ—ÊÃ');
      tblSpc.Filter := 'Spc_NotExit = ' + IntToStr(CNST_TRUE);
      HelpContext := 401;
    end;

    MB_MOTAVARI :
    begin
      Caption := ('„⁄—›Ì ŒÊœ—ÊÊÂ«Ì „ Ê«—Ì');
      tblSpc.Filter := 'Spc_Motavari = ' + IntToStr(CNST_TRUE);
      HelpContext := 402;
    end;
  end;
  tblSpc.Filtered := True;

  FormInEdit(False);
  tblSpc.Open;
end;

procedure TfrmSpecials.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblSpc.Close;
end;

procedure TfrmSpecials.dbgSpcKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmSpecials.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearScrFields;
  cmbCarName.SetFocus;
end;

procedure TfrmSpecials.cmdEditClick(Sender: TObject);
begin
  if tblSpc.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    cmbCarName.Text := tblSpc.FieldByName('Spc_Name').AsString;
    cmbCarColor.Text := tblSpc.FieldByName('Spc_Color').AsString;
    txtCarNumber.Text := tblSpc.FieldByName('Spc_Number').AsString;
    cmbCarCity.Text := tblSpc.FieldByName('Spc_City').AsString;
    txtSerial.Text := tblSpc.FieldByName('Spc_Serial').AsString;
    if SpcType = MB_NOTEXIT then
      txtDescribe.Text := tblSpc.FieldByName('Spc_DescribeNotExit').AsString
    else if SpcType = MB_MOTAVARI then
      txtDescribe.Text := tblSpc.FieldByName('Spc_DescribeMotavari').AsString;
    if tblSpc.FieldByName('Spc_Percent').AsFloat < 100 then
    begin
      txtPercent.Text := tblSpc.FieldByName('Spc_Percent').AsString;
      rdoTakhfif.Checked := tblSpc.FieldByName('Spc_Takhfif').AsBoolean;
    end
    else
    begin
      txtPercent.Text := '';
      rdoRaygan.Checked := True;
    end;
    cmbCarName.SetFocus;
  end;
end;

procedure TfrmSpecials.cmdDeleteClick(Sender: TObject);
var Num, City, Seri : String;
begin
  if (tblSpc.RecordCount > 0) and
      ConfirmMessage('¬Ì« »—«Ì Õ–› —ﬂÊ—œ «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    Num := tblSpc.FieldByName('Spc_Number').AsString;
    City := tblSpc.FieldByName('Spc_City').AsString;
    Seri := tblSpc.FieldByName('Spc_Serial').AsString;
    case SpcType of
      MB_TAKHFIF:
      begin
        if tblSpc.FieldByName('Spc_Motavari').AsBoolean or
           tblSpc.FieldByName('Spc_NotExit').AsBoolean then
        begin
          tblSpc.Edit;
          tblSpc.FieldByName('Spc_Takhfif').AsBoolean := False;
          tblSpc.Post;
        end
        else
          tblSpc.Delete;
      end;

      MB_MOTAVARI:
      begin
        if tblSpc.FieldByName('Spc_Takhfif').AsBoolean or
           tblSpc.FieldByName('Spc_NotExit').AsBoolean then
        begin
          tblSpc.Edit;
          tblSpc.FieldByName('Spc_Motavari').AsBoolean := False;
          tblSpc.Post;
        end
        else
          tblSpc.Delete;
      end;

      MB_NOTEXIT:
      begin
        if tblSpc.FieldByName('Spc_Motavari').AsBoolean or
           tblSpc.FieldByName('Spc_Takhfif').AsBoolean then
        begin
          tblSpc.Edit;
          tblSpc.FieldByName('Spc_NotExit').AsBoolean := False;
          tblSpc.Post;
        end
        else
          tblSpc.Delete;
      end;
    end;
    SetCarStat(Num, City, Seri);
  end;
end;

procedure TfrmSpecials.cmbCarNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmSpecials.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbCarColor.SetFocus;
  end
  else
    SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmSpecials.cmbCarColorEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmSpecials.cmbCarColorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtCarNumber.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCarColor, Key);
end;

procedure TfrmSpecials.txtCarNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    cmbCarCity.SetFocus
  else
    txtCarNumber.Text := Key_CarNumber(txtCarNumber.Text, Key, txtCarNumber.SelLength);

  Key := #0;
end;

procedure TfrmSpecials.cmbCarCityEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmSpecials.cmbCarCityKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSpecials.txtSerialKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    case SpcType of
      MB_TAKHFIF:
      begin
        if rdoTakhfif.Checked then
          rdoTakhfif.SetFocus
        else
          rdoRaygan.SetFocus;
      end;
      else
        txtDescribe.SetFocus;
    end;
  end;
end;

procedure TfrmSpecials.rdoTakhfifClick(Sender: TObject);
begin
  txtPercent.Enabled := rdoTakhfif.Checked;
end;

procedure TfrmSpecials.rdoTakhfifKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPercent.SetFocus;
  end;
end;

procedure TfrmSpecials.rdoRayganKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmSpecials.txtPercentKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSpecials.tblSpcCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('Number').AsString := ConvertToFarsi(DataSet.FieldByName('Spc_Number').AsString);
end;

procedure TfrmSpecials.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
    begin
      if tblSpc.Filtered = True then
        tblSpc.Filtered := False;
////kaveh      tblSpc.SetKey;
//kaveh      if tblSpc.FindKey([txtCarNumber.Text, cmbCarCity.Text, txtSerial.Text]) then
      if tblSpc.Locate('Spc_Number;Spc_City;Spc_Serial', VarArrayOf([txtCarNumber.Text, cmbCarCity.Text, txtSerial.Text]), [loPartialKey]) then
        tblSpc.Edit
      else
        tblSpc.Append;
    end
    else if Flag = MB_EDIT then
      tblSpc.Edit;
    tblSpc.FieldByName('Spc_Name').AsString := cmbCarName.Text;
    tblSpc.FieldByName('Spc_Color').AsString := cmbCarColor.Text;
    tblSpc.FieldByName('Spc_Number').AsString := txtCarNumber.Text;
    tblSpc.FieldByName('Spc_City').AsString := cmbCarCity.Text;
    tblSpc.FieldByName('Spc_Serial').AsString := txtSerial.Text;
    case SpcType of
      MB_TAKHFIF:
      begin
        tblSpc.FieldByName('Spc_Takhfif').AsBoolean := True;
        if rdoTakhfif.Checked then
          tblSpc.FieldByName('Spc_Percent').AsInteger := StrToInt(txtPercent.Text)
        else
          tblSpc.FieldByName('Spc_Percent').AsInteger := 100;
      end;

      MB_NOTEXIT:
      begin
        tblSpc.FieldByName('Spc_NotExit').AsBoolean := True;
        tblSpc.FieldByName('Spc_DescribeNotExit').AsString := txtDescribe.Text;
      end;

      MB_MOTAVARI:
      begin
        tblSpc.FieldByName('Spc_Motavari').AsBoolean := True;
        tblSpc.FieldByName('Spc_DescribeMotavari').AsString := txtDescribe.Text;
      end;
    end;


    tblSpc.Post;
    SetCarStat(txtCarNumber.Text, cmbCarCity.Text, txtSerial.Text);
    tblSpc.Filtered := True;

    if Flag = MB_NEW then
    begin
      ClearScrFields;
      cmbCarName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgSpc.SetFocus;
    end;
  end;
end;

procedure TfrmSpecials.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgSpc.SetFocus;
end;


end.
