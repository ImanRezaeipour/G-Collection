unit RpPerson;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, ADODB;

type
  TqrptPersons = class(TQuickRep)
    bndCoName: TQRBand;
    lblCoName: TQRLabel;
    ChildBand1: TQRChildBand;
    lblName: TQRLabel;
    lblDateP: TQRLabel;
    lblDate: TQRLabel;
    QRSysData2: TQRSysData;
    lblTimeP: TQRLabel;
    lblPage: TQRLabel;
    QRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    QRBand1: TQRBand;
    QRExpr2: TQRExpr;
    lbltedad: TQRLabel;
    snamefamily: TQRShape;
    grpP1: TQRGroup;
    btnTitle: TQRChildBand;
    lblpno1: TQRLabel;
    lblnamefamily1: TQRLabel;
    snamefamily1: TQRShape;
    lblGrp: TQRLabel;
    lblContractDate: TQRLabel;
    lblsodoorcity: TQRLabel;
    lblbirthdate: TQRLabel;
    lblContractDate1: TQRLabel;
    lblsodoorcity1: TQRLabel;
    lblbirthdate1: TQRLabel;
    lblfno: TQRLabel;
    lblsno: TQRLabel;
    lblfno1: TQRLabel;
    lblsno1: TQRLabel;
    lblnamefamily: TQRLabel;
    lblpno: TQRLabel;
    ssno1: TQRShape;
    sfno1: TQRShape;
    sbirthdate1: TQRShape;
    ssodoorcity1: TQRShape;
    sContractDate1: TQRShape;
    sContractDate: TQRShape;
    ssodoorcity: TQRShape;
    sbirthdate: TQRShape;
    sfno: TQRShape;
    ssno: TQRShape;
    spno1: TQRShape;
    spno: TQRShape;
    lbladdress1: TQRLabel;
    saddress1: TQRShape;
    saddress: TQRShape;
    lblContractEndDate1: TQRLabel;
    lblContractEndDate: TQRLabel;
    sContractEndDate1: TQRShape;
    sContractEndDate: TQRShape;
    lblTemp: TQRLabel;
    lblCoTemp: TQRLabel;
    bndSum: TQRBand;
    lblEndRep4: TQRLabel;
    lblEndRep3: TQRLabel;
    lblEndRep2: TQRLabel;
    lblEndRep1: TQRLabel;
    lblEndRep5: TQRLabel;
    lblradif1: TQRLabel;
    sradif1: TQRShape;
    sradif: TQRShape;
    lblradif: TQRLabel;
    btnHead: TQRBand;
    lblContractDate2: TQRLabel;
    lblsodoorcity2: TQRLabel;
    lblbirthdate2: TQRLabel;
    ssodoorcity2: TQRShape;
    sContractDate2: TQRShape;
    lblContractEndDate2: TQRLabel;
    sContractEndDate2: TQRShape;
    lblpno2: TQRLabel;
    lblnamefamily2: TQRLabel;
    snamefamily2: TQRShape;
    lblfno2: TQRLabel;
    lblsno2: TQRLabel;
    ssno2: TQRShape;
    sfno2: TQRShape;
    sbirthdate2: TQRShape;
    spno2: TQRShape;
    lbladdress2: TQRLabel;
    saddress2: TQRShape;
    lblradif2: TQRLabel;
    sradif2: TQRShape;
    lblteahol2: TQRLabel;
    steahol2: TQRShape;
    lblHometel2: TQRLabel;
    sHometel2: TQRShape;
    lblteahol1: TQRLabel;
    steahol1: TQRShape;
    lblHometel1: TQRLabel;
    SHometel1: TQRShape;
    lblteahol: TQRLabel;
    steahol: TQRShape;
    lblHometel: TQRLabel;
    SHometel: TQRShape;
    adoQryPersons: TADOQuery;
    lblWorkTel2: TQRLabel;
    SWorkTel2: TQRShape;
    lblMobile2: TQRLabel;
    SMobile2: TQRShape;
    lblWorkTel1: TQRLabel;
    sWorkTel1: TQRShape;
    lblMobile1: TQRLabel;
    SMobile1: TQRShape;
    lblWorkTel: TQRLabel;
    sWorkTel: TQRShape;
    lblMobile: TQRLabel;
    SMobile: TQRShape;
    lblAddress: TQRLabel;
    sNation2: TQRShape;
    lblNation2: TQRLabel;
    sNation1: TQRShape;
    lblNation1: TQRLabel;
    lblNation: TQRLabel;
    sNation: TQRShape;
    lblPost2: TQRLabel;
    sPost2: TQRShape;
    lblPost1: TQRLabel;
    sPost1: TQRShape;
    lblPost: TQRLabel;
    sPost: TQRShape;
    lblAccountNo2: TQRLabel;
    sAccountNo2: TQRShape;
    lblAccountNo1: TQRLabel;
    sAccountNo1: TQRShape;
    lblAccountNo: TQRLabel;
    sAccountNo: TQRShape;
    lblAccountType2: TQRLabel;
    sAccountType2: TQRShape;
    sAccountType1: TQRShape;
    lblAccountType1: TQRLabel;
    lblAccountType: TQRLabel;
    sAccountType: TQRShape;
    lblContractNo2: TQRLabel;
    sContractNo2: TQRShape;
    lblContractNo1: TQRLabel;
    sContractNo1: TQRShape;
    lblContractNo: TQRLabel;
    sContractNo: TQRShape;
    lblAccountBranch2: TQRLabel;
    sAccountBranch2: TQRShape;
    lblAccountBranch1: TQRLabel;
    sAccountBranch1: TQRShape;
    lblAccountBranch: TQRLabel;
    sAccountBranch: TQRShape;
    lblDeposite2: TQRLabel;
    sDeposite2: TQRShape;
    lblDeposite1: TQRLabel;
    sDeposite1: TQRShape;
    lblDeposite: TQRLabel;
    sDeposite: TQRShape;
    lblBimeh2: TQRLabel;
    sBimeh2: TQRShape;
    lblBimeh1: TQRLabel;
    sBimeh1: TQRShape;
    lblBimeh: TQRLabel;
    sBimeh: TQRShape;
    lblBoxType2: TQRLabel;
    sBoxType2: TQRShape;
    lblBoxType1: TQRLabel;
    sBoxType1: TQRShape;
    lblBoxType: TQRLabel;
    sBoxType: TQRShape;
    lblBoxPlace2: TQRLabel;
    sBoxPlace2: TQRShape;
    lblBoxPlace1: TQRLabel;
    sBoxPlace1: TQRShape;
    lblBoxPlace: TQRLabel;
    sBoxPlace: TQRShape;
    lblBox2: TQRLabel;
    sBox2: TQRShape;
    lblBox1: TQRLabel;
    sBox1: TQRShape;
    lblBox: TQRLabel;
    sBox: TQRShape;
    lblColleague: TQRLabel;
    sColleague: TQRShape;
    lblColleague1: TQRLabel;
    sColleague1: TQRShape;
    lblColleague2: TQRLabel;
    sColleague2: TQRShape;
    lblBlockDate2: TQRLabel;
    sBlockDate2: TQRShape;
    lblBlockDate1: TQRLabel;
    sBlockDate1: TQRShape;
    lblBlockDate: TQRLabel;
    sBlockDate: TQRShape;
    lblBlockDesc2: TQRLabel;
    sBlockDesc2: TQRShape;
    lblBlockDesc1: TQRLabel;
    sBlockDesc1: TQRShape;
    lblBlockDesc: TQRLabel;
    sBlockDesc: TQRShape;
    hl01: TQRShape;
    hl02: TQRShape;
    hl03: TQRShape;
    hl04: TQRShape;
    hl05: TQRShape;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    hl06: TQRShape;
    hl07: TQRShape;
    sContractEndDate3: TQRShape;
    QRShape4: TQRShape;
    sContractDate3: TQRShape;
    ssodoorcity3: TQRShape;
    sbirthdate3: TQRShape;
    saddress3: TQRShape;
    sfno3: TQRShape;
    ssno3: TQRShape;
    snamefamily3: TQRShape;
    spno3: TQRShape;
    sradif3: TQRShape;
    steahol3: TQRShape;
    SHometel3: TQRShape;
    sWorkTel3: TQRShape;
    SMobile3: TQRShape;
    sNation3: TQRShape;
    sPost3: TQRShape;
    sAccountNo3: TQRShape;
    sAccountType3: TQRShape;
    sContractNo3: TQRShape;
    sAccountBranch3: TQRShape;
    sDeposite3: TQRShape;
    sBimeh3: TQRShape;
    sBoxType3: TQRShape;
    sBoxPlace3: TQRShape;
    sBox3: TQRShape;
    sColleague3: TQRShape;
    sBlockDate3: TQRShape;
    sBlockDesc3: TQRShape;
    lblDepositeSum: TQRLabel;
    lblBimehSum: TQRLabel;
    procedure initcustomvec;
    procedure placeselects;
    procedure placeothers;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpP1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure btnHeadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private

  public
    GrpType : Byte;

    veccount:byte;
    vlabelcount,vshapecount, vQRExprcount:integer;
    vec:array [1..50] of
         record
            vectitle:string[30];
            labelcount:byte;
            shapecount:byte;
            QRExprcount:byte;
            flabel:integer;
            fshape:integer;
            fQRExpr:integer;
            vecwidth:integer;
            vecleft:integer;
         end;
    veclabels:array[1..200] of tqrlabel;
    vecshapes:array[1..200] of tqrshape;
    vecQRExpr:array[1..200] of TQRExpr;
    vselect:array[1..50] of byte;
    selcount:byte;
    CustomWidth : Integer;
    radif: integer;
    lencustom:boolean;
    flen : array[1..50] of byte;
    DepositeSum,BimehSum : Real;
  end;

