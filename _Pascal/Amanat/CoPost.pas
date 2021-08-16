unit CoPost;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB;

type
  TfrmCoPost = class(TForm)
    grpAll: TGroupBox;
    dbgCoPost: TDBGrid;
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
    dtaCoPost: TDataSource;
    lbl1: TLabel;
    txtCode: TEdit;
    adotblCoPost: TADOTable;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgCoPostKeyDown(Sender: TObject; var Key: Word;
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


var
  frmCoPost : TfrmCoPost;


implementation

uses
  Funcs, MSGs, DBS, FarsiApi, Keyboard, FntSel;

{$R *.DFM}

procedure TfrmCoPost.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmCoPost));

  Caption := (Caption);
  for i := 0 to dbgCoPost.Columns.Count-1 do
    dbgCoPost.Columns[i].Title.Caption := (dbgCoPost.Columns[i].Title.Caption);
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

procedure TfrmCoPost.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmCoPost.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ Ã«Ìê«Â Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ Ã«Ìê«Â Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('CoPosts', 'CoPost_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblCoPost.FieldByName('CoPost_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ Ã«Ìê«Â  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('CoPosts', 'CoPost_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblCoPost.FieldByName('CoPost_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ Ã«Ìê«Â  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmCoPost.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  adotblCoPost.Connection := frmDBS.adoConnect;
  adotblCoPost.Open;
end;

procedure TfrmCoPost.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmCoPost.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adotblCoPost.Close;
end;

procedure TfrmCoPost.dbgCoPostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmCoPost.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('CoPosts', 'CoPost_Code'));
  txtName.Text := '';
  txtName.SetFocus;
end;

procedure TfrmCoPost.cmdEditClick(Sender: TObject);
begin
  if adotblCoPost.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(adotblCoPost.FieldByName('CoPost_Code').AsInteger);
    txtName.Text := adotblCoPost.FieldByName('CoPost_Name').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmCoPost.cmdDeleteClick(Sender: TObject);
begin
  if adotblCoPost.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Employee', 'Empl_CoPost', adotblCoPost.FieldByName('CoPost_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› Ã«Ìê«Â «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        adotblCoPost.Delete;
        adotblCoPost.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ Ã«Ìê«Â ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmCoPost.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmCoPost.cmdSaveClick(Sender: TObject);
var
  OldPost : String;
begin
  if AreValidFields then
  begin
    OldPost := adotblCoPost.FieldByName('CoPost_Code').AsString;
    if Flag = MB_NEW then
      adotblCoPost.Append
    else if Flag = MB_EDIT then
      adotblCoPost.Edit;

    adotblCoPost.FieldByName('CoPost_Code').AsInteger := StrToInt(txtCode.Text);
    adotblCoPost.FieldByName('CoPost_Name').AsString := txtName.Text;
    adotblCoPost.Post;

    if (Flag = MB_EDIT) and (OldPost <> txtCode.Text) then
    begin
      frmDBS.adoQryG.SQL.Clear;
      frmDBS.adoQryG.SQL.Add('UPDATE Employee SET Empl_CoPost = ' + txtCode.Text);
      frmDBS.adoQryG.SQL.Add('WHERE Empl_CoPost = ' + OldPost);
      frmDBS.adoQryG.ExecSQL;
    end;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('CoPosts', 'CoPost_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgCoPost.SetFocus;
    end;
  end;
end;

procedure TfrmCoPost.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCoPost.SetFocus;
end;







procedure TfrmCoPost.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
