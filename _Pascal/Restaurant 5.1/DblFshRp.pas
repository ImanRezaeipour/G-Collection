unit DblFshRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, DB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpDblFsh,slctpart;

type
  TfrmDblFishRpt = class(TForm)
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
    procedure CreateReportDBS(fdate,edate:string);
    procedure SetWinF;

  public
  partcode:string;  { Public declarations }
  end;


implementation

uses
  ComTools, DBS_Proc;

{$R *.DFM}

procedure TfrmDblFishRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label4.Caption := (Label4.Caption);
  Label3.Caption := (Label3.Caption);
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

procedure TfrmDblFishRpt.CreateReportDBS(fdate,edate:string);
var
  tbl : TAdoTable;
  qry : TAdoQuery;
begin
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.DBConnection;
  tbl.TableName := 'DblFish';

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('delete from dblFish');
  qry.ExecSQL;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT COUNT(Fish_PCode) As C, Fish_Date, Fish_Type, Fish_PCode FROM Fish');
  qry.SQL.Add('where 1 = 1');
  if fdate<>''
    then qry.SQL.Add('and Fish_Date>='''+fdate+'''');
  if edate<>''
    then qry.SQL.Add('and Fish_Date<='''+edate+'''');
  qry.SQL.Add('GROUP BY Fish_Date, Fish_Type, Fish_PCode');
  qry.SQL.Add('ORDER BY Fish_Date, Fish_Type, Fish_PCode');
  qry.Open;
  tbl.Open;
  while not qry.Eof do
  begin
    tbl.Append;
    tbl.FieldByName('DBL_Date').AsString := qry.FieldByname('Fish_Date').AsString;
    tbl.FieldByName('DBL_Type').AsInteger := qry.FieldByname('Fish_Type').AsInteger;
    tbl.FieldByName('DBL_PCode').AsString := qry.FieldByname('Fish_PCode').AsString;
    tbl.FieldByName('DBL_Count').AsInteger := qry.FieldByname('C').AsInteger;
    tbl.Post;
    qry.Next;
  end;
  qry.Close;
  tbl.Close;
  qry.Free;
  tbl.Free;
end;

procedure TfrmDblFishRpt.FormCreate(Sender: TObject);
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

procedure TfrmDblFishRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmDblFishRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmDblFishRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmDblFishRpt.cmbPartKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbJob.SetFocus;
  end;
end;

procedure TfrmDblFishRpt.cmbJobKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    rdoPerson.SetFocus;
  end;
end;

procedure TfrmDblFishRpt.cmbJobKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJob.ItemIndex := -1;
  end;
end;

procedure TfrmDblFishRpt.chkSobhKeyPress(Sender: TObject;
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

procedure TfrmDblFishRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmDblFishRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);

end;

procedure TfrmDblFishRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmDblFishRpt.cmdPrintClick(Sender: TObject);
var
  frmDblFish : TfrmRpDblFish;
  part_lcode:string;
  fdate,edate:string;
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
    CreateReportDBS(txtFromDate.Text,txtToDate.Text);
    Application.CreateForm(TfrmRpDblFish, frmDblFish);
    with frmDblFish do
    begin
      Mouse_Wait;
      Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘...');

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
      qryDblFish.SQL.Clear;

      qryDblFish.SQL.Add('SELECT * FROM Persons, DblFish');
      qryDblFish.SQL.Add('WHERE DBL_Count > 1');
      qryDblFish.SQL.Add('AND DBL_PCode = P_BarCode');
      if txtFromDate.Text <> '' then
        qryDblFish.SQL.Add('AND DBL_Date >= ''' + txtFromDate.Text + '''');
      if txtToDate.Text <> '' then
        qryDblFish.SQL.Add('AND DBL_Date <= ''' + txtToDate.Text + '''');

      if not chkSobh.Checked then
        qryDblFish.SQL.Add('AND DBL_Type <> ' + IntToStr(MB_SOBH));
      if not chkNahar.Checked then
        qryDblFish.SQL.Add('AND DBL_Type <> ' + IntToStr(MB_NAHAR));
      if not chkSham.Checked then
        qryDblFish.SQL.Add('AND DBL_Type <> ' + IntToStr(MB_SHAM));

      if txtParts.Text <> '' then
        qryDblFish.SQL.Add('AND P_parts like ' + ''''+part_lcode +'''');

      if cmbJob.Text <> '' then
        qryDblFish.SQL.Add('AND P_JobCode = ' + Copy(cmbJob.Text, 1, Pos('-', cmbJob.Text)-1));


      case rdoPerson.ItemIndex of
        1: qryDblFish.SQL.Add('AND P_IsGuest = 0 AND P_Rejim = 0');
        2: qryDblFish.SQL.Add('AND P_Rejim = 1');
        3: qryDblFish.SQL.Add('AND P_IsGuest = 1');
      end;

      case grpSort.ItemIndex of
        0: qryDblFish.SQL.Add('ORDER BY P_Family, P_Name, P_parts ');
        1: qryDblFish.SQL.Add('ORDER BY P_parts, P_Family, P_Name');
        2: qryDblFish.SQL.Add('ORDER BY P_JobCode, P_Family, P_Name');
      end;
      qryDblFish.Open;
      Mouse_NoWait;
      Msg_NoWait;
      if qryDblFish.RecordCount > 0 then
      begin
        SetUserControl;
        if rdoScreen.Checked then qrptDblFish.Preview
        else qrptDblFish.Print;
        USERCONTROL := False;
      end
      else
        InformationMessage('Å—”‰· œ«—«Ì €–«Ì  ﬂ—«—Ì ÊÃÊœ ‰œ«—œ.');
      qryDblFish.Close;
      Free;
    end;
  end;
end;

end.
