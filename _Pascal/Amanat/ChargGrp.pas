unit ChargGrp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls,xpman, Mask, ComCtrls,
  DB, ADODB, DosMove;

type
  TfrmchargGrp = class(TForm)
    pan_insert: TPanel;
    Pan_dbg: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    txt_Code: TLabeledEdit;
    txt_tarikhsh: TMaskEdit;
    txt_Price: TLabeledEdit;
    lbl_tarikh: TLabel;
    txt_Desc: TMemo;
    Label1: TLabel;
    atblchargGrp: TADOQuery;
    DschargGrp: TDataSource;
    txt_tarikhex: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    atblchargGrpGrpCode: TIntegerField;
    atblchargGrpGrpTime: TWideStringField;
    atblchargGrpGrpExpireDate: TWideStringField;
    atblchargGrpGrpDate: TWideStringField;
    atblchargGrpGrpPrice: TBCDField;
    atblchargGrpGrpDesc: TWideStringField;
    pan_save: TPanel;
    btn_cancel: TBitBtn;
    BitBtn6: TBitBtn;
    DosMove1: TDosMove;
    txt_Time: TEdit;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    atblchargGrptimestr: TStringField;
    DataSource2: TDataSource;
    Dsmaxdate: TDataSource;
    ADOQuery2: TADOQuery;
    qrymaxdate: TADOQuery;
    d: TDBGrid;
    pan_con: TPanel;
    btnnewd: TBitBtn;
    btn_edit: TBitBtn;
    btn_del: TBitBtn;
    btn_newp: TBitBtn;
    btn_viewp: TBitBtn;
    procedure atblchargGrpCalcFields(DataSet: TDataSet);
    procedure txt_PriceKeyPress(Sender: TObject; var Key: Char);
    procedure txt_tarikhshKeyPress(Sender: TObject; var Key: Char);
    procedure txt_timeKeyPress(Sender: TObject; var Key: Char);
    procedure txt_timeExit(Sender: TObject);
    procedure txt_tarikhexExit(Sender: TObject);
    procedure txt_tarikhshExit(Sender: TObject);
    procedure dDblClick(Sender: TObject);
    procedure btn_viewpClick(Sender: TObject);
    procedure btn_newpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btnnewdClick(Sender: TObject);
  

  private
    { Private declarations }
      procedure checkpan(fl:integer);

  public
    editMode : boolean;
    { Public declarations }

  end;

var
  frmchargGrp: TfrmchargGrp;


implementation

uses DBS, ADODB_TLB, ADOX_TLB, Code_Sys, ComTools, DateProc, DprtActv, Farsiapi,
  FntSel, Funcs, Keyboard, Login, Msgs, Online, RunCmnds, Select, SelPath,
  TimeTool,charge, WinSetup, Z80_CMD, Z84_cmd,editchrg ;


{$R *.dfm}

procedure TfrmchargGrp.BitBtn6Click(Sender: TObject);
var i:integer;
max_tarikhsh:string;
begin
{//kaveh 900901
  qrymaxdate.Open;
  max_tarikhsh  :=qrymaxdate.FieldByName('MaxOfGrpDATE').AsString ;
  qrymaxdate.CLOSE;
}//kaveh 900901
  if editMode then
  begin
    atblchargGrp.FieldByName('GrpDesc').AsString := txt_Desc.Text;
    atblchargGrp.Post;
    frmchargGrp.Width:=676;
    frmchargGrp.Height:=307;
    i:=5;
    checkpan(i);
    pan_insert.Visible := false;
    frmchargGrp.Position :=poScreenCenter;
  end
  else
{//kaveh 900901
  if (max_tarikhsh >= txt_tarikhsh.text) then
  begin
    InformationMessage('تاریخ شارژ از آخرین تاریخ شارژ کوچکتر است');
    txt_tarikhsh.SetFocus;
  end else
}//kaveh 900901
  begin
    frmchargGrp.Width:=676;
    i:=4;
    checkpan(i);
    frmchargGrp.Position :=poScreenCenter;
  end;
end;

