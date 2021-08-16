unit week;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, ExtCtrls, DosMove, XStringGrid;

type
  TfrmWeek = class(TForm)
    grpAll: TGroupBox;
    dbgWeek: TDBGrid;
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
    dtaWeek: TDataSource;
    lbl1: TLabel;
    txtSearch: TEdit;
    lbl2: TLabel;
    txtCode: TEdit;
    atblWeek: TADOTable;
    DosMove1: TDosMove;
    grdWeek: TXStringGrid;
    MaskEditCellEditor1: TMaskEditCellEditor;
    atblWeekW_Code: TIntegerField;
    atblWeekW_Name: TWideStringField;
    atblWeekW_prgDay1: TWideStringField;
    atblWeekW_prgDay2: TWideStringField;
    atblWeekW_prgDay3: TWideStringField;
    atblWeekW_prgDay4: TWideStringField;
    atblWeekW_prgDay5: TWideStringField;
    atblWeekW_prgDay6: TWideStringField;
    atblWeekW_prgDay7: TWideStringField;
    lbl25: TLabel;
    cmbSex: TComboBox;
    atblWeekW_Sex: TSmallintField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgWeekKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchChange(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
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
  frmWeek : TfrmWeek;


implementation

uses
  Funcs, DBS, DateProc, Globals, MSGs, FarsiApi, Keyboard, FntSel;

{$R *.DFM}

procedure TfrmWeek.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmWeek));
end;

procedure TfrmWeek.DBS_Set;
var s : String;
begin
  atblWeek.Filtered := False;
  if txtSearch.Text <> '' then
    s := 'w_Name LIKE ''' + txtSearch.Text + '*''';
  atblWeek.Filter := s;
  atblWeek.Filtered := True;
end;

procedure TfrmWeek.FormInEdit(vis : Boolean);
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



procedure TfrmWeek.ClearScrFields;
begin
  txtCode.Text := IntToStr(GetNewNumber('Weeks', 'W_Code'));
  txtName.Text := '';
  cmbSex.ItemIndex:=0;
  grdWeek.RowS[1].DelimitedText := 'شـنبه,00:00,00:00,00:00,00:00,00:00,00:00,00:00,00:00';
  grdWeek.RowS[2].DelimitedText := '1شنبه,00:00,00:00,00:00,00:00,00:00,00:00,00:00,00:00';
  grdWeek.RowS[3].DelimitedText := '2شنبه,00:00,00:00,00:00,00:00,00:00,00:00,00:00,00:00';
  grdWeek.RowS[4].DelimitedText := '3شنبه,00:00,00:00,00:00,00:00,00:00,00:00,00:00,00:00';
  grdWeek.RowS[5].DelimitedText := '4شنبه,00:00,00:00,00:00,00:00,00:00,00:00,00:00,00:00';
  grdWeek.RowS[6].DelimitedText := '5شنبه,00:00,00:00,00:00,00:00,00:00,00:00,00:00,00:00';
  grdWeek.RowS[7].DelimitedText := 'جـمعه,00:00,00:00,00:00,00:00,00:00,00:00,00:00,00:00';
  txtName.SetFocus;
end;

procedure TfrmWeek.SetScreenFields;
begin
  txtCode.Text := IntToStr(atblWeek.FieldByName('W_Code').AsInteger);
  cmbSex.ItemIndex:=atblWeek.FieldByName('W_Sex').AsInteger;
  txtName.Text := atblWeek.FieldByName('W_Name').AsString;
  with grdWeek do
  begin
    Rows[1].DelimitedText := atblWeek.FieldByName('W_prgDay1').AsString;
    Rows[2].DelimitedText := atblWeek.FieldByName('W_prgDay2').AsString;
    Rows[3].DelimitedText := atblWeek.FieldByName('W_prgDay3').AsString;
    Rows[4].DelimitedText := atblWeek.FieldByName('W_prgDay4').AsString;
    Rows[5].DelimitedText := atblWeek.FieldByName('W_prgDay5').AsString;
    Rows[6].DelimitedText := atblWeek.FieldByName('W_prgDay6').AsString;
    Rows[7].DelimitedText := atblWeek.FieldByName('W_prgDay7').AsString;
  end;
  txtName.SetFocus;
end;


function TfrmWeek.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('كد خدمات وارد نشده است.');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('نام خدمات وارد نشده است.');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Weeks', 'W_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (atblWeek.FieldByName('W_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('كد خدمات تكراري است.');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Weeks', 'W_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (atblWeek.FieldByName('W_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('نام خدمات تكراري است.');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmWeek.FormCreate(Sender: TObject);
begin
  SetWinF;
  atblWeek.Connection := frmDBS.adoConnect;
  atblWeek.Open;
  with grdWeek do
  begin
    Cells[0,1] := 'شنبه';
    Cells[0,2] := 'یک شنبه';
    Cells[0,3] := 'دوشنبه';
    Cells[0,4] := 'سه شنبه';
    Cells[0,5] := 'چهارشنبه';
    Cells[0,6] := 'پنج شنبه';
    Cells[0,7] := 'جمعه';
  end;
end;

procedure TfrmWeek.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
  DBS_Set;
end;

procedure TfrmWeek.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  atblWeek.Close;
end;

procedure TfrmWeek.txtSearchChange(Sender: TObject);
begin
  DBS_Set;
end;

procedure TfrmWeek.dbgWeekKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmWeek.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearScrFields;
end;

procedure TfrmWeek.cmdEditClick(Sender: TObject);
begin
  if atblWeek.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetScreenFields;
  end;
end;

procedure TfrmWeek.cmdDeleteClick(Sender: TObject);
begin
  if atblWeek.RecordCount > 0 then
  begin
    if ConfirmMessage('آيا براي حذف خدمات اطمينان داريد؟') then
      atblWeek.Delete;
  end;
end;

procedure TfrmWeek.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      atblWeek.Append
    else if Flag = MB_EDIT then
      atblWeek.Edit;

    atblWeek.FieldByName('W_Code').AsInteger := StrToInt(txtCode.Text);
    atblWeek.FieldByName('W_Name').AsString := txtName.Text;
    atblWeek.FieldByName('W_Sex').AsInteger:=cmbSex.ItemIndex;
    with grdWeek do
    begin
      atblWeek.FieldByName('W_prgDay1').AsString := Rows[1].DelimitedText;
      atblWeek.FieldByName('W_prgDay2').AsString := Rows[2].DelimitedText;
      atblWeek.FieldByName('W_prgDay3').AsString := Rows[3].DelimitedText;
      atblWeek.FieldByName('W_prgDay4').AsString := Rows[4].DelimitedText;
      atblWeek.FieldByName('W_prgDay5').AsString := Rows[5].DelimitedText;
      atblWeek.FieldByName('W_prgDay6').AsString := Rows[6].DelimitedText;
      atblWeek.FieldByName('W_prgDay7').AsString := Rows[7].DelimitedText;
    end;
    atblWeek.Post;

    if Flag = MB_NEW then
      ClearScrFields
    else
    begin
      FormInEdit(False);
      dbgWeek.SetFocus;
    end;
  end;
end;

procedure TfrmWeek.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmWeek.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgWeek.SetFocus;
end;




procedure TfrmWeek.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
