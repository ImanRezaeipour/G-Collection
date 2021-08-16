unit Employee;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, CheckLst, DB, ExtCtrls, ADODB, DosMove, 
  OleCtrls, Menus;

type
  TfrmEmployee = class(TForm)
    grpAll: TGroupBox;
    dbgPersons: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lbl4: TLabel;
    txtNo: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaPersons: TDataSource;
    lbl5: TLabel;
    txtName: TEdit;
    lbl6: TLabel;
    txtFamily: TEdit;
    lbl9: TLabel;
    cmbParts: TComboBox;
    lbl3: TLabel;
    cmbSearchDscnt: TComboBox;
    txtSearchCode: TEdit;
    lbl1: TLabel;
    lbl10: TLabel;
    cmbCoPosts: TComboBox;
    Bevel1: TBevel;
    lblRecNo: TLabel;
    lbl2: TLabel;
    txtSearchFamily: TEdit;
    DosMove1: TDosMove;
    cmbDiscount: TComboBox;
    lbl11: TLabel;
    btnChngAll: TBitBtn;
    chkActive: TCheckBox;
    lbl7: TLabel;
    txtID: TEdit;
    lbl8: TLabel;
    cmbDepartment: TComboBox;
    txtExpDate: TEdit;
    Label1: TLabel;
    cmdFixPCode: TBitBtn;
    adotblEmployeee: TADOQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    cmbMoRanges: TComboBox;
    adotblEmployee: TADOQuery;
    procedure adotblEmployeeCalcFields(DataSet: TDataSet);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure cmdFixPCodeClick(Sender: TObject);
    procedure dbgPersonsTitleClick(Column: TColumn);
    procedure txtExpDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtExpDateExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgPersonsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchCodeExit(Sender: TObject);
    procedure cmbPartsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbCoPostsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbSearchDscntKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmbDiscountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnChngAllClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure cmbMoRangesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Flag : Byte;
    procedure ReOpenTable;
    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
    procedure SetWinF;
    procedure  checkactive(falg: boolean) ;

  public
    { Public declarations }
  end;

var
  frmEmployee : TfrmEmployee;


implementation

uses
  Funcs, MSGs, DBS, Globals, Keyboard, FntSel{, ChngAll},DateProc,main,EditChrg,ChargGrp;

{$R *.DFM}
procedure TfrmEmployee.checkactive(falg: Boolean);

begin
  adotblEmployeee.Filtered:=true;
  adotblEmployeee.Filter:='empl_no = '+QuotedStr(adotblEmployee.FieldByName('empl_no').AsString);
  adotblEmployeee.Edit;
  adotblEmployeee.FieldByName('Empl_Active').AsBoolean := falg;
  adotblEmployeee.Post;
  adotblEmployee.Requery();
//  adotblEmployee.locate('empl_no' ,fixleft(empl,'0',8) , [LoPArtialKey]);
//  ReOpenTable;
end;

procedure TfrmEmployee.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmEmployee));

end;

procedure TfrmEmployee.ReOpenTable;
var s : String;
begin
  s := '';
  if gOptions.UserDepart <> 0 then
    s := 'Empl_Department = ' + IntToStr(gOptions.UserDepart);

