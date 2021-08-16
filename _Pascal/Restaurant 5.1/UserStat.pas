unit UserStat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Buttons, AdoDB, Grids, DBGrids;

type
  TfrmUserState = class(TForm)
    Label1: TLabel;
    cmbUsers: TComboBox;
    dbgUserStat: TDBGrid;
    dtaUserStat: TDataSource;
    tblUserStat: TAdoTable;
    Label2: TLabel;
    Label3: TLabel;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    tblUserStatUser_Name: TStringField;
    tblUserStatUser_Program: TStringField;
    tblUserStatUser_Date: TStringField;
    tblUserStatUser_Time: TStringField;
    cmdDel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbUsersClick(Sender: TObject);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbUsersKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmbUsersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDelClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadData;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

Uses
  Globals, DateProc, Keyboard, MSGs, DBS_Proc;

{$R *.DFM}

procedure TfrmUserState.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  cmdDel.Caption := (cmdDel.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  tblUserStatUser_Name.DisplayLabel := (tblUserStatUser_Name.DisplayLabel);
  tblUserStatUser_Program.DisplayLabel := (tblUserStatUser_Program.DisplayLabel);
  tblUserStatUser_Date.DisplayLabel := (tblUserStatUser_Date.DisplayLabel);
  tblUserStatUser_Time.DisplayLabel := (tblUserStatUser_Time.DisplayLabel);
end;

procedure TfrmUserState.ReadData;
var s : String;
begin
  s := '';
  if cmbUsers.Text <> '' then
    s := 'User_Name = ''' + cmbUsers.Text + '''';

  if txtFromDate.Text <> '' then
    if s = '' then
      s := 'User_Date >= ''' + txtFromDate.Text + ''''
    else
      s := s + ' AND User_Date >= ''' + txtFromDate.Text + '''';

  if txtToDate.Text <> '' then
    if s = '' then
      s := 'User_Date <= ''' + txtToDate.Text + ''''
    else
      s := s + ' AND User_Date <= ''' + txtToDate.Text + '''';

  tblUserStat.Filtered := False;
  tblUserStat.Filter := s;
  tblUserStat.Filtered := True;
end;

procedure TfrmUserState.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Security');
  qry.Open;
  while not qry.Eof do
  begin
    cmbUsers.Items.Add(qry.FieldByName('UserName').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;
  tblUserStat.connection := frmDBS.DBConnection;
  tblUserStat.Open;
  cmdDel.Visible := (UpperCase(g_options.UserName) = ADMIN_NAME);
end;

procedure TfrmUserState.FormDestroy(Sender: TObject);
begin
  tblUserStat.Close;
end;

procedure TfrmUserState.cmbUsersClick(Sender: TObject);
begin
  ReadData;
end;

procedure TfrmUserState.txtFromDateExit(Sender: TObject);
begin
  if (txtFromDate.Text <> '') and IsTrueDate(txtFromDate.Text) then
  begin
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
    ReadData;
  end
  else
    txtFromDate.Text := '';
end;

procedure TfrmUserState.txtToDateExit(Sender: TObject);
begin
  if (txtToDate.Text <> '') and IsTrueDate(txtToDate.Text) then
  begin
    txtToDate.Text := BeautifulDate(txtToDate.Text);
    ReadData;
  end
  else
    txtToDate.Text := '';
end;

procedure TfrmUserState.cmbUsersKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtFromDate.SetFocus;
  end;
end;

procedure TfrmUserState.txtFromDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmUserState.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgUserStat.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmUserState.cmbUsersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbUsers.ItemIndex := -1;
  end;
end;

procedure TfrmUserState.cmdDelClick(Sender: TObject);
begin
  if (tblUserStat.RecordCount > 0) and
     ConfirmMessage('¬Ì« »—«Ì Õ–› —ﬂÊ—œÂ« «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    while not tblUserStat.Eof do
      tblUserStat.Delete;
  end;
end;

end.
