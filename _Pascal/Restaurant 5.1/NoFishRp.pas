unit NoFishRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,slctpart,
  MSGs, Keyboard, RpNoFish;

type
  TfrmPersonNoFishRpt = class(TForm)
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
    cmbJob: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    grpVadeh: TGroupBox;
    chkSobh: TCheckBox;
    chkNahar: TCheckBox;
    chkSham: TCheckBox;
    grpSort: TRadioGroup;
    rdoPerson: TRadioGroup;
    chkSign: TCheckBox;
    txtParts: TEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmbPartKeyPress(Sender: TObject; var Key: Char);
    procedure cmbJobKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateExit(Sender: TObject);
    procedure chkSobhKeyPress(Sender: TObject; var Key: Char);
    procedure cmbJobKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
  public
    PartCode:string;
    sobhaneh , nahar , sham : boolean;
  end;


implementation

uses
  ComTools, DBS_Proc;

{$R *.DFM}

procedure TfrmPersonNoFishRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  rdoPerson.Caption := (rdoPerson.Caption);
  for i := 0 to rdoPerson.Items.Count-1 do
    rdoPerson.Items.Strings[i] := (rdoPerson.Items.Strings[i]);

  grpSort.Caption := (grpSort.Caption);
  for i := 0 to grpSort.Items.Count-1 do
    grpSort.Items.Strings[i] := (grpSort.Items.Strings[i]);

  grpVadeh.Caption := (grpVadeh.Caption);
  chkSobh.Caption := (chkSobh.Caption);
  chkNahar.Caption := (chkNahar.Caption);
  chkSham.Caption := (chkSham.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmPersonNoFishRpt.FormCreate(Sender: TObject);
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
    SQL.Add('SELECT * FROM JobType');
    Open;
    while not EOF do
    begin
      cmbJob.Items.Add(IntToStr(FieldByName('Job_Code').AsInteger) + '-' + FieldByname('Job_Name').AsString);
      Next;
    end;
    Close;

    Free;
  end;
end;

procedure TfrmPersonNoFishRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmPersonNoFishRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmPersonNoFishRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmPersonNoFishRpt.cmbPartKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbJob.SetFocus;
  end;
end;

procedure TfrmPersonNoFishRpt.cmbJobKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    rdoPerson.SetFocus;
  end;
end;

procedure TfrmPersonNoFishRpt.cmbJobKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJob.ItemIndex := -1;
  end;
end;

procedure TfrmPersonNoFishRpt.chkSobhKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmPersonNoFishRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmPersonNoFishRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);

end;

procedure TfrmPersonNoFishRpt.chkSignKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmPersonNoFishRpt.cmdPrintClick(Sender: TObject);
var frmRpNoFish : TfrmRpNoFish;
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
    g_Options.RptFDate := txtFromDate.Text;
    g_Options.RptTDate := txtToDate.Text;
    Application.CreateForm(TfrmRpNoFish, frmRpNoFish);
    with frmRpNoFish do
    begin
      isSobhaneh := chkSobh.Checked;
      isNahar := chkNahar.Checked;
      isSham := chkSham.Checked;
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
      qryPersonNoFish.SQL.Clear;

      qryPersonNoFish.SQL.Add('SELECT * FROM Persons');
      qryPersonNoFish.SQL.Add('left outer join parts on P_parts = P_Code');
      qryPersonNoFish.SQL.Add('WHERE p_isvalid=1 and P_BarCode NOT IN (SELECT Fish_PCode FROM Fish');
      qryPersonNoFish.SQL.Add('WHERE Fish_No > 0');

      if txtFromDate.Text <> '' then
        qryPersonNoFish.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
      if txtToDate.Text <> '' then
        qryPersonNoFish.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

      if not chkSobh.Checked then
        qryPersonNoFish.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SOBH));
      if not chkNahar.Checked then
        qryPersonNoFish.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_NAHAR));
      if not chkSham.Checked then
        qryPersonNoFish.SQL.Add('AND Fish_Type <> ' + IntToStr(MB_SHAM));
      qryPersonNoFish.SQL.Add(')');

      if txtParts.Text <> '' then
        qryPersonNoFish.SQL.Add('AND P_parts like ' +''''+ part_lcode +'''' );

      if cmbJob.Text <> '' then
        qryPersonNoFish.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));

//      qryPersonNoFish.SQL.Add('AND P_parts = P_Code');

      case rdoPerson.ItemIndex of
        1: qryPersonNoFish.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0');
        2: qryPersonNoFish.SQL.Add('AND P_Rejim = 1');
        3: qryPersonNoFish.SQL.Add('AND P_IsGuest = 1');
      end;

      case grpSort.ItemIndex of
        0: qryPersonNoFish.SQL.Add('ORDER BY P_Family, P_parts ');
        1: qryPersonNoFish.SQL.Add('ORDER BY P_parts, P_Family, P_Name');
        2: qryPersonNoFish.SQL.Add('ORDER BY P_JobCode, P_Family, P_Name');
      end;
      qryPersonNoFish.Open;
      Mouse_NoWait;
      Msg_NoWait;
      if qryPersonNoFish.RecordCount > 0 then
      begin
        SetUserControl;
        if rdoScreen.Checked then qrptNoFish.Preview
        else qrptNoFish.Print;
        USERCONTROL := False;
      end
      else
        InformationMessage('Å—”‰· €–« ‰ŒÊ—œÂ ÊÃÊœ ‰œ«—œ.');
      qryPersonNoFish.Close;
      Free;
    end;
  end;
end;

end.
