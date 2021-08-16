unit CstFodRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,slctpart,
  MSGs, Keyboard;

type
  TfrmCostUsedFoodRpt = class(TForm)
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
    Label3: TLabel;
    txtPCode: TEdit;
    lblPFamily: TLabel;
    txtFamily: TEdit;
    rdoRptType: TRadioGroup;
    Label7: TLabel;
    txtToDate: TEdit;
    grpTafkik: TGroupBox;
    chkPart: TCheckBox;
    chkJob: TCheckBox;
    Label2: TLabel;
    Label4: TLabel;
    cmbJob: TComboBox;
    chkSign: TCheckBox;
    rdoPrice: TRadioGroup;
    grpPerson: TGroupBox;
    chkAll: TCheckBox;
    chkNorm: TCheckBox;
    chkRejim: TCheckBox;
    chkGuest: TCheckBox;
    rdoSort: TRadioGroup;
    txtParts: TEdit;
    BitBtn2: TBitBtn;
    cmbreserve7: TComboBox;
    Label10: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtPCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbJobKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure chkAllClick(Sender: TObject);
    procedure chkNormClick(Sender: TObject);
  private
    { Private declarations }
    procedure SendTab(var Key : Char);
    procedure SetWinF;
  public
  partcode:string;
    { Public declarations }
  end;


implementation

uses
  ComTools, RpCstFod, RpCstFdP, DBS_Proc;

{$R *.DFM}

procedure TfrmCostUsedFoodRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label3.Caption := (Label3.Caption);
  Label2.Caption := (Label2.Caption);
  Label7.Caption := (Label7.Caption);
  lblPFamily.Caption := (lblPFamily.Caption);
  Label4.Caption := (Label4.Caption);
  grpType.Caption := (grpType.Caption);
  chkSobh.Caption := (chkSobh.Caption);
  chkNahar.Caption := (chkNahar.Caption);
  chkSham.Caption := (chkSham.Caption);
  grpTafkik.Caption := (grpTafkik.Caption);
  chkPart.Caption := (chkPart.Caption);
  chkJob.Caption := (chkJob.Caption);

  grpPerson.Caption := (grpPerson.Caption);
  chkAll.Caption := (chkAll.Caption);
  chkNorm.Caption := (chkNorm.Caption);
  chkRejim.Caption := (chkRejim.Caption);
  chkGuest.Caption := (chkGuest.Caption);

  rdoRptType.Caption := (rdoRptType.Caption);
  for i := 0 to rdoRptType.Items.Count-1 do
    rdoRptType.Items.Strings[i] := (rdoRptType.Items.Strings[i]);

  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count-1 do
    rdoSort.Items.Strings[i] := (rdoSort.Items.Strings[i]);
    
  for i := 0 to rdoPrice.Items.Count-1 do
    rdoPrice.Items.Strings[i] := (rdoPrice.Items.Strings[i]);

  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmCostUsedFoodRpt.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmCostUsedFoodRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtFamily.Handle);

  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM JobType');
    Open;
    while not EOF do
    begin
      cmbJob.Items.Add(IntToStr(FieldByName('Job_Code').AsInteger) + '-' + FieldByname('Job_Name').AsString);
      Next;
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM reserve7');
    Open;
    while not Eof do
    begin
      cmbreserve7.Items.Add(qry.FieldByName('rsrv7_name').AsString );
      Next;
    end;
    Close;

    Free;
  end;

end;

procedure TfrmCostUsedFoodRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmCostUsedFoodRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmCostUsedFoodRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text
end;

