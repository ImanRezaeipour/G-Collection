unit LmitCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids;

type
  TfrmLimitCard = class(TForm)
    cmbReaders: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cmbOperate: TComboBox;
    cmdOk: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    grdPishCard: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure cmbReadersKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOkClick(Sender: TObject);
    procedure grdPishCardKeyPress(Sender: TObject; var Key: Char);
    procedure grdPishCardEnter(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    procedure InitialGrid;

  public
    { Public declarations }
  end;


implementation

uses
  Globals, Keyboard, DateProc, MSGs, Ertebat, ComTools;

{$R *.DFM}


function Str_PBCD(ST : String; l : Byte) : String;
var
  i, k : Byte;
  S : String;
begin
  S := '';
  if l > 0 then ST := FixLeft(ST, '0', l);
  if Odd(Length(ST)) then ST := '0' + ST;
  l := Length(ST);
  for i := 1 to l do
    if ST[i] in ['0'..'9', 'a'..'f', 'A'..'F'] then
    begin
      if ST[i] in ['a'..'f'] then ST[i] := Chr(Ord(ST[i])-32);
    end
    else
    begin
      Str_PBCD := '';
      Exit;
    end;

  i := 1;
  while i <= l do
  begin
    if ST[i] in ['0'..'9'] then
      k := (Ord(ST[i])-48)*16
    else
      k := (Ord(ST[i])-55)*16;

    if ST[i+1] in ['0'..'9'] then
      k := k + Ord(ST[i+1])-48
    else
      k := k + Ord(ST[i+1])-55;

    S := S + Chr(k);
    Inc(i, 2);
  end;
  Str_PBCD := S;
end;

function PBCD_Str(ST : String; l : Byte) : String;
var
  i : Byte;
  S : String;
begin
  S := '';
  for i := 1 to Length(ST) do
    S := S + HexToChar(Ord(ST[i]) div 16) + HexToChar(Ord(ST[i]) mod 16);
  if l > 0 then S := FixLeft(S, '0', l);
  PBCD_Str := S;
end;

function SetLimitCard(No : Byte; FromCard, ToCard : String) : Boolean;
var
  PK, ST : String;
  getVal: Byte;
  OK : Boolean;
begin
  if (FromCard = '') or (ToCard = '') then
    ST := Chr(No) + #255#255#255#255#255#255#255#255
  else
    ST := Chr(No) + Str_PBCD(FromCard, 8) + Str_PBCD(ToCard, 8);

  MakePocket(PK, MicroAddress, $36, 0, ST);
  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, getVal);
    if length(pk)>3 then
      OK := (getVal = 0) and (Ord(PK[4]) = $06) and (Ord(PK[3]) = MicroAddress)
    else
      OK := false;
  end;
  SetLimitCard := OK;
end;

function GetlimitCard(No : Byte; var FromCard, ToCard : String) : Boolean;
var
  PK : String;
  getVal : Byte;
  OK : Boolean;
begin
  MakePocket(PK, MicroAddress, $37, 0, Chr(No));
  if not SendPocket(PK) then
    OK := False
  else
  begin
    GetPocket(PK, True, getVal);
    if length(pk)>3 then
      OK := ((getVal = 0) and (Ord(PK[4]) = $36) and (Ord(PK[3]) = MicroAddress))
    else
      OK := False;
    if OK then
    begin
      Delete(PK, 1, 6);
      FromCard := PBCD_Str(Copy(PK, 1, 4), 8);
      ToCard := PBCD_Str(Copy(PK, 5, 4), 8);
    end;
  end;

  GetLimitCard := OK;
end;

procedure TfrmLimitCard.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  for i := 0 to cmbOperate.Items.Count-1 do
    cmbOperate.Items.Strings[i] := (cmbOperate.Items.Strings[i]);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmLimitCard.InitialGrid;
var i : Byte;
begin
  grdPishCard.ColCount := 3;
  grdPishCard.RowCount := 13;

  grdPishCard.ColWidths[0] := 50;
  grdPishCard.Cells[0, 0] := ('—œÌ›');

  grdPishCard.ColWidths[1] := 100;
  grdPishCard.Cells[1, 0] := ('‘—Ê⁄ ﬂ«— Â«');

  grdPishCard.ColWidths[2] := 100;
  grdPishCard.Cells[2, 0] := ('Å«Ì«‰ ﬂ«— Â«');
  for i := 1 to 8 do grdPishCard.Cells[0, i] := IntToStr(i);
