unit PrgFodRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, Keyboard, DateProc, DBS_Proc,
  MSGs, FarsiApi, RpPrgFod;

type
  TfrmProgFoodRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    Label2: TLabel;
    txtDate: TEdit;
    chkSign: TCheckBox;
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmProgFoodRpt.SetWinF;
begin
  Caption := (Caption);
  Label2.Caption := (Label2.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmProgFoodRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  txtDate.Text := CurrentDate;
end;

procedure TfrmProgFoodRpt.txtDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoScreen.Checked then
      rdoScreen.SetFocus
    else
      rdoPrinter.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmProgFoodRpt.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmProgFoodRpt.rdoScreenKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmProgFoodRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus
  end;
end;

procedure TfrmProgFoodRpt.cmdPrintClick(Sender: TObject);
var
  frmRptProgFood : TfrmRptProgFood;
  d : Integer;
begin
  if txtDate.Text = '' then
  begin
    ErrorMessage(' «—ÌŒ „‘Œ’ ‰‘œÂ «” .');
    txtDate.SetFocus;
  end
  else if not IsTrueDate(txtDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ’ÕÌÕ ‰Ì” .');
    txtDate.SetFocus;
  end
  else
  begin
    Application.CreateForm(TfrmRptProgFood, frmRptProgFood);
    with frmRptProgFood do
    begin
      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      FirstDay := txtDate.Text;
      d := DayOfWeek(M_Date(FirstDay));
      if d = 7 then
        d := 0
      else
        d := -1 * d;
      FirstDay := AddDate(FirstDay, d);
      if rdoScreen.Checked then
        qrptFoodProg.Preview
      else
        qrptFoodProg.Print;
      Free;
    end;
  end;
end;


end.
