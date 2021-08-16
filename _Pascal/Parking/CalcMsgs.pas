unit CalcMsgs;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, AdoDB, globals;

type
  TfrmCalcMsgBox = class(TForm)
    cmdRun: TBitBtn;
    cmdStop: TBitBtn;
    cmdPause: TBitBtn;
    imgIcon: TImage;
    lblMsg: TLabel;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lblCountAll: TLabel;
    lblCount: TLabel;
    tmrCalc: TTimer;
    procedure cmdPauseClick(Sender: TObject);
    procedure cmdStopClick(Sender: TObject);
    procedure cmdRunClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrCalcTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
//    RetVals : array[0..2] of Integer;
//    btnNo : Integer;

//    procedure IconSet;
//    procedure MsgSet;
//    procedure ButtnsSet;

  public
    { Public declarations }
//    RetVal,
//    Btns,
//    Icns : Integer;
  end;

{const
  MBOKOnly           = 0;
  MBOKCancel         = 1;
  MBAbortRetryIgnore = 2;
  MBYesNoCancel	     = 3;
  MBYesNo            = 4;
  MBRetryCancel      = 5;

  MBCritical         = 16;
  MBQuestion         = 32;
  MBExclamation      = 48;
  MBInformation      = 64;

  MBOK               = 1;
  MBCancel           = 2;
  MBAbort            = 3;
  MBRetry            = 4;
  MBIgnore           = 5;
  MBYes              = 6;
  MBNo               = 7; }


//procedure ErrorMessage(Msg : String);
//function  ConfirmMessage(Msg : String) : Boolean;
//function  InformationMessage(msg : String) : Integer;
//procedure Msg_Wait(msg : String);
//procedure Msg_NoWait;

//function  FMsgBox(Msg : String; aBtns, aIcns : Integer; Titl : string) : Integer;


var frmCalcMsgBox : TfrmCalcMsgBox;


implementation

uses
  Funcs, DBS, MSGs, DateProc;

{$R *.DFM}
var
  existRec : Boolean;
  recsCount : Integer;

{procedure ErrorMessage(Msg : String);
begin
  FMsgBox((msg), MBOKOnly, MBCritical, ('خطا'));
end;}

{function ConfirmMessage(Msg : String) : Boolean;
begin
  if FMsgBox((Msg), MBYesNo, MBQuestion, ('تصديق')) = MBYes then
    ConfirmMessage := True
  else
    ConfirmMessage := False;
end;}

{function InformationMessage(msg : String) : Integer;
begin
  InformationMessage := FMsgBox((msg), MBOKOnly, MBInformation, ('اطلاع'));
end;}

{procedure Msg_Wait(msg : String);
begin
  Application.CreateForm(TfrmMsgBox, frmMsgBox);
  frmMsgBox.Caption := (Msg) + #254;
  frmMsgBox.Width := frmMsgBox.Canvas.TextWidth(frmMsgBox.Caption) + 70;
  frmMsgBox.Height := 5;
  frmMsgBox.BorderStyle := bsDialog;
  frmMsgBox.BorderIcons := [];
  frmMsgBox.Show;
end;}

{procedure Msg_NoWait;
begin
  frmMsgBox.Close;
  frmMsgBox.Free;
end;}

{function FMsgBox(Msg : String; aBtns, aIcns : Integer; Titl : string) : Integer;
var frmMessageBox : TfrmMsgBox;
begin
  Application.CreateForm(TfrmMsgBox, frmMessageBox);
  frmMessageBox.Caption := Titl;
  frmMessageBox.lblMsg.Caption := Msg + #254;
  frmMessageBox.Btns := aBtns;
  frmMessageBox.Icns := aIcns;
  frmMessageBox.IconSet;
  frmMessageBox.MsgSet;
  frmMessageBox.ButtnsSet;
  frmMessageBox.Top := (Screen.Height - frmMessageBox.Height) div 2;
  frmMessageBox.Left := (Screen.Width - frmMessageBox.Width) div 2;
  frmMessageBox.BorderStyle := bsDialog;
  frmMessageBox.ShowModal;
  FMsgBox := frmMessageBox.RetVal;
  frmMessageBox.Free;
end;}