var
  qrptPersons: TqrptPersons;

implementation

uses
  Globals, DBS, Funcs, Code_Sys;

{$R *.DFM}


procedure TqrptPersons.initcustomvec;

procedure InsertVec(title1:string;left1,right1:integer);
begin
    inc(veccount);
    with vec[veccount] do
    begin
        title1 := (Title1);
        vectitle:=title1;
        vecleft:=left1;
        vecwidth:=right1-left1;
        labelcount:=0;
        shapecount:=0;
        QRExprcount:=0;
        flabel:=vlabelcount+1;
        fshape:=vshapecount+1;
        fQRExpr:=vQRExprcount+1;

    end;
end;

procedure InsertLabel(var label1:tqrlabel);
begin
    label1.Caption := (label1.Caption);
    inc(vlabelcount);
    veclabels[vlabelcount]:=label1;
    inc(vec[veccount].labelcount);
end;

procedure InsertQRExpr(var QRExpr1:TQRExpr);
begin
    //label1.Caption := (label1.Caption);
    inc(vQRExprcount);
    vecQRExpr[vQRExprcount]:=QRExpr1;
    inc(vec[veccount].QRExprcount);
end;

procedure InsertShape(shape1:tqrshape);
begin
    inc(vshapecount);
    vecshapes[vshapecount]:=shape1;
    inc(vec[veccount].shapecount);
