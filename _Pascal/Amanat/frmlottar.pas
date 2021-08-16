unit frmlottar;

interface

uses
  Windows, Messages, SysUtils,KEYBOARD, DateProc ,Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckLst, Mask, Grids, DBGrids, Buttons, DB ,
  ADODB, DosMove,MSGs ;

type

   TFrmlotter = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    chkListData: TCheckListBox;
    Adolottar: TADOQuery;
    Dslottar: TDataSource;
    lstlotter: TListBox;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    Label3: TLabel;
    txtfdate: TMaskEdit;
    txtldate: TMaskEdit;
    txtlprice: TMaskEdit;
    txtfpric: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DosMove1: TDosMove;
    rdsort: TRadioGroup;
    txtlot: TEdit;
    SpeedButton1: TSpeedButton;
    ListBox1: TListBox;
    Label8: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure txtlpriceKeyPress(Sender: TObject; var Key: Char);
    procedure txtfpricKeyPress(Sender: TObject; var Key: Char);
    procedure txtldateExit(Sender: TObject);
    procedure txtfdateExit(Sender: TObject);
    procedure chkListDataClickCheck(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    PROCEDURE LOTEER();

   
  private
   k:integer;
   sqltxt:string; { Private declarations }
  public
{ Public declarations }
  end;

var
  Frmlotter: TFrmlotter;



implementation
uses DBS,RpLotter,Globals ;
{$R *.dfm}

procedure TFrmlotter.BitBtn1Click(Sender: TObject);

begin
LOTEER;

end;

procedure TFrmlotter.BitBtn2Click(Sender: TObject);
var qrplotter  : TrpLotter ;
begin
LOTEER;
try
 Application.CreateForm(TrpLotter , qrplotter);
  qrplotter.qrylotter.Connection := frmDBS.adoConnect;

with  qrplotter.qrylotter    do
    begin
     close;
     sql.Add(sqltxt);
     Open;

    end;
     QRPLOTTER.lblDate.Caption := CurrentDate;
    qrplotter.SetWinF_Rpt;
   qrplotter.Preview
 finally
  FreeAndNil(qrplotter);

END;
end;

procedure TFrmlotter.BitBtn3Click(Sender: TObject);
 type
  stype= set of byte;
var a:stype;
n,i,b,c:integer;
begin
Label8.Visible:=true;
ListBox1.Visible:=true;
SpeedButton1.Visible :=true;
txtlot.Visible :=true;
LOTEER;
ListBox1.Clear;
n:=strtoint(txtlot.Text);
 a:=[];
 c:=n;
 b:=round(Random(k));
 b:=0;
 if k > n  then
  begin
 while c>0  do
 begin
  b:=round(Random(k));
 if not (b in a)  then
 begin
   a:=a + [b];
  ListBox1.Items.Add(inttostr(b));
   c:=c-1;
 end;
  end;

  end else
  begin
  ErrorMessage ('این  تعداد افراد برای قرعه کشی وجود ندارد');
  end;





 end;

PROCEDURE TFrmlotter.LOTEER ;
var selectl:string;
    i,c:integer;
    S:STRING;
begin
s:='-';
c:=lstlotter.Count;
  i:=0;
  selectl:='(Receipt1.Recit1_Rdr='+ copy(lstlotter.Items[i] , 1, pos('-', lstlotter.Items[i]  )-1);
  while i< c-1   do
  begin
    i:=i+1;
    selectl:= selectl+ ' OR Receipt1.Recit1_Rdr='+ copy(lstlotter.Items[i] , 1, pos('-', lstlotter.Items[i]  )-1) ;
  end;
  selectl:=selectl+')';
   WITH Adolottar  DO
   begin
    Close;
    sql.Clear;
    sql.Add('SELECT Receipt1.Recit1_EmplNo, Receipt1.Recit1_No, Sum(Receipt1.Recit1_TotalPrice) AS SumOfRecit1_TotalPrice, (Employee.Empl_Name+'+''''+ S +''''+'+Employee.Empl_Family) AS familyname ' +
           'FROM Employee RIGHT JOIN Receipt1 ON Employee.Empl_No = Receipt1.Recit1_EmplNo  ');
    sql.add( 'where '+ selectl );
