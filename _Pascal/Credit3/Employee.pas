unit Employee;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, CheckLst, DB, ExtCtrls, ADODB, DosMove, 
  OleCtrls, Menus, XStringGrid, Mask;

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
    adotblEmployee: TADOQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    BooleanField1: TBooleanField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    WideStringField6: TWideStringField;
    BCDField1: TBCDField;
    BCDField2: TBCDField;
    BCDField3: TBCDField;
    BCDField4: TBCDField;
    StringField1: TStringField;
    GRID: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    adotblEmployeeEmpl_Services: TWideStringField;
    Label2: TLabel;
    cmbWeek: TComboBox;
    adotblEmployeeEmpl_Week: TIntegerField;
    txtnumber: TEdit;
    Label3: TLabel;
    txtmeli: TEdit;
    Label4: TLabel;
    txttel: TEdit;
    Label5: TLabel;
    txtaddress: TEdit;
    Label6: TLabel;
    cmbSex: TComboBox;
    lbl25: TLabel;
    adotblEmployeeempl_tel: TStringField;
    adotblEmployeeempl_address: TStringField;
    adotblEmployeeempl_meli: TStringField;
    adotblEmployeeempl_sex: TSmallintField;
    adotblEmployeeempl_number: TStringField;
    clbservice: TCheckListBox;
    Label7: TLabel;
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
    function  newpersonno: string;
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
    procedure MaskEditCellEditor1AllowEndEditEvent(Sender: TObject;
      var Key: Word; Shift: TShiftState; var EndEdit: Boolean);
    procedure cmbCoPostsExit(Sender: TObject);
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
  Funcs, MSGs, DBS, Globals, Keyboard, FntSel{, ChngAll},DateProc,main,EditChrg,ChargGrp,login;

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
    s := s + 'Empl_No LIKE ''' + txtSearchCode.Text + '%''';
  end;

  if txtSearchFamily.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
    s := s + 'Empl_Family LIKE ''' + txtSearchFamily.Text + '%''';
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
  grpAll.visible := not vis;
  grpEdit.visible := vis;

  if vis then
    grpEdit.Top:=grpAll.top +80
  else
    grpEdit.Top:=grpAll.Height;
  {
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
  }
end;


procedure TfrmEmployee.MaskEditCellEditor1AllowEndEditEvent(Sender: TObject;
  var Key: Word; Shift: TShiftState; var EndEdit: Boolean);
begin
  EndEdit := false;
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
var
  stno,left,right:string;
  n: integer;
begin
  result := True;

  if txtNo.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('کد وارد نشده است.');
    txtNo.SetFocus;
    exit;
  end;
  if txtName.Visible and (txtName.Text = '') then
  begin
    result := False;
    ErrorMessage('نام وارد نشده است.');
    txtName.SetFocus;
    exit;
  end;
  if txtFamily.Visible and (txtFamily.Text = '') then
  begin
    result := False;
    ErrorMessage('نام خانوادگي وارد نشده است.');
    txtFamily.SetFocus;
    exit;
  end;
  if IsExistsRec_Str('Employee', 'Empl_No', FixLeft(txtNo.Text,'0',8)) and
          ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblEmployee.FieldByName('Empl_No').AsString <> FixLeft(txtNo.Text,'0',8)))) then
  begin
    result := False;
    ErrorMessage('کد تكراري است.');
    txtNo.SetFocus;
    exit;
  end;

  if cmbCoPosts.ItemIndex<0
  then begin
      ErrorMessage('جایگاه تعیین نشده است .');
      cmbCoPosts.SetFocus;
      result:=false;
      exit;
  end;

  if cmbweek.ItemIndex<0
  then begin
      ErrorMessage('برنامه هفتگی تعیین نشده است');
      cmbweek.SetFocus;
      result:=false;
      exit;
  end;

  if cmbSex.ItemIndex<0
  then begin
      ErrorMessage('جنسیت تعیین نشده است .');
      cmbSex.SetFocus;
      result:=false;
      exit;
  end;

  if cmbweek.ItemIndex>=0
  then if cmbsex.ItemIndex>=0
  then begin
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM weeks');
      SQL.Add('WHERE w_code = ' + copy(cmbweek.Text,1,pos('-',cmbweek.Text)-1) + '');
      Open;
      if RecordCount > 0
      then begin
           if fieldbyname('w_sex').asinteger<>cmbsex.ItemIndex
           then begin
              ErrorMessage('جنسیت فرد با برنامه هفتگی همخوانی ندارد');
              txtName.SetFocus;
              result:=false;
           end;
      end;
      Close;
    end;
    if result=false then exit;
  end;

  stno:=txtno.Text;
  if length(stno)<>8
  then begin
      ErrorMessage('طول کد 8 رقم باید باشد');
      txtNo.SetFocus;
      result:=false;
      exit;
  end;

  if cmbCoPosts.Text=''
  then n:=0
  else begin
       n:=strtoint(copy(cmbCoPosts.text,1,2));
  end;
