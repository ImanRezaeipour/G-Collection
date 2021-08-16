unit amarrp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DosMove, XStringGrid, Grids,
  ExtCtrls, timetool;

type
  Tfrmamarrp = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure rdoReportTypeClick(Sender: TObject);
    procedure txtFDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateExit(Sender: TObject);
    procedure txtfromtimeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


var
  frmamarrp : Tfrmamarrp;



implementation

uses Funcs, Globals, DBS, MSGS, Keyboard, DateProc, Select, FntSel,
  rpamar, QuickRpt;

{$R *.dfm}

procedure Tfrmamarrp.SetWinF;
begin
end;

procedure Tfrmamarrp.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

procedure Tfrmamarrp.cmdPrintClick(Sender: TObject);
var
  s : string;
  qrptamar: Tqrptamar;
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

    Application.CreateForm(Tqrptamar, qrptamar);
    with qrptamar do
    begin
      SetWinF_Rpt;
      lblCoName.Caption := gOptions.CoName;
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
//      qry.SQL.add('select s_name ,count(Recit1_Service) as tedad');
      qry.SQL.add('select count(Recit1_Service) as tedad ,services.s_name');
      qry.SQL.add('from Receipt1,services');
      qry.SQL.add('where s_code=Recit1_Service');
      if txtFromDate.Text<>''
      then qry.SQL.add('and Recit1_Date>='''+txtFromDate.Text+'''');
      if txtToDate.Text<>''
      then qry.SQL.add('and Recit1_Date<='''+txtToDate.Text+'''');
      if txtFromTime.Text<>''
      then qry.SQL.add('and Recit1_Time<='+inttostr(timetoint(txtFromTime.Text)));
      if txtToTime.Text<>''
      then qry.SQL.add('and Recit1_Time<='+inttostr(timetoint(txtToTime.Text)));
      qry.SQL.add('group by s_name');
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

procedure Tfrmamarrp.rdoReportTypeClick(Sender: TObject);
begin
//  rdoGroup.Enabled := (rdoReportType.ItemIndex < 3);
end;

procedure Tfrmamarrp.txtFDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamarrp.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure Tfrmamarrp.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmamarrp.txtfromtimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_time(Key);
end;

procedure Tfrmamarrp.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

end.


