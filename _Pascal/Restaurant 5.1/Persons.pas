unit Persons;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard, ExtCtrls, Ertebat, DateProc, slctPart, SelPic ;

type
  TfrmPersons = class(TForm)
    grpAll: TGroupBox;
    dbgPersons: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lblBarCode: TLabel;
    txtBarCode: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaPersons: TDataSource;
    tblPerson: TAdoTable;
    lblName: TLabel;
    txtName: TEdit;
    lblFamily: TLabel;
    txtFamily: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    cmbJob: TComboBox;
    chkIsValid: TCheckBox;
    chkValidTest: TCheckBox;
    chkPricable: TCheckBox;
    GroupBox1: TGroupBox;
    chkSobhaneh: TCheckBox;
    chkNahar: TCheckBox;
    chkSham: TCheckBox;
    Label7: TLabel;
    cmbPartCode: TComboBox;
    cmbPartName: TComboBox;
    txtSearchCode: TEdit;
    Label6: TLabel;
    cmdListNew: TBitBtn;
    txtToBarCode: TEdit;
    Label1: TLabel;
    cmbGroups: TComboBox;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    txtProxi: TEdit;
    tmrProxi: TTimer;
    chkDblFood: TCheckBox;
    cmdFixPCode: TBitBtn;
    lblRecNo: TLabel;
    Label9: TLabel;
    txtSearchFamily: TEdit;
    chkRejim: TCheckBox;
    cmbCashType: TComboBox;
    Label10: TLabel;
    cmbBuilding: TComboBox;
    Label11: TLabel;
    txtsearchcard: TEdit;
    Label12: TLabel;
    tblPersonP_BarCode: TWideStringField;
    tblPersonP_Proxi: TWideStringField;
    tblPersonP_Name: TWideStringField;
    tblPersonP_Family: TWideStringField;
    tblPersonP_Parts: TWideStringField;
    tblPersonP_JobCode: TSmallintField;
    tblPersonP_ShiftGroup: TSmallintField;
    tblPersonP_IsValid: TBooleanField;
    tblPersonP_ValidTest: TBooleanField;
    tblPersonP_Pricable: TBooleanField;
    tblPersonP_Sobhaneh: TBooleanField;
    tblPersonP_Nahar: TBooleanField;
    tblPersonP_Sham: TBooleanField;
    tblPersonP_Rejim: TBooleanField;
    tblPersonP_IsGuest: TBooleanField;
    tblPersonP_Special: TSmallintField;
    tblPersonP_ManyFish: TSmallintField;
    tblPersonP_EtebarFish: TWideStringField;
    tblPersonP_DblFood: TBooleanField;
    tblPersonP_CashType: TSmallintField;
    tblPersonP_DeserNoFood: TBooleanField;
    tblPersonP_Building: TSmallintField;
    tblPersonpart: TStringField;
    tblPersonpcode: TStringField;
    txtParts: TEdit;
    BitBtn2: TBitBtn;
    chkprepaid: TCheckBox;
    tblPersonp_prepaid: TBooleanField;
    tblPersonP_Credit: TBCDField;
    Label13: TLabel;
    cmbreserve7: TComboBox;
    tblPersonp_reserve7: TStringField;
    txtCount: TEdit;
    tblPersonP_dblFoodMax: TSmallintField;
    txtMntCount: TEdit;
    chkMntFood: TCheckBox;
    tblPersonP_MntFoodMax: TSmallintField;
    tblPersonP_MntFood: TBooleanField;
    imgPicture: TImage;
    Label14: TLabel;
    Shape1: TShape;
    tblPersonP_Picture: TWideStringField;
    procedure cmbreserve7KeyPress(Sender: TObject; var Key: Char);
    procedure chkPricableClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure tblPersonFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure txtsearchcardKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBuildingKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBuildingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgPersonsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPartKeyPress(Sender: TObject; var Key: Char);
    procedure cmbJobKeyPress(Sender: TObject; var Key: Char);
    procedure chkIsValidKeyPress(Sender: TObject; var Key: Char);
    procedure chkValidTestKeyPress(Sender: TObject; var Key: Char);
    procedure chkPricableKeyPress(Sender: TObject; var Key: Char);
    procedure chkSobhanehKeyPress(Sender: TObject; var Key: Char);
    procedure chkNaharKeyPress(Sender: TObject; var Key: Char);
    procedure chkShamKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPartCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPartCodeClick(Sender: TObject);
    procedure cmbPartNameClick(Sender: TObject);
    procedure tblPersonCalcFields(DataSet: TDataSet);
    procedure txtSearchCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtSearchCodeExit(Sender: TObject);
    procedure cmdListNewClick(Sender: TObject);
    procedure txtToBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbGroupsKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPartKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbJobKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbGroupsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtProxiKeyPress(Sender: TObject; var Key: Char);
    procedure tmrProxiTimer(Sender: TObject);
    procedure chkDblFoodKeyPress(Sender: TObject; var Key: Char);
    procedure cmdFixPCodeClick(Sender: TObject);
    procedure txtSearchFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure chkRejimKeyPress(Sender: TObject; var Key: Char);
    procedure txtCountKeyPress(Sender: TObject; var Key: Char);
    procedure chkDblFoodClick(Sender: TObject);
    procedure chkMntFoodClick(Sender: TObject);
    procedure txtMntCountKeyPress(Sender: TObject; var Key: Char);
    procedure imgPictureDblClick(Sender: TObject);
  private
    { Private declarations }
    Flag,
    ProxiCode : Byte;
    PictureName : String;

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
uses ComTools;
{$R *.DFM}