procedure TfrmchargGrp.btnnewdClick(Sender: TObject);
var i:integer;
begin
  editMode := false;
  frmchargGrp.Width:=676;
  frmchargGrp.Height:=527;
  i:=1;
  checkpan(i);
  frmchargGrp.Position :=poScreenCenter;
end;

procedure TfrmchargGrp.btn_cancelClick(Sender: TObject);
var i:integer;
begin

frmchargGrp.Width:=676;
frmchargGrp.Height:=307;

  i:=5;
checkpan(i);
pan_insert.Visible := false;
frmchargGrp.Position :=poScreenCenter;
end;

procedure TfrmchargGrp.btn_delClick(Sender: TObject);
var i:integer;
code_dtl:string;

begin
frmchargGrp.Position :=poScreenCenter;
frmchargGrp.Width:=676;
frmchargGrp.Height:=307;
i:=3;
checkpan(i);

    if (atblchargGrp.RecordCount > 0) and

      ConfirmMessage('آيا براي حذف اطمينان داريد؟') then
      begin
   code_dtl := inttostr( atblchargGrp.FieldByName('GrpCode').AsInteger);
  atblchargGrp.Delete;
  ADOQuery1.SQL.Clear;
  ADOQuery1.Close;
  ADOQuery1.SQL.Add(' delete from ChargeDtl where DtlCode = ' + code_dtl  );
  ADOQuery1.ExecSQL ;
    end;
     end;



procedure TfrmchargGrp.btn_editClick(Sender: TObject);
var i:integer;
begin
editMode := True;
frmchargGrp.Width:=676;
frmchargGrp.Height:=527;
i:=2;
checkpan(i);
frmchargGrp.Position :=poScreenCenter;
end;

procedure TfrmchargGrp.btn_newpClick(Sender: TObject);

begin
   frmchargGrp.Width:=676;
   txt_Code.Text := inttostr( atblchargGrp.FieldByName('GrpCode').AsInteger);
    txt_tarikhsh.Text := atblchargGrp.FieldByName('GrpDate').AsString;
    txt_Price.Text :=  inttostr(atblchargGrp.FieldByName('GrpPrice').AsInteger);
    txt_Desc.Text :=  atblchargGrp.FieldByName('GrpDesc').AsString ;
    txt_tarikhex.Text := atblchargGrp.FieldByName('GrpExpireDate').AsString;
    txt_time.Text :=atblchargGrp.FieldByName('GrpTime').Asstring ;

  Application.CreateForm(TfrmCharge,frmcharge);

  frmCharge.Label2.Caption :=txt_Code.Text ;
  frmCharge.txtDate.text :=txt_tarikhsh.Text ;
  frmCharge.txtTime.text := inttotime(strtoint(txt_time.Text)) ;
  frmCharge.txtCharge.text :=txt_Price.Text;
  frmcharge.ShowModal;
  frmcharge.Free;
end;

procedure TfrmchargGrp.btn_viewpClick(Sender: TObject);
begin

 txt_Code.Text := inttostr( atblchargGrp.FieldByName('GrpCode').AsInteger);
  Application.CreateForm(TfrmEditCharge,frmEditCharge );

 with frmEditCharge  do
   begin
     ADOQuery3.sql.Clear ;
  ADOQuery3.close;
  ADOQuery3.SQL.Add('SELECT * FROM ChargeGrp order by GrpCode ');
  ADOQuery3.Open;
  ADOQuery3.First;
  while not ADOQuery3.Eof   do
  begin
  ComboBox1.Items.Add (inttostr(ADOQuery3.FieldByName('GrpCode').AsInteger));

    ADOQuery3.Next;
 end;
    ADOQuery2.SQL.Clear;
    ADOQuery2.Close;
    ADOQuery2.sql.Add('select * from Employee where Empl_Active = ' + IntToStr(MB_TRUE));
    ADOQuery2.Open;

