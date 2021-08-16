unit LstFshRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpLstFsh,slctpart;

type
  TfrmFishLisrRpt = class(TForm)
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
    Label2: TLabel;
    Label3: TLabel;
    txtPCode: TEdit;
    Label4: TLabel;
    txtFamily: TEdit;
    Label5: TLabel;
    txtName: TEdit;
    rdoSort: TRadioGroup;
    cmbJobs: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    txtToDate: TEdit;
    rdoPerson: TRadioGroup;
    grpTafkik: TGroupBox;
    chkPart: TCheckBox;
    chkJob: TCheckBox;
    chkSign: TCheckBox;
    Label8: TLabel;
    cmbBuilding: TComboBox;
    Label9: TLabel;
    cmbTerminal: TComboBox;
    txtParts: TEdit;
    BitBtn1: TBitBtn;
    Label10: TLabel;
    cmbreserve7: TComboBox;
    rdoRecType: TRadioGroup;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure chkSobhKeyPress(Sender: TObject; var Key: Char);
    procedure txtPCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmbJobsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkPartKeyPress(Sender: TObject; var Key: Char);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBuildingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbTerminalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbreserve7KeyDown(Sender: TObject; var Key: Word;
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
  ComTools, DBS_Proc;

{$R *.DFM}


procedure TfrmFishLisrRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label7.Caption := (Label7.Caption);
  Label6.Caption := (Label6.Caption);
  Label2.Caption := (Label2.Caption);
  grpType.Caption := (grpType.Caption);
  chkSobh.Caption := (chkSobh.Caption);
  chkNahar.Caption := (chkNahar.Caption);
  chkSham.Caption := (chkSham.Caption);

  rdoPerson.Caption := (rdoPerson.Caption);
  for i := 0 to rdoPerson.Items.Count-1 do
    rdoPerson.Items.Strings[i] := (rdoPerson.Items.Strings[i]);

  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count-1 do
    rdoSort.Items.Strings[i] := (rdoSort.Items.Strings[i]);

  grpTafkik.Caption := (grpTafkik.Caption);
  chkPart.Caption := (chkPart.Caption);
  chkJob.Caption := (chkJob.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmFishLisrRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtFamily.Handle);
  SetDirectionFarsi(txtFamily.Handle);

  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

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

procedure TfrmFishLisrRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmFishLisrRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmFishLisrRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmFishLisrRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPCode.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmFishLisrRpt.txtPCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtFamily.SetFocus;
  end;
end;

procedure TfrmFishLisrRpt.txtFamilyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end;
end;

procedure TfrmFishLisrRpt.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbJobs.SetFocus;
  end;
end;

procedure TfrmFishLisrRpt.cmbBuildingKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbBuilding.ItemIndex := -1;
  end;
end;

procedure TfrmFishLisrRpt.cmbJobsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJobs.ItemIndex := -1;
  end;
end;

procedure TfrmFishLisrRpt.cmbreserve7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbreserve7.ItemIndex := -1;
  end;
end;

procedure TfrmFishLisrRpt.cmbTerminalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbTerminal.ItemIndex := -1;
  end;
end;

procedure TfrmFishLisrRpt.chkSobhKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    rdoPerson.SetFocus;
  end;
end;

procedure TfrmFishLisrRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);
end;

procedure TfrmFishLisrRpt.chkPartKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
  end;
end;

procedure TfrmFishLisrRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmFishLisrRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmFishLisrRpt.cmdPrintClick(Sender: TObject);
 var frmRptListFish : TfrmRptListFish;
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
  else
  begin
    SetUserControl;
    Application.CreateForm(TfrmRptListFish, frmRptListFish);
    with frmRptListFish do
    begin
      Mouse_Wait;
      Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      grpPartJob.Enabled := (chkPart.Checked OR chkJob.Checked);

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
      else if txtFromDate.Text <> '' then
        lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
      else if txtToDate.Text <> '' then
        lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
      else
        lblRepDate.Caption := '';
      qryFish.SQL.Clear;
      qryFish.SQL.Add('SELECT * FROM Fish, Persons WHERE Fish_PCode = P_BarCode');

      if txtFromDate.Text <> '' then
        qryFish.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
      if txtToDate.Text <> '' then
        qryFish.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

      if txtPCode.Text <> '' then
        qryFish.SQL.Add('AND Fish_PCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''');

      if txtFamily.Text <> '' then
        qryFish.SQL.Add('AND P_Family = ''' + txtFamily.Text + '''');

      if txtName.Text <> '' then
        qryFish.SQL.Add('AND P_Name = ''' + txtName.Text + '''');

      if cmbJobs.Text <> '' then
        qryFish.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));

      if txtparts.text <> '' then
        qryFish.SQL.Add('AND P_parts like  ' + ''''+ part_lcode+'''');

      if cmbBuilding.Text <> '' then
        qryFish.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));

      if cmbreserve7.Text <> '' then
        qryFish.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

      if cmbTerminal.Text <> '' then
        qryFish.SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));

      if not chkSobh.Checked then
        qryFish.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
      if not chkNahar.Checked then
        qryFish.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
      if not chkSham.Checked then
        qryFish.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));

      case rdoPerson.ItemIndex of
        1: qryFish.SQL.Add('AND P_Rejim = 0 AND P_IsGuest = 0');
        2: qryFish.SQL.Add('AND P_Rejim = 1');
        3: qryFish.SQL.Add('AND P_IsGuest = 1');
      end;
      case rdoRecType.ItemIndex of
        1: qryFish.SQL.Add('AND fish_rdrCode>0');
        2: qryFish.SQL.Add('AND fish_rdrCode=0');
      end;

      qryFish.SQL.Add('ORDER BY Fish_Date, Fish_Type');

      if not grpPartJob.Enabled then
       grpPartJob.Expression := ''
      else if chkPart.Checked and chkJob.Checked then
      begin
        grpPartJob.Expression := 'qryFish.P_parts + qryFish.P_JobCode';
        qryFish.SQL.Add(', P_parts, P_JobCode');
      end
      else if chkPart.Checked then
      begin
        grpPartJob.Expression := 'qryFish.P_parts';
        lblJob.Enabled := False;
        qryFish.SQL.Add(', P_parts');
      end
      else if chkJob.Checked then
      begin
        grpPartJob.Expression := 'qryFish.P_JobCode';
        lblPart.Enabled := False;
        qryFish.SQL.Add(', P_JobCode');
      end;

      case rdoSort.ItemIndex of
        0: qryFish.SQL.Add(', Fish_No');
        1: qryFish.SQL.Add(', Fish_PCode');
        2: qryFish.SQL.Add(', P_Family, P_Name, P_BarCode');
      end;

      qryFish.Open;
      Mouse_NoWait;
      Msg_NoWait;
      if qryFish.RecordCount > 0 then
      begin
        if rdoScreen.Checked then qrptFish.Preview
        else qrptFish.Print;
      end
      else
        InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
      qryFish.Close;
      Free;
    end;
    USERCONTROL := False;
  end;
end;

end.
