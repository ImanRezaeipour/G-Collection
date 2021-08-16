unit DayFodRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpDayFod, RpFodUse;

type
  TfrmDayFoodRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    txtFromDate: TEdit;
    grpType: TGroupBox;
    chkNahar: TCheckBox;
    chkSobh: TCheckBox;
    chkMokhalafat: TCheckBox;
    cmbSobh: TComboBox;
    cmbNahar: TComboBox;
    cmbMokhalafat: TComboBox;
    Label2: TLabel;
    txtToDate: TEdit;
    GroupBox1: TGroupBox;
    chkPart: TCheckBox;
    chkJob: TCheckBox;
    chkSign: TCheckBox;
    chkGroup: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure chkCoNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmbSobhKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbNaharKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbMokhalafatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
    procedure chkGroupClick(Sender: TObject);
    procedure chkPartClick(Sender: TObject);
    procedure chkJobClick(Sender: TObject);
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

procedure TfrmDayFoodRpt.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  chkSobh.Caption := (chkSobh.Caption);
  chkNahar.Caption := (chkNahar.Caption);
  chkMokhalafat.Caption := (chkMokhalafat.Caption);
  GroupBox1.Caption := (GroupBox1.Caption);
  chkPart.Caption := (chkPart.Caption);
  chkJob.Caption := (chkJob.Caption);
  chkGroup.Caption := (chkGroup.Caption); 
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmDayFoodRpt.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

  for i := 1 to TotalFoods do
  begin
    case FoodsList[i].Food_Type of
      MB_SOBHANEH   : cmbSobh.Items.Add(IntToStr(FoodsList[i].Food_Code) + '-' + FoodsList[i].Food_Name);
      MB_GHAZA      : cmbNahar.Items.Add(IntToStr(FoodsList[i].Food_Code) + '-' + FoodsList[i].Food_Name);
      MB_MOKHALAFAT : cmbMokhalafat.Items.Add(IntToStr(FoodsList[i].Food_Code) + '-' + FoodsList[i].Food_Name);
    end;
  end;
end;

procedure TfrmDayFoodRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmDayFoodRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text; 
end;

procedure TfrmDayFoodRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSobh.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmDayFoodRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmDayFoodRpt.cmbSobhKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbSobh.ItemIndex := -1;
  end;
end;

procedure TfrmDayFoodRpt.cmbNaharKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbNahar.ItemIndex := -1;
  end;
end;

procedure TfrmDayFoodRpt.cmbMokhalafatKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbMokhalafat.ItemIndex := -1;
  end;
end;