{procedure TfrmCalcMsgBox.IconSet;
begin
  if Icns = MBCritical then
  begin
    imgIcon.Picture := img1.Picture;
    lblMsg.Left := imgIcon.Left + imgIcon.Width + 16;
  end
  else if Icns = MBQuestion then
  begin
    imgIcon.Picture := img2.Picture;
    lblMsg.Left := imgIcon.Left + imgIcon.Width + 16;
  end
  else if Icns = MBExclamation then
  begin
    imgIcon.Picture := img3.Picture;
    lblMsg.Left := imgIcon.Left + imgIcon.Width + 16;
  end
  else if Icns = MBInformation then
  begin
    imgIcon.Picture := img4.Picture;
    lblMsg.Left := imgIcon.Left + imgIcon.Width + 16;
  end
  else
    lblMsg.Left := 16;

  lblmsg.Width := Width - lblmsg.Left - 20;
end; }

{procedure TfrmCalcMsgBox.MsgSet;
begin
  lblmsg.AutoSize := True;
  if (lblMsg.Left + lblMsg.Width) < (Width - 20) then
    Width := lblMsg.Left + lblMsg.Width + 20
  else
  begin
    lblMsg.WordWrap := False;
    lblMsg.AutoSize := False;
    lblMsg.Width := Width - lblmsg.Left - 20;
    lblMsg.Height := 16;
    lblMsg.Alignment := taRightJustify;
    lblMsg.WordWrap := True;
    lblMsg.AutoSize := True;
  end;
end; }

{procedure TfrmCalcMsgBox.ButtnsSet;
var i, w : Integer;
begin
  if (lblmsg.Top + lblmsg.Height + 15) > cmds1.Top then
  begin
    cmds0.Top := lblMsg.Top + lblMsg.Height + 15;
    cmds1.Top := cmds0.Top;
    cmds2.Top := cmds1.Top;
    Height := cmds0.Top + cmds0.Height + 35;
  end;

  case Btns of
    MBOKCancel:
    begin
      cmds0.Kind := bkOK;
      cmds0.Caption := ('&تأييد');
      RetVals[0] := MBOK;

      cmds1.Visible := True;
      cmds1.Kind := bkCancel;
      cmds1.Caption := ('&انصراف');
      RetVals[1] := MBCancel;
      btnNo := 2;
    end;

    MBAbortRetryIgnore:
    begin
      cmds0.Kind := bkAbort;
      cmds0.Caption := ('&صرف نظر');
      RetVals[0] := MBAbort;

      cmds1.Visible := True;
      cmds1.Kind := bkRetry;
      cmds1.Caption := ('&سعي مجدد');
      RetVals[1] := MBRetry;

      cmds2.Visible := True;
      cmds2.Kind := bkIgnore;
      cmds2.Caption := ('&جهش');
      RetVals[1] := MBIgnore;
      btnNo := 3;
    end;

    MBYesNoCancel:
    begin
      cmds0.Kind := bkYes;
      cmds0.Caption := ('&بلي');
      RetVals[0] := MBYes;

      cmds1.Visible := True;
      cmds1.Kind := bkNo;
      cmds1.Caption := ('&خير');
      RetVals[1] := MBNo;

      cmds2.Visible := True;
      cmds2.Kind := bkCancel;
      cmds2.Caption := ('&انصراف');
      RetVals[2] := MBCancel;
      btnNo := 3;
    end;

    MBYesNo:
    begin
      cmds0.Kind := bkYes;
      cmds0.Caption := ('&بلي');
      RetVals[0] := MBYes;

      cmds1.Visible := True;
      cmds1.Kind := bkNo;
      cmds1.Caption := ('&خير');
      RetVals[1] := MBNo;
      btnNo := 2;
    end;

    MBRetryCancel:
    begin
      cmds0.Kind := bkRetry;
      cmds0.Caption := ('&سعي مجدد');
      RetVals[0] := MBRetry;

      cmds1.Visible := True;
      cmds1.Kind := bkCancel;
      cmds1.Caption := ('&انصراف');
      RetVals[1] := MBCancel;
      btnNo := 2
    end;

    else
    begin
      cmds0.Kind := bkOK;
      cmds0.Caption := ('&تأييد');
      RetVals[0] := MBOK;
      btnNo := 1;
    end;
  end;

  w := 8;
  for i := 0 to btnNo - 1 do
  begin
    if i > 0 then
      w := w + 7;

    case i of
      0 : cmds0.Left := w;
      1 : cmds1.Left := w;
      2 : cmds2.Left := w;
    end;
    w := w + cmds0.Width;
  end;
  w := w + 16;
  case btnNo of
    2 :
    begin
      cmds0.Left := cmds1.Left;
      cmds1.Left := 8;
    end;
    3 :
    begin
      cmds0.Left := cmds2.Left;
      cmds2.Left := 8;
    end;

  end;

  if Width < w then
  begin
    Width := w;
    lblMsg.Left := Width - lblMsg.Width - 20;
  end
  else
  begin
    w := (Width - w + 16) div 2;
    for i := 0 to btnNo - 1 do
      case i of
        0 : cmds0.Left := cmds0.Left + w;
        1 : cmds1.Left := cmds1.Left + w;
        2 : cmds2.Left := cmds2.Left + w;
      end;
  end;
end;
 }
