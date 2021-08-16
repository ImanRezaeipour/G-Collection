unit DifferRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpDiffer;

type
  TfrmDifferRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    txtFromDate: TEdit;
    Label2: TLabel;
    txtToDate: TEdit;
    Label3: TLabel;
    txtPercent: TEdit;
    rdoPaper: TRadioGroup;
    chkSign: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtPercentKeyPress(Sender: TObject; var Key: Char);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  ComTools, Printers;

{$R *.DFM}

procedure TfrmDifferRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  rdoPaper.Caption := (rdoPaper.Caption);

  for i := 0 to rdoPaper.Items.Count-1 do
    rdoPaper.Items.Strings[i] := (rdoPaper.Items.Strings[i]);

  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmDifferRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;
end;

procedure TfrmDifferRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmDifferRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmDifferRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPercent.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmDifferRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmDifferRpt.txtPercentKeyPress(Sender: TObject; var Key: Char);
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
    Keyboard_Number(Key, txtPercent.Text);
end;

procedure TfrmDifferRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmDifferRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmDifferRpt.cmdPrintClick(Sender: TObject);
var frmRptDiffer : TfrmRptDiffer;
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
  else if txtPercent.Text = '' then
  begin
    ErrorMessage('œ—’œ Ê«—œ ‰‘œÂ «” ');
    txtPercent.SetFocus;
  end
  else
  begin
    Application.CreateForm(TfrmRptDiffer, frmRptDiffer);
    with frmRptDiffer do
    begin
      Mouse_Wait;
      Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');
      Percent := StrToFloat(txtPercent.Text);
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
      qryDiffer.SQL.Clear;

      qryDiffer.SQL.Add('SELECT FF_Date, FF_Type, FF_Food, Food_Name, FF_No FROM FishFood, FoodList');
      qryDiffer.SQL.Add('WHERE FF_Food = Food_Code');

      if txtFromDate.Text <> '' then
        qryDiffer.SQL.Add('AND FF_Date >= ''' + txtFromDate.Text + '''');
      if txtToDate.Text <> '' then
        qryDiffer.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');

      qryDiffer.SQL.Add('ORDER BY FF_Date, FF_Type, FF_Food');
      qryDiffer.Open;
      Mouse_NoWait;
      Msg_NoWait;
      if qryDiffer.RecordCount > 0 then
      begin
        while Ord(qrptDiffer.Page.PaperSize) > 7 do
          qrptDiffer.Page.PaperSize := Pred(qrptDiffer.Page.PaperSize);

        if rdoPaper.ItemIndex = 0 then
        begin
          qrptDiffer.Page.Orientation := poPortrait;
          while Ord(qrptDiffer.Page.PaperSize) <> 8 do
            qrptDiffer.Page.PaperSize := Succ(qrptDiffer.Page.PaperSize);
        end
        else
        begin
          qrptDiffer.Page.Orientation := poLandscape;
          while Ord(qrptDiffer.Page.PaperSize) <> 9 do
            qrptDiffer.Page.PaperSize := Succ(qrptDiffer.Page.PaperSize);
        end;
        SetUserControl;
        if rdoScreen.Checked then qrptDiffer.Preview
        else qrptDiffer.Print;
        USERCONTROL := False;
      end
      else
        InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
      qryDiffer.Close;
      Free;
    end;
  end;
end;

end.
