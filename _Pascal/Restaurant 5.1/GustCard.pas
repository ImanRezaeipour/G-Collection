unit GustCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, QuickRpt,
  Qrctrls, ExtCtrls, Globals, FarsiApi, MSGs, DBS_Proc,
  Keyboard, DateProc,slctPart;

type
  TfrmGustCard = class(TForm)
    grpAll: TGroupBox;
    dbgGuest: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    txtBarCode: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaGuest: TDataSource;
    Label2: TLabel;
    txtDescribe: TEdit;
    Label4: TLabel;
    chkPricable: TCheckBox;
    tblGuest: TAdoTable;
    tblGuestPart: TStringField;
    Label3: TLabel;
    cmbPartCode: TComboBox;
    cmbPartName: TComboBox;
    tblGuestP_BarCode: TStringField;
    tblGuestP_Family: TStringField;
    tblGuestP_Pricable: TBooleanField;
    tblGuestP_IsGuest: TBooleanField;
    Label6: TLabel;
    txtSearchCode: TEdit;
    tblGuestP_IsValid: TBooleanField;
    tblGuestP_ValidTest: TBooleanField;
    tblGuestP_Sobhaneh: TBooleanField;
    tblGuestP_Nahar: TBooleanField;
    tblGuestP_Sham: TBooleanField;
    Label5: TLabel;
    Label7: TLabel;
    Bevel1: TBevel;
    tblGuestP_Special: TSmallintField;
    tblGuestP_ManyFish: TSmallintField;
    tblGuestP_EtebarFish: TStringField;
    Label9: TLabel;
    txtProxi: TEdit;
    tblGuestP_Proxi: TStringField;
    tblGuestP_ShiftGroup: TSmallintField;
    tblGuestP_Rejim: TBooleanField;
    chkDblFood: TCheckBox;
    tblGuestP_DblFood: TBooleanField;
    tblGuestPCode: TStringField;
    tblGuestP_Parts: TWideStringField;
    txtParts: TEdit;
    BitBtn2: TBitBtn;
    cmbType: TComboBox;
    Label8: TLabel;
    pnlMany: TPanel;
    lbl1: TLabel;
    txtMany: TEdit;
    pnlDate: TPanel;
    Label10: TLabel;
    txtDate: TEdit;
    txtCount: TEdit;
    BitBtn1: TBitBtn;
    tblGuestP_dblFoodMax: TSmallintField;
    tblGuestP_Reserve1: TStringField;
    txtremark: TEdit;
    Label11: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgGuestKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtDescribeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPartKeyPress(Sender: TObject; var Key: Char);
    procedure chkPricableKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPartCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPartCodeClick(Sender: TObject);
    procedure cmbPartNameClick(Sender: TObject);
    procedure tblGuestCalcFields(DataSet: TDataSet);
    procedure txtSearchCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtSearchCodeExit(Sender: TObject);
    procedure cmbTypeClick(Sender: TObject);
    procedure cmbTypeKeyPress(Sender: TObject; var Key: Char);
    procedure txtManyKeyPress(Sender: TObject; var Key: Char);
    procedure txtProxiKeyPress(Sender: TObject; var Key: Char);
    procedure chkDblFoodKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtCountKeyPress(Sender: TObject; var Key: Char);
    procedure chkDblFoodClick(Sender: TObject);
    procedure txtremarkKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure ReOpenTable;
    procedure FormInEdit(vis : Boolean);
    procedure ClearScrFields;
    procedure SetScrFields;
    function  AreValidFields : Boolean;
    procedure SetWinF;
  public
   partcode:string; { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmGustCard.SetWinF;
var
  i : byte;
begin
  Caption := (Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label3.Caption := (Label3.Caption);
  Label7.Caption := (Label7.Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label1.Caption := (Label1.Caption);
  Label9.Caption := (Label9.Caption);
  Label4.Caption := (Label4.Caption);
  Label2.Caption := (Label2.Caption);
  Label8.Caption := (Label8.Caption);
  lbl1.Caption := (lbl1.Caption);
  chkPricable.Caption := (chkPricable.Caption);
  chkDblFood.Caption := (chkDblFood.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblGuestPCode.DisplayLabel := (tblGuestPCode.DisplayLabel);
  tblGuestP_Family.DisplayLabel := (tblGuestP_Family.DisplayLabel);
  tblGuestPart.DisplayLabel := (tblGuestPart.DisplayLabel);
  for i := 0 to cmbType.Items.Count - 1 do
    cmbType.Items.Strings[i] := (cmbType.Items.Strings[i]);
end;

procedure TfrmGustCard.ReOpenTable;
var s : String;
begin
  s := 'P_IsGuest = True';
  if txtSearchCode.Text <> '' then
    s := s + ' AND P_BarCode = ''' + FixLeft(txtSearchCode.Text, '0', 8) + '''';
  if cmbPartCode.Text <> '' then
    s := s + ' AND P_parts = ' + GetPartCode(cmbPartCode.Text);

  tblGuest.Filtered := False;
  tblGuest.Filter := s;
  tblGuest.Filtered := True;
end;

procedure TfrmGustCard.FormInEdit(vis : Boolean);
begin
  grpAll.Visible := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
  Top := 70;
end;

procedure TfrmGustCard.ClearScrFields;
begin
  txtBarcode.Text := '';
  txtProxi.Text := '';
  txtDescribe.Text := '';
  txtremark.Text := '';
  txtParts.Text := '';
  chkPricable.Checked := False;
  cmbType.ItemIndex := MB_NORMAL;
  pnlMany.Visible := false;
  pnlDate.Visible := False;
  txtCount.Text := '1';
  txtCount.Enabled := false;  
  txtBarCode.SetFocus;
end;

procedure TfrmGustCard.SetScrFields;
var
  i : Byte;
  qry : TAdoQuery;
begin
  txtBarcode.Text := tblGuest.FieldByName('P_BarCode').AsString;
  txtProxi.Text := tblGuest.FieldByName('P_Proxi').AsString;
  txtDescribe.Text := tblGuest.FieldByName('P_Family').AsString;
  txtremark.Text := tblGuest.FieldByName('P_reserve1').AsString;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM Parts where P_CustomCode=' +''''+tblGuest.FieldByName('P_parts').AsString+'''' );
    Open;
    txtParts.Text :=FieldByName('P_CustomCode').AsString + '-' + FieldByName('P_name').AsString;
    Close;
  end;
//  if cmbPart.Items.Count > 0 then
//    for i := 0 to cmbPart.Items.Count-1 do
//      if StrToInt(Copy(cmbPart.Items.Strings[i], 1, Pos('-', cmbPart.Items.Strings[i])-1)) = tblGuest.FieldByName('P_parts').AsInteger then
//      begin
//        cmbPart.ItemIndex := i;
//        Break;
//      end;
  chkPricable.Checked := tblGuest.FieldByName('P_Pricable').AsBoolean;
  cmbType.ItemIndex := tblGuest.FieldByName('P_Special').AsInteger;
  chkDblFood.Checked := tblGuest.FieldByName('P_DblFood').AsBoolean;
  txtCount.Enabled := chkDblFood.Checked;
  txtCount.Text := inttostr(tblGuest.FieldByName('P_dblFoodMax').asinteger);
  if chkDblFood.checked and   (txtCount.text = '0') then
    txtCount.Text := '1';
  case cmbType.ItemIndex of
    MB_NORMAL:
    begin
      pnlMany.Visible := false;
      pnlDate.Visible := false;
    end;

    MB_ANYCARD:
    begin
      pnlMany.Visible := True;
      pnlDate.Visible := false;
      txtMany.Text := IntToStr(tblGuest.FieldByName('P_ManyFish').AsInteger);
    end;

    MB_DATECARD:
    begin
      pnlMany.Visible := false;
      pnlDate.Visible := True;
      txtDate.Text := tblGuest.FieldByName('P_EtebarFish').AsString;
    end;
    MB_ANYDATECARD:
    begin
      pnlMany.Visible := True;
      pnlDate.Visible := True;
      txtMany.Text := IntToStr(tblGuest.FieldByName('P_ManyFish').AsInteger);
      txtDate.Text := tblGuest.FieldByName('P_EtebarFish').AsString;
    end;
  end;
  txtBarCode.SetFocus;
end;

function TfrmGustCard.AreValidFields : Boolean;
begin
  if txtBarCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره كارت وارد نشده است.');
    txtBarCode.SetFocus;
  end
  else if txtDescribe.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('عنوان كارت وارد نشده است.');
    txtDescribe.SetFocus;
  end
  else if IsExistsRec_Str('Persons', 'P_BarCode', FixLeft(txtBarCode.Text, '0', 8)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblGuest.FieldByName('P_BarCode').AsString <> FixLeft(txtBarCode.Text, '0', 8)))) then
  begin
    AreValidFields := False;
    ErrorMessage('شماره شناسايي تكراري است.');
    txtBarCode.SetFocus;
  end
  else if IsExistsRec_Str('Persons', 'P_Proxi', FixLeft(txtProxi.Text, '0', 8)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblGuest.FieldByName('P_Proxi').AsString <> FixLeft(txtProxi.Text, '0', 8)))) then
  begin
    AreValidFields := False;
    ErrorMessage('شماره كارت تكراري است.');
    txtProxi.SetFocus;
  end
  else if (Flag = MB_EDIT) and (tblGuest.FieldByName('P_BarCode').AsString <> FixLeft(txtBarCode.Text, '0', 8)) and
          IsExistsRec_Str('Fish', 'Fish_PCode', tblGuest.FieldByName('P_BarCode').AsString) then
  begin
    AreValidFields := False;
    ErrorMessage('براي اين كارت فيش صادر شده و شماره كارت آن قابل تغيير نيست.');
    txtBarCode.SetFocus;
  end
  else if ((cmbType.ItemIndex = MB_ANYCARD) or (cmbType.ItemIndex = MB_ANYDATECARD)) and (txtMany.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('تعداد نفرات وارد نشده است.');
    txtMany.SetFocus;
  end
  else if ((cmbType.ItemIndex = MB_DATECARD) or (cmbType.ItemIndex = MB_ANYDATECARD)) and (txtDate.Text = '')  then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ پايان اعتبار وارد نشده است.');
    txtDate.SetFocus;
  end
  else if (txtCount.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('تعداد غذای اضافی وارد نشده است.');
    txtCount.SetFocus;
  end
  else if ((cmbType.ItemIndex = MB_DATECARD) or (cmbType.ItemIndex = MB_ANYDATECARD)) and not IsTrueDate(txtDate.Text) then
  begin
    AreValidFields := False;
    ErrorMessage('تاريخ پايان اعتبار اشتباه است.');
    txtDate.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmGustCard.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtDescribe.Handle);
  SetDirectionFarsi(txtremark.Handle);
  SetDirectionFarsi(cmbPartName.Handle);
  tblGuest.connection := frmDBS.DBConnection;

//  qry := TAdoQuery.Create(Application);
//  with qry do
//  begin
//    connection := frmDBS.DBConnection;
//    SQL.Clear;
//    SQL.Add('SELECT * FROM Parts');
//    Open;
//    while not EOF do
//    begin
//      cmbPartCode.Items.Add(FieldByName('P_CustomCode').AsString);
//      cmbPartName.Items.Add(FieldByName('P_Name').AsString);
//      cmbPart.Items.Add(FieldByName('P_CustomCode').AsString + '-' + FieldByName('P_Name').AsString);
//      Next;
//    end;
//    Close;
//    Free;
//  end;

  tblGuest.Open;
end;

procedure TfrmGustCard.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmGustCard.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblGuest.Close;
end;

procedure TfrmGustCard.tblGuestCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('PCode').AsString := DelLeftZero(FieldByName('P_BarCode').AsString);
    FieldByName('Part').AsString := GetPartNam(FieldByName('P_parts').Asstring);
  end;
end;

procedure TfrmGustCard.txtSearchCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgGuest.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmGustCard.txtSearchCodeExit(Sender: TObject);
begin
  ReOpenTable;
end;

procedure TfrmGustCard.cmbPartCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgGuest.SetFocus;
  end;
end;

procedure TfrmGustCard.cmbPartCodeClick(Sender: TObject);
begin
  if cmbPartCode.Text <> '' then
  begin
    cmbPartCode.ItemIndex := cmbPartCode.Items.IndexOf(cmbPartCode.Text);
    cmbPartName.ItemIndex := cmbPartCode.ItemIndex;
  end
  else
    cmbPartName.Text := '';
  ReOpenTable;
end;

procedure TfrmGustCard.cmbPartNameClick(Sender: TObject);
begin
  if cmbPartName.Text <> '' then
  begin
    cmbPartName.ItemIndex := cmbPartName.Items.IndexOf(cmbPartName.Text);
    cmbPartCode.ItemIndex := cmbPartName.ItemIndex;
  end
  else
    cmbPartCode.Text := '';
  ReOpenTable;
end;

procedure TfrmGustCard.dbgGuestKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 9 then
  begin
    Key := 0;
    cmdNew.SetFocus;
  end
  else if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmGustCard.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearScrFields;
end;

procedure TfrmGustCard.cmdEditClick(Sender: TObject);
begin
  if tblGuest.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetScrFields;
  end;
end;

procedure TfrmGustCard.cmdDeleteClick(Sender: TObject);
begin
  if tblGuest.RecordCount > 0 then
  begin
    if not IsExistsRec_Str('Fish', 'Fish_PCode', tblGuest.FieldByName('P_BarCode').AsString) then
    begin
      if ConfirmMessage('آيا براي حذف پرسنل اطمينان داريد؟') then
      begin
        tblGuest.Delete;
//        tblGuest.Refresh;
      end;
    end
    else
      InformationMessage('براي اين كارت فيش صادر شده و حذف آن امكان پذير نيست.');
  end;
end;

procedure TfrmGustCard.txtBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtProxi.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmGustCard.txtCountKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key)
end;

procedure TfrmGustCard.txtProxiKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtDescribe.SetFocus;
  end
  else
    Keyboard_Proxi(Key);
end;

procedure TfrmGustCard.txtremarkKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    BitBtn1.SetFocus;
  end;
end;

procedure TfrmGustCard.txtDateExit(Sender: TObject);
begin
  if ((cmbType.ItemIndex = MB_DATECARD) or (cmbType.ItemIndex = MB_ANYDATECARD)) and
     (txtDate.Text <> '')then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmGustCard.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmGustCard.txtDescribeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtParts.SetFocus;
  end;
end;

procedure TfrmGustCard.cmbPartKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbType.SetFocus;
  end;
end;

procedure TfrmGustCard.chkPricableKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkDblFood.SetFocus;
  end;
end;

procedure TfrmGustCard.BitBtn2Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);
end;

procedure TfrmGustCard.chkDblFoodClick(Sender: TObject);
begin
  txtCount.Enabled := chkDblFood.Checked;
  if chkDblFood.Checked and (txtCount.Text='0') then
    txtCount.Text := '1';
end;

procedure TfrmGustCard.chkDblFoodKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmGustCard.cmbTypeClick(Sender: TObject);
begin
  case cmbType.ItemIndex of
    MB_NORMAL:
    begin
      pnlMany.Visible := false;
      pnlDate.Visible := false;
    end;
    MB_ANYCARD:
    begin
      pnlMany.Visible := True;
      pnlDate.Visible := false;
    end;
    MB_DATECARD:
    begin
      pnlMany.Visible := false;
      pnlDate.Visible := True;
    end;
    MB_ANYDATECARD :
    begin
      pnlMany.Visible := True;
      pnlDate.Visible := True;
    end;
  end;
end;

procedure TfrmGustCard.cmbTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    case cmbType.ItemIndex of
      MB_NORMAL : chkPricable.SetFocus;
      MB_ANYCARD,MB_ANYDATECARD : txtMany.SetFocus;
      MB_DATECARD : txtDate.SetFocus;
    end;
  end;
end;

procedure TfrmGustCard.txtManyKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key)
end;

procedure TfrmGustCard.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblGuest.Append
    else if Flag = MB_EDIT then
      tblGuest.Edit;

    tblGuest.FieldByName('P_BarCode').AsString := FixLeft(txtBarcode.Text, '0', 8);
    if txtProxi.Text = '' then
      tblGuest.FieldByName('P_Proxi').AsString := tblGuest.FieldByName('P_BarCode').AsString
    else
      tblGuest.FieldByName('P_Proxi').AsString := FixLeft(txtProxi.Text, '0', 8);
    tblGuest.FieldByName('P_Family').AsString := txtDescribe.Text;
    tblGuest.FieldByName('P_reserve1').AsString := txtremark.Text;
    if txtParts.Text <> '' then
      tblGuest.FieldByName('P_parts').Asstring :=Copy(txtParts.Text, 1, Pos('-',txtParts.Text)-1)
    else
      tblGuest.FieldByName('P_parts').AsInteger := 0;

    tblGuest.FieldByName('P_Pricable').AsBoolean := chkPricable.Checked;
    tblGuest.FieldByName('P_IsGuest').AsBoolean := True;
    tblGuest.FieldByName('P_IsValid').AsBoolean := True;
    tblGuest.FieldByName('P_Rejim').AsBoolean := False;
    tblGuest.FieldByName('P_ShiftGroup').AsInteger := 0;
    tblGuest.FieldByName('P_Sobhaneh').AsBoolean := True;
    tblGuest.FieldByName('P_Nahar').AsBoolean := True;
    tblGuest.FieldByName('P_Sham').AsBoolean := True;
    tblGuest.FieldByName('P_ValidTest').AsBoolean := False;
    tblGuest.FieldByName('P_Special').AsInteger := cmbType.ItemIndex;
    case cmbType.ItemIndex of
      MB_ANYCARD:
      begin
        tblGuest.FieldByName('P_ManyFish').AsInteger := StrToInt(txtMany.Text);
        tblGuest.FieldByName('P_EtebarFish').AsString := '';
      end;

      MB_DATECARD:
      begin
        tblGuest.FieldByName('P_ManyFish').AsInteger := 1;
        tblGuest.FieldByName('P_EtebarFish').AsString := txtDate.Text;
      end;

      MB_ANYDATECARD:
      begin
        tblGuest.FieldByName('P_ManyFish').AsInteger := StrToInt(txtMany.Text);
        tblGuest.FieldByName('P_EtebarFish').AsString := txtDate.Text;
      end;

      else
      begin
        tblGuest.FieldByName('P_ManyFish').AsInteger := 1;
        tblGuest.FieldByName('P_EtebarFish').AsString := '';
      end;
    end;
    tblGuest.FieldByName('P_dblFoodMax').AsInteger := StrToInt(txtCount.Text);
    if tblGuest.FieldByName('P_dblFoodMax').AsInteger = 0 then
      chkDblFood.Checked := false;
    tblGuest.FieldByName('P_DblFood').AsBoolean := chkDblFood.Checked;
    tblGuest.Post;

    if Flag = MB_NEW then
    begin
      {ClearScrFields}
      txtBarcode.Text := '';
      txtProxi.Text := '';
      txtBarCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgGuest.SetFocus;
    end;
  end;
end;

procedure TfrmGustCard.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgGuest.SetFocus;
end;


end.