{    cmbCode.Clear ;
    cmbName.Clear ;
    ADOQuery2.First;
   while not ADOQuery2.Eof   do
    begin
      cmbCode.Items.Add(ADOQuery2.FieldByName('Empl_No').AsString);
      cmbName.items.add (ADOQuery2.FieldByName('Empl_Family').AsString + '-' +  ADOQuery2. FieldByName('Empl_Name').AsString) ;
      ADOQuery2.Next;
     end;
          }
    end;
    frmEditCharge.ComboBox1.Text :=txt_Code.Text ;
    frmEditCharge.Edit1.Text   :=txt_Code.Text ;

  frmEditCharge.ShowModal;
  frmEditCharge.Free;
end;

procedure TfrmchargGrp.checkpan(fl:integer);
var i:integer;
begin
  i:=fl;
  case i of
    1:
    begin
      txt_Time.ReadOnly:=false;
      txt_tarikhsh.ReadOnly :=false;
      txt_Price.ReadOnly:=false;
      pan_insert.Visible := true;
      pan_con.Enabled :=false;
      pan_insert.Enabled :=true ;
      pan_save.Enabled  :=true ;
      txt_Code.Clear;
      txt_Price.Clear;
      txt_tarikhex.Clear;
      txt_tarikhsh.Clear;
      txt_time.Clear;
      txt_Desc.Clear;

      Pan_dbg.Enabled :=FALSE;
      atblchargGrp.Append ;
      txt_Code.Text := IntToStr(GetNewNumber('ChargeGrp', 'GrpCode'));
      txt_tarikhsh.Text :=CurrentDate;
      txt_Time.Text :=CurrentTime;
      txt_Price.SetFocus;
    end;
    2:
    begin
      pan_insert.Visible := true;
      pan_con.Enabled :=false;
      pan_insert.Enabled :=true ;
      pan_save.Enabled  :=true ;
      Pan_dbg.Enabled :=FALSE;
      txt_Time.ReadOnly:=true;
      txt_tarikhsh.ReadOnly :=true;
      txt_Price.ReadOnly:=true;

      atblchargGrp.Edit ;
      txt_Code.Text := inttostr( atblchargGrp.FieldByName('GrpCode').AsInteger);
      txt_tarikhsh.Text := atblchargGrp.FieldByName('GrpDate').AsString;
      txt_Price.Text :=  inttostr(atblchargGrp.FieldByName('GrpPrice').AsInteger);
      txt_Desc.Text :=  atblchargGrp.FieldByName('GrpDesc').AsString ;
      txt_tarikhex.Text := atblchargGrp.FieldByName('GrpExpireDate').AsString;
      txt_time.Text :=inttotime( strtoint(atblchargGrp.FieldByName('GrpTime').Asstring)) ;
    end;
    3:
    begin
      pan_con.Enabled :=true;
      pan_insert.Enabled :=false ;
      pan_save.Enabled  :=false ;
      Pan_dbg.Enabled :=TRUE;
    end;
    4:
    begin
      if txt_tarikhsh.Text  = '' then
      begin
        ErrorMessage('تاريخ شارژ مشخص نشده است');
        txt_tarikhsh.SetFocus;
      end else
      begin
        if txt_time.Text  = ''  then
        begin
          ErrorMessage('زمان مشخص نشده است.');
          txt_Time.SetFocus;
        end else
        begin
          frmchargGrp.Height:=307;
          pan_con.Enabled :=true;
          pan_insert.Enabled :=false ;
          pan_save.Enabled  :=false ;
          Pan_dbg.Enabled :=TRUE;
          pan_insert.Visible := false;

          atblchargGrp.FieldByName('GrpCode').AsInteger  := strtoint(txt_Code.Text );
          atblchargGrp.FieldByName('GrpTime').Asstring :=inttostr(timetoint(txt_time.Text ));
          atblchargGrp.FieldByName('GrpExpireDate').AsString  :=txt_tarikhex.text;
          if txt_Price.Text  <> ''  then
          BEGIN
            atblchargGrp.FieldByName('GrpPrice').AsInteger :=strtoint(txt_Price.text);
          END ELSE
          BEGIN
            atblchargGrp.FieldByName('GrpPrice').AsInteger :=0;
          end;
          atblchargGrp.FieldByName('GrpDesc').AsString  :=txt_Desc.text ;
          atblchargGrp.FieldByName('GrpDate').AsString  :=txt_tarikhsh.Text;
          atblchargGrp.Post ;
        end;
      END;
    end  ELSE
    BEGIN
      pan_con.Enabled :=true;
      pan_insert.Enabled :=false ;
      pan_save.Enabled  :=false ;
      Pan_dbg.Enabled :=TRUE;
      atblchargGrp.Cancel;
      txt_Code.Clear ;
    END;
  end;
