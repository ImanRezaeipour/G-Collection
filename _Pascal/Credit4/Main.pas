unit Main;
{$I Features}
interface

uses
  Windows, DosMove, Menus, Controls, ExtCtrls, ComCtrls, VrAnalog, VrControls,
  VrHyperCtrls, Classes, Messages, SysUtils, Graphics, Forms, Dialogs,
  DBTables, Math, ShellApi, StdCtrls, FileCtrl, jpeg,
  ADODB , CPortCtl,
  DateProc, MSGs, FarsiApi,Globals,Persons, RdrList,Relation,
  Cashes,params,PersonRp,IORdrRp,HistoryRp,
  {Reders and Relation Menu}
  ChngAddr, ChngBaud, KeyPdChg, InVldCrd,
  Alarms, AcesCode, LmitCard, FuncKeys,picrec,
  VorCRecs, //kaveh
  ReadText,
  {Tools Menu}
  Admin,Users, ChngPass, Login,
  MakeDB, RptFont, About, BACKUP, MakeTbl;

type
  TfrmMain = class(TForm)
    StatusBar: TStatusBar;
    Bevel1: TBevel;
    mnuClock: TMainMenu;
    mnuBase: TMenuItem;
    mnuPersons: TMenuItem;
    mnuExit: TMenuItem;
    mnuReport: TMenuItem;
    mnuPersonRpt: TMenuItem;
    mnuSep3_1: TMenuItem;
    mnuSetup: TMenuItem;
    mnuPartTitle: TMenuItem;
    mnuRelation: TMenuItem;
    mnuControls: TMenuItem;
    mnuSep5_1: TMenuItem;
    mnuRelationTest: TMenuItem;
    mnuReset: TMenuItem;
    mnuControlVersion: TMenuItem;
    mnuSendDateTime: TMenuItem;
    mnuChangeAddr: TMenuItem;
    mnuBaud: TMenuItem;
    mnuLimitTime: TMenuItem;
    mnuLimitCard: TMenuItem;
    mnuKeys: TMenuItem;
    mnuMsgCard: TMenuItem;
    mnuAuthority: TMenuItem;
    mnuAlarms: TMenuItem;
    mnuAccessCode: TMenuItem;
    mnuDoorControl: TMenuItem;
    mnuPishCard: TMenuItem;
    mnuSep5_4: TMenuItem;
    mnuClockNewRec: TMenuItem;
    mnuRecovery: TMenuItem;
    mnuViewRec: TMenuItem;
    mnuTools: TMenuItem;
    mnuUserDef: TMenuItem;
    mnuChangePass: TMenuItem;
    mnuSep6_1: TMenuItem;
    mnuChangeUser: TMenuItem;
    mnuAbout: TMenuItem;
    mnuHelp: TMenuItem;
    mnuSep6_5: TMenuItem;
    mnuStatusBar: TMenuItem;
    mnuRdrInitial: TMenuItem;
    pnl: TPanel;
    mnuSep5_2: TMenuItem;
    mnuSep5_3: TMenuItem;
    mnuMsg: TMenuItem;
    mnuKeypadPassword: TMenuItem;
    mnuFont: TMenuItem;
    mnuUsers: TMenuItem;
    mnuOnlyCard: TMenuItem;
    DosMove1: TDosMove;
    mnuViewOnline: TMenuItem;
    lblSite: TVrWebLabel;
    mnuInvalidCard: TMenuItem;
    mnuCashes: TMenuItem;
    mnuIORdrRpt: TMenuItem;
    N1: TMenuItem;
    mnuFingerPrg: TMenuItem;
    N2: TMenuItem;
    mnuSep6_2: TMenuItem;
    mnuCreateDBs: TMenuItem;
    mnuSep3_2: TMenuItem;
    mnuHistoryRpt: TMenuItem;
    imgPicture: TImage;
    VrAnalogClock1: TVrAnalogClock;
    procedure N2Click(Sender: TObject);
    procedure mnuFingerPrgClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure mnuIORdrRptClick(Sender: TObject);
    procedure mnuPersonRptClick(Sender: TObject);
    procedure mnuPartTitleClick(Sender: TObject);
    procedure mnuCashesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuChangePassClick(Sender: TObject);
    procedure mnuStatusBarClick(Sender: TObject);
    procedure mnuUserDefClick(Sender: TObject);
    procedure mnuRelationTestClick(Sender: TObject);
    procedure mnuResetClick(Sender: TObject);
    procedure mnuLimitTimeClick(Sender: TObject);
    procedure mnuSendDateTimeClick(Sender: TObject);
    procedure mnuControlVersionClick(Sender: TObject);
    procedure mnuChangeAddrClick(Sender: TObject);
    procedure mnuBaudClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuHelpClick(Sender: TObject);
    procedure mnuChangeUserClick(Sender: TObject);
    procedure mnuPersonsClick(Sender: TObject);
    procedure mnuControlsClick(Sender: TObject);
    procedure mnuClockNewRecClick(Sender: TObject);
    procedure mnuAlarmsClick(Sender: TObject);
    procedure mnuAuthorityClick(Sender: TObject);
    procedure mnuAccessCodeClick(Sender: TObject);
    procedure mnuMsgCardClick(Sender: TObject);
    procedure mnuDoorControlClick(Sender: TObject);
    procedure mnuRecoveryClick(Sender: TObject);
    procedure mnuViewRecClick(Sender: TObject);
    procedure mnuLimitCardClick(Sender: TObject);
    procedure mnuKeysClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuRdrInitialClick(Sender: TObject);
    procedure mnuKeypadPasswordClick(Sender: TObject);
    procedure mnuMsgClick(Sender: TObject);
    procedure mnuFontClick(Sender: TObject);
    procedure mnuUsersClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure mnuAboutClick(Sender: TObject);
    procedure mnuCreateDBsClick(Sender: TObject);
    procedure mnuHistoryRptClick(Sender: TObject);
  private
    { Private declarations }


    procedure SetCodePageItems;
    procedure SetMenuItems;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  frmPicRec : TfrmPictureRec;
  frmVorCRecs : TfrmVorCRecs; //kaveh