end;

begin
   veccount:=0;
   vlabelcount:=0;
   vshapecount:=0;
   vQRExprcount:=0;

   InsertVec('—œÌ›', 1, 30);
   InsertLabel(lblradif);
   InsertShape(sradif);
   InsertLabel(lblradif1);
   InsertShape(sradif1);
   InsertLabel(lblradif2);
   InsertShape(sradif2);
   InsertShape(sradif3);

   InsertVec('‘„«—Â', 1, 82);
   InsertLabel(lblpno);
   InsertShape(spno);
   InsertLabel(lblpno1);
   InsertShape(spno1);
   InsertLabel(lblpno2);
   InsertShape(spno2);
   InsertShape(spno3);

   InsertVec('‰«„ Œ«‰Ê«œêÌ - ‰«„', 1, 160);
   InsertLabel(lblnamefamily);
   InsertShape(snamefamily);
   InsertLabel(lblnamefamily1);
   InsertShape(snamefamily1);
   InsertLabel(lblnamefamily2);
   InsertShape(snamefamily2);
   InsertShape(snamefamily3);


   InsertVec('‘„«—Â ‘‰«”‰«„Â', 1, 80);
   InsertLabel(lblsno);
   InsertShape(ssno);
   InsertLabel(lblsno1);
   InsertShape(ssno1);
   InsertLabel(lblsno2);
   InsertShape(ssno2);
   InsertShape(ssno3);

   InsertVec('‰«„ Åœ—', 1, 80);
   InsertLabel(lblfno);
   InsertShape(sfno);
   InsertLabel(lblfno1);
   InsertShape(sfno1);
   InsertLabel(lblfno2);
   InsertShape(sfno2);
   InsertShape(sfno3);

   InsertVec('„Õ· ’œÊ—', 1, 80);
   InsertLabel(lblsodoorcity);
   InsertShape(ssodoorcity);
   InsertLabel(lblsodoorcity1);
   InsertShape(ssodoorcity1);
   InsertLabel(lblsodoorcity2);
   InsertShape(ssodoorcity2);
   InsertShape(ssodoorcity3);

   InsertVec(' «—ÌŒ  Ê·œ', 1, 80);
   InsertLabel(lblbirthdate);
   InsertShape(sbirthdate);
   InsertLabel(lblbirthdate1);
   InsertShape(sbirthdate1);
   InsertLabel(lblbirthdate2);
   InsertShape(sbirthdate2);
   InsertShape(sbirthdate3);

   InsertVec(' «—ÌŒ ﬁ—«—œ«œ', 1, 80);
   InsertLabel(lblContractDate);
   InsertShape(sContractDate);
   InsertLabel(lblContractDate1);
   InsertShape(sContractDate1);
   InsertLabel(lblContractDate2);
   InsertShape(sContractDate2);
   InsertShape(sContractDate3);

   InsertVec('Å«Ì«‰ ﬁ—«—œ«œ', 1, 80);
   InsertLabel(lblContractEndDate);
   InsertShape(sContractEndDate);
   InsertLabel(lblContractEndDate1);
   InsertShape(sContractEndDate1);
   InsertLabel(lblContractEndDate2);
   InsertShape(sContractEndDate2);
   InsertShape(sContractEndDate3);

   InsertVec('„·Ì ', 1, 80);
   InsertLabel(lblNation);
   InsertShape(sNation);
   InsertLabel(lblNation1);
   InsertShape(sNation1);
   InsertLabel(lblNation2);
   InsertShape(sNation2);
   InsertShape(sNation3);

   InsertVec('‘€·', 1, 80);
   InsertLabel(lblPost);
   InsertShape(sPost);
   InsertLabel(lblPost1);
   InsertShape(sPost1);
   InsertLabel(lblPost2);
   InsertShape(sPost2);
   InsertShape(sPost3);

   InsertVec('‘„«—Â Õ”«»', 1, 80);
   InsertLabel(lblAccountNo);
   InsertShape(sAccountNo);
   InsertLabel(lblAccountNo1);
   InsertShape(sAccountNo1);
   InsertLabel(lblAccountNo2);
   InsertShape(sAccountNo2);
   InsertShape(sAccountNo3);

   InsertVec('‰Ê⁄ Õ”«»', 1, 80);
   InsertLabel(lblAccountType);
   InsertShape(sAccountType);
   InsertLabel(lblAccountType1);
   InsertShape(sAccountType1);
   InsertLabel(lblAccountType2);
   InsertShape(sAccountType2);
   InsertShape(sAccountType3);

   InsertVec('‘„«—Â ﬁ—«œ«œ', 1, 80);
   InsertLabel(lblContractNo);
   InsertShape(sContractNo);
   InsertLabel(lblContractNo1);
   InsertShape(sContractNo1);
   InsertLabel(lblContractNo2);
   InsertShape(sContractNo2);
   InsertShape(sContractNo3);

   InsertVec('‘⁄»Â »«‰ò', 1, 80);
   InsertLabel(lblAccountBranch);
   InsertShape(sAccountBranch);
   InsertLabel(lblAccountBranch1);
   InsertShape(sAccountBranch1);
   InsertLabel(lblAccountBranch2);
   InsertShape(sAccountBranch2);
   InsertShape(sAccountBranch3);

   InsertVec('„»·€ ÊœÌ⁄Â', 1, 80);
   InsertLabel(lblDeposite);
   InsertShape(sDeposite);
   InsertLabel(lblDeposite1);
   InsertShape(sDeposite1);
   InsertLabel(lblDeposite2);
   InsertShape(sDeposite2);
   InsertShape(sDeposite3);
   InsertLabel(lblDepositeSum);

   InsertVec('„»·€ »Ì„Â', 1, 80);
   InsertLabel(lblBimeh);
   InsertShape(sBimeh);
   InsertLabel(lblBimeh1);
   InsertShape(sBimeh1);
   InsertLabel(lblBimeh2);
   InsertShape(sBimeh2);
   InsertShape(sBimeh3);
   InsertLabel(lblBimehSum);

   InsertVec('òœ ’‰œÊﬁ', 1, 80);
   InsertLabel(lblBox);
   InsertShape(sBox);
   InsertLabel(lblBox1);
   InsertShape(sBox1);
   InsertLabel(lblBox2);
   InsertShape(sBox2);
   InsertShape(sBox3);

   InsertVec('„Õ· ’‰œÊﬁ', 1, 80);
   InsertLabel(lblBoxPlace);
   InsertShape(sBoxPlace);
   InsertLabel(lblBoxPlace1);
   InsertShape(sBoxPlace1);
   InsertLabel(lblBoxPlace2);
   InsertShape(sBoxPlace2);
   InsertShape(sBoxPlace3);

   InsertVec('‰Ê⁄ ’‰œÊﬁ', 1, 80);
   InsertLabel(lblBoxType);
   InsertShape(sBoxType);
   InsertLabel(lblBoxType1);
   InsertShape(sBoxType1);
   InsertLabel(lblBoxType2);
   InsertShape(sBoxType2);
   InsertShape(sBoxType3);

   InsertVec('Â„ò«—', 1, 80);
   InsertLabel(lblColleague);
   InsertShape(sColleague);
   InsertLabel(lblColleague1);
   InsertShape(sColleague1);
   InsertLabel(lblColleague2);
   InsertShape(sColleague2);
   InsertShape(sColleague3);

   InsertVec('Ê÷⁄Ì   «Â·', 1, 80);
   InsertLabel(lblteahol);
   InsertShape(steahol);
   InsertLabel(lblteahol1);
   InsertShape(steahol1);
   InsertLabel(lblteahol2);
   InsertShape(steahol2);
   InsertShape(steahol3);

   InsertVec('¬œ—”', 1, 205);
   InsertLabel(lbladdress);
   InsertShape(saddress);
   InsertLabel(lbladdress1);
   InsertShape(saddress1);
   InsertLabel(lbladdress2);
   InsertShape(saddress2);
   InsertShape(saddress3);

   InsertVec(' ·›‰ „‰“·', 1, 80);
   InsertLabel(lblHomeTel);
   InsertShape(sHomeTel);
   InsertLabel(lblHomeTel1);
   InsertShape(sHomeTel1);
   InsertLabel(lblHomeTel2);
   InsertShape(sHomeTel2);
   InsertShape(sHomeTel3);

   InsertVec(' ·›‰ „Õ· ò«—', 1, 80);
   InsertLabel(lblWorkTel);
   InsertShape(sWorkTel);
   InsertLabel(lblWorkTel1);
   InsertShape(sWorkTel1);
   InsertLabel(lblWorkTel2);
   InsertShape(sWorkTel2);
   InsertShape(sWorkTel3);

   InsertVec('Â„—«Â', 1, 80);
   InsertLabel(lblMobile);
   InsertShape(sMobile);
   InsertLabel(lblMobile1);
   InsertShape(sMobile1);
   InsertLabel(lblMobile2);
   InsertShape(sMobile2);
   InsertShape(sMobile3);

   InsertVec(' «—ÌŒ «‰”œ«œ', 1, 80);
   InsertLabel(lblBlockDate);
   InsertShape(sBlockDate);
   InsertLabel(lblBlockDate1);
   InsertShape(sBlockDate1);
   InsertLabel(lblBlockDate2);
   InsertShape(sBlockDate2);
   InsertShape(sBlockDate3);

   InsertVec('⁄·  «‰”œ«œ', 1, 160);
   InsertLabel(lblBlockDesc);
   InsertShape(sBlockDesc);
   InsertLabel(lblBlockDesc1);
   InsertShape(sBlockDesc1);
   InsertLabel(lblBlockDesc2);
   InsertShape(sBlockDesc2);
   InsertShape(sBlockDesc3);
