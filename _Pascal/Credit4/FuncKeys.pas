unit FuncKeys;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DosMove;

type
  TfrmFunctionKeys = class(TForm)
    cmbReaders: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cmbOperate: TComboBox;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    cmdOk: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmbF1: TComboBox;
    cmbF2: TComboBox;
    cmbF3: TComboBox;
    cmbF4: TComboBox;
    chkActive: TCheckBox;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmbReadersKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOkClick(Sender: TObject);
    procedure cmbOperateClick(Sender: TObject);
    procedure cmbF1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbF2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbF3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbF4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure SetWinF;
    
  public
    { Public declarations }
  end;


implementation

uses
  Globals, Keyboard, MSGs, RunCmnds, Funcs, DBS;

{$R *.DFM}



const
  SET_KEYS = 0;
  GET_KEYS = 1;


procedure TfrmFunctionKeys.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  for i := 0 to cmbOperate.Items.Count-1 do
    cmbOperate.Items.Strings[i] := (cmbOperate.Items.Strings[i]);
  chkActive.Caption := (chkActive.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmFunctionKeys.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  for i := 1 to TotalReader do
    if Readers[i].R_Type = RDR_CLK6000 then
      cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);

  cmbReaders.ItemIndex := 0;
  cmbOperate.ItemIndex := 0;
  for i := 1 to MaxPishCard do
    if PishCard_Active[i] = MB_TRUE then
    cmbF1.Items.Add(FixLeft(IntToStr(PishCard_No[i]), '0', 2) + '-' +
                    (PishCard_Name[i]) + ' ' +
                    PishCard_LastName[i]);

  cmbF2.Items := cmbF1.Items;
  cmbF3.Items := cmbF1.Items;
  cmbF4.Items := cmbF1.Items;
end;

procedure TfrmFunctionKeys.cmbReadersKeyPress(Sender: TObject; var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, True);
    tp.SetFocus;
  end;
end;

procedure TfrmFunctionKeys.cmbOperateClick(Sender: TObject);
begin
  chkActive.Visible := (cmbOperate.ItemIndex = SET_KEYS);
end;

procedure TfrmFunctionKeys.cmdOkClick(Sender: TObject);
var
  idx, i,
  FKey1, FKey2, FKey3, FKey4 : Byte;
  OK : Boolean;
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
      SET_KEYS:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«·  ‰ŸÌ„ ﬂ·ÌœÂ«Ì ⁄„·Ì« Ì...');
        if (cmbF1.Text <> '') and (Pos('-', cmbF1.Text) > 0) then
          FKey1 := StrToInt(Copy(cmbF1.Text, 1, Pos('-', cmbF1.Text)-1))
        else
          FKey1 := 0;

        if (cmbF2.Text <> '') and (Pos('-', cmbF2.Text) > 0) then
          FKey2 := StrToInt(Copy(cmbF2.Text, 1, Pos('-', cmbF2.Text)-1))
        else
          FKey2 := 0;

        if (cmbF3.Text <> '') and (Pos('-', cmbF3.Text) > 0) then
          FKey3 := StrToInt(Copy(cmbF3.Text, 1, Pos('-', cmbF3.Text)-1))
        else
          FKey3 := 0;

        if (cmbF4.Text <> '') and (Pos('-', cmbF4.Text) > 0) then
          FKey4 := StrToInt(Copy(cmbF4.Text, 1, Pos('-', cmbF4.Text)-1))
        else
          FKey4 := 0;

        idx := FindReaderNameIdx(Copy(cmbReaders.Text, Pos('-',cmbReaders.Text)+1, 40));
        OK := SetFunctionKeys(Readers[idx], FKey1, FKey2, FKey3, FKey4);
        if OK then
          OK := (OK AND ChangeFunctionKeysActive(Readers[idx], chkActive.Checked));
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ﬂ·ÌœÂ«Ì ⁄„·Ì« Ì  —„Ì‰«·  ‰ŸÌ„ ‘œ.')
        else
          InformationMessage(' ‰ŸÌ„ ﬂ·ÌœÂ«Ì ⁄„·Ì« Ì  —„Ì‰«· ‰«„Ê›ﬁ »Êœ.');
      end;

      GET_KEYS:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«· ŒÊ«‰œ‰ ﬂ·ÌœÂ«Ì ⁄„·Ì« Ì...');
        idx := FindReaderNameIdx(Copy(cmbReaders.Text, Pos('-',cmbReaders.Text)+1, 40));
        OK := GetFunctionKeys(Readers[idx], FKey1, FKey2, FKey3, FKey4);
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
        begin
          for i := 0 to cmbF1.Items.Count-1 do
            if StrToInt(Copy(cmbF1.Items.Strings[i], 1, Pos('-', cmbF1.Items.Strings[i])-1)) = FKey1 then
            begin
              cmbF1.ItemIndex := i;
              Break;
            end;

          for i := 0 to cmbF2.Items.Count-1 do
            if StrToInt(Copy(cmbF2.Items.Strings[i], 1, Pos('-', cmbF2.Items.Strings[i])-1)) = FKey2 then
            begin
              cmbF2.ItemIndex := i;
              Break;
            end;

          for i := 0 to cmbF3.Items.Count-1 do
            if StrToInt(Copy(cmbF3.Items.Strings[i], 1, Pos('-', cmbF3.Items.Strings[i])-1)) = FKey3 then
            begin
              cmbF3.ItemIndex := i;
              Break;
            end;

          for i := 0 to cmbF4.Items.Count-1 do
            if StrToInt(Copy(cmbF4.Items.Strings[i], 1, Pos('-', cmbF4.Items.Strings[i])-1)) = FKey4 then
            begin
              cmbF4.ItemIndex := i;
              Break;
            end;

          if (cmbF1.ItemIndex = -1) and (cmbF2.ItemIndex = -1) and
             (cmbF3.ItemIndex = -1) and (cmbF4.ItemIndex = -1) then
            InformationMessage('ﬂ·ÌœÂ«Ì ⁄„·Ì« Ì »—«Ì  —„Ì‰«·  ‰ŸÌ„ ‰‘œÂ «” .')
          else
            InformationMessage('ﬂ·ÌœÂ«Ì ⁄„·Ì« Ì  —„Ì‰«· ŒÊ«‰œÂ ‘œ.');
        end
        else
          InformationMessage('ŒÊ«‰œ‰ ﬂ·ÌœÂ«Ì ⁄„·Ì« Ì  —„Ì‰«· ‰«„Ê›ﬁ »Êœ.');
      end;

    end;
  end;
end;

procedure TfrmFunctionKeys.cmbF1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbF1.ItemIndex := -1;
  end;
end;

procedure TfrmFunctionKeys.cmbF2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbF2.ItemIndex := -1;
  end;
end;

procedure TfrmFunctionKeys.cmbF3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbF3.ItemIndex := -1;
  end;
end;

procedure TfrmFunctionKeys.cmbF4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbF4.ItemIndex := -1;
  end;
end;

end.