implementation

uses
 DBS, ComTools, Code_sys, Funcs;

{$R *.DFM}




procedure TfrmMain.SetCodePageItems;
var i, j : Byte;
begin
  Caption := (Caption) + ' ' + g_options.CoName;
  if g_options.Shobeh <> '' then
    Caption := Caption + '-' + g_options.Shobeh;

  pnl.Caption := ConvertToFarsi(('”Ì” „ „ò«‰Ì“Â ’‰œÊﬁ «„«‰« ' + ' - „Õ’Ê·Ì «“ ‘—ò  ÿ—Õ Ê Å—œ«“‘ €œÌ—' + ' -  ·›‰ : 4-88312732')) + #254;

  StatusBar.Panels[1].Text := CurrentDate;
  StatusBar.Panels[2].Text := ('˛ﬂ«—»—:') + UpperCase(g_options.UserName) + '˛';
  StatusBar.Panels[4].Text := g_options.CoName;
  if g_options.Shobeh <> '' then
    StatusBar.Panels[4].Text := StatusBar.Panels[4].Text + '-' +
                                g_options.Shobeh;

end;

procedure TfrmMain.SetMenuItems;
var
  i, j, k, dif : Byte;
  MnuBarVal : Integer;
  MnuItemVal : LongInt;
  SepValid : Boolean;
  qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(self);
  qry.Connection := frmDBS.DBConnection;
  with qry do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Security,Users WHERE Security.Code = Users.SecurityCode and Users.UserName = ''' + g_options.UserName + '''');
    Open;
    MnuBarVal := FieldByName('MenuBar').AsInteger;
    for i := MNU_BASE to mnuClock.Items.Count -1 do
    begin
      case i of
        MNU_BASE      : dif := 2;
       MNU_REPORT    : dif := 1;
        MNU_SETUP     : dif := 1;
        MNU_RELATION  : dif := 1;
        MNU_TOOLS     : dif := 7;
        else            dif := 1;
      end;

      if UpperCase(g_options.UserName) = ADMIN_NAME then
      begin
        if mnuClock.Items[i].Count = 0 then
        begin
          mnuClock.Items[i].Visible := False;
          Continue;
        end
        else
          mnuClock.Items[i].Visible := True;
        for j := 0 to mnuClock.Items[i].Count-dif do
          mnuClock.Items[i].Items[j].Visible := True;
      end
      else if ((Trunc(Power(2, i)) and MnuBarVal) <> 0) or (i in [MNU_BASE, MNU_TOOLS]) then
      begin
        mnuClock.Items[i].Visible := True;
        MnuItemVal := Fields[i+3{4}].AsInteger;
        k := 0;
        SepValid := False;
        if mnuClock.Items[i].Count = 0 then
        begin
          mnuClock.Items[i].Visible := False;
          mnuClock.Items[i].ShortCut := 0;
          Continue;
        end;
        for j := 0 to mnuClock.Items[i].Count-dif do
        begin
          if mnuClock.Items[i].Items[j].Caption <> '-' then
          begin
            if (Trunc(Power(2, k)) and MnuItemVal) <> 0 then
            begin
              mnuClock.Items[i].Items[j].Visible := True;
              SepValid := True;
            end
            else
            begin
              mnuClock.Items[i].Items[j].Visible := False;
              mnuClock.Items[i].Items[j].ShortCut := 0;
            end;

            Inc(k);
          end
          else
          begin
            if not SepValid then
              mnuClock.Items[i].Items[j].Visible := False;
            SepValid := False;
          end;
        end;
      end
      else
        mnuClock.Items[i].Visible := False;
    end;
    Close;
    Free;
  end;