end;

procedure TqrptPersons.placeselects;
var
   i,j:byte;
   k,left1:integer;
   w:integer;
begin
   for k:=1 to vlabelcount do veclabels[k].enabled:=false;
   for k:=1 to vshapecount do vecshapes[k].enabled:=false;
   for k:=1 to vQRExprcount do vecQRExpr[k].enabled:=false;
   left1:=0;
   for i:=selcount downto 1 do
   with vec[vselect[i]] do
   begin
      w:=vecwidth;
      if w<>0
      then if flen[vselect[i]]<>0
      then begin
           w:=round(flen[vselect[i]]*3.78);
      end;
      for j:=1 to shapecount do
      with vecshapes[fshape+j-1] do
      begin
         width:=1;
         left:=left1+w;
         enabled:=true;
      end;
      for j:=1 to labelcount do
      with veclabels[flabel+j-1] do
      begin
         width:=w-5;
         left:=left1+3;
         enabled:=true;
      end;
      for j:=1 to QRExprcount do
      with vecQRExpr[fQRExpr+j-1] do
      begin
         width:=w-5;
         left:=left1+3;
         enabled:=true;
      end;

      inc(left1,w);
   end;
   CustomWidth:=left1-3;
end;

procedure TqrptPersons.placeothers;
begin
  lblCoTemp.Caption := lblCoName.Caption;
  lblCoName.Left := 0;
  lblCoName.Width := CustomWidth;
  if lblCoTemp.Width > CustomWidth then
    bndCoName.Height := lblCoTemp.Height * ((lblCoTemp.Width div CustomWidth)+1)
  else
    bndCoName.Height := lblCoTemp.Height;
  lblCoName.Height := bndCoName.Height;

  lblName.Left := (CustomWidth - lblName.Width) div 2;
  Page.RightMargin := Page.Width - Page.LeftMargin - (CustomWidth/3.78)-1;
  qrexpr2.Left := CustomWidth - qrexpr2.Width - 30;
  lbltedad.Left := CustomWidth - lbltedad.Width;
  lblGrp.Width := CustomWidth;
  lblGrp.Left := 0;
