unit Parts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB;

type
  TfrmParts = class(TForm)
    grpAll: TGroupBox;
    dbgParts: TDBGrid;
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
    dtaParts: TDataSource;
    lbl1: TLabel;
    txtCode: TEdit;
    adotblParts: TADOTable;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgPartsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


var
  frmParts : TfrmParts;

implementation

uses
  Funcs, MSGs, DBS, FarsiApi, Keyboard, FntSel;

{$R *.DFM}

procedure TfrmParts.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmParts));

  Caption := (Caption);
  for i := 0 to dbgParts.Columns.Count-1 do
    dbgParts.Columns[i].Title.Caption := (dbgParts.Columns[i].Title.Caption);

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

procedure TfrmParts.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmParts.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ „Õ· Œœ„  Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ „Õ· Œœ„  Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Parts', 'Part_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblParts.FieldByName('Part_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ „Õ· Œœ„   ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Parts', 'Part_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblParts.FieldByName('Part_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ „Õ· Œœ„   ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmParts.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  adotblParts.Connection := frmDBS.adoConnect;
  adotblParts.Open;
end;

procedure TfrmParts.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmParts.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adotblParts.Close;
end;

procedure TfrmParts.dbgPartsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmParts.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('Parts', 'Part_Code'));
  txtName.Text := '';
  txtName.SetFocus;
end;

procedure TfrmParts.cmdEditClick(Sender: TObject);
begin
  if adotblParts.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(adotblParts.FieldByName('Part_Code').AsInteger);
    txtName.Text := adotblParts.FieldByName('Part_Name').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmParts.cmdDeleteClick(Sender: TObject);
begin
  if adotblParts.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Employee', 'Empl_Part', adotblParts.FieldByName('Part_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› „Õ· Œœ„  «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        adotblParts.Delete;
        adotblParts.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ „Õ· Œœ„  ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmParts.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmParts.cmdSaveClick(Sender: TObject);
var
  OldPart : String;
begin
  if AreValidFields then
  begin
    OldPart := adotblParts.FieldByName('Part_Code').AsString;
    if Flag = MB_NEW then
      adotblParts.Append
    else if Flag = MB_EDIT then
      adotblParts.Edit;

    adotblParts.FieldByName('Part_Code').AsInteger := StrToInt(txtCode.Text);
    adotblParts.FieldByName('Part_Name').AsString := txtName.Text;
    adotblParts.Post;

    if (Flag = MB_EDIT) and (OldPart <> txtCode.Text) then
    begin
      frmDBS.adoQryG.SQL.Clear;
      frmDBS.adoQryG.SQL.Add('UPDATE Employee SET Empl_Part = ' + txtCode.Text);
      frmDBS.adoQryG.SQL.Add('WHERE Empl_Part = ' + OldPart);
      frmDBS.adoQryG.ExecSQL;
    end;

    if Flag = MB_NEW then
    begin
      txtCode.Text := IntToStr(GetNewNumber('Parts', 'Part_Code'));
      txtName.Text := '';
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgParts.SetFocus;
    end;
  end;
end;

procedure TfrmParts.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgParts.SetFocus;
end;







procedure TfrmParts.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
