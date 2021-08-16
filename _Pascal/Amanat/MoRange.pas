unit MoRange;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB;

type
  TfrmMoRange = class(TForm)
    grpAll: TGroupBox;
    dbgMoRange: TDBGrid;
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
    dtaMoRange: TDataSource;
    lbl1: TLabel;
    txtCode: TEdit;
    adotblMoRange: TADOTable;
    txtPrice: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    txtDay: TEdit;
    chkDelRemain: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgMoRangeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtPriceKeyPress(Sender: TObject; var Key: Char);
    procedure txtDayKeyPress(Sender: TObject; var Key: Char);
    procedure txtDayExit(Sender: TObject);
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
  frmMoRange : TfrmMoRange;


implementation

uses
  Funcs, MSGs, DBS, FarsiApi, Keyboard, FntSel;

{$R *.DFM}

procedure TfrmMoRange.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmMoRange));

  Caption := (Caption);
  for i := 0 to dbgMoRange.Columns.Count-1 do
    dbgMoRange.Columns[i].Title.Caption := (dbgMoRange.Columns[i].Title.Caption);
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

procedure TfrmMoRange.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmMoRange.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ê—ÊÂ ”ﬁ› Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ ê—ÊÂ ”ﬁ› Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if txtPrice.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('„ﬁœ«— —Ì«·Ì ”ﬁ› Ê«—œ ‰‘œÂ «” .');
    txtPrice.SetFocus;
  end
  else if txtDay.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('—Ê“ «» œ«Ì œÊ—Â Ê«—œ ‰‘œÂ «” .');
    txtDay.SetFocus;
  end
  else if IsExistsRec_Num('MoRanges', 'MoRange_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblMoRange.FieldByName('MoRange_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ê—ÊÂ ”ﬁ›  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('MoRanges', 'MoRange_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblMoRange.FieldByName('MoRange_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('⁄‰Ê«‰ ê—ÊÂ ”ﬁ›  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmMoRange.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  adotblMoRange.Connection := frmDBS.adoConnect;
  adotblMoRange.Open;
end;

procedure TfrmMoRange.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmMoRange.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adotblMoRange.Close;
end;

procedure TfrmMoRange.dbgMoRangeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmMoRange.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('MoRanges', 'MoRange_Code'));
  txtName.Text := '';
  txtPrice.Text := '';
  txtDay.Text := '1';
  chkDelRemain.Checked := False;
  txtName.SetFocus;
end;

procedure TfrmMoRange.cmdEditClick(Sender: TObject);
begin
  if adotblMoRange.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(adotblMoRange.FieldByName('MoRange_Code').AsInteger);
    txtName.Text := adotblMoRange.FieldByName('MoRange_Name').AsString;
    txtPrice.Text := adotblMoRange.FieldByName('MoRange_Price').AsString;
    txtDay.Text := IntToStr(adotblMoRange.FieldByName('MoRange_Day').AsInteger);
    chkDelRemain.Checked := adotblMoRange.FieldByName('MoRange_DelRemain').AsBoolean;
    txtName.SetFocus;
  end;
end;

procedure TfrmMoRange.cmdDeleteClick(Sender: TObject);
begin
  if adotblMoRange.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Employee', 'Empl_MoRange', adotblMoRange.FieldByName('MoRange_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› Ã«Ìê«Â «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        adotblMoRange.Delete;
        adotblMoRange.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ Ã«Ìê«Â ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmMoRange.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmMoRange.txtDayExit(Sender: TObject);
begin
  if txtDay.Text = '' then
    txtDay.Text := '1';
  if StrToInt(txtDay.Text) < 1 then
    txtDay.Text := '1'
  else if StrToInt(txtDay.Text) > 29 then
    txtDay.Text := '29';
end;

procedure TfrmMoRange.txtDayKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmMoRange.cmdSaveClick(Sender: TObject);
var
  OldPost : String;
begin
{  if txtDay.Text <> '' then
    if StrToInt(txtDay.Text) < 1 then
      txtDay.Text := '1'
    else if StrToInt(txtDay.Text) > 29 then
      txtDay.Text := '29';  }
  if AreValidFields then
  begin
    OldPost := adotblMoRange.FieldByName('MoRange_Code').AsString;
    if Flag = MB_NEW then
      adotblMoRange.Append
    else if Flag = MB_EDIT then
      adotblMoRange.Edit;

    adotblMoRange.FieldByName('MoRange_Code').AsInteger := StrToInt(txtCode.Text);
    adotblMoRange.FieldByName('MoRange_Name').AsString := txtName.Text;
    adotblMoRange.FieldByName('MoRange_Price').AsString := txtPrice.Text;
    adotblMoRange.FieldByName('MoRange_Day').AsInteger := StrToInt(txtDay.Text);
    adotblMoRange.FieldByName('MoRange_DelRemain').AsBoolean := chkDelRemain.Checked;
    adotblMoRange.Post;

    if (Flag = MB_EDIT) and (OldPost <> txtCode.Text) then
    begin
      frmDBS.adoQryG.SQL.Clear;
      frmDBS.adoQryG.SQL.Add('UPDATE Employee SET Empl_MoRange = ' + txtCode.Text);
      frmDBS.adoQryG.SQL.Add('WHERE Empl_MoRange = ' + OldPost);
      frmDBS.adoQryG.ExecSQL;
    end;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtPrice.Text := '';
      txtDay.Text := '1';
      chkDelRemain.Checked := False;
      txtCode.Text := IntToStr(GetNewNumber('MoRanges', 'MoRange_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgMoRange.SetFocus;
    end;
  end;
end;

procedure TfrmMoRange.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgMoRange.SetFocus;
end;







procedure TfrmMoRange.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

procedure TfrmMoRange.txtPriceKeyPress(Sender: TObject; var Key: Char);
begin
//  Keyboard_Integer(Key);
  Keyboard_Money(Key);
end;

end.