//  if cmbSearchDscnt.Text <> '' then
//  begin
//    if s <> '' then s := s + ' AND ';
//    s := 'Empl_Dscnt = ' + Copy(cmbSearchDscnt.Text, 1, Pos('-', cmbSearchDscnt.Text)-1);
//  end;

  if txtSearchCode.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
    s := s + 'Empl_No LIKE ''' + FixLeft(txtSearchCode.Text,'0',8) + '''';
  end;

  if txtSearchFamily.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
    s := s + 'Empl_Family LIKE ''' + txtSearchFamily.Text + '''';
  end;

  adotblEmployee.Filtered := False;
  adotblEmployee.Filter := s;
  adotblEmployee.Filtered := True;
  lblRecNo.Caption := ('تعداد : ' + IntToStr(adotblEmployee.RecordCount));
end;

procedure TfrmEmployee.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Enabled := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;


procedure TfrmEmployee.N1Click(Sender: TObject);
begin
checkactive(true);
end;

procedure TfrmEmployee.N2Click(Sender: TObject);
begin
checkactive(false);
end;

procedure TfrmEmployee.adotblEmployeeCalcFields(DataSet: TDataSet);
begin
 with DataSet do
  begin
    if FieldByName('Empl_Active').AsBoolean then
      FieldByName('active').Asstring  := 'فعال'
    else
      FieldByName('active').Asstring   := 'غیر فعال';
  end;
end;

function TfrmEmployee.AreValidFields : Boolean;
begin
  if txtNo.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('شماره پرسنلي وارد نشده است.');
    txtNo.SetFocus;
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
  else if IsExistsRec_Str('Employee', 'Empl_No', FixLeft(txtNo.Text,'0',8)) and
          ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblEmployee.FieldByName('Empl_No').AsString <> FixLeft(txtNo.Text,'0',8)))) then
  begin
    AreValidFields := False;
    ErrorMessage('شماره پرسنلي تكراري است.');
    txtNo.SetFocus;
  end
  else
    AreValidFields := True;
end;




procedure TfrmEmployee.BitBtn1Click(Sender: TObject);
begin
  //Edit credit card charging
  if EmployeeFull then exit;
  Application.CreateForm(TfrmEditCharge, frmEditCharge);
  with frmEditCharge  do
   begin
     ADOQuery3.sql.Clear ;
  ADOQuery3.close;
  ADOQuery3.SQL.Add('SELECT * FROM ChargeGrp ');
  ADOQuery3.Open;
  ADOQuery3.First;
  while not ADOQuery3.Eof   do
  begin
  ComboBox1.Items.Add (inttostr(ADOQuery3.FieldByName('GrpCode').AsInteger));

    ADOQuery3.Next;
end;
 ADOQuery2.SQL.Clear;
    ADOQuery2.Close;
    ADOQuery2.sql.Add('select * from Employee where Empl_Active = ' + IntToStr(MB_TRUE));
    ADOQuery2.Open;

{   cmbCode.Clear ;
    cmbName.Clear ;
    ADOQuery2.First;
   while not ADOQuery2.Eof   do
    begin
      cmbCode.Items.Add(ADOQuery2.FieldByName('Empl_No').AsString);
      cmbName.items.add (ADOQuery2.FieldByName('Empl_Family').AsString + '-' +  ADOQuery2. FieldByName('Empl_Name').AsString) ;
      ADOQuery2.Next;
     end;}
    end;
   // frmEditCharge.ComboBox1.Text :=txt_Code.Text ;
   // frmEditCharge.Edit1.Text   :=txt_Code.Text ;
  frmEditCharge.Pagefind.TabIndex := 1;
//  frmEditCharge.ADOTable2.Last;
  frmEditCharge.ADOTable1.Locate('Empl_No',adotblEmployee.FieldByName('Empl_No').AsString,[loPartialKey]);
  frmEditCharge.fillgrid;
  frmEditCharge.ShowModal;
  frmEditCharge.Free;

end;

procedure TfrmEmployee.BitBtn2Click(Sender: TObject);
begin
  if EmployeeFull then exit;
  Application.CreateForm(TfrmchargGrp, frmchargGrp  );
  frmchargGrp.ShowModal;
  frmchargGrp.Free;
end;

procedure TfrmEmployee.FormCreate(Sender: TObject);
begin
  SetWinF;
  grpEdit.Align := alTop;
  adotblEmployee.Connection := frmDBS.adoConnect;
  adotblEmployeee.Connection := frmDBS.adoConnect;
  adotblEmployeee.Open;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Department');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Depart_Code = ' + IntToStr(gOptions.UserDepart));
    Open;
    while not Eof do
    begin
      cmbDepartment.Items.Add(FieldByName('Depart_Code').AsString + '-' +
                              FieldByName('Depart_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Parts');
    Open;
    while not EOF do
    begin
      cmbParts.Items.Add(FieldByName('Part_Code').AsString + '-' + FieldByName('Part_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT CoPost_Code, CoPost_Name FROM CoPosts');
    Open;
    while not EOF do
    begin
      cmbCoPosts.Items.Add(FieldByName('CoPost_Code').AsString + '-' + FieldByName('CoPost_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT MoRange_Code, MoRange_Name, MoRange_Price FROM MoRanges');
    Open;
    while not EOF do
    begin
      cmbMoRanges.Items.Add(FieldByName('MoRange_Code').AsString + '-' + FieldByName('MoRange_Name').AsString + ' (' + FieldByName('MoRange_Price').AsString + ' ریال)');
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Discount');
    Open;
    while not EOF do
    begin
      cmbSearchDscnt.Items.Add(FieldByName('Dscnt_No').AsString + '-' + FieldByName('Dscnt_Name').AsString);
      cmbDiscount.Items.Add(FieldByName('Dscnt_No').AsString + '-' + FieldByName('Dscnt_Name').AsString);
      Next;
    end;
    Close;
  end;

  adotblEmployee.Open;
  ReOpenTable;

end;

procedure TfrmEmployee.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
  ReOpenTable;
end;

procedure TfrmEmployee.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adotblEmployee.Close;
end;

procedure TfrmEmployee.txtSearchCodeExit(Sender: TObject);
begin
  ReOpenTable;
end;

procedure TfrmEmployee.dbgPersonsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmEmployee.cmdNewClick(Sender: TObject);
begin
    if EmployeeFull then exit;
    FormInEdit(True);

    Flag := MB_NEW;
    txtNo.Text := '';
    txtName.Text := '';
    txtFamily.Text := '';
    txtID.Text := '';
    txtExpDate.Text := '';
    cmbDepartment.ItemIndex := -1;
    cmbParts.ItemIndex := -1;
    cmbCoPosts.ItemIndex := -1;
    cmbMoRanges.ItemIndex := -1;
    cmbDiscount.ItemIndex := -1;
    chkActive.Checked := True;
    txtNo.SetFocus;
end;

procedure TfrmEmployee.cmdEditClick(Sender: TObject);
var
  i : Byte;
  depart : String;
begin
  if adotblEmployee.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    depart := adotblEmployee.FieldByName('Empl_Department').AsString + '-' + GetDepartmentName(adotblEmployee.FieldByName('Empl_Department').AsInteger);
    txtNo.Text := adotblEmployee.FieldByName('Empl_No').AsString;
    txtName.Text := adotblEmployee.FieldByName('Empl_Name').AsString;
    txtFamily.Text := adotblEmployee.FieldByName('Empl_Family').AsString;
    txtID.Text := adotblEmployee.FieldByName('Empl_ID').AsString;
    txtExpDate.Text := adotblEmployee.FieldByName('Empl_ExpDate').AsString;
    cmbDepartment.ItemIndex := cmbDepartment.Items.IndexOf(depart);

    cmbParts.ItemIndex := -1;
    if cmbParts.Items.Count > 0 then
      for i := 0 to cmbParts.Items.Count-1 do
        if StrToInt(Copy(cmbParts.Items.Strings[i], 1, Pos('-', cmbParts.Items.Strings[i])-1)) = adotblEmployee.FieldByName('Empl_Part').AsInteger then
        begin
          cmbParts.ItemIndex := i;
          Break;
        end;

    cmbCoPosts.ItemIndex := -1;
    if cmbCoPosts.Items.Count > 0 then
      for i := 0 to cmbCoPosts.Items.Count-1 do
        if StrToInt(Copy(cmbCoPosts.Items.Strings[i], 1, Pos('-', cmbCoPosts.Items.Strings[i])-1)) = adotblEmployee.FieldByName('Empl_CoPost').AsInteger then
        begin
          cmbCoPosts.ItemIndex := i;
          Break;
        end;

    cmbMoRanges.ItemIndex := -1;
    if cmbMoRanges.Items.Count > 0 then
      for i := 0 to cmbMoRanges.Items.Count-1 do
        if StrToInt(Copy(cmbMoRanges.Items.Strings[i], 1, Pos('-', cmbMoRanges.Items.Strings[i])-1)) = adotblEmployee.FieldByName('Empl_MoRange').AsInteger then
        begin
          cmbMoRanges.ItemIndex := i;
          Break;
        end;

      adotblEmployeee.Filtered:=true;
      adotblEmployeee.Filter:='empl_no='+QuotedStr(txtNo.Text );

//    cmbDiscount.ItemIndex := -1;
//    if cmbDiscount.Items.Count > 0 then
//      for i := 0 to cmbDiscount.Items.Count-1 do
//        if StrToInt(Copy(cmbDiscount.Items.Strings[i], 1, Pos('-', cmbDiscount.Items.Strings[i])-1)) = adotblEmployee.FieldByName('Empl_Dscnt').AsInteger then
//        begin
//          cmbDiscount.ItemIndex := i;
//          Break;
//        end;
//

    chkActive.Checked := adotblEmployee.FieldByName('Empl_Active').AsBoolean;
    txtNo.SetFocus;
  end;
end;

procedure TfrmEmployee.cmbPartsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbParts.ItemIndex := -1;
  end;
end;

procedure TfrmEmployee.cmbCoPostsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbCoPosts.ItemIndex := -1;
  end;
end;

procedure TfrmEmployee.cmdSaveClick(Sender: TObject);
var
  LastCode : String;
  rec_no:Integer;
 empl:String;
  begin
 empl:=txtNo.Text ;
 if AreValidFields then
  begin
   if Flag = MB_NEW then
     begin
      adotblEmployeee.Append;
      adotblEmployeee.FieldByName('Empl_Balance').AsCurrency := 0;

    end
    else if Flag = MB_EDIT then
    begin

     LastCode := adotblEmployeee.FieldByName('Empl_No').AsString;
     adotblEmployeee.Edit;

    end;

    adotblEmployeee.FieldByName('Empl_No').AsString := fixleft(txtNo.Text,'0',8);
    adotblEmployeee.FieldByName('Empl_Name').AsString := txtName.Text;
    adotblEmployeee.FieldByName('Empl_Family').AsString := txtFamily.Text;
    adotblEmployeee.FieldByName('Empl_ID').AsString := fixleft(txtID.Text,'0',8);
    adotblEmployeee.FieldByName('Empl_ExpDate').AsString := txtExpDate.Text;

    if cmbDepartment.Text <> '' then
      adotblEmployeee.FieldByName('Empl_Department').AsInteger := StrToInt(Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1))
    else
      adotblEmployeee.FieldByName('Empl_Department').AsInteger := 0;

    if cmbParts.Text <> '' then
      adotblEmployeee.FieldByName('Empl_Part').AsInteger := StrToInt(Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1))
    else
      adotblEmployeee.FieldByName('Empl_Part').AsInteger := 0;

    if cmbCoPosts.Text <> '' then
      adotblEmployeee.FieldByName('Empl_CoPost').AsInteger := StrToInt(Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1))
    else
      adotblEmployeee.FieldByName('Empl_CoPost').AsInteger := 0;

   if cmbDiscount.Text <> '' then
      adotblEmployeee.FieldByName('Empl_Dscnt').AsInteger := StrToInt(Copy(cmbDiscount.Text, 1, Pos('-', cmbDiscount.Text)-1))
   else
    adotblEmployeee.FieldByName('Empl_Dscnt').AsInteger := 0;

    if cmbCoPosts.Text <> '' then
      adotblEmployeee.FieldByName('Empl_CoPost').AsInteger := StrToInt(Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1))
    else
      adotblEmployeee.FieldByName('Empl_CoPost').AsInteger := 0;

    if cmbMoRanges.Text <> '' then
      adotblEmployeee.FieldByName('Empl_MoRange').AsInteger := StrToInt(Copy(cmbMoRanges.Text, 1, Pos('-', cmbMoRanges.Text)-1))
    else
      adotblEmployeee.FieldByName('Empl_MoRange').AsInteger := 0;
      
    adotblEmployeee.FieldByName('Empl_Active').AsBoolean := chkActive.Checked;
    adotblEmployeee.Post;
    lblRecNo.Caption := ('تعداد : ' + IntToStr(adotblEmployee.RecordCount));

    if Flag = MB_NEW then
    begin
      txtNo.Text := IntToStr(StrToInt(txtNo.Text) + 1);
      txtName.Text := '';
      txtFamily.Text := '';
      txtID.Text := '';
      txtExpDate.Text := '';
      txtNo.SetFocus;
    end
    else
    begin
      if LastCode <> txtNo.Text then
      begin
        with frmDBS.adoQryG do
        begin
          SQL.Clear;
          SQL.Add('UPDATE Receipt1 SET Recit1_EmplNo = ''' + txtNo.Text + '''');
          SQL.Add('WHERE Recit1_EmplNo = ''' + LastCode + '''');
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE Receipt2 SET Recit2_EmplNo = ''' + txtNo.Text + '''');
          SQL.Add('WHERE Recit2_EmplNo = ''' + LastCode + '''');
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE ChargeDtl SET DtlEmplNo = ''' + fixleft(txtNo.Text,'0',8) + '''');
          SQL.Add('WHERE DtlEmplNo = ''' + LastCode + '''');
          ExecSQL;


        end;
      end;

      FormInEdit(False);
      dbgPersons.SetFocus;
    end;
  end;
  adotblEmployee.Requery();
  adotblEmployee.locate('empl_no' ,fixleft(empl,'0',8) , [LoPArtialKey]);
  ReOpenTable;
end;

procedure TfrmEmployee.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgPersons.SetFocus;
end;



procedure TfrmEmployee.cmbSearchDscntKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmbSearchDscnt.ItemIndex := -1;
end;

procedure TfrmEmployee.cmdDeleteClick(Sender: TObject);
var rec_no:integer;
begin
rec_no:=adotblEmployee.RecNo;
  if (adotblEmployee.RecordCount > 0) and
     ConfirmMessage('در صورت وجود اعتبار و فيش براي اين شخص، كليه موارد حذف خواهد شد.'+#10+
                    'آيا براي حذف اطمينان داريد؟') then
  begin
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM Chargedtl');
      SQL.Add('WHERE dtlEmplNo = ''' + adotblEmployee.fieldByName('Empl_No').AsString + '''');
      ExecSQL;
      Close;



      SQL.Clear;
      SQL.Add('DELETE FROM Receipt1');
      SQL.Add('WHERE Recit1_EmplNo = ''' + adotblEmployee.fieldByName('Empl_No').AsString + '''');
      ExecSQL;
      Close;

      SQL.Clear;
      SQL.Add('DELETE FROM Receipt2');
      SQL.Add('WHERE Recit2_EmplNo = ''' + adotblEmployee.fieldByName('Empl_No').AsString + '''');
      ExecSQL;
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM employee');
      SQL.Add('WHERE Empl_No = ''' + adotblEmployee.fieldByName('Empl_No').AsString + '''');
      ExecSQL;
      Close;
      adotblEmployee.Requery(); 
      adotblEmployee.RecNo:=rec_no;
//      adotblEmployee.Delete;
    end;
  end;
  lblRecNo.Caption := ('تعداد : ' + IntToStr(adotblEmployee.RecordCount));
end;

procedure TfrmEmployee.cmbDiscountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbDiscount.ItemIndex := -1;
  end;
end;

procedure TfrmEmployee.cmbMoRangesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbMoRanges.ItemIndex := -1;
  end;
end;

procedure TfrmEmployee.btnChngAllClick(Sender: TObject);
begin
{  adotblEmployee.Close;
  Application.CreateForm(TfrmAllChange, frmAllChange);
  frmAllChange.ShowModal;
  frmAllChange.Free;
  adotblEmployee.Open;}
end;

procedure TfrmEmployee.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

procedure TfrmEmployee.cmbDepartmentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cmbDepartment.ItemIndex := -1;
end;

procedure TfrmEmployee.txtExpDateExit(Sender: TObject);
begin
  if txtExpDate.Text <> '' then
    txtExpDate.Text := BeautifulDate(txtExpDate.Text);
end;

procedure TfrmEmployee.txtExpDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmEmployee.dbgPersonsTitleClick(Column: TColumn);
var
  i : integer;
begin
  if Column.FieldName = 'FamilyName' then
    if pos('empl_Family',adotblEmployee.Sort) <> 0 then
      if pos(' ASC',adotblEmployee.Sort) <> 0 then
        adotblEmployee.Sort := 'empl_Family DESC'
      else
        adotblEmployee.Sort := 'empl_Family ASC'
    else
        adotblEmployee.Sort := 'empl_Family ASC'
  else
    if pos(Column.FieldName,adotblEmployee.Sort) <> 0 then
      if pos(' ASC',adotblEmployee.Sort) <> 0 then
        adotblEmployee.Sort := Column.FieldName + ' DESC'
      else
        adotblEmployee.Sort := Column.FieldName + ' ASC'
    else
        adotblEmployee.Sort := Column.FieldName + ' ASC';

  with dbgPersons do
  begin
    for i := 0 to Columns.Count - 1 do
      Columns[i].color := clWhite;
  end;
  Column.Color := clInfoBk;

end;

procedure TfrmEmployee.cmdFixPCodeClick(Sender: TObject);
var qry : TAdoQuery;
begin
  Mouse_Wait;
  MSG_Wait('در حال بازخواني شماره هاي پرسنلي...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Add('SELECT * FROM EMPLOYEE');
  qry.Open;
  while not qry.Eof do
  begin
    qry.Edit;
    qry.FieldByName('EMPL_NO').AsString := FixLeft(qry.FieldByName('EMPL_NO').AsString, '0', 8);
    qry.FieldByName('EMPL_ID').AsString := FixLeft(qry.FieldByName('EMPL_ID').AsString, '0', 8);
    qry.Post;
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM ChargeDtl');
  qry.Open;
  while not qry.Eof do
  begin
    qry.Edit;
    qry.FieldByName('DtlEmplNo').AsString := FixLeft(qry.FieldByName('DtlEmplNo').AsString, '0', 8);
    qry.Post;
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM RECEIPT1');
  qry.Open;
  while not qry.Eof do
  begin
    qry.Edit;
    qry.FieldByName('RECIT1_EMPLNO').AsString := FixLeft(qry.FieldByName('RECIT1_EMPLNO').AsString, '0', 8);
    qry.Post;
    qry.Next;
  end;
  qry.Close;

  qry.Free;
  adotblEmployee.Requery([eoAsyncFetch]);
  lblRecNo.Caption := ('تعداد : ' + IntToStr(adotblEmployee.RecordCount));
  Mouse_NoWait;
  MSG_NoWait;


end;

end.






























