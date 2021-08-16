unit ChngBaud;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, AdoDB, Ertebat, MSGs, Globals,
  DBS_Proc, DateProc;

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
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;



implementation
uses ComTools;
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
    ErrorMessage('œ” ê«Â „‘Œ’ ‰Ì” .');
    lstReader.SetFocus;
  end
  else if lstBaud.ItemIndex < 0 then
  begin
    AreValidFields := False;
    ErrorMessage('”—⁄  «— »«ÿ „‘Œ’ ‰Ì” .');
    lstBaud.SetFocus;
  end
  else if not (lstBaud.ItemIndex in [0..11]) then
  begin
    AreValidFields := False;
    ErrorMessage('”—⁄  «— »«ÿ œ—”  ‰Ì”  ');
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
  idx, STAT : Byte;
  PK : String;
  BD : Char;
  OK : Boolean;
begin
  if AreValidFields then
  begin
    Mouse_Wait;
    idx := FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex]);
    lblMsg.Caption := ('œ— Õ«· «— »«ÿ »« œ” ê«Â');
    lblMsg.Refresh;
    SetUserControl;
    if SwitchReader(idx) then
    begin
      BD := Chr(ToBCD(lstBaud.ItemIndex));
      MakePocket(PK, MicroAddress, $2D, 0, BD);
      if not SendPocket(PK) then
        OK := False
      else
      begin
        GetPocket(PK, True, STAT);
        if (STAT = 0) and (length(PK)>3) then
          OK := (ORD(PK[4]) = $06)
        else
          OK := False;
      end;
    end
    else
      OK := False;

    if OK then
    begin
      lblMsg.Caption := (' €ÌÌ— ”—⁄  «‰Ã«„ ‘œ.');
      lblMsg.Refresh;
      Readers[idx].R_BaudNo := lstBaud.ItemIndex;
      Delay(500);

      qry := TAdoQuery.Create(Application);
      with qry do
      begin
        connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('UPDATE Readers SET R_BaudNo = ' + IntToStr(Readers[idx].R_BaudNo));
        SQL.Add('WHERE R_Name = ''' + lstReader.Items.Strings[lstReader.ItemIndex] + '''');
        ExecSQL;
        Free;
      end;

      if not RS232Initial(Readers[idx].R_BaudNo, Readers[idx].R_Port, Readers[idx].R_Type) then
        ErrorMessage('»«“ê‘«ÌÌ ÅÊ—  „Ì”— ‰Ì” .');
    end
    else
      lblMsg.Caption := ('«— »«ÿ »—ﬁ—«— ‰Ì” .');
    lblMsg.Refresh;
    Mouse_NoWait;
    USERCONTROL := False;
  end;
end;


end.
