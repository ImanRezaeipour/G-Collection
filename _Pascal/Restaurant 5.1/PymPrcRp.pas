unit PymPrcRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, DosMove;

type
  TfrmPeymanPrcntRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    lbl1: TLabel;
    txtFromDate: TEdit;
    lbl2: TLabel;
    txtToDate: TEdit;
    chkSign: TCheckBox;
    rdoGroup: TRadioGroup;
    cmbFoods: TComboBox;
    lbl3: TLabel;
    grpPercent: TGroupBox;
    lbl4: TLabel;
    txtMavad: TEdit;
    lbl6: TLabel;
    txtTabkh: TEdit;
    rdoRptType: TRadioGroup;
    lbl5: TLabel;
    lbl7: TLabel;
    DosMove1: TDosMove;
    chkNewPage: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbFoodsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtMavadKeyPress(Sender: TObject; var Key: Char);
    procedure txtTabkhKeyPress(Sender: TObject; var Key: Char);
    procedure txtMavadExit(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  ComTools, Globals, Keyboard, MSGs, DateProc, RpPymPrc, RpMvdTbk;

{$R *.DFM}

procedure TfrmPeymanPrcntRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);

  rdoGroup.Caption := (rdoGroup.Caption);
  for i := 0 to rdoGroup.Items.Count-1 do
    rdoGroup.Items.Strings[i] := (rdoGroup.Items.Strings[i]);

  grpPercent.Caption := (grpPercent.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);

  rdoRptType.Caption := (rdoRptType.Caption);
  for i := 0 to rdoRptType.Items.Count-1 do
    rdoRptType.Items.Strings[i] := (rdoRptType.Items.Strings[i]);

  chkNewPage.Caption := (chkNewPage.Caption);
  
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);

  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmPeymanPrcntRpt.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

  for i := 1 to TotalFoods do
  begin
    if FoodsList[i].Food_Type = MB_GHAZA then
      cmbFoods.Items.Add(IntToStr(FoodsList[i].Food_Code) + '-' + FoodsList[i].Food_Name);
  end;
end;

procedure TfrmPeymanPrcntRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmPeymanPrcntRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmPeymanPrcntRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmPeymanPrcntRpt.cmbFoodsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbFoods.ItemIndex := -1;
  end;
end;