const
  MB_LIST = 10;

procedure TfrmPersons.SetWinF;
begin
end;

procedure TfrmPersons.ReOpenTable;
var s : String;
begin
   s := 'P_IsGuest = false';
  if cmbPartCode.Text <> '' then
    s := s + ' AND P_parts like '+ GetPartCode(cmbPartCode.Text) +'%';
  if txtSearchCode.Text <> '' then
    s := s + ' AND P_BarCode like ''%' +txtSearchCode.Text + '%''';
  if txtSearchFamily.Text <> '' then
    s := s + ' AND P_Family like ''' + txtSearchFamily.Text + '%''';
  if txtSearchCard.Text <> '' then
    s := s + ' AND P_proxi like ''%' + txtSearchcard.Text + '%''';

  tblPerson.Filtered := False;
  tblPerson.Filter := s;
  tblPerson.Filtered := True;
  lblRecNo.Caption := ('تعداد : ' + IntToStr(tblPerson.RecordCount));
end;

procedure TfrmPersons.FormInEdit(vis : Boolean);
begin
  tmrProxi.Enabled := vis;
  grpAll.Visible := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpEdit.Height
  else
    Height := grpAll.Height+100;
  Height := Height + 25;
  if not vis then
  begin
    lblBarCode.Caption := ('&شماره پرسنلي');
    lblName.Caption := ('&نام');
    txtToBarCode.Visible := False;

    txtName.Visible := True;
    txtFamily.Visible := True;
    lblFamily.Visible := True;
  end;
end;

procedure TfrmPersons.imgPictureDblClick(Sender: TObject);
var frmSelPicture: TfrmSelPicture;
begin
//  if DirectoryExists(g_options.ProgramPath + PICTURE_PATH) then
  if DirectoryExists({g_options.ProgramPath +} F_Params.PrsImgsFld) then
  begin
    Application.CreateForm(TfrmSelPicture, frmSelPicture);
//    frmSelPicture.FileListBox1.Directory := g_options.ProgramPath + PICTURE_PATH;
    frmSelPicture.FileListBox1.Directory := {g_options.ProgramPath + }F_Params.PrsImgsFld;
    if frmSelPicture.Execute then
    begin
      PictureName := frmSelPicture.FileSel;
      if (PictureName <> '') and FileExists(PictureName)
      then begin
        imgPicture.Picture.LoadFromFile(PictureName);
//        imgPicture.Width:=round(imgPicture.Height*imgPicture.Picture.Width/imgPicture.Picture.Height);
      end
      else
        imgPicture.Picture.Bitmap := nil
    end;
    frmSelPicture.Free;
  end
  else
    ErrorMessage('شاخه ' +
//                 Chr(13) + g_options.ProgramPath + PICTURE_PATH + Chr(13) +
                 Chr(13) + {g_options.ProgramPath + }F_Params.PrsImgsFld + Chr(13) +
                 ' وجود ندارد.');
end;

procedure TfrmPersons.ClearScrFields;
begin
  txtBarcode.Text := '';
  txtProxi.Text := '';
  txtName.Text := '';
  txtFamily.Text := '';
//  cmbPart.ItemIndex := 0;
  cmbBuilding.ItemIndex := 0;
  cmbJob.ItemIndex := 0;
  cmbCashType.ItemIndex := 0;
  cmbreserve7.ItemIndex := -1;
  cmbreserve7.text := '';
  chkIsValid.Checked := False;
  chkValidTest.Checked := False;
  chkPricable.Checked := False;
  chkrejim.Checked := False;
  chkSobhaneh.Checked := False;
  chkNahar.Checked := False;
  chkSham.Checked := False;
  chkDblFood.Checked := False;
  txtCount.Text := '1';
  txtCount.Enabled := false;
//kaveh is
{$ifdef OperatorBase}
  txtMntCount.Visible := True;
  chkMntFood.Visible := True;
{$else OperatorBase}
  txtMntCount.Visible := False;
  chkMntFood.Visible := False;
{$endif OperatorBase}
  PictureName := '';
  imgPicture.Picture.Bitmap := nil;
//kaveh ie
  chkMntFood.Checked := False;
  txtMntCount.Text := '1';
  txtBarCode.SetFocus;
end;

procedure TfrmPersons.SetScrFields;
var i : integer;
 qry : TAdoQuery;
begin
  txtBarcode.Text := tblPerson.FieldByName('P_BarCode').AsString;
  txtProxi.Text := tblPerson.FieldByName('P_Proxi').AsString;
  txtName.Text := tblPerson.FieldByName('P_Name').AsString;
  txtFamily.Text := tblPerson.FieldByName('P_Family').AsString;

  if tblPerson.FieldByName('P_parts').AsString <> '' then
  begin
    PartCode := GetPartCustomCode(tblPerson.FieldByName('P_Parts').AsString);
    txtParts.Text := PartCode + ' - ' + GetPartName(PartCode);
  end
  else
  begin
    PartCode := '';
    txtParts.Text := '';
  end;

  //**********************************************************888
   qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
//    SQL.Clear;
//    SQL.Add('SELECT * FROM Parts where P_CustomCode=' +''''+tblPerson.FieldByName('P_parts').AsString+'''' );
//    Open;
//    txtParts.Text :=FieldByName('P_CustomCode').AsString + '-' + FieldByName('P_name').AsString;
//    Close;
  //***************************************************************8

