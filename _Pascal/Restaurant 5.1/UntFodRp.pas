unit UntFodRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpFdUnTU, RpFdUnTD, RpFdUnK, RpFdUnM, RpFdUnMC, RpPymanU;

type
  TfrmUnitFishRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    txtFromDate: TEdit;
    grpType: TGroupBox;
    chkSham: TCheckBox;
    chkNahar: TCheckBox;
    chkSobh: TCheckBox;
    rdoSort: TRadioGroup;
    Label7: TLabel;
    txtToDate: TEdit;
    cmbUnits: TComboBox;
    Label2: TLabel;
    rdoPaper: TRadioGroup;
    chkSign: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbUnitsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdoSortClick(Sender: TObject);
    procedure cmbUnitsKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SendTab(var Key : Char);
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

uses
  ComTools, Printers, DBS_Proc;

{$R *.DFM}
procedure TfrmUnitFishRpt.SetWinF;
begin
end;

procedure TfrmUnitFishRpt.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmUnitFishRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM Units');
    Open;
    while not EOF do
    begin
      cmbunits.Items.Add(IntToStr(FieldByName('Unit_Code').AsInteger) + '-' + FieldByname('Unit_Name').AsString);
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure TfrmUnitFishRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmUnitFishRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmUnitFishRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmUnitFishRpt.cmbUnitsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbUnits.ItemIndex := -1;
  end;
end;

procedure TfrmUnitFishRpt.rdoSortClick(Sender: TObject);
begin
  rdoPaper.Enabled := (rdoSort.ItemIndex = 1);
end;

