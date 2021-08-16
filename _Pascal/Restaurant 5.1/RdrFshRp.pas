unit RdrFshRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpRdrFsh;

type
  TfrmRdrFishRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    txtFromDate: TEdit;
    Label7: TLabel;
    txtToDate: TEdit;
    chkSign: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  ComTools;

{$R *.DFM}

procedure TfrmRdrFishRpt.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label7.Caption := (Label7.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmRdrFishRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;
end;

procedure TfrmRdrFishRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmRdrFishRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmRdrFishRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmRdrFishRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmRdrFishRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmRdrFishRpt.chkSignKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmRdrFishRpt.cmdPrintClick(Sender: TObject);
var frmRptRdrFish : TfrmRptRdrFish;
begin
  if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
    txtFromDate.SetFocus;
  end
  else if (txtToDate.Text <> '') and not IsTrueDate(txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
    txtToDate.SetFocus;
  end
  else
  begin
    Mouse_Wait;
    Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');
    Application.CreateForm(TfrmRptRdrFish, frmRptRdrFish);
    with frmRptRdrFish do
    begin
      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblRepDate.Caption := ' «  «—ÌŒ :' + txtToDate.Text
      else
        lblRepDate.Caption := '';

      lblRepDate.Caption := (lblRepDate.Caption);

      qryRdrFish.SQL.Clear;
      qryRdrFish.SQL.Add('SELECT COUNT(Fish_No) AS c, Fish_RdrCode, P_IsGuest');
      qryRdrFish.SQL.Add('FROM Fish, Persons');
      qryRdrFish.SQL.Add('WHERE Fish_PCode = P_BarCode');
      if txtFromDate.Text <> '' then
        qryRdrFish.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
      if txtToDate.Text <> '' then
        qryRdrFish.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');
      qryRdrFish.SQL.Add('GROUP BY P_IsGuest, Fish_RdrCode');
      qryRdrFish.SQL.Add('ORDER BY P_IsGuest, Fish_RdrCode');

      qryRdrFish.Open;
      Mouse_NoWait;
      Msg_NoWait;
      if qryRdrFish.RecordCount > 0 then
      begin
        SetUserControl;
        if rdoScreen.Checked then qrptRdrFish.Preview
        else qrptRdrFish.Print;
        USERCONTROL := False;
      end
      else
        InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
      qryRdrFish.Close;
      Free;
    end;
  end;
end;

end.
