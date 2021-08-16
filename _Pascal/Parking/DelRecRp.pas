unit DelRecRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Globals, Keyboard, DateProc, RpDelRec,
  MSGs, RunCmnds, DosMove;

type
  TfrmDeleRecRpt = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtFromDateD: TEdit;
    txtToDateD: TEdit;
    txtFromTimeD: TEdit;
    txtToTimeD: TEdit;
    grpDel: TGroupBox;
    rdoBoth: TRadioButton;
    rdoArival: TRadioButton;
    rdoExit: TRadioButton;
    cmdPrint: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    DosMove1: TDosMove;
    Label7: TLabel;
    Label8: TLabel;
    txtFromDateI: TEdit;
    Label9: TLabel;
    txtToDateI: TEdit;
    txtToTimeI: TEdit;
    Label10: TLabel;
    txtFromTimeI: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    txtFromDateO: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    txtToDateO: TEdit;
    txtToTimeO: TEdit;
    Label16: TLabel;
    txtFromTimeO: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    GroupBox1: TGroupBox;
    rdoDTArival: TRadioButton;
    rdoDTExit: TRadioButton;
    cmdCancelFilter: TBitBtn;
    rdoDTDelete: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateDKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateDExit(Sender: TObject);
    procedure txtToDateDExit(Sender: TObject);
    procedure txtFromTimeDKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromTimeDExit(Sender: TObject);
    procedure txtToTimeDExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtFromDateIExit(Sender: TObject);
    procedure txtFromDateOExit(Sender: TObject);
    procedure txtToDateIExit(Sender: TObject);
    procedure txtToDateOExit(Sender: TObject);
    procedure txtFromTimeIExit(Sender: TObject);
    procedure txtFromTimeOExit(Sender: TObject);
    procedure txtToTimeIExit(Sender: TObject);
    procedure txtToTimeOExit(Sender: TObject);
    procedure txtFromDateIKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateIKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateOKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateOKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromTimeIKeyPress(Sender: TObject; var Key: Char);
    procedure txtToTimeIKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromTimeOKeyPress(Sender: TObject; var Key: Char);
    procedure txtToTimeOKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateDChange(Sender: TObject);
    procedure txtFromDateIChange(Sender: TObject);
    procedure txtFromDateOChange(Sender: TObject);
    procedure txtFromDateDEnter(Sender: TObject);
    procedure txtFromDateIEnter(Sender: TObject);
    procedure txtFromDateOEnter(Sender: TObject);
    procedure cmdCancelFilterClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}
const
  filterDelete = 1;
  filterInpute = 2;
  filterOutput = 3;

var
  filterType : byte; 