end;


procedure deletelockfiles(viewresult:boolean);
var
   fname: string;
   f:file;
begin
       fname:=g_options.ProgramPath+'pdoxusrs.lck';
       if fileexists(fname)
       then begin
            assignfile(f,fname);
            erase(f);
            if viewresult
            then InformationMessage(fname+' deleted');
       end
       else if viewresult
            then InformationMessage(fname+' not found');
       fname:=g_options.ProgramPath+'paradox.lck';
       if fileexists(fname)
       then begin
            assignfile(f,fname);
            erase(f);
            if viewresult
            then InformationMessage(fname+' deleted');
       end
       else if viewresult
            then InformationMessage(fname+' not found');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  StatusBar.Panels[3].Text := '‰”ŒÂ '+Version;
  Self.Top := 0;
  Self.Left := 0;
  Self.Width := Screen.Width;
  Self.Height := Screen.Height;
  if UpperCase(g_options.UserName) <> ADMIN_NAME then
    SetMenuItems;


  Mouse_Wait;

  lblSite.BringToFront;
  G_ToDate := CurrentDate;
  G_FromDate := G_ToDate;
  G_FromDate[10] :='1';
  G_FromDate[9] :='0';
  LoadReaders;
  frmPicRec := TfrmPictureRec.Create(Application);
  frmPicRec.BorderStyle := bsNone;
  frmPicRec.Parent := frmMain;
//  frmPicRec.Align := alBottom;
  frmPicRec.Height := frmPicRec.Height - 20; 
  frmPicRec.Show;

  frmVorCRecs := TfrmVorCRecs.Create(Application);
//  frmVorCRecs.BorderStyle := bsNone;
//  frmVorCRecs.Parent := frmMain;
//  frmVorCRecs.Show;

end;

procedure TfrmMain.FormShow(Sender: TObject);
var frmParams : TfrmParams;
begin
//  if FullScreen then
//    frmMain.WindowState := wsMaximized
//  else
//    frmMain.WindowState := wsNormal;
//  then
//  else frmmain.Height:=100;
  frmMain.Menu := mnuClock;
  Refresh;
  InitVariables;
  SetCodePageItems;
  current_rule := 0 ;
  Mouse_NoWait;

  //kaveh is
  imgPicture.Height := frmMain.Height;
  imgPicture.Width := frmMain.Width;
  imgPicture.Left := 0;
  imgPicture.Top := 0;
  VrAnalogClock1.Top := 155;
  lblSite.Top := 288;

  if (F_Params.BranchCode = '') or (F_Params.BranchName = '') then
  begin
    Application.CreateForm(TfrmParams, frmParams);
    frmParams.ShowModal;
    frmParams.Free;
  end;
//  frmMain.Top := 0;
  //kaveh ie
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not ConfirmMessage('¬Ì« „ÌùùŒÊ«ÂÌœ «“ »—‰«„Â. Œ«—Ã ‘ÊÌœø') then
    CanClose := False
  else
    frmDBS.adoTblPersons.Close;
end;

procedure TfrmMain.mnuHelpClick(Sender: TObject);
begin
  Application.HelpCommand(1, 2);