//  case n of
//       1:left:='11';
//       2:left:='22';
//       3:left:='33';
//       4:left:='44';
//       5:left:='55';
//       6:left:='66';
//       7:left:='77';
//       8:left:='88';
//       9:left:='99';
//       else left:='00';
//  end;
  left := FixLeft(inttostr(n),'0',2);
  if left<>copy(stno,1,2)
  then begin
      ErrorMessage('دورقم سمت چپ کد صحیح نیست');
      txtNo.SetFocus;
      result:=false;
      exit;
  end;
  right:=copy(stno,3,6);
  if (strtoint(right)-101) mod 7 <> 0
  then begin
      ErrorMessage('شش رقم سمت راست کد صحیح نیست');
      txtNo.SetFocus;
      result:=false;
      exit;
  end;

  if (result=True) and (Flag = MB_NEW)
  then begin
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM Employee');
      SQL.Add('WHERE Empl_Name = ''' + txtName.Text + '''');
      SQL.Add('and Empl_Family = ''' + txtFamily.Text + '''');
      Open;
      if RecordCount > 0
      then begin
        result:= ConfirmMessage('نام و فامیلی این شخص تکراری است . آیا ثبت شود؟');
      end;
      Close;
    end;
    if result=false then exit;
  end;

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
//  grpEdit.Align := alTop;
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
    SQL.Add('SELECT * FROM Discount');
    Open;
    while not EOF do
    begin
      cmbSearchDscnt.Items.Add(FieldByName('Dscnt_No').AsString + '-' + FieldByName('Dscnt_Name').AsString);
      cmbDiscount.Items.Add(FieldByName('Dscnt_No').AsString + '-' + FieldByName('Dscnt_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Weeks');
    if gOptions.UserDepart > 0 then
      SQL.Add('WHERE w_Code = ' + IntToStr(gOptions.UserDepart));
    Open;
    while not Eof do
    begin
      cmbWeek.Items.Add(FieldByName('W_Code').AsString + '-' +
                              FieldByName('W_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM services');
    Open;
    while not Eof do
    begin
      clbservice.Items.Add(FieldByName('S_Code').AsString + '-' +
                              FieldByName('S_Name').AsString);
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

function TfrmEmployee.newpersonno: string;
var
  qry : TAdoQuery;
  stno,left,right : string;
  n : integer;
begin
    {
    stno := txtno.Text;
    if stno=''
    then begin
      result := '00000101';
    end;
    }
  if cmbCoPosts.Text=''
  then n:=0
  else begin
       n:=strtoint(copy(cmbCoPosts.text,1,2));
  end;
//    case n of
//         1:left:='11';
//         2:left:='22';
//         3:left:='33';
//         4:left:='44';
//         5:left:='55';
//         6:left:='66';
//         7:left:='77';
//         8:left:='88';
//         9:left:='99';
//         else left:='00';
//    end;
    left := FixLeft(inttostr(n),'0',2);
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    qry.SQL.Add('SELECT max(empl_no)as maxno FROM EMPLOYEE');
    qry.SQL.Add('where empl_no like '''+left+'%''');
    qry.Open;
    if not qry.Eof
    then begin
      stno:= qry.fieldbyname('maxno').asstring;
      if stno=''
      then stno:=left+'000094';
      left:=copy(stno,1,2);
      right:=copy(stno,3,6);
      if right='' then right:='101';
      right:=inttostr(strtoint(right)+7);
      while length(right)<6 do right:='0'+right;
      result := left+right;
    end
    else begin
       result:=left+'000101';
    end;
    qry.Close;
    qry.Free;
end;

procedure TfrmEmployee.cmdNewClick(Sender: TObject);
begin
    if EmployeeFull then exit;
    FormInEdit(True);

    Flag := MB_NEW;
    txtName.Text := '';
    txtFamily.Text := '';
    txtID.Text := '';
    txtExpDate.Text := '';
    txtnumber.Text:='';
    txtmeli.Text:='';
    txttel.Text:='';
    txtaddress.Text:='';
    cmbsex.ItemIndex:=-1;
    cmbDepartment.ItemIndex := -1;
    cmbParts.ItemIndex := -1;
    cmbCoPosts.ItemIndex := -1;
    cmbWeek.ItemIndex := -1;
    cmbDiscount.ItemIndex := -1;
    chkActive.Checked := True;
    txtNo.Text := newpersonno;

    if UpperCase(gOptions.UserName) = ADMIN_NAME
    then begin
      txtno.Enabled:=true;
      txtno.setfocus;
    end
    else begin
      txtid.SetFocus;
      txtno.Enabled:=false;
    end;
end;

