unit ReadArch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmReadArchive = class(TForm)
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
    cmdHelp: TBitBtn;
    Label1: TLabel;
    txtFromDate: TEdit;
    Label2: TLabel;
    txtToDate: TEdit;
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOKClick(Sender: TObject);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  AdoDB, Globals, Keyboard, MSGs, DBS, DateProc;

{$R *.DFM}

procedure TfrmReadArchive.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmReadArchive.txtFromDateKeyPress(Sender: TObject;
  var Key: Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmReadArchive.txtFromDateExit(Sender: TObject);
begin
  with txtFromDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmReadArchive.txtToDateExit(Sender: TObject);
begin
  with txtToDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmReadArchive.cmdOKClick(Sender: TObject);
var qry : TAdoQuery;
begin
  if FileExists(g_options.DB_MonthPath + 'Machines.Db') then
  begin
    if ConfirmMessage('¬Ì« »—«Ì »«“ŒÊ«‰Ì «ÿ·«⁄«  »«Ìê«‰Ì ‘œÂ «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      qry := TAdoQuery.Create(Application);

      qry.SQL.Clear;
      qry.SQL.Add('INSERT INTO ''' + g_options.DataBasePath + 'Machines.Db''');
      qry.SQL.Add('SELECT * FROM ''' + g_options.DB_MonthPath + 'Machines.Db''');
      qry.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
      if txtFromDate.Text <> '' then
        qry.SQL.Add('AND (M_IDate >= ''' + txtFromDate.Text + ''' OR M_ODate >= ''' + txtFromDate.Text + ''')');
      if txtToDate.Text <> '' then
        qry.SQL.Add('AND (M_IDate <= ''' + txtToDate.Text + ''' OR M_ODate <= ''' + txtToDate.Text + ''')');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM ''' + g_options.DB_MonthPath + 'Machines.Db''');
      qry.SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
      if txtFromDate.Text <> '' then
        qry.SQL.Add('AND (M_IDate >= ''' + txtFromDate.Text + ''' OR M_ODate >= ''' + txtFromDate.Text + ''')');
      if txtToDate.Text <> '' then
        qry.SQL.Add('AND (M_IDate <= ''' + txtToDate.Text + ''' OR M_ODate <= ''' + txtToDate.Text + ''')');
      qry.ExecSQL;

      qry.Free;
      LoadExit_Park;
    end;
  end
  else
    InformationMessage(' «ﬂ‰Ê‰ «‰ ﬁ«· «ÿ·«⁄«  „«Â«‰Â «‰Ã«„ ‰‘œÂ «” .');
end;

procedure TfrmReadArchive.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

end.
