unit RpPrsAmr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, AdoDB, Globals, DateProc, DBS_Proc;

type
  TfrmRptPrsAmar = class(TForm)
    qryPrsFish: TAdoQuery;
    qrptPrsFish: TQuickRep;
    bndDetail: TQRBand;
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lbl2: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lbl3: TQRLabel;
    lbl1: TQRLabel;
    QRSysData1: TQRSysData;
    lblRepDate: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    lbl7: TQRLabel;
    lbl12: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    grpPartJob: TQRGroup;
    lbl4: TQRLabel;
    QRShape9: TQRShape;
    qry: TAdoQuery;
    lbl6: TQRLabel;
    SummaryBand1: TQRBand;
    lblAllPrc: TQRLabel;
    lblAllFish: TQRLabel;
    QRShape2: TQRShape;
    QRShape7: TQRShape;
    lbl13: TQRLabel;
    grpBarCode: TQRGroup;
    lblPart: TQRLabel;
    lblJob: TQRLabel;
    ChildBand2: TQRChildBand;
    TitleBand1: TQRBand;
    bndSign: TQRBand;
    lblEndRep1: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep4: TQRLabel;
    lbl5: TQRLabel;
    QRShape4: TQRShape;
    lbl8: TQRLabel;
    lbl9: TQRLabel;
    lbl10: TQRLabel;
    lbl11: TQRLabel;
    QRShape8: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape18: TQRShape;
    lblAllSham: TQRLabel;
    QRShape19: TQRShape;
    lblAllNahar: TQRLabel;
    QRShape20: TQRShape;
    lblAllSobh: TQRLabel;
    bndPrsGrp: TQRBand;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape10: TQRShape;
    lblPAllFish: TQRLabel;
    lblPrc: TQRLabel;
    QRExpr1: TQRExpr;
    lblPCode: TQRLabel;
    lblRow: TQRLabel;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    lblSham: TQRLabel;
    QRShape16: TQRShape;
    lblNahar: TQRLabel;
    lblSobh: TQRLabel;
    QRShape17: TQRShape;
    lblsobhname: TQRLabel;
    lblnaharname: TQRLabel;
    lblshamname: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpPartJobBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPrsGrpBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrptPrsFishBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }


    row,
    AllSbh, AllNhr, AllShm : Integer;
    AllPrice : Currency;

    procedure SetWinF;
  public
    { Public declarations }
    SDate, EDate : String;
  end;

implementation

{$R *.DFM}

procedure TfrmRptPrsAmar.SetWinF;
begin
end;

