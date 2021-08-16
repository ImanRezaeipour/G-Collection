unit YearFdRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpYearFd;

type
  TfrmYearFdMkhRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    lbl1: TLabel;
    lbl2: TLabel;
    chkSign: TCheckBox;
    cmbYear: TComboBox;
    cmbFMonth: TComboBox;
    lbl3: TLabel;
    cmbTMonth: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
    procedure SendTab(var Key : Char);

  public
    { Public declarations }
  end;


implementation

uses
  ComTools;

{$R *.DFM}

procedure TfrmYearFdMkhRpt.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmYearFdMkhRpt.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmYearFdMkhRpt.FormCreate(Sender: TObject);
var
  t : String;
  i, n : Integer;
begin
  SetWinF;
  t := CurrentDate;
  n := StrToInt(Copy(t, 1, 4));
  for i := 0 to 4 do
    cmbYear.Items.Add(IntToStr(n-i));
  cmbYear.ItemIndex := 0;

  n := StrToInt(Copy(t, 6, 2));
  for i := 1 to 12 do
    cmbFMonth.Items.Add(MonthName[i]);
  cmbTMonth.Items := cmbFMonth.Items;
  cmbFMonth.ItemIndex := 0;
  cmbTMonth.ItemIndex := n-1;
end;

procedure TfrmYearFdMkhRpt.FormKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmYearFdMkhRpt.cmdPrintClick(Sender: TObject);
var
  frmRptYearFdMkh : TfrmRptYearFdMkh;
  sDate, eDate : String;
begin
  if cmbFMonth.ItemIndex > cmbTMonth.ItemIndex then
  begin
    ErrorMessage('„«Â ‘—Ê⁄ «“ „«Â Å«Ì«‰ »“—ê — «” .');
    cmbFMonth.SetFocus;
  end
  else
  begin
    Application.CreateForm(TfrmRptYearFdMkh, frmRptYearFdMkh);
    with frmRptYearFdMkh do
    begin
      Mouse_Wait;
      Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');
      sDate := BeautifulDate(cmbYear.Text + '/' + IntToStr(cmbFMonth.ItemIndex+1) + '/01');
      eDate := BeautifulDate(cmbYear.Text + '/' + IntToStr(cmbTMonth.ItemIndex+1) + '/31');

      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      qryFishPrs.SQL.Clear;
      qryFishPrs.SQL.Add('SELECT SUM(FF_Pay * FF_No) AS Pay, SUM(FF_Price * FF_No) AS Price, FF_Date, P_IsGuest FROM Fish, FishFood, Persons');
      qryFishPrs.SQL.Add('WHERE FF_Date = Fish_Date AND FF_Type = Fish_Type AND FF_FishNo = Fish_No');
      qryFishPrs.SQL.Add('AND Fish_PCode = P_BarCode');

      qryFishPrs.SQL.Add('AND Fish_Date >= ''' + sDate + '''');
      qryFishPrs.SQL.Add('AND Fish_Date <= ''' + eDate + '''');

      qryFishPrs.SQL.Add('GROUP BY FF_Date, P_IsGuest');
      qryFishPrs.SQL.Add('ORDER BY FF_Date, P_IsGuest');

      qryFishPrs.Open;
      Mouse_NoWait;
      Msg_NoWait;
      if qryFishPrs.RecordCount > 0 then
      begin
        SetUserControl;
        grpMonth.Height := 0;
        grpGuest.Height := 0;
        bndGuest.Height := 0;
        if rdoScreen.Checked then qrptFoodMonth.Preview
        else qrptFoodMonth.Print;
        USERCONTROL := False;
      end
      else
        InformationMessage('€–«ÌÌ œ— «Ì‰ „ÕœÊœÂ „’—› ‰‘œÂ «” ..');
      qryFishPrs.Close;
      Free;
    end;
  end;
end;

end.
