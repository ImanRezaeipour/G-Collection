unit KeyPad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Globals, FarsiApi,Code_Sys;

type
  TfrmKeyPad = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    txt1: TEdit;
    txt2: TEdit;
    txt3: TEdit;
    txt4: TEdit;
    txt5: TEdit;
    txt6: TEdit;
    txt7: TEdit;
    txt8: TEdit;
    txt9: TEdit;
    txt10: TEdit;
    txt11: TEdit;
    txt12: TEdit;
    txt13: TEdit;
    txt14: TEdit;
    txt15: TEdit;
    txt16: TEdit;
    txt17: TEdit;
    txt18: TEdit;
    txt19: TEdit;
    txt20: TEdit;
    txtCoName: TEdit;
    Label13: TLabel;
    cmdSave: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    txt21: TEdit;
    txt22: TEdit;
    txt23: TEdit;
    txt24: TEdit;
    txt25: TEdit;
    txt26: TEdit;
    txt27: TEdit;
    txt28: TEdit;
    txt29: TEdit;
    txt30: TEdit;
    Label14: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtCoNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    txt : array[1..30] of TEdit;
    Keys : KeyType;

    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmKeyPad.SetWinF;
begin
  Caption := (Caption);
  Label13.Caption := (Label13.Caption);
  Label11.Caption := (Label11.Caption);
  Label12.Caption := (Label12.Caption);
  Label14.Caption := (Label14.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label7.Caption := (Label7.Caption);
  Label8.Caption := (Label8.Caption);
  Label9.Caption := (Label9.Caption);
  Label10.Caption := (Label10.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  cmdSave.Caption := (cmdSave.Caption);
end;
procedure TfrmKeyPad.FormCreate(Sender: TObject);
var i : Byte;
a : boolean;
begin
  SetWinF;
  SetDirectionFarsi(txtCoName.Handle);
  txt[1] := txt1;
  txt[2] := txt2;
  txt[3] := txt3;
  txt[4] := txt4;
  txt[5] := txt5;
  txt[6] := txt6;
  txt[7] := txt7;
  txt[8] := txt8;
  txt[9] := txt9;
  txt[10] := txt10;
  txt[11] := txt11;
  txt[12] := txt12;
  txt[13] := txt13;
  txt[14] := txt14;
  txt[15] := txt15;
  txt[16] := txt16;
  txt[17] := txt17;
  txt[18] := txt18;
  txt[19] := txt19;
  txt[20] := txt20;
  txt[21] := txt21;
  txt[22] := txt22;
  txt[23] := txt23;
  txt[24] := txt24;
  txt[25] := txt25;
  txt[26] := txt26;
  txt[27] := txt27;
  txt[28] := txt28;
  txt[29] := txt29;
  txt[30] := txt30;
  for i := 1 to 30 do SetDirectionFarsi(txt[i].Handle);
  LoadKeyPads(Keys);

  txtCoName.Text := Keys[0];
  for i := 1 to 30 do txt[i].Text := Keys[i];
end;

procedure TfrmKeyPad.txtCoNameKeyPress(Sender: TObject; var Key: Char);
var p : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    p := Self.FindNextControl(Self.ActiveControl, True, True, False);
    p.SetFocus;
  end;
end;

procedure TfrmKeyPad.cmdSaveClick(Sender: TObject);
var i : Byte;
begin
  Keys[0] := txtCoName.Text;
  for i := 1 to 30 do Keys[i] := txt[i].Text;
  SaveKeyPads(Keys);
  Close;
end;

end.