procedure TfrmDayFoodRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmDayFoodRpt.chkCoNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmDayFoodRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmDayFoodRpt.cmdPrintClick(Sender: TObject);
var
  frmRptDayFood : TfrmRptDayFood;
  frmRptoodUsed : TfrmRptoodUsed;
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
  else
  begin
    if not chkGroup.Checked then
    begin
      Application.CreateForm(TfrmRptDayFood, frmRptDayFood);
      with frmRptDayFood do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

        if chkSign.Checked then
        begin
          lblEndRep1.Caption := F_Params.EndRep1;
          lblEndRep2.Caption := F_Params.EndRep2;
          lblEndRep3.Caption := F_Params.EndRep3;
          lblEndRep4.Caption := F_Params.EndRep4;
        end
        else
        bndSign.Enabled := False;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryFishFood.SQL.Clear;

        if chkPart.Checked and chkJob.Checked then
        begin
          grpPartJob.Expression := 'qryFishFood.P_parts + qryFishFood.P_JobCode';
          grpPartJob.Enabled := True;
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, P_parts, P_JobCode FROM FishFood, Persons, Fish, FoodList');
          qryFishFood.SQL.Add('WHERE FF_Food = Food_Code AND Fish_PCode = P_BarCode AND Fish_No = FF_FishNo AND Fish_Date = FF_Date AND Fish_Type = FF_Type');
        end
        else if chkPart.Checked then
        begin
          grpPartJob.Expression := 'qryFishFood.P_parts';
          lblJob.Enabled := False;
          grpPartJob.Enabled := True;
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, P_parts FROM FishFood, Persons, Fish, FoodList');
          qryFishFood.SQL.Add('WHERE FF_Food = Food_Code AND Fish_PCode = P_BarCode AND Fish_No = FF_FishNo AND Fish_Date = FF_Date AND Fish_Type = FF_Type');
        end
        else if chkJob.Checked then
        begin
          grpPartJob.Expression := 'qryFishFood.P_JobCode';
          grpPartJob.Enabled := True;
          lblPart.Enabled := False;
          qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, P_JobCode FROM FishFood, Persons, Fish, FoodList');
          qryFishFood.SQL.Add('WHERE FF_Food = Food_Code AND Fish_PCode = P_BarCode AND Fish_No = FF_FishNo AND Fish_Date = FF_Date AND Fish_Type = FF_Type');
        end
        else
        begin
          grpPartJob.Expression := '';
          grpPartJob.Enabled := False;
          qryFishFood.SQL.Add('SELECT  FishFood.*, Food_Name FROM FishFood, Persons, Fish, FoodList');
          qryFishFood.SQL.Add('WHERE FF_Food = Food_Code AND Fish_PCode = P_BarCode AND Fish_No = FF_FishNo AND Fish_Date = FF_Date AND Fish_Type = FF_Type');
        end;
        chldType.Enabled := not grpPartJob.Enabled;
        chldPartJob.Enabled := grpPartJob.Enabled;

        if txtFromDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_SOBHANEH))
        else if cmbSobh.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbSobh.Text, 1, Pos('-', cmbSobh.Text)-1));

        if not chkNahar.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_NAHAR))
        else if cmbNahar.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbNahar.Text, 1, Pos('-', cmbNahar.Text)-1));

        if not chkMokhalafat.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_MOKHALAFAT))
        else if cmbMokhalafat.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbMokhalafat.Text, 1, Pos('-', cmbMokhalafat.Text)-1));

        if chkPart.Checked and chkJob.Checked then
          qryFishFood.SQL.Add('ORDER BY FF_Date, FF_Type, P_parts, P_JobCode, FF_Food')
        else if chkPart.Checked then
          qryFishFood.SQL.Add('ORDER BY FF_Date, FF_Type, P_parts, FF_Food')
        else if chkJob.Checked then
          qryFishFood.SQL.Add('ORDER BY FF_Date, FF_Type, P_JobCode, FF_Food')
        else
          qryFishFood.SQL.Add('ORDER BY FF_Date, FF_Type, FF_Food');

        qryFishFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryFishFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptFishFood.Preview
          else qrptFishFood.Print;
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
      Application.CreateForm(TfrmRptoodUsed, frmRptoodUsed);
      with frmRptoodUsed do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

        if chkSign.Checked then
        begin
          lblEndRep1.Caption := F_Params.EndRep1;
          lblEndRep2.Caption := F_Params.EndRep2;
          lblEndRep3.Caption := F_Params.EndRep3;
          lblEndRep4.Caption := F_Params.EndRep4;
        end
        else
        bndSign.Enabled := False;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryFishFood.SQL.Clear;

        qryFishFood.SQL.Add('SELECT  FishFood.*, Food_Name FROM FishFood, Fish, FoodList');
        qryFishFood.SQL.Add('WHERE FF_Food = Food_Code AND Fish_No = FF_FishNo AND Fish_Date = FF_Date AND Fish_Type = FF_Type');

        if txtFromDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_SOBHANEH))
        else if cmbSobh.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbSobh.Text, 1, Pos('-', cmbSobh.Text)-1));

        if not chkNahar.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_NAHAR))
        else if cmbNahar.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbNahar.Text, 1, Pos('-', cmbNahar.Text)-1));

        if not chkMokhalafat.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_MOKHALAFAT))
        else if cmbMokhalafat.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbMokhalafat.Text, 1, Pos('-', cmbMokhalafat.Text)-1));

        qryFishFood.SQL.Add('ORDER BY  ff_Date,ff_food,fish_type');

        qryFishFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryFishFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptFoodUsed.Preview
          else qrptFoodUsed.Print;
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

procedure TfrmDayFoodRpt.chkGroupClick(Sender: TObject);
begin
  if chkGroup.Checked then
  begin
    chkPart.Checked := False;
    chkJob.Checked := False;
  end;
end;

procedure TfrmDayFoodRpt.chkPartClick(Sender: TObject);
begin
  if chkPart.Checked then
    chkGroup.Checked := False;
end;

procedure TfrmDayFoodRpt.chkJobClick(Sender: TObject);
begin
  if chkJob.Checked then
    chkGroup.Checked := False;
end;

end.
