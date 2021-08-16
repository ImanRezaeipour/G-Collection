unit DscntDtl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, DosMove;

type
  TfrmDscntDtl = class(TForm)
    grpAll: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    GrpEdit: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    txtPercent: TEdit;
    txtLimit: TEdit;
    lbl3: TLabel;
    grpCredType: TGroupBox;
    rdoDaily: TRadioButton;
    rdoDate: TRadioButton;
    txtsDate: TEdit;
    lblFrom: TLabel;
    lblTo: TLabel;
    txteDate: TEdit;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    txtCode: TEdit;
    lbl0: TLabel;
    lbl4: TLabel;
    dbgDscntDtl: TDBGrid;
    dtaDscntDtl: TDataSource;
    atblDscntDtl: TADOTable;
    atblDscntDtlDscntDtl_No: TIntegerField;
    atblDscntDtlDscntDtl_Service: TIntegerField;
    atblDscntDtlDscntDtl_Percent: TIntegerField;
    atblDscntDtlDscntDtl_Limit: TIntegerField;
    atblDscntDtlDscntDtl_SDate: TWideStringField;
    atblDscntDtlDscntDtl_eDate: TWideStringField;
    atblDscntDtlDscntDtl_Daily: TBooleanField;
    atblDscntDtlDaily: TStringField;
    cmbService: TComboBox;
    atblDscntDtlDscntDtl_GrpNo: TIntegerField;
    atblDscntDtlSrvc: TStringField;
    DosMove1: TDosMove;
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure atblDscntDtlCalcFields(DataSet: TDataSet);
    procedure rdoDailyClick(Sender: TObject);
    procedure rdoDateClick(Sender: TObject);
    procedure txtsDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtsDateExit(Sender: TObject);
    procedure txteDateExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Grp_Code : integer;
    Grp_Name : string;
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
    function  SaveData : Boolean;
    procedure SetWinF;
    function  IsExistRec2Num(tblName , fld1 ,fld2, val1 , val2 : string) : boolean;
  end;

var
  frmDscntDtl: TfrmDscntDtl;

implementation

uses
    Funcs, MSGs, DBS, Keyboard, Calendar, DateProc, FntSel;

{$R *.dfm}

{ TfrmDscntDtl }