procedure TfrmCostUsedFoodRpt.txtPCodeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmCostUsedFoodRpt.txtFamilyKeyPress(Sender: TObject;
  var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmCostUsedFoodRpt.cmbJobKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJob.ItemIndex := -1;
  end;
end;

procedure TfrmCostUsedFoodRpt.cmdPrintClick(Sender: TObject);
var
  frmRpCostUsedFood : TfrmRpCostUsedFood;
  frmRpCostUsedFoodParts : TfrmRpCostUsedFoodParts;
  sOrder : string;
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
  else if not chkAll.Checked and not chkNorm.Checked and
          not chkRejim.Checked and not chkGuest.Checked then
  begin
    ErrorMessage('‰Ê⁄ «›—«œ „‘Œ’ ‰Ì” .');
    chkAll.SetFocus;
  end
  else
  begin
    Mouse_Wait;
    Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');
    if rdoRptType.ItemIndex = 0 then
    begin
      Application.CreateForm(TfrmRpCostUsedFood, frmRpCostUsedFood);
      with frmRpCostUsedFood do
      begin
        if chkSign.Checked then
        begin
          lblEndRep1.Caption := F_Params.EndRep1;
          lblEndRep2.Caption := F_Params.EndRep2;
          lblEndRep3.Caption := F_Params.EndRep3;
          lblEndRep4.Caption := F_Params.EndRep4;
        end
        else
          bndSign.Enabled := False;

        StartDate := txtFromDate.Text;
        EndDate := txtToDate.Text;
        Sobh_Valid := chkSobh.Checked;
        Nahar_Valid := chkNahar.Checked;
        Sham_Valid := chkSham.Checked;
        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryPrsFood.SQL.Clear;


        qryPrsFood.SQL.Add('SELECT DISTINCT P_BarCode, P_Name, P_Family, P_parts, P_JobCode');
        qryPrsFood.SQL.Add('FROM Persons, Fish WHERE Fish_PCode = P_BarCode');

        if txtFromDate.Text <> '' then
          qryPrsFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryPrsFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryPrsFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
        if not chkNahar.Checked then
          qryPrsFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
        if not chkSham.Checked then
          qryPrsFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));

        if txtPCode.Text <> '' then
          qryPrsFood.SQL.Add('AND Fish_PCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''');

        if txtFamily.Text <> '' then
          qryPrsFood.SQL.Add('AND P_Family = ''' + txtFamily.Text + '''');

        if txtParts.Text <> '' then
          qryPrsFood.SQL.Add('AND P_parts like ' + ''''+part_lcode+'''');

        if cmbreserve7.Text <> '' then
          qryPrsFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1');

        case rdoPrice.ItemIndex of
          1: qryPrsFood.SQL.Add('AND P_Pricable = 1');
          2: qryPrsFood.SQL.Add('AND P_Pricable = 0');
        end;

        sOrder := '';
        grpPartJob.Enabled := (chkPart.Checked OR chkJob.Checked);
        if not grpPartJob.Enabled then
          grpPartJob.Expression := ''
        else if chkPart.Checked and chkJob.Checked then
        begin
          grpPartJob.Expression := 'qryPrsFood.P_parts + qryPrsFood.P_JobCode';
          sOrder := 'ORDER BY P_parts, P_JobCode';
        end
        else if chkPart.Checked then
        begin
          grpPartJob.Expression := 'qryPrsFood.P_parts';
          sOrder := 'ORDER BY P_parts';
          lblJob.Enabled := False;
        end
        else if chkJob.Checked then
        begin
          grpPartJob.Expression := 'qryPrsFood.P_JobCode';
          sOrder := 'ORDER BY P_JobCode';
          lblPart.Enabled := False;
        end;

        if sOrder <> '' then
          sOrder := sOrder + ', '
        else
          sOrder := 'ORDER BY ';
        if rdoSort.ItemIndex = 0 then
          qryPrsFood.SQL.Add(sOrder + 'P_BarCode')
        else
          qryPrsFood.SQL.Add(sOrder + 'P_Family, P_Name');

        qryPrsFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryPrsFood.RecordCount > 0 then
        begin
          if rdoScreen.Checked then qrptPrsFood.Preview
          else qrptPrsFood.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryPrsFood.Close;
        Free;
      end;
    end
    else
    begin
      Application.CreateForm(TfrmRpCostUsedFoodParts, frmRpCostUsedFoodParts);
      with frmRpCostUsedFoodParts do
      begin
        if chkSign.Checked then
        begin
          lblEndRep1.Caption := F_Params.EndRep1;
          lblEndRep2.Caption := F_Params.EndRep2;
          lblEndRep3.Caption := F_Params.EndRep3;
          lblEndRep4.Caption := F_Params.EndRep4;
        end
        else
          bndSign.Enabled := False;

        grpPart.Height := 0;
        dtlData.Height := 0;

        StartDate := txtFromDate.Text;
        EndDate := txtToDate.Text;
        Sobh_Valid := chkSobh.Checked;
        Nahar_Valid := chkNahar.Checked;
        Sham_Valid := chkSham.Checked;
        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';

        qryPrsFood.SQL.Clear;
        qryPrsFood.SQL.Add('SELECT DISTINCT P_parts');
        qryPrsFood.SQL.Add('FROM Persons, Fish WHERE Fish_PCode = P_BarCode');

        if txtFromDate.Text <> '' then
          qryPrsFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryPrsFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryPrsFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
        if not chkNahar.Checked then
          qryPrsFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
        if not chkSham.Checked then
          qryPrsFood.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));

        if txtPCode.Text <> '' then
          qryPrsFood.SQL.Add('AND Fish_PCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''');

        if txtFamily.Text <> '' then
          qryPrsFood.SQL.Add('AND P_Family = ''' + txtFamily.Text + '''');

        if txtParts.Text <> '' then
          qryPrsFood.SQL.Add('AND P_parts like ' +''''+ part_lcode +'''');

        if cmbreserve7.Text <> '' then
          qryPrsFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1');

        case rdoPrice.ItemIndex of
          1: qryPrsFood.SQL.Add('AND P_Pricable = 1');
          2: qryPrsFood.SQL.Add('AND P_Pricable = 0');
        end;

        qryPrsFood.SQL.Add('ORDER BY P_parts');

        qryPrsFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryPrsFood.RecordCount > 0 then
        begin
          if rdoScreen.Checked then qrptPrsFood.Preview
          else qrptPrsFood.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryPrsFood.Close;
        Free;
      end;
    end;
  end;
end;


procedure TfrmCostUsedFoodRpt.BitBtn2Click(Sender: TObject);
begin
  PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);

end;

procedure TfrmCostUsedFoodRpt.chkAllClick(Sender: TObject);
begin
  if chkAll.Checked then
  begin
    chkNorm.Checked := False;
    chkRejim.Checked := False;
    chkGuest.Checked := False;
  end;
end;

procedure TfrmCostUsedFoodRpt.chkNormClick(Sender: TObject);
begin
  if chkNorm.Checked and chkRejim.Checked and chkGuest.Checked then
  begin
    chkNorm.Checked := False;
    chkRejim.Checked := False;
    chkGuest.Checked := False;
    chkAll.Checked := True;
  end
  else if chkNorm.Checked or chkRejim.Checked or chkGuest.Checked then
    chkAll.Checked := False;
end;

end.