//  cmbPart.ItemIndex := -1;
//  if cmbPart.Items.Count > 0 then
//    for i := 0 to cmbPart.Items.Count-1 do
//      if Copy(cmbPart.Items.Strings[i], 1, Pos('-', cmbPart.Items.Strings[i])-1) = tblPerson.FieldByName('P_parts').Asstring then
//      begin
//        cmbPart.ItemIndex := i;
//        Break;
//      end;


    cmbBuilding.ItemIndex := -1;
    if cmbBuilding.Items.Count > 0 then
      for i := 0 to cmbBuilding.Items.Count-1 do
        if StrToInt(Copy(cmbBuilding.Items.Strings[i], 1, Pos('-', cmbBuilding.Items.Strings[i])-1)) = tblPerson.FieldByName('P_building').AsInteger then
        begin
          cmbBuilding.ItemIndex := i;
          Break;
        end;

    cmbJob.ItemIndex := -1;
    if cmbJob.Items.Count > 0 then
      for i := 0 to cmbJob.Items.Count-1 do
        if StrToInt(Copy(cmbJob.Items.Strings[i], 1, Pos('-', cmbJob.Items.Strings[i])-1)) = tblPerson.FieldByName('P_JobCode').AsInteger then
        begin
          cmbJob.ItemIndex := i;
          Break;
        end;

    cmbGroups.ItemIndex := -1;
    if cmbGroups.Items.Count > 0 then
      for i := 0 to cmbGroups.Items.Count-1 do
        if StrToInt(Copy(cmbGroups.Items.Strings[i], 1, Pos('-', cmbGroups.Items.Strings[i])-1)) = tblPerson.FieldByName('P_ShiftGroup').AsInteger then
        begin
          cmbGroups.ItemIndex := i;
          Break;
        end;
    cmbCashType.ItemIndex := tblPerson.fieldbyname('P_CashType').AsInteger;

    cmbreserve7.ItemIndex := -1;
    if cmbreserve7.Items.Count > 0 then
      for i := 0 to cmbreserve7.Items.Count-1 do
        if cmbreserve7.Items.Strings[i]= tblPerson.FieldByName('P_reserve7').AsString
        then begin
          cmbreserve7.ItemIndex := i;
          Break;
        end;

    chkIsValid.Checked := tblPerson.FieldByName('P_IsValid').AsBoolean;
    chkprepaid.Checked := tblPerson.FieldByName('p_prepaid').AsBoolean;
    chkValidTest.Checked := tblPerson.FieldByName('P_ValidTest').AsBoolean;
    chkPricable.Checked := tblPerson.FieldByName('P_Pricable').AsBoolean;
    chkRejim.Checked := tblPerson.FieldByName('P_Rejim').AsBoolean;
    chkSobhaneh.Checked := tblPerson.FieldByName('P_Sobhaneh').AsBoolean;
    chkNahar.Checked := tblPerson.FieldByName('P_Nahar').AsBoolean;
    chkSham.Checked := tblPerson.FieldByName('P_Sham').AsBoolean;
    chkDblFood.Checked := tblPerson.FieldByName('P_DblFood').AsBoolean;
    txtCount.Enabled := chkDblFood.Checked;
    txtCount.Text := inttostr(tblPerson.FieldByName('P_dblFoodMax').asinteger);
    if chkDblFood.checked and   (txtCount.text = '0') then
      txtCount.Text := '1';
//kaveh is
{$ifdef OperatorBase}
    txtMntCount.Visible := True;
    chkMntFood.Visible := True;
    chkMntFood.Checked := tblPerson.FieldByName('P_MntFood').AsBoolean;
    txtMntCount.Enabled := chkMntFood.Checked;
    txtMntCount.Text := inttostr(tblPerson.FieldByName('P_MntFoodMax').asinteger);
    if (chkMntFood.checked) and (txtMntCount.text = '0') then
      txtMntCount.Text := '1';
{$else OperatorBase}
    txtMntCount.Visible := False;
    chkMntFood.Visible := False;
    chkMntFood.Checked := False;
    txtMntCount.Text := '0';
{$endif OperatorBase}
    if tblPerson.FieldByName('P_Picture').AsString = '' then
//      PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(FieldByName('P_BarCode').AsString) + '.jpg'
      PictureName := {g_options.ProgramPath +} F_Params.PrsImgsFld + '\' + DelLeftZero(tblPerson.FieldByName('P_BarCode').AsString) + '.jpg'
    else
//      PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_Picture').AsString;
      PictureName := {g_options.ProgramPath +} F_Params.PrsImgsFld + '\' + tblPerson.FieldByName('P_Picture').AsString;
    if (PictureName <> '') and FileExists(PictureName)
    then begin
      imgPicture.Picture.LoadFromFile(PictureName);
//      imgPicture.Width:=round(imgPicture.Height*imgPicture.Picture.Width/imgPicture.Picture.Height);
    end
    else
      imgPicture.Picture.Bitmap := nil;

//kaveh ie
    txtBarCode.SetFocus;
  end;