end;


procedure TfrmchargGrp.dDblClick(Sender: TObject);
begin
    txt_Code.Text := inttostr( atblchargGrp.FieldByName('GrpCode').AsInteger);


  Application.CreateForm(TfrmEditCharge,frmEditCharge );
  with frmEditCharge  do
   begin
     ADOQuery3.sql.Clear ;
  ADOQuery3.close;
  ADOQuery3.SQL.Add('SELECT * FROM ChargeGrp ');
  ADOQuery3.Open;
  ADOQuery3.First;
  while not ADOQuery3.Eof   do
  begin
  ComboBox1.Items.Add (inttostr(ADOQuery3.FieldByName('GrpCode').AsInteger));

    ADOQuery3.Next;
end;
 ADOQuery2.SQL.Clear;
    ADOQuery2.Close;
    ADOQuery2.sql.Add('select * from Employee where Empl_Active = ' + IntToStr(MB_TRUE));
    ADOQuery2.Open;

{    cmbCode.Clear ;
    cmbName.Clear ;
    ADOQuery2.First;
   while not ADOQuery2.Eof   do
    begin
      cmbCode.Items.Add(ADOQuery2.FieldByName('Empl_No').AsString);
      cmbName.items.add (ADOQuery2.FieldByName('Empl_Family').AsString + '-' +  ADOQuery2. FieldByName('Empl_Name').AsString) ;
      ADOQuery2.Next;
     end;}
    frmEditCharge.ComboBox1.Text :=txt_Code.Text ;
  frmEditCharge.Edit1.Text   :=txt_Code.Text ;
  frmEditCharge.ShowModal;
  frmEditCharge.Free;

end;

  end;


procedure TfrmchargGrp.FormCreate(Sender: TObject);
begin
 SetFontColor(TForm(frmchargGrp ));
atblchargGrp.Connection:=frmDBS.adoConnect ;
ADOQuery1.Connection:=frmDBS.adoConnect ;
qrymaxdate.Connection:=frmDBS.adoConnect ;
frmchargGrp.Height:=307;
 with atblchargGrp do
  begin
    SQL.Clear;
    close;
    SQL.Add('SELECT * FROM ChargeGrp order by GrpCode');
   Open ;
end;
end;

procedure TfrmchargGrp.txt_PriceKeyPress(Sender: TObject; var Key: Char);
begin
Keyboard_Integer(Key);

end;

procedure TfrmchargGrp.txt_tarikhexExit(Sender: TObject);
begin
      if txt_tarikhex.Text <> '' then
          begin
    txt_tarikhex.Text := BeautifulDate(txt_tarikhex.Text);
          end;
end;

procedure TfrmchargGrp.txt_tarikhshExit(Sender: TObject);
begin
     if txt_tarikhsh.Text <> '' then
      begin
    txt_tarikhsh.Text := BeautifulDate(txt_tarikhsh.Text);
      end;
end;

procedure TfrmchargGrp.txt_tarikhshKeyPress(Sender: TObject; var Key: Char);
begin
Keyboard_Date(key)
end;

procedure TfrmchargGrp.txt_timeExit(Sender: TObject);
begin
     if txt_time.Text <> '' then
    txt_time.Text :=  BeautifulTime(txt_time.Text);


end;

procedure TfrmchargGrp.txt_timeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmchargGrp.atblchargGrpCalcFields(DataSet: TDataSet);
begin

  if DataSet.FieldByName('GrpTime').AsString <> '' then
     DataSet.FieldByName('timestr').AsString  :=inttotime(strtoint(DataSet.FieldByName('GrpTime').AsString ));

end;

end.
