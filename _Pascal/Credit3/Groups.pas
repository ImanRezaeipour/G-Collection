unit Groups;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, DosMove;

type
  TfrmGroups = class(TForm)
    grpAll: TGroupBox;
    dbgGroups: TDBGrid;
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
    dtaGroups: TDataSource;
    lbl1: TLabel;
    txtCode: TEdit;
    cmdProgs: TBitBtn;
    cmdProg: TBitBtn;
    atblGroups: TADOTable;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgGroupsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdProgClick(Sender: TObject);
    procedure cmdProgsClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
    function  SaveData : Boolean;
    procedure SetWinF;
  public
    { Public declarations }
  end;


var
  frmGroups : TfrmGroups;

implementation

uses
  Funcs, MSGs, DBS, Keyboard, Calendar, DateProc, DscntDtl, FntSel;

{$R *.DFM}

procedure TfrmGroups.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmGroups));

  Caption := (Caption);
  for i := 0 to dbgGroups.Columns.Count-1 do
    dbgGroups.Columns[i].Title.Caption := (dbgGroups.Columns[i].Title.Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdProg.Caption := (cmdProg.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);

  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdProgs.Caption := (cmdProgs.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmGroups.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmGroups.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ê—ÊÂ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else
  if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ ê—ÊÂ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Discount', 'Dscnt_No', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (IntToStr(atblGroups.FieldByName('Dscnt_No').AsInteger) <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ê—ÊÂ  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Discount', 'Dscnt_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (atblGroups.FieldByName('Dscnt_Name').asstring <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ ê—ÊÂ  ﬂ—«—Ì «”  .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

function TfrmGroups.SaveData : Boolean;
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      atblGroups.Append
    else if Flag = MB_EDIT then
      atblGroups.Edit;

    atblGroups.FieldByName('Dscnt_Name').AsString := txtName.Text;
    atblGroups.FieldByName('Dscnt_No').AsInteger := StrToInt(txtCode.Text);
    atblGroups.Post;
    SaveData := True;
  end
  else
    SaveData := False;
end;

procedure TfrmGroups.FormCreate(Sender: TObject);
begin
  SetWinF;
  atblGroups.Connection := frmDBS.adoConnect;
  atblGroups.Open;
end;

procedure TfrmGroups.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmGroups.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  atblGroups.Close;
end;

procedure TfrmGroups.dbgGroupsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmGroups.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('Discount', 'Dscnt_No'));
  txtName.Text := '';
  txtCode.SetFocus;
end;

procedure TfrmGroups.cmdEditClick(Sender: TObject);
begin
  if atblGroups.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := atblGroups.FieldByName('Dscnt_Name').AsString;
    txtCode.Text := IntToStr(atblGroups.FieldByName('Dscnt_No').AsInteger);
    txtCode.SetFocus;
  end;
end;

procedure TfrmGroups.cmdDeleteClick(Sender: TObject);
begin
  if atblGroups.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Employee', 'Empl_Dscnt', atblGroups.FieldByName('Dscnt_No').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ê—ÊÂ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        with frmDBS.adoQryG do
        begin
          SQL.Clear;
          SQL.Add('DELETE FROM DscntDtl WHERE DscntDtl_No = ' + IntToStr(atblGroups.FieldByName('Dscnt_No').AsInteger));
          ExecSQL;
        end;
        atblGroups.Delete;
      end;
    end
    else
      InformationMessage('«Ì‰ ê—ÊÂ œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmGroups.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmGroups.cmdSaveClick(Sender: TObject);
begin
  if SaveData then
  begin
    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Discount', 'Dscnt_No'));
      txtCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgGroups.SetFocus;
    end;
  end;
end;

procedure TfrmGroups.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgGroups.SetFocus;
end;







procedure TfrmGroups.cmdProgClick(Sender: TObject);
begin
  if atblGroups.RecordCount > 0 then
  begin
    Mouse_Wait;
    MSG_Wait('. ﬂ„Ì ’»— ‰„«ÌÌœ...');
    Application.CreateForm(TfrmDscntDtl, frmDscntDtl);
    frmDscntDtl.Caption := ('»—‰«„Â —Ì“Ì ê—ÊÂ  Œ›Ì› (') + atblGroups.FieldByName('Dscnt_Name').AsString + ')ù';
    frmDscntDtl.Grp_Code := atblGroups.FieldByName('Dscnt_No').AsInteger;
    frmDscntDtl.Grp_name := GetDiscountName(frmDscntDtl.Grp_Code);
    Msg_NoWait;
    Mouse_NoWait;
    frmDscntDtl.ShowModal;
    frmDscntDtl.Free;
  end;
end;

procedure TfrmGroups.cmdProgsClick(Sender: TObject);
begin
  if SaveData then     
  begin                                
    Application.CreateForm(TfrmDscntDtl, frmDscntDtl);
    frmDscntDtl.Caption := ('»—‰«„Â —Ì“Ì ê—ÊÂ  Œ›Ì› (') + atblGroups.FieldByName('Dscnt_Name').AsString + ')ù';
    frmDscntDtl.Grp_Code := atblGroups.FieldByName('Dscnt_No').AsInteger;
    frmDscntDtl.Grp_name := GetDiscountName(frmDscntDtl.Grp_Code);
    frmDscntDtl.ShowModal;
    frmDscntDtl.Free;
  end;
end;

procedure TfrmGroups.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
