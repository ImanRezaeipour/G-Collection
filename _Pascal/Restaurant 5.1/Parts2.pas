unit Parts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, DBTables, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard , adodb;

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
    Label1: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaParts: TDataSource;
    tblParts: TAdoTable;
    tblPartsPart_Code: TSmallintField;
    Label2: TLabel;
    txtCode: TEdit;
    tblPartsPart_Name: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgPartsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmParts.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  tblPartsPart_Code.DisplayLabel := (tblPartsPart_Code.DisplayLabel);
  tblPartsPart_Name.DisplayLabel := (tblPartsPart_Name.DisplayLabel);
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
    ErrorMessage('ﬂœ »Œ‘ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ »Œ‘ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Str('Parts', 'Part_Code', txtCode.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblParts.FieldByName('Part_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ »Œ‘  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Parts', 'Part_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblParts.FieldByName('Part_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ »Œ‘  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmParts.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  tblParts.Connection := frmDBS.DBConnection;
  tblParts.Open;
end;

procedure TfrmParts.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmParts.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblParts.Close;
end;

procedure TfrmParts.dbgPartsKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmParts.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('Parts', 'Part_Code'));
  txtName.Text := '';
  txtCode.SetFocus;
end;

procedure TfrmParts.cmdEditClick(Sender: TObject);
begin
  if tblParts.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(tblParts.FieldByName('Part_Code').AsInteger);
    txtName.Text := tblParts.FieldByName('Part_Name').AsString;
    txtCode.SetFocus;
  end;
end;

procedure TfrmParts.cmdDeleteClick(Sender: TObject);
begin
  if tblParts.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Persons', 'P_parts', tblParts.FieldByName('Part_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› »Œ‘ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        tblParts.Delete;
//        tblParts.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ »Œ‘ ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmParts.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmParts.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmParts.cmdSaveClick(Sender: TObject);
var
  OldPart : String;
  qry : TAdoQuery;
begin
  if AreValidFields then
  begin
    OldPart := tblParts.FieldByName('Part_Code').AsString;
    if Flag = MB_NEW then
      tblParts.Append
    else if Flag = MB_EDIT then
      tblParts.Edit;

    tblParts.FieldByName('Part_Code').AsInteger := StrToInt(txtCode.Text);
    tblParts.FieldByName('Part_Name').AsString := txtName.Text;
    tblParts.Post;

    if (Flag = MB_EDIT) and (OldPart <> txtCode.Text) then
    begin
      qry := TADOQuery.Create(Application);
      qry.Connection := frmDBS.DBConnection;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE Persons SET P_parts = ' + txtCode.Text);
      qry.SQL.Add('WHERE P_parts = ' + OldPart);
      qry.ExecSQL;
      qry.Free;
    end;

    if Flag = MB_NEW then
    begin
      txtCode.Text := IntToStr(GetNewNumber('Parts', 'Part_Code'));
      txtName.Text := '';
      txtCode.SetFocus;
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







end.
