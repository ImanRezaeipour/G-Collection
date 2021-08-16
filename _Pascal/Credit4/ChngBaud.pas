unit ChngBaud;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, ComTools, RunCmnds, MSGs, Globals,
  DBS, ADODB, DosMove;

type
  TfrmChngBaud = class(TForm)
    lbl2: TLabel;
    cmdOK: TBitBtn;
    cmdExit: TBitBtn;
    lbl1: TLabel;
    cmdHelp: TBitBtn;
    lblMsg: TLabel;
    lstReader: TListBox;
    lstBaud: TListBox;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure lstReaderClick(Sender: TObject);
    procedure lstReaderKeyPress(Sender: TObject; var Key: Char);
    procedure lstBaudKeyPress(Sender: TObject; var Key: Char);
    procedure lstBaudClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    function  AreValidFields : Boolean;

  public
    { Public declarations }
  end;



implementation

uses
  Funcs;

{$R *.DFM}



procedure TfrmChngBaud.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

function TfrmChngBaud.AreValidFields : Boolean;
begin
  if lstReader.ItemIndex < 0 then
  begin
    AreValidFields := False;
    ErrorMessage('ÏÓÊÇå ãÔÎÕ äíÓÊ.');
    lstReader.SetFocus;
  end
  else if lstBaud.ItemIndex < 0 then
  begin
    AreValidFields := False;
    ErrorMessage('ÓÑÚÊ ÇÑÊÈÇØ ãÔÎÕ äíÓÊ.');
    lstBaud.SetFocus;
  end
  else if not (lstBaud.ItemIndex in [0..11]) then
  begin
    AreValidFields := False;
    ErrorMessage('ÓÑÚÊ ÇÑÊÈÇØ ÏÑÓÊ äíÓÊ ');
    lstBaud.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmChngBaud.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  lstBaud.Clear;
  for i := 0 to MaxBaudIndex do
    lstBaud.Items.Add(IntToStr(BAUDRATES[i]));

  for i := 1 to TotalReader do
    if Readers[i].R_Active and
       (Readers[i].R_Type in [RDR_CLK6000]) then
      lstReader.Items.Add(Readers[i].R_Name);
end;

procedure TfrmChngBaud.lstReaderClick(Sender: TObject);
begin
  lstBaud.ItemIndex := Readers[FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex])].R_BaudNo;
  lblMsg.Caption := '';
end;

procedure TfrmChngBaud.lstReaderKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    lstBaud.SetFocus;
  end;
end;

procedure TfrmChngBaud.lstBaudClick(Sender: TObject);
begin
  lblMsg.Caption := '';
end;

procedure TfrmChngBaud.lstBaudKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdOK.SetFocus;
  end;
end;

procedure TfrmChngBaud.cmdOKClick(Sender: TObject);
var
  qry : TAdoQuery;
  idx : Byte;
begin
  if AreValidFields then
  begin
    Mouse_Wait;
    idx := FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex]);
    lblMsg.Caption := ('ÏÑ ÍÇá ÊÛííÑ ÓÑÚÊ');
    lblMsg.Refresh;
    SetUserControl;
    if ChangeBaudRate(Readers[idx], lstBaud.ItemIndex+7) then
    begin
      lblMsg.Caption := ('ÊÛííÑ ÓÑÚÊ ÇäÌÇã ÔÏ.');
      lblMsg.Refresh;
      Readers[idx].R_BaudNo := lstBaud.ItemIndex;
      Sleep(500);

     with qry do
      begin
        qry := TAdoQuery.Create(Application);
        Connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('UPDATE Readers SET R_BaudNo = ' + IntToStr(lstBaud.ItemIndex));
        SQL.Add('WHERE R_Code = ' + IntToStr(Readers[idx].R_Code));
        ExecSQL;
        Free;
      end;
      LoadReaders;
    end
    else
      lblMsg.Caption := ('ÇÑÊÈÇØ ÈÑÞÑÇÑ äíÓÊ.');

    lblMsg.Refresh;
    Mouse_NoWait;
    USERCONTROL := False;
  end;
end;


end.
