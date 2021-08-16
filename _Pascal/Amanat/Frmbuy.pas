unit Frmbuy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, CheckLst, ExtCtrls, Mask, Buttons, Grids,
  DBGrids,dateproc,msgs;

type
  TfrmbuyRp = class(TForm)
    Panel1: TPanel;
    lstlotter: TListBox;
    chkListData: TCheckListBox;
    Panel2: TPanel;
    Label4: TLabel;
    txtfdate: TMaskEdit;
    Label6: TLabel;
    txtldate: TMaskEdit;
    Panel3: TPanel;
    BitBtn2: TBitBtn;
    Adobuy: TADOQuery;
    Dsbuy: TDataSource;
    cmdSelectAll: TBitBtn;
    cmdDeleteAll: TBitBtn;
    procedure cmdDeleteAllClick(Sender: TObject);
    procedure cmdSelectAllClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure chkListDataClickCheck(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buy;

  private
  selectl,GHESMAT:string;   { Private declarations }
  public
    { Public declarations }
  end;

var
  frmbuyRp: TfrmbuyRp;

implementation
uses DBS,RpLotter,Globals,rpbuy ;
{$R *.dfm}
procedure TfrmbuyRp.buy  ;


   var i,c:integer;
begin
c:=lstlotter.Count;
  i:=0;
  selectl:=' Employee.Empl_Part='+ copy(lstlotter.Items[i] , 1, pos('-', lstlotter.Items[i]  )-1);
  while i< c-1   do
  begin
    i:=i+1;
    selectl:= selectl+ ' or Employee.Empl_Part='+ copy(lstlotter.Items[i] , 1, pos('-', lstlotter.Items[i]  )-1) ;
    GHESMAT:=GHESMAT+lstlotter.Items[i];

   end;

end;
procedure TfrmbuyRp.BitBtn2Click(Sender: TObject);

var qrpbuy  : Trpbuy ;
  I: Integer;
begin
TRY
 Application.CreateForm(Trpbuy, qrpbuy );

try
 buy;
 WITH qrpbuy  DO
 BEGIN
 lblCoName.Caption := gOptions.CoName;
 Adobuy.Connection :=frmDBS.adoConnect;
 Adobuy.Close;
 Adobuy.sql.Clear;
 Adobuy.SQL.Add(' SELECT Employee.Empl_Part, Sum(Receipt1.Recit1_TotalPrice) AS SumOfRecit1_TotalPrice, Parts.Part_Name '+
                 ' FROM ((Employee LEFT JOIN Receipt1 ON Employee.Empl_No = Receipt1.Recit1_EmplNo) LEFT JOIN (SELECT chargedtl.DTLEMPLNO, Sum(chargegrp.GRPPRICE) AS SumOfGRPPRICE '+
                 ' FROM chargegrp INNER JOIN chargedtl ON chargegrp.GRPCODE = chargedtl.DTLCODE '+
                  ' GROUP BY chargedtl.DTLEMPLNO '+
                  ' ) AS a ON Employee.Empl_No = a.DTLEMPLNO) INNER JOIN Parts ON Employee.Empl_Part = Parts.Part_Code ');
                  if txtfdate.Text <> ''  then
                 Adobuy.sql.add(' WHERE Receipt1.Recit1_Date >= '+''''+txtfdate.Text +'''');
              if txtldate.Text <> ''  then
                   Adobuy.sql.add( ' AND Receipt1.Recit1_Date <= ' + ''''+ txtldate.Text  +'''' );
  Adobuy.sql.add(' GROUP BY Employee.Empl_Part, Parts.Part_Name ');
  Adobuy.sql.add(' HAVING  ' + selectl );
  Adobuy.Open;
  Adobuy.First;
 end;
    qrpbuy.lblDate.Caption := CurrentDate;
  if (txtfdate.Text <> '') and (txtldate.Text <> '') then
        qrpbuy.lblRepDate.Caption := ('از تاريخ : ') + txtFDate.Text + ('     تا تاريخ : ') + txtlDate.Text;

    qrpbuy.SetWinF_Rpt;

  if qrpbuy.Adobuy.RecordCount > 0    then
  BEGIN
   qrpbuy.Preview
  end ELSE
  BEGIN
   ErrorMessage ('هیچ رکوردی یافت نشد');
  end;
 finally
  FreeAndNil( qrpbuy);
 END;
except

   InformationMessage('لطفا یک قسمت را انتخاب کنید');

end;



end;

procedure TfrmbuyRp.chkListDataClickCheck(Sender: TObject);
begin
if chkListData.Checked[chkListData.ItemIndex] then
    lstlotter.Items.Add(chkListData.Items.Strings[chkListData.ItemIndex])
  else
    lstlotter.Items.Delete(lstlotter.Items.IndexOf(chkListData.Items.Strings[chkListData.ItemIndex]));

end;

procedure TfrmbuyRp.cmdDeleteAllClick(Sender: TObject);
var i : Integer;
begin
  lstlotter.Clear;
  for i := 0 to chkListData.Items.Count-1 do
    chkListData.Checked[i] := False;
end;

procedure TfrmbuyRp.cmdSelectAllClick(Sender: TObject);
var i : Integer;
begin
  for i := 0 to chkListData.Items.Count-1 do
    if not chkListData.Checked[i] then
    begin
      chkListData.Checked[i] := True;
      lstlotter.Items.Add(chkListData.Items.Strings[i]) ;

    end;
end;
procedure TfrmbuyRp.FormShow(Sender: TObject);
begin
 txtFDate.Text := gOptions.fromDate;
 txtlDate.Text := gOptions.toDate;
 Adobuy.Connection:=frmDBS.adoConnect;
 Adobuy.Close;
 Adobuy.sql.Clear;
 Adobuy.SQL.Add('SELECT Part_Code , Part_Name FROM Parts');
 Adobuy.Open;
 Adobuy.First;
 while not Adobuy.Eof   do
  begin
   chkListData.Items.Add(inttostr(Adobuy.FieldByName('Part_Code').Asinteger)+ '--'+ Adobuy.FieldByName('Part_Name').AsString   );
   Adobuy.Next;
  end;
  Adobuy.Close;
end;

end.