procedure TfrmRptPrsAmar.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  st,st1 :string;
begin
  if (sdate=edate)and(sdate<>'')
  then begin
      qry.close;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT distinct ff_food from Fish,fishfood');
      qry.SQL.Add('WHERE Fish_Type = ' + IntToStr(MB_SOBH));
      qry.SQL.Add('AND Fish_Date = ''' + SDate + '''');
      qry.SQL.Add('AND Fish_Date = FF_date');
      qry.SQL.Add('and FF_Type = fish_type');
      qry.SQL.Add('and FF_FishNo = Fish_No');
      qry.Open;
      st:='';
      while not qry.Eof do
      begin
        st1:=GetFoodNameInRam(qry.FieldByName('FF_Food').AsInteger);;
        st:=st+' '+st1;
        qry.Next;
      end;
      qry.close;
      if st=''
      then lblsobhname.Caption:=''
      else lblsobhname.Caption:='’»Õ«‰Â :'+st;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT distinct ff_food from Fish,fishfood');
      qry.SQL.Add('WHERE Fish_Type = ' + IntToStr(MB_nahar));
      qry.SQL.Add('AND Fish_Date = ''' + SDate + '''');
      qry.SQL.Add('AND Fish_Date = FF_date');
      qry.SQL.Add('and FF_Type = fish_type');
      qry.SQL.Add('and FF_FishNo = Fish_No');

      qry.Open;
      st:='';
      while not qry.Eof do
      begin
        st1:=GetFoodNameInRam(qry.FieldByName('FF_Food').AsInteger);;
        st:=st+' '+st1;
        qry.Next;
      end;
      qry.close;
      if st=''
      then lblnaharname.Caption:=''
      else lblnaharname.Caption:='‰«Â«—: '+st;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT distinct ff_food from Fish,fishfood');
      qry.SQL.Add('WHERE Fish_Type = ' + IntToStr(MB_sham));
      qry.SQL.Add('AND Fish_Date = ''' + SDate + '''');
      qry.SQL.Add('AND Fish_Date = FF_date');
      qry.SQL.Add('and FF_Type = fish_type');
      qry.SQL.Add('and FF_FishNo = Fish_No');
      qry.Open;
      st:='';
      while not qry.Eof do
      begin
        st1:=GetFoodNameInRam(qry.FieldByName('FF_Food').AsInteger);;
        st:=st+' '+st1;
        qry.Next;
      end;
      qry.close;
      if st=''
      then lblshamname.Caption:=''
      else lblshamname.Caption:='‘«„ :'+st;
  end
  else begin
       lblsobhname.Caption:='';
       lblnaharname.Caption:='';
       lblshamname.Caption:='';
  end;
end;

procedure TfrmRptPrsAmar.FormCreate(Sender: TObject);
begin
  SetWinF;
  qryPrsFish.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  lblCoName.Caption := g_options.CoName;
  if g_options.Shobeh <> '' then
    lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
  lblDate.Caption := CurrentDate;
end;

procedure TfrmRptPrsAmar.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblAllSobh.Caption := IntToStr(AllSbh);
  lblAllNahar.Caption := IntToStr(AllNhr);
  lblAllSham.Caption := IntToStr(AllShm);
  lblAllFish.Caption := IntToStr(AllSbh + AllNhr + AllShm);
  lblAllPrc.Caption := Format('%m', [AllPrice]);
end;

procedure TfrmRptPrsAmar.grpPartJobBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblPart.Caption := ('»Œ‘ : ') + GetPartNam(qryPrsFish.FieldByName('P_parts').Asstring);
  lblJob.Caption := ('‰Ê⁄ «” Œœ«„ : ') + GetJobName(qryPrsFish.FieldByName('P_JobCode').AsInteger);
  row := 0;
  AllSbh := 0;
  AllNhr := 0;
  AllShm := 0;
  AllPrice := 0;
end;

procedure TfrmRptPrsAmar.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  row := 0;
  AllSbh := 0;
  AllNhr := 0;
  AllShm := 0;
  AllPrice := 0;
end;

procedure TfrmRptPrsAmar.bndPrsGrpBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  c, all : Integer;
  p : Currency;
begin
  Inc(row);
  lblRow.Caption := IntToStr(row);
  lblPCode.Caption := DelLeftZero(qryPrsFish.FieldByName('P_BarCode').AsString);

  //tedad e sobhaneh
  qry.SQL.Clear;
  //qry.SQL.Add('SELECT COUNT(Fish_No) AS Fsh_C FROM Fish');
  qry.SQL.Add('SELECT Fish_PCode FROM Fish');
  qry.SQL.Add('WHERE Fish_Type = ' + IntToStr(MB_SOBH));
  qry.SQL.Add('AND Fish_PCode = ''' + qryPrsFish.FieldByName('P_BarCode').AsString + '''');
  if SDate <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + SDate + '''');
  if EDate <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + EDate + '''');
  qry.Open;
  //c := qry.FieldByName('Fsh_C').AsInteger;
  c := qry.RecordCount;
  Inc(AllSbh, c);
  lblSobh.Caption := IntToStr(c);
  all := c;

  //tedad e nahar
  qry.Close;
  qry.SQL.Clear;
  //qry.SQL.Add('SELECT COUNT(Fish_No) AS Fsh_C FROM Fish');
  qry.SQL.Add('SELECT Fish_PCode FROM Fish');
  qry.SQL.Add('WHERE Fish_Type = ' + IntToStr(MB_NAHAR));
  qry.SQL.Add('AND Fish_PCode = ''' + qryPrsFish.FieldByName('P_BarCode').AsString + '''');
  if SDate <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + SDate + '''');
  if EDate <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + EDate + '''');
  qry.Open;
  //c := qry.FieldByName('Fsh_C').AsInteger;
  c := qry.RecordCount;
  Inc(AllNhr, c);
  lblNahar.Caption := IntToStr(c);
  Inc(all, c);

  //tedad e sham
  qry.Close;
  qry.SQL.Clear;
  //qry.SQL.Add('SELECT COUNT(Fish_No) AS Fsh_C FROM Fish');
  qry.SQL.Add('SELECT Fish_PCode FROM Fish');
  qry.SQL.Add('WHERE Fish_Type = ' + IntToStr(MB_SHAM));
  qry.SQL.Add('AND Fish_PCode = ''' + qryPrsFish.FieldByName('P_BarCode').AsString + '''');
  if SDate <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + SDate + '''');
  if EDate <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + EDate + '''');
  qry.Open;
  //c := qry.FieldByName('Fsh_C').AsInteger;
  c := qry.RecordCount;
  Inc(AllShm, c);
  lblSham.Caption := IntToStr(c);
  Inc(all, c);
  lblPAllFish.Caption := IntToStr(all);


  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT SUM(FF_Price * FF_No) AS Prc FROM Fish, FishFood');
  qry.SQL.Add('WHERE FF_FishNo = Fish_No AND FF_Type = Fish_Type AND FF_Date = Fish_Date');
  qry.SQL.Add('AND Fish_PCode = ''' + qryPrsFish.FieldByName('P_BarCode').AsString + '''');
  if SDate <> '' then
    qry.SQL.Add('AND FF_Date >= ''' + SDate + '''');
  if EDate <> '' then
    qry.SQL.Add('AND FF_Date <= ''' + EDate + '''');
  qry.Open;
  p := qry.FieldByName('Prc').AsCurrency;
  lblPrc.Caption := Format('%m', [p]);
  AllPrice := AllPrice + p;

  qry.Close;
end;

procedure TfrmRptPrsAmar.qrptPrsFishBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  lblCoName.Font.Name := RptTitleFont;
  lblCoName.Font.Size := RptTitleFntSize;
  lblName.Font.Name := RptTitleFont;
  lblName.Font.Size := RptTitleFntSize;
  qrptPrsFish.Font.Name := RptFont;
  qrptPrsFish.Font.Size := RptFntSize;
end;

end.


select y_PCode,FamilyName,y_WorkDays,FishCount,FishPrice,FishCount as AteYaranehCount,FishCount*y_AteYaraneh as AteYaraneh,(y_WorkDays-FishCount) as AteYaranehCount,(y_WorkDays-FishCount)*y_NotAteYaraneh as NotAteYaraneh , FishPrice-(FishCount*y_AteYaraneh)-((y_WorkDays-FishCount)*y_NotAteYaraneh) from
	(select yaraneh.*,p_family+'-'+p_Name as FamilyName from yaraneh , persons where y_Pcode=p_barcode) p
 join 
	(
	SELECT fish_Pcode,SUM(FF_Price * FF_No)as FishPrice,count(fish_no)as FishCount,substring(ff_date,6,2)as m FROM Fish, FishFood
	WHERE FF_FishNo = Fish_No AND FF_Type = Fish_Type AND FF_Date = Fish_Date
	group by fish_PCode,substring(ff_date,6,2)
	) a 
on a.fish_pcode = p.Y_Pcode and a.m =p.y_Month


	select yaraneh.*,p_family+'-'+p_Name as FamilyName from yaraneh , persons where y_Pcode=p_barcode

	SELECT fish_Pcode,SUM(FF_Price * FF_No)as FishPrice,count(fish_no)as FishCount,substring(ff_date,6,2)as m FROM Fish, FishFood
	WHERE FF_FishNo = Fish_No AND FF_Type = Fish_Type AND FF_Date = Fish_Date
	group by fish_PCode,substring(ff_date,6,2)