end;

procedure TqrptPersons.grpP1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  with adoQryPersons do
//  begin
//    case GrpType of
//      1: lblGrp.Caption := ('»Œ‘: ') + GetAllPartName(FieldByName('P_Parts').AsString);
//      2: lblgrp.Caption := ('‰Ê⁄ «” Œœ«„ : ' ) + GetJobName(FieldByName('P_JobCode').AsInteger);
//    end;
//  end;
  lblTemp.Caption := lblGrp.Caption;
  if lblTemp.Width > CustomWidth then
    grpP1.Height := lblTemp.Height * 2
  else
    grpP1.Height := lblTemp.Height;

  lblGrp.Height := grpP1.Height;

end;

procedure TqrptPersons.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  {
  case GrpType of
    1: lblDtlTitle.Caption := '‰Ê⁄ «” Œœ«„';
    2: lblDtlTitle.Caption := '»Œ‘';
    else lblDtlTitle.Caption := '‰Ê⁄ «” Œœ«„ / »Œ‘';
  end;
  }
end;

procedure TqrptPersons.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  btnTitle.Enabled := True;
  with adoQryPersons do
  begin
     inc(radif);
     lblradif.Caption:=inttostr(radif);
     lblpno.Caption := DelLeftZero(FieldByName('P_Code').AsString);
     lblNamefamily.caption := FieldByName('nP_Family').AsString+' - '+FieldByName('nP_Name').AsString;
     lblsno.caption := FieldByName('nP_IDNo').AsString;
     lblfno.caption := FieldByName('nP_Father').AsString;
     lblsodoorcity.Caption := FieldByName('nP_BirthPlace').AsString;
