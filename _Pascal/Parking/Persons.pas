unit Persons;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS;

type
  TfrmPersons = class(TForm)
    grpAll: TGroupBox;
    dbgPersons: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    txtName: TEdit;
    txtCode: TEdit;
    Label2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaPersons: TDataSource;
    tblPersons: TAdoTable;
    tblPersonsP_BarCode: TStringField;
    tblPersonsP_Name: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgPersonsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmPersons.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblPersonsP_BarCode.DisplayLabel := (tblPersonsP_BarCode.DisplayLabel);
  tblPersonsP_Name.DisplayLabel := (tblPersonsP_Name.DisplayLabel);
end;

procedure TfrmPersons.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmPersons.AreValidFields : Boolean;
begin
  if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ „ ’œÌ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ „ ’œÌ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Persons', 'P_BarCode', txtCode.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblPersons.FieldByName('P_BarCode').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ „ ’œÌ  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmPersons.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  tblPersons.connection := frmDBS.adoConnect;
  tblPersons.Open;
end;

procedure TfrmPersons.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmPersons.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblPersons.Close;
end;

procedure TfrmPersons.dbgPersonsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmPersons.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtName.Text := '';
  txtCode.Text := '';
  txtName.SetFocus;
end;

procedure TfrmPersons.cmdEditClick(Sender: TObject);
begin
  if not tblPersons.EOF then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := tblPersons.FieldByName('P_Name').AsString;
    txtCode.Text := tblPersons.FieldByName('P_BarCode').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmPersons.cmdDeleteClick(Sender: TObject);
begin
  if tblPersons.RecordCount > 0 then
  begin
    if not InCirclePerson(tblPersons.FieldByName('P_BarCode').AsString) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› „ ’œÌ «ÿ„Ì‰«‰ œ«—Ìœø') then
        tblPersons.Delete;
    end
    else
      InformationMessage('„ ’œÌ „Ê—œ ‰Ÿ— ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmPersons.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtCode.SetFocus;
  end;
end;

procedure TfrmPersons.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmPersons.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblPersons.Append
    else if Flag = MB_EDIT then
    begin
      if InCirclePerson(tblPersons.FieldByName('P_BarCode').AsString) and
         (tblPersons.FieldByName('P_BarCode').AsString <> txtCode.Text) then
      begin
        InformationMessage('„ ’œÌ „Ê—œ ‰Ÿ— œ— ê—œ‘ „Ìù»«‘œ. Ê   €ÌÌ— ¬‰ „Ì”— ‰Ì” .');
        FormInEdit(False);
        Exit;
      end;

      tblPersons.Edit;
    end;
    tblPersons.FieldByName('P_Name').AsString := txtName.Text;
    tblPersons.FieldByName('P_BarCode').AsString := txtCode.Text;
    tblPersons.Post;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := '';
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgPersons.SetFocus;
    end;
  end;
end;

procedure TfrmPersons.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgPersons.SetFocus;
end;

end.