if txtfdate.Text <> ''  then
    sql.add('and  Receipt1.Recit1_Date >= '+''''+txtfdate.Text +'''');
if txtldate.Text <> ''  then
    sql.add( ' AND Receipt1.Recit1_Date <= ' + ''''+ txtldate.Text  +'''' );

  sql.add(' GROUP BY Receipt1.Recit1_EmplNo, Receipt1.Recit1_No, Employee.Empl_Name, Employee.Empl_Family' );
if txtfpric.Text  <> ''  then
    sql.add(' HAVING Sum(Receipt1.Recit1_TotalPrice)>=' + txtfpric.Text );
if txtlprice.Text  <> '' then
   sql.add (' and Sum(Receipt1.Recit1_TotalPrice) <= '+ txtlprice.Text );
if rdsort.ItemIndex =0    then
   sql.add (' order by  (Employee.Empl_Name+Employee.Empl_Family)');
if rdsort.ItemIndex =1    then
   sql.add (' order by   Receipt1.Recit1_No');
if rdsort.ItemIndex =2    then
   sql.add (' order by   Receipt1.Recit1_EmplNo');
if rdsort.ItemIndex =3    then
   sql.add (' order by  Sum(Receipt1.Recit1_TotalPrice)');
    Open;
     Label3.Caption :=  'تعداد خرید کنندگان:'  +inttostr(Adolottar.RecordCount );
    sqltxt:= sql.Text ;
    end;
    k:=Adolottar.RecordCount;

end;



procedure TFrmlotter.SpeedButton1Click(Sender: TObject);
begin
Label8.Visible:=false;
ListBox1.Visible:=false;
SpeedButton1.Visible :=false;
end;

procedure TFrmlotter.chkListDataClickCheck(Sender: TObject);
begin
 if chkListData.Checked[chkListData.ItemIndex] then
    lstlotter.Items.Add(chkListData.Items.Strings[chkListData.ItemIndex])
  else
    lstlotter.Items.Delete(lstlotter.Items.IndexOf(chkListData.Items.Strings[chkListData.ItemIndex]));
end;

procedure TFrmlotter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Adolottar.Close;
end;

procedure TFrmlotter.FormShow(Sender: TObject);
var s:string;
begin
s:='-';
 txtFDate.Text := gOptions.fromDate;
 txtlDate.Text := gOptions.toDate;
 Adolottar.Connection:=frmDBS.adoConnect;
 Adolottar.Close;
 Adolottar.sql.Clear;
 Adolottar.SQL.Add('SELECT Rdr_Code , Rdr_Name FROM Readers');
 Adolottar.Open;
 Adolottar.First;
 while not Adolottar.Eof   do
  begin
   chkListData.Items.Add(inttostr(Adolottar.FieldByName('Rdr_Code').Asinteger)+ '--'+ Adolottar.FieldByName('Rdr_Name').AsString   );
   Adolottar.Next;
  end;
  Adolottar.Close;
  with Adolottar  do
  begin
     sql.Clear ;
     sql.Add('SELECT Receipt1.Recit1_EmplNo, Receipt1.Recit1_No, Sum(Receipt1.Recit1_TotalPrice) AS SumOfRecit1_TotalPrice, (Employee.Empl_Name+ '+''''+s+''''+
              '+Employee.Empl_Family) AS familyname ' +
              'FROM Employee RIGHT JOIN Receipt1 ON Employee.Empl_No = Receipt1.Recit1_EmplNo ' +
             'GROUP BY Receipt1.Recit1_EmplNo, Receipt1.Recit1_No, Employee.Empl_Name, Employee.Empl_Family');

     Open;
    sqltxt:= sql.Text;
  end;

      Label3.Caption :=  'تعداد خرید کنندگان:'  +inttostr(Adolottar.RecordCount );
end;

procedure TFrmlotter.txtfdateExit(Sender: TObject);
begin
   if txtfdate.Text <> '' then
      begin
    txtfdate.Text := BeautifulDate(txtfdate.Text);
      end;
end;

procedure TFrmlotter.txtfpricKeyPress(Sender: TObject; var Key: Char);
begin
Keyboard_Number(Key,txtfpric.Text);
end;

procedure TFrmlotter.txtldateExit(Sender: TObject);
begin
   if txtldate.Text <> '' then
      begin
    txtldate.Text := BeautifulDate(txtldate.Text);
      end;
end;

procedure TFrmlotter.txtlpriceKeyPress(Sender: TObject; var Key: Char);
begin
Keyboard_Number(Key,txtlprice.Text);
end;

end.
