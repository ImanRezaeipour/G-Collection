unit Online;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, XStringGrid, StdCtrls, Buttons, ExtCtrls,DBS;

type
  TfrmOnline = class(TForm)
    grd: TXStringGrid;
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    lblReader: TLabel;
    Panel1: TPanel;
    lblservice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;

var
  frmOnline: TfrmOnline;

function  sendprint(st:string;DblWidth, Clr : Boolean):boolean;
//procedure ViewRecord(receipt : TReceipt; errCode : Byte);
//procedure ProcessOnline(readerIndex : Byte);

implementation

uses
  Funcs, Globals, RunCmnds, ComTools, dateProc, Code_Sys, FntSel, z84_cmd;

{$R *.dfm}
function tabdil(st:string):string;
begin
    st:=AlphaReverse(st);
    st:=StrRev(WinToDos(st, WIN_MICROSOFT_SYS, DOS_IR_SYS));
    tabdil:=st;
end;

function sendprint(st:string;DblWidth, Clr : Boolean):boolean;
begin
    st:=st+#13#10;
    case gParams.PrnType of
    PRN_LX:
    begin
      ST := #27#120#0 + ST;
      if DblWidth then ST := #14 + ST;
    end;

    PRN_LQ:
    begin
      ST := #27#120#1 + ST;
      if DblWidth then ST := #14 + ST;
    end;

    PRN_CITIZEN3551,
    PRN_CITIZEN3541:
    begin
      ST := #27'1' + ST;
      if DblWidth then ST := #14 + ST + #20;
      if Clr then
      begin
        if GParams.PrnType = PRN_CITIZEN3551 then
          ST := #27'4' + ST + #27'5'
        else
          ST := #$13+ST;
      end;
    end;

    PRN_ITHACA:
    begin
      if DblWidth then ST := #27'W'#1 + ST + #27'W'#0;
      if Clr then
        ST := #27'c'#1 + ST
      else
        ST := #27'c'#0 + ST;
    end;
  end;
  sendprint:=z84_PrintToReader(st);
end;

//procedure ViewRecord(receipt : TReceipt; errCode : Byte);
//var
//   i,j: integer;
//   st:string;
//   ok:boolean;
//begin
//  with frmOnline.grd do
//  begin
//    RowCount := RowCount+1;
//    if FixedRows = 0 then
//      FixedRows := 1;
//
//    Row := RowCount-1;
//
//    Cells[0, Row] := GetReaderName(receipt.recit_rdrCode);
//    Cells[1, Row] := receipt.recit_EmplNo;
//    Cells[2, Row] := receipt.recit_Onvan;
//    Cells[3, Row] := FloatToStr(receipt.recit_TotalPrc);
//    {if errcode<>3
//    then }Cells[4, Row] := FloatToStr(receipt.recit_BefCred - receipt.recit_Credit)
//    {else Cells[4, Row] := FloatToStr(receipt.recit_BefCred )};
//    Cells[5, Row] := receipt.recit_Time;
//    Cells[6, Row] := (ReceiptErrorStr(errCode));
//    st:='';
//    frmOnline.lblservice.caption:='    ';
//    for i := 1 to MAX_SERVICE_SEL do
//    if receipt.recit_Srvcs[i].SS_SrvcNo>0
//    then begin
//       st:=st+ GetServiceName(receipt.recit_Srvcs[i].SS_SrvcCode)
//             +' '+ inttostr(receipt.recit_Srvcs[i].SS_SrvcNo)+' ';
//       frmOnline.lblservice.caption:=frmOnline.lblservice.caption
//             + GetServiceName(receipt.recit_Srvcs[i].SS_SrvcCode)
//             +' '+ inttostr(receipt.recit_Srvcs[i].SS_SrvcNo)
//             +' '+ GetServiceUnit(receipt.recit_Srvcs[i].SS_SrvcCode)+' ';
//    end;
//    Cells[7, Row] := st;
//    if Cells[6, Row]<>'' then frmOnline.lblservice.caption:=Cells[6, Row];
//  end;
//  with frmOnline.grd do
//  if GParams.printfish
//  then {if Cells[6, Row]<>''
//  then if receipt.recit_TotalPrc>0
//  then } if errcode=1
//  then begin
//    ok:=true;
//    if ok
//    then begin
//         st:=gOptions.CoName;
//         st:=tabdil(st);
//         st:=fixright(st,' ',30);
//         ok:=sendprint(st,false,false);
//    end;
//    if ok
//    then begin
//         st:= tabdil(cells[5,row])
//             +tabdil(('  ÒãÇä  '))
//             +tabdil(currentdate)
//             +'  '+tabdil(('ÊÇÑíÎ'));
//         ok:=sendprint(st,false,false);
//    end;
//    if ok
//    then begin
//         st:=tabdil(fixright(UpperCase(gOptions.UserName),' ',23))
//            +'  '+tabdil(('ßÇÑÈÑ'));
//         ok:=sendprint(st,false,false);
//    end;
//    if ok
//    then begin
//         st:=('ÏÓÊÇå ')+cells[0,row];
//         st:=tabdil(st);
//         st:=fixright(st,' ',30);
//         ok:=sendprint(st,false,false);
//    end;
//    if ok
//    then begin
//         st:=('Ô ')+cells[1,row]+(' ')+cells[2,row];
//         st:=tabdil(st);
//         st:=fixright(st,' ',30);
//         ok:=sendprint(st,false,false);
//    end;
//    if ok
//    then begin
//         st:='- - - - - - - - - - - - - - - -';
//         ok:=sendprint(st,false,false);
//    end;
//    for i := 1 to MAX_SERVICE_SEL do
//    if ok then
//    if receipt.recit_Srvcs[i].SS_SrvcNo>0
//    then begin
//       st:= tabdil(FixRight(GetServiceUnit(receipt.recit_Srvcs[i].SS_SrvcCode),' ',7))
//           +' '+ tabdil(fixright(inttostr(receipt.recit_Srvcs[i].SS_SrvcNo),' ',4))
//           +' '+ tabdil(fixLeft(GetServiceName(receipt.recit_Srvcs[i].SS_SrvcCode)+'                ',' ',17));
//       ok:=sendprint(st,false,false);
//    end;
//
//    with frmOnline.grd do
//    begin
//      if ok
//      then begin
//         st:='-- - - - - - - - - - - - - - -';
//           ok:=sendprint(st,false,false);
//      end;
//      if ok
//      then begin
//           st:=tabdil((' ÑíÇá'))
//              +tabdil(fixright(cells[3,row],' ',12))
//              +tabdil(('ÌãÚ ÎÏãÇÊ    '));
//           ok:=sendprint(st,false,false);
//      end;
//      if ok
//      then begin
//           st:=tabdil((' ÑíÇá'))
//           +tabdil(fixright(cells[4,row],' ',12))
//           +tabdil(('ãÇäÏå ÇÚÊÈÇÑ '));
//           ok:=sendprint(st,false,false);
//      end;
//    end;
//    for i:=1 to GParams.Linefeed do
//      if ok then ok:=z84_PrintToReader(#10);
//    if ok then cutprint(gparams.prntype,ok);
//  end;
//end;