procedure TfrmDeleRecRpt.SetWinF;
begin
  Caption := (Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  grpDel.Caption := (grpDel.Caption);
  rdoBoth.Caption := (rdoBoth.Caption);
  rdoArival.Caption := (rdoArival.Caption);
  rdoExit.Caption := (rdoExit.Caption);
end;

procedure TfrmDeleRecRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  txtFromDateD.Text := CurrentDate;
  txtToDateD.Text := CurrentDate;
  rdoPrinter.Enabled := g_options.AcesPrint;
  filterType := filterDelete;
end;

procedure TfrmDeleRecRpt.txtFromDateDKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmDeleRecRpt.txtFromDateIChange(Sender: TObject);
begin
  if filterType = filterInpute then
  begin
    txtFromDateD.Text := '';
    txtFromDateO.Text := '';
    txtToDateD.Text := '';
    txtToDateO.Text := '';
    txtFromTimeD.Text := '';
    txtFromTimeO.Text := '';
    txtToTimeD.Text := '';
    txtToTimeO.Text := '';
  end;
end;

procedure TfrmDeleRecRpt.txtFromDateIEnter(Sender: TObject);
begin
  filterType := filterInpute;
end;

procedure TfrmDeleRecRpt.txtFromDateIExit(Sender: TObject);
begin
  if txtFromDateI.Text <> '' then
    txtFromDateI.Text := BeautifulDate(txtFromDateI.Text);
end;

procedure TfrmDeleRecRpt.txtFromDateIKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmDeleRecRpt.txtFromDateOChange(Sender: TObject);
begin
  if filterType = filterOutput then
  begin
    txtFromDateI.Text := '';
    txtFromDateD.Text := '';
    txtToDateI.Text := '';
    txtToDateD.Text := '';
    txtFromTimeI.Text := '';
    txtFromTimeD.Text := '';
    txtToTimeI.Text := '';
    txtToTimeD.Text := '';
  end;
end;

procedure TfrmDeleRecRpt.txtFromDateOEnter(Sender: TObject);
begin
  filterType := filterOutput;
end;

procedure TfrmDeleRecRpt.txtFromDateOExit(Sender: TObject);
begin
  if txtFromDateO.Text <> '' then
    txtFromDateO.Text := BeautifulDate(txtFromDateO.Text);
end;

procedure TfrmDeleRecRpt.txtFromDateOKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmDeleRecRpt.txtFromDateDChange(Sender: TObject);
begin
  if filterType = filterDelete then
  begin
    txtFromDateI.Text := '';
    txtFromDateO.Text := '';
    txtToDateI.Text := '';
    txtToDateO.Text := '';
    txtFromTimeI.Text := '';
    txtFromTimeO.Text := '';
    txtToTimeI.Text := '';
    txtToTimeO.Text := '';
  end;
end;

procedure TfrmDeleRecRpt.txtFromDateDEnter(Sender: TObject);
begin
  filterType := filterDelete;
end;

procedure TfrmDeleRecRpt.txtFromDateDExit(Sender: TObject);
begin
  if txtFromDateD.Text <> '' then
    txtFromDateD.Text := BeautifulDate(txtFromDateD.Text);
end;

procedure TfrmDeleRecRpt.txtToDateDExit(Sender: TObject);
begin
  if txtToDateD.Text <> '' then
    txtToDateD.Text := BeautifulDate(txtToDateD.Text);
end;

procedure TfrmDeleRecRpt.txtToDateIExit(Sender: TObject);
begin
  if txtToDateI.Text <> '' then
    txtToDateI.Text := BeautifulDate(txtToDateI.Text);
end;

procedure TfrmDeleRecRpt.txtToDateIKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmDeleRecRpt.txtToDateOExit(Sender: TObject);
begin
  if txtToDateO.Text <> '' then
    txtToDateO.Text := BeautifulDate(txtToDateO.Text);
end;

procedure TfrmDeleRecRpt.txtToDateOKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmDeleRecRpt.txtFromTimeDKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmDeleRecRpt.txtFromTimeIExit(Sender: TObject);
begin
  if txtFromTimeI.Text <> '' then
    txtFromTimeI.Text := BeautifulTime(txtFromTimeI.Text);
end;

procedure TfrmDeleRecRpt.txtFromTimeIKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmDeleRecRpt.txtFromTimeOExit(Sender: TObject);
begin
  if txtFromTimeO.Text <> '' then
    txtFromTimeO.Text := BeautifulTime(txtFromTimeO.Text);
end;

procedure TfrmDeleRecRpt.txtFromTimeOKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmDeleRecRpt.txtFromTimeDExit(Sender: TObject);
begin
  if txtFromTimeD.Text <> '' then
    txtFromTimeD.Text := BeautifulTime(txtFromTimeD.Text);
end;

procedure TfrmDeleRecRpt.txtToTimeDExit(Sender: TObject);
begin
  if txtToTimeD.Text <> '' then
    txtToTimeD.Text := BeautifulTime(txtToTimeD.Text);
end;

procedure TfrmDeleRecRpt.txtToTimeIExit(Sender: TObject);
begin
  if txtToTimeI.Text <> '' then
    txtToTimeI.Text := BeautifulTime(txtToTimeI.Text);
end;

procedure TfrmDeleRecRpt.txtToTimeIKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmDeleRecRpt.txtToTimeOExit(Sender: TObject);
begin
  if txtToTimeO.Text <> '' then
    txtToTimeO.Text := BeautifulTime(txtToTimeO.Text);
end;

procedure TfrmDeleRecRpt.txtToTimeOKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmDeleRecRpt.cmdCancelFilterClick(Sender: TObject);
begin
  txtFromDateD.Text := CurrentDate;
  txtToDateD.Text := CurrentDate;
  txtFromTimeD.Text := '';
  txtToTimeD.Text := '';

  txtFromDateI.Text := '';
  txtToDateI.Text := '';
  txtFromTimeI.Text := '';
  txtToTimeI.Text := '';

  txtFromDateO.Text := '';
  txtToDateO.Text := '';
  txtFromTimeO.Text := '';
  txtToTimeO.Text := '';

  rdoDTDelete.Checked := True;
  rdoBoth.Checked := True;
  rdoScreen.Checked := True;
end;

procedure TfrmDeleRecRpt.cmdPrintClick(Sender: TObject);
var frmRptDelRec : TfrmRptDelRec;
test : string;
begin
  if g_options.RdrOff_Rpt = MB_TRUE then
    SetUserControl;
  Application.CreateForm(TfrmRptDelRec, frmRptDelRec);
  with frmRptDelRec do
  begin
    if (txtFromDateD.Text <> '') and (txtToDateD.Text <> '') then
      lblFromToDate.Caption := ('Õ–› «“  «—ÌŒ: ' )+ txtFromDateD.Text + ('     «  «—ÌŒ: ' )+ txtToDateD.Text
    else if txtFromDateD.Text <> '' then
      lblFromToDate.Caption := ('Õ–› «“  «—ÌŒ: ' )+ txtFromDateD.Text
    else if txtToDateD.Text <> '' then
      lblFromToDate.Caption := ('Õ–›  «  «—ÌŒ: ' )+ txtToDateD.Text
    else
    begin
      if (txtFromDateI.Text <> '') and (txtToDateI.Text <> '') then
        lblFromToDate.Caption := ('Ê—Êœ «“  «—ÌŒ: ' )+ txtFromDateI.Text + ('     «  «—ÌŒ: ' )+ txtToDateI.Text
      else if txtFromDateI.Text <> '' then
        lblFromToDate.Caption := ('Ê—Êœ «“  «—ÌŒ: ' )+ txtFromDateI.Text
      else if txtToDateI.Text <> '' then
        lblFromToDate.Caption := ('Ê—Êœ  «  «—ÌŒ: ' )+ txtToDateI.Text
      else
      begin
        if (txtFromDateO.Text <> '') and (txtToDateO.Text <> '') then
          lblFromToDate.Caption := ('Œ—ÊÃ «“  «—ÌŒ: ' )+ txtFromDateO.Text + ('     «  «—ÌŒ: ' )+ txtToDateO.Text
        else if txtFromDateO.Text <> '' then
          lblFromToDate.Caption := ('Œ—ÊÃ «“  «—ÌŒ: ' )+ txtFromDateO.Text
        else if txtToDateO.Text <> '' then
          lblFromToDate.Caption := ('Œ—ÊÃ  «  «—ÌŒ: ' )+ txtToDateO.Text
        else
          lblFromToDate.Caption := '';
      end;
    end;

    if (txtFromTimeD.Text <> '') and (txtToTimeD.Text <> '') then
      lblFromToTime.Caption := ('Õ–› «“ ”«⁄ : ' )+ txtFromTimeD.Text + ('     « ”«⁄ : ' )+ txtToTimeD.Text
    else if txtFromTimeD.Text <> '' then
      lblFromToTime.Caption := ('Õ–› «“ ”«⁄ : ' )+ txtFromTimeD.Text
    else if txtToTimeD.Text <> '' then
      lblFromToTime.Caption := ('Õ–›  « ”«⁄ : ' )+ txtToTimeD.Text
    else
    begin
      if (txtFromTimeI.Text <> '') and (txtToTimeI.Text <> '') then
        lblFromToTime.Caption := ('Ê—Êœ «“ ”«⁄ : ' )+ txtFromTimeI.Text + ('     « ”«⁄ : ' )+ txtToTimeI.Text
      else if txtFromTimeI.Text <> '' then
        lblFromToTime.Caption := ('Ê—Êœ «“ ”«⁄ : ' )+ txtFromTimeI.Text
      else if txtToTimeI.Text <> '' then
        lblFromToTime.Caption := ('Ê—Êœ  « ”«⁄ : ' )+ txtToTimeI.Text
      else
      begin
        if (txtFromTimeO.Text <> '') and (txtToTimeO.Text <> '') then
          lblFromToTime.Caption := ('Œ—ÊÃ «“ ”«⁄ : ' )+ txtFromTimeO.Text + ('     « ”«⁄ : ' )+ txtToTimeO.Text
        else if txtFromTimeO.Text <> '' then
          lblFromToTime.Caption := ('Œ—ÊÃ «“ ”«⁄ : ' )+ txtFromTimeO.Text
        else if txtToTimeO.Text <> '' then
          lblFromToTime.Caption := ('Œ—ÊÃ  « ”«⁄ : ' )+ txtToTimeO.Text
        else
          lblFromToTime.Caption := '';
      end;
    end;
    
    qryDel.SQL.Clear;
    qryDel.SQL.Add(' SELECT * FROM (');
    if (rdoBoth.Checked) or (rdoArival.Checked) then
    begin
      qryDel.SQL.Add(' SELECT M_BarCode, M_DDate, M_DTime, ''Õ–› Ê—Êœ'' AS DelType, M_DUserName,');
      qryDel.SQL.Add(' M_Number, M_Serial, M_IsDeleted, M_IDate, M_ITime, M_PayAble,');
      qryDel.SQL.Add(' R_Name AS IDoor, P_Name AS IPerson, M_ODate, M_OTime, '''' AS ODoor, '''' AS OPerson');
      qryDel.SQL.Add(' FROM InputCar LEFT OUTER JOIN');
      qryDel.SQL.Add(' Persons ON M_OperatorCode = P_BarCode LEFT OUTER JOIN');
      qryDel.SQL.Add(' Readers ON M_rdrCode = R_Code');
      qryDel.SQL.Add(' WHERE (M_IsDeleted = ' + IntToStr(CNST_TRUE) + ')');
    end;
    if (rdoBoth.Checked) then
      qryDel.SQL.Add(' UNION');
    if (rdoBoth.Checked) or (rdoExit.Checked) then
    begin
      qryDel.SQL.Add(' SELECT M_BarCode, M_DDate, M_DTime, ''Õ–› Œ—ÊÃ'' AS DelType, M_DUserName,');
      qryDel.SQL.Add(' M_Number, M_Serial, M_IsDeleted, M_IDate, M_ITime, M_PayAble,');
      qryDel.SQL.Add(' '''' AS IDoor, '''' AS IPerson, M_ODate, M_OTime, R_Name AS ODoor, P_Name AS OPerson');
      qryDel.SQL.Add(' FROM Machines LEFT OUTER JOIN');
      qryDel.SQL.Add(' Persons ON M_OperatorCode = P_BarCode LEFT OUTER JOIN');
      qryDel.SQL.Add(' Readers ON M_rdrCode = R_Code');
      qryDel.SQL.Add(' WHERE (M_IsDeleted = ' + IntToStr(CNST_TRUE) + ')');
    end;
    qryDel.SQL.Add(' ) AS l1');
    qryDel.SQL.Add(' WHERE (M_IsDeleted = ' + IntToStr(CNST_TRUE) + ')');

// --AND (M_DDate >= '1388/12/19')
//kaveh880312    qryDel.SQL.Add('SELECT Deleted.*, R_Name, P_Name FROM Deleted, Readers, Persons');
//kaveh880312    qryDel.SQL.Add('WHERE D_IDoor = R_Code AND D_IPerson = P_BarCode');
    if txtFromDateD.Text <> '' then
      qryDel.SQL.Add(' AND (M_DDate >= ''' + txtFromDateD.Text + ''')');
    if txtToDateD.Text <> '' then
      qryDel.SQL.Add(' AND (M_DDate <= ''' + txtToDateD.Text + ''')');
    if txtFromTimeD.Text <> '' then
      qryDel.SQL.Add(' AND (M_DTime >= ''' + txtFromTimeD.Text + ''')');
    if txtToTimeD.Text <> '' then
      qryDel.SQL.Add(' AND (M_DTime <= ''' + txtToTimeD.Text + ''')');

    if txtFromDateI.Text <> '' then
      qryDel.SQL.Add(' AND (M_IDate >= ''' + txtFromDateI.Text + ''')');
    if txtToDateI.Text <> '' then
      qryDel.SQL.Add(' AND (M_IDate <= ''' + txtToDateI.Text + ''')');
    if txtFromTimeI.Text <> '' then
      qryDel.SQL.Add(' AND (M_ITime >= ''' + txtFromTimeI.Text + ''')');
    if txtToTimeI.Text <> '' then
      qryDel.SQL.Add(' AND (M_ITime <= ''' + txtToTimeI.Text + ''')');

    if txtFromDateO.Text <> '' then
      qryDel.SQL.Add(' AND (M_ODate >= ''' + txtFromDateO.Text + ''')');
    if txtToDateO.Text <> '' then
      qryDel.SQL.Add(' AND (M_ODate <= ''' + txtToDateO.Text + ''')');
    if txtFromTimeO.Text <> '' then
      qryDel.SQL.Add(' AND (M_OTime >= ''' + txtFromTimeO.Text + ''')');
    if txtToTimeO.Text <> '' then
      qryDel.SQL.Add(' AND (M_OTime <= ''' + txtToTimeO.Text + ''')');
      
{    if rdoArival.Checked then
      qryDel.SQL.Add(' AND D_IsPark = ' + IntToStr(CNST_TRUE))
    else if rdoExit.Checked then
      qryDel.SQL.Add(' AND D_IsPark = ' + IntToStr(CNST_FALSE));
}
//    qryDel.SQL.Add('ORDER BY D_Date, D_Time, D_UserName');
    if rdoDTDelete.Checked then
      qryDel.SQL.Add(' ORDER BY M_DDate, M_DTime, M_Number')
    else if rdoDTArival.Checked then
      qryDel.SQL.Add(' ORDER BY M_IDate, M_ITime, M_Number')
    else if rdoDTExit.Checked then
      qryDel.SQL.Add(' ORDER BY M_ODate, M_OTime, M_Number')
    else
      qryDel.SQL.Add(' ORDER BY M_DDate, M_DTime, M_Number');


    test := qryDel.SQL.Text;
    qryDel.Open;
    if qryDel.RecordCount > 0 then
    begin
      if rdoPrinter.Checked then
        qrptDel.Print
      else
        qrptdel.Preview;
    end
    else
      InformationMessage('—ﬂÊ—œ Õ–› ‘œÂù«Ì ÊÃÊœ ‰œ«—œ.');
    qryDel.Close;
    Free;
  end;
  if g_options.RdrOff_Rpt = MB_TRUE then
    UserControl := False;
end;

end.
