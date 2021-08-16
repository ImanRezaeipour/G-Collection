unit MnuSet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Math, Menus, Globals;

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
    procedure FormActivate(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdAllClick(Sender: TObject);
    procedure cmdNoneClick(Sender: TObject);
  private
    { Private declarations }
    chk : Array [0..17] Of TCheckBox;
    ItemCaptions : Array [0..17] Of String;
    ItemEnabled : Array [0..17] of Boolean;
    ItemVisible : Array [0..17] of Boolean;
    MaxItem : Integer;
    Actv : Boolean; 

    procedure SetCaptions;
    procedure SetWinF;

  public
    { Public declarations }
    mnus : TMainMenu;
    MnuBarVal,
    MnuItemVal : LongInt;

  end;


implementation

{$R *.DFM}


procedure TfrmMnuItemList.SetCaptions;
var i, j : Byte;
begin
  case MnuBarVal of
    MNU_BASE     : j := 2;
    MNU_RELATION : j := 1;
    MNU_TRANSFER : j := 1;
    MNU_SPECIAL  : j := 1;
    MNU_REPORT   : j := 1;
    MNU_TOOLS    : j := 5;
    else           j := 1;
  end;

  for i := 0 to mnus.Items[MnuBarVal].Count - j do
    if mnus.Items[MnuBarVal].Items[i].Caption <> '-' then
    begin
      ItemCaptions[MaxItem] := mnus.Items[MnuBarVal].Items[i].Caption;
      ItemEnabled[MaxItem]:= mnus.Items[MnuBarVal].Items[i].Enabled;
      ItemVisible[MaxItem]:= mnus.Items[MnuBarVal].Items[i].Visible;
      Inc(MaxItem);
    end;
end;

procedure TfrmMnuItemList.SetWinF;
begin
  cmdAll.Caption := (cmdAll.Caption);
  cmdNone.Caption := (cmdNone.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmMnuItemList.FormActivate(Sender: TObject);
var i : Integer;
begin
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

    for i := 0 to MaxItem-1 do
    begin
      chk[i].Caption := ItemCaptions[i];
      chk[i].Visible := True;
      chk[i].Enabled := ItemEnabled[i];
      chk[i].Visible := ItemVisible[i];
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
  for i := 0 to MaxItem-1 do
    chk[i].Checked := False;
end;

end.
