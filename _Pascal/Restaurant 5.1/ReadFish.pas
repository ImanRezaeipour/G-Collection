unit ReadFish;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmReadFish = class(TForm)
    Label1: TLabel;
    txtFromDate: TEdit;
    Label2: TLabel;
    txtToDate: TEdit;
    Label3: TLabel;
    txtPath: TEdit;
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    cmdPath: TButton;
    procedure cmdOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateExit(Sender: TObject);
    procedure txtPathKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPathClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

uses
  dbTables, FileCtrl, Globals, DateProc, MSGs, Keyboard, SelPath, AdoDB;

{$R *.DFM}

procedure TfrmReadFish.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

procedure TfrmReadFish.FormCreate(Sender: TObject);
begin
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := txtFromDate.Text;
  txtPath.Text := g_options.DataBasePath;
  SetWinF;
end;

procedure TfrmReadFish.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmReadFish.txtFromDateExit(Sender: TObject);
begin
  with txtFromDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmReadFish.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPath.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmReadFish.txtToDateExit(Sender: TObject);
begin
  with txtToDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmReadFish.txtPathKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdOK.SetFocus;
  end;
end;

procedure TfrmReadFish.cmdPathClick(Sender: TObject);
var frmSelPath : TfrmSelPath;
begin
  Application.CreateForm(TfrmSelPath, frmSelPath);
  if frmSelPath.ShowModal = mrOK then
    txtPath.Text := frmSelPath.lblPath.Caption;
  frmSelPath.Free;
end;

procedure TfrmReadFish.cmdOKClick(Sender: TObject);
var
  qry : TAdoQuery;
  p1, p2 : String;
begin
  p1 := g_options.DataBasePath;
  if txtPath.Text <> '' then
    p2 := txtPath.Text
  else
    p2 := p1;

  if p2[Length(p2)] <> '\' then p2 := p2 + '\';

  if p1 = p2 then
  begin
    ErrorMessage('ÈÇÒÎæÇäí ÝíÔåÇ ÇÒ ÈÇäß ÇÕáí ÇãßÇä ÐíÑ äíÓÊ.');
    txtPath.SetFocus;
  end
  else if not DirectoryExists(p2) then
  begin
    ErrorMessage('ãÓíÑ ÇäÊÎÇÈ ÔÏå æÌæÏ äÏÇÑÏ.');
    txtPath.SetFocus;
  end
  else if not FileExists(p2+'Fish.Db') or
          not FileExists(p2+'FishFood.Db') then
  begin
    ErrorMessage('ÈÇäß ÇãÑÈæØ Èå ÝíÔåÇ ÏÑ ãÓíÑ ÇäÊÎÇÈ ÔÏå æÌæÏ äÏÇÑÏ.');
    txtPath.SetFocus;
  end
  else if ConfirmMessage('ÂíÇ ÈÑÇí ÈÇÒÎæÇäí ÝíÔåÇ ÇØãíäÇä ÏÇÑíÏ¿') then
  begin
    Mouse_Wait;
    MSG_Wait('ÏÑ ÍÇá ÈÇÒÎæÇäí ÝíÔåÇ...');

    qry := TADOQuery.Create(Application);
//    qry.DatabaseName := p1;

    if ConfirmMessage('ÝíÔåÇí ÞÈáí ãæÌæÏ ÏÑ ÈÇä˜ ÇØáÇÚÇÊí ÏÑ ÈÇÒå ÒãÇäí ãÔÎÕ ÔÏå ÍÐÝ ÑÏäÏ ¿') then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Fish');
      qry.SQL.Add('WHERE Fish_Date >= ''' + txtFromDate.Text + '''');
      qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM FishFood');
      qry.SQL.Add('WHERE FF_Date >= ''' + txtFromDate.Text + '''');
      qry.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');
      qry.ExecSQL;
    end;

    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO Fish');
    qry.SQL.Add('SELECT * FROM ''' + p2+ 'Fish.Db''');
    qry.SQL.Add('WHERE Fish_Date >= ''' + txtFromDate.Text + '''');
    qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO FishFood');
    qry.SQL.Add('SELECT * FROM ''' + p2+ 'FishFood.Db''');
    qry.SQL.Add('WHERE FF_Date >= ''' + txtFromDate.Text + '''');
    qry.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');
    qry.ExecSQL;

    qry.Free;
    MSG_NoWait;
    Mouse_NoWait;
  end;
end;

end.
