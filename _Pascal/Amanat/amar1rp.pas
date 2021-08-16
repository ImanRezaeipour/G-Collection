unit amar1rp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DosMove, XStringGrid, Grids,
  ExtCtrls, timetool, DBCtrls, DB, ADODB;

type
  Tfrmamar1rp = class(TForm)
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
  frmamar1rp : Tfrmamar1rp;



implementation

uses Funcs, Globals, DBS, MSGS, Keyboard, DateProc, Select, FntSel,
  rpamar1, QuickRpt;

{$R *.dfm}

procedure Tfrmamar1rp.SetWinF;
begin
end;

procedure Tfrmamar1rp.FormCreate(Sender: TObject);
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

procedure Tfrmamar1rp.cmbEmplCodeClick(Sender: TObject);
begin
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure Tfrmamar1rp.cmbEmplCodeExit(Sender: TObject);
begin
 if (cmbEmplCode.Text <> '') and (cmbEmplCode.ItemIndex = -1) then
    cmbEmplCode.ItemIndex := cmbEmplCode.Items.IndexOf(cmbEmplCode.Text);
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure Tfrmamar1rp.cmbEmplNameClick(Sender: TObject);
begin
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure Tfrmamar1rp.cmbEmplNameExit(Sender: TObject);
begin
  if (cmbEmplName.Text <> '') and (cmbEmplName.ItemIndex = -1) then
    cmbEmplName.ItemIndex := cmbEmplName.Items.IndexOf(cmbEmplName.Text);
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure Tfrmamar1rp.cmdPrintClick(Sender: TObject);
var
  s : string;
  qrptamar1: Tqrptamar1;
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

    Application.CreateForm(Tqrptamar1, qrptamar1);
    with qrptamar1 do
    begin
      SetWinF_Rpt;
      lblCoName.Caption := gOptions.CoName;
      lblname.caption:=' گزارش خرید '+cmbEmplName.Text;
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
      qry.SQL.add('select Recit1_Date as date1,Recit1_Time as time1,Recit1_TotalPrice as mablagh1,Empl_Name,Empl_Family,Empl_No');
      qry.SQL.add('from Receipt1,employee');
      qry.SQL.add('where Recit1_EmplNo=Empl_No');
      qry.SQL.add('and Recit1_TotalPrice>0');
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

//      qry.SQL.Add(' AND Recit1_Status <> 14 '); //kaveh
      qry.SQL.Add('AND (Recit1_Status <> 14 or Recit1_Status is null) '); //kaveh
      
      qry.SQL.add('order by Recit1_Date,Recit1_time,Empl_Family,Empl_Name');
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

procedure Tfrmamar1rp.rdoReportTypeClick(Sender: TObject);
begin
//  rdoGroup.Enabled := (rdoReportType.ItemIndex < 3);
end;

procedure Tfrmamar1rp.txtFDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamar1rp.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure Tfrmamar1rp.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamar1rp.txtfromtimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_time(Key);
end;

procedure Tfrmamar1rp.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

end.