function TfrmDscntDtl.AreValidFields: Boolean;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM DscntDtl WHERE DscntDtl_GrpNo = ' + IntToStr(Grp_Code));
    SQL.Add('AND DscntDtl_Service = ' + Copy(cmbService.Text , 1 , Pos('-' , cmbService.Text)-1));
    Open;
  end;

  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if cmbService.ItemIndex < 0 then
  begin
    AreValidFields := False;
    ErrorMessage('Œœ„«  „Ê—œ ‰Ÿ— Ê«—œ ‰‘œÂ «” .');
    cmbService.SetFocus;
  end
  else if txtPercent.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('„ﬁœ«—  Œ›Ì› Ê«—œ ‰‘œÂ «” .');
    txtPercent.SetFocus;
  end
  else if txtLimit.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('Õœ „Ã«“ Ê«—œ ‰‘œÂ «” .');
    txtLimit.SetFocus;
  end
  else if rdoDate.Checked then
  begin
    if not IsTrueDate(txtsDate.Text) then
    begin
      AreValidFields := False;
      ErrorMessage(' «—ÌŒ ‘—Ê⁄ «‘ »«Â «”  .');
      txtsDate.SetFocus;
    end
    else if not IsTrueDate(txteDate.Text) then
    begin
      AreValidFields := False;
      ErrorMessage(' «—ÌŒ Å«Ì«‰ «‘ »«Â «”  .');
      txteDate.SetFocus;
    end
    else if not (txtsDate.Text < txteDate.Text) then
    begin
      AreValidFields := False;
      ErrorMessage(' «—ÌŒ ‘—Ê⁄ «“  «—ÌŒ Å«Ì«‰ »“—ê — «”  .');
      txtsDate.SetFocus;
    end
    else
      AreValidFields := True;
  end
  else if not frmDBS.adoQryG.IsEmpty and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (IntToStr(atblDscntDtl.FieldByName('DscntDtl_service').AsInteger) <> copy(cmbService.Text , 1 , pos('-' , cmbService.Text) - 1)))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ Œœ„«   ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmDscntDtl.FormInEdit(vis: Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmDscntDtl.IsExistRec2Num(tblName, fld1, fld2, val1,
  val2: string): boolean;
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT ' + fld1 + ' , ' + fld2 + ' FROM ' + tblName);
    SQL.Add('WHERE ' + fld1 + ' = ' + Val1 + ' , ' + fld2 + ' = ' + Val2);
    Open;
    Result := (RecordCount > 0);
    Close;
  end;
end;

function TfrmDscntDtl.SaveData: Boolean;
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      atblDscntDtl.Append
    else if Flag = MB_EDIT then
      atblDscntDtl.Edit;

    atblDscntDtl.FieldByName('DscntDtl_No').AsInteger := StrToInt(txtCode.Text);
    atblDscntDtl.FieldByName('DscntDtl_GrpNo').AsInteger := Grp_Code;
    atblDscntDtl.FieldByName('DscntDtl_Service').AsString := copy(cmbService.Text , 1 , pos('-' , cmbService.Text) - 1);
    atblDscntDtl.FieldByName('DscntDtl_Percent').AsString := txtPercent.text;
    atblDscntDtl.FieldByName('DscntDtl_limit').AsString := txtLimit.text;    
    atblDscntDtl.FieldByName('DscntDtl_Daily').AsBoolean := rdoDaily.Checked;
    atblDscntDtl.FieldByName('DscntDtl_SDate').AsString := txtsDate.Text;
    atblDscntDtl.FieldByName('DscntDtl_eDate').AsString := txteDate.Text;
    atblDscntDtl.Post;
    SaveData := True;
  end
  else
    SaveData := False;
end;

procedure TfrmDscntDtl.SetWinF;
var
  i : integer;
begin
  SetFontColor(TForm(frmDscntDtl));
  Caption := (Caption);
  for i := 0 to dbgDscntDtl.Columns.Count-1 do
    dbgDscntDtl.Columns[i].Title.Caption := (dbgDscntDtl.Columns[i].Title.Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);

  lblFrom.Caption := (lblFrom.Caption);
  lblTo.Caption := (lblTo.Caption);

  lbl0.Caption := (lbl0.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);

  grpCredType.Caption := (grpCredType.Caption);
  rdoDaily.Caption := (rdoDaily.Caption);
  rdoDate.Caption := (rdoDate.Caption);

  btnSave.Caption := (btnSave.Caption);
  btnCancel.Caption := (btnCancel.Caption);
end;

procedure TfrmDscntDtl.cmdNewClick(Sender: TObject);
var
  tmp : String;
  m,y : integer;
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('DscntDtl', 'DscntDtl_No'));
  cmbService.ItemIndex := -1;
  txtPercent.Text := '';
  txtLimit.Text := '';
  tmp := CurrentDate;
  txtsDate.Text := tmp;
  m := strtoint(copy(tmp,6,2));
  y := strtoint(copy(tmp,9,2));
  txteDate.Text := copy(tmp,1,8) + inttostr(maxdays(y,m));
  rdoDaily.Checked := True;
  txtCode.SetFocus;
end;

