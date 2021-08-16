unit EmplType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB;

type
  TfrmEmploymentType = class(TForm)
    grpAll: TGroupBox;
    dbgEmplType: TDBGrid;
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
    dtaEmplType: TDataSource;
    lbl1: TLabel;
    txtCode: TEdit;
    adotblEmplType: TADOTable;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgEmplTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure SetWinF;
    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  Funcs, MSGs, DBS, FarsiApi, Keyboard;

{$R *.DFM}

procedure TfrmEmploymentType.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  for i := 0 to dbgEmplType.Columns.Count-1 do
    dbgEmplType.Columns[i].Title.Caption := (dbgEmplType.Columns[i].Title.Caption);
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

procedure TfrmEmploymentType.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmEmploymentType.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ «” Œœ«„ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰Ê⁄ «” Œœ«„ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('EmplType', 'EmplType_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblEmplType.FieldByName('EmplType_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ «” Œœ«„  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('EmplType', 'EmplType_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblEmplType.FieldByName('EmplType_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ «” Œœ«„  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmEmploymentType.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  adotblEmplType.Connection := frmDBS.adoConnect;
  adotblEmplType.Open;
end;

procedure TfrmEmploymentType.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmEmploymentType.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adotblEmplType.Close;
end;

procedure TfrmEmploymentType.dbgEmplTypeKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmEmploymentType.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('EmplType', 'EmplType_Code'));
  txtName.Text := '';
  txtName.SetFocus;
end;

procedure TfrmEmploymentType.cmdEditClick(Sender: TObject);
begin
  if adotblEmplType.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(adotblEmplType.FieldByName('EmplType_Code').AsInteger);
    txtName.Text := adotblEmplType.FieldByName('EmplType_Name').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmEmploymentType.cmdDeleteClick(Sender: TObject);
begin
  if adotblEmplType.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Employee', 'Empl_EmplType', adotblEmplType.FieldByName('EmplType_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› «” Œœ«„ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        adotblEmplType.Delete;
        adotblEmplType.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ ‰Ê⁄ «” Œœ«„ ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmEmploymentType.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmEmploymentType.cmdSaveClick(Sender: TObject);
var
  OldJob : String;
begin
  if AreValidFields then
  begin
    OldJob := adotblEmplType.FieldByName('EmplType_Code').AsString;
    if Flag = MB_NEW then
      adotblEmplType.Append
    else if Flag = MB_EDIT then
      adotblEmplType.Edit;

    adotblEmplType.FieldByName('EmplType_Code').AsInteger := StrToInt(txtCode.Text);
    adotblEmplType.FieldByName('EmplType_Name').AsString := txtName.Text;
    adotblEmplType.Post;

    if (Flag = MB_EDIT) and (OldJob <> txtCode.Text) then
    begin
      frmDBS.adoQryG.SQL.Clear;
      frmDBS.adoQryG.SQL.Add('UPDATE Persons SET Empl_EmplType = ' + txtCode.Text);
      frmDBS.adoQryG.SQL.Add('WHERE Empl_EmplType = ' + OldJob);
      frmDBS.adoQryG.ExecSQL;
    end;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('EmplType', 'EmplType_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgEmplType.SetFocus;
    end;
  end;
end;

procedure TfrmEmploymentType.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgEmplType.SetFocus;
end;







procedure TfrmEmploymentType.txtNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
