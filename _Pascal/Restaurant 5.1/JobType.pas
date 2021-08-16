unit JobType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard;

type
  TfrmJobType = class(TForm)
    grpAll: TGroupBox;
    dbgJob: TDBGrid;
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
    dtaJob: TDataSource;
    tblJob: TAdoTable;
    tblJobJob_Code: TSmallintField;
    tblJobJob_Name: TStringField;
    lbl1: TLabel;
    txtCode: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgJobKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
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

{$R *.DFM}

procedure TfrmJobType.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  tblJobJob_Code.DisplayLabel := (tblJobJob_Code.DisplayLabel);
  tblJobJob_Name.DisplayLabel := (tblJobJob_Name.DisplayLabel);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmJobType.FormInEdit(vis : Boolean);
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

function TfrmJobType.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ «” Œœ«„ Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰Ê⁄ «” Œœ«„ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Str('JobType', 'Job_Code', txtCode.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblJob.FieldByName('Job_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ »Œ‘  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('JobType', 'Job_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblJob.FieldByName('Job_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ »Œ‘  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmJobType.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  tblJob.connection := frmDBS.DBConnection;
  tblJob.Open;
end;

procedure TfrmJobType.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmJobType.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblJob.Close;
end;

procedure TfrmJobType.dbgJobKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmJobType.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('JobType', 'Job_Code'));
  txtName.Text := '';
  txtCode.SetFocus;
end;

procedure TfrmJobType.cmdEditClick(Sender: TObject);
begin
  if tblJob.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(tblJob.FieldByName('Job_Code').AsInteger);
    txtName.Text := tblJob.FieldByName('Job_Name').AsString;
    txtCode.SetFocus;
  end;
end;

procedure TfrmJobType.cmdDeleteClick(Sender: TObject);
begin
  if tblJob.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Persons', 'P_JobCode', tblJob.FieldByName('Job_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› «” Œœ«„ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        tblJob.Delete;
//        tblJob.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ ‰Ê⁄ «” Œœ«„ ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmJobType.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmJobType.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmJobType.cmdSaveClick(Sender: TObject);
var
  OldJob : String;
  qry : TAdoQuery;
begin
  if AreValidFields then
  begin
    OldJob := tblJob.FieldByName('Job_Code').AsString;
    if Flag = MB_NEW then
      tblJob.Append
    else if Flag = MB_EDIT then
      tblJob.Edit;

    tblJob.FieldByName('Job_Code').AsInteger := StrToInt(txtCode.Text);
    tblJob.FieldByName('Job_Name').AsString := txtName.Text;
    tblJob.Post;

    if (Flag = MB_EDIT) and (OldJob <> txtCode.Text) then
    begin
      qry := TAdoQuery.Create(Application);
      qry.connection := frmDBS.DBConnection;
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE Persons SET P_JobCode = ' + txtCode.Text);
      qry.SQL.Add('WHERE P_JobCode = ' + OldJob);
      qry.ExecSQL;
      qry.Free;
    end;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('JobType', 'Job_Code'));
      txtCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgJob.SetFocus;
    end;
  end;
end;

procedure TfrmJobType.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgJob.SetFocus;
end;







end.
