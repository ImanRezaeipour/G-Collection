unit AcesCode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmAccessCode = class(TForm)
    cmbReaders: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cmbOperate: TComboBox;
    lbl3: TLabel;
    txtAccess1: TEdit;
    lbl4: TLabel;
    txtAccess2: TEdit;
    lbl5: TLabel;
    txtAccess3: TEdit;
    lbl6: TLabel;
    txtAccess4: TEdit;
    lbl7: TLabel;
    txtAccess5: TEdit;
    cmdOk: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmbReadersKeyPress(Sender: TObject; var Key: Char);
    procedure txtAccess1KeyPress(Sender: TObject; var Key: Char);
    procedure cmdOkClick(Sender: TObject);
  private
    { Private declarations }
    TxtArray : array[2..6] of TEdit;

    procedure SetWinF;
  public
    { Public declarations }
  end;

var
  frmAccessCode : TfrmAccessCode;
  

implementation

uses
  Globals, Keyboard, DateProc, MSGs, RunCmnds, Funcs, FntSel;

{$R *.DFM}



procedure TfrmAccessCode.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmAccessCode));

  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  for i := 0 to cmbOperate.Items.Count-1 do
    cmbOperate.Items.Strings[i] := (cmbOperate.Items.Strings[i]);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmAccessCode.FormCreate(Sender: TObject);
var i : Byte;
begin
  TxtArray[2] := txtAccess1;
  TxtArray[3] := txtAccess2;
  TxtArray[4] := txtAccess3;
  TxtArray[5] := txtAccess4;
  TxtArray[6] := txtAccess5;
  SetWinF;

  if rdrCount > 0 then
    for i := 0 to rdrCount-1 do
      cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);

  cmbReaders.ItemIndex := 0;
  cmbOperate.ItemIndex := 0;
end;

procedure TfrmAccessCode.cmbReadersKeyPress(Sender: TObject; var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, True);
    tp.SetFocus;
  end;
end;

procedure TfrmAccessCode.txtAccess1KeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmAccessCode.cmdOkClick(Sender: TObject);
const
  SET_ACCESS = 0;
  GET_ACCESS = 1;
  DEL_ACCESS = 2;

var
  i : Byte;
  OK : Boolean;
  ST : String;
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
      SET_ACCESS:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«·  ‰ŸÌ„ ﬂœÂ«Ì ê—ÊÂ ﬂ«— ...');
        ST := '';
        for i := 2 to 6 do
          if TxtArray[i].Text <> '' then
            ST := ST + FixLeft(TxtArray[i].Text, '0', 4)
          else if Readers[cmbReaders.ItemIndex].R_Type = RDR_CLK6000 then
            ST := ST + '????';
        OK := SetAccessCode(Readers[cmbReaders.ItemIndex], ST);
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ﬂœÂ«Ì ê—ÊÂ ﬂ«—  »Â  —„Ì‰«· «—”«· ‘œ.')
        else
          InformationMessage('„⁄—›Ì ﬂœÂ«Ì ê—ÊÂ ﬂ«—  »Â  —„Ì‰«· ‰«„Ê›ﬁ »Êœ.');
      end;

      GET_ACCESS:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«· ŒÊ«‰œ‰ ﬂœÂ«Ì ê—ÊÂ ﬂ«— ...');
        OK := GetAccessCode(Readers[cmbReaders.ItemIndex], ST);
        for i := 2 to 6 do
        begin
          if Copy(ST, 1, 4) = '0000' then
            TxtArray[i].Text := ''
          else
            TxtArray[i].Text := DelLeftZero(Copy(ST, 1, 4));
          Delete(ST, 1, 4);
        end;
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ﬂœÂ«Ì ê—ÊÂ ﬂ«—   —„Ì‰«· ŒÊ«‰œÂ ‘œ.')
        else
          InformationMessage('ŒÊ«‰œ‰ ﬂœÂ«Ì ê—ÊÂ ﬂ«—   —„Ì‰«· ‰«„Ê›ﬁ »Êœ.');
      end;

      DEL_ACCESS:
      begin
        Mouse_Wait;
        MSG_Wait('œ— Õ«· Õ–› ﬂœÂ«Ì ê—ÊÂ ﬂ«— ...');
        OK := DelAccessCode(Readers[cmbReaders.ItemIndex]);
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ﬂœÂ«Ì ê—ÊÂ ﬂ«—   —„Ì‰«· Õ–› ‘œ.')
        else
          InformationMessage('Õ–› ﬂœÂ«Ì ê—ÊÂ ﬂ«—  ‰«„Ê›ﬁ »Êœ.');
      end;
    end;
  end;
end;

end.
