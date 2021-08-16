unit AmrPrcRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, DosMove,slctpart;

type
  TfrmAmarPriceRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    lbl1: TLabel;
    txtFromDate: TEdit;
    grpType: TGroupBox;
    chkNahar: TCheckBox;
    chkSobh: TCheckBox;
    chkMokhalafat: TCheckBox;
    cmbSobh: TComboBox;
    cmbNahar: TComboBox;
    cmbMokhalafat: TComboBox;
    lbl2: TLabel;
    txtToDate: TEdit;
    chkSign: TCheckBox;
    rdoGroup: TRadioGroup;
    lbl3: TLabel;
    cmbPCode: TComboBox;
    cmbFamilyName: TComboBox;
    lbl4: TLabel;
    lbl5: TLabel;
    cmbJobType: TComboBox;
    DosMove1: TDosMove;
    txtParts: TEdit;
    BitBtn1: TBitBtn;
    cmbreserve7: TComboBox;
    Label10: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbSobhKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbNaharKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbMokhalafatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbPCodeClick(Sender: TObject);
    procedure cmbFamilyNameClick(Sender: TObject);
    procedure cmbPCodeExit(Sender: TObject);
    procedure cmbFamilyNameExit(Sender: TObject);
    procedure cmbJobTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure SetWinF;

  public
  partcode:string;  { Public declarations }
  end;


implementation

uses
  ComTools, RpAmrPrc, RpAmrPcG, DBS_Proc;

{$R *.DFM}

procedure TfrmAmarPriceRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);

  chkSobh.Caption := (chkSobh.Caption);
  chkNahar.Caption := (chkNahar.Caption);
  chkMokhalafat.Caption := (chkMokhalafat.Caption);

  rdoGroup.Caption := (rdoGroup.Caption);
  for i := 0 to rdoGroup.Items.Count-1 do
    rdoGroup.Items.Strings[i] := (rdoGroup.Items.Strings[i]);

  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);

  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmAmarPriceRpt.FormCreate(Sender: TObject);
var
  i : Byte;
  qry : TAdoQuery;
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_BarCode, P_Family, P_Name FROM Persons ORDER BY P_Family, P_Name');
  qry.Open;
  while not qry.Eof do
  begin
    cmbPCode.Items.Add(DelLeftZero(qry.FieldByName('P_BarCode').AsString));
    cmbFamilyName.Items.Add(qry.FieldByName('P_Family').AsString + '-' +
                            qry.FieldByName('P_Name').AsString);
    qry.Next;
  end;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Job_Code, Job_Name FROM JobType');
  qry.Open;
  while not qry.Eof do
  begin
    cmbJobType.Items.Add(qry.FieldByName('Job_Code').AsString + '-' +
                         qry.FieldByName('Job_Name').AsString);
    qry.Next;
  end;

  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM reserve7');
  qry.Open;
  while not qry.Eof do
  begin
    cmbreserve7.Items.Add(qry.FieldByName('rsrv7_name').AsString );
    qry.Next;
  end;
  qry.Close;

  qry.Free;

  for i := 1 to TotalFoods do
  begin
    case FoodsList[i].Food_Type of
      MB_SOBHANEH   : cmbSobh.Items.Add(IntToStr(FoodsList[i].Food_Code) + '-' + FoodsList[i].Food_Name);
      MB_GHAZA      : cmbNahar.Items.Add(IntToStr(FoodsList[i].Food_Code) + '-' + FoodsList[i].Food_Name);
      MB_MOKHALAFAT : cmbMokhalafat.Items.Add(IntToStr(FoodsList[i].Food_Code) + '-' + FoodsList[i].Food_Name);
    end;
  end;
end;

procedure TfrmAmarPriceRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmAmarPriceRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text; 
end;

procedure TfrmAmarPriceRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmAmarPriceRpt.cmbPCodeClick(Sender: TObject);
begin
  cmbFamilyName.ItemIndex := cmbPCode.ItemIndex;
end;

procedure TfrmAmarPriceRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);
  
end;

procedure TfrmAmarPriceRpt.cmbFamilyNameClick(Sender: TObject);
begin
  cmbPCode.ItemIndex := cmbFamilyName.ItemIndex;
end;

procedure TfrmAmarPriceRpt.cmbPCodeExit(Sender: TObject);
begin
  if cmbPCode.ItemIndex = -1 then
    cmbFamilyName.Text := '';
end;

procedure TfrmAmarPriceRpt.cmbFamilyNameExit(Sender: TObject);
begin
  if cmbFamilyName.ItemIndex = -1 then
    cmbPCode.Text := '';
end;

procedure TfrmAmarPriceRpt.cmbSobhKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbSobh.ItemIndex := -1;
  end;
end;

procedure TfrmAmarPriceRpt.cmbNaharKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbNahar.ItemIndex := -1;
  end;
end;

procedure TfrmAmarPriceRpt.cmbMokhalafatKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbMokhalafat.ItemIndex := -1;
  end;
end;

procedure TfrmAmarPriceRpt.cmbJobTypeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJobType.ItemIndex := -1;
  end;
end;

