unit Cntroler;

interface

Uses
  Controls, SysUtils, Db, AdoDB, Forms, ComTools, MSGs, FarsiApi,
  DateProc, Globals, Code_Sys, DBS;



procedure GetInput(var OK : Boolean);
procedure GetOutPut(var OK : Boolean);
procedure ControlReaders;
procedure CustDisplaySet(Code : Integer; ST : String; var OK : Boolean);
procedure PrintOutput(rdrCode : Byte);


implementation

uses
  RdrStat, RunCmnds, Z84_CMD;


const
  MinCap = 5;




function DelDom(s : String) : String;
var i : Byte;
begin
  i := Pos(#144, S);
  if i <> 0 then
    Delete(s, i, 1);

  i := Pos(#160, S);
  if i <> 0 then
    Delete(s, i, 1);
  DelDom := s;
end;

function CenterText(s : String) : String;
var i, l, r, len : Byte;
begin
  len := Length(s);
  if (len > 0) and (len < 22) then
  begin
    l := (22 - len) div 2;
    r := 22 - len - l;
    for i := 1 to l do s := ' ' + s;
    for i := 1 to r do s := s + ' ';
  end;
  CenterText := s;
end;




procedure GetInput(var OK : Boolean);
//var
//  PK : String;
//  retVal : Byte;
//  Rec : TMachines;
begin
//  Z84_GetLastRecord(retVal, PK);
//  if retVal = MB_BUFFEMPTY then
//  begin
//    Inc(Readers[RdrIndx].BuffEmpty);
//    if Readers[RdrIndx].BuffEmpty >= 5 then
//      Readers[RdrIndx].MaxTimeOff := g_options.MaxOffReader;
//  end
//  else if retVal = MB_TRUEREC then
//  begin
//    if Readers[RdrIndx].BuffEmpty > 0 then
//      Readers[RdrIndx].BuffEmpty := 0;
//
//    case Ord(PK[6]) of
//      0:
//      begin
//        Rec := Z84_AnalizeData(PK);
//        InputCar(Rec);
//        with ReadersLast[RdrIndx] do
//        begin
//          CardNo := Rec.M_BarCode;
//          CarTime := Rec.M_ITime;
//          ParkCost := '';
//          CarNumber := Rec.M_Number;
//          ComTime := CurrentTimes;
//          OP := ('Ê—Êœ ŒÊœ—Ê');
//          ComStat := ('»—ﬁ—«—');
//        end;
//      end;
//
//      2:
//      begin
//        Rec := UndoInCar(BarCode8(Copy(PK, 7, 4)), IntToStr(Ord(PK[3])));
//        with ReadersLast[RdrIndx] do
//        begin
//          CardNo := Rec.M_BarCode;
//          CarTime := Rec.M_ITime;
//          ParkCost := '';
//          CarNumber := Rec.M_Number;
//          ComTime := CurrentTimes;
//          OP := ('«»ÿ«· Ê—Êœ');
//          ComStat := ('»—ﬁ—«—');
//        end;
//      end;
//    end;
//  end;
end;

procedure PrintToReader(ST : String; var OK : Boolean);
var
  PK : String;
  Status, n : Byte;
begin
  if not OK then Exit;
  ST := #27'x'#0 + StrRev(WinToDos(ST, g_options.WinType, DOS_IR_SYS)) + #13#10;
  n := 0;
  repeat
    OK := True;
    Inc(n);
    Z84_MakePocket(PK, curRdrCode, $1C, 0, ST);
    if not SendPocket(PK) then
      OK := False
    else
    begin
      Z84_GetPocket(PK, 7, 50, Status);
      OK := ((Status = ERR_NONE) and (Ord(PK[4]) = $06)  and (Ord(PK[3]) =  curRdrCode));
    end;
  until (n = 2) or OK;
end;

procedure PrintOutput(rdrCode : Byte);
//var
//  St : String;
//  Rec : TMachines;
//  OK : Boolean;
//  i : Byte;
begin
//  OK := True;
//  Rec := LastRec[FindReaderCodeIdx(rdrCode)];
//  if ((Rec.M_Kind and MB_MOTAVARI) = MB_MOTAVARI) or
//     ((Rec.M_Kind and MB_NOTEXIT) = MB_NOTEXIT) or
//     (not Rec.M_ExitValid) then
//    Exit;
//
//  with Rec do
//  begin
//    ST := FixLen(NumReverse(M_CarName) + ' - ' +
//                 NumReverse(M_Color), ' ', 22) + 'M'#27;
//    PrintToReader(ST, OK);
//
//    ST := FixLen(NumReverse(M_Number) + '- ' +
//                 NumReverse(M_CityName) + ' - ' +
//                 NumReverse(M_Serial), ' ', 22);
//    PrintToReader(ST, OK);
//
//    ST := FixLen(('Ê—Êœ: ') + StrRev(M_IDate) + ' ' + StrRev(M_ITime), ' ', 22);
//    PrintToReader(ST, OK);
//
//    ST :=  FixLen(('Œ—ÊÃ: ') + StrRev(M_ODate) + ' ' + StrRev(M_OTime), ' ', 22);
//    PrintToReader(ST, OK);
//
//    Str(Round(M_PayAble):8, ST);
//    ST := FixLen(('Å—œ«Œ Ì ')+ NumReverse(ST)  + (' —Ì«·') , ' ', 22);
//    PrintToReader(ST, OK);
//
//
//    if Remainder <> 0 then
//    begin
//      Str(Round(Remainder):8, ST);
//      ST := FixLen(('„«‰œÂ «‘ —«ﬂ ')+ NumReverse(ST), ' ', 22);
//      PrintToReader(ST,OK);
//    end;
//
//    PrintToReader(#10#10, OK);
//
//    for i := 1 to 5 do
//      PrintToReader(CenterText(g_options.OutPutLines[i]), OK);
//
//    ST := FixLen(NumReverse(Readers[RdrIndx].R_Name), ' ', 17);
//    PrintToReader(ST, OK);
//  end;
end;

procedure CustDisplaySet(Code : Integer; ST : String; var OK : Boolean);
//var
//  PK : String;
//  retVal : Byte;
begin
//  Rs232Initial(2, 2, RDR_CLOCK_Z84);
//  Z84_MakePocket(PK, Code, $60, 0, ST);
//  if SendPocket(PK) then
//  begin
//    Z84_GetPocket(PK, 7, 50, retVal);
//    OK := ((retVal = ERR_NONE) and (Ord(PK[4]) = $06));
//  end
//  else
//    OK := False;
end;

procedure ViewCustomer(ST : String; var OK : Boolean);
var
  DC, n : Byte;
begin
  OK := True;
  DC := Readers[FindReaderCodeIdx(curRdrCode)].R_DisplayCode;
  if DC <> 0 then
  begin
    n := 0;
    repeat
      CustDisplaySet(DC, ST, OK);
      Inc(n);
    until OK or (n = 2);
  end;
end;

procedure GetOutPut(var OK:Boolean);
//var
//  PK, ST2 : String;
//  cmdNo, St : String;
//  retVal, Status : Byte;
//  CarExist : Boolean;
//  Rec : TMachines;
//  PAY : LongInt;
//  OK2 : Boolean;
//  ParkTime : LongInt;
//  m, d, h, mn : Byte;
//  Special : Byte;
begin
//  cmdNo := #$18;
//  Z84_GetCardRecord(16, retVal, PK);
//  if retVal = MB_TRUEREC then
//    case Ord(PK[6]) of
//      0: {Exit car request}
//      begin
//        Rec.M_ODoor := Ord(PK[3]);
//        Rec.M_ODate := CurrentDate;
//        Rec.M_OTime := CurrentTime;
//        Rec.M_OPerson := BarCode8(StrRev(Copy(PK, 7, 4)));
//        Rec.M_BarCode := BarCode8(StrRev(Copy(PK, 11, 4)));
//        Status := OutPutCar(Rec);
//        ST2 := Chr(Rec.M_Kind);
//        if Status <> MB_NOTEXIST then
//        begin
//          Special := Status;
//          if (Special AND MB_GHOLNAMEH) <> 0 then
//            Special := MB_NOTEXIT;
//          if Rec.M_Gholnameh then
//            Special := Special + MB_GHOLNAMEH;
//          if Rec.M_KarShenasi then
//            Special := Special + MB_KARSHENASI;
//
//          ST2 := Chr(Special);
//          CarExist := True;
//          Pay := Round(Rec.M_PayAble);
//          Str(Pay, St);
//          St := StrRev(BarCode4(St));
//          ST2 := St2 + St;
//
//          ParkTime := Differ(Rec.M_IDate, Rec.M_ITime, Rec.M_ODate, Rec.M_OTime);
//          m := IntToBCD(ParkTime div 43200);
//          ParkTime := ParkTime mod 43200;
//          d := IntToBCD(ParkTime div 1440);
//          ParkTime := ParkTime mod 1440;
//          h := IntToBCD(ParkTime div 60);
//          ParkTime := ParkTime mod 60;
//          mn := IntToBCD(ParkTime);
//          ST2 := ST2 + Chr(m) + Chr(d) + Chr(h) + Chr(mn);
//
//          ST2 := St2 + Chr(IntToBCD(StrToInt(Copy(Rec.M_IDate, 6, 2))));
//          ST2 := St2 + Chr(IntToBCD(StrToInt(Copy(Rec.M_IDate, 9, 2))));
//          ST2 := St2 + Chr(IntToBCD(StrToInt(Copy(Rec.M_ITime, 1, 2))));
//          ST2 := St2 + Chr(IntToBCD(StrToInt(Copy(Rec.M_ITime, 4, 2))));
//
//          St := ConvertFromWinCode(StrRev(NumReverse(Rec.M_Number)));
//          if not Readers[FindReaderCodeIdx(curRdrCode)].R_IsReader then
//            ST := DelDom(ST);
//          ST2 := ST2 + FixLen(ST, ' ', 6);
//
//          ST := FixLen(ConvertFromWinCode(NumReverse(Rec.M_CityName)), ' ', 15);
//          ST2 := ST2 + ST;
//
//          St := FixLen(ConvertFromWinCode(NumReverse(Rec.M_Serial)), ' ', 2);
//          ST2 := ST2 + ST;
//
//          St := FixLen(ConvertFromWinCode(NumReverse(Rec.M_CarName)), ' ', 15);
//          ST2 := ST2 + ST;
//
//          St := FixLen(ConvertFromWinCode(NumReverse(Rec.M_Color)), ' ', 15);
//          ST2 := ST2 + ST;
//        end
//        else
//        begin
//          Pay := 0;
//          ST2 := Format('%-66s', [ST2]);
//          CarExist := False;
//        end;
//
//        with ReadersLast[RdrIndx] do
//        begin
//          CardNo := Rec.M_BarCode;
//          CarTime := Rec.M_OTime;
//          ParkCost := Coma(IntToStr(Pay), '/');
//          CarNumber := Rec.M_Number;
//          ComTime := CurrentTimes;
//          OP := ('œ—ŒÊ«”  Œ—ÊÃ');
//          ComStat := ('»—ﬁ—«—');
//        end;
//
//        Z84_MakePocket(PK, curRdrCode, $1D, 0, ST2);
//        if not SendPocket(PK) then
//          OK := False
//        else
//        begin
//          Z84_GetPocket(PK, 7, 50, retVal);
//          if (retVal = ERR_NONE) and (Ord(PK[4]) = $06) and (Ord(PK[3]) =  curRdrCode) then
//            OK := True
//          else
//            OK := False;
//        end;
//
//        if not CarExist then
//        begin
//          if OK then ViewCustomer('xxxxxx', OK2);
//        end
//        else if OK then
//        begin
//          LastRec[FindReaderCodeIdx(Rec.M_ODoor)] := Rec;
//          ViewCustomer(IntToStr(Round(Rec.M_PayAble)), OK2);
//          if (g_options.OutPrint = MB_ALLPRINT) or
//             ((g_options.OutPrint = MB_PRCPRINT) and ((Rec.M_Payable>0) or (Rec.Remainder>0))) then
//            PrintOutput(Rec.M_ODoor);
//        end;
//      end;
//
//      2: {Cancel Exit car}
//      begin
//        Z84_MakePocket(PK, curRdrCode, $06, 0, cmdNo);
//        SendPocket(PK);
//        ViewCustomer('xxxxxx', OK2);
//        with ReadersLast[RdrIndx] do
//        begin
//          //CardNo := Rec.M_BarCode;
//          //CarTime := Rec.M_OTime;
//          //CarName := Rec.M_CarName;
//          //CarNumber := Rec.M_Number;
//          ComTime := CurrentTimes;
//          OP := ('«‰’—«› Œ—ÊÃ');
//          ComStat := ('»—ﬁ—«—');
//        end;
//      end;
//
//      3: {Exit car}
//      begin
//        Rec := LastRec[FindReaderCodeIdx(Ord(PK[3]))];
//        Z84_MakePocket(PK, curRdrCode, $06, 0, cmdNo);
//        if SendPocket(PK) then
//        begin
//          with Rec do
//          begin
//            UpdateOutPutCar(Rec);
//            with ReadersLast[RdrIndx] do
//            begin
//              CardNo := Rec.M_BarCode;
//              CarTime := M_OTime;
//              //CarName := M_CarName;
//              CarNumber := M_Number;
//              ComTime := CurrentTimes;
//              OP := ('Œ—ÊÃ ŒÊœ—Ê');
//              ComStat := ('»—ﬁ—«—');
//            end;
//          end;
//        end;
//        ViewCustomer('xxxxxx', OK2);
//      end;
//
//      4: {Print Request}
//      begin
//        Z84_MakePocket(PK, curRdrCode, $06, 0, cmdNo);
//        if not SendPocket(PK) then
//          OK := False;
//        PrintOutput(Ord(PK[3]));
//      end;
//    end;
end;


procedure ChngCapacities;
//var
//  i, m : Byte;
//  Cap : Integer;
//  ST : String;
begin
//  for i := 1 to TotalReader do
//    with Readers[i] do
//      if R_Active and (R_Kind in [MB_IN, MB_INOUT]) then
//      begin
//         for m := 1 to TotalTypes do
//         begin
//           Cap := FreeCapacity[m];
//           if Cap <> UnitCapacity[i, m] then
//             if (Cap = MinCap) and (UnitCapacity[i, m] < MinCap) then
//             begin
//               if i <> RdrIndx then
//                 if not SwitchReader(i) then Exit;
//
//               ST := '';
//               Z84_SendReaderMsg(ST);
//               UnitCapacity[i, m] := Cap;
//             end
//             else if (Cap < MinCap) or (UnitCapacity[i, m] < MinCap) then
//             begin
//               if i <> RdrIndx then
//                 if not SwitchReader(i) then Exit;
//
//               ST := ('„«‰œÂ Ÿ—›Ì      ') +
//                     FixLen(CarTypes[m].Type_Name, ' ', 10) + '= ' + Format('%-3s', [NumReverse(IntToStr(Cap))]);
//               ST := ConvertFromWinCode(ST);
//               Z84_SendReaderMsg(ST);
//               UnitCapacity[i, m] := Cap;
//             end;
//         end;
//      end;
end;

procedure ControlReaders;
//var
//  i : Byte;
//  OK : Boolean;
begin
//  if not USERCONTROL then
//  begin
//    AUTOCONTROL := True;
//    for i := 1 to TotalReader do
//    begin
//      with Readers[i] do
//        if R_Active then
//          if RdrRelation <= 5 then
//          begin
//            if SwitchReader(i) then
//              case R_Kind of
//                MB_IN :
//                  if MaxTimeOff > 0 then
//                  begin
//                    Dec(MaxTimeOff);
//                    ReadersLast[i].ComTime := CurrentTimes;
//                    ReadersLast[i].ComStat := ('»‹—ﬁ—«—');
//                  end
//                  else
//                  begin
//                    if Readers[RdrIndx].BuffEmpty = 5 then
//                      Readers[RdrIndx].BuffEmpty := 0;
//                    GetInput(OK);
//                  end;
//
//                MB_OUT:
//                  GetOutPut(OK);
//
//                MB_INOUT:
//                begin
//                  if MaxTimeOff > 0 then
//                  begin
//                    Dec(MaxTimeOff);
//                    ReadersLast[i].ComTime := CurrentTimes;
//                    ReadersLast[i].ComStat := ('»‹—ﬁ—«—');
//                  end
//                  else
//                  begin
//                    if Readers[RdrIndx].BuffEmpty = 5 then
//                      Readers[RdrIndx].BuffEmpty := 0;
//                    GetInput(OK);
//                  end;
//
//                  Sleep(20);
//                  GetOutPut(OK);
//                end;
//              end;
//
//            frmReaderState.ViewLastInOut(i);
//          end
//          else if RdrRelation >= 12 then
//            RdrRelation := 5
//          else
//            Inc(RdrRelation);
//    end;
//    ChngCapacities;
//    AUTOCONTROL := False;
//  end;
end;


end.
