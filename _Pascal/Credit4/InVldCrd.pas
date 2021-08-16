unit InVldCrd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DosMove;

type
  TfrmInvalidCard = class(TForm)
    cmbReaders: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cmbOperate: TComboBox;
    lbl3: TLabel;
    txtBarCode1: TEdit;
    lbl4: TLabel;
    txtBarCode2: TEdit;
    lbl5: TLabel;
    txtBarCode3: TEdit;
    lbl6: TLabel;
    txtBarCode4: TEdit;
    lbl7: TLabel;
    txtBarCode5: TEdit;
    lbl8: TLabel;
    txtBarCode6: TEdit;
    lbl9: TLabel;
    txtBarCode7: TEdit;
    lbl10: TLabel;
    txtBarCode8: TEdit;
    lbl11: TLabel;
    txtBarCode9: TEdit;
    lbl12: TLabel;
    txtBarCode10: TEdit;
    cmdOk: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmbReadersKeyPress(Sender: TObject; var Key: Char);
    procedure txtBarCode1KeyPress(Sender: TObject; var Key: Char);
    procedure cmdOkClick(Sender: TObject);
  private
    { Private declarations }
    TxtArray : array[2..11] of TEdit;

    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  Globals, Keyboard, MSGs, RunCmnds, Funcs, DBS;

{$R *.DFM}



procedure TfrmInvalidCard.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
  lbl9.Caption := (lbl9.Caption);
  lbl10.Caption := (lbl10.Caption);
  lbl11.Caption := (lbl11.Caption);
  lbl12.Caption := (lbl12.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  for i := 0 to cmbOperate.Items.Count-1 do
    cmbOperate.Items.Strings[i] := (cmbOperate.Items.Strings[i]);
end;

procedure TfrmInvalidCard.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  for i := 1 to TotalReader do
    cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);

  cmbReaders.ItemIndex := 0;
  cmbOperate.ItemIndex := 0;
  TxtArray[2] := txtBarCode1;
  TxtArray[3] := txtBarCode2;
  TxtArray[4] := txtBarCode3;
  TxtArray[5] := txtBarCode4;
  TxtArray[6] := txtBarCode5;
  TxtArray[7] := txtBarCode6;
  TxtArray[8] := txtBarCode7;
  TxtArray[9] := txtBarCode8;
  TxtArray[10] := txtBarCode9;
  TxtArray[11] := txtBarCode10;
end;

procedure TfrmInvalidCard.cmbReadersKeyPress(Sender: TObject; var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, True);
    tp.SetFocus;
  end;
end;

procedure TfrmInvalidCard.txtBarCode1KeyPress(Sender: TObject; var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, True);
    tp.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmInvalidCard.cmdOkClick(Sender: TObject);
const
  SET_CARD = 0;
  GET_CARD = 1;
  DEL_CARD = 2;

var
  i : Byte;
  OK : Boolean;
  ST : String;
  p : TPerson;
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
      SET_CARD:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«·  ‰ŸÌ„ ﬂ«— Â«Ì €Ì—„Ã«“...');
        ST := '';
        for i := 2 to 11 do
          if TxtArray[i].Text <> '' then
          begin
            TxtArray[i].Text := FixLeft(TxtArray[i].Text, '0', 8);
            p := GetPerson(TxtArray[i].Text, False);
          end
          else
            ST := ST + '00000000';

        OK := SetInvalidCards(Readers[cmbReaders.ItemIndex+1], ST);
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ﬂ«— Â«Ì €Ì—„Ã«“ »Â  —„Ì‰«· «—”«· ‘œ.')
        else
          InformationMessage('„⁄—›Ì ﬂ«— Â«Ì €Ì—„Ã«“ »Â  —„Ì‰«· ‰«„Ê›ﬁ »Êœ.');
      end;

      GET_CARD:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«· ŒÊ«‰œ‰ ﬂ«— Â«Ì €Ì—„Ã«“...');
        OK := GetInvalidCards(Readers[cmbReaders.ItemIndex+1], ST);
        for i := 2 to 11 do
        begin
          if Copy(ST, 1, 8) = '00000000' then
            TxtArray[i].Text := ''
          else
          begin
            p := GetPerson(Copy(ST, 1, 8), True);
            if p.P_Code = '' then
              TxtArray[i].Text := DelLeftZero(Copy(ST, 1, 8))
            else
              TxtArray[i].Text := DelLeftZero(p.P_Code);
          Delete(ST, 1, 8);
          end;
        end;
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ﬂ«— Â«Ì €Ì—„Ã«“  —„Ì‰«· ŒÊ«‰œÂ ‘œ.')
        else
          InformationMessage('ŒÊ«‰œ‰ ﬂ«— Â«Ì €Ì—„Ã«“  —„Ì‰«· ‰«„Ê›ﬁ »Êœ.');
      end;

      DEL_CARD:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«· Õ–› ﬂ«— Â«Ì €Ì—„Ã«“...');
        OK := DelInvalidCards(Readers[cmbReaders.ItemIndex+1]);
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ﬂ«— Â«Ì €Ì—„Ã«“  —„Ì‰«· Õ–› ‘œ.')
        else
          InformationMessage('Õ–› ﬂ«— Â«Ì €Ì—„Ã«“ ‰«„Ê›ﬁ »Êœ.');
      end;
    end;
  end;
end;

end.