procedure TfrmAmarPriceRpt.cmdPrintClick(Sender: TObject);
var
  frmRptAmarPrice : TfrmRptAmarPrice;
  frmRptAmarPriceGroup : TfrmRptAmarPriceGroup;
  part_lcode:string;
  begin
  part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';
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
    if rdoGroup.ItemIndex in[0..2]then
    begin
      Application.CreateForm(TfrmRptAmarPriceGroup, frmRptAmarPriceGroup);
      with frmRptAmarPriceGroup do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

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
        qryFishFood.SQL.Clear;

        case rdoGroup.ItemIndex of
          0:
          begin
            qryFishFood.SQL.Add('SELECT SUM(FF_No) AS C, SUM(FF_No * FP_PriceFee) AS Prc, FP_PriceFee, P_BarCode, P_Family, P_Name');
            qryFishFood.SQL.Add('FROM Fish, FishFood, FoodList, FoodPric, Persons');
            qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
            qryFishFood.SQL.Add('AND FF_Food = FP_FoodCode');
            qryFishFood.SQL.Add('AND FF_Food = Food_Code');
            qryFishFood.SQL.Add('AND Fish_PCode = P_BarCode');
          end;

          1:
          begin
            qryFishFood.SQL.Add('SELECT SUM(FF_No) AS C, SUM(FF_No * FP_PriceFee) AS Prc, FP_PriceFee, P_parts, Part_Name');
            qryFishFood.SQL.Add('FROM Fish, FishFood, FoodList, FoodPric, Persons, Parts');
            qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
            qryFishFood.SQL.Add('AND FF_Food = FP_FoodCode');
            qryFishFood.SQL.Add('AND FF_Food = Food_Code');
            qryFishFood.SQL.Add('AND Fish_PCode = P_BarCode');
            qryFishFood.SQL.Add('AND P_parts = Part_Code');
          end;

          2:
          begin
            qryFishFood.SQL.Add('SELECT SUM(FF_No) AS C, SUM(FF_No * FP_PriceFee) AS Prc, FP_PriceFee, P_JobCode, Job_Name');
            qryFishFood.SQL.Add('FROM Fish, FishFood, FoodList, FoodPric, Persons, JobType');
            qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
            qryFishFood.SQL.Add('AND FF_Food = FP_FoodCode');
            qryFishFood.SQL.Add('AND FF_Food = Food_Code');
            qryFishFood.SQL.Add('AND Fish_PCode = P_BarCode');
            qryFishFood.SQL.Add('AND P_JobCode = Job_Code');
          end;
        end;

        if txtFromDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_SOBHANEH))
        else if cmbSobh.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbSobh.Text, 1, Pos('-', cmbSobh.Text)-1));

        if not chkNahar.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_GHAZA))
        else if cmbNahar.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbNahar.Text, 1, Pos('-', cmbNahar.Text)-1));

        if not chkMokhalafat.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_MOKHALAFAT))
        else if cmbMokhalafat.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbMokhalafat.Text, 1, Pos('-', cmbMokhalafat.Text)-1));

        if cmbPCode.Text <> '' then
          qryFishFood.SQL.Add('AND P_BarCode = ''' + FixLeft(cmbPCode.Text, '0', 8) + '''');

        if txtParts.Text <> '' then
          qryFishFood.SQL.Add('AND P_parts  like ' + ''''+ part_lcode +'''');

        if cmbJobType.Text <> '' then
          qryFishFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJobType.Text, 1, Pos('-', cmbJobType.Text)-1));

        if cmbreserve7.Text <> '' then
          qryFishFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        case rdoGroup.ItemIndex of
          0:
          begin
            grpPublic.Expression := 'qryFishFood.P_BarCode';
            exprGroup.Expression := '''˛'' + qryFishFood.P_BarCode + ''-'' + qryFishFood.P_Family + ''-'' + qryFishFood.P_Name';
            qryFishFood.SQL.Add('GROUP BY P_BarCode, P_Family, P_Name, FP_PriceFee');
            qryFishFood.SQL.Add('ORDER BY P_BarCode');
          end;

          1:
          begin
            grpPublic.Expression := 'qryFishFood.P_parts';
            exprGroup.Expression := '''˛'' + qryFishFood.P_parts + ''-'' + qryFishFood.Part_Name';
            qryFishFood.SQL.Add('GROUP BY P_parts, Part_Name, FP_PriceFee');
            qryFishFood.SQL.Add('ORDER BY P_parts');
          end;

          2:
          begin
            grpPublic.Expression := 'qryFishFood.P_JobCode';
            exprGroup.Expression := '''˛'' + qryFishFood.P_JobCode + ''-'' + qryFishFood.Job_Name';
            qryFishFood.SQL.Add('GROUP BY P_JobCode, Job_Name, FP_PriceFee');
            qryFishFood.SQL.Add('ORDER BY P_JobCode');
          end;
        end;

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
    else if rdoGroup.ItemIndex = 3 then
    begin
      Application.CreateForm(TfrmRptAmarPrice, frmRptAmarPrice);
      with frmRptAmarPrice do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

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
        qryFishFood.SQL.Clear;
        qryFishFood.SQL.Add('SELECT SUM(FF_No) AS C, SUM(FF_No * FP_PriceFee) AS Prc, FP_PriceFee FROM FishFood, FoodList, FoodPric');
        qryFishFood.SQL.Add('WHERE FF_Food = FP_FoodCode');
        qryFishFood.SQL.Add('AND FF_Food = Food_Code');

        if txtFromDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_SOBHANEH))
        else if cmbSobh.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbSobh.Text, 1, Pos('-', cmbSobh.Text)-1));

        if not chkNahar.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_GHAZA))
        else if cmbNahar.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbNahar.Text, 1, Pos('-', cmbNahar.Text)-1));

        if not chkMokhalafat.Checked then
          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_MOKHALAFAT))
        else if cmbMokhalafat.Text <> '' then
          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbMokhalafat.Text, 1, Pos('-', cmbMokhalafat.Text)-1));

        qryFishFood.SQL.Add('GROUP BY FP_PriceFee');
        qryFishFood.SQL.Add('ORDER BY FP_PriceFee');

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

end.