//procedure ProcessOnline(readerIndex : Byte);
//var
//  data : String;
//  retVal, i  : Byte;
//  receipt : TReceipt;
//begin
//  frmOnline.lblReader.Caption := ('ßÇÑÊÎæÇä : ') + Readers[readerIndex].R_Name +'        ' +CurrentTimes;
//  retVal := ReadOnLineRec(Readers[readerIndex], data);
//  case retVal of
//    MB_TRUEREC:
//    begin
//      for i := 1 to MAX_SERVICE_SEL do
//        receipt.recit_Srvcs[i].SS_SrvcCode := 0;
//
//      receipt.recit_Date := BeautifulDate(Copy(data, 6, 2) + '/' +
//                                          Copy(data, 8, 2) + '/' +
//                                          Copy(data, 10, 2));
//      receipt.recit_Time := BeautifulTime(Copy(data, 12, 2) + ':' +
//                                          Copy(data, 14, 2));
//      receipt.recit_EmplNo := DelLeftZero(Copy(data, 16, 8));
//      receipt.recit_rdrCode := StrToInt(Copy(data, 1, 3));
//      receipt.recit_PayType := PAY_CREDIT;
//      Delete(data, 1, 23);
//      i := 0;
//      while Length(data) >= 3 do
//      begin
//        Inc(i);
//        receipt.recit_Srvcs[i].SS_SrvcCode := Ord(data[1]);
//        receipt.recit_Srvcs[i].SS_SrvcNo := Ord(data[2]) + (Ord(data[3]) * 256);
//        Delete(data, 1, 3);
//      end;
//      receipt.recit_Depart := gParams.department;
//      retVal := CardReciet(receipt);
//      ViewRecord(receipt, retVal);
//      if retVal <> ERR_NONE then
//      begin
//        data := ReceiptErrorStr(retVal);
//        data := StrRev(WinToDos(data, WIN_MICROSOFT_SYS, DOS_IR_SYS)) + #0;
//      end;
//    end;
//
//    else
//    begin
//      retVal := ERR_NONE;
//      data := '';
//    end;
//
//  end;
//  DelOnlineRec(Readers[readerIndex], retVal, data);
//end;


procedure TfrmOnline.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmOnline));

  Caption := (Caption);
  for i := 0 to grd.ColCount-1 do
    grd.Cells[i, 0] := (grd.Cells[i, 0]);
  lblReader.Caption := (lblReader.Caption);
  btnCancel.Caption := (btnCancel.Caption);
end;

procedure TfrmOnline.FormCreate(Sender: TObject);
begin
  SetWinF;
  Left := (Screen.Width - Width) div 2;
end;

procedure TfrmOnline.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