end;

procedure TfrmMain.mnuHistoryRptClick(Sender: TObject);
var frmHistoryRpt : TfrmHistoryRpt;
begin
  Application.CreateForm(TfrmHistoryRpt, frmHistoryRpt);
  frmHistoryRpt.ShowModal;
  frmHistoryRpt.Free;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
//  StatusBar.Panels[0].Text := TimeToStr(Time);
//  StatusBar.Panels[1].Text := CurrentDate;
end;







{ Base }
procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.mnuPartTitleClick(Sender: TObject);
var frmParams : TfrmParams;
begin
  Application.CreateForm(TfrmParams, frmParams);
  frmParams.ShowModal;
  frmParams.Free;
end;

procedure TfrmMain.mnuPersonRptClick(Sender: TObject);
var frmPersonRpt : TfrmPersonRpt;
begin
  Application.CreateForm(TfrmPersonRpt, frmPersonRpt);
  frmPersonRpt.ShowModal;
  frmPersonRpt.Free;
end;

procedure TfrmMain.mnuPersonsClick(Sender: TObject);
var frmPersons : TfrmPersons;
begin
  Application.CreateForm(TfrmPersons, frmPersons);
  frmPersons.ShowModal;
  frmPersons.Free;
end;

{ Relation Operation }
procedure TfrmMain.mnuControlsClick(Sender: TObject);
var frmReaders : TfrmReaders;
begin
  Application.CreateForm(TfrmReaders, frmReaders);
  frmReaders.ShowModal;
  frmReaders.Free;
end;

procedure TfrmMain.mnuRelationTestClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_TEST;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuResetClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_RESTART;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuControlVersionClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_VER;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuCreateDBsClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCreateTables, frmCreateTables);
  frmCreateTables.ShowModal;
  frmCreateTables.Free;
end;

procedure TfrmMain.mnuSendDateTimeClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_DATETIME;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuCashesClick(Sender: TObject);
var frmCashes : TfrmCashes;
begin
  Application.CreateForm(TfrmCashes, frmCashes);
  frmCashes.ShowModal;
  frmCashes.Free;
end;

procedure TfrmMain.mnuChangeAddrClick(Sender: TObject);
var frmChngAddr : TfrmChngAddr;
begin
  Application.CreateForm(TfrmChngAddr, frmChngAddr);
  frmChngAddr.ShowModal;
  frmChngAddr.Free;
end;

procedure TfrmMain.mnuKeypadPasswordClick(Sender: TObject);
var frmKeypayPassword : TfrmKeypayPassword;
begin
  Application.CreateForm(TfrmKeypayPassword, frmKeypayPassword);
  frmKeypayPassword.ShowModal;
  frmKeypayPassword.Free;
end;

procedure TfrmMain.mnuBaudClick(Sender: TObject);
var frmChngBaud: TfrmChngBaud;
begin
  Application.CreateForm(TfrmChngBaud, frmChngBaud);
  frmChngBaud.ShowModal;
  frmChngBaud.Free;
end;

procedure TfrmMain.mnuRdrInitialClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_INITIAL;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuLimitTimeClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_LIMITTIME;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuLimitCardClick(Sender: TObject);
var frmLimitCard : TfrmLimitCard;
begin
  Application.CreateForm(TfrmLimitCard, frmLimitCard);
  frmLimitCard.ShowModal;
  frmLimitCard.Free;
end;

procedure TfrmMain.mnuKeysClick(Sender: TObject);
var frmFunctionKeys : TfrmFunctionKeys;
begin
  Application.CreateForm(TfrmFunctionKeys, frmFunctionKeys);
  frmFunctionKeys.ShowModal;
  frmFunctionKeys.Free;
end;

procedure TfrmMain.mnuMsgCardClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_CARDMSG;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuMsgClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_MSG;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuAuthorityClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_Authority;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuAlarmsClick(Sender: TObject);
var frmAlarms : TfrmAlarms;
begin
  Application.CreateForm(TfrmAlarms, frmAlarms);
  frmAlarms.ShowModal;
  frmAlarms.Free;
end;

procedure TfrmMain.mnuAboutClick(Sender: TObject);
var frmAbout : TfrmAbout;
begin
  Application.CreateForm(TfrmAbout, frmAbout);
  frmAbout.ShowModal;
  frmAbout.Free;
