unit Units;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB;

type
  TfrmUnits = class(TForm)
    grpAll: TGroupBox;
    dbgUnits: TDBGrid;
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
    adotblUnits: TADOTable;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgUnitsKeyDown(Sender: TObject; var Key: Word;
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
  frmUnits : TfrmUnits;

implementation

uses
  Funcs, MSGs, DBS, FarsiApi, Keyboard, FntSel;

{$R *.DFM}

procedure TfrmUnits.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmUnits));

  Caption := (Caption);
  for i := 0 to dbgUnits.Columns.Count-1 do
    dbgUnits.Columns[i].Title.Caption := (dbgUnits.Columns[i].Title.Caption);
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

procedure TfrmUnits.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmUnits.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ﬂ„Ì  Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ ﬂ„Ì  Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Units', 'Unit_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblUnits.FieldByName('Unit_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ﬂ„Ì   ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Units', 'Unit_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblUnits.FieldByName('Unit_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ ﬂ„Ì   ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmUnits.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  adotblUnits.Connection := frmDBS.adoConnect;
  adotblUnits.Open;
end;

procedure TfrmUnits.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmUnits.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adotblUnits.Close;
end;

procedure TfrmUnits.dbgUnitsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmUnits.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('Units', 'Unit_Code'));
  txtName.Text := '';
  txtName.SetFocus;
end;

procedure TfrmUnits.cmdEditClick(Sender: TObject);
begin
  if adotblUnits.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(adotblUnits.FieldByName('Unit_Code').AsInteger);
    txtName.Text := adotblUnits.FieldByName('Unit_Name').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmUnits.cmdDeleteClick(Sender: TObject);
begin
  if adotblUnits.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Services', 'S_Unit', adotblUnits.FieldByName('Unit_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ﬂ„Ì  «ÿ„Ì‰«‰ œ«—Ìœø') then
        adotblUnits.Delete;
    end
    else
      InformationMessage('«Ì‰ ﬂ„Ì  ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmUnits.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmUnits.cmdSaveClick(Sender: TObject);
var
  oldUnit : String;
begin
  if AreValidFields then
  begin
    oldUnit := adotblUnits.FieldByName('Unit_Code').AsString;
    if Flag = MB_NEW then
      adotblUnits.Append
    else if Flag = MB_EDIT then
      adotblUnits.Edit;

    adotblUnits.FieldByName('Unit_Code').AsInteger := StrToInt(txtCode.Text);
    adotblUnits.FieldByName('Unit_Name').AsString := txtName.Text;
    adotblUnits.Post;

    if (Flag = MB_EDIT) and (oldUnit <> txtCode.Text) then
    begin
      frmDBS.adoQryG.SQL.Clear;
      frmDBS.adoQryG.SQL.Add('UPDATE Services SET S_Unit = ' + txtCode.Text);
      frmDBS.adoQryG.SQL.Add('WHERE S_Unit = ' + oldUnit);
      frmDBS.adoQryG.ExecSQL;
    end;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Units', 'Unit_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgUnits.SetFocus;
    end;
  end;
end;

procedure TfrmUnits.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgUnits.SetFocus;
end;


procedure TfrmUnits.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
