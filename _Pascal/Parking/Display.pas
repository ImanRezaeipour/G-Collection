unit Display;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, StdCtrls, Buttons, ComTools, RunCmnds, MSGs, Globals,
  DBS, Keyboard, Cntroler;

type
  TfrmDisplay = class(TForm)
    Label1: TLabel;
    cmdOK: TBitBtn;
    cmdExit: TBitBtn;
    txtCode: TEdit;
    cmdHelp: TBitBtn;
    lblMsg: TLabel;
    Label2: TLabel;
    txtData: TEdit;
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOKClick(Sender: TObject);
    procedure txtCodeChange(Sender: TObject);
    procedure txtDataKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmDisplay.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmDisplay.txtCodeChange(Sender: TObject);
begin
  lblMsg.Caption := '';
end;

procedure TfrmDisplay.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtData.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmDisplay.txtDataKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdOK.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmDisplay.cmdOKClick(Sender: TObject);
var OK : Boolean;
begin
  if txtCode.Text = '' then
  begin
    ErrorMessage('ﬂœ ‰„«Ì‘ê— „‘Œ’ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtData.Text = '' then
  begin
    ErrorMessage('„ﬁœ«—  ⁄ÌÌ‰ ‰‘œÂ «” .');
    txtData.SetFocus;
  end
  else
  begin
    lblMsg.Caption := ('œ— Õ«· «— »«ÿ »« œ” ê«Â');
    lblMsg.Refresh;
    SetUserControl;
    CustDisplaySet(StrToInt(txtCode.Text), txtData.Text, OK);
    USERCONTROL := False;
    if OK then
      lblMsg.Caption := ('.«—”«· „Ê›ﬁÌ  ¬„Ì“ »Êœ')
    else
      lblMsg.Caption := ('.«— »«ÿ »—ﬁ—«— ‰Ì” ');
    lblMsg.Refresh;
    Mouse_NoWait;
  end;
end;

procedure TfrmDisplay.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

end.