procedure TfrmPeymanPrcntRpt.cmdPrintClick(Sender: TObject);
var
  frmRptPymnPrcntGrp : TfrmRptPymnPrcntGrp;
  frmRptMavadTabkh : TfrmRptMavadTabkh;
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
  else if (txtFromDate.Text <> '') and (txtToDate.Text <> '') and
          (txtFromDate.Text > txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ «» œ« «“  «—ÌŒ «‰ Â« »“—ê — «” .');
    txtToDate.SetFocus;
  end
  else if txtMavad.Text = '' then
  begin
    ErrorMessage('œ—’œ „»·€ „Ê«œ «Ê·ÌÂ „‘Œ’ ‰‘œÂ «” .');
    txtMavad.SetFocus;
  end
  else if txtTabkh.Text = '' then
  begin
    ErrorMessage('œ—’œ „»·€ ÿ»Œ „‘Œ’ ‰‘œÂ «” .');
    txtTabkh.SetFocus;
  end
  else if StrToFloat(txtMavad.Text) + StrToFloat(txtTabkh.Text) > 100 then
  begin
    ErrorMessage('„Ã„Ê⁄ œ—’œÂ« »Ì‘ — «“ 100 „Ìù»«‘œ.');
    txtMavad.SetFocus;
  end
  else
  begin
    g_options.RptFDate := txtFromDate.Text;
    g_options.RptTDate := txtToDate.Text;
    if rdoRptType.ItemIndex = 0 then
    begin
      Application.CreateForm(TfrmRptPymnPrcntGrp, frmRptPymnPrcntGrp);
      with frmRptPymnPrcntGrp do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        grpPub.ForceNewPage := chkNewPage.Checked;

        EDate := txtToDate.Text;
        mavadPrcnt := StrToFloat(txtMavad.Text);
        tabkhPrcnt := StrToFloat(txtTabkh.Text);

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';

        qryFishFood.SQL.Clear;
        if rdoGroup.ItemIndex = 0 then
        begin
          lblName.Caption := ('ê“«—‘ Â“Ì‰Â „Ê«œ «Ê·ÌÂ Ê ÿ»Œ Ê  Ê“Ì⁄ €–« » ›ﬂÌﬂ Å—”‰· Ê „ÌÂ„«‰');
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, Food_Type, P_Rejim, P_IsGuest FROM Fish, FishFood, FoodList, Persons');
          qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
          qryFishFood.SQL.Add('AND FF_Food = Food_Code AND Fish_PCode = P_BarCode');
          grpPub.FooterBand := bndAll;
        end
        else if rdoGroup.ItemIndex = 1 then
        begin
          lblName.Caption := ('ê“«—‘ Â“Ì‰Â „Ê«œ «Ê·ÌÂ Ê ÿ»Œ Ê  Ê“Ì⁄ €–« » ›ﬂÌﬂ Ê«ÕœÂ«Ì  «»⁄Â');
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, Food_Type, Unit_Code, Unit_Name FROM Fish, FishFood, FoodList, Units');
          qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
          qryFishFood.SQL.Add('AND FF_Food = Food_Code AND Fish_UCode = Unit_Code');
          grpRejim.Expression := '';
          grpRejim.Enabled := False;
          grpPub.Expression := 'qryFishFood.Unit_Code';
          grpPub.FooterBand := bndAll;
        end
        else
        begin
          lblName.Caption := ('ê“«—‘ Â“Ì‰Â „Ê«œ «Ê·ÌÂ Ê ÿ»Œ Ê  Ê“Ì⁄ €–«');
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, Food_Type FROM Fish, FishFood, FoodList');
          qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
          qryFishFood.SQL.Add('AND FF_Food = Food_Code');
          grpRejim.Expression := '';
          grpRejim.Enabled := False;
          grpPub.Expression := '';
          grpPub.Enabled := False;
        end;
        qrptPeyman.ReportTitle := lblName.Caption;
        qryFishFood.SQL.Add('AND Food_Type = ' + IntToStr(MB_GHAZA));


        if txtFromDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');

        if cmbFoods.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbFoods.Text, 1, Pos('-', cmbFoods.Text)-1));

        if rdoGroup.ItemIndex = 0 then
          qryFishFood.SQL.Add('ORDER BY P_Rejim, P_IsGuest, FF_Food')
        else if rdoGroup.ItemIndex = 1 then
          qryFishFood.SQL.Add('ORDER BY Unit_Code, FF_Food')
        else
          qryFishFood.SQL.Add('ORDER BY FF_Food');

        qryFishFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryFishFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptPeyman.Preview
          else qrptPeyman.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryFishFood.Close;
        Free;
      end;
    end
    else
    begin
      Application.CreateForm(TfrmRptMavadTabkh, frmRptMavadTabkh);
      with frmRptMavadTabkh do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        grpPub.ForceNewPage := chkNewPage.Checked;

        EDate := txtToDate.Text;
        if rdoRptType.ItemIndex = 1 then
        begin
          lblName.Caption := ('ê“«—‘ Â“Ì‰Â „Ê«œ «Ê·ÌÂ €–«Ì ‰Ì„—Ê“Ì');
          lbl6.Caption := ('„Ê«œ «Ê·ÌÂ Â— Å—”');
          Prcnt := StrToFloat(txtMavad.Text)
        end
        else
        begin
          lblName.Caption := ('ê“«—‘ Â“Ì‰Â ÿ»Œ Ê  Ê“Ì⁄ €–«Ì ‰Ì„—Ê“Ì');
          lbl6.Caption := ('ÿ»Œ Ê  Ê“Ì⁄ Â— Å—”');
          Prcnt := StrToFloat(txtTabkh.Text);
        end;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';

        qryFishFood.SQL.Clear;
        if rdoGroup.ItemIndex = 0 then
        begin
          lblName.Caption := lblName.Caption + (' ﬂ«—ﬂ‰«‰');
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, Food_Type, P_Rejim, P_IsGuest FROM Fish, FishFood, FoodList, Persons');
          qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
          qryFishFood.SQL.Add('AND FF_Food = Food_Code AND Fish_PCode = P_BarCode');
          grpPub.FooterBand := bndAll;
        end
        else if rdoGroup.ItemIndex = 1 then
        begin
          lblName.Caption := lblName.Caption + (' Ê«ÕœÂ«Ì  «»⁄Â');
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, Food_Type, Unit_Code, Unit_Name FROM Fish, FishFood, FoodList, Units');
          qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
          qryFishFood.SQL.Add('AND FF_Food = Food_Code AND Fish_UCode = Unit_Code');
          grpRejim.Expression := '';
          grpRejim.Enabled := False;
          grpPub.Expression := 'qryFishFood.Unit_Code';
          grpPub.FooterBand := bndAll;
        end
        else
        begin
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, Food_Type FROM Fish, FishFood, FoodList');
          qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
          qryFishFood.SQL.Add('AND FF_Food = Food_Code');
          grpRejim.Expression := '';
          grpRejim.Enabled := False;
          grpPub.Expression := '';
          grpPub.Enabled := False;
        end;
        qrptPeyman.ReportTitle := lblName.Caption;
        qryFishFood.SQL.Add('AND Food_Type = ' + IntToStr(MB_GHAZA));


        if txtFromDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');

        if cmbFoods.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbFoods.Text, 1, Pos('-', cmbFoods.Text)-1));

        if rdoGroup.ItemIndex = 0 then
          qryFishFood.SQL.Add('ORDER BY P_Rejim, P_IsGuest, FF_Food')
        else if rdoGroup.ItemIndex = 1 then
          qryFishFood.SQL.Add('ORDER BY Unit_Code, FF_Food')
        else
          qryFishFood.SQL.Add('ORDER BY FF_Food');

        qryFishFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryFishFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptPeyman.Preview
          else qrptPeyman.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryFishFood.Close;
        Free;
      end;
    end;
  end;
end;

procedure TfrmPeymanPrcntRpt.txtMavadKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Number(Key, txtMavad.Text);
end;

procedure TfrmPeymanPrcntRpt.txtTabkhKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Number(Key, txtTabkh.Text);
end;

procedure TfrmPeymanPrcntRpt.txtMavadExit(Sender: TObject);
begin
  if txtMavad.Text <> '' then
    txtTabkh.Text := FloatToStr(100 - StrToFloat(txtMavad.Text));
end;

end.
