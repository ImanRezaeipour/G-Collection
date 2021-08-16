unit building;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard;

type
  TfrmBuilding = class(TForm)
    grpAll: TGroupBox;
    dbgBuilding: TDBGrid;
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
    dtaBuilding: TDataSource;
    tblBuilding: TAdoTable;
    lbl1: TLabel;
    txtCode: TEdit;
    tblBuildingBuilding_Code: TSmallintField;
    tblBuildingBuilding_Name: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgBuildingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmBuilding.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  //Height := Height + 25;
  Height := Height + 35;
end;

function TfrmBuilding.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ  Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Str('building', 'Building_Code', txtCode.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblBuilding.FieldByName('Building_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ   ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Building', 'Building_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblBuilding.FieldByName('Building_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„   ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmBuilding.FormCreate(Sender: TObject);
begin
  SetDirectionFarsi(txtName.Handle);
  tblBuilding.connection := frmDBS.DBConnection;
  tblBuilding.Open;
end;

procedure TfrmBuilding.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmBuilding.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblBuilding.Close;
end;

procedure TfrmBuilding.dbgBuildingKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmBuilding.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('Building', 'Building_Code'));
  txtName.Text := '';
  txtCode.SetFocus;
end;

procedure TfrmBuilding.cmdEditClick(Sender: TObject);
begin
  if tblBuilding.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(tblBuilding.FieldByName('Building_Code').AsInteger);
    txtName.Text := tblBuilding.FieldByName('Building_Name').AsString;
    txtCode.SetFocus;
  end;
end;

procedure TfrmBuilding.cmdDeleteClick(Sender: TObject);
begin
  if tblBuilding.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Persons', 'P_Building', tblBuilding.FieldByName('Building_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–›  «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        tblBuilding.Delete;
      end;
    end
    else
      InformationMessage('«Ì‰  —òÊ—œ ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmBuilding.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmBuilding.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmBuilding.cmdSaveClick(Sender: TObject);
var
  OldBuilding : String;
  qry : TAdoQuery;
begin
  if AreValidFields then
  begin
    OldBuilding := tblBuilding.FieldByName('Building_Code').AsString;
    if Flag = MB_NEW then
      tblBuilding.Append
    else if Flag = MB_EDIT then
      tblBuilding.Edit;

    tblBuilding.FieldByName('Building_Code').AsInteger := StrToInt(txtCode.Text);
    tblBuilding.FieldByName('Building_Name').AsString := txtName.Text;
    tblBuilding.Post;

    if (Flag = MB_EDIT) and (OldBuilding <> txtCode.Text) then
    begin
      qry := TAdoQuery.Create(Application);
      qry.connection := frmDBS.DBConnection;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE Persons SET P_Building = ' + txtCode.Text);
      qry.SQL.Add('WHERE P_Building = ' + OldBuilding);
      qry.ExecSQL;
      qry.Free;
    end;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Building', 'Building_Code'));
      txtCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgBuilding.SetFocus;
    end;
  end;
end;

procedure TfrmBuilding.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgBuilding.SetFocus;
end;







end.