procedure TfrmUnitFishRpt.cmdPrintClick(Sender: TObject);
var
  frmRptUnitFoodTU : TfrmRptUnitFoodTU;
  frmRptUnitFoodTD : TfrmRptUnitFoodTD;
  frmRptUnitFoodK  : TfrmRptUnitFoodK;
  frmRptUnitFoodM  : TfrmRptUnitFoodM;
  frmRptUnitFoodMC : TfrmRptUnitFoodMC;
  frmRptPeymanUnit : TfrmRptPeymanUnit;
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
    if rdoSort.ItemIndex = 0 then
    begin
      Application.CreateForm(TfrmRptUnitFoodTU, frmRptUnitFoodTU);
      with frmRptUnitFoodTU do
      begin

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryUnitFood.SQL.Clear;
        qryUnitFood.SQL.Add('SELECT * FROM Fish, FishFood, Units, FoodList');
        qryUnitFood.SQL.Add('WHERE Fish_Date = FF_Date AND FIsh_Type = FF_Type AND Fish_No = FF_FishNo');
        qryUnitFood.SQL.Add('AND Fish_UCode = Unit_Code AND FF_Food = Food_Code');

        if txtFromDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
        if not chkNahar.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
        if not chkSham.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));


        if cmbUnits.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_UCode = ' + Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1));

        qryUnitFood.SQL.Add('ORDER BY Fish_UCode, Fish_Date, Fish_Type');
        qryUnitFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryUnitFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptUnitFoodTU.Preview
          else qrptUnitFoodTU.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryUnitFood.Close;
        Free;
      end;
    end
    else if rdoSort.ItemIndex = 1 then
    begin
      Application.CreateForm(TfrmRptUnitFoodTD, frmRptUnitFoodTD);
      with frmRptUnitFoodTD do
      begin

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryUnitFood.SQL.Clear;
        qryUnitFood.SQL.Add('SELECT * FROM Fish, Units');
        qryUnitFood.SQL.Add('WHERE Fish_UCode = Unit_Code');

        if txtFromDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
        if not chkNahar.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
        if not chkSham.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));


        if cmbUnits.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_UCode = ' + Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1));

        qryUnitFood.SQL.Add('ORDER BY Fish_Date, Fish_Type, Fish_UCode');
        qryUnitFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryUnitFood.RecordCount > 0 then
        begin
          SetUserControl;
          while Ord(qrptUnitFoodTU.Page.PaperSize) > 7 do
            qrptUnitFoodTU.Page.PaperSize := Pred(qrptUnitFoodTU.Page.PaperSize);

          if rdoPaper.ItemIndex = 0 then
          begin
            qrptUnitFoodTU.Page.Orientation := poPortrait;
            while Ord(qrptUnitFoodTU.Page.PaperSize) <> 8 do
              qrptUnitFoodTU.Page.PaperSize := Succ(qrptUnitFoodTU.Page.PaperSize);
          end
          else
          begin
            qrptUnitFoodTU.Page.Orientation := poLandscape;
            while Ord(qrptUnitFoodTU.Page.PaperSize) <> 9 do
              qrptUnitFoodTU.Page.PaperSize := Succ(qrptUnitFoodTU.Page.PaperSize);
          end;
          if rdoScreen.Checked then qrptUnitFoodTU.Preview
          else qrptUnitFoodTU.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryUnitFood.Close;
        Free;
      end;
    end
    else if rdoSort.ItemIndex = 2 then
    begin
      Application.CreateForm(TfrmRptUnitFoodK, frmRptUnitFoodK);
      with frmRptUnitFoodK do
      begin
        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';

        qryUnitFood.SQL.Clear;
        qryUnitFood.SQL.Add('SELECT Fish_UCode, Fish_Date, Fish_Type, Fish_UPrc, Fish_UPay, FF_Price, FF_Pay, FF_No, Unit_Name');
        qryUnitFood.SQL.Add('FROM Fish, FishFood, Units');
        qryUnitFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
        qryUnitFood.SQL.Add('AND Fish_UCode = Unit_Code');

        if txtFromDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
        if not chkNahar.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
        if not chkSham.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));

        if cmbUnits.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_UCode = ' + Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1));

        qryUnitFood.SQL.Add('ORDER BY Fish_UCode, Fish_Date, Fish_Type');
        qryUnitFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryUnitFood.RecordCount > 0 then
        begin
          if rdoScreen.Checked then qrptUnitFood.Preview
          else qrptUnitFood.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryUnitFood.Close;
        Free;
      end;
    end
    else if rdoSort.ItemIndex = 3 then
    begin
      Application.CreateForm(TfrmRptUnitFoodM, frmRptUnitFoodM);
      with frmRptUnitFoodM do
      begin
        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryUnitFood.SQL.Clear;

        qryUnitFood.SQL.Add('SELECT Fish_UCode, SUBSTRING(Fish_Date ,6,2) AS Fish_D, Fish_Type, Fish_UPrc, Fish_UPay, FF_Price, FF_Pay, FF_No, Unit_Name');
        qryUnitFood.SQL.Add('FROM Fish, FishFood, Units');
        qryUnitFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
        qryUnitFood.SQL.Add('AND Fish_UCode = Unit_Code');

        if txtFromDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
        if not chkNahar.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
        if not chkSham.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));

        if cmbUnits.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_UCode = ' + Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1));

        qryUnitFood.SQL.Add('ORDER BY Fish_D, Fish_UCode');
        qryUnitFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryUnitFood.RecordCount > 0 then
        begin
          if rdoScreen.Checked then qrptUnitFood.Preview
          else qrptUnitFood.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryUnitFood.Close;
        Free;
      end;
    end
    else if rdoSort.ItemIndex = 4 then
    begin
      Application.CreateForm(TfrmRptUnitFoodMC, frmRptUnitFoodMC);
      with frmRptUnitFoodMC do
      begin
        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryUnitFood.SQL.Clear;

        qryUnitFood.SQL.Add('SELECT Fish_UCode, SUBSTRING(Fish_Date ,6 ,2) AS Fish_D, Fish_Type, Fish_UPrc, Fish_UPay, FF_Price, FF_Pay, FF_No, Unit_Name');
        qryUnitFood.SQL.Add('FROM Fish, FishFood, Units');
        qryUnitFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
        qryUnitFood.SQL.Add('AND Fish_UCode = Unit_Code');

        if txtFromDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
        if not chkNahar.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
        if not chkSham.Checked then
          qryUnitFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));

        if cmbUnits.Text <> '' then
          qryUnitFood.SQL.Add('AND Fish_UCode = ' + Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1));

        qryUnitFood.SQL.Add('ORDER BY Fish_D, Fish_UCode');
        qryUnitFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryUnitFood.RecordCount > 0 then
        begin
          if rdoScreen.Checked then qrptUnitFood.Preview
          else qrptUnitFood.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryUnitFood.Close;
        Free;
      end;
    end
    else if rdoSort.ItemIndex = 5 then
    begin
      Application.CreateForm(TfrmRptPeymanUnit, frmRptPeymanUnit);
      with frmRptPeymanUnit do
      begin
        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        //MokhPrc := chkMokhPrice.Checked;
        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryFishFood.SQL.Clear;

        qryFishFood.SQL.Add('SELECT FishFood.*, Fish_UCode, Food_Name,Food_Code, Food_Type, Unit_Name FROM FishFood, Fish, FoodList, Units');
        qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
        qryFishFood.SQL.Add('AND Fish_UCode = Unit_Code AND FF_Food = Food_Code AND Fish_UCode > 0');

        if txtFromDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryFishFood.SQL.Add('AND FF_Type <> ' + IntToStr(MB_SOBH));

        if not chkNahar.Checked then
          qryFishFood.SQL.Add('AND FF_Type <> ' + IntToStr(MB_NAHAR));

        if not chkSham.Checked then
          qryFishFood.SQL.Add('AND FF_Type <> ' + IntToStr(MB_SHAM));

        if cmbUnits.Text <> '' then
          qryFishFood.SQL.Add('AND Fish_UCode = ' + Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1));

        qryFishFood.SQL.Add('ORDER BY Fish_UCode, FF_Food');

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

procedure TfrmUnitFishRpt.cmbUnitsKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

end.