procedure TfrmEmployee.cmdEditClick(Sender: TObject);
var
  i,j,k : Byte;
  ch : char;
  st: string;
  depart : String;
  srvc: string;
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
    txtnumber.Text:=adotblEmployee.FieldByName('Empl_Number').AsString;
    txtmeli.Text:=adotblEmployee.FieldByName('Empl_Meli').AsString;
    txttel.Text:=adotblEmployee.FieldByName('Empl_Tel').AsString;
    txtaddress.Text:=adotblEmployee.FieldByName('Empl_Address').AsString;
    cmbsex.ItemIndex:=adotblEmployee.FieldByName('Empl_Sex').AsInteger;
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

    cmbWeek.ItemIndex := -1;
    if cmbWeek.Items.Count > 0 then
      for i := 0 to cmbWeek.Items.Count-1 do
        if StrToInt(Copy(cmbWeek.Items.Strings[i], 1, Pos('-', cmbWeek.Items.Strings[i])-1)) = adotblEmployee.FieldByName('Empl_week').AsInteger then
        begin
          cmbWeek.ItemIndex := i;
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
    srvc := adotblEmployee.FieldByName('Empl_Services').AsString;
    for I := 1 to length(srvc) do
    begin
        ch:=srvc[i];
        for k:= 0 to clbservice.Count - 1 do
        begin
          st:=clbservice.Items.Strings[k];
          j:=strtoint(copy(st,1,pos('-',st)-1));
          if j=i
          then clbservice.Checked[k]:=(ch='1')
        end;
    end;
    {
    chkSrvc1.Checked := (srvc[1] = '1');
    chkSrvc2.Checked := (srvc[2] = '1');
    chkSrvc3.Checked := (srvc[3] = '1');
    chkSrvc4.Checked := (srvc[4] = '1');
    chkSrvc5.Checked := (srvc[5] = '1');
    chkSrvc6.Checked := (srvc[6] = '1');
    chkSrvc7.Checked := (srvc[7] = '1');
    }
    if UpperCase(gOptions.UserName) = ADMIN_NAME
    then begin
      txtno.Enabled:=true;
      txtid.setfocus;
    end
    else begin
      txtid.SetFocus;
      txtno.Enabled:=false;
    end;
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

procedure TfrmEmployee.cmbCoPostsExit(Sender: TObject);
begin
   txtno.Text:=newpersonno;
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
  srvc: string;
  i,j: integer;
  st : string;
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
    adotblEmployeee.FieldByName('Empl_Number').AsString := txtNumber.Text;
    adotblEmployeee.FieldByName('Empl_Meli').AsString := txtMeli.Text;
    adotblEmployeee.FieldByName('Empl_Tel').AsString := txtTel.Text;
    adotblEmployeee.FieldByName('Empl_Address').AsString := txtAddress.Text;
    adotblEmployeee.FieldByName('Empl_Sex').AsInteger := cmbsex.Itemindex;

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
      adotblEmployeee.FieldByName('Empl_week').AsInteger := StrToInt(Copy(cmbWeek.Text, 1, Pos('-', cmbWeek.Text)-1))
    else
      adotblEmployeee.FieldByName('Empl_week').AsInteger := 0;

    adotblEmployeee.FieldByName('Empl_Active').AsBoolean := chkActive.Checked;

    srvc := '';
    for i:=1 to 50 do
      srvc:=srvc+'0';
    for i:=0 to clbservice.Count-1 do
    begin
        st:=clbservice.Items.Strings[i];
        j:=strtoint(copy(st,1,pos('-',st)-1));
        if clbservice.Checked[i]
        then srvc[j]:='1';
    end;
    {
    if chkSrvc1.Checked then
    srvc[1] := '1';
    if chkSrvc2.Checked then
    srvc[2] := '1';
    if chkSrvc3.Checked then
    srvc[3] := '1';
    if chkSrvc4.Checked then
    srvc[4] := '1';
    if chkSrvc5.Checked then
    srvc[5] := '1';
    if chkSrvc6.Checked then
    srvc[6] := '1';
    if chkSrvc7.Checked then
    srvc[7] := '1';
    }
    adotblEmployeee.FieldByName('Empl_Services').AsString := srvc;

    if cmbWeek.Text <> '' then
      adotblEmployeee.FieldByName('Empl_Week').AsInteger := StrToInt(Copy(cmbWeek.Text, 1, Pos('-', cmbWeek.Text)-1))
    else
      adotblEmployeee.FieldByName('Empl_Week').AsInteger := 0;

    adotblEmployeee.Post;
    lblRecNo.Caption := ('تعداد : ' + IntToStr(adotblEmployee.RecordCount));

    if Flag = MB_NEW then
    begin
      txtNo.Text := newpersonno;
      txtName.Text := '';
      txtFamily.Text := '';
      txtID.Text := '';
      txtExpDate.Text := '';
      txtnumber.Text:='';
      txtmeli.Text:='';
      txttel.Text:='';
      txtaddress.Text:='';
      cmbsex.ItemIndex:=-1;
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
      if rec_no <= adotblEmployee.RecordCount  then
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
  MSG_Wait('در حال بازخواني کد هاي پرسنلي...');
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






























