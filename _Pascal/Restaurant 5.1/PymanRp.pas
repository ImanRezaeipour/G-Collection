unit PymanRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpPyman, RpPymanG, RpPymanRejim;

type
  TfrmPeymanRpt = class(TForm)
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
    chkSign: TCheckBox;
    chkMokhPrice: TCheckBox;
    rdoGroup: TRadioGroup;
    cmbTerminal: TComboBox;
    Label9: TLabel;
    cmbreserve7: TComboBox;
    Label10: TLabel;
    cmbBuilding: TComboBox;
    Label8: TLabel;
    txtParts: TEdit;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    cmbJobs: TComboBox;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
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
    procedure chkMokhPriceKeyPress(Sender: TObject; var Key: Char);
    procedure cmbJobsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure cmbBuildingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbreserve7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbTerminalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure SetWinF;

  public
   partcode:string;
    { Public declarations }
  end;


implementation

uses
  ComTools,DBS_Proc,slctPart;

{$R *.DFM}

procedure TfrmPeymanRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  chkSobh.Caption := (chkSobh.Caption);
  chkNahar.Caption := (chkNahar.Caption);
  chkMokhalafat.Caption := (chkMokhalafat.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  chkMokhPrice.Caption := (chkMokhPrice.Caption);
  rdoGroup.Caption := (rdoGroup.Caption);
  for i := 0 to rdoGroup.Items.Count-1 do
    rdoGroup.Items.Strings[i] := (rdoGroup.Items.Strings[i]);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmPeymanRpt.FormCreate(Sender: TObject);
var
  i : Byte;
  qry : TAdoQuery;
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
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM JobType');
  qry.Open;
  while not qry.Eof do
  begin
    cmbJobs.Items.Add(qry.FieldByName('Job_Code').AsString + '-' + qry.FieldByName('Job_Name').AsString);
    qry.Next;
  end;

  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM building');
  qry.Open;
  while not qry.Eof do
  begin
    cmbBuilding.Items.Add(qry.FieldByName('building_Code').AsString + '-' + qry.FieldByName('building_Name').AsString);
    qry.Next;
  end;
  qry.Close;

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

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM readers');
  qry.Open;
  while not qry.Eof do
  begin
    cmbTerminal.Items.Add(qry.FieldByName('r_Code').AsString + '-' + qry.FieldByName('r_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.Free;
  
end;

procedure TfrmPeymanRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmPeymanRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text; 
end;

procedure TfrmPeymanRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSobh.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmPeymanRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmPeymanRpt.cmbSobhKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbSobh.ItemIndex := -1;
  end;
end;

procedure TfrmPeymanRpt.cmbTerminalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbTerminal.ItemIndex := -1;
  end;
end;

procedure TfrmPeymanRpt.cmbNaharKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbNahar.ItemIndex := -1;
  end;
end;

procedure TfrmPeymanRpt.cmbreserve7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbreserve7.ItemIndex := -1;
  end;
end;

procedure TfrmPeymanRpt.cmbBuildingKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbBuilding.ItemIndex := -1;
  end;
end;

procedure TfrmPeymanRpt.cmbJobsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJobs.ItemIndex := -1;
  end;
end;

procedure TfrmPeymanRpt.cmbMokhalafatKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbMokhalafat.ItemIndex := -1;
  end;
end;

procedure TfrmPeymanRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmPeymanRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkMokhPrice.SetFocus;
  end;
end;

procedure TfrmPeymanRpt.cmdPrintClick(Sender: TObject);
var
  frmRptPeyman : TfrmRptPeyman;
  frmRptPeymanRejim : TfrmRptPeymanRejim;
  frmRptPeymanGroup : TfrmRptPeymanGroup;
  part_lcode:string;
begin
  part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';
  if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
  begin
    ErrorMessage('تاريخ اشتباه است.');
    txtFromDate.SetFocus;
  end
  else if (txtToDate.Text <> '') and not IsTrueDate(txtToDate.Text) then
  begin
    ErrorMessage('تاريخ اشتباه است.');
    txtToDate.SetFocus;
  end
  else if (txtFromDate.Text <> '') and (txtToDate.Text <> '') and
          (txtFromDate.Text > txtToDate.Text) then
  begin
    ErrorMessage('تاريخ ابتدا از تاريخ انتها بزرگتر است.');
    txtToDate.SetFocus;
  end
  else
  begin
    if rdoGroup.ItemIndex = 3 then
    begin
      Application.CreateForm(TfrmRptPeyman, frmRptPeyman);
      with frmRptPeyman do
      begin
        Mouse_Wait;
        Msg_Wait('در حال ايجاد گزارش');

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        MokhPrc := chkMokhPrice.Checked;
        EDate := txtToDate.Text;
        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('از تاريخ : ' + txtFromDate.Text + '    تا تاريخ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('از تاريخ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := ('تا تاريخ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryFishFood.SQL.Clear;

//        qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, persons.* , Food_Name, Food_Type FROM Fish, FishFood, FoodList, Persons');
//        qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
//        qryFishFood.SQL.Add('AND FF_Food = Food_Code AND Fish_PCode = P_BarCode');// or fish_UCode in (select unit_code from units)');
        qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*, Food_Name, Food_Type FROM FishFood, FoodList');
        qryFishFood.SQL.Add('WHERE FF_Food = Food_Code');

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

        if cmbJobs.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));
          lblRepDate.Caption := 'نوع استخدام :' + cmbJobs.Text + '    ' + lblRepDate.Caption;
        end;

        if txtparts.text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_parts like  ' + ''''+ part_lcode+'''');
          lblRepDate.Caption := 'بخش :' + txtParts.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbBuilding.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));
          lblRepDate.Caption := 'ساختمان : ' + cmbBuilding.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbreserve7.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');
          lblRepDate.Caption := 'مرکز هزینه : ' + cmbreserve7.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbTerminal.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));
          lblRepDate.Caption := 'ترمینال : ' + cmbTerminal.Text + '    ' + lblRepDate.Caption;
        end;

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
          InformationMessage('هيچ فيشي صادر نشده است.');
        qryFishFood.Close;
        Free;
      end;
    end
    else if rdoGroup.ItemIndex = 2 then
    begin
      Application.CreateForm(TfrmRptPeymanRejim, frmRptPeymanRejim);
      with frmRptPeymanRejim do
      begin
        Mouse_Wait;
        Msg_Wait('در حال ايجاد گزارش');

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        MokhPrc := chkMokhPrice.Checked;
        EDate := txtToDate.Text;
        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('از تاريخ : ' + txtFromDate.Text + '    تا تاريخ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('از تاريخ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := ('تا تاريخ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryFishFood.SQL.Clear;

        qryFishFood.SQL.Add('select fish_date , SUM (CASE p_Rejim WHEN 0 THEN SOBH ELSE 0 END)  AS SOBH');
        qryFishFood.SQL.Add('		 , SUM (CASE p_Rejim WHEN 1 THEN SOBH ELSE 0 END)  AS SOBH_R');
        qryFishFood.SQL.Add('		 , SUM (CASE p_Rejim WHEN 0 THEN NAHAR ELSE 0 END) AS NAHAR');
        qryFishFood.SQL.Add('		 , SUM (CASE p_Rejim WHEN 1 THEN NAHAR ELSE 0 END) AS NAHAR_R');
        qryFishFood.SQL.Add('		 , SUM (CASE p_Rejim WHEN 0 THEN SHAM ELSE 0 END)  AS SHAM');
        qryFishFood.SQL.Add('		 , SUM (CASE p_Rejim WHEN 1 THEN SHAM ELSE 0 END)  AS SHAM_R');
        qryFishFood.SQL.Add('		 ,sum(SOBH)+Sum(NAHAR)+Sum(SHAM) AS TOTAL');
        qryFishFood.SQL.Add('from(');
        qryFishFood.SQL.Add('select fish_date ,p_Rejim, SUM(CASE fish_type WHEN 1 THEN amount ELSE 0 END) AS SOBH');
        qryFishFood.SQL.Add(' 			 , SUM(CASE fish_type WHEN 2 THEN amount ELSE 0 END) AS NAHAR');
        qryFishFood.SQL.Add(' 			 , SUM(CASE fish_type WHEN 3 THEN amount ELSE 0 END) AS SHAM');
        qryFishFood.SQL.Add('from');
        qryFishFood.SQL.Add('(');
        qryFishFood.SQL.Add('select fish_date,fish_type,p_Rejim ,amount=count(fish_no) from');
        qryFishFood.SQL.Add('(select * from fish,persons where fish.fish_PCode=p_barcode');

        if cmbJobs.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));
          lblRepDate.Caption := 'نوع استخدام :' + cmbJobs.Text + '    ' + lblRepDate.Caption;
        end;

        if txtparts.text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_parts like  ' + ''''+ part_lcode+'''');
          lblRepDate.Caption := 'بخش :' + txtParts.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbBuilding.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));
          lblRepDate.Caption := 'ساختمان : ' + cmbBuilding.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbreserve7.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');
          lblRepDate.Caption := 'مرکز هزینه : ' + cmbreserve7.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbTerminal.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));
          lblRepDate.Caption := 'ترمینال : ' + cmbTerminal.Text + '    ' + lblRepDate.Caption;
        end;

        qryFishFood.SQL.Add(')a');
        qryFishFood.SQL.Add('group by fish_date,fish_type,p_Rejim');
        qryFishFood.SQL.Add(')aa');
        qryFishFood.SQL.Add('group by fish_date,p_Rejim');
        qryFishFood.SQL.Add(')aaa where 1=1 ');
        if txtFromDate.Text <> '' then
          qryFishFood.SQL.Add('and Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryFishFood.SQL.Add('and Fish_Date <= ''' + txtToDate.Text + '''');



//        if not chkSobh.Checked then
//          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_SOBHANEH))
//        else if cmbSobh.Text <> '' then
//          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbSobh.Text, 1, Pos('-', cmbSobh.Text)-1));
//
//        if not chkNahar.Checked then
//          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_GHAZA))
//        else if cmbNahar.Text <> '' then
//          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbNahar.Text, 1, Pos('-', cmbNahar.Text)-1));
//
//        if not chkMokhalafat.Checked then
//          qryFishFood.SQL.Add('AND Food_Type <> ' + IntToStr(MB_MOKHALAFAT))
//        else if cmbMokhalafat.Text <> '' then
//          qryFishFood.SQL.Add('AND FF_Food = ' + Copy(cmbMokhalafat.Text, 1, Pos('-', cmbMokhalafat.Text)-1));

        qryFishFood.SQL.Add('group by fish_date');
        qryFishFood.SQL.Add('ORDER BY Fish_Date');

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
          InformationMessage('هيچ فيشي صادر نشده است.');
        qryFishFood.Close;
        Free;
      end;
    end
    else if rdoGroup.ItemIndex in [0,1] then
    begin
      Application.CreateForm(TfrmRptPeymanGroup, frmRptPeymanGroup);
      with frmRptPeymanGroup do
      begin
        Mouse_Wait;
        Msg_Wait('در حال ايجاد گزارش');

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        MokhPrc := chkMokhPrice.Checked;
        EDate := txtToDate.Text;
        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('از تاريخ : ' + txtFromDate.Text + '    تا تاريخ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('از تاريخ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := ('تا تاريخ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryFishFood.SQL.Clear;

        qryFishFood.SQL.Add('SELECT DISTINCT FishFood.*,persons.*, Food_Name, Food_Type,fish_type , P_Rejim, P_IsGuest FROM Fish, FishFood, FoodList, Persons');
        qryFishFood.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
        qryFishFood.SQL.Add('AND FF_Food = Food_Code AND Fish_PCode = P_BarCode');

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


        if cmbJobs.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));
          lblRepDate.Caption := 'نوع استخدام :' + cmbJobs.Text + '    ' + lblRepDate.Caption;
        end;

        if txtparts.text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_parts like  ' + ''''+ part_lcode+'''');
          lblRepDate.Caption := 'بخش :' + txtParts.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbBuilding.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));
          lblRepDate.Caption := 'ساختمان : ' + cmbBuilding.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbreserve7.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');
          lblRepDate.Caption := 'مرکز هزینه : ' + cmbreserve7.Text + '    ' + lblRepDate.Caption;
        end;
        if cmbTerminal.Text <> '' then
        begin
          qryFishFood.SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));
          lblRepDate.Caption := 'ترمینال : ' + cmbTerminal.Text + '    ' + lblRepDate.Caption;
        end;

        qryFishFood.SQL.Add('ORDER BY fish_type, P_Rejim, P_IsGuest, FF_Food, FF_Pay');

        qryFishFood.Open;
        Mouse_NoWait;
        Msg_NoWait;

        groupAsFishType := (rdoGRoup.ItemIndex = 1);

        if qryFishFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptPeyman.Preview
          else qrptPeyman.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('هيچ فيشي صادر نشده است.');
        qryFishFood.Close;
        Free;
      end;
    end;
  end;
end;

procedure TfrmPeymanRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);
end;

procedure TfrmPeymanRpt.chkMokhPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

end.
