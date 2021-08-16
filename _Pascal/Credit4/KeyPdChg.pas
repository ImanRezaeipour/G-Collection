unit KeyPdChg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ComTools, MSGs, Globals,
  Keyboard, DBS, RunCmnds;

type
  TfrmKeypayPassword = class(TForm)
    lbl2: TLabel;
    lbl1: TLabel;
    cmdOK: TBitBtn;
    cmdExit: TBitBtn;
    txtPassword: TEdit;
    cmdHelp: TBitBtn;
    lblMsg: TLabel;
    lstReader: TListBox;
    procedure txtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure txtPasswordChange(Sender: TObject);
    procedure lstReaderClick(Sender: TObject);
    procedure lstReaderKeyPress(Sender: TObject; var Key: Char);
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

var
   Addr_Set : set of 0..255 = [];



procedure TfrmKeypayPassword.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

function TfrmKeypayPassword.AreValidFields : Boolean;
begin
  if lstReader.ItemIndex < 0 then
  begin
    AreValidFields := False;
    ErrorMessage('ÏÓÊÇå ãÔÎÕ äÔÏå ÇÓÊ.');
    lstReader.SetFocus;
  end
  else if txtPassword.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ÑãÒ ÌÏíÏ ãÔÎÕ äÔÏå ÇÓÊ.');
    txtPassword.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmKeypayPassword.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  for i := 1 to TotalReader do
    with Readers[i] do
     begin
       if R_Active and (R_Type = RDR_CLK6000) then
         lstReader.Items.Add(R_Name);
       Addr_Set := Addr_Set + [R_Code];
    end;
end;

procedure TfrmKeypayPassword.lstReaderClick(Sender: TObject);
begin
  lblMsg.Caption := '';
end;

procedure TfrmKeypayPassword.lstReaderKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPassword.SetFocus;
  end;
end;

procedure TfrmKeypayPassword.txtPasswordChange(Sender: TObject);
begin
  lblMsg.Caption := '';
end;

procedure TfrmKeypayPassword.txtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdOK.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmKeypayPassword.cmdOKClick(Sender: TObject);
var
  idx : Byte;
begin
  if AreValidFields then
  begin
    Mouse_Wait;
    idx := FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex]);
    lblMsg.Caption := ('ÏÑ ÍÇá ÇÑÊÈÇØ ÈÇ ÏÓÊÇå');
    lblMsg.Refresh;
    SetUserControl;
    if ChangReaderPassword(Readers[idx], txtPassword.Text) then
      lblMsg.Caption := ('ÊÛííÑ ÑãÒ ÇäÌÇã ÔÏ.')
    else
      lblMsg.Caption := ('ÇÑÊÈÇØ ÈÑÞÑÇÑ äíÓÊ.');
    UserControl := False;
    lblMsg.Refresh;
    Mouse_NoWait;
  end;
end;


end.