//     lblbirthcity.Caption := FieldByName('P_BirthPlace').AsString;
     lblBirthDate.caption := FieldByName('nP_BirthDate').AsString;
     lblContractDate.Caption := FieldByName('P_ContractDate').AsString;
     lblContractEndDate.Caption := FieldByName('P_ContractEndDate').AsString;
     lbladdress.Caption := FieldByName('nP_address').AsString;
     case FieldByName('nP_IsMarried').AsInteger of
       0: lblteahol.Caption := ('„Ã—œ');
       1: lblteahol.Caption := ('„ «Â·');
       2: lblteahol.Caption := ('„ÿ·ﬁÂ');
       else lblteahol.Caption := '';
     end;
     lblHometel.Caption := FieldByName('nP_HomeTel').AsString;
     lblWorkTel.Caption := FieldByName('nP_WorkTel').AsString;
     lblMobile.Caption := FieldByName('nP_Mobile').AsString;
     lblNation.Caption := FieldByName('nP_Nation').AsString;
     lblPost.Caption := FieldByName('nP_Post').AsString;
     lblAccountNo.Caption := FieldByName('P_AccountNo').AsString;

     case FieldByName('P_AccountType').AsInteger of
       0: lblAccountType.Caption := ('Ã«—Ì');
       1: lblAccountType.Caption := ('Å” «‰œ«“');
       else lblAccountType.Caption := '';
     end;

     lblContractNo.Caption := FieldByName('P_ContractNo').AsString;
     lblAccountBranch.Caption := FieldByName('P_AccountBranch').AsString;
     lblDeposite.Caption := FieldByName('P_Deposite').AsString;
     if FieldByName('P_Deposite').AsString <> '' then
       DepositeSum := DepositeSum + StrToFloat(FieldByName('P_Deposite').AsString);

     lblBimeh.Caption := FieldByName('P_Bimeh').AsString;
     if FieldByName('P_Bimeh').AsString <> '' then
       BimehSum := BimehSum + StrToFloat(FieldByName('P_Bimeh').AsString);

     lblBlockDate.Caption := FieldByName('P_BlockDate').AsString;
     lblBlockDesc.Caption := FieldByName('P_BlockDesc').AsString;

     case FieldByName('c_Type').AsInteger of
       0: lblBoxType.Caption := ('òÊçò');
       1: lblBoxType.Caption := ('„ Ê”ÿ');
       2: lblBoxType.Caption := ('»“—ê');
       else lblBoxType.Caption := '';
     end;

     if FieldByName('P_IsColleague').Asboolean then
       lblColleague.Caption := ('»·Ì')
     else
       lblColleague.Caption := ('ŒÌ—');

     if FindField('C_Code')<> nil then
       lblBox.Caption := FieldByName('C_Code').AsString
     else
       lblBox.Caption := '';

     lblBoxPlace.Caption :=  FieldByName('C_Place').AsString;
  end;
