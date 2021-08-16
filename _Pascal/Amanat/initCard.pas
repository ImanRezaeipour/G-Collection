unit initCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, DB, ADODB, ExtCtrls, ComCtrls,
  Globals,Online;

type
  TfrmInitCard = class(TForm)
    grpCom: TGroupBox;
    btnTestLink: TBitBtn;
    grpAll: TGroupBox;
    dbgPersons: TDBGrid;
    btnCharge: TBitBtn;
    cmdClose: TBitBtn;
    cmdHelp: TBitBtn;
    cmdDelete: TBitBtn;
    cmdNew: TBitBtn;
    lbl1: TLabel;
    cmbReaders: TComboBox;
    adoQry: TADOQuery;
    dtaSrc: TDataSource;
    adoQryEmpl_No: TWideStringField;
    adoQryEmpl_ID: TWideStringField;
    adoQryEmpl_Name: TWideStringField;
    adoQryEmpl_Family: TWideStringField;
    adoQrystatus: TStringField;
    adoQryEmpl_Active: TBooleanField;
    adoQryEmpl_Department: TIntegerField;
    adoQryEmpl_CoPost: TIntegerField;
    adoQryEmpl_Part: TIntegerField;
    adoQryEmpl_Dscnt: TIntegerField;
    adoQryEmpl_ExpDate: TWideStringField;
    adoQryEmpl_Balance: TBCDField;
    tmrReadCard: TTimer;
    BTNcANCEL: TBitBtn;
    prgrs: TProgressBar;
    Bevel1: TBevel;
    Label1: TLabel;
    lbl2: TLabel;
    txtSearchCode: TEdit;
    txtSearchFamily: TEdit;
    chkPrint: TCheckBox;
    lblRecNo: TLabel;
    lblInfo: TLabel;
    chkPass: TCheckBox;
    procedure txtSearchCodeKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPersonsTitleClick(Column: TColumn);
    procedure adoQryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure BTNcANCELClick(Sender: TObject);
    procedure tmrReadCardTimer(Sender: TObject);
    procedure tmrCancelTimer(Sender: TObject);
    procedure btnChargeClick(Sender: TObject);
    procedure adoQryCalcFields(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure btnTestLinkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateList;
    function unPackPosPacket(PK : string): TEmployee;
    function MakePosPacket(doPrint : boolean ;CardInfo  : TEmployee): String;
    procedure printInfo(rec : TEmployee);
  private
    selected : string;
    DoRead : boolean;
    { Private declarations }
    _RecCount : integer;
  public
    { Public declarations }
  end;
var
  frmInitCard: TfrmInitCard;
implementation
uses
  Keyboard, DateProc, MSGs, RunCmnds, Funcs, FntSel, DBS, Select,
  ComTools, Z84_cmd, Code_Sys;

{$R *.dfm}

procedure TfrmInitCard.FormCreate(Sender: TObject);
var
  i : integer;
begin
  SetFontColor(TForm(frmInitCard));
  if rdrCount > 0 then
    for i := 0 to rdrCount-1 do
//      if Readers[i].R_Model = RDR_INITCARD then
      cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);

  IF cmbReaders.Items.Count > 0 THEN
    cmbReaders.ItemIndex := 0;

  adoQry.Connection := frmDBS.adoConnect;

  UpdateList;
  doread := false;
  prgrs.Position := 0;
  lblRecNo.Caption := (' ⁄œ«œ : ' + IntToStr(adoQry.RecordCount));
  _RecCount := adoQry.RecordCount;
end;
procedure TfrmInitCard.UpdateList;
begin
  adoQry.Close;
  with adoQry.SQL do
  begin
    Clear;
    Add('select * from Employee');
    Add('where Empl_ID = '''' OR Empl_ID = ''00000000''');
    if selected <> '' then
      Add('or Empl_No in (' + selected + ')');
  end;
  adoQry.Open;
end;
procedure TfrmInitCard.btnTestLinkClick(Sender: TObject);
var
  a,b : integer;
begin
//  a := pos ('-' , cmbReaders.Text)-1;
//  b := strtoint(COPY(cmbReaders.Text , 1,a));
  if LinkTest(readers[cmbReaders.itemindex]) then
    InformationMessage('«— »«ÿ »—ﬁ—«— «” ')
  else
    InformationMessage('«— »«ÿ ﬁÿ⁄ „Ì »«‘œ');
end;

