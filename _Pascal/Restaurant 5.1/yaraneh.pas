unit yaraneh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard, DBCtrls;

type
  TfrmYaraneh = class(TForm)
    grpAll: TGroupBox;
    dbgYaraneh: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaYaraneh: TDataSource;
    qryYaraneh: TADOQuery;
    GroupBox1: TGroupBox;
    rdoJob: TRadioButton;
    rdoAll: TRadioButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    cmbMonth: TComboBox;
    txtWorkDays: TEdit;
    txtAteYaraneh: TEdit;
    txtNotAteYaraneh: TEdit;
    rdoOne: TRadioButton;
    cmbBarCode: TComboBox;
    Label5: TLabel;
    cmbName: TComboBox;
    cmbJob: TComboBox;
    Label4: TLabel;
    cmbYear: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgYaranehKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure rdoOneClick(Sender: TObject);
    procedure cmbBarCodeClick(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbNameClick(Sender: TObject);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmYaraneh.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  if vis then
    grpEdit.Align := alBottom
  else
    grpEdit.Align := alNone;
  grpEdit.Visible := vis;    

//  if vis then
//    Height := grpAll.Height + grpEdit.Height
//  else
//    Height := grpAll.Height;
//  //Height := Height + 25;
//  Height := Height + 35;
end;

procedure TfrmYaraneh.rdoOneClick(Sender: TObject);
begin
  with Sender as TRadioButton do
  begin
    cmbBarCode.ItemIndex := -1;
    cmbName.ItemIndex := -1;
    cmbJob.ItemIndex := -1;
    cmbBarCode.Enabled := (Name='rdoOne');
    cmbName.Enabled := (Name='rdoOne');
    cmbJob.Enabled := (Name='rdoJob');
  end;
end;

function TfrmYaraneh.AreValidFields : Boolean;
var
  qry : TAdoQuery;

begin
  AreValidFields := True;
  if (rdoOne.Checked) and (cmbBarCode.ItemIndex = -1) then
  begin
    AreValidFields := False;
    ErrorMessage('شماره پرسنلی انتخاب شده صحیح نیست .');
    cmbBarCode.SetFocus;
  end
  else if (rdoJob.Checked) and (cmbJob.ItemIndex = -1) then
  begin
    AreValidFields := False;
    ErrorMessage('نوع استخدام انتخاب شده صحیح نیست .');
    cmbJob.SetFocus;
  end;
end;

procedure TfrmYaraneh.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
begin
  qryYaraneh.connection := frmDBS.DBConnection;
  qryYaraneh.Open;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;

    SQL.Add('SELECT P_BarCode, P_Name, P_Family FROM Persons where p_isGuest<>1 ');
    Open;
    while not EOF do
    begin
      cmbName.Items.Add(FieldByName('P_Family').AsString + ' - ' + FieldByName('P_Name').AsString);
      cmbBarCode.Items.Add(DelLeftZero(FieldByName('P_BarCode').AsString));
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
  end;
end;

procedure TfrmYaraneh.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmYaraneh.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  qryYaraneh.Close;
end;

procedure TfrmYaraneh.dbgYaranehKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmYaraneh.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  GroupBox1.Enabled := true;
  rdoOne.Checked := true;
//  txtCode.Text := IntToStr(GetNewNumber('Building', 'Building_Code'));
//  txtName.Text := '';
//  txtCode.SetFocus;
end;

procedure TfrmYaraneh.cmdEditClick(Sender: TObject);
begin
  if qryYaraneh.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    rdoOne.Checked := true;
    cmbBarCode.ItemIndex := cmbBarCode.Items.IndexOf(DelLeftZero(qryYaraneh.FieldByName('Y_PCode').AsString));
    cmbName.ItemIndex := cmbBarCode.ItemIndex;
    cmbMonth.Text := qryYaraneh.FieldByName('Y_Month').AsString;
    cmbYear.Text := qryYaraneh.FieldByName('Y_Year').AsString;    
    txtWorkDays.Text := qryYaraneh.FieldByName('Y_WorkDays').AsString;
    txtAteYaraneh.Text := qryYaraneh.FieldByName('Y_ateYaraneh').AsString;
    txtNotAteYaraneh.Text := qryYaraneh.FieldByName('Y_NotAteYaraneh').AsString;
    cmbMonth.SetFocus;
    GroupBox1.Enabled := false;
  end;
end;

procedure TfrmYaraneh.cmdDeleteClick(Sender: TObject);
var
  qry : TAdoQuery;
begin
  if qryYaraneh.RecordCount > 0 then
  begin
    if ConfirmMessage('آيا براي حذف  اطمينان داريد؟') then
    begin
      qry := TAdoQuery.Create(Application);
      with qry do
      begin
        connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('delete from yaraneh where y_pCode= ''' + qryYaraneh.FieldByName('Y_PCode').AsString + ''' and y_Month= ' + qryYaraneh.FieldByName('Y_month').AsString + ' and y_Year = ' + qryYaraneh.FieldByName('Y_Year').AsString);
        ExecSQL;
        qryYaraneh.Close;
        qryYaraneh.Open;
      end;
    end;
  end;
end;

procedure TfrmYaraneh.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmYaraneh.cmdSaveClick(Sender: TObject);
var
  qry : TADOQuery;
  condi,cnfrm : string;
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
    begin
      qry := TAdoQuery.Create(Application);
      with qry do
      begin
        connection := frmDBS.DBConnection;
        SQL.Clear;
        condi := ' where y_Month = ' + cmbMonth.Text + ' and y_year = ' + cmbYear.Text;
        if rdoOne.Checked then
          condi := condi + ' and y_PCode = ''' + fixleft(cmbBarCode.Text , '0',8) + ''' '
        else if rdoJob.Checked  then
          condi := condi + ' and y_PCode in (select P_Barcode from persons where p_isGuest<>1 and P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1) + ') ';

        SQL.Add('SELECT * FROM Yaraneh ' + condi);
        Open;
        if qry.RecordCount>0 then
        begin
          if rdoOne.Checked then
            cnfrm := ' رکورد مورد نظر در این ماه وجود دارد . آیا میخواهید با تنظیمات جدید بازنویسی گردد؟'
          else
            cnfrm :=  ' تعداد ' + IntToStr(qry.RecordCount) + 'رکورد در این ماه وجود دارد . آیا میخواهید با تنظیمات جدید بازنویسی گردند؟';
          if ConfirmMessage(cnfrm) then
          begin
            close;
            SQL.Clear;
            SQL.Add('Delete FROM Yaraneh ' + condi);
            ExecSQL;
            close;
          end
          else
            exit;
        end;
        SQL.Clear;
        SQL.Add('SELECT p_Barcode FROM persons where p_isGuest<>1 ');
        if rdoOne.Checked then
          SQL.Add(' and P_BarCode = ''' + fixleft(cmbBarCode.Text , '0',8) + '''')
        else if rdoJob.Checked  then
          SQL.Add(' and P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));
        Open;
        qry.First;
        while not eof do
        begin
          qryYaraneh.Append;
          qryYaraneh.FieldByName('Y_PCode').AsString := fixleft(qry.FieldByName('p_Barcode').AsString,'0',8);
          qryYaraneh.FieldByName('Y_Month').AsInteger := StrToInt(cmbMonth.Text);
          qryYaraneh.FieldByName('Y_Year').AsInteger := StrToInt(cmbYear.Text);
          qryYaraneh.FieldByName('Y_WorkDays').AsInteger := StrToInt(txtWorkDays.Text);
          qryYaraneh.FieldByName('Y_ateYaraneh').AsCurrency := StrToCurr(txtAteYaraneh.Text);
          qryYaraneh.FieldByName('Y_NotAteYaraneh').AsCurrency := StrToCurr(txtNotAteYaraneh.Text);
          try
            qryYaraneh.Post;
          except
            qryYaraneh.cancel;
          end;
          qry.Next;
        end;
      end;
    end
    else if Flag = MB_EDIT then
    begin
      qryYaraneh.Edit;
      qryYaraneh.FieldByName('Y_PCode').AsString := fixleft(cmbBarCode.Text,'0',8);
      qryYaraneh.FieldByName('Y_Month').AsInteger := StrToInt(cmbMonth.Text);
      qryYaraneh.FieldByName('Y_Year').AsInteger := StrToInt(cmbYear.Text);
      qryYaraneh.FieldByName('Y_WorkDays').AsInteger := StrToInt(txtWorkDays.Text);
      qryYaraneh.FieldByName('Y_ateYaraneh').AsCurrency := StrToCurr(txtAteYaraneh.Text);
      qryYaraneh.FieldByName('Y_NotAteYaraneh').AsCurrency := StrToCurr(txtNotAteYaraneh.Text);
      try
        qryYaraneh.Post;
      except
        qryYaraneh.cancel;
      end;
    end;
    qryYaraneh.close;
    qryYaraneh.Open;

    if (Flag = MB_NEW) and rdoOne.Checked then
    begin
      cmbBarCode.ItemIndex := -1;
      cmbBarCode.ItemIndex:= -1;
      cmbName.ItemIndex := -1;
      cmbBarCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgYaraneh.SetFocus;
    end;
  end;
end;

procedure TfrmYaraneh.cmbBarCodeClick(Sender: TObject);
begin
  cmbName.ItemIndex := cmbBarCode.ItemIndex;
end;

procedure TfrmYaraneh.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmYaraneh.cmbNameClick(Sender: TObject);
begin
  cmbBarCode.ItemIndex := cmbName.ItemIndex;
end;

procedure TfrmYaraneh.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgYaraneh.SetFocus;
end;







end.
