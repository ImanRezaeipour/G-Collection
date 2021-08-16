unit PrsFodRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpFdPrT, RpFdPrs, RpFdPrM, RpFdPrMC, RpFdTPrs, RpFdMkPr,
  RpFdPrF, RpFdPrCP, Rptedad, DosMove,slctpart;

type
  TfrmPersonFishRpt = class(TForm)
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
    DosMove1: TDosMove;
    chkOnPage: TCheckBox;
    BitBtn1: TBitBtn;
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
    procedure chkAllClick(Sender: TObject);
    procedure chkNormClick(Sender: TObject);
    procedure rdoRptTypeClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
  public
  partcode:string;  { Public declarations }
  end;


implementation

uses
  ComTools, DBS_Proc;

{$R *.DFM}

procedure TfrmPersonFishRpt.SetWinF;
begin
end;


procedure TfrmPersonFishRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtFamily.Handle);

  rdoRptTypeClick(Sender);

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

    Free;                                                                                    qry.Close;
  end;
end;

procedure TfrmPersonFishRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmPersonFishRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmPersonFishRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text
end;

procedure TfrmPersonFishRpt.txtPCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmPersonFishRpt.cmbJobKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJob.ItemIndex := -1;
  end;
end;

procedure TfrmPersonFishRpt.cmdPrintClick(Sender: TObject);
var
  frmRptPrsFoodT : TfrmRptPrsFoodT;
  frmRptPrsFoods : TfrmRptPrsFoods;
  frmRptPrsFoodM : TfrmRptPrsFoodM;
  frmRptPrsFoodMC : TfrmRptPrsFoodMC;
  frmRptPrsFoodType : TfrmRptPrsFoodType;
  frmRptPrsFoodMokhalafat : TfrmRptPrsFoodMokhalafat;
  frmRptPrsFoodCount : TfrmRptPrsFoodCount;
  frmRptPrsFoodCntPrc : TfrmRptPrsFoodCntPrc;
  frmRpttedad : TfrmRpttedad;
  sOrder : string;
  part_lcode:string;
  s : string;
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
      Application.CreateForm(TfrmRptPrsFoodT, frmRptPrsFoodT);
      with frmRptPrsFoodT do
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
        grpFamily.ForceNewPage := chkOnPage.Checked;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryPrsFood.SQL.Clear;
        qryPrsFood.SQL.Add('SELECT * FROM Fish, Persons WHERE Fish_PCode = P_BarCode');

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
          qryPrsFood.SQL.Add('AND P_parts like ' + ''''+  part_lcode +'''');

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if cmbreserve7.Text <> '' then
          qryPrsFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1')
        else if chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 1')
        else if chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1');

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
          qryPrsFood.SQL.Add(sOrder + 'P_BarCode, Fish_Date, Fish_Type')
        else
          qryPrsFood.SQL.Add(sOrder + 'P_Family, P_Name, Fish_Date, Fish_Type');

        qryPrsFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryPrsFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptPrsFood.Preview
          else qrptPrsFood.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryPrsFood.Close;
        Free;
      end;
    end
    else if rdoRptType.ItemIndex = 1 then
    begin
      Application.CreateForm(TfrmRptPrsFoods, frmRptPrsFoods);
      with frmRptPrsFoods do
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
          qryPrsFood.SQL.Add('AND P_parts like ' + ''''+ part_lcode +'''');

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if cmbreserve7.Text <> '' then
          qryPrsFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1')
        else if chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 1')
        else if chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1');

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
    else if rdoRptType.ItemIndex = 2 then
    begin
      Application.CreateForm(TfrmRptPrsFoodM, frmRptPrsFoodM);
      with frmRptPrsFoodM do
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

        qryPrsFood.SQL.Add('SELECT DISTINCT P_BarCode, P_Name, P_Family, P_parts, P_JobCode, Fish_Date');
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
          qryPrsFood.SQL.Add('AND P_parts like ' + ''''+part_lcode +'''');

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1')
        else if chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 1')
        else if chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1');


        case rdoPrice.ItemIndex of
          1: qryPrsFood.SQL.Add('AND P_Pricable = 1');
          2: qryPrsFood.SQL.Add('AND P_Pricable = 0');
        end;

        grpPartJob.Enabled := (chkPart.Checked OR chkJob.Checked);
        sOrder := '';
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
          qryPrsFood.SQL.Add(sOrder + 'P_BarCode, Fish_Date')
        else
          qryPrsFood.SQL.Add(sOrder + 'P_Family, P_Name, Fish_Date');

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
    else if rdoRptType.ItemIndex = 3 then
    begin
      Application.CreateForm(TfrmRptPrsFoodMC, frmRptPrsFoodMC);
      with frmRptPrsFoodMC do
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

        qryPrsFood.SQL.Add('SELECT DISTINCT P_BarCode, P_parts, P_JobCode, Fish_Date, Fish_Type, Fish_No');
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

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1')
        else if chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 1')
        else if chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1');

        case rdoPrice.ItemIndex of
          1: qryPrsFood.SQL.Add('AND P_Pricable = 1');
          2: qryPrsFood.SQL.Add('AND P_Pricable = 0');
        end;

        sOrder := '';
        if not chkPart.Checked and not chkJob.Checked then
          grpMonth.Expression := 'COPY(qryPrsFood.Fish_Date, 6, 2)'
        else if chkPart.Checked and chkJob.Checked then
        begin
          grpMonth.Expression := 'COPY(qryPrsFood.Fish_Date,6,2) + STR(qryPrsFood.P_parts) + STR(qryPrsFood.P_JobCode)';
          sOrder := 'ORDER BY P_parts, P_JobCode';
        end
        else if chkPart.Checked then
        begin
          grpMonth.Expression := 'COPY(qryPrsFood.Fish_Date,6,2) + STR(qryPrsFood.P_parts)';
          sOrder := 'ORDER BY P_parts';
          lblJob.Enabled := False;
        end
        else if chkJob.Checked then
        begin
          grpMonth.Expression := 'COPY(qryPrsFood.Fish_Date,6,2) + STR(qryPrsFood.P_JobCode)';
          sOrder := 'ORDER BY P_JobCode';
          lblPart.Enabled := False;
        end;

        if sOrder <> '' then
          sOrder := sOrder + ', '
        else
          sOrder := 'ORDER BY ';
        qryPrsFood.SQL.Add(sOrder + 'P_BarCode, Fish_Date');

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
    else if rdoRptType.ItemIndex = 4 then
    begin
      Application.CreateForm(TfrmRptPrsFoodType, frmRptPrsFoodType);
      with frmRptPrsFoodType do
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
          qryPrsFood.SQL.Add('AND P_parts  like ' + ''''+part_lcode +'''');

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1')
        else if chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 1')
        else if chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1');

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
    else if rdoRptType.ItemIndex in [5, 6] then
    begin
      Application.CreateForm(TfrmRptPrsFoodMokhalafat, frmRptPrsFoodMokhalafat);
      with frmRptPrsFoodMokhalafat do
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

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1')
        else if chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 1')
        else if chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1');

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
          if rdoRptType.ItemIndex = 6 then
          begin
            dtlData.Height := 0;
            grpPartJob.ForceNewPage := false;
          end;
          if rdoScreen.Checked then qrptPrsFood.Preview
          else qrptPrsFood.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryPrsFood.Close;
        Free;
      end;
    end
    else if rdoRptType.ItemIndex = 7 then
    begin
      Application.CreateForm(TfrmRptPrsFoodCount, frmRptPrsFoodCount);
      with frmRptPrsFoodCount do
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
        grpFamily.ForceNewPage := chkOnPage.Checked;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';

        qryPrsFood.SQL.Clear;

        qryPrsFood.SQL.Add('SELECT P_BarCode, P_Name, P_Family, P_parts, P_JobCode, FF_Food, FF_No, FF_Pay, FF_Price');
        qryPrsFood.SQL.Add('FROM Persons, Fish, FishFood');
        qryPrsFood.SQL.Add('WHERE Fish_PCode = P_BarCode');
        qryPrsFood.SQL.Add('AND Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');

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
          qryPrsFood.SQL.Add('AND P_parts like' + ''''+part_lcode+'''');

        if cmbJob.Text <> '' then
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1')
        else if chkRejim.Checked then
          qryPrsFood.SQL.Add('AND P_Rejim = 1')
        else if chkGuest.Checked then
          qryPrsFood.SQL.Add('AND P_IsGuest = 1');

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
          qryPrsFood.SQL.Add(sOrder + 'P_BarCode, FF_Food')
        else
          qryPrsFood.SQL.Add(sOrder + 'P_Family, P_Name, FF_Food');

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
    else if rdoRptType.ItemIndex = 8 then
    begin
      Application.CreateForm(TfrmRptPrsFoodCntPrc, frmRptPrsFoodCntPrc);
      with frmRptPrsFoodCntPrc do
      begin
        SetRptWinF;
        if chkSign.Checked then
        begin
          lblEndRep1.Caption := F_Params.EndRep1;
          lblEndRep2.Caption := F_Params.EndRep2;
          lblEndRep3.Caption := F_Params.EndRep3;
          lblEndRep4.Caption := F_Params.EndRep4;
        end
        else
          bndSign.Enabled := False;

        lblDate.Caption := CurrentDate;
        grpFamily.ForceNewPage := chkOnPage.Checked;
        StartDate := txtFromDate.Text;
        EndDate := txtToDate.Text;

        qryPrs.connection := frmDBS.DBConnection;
        qryFood.connection := frmDBS.DBConnection;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';

        qryPrs.SQL.Clear;

        qryPrs.SQL.Add('SELECT DISTINCT P_BarCode, P_Name, P_Family, P_parts, P_JobCode');
        qryPrs.SQL.Add('FROM Persons, Fish');
        qryPrs.SQL.Add('WHERE Fish_PCode = P_BarCode');

        if txtFromDate.Text <> '' then
          qryPrs.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryPrs.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if not chkSobh.Checked then
          qryPrs.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
        if not chkNahar.Checked then
          qryPrs.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
        if not chkSham.Checked then
          qryPrs.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));

        if txtPCode.Text <> '' then
          qryPrs.SQL.Add('AND Fish_PCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''');

        if txtFamily.Text <> '' then
          qryPrs.SQL.Add('AND P_Family = ''' + txtFamily.Text + '''');

        if txtParts.Text <> '' then
          qryPrs.SQL.Add('AND P_parts like ' +''''+part_lcode +'''');

        if cmbJob.Text <> '' then
          qryPrs.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
          qryPrs.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0')
        else if chkNorm.Checked and chkRejim.Checked then
          qryPrs.SQL.Add('AND P_IsGuest = 0')
        else if chkNorm.Checked and chkGuest.Checked then
          qryPrs.SQL.Add('AND P_Rejim = 0')
        else if chkRejim.Checked and chkGuest.Checked then
          qryPrs.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1')
        else if chkRejim.Checked then
          qryPrs.SQL.Add('AND P_Rejim = 1')
        else if chkGuest.Checked then
          qryPrs.SQL.Add('AND P_IsGuest = 1');

        case rdoPrice.ItemIndex of
          1: qryPrs.SQL.Add('AND P_Pricable = 1');
          2: qryPrs.SQL.Add('AND P_Pricable = 0');
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
          qryPrs.SQL.Add(sOrder + 'P_BarCode')
        else
          qryPrs.SQL.Add(sOrder + 'P_Family, P_Name');
        qryPrs.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryPrs.RecordCount > 0 then
        begin
          if rdoScreen.Checked then Preview
          else Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryPrs.Close;
        Free;
      end;
    end
    else if rdoRptType.ItemIndex = 9 then
    begin
      Application.CreateForm(TfrmRpttedad, frmRpttedad);
      with frmRpttedad do
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

        s:='';
        qryPrsFood.SQL.Add('SELECT count(fish_type) as tghaza, fish_date FROM Fish, Persons WHERE Fish_PCode = P_BarCode');

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
        begin
          qryPrsFood.SQL.Add('AND Fish_PCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''');
          s:=s+' AND Fish_PCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''';
        end;

        if txtFamily.Text <> '' then
        begin
          qryPrsFood.SQL.Add('AND P_Family = ''' + txtFamily.Text + '''');
          s:=s+'AND P_Family = ''' + txtFamily.Text + '''';
        end;

        if txtParts.Text <> '' then
        begin
          qryPrsFood.SQL.Add('AND P_parts like ' + ''''+  part_lcode +'''');
          s:=s+'AND P_parts like ' + ''''+  part_lcode +'''';
        end;

        if cmbJob.Text <> '' then
        begin
          qryPrsFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));
          s:=s+'AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1);
        end;

        if cmbreserve7.Text <> '' then
        begin
          qryPrsFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');
          s:=s+'AND P_reserve7 = ''' + cmbreserve7.Text+'''';
        end;

        if chkNorm.Checked and not chkRejim.Checked and not chkGuest.Checked then
        begin
          qryPrsFood.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0');
          s:=s+'AND P_IsGuest = 0 AND P_Rejim = 0'
        end
        else if chkNorm.Checked and chkRejim.Checked then
        begin
          qryPrsFood.SQL.Add('AND P_IsGuest = 0');
          s:=s+'AND P_IsGuest = 0'
        end
        else if chkNorm.Checked and chkGuest.Checked then
        begin
          qryPrsFood.SQL.Add('AND P_Rejim = 0');
          s:=s+'AND P_Rejim = 0'
        end
        else if chkRejim.Checked and chkGuest.Checked then
        begin
          qryPrsFood.SQL.Add('AND P_IsGuest = 1 AND P_Rejim = 1');
          s:=s+'AND P_IsGuest = 1 AND P_Rejim = 1'
        end
        else if chkRejim.Checked then
        begin
          qryPrsFood.SQL.Add('AND P_Rejim = 1');
          s:=s+'AND P_Rejim = 1'
        end
        else if chkGuest.Checked then
        begin
          qryPrsFood.SQL.Add('AND P_IsGuest = 1');
          s:=s+'AND P_IsGuest = 1';
        end;

        case rdoPrice.ItemIndex of
          1: begin
               qryPrsFood.SQL.Add('AND P_Pricable = 1');
               s:=s+'AND P_Pricable = 1';
             end;
          2: begin
               qryPrsFood.SQL.Add('AND P_Pricable = 0');
               s:=s+'AND P_Pricable = 0';
             end;
        end;

        qryPrsFood.SQL.Add('group by fish_date');

        qryPrsFood.SQL.Add('ORDER BY Fish_Date');

        qryPrsFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        ss:=s;
        if qryPrsFood.RecordCount > 0 then
        begin
          if rdoScreen.Checked then qrpttedad.Preview
          else qrpttedad.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryPrsFood.Close;
        Free;
      end;
    end;
  end;
end;


procedure TfrmPersonFishRpt.BitBtn2Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);

end;

procedure TfrmPersonFishRpt.chkAllClick(Sender: TObject);
begin
  if chkAll.Checked then
  begin
    chkNorm.Checked := False;
    chkRejim.Checked := False;
    chkGuest.Checked := False;
  end;
end;

procedure TfrmPersonFishRpt.chkNormClick(Sender: TObject);
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

procedure TfrmPersonFishRpt.rdoRptTypeClick(Sender: TObject);
begin
  chkOnPage.Enabled := (rdoRptType.ItemIndex in [0, 7, 8]);
end;

end.


