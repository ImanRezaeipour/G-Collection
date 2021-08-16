unit Groups;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard, Calendar, DateProc;

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
    Label1: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaGroups: TDataSource;
    tblGroups: TAdoTable;
    tblGroupsGrp_Code: TSmallintField;
    tblGroupsGrp_Name: TStringField;
    Label2: TLabel;
    txtCode: TEdit;
    cmdProgs: TBitBtn;
    cmdProg: TBitBtn;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    txtFromSobh: TEdit;
    txtToSobh: TEdit;
    txtFromNahar: TEdit;
    txtToNahar: TEdit;
    txtFromSham: TEdit;
    txtToSham: TEdit;
    tblGroupsGrp_FromSobh: TStringField;
    tblGroupsGrp_ToSobh: TStringField;
    tblGroupsGrp_FromNahar: TStringField;
    tblGroupsGrp_ToNahar: TStringField;
    tblGroupsGrp_FromSham: TStringField;
    tblGroupsGrp_ToSham: TStringField;
    procedure txtFromSobhExit(Sender: TObject);
    procedure txtFromSobhKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgGroupsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdProgClick(Sender: TObject);
    procedure cmdProgsClick(Sender: TObject);
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

procedure TfrmGroups.SetWinF;
begin
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
  else if IsExistsRec_Num('Groups', 'Grp_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (IntToStr(tblGroups.FieldByName('Grp_Code').AsInteger) <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ê—ÊÂ  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else
    AreValidFields := True;
end;

function TfrmGroups.SaveData : Boolean;
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblGroups.Append
    else if Flag = MB_EDIT then
      tblGroups.Edit;

    tblGroups.FieldByName('Grp_Name').AsString := txtName.Text;
    tblGroups.FieldByName('Grp_Code').AsInteger := StrToInt(txtCode.Text);

    tblGroups.FieldByName('Grp_FromSobh').AsString := txtFromSobh.Text;
    tblGroups.FieldByName('Grp_ToSobh').AsString := txtToSobh.Text;

    tblGroups.FieldByName('Grp_FromNahar').AsString := txtFromNahar.Text;
    tblGroups.FieldByName('Grp_ToNahar').AsString := txtToNahar.Text;

    tblGroups.FieldByName('Grp_FromSham').AsString := txtFromSham.Text;
    tblGroups.FieldByName('Grp_ToSham').AsString := txtToSham.Text;

    tblGroups.Post;
    SaveData := True;
  end
  else
    SaveData := False;
end;

procedure TfrmGroups.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  tblGroups.connection := frmDBS.DBConnection;
  tblGroups.Open;
  cmdNew.Enabled := NOT Linked_To_Clock;
  cmdDelete.Enabled := NOT Linked_To_Clock;
end;

procedure TfrmGroups.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmGroups.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblGroups.Close;
end;

procedure TfrmGroups.dbgGroupsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Linked_To_Clock then close;

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

procedure TfrmGroups.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('Groups', 'Grp_Code'));
  txtName.Text := '';
  txtFromSobh.Text := '';
  txtToSobh.Text := '';

  txtFromNahar.Text := '';
  txtToNahar.Text := '';

  txtFromSham.Text := '';
  txtToSham.Text := '';
  txtCode.SetFocus;
end;

procedure TfrmGroups.cmdEditClick(Sender: TObject);
begin
  if tblGroups.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := tblGroups.FieldByName('Grp_Name').AsString;
    txtCode.Text := IntToStr(tblGroups.FieldByName('Grp_Code').AsInteger);

    txtFromSobh.Text := tblGroups.FieldByName('Grp_FromSobh').AsString;
    txtToSobh.Text := tblGroups.FieldByName('Grp_ToSobh').AsString;

    txtFromNahar.Text := tblGroups.FieldByName('Grp_FromNahar').AsString;
    txtToNahar.Text := tblGroups.FieldByName('Grp_ToNahar').AsString;

    txtFromSham.Text := tblGroups.FieldByName('Grp_FromSham').AsString;
    txtToSham.Text := tblGroups.FieldByName('Grp_ToSham').AsString;

    txtCode.SetFocus;
  end;
end;

procedure TfrmGroups.cmdDeleteClick(Sender: TObject);
begin
  if tblGroups.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Persons', 'P_ShiftGroup', tblGroups.FieldByName('Grp_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ê—ÊÂ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        tblGroups.Delete;
//        tblGroups.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ ê—ÊÂ œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmGroups.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmGroups.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmGroups.cmdSaveClick(Sender: TObject);
begin
  if SaveData then
  begin
    if Flag = MB_NEW then
    begin
      txtName.Text := '';

      txtFromSobh.Text := '';
      txtToSobh.Text := '';

      txtFromNahar.Text := '';
      txtToNahar.Text := '';

      txtFromSham.Text := '';
      txtToSham.Text := '';

      txtCode.Text := IntToStr(GetNewNumber('Groups', 'Grp_Code'));
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
var frmCalendar : TfrmCalendar;
begin
  if tblGroups.RecordCount > 0 then
  begin
    Mouse_Wait;
//    MSG_Wait('œ— Õ«· «ÌÃ«œ  ﬁÊÌ„ ”«·«‰Â. ﬂ„Ì ’»— ‰„«ÌÌœ...');
    Application.CreateForm(TfrmCalendar, frmCalendar);
    frmCalendar.C_Year := StrToInt(Copy(CurrentDate, 1, 4));
    frmCalendar.Group_Code := tblGroups.FieldByName('Grp_Code').AsInteger;
    frmCalendar.ShowModal;
    frmCalendar.Free;
    LoaDayGroup(CurrentDate,tblGroups.FieldByName('Grp_Code').AsInteger);
  end;
end;

procedure TfrmGroups.cmdProgsClick(Sender: TObject);
var frmCalendar : TfrmCalendar;
begin
  if SaveData then
  begin
    Mouse_Wait;
//    MSG_Wait('œ— Õ«· «ÌÃ«œ  ﬁÊÌ„ ”«·«‰Â. ﬂ„Ì ’»— ‰„«ÌÌœ...');
    Application.CreateForm(TfrmCalendar, frmCalendar);
    frmCalendar.C_Year := StrToInt(Copy(CurrentDate, 1, 4));
    frmCalendar.Group_Code := tblGroups.FieldByName('Grp_Code').AsInteger;
    frmCalendar.ShowModal;
    frmCalendar.Free;
    LoaDayGroup(CurrentDate,tblGroups.FieldByName('Grp_Code').AsInteger);
  end;
end;

procedure TfrmGroups.txtFromSobhKeyPress(Sender: TObject; var Key: Char);
begin
//  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmGroups.txtFromSobhExit(Sender: TObject);
begin
  if (sender as TEdit).Text <> '' then (sender as TEdit).Text := BeautifulTime((sender as TEdit).Text);
end;

end.