end;

procedure TqrptPersons.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblDepositeSum.Caption := FloatToStr(DepositeSum);
  lblBimehSum.Caption := FloatToStr(BimehSum);
end;

procedure TqrptPersons.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  radif:=0;

  lblCoName.Font.Name := F_Params.RptTitleFont;
  lblCoName.Font.Size := F_Params.RptTitleFntSize;
  lblName.Font.Name := F_Params.RptTitleFont;
  lblName.Font.Size := F_Params.RptTitleFntSize;
  bndSum.Font.Name := F_Params.RptTitleFont;
  bndSum.Font.Size := F_Params.RptTitleFntSize;
  Font.Name := F_Params.RptFont;
  Font.Size := F_Params.RptFntSize;

  hl01.Left := 2;
  hl01.Top := -1;
  hl01.Width := btnHead.Width - 3;
  hl02.Left := hl01.Left;
  hl02.Top := btnHead.Height;
  hl02.Width := hl01.Width;
  hl03.Left := hl01.Left;
  hl03.Top := hl01.Top;
  hl03.Width := hl01.Width;
  hl04.Left := hl01.Left;
  hl04.Top := btnTitle.Height;
  hl04.Width := hl01.Width;
  hl05.Left := hl01.Left;
  hl05.Top := hl01.Top;
  hl05.Width := hl01.Width;
  hl06.Left := hl01.Left;
  hl06.Top := hl01.Top;
  hl06.Width := hl01.Width;
  hl07.Left := hl01.Left;
  hl07.Top := 31;
  hl07.Width := hl01.Width;
  DepositeSum := 0;
  BimehSum := 0;
end;

procedure TqrptPersons.btnHeadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  btnTitle.Enabled := False;
end;

end.
