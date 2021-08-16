unit amar4rp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DosMove, XStringGrid, Grids,
  ExtCtrls, timetool, DBCtrls, DB, ADODB, CheckCombo;

type
  Tfrmamar4rp = class(TForm)
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
    Label3: TLabel;
    cmbEmplCode: TComboBox;
    cmbEmplName: TComboBox;
    qry1: TADOQuery;
    tbl1: TADOTable;
    rdoSort: TRadioGroup;
    rdokind: TRadioGroup;
    lbl4: TLabel;
    cmbcoposts: TCheckedComboBox;
    txttedad: TEdit;
    Label1: TLabel;
    cbdontshowkharid: TCheckBox;
    cbdontshowcharge: TCheckBox;
    cbdontshowkharidcharge: TCheckBox;
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
    procedure txttedadKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


var
  frmamar4rp : Tfrmamar4rp;



implementation

uses Funcs, Globals, DBS, MSGS, Keyboard, DateProc, Select, FntSel,
  rpamar4, rpamar44, QuickRpt;

{$R *.dfm}

procedure Tfrmamar4rp.SetWinF;
begin
end;

procedure Tfrmamar4rp.FormCreate(Sender: TObject);
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

    SQL.Clear;
    SQL.Add('SELECT * FROM CoPosts');
    Open;
    while not EOF do
    begin
      cmbCoPosts.Items.Add(FieldByName('CoPost_Code').AsString + '-' + FieldByName('CoPost_Name').AsString);
      Next;
    end;
    Close;

  end;
end;

procedure Tfrmamar4rp.cmbEmplCodeClick(Sender: TObject);
begin
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure Tfrmamar4rp.cmbEmplCodeExit(Sender: TObject);
begin
 if (cmbEmplCode.Text <> '') and (cmbEmplCode.ItemIndex = -1) then
    cmbEmplCode.ItemIndex := cmbEmplCode.Items.IndexOf(cmbEmplCode.Text);
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure Tfrmamar4rp.cmbEmplNameClick(Sender: TObject);
begin
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure Tfrmamar4rp.cmbEmplNameExit(Sender: TObject);
begin
  if (cmbEmplName.Text <> '') and (cmbEmplName.ItemIndex = -1) then
    cmbEmplName.ItemIndex := cmbEmplName.Items.IndexOf(cmbEmplName.Text);
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure Tfrmamar4rp.cmdPrintClick(Sender: TObject);
var
  s : string;
  qrptamar4: Tqrptamar4;
  qrptamar44: Tqrptamar44;
  i : Integer;
  st,stname,st1,stcopost: string;
  count: integer;
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

    count:=0;
    st1:='';
    stcopost:='';
    for i:=0 to cmbcoposts.Items.Count-1 do
    if cmbcoposts.Checked[i]
    then begin
         inc(count);
         st:=copy(cmbcoposts.Items[i],1,Pos('-', cmbcoposts.Items[i])-1);
         stname:=copy(cmbcoposts.Items[i],Pos('-', cmbcoposts.Items[i])+1,50);
         if count =1
         then begin
              st1:=st;
              stcopost:=stname;
         end
         else begin
              st1:=st1+','+st;
              stcopost:=stcopost+','+stname;
         end;
    end;
    if count>0
      then st:='AND Empl_CoPost in (' + st1+')'
      else st:='';

    case rdokind.ItemIndex of
      0:begin
          Application.CreateForm(Tqrptamar4, qrptamar4);
          with qrptamar4 do
          begin
            SetWinF_Rpt;
            date1:=txtFromDate.Text;
            date2:=txtToDate.Text;
            if txttedad.Text=''
            then begin
                 tghest:=0;
                 lbltghest.Caption:='';
            end
            else begin
                 tghest:=strtoint(txttedad.Text);
                 lbltghest.Caption:=' تعداد قسط '+txttedad.Text;
            end;
            dontshowkharid:=cbdontshowkharid.Checked;
            dontshowcharge:=cbdontshowcharge.Checked;
            dontshowkharidcharge:=cbdontshowkharidcharge.Checked;
            cardno1:=cmbEmplCode.Text ;
            lblCoName.Caption := gOptions.CoName;
            lblname.caption:=' گزارش کلی اعتبار و استفاده '+cmbEmplName.Text;
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

            qry.Connection := frmDBS.adoConnect;
            qry.SQL.Clear;
            qry.SQL.add('select * from employee');
            qry.SQL.add('where 1 = 1 ');
            if cardno1 <>''
            then qry.SQL.add('and empl_No='''+cardno1+'''');

            qry.SQL.Add(st);

            case rdoSort.ItemIndex of
              0: qry.SQL.add('order by empl_No');
              1: qry.SQL.add('order by empl_family,empl_name');
            end;

            qry.open;
            begin
                if rdoScreen.Checked
                then Preview
                else Print;
            end;
            Free;
          end;
        end;
      1:begin
          Application.CreateForm(Tqrptamar44, qrptamar44);
          with qrptamar44 do
          begin
            SetWinF_Rpt;
            date1:=txtFromDate.Text;
            date2:=txtToDate.Text;
            cardno1:=cmbEmplCode.Text ;
            stcoposts :=st;
            lblCoName.Caption := gOptions.CoName;
            lblname.caption:=' گزارش مجموع اعتبار و استفاده '+cmbEmplName.Text;
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
            {
            qry.Connection := frmDBS.adoConnect;
            qry.SQL.Clear;
            qry.SQL.add('select * from employee');

            qry.open;
            }
            begin
                if rdoScreen.Checked
                then Preview
                else Print;
            end;
            Free;
          end;
        end;
    end;
  end;
end;

procedure Tfrmamar4rp.rdoReportTypeClick(Sender: TObject);
begin
//  rdoGroup.Enabled := (rdoReportType.ItemIndex < 3);
end;

procedure Tfrmamar4rp.txtFDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamar4rp.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure Tfrmamar4rp.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamar4rp.txtfromtimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_time(Key);
end;

procedure Tfrmamar4rp.txttedadKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure Tfrmamar4rp.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

end.


