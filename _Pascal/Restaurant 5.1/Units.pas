unit Units;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard, Calendar, DateProc;

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
    Label1: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaUnits: TDataSource;
    tblUnits: TAdoTable;
    Label2: TLabel;
    txtCode: TEdit;
    tblUnitsUnit_Code: TSmallintField;
    tblUnitsUnit_Name: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgUnitsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
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

implementation

{$R *.DFM}

procedure TfrmUnits.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label2.Caption := (Label2.Caption);
  Label1.Caption := (Label1.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblUnitsUnit_Code.DisplayLabel := (tblUnitsUnit_Code.DisplayLabel);
  tblUnitsUnit_Name.DisplayLabel := (tblUnitsUnit_Name.DisplayLabel);
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
    ErrorMessage('ﬂœ Ê«Õœ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ Ê«Õœ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Units', 'Unit_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (IntToStr(tblUnits.FieldByName('Unit_Code').AsInteger) <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ Ê«Õœ  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else
    AreValidFields := True;
end;

function TfrmUnits.SaveData : Boolean;
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblUnits.Append
    else if Flag = MB_EDIT then
      tblUnits.Edit;

    tblUnits.FieldByName('Unit_Name').AsString := txtName.Text;
    tblUnits.FieldByName('Unit_Code').AsInteger := StrToInt(txtCode.Text);
    tblUnits.Post;
    SaveData := True;
  end
  else
    SaveData := False;
end;

procedure TfrmUnits.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  tblUnits.connection := frmDBS.DBConnection;
  tblUnits.Open;
end;

procedure TfrmUnits.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmUnits.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblUnits.Close;
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
  txtCode.SetFocus;
end;

procedure TfrmUnits.cmdEditClick(Sender: TObject);
begin
  if tblUnits.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := tblUnits.FieldByName('Unit_Name').AsString;
    txtCode.Text := IntToStr(tblUnits.FieldByName('Unit_Code').AsInteger);
    txtCode.SetFocus;
  end;
end;

procedure TfrmUnits.cmdDeleteClick(Sender: TObject);
begin
  if tblUnits.RecordCount > 0 then
  begin
    {if not IsExistsRec_Num('Persons', 'P_ShiftGroup', tblUnits.FieldByName('Grp_Code').AsInteger) then}
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› Ê«Õœ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        tblUnits.Delete;
//        tblUnits.Refresh;
      end;
    end
    {else
      InformationMessage('«Ì‰ ê—ÊÂ œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');}
  end;
end;

procedure TfrmUnits.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmUnits.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmUnits.cmdSaveClick(Sender: TObject);
begin
  if SaveData then
  begin
    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Units', 'Unit_Code'));
      txtCode.SetFocus;
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







end.
