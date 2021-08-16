unit Main;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, AdoDB, Math, Menus, jpeg, WinSvc,

  Ertebat, ClckRecs, Globals, DateProc, MSGs, FarsiApi,
  Cntroler, DBS_Proc, ComTools,on_line, funcs, MakeDb,

  {Base Menu}
  Parts, JobType, Persons, Rejim, GustCard, Groups, OutGroup,
  Units, PrnDef,building,Reserve7,yaraneh,

  {Resturant Menu}
  Params, chargLst, KeyPad, FoodList, PrgFood, RdrKey, Fish, FishUnit, DelFish,
  DelUFish, FishLst,PrgPrs, VrAnalog, VrControls, VrHyperCtrls,

  {Reports Menu}
  PersonRp, GustRp, FodPrcRp, PrgFodRp, ChargeRp, RemainRp, 
  LstFshRp, PrsAmrRP, DayFodRp, PrsFodRp, YearFdRp, UntFodRp, AllFodRp,
  PymanRp, CstFodRp, AmrPrcRp, RdrFshRp, NoFishRp, DblFshRp, GhFshRp, ezFshRp, ilgfshRp, DifferRp, PymPrcRp,
  TextFish, DBF_Fish, DBF_Mnth, OilRpt,amrTabkh, StatisticsPaymentRp, StatisticsUseRp, ChargeUsedbyReserveRp,

  {Reders and Relation Menu}
  RdrList, Modem, Relation, ChngAddr, ChngBaud, LmitCard, ViewRecs,
  ClckFile, RdrStat, FishLst1,
  FishLstPics, //kaveh

  {Tools Menu}
  Admin, ChngPass, UserStat, Login, BackUp,Restore, MBackup, ChngAll, FreeDBS,
  PrsnCnvr, ReadFish, About, UpdateDB, createDB,RELOGIN, StdCtrls
;

