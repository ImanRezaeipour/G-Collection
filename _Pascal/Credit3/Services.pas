unit Services;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, ExtCtrls, DosMove;

type
  TfrmServices = class(TForm)
    grpAll: TGroupBox;
    dbgService: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lbl3: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaService: TDataSource;
    lbl1: TLabel;
    txtSearch: TEdit;
    lbl2: TLabel;
    txtCode: TEdit;
    atblService: TADOTable;
    DosMove1: TDosMove;
    atblServiceS_Code: TIntegerField;
    atblServiceS_Name: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgServiceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchChange(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure atblServiceCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    Flag : Byte;

    procedure DBS_Set;
    procedure FormInEdit(vis : Boolean);
    procedure ClearScrFields;
    procedure SetScreenFields;
    function  AreValidFields : Boolean;
    procedure SetWinF;
  public
    { Public declarations }
  end;


var
  frmServices : TfrmServices;


implementation

uses
  Funcs, DBS, DateProc, Globals, MSGs, FarsiApi, Keyboard, FntSel;

{$R *.DFM}

procedure TfrmServices.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmServices));
end;

procedure TfrmServices.DBS_Set;
var s : String;
begin
  atblService.Filtered := False;
  if txtSearch.Text <> '' then
    s := 'S_Name LIKE ''' + txtSearch.Text + '*''';
  atblService.Filter := s;
  atblService.Filtered := True;
end;

procedure TfrmServices.FormInEdit(vis : Boolean);
begin
  grpEdit.Align := alNone;
  if vis = False then
    Flag := MB_NONE;
  grpAll.Visible := True;
  grpEdit.Visible := vis;
  grpAll.Enabled := not vis;
  grpEdit.Align := alTop;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;



procedure TfrmServices.ClearScrFields;
begin
  txtCode.Text := IntToStr(GetNewNumber('Services', 'S_Code'));
  txtName.Text := '';
  txtName.SetFocus;
end;

procedure TfrmServices.SetScreenFields;
begin
  txtCode.Text := IntToStr(atblService.FieldByName('S_Code').AsInteger);
  txtName.Text := atblService.FieldByName('S_Name').AsString;
  txtName.SetFocus;
end;


function TfrmServices.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ Œœ„«  Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ Œœ„«  Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Services', 'S_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (atblService.FieldByName('S_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ Œœ„«   ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Services', 'S_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (atblService.FieldByName('S_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ Œœ„«   ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmServices.FormCreate(Sender: TObject);
begin
  SetWinF;
  atblService.Connection := frmDBS.adoConnect;
  atblService.Open;
end;

procedure TfrmServices.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
  DBS_Set;
end;

procedure TfrmServices.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  atblService.Close;
end;

procedure TfrmServices.txtSearchChange(Sender: TObject);
begin
  DBS_Set;
end;

procedure TfrmServices.dbgServiceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmServices.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearScrFields;
end;

procedure TfrmServices.cmdEditClick(Sender: TObject);
begin
  if atblService.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetScreenFields;
  end;
end;

procedure TfrmServices.cmdDeleteClick(Sender: TObject);
begin
  if atblService.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Receipt2', 'Recit2_Food', atblService.FieldByName('S_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› Œœ„«  Ê ﬁÌ„ Â«Ì ¬‰ «ÿ„Ì‰«‰ œ«—Ìœø') then
        atblService.Delete;
    end
    else
      InformationMessage('«Ì‰ Œœ„«  œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmServices.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      atblService.Append
    else if Flag = MB_EDIT then
      atblService.Edit;

    atblService.FieldByName('S_Code').AsInteger := StrToInt(txtCode.Text);
    atblService.FieldByName('S_Name').AsString := txtName.Text;
    atblService.Post;

    if Flag = MB_NEW then
      ClearScrFields
    else
    begin
      FormInEdit(False);
      dbgService.SetFocus;
    end;
  end;
end;

procedure TfrmServices.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmServices.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgService.SetFocus;
end;




procedure TfrmServices.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

procedure TfrmServices.atblServiceCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('UnitName').AsString := GetUnitName(DataSet.FieldByName('S_Unit').AsInteger);
end;

end.
