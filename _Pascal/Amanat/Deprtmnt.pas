unit Deprtmnt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB;

type
  TfrmDepartment = class(TForm)
    grpAll: TGroupBox;
    dbgDepartment: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lbl2: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaDepartment: TDataSource;
    lbl1: TLabel;
    txtCode: TEdit;
    atblDepartment: TADOTable;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure SetWinF;
    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
  public
    { Public declarations }
  end;


var frmDepartment : TfrmDepartment;



implementation

uses
  Funcs, MSGs, DBS, FarsiApi, Keyboard, FntSel;

{$R *.DFM}

procedure TfrmDepartment.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmDepartment));

  Caption := (Caption);
  for i := 0 to dbgDepartment.Columns.Count-1 do
    dbgDepartment.Columns[i].Title.Caption := (dbgDepartment.Columns[i].Title.Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);

  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmDepartment.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmDepartment.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ „—ﬂ“ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ „—ﬂ“ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Department', 'Depart_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (atblDepartment.FieldByName('Depart_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ „—ﬂ“  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Department', 'Depart_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (atblDepartment.FieldByName('Depart_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ „—ﬂ“  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmDepartment.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  atblDepartment.Connection := frmDBS.adoConnect;
  atblDepartment.Open;
end;

procedure TfrmDepartment.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmDepartment.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  atblDepartment.Close;
end;

procedure TfrmDepartment.dbgDepartmentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmDepartment.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('Department', 'Depart_Code'));
  txtName.Text := '';
  txtName.SetFocus;
end;

procedure TfrmDepartment.cmdEditClick(Sender: TObject);
begin
  if atblDepartment.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(atblDepartment.FieldByName('Depart_Code').AsInteger);
    txtName.Text := atblDepartment.FieldByName('Depart_Name').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmDepartment.cmdDeleteClick(Sender: TObject);
begin
  if atblDepartment.RecordCount > 0 then
  begin
    if IsExistsRec_Num('Readers', 'Rdr_Department', atblDepartment.FieldByName('Depart_Code').AsInteger) or
       IsExistsRec_Num('Employee', 'Empl_Department', atblDepartment.FieldByName('Depart_Code').AsInteger) or
       IsExistsRec_Num('Receipt1', 'Recit1_Department', atblDepartment.FieldByName('Depart_Code').AsInteger) or
       IsExistsRec_Num('Users', 'User_Department', atblDepartment.FieldByName('Depart_Code').AsInteger) then
      InformationMessage('«Ì‰ „—ﬂ“ ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .')
    else if ConfirmMessage('¬Ì« »—«Ì Õ–› „—ﬂ“ «ÿ„Ì‰«‰ œ«—Ìœø') then
      atblDepartment.Delete;
  end;
end;

procedure TfrmDepartment.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmDepartment.cmdSaveClick(Sender: TObject);
var
  OldPost : String;
begin
  if AreValidFields then
  begin
    OldPost := atblDepartment.FieldByName('Depart_Code').AsString;
    if Flag = MB_NEW then
      atblDepartment.Append
    else if Flag = MB_EDIT then
      atblDepartment.Edit;

    atblDepartment.FieldByName('Depart_Code').AsInteger := StrToInt(txtCode.Text);
    atblDepartment.FieldByName('Depart_Name').AsString := txtName.Text;
    atblDepartment.Post;

    if (Flag = MB_EDIT) and (OldPost <> txtCode.Text) then
    begin
      frmDBS.adoQryG.SQL.Clear;
      frmDBS.adoQryG.SQL.Add('UPDATE Readers SET Rdr_Department = ' + txtCode.Text);
      frmDBS.adoQryG.SQL.Add('WHERE Rdr_Department = ' + OldPost);
      frmDBS.adoQryG.ExecSQL;
    end;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Department', 'Depart_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgDepartment.SetFocus;
    end;
  end;
end;

procedure TfrmDepartment.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgDepartment.SetFocus;
end;







end.