procedure TfrmDscntDtl.cmdEditClick(Sender: TObject);
begin
  if atblDscntDtl.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;

    txtCode.Text := atblDscntDtl.FieldByName('DscntDtl_No').AsString;
    cmbService.Text := atblDscntDtl.FieldByName('DscntDtl_Service').Asstring + '-' +
                            GetServiceName(atblDscntDtl.FieldByName('DscntDtl_Service').AsInteger);

    cmbService.ItemIndex := cmbService.Items.IndexOf(cmbService.Text);

    txtPercent.Text := atblDscntDtl.FieldByName('DscntDtl_Percent').AsString;
    txtLimit.Text := atblDscntDtl.FieldByName('DscntDtl_Limit').AsString;
    txtsDate.Text := atblDscntDtl.FieldByName('DscntDtl_SDate').AsString;
    txteDate.Text := atblDscntDtl.FieldByName('DscntDtl_eDate').AsString;
    if atblDscntDtl.FieldByName('DscntDtl_Daily').AsBoolean then
    begin
      txtsDate.Enabled := false;
      txteDate.Enabled := false;
      rdoDaily.Checked := true;
    end
    else
    begin
      txtsDate.Enabled := True;
      txteDate.Enabled := True;
      rdoDate.Checked := true;
    end;

    txtCode.SetFocus;
  end;
end;

procedure TfrmDscntDtl.btnSaveClick(Sender: TObject);
begin
  if SaveData then
  begin
    if Flag = MB_NEW then
    begin
      txtCode.Text := IntToStr(GetNewNumber('DscntDtl', 'DscntDtl_No'));

      cmbService.ItemIndex := -1;
      txtPercent.Text := '';
      txtLimit.Text := '';
      txtsDate.Text := '';
      txteDate.Text := '';
      rdoDaily.Checked := true;

      txtCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgDscntDtl.SetFocus;
    end;
  end;
end;

procedure TfrmDscntDtl.btnCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgDscntDtl.SetFocus;
end;

procedure TfrmDscntDtl.cmdDeleteClick(Sender: TObject);
begin
  if atblDscntDtl.RecordCount > 0 then
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ê—ÊÂ «ÿ„Ì‰«‰ œ«—Ìœø') then
        atblDscntDtl.Delete;
end;

procedure TfrmDscntDtl.FormShow(Sender: TObject);
begin
  atblDscntDtl.Filtered := False;
  atblDscntDtl.Filter := 'DscntDtl_GrpNo = ' + inttostr(Grp_Code);
  atblDscntDtl.Filtered := true;  
  cmbService.Clear;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * From Services order by S_Code');
    Open;
    first;
    while not Eof do
    begin
      cmbService.Items.Add(FieldByName('S_Code').AsString + '-' + FieldByName('S_Name').AsString);
      Next;
    end;
  end;
end;
procedure TfrmDscntDtl.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmDscntDtl.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  atblDscntDtl.Close;
end;

procedure TfrmDscntDtl.FormCreate(Sender: TObject);
begin
  SetWinF;
  atblDscntDtl.Connection := frmDBS.adoConnect;
  atblDscntDtl.Open;
end;

procedure TfrmDscntDtl.atblDscntDtlCalcFields(DataSet: TDataSet);
begin
  with atblDscntDtl do
  begin
    atblDscntDtl.FieldByName('Srvc').AsString := GetServiceName(atblDscntDtl.FieldByName('DscntDtl_Service').AsInteger);
    if FieldByName('DscntDtl_Daily').AsBoolean then
      FieldByName('Daily').AsString := ('»·Ì')
    else
      FieldByName('Daily').AsString := ('ŒÌ—');   
  end;
end;

procedure TfrmDscntDtl.rdoDailyClick(Sender: TObject);
begin
  txtsDate.Enabled := false;
  txteDate.Enabled := false;
end;

procedure TfrmDscntDtl.rdoDateClick(Sender: TObject);
begin
  txtsDate.Enabled := True;
  txteDate.Enabled := True;
end;

procedure TfrmDscntDtl.txtsDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmDscntDtl.txtsDateExit(Sender: TObject);
begin
  if txtsDate.Text <> '' then
    txtsDate.Text := BeautifulDate(txtsDate.Text);
end;

procedure TfrmDscntDtl.txteDateExit(Sender: TObject);
begin
  if txteDate.Text <> '' then
    txteDate.Text := BeautifulDate(txteDate.Text);
end;

end.