procedure TfrmCalcMsgBox.cmdPauseClick(Sender: TObject);
begin
//  RetVal := RetVals[0];
////  prgrs.Position := 0;
////  tmrCalc.Enabled := FALSE;
////  grpCom.Enabled := true;
////  grpAll.Enabled := true;
  cmdRun.Enabled := True;
  cmdPause.Enabled := False;
  lblMsg.Caption := 'توقف در انجام محاسبات...';
  existRec := False;
  tmrCalc.Enabled := False;

end;

procedure TfrmCalcMsgBox.cmdStopClick(Sender: TObject);
begin
//  RetVal := RetVals[1];
////  prgrs.Position := 0;
////  tmrCalc.Enabled := FALSE;
////  grpCom.Enabled := true;
////  grpAll.Enabled := true;
  existRec := False;
  tmrCalc.Enabled := False;
  Close;
end;

procedure TfrmCalcMsgBox.cmdRunClick(Sender: TObject);
begin
//  RetVal := RetVals[2];
////  ComPortInitial(Readers[cmbreaders.itemindex]);
{  if _RecCount = 0 then
  begin
    txtSearchCode.Text := '';
    txtSearchCode.SetFocus;
    exit;
  end;
  prgrs.Position := 0;}
  cmdRun.Enabled := False;
  cmdPause.Enabled := True;
  lblMsg.Caption := 'در حال انجام محاسبات...';
  existRec := True;
  tmrCalc.Enabled := true;
////  grpCom.Enabled := false;
////  grpAll.Enabled := false;
end;

procedure TfrmCalcMsgBox.FormActivate(Sender: TObject);
begin
//  cmds0.SetFocus;
end;

procedure TfrmCalcMsgBox.FormShow(Sender: TObject);
var
  qry : TADOQuery;
begin
  if CheckCollectedRecsTable then
     existRec := True
  else
  begin
    ErrorMessage('اشکال در ایجاد جدول جمع آوری');
    existRec := False;
  end;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.adoConnect;
    SQL.Clear;
  //        SQL.Add('SELECT * FROM collectedRecs ');
  //        SQL.Add('ORDER BY C_id ');
    SQL.Add('SELECT count(*) AS cou FROM collectedRecs');
//    SQL.Add(' WHERE C_id = (SELECT min(C_id)FROM collectedRecs)');
    Open;
    if FieldByName('cou').AsInteger > 0 then
    begin
      lblCountAll.Caption := IntToStr(FieldByName('cou').AsInteger);
      lblCount.Caption := '0';
      cmdRun.Enabled := True;
      cmdPause.Enabled := False;
      lblMsg.Caption := 'آماده انجام محاسبات...';
    end
    else
    begin
      lblCountAll.Caption := '0';
      lblCount.Caption := '0';
      cmdRun.Enabled := False;
      cmdPause.Enabled := False;
      lblMsg.Caption := 'رکوردی برای انجام محاسبات وجود ندارد.';
    end;
    recsCount := 0;
    Close;
    Free;
  end;