end;

procedure TfrmLimitCard.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  for i := 1 to TotalReader do
    cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);

  cmbReaders.ItemIndex := 0;
  cmbOperate.ItemIndex := 0;
  InitialGrid;
end;

procedure TfrmLimitCard.cmbReadersKeyPress(Sender: TObject; var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, True);
    tp.SetFocus;
  end;
end;

procedure TfrmLimitCard.cmdOkClick(Sender: TObject);
const
  SET_LIMITCARD = 0;
  GET_LIMITCARD = 1;

var
  i : Byte;
  OK : Boolean;
  ST1, ST2 : String;
begin
  if cmbReaders.Text = '' then
  begin
    ErrorMessage(' —„Ì‰«· „‘Œ’ ‰‘œÂ «” .');
    cmbReaders.SetFocus;
  end
  else if cmbOperate.Text = '' then
   begin
    ErrorMessage('⁄„·Ì«  „‘Œ’ ‰‘œÂ «” .');
    cmbReaders.SetFocus;
  end
  else
  begin
    case cmbOperate.ItemIndex of
      SET_LIMITCARD:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«·  ‰ŸÌ„ „ÕœÊœÂ ﬂ«— Â«...');
        OK := True;
        SwitchReader(cmbReaders.ItemIndex+1);
        for i := 1 to 8 do
        begin
          OK := (OK AND SetLimitCard(i, grdPishCard.Cells[1, i], grdPishCard.Cells[2, i]));
          if not OK then Break;
        end;
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('„ÕœÊœÂ ›⁄«·Ì  ﬂ«— Â« »Â  —„Ì‰«· «—”«· ‘œ.')
        else
          InformationMessage('«—”«· „ÕœÊœÂ ›⁄«·Ì  ‘„«—Â ' + IntToStr(i) + ' »Â  —„Ì‰«· ‰«„Ê›ﬁ »Êœ.');
      end;

      GET_LIMITCARD:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«· ŒÊ«‰œ‰ „ÕœÊœÂ ›⁄«·Ì  ﬂ«— Â«...');
        SwitchReader(cmbReaders.ItemIndex+1);
        for i := 1 to 8 do
        begin
          grdPishCard.Cells[1, i] := '';
          grdPishCard.Cells[2, i] := '';
        end;

        grdPishCard.Refresh;
        for i := 1 to 8 do
        begin
          if GetLimitCard(i, ST1, ST2) then
          begin
            OK := True;
            //if ST1 <> '00000000' then
            begin
              grdPishCard.Cells[1, i] := ST1;
              grdPishCard.Cells[2, i] := ST2;
              grdPishCard.Refresh;
            end;
          end
          else
          begin
            OK := False;
            InformationMessage('ŒÊ«‰œ‰ „ÕœÊœÂ ›⁄«·Ì  ﬂ«— Â« œ— —œÌ› '+ IntToStr(i) + '  —„Ì‰«· ‰«„Êﬁ »Êœ.');
            Break;
          end;
        end;

        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('„ÕœÊœÂ ›⁄«·Ì  ﬂ«— Â«Ì  —„Ì‰«· ŒÊ«‰œÂ ‘œ.');
        {else
          InformationMessage('ŒÊ«‰œ‰ „ÕœÊœÂ ›⁄«·Ì  ﬂ«—  —œÌ› '+ IntToStr(i) + '  —„Ì‰«· ‰«„Êﬁ »Êœ.');}
      end;

    end;
  end;
end;

procedure TfrmLimitCard.grdPishCardKeyPress(Sender: TObject; var Key: Char);
var s : String;
begin
  grdPishCardEnter(Sender);
  if grdPishCard.Col <> 0 then
  begin
    Keyboard_Proxi(Key);
    s := grdPishCard.Cells[grdPishCard.Col, grdPishCard.Row];
    if (Length(s) = 8) and not (Key in [#13, #8]) then Key := #0;
  end;
end;

procedure TfrmLimitCard.grdPishCardEnter(Sender: TObject);
begin
  if grdPishCard.Col = 0 then
    grdPishCard.Options := grdPishCard.Options - [goEditing]
  else
    grdPishCard.Options := grdPishCard.Options + [goEditing];

  grdPishCard.Refresh;
end;

end.