end;
function TfrmPersons.AreValidFields : Boolean;
begin
  if txtBarCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره پرسنلي وارد نشده است.');
    txtBarCode.SetFocus;
  end
  else if txtName.Visible and (txtName.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('نام وارد نشده است.');
    txtName.SetFocus;
  end
  else if txtFamily.Visible and (txtFamily.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('نام خانوادگي وارد نشده است.');
    txtFamily.SetFocus;
  end
  {else if cmbPart.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('بخش مشخص نشده است.');
    cmbPart.SetFocus;
  end
  else if cmbJob.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('نوع استخدام مشخص نشده است.');
    cmbJob.SetFocus;
  end}
  else if IsExistsRec_Str('Persons', 'P_BarCode', FixLeft(txtBarCode.Text, '0', 8)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblPerson.FieldByName('P_BarCode').AsString <> FixLeft(txtBarCode.Text, '0', 8)))) then
  begin
    AreValidFields := False;
    ErrorMessage('شماره پرسنلي تكراري است.');
    txtBarCode.SetFocus;
  end
  else if IsExistsRec_Str('Persons', 'P_Proxi', FixLeft(txtProxi.Text, '0', 8)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblPerson.FieldByName('P_Proxi').AsString <> FixLeft(txtProxi.Text, '0', 8)))) then
  begin
    AreValidFields := False;
    ErrorMessage('شماره كارت پرسنلي تكراري است.');
    txtProxi.SetFocus;
  end
  else if (txtCount.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('تعداد غذای اضافی وارد نشده است.');
    txtCount.SetFocus;
  end
  {else if (Flag = MB_EDIT) and (tblPerson.FieldByName('P_BarCode').AsString <> FixLeft(txtBarCode.Text, '0', 8)) and
          IsExistsRec_Str('Fish', 'Fish_PCode', tblPerson.FieldByName('P_BarCode').AsString)  then
  begin
    AreValidFields := False;
    ErrorMessage('براي اين فرد فيش صادر شده و تغيير شماره پرسنلي ميسر نيست.');
    txtBarCode.SetFocus;
  end}
  else
    AreValidFields := True;
end;




procedure TfrmPersons.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
  i : Byte;
begin
  SetWinF;
//  cmdNew.Enabled := not Linked_To_Clock;
//  cmdListNew.Enabled := not Linked_To_Clock;
//  cmdDelete.Enabled := not Linked_To_Clock;

  grpEdit.Align := alTop;
  SetDirectionFarsi(cmbPartname.Handle);
  SetDirectionFarsi(txtName.Handle);
  SetDirectionFarsi(txtFamily.Handle);
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
   connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM Parts');
    Open;
    while not EOF do
    begin
      cmbPartCode.Items.Add(FieldByName('P_CustomCode').AsString);
      cmbPartName.Items.Add(FieldByName('P_Name').AsString);
//      cmbPart.Items.Add(FieldByName('P_CustomCode').AsString + '-' + FieldByName('P_name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM building');
    Open;
    while not EOF do
    begin
      cmbBuilding.Items.Add(FieldByName('building_Code').AsString + '-' + FieldByName('building_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM JobType');
    Open;
    while not EOF do
    begin
      cmbJob.Items.Add(FieldByName('Job_Code').AsString + '-' + FieldByName('Job_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT Grp_Code, Grp_Name FROM Groups');
    Open;
    while not EOF do
    begin
      cmbGroups.Items.Add(FieldByName('Grp_Code').AsString + '-' + FieldByName('Grp_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM reserve7');
    Open;
    while not EOF do
    begin
      cmbreserve7.Items.Add(FieldByName('rsrv7_name').AsString);
      Next;
    end;
    Close;
    Free;
  end;

  ProxiCode := 0;
  for i := 1 to TotalReader do
    if Readers[i].R_Active and (Readers[i].R_Type = RDR_PROXI) then
    begin
      ProxiCode := i;
      Break;
    end;
  tblPerson.connection := frmDBS.DBConnection;
  tblPerson.Open;
  lblRecNo.Caption := ('تعداد : ' + IntToStr(tblPerson.RecordCount));

end;

procedure TfrmPersons.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
  ReOpenTable;
//kaveh is
{$ifndef OperatorBase}
  chkMntFood.Visible := False;
  txtMntCount.Visible := false;
{$else OperatorBase}
  chkMntFood.Checked := False;
  txtMntCount.Text := '1';
  txtMntCount.Enabled := false;
{$endif OperatorBase}
//kaveh is
end;

procedure TfrmPersons.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblPerson.Close;
end;

procedure TfrmPersons.tblPersonCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('Part').AsString := GetPartNam(FieldByName('P_parts').Asstring);
    FieldByName('PCode').AsString := DelLeftZero(FieldByName('P_BarCode').AsString);
  end;
end;

procedure TfrmPersons.txtSearchCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgPersons.SetFocus
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmPersons.txtSearchFamilyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgPersons.SetFocus
  end;
end;

procedure TfrmPersons.txtSearchCodeExit(Sender: TObject);
begin
ReOpenTable;
end;

procedure TfrmPersons.cmbPartCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgPersons.SetFocus
  end;
end;

procedure TfrmPersons.cmbPartCodeClick(Sender: TObject);
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

procedure TfrmPersons.cmbPartNameClick(Sender: TObject);
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

procedure TfrmPersons.cmbreserve7KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkisvalid.SetFocus;
  end;
end;

procedure TfrmPersons.dbgPersonsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Linked_To_Clock then close;

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

procedure TfrmPersons.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearScrFields;
end;

procedure TfrmPersons.cmdListNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_LIST;
  lblBarCode.Caption := ('از شماره');
  lblName.Caption := ('تا شماره');
  txtToBarCode.Top := txtName.Top;
  txtToBarCode.Visible := True;

  txtName.Visible := False;
  txtFamily.Visible := False;
  lblFamily.Visible := False;
  ClearScrFields;
end;

procedure TfrmPersons.cmdEditClick(Sender: TObject);
begin
  if tblPerson.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetScrFields;
  end;
end;

procedure TfrmPersons.cmdDeleteClick(Sender: TObject);
var
  qryF, qryFF : TAdoQuery;
begin
  if tblPerson.RecordCount > 0 then
  begin
    if not IsExistsRec_Str('Fish', 'Fish_PCode', tblPerson.FieldByName('P_BarCode').AsString) then
    begin
      if ConfirmMessage('آيا براي حذف پرسنل اطمينان داريد؟') then
      begin
        tblPerson.Delete;
//        tblPerson.Refresh;
        lblRecNo.Caption := ('تعداد : ' + IntToStr(tblPerson.RecordCount));
      end;
    end
    else if ConfirmMessage('براي اين فرد فيش صادر شده است. آيا براي حذف اطمينان داريد؟') then
    begin
      if ConfirmMessage('آيا مي خواهيد فيشهاي صادر شده براي اين فرد نيز حذف گردند ؟') then
      begin
        qryF := TAdoQuery.Create(Application);
        qryFF := TAdoQuery.Create(Application);
        qryF.connection := frmDBS.DBConnection;
        qryFF.connection := frmDBS.DBConnection;

        qryF.SQL.Clear;
        qryF.SQL.Add('SELECT * FROM Fish WHERE Fish_PCode = ''' + tblPerson.FieldByName('P_BarCode').AsString + '''');
        qryF.Open;
        while not qryF.Eof do
        begin
          qryFF.SQL.Clear;
          qryFF.SQL.Add('DELETE FROM FishFood');
          qryFF.SQL.Add('WHERE FF_Date = ''' + qryF.FieldByName('Fish_Date').AsString + '''');
          qryFF.SQL.Add('AND FF_Type = ' + qryF.FieldByName('Fish_Type').AsString);
          qryFF.SQL.Add('AND FF_FishNo = ' + qryF.FieldByName('Fish_No').AsString);
          qryFF.ExecSQL;
          qryF.Next;
        end;
        qryF.Close;
        qryF.SQL.Clear;
        qryF.SQL.Add('DELETE FROM Fish WHERE Fish_PCode = ''' + tblPerson.FieldByName('P_BarCode').AsString + '''');
        qryF.ExecSQL;
        qryF.Free;
        qryFF.Free;
      end;

      tblPerson.Delete;
//      tblPerson.Refresh;
      lblRecNo.Caption := ('تعداد : ' + IntToStr(tblPerson.RecordCount));
    end;
  end;
end;

procedure TfrmPersons.cmdFixPCodeClick(Sender: TObject);
var qry : TAdoQuery;
begin
  Mouse_Wait;
  MSG_Wait('در حال بازخواني شماره هاي پرسنلي...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
//  qry.RequestLive := True;

  qry.SQL.Clear;
  qry.SQL.Add('UPDATE persons');
  qry.SQL.Add('SET P_Proxi = STUFF(''00000000'', 8 - LEN(P_Proxi) + 1, LEN(P_Proxi), P_Proxi)');
  qry.SQL.Add('WHERE  LEN(p_PROXI) < 8');
  qry.ExecSQL;

  qry.sql.Clear;
  qry.SQL.Add('UPDATE persons');
  qry.SQL.Add('SET p_isGuest = ' + IntToStr(MB_False));
  qry.SQL.Add('WHERE  p_isGuest is null');
  qry.ExecSQL;

//  qry.SQL.Add('SELECT * FROM Persons');
//  qry.Open;
//  while not qry.Eof do
//  begin
//    qry.Edit;
//    qry.FieldByName('P_BarCode').AsString := FixLeft(qry.FieldByName('P_BarCode').AsString, '0', 8);
//    qry.FieldByName('P_Proxi').AsString := FixLeft(qry.FieldByName('P_Proxi').AsString, '0', 8);
//    qry.FieldByName('P_IsGuest').AsBoolean := (qry.FieldByName('P_IsGuest').AsBoolean = True);
//    qry.Post;
//    qry.Next;
//  end;
//  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('UPDATE Fish');
  qry.SQL.Add('SET Fish_PCode = STUFF(''00000000'', 8 - LEN(Fish_PCode) + 1, LEN(Fish_PCode), Fish_PCode)');
  qry.SQL.Add('WHERE LEN(Fish_PCode) < 8');
  qry.ExecSQL;

//  qry.SQL.Add('SELECT * FROM Fish');
//  qry.Open;
//  while not qry.Eof do
//  begin
//    qry.Edit;
//    qry.FieldByName('Fish_PCode').AsString := FixLeft(qry.FieldByName('Fish_PCode').AsString, '0', 8);
//    qry.Post;
//    qry.Next;
//  end;
//  qry.Close;

  qry.SQL.Clear;

  qry.SQL.Add('UPDATE DblFish');
  qry.SQL.Add('SET DBL_PCode = STUFF(''00000000'', 8 - LEN(DBL_PCode) + 1, LEN(DBL_PCode), DBL_PCode)');
  qry.SQL.Add('WHERE LEN(DBL_PCode) < 8');
  qry.ExecSQL;

//  qry.SQL.Add('SELECT * FROM DblFish');
//  qry.Open;
//  while not qry.Eof do
//  begin
//    qry.Edit;
//    qry.FieldByName('DBL_PCode').AsString := FixLeft(qry.FieldByName('DBL_PCode').AsString, '0', 8);
//    qry.Post;
//    qry.Next;
////    qry.Tag;
//  end;
  qry.Close;
  qry.Free;
  tblPerson.Requery([eoAsyncFetch]);
//  ReOpenTable;
  lblRecNo.Caption := ('تعداد : ' + IntToStr(tblPerson.RecordCount));
  Mouse_NoWait;
  MSG_NoWait;

end;

procedure TfrmPersons.txtBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtToBarCode.Visible then
      txtToBarCode.SetFocus
    else
      txtProxi.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmPersons.txtCountKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key)
end;

procedure TfrmPersons.txtToBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;

  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmPersons.txtProxiKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else
    Keyboard_Proxi(Key);
end;

procedure TfrmPersons.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtFamily.SetFocus;
  end;
end;

procedure TfrmPersons.txtFamilyKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;

  end;
end;

procedure TfrmPersons.txtMntCountKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key)
end;

procedure TfrmPersons.cmbPartKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbJob.SetFocus;
  end;
end;

procedure TfrmPersons.cmbPartKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;

  end;
end;

procedure TfrmPersons.cmbJobKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbGroups.SetFocus;
  end;
end;

procedure TfrmPersons.cmbJobKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJob.ItemIndex := -1;
  end;
end;

procedure TfrmPersons.cmbGroupsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkIsValid.SetFocus;
  end;
end;

procedure TfrmPersons.cmbGroupsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbGroups.ItemIndex := -1;
  end;
end;

procedure TfrmPersons.chkIsValidKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkValidTest.SetFocus;
  end;
end;

procedure TfrmPersons.chkMntFoodClick(Sender: TObject);
begin
  txtMntCount.Enabled := chkMntFood.Checked;
  if chkMntFood.Checked and (txtMntCount.Text='0') then
    txtMntCount.Text := '1';
end;

procedure TfrmPersons.chkValidTestKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkPricable.SetFocus;
  end;
end;

procedure TfrmPersons.chkPricableClick(Sender: TObject);
begin
if chkPricable.Checked   then
begin
chkprepaid.Visible:=true;
end else
begin
chkprepaid.Visible:=false;
end;
end;

procedure TfrmPersons.chkPricableKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkDblFood.SetFocus;
  end;
end;

procedure TfrmPersons.BitBtn2Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);
end;

procedure TfrmPersons.chkDblFoodClick(Sender: TObject);
begin
  txtCount.Enabled := chkDblFood.Checked;
  if chkDblFood.Checked and (txtCount.Text='0') then
    txtCount.Text := '1';
end;

procedure TfrmPersons.chkDblFoodKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkRejim.SetFocus;
  end;
end;

procedure TfrmPersons.chkRejimKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSobhaneh.SetFocus;
  end;
end;

procedure TfrmPersons.chkSobhanehKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkNahar.SetFocus;
  end;
end;

procedure TfrmPersons.chkNaharKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSham.SetFocus;
  end;
end;

procedure TfrmPersons.chkShamKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmPersons.tmrProxiTimer(Sender: TObject);
var
  PK : String;
  ComState : Byte;
begin
  if ProxiCode <> 0 then
  begin
    if SwitchReader(ProxiCode) then
    begin
      MakeProxiPocket(PK, $09, $01, '');
      if SendProxiPocket(PK) then
      begin
        Delay(500);
        GetProxiPocket(PK, ComState);
        if ComState = 0 then
          if Length(PK) >= 10 then
          begin
            txtProxi.Text := Copy(PK, 5, 9);
          end;
      end;
    end;
  end;
end;

procedure TfrmPersons.cmdSaveClick(Sender: TObject);
var
  Code : LongInt;
  LastCode : String;
  qry : TAdoQuery;
begin
  if AreValidFields then
  begin
    frmDBS.tblPersons.Close;
    if Flag = MB_LIST then
    begin
      if txtBarCode.Text = '' then
      begin
        ErrorMessage('شماره ابتدا وارد نشده است.');
        txtBarCode.SetFocus;
      end
      else if txtToBarCode.Text = '' then
      begin
        ErrorMessage('شماره انتها وارد نشده است.');
        txtToBarCode.SetFocus;
      end
      else
      begin
        Mouse_Wait;
        Msg_Wait('در حال ايجاد پرسنل جديد...');
        for code := StrToInt(txtBarCode.Text) to StrToInt(txtToBarCode.Text) do
//          if not tblPerson.FindKey([code]) then
          if not tblPerson.Locate('P_Barcode' ,  FixLeft(IntToStr(code),'0',8) , [loPartialKey]) then
          begin
            tblPerson.Append;
            tblPerson.FieldByName('P_BarCode').AsString := FixLeft(IntToStr(code), '0', 8);
            if txtProxi.Text = '' then
              tblPerson.FieldByName('P_Proxi').AsString := tblPerson.FieldByName('P_BarCode').AsString
            else
              tblPerson.FieldByName('P_Proxi').AsString := txtProxi.Text;

            tblPerson.FieldByName('P_Name').AsString := '';
            tblPerson.FieldByName('P_Family').AsString := '';
            if txtParts.Text <> '' then
              tblPerson.FieldByName('P_Parts').AsString := GetPartCode(PartCode)
            else
              tblPerson.FieldByName('P_parts').AsInteger := 0;
            if cmbBuilding.Text <> '' then
              tblPerson.FieldByName('P_building').AsInteger := StrToInt(Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1))
            else
              tblPerson.FieldByName('P_building').AsInteger := 0;
            if cmbJob.Text <> '' then
              tblPerson.FieldByName('P_JobCode').AsInteger := StrToInt(Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1))
            else
              tblPerson.FieldByName('P_JobCode').AsInteger := 0;
            if cmbGroups.Text <> '' then
              tblPerson.FieldByName('P_ShiftGroup').AsInteger := StrToInt(Copy(cmbGroups.Text, 1, Pos('-', cmbGroups.Text)-1))
            else
              tblPerson.FieldByName('P_ShiftGroup').AsInteger := 0;

            if cmbCashType.Text <> '' then
              tblPerson.FieldByName('P_CashType').AsInteger := cmbCashType.ItemIndex
            else
            tblPerson.FieldByName('P_CashType').AsInteger := 0;
            tblPerson.FieldByName('P_reserve7').Asstring := cmbreserve7.Text;
            tblPerson.FieldByName('P_IsValid').AsBoolean := chkIsValid.Checked;
            tblPerson.FieldByName('P_ValidTest').AsBoolean := chkValidTest.Checked;
            tblPerson.FieldByName('P_Pricable').AsBoolean := chkPricable.Checked;
            tblPerson.FieldByName('P_Sobhaneh').AsBoolean := chkSobhaneh.Checked;
            tblPerson.FieldByName('P_Nahar').AsBoolean := chkNahar.Checked;
            tblPerson.FieldByName('P_Sham').AsBoolean := chkSham.Checked;
             if  chkPricable.Checked =false then
              begin
              tblPerson.FieldByName('P_Prepaid').AsBoolean :=false;
              end else
              begin
              tblPerson.FieldByName('P_Prepaid').AsBoolean := chkprepaid.Checked  ;
              end;
            tblPerson.FieldByName('P_Rejim').AsBoolean := False;
            tblPerson.FieldByName('P_IsGuest').AsBoolean := False;
            tblPerson.FieldByName('P_dblFoodMax').AsInteger := StrToInt(txtCount.Text);
            if tblPerson.FieldByName('P_dblFoodMax').AsInteger = 0 then
              chkDblFood.Checked := false;
            tblPerson.FieldByName('P_DblFood').AsBoolean := chkDblFood.Checked;
            tblPerson.FieldByName('P_Rejim').AsBoolean := chkRejim.Checked;
//kaveh is
{$ifdef OperatorBase}
            tblPerson.FieldByName('P_MntFoodMax').AsInteger := StrToInt(txtMntCount.Text);
            if tblPerson.FieldByName('P_MntFoodMax').AsInteger = 0 then
              chkMntFood.Checked := false;
            tblPerson.FieldByName('P_MntFood').AsBoolean := chkMntFood.Checked;
{$endif OperatorBase}
            if PictureName = '' then
              tblPerson.FieldByName('P_Picture').AsString := DelLeftZero(tblPerson.FieldByName('P_BarCode').AsString) + '.jpg'
            else
              tblPerson.FieldByName('P_Picture').AsString := ExtractFileName(PictureName);
//kaveh ie
            tblPerson.Post;
//            tblPerson.FlushBuffers;
            lblRecNo.Caption := ('تعداد : ' + IntToStr(tblPerson.RecordCount));
          end;
        Mouse_NoWait;
        Msg_NoWait;
        FormInEdit(False);
        dbgPersons.SetFocus;
      end;
    end
    else
    begin
      if Flag = MB_NEW then
      BEGIN
        tblPerson.Append;
        tblPerson.FieldByName('P_Credit').AsInteger := 0;
      END
      else if Flag = MB_EDIT then
      begin
        LastCode := tblPerson.FieldByName('P_BarCode').AsString;
        tblPerson.Edit;

      end;


      tblPerson.FieldByName('P_BarCode').AsString := FixLeft(txtBarcode.Text, '0', 8);
      if txtProxi.Text = '' then
        tblPerson.FieldByName('P_Proxi').AsString := tblPerson.FieldByName('P_BarCode').AsString
      else
        tblPerson.FieldByName('P_Proxi').AsString := txtProxi.Text;

      tblPerson.FieldByName('P_Name').AsString := txtName.Text;
      tblPerson.FieldByName('P_Family').AsString := txtFamily.Text;

      if txtParts.Text <> '' then
        tblPerson.FieldByName('P_parts').Asstring :=GetPartCode(partcode)
      else
        tblPerson.FieldByName('P_parts').Asstring := '0';

      if cmbBuilding.Text <> '' then
        tblPerson.FieldByName('P_building').AsInteger := StrToInt(Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1))
      else
        tblPerson.FieldByName('P_building').AsInteger := 0;

      if cmbJob.Text <> '' then
        tblPerson.FieldByName('P_JobCode').AsInteger := StrToInt(Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1))
      else
        tblPerson.FieldByName('P_JobCode').AsInteger := 0;

      if cmbGroups.Text <> '' then
        tblPerson.FieldByName('P_ShiftGroup').AsInteger := StrToInt(Copy(cmbGroups.Text, 1, Pos('-', cmbGroups.Text)-1))
      else
        tblPerson.FieldByName('P_ShiftGroup').AsInteger := 0;
      if cmbCashType.Text <> '' then
        tblPerson.FieldByName('P_CashType').AsInteger := cmbCashType.ItemIndex
      else
        tblPerson.FieldByName('P_CashType').AsInteger := 0;
      tblPerson.FieldByName('P_reserve7').Asstring := cmbreserve7.Text;
      tblPerson.FieldByName('P_IsValid').AsBoolean := chkIsValid.Checked;
      tblPerson.FieldByName('P_ValidTest').AsBoolean := chkValidTest.Checked;
      tblPerson.FieldByName('P_Pricable').AsBoolean := chkPricable.Checked;
      tblPerson.FieldByName('P_Sobhaneh').AsBoolean := chkSobhaneh.Checked;
      tblPerson.FieldByName('P_Nahar').AsBoolean := chkNahar.Checked;
      tblPerson.FieldByName('P_Sham').AsBoolean := chkSham.Checked;
      tblPerson.FieldByName('P_Rejim').AsBoolean := False;
      tblPerson.FieldByName('P_IsGuest').AsBoolean := False;
      tblPerson.FieldByName('P_dblFoodMax').AsInteger := StrToInt(txtCount.Text);
      if tblPerson.FieldByName('P_dblFoodMax').AsInteger = 0 then
        chkDblFood.Checked := false;
      tblPerson.FieldByName('P_DblFood').AsBoolean := chkDblFood.Checked;
      tblPerson.FieldByName('P_Rejim').AsBoolean := chkRejim.Checked;
//kaveh is
{$ifdef OperatorBase}
      tblPerson.FieldByName('P_MntFoodMax').AsInteger := StrToInt(txtMntCount.Text);
      if tblPerson.FieldByName('P_MntFoodMax').AsInteger = 0 then
        chkMntFood.Checked := false;
      tblPerson.FieldByName('P_MntFood').AsBoolean := chkMntFood.Checked;
{$endif OperatorBase}
      if PictureName = '' then
        tblPerson.FieldByName('P_Picture').AsString := DelLeftZero(tblPerson.FieldByName('P_BarCode').AsString) + '.jpg'
      else
        tblPerson.FieldByName('P_Picture').AsString := ExtractFileName(PictureName);
//kaveh ie
      if  chkPricable.Checked =false then
      begin
        tblPerson.FieldByName('P_Prepaid').AsBoolean :=false;
      end
      else if  chkPricable.Checked =true then
      begin
        tblPerson.FieldByName('P_Prepaid').AsBoolean := chkprepaid.Checked  ;
      end;
      tblPerson.Post;
//      tblPerson.FlushBuffers;
      lblRecNo.Caption := ('تعداد : ' + IntToStr(tblPerson.RecordCount));

      if Flag = MB_NEW then
      begin
        {ClearScrFields;}
        txtBarCode.Text := IntToStr(StrToInt(txtBarCode.Text) + 1);
        txtProxi.Text := '';
        txtName.Text := '';
        txtFamily.Text := '';

        PictureName := ''; //kaveh
        imgPicture.Picture.Bitmap := nil; //kaveh

        txtBarCode.SetFocus;
      end
      else
      begin
        txtBarcode.Text := FixLeft(txtBarcode.Text, '0', 8);
        if LastCode <> txtBarcode.Text then
        begin
          qry := TAdoQuery.Create(Application);
          qry.connection := frmDBS.DBConnection;
//          qry.RequestLive := True;
          qry.SQL.Clear;
          qry.SQL.Add('UPDATE Fish SET Fish_PCode = ''' + txtBarcode.Text + '''');
          qry.SQL.Add('WHERE Fish_PCode = ''' + LastCode + '''');
          qry.ExecSQL;

          qry.SQL.Clear;
          qry.SQL.Add('UPDATE DblFish SET DBL_PCode = ''' + txtBarcode.Text + '''');
          qry.SQL.Add('WHERE DBL_PCode = ''' + LastCode + '''');
          qry.ExecSQL;

          qry.SQL.Clear;
          qry.SQL.Add('UPDATE OutGroup SET OG_PCode = ''' + txtBarcode.Text + '''');
          qry.SQL.Add('WHERE OG_PCode = ''' + LastCode + '''');
          qry.ExecSQL;

          if tblExists(g_options.ClockDBS) then
          begin
            qry.SQL.Clear;
            qry.SQL.Add('UPDATE ' + g_options.ClockDBS + ' SET Clock_BarCode = ''' + txtBarcode.Text + '''');
            qry.SQL.Add('WHERE Clock_BarCode = ''' + LastCode + '''');
            qry.ExecSQL;
          end;
          qry.Free;
        end;

        FormInEdit(False);
        dbgPersons.SetFocus;
      end;
    end;
    frmDBS.tblPersons.Open;
  end;
end;

procedure TfrmPersons.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgPersons.SetFocus;
end;

















procedure TfrmPersons.cmbBuildingKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbBuilding.ItemIndex := -1;
  end;
end;

procedure TfrmPersons.cmbBuildingKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbBuilding.SetFocus;
  end;
end;

procedure TfrmPersons.txtsearchcardKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgPersons.SetFocus
  end
  else
    Keyboard_Proxi(Key);
end;

procedure TfrmPersons.tblPersonFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
 { with DataSet do
  begin
    accept := not FieldByName('P_IsGuest').AsBoolean;
    if cmbPartCode.Text <> '' then
      accept := accept and (FieldByName('P_parts').AsString =  cmbPartCode.Text);
    if txtSearchCode.Text <> '' then
      accept := accept and (pos(txtSearchCode.Text,FieldByName('P_BarCode').AsString) <> 0);
    if txtSearchFamily.Text <> '' then
      accept := accept and (pos(txtSearchFamily.Text,FieldByName('P_Family').AsString) <> 0);
    if txtSearchCard.Text <> '' then
      accept := accept and (pos(txtSearchcard.Text,FieldByName('P_proxi').AsString) <> 0);
  end; }
end;

end.