procedure TfrmInitCard.cmdDeleteClick(Sender: TObject);
var
  delItem : &string;
  posItem : integer;
begin
  if ConfirmMessage('¬Ì« »« Õ–› ‰«„ «Ì‰ ›—œ «“ ·Ì”  ’œÊ— ò«—  „Ê«›ﬁÌœ ø') then
  begin
    if adoQry.FieldByName('status').AsString = 'Å—”‰· ÃœÌœ' then
      ErrorMessage('«„ò«‰ Õ–› «›—«œ ÃœÌœ «“ ·Ì”  ’œÊ— ò«—  «„ò«‰ Å–Ì—  ‰„Ì»«‘œ .' + #13 + '»—«Ì Õ–› «Ì‰ «›—«œ «“ ·Ì”  œ— ﬁ”„  „⁄—›Ì Å—”‰· , ¬‰Â« —« «“ Õ«·   ›⁄«· Œ«—Ã ò‰Ìœ ')
    else
    begin
      delItem := adoQry.FieldByName('Empl_No').AsString;
      posItem := Pos(''''+delItem+'''' , selected);
      if posItem <> 0 then
        Delete(selected , posItem , length(selected));
      UpdateList;
    end;
  end;
  lblRecNo.Caption := (' ⁄œ«œ : ' + IntToStr(adoQry.RecordCount));
end;

procedure TfrmInitCard.cmdNewClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelect, frmSelect);
  frmSelect.selType := SEL_PRS;
  if frmSelect.ShowModal = mrOK then
    selected := frmSelect.dataSelected
  else
    selected := '';
  UpdateList;
  frmSelect.Free;
  lblRecNo.Caption := (' ⁄œ«œ : ' + IntToStr(adoQry.RecordCount));
end;

procedure TfrmInitCard.adoQryCalcFields(DataSet: TDataSet);
begin
  if DelLeftZero(adoQry.fieldByName('empl_ID').AsString) = '' then
    adoQry.fieldByName('status').AsString := 'Å—”‰· ÃœÌœ'
  else
    adoQry.fieldByName('status').AsString := 'ò«—  «·„À‰Ì';


end;

procedure TfrmInitCard.btnChargeClick(Sender: TObject);
begin
  ComPortInitial(Readers[cmbreaders.itemindex]);
  if _RecCount = 0 then
  begin
    txtSearchCode.Text := '';
    txtSearchCode.SetFocus;
    exit;
  end;
  prgrs.Position := 0;
  tmrReadCard.Enabled := true;
  grpCom.Enabled := false;
  grpAll.Enabled := false;
end;

procedure TfrmInitCard.tmrCancelTimer(Sender: TObject);
begin
  doread := false;
end;
function TfrmInitCard.unPackPosPacket(PK : string): TEmployee;
var
  NameFamily : ansiString;
  dashPos : integer;
begin
  Result.EmplID     := PBCD_Str(Copy(PK, 2, 4),8);
  Result.EmplCode   := DelLeftZero(PBCD_Str(Copy(PK, 6, 6),12));
  Result.EmplPass   := PBCD_Str(Copy(PK, 12, 2),4);
//kaveh  Result.LastCharge := BeautifulDate(inttostr(ord(PK[14])) + '/' + inttostr(ord(PK[15])) + '/' + inttostr(ord(PK[16])));
  Result.LastChargeCode :=(ord(PK[15]))*100 +(ord(PK[16])); //kaveh
  Result.ExpireDate := BeautifulDate(inttostr(ord(PK[17])) + '/' + inttostr(ord(PK[18])) + '/' + inttostr(ord(PK[19])));

  NameFamily        := IR_To_Win(WIN_MICROSOFT_SYS,Copy(PK, 20, 32));
  dashPos           := pos('-',NameFamily);
  Result.EmplName   := Copy(NameFamily, 1, dashPos-1);
  Result.EmplFamily := Copy(NameFamily, dashPos+1 ,length(NameFamily)-dashPos);
  Result.Credit     := StrToInt64('$' +PBCD_Str(StrRev(Copy(PK, 52, 4)),8));
  if IsNumeric(PBCD_Str(Copy(PK, 56, 4),8)) then
    Result.Emplpart   := StrToInt(PBCD_Str(Copy(PK, 56, 4),8));
end;

function TfrmInitCard.MakePosPacket(doPrint : boolean ;CardInfo  : TEmployee): String;
begin
  if doPrint then
    result := #$22
  else
    result := #$11;
  result := result + Str2PBCD(FixLeft(CardInfo.EmplID,'0',8));
  result := result + Str2PBCD(FixLeft(CardInfo.EmplCode,'0',12));
  result := result + Str2PBCD(fixLeft(CardInfo.EmplPass,'0',4));
{//kaveh
  if Length(CardInfo.LastCharge) = 10 then
    result := result + Str2PBCD(IntToHex(strtoint(copy(CardInfo.LastCharge,3,2)),2) + IntToHex(strtoint(copy(CardInfo.LastCharge,6,2)),2) + IntToHex(strtoint(copy(CardInfo.LastCharge,9,2)),2))
  else
    result := result + #$00#$00#$00;
//kaveh}
//kavhe is
  if CardInfo.LastChargeCode > 0 then
    result := result + #$00 + Str2PBCD(IntToHex(CardInfo.LastChargeCode div 100,2)) + Str2PBCD(IntToHex(CardInfo.LastChargeCode mod 100,2))
  else
    result := result + #$00#$00#$00;
//kavhe ie
  if Length(CardInfo.ExpireDate) = 10 then
  begin
    if CardInfo.ExpireDate = 'FFFF/FF/FF' then
      result := result + #$FF#$FF#$FF
    else
      result := result + Str2PBCD(IntToHex(strtoint(copy(CardInfo.ExpireDate,3,2)),2) + IntToHex(strtoint(copy(CardInfo.ExpireDate,6,2)),2) + IntToHex(strtoint(copy(CardInfo.ExpireDate,9,2)),2))
  end
  else
    result := result + #$00#$00#$00;
  result := result + FixRight(Win_To_IR(WIN_MICROSOFT_SYS,CardInfo.EmplName + '-' + CardInfo.EmplFamily),#0,32);
  result := result + Str_PBCD(IntToHex(strtoint((CurrToStr(cardInfo.Credit))),8),8);
  result := result + Str2PBCD(FixLeft(IntToStr(CardInfo.EmplPart),'0',8));

  result := result + Str_PBCD(IntToHex(strtoint((CurrToStr(cardInfo.MoRangePrice))),8),8); //kaveh
  result := result + Str_PBCD(IntToHex(strtoint((CurrToStr(cardInfo.MoRangeRemain))),8),8); //kaveh
  result := result + Str2PBCD(IntToHex(CardInfo.MoRangeMonth,2)); //kaveh
  result := result + Str2PBCD(IntToHex(CardInfo.MoRangeDay,2)); //kaveh
  if CardInfo.MoRangeDelRemain then
    result := result + Str2PBCD(FixLeft('1','0',2)) //kaveh
  else
    result := result + Str2PBCD(FixLeft('0','0',2)); //kaveh
end;

procedure TfrmInitCard.tmrReadCardTimer(Sender: TObject);
  var
    Rec ,RecWrite : TEmployee;
    i : integer;
    retVal, Status : Byte;
    PK, NameFamily , dta : String;
    cmdNo, St : String;
    OK : Boolean;

    ParkTime : LongInt;
    m, d, h, mn : Byte;
    Special : Byte;
    
begin
  prgrs.Position := prgrs.Position + 1;
  if (prgrs.Position = 10) then
  begin
    prgrs.Position := 0;
    tmrReadCard.Enabled := false;
    grpCom.Enabled := true;
    grpAll.Enabled := true;
  end
  else
  begin
    lblInfo.Caption := '';
    cmdNo := #$18;
    Z84_GetCardRecord(59, retVal, PK);
    if retVal = MB_TRUEREC then
      case Ord(PK[6]) of
        $11: {Valid Card}
        begin
            Rec := unPackPosPacket(copy(PK,6,59));
            BTNcANCEL.Click;
            if (length(rec.EmplCode) <> 8) or ((length(rec.EmplCode) = 8) and
               ConfirmMessage(
                               'Card No : '        +  Rec.EmplID           + #13 +
                               'Employee Code : '  +  Rec.EmplCode         + #13 +
                               'Employee Name : '  +  Rec.EmplName         + #13 +
                               'Part Code : '      +  inttostr(Rec.EmplPart)+ #13 +
                               'Employee Family : '+  Rec.EmplFamily       + #13 +
//kaveh                               'Last Charge : '    +  Rec.LastCharge       + #13 +
                               'Last Charge Code: '+  IntToStr(Rec.LastChargeCode)+ #13 + //kaveh
                               'Expire Date : '    +  Rec.ExpireDate       + #13 +
                               'Credit : '         +  CurrToStr(Rec.Credit)+ #13 +
                               'Pass : '           +  Rec.EmplPass
                             ))
            then
            begin
              with frmDBS.adoQryG do
              begin
                Close;
                SQL.Clear;
                sql.Add('select * from Employee where Empl_ID = ''' + rec.EmplID + '''');
                Open;
                while not eof do
                begin
                  Edit;
                  FieldByName('Empl_ID').AsString := '00000000';
                  post;
                  next;
                end;
                close;
              end;
              RecWrite.EmplID     := rec.EmplID;
              RecWrite.EmplCode   := adoQry.FieldByName('Empl_No').AsString;
              RecWrite.EmplName   := adoQry.FieldByName('Empl_Name').AsString;
              RecWrite.EmplFamily := adoQry.FieldByName('Empl_Family').AsString;
//kaveh              RecWrite.LastCharge := '0000/00/00';//CurrentDate;
              RecWrite.LastChargeCode := 0;//CurrentDate;  //kaveh
              RecWrite.ExpireDate := 'FFFF/FF/FF';
              Randomize;
              repeat
                RecWrite.EmplPass   := fixleft(IntToStr(Random(9999)),'0',4);
              until RecWrite.EmplPass > '1000';

              if  chkPass.Checked then
                if length(RecWrite.EmplCode) > 4 then
                  RecWrite.EmplPass := copy(RecWrite.EmplCode,length(RecWrite.EmplCode)-3,4);

              RecWrite.EmplPart   := adoQry.FieldByName('Empl_Part').AsInteger;
              RecWrite.Credit     := StrToCurr('0');

              RecWrite.Credit := CalculBalance(RecWrite.EmplCode,'',CurrentDate, RecWrite.LastCharge, RecWrite.LastChargeCode); //kaveh
              UpdateAllChargeRecords(RecWrite.EmplCode, curRdrCode, CurrentDate); //kaveh
              RecWrite.MoRangeRemain := CalculMoRangeBalance(RecWrite.EmplCode, {CurrentDate,} RecWrite.LastCharge, { RecWrite.Credit,} RecWrite.MoRangePrice, RecWrite.MoRangeMonth, RecWrite.MoRangeDay, RecWrite.MoRangeDelRemain); //kaveh

              dta := MakePosPacket(chkPrint.Checked,RecWrite);
              Z84_MakePocket(PK ,curRdrCode ,$1D ,0 ,dta);
              if not SendPocket(PK) then
                OK := False
              else
              begin
                Z84_GetPocket(PK, 8, 400, retVal);
                if (retVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) =  curRdrCode) then
                begin
                  case Ord(PK[6]) of
                    00 : InformationMessage('‰«„Ê›ﬁ');
                    01 :
                      begin
                        with adoQry do
                        begin
                          edit;
                          FieldByName('EMPL_ID').asstring := rec.EmplID;
                          post;
                          Requery([]);
                        end;

                        lblinfo.Caption := 'ò«—  »« „Ê›ﬁÌ  òœ ‘œ .';
//                      printInfo(recWrite);
                        txtSearchCode.Text := '';
                        txtSearchCode.SetFocus;
                      end;
                    02 : InformationMessage('·€Ê ⁄„·Ì«   Ê”ÿ ò«—»—');
                    03 : InformationMessage('ò«—  €Ì— „⁄ »—');
                  end
                end
                else
                  InformationMessage('«‘ò«· œ— «— »«ÿ ...');
              end;
            end;
        end;
        $22: {inValid Card}
        begin
          BTNcANCEL.Click;
          ErrorMessage('ò«—  ‰«„⁄ »— «”  !');
        end;
      end;
  end;


//  prgrs.Position := prgrs.Position +1;
//  if (prgrs.Position = 10) then
//  begin
//    prgrs.Position := 0;
//    tmrReadCard.Enabled := false;
//    grpCom.Enabled := true;
//    grpAll.Enabled := true;
//  end
//  else
//  begin
//    lblInfo.Caption := '';
//    cmdNo := #$18;
//    Z84_GetCardRecord(59, retVal, PK);
//    if retVal = MB_TRUEREC then
//      case Ord(PK[6]) of
//        $11: {Valid Card}
//        begin
//            Rec := unPackPosPacket(copy(PK,6,59));
//            BTNcANCEL.Click;
//            if (length(rec.EmplCode) <> 8) or ((length(rec.EmplCode) = 8) and
//               ConfirmMessage(
//                               'Card No : '        +  Rec.EmplID           + #13 +
//                               'Employee Code : '  +  Rec.EmplCode         + #13 +
//                               'Employee Name : '  +  Rec.EmplName         + #13 +
//                               'Part Code : '      +  inttostr(Rec.EmplPart)+ #13 +
//                               'Employee Family : '+  Rec.EmplFamily       + #13 +
//                               'Last Charge : '    +  Rec.LastCharge       + #13 +
//                               'Expire Date : '    +  Rec.ExpireDate       + #13 +
//                               'Credit : '         +  CurrToStr(Rec.Credit)+ #13 +
//                               'Pass : '           +  Rec.EmplPass
//                             ))
//            then
//            begin
//              with frmDBS.adoQryG do
//              begin
//                Close;
//                SQL.Clear;
//                sql.Add('select * from Employee where Empl_ID = ''' + rec.EmplID + '''');
//                Open;
//                while not eof do
//                begin
//                  Edit;
//                  FieldByName('Empl_ID').AsString := '00000000';
//                  post;
//                  next;
//                end;
//                close;
//              end;
//              RecWrite.EmplID     := rec.EmplID;
//              RecWrite.EmplCode   := adoQry.FieldByName('Empl_No').AsString;
//              RecWrite.EmplName   := adoQry.FieldByName('Empl_Name').AsString;
//              RecWrite.EmplFamily := adoQry.FieldByName('Empl_Family').AsString;
//              RecWrite.LastCharge := '0000/00/00';//CurrentDate;
//              RecWrite.ExpireDate := 'FFFF/FF/FF';
//              Randomize;
//              repeat
//                RecWrite.EmplPass   := fixleft(IntToStr(Random(9999)),'0',4);
//              until RecWrite.EmplPass > '1000';
//
//              if  chkPass.Checked then
//                if length(RecWrite.EmplCode) > 4 then
//                  RecWrite.EmplPass := copy(RecWrite.EmplCode,length(RecWrite.EmplCode)-3,4);
//
//              RecWrite.EmplPart   := adoQry.FieldByName('Empl_Part').AsInteger;
//              RecWrite.Credit     := StrToCurr('0');
//
//              RecWrite.Credit := CalculBalance(RecWrite.EmplCode,'',CurrentDate, RecWrite.LastCharge); //kaveh
//
//              dta := MakePosPacket(chkPrint.Checked,recWrite);
//              Z84_MakePocket(PK ,curRdrCode ,$1D ,0 ,dta);
//              if not SendPocket(PK) then
//                OK := False
//              else
//              begin
//                Z84_GetPocket(PK, 8, 400, retVal);
//                if (retVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) =  curRdrCode) then
//                begin
//                  case Ord(PK[6]) of
//                    00 : InformationMessage('‰«„Ê›ﬁ');
//                    01 :
//                      begin
//                        with adoQry do
//                        begin
//                          edit;
//                          FieldByName('EMPL_ID').asstring := rec.EmplID;
//                          post;
//                          Requery([]);
//                        end;
//
//                        lblinfo.Caption := 'ò«—  »« „Ê›ﬁÌ  òœ ‘œ .';
////                      printInfo(recWrite);
//                        txtSearchCode.Text := '';
//                        txtSearchCode.SetFocus;
//                      end;
//                    02 : InformationMessage('·€Ê ⁄„·Ì«   Ê”ÿ ò«—»—');
//                    03 : InformationMessage('ò«—  €Ì— „⁄ »—');
//                  end
//                end
//                else
//                  InformationMessage('«‘ò«· œ— «— »«ÿ ...');
//              end;
//            end;
//        end;
//        $22: {inValid Card}
//        begin
//          BTNcANCEL.Click;
//          ErrorMessage('ò«—  ‰«„⁄ »— «”  !');
//        end;
//      end;
//  end;

end;

function tabdil(st:string):string;
begin
    st:=AlphaReverse(st);
    st:=StrRev(WinToDos(st, WIN_MICROSOFT_SYS, DOS_IR_SYS));
    tabdil:=st;
end;

procedure TfrmInitCard.printInfo(rec : TEmployee);
var
   st:string;
   ok:boolean;
begin
  gParams.PrnType := PRN_ITHACA;
  gParams.Linefeed := 0;
//  curRdrCode := 10;
  ComPortInitial(Readers[1]);
  st:=' ⁄«Ê‰Ì ›—Â‰êÌ«‰ «” «‰ Â—„“ê«‰';
  st:=tabdil(st);
  st:=fixLeft(st,' ',35);
  ok:=sendprint(st,false,false);
  if ok
  then begin
       st:='----------------------------------------';
       ok:=sendprint(st,false,false);
  end;
  if ok
  then begin
       st:= rec.EmplName + '-' + rec.EmplFamily;
       st:=tabdil(st);
       st:=fixLeft(st,' ',40);
       ok:=sendprint(st,false,false);
  end;
//  if ok
//  then begin
//       st:='----------------------------------------';
//       ok:=sendprint(st,false,false);
//  end;
  if ok
  then begin
       st:= '‘„«—Â Å—”‰·Ì'  + ' -- ' + rec.EmplCode + 'òœ ò«—  ' + rec.EmplID;
       st:=tabdil(st);
//       st:=fixLeft(st,' ',40);
       ok:=sendprint(st,false,true);
  end;
//  if ok
//  then begin
//       st:='----------------------------------------';
//       ok:=sendprint(st,false,false);
//  end;
  if ok
  then begin
       st:= 'òœ ‰«ÕÌÂ'  + ' -- ' + IntToStr(rec.EmplPart) + ' «—ÌŒ ’œÊ—' + rec.LastCharge;
       st:=tabdil(st);
       st:=fixLeft(st,' ',40);
       ok:=sendprint(st,false,false);
  end;
  if ok
  then begin
       st:='----------------------------------------';
       ok:=sendprint(st,false,false);
  end;
  if ok
  then begin
       st:= '—„“ ⁄»Ê—  ' + rec.EmplPass;;
       st:=tabdil(st);
       st:=fixLeft(st,' ',15);
       ok:=sendprint(st,True,true);
       cutprint(gparams.prntype,ok);
  end;
end;
procedure TfrmInitCard.BTNcANCELClick(Sender: TObject);
begin
  prgrs.Position := 0;
  tmrReadCard.Enabled := FALSE;
  grpCom.Enabled := true;
  grpAll.Enabled := true;
end;

procedure TfrmInitCard.adoQryFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  emplCode , emplFamily : string;
begin
  if (txtSearchCode.Text = '') and (txtSearchFamily.Text = '') then
    exit;

  emplCode   := DataSet.FieldByName('Empl_No').AsString;
  emplFamily := DataSet.FieldByName('Empl_Family').AsString;
  if (pos(txtSearchCode.Text , emplCode) <> 0) or (pos(txtSearchFamily.Text , emplFamily) <> 0) then
    Accept := true
  else
  begin
    dec(_RecCount);
    Accept := False;
  end;
end;

procedure TfrmInitCard.dbgPersonsTitleClick(Column: TColumn);
var
  i : integer;
begin
  if Column.FieldName = 'status' then
    if pos('empl_ID',adoQry.Sort) <> 0 then
      if pos(' ASC',adoQry.Sort) <> 0 then
        adoQry.Sort := 'empl_ID DESC'
      else
        adoQry.Sort := 'empl_ID ASC'
    else
        adoQry.Sort := 'empl_ID ASC'
  else
    if pos(Column.FieldName,adoQry.Sort) <> 0 then
      if pos(' ASC',adoQry.Sort) <> 0 then
        adoQry.Sort := Column.FieldName + ' DESC'
      else
        adoQry.Sort := Column.FieldName + ' ASC'
    else
        adoQry.Sort := Column.FieldName + ' ASC';

  with dbgPersons do
  begin
    for i := 0 to Columns.Count - 1 do
      Columns[i].color := clWhite;
  end;
  Column.Color := clInfoBk;

end;
procedure TfrmInitCard.txtSearchCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if (key <> #13) then exit;
  _RecCount := adoQry.RecordCount;
  if Length(txtSearchCode.Text)= 13 then
    txtSearchCode.Text := copy(txtSearchCode.Text,5,8);

  if adoQry.Locate('empl_No' , fixleft(txtSearchCode.Text,'0',8),[loPartialKey]) then
  begin
  //  adoQry.Filtered := False;
  //  adoQry.Filtered := True;
    lblRecNo.Caption := (' ⁄œ«œ : ' + IntToStr(_RecCount));
    btnCharge.Click;
  end;
end;

end.

