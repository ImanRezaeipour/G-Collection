unit cashes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, DBTables, Globals, FarsiApi,
  MSGs, DBS, ADODB, DosMove;

type
  TfrmCashes = class(TForm)
    grpAll: TGroupBox;
    dbgCoPosts: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lblName: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaCashes: TDataSource;
    lblCode: TLabel;
    txtCode: TEdit;
    DosMove1: TDosMove;
    cmbBoxType: TComboBox;
    Label13: TLabel;
    Label1: TLabel;
    txtBoxPlace: TEdit;
    adoTblCashes: TADOTable;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgCoPostsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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
  Funcs;

{$R *.DFM}


procedure TfrmCashes.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  for i := 0 to dbgCoPosts.Columns.Count-1 do
    dbgCoPosts.Columns[i].Title.Caption := (dbgCoPosts.Columns[i].Title.Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  lblCode.Caption := (lblCode.Caption);
  lblName.Caption := (lblName.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmCashes.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmCashes.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ’‰œÊﬁ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ ’‰œÊﬁ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if (cmbBoxType.ItemIndex = -1)  then
  begin
    AreValidFields := False;
    ErrorMessage('‰Ê⁄ ’‰œÊﬁ «‰ Œ«» ‰‘œÂ «” .');
    cmbBoxType.SetFocus;
  end
  else if IsExistsRec_Num('cashes', 'c_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adoTblCashes.FieldByName('c_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ’‰œÊﬁ  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
//  else if IsExistsRec_Str('Cashes', 'c_Name', txtName.Text) and
//    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adoTblCashes.FieldByName('c_Name').AsString <> txtName.Text))) then
//  begin
//    AreValidFields := False;
//    ErrorMessage('‰«„ ’‰œÊﬁ  ﬂ—«—Ì «” .');
//    txtName.SetFocus;
//  end
  else if (Flag = MB_EDIT) and (adoTblCashes.FieldByName('c_Code').AsInteger <> StrToInt(txtCode.Text)) and
    IsExistsRec_Num('Persons', 'P_BoxNo', adoTblCashes.FieldByName('c_Code').AsInteger) then
  begin
    AreValidFields := False;
    ErrorMessage('«Ì‰ ’‰œÊﬁ ˛œ— ê—œ‘ »ÊœÂ Ê  €ÌÌ— òœ ¬‰ «„ò«‰ Å–Ì— ‰„Ì»«‘œ .');
    cmbBoxType.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmCashes.FormCreate(Sender: TObject);
begin
  SetDirectionFarsi(txtName.Handle);
  SetWinF;
  adoTblCashes.Connection := frmDBS.DBConnection;
  dtaCashes.DataSet := adoTblCashes;
  adoTblCashes.Open;
end;

procedure TfrmCashes.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmCashes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adoTblCashes.Close;
end;

procedure TfrmCashes.dbgCoPostsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmCashes.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtName.Text := '';
  txtCode.Text := IntToStr(GetNewNumber('Cashes', 'c_Code'));
  txtBoxPlace.Text := '';
  cmbBoxType.ItemIndex := -1;
  txtName.SetFocus;
end;

procedure TfrmCashes.cmdEditClick(Sender: TObject);
begin
  if adoTblCashes.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := adoTblCashes.FieldByName('c_Name').AsString;
    txtCode.Text := IntToStr(adoTblCashes.FieldByName('c_Code').AsInteger);
    txtBoxPlace.Text := adoTblCashes.FieldByName('c_place').AsString;
    cmbBoxType.ItemIndex := adoTblCashes.FieldByName('c_Type').AsInteger;
    txtName.SetFocus;
  end;
end;

procedure TfrmCashes.cmdDeleteClick(Sender: TObject);
begin
  if adoTblCashes.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Persons', 'P_BoxNo', adoTblCashes.FieldByName('c_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ’‰œÊﬁ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        adoTblCashes.Delete;
      end;
    end
    else
      InformationMessage('«Ì‰ ’‰œÊﬁ ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
    end;
end;

procedure TfrmCashes.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmCashes.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      adoTblCashes.Append
    else if Flag = MB_EDIT then
      adoTblCashes.Edit;
    adoTblCashes.FieldByName('c_Name').AsString := txtName.Text;
    adoTblCashes.FieldByName('c_Code').AsInteger := StrToInt(txtCode.Text);
    adoTblCashes.FieldByName('c_Type').AsInteger := cmbBoxType.ItemIndex;
    adoTblCashes.FieldByName('c_Place').AsString := txtBoxPlace.Text;
    adoTblCashes.Post;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('cashes', 'c_Code'));
      txtBoxPlace.Text := '';
      cmbBoxType.ItemIndex := -1;
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgCoPosts.SetFocus;
    end;
  end;
end;

procedure TfrmCashes.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCoPosts.SetFocus;
end;

end.