type
  TfrmMain = class(TForm)
    Timer1: TTimer;
    StatusBar: TStatusBar;
    imgPicture: TImage;
    mnuResturan: TMainMenu;
    mnuBase: TMenuItem;
    mnuControls: TMenuItem;
    mnuExit: TMenuItem;
    mnuTranslate: TMenuItem;
    mnuReport: TMenuItem;
    mnuTools: TMenuItem;
    mnuUserDef: TMenuItem;
    mnuChangePass: TMenuItem;
    mnuSep5_2: TMenuItem;
    mnuBackup: TMenuItem;
    mnuRestore: TMenuItem;
    mnuSep5_3: TMenuItem;
    mnuAbout: TMenuItem;
    mnuHelp: TMenuItem;
    mnuStatusBar: TMenuItem;
    mnuRelation: TMenuItem;
    mnuRelationTest: TMenuItem;
    mnuChangeAddr: TMenuItem;
    mnuBaud: TMenuItem;
    mnuReset: TMenuItem;
    mnuSendTables: TMenuItem;
    mnuSendDateTime: TMenuItem;
    mnuControlVersion: TMenuItem;
    mnuSep5_4: TMenuItem;
    StatusBar1: TStatusBar;
    Bevel1: TBevel;
    mnuFreeDBS: TMenuItem;
    mnuFromData: TMenuItem;
    mnuSep1_2: TMenuItem;
    mnuChangeUser: TMenuItem;
    mnuParts: TMenuItem;
    mnuJobType: TMenuItem;
    mnuPersons: TMenuItem;
    mnuPersonRpt: TMenuItem;
    mnuParams: TMenuItem;
    mnuGustCard: TMenuItem;
    mnuGustCardRpt: TMenuItem;
    mnuFoodlist: TMenuItem;
    mnuFoodPriceRpt: TMenuItem;
    mnuProgFood: TMenuItem;
    mnuProgFodRpt: TMenuItem;
    mnuKeyPad: TMenuItem;
    mnuRejim: TMenuItem;
    mnuSep2_1: TMenuItem;
    mnuFish: TMenuItem;
    mnuSep4_1: TMenuItem;
    mnuSep4_3: TMenuItem;
    mnuInteligent: TMenuItem;
    mnuSep4_4: TMenuItem;
    mnuRdrState: TMenuItem;
    mnuChangeOnLine: TMenuItem;
    mnuListFishRpt: TMenuItem;
    mnuDayFoodRpt: TMenuItem;
    mnuNoFishRpt: TMenuItem;
    mnuPrcFoodRpt: TMenuItem;
    mnuDiffRpt: TMenuItem;
    mnuSep3_1: TMenuItem;
    mnuGrups: TMenuItem;
    mnuOutGrp: TMenuItem;
    mnuSep1_1: TMenuItem;
    mnuPrn: TMenuItem;
    mnuUnits: TMenuItem;
    mnuFishUnit: TMenuItem;
    mnuReadClockRecs: TMenuItem;
    mnuAllFoodsRpt: TMenuItem;
    mnuUserAction: TMenuItem;
    mnuModem: TMenuItem;
    mnuSep5_1: TMenuItem;
    mnuPersonConvert: TMenuItem;
    mnuDelFish: TMenuItem;
    mnuDoubleFishRpt: TMenuItem;
    mnuSep3_2: TMenuItem;
    mnuTextFishRpt: TMenuItem;
    mnuViewClockrecs: TMenuItem;
    mnuReadFileRecs: TMenuItem;
    mnuUnitFishRpt: TMenuItem;
    mnuDelUnitFish: TMenuItem;
    mnuPrsCostrpt: TMenuItem;
    mnuPeymanRpt: TMenuItem;
    mnuSep2_2: TMenuItem;
    mnuFishLst: TMenuItem;
    mnuChangeAll: TMenuItem;
    mnuLimitCard: TMenuItem;
    mnuOilRpt: TMenuItem;
    mnuMBakup: TMenuItem;
    mnuPrsAmrRpt: TMenuItem;
    mnuYearFoodRpt: TMenuItem;
    mnuSep4_2: TMenuItem;
    mnuReaderInitial: TMenuItem;
    mnuCostUsedFoodRpt: TMenuItem;
    mnuAmarPriceRpt: TMenuItem;
    mnuRptReaderFish: TMenuItem;
    mnuRdrKey: TMenuItem;
    mnuFoodPricePrcnt: TMenuItem;
    mnuSep2_3: TMenuItem;
    mnuIntelligentFile: TMenuItem;
    mnuDBFPrs: TMenuItem;
    mnuSep3_3: TMenuItem;
    mnuAmarTabkh: TMenuItem;
    mnuUpdateDB: TMenuItem;
    mnuPrgPrs: TMenuItem;
    mnuBuilding: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    lblSite: TVrWebLabel;
    analogClock: TVrAnalogClock;
    mnucharge: TMenuItem;
    timeruser: TTimer;
    mnuRemainRpt: TMenuItem;
    mnureserve7: TMenuItem;
    mnughFishRpt: TMenuItem;
    mnuezFishRpt: TMenuItem;
    mnuilgFishRpt: TMenuItem;
    mnufishlst1: TMenuItem;
    N3: TMenuItem;
    mnuStatisticsPaymentRpt: TMenuItem;
    mnuStatisticsUseRpt: TMenuItem;
    N4: TMenuItem;
    mnuChargeUsedbyReserve: TMenuItem;
    mnufishlstPics: TMenuItem;
    procedure mnureserve7Click(Sender: TObject);
    procedure mnuRemainRptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure timeruserTimer(Sender: TObject);
    procedure mnuchargeClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure mnuBuildingClick(Sender: TObject);
    procedure mnuPrgPrsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuChangePassClick(Sender: TObject);
    procedure mnuStatusBarClick(Sender: TObject);
    procedure mnuUserDefClick(Sender: TObject);
    procedure mnuAboutClick(Sender: TObject);
    procedure mnuRelationTestClick(Sender: TObject);
    procedure mnuResetClick(Sender: TObject);
    procedure mnuSendTablesClick(Sender: TObject);
    procedure mnuSendDateTimeClick(Sender: TObject);
    procedure mnuControlVersionClick(Sender: TObject);
    procedure mnuChangeAddrClick(Sender: TObject);
    procedure mnuBaudClick(Sender: TObject);
    procedure tmrRdrTimer(Sender: TObject);
    procedure mnuBackupClick(Sender: TObject);
    procedure mnuRestoreClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuHelpClick(Sender: TObject);
    procedure mnuChangeUserClick(Sender: TObject);
    procedure mnuPartsClick(Sender: TObject);
    procedure mnuJobTypeClick(Sender: TObject);
    procedure mnuPersonsClick(Sender: TObject);
    procedure mnuPersonRptClick(Sender: TObject);
    procedure mnuParamsClick(Sender: TObject);
    procedure mnuGustCardClick(Sender: TObject);
    procedure mnuGustCardRptClick(Sender: TObject);
    procedure mnuFoodlistClick(Sender: TObject);
    procedure mnuFoodPriceRptClick(Sender: TObject);
    procedure mnuProgFoodClick(Sender: TObject);
    procedure mnuProgFodRptClick(Sender: TObject);
    procedure mnuKeyPadClick(Sender: TObject);
    procedure mnuRejimClick(Sender: TObject);
    procedure mnuControlsClick(Sender: TObject);
    procedure mnuFishClick(Sender: TObject);
    procedure mnuRdrStateClick(Sender: TObject);
    procedure mnuChangeOnLineClick(Sender: TObject);
    procedure mnuInteligentClick(Sender: TObject);
    procedure mnuListFishRptClick(Sender: TObject);
    procedure mnuDayFoodRptClick(Sender: TObject);
    procedure mnuFreeDBSClick(Sender: TObject);
    procedure mnuNoFishRptClick(Sender: TObject);
    procedure mnuPrcFoodRptClick(Sender: TObject);
    procedure mnuDiffRptClick(Sender: TObject);
    procedure mnuGrupsClick(Sender: TObject);
    procedure mnuOutGrpClick(Sender: TObject);
    procedure mnuPrnClick(Sender: TObject);
    procedure mnuUnitsClick(Sender: TObject);
    procedure mnuFishUnitClick(Sender: TObject);
    procedure mnuReadClockRecsClick(Sender: TObject);
    procedure mnuAllFoodsRptClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuModemClick(Sender: TObject);
    procedure mnuPersonConvertClick(Sender: TObject);
    procedure mnuDelFishClick(Sender: TObject);
    procedure mnuDoubleFishRptClick(Sender: TObject);
    procedure mnuTextFishRptClick(Sender: TObject);
    procedure mnuUserActionClick(Sender: TObject);
    procedure mnuViewClockrecsClick(Sender: TObject);
    procedure mnuFromDataClick(Sender: TObject);
    procedure mnuReadFileRecsClick(Sender: TObject);
    procedure mnuUnitFishRptClick(Sender: TObject);
    procedure mnuDelUnitFishClick(Sender: TObject);
    procedure mnuPrsCostrptClick(Sender: TObject);
    procedure mnuPeymanRptClick(Sender: TObject);
    procedure mnuFishLstClick(Sender: TObject);
    procedure mnuChangeAllClick(Sender: TObject);
    procedure mnuLimitCardClick(Sender: TObject);
    procedure mnuOilRptClick(Sender: TObject);
    procedure mnuMBakupClick(Sender: TObject);
    procedure mnuPrsAmrRptClick(Sender: TObject);
    procedure mnuYearFoodRptClick(Sender: TObject);
    procedure mnuReaderInitialClick(Sender: TObject);
    procedure mnuCostUsedFoodRptClick(Sender: TObject);
    procedure mnuAmarPriceRptClick(Sender: TObject);
    procedure mnuRptReaderFishClick(Sender: TObject);
    procedure mnuRdrKeyClick(Sender: TObject);
    procedure mnuFoodPricePrcntClick(Sender: TObject);
    procedure mnuIntelligentFileClick(Sender: TObject);
    procedure mnuDBFPrsClick(Sender: TObject);
    procedure mnuAmarTabkhClick(Sender: TObject);
    procedure mnuUpdateDBClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure mnughFishRptClick(Sender: TObject);
    procedure mnuezFishRptClick(Sender: TObject);
    procedure mnuilgFishRptClick(Sender: TObject);
    procedure mnufishlst1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mnuStatisticsPaymentRptClick(Sender: TObject);
    procedure mnuStatisticsUseRptClick(Sender: TObject);
    procedure mnuChargeUsedbyReserveClick(Sender: TObject);
    procedure mnufishlstPicsClick(Sender: TObject);
  private
    { Private declarations }
    StrCrcl : String;

    procedure SetWinF;
    procedure SetMenuItems;
    procedure AddUserAction(Actn : String);
    procedure createOnlineFrm(rdr :TReaders);
  public
    { Public declarations }
    userDiscard : boolean;
    procedure ReCreateOnlineFrms;    
  end;

var
  frmMain: TfrmMain;

implementation

uses
  //prnTest,
  Code_Sys, Intlgnt;

{$R *.DFM}



