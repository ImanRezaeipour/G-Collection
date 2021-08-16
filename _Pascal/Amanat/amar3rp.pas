unit amar3rp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DosMove, XStringGrid, Grids,
  ExtCtrls, timetool, DBCtrls, DB, ADODB;

type
  Tfrmamar3rp = class(TForm)
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
    qry1: TADOQuery;
    tbl1: TADOTable;
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
  frmamar3rp : Tfrmamar3rp;



implementation

uses Funcs, Globals, DBS, MSGS, Keyboard, DateProc, Select, FntSel,
  rpamar3, QuickRpt;

{$R *.dfm}

procedure Tfrmamar3rp.SetWinF;
begin
end;

procedure Tfrmamar3rp.FormCreate(Sender: TObject);
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

procedure Tfrmamar3rp.cmbEmplCodeClick(Sender: TObject);
begin
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure Tfrmamar3rp.cmbEmplCodeExit(Sender: TObject);
begin
 if (cmbEmplCode.Text <> '') and (cmbEmplCode.ItemIndex = -1) then
    cmbEmplCode.ItemIndex := cmbEmplCode.Items.IndexOf(cmbEmplCode.Text);
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure Tfrmamar3rp.cmbEmplNameClick(Sender: TObject);
begin
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure Tfrmamar3rp.cmbEmplNameExit(Sender: TObject);
begin
  if (cmbEmplName.Text <> '') and (cmbEmplName.ItemIndex = -1) then
    cmbEmplName.ItemIndex := cmbEmplName.Items.IndexOf(cmbEmplName.Text);
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure Tfrmamar3rp.cmdPrintClick(Sender: TObject);
var
  s : string;
  qrptamar3: Tqrptamar3;
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

    Application.CreateForm(Tqrptamar3, qrptamar3);
    with qrptamar3 do
    begin
      SetWinF_Rpt;
      date1:=txtFromDate.Text;
      cardno1:=cmbEmplCode.Text ;
      lblCoName.Caption := gOptions.CoName;
      lblname.caption:=' گزارش اعتبار و استفاده '+cmbEmplName.Text;
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
      CreateTable('Amar3Tbl');

      tbl1.Connection := frmDBS.adoConnect;
      tbl1.open;
      qry1.Connection := frmDBS.adoConnect;
      qry1.SQL.Clear;
      qry1.SQL.add('select DtlEmplNo as pno1 , grpdate as date1,grptime as time1,GrpPrice as mablagh1, 1 as code1');
      qry1.SQL.add('from ChargeGrp,ChargeDtl');
      qry1.SQL.add('where GrpCode=DtlCode');
      if txtFromDate.Text<>''
      then qry1.SQL.add('and GrpDate>='''+txtFromDate.Text+'''');
      if txtToDate.Text<>''
      then qry1.SQL.add('and GrpDate<='''+txtToDate.Text+'''');
      if txtFromTime.Text<>''
      then qry1.SQL.add('and GrpTime<='+inttostr(timetoint(txtFromTime.Text)));
      if txtToTime.Text<>''
      then qry1.SQL.add('and GrpTime<='+inttostr(timetoint(txtToTime.Text)));
      if cmbEmplCode.Text <> '' then
        qry1.SQL.Add('AND DtlEmplNo = ''' + cmbEmplCode.Text + '''');
      qry1.close;
      qry1.open;
      while not qry1.Eof do
      begin
        tbl1.Append;
        tbl1.FieldByName('pno1').asstring:=qry1.FieldByName('pno1').asstring;
        tbl1.FieldByName('date1').asstring:=qry1.FieldByName('date1').asstring;
        tbl1.FieldByName('time1').asinteger:=qry1.FieldByName('time1').asinteger;
        tbl1.FieldByName('code1').asinteger:=qry1.FieldByName('code1').asinteger;
        tbl1.FieldByName('mablagh1').AsCurrency:=qry1.FieldByName('mablagh1').AsCurrency;
        tbl1.Post;
        qry1.Next;
      end;
      qry1.Close;

      qry1.SQL.Clear;
//kaveh      qry1.SQL.add('select Recit1_EmplNo as pno1 , Recit1_Date as date1,Recit1_Time as time1,Recit1_TotalPrice as mablagh1, 2 as code1');
//      qry1.SQL.add('select Recit1_EmplNo as pno1 , Recit1_Date as date1,Recit1_Time as time1,Recit1_TotalPrice as mablagh1, (case when Recit1_Status <> 14 then 2 else 3 end) as Code1'); //kaveh
      qry1.SQL.add('select Recit1_EmplNo as pno1 , Recit1_Date as date1,Recit1_Time as time1,Recit1_TotalPrice as mablagh1, (case when (Recit1_Status <> 14 or Recit1_Status is null) then 2 else 3 end) as Code1'); //kaveh
      qry1.SQL.add('from Receipt1');
      qry1.SQL.add('where 1=1');
      if txtFromDate.Text<>''
      then qry1.SQL.add('and Recit1_Date>='''+txtFromDate.Text+'''');
      if txtToDate.Text<>''
      then qry1.SQL.add('and Recit1_Date<='''+txtToDate.Text+'''');
      if txtFromTime.Text<>''
      then qry1.SQL.add('and Recit1_Time<='+inttostr(timetoint(txtFromTime.Text)));
      if txtToTime.Text<>''
      then qry1.SQL.add('and Recit1_Time<='+inttostr(timetoint(txtToTime.Text)));
      if cmbEmplCode.Text <> '' then
        qry1.SQL.Add('AND Recit1_EmplNo = ''' + cmbEmplCode.Text + '''');
      qry1.open;
      while not qry1.Eof do
      begin
        tbl1.Append;
        tbl1.FieldByName('pno1').asstring:=qry1.FieldByName('pno1').asstring;
        tbl1.FieldByName('date1').asstring:=qry1.FieldByName('date1').asstring;
        tbl1.FieldByName('time1').asinteger:=qry1.FieldByName('time1').asinteger;
        tbl1.FieldByName('code1').asinteger:=qry1.FieldByName('code1').asinteger;
        tbl1.FieldByName('mablagh1').AsCurrency:=qry1.FieldByName('mablagh1').AsCurrency;
        tbl1.Post;
        qry1.Next;
      end;
      qry1.Close;
      tbl1.Close;

      qry.Connection := frmDBS.adoConnect;
      qry.SQL.Clear;
      qry.SQL.add('select * from Amar3Tbl,Employee');
      qry.SQL.add('where pno1=Empl_No');
      qry.SQL.add('order by date1,time1');

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

procedure Tfrmamar3rp.rdoReportTypeClick(Sender: TObject);
begin
//  rdoGroup.Enabled := (rdoReportType.ItemIndex < 3);
end;

procedure Tfrmamar3rp.txtFDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamar3rp.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure Tfrmamar3rp.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamar3rp.txtfromtimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_time(Key);
end;

procedure Tfrmamar3rp.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

end.


