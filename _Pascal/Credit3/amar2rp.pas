unit amar2rp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DosMove, XStringGrid, Grids,
  ExtCtrls, timetool, DBCtrls;

type
  Tfrmamar2rp = class(TForm)
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    DosMove1: TDosMove;
    lbl1: TLabel;
    txtFromDate: TEdit;
    lbl2: TLabel;
    txtToDate: TEdit;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    chkSign: TCheckBox;
    txtfromtime: TEdit;
    Label1: TLabel;
    txttotime: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    cmbEmplCode: TComboBox;
    cmbEmplName: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure rdoReportTypeClick(Sender: TObject);
    procedure txtFDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateExit(Sender: TObject);
    procedure txtfromtimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbEmplCodeClick(Sender: TObject);
    procedure cmbEmplNameClick(Sender: TObject);
    procedure cmbEmplCodeExit(Sender: TObject);
    procedure cmbEmplNameExit(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


var
  frmamar2rp : Tfrmamar2rp;



implementation

uses Funcs, Globals, DBS, MSGS, Keyboard, DateProc, Select, FntSel,
  rpamar2, QuickRpt;

{$R *.dfm}

procedure Tfrmamar2rp.SetWinF;
begin
end;

procedure Tfrmamar2rp.FormCreate(Sender: TObject);
begin
  SetWinF;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Empl_Department = ' + IntToStr(gOptions.UserDepart));
    SQL.Add('ORDER BY Empl_Family, Empl_Name, Empl_No');
    Open;
    while not Eof do
    begin
      cmbEmplCode.Items.Add(FieldByName('Empl_No').AsString);
      cmbEmplName.Items.Add(FieldByName('Empl_Family').AsString + '-' +
                            FieldByName('Empl_Name').AsString);
      Next;
    end;

    Close;
  end;
end;

procedure Tfrmamar2rp.cmbEmplCodeClick(Sender: TObject);
begin
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure Tfrmamar2rp.cmbEmplCodeExit(Sender: TObject);
begin
 if (cmbEmplCode.Text <> '') and (cmbEmplCode.ItemIndex = -1) then
    cmbEmplCode.ItemIndex := cmbEmplCode.Items.IndexOf(cmbEmplCode.Text);
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure Tfrmamar2rp.cmbEmplNameClick(Sender: TObject);
begin
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure Tfrmamar2rp.cmbEmplNameExit(Sender: TObject);
begin
  if (cmbEmplName.Text <> '') and (cmbEmplName.ItemIndex = -1) then
    cmbEmplName.ItemIndex := cmbEmplName.Items.IndexOf(cmbEmplName.Text);
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure Tfrmamar2rp.cmdPrintClick(Sender: TObject);
var
  s : string;
  qrptamar2: Tqrptamar2;
begin
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
    gOptions.fromDate := txtFromDate.Text;
    gOptions.toDate := txtToDate.Text;

    Application.CreateForm(Tqrptamar2, qrptamar2);
    with qrptamar2 do
    begin
      SetWinF_Rpt;
      lblCoName.Caption := gOptions.CoName;
      lblname.caption:=' گزارش استفاده '+cmbEmplName.Text;
      if gOptions.Shobeh <> '' then
        lblCoName.Caption := lblCoName.Caption + '-' + gOptions.Shobeh;
      lblDate.Caption := CurrentDate;
      bndSign.Enabled := chkSign.Checked;
      lblrepdate.Caption:='';
      if txtFromDate.Text<>''
      then lblrepdate.Caption:=lblrepdate.Caption+'از تاریخ '+txtFromDate.Text;
      if txtToDate.Text<>''
      then lblrepdate.Caption:=lblrepdate.Caption+' تا تاریخ '+txtToDate.Text;
      lblreptime.Caption:='';
      if txtFromDate.Text<>''
      then lblreptime.Caption:=lblreptime.Caption+'از ساعت '+txtFromtime.Text;
      if txtToDate.Text<>''
      then lblreptime.Caption:=lblreptime.Caption+' تا ساعت '+txtTotime.Text;
      qry.Connection := frmDBS.adoConnect;
      qry.SQL.Clear;
      qry.SQL.add('select *');
      qry.SQL.add('from Receipt1,services,employee');
      qry.SQL.add('where s_code=Recit1_Service');
      qry.SQL.add('and Recit1_EmplNo =empl_no');
      if txtFromDate.Text<>''
      then qry.SQL.add('and Recit1_Date>='''+txtFromDate.Text+'''');
      if txtToDate.Text<>''
      then qry.SQL.add('and Recit1_Date<='''+txtToDate.Text+'''');
      if txtFromTime.Text<>''
      then qry.SQL.add('and Recit1_Time<='+inttostr(timetoint(txtFromTime.Text)));
      if txtToTime.Text<>''
      then qry.SQL.add('and Recit1_Time<='+inttostr(timetoint(txtToTime.Text)));

      if cmbEmplCode.Text <> '' then
        qry.SQL.Add('AND Recit1_EmplNo = ''' + cmbEmplCode.Text + '''');

      qry.open;
      begin
          if rdoScreen.Checked
          then Preview
          else Print;
      end;
      Free;
    end;
  end;
end;

procedure Tfrmamar2rp.rdoReportTypeClick(Sender: TObject);
begin
//  rdoGroup.Enabled := (rdoReportType.ItemIndex < 3);
end;

procedure Tfrmamar2rp.txtFDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamar2rp.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure Tfrmamar2rp.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamar2rp.txtfromtimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_time(Key);
end;

procedure Tfrmamar2rp.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

end.