procedure TfrmMain.SetWinF;
var i, j : Byte;
begin

  Caption := (Caption) + ' ' + g_options.CoName;
  if g_options.Shobeh <> '' then
    Caption := Caption + '-' + g_options.Shobeh;


  StrCrcl := ('**”Ì” „ „ﬂ«‰Ì“Â —” Ê—«‰ 5.1- „Õ’Ê·Ì «“ ‘—ò  ÿ—Õ Ê Å—œ«“‘ €œÌ— ù -  ·›‰ 4-8312732 - ›«ﬂ” 8312072** ');
  StatusBar1.Panels[0].Text := ConvertToFarsi(StrCrcl) + #254;
  StatusBar.Panels[1].Text := CurrentDate;
  StatusBar.Panels[2].Text := ('˛ﬂ«—»—:') + UpperCase(g_options.UserName) + '˛';
  StatusBar.Panels[3].Text := g_options.CoName;
  if g_options.Shobeh <> '' then
    StatusBar.Panels[3].Text := StatusBar.Panels[3].Text + '-' +
                                g_options.Shobeh;
end;

procedure TfrmMain.AddUserAction(Actn : String);
var
  qry : TAdoQuery;
  p : Byte;
begin
  p := Pos('...', Actn);
  if p > 0 then
    Delete(Actn, p, 3);

  p := Pos('&', Actn);
  if p > 0 then
    Delete(Actn, p, 1);

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('INSERT INTO UserStat VALUES(''' + g_options.UserName + ''', ''' +
              Actn + ''', ''' + CurrentDate + ''', ''' + CurrentTime + ''')');
  qry.ExecSQL;
  qry.Free;
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
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Security WHERE UserName = ''' + g_options.UserName + '''');
  qry.Open;
  MnuBarVal := qry.FieldByName('MenuBar').AsInteger;
  for i := MNU_BASE to mnuResturan.Items.Count -1 do
  begin
    case i of
      MNU_BASE      : dif := 2;
      MNU_RESTURANT : dif := 1;
      MNU_REPORT    : dif := 1;
      MNU_RELATION  : dif := 1;
      MNU_TOOLS     : dif := 6;
      else            dif := 1;
    end;

    if UpperCase(g_options.UserName) = ADMIN_NAME then
    begin
      if mnuResturan.Items[i].Count = 0 then
      begin
        mnuResturan.Items[i].Visible := False;
        Continue;
      end
      else
        mnuResturan.Items[i].Visible := True;
      for j := 0 to mnuResturan.Items[i].Count-dif do
        mnuResturan.Items[i].Items[j].Visible := True;
    end
    else if ((Trunc(Power(2, i)) and MnuBarVal) <> 0) or (i in [MNU_BASE, MNU_TOOLS]) then
    begin
      mnuResturan.Items[i].Visible := True;
      MnuItemVal := qry.Fields[i+4].AsInteger;
      k := 0;
      SepValid := False;
      if mnuResturan.Items[i].Count = 0 then
      begin
        mnuResturan.Items[i].Visible := False;
        Continue;
      end;
      for j := 0 to mnuResturan.Items[i].Count-dif do
      begin
        if mnuResturan.Items[i].Items[j].Caption <> '-' then
        begin
          if (Trunc(Power(2, k)) and MnuItemVal) <> 0 then
          begin
            mnuResturan.Items[i].Items[j].Visible := True;
            SepValid := True;
          end
          else
          begin
            mnuResturan.Items[i].Items[j].Visible := False;
            mnuResturan.Items[i].Items[j].ShortCut := 0;
          end;

          Inc(k);
        end
        else
        begin
          if not SepValid then
            mnuResturan.Items[i].Items[j].Visible := False;
          SepValid := False;
        end;
      end;
    end
    else
      mnuResturan.Items[i].Visible := False;
  end;

  qry.Close;
  qry.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i :integer;
begin
  frmDBS.UpgradeFishTbl;
  userDiscard := false;
  Self.Top := 0;
  Self.Left := 0;
  Self.Width := Screen.Width;
  Self.Height := Screen.Height - 25;

  if UpperCase(g_options.UserName) <> ADMIN_NAME then
    SetMenuItems;

//  if FileExists(g_options.ProgramPath + 'Resturan.Jpg') then
//    imgPicture.Picture.LoadFromFile(g_options.ProgramPath + 'Resturan.Jpg')
//  else if FileExists(g_options.ProgramPath + 'Resturan.Bmp') then
//    imgPicture.Picture.LoadFromFile(g_options.ProgramPath + 'Resturan.Bmp');


  Mouse_Wait;
  if (g_options.WinType = WIN_SINA_SYS) and FileExists(g_options.ProgramPath + 'SRest.Hlp') then
    Application.HelpFile := g_options.ProgramPath + 'SRest.Hlp'
  else if (g_options.WinType = WIN_MICROSOFT_SYS) and FileExists(g_options.ProgramPath + 'MRest.Hlp') then
    Application.HelpFile := g_options.ProgramPath + 'MRest.Hlp';
//  tmrRdr.Interval := F_Params.RestCycle;
  timeruser.Interval:=1000*60*refreshpriod;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var i : Byte;
begin
//kaveh is
{$ifdef OperatorBase}
  if not tblExists('collectMnt') then
    CreateTbl('collectMnt');
//  else if changedTbl('collectMnt') then
//    UpgradeTable('collectMnt');
{$endif OperatorBase}
//kaveh ie
  Timer1.Enabled := True;
  frmMain.Menu := mnuResturan;
  SetWinF;
  Refresh;
//  tmrRdr.Enabled := (TotalOnLineRdr > 0);
  Application.CreateForm(TfrmReaderState, frmReaderState);
  Application.CreateForm(TfrmFishLst, frmFishLst);
  Application.CreateForm(TfrmFishLst1, frmFishLst1);
  Application.CreateForm(TfrmFishLstPics, frmFishLstPics);
  g_options.RptFDate := CurrentDate;
  g_options.RptTDate := CurrentDate;

  if F_Params.AutoFishLstPicsActive then
  begin
    mnufishlstPics.Checked := not mnufishlstPics.Checked;
    if not frmFishLstPics.Showing then
      frmFishLstPics.Show
    else
      frmFishLstPics.Hide;
  end;
  
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 119) and (Shift = [ssCtrl]) then
    //Ctrl+F8
  begin
    IsTest := not IsTest;
     if IsTest then
       OpenTestFile
     else
     begin
       CloseTestFile;
       ShellEXECandWait('test.txt');
     end;
  end
  else if (Key = 116) and (Shift = [ssCtrl]) then
    // Ctrl+F5
  begin
    userDiscard := not userDiscard;
  end;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  if frmMain.WindowState = wsMinimized then
  begin
    frmMain.WindowState := wsMaximized;
    Application.Minimize;
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var frmparts: TfrmParts ;
begin           
  AddUserAction(mnuJobType.Caption);
  Application.CreateForm(TfrmParts , frmparts  );
 frmparts.ShowModal;
  frmparts.Free;

end;

procedure TfrmMain.createOnlineFrm(rdr: TReaders);
var
  frm : TfrmOnline;
begin
  frm := TfrmOnline.Create(frmMain);
  frm.Parent := frmMain;
  frm.rdr := rdr;
{$ifdef GHSDK}
  frm.SwitchReader(rdr);
{$endif}
  frm.LoadFishsNo(g_options.RunDate);
//  frm.Show;
end;

procedure TfrmMain.ReCreateOnlineFrms;
var
  i , last: Integer;

  obj : TObject;
begin
  last := frmMain.ControlCount-1;
  i := 0;
  while i<=last do
  begin
    if frmMain.Controls[i] is TfrmOnline then
    begin
      (frmMain.Controls[i] as TfrmOnline).Free;
      Dec(last);
    end
    else
      inc(i);
  end;
  i := 1;
{ ifndef RestService}
  for i := 1 to TotalReader do
{ endif RestService}  
    createOnlineFrm(Readers[i]);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//   EndOfUser;

{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    ServiceStop('', 'RestaurantService');
{$endif RestService}
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not ConfirmMessage('¬Ì« „ÌùŒÊ«ÂÌœ «“ »—‰«„Â Œ«—Ã ‘ÊÌœø') then
    CanClose := False
  else
  begin
    frmDBS.tblPersons.Close;
    {$ifdef RestService}
    if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
      ServiceStop('', 'RestaurantService');
    {$endif RestService}
    Halt(0);
  end;
end;

procedure TfrmMain.mnuHelpClick(Sender: TObject);
begin
  Application.HelpCommand(1, 2);
end;

procedure TfrmMain.mnuilgFishRptClick(Sender: TObject);
var frmilgFishRpt : TfrmilgFishRpt;
begin
  AddUserAction(mnuilgFishRpt.Caption);
  Application.CreateForm(TfrmilgFishRpt, frmilgFishRpt);
  frmilgFishRpt.ShowModal;
  frmilgFishRpt.Free;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var dt : String;
begin
  StatusBar.Panels[0].Text := TimeToStr(Time);
  dt := CurrentDate;
  if StatusBar.Panels[1].Text <> dt then
  begin
    StatusBar.Panels[1].Text := dt;
    g_options.RunDate := dt;
    InitVariables(False);
  end;
  Mouse_NoWait;
end;

procedure TfrmMain.timeruserTimer(Sender: TObject);
begin
   refreshuser(false);
end;

procedure TfrmMain.tmrRdrTimer(Sender: TObject);
begin
end;


{ Base }
procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.mnuezFishRptClick(Sender: TObject);
var frmezFishRpt : TfrmezFishRpt;
begin
  AddUserAction(mnuezFishRpt.Caption);
  Application.CreateForm(TfrmezFishRpt, frmezFishRpt);
  frmezFishRpt.ShowModal;
  frmezFishRpt.Free;
end;

procedure TfrmMain.mnuPartsClick(Sender: TObject);
var frmParts : TfrmParts;
begin
  AddUserAction(mnuParts.Caption);
  Application.CreateForm(TfrmParts, frmParts);
  frmParts.ShowModal;
  frmParts.Free;
end;

procedure TfrmMain.mnuJobTypeClick(Sender: TObject);
var frmJobType : TfrmJobType;
begin
  AddUserAction(mnuJobType.Caption);
  Application.CreateForm(TfrmJobType, frmJobType);
  frmJobType.ShowModal;
  frmJobType.Free;
end;

procedure TfrmMain.mnuPersonsClick(Sender: TObject);
var frmPersons : TfrmPersons;
begin
  AddUserAction(mnuPersons.Caption);
  Application.CreateForm(TfrmPersons, frmPersons);
  frmPersons.ShowModal;
  frmPersons.Free;
end;

procedure TfrmMain.mnuRejimClick(Sender: TObject);
var frmRejim : TfrmRejim;
begin
  AddUserAction(mnuRejim.Caption);
  Application.CreateForm(TfrmRejim, frmRejim);
  frmRejim.ShowModal;
  frmRejim.Free;
end;

procedure TfrmMain.mnuGustCardClick(Sender: TObject);
var frmGustCard : TfrmGustCard;
begin
  AddUserAction(mnuGustCard.Caption);
  Application.CreateForm(TfrmGustCard, frmGustCard);
  frmGustCard.ShowModal;
  frmGustCard.Free;
end;

procedure TfrmMain.mnuGrupsClick(Sender: TObject);
var frmGroups : TfrmGroups;
begin
  AddUserAction(mnuGrups.Caption);
  Application.CreateForm(TfrmGroups, frmGroups);
  frmGroups.ShowModal;
  frmGroups.Free;
end;

procedure TfrmMain.mnuOutGrpClick(Sender: TObject);
var frmOutGroup : TfrmOutGroup;
begin
  AddUserAction(mnuOutGrp.Caption);
  Application.CreateForm(TfrmOutGroup, frmOutGroup);
  frmOutGroup.ShowModal;
  frmOutGroup.Free;
end;

procedure TfrmMain.mnuUnitsClick(Sender: TObject);
var frmUnits : TfrmUnits;
begin
  AddUserAction(mnuUnits.Caption);
  Application.CreateForm(TfrmUnits, frmUnits);
  frmUnits.ShowModal;
  frmUnits.Free;
end;

procedure TfrmMain.mnuPrnClick(Sender: TObject);
var
  frmPrnParam: TfrmPrnParam;
  //frmPrnTest: TfrmPrnTest;
begin
  AddUserAction(mnuPrn.Caption);
  Application.CreateForm(TfrmPrnParam, frmPrnParam);
  frmPrnParam.ShowModal;
  frmPrnParam.Free;

  {Application.CreateForm(TfrmPrnTest, frmPrnTest);
  frmPrnTest.ShowModal;
  frmPrnTest.Free;}
end;





{ Resturant Operation }
procedure TfrmMain.mnuParamsClick(Sender: TObject);
var frmParams: TfrmParams;
begin
  AddUserAction(mnuParams.Caption);
  Application.CreateForm(TfrmParams, frmParams);
  frmParams.ShowModal;
  frmParams.Free;
end;

procedure TfrmMain.mnuKeyPadClick(Sender: TObject);
var frmKeyPad : TfrmKeyPad;
begin
  AddUserAction(mnuKeyPad.Caption);
  Application.CreateForm(TfrmKeyPad, frmKeyPad);
  frmKeyPad.ShowModal;
  frmKeyPad.Free;
end;

procedure TfrmMain.mnuFoodlistClick(Sender: TObject);
var frmFoodList : TfrmFoodList;
begin
  AddUserAction(mnuFoodList.Caption);
  Application.CreateForm(TfrmFoodList, frmFoodList);
  frmFoodList.ShowModal;
  frmFoodList.Free;
  LoadFoodList(g_options.RunDate);
end;

procedure TfrmMain.mnuProgFoodClick(Sender: TObject);
var frmProgFood: TfrmProgFood;
begin
  if (F_Params.Vadeh[MB_SOBH] = MB_FALSE) and
     (F_Params.Vadeh[MB_NAHAR] = MB_FALSE) and
     (F_Params.Vadeh[MB_SHAM] = MB_FALSE) then
    ErrorMessage('’»Õ«‰Â Ê ‰«Â«— Ê ‘«„° ”—Ê ‰„Ì ‘Êœ!')
  else
  begin
    AddUserAction(mnuProgFood.Caption);
    Application.CreateForm(TfrmProgFood, frmProgFood);
    frmProgFood.ShowModal;
    frmProgFood.Free;
    LoadDayProg(CurrentDate);
  end;
end;

procedure TfrmMain.mnuRdrKeyClick(Sender: TObject);
var frmRdrKey : TfrmRdrKey;
begin
  AddUserAction(mnuFish.Caption);
  Application.CreateForm(TfrmRdrKey, frmRdrKey);
  frmRdrKey.ShowModal;
  frmRdrKey.Free;
end;

procedure TfrmMain.mnuFishClick(Sender: TObject);
var frmPersonFish : TfrmPersonFish;
begin
  AddUserAction(mnuFish.Caption);
  Application.CreateForm(TfrmPersonFish, frmPersonFish);
  frmPersonFish.ShowModal;
  frmPersonFish.Free;
end;

procedure TfrmMain.mnufishlst1Click(Sender: TObject);
begin
  mnuFishLst1.Checked := not mnuFishLst1.Checked;
  if not frmFishLst1.Showing then
    frmFishLst1.Show
  else
    frmFishLst1.Hide;
end;

procedure TfrmMain.mnuFishUnitClick(Sender: TObject);
var frmFishUnit : TfrmFishUnit;
begin
  AddUserAction(mnuFishUnit.Caption);
  Application.CreateForm(TfrmFishUnit, frmFishUnit);
  frmFishUnit.ShowModal;
  frmFishUnit.Free;
end;

procedure TfrmMain.mnuDelFishClick(Sender: TObject);
var frmDelFish : TfrmDelFish;
begin
  AddUserAction(mnuDelFish.Caption);
  Application.CreateForm(TfrmDelFish, frmDelFish);
  frmDelFish.ShowModal;
  frmDelFish.Free;
end;

procedure TfrmMain.mnuDelUnitFishClick(Sender: TObject);
var frmDelUnitFish : TfrmDelUnitFish;
begin
  AddUserAction(mnuDelUnitFish.Caption);
  Application.CreateForm(TfrmDelUnitFish, frmDelUnitFish);
  frmDelUnitFish.ShowModal;
  frmDelUnitFish.Free;
end;

procedure TfrmMain.mnuIntelligentFileClick(Sender: TObject);
var frmIntelligentFile: TfrmIntelligentFile;
begin
  AddUserAction(mnuIntelligentFile.Caption);
  Application.CreateForm(TfrmIntelligentFile, frmIntelligentFile);
  frmIntelligentFile.ShowModal;
  frmIntelligentFile.Free
end;

procedure TfrmMain.mnuFishLstClick(Sender: TObject);
begin
  mnuFishLst.Checked := not mnuFishLst.Checked;
  if not frmFishLst.Showing then
    frmFishLst.Show
  else
    frmFishLst.Hide;
end;





procedure TfrmMain.mnufishlstPicsClick(Sender: TObject);
begin
  mnufishlstPics.Checked := not mnufishlstPics.Checked;
  if not frmFishLstPics.Showing then
    frmFishLstPics.Show
  else
    frmFishLstPics.Hide;
end;

{ Reports }
procedure TfrmMain.mnuPersonRptClick(Sender: TObject);
var frmPersonRpt : TfrmPersonRpt;
begin
  AddUserAction(mnuPersonRpt.Caption);
  Application.CreateForm(TfrmPersonRpt, frmPersonRpt);
  frmPersonRpt.ShowModal;
  frmPersonRpt.Free;
end;

procedure TfrmMain.mnuGustCardRptClick(Sender: TObject);
var frmGustCardRpt : TfrmGustCardRpt;
begin
  AddUserAction(mnuGustCardRpt.Caption);
  Application.CreateForm(TfrmGustCardRpt, frmGustCardRpt);
  frmGustCardRpt.ShowModal;
  frmGustCardRpt.Free;
end;

procedure TfrmMain.mnuFoodPriceRptClick(Sender: TObject);
var frmFoodPrcRpt: TfrmFoodPrcRpt;
begin
  AddUserAction(mnuFoodPriceRpt.Caption);
  Application.CreateForm(TfrmFoodPrcRpt, frmFoodPrcRpt);
  frmFoodPrcRpt.ShowModal;
  frmFoodPrcRpt.Free;
end;

procedure TfrmMain.mnuProgFodRptClick(Sender: TObject);
var frmProgFoodRpt : TfrmProgFoodRpt;
begin
  AddUserAction(mnuProgFodRpt.Caption);
  Application.CreateForm(TfrmProgFoodRpt, frmProgFoodRpt);
  frmProgFoodRpt.ShowModal;
  frmProgFoodRpt.Free;
end;

procedure TfrmMain.mnuListFishRptClick(Sender: TObject);
var frmFishLisrRpt: TfrmFishLisrRpt;
begin
  AddUserAction(mnuListFishRpt.Caption);
  Application.CreateForm(TfrmFishLisrRpt, frmFishLisrRpt);
  frmFishLisrRpt.ShowModal;
  frmFishLisrRpt.Free;
end;

procedure TfrmMain.mnuPrsAmrRptClick(Sender: TObject);
var frmPrsAmarRpt : TfrmPrsAmarRpt;
begin
  AddUserAction(mnuPrsAmrRpt.Caption);
  Application.CreateForm(TfrmPrsAmarRpt, frmPrsAmarRpt);
  frmPrsAmarRpt.ShowModal;
  frmPrsAmarRpt.Free;
end;

procedure TfrmMain.mnuDayFoodRptClick(Sender: TObject);
var frmDayFoodRpt : TfrmDayFoodRpt;
begin
  AddUserAction(mnuDayFoodRpt.Caption);
  Application.CreateForm(TfrmDayFoodRpt, frmDayFoodRpt);
  frmDayFoodRpt.ShowModal;
  frmDayFoodRpt.Free;
end;

procedure TfrmMain.mnuPrcFoodRptClick(Sender: TObject);
var frmPersonFishRpt : TfrmPersonFishRpt;
begin
  AddUserAction(mnuPrcFoodRpt.Caption);
  Application.CreateForm(TfrmPersonFishRpt, frmPersonFishRpt);
  frmPersonFishRpt.ShowModal;
  frmPersonFishRpt.Free;
end;

procedure TfrmMain.mnuYearFoodRptClick(Sender: TObject);
var frmYearFdMkhRpt : TfrmYearFdMkhRpt;
begin
  AddUserAction(mnuYearFoodRpt.Caption);
  Application.CreateForm(TfrmYearFdMkhRpt, frmYearFdMkhRpt);
  frmYearFdMkhRpt.ShowModal;
  frmYearFdMkhRpt.Free;
end;

procedure TfrmMain.mnuUnitFishRptClick(Sender: TObject);
var frmUnitFishRpt : TfrmUnitFishRpt;
begin
  AddUserAction(mnuUnitFishRpt.Caption);
  Application.CreateForm(TfrmUnitFishRpt, frmUnitFishRpt);
  frmUnitFishRpt.ShowModal;
  frmUnitFishRpt.Free;
end;

procedure TfrmMain.mnuAllFoodsRptClick(Sender: TObject);
var frmAllFoodsRpt : TfrmAllFoodsRpt;
begin
  AddUserAction(mnuAllFoodsRpt.Caption);
  Application.CreateForm(TfrmAllFoodsRpt, frmAllFoodsRpt);
  frmAllFoodsRpt.ShowModal;
  frmAllFoodsRpt.Free;
end;

procedure TfrmMain.mnuPeymanRptClick(Sender: TObject);
var frmPeymanRpt : TfrmPeymanRpt;
begin
  AddUserAction(mnuPeymanRpt.Caption);
  Application.CreateForm(TfrmPeymanRpt, frmPeymanRpt);
  frmPeymanRpt.ShowModal;
  frmPeymanRpt.Free;
end;

procedure TfrmMain.mnuCostUsedFoodRptClick(Sender: TObject);
var frmCostUsedFoodRpt : TfrmCostUsedFoodRpt;
begin
  AddUserAction(mnuCostUsedFoodRpt.Caption);
  Application.CreateForm(TfrmCostUsedFoodRpt, frmCostUsedFoodRpt);
  frmCostUsedFoodRpt.ShowModal;
  frmCostUsedFoodRpt.Free;
end;

procedure TfrmMain.mnuAmarPriceRptClick(Sender: TObject);
var frmAmarPriceRpt : TfrmAmarPriceRpt;
begin
  AddUserAction(mnuAmarPriceRpt.Caption);
  Application.CreateForm(TfrmAmarPriceRpt, frmAmarPriceRpt);
  frmAmarPriceRpt.ShowModal;
  frmAmarPriceRpt.Free;
end;

procedure TfrmMain.mnuRptReaderFishClick(Sender: TObject);
var frmRdrFishRpt : TfrmRdrFishRpt;
begin
  AddUserAction(mnuRptReaderFish.Caption);
  Application.CreateForm(TfrmRdrFishRpt, frmRdrFishRpt);
  frmRdrFishRpt.ShowModal;
  frmRdrFishRpt.Free;
end;

procedure TfrmMain.mnuNoFishRptClick(Sender: TObject);
var frmPersonNoFishRpt : TfrmPersonNoFishRpt;
begin
  AddUserAction(mnuNoFishRpt.Caption);
  Application.CreateForm(TfrmPersonNoFishRpt, frmPersonNoFishRpt);
  frmPersonNoFishRpt.ShowModal;
  frmPersonNoFishRpt.Free;
end;

procedure TfrmMain.mnuDoubleFishRptClick(Sender: TObject);
var frmDblFishRpt : TfrmDblFishRpt;
begin
  AddUserAction(mnuNoFishRpt.Caption);
  Application.CreateForm(TfrmDblFishRpt, frmDblFishRpt);
  frmDblFishRpt.ShowModal;
  frmDblFishRpt.Free;
end;

procedure TfrmMain.mnuDiffRptClick(Sender: TObject);
var frmDifferRpt : TfrmDifferRpt;
begin
  AddUserAction(mnuDiffRpt.Caption);
  Application.CreateForm(TfrmDifferRpt, frmDifferRpt);
  frmDifferRpt.ShowModal;
  frmDifferRpt.Free;
end;

procedure TfrmMain.mnuFoodPricePrcntClick(Sender: TObject);
var frmPeymanPrcntRpt : TfrmPeymanPrcntRpt;
begin
  AddUserAction(mnuFoodPricePrcnt.Caption);
  Application.CreateForm(TfrmPeymanPrcntRpt, frmPeymanPrcntRpt);
  frmPeymanPrcntRpt.ShowModal;
  frmPeymanPrcntRpt.Free;
end;

procedure TfrmMain.mnuTextFishRptClick(Sender: TObject);
var frmTextFish : TfrmTextFish;
begin
  AddUserAction(mnuTextFishRpt.Caption);
  Application.CreateForm(TfrmTextFish, frmTextFish);
  frmTextFish.ShowModal;
  frmTextFish.Free;
end;

procedure TfrmMain.mnuPrsCostRptClick(Sender: TObject);
var frmPrsCost : TfrmPrsCost;
begin
  AddUserAction(mnuPrsCostRpt.Caption);
  Application.CreateForm(TfrmPrsCost, frmPrsCost);
  frmPrsCost.ShowModal;
  frmPrsCost.Free;
end;

procedure TfrmMain.mnuDBFPrsClick(Sender: TObject);
var frmDBFMonth : TfrmDBFMonth;
begin
  AddUserAction(mnuDBFPrs.Caption);
  Application.CreateForm(TfrmDBFMonth, frmDBFMonth);
  frmDBFMonth.ShowModal;
  frmDBFMonth.Free;
end;

procedure TfrmMain.mnuOilRptClick(Sender: TObject);
var frmOilRpt : TfrmOilRpt;
begin
  AddUserAction(mnuOilRpt.Caption);
  Application.CreateForm(TfrmOilRpt, frmOilRpt);
  frmOilRpt.ShowModal;
  frmOilRpt.Free;
end;





{ Relation Operation }
procedure TfrmMain.mnuChargeUsedbyReserveClick(Sender: TObject);
var frmChargeUsedbyReserveRpt : TfrmChargeUsedbyReserveRpt;
begin
  AddUserAction(mnuChargeUsedbyReserve.Caption);
  Application.CreateForm(TfrmChargeUsedbyReserveRpt, frmChargeUsedbyReserveRpt);
  frmChargeUsedbyReserveRpt.ShowModal;
  frmChargeUsedbyReserveRpt.Free;
end;

procedure TfrmMain.mnuControlsClick(Sender: TObject);
var frmReaderList : TfrmReaderList;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuControls.Caption);
  Application.CreateForm(TfrmReaderList, frmReaderList);
  frmReaderList.ShowModal;
  frmReaderList.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuModemClick(Sender: TObject);
var frmModem : TfrmModem;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuModem.Caption);
  Application.CreateForm(TfrmModem, frmModem);
  frmModem.ShowModal;
  frmModem.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuRelationTestClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuRelationTest.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_TEST;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuRemainRptClick(Sender: TObject);
var frmRemainRpt : TfrmRemainRpt;
begin
  AddUserAction(mnuRemainRpt.Caption);
  Application.CreateForm(TfrmRemainRpt, frmRemainRpt);
  frmRemainRpt.ShowModal;
  frmRemainRpt.Free;
end;

procedure TfrmMain.mnureserve7Click(Sender: TObject);
var frmReserve7 : TfrmReserve7;
begin
  AddUserAction(mnureserve7.Caption);
  Application.CreateForm(TfrmReserve7, frmReserve7);
  frmReserve7.ShowModal;
  frmReserve7.Free;
end;

procedure TfrmMain.mnuChangeAddrClick(Sender: TObject);
var frmChngAddr : TfrmChngAddr;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuChangeAddr.Caption);
  Application.CreateForm(TfrmChngAddr, frmChngAddr);
  frmChngAddr.ShowModal;
  frmChngAddr.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuBaudClick(Sender: TObject);
var frmChngBaud: TfrmChngBaud;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuBaud.Caption);
  Application.CreateForm(TfrmChngBaud, frmChngBaud);
  frmChngBaud.ShowModal;
  frmChngBaud.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuChangeOnLineClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuChangeOnLine.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_ONLINE;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuResetClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuReset.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_RESTART;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuReaderInitialClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuReaderInitial.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_INITIAL;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuControlVersionClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuControlVersion.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_VER;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuSendTablesClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuSendTables.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_TBLSEND;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuSendDateTimeClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuSendDateTime.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_DATETIME;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuLimitCardClick(Sender: TObject);
var frmLimitCard : TfrmLimitCard;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuLimitCard.Caption);
  Application.CreateForm(TfrmLimitCard, frmLimitCard);
  frmLimitCard.ShowModal;
  frmLimitCard.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuInteligentClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuInteligent.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_READRECS;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuReadClockRecsClick(Sender: TObject);
var frmRelations : TfrmRelations;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuReadClockRecs.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := MB_RECOVERY;
  frmRelations.ShowModal;
  frmRelations.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuReadFileRecsClick(Sender: TObject);
var frmClockRecFile: TfrmClockRecFile;
begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
  AddUserAction(mnuReadFileRecs.Caption);
  Application.CreateForm(TfrmClockRecFile, frmClockRecFile);
  frmClockRecFile.ShowModal;
  frmClockRecFile.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
end;

procedure TfrmMain.mnuViewClockrecsClick(Sender: TObject);
var frmViewClockRecs: TfrmViewClockRecs;
begin
  if tblExists('ClckRecs') then
  begin
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ „ Êﬁ› ‘Êœø') then
      ServiceStop('', 'RestaurantService');
{$endif RestService}
    AddUserAction(mnuControlVersion.Caption);
    Application.CreateForm(TfrmViewClockRecs, frmViewClockRecs);
    frmViewClockRecs.ShowModal;
    frmViewClockRecs.Free;
{$ifdef RestService}
  if ServiceGetStatus('', 'RestaurantService') = SERVICE_STOPPED then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ «Ã—« ‘Êœø') then
      ServiceStart('', 'RestaurantService');
  end
  else if ServiceGetStatus('', 'RestaurantService') = SERVICE_RUNNING then
  begin
    if ConfirmMessage('¬Ì« ”—ÊÌ” —” Ê—«‰ —«Â «‰œ«“Ì „Ãœœ ‘Êœø') then
    begin
      ServiceStop('', 'RestaurantService');
      ServiceStart('', 'RestaurantService');
    end;
  end;
{$endif RestService}
  end
  else
    ErrorMessage('»«‰ﬂ „—»Êÿ »Â —ﬂÊ—œÂ«Ì ”«⁄  ÊÃÊœ ‰œ«—œ.');
end;

procedure TfrmMain.mnuRdrStateClick(Sender: TObject);
begin
  mnuRdrState.Checked := not mnuRdrState.Checked;
  if not frmReaderState.Showing then
    frmReaderState.Show
  else
    frmReaderState.Hide;
end;





{ Tools }
procedure TfrmMain.mnuUserDefClick(Sender: TObject);
var frmAdmin : TfrmAdmin;
begin
  AddUserAction(mnuUserDef.Caption);
  Application.CreateForm(TfrmAdmin, frmAdmin);
  frmAdmin.mnus := mnuResturan;
  frmAdmin.ShowModal;
  frmAdmin.Free;
end;

procedure TfrmMain.mnuChangePassClick(Sender: TObject);
var frmChangePassword : TfrmChangePassword;
begin
  AddUserAction(mnuChangePass.Caption);
  Application.CreateForm(TfrmChangePassword, frmChangePassword);
  frmChangePassword.ShowModal;
  frmChangePassword.Free;
end;

procedure TfrmMain.mnuUserActionClick(Sender: TObject);
var frmUserState : TfrmUserState;
begin
  AddUserAction(mnuUserAction.Caption);
  Application.CreateForm(TfrmUserState, frmUserState);
  frmUserState.ShowModal;
  frmUserState.Free;
end;

procedure TfrmMain.mnuChangeUserClick(Sender: TObject);
var frmreLogin : TfrmreLogin;
begin
  AddUserAction(mnuChangeUser.Caption);
  Application.CreateForm(TfrmReLogin, frmReLogin);
  frmReLogin.ShowModal;
  if frmReLogin.LoginValid then
  begin
    SetMenuItems;
    StatusBar.Panels[2].Text := ('˛ﬂ«—»—:') + UpperCase(g_Options.UserName) + '˛';
  end;

  frmReLogin.Free;
  if not authorized then halt(0);
end;

procedure TfrmMain.mnuBackupClick(Sender: TObject);
var frmBackup : TfrmBackup;
begin
  AddUserAction(mnuBackup.Caption);
  Application.CreateForm(TfrmBackup, frmBackup);
  frmBackup.ShowModal;
  frmBackup.Free;
end;

procedure TfrmMain.mnuRestoreClick(Sender: TObject);
var frmRestore : TfrmRestore;
begin
  AddUserAction(mnuRestore.Caption);
  Application.CreateForm(TfrmRestore, frmRestore);
  frmRestore.ShowModal;
  frmRestore.Free;
end;

procedure TfrmMain.mnuMBakupClick(Sender: TObject);
var frmMonthBackup : TfrmMonthBackup;
begin
  AddUserAction(mnuMBakup.Caption);
  Application.CreateForm(TfrmMonthBackup, frmMonthBackup);
  frmMonthBackup.ShowModal;
  frmMonthBackup.Free;
end;

procedure TfrmMain.mnuChangeAllClick(Sender: TObject);
var frmAllChange: TfrmAllChange;
begin
  AddUserAction(mnuChangeAll.Caption);
  Application.CreateForm(TfrmAllChange, frmAllChange);
  frmAllChange.ShowModal;
  frmAllChange.Free;
end;

procedure TfrmMain.mnuFreeDBSClick(Sender: TObject);
var frmFreeDBase : TfrmFreeDBase;
begin
  AddUserAction(mnuFreeDBS.Caption);
  Application.CreateForm(TfrmFreeDBase, frmFreeDBase);
  frmFreeDBase.ShowModal;
  frmFreeDBase.Free;
end;

procedure TfrmMain.mnuPersonConvertClick(Sender: TObject);
var frmPersonConvert : TfrmPersonConvert;
begin
  AddUserAction(mnuPersonConvert.Caption);
  Application.CreateForm(TfrmPersonConvert, frmPersonConvert);
  frmPersonConvert.ShowModal;
  frmPersonConvert.Free;
end;

procedure TfrmMain.mnuFromDataClick(Sender: TObject);
var frmReadFish : TfrmReadFish;
begin
  AddUserAction(mnuFromData.Caption);
  Application.CreateForm(TfrmReadFish, frmReadFish);
  frmReadFish.ShowModal;
  frmReadFish.Free;
end;

procedure TfrmMain.mnughFishRptClick(Sender: TObject);
var frmGhFishRpt : TfrmGhFishRpt;
begin
  AddUserAction(mnuGhFishRpt.Caption);
  Application.CreateForm(TfrmGhFishRpt, frmGhFishRpt);
  frmGhFishRpt.ShowModal;
  frmGhFishRpt.Free;
end;

procedure TfrmMain.mnuAboutClick(Sender: TObject);
var frmAbout : TfrmAbout;
begin
  AddUserAction(mnuAbout.Caption);
  Application.CreateForm(TfrmAbout, frmAbout);
  frmAbout.ShowModal;
  frmAbout.Free;
end;

procedure TfrmMain.mnuStatisticsPaymentRptClick(Sender: TObject);
var frmStatisticsPaymentRpt : TfrmStatisticsPaymentRpt;
begin
//kaveh is
  AddUserAction(mnuStatisticsPaymentRpt.Caption);
  Application.CreateForm(TfrmStatisticsPaymentRpt, frmStatisticsPaymentRpt);
  frmStatisticsPaymentRpt.ShowModal;
  frmStatisticsPaymentRpt.Free;
//kaveh ie
end;

procedure TfrmMain.mnuStatisticsUseRptClick(Sender: TObject);
var frmStatisticsUseRpt : TfrmStatisticsUseRpt;
begin
//kaveh is
  AddUserAction(mnuStatisticsUseRpt.Caption);
  Application.CreateForm(TfrmStatisticsUseRpt, frmStatisticsUseRpt);
  frmStatisticsUseRpt.ShowModal;
  frmStatisticsUseRpt.Free;
//kaveh ie
end;

procedure TfrmMain.mnuStatusBarClick(Sender: TObject);
begin
  mnuStatusBar.Checked := not mnuStatusBar.Checked;
  StatusBar.Visible := mnuStatusBar.Checked;
  StatusBar1.Visible := mnuStatusBar.Checked;
end;







procedure TfrmMain.mnuAmarTabkhClick(Sender: TObject);
var
  frmAmarTabkh: TfrmAmarTabkh;
begin
  AddUserAction(mnuAmarTabkh.Caption);
  Application.CreateForm(TfrmAmarTabkh, frmAmarTabkh);
  frmAmarTabkh.ShowModal;
  frmAmarTabkh.Free;
end;

procedure TfrmMain.mnuUpdateDBClick(Sender: TObject);
var
  frmUpdateDB: TfrmUpdateDB;
begin
  AddUserAction(mnuUpdateDB.Caption);
  Application.CreateForm(TfrmUpdateDB, frmUpdateDB);
  frmUpdateDB.ShowModal;
  frmUpdateDB.Free;
end;

procedure TfrmMain.mnuPrgPrsClick(Sender: TObject);
var frmPrgPerson : TfrmPrgPerson;
begin
  AddUserAction(mnuPrgPrs.Caption);
  Application.CreateForm(TfrmPrgPerson, frmPrgPerson);
  frmPrgPerson.ShowModal;
  frmPrgPerson.Free;
end;

procedure TfrmMain.mnuBuildingClick(Sender: TObject);
var frmBuilding : TfrmBuilding;
begin
  AddUserAction(mnuBuilding.Caption);
  Application.CreateForm(TfrmBuilding, frmBuilding);
  frmBuilding.ShowModal;
  frmBuilding.Free;
end;

procedure TfrmMain.mnuchargeClick(Sender: TObject);
var frmChargeRpt : TfrmChargeRpt;
begin
  AddUserAction(mnuCharge.Caption);
  Application.CreateForm(TfrmChargeRpt, frmChargeRpt);
  frmChargeRpt.ShowModal;
  frmChargeRpt.Free;
end;

procedure TfrmMain.N1Click(Sender: TObject);
var frmCreateDBs : TfrmCreateDBs;
begin
  AddUserAction(mnuBuilding.Caption);
  Application.CreateForm(TfrmCreateDBs, frmCreateDBs);
  frmCreateDBs.ShowModal;
  frmCreateDBs.Free;
end;

procedure TfrmMain.N2Click(Sender: TObject);
var frmchargLst: TfrmchargLst ;
begin
  AddUserAction(mnuParams.Caption);
  Application.CreateForm(TfrmchargLst , frmchargLst);
  frmchargLst.ShowModal;
  frmchargLst.Free;
end;


procedure TfrmMain.N3Click(Sender: TObject);
var frmYaraneh: TfrmYaraneh;
begin
  AddUserAction(mnuParams.Caption);
  Application.CreateForm(TfrmYaraneh , frmYaraneh);
  frmYaraneh.ShowModal;
  frmYaraneh.Free;
end;

end.
