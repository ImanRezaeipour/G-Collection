unit StupMnu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FarsiApi, MSGs, SelPath, ExtCtrls;

type
  TfrmSetup = class(TForm)
    Label1: TLabel;
    txtCoName: TEdit;
    Label2: TLabel;
    txtPath: TEdit;
    cmdPath: TBitBtn;
    grpSecurit: TGroupBox;
    rdoSerial: TRadioButton;
    rdoPass: TRadioButton;
    txtPass: TEdit;
    cmdOK: TBitBtn;
    cmdClose: TBitBtn;
    Label3: TLabel;
    txtShobeh: TEdit;
    rdoWinType: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure cmdPathClick(Sender: TObject);
    procedure rdoSerialClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
    procedure CreateLicenceFile;
    function  GetSerialNo : String;

    function  GetRandom(S, T : Integer) : Integer;
    procedure SetWinF;

  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation

{$R *.DFM}
procedure TfrmSetup.SetWinF;
var
 i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  rdoSerial.Caption := (rdoSerial.Caption);
  rdoPass.Caption := (rdoPass.Caption);
  rdoWinType.Caption := (rdoWinType.Caption);
  for i := 0 to rdoWinType.Items.Count-1 do
    rdoWinType.Items.Strings[i] := (rdoWinType.Items.Strings[i]);

  cmdOK.Caption := (cmdOK.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

function TfrmSetup.GetRandom(S, T : Integer) : Integer;
var num : Integer;
begin
  repeat
    num := Random(T);
  until num >= S;
  GetRandom := num;
end;

function TfrmSetup.GetSerialNo : String;
begin
  GetSerialNo := 'Resturant';
end;

procedure TfrmSetup.CreateLicenceFile;
var
  data : String;
  SepChar, ch, XO : Char;
  f : file of Char;
  rnd, i : Integer;
begin
  if Copy(txtPath.Text, Length(txtPath.Text), 1) <> '\' then
    txtPath.Text := txtPath.Text + '\';

  SepChar := '+';
  if rdoSerial.Checked then
    data := GetSerialNo
  else
    data := txtPass.Text;

  data := data + SepChar + txtCoName.Text
               + SepChar + txtShobeh.Text
               + SepChar + txtPath.Text
               + SepChar + IntToStr(rdoWinType.ItemIndex + 1);

  AssignFile(f, txtPath.Text + 'Resturan.Lic');
  ReWrite(f);
  Randomize;
  rnd := GetRandom(255, 32767);
  ch := Chr(Hi(rnd));
  Write(f , ch);
  ch := Chr(Lo(rnd));
  Write(f , ch);
  XO := Chr(GetRandom(100, 255));
  Write(f , XO);
  ch := Chr(Length(data));
  Write(f , ch);
  Write(f , SepChar);
  if rdoSerial.Checked then
    ch := #0
  else
    ch := #1;
  Write(f , ch);
  for i := 7 to rnd do
  begin
    ch := Chr(GetRandom(14, 255));
    Write(f , ch) ;
  end;
  for i := 1 to Length(data) do
  begin
    ch := data[i];
    ch := Chr(Ord(ch) xor Ord(Xo));
    Write(f , ch);
  end;
  rnd := GetRandom(10, 32767);
  for i := 1 to  rnd do
  begin
    ch := Chr(Integer(Random (255)));
    Write(f , ch);
  end;
  CloseFile(f);
end;

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
  SetDirectionFarsi(txtCoName.Handle);
end;


procedure TfrmSetup.cmdPathClick(Sender: TObject);
var frmSelPath : TfrmSelPath;
begin
  Application.CreateForm(TfrmSelPath, frmSelPath);
  if frmSelPath.ShowModal = mrOK then
    txtPath.Text := frmSelPath.lblPath.Caption;
  frmSelPath.Free;
end;

procedure TfrmSetup.rdoSerialClick(Sender: TObject);
begin
  txtPass.Enabled := not rdoSerial.Checked;
end;

procedure TfrmSetup.cmdOKClick(Sender: TObject);
begin
  if txtCoName.Text = '' then
  begin
    InforMationMessage('‰«„ ‘—ﬂ /„ƒ””Â Ê«—œ ‰‘œÂ «” .');
    txtCoName.SetFocus;
  end
  else if txtPath.Text = '' then
  begin
    InforMationMessage('„”Ì— „ﬁ’œ „‘Œ’ ‰Ì” .');
    txtPath.SetFocus;
  end
  else if rdoPass.Checked and (txtPass.Text = '') then
  begin
    InforMationMessage('ﬂ·„Â —„“ Ê«—œ ‰‘œÂ «” .');
    txtPass.SetFocus;
  end
  else
  begin
    CreateLicenceFile;
    InformationMessage('»—‰«„Â ‰’» »Â Å«Ì«‰ —”Ìœ.');
  end;
end;

end.
