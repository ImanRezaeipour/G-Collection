unit DiffRp;

interface

uses
  Forms, StdCtrls, Buttons, Classes, Controls, AdoDB, SysUtils,
  Globals, MSgs, RpDiff, DBS, RunCmnds, DosMove;

type
  TfrmDiffRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
    TBank1, TPark1 : Word;

    procedure MakeDifferFile;
    procedure SetWinF;

  public
    { Public declarations }
  end;



implementation

{$R *.DFM}

procedure TfrmDiffRpt.SetWinF;
begin
  Caption := (Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmDiffRpt.MakeDifferFile;
var
  qry : TAdoQuery;
   table1,table2:TAdoTable;
   serial1,city1,number1,BARCODE1:string;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  
   tbank1:=0;
   tpark1:=0;
   qry.close;
   with qry.sql do
   begin
     clear;
     add('delete from diff');
   end;
   qry.execsql;
   qry.close;
   table1:=TAdoTable.Create(APPLICATION);


   WITH table1 DO
   BEGIN
//kaveh     DATABASENAME:=G_OPTIONS.DATABASEPATH;
     Connection := frmDBS.adoConnect; //kaveh
     Open; //kaveh
     tablename:='CarPark';
     open;
   end;
   table2:=TAdoTable.Create(APPLICATION);
   WITH table2 DO
   BEGIN
//kaveh     DATABASENAME:=G_OPTIONS.DATABASEPATH;
     Connection := frmDBS.adoConnect; //kaveh
     Open; //kaveh
     tablename:='diff';
     open;
   end;
   table1.first;
   with table1 do
   while not eof do
   begin
     inc(tpark1);
     serial1:=fieldbyname('P_serial').asstring;
     city1:=fieldbyname('P_city').asstring;
     number1:=fieldbyname('P_number').asstring;
     with qry.sql do
     begin
       clear;
       add('select * from machines');
       add('where m_ispark= ' + IntToStr(CNST_TRUE));
       add('and m_serial='''+serial1+'''');
       add('and m_cityname='''+city1+'''');
       add('and m_number='''+number1+'''');
     end;
     qry.open;
     if qry.eof
     then begin
       table2.Append;
       table2.fieldbyname('D_serial').asstring:=fieldbyname('P_serial').asstring;
       table2.fieldbyname('D_city').asstring:=fieldbyname('P_city').asstring;
       table2.fieldbyname('D_number').asstring:=fieldbyname('P_number').asstring;
       table2.fieldbyname('D_color').asstring:=fieldbyname('P_color').asstring;
       table2.fieldbyname('D_carname').asstring:=fieldbyname('P_carname').asstring;
       table2.fieldbyname('D_date').asstring:=fieldbyname('P_date').asstring;
       table2.FieldByName('D_type').asinteger:=0;
       table2.post;
     end
     else begin
       BARCODE1:=qry.fieldbyname('M_BARCODE').asstring;
       qry.next;
       if qry.eof
       then
       else begin
         table2.Append;
         table2.fieldbyname('D_serial').asstring:=fieldbyname('P_serial').asstring;
         table2.fieldbyname('D_city').asstring:=fieldbyname('P_city').asstring;
         table2.fieldbyname('D_number').asstring:=fieldbyname('P_number').asstring;
         table2.fieldbyname('D_color').asstring:=fieldbyname('P_color').asstring;
         table2.fieldbyname('D_carname').asstring:=fieldbyname('P_carname').asstring;
         table2.fieldbyname('D_date').asstring:=fieldbyname('P_date').asstring;
         table2.FieldByName('D_type').asinteger:=2;
         table2.fieldbyname('D_BARCODE1').asstring:=BARCODE1;
         table2.fieldbyname('D_BARCODE2').asstring:=qry.fieldbyname('M_BARCODE').asstring;
         table2.post;
       end;
     end;
     qry.close;
     next;
   end;
   WITH table1 DO
   BEGIN
     close;
     tablename:='machines';
     filtered:=true;
     filter:='m_ispark= ' + IntToStr(CNST_TRUE);
     open;
     first;
   end;
   with table1 do
   while not eof do
   begin
     inc(tbank1);
     serial1:=fieldbyname('m_serial').asstring;
     city1:=fieldbyname('m_cityname').asstring;
     number1:=fieldbyname('m_number').asstring;
     with qry.sql do
     begin
       clear;
       add('select * from CarPark');
       add('where P_serial='''+serial1+'''');
       add('and P_city='''+city1+'''');
       add('and P_number='''+number1+'''');
     end;
     qry.open;
     if qry.eof
     then begin
       table2.Append;
       table2.fieldbyname('d_serial').asstring:=fieldbyname('m_serial').asstring;
       table2.fieldbyname('d_city').asstring:=fieldbyname('m_cityname').asstring;
       table2.fieldbyname('d_number').asstring:=fieldbyname('m_number').asstring;
       table2.fieldbyname('d_color').asstring:=fieldbyname('m_color').asstring;
       table2.fieldbyname('d_carname').asstring:=fieldbyname('m_carname').asstring;
       table2.fieldbyname('d_date').asstring:=fieldbyname('m_idate').asstring;
       table2.FieldByName('d_type').asinteger:=1;
       table2.fieldbyname('d_BARCODE1').asstring:=fieldbyname('m_BARCODE').asstring;
       table2.post;
     end;
     qry.close;
     next;
   end;

   table1.close;
   table2.Close;
   table1.free;
   table2.free;
end;

procedure TfrmDiffRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  rdoPrinter.Enabled := g_options.AcesPrint;
end;

procedure TfrmDiffRpt.cmdPrintClick(Sender: TObject);
var frmRptDiff : TfrmRptDiff;
begin
  if g_options.RdrOff_Rpt = MB_TRUE then
    SetUserControl;
  AddRecToMachine;
  makedifferfile;
  Application.CreateForm(TfrmRptDiff, frmRptDiff);
  with frmRptDiff do
  begin
    tbank.caption:=inttostr(tbank1);
    tpark.caption:=inttostr(tpark1);
    Query1.Open;
    if Query1.RecordCount > 0 then
    begin
      if rdoScreen.Checked then
        quickrep1.Preview
      else
        quickrep1.Print;
    end
    else
      InformationMessage('„€«Ì— Ì ÊÃÊœ ‰œ«—œ.');
    Query1.Close;
    Free;
  end;
  DelRecFromMachine;
  if g_options.RdrOff_Rpt = MB_TRUE then
    UserControl := False;
end;

end.