end;

procedure TfrmMain.mnuAccessCodeClick(Sender: TObject);
var frmAccessCode : TfrmAccessCode;
begin
  Application.CreateForm(TfrmAccessCode, frmAccessCode);
  frmAccessCode.ShowModal;
  frmAccessCode.Free;
end;

procedure TfrmMain.mnuDoorControlClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_DOORS;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuIORdrRptClick(Sender: TObject);
var frmInOutReaderRpt : TfrmInOutReaderRpt;
begin
  Application.CreateForm(TfrmInOutReaderRpt, frmInOutReaderRpt);
  frmInOutReaderRpt.ShowModal;
  frmInOutReaderRpt.Free;
end;

procedure TfrmMain.mnuClockNewRecClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_COLLECT;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuRecoveryClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_RECOVERY;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuViewRecClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_VIEWREC;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.N1Click(Sender: TObject);
var frmBackup : TfrmBackup;
begin
  Application.CreateForm(TfrmBackup, frmBackup);
  frmBackup.ShowModal;
  frmBackup.Free;
end;

procedure TfrmMain.N2Click(Sender: TObject);
var frmReadText : TfrmReadText;
begin
  Application.CreateForm(TfrmReadText, frmReadText);
  frmReadText.ShowModal;
  frmReadText.Free;
end;

procedure TfrmMain.mnuFingerPrgClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_FingerPrg;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

{ Tools }
procedure TfrmMain.mnuUserDefClick(Sender: TObject);
var frmAdmin : TfrmAdmin;
begin
  Application.CreateForm(TfrmAdmin, frmAdmin);
  frmAdmin.mnus := mnuClock;
  frmAdmin.ShowModal;
  frmAdmin.Free;
end;

procedure TfrmMain.mnuChangePassClick(Sender: TObject);
var frmChangePassword : TfrmChangePassword;
begin
  Application.CreateForm(TfrmChangePassword, frmChangePassword);
  frmChangePassword.ShowModal;
  frmChangePassword.Free;
end;

procedure TfrmMain.mnuFontClick(Sender: TObject);
var frmReportFont : TfrmReportFont;
begin
  Application.CreateForm(TfrmReportFont, frmReportFont);
  frmReportFont.ShowModal;
  frmReportFont.Free;
end;

procedure TfrmMain.mnuChangeUserClick(Sender: TObject);
var frmLogin : TfrmLogin;
begin
  Application.CreateForm(TfrmLogin, frmLogin);
  frmLogin.ShowModal;
  if frmLogin.LoginValid then
  begin
    SetMenuItems;
    StatusBar.Panels[2].Text := ('˛ﬂ«—»—:') + UpperCase(g_options.UserName) + '˛';
  end;
  frmLogin.Free;
end;

procedure TfrmMain.mnuStatusBarClick(Sender: TObject);
begin
  mnuStatusBar.Checked := not mnuStatusBar.Checked;
  pnl.Visible := False;
  StatusBar.Visible := mnuStatusBar.Checked;
  pnl.Visible := True;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 119) and (Shift = [ssCtrl]) then
  //Ctrl + F8
  begin
    IsTest := not IsTest;
    if IsTest then
      OpenTestFile
    else
    begin
      CloseTestFile;
      ShellEXECandWait('test.txt');
    end;
  end;
end;


procedure TfrmMain.mnuUsersClick(Sender: TObject);
var
  frmUsers: TfrmUsers;
begin
  Application.CreateForm(TfrmUsers, frmUsers);
  frmUsers.ShowModal;
  frmUsers.Free;
end;


procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
var
   mb : longint;
begin
   if key='\'
   then begin
      deletelockfiles(true);
   end;
   if key='@'
   then begin
     case random(8) of
       1: mb := MB_ICONASTERISK; //SystemAsterisk
       2: mb := MB_ICONEXCLAMATION; //SystemExclamation
       3: mb := MB_ICONHAND; //SystemHand
       4: mb := MB_ICONQUESTION; //SystemQuestion
       5: mb := MB_OK; //SystemDefault
     else
       mb:= $0FFFFFFFF; //Standard beep using the computer speaker
     end;
     MessageBeep(mb);
   end;

end;

{ TMahdyar }

end.




