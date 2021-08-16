unit FodPrcRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, RpFodPrc, Keyboard, DateProc,
  DBS_Proc, MSGs, FarsiApi;

type
  TfrmFoodPrcRpt = class(TForm)
    Label1: TLabel;
    cmbFoods: TComboBox;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    grpGroup: TGroupBox;
    rdoDate: TRadioButton;
    rdoFood: TRadioButton;
    Label2: TLabel;
    txtFromDate: TEdit;
    Label3: TLabel;
    txtToDate: TEdit;
    rdoNon: TRadioButton;
    chkSign: TCheckBox;
    procedure cmbFoodsKeyPress(Sender: TObject; var Key: Char);
    procedure rdoDateKeyPress(Sender: TObject; var Key: Char);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateExit(Sender: TObject);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmFoodPrcRpt.SetWinF;
begin
  Caption := (Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label1.Caption := (Label1.Caption);
  grpGroup.Caption := (grpGroup.Caption);
  rdoDate.Caption := (rdoDate.Caption);
  rdoFood.Caption := (rdoFood.Caption);
  rdoNon.Caption := (rdoNon.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmFoodPrcRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;
  SetDirectionFarsi(cmbFoods.Handle);

  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT Food_Name FROM FoodList');
    Open;
    while not EOF do
    begin
      cmbFoods.Items.Add(FieldByname('Food_Name').AsString);
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure TfrmFoodPrcRpt.txtFromDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmFoodPrcRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);

  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmFoodPrcRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbFoods.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmFoodPrcRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmFoodPrcRpt.cmbFoodsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoDate.Checked then
      rdoDate.SetFocus
    else
      rdoFood.SetFocus;
  end;
end;

procedure TfrmFoodPrcRpt.rdoDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoScreen.Checked then
      rdoScreen.SetFocus
    else
      rdoPrinter.SetFocus;
  end;
end;

procedure TfrmFoodPrcRpt.rdoScreenKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmFoodPrcRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmFoodPrcRpt.cmdPrintClick(Sender: TObject);
var frmRptFoodPrc: TfrmRptFoodPrc;
begin
  if (txtFromDate.Text <> '') and (txtToDate.Text <> '') and
     (txtFromDate.Text > txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «» œ« «“  «—ÌŒ «‰ Â« »“—ê — «” .');
    txtFromDate.SetFocus;
  end
  else if (txtFromDate.Text <> '') and not IsTruedate(txtFromDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «» œ« ‰«œ—”  «” .');
    txtFromDate.SetFocus;
  end
  else if (txtToDate.Text <> '') and not IsTruedate(txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «‰ Â« ‰«œ—”  «” .');
    txtFromDate.SetFocus;
  end
  else
  begin
    Application.CreateForm(TfrmRptFoodPrc, frmRptFoodPrc);
    with frmRptFoodPrc do
    begin
      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '  «  «—ÌŒ : ' + txtToDate.Text)
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
      else
        lblFromToDate.Caption := '';

      with qryFoodPrice do
      begin
        SQL.Clear;
        SQL.Add('SELECT * FROM FoodPric, FoodList WHERE FP_FoodCode = Food_Code');

        if txtFromDate.Text <> '' then
          SQL.Add('AND FP_Date >= ''' + txtFromDate.Text + '''');

        if txtToDate.Text <> '' then
          SQL.Add('AND FP_Date <= ''' + txtToDate.Text + '''');

        if cmbFoods.Text <> '' then
          SQL.Add('AND FP_FoodCode = ' + IntToStr(GetFoodCodeInRam(cmbFoods.Text)));

        if rdoDate.Checked then
        begin
          grpType.Expression := 'qryFoodPrice.FP_Date';
          lblName.Caption := (lblName.Caption + ' »Â  ›ﬂÌﬂ  «—ÌŒ');
          SQL.Add('ORDER BY FP_Date, FP_FoodCode');
        end
        else if rdoFood.Checked then
        begin
          grpType.Expression := 'qryFoodPrice.FP_FoodCode';
          lblName.Caption := (lblName.Caption + ' »Â  ›ﬂÌﬂ ‰Ê⁄ €–«');
          SQL.Add('ORDER BY FP_FoodCode, FP_Date');
        end
        else if rdoNon.Checked then
        begin
          grpType.Enabled := False;
          grpType.Expression := '';
          lblName.Caption := (lblName.Caption + ' »œÊ‰  ›ﬂÌﬂ');
          SQL.Add('ORDER BY FP_FoodCode, FP_Date');
          clmnHeader.Enabled := True;
        end;
        Open;
        if RecordCount > 0 then
        begin
          if rdoScreen.Checked then
            qrptFoodPrice.Preview
          else
            qrptFoodPrice.Print;
        end
        else
          InformationMessage('ﬁÌ„  ê–«—Ì «‰Ã«„ ‰‘œÂ «” .');

        Close;
      end;
      Free;
    end;
  end;
end;

end.