end;

procedure TfrmCalcMsgBox.tmrCalcTimer(Sender: TObject);
var
  qry : TADOQuery;
  recT : TMachines;
  iC_id : Integer;
begin
  //Result := True;
{  if CheckCollectedRecsTable then
     existRec := True
  else
  begin
    ErrorMessage('اشکال در ایجاد جدول جمع آوری');
    existRec := False;
  end;}
  try
    qry := TAdoQuery.Create(Application);
    with qry do
    begin
      connection := frmDBS.adoConnect;
      if (existRec) then
      begin
        SQL.Clear;
  //        SQL.Add('SELECT * FROM collectedRecs ');
  //        SQL.Add('ORDER BY C_id ');
        SQL.Add('SELECT * FROM collectedRecs');
        SQL.Add(' WHERE C_id = (SELECT min(C_id)FROM collectedRecs)');
        Open;
  //        ExecSQL;
        if FieldByName('C_id').AsInteger > 0 then
        begin
          iC_id := FieldByName('C_id').AsInteger;
          recT.M_BarCode := FieldByName('M_BarCode').AsString;
          recT.M_Number := FieldByName('M_Number').AsString;
          recT.M_Serial := FieldByName('M_Serial').AsString;
          recT.M_IDate := FieldByName('M_IDate').AsString;
          recT.M_ITime := FieldByName('M_ITime').AsString;
          recT.M_rdrCode := FieldByName('M_rdrCode').AsInteger;
          recT.M_OperatorCode := FieldByName('M_OperatorCode').AsString;
          recT.M_PlaqueType := FieldByName('M_PlaqueType').AsInteger;
          recT.M_PlaqueAppliance := FieldByName('M_PlaqueAppliance').AsInteger;
          recT.M_CitySerial := FieldByName('M_CitySerial').AsInteger;
          recT.M_ODate := FieldByName('M_ODate').AsString;
          recT.M_OTime := FieldByName('M_OTime').AsString;
          recT.M_Payable := FieldByName('M_PayAble').AsFloat;
          recT.M_Status := FieldByName('M_Status').AsInteger;
          recT.M_MemberCode := FieldByName('M_MemberCode').AsString;
{$ifdef TarehBar}
          recT.M_CargoKind := FieldByName('M_CargoKind').AsInteger;
          recT.M_CargoWeight := FieldByName('M_CargoWeight').AsInteger;
          recT.M_Salon := FieldByName('M_Salon').AsInteger;
          recT.M_Loge := FieldByName('M_Loge').AsInteger;
{$endif TarehBar}
          case recT.M_Status of
            21, 61, 62: SaveInputCarRecord(recT);
            23, 24, 63, 64: UpdateOutputCarRecord(recT);
    //          61, 62: SaveInputCarRecordMember(ClkRecs[j]);
    //          63, 64: UpdateOutputCarRecordMember(ClkRecs[j]);
          end;
          recsCount := recsCount + 1;
          lblCount.Caption := IntToStr(recsCount);
          SQL.Clear;
          SQL.Add('DELETE FROM collectedRecs');
          SQL.Add(' WHERE C_id = ' + IntToStr(iC_id));
          ExecSQL;

        end
        else
        begin
          UpdateMachinesCount(CurrentDate,0,AllParkNo,DayParkNo,DayAriveNo,DayExitNo);
          cmdRun.Enabled := False;
          cmdPause.Enabled := False;
          lblMsg.Caption := 'تمام رکوردها محاسبه گردید.';
          existRec := False;
          tmrCalc.Enabled := False;
        end;

      //SQL.Add('(M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_rdrCode,');
      //SQL.Add(' M_OperatorCode, M_PlaqueType, M_PlaqueAppliance, M_CitySerial,');
      //SQL.Add(' M_ODate, M_OTime, M_PayAble, M_Status, M_MemberCode)');
      end;
      Close;
      Free;
    end;
  except
    //Result := False;
  end;
//  tmrCalc.Enabled := FALSE;
end;



end.
