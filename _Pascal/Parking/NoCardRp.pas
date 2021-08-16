unit NoCardRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, DateProc, MSGs, FarsiApi, Globals,
  Keyboard, RpNoCard, DBS, RunCmnds, DosMove;

type
  TfrmExitNoCardRpt = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    txtBarCode: TEdit;
    txtDate: TEdit;
    txtNumber: TEdit;
    txtSerial: TEdit;
    cmbCarName: TComboBox;
    cmbCity: TComboBox;
    Label13: TLabel;
    txtTime: TEdit;
    cmdClose: TBitBtn;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure txtBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarNameEnter(Sender: TObject);
    procedure cmbCarNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure txtTimeExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
    SrchStr : String;

    function AreValidControls : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmExitNoCardRpt.SetWinF;
begin
  Caption := (Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label6.Caption := (Label6.Caption);
  Label13.Caption := (Label13.Caption);
  Label5.Caption := (Label5.Caption);
  Label7.Caption := (Label7.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

function TfrmExitNoCardRpt.AreValidControls : Boolean;
begin
  if (txtDate.Text <> '') and not IsTrueDate(txtDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ Œ—ÊÃ «‘ »«Â «” ');
    AreValidControls := False;
    txtDate.SetFocus;
  end
  else if (txtTime.Text <> '') and not IsTrueTime(txtTime.Text) then
  begin
    ErrorMessage('“„«‰ Œ—Ê⁄ «‘ »«Â «” ');
    AreValidControls := False;
    txtTime.SetFocus;
  end
  else
    AreValidControls := True;
end;


procedure TfrmExitNoCardRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  rdoPrinter.Enabled := g_options.AcesPrint;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
     connection := frmDBS.adoConnect;
     SQL.Clear;
     SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
     Open;
     cmbCity.Items.Clear;
     while not EOF do
     begin
       cmbCity.Items.Add(FieldByName('City_Name').AsString);
       Next;
     end;

     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Cars ORDER BY Car_Code');
     Open;
     cmbCarName.Items.Clear;
     while not EOF do
     begin
       cmbCarName.Items.Add(FieldByName('Car_Name').AsString);
       Next;
     end;
    Close;
    Free;
  end;
  SetDirectionFarsi(cmbCarName.Handle);
  SetDirectionFarsi(txtNumber.Handle);
  SetDirectionFarsi(cmbCity.Handle);
end;

procedure TfrmExitNoCardRpt.txtBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmExitNoCardRpt.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmExitNoCardRpt.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmExitNoCardRpt.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmExitNoCardRpt.txtTimeExit(Sender: TObject);
begin
  if txtTime.Text <> '' then
    txtTime.Text := BeautifulTime(txtTime.Text);
end;

procedure TfrmExitNoCardRpt.cmbCarNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmExitNoCardRpt.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmExitNoCardRpt.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmExitNoCardRpt.cmbCityKeyPress(Sender: TObject; var Key: Char);
begin
  SrchNearst(SrchStr, cmbCity, Key);
end;

procedure TfrmExitNoCardRpt.cmdPrintClick(Sender: TObject);
var
  frmRptNoCard : TfrmRptNoCard;
  sql : String;
begin
  if AreValidControls then
  begin
    if g_options.RdrOff_Rpt = MB_TRUE then
      SetUserControl;
    Application.CreateForm(TfrmRptNoCard, frmRptNoCard);
    with frmRptNoCard do
    begin
      sql := '';
      qryNoCard.SQL.Clear;
      qryNoCard.SQL.Add('SELECT * FROM NoCard');
      if txtBarCode.Text <> '' then
        sql := 'WHERE N_BarCode = ''' + txtBarCode.Text + '''';
      if txtDate.Text <> '' then
      begin
        if sql = '' then
         sql := 'WHERE '
        else
          sql := sql + ' AND ';
        sql := sql + 'N_ExitDate = ''' + txtDate.Text + '''';
      end;
      if txtTime.Text <> '' then
      begin
        if sql = '' then
         sql := 'WHERE '
        else
          sql := sql + ' AND ';
        sql := sql + 'N_ExitTime = ''' + txtTime.Text + '''';
      end;
      if cmbCarName.Text <> '' then
      begin
        if sql = '' then
         sql := 'WHERE '
        else
          sql := sql + ' AND ';
        sql := sql + 'N_Name = ''' + cmbCarName.Text + '''';
      end;
      if txtNumber.Text <> '' then
      begin
        if sql = '' then
         sql := 'WHERE '
        else
          sql := sql + ' AND ';
        sql := sql + 'N_Number = ''' + txtNumber.Text + '''';
      end;
      if cmbCity.Text <> '' then
      begin
        if sql = '' then
         sql := 'WHERE '
        else
          sql := sql + ' AND ';
        sql := sql + 'N_City = ''' + cmbCity.Text + '''';
      end;
      if txtSerial.Text <> '' then
      begin
        if sql = '' then
         sql := 'WHERE '
        else
          sql := sql + ' AND ';
        sql := sql + 'N_Serial = ''' + txtSerial.Text + '''';
      end;
      if sql <> '' then
        qryNoCard.SQL.Add(sql);
      qryNoCard.SQL.Add('ORDER BY N_ExitDate, N_ExitTime');
      qryNoCard.Open;
      if not qryNoCard.EOF then
      begin
        if rdoScreen.Checked then
          qrptNoCard.Preview
        else
          qrptNoCard.Print;
      end
      else
        InformationMessage('ÂÌç ŒÊœ—ÊÌÌ ÊÃÊœ ‰œ«—œ.');
      Free;
    end;
    if g_options.RdrOff_Rpt = MB_TRUE then
      UserControl := False;
  end;
end;

end.
