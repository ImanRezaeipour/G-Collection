unit MnuSet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Math, Menus, Globals, DosMove;

type
  TfrmMnuItemList = class(TForm)
    pnlCheckBox: TPanel;
    pnlButton: TPanel;
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    cmdAll: TBitBtn;
    cmdNone: TBitBtn;
    cmdHelp: TBitBtn;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    DosMove1: TDosMove;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    CheckBox36: TCheckBox;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    CheckBox39: TCheckBox;
    CheckBox40: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdAllClick(Sender: TObject);
    procedure cmdNoneClick(Sender: TObject);
  private
    { Private declarations }
    chk : Array [0..59] Of TCheckBox;
    ItemCaptions : Array [0..59] Of String;
    MaxItem : Integer;
    Actv : Boolean;

    procedure SetWinF;
    function  FixLen(txt : String) : String;
    procedure SetCaptions;

  public
    { Public declarations }
    mnus : TMainMenu;
    MnuBarVal,
    MnuItemVal : LongInt;

  end;


implementation

uses
  Funcs;

{$R *.DFM}


procedure TfrmMnuItemList.SetWinF;
begin
  cmdAll.Caption := (cmdAll.Caption);
  cmdNone.Caption := (cmdNone.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmMnuItemList.SetCaptions;
var i, j : Byte;
begin
  case MnuBarVal of
    MNU_BASE      : j := 2;
    MNU_REPORT    : j := 1;
    MNU_SETUP     : j := 1;
    MNU_RELATION  : j := 1;
    MNU_TOOLS     : j := 7;
    else            j := 1;
  end;

  for i := 0 to mnus.Items[MnuBarVal].Count - j do
    if mnus.Items[MnuBarVal].Items[i].Caption <> '-' then
    begin
      ItemCaptions[MaxItem] := mnus.Items[MnuBarVal].Items[i].Caption;
      Inc(MaxItem);
    end;
end;

function TfrmMnuItemList.FixLen(txt : String) : String;
begin
  while Canvas.TextWidth(txt) < 178 do
    txt := ' ' + txt;

  FixLen := txt;
end;


procedure TfrmMnuItemList.FormActivate(Sender: TObject);
var
  i : Integer;
  s : String;
begin
  if Pos('&', Caption) > 0 then
  begin
    s := Caption;
    Delete(s, Pos('&', s), 1);
    Caption := s;
  end;

  SetWinF;
  Actv := False;
  if mnus.Items[MnuBarVal].Count <> 0 then
  begin
    SetCaptions;

    chk[0] := CheckBox1;
    chk[1] := CheckBox2;
    chk[2] := CheckBox3;
    chk[3] := CheckBox4;
    chk[4] := CheckBox5;
    chk[5] := CheckBox6;
    chk[6] := CheckBox7;
    chk[7] := CheckBox8;
    chk[8] := CheckBox9;
    chk[9] := CheckBox10;
    chk[10] := CheckBox11;
    chk[11] := CheckBox12;
    chk[12] := CheckBox13;
    chk[13] := CheckBox14;
    chk[14] := CheckBox15;
    chk[15] := CheckBox16;
    chk[16] := CheckBox17;
    chk[17] := CheckBox18;
    chk[18] := CheckBox19;
    chk[19] := CheckBox20;
    chk[20] := CheckBox21;
    chk[21] := CheckBox22;
    chk[22] := CheckBox23;
    chk[23] := CheckBox24;
    chk[24] := CheckBox25;
    chk[25] := CheckBox26;
    chk[26] := CheckBox27;
    chk[27] := CheckBox28;
    chk[28] := CheckBox29;
    chk[29] := CheckBox30;
    chk[30] := CheckBox31;
    chk[31] := CheckBox32;
    chk[32] := CheckBox33;
    chk[33] := CheckBox34;
    chk[34] := CheckBox35;
    chk[35] := CheckBox36;
    chk[36] := CheckBox37;
    chk[37] := CheckBox38;
    chk[38] := CheckBox39;
    chk[39] := CheckBox40;

    for i := 0 to MaxItem-1 do
    begin
      chk[i].Caption := ItemCaptions[i];
      chk[i].Visible := True;
      if (Trunc(Power(2, i)) and MnuItemVal) <> 0 then
        chk[i].Checked := True
      else
        chk[i].Checked := False;
    end;
    Actv := True;
  end;
end;

procedure TfrmMnuItemList.cmdSaveClick(Sender: TObject);
var i : Integer;
begin
  MnuItemVal := 0;
  for i := 0 to MaxItem-1 do
    if chk[i].Checked then
      MnuItemVal := Trunc(Power(2, i)) or MnuItemVal;
end;

procedure TfrmMnuItemList.cmdAllClick(Sender: TObject);
var i : Integer;
begin
  for i := 0 to MaxItem-1 do
    chk[i].Checked := True;
end;

procedure TfrmMnuItemList.cmdNoneClick(Sender: TObject);
var i : Integer;
begin
  for i := 0 to MaxItem-1 do chk[i].Checked := False;
end;

end.
