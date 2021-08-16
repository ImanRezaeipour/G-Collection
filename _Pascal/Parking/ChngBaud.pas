unit ChngBaud;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, AdoDB, ComTools, RunCmnds, MSGs, Globals,
  DBS, DateProc, Z84_CMD;

type
  TfrmChngBaud = class(TForm)
    Label1: TLabel;
    cmdOK: TBitBtn;
    cmdExit: TBitBtn;
    Label2: TLabel;
    cmdHelp: TBitBtn;
    lblMsg: TLabel;
    lstReader: TListBox;
    lstBaud: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure lstReaderClick(Sender: TObject);
    procedure lstReaderKeyPress(Sender: TObject; var Key: Char);
    procedure lstBaudKeyPress(Sender: TObject; var Key: Char);
    procedure lstBaudClick(Sender: TObject);
  private
    { Private declarations }
    function AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;



implementation

{$R *.DFM}

procedure TfrmChngBaud.SetWinF;
begin
  Caption := (Caption);
  Label2.Caption := (Label2.Caption);
  Label1.Caption := (Label1.Caption);
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
    if Readers[i].R_Active then
      lstReader.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);
end;

procedure TfrmChngBaud.lstReaderClick(Sender: TObject);
var
  i : Byte;
  s : String;
begin
  s := lstReader.Items.Strings[lstReader.ItemIndex];
  i := FindReaderCodeIdx(StrToInt(Copy(s, 1, Pos('-', s)-1)));
  lstBaud.ItemIndex := Readers[i].R_BaudNo;
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
  s : String;
begin
  if AreValidFields then
  begin
    Mouse_Wait;
    s := lstReader.Items.Strings[lstReader.ItemIndex];
    idx := FindReaderCodeIdx(StrToInt(Copy(s, 1, Pos('-', s)-1)));
    lblMsg.Caption := ('ÏÑ ÍÇá ÇÑÊÈÇØ ÈÇ ÏÓÊÇå');
    lblMsg.Refresh;
    SetUserControl;
    if SwitchReader(idx) then
    begin
      if ChangeBaudRate(Readers[idx],lstBaud.ItemIndex) then
      begin
        lblMsg.Caption := ('ÊÛííÑ ÓÑÚÊ ÇäÌÇã ÔÏ.');
        lblMsg.Refresh;
        Readers[idx].R_BaudNo := lstBaud.ItemIndex;
        Sleep(500);

        qry := TAdoQuery.Create(Application);
        with qry do
        begin
          connection := frmDBS.adoConnect;
          SQL.Clear;
          SQL.Add('UPDATE Readers SET R_BaudNo = ' + IntToStr(Readers[idx].R_BaudNo));
          SQL.Add('WHERE R_Code = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;
          Free;
        end;

        lstReader.SetFocus;
//        RS232Initial(Readers[idx].R_BaudNo, Readers[idx].R_Port, RDR_CLOCK_Z84);
      end
      else
        lblMsg.Caption := ('ÇÑÊÈÇØ ÈÑÞÑÇÑ äíÓÊ.');
    end;
    lblMsg.Refresh;
    Mouse_NoWait;
    USERCONTROL := False;
  end;
end;


end.
