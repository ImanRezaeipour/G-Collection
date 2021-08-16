unit ilgFshRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, DB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, RpilgFsh,slctpart;

type
  TfrmilgFishRpt = class(TForm)
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

procedure TfrmilgFishRpt.SetWinF;
var i : Byte;
begin
end;

procedure TfrmilgFishRpt.CreateReportDBS(fdate,edate:string);
var
  tbl : TAdoTable;
  qry : TAdoQuery;
begin
  tbl := TAdoTable.Create(Application);
  tbl.connection := frmDBS.DBConnection;
  tbl.TableName := 'GhFish';

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('delete from GhFish');
  qry.ExecSQL;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT COUNT(Fish_PCode) As C, Fish_Date, Fish_Type, Fish_PCode FROM Fish');
  qry.SQL.Add('where Fish_PCode not in(select p_barcode as Fish_PCode from persons)');
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
    if qry.FieldByName('Fish_PCode').AsString<>''
    then if qry.FieldByName('fish_Date').AsString<>''
    then begin
        tbl.Append;
        tbl.FieldByName('Gh_Date').AsString := qry.FieldByname('Fish_Date').AsString;
        tbl.FieldByName('Gh_Type').AsInteger := qry.FieldByname('Fish_Type').AsInteger;
        tbl.FieldByName('Gh_PCode').AsString := qry.FieldByname('Fish_PCode').AsString;
        tbl.FieldByName('Gh_Count').AsInteger := qry.FieldByname('C').AsInteger;
        tbl.FieldByName('Gh_statday').AsInteger := 0;
        tbl.Post;
    end;
    qry.Next;
  end;
  qry.Close;
  tbl.Close;
  qry.Free;
  tbl.Free;
end;

procedure TfrmilgFishRpt.FormCreate(Sender: TObject);
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

procedure TfrmilgFishRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmilgFishRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmilgFishRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmilgFishRpt.cmbPartKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbJob.SetFocus;
  end;
end;

procedure TfrmilgFishRpt.cmbJobKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
  end;
end;

procedure TfrmilgFishRpt.cmbJobKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJob.ItemIndex := -1;
  end;
end;

procedure TfrmilgFishRpt.chkSobhKeyPress(Sender: TObject;
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

procedure TfrmilgFishRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmilgFishRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);

end;

procedure TfrmilgFishRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmilgFishRpt.cmdPrintClick(Sender: TObject);
var
  frmilgFish : TfrmRpilgFish;
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
    Application.CreateForm(TfrmRpilgFish, frmilgFish);
    with frmilgFish do
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
      qryGhFish.SQL.Clear;

      qryGhFish.SQL.Add('SELECT * FROM GhFish');
      qryGhFish.SQL.Add('WHERE 1 = 1');

      if not chkSobh.Checked then
        qryGhFish.SQL.Add('AND Gh_Type <> ' + IntToStr(MB_SOBH));
      if not chkNahar.Checked then
        qryGhFish.SQL.Add('AND Gh_Type <> ' + IntToStr(MB_NAHAR));
      if not chkSham.Checked then
        qryGhFish.SQL.Add('AND Gh_Type <> ' + IntToStr(MB_SHAM));

      qryGhFish.Open;
      Mouse_NoWait;
      Msg_NoWait;
      if qryGhFish.RecordCount > 0 then
      begin
        SetUserControl;
        if rdoScreen.Checked then qrptilgFish.Preview
        else qrptilgFish.Print;
        USERCONTROL := False;
      end
      else
        InformationMessage('Å—”‰· é Ê‰ ê—› Â ‰«‘‰«” ÊÃÊœ ‰œ«—œ.');
      qryGhFish.Close;
      Free;
    end;
  end;
end;

end.
