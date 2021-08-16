unit Main;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, AdoDB, Math, ShellApi, Menus,

  Globals, DateProc, MSGs, FarsiApi, DBS, Cntroler, PlayMSG, Logo,
  PrnType, ComTools, RunCmnds,

  {Base Menu}
  Persons, CarType, Cars, Colors, Cities, Capacity, BarCods,
  Customs, Specials, Params, NewPersons, Departments, CoCars,

  {Relation Menu}
  RdrList, Relation, ChngAddr, ChngBaud, RdrStat, Display,

  {Translate Menu}
  Arival, ExitCar, EditInpt, 
  DelRec, ExtNoCrd, ExtNoCrdEdit,
  EditInptRiali,

  {Special Menu}
  Difrent,

  {Reports Menu}
  InOutRp, InOutARp, InOutPRp, GetPrcRp, CustRpt, BarCodRp, SpcRpt,
  DiffRp, DelRecRp, NoCardRp,
  InOutCRp, AmperRp, IOCstRp,
  

  {Tools Menu}
  Admin, ChngPass, Login, BackRstr, TimeDate, Archive,
  ReadArch, FreeDBS, About, jpeg, MakeTbl;

type
  TfrmMain = class(TForm)
    Timer1: TTimer;
    StatusBar: TStatusBar;
    imgPicture: TImage;
    mnuAllPark: TMainMenu;
    mnu1Base: TMenuItem;
    mnu1Cars: TMenuItem;
    mnu1Customs: TMenuItem;
    mnu1Card: TMenuItem;
    mnu1Capacity: TMenuItem;
    mnu1Special: TMenuItem;
    mnu1Sep1_2: TMenuItem;
    mnu1Exit: TMenuItem;
    mnu1Sep1_1: TMenuItem;
    mnu1Translate: TMenuItem;
    mnu1EnterCar: TMenuItem;
    mnu1ExitCar: TMenuItem;
    mnu1NoExit: TMenuItem;
    mnu1Report: TMenuItem;
    mnu1EntrExitRpt: TMenuItem;
    mnu1DarAmadRpt: TMenuItem;
    mnu1CustomRpt: TMenuItem;
    mnu1CardsRpt: TMenuItem;
    mnu1Tools: TMenuItem;
    mnu1UserDef: TMenuItem;
    mnu1ChangePass: TMenuItem;
    mnu1Sep5_1: TMenuItem;
    mnu1Backup: TMenuItem;
    mnu1Restore: TMenuItem;
    mnu1Sep5_2: TMenuItem;
    mnu1About: TMenuItem;
    mnu1Help: TMenuItem;
    mnu1Sep5_5: TMenuItem;
    mnu1StatusBar: TMenuItem;
    mnu1Colors: TMenuItem;
    mnu1Cities: TMenuItem;
    mnu1SetDateTime: TMenuItem;
    mnu1Sep5_4: TMenuItem;
    mnu1SpecialOp: TMenuItem;
    mnu1Motavari: TMenuItem;
    mnu1Amagar: TMenuItem;
    mnu1DelRec: TMenuItem;
    mnu1ExitNoCard: TMenuItem;
    mnu1DiffRpt: TMenuItem;
    mnu1CarName: TMenuItem;
    StatusBar1: TStatusBar;
    Bevel1: TBevel;
    mnu1SpcRpt: TMenuItem;
    mnu1Persons: TMenuItem;
    mnu1DelRecRpt: TMenuItem;
    tmrCar: TTimer;
    mnu1ExitNoCardRpt: TMenuItem;
    mnu1Sep3_1: TMenuItem;
    mnu1ReadetState: TMenuItem;
    mnu1FreeDBS: TMenuItem;
    mnu1Sep5_3: TMenuItem;
    mnu1Archive: TMenuItem;
    mnu1OutPrint: TMenuItem;
    mnu1Sep1_3: TMenuItem;
    mnu1ChangeUser: TMenuItem;
    mnu1InOutAmarRpt: TMenuItem;
    stsAmar: TStatusBar;
    mnu1ReadArchive: TMenuItem;
    mnu1EditEnter: TMenuItem;
    mnu1InOutPrcntRpt: TMenuItem;
    mnu1InOutCstRpt: TMenuItem;
    mnu1Sep3_2: TMenuItem;
    mnuCarsStatus: TMenuItem;
    mnuRelation1: TMenuItem;
    mnuControls1: TMenuItem;
    mnuSep5_1: TMenuItem;
    mnuRelationTest1: TMenuItem;
    mnuControlVersion1: TMenuItem;
    mnuSendDateTime1: TMenuItem;
    mnuBaud1: TMenuItem;
    mnuChangeAddr1: TMenuItem;
    mnuSep5_2: TMenuItem;
    mnuReset1: TMenuItem;
    mnuRdrInitial1: TMenuItem;
    mnuSep5_3: TMenuItem;
    mnuMsg1: TMenuItem;
    mnuSep5_4: TMenuItem;
    mnuClockNewRec1: TMenuItem;
    mnuRecovery1: TMenuItem;
    mnu1EditRialExit: TMenuItem;
    mnu1EditExit: TMenuItem;
    mnu1EditExitNoCard: TMenuItem;
    N1: TMenuItem;
    mnu1OpenDoor: TMenuItem;
    mnuCreateDBs: TMenuItem;
    mnu1CoCar: TMenuItem;
    mnu1InOutCoRpt: TMenuItem;
    mnu1AmperRpt: TMenuItem;
    mnu1CoCarsRpt: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure mnu1ExitClick(Sender: TObject);
    procedure mnu1ChangePassClick(Sender: TObject);
    procedure mnu1StatusBarClick(Sender: TObject);
    procedure mnu1UserDefClick(Sender: TObject);
    procedure mnu1CarsClick(Sender: TObject);
    procedure mnu1CarNameClick(Sender: TObject);
    procedure mnu1CitiesClick(Sender: TObject);
    procedure mnu1ColorsClick(Sender: TObject);
    procedure mnu1CapacityClick(Sender: TObject);
    procedure mnu1AboutClick(Sender: TObject);
    procedure mnu1CardClick(Sender: TObject);
    procedure mnu1CustomsClick(Sender: TObject);
    procedure mnu1SpecialClick(Sender: TObject);
    procedure mnu1NoExitClick(Sender: TObject);
    procedure mnu1MotavariClick(Sender: TObject);
    procedure mnu1EnterCarClick(Sender: TObject);
    procedure mnu1SetDateTimeClick(Sender: TObject);
    procedure mnu1ExitCarClick(Sender: TObject);
    procedure mnu1CustomRptClick(Sender: TObject);
    procedure mnu1SpcRptClick(Sender: TObject);
    procedure mnu1CardsRptClick(Sender: TObject);
    procedure mnu1DarAmadRptClick(Sender: TObject);
    procedure mnu1PersonsClick(Sender: TObject);
    procedure mnuRelationTest1Click(Sender: TObject);
    procedure mnuReset1Click(Sender: TObject);
    procedure mnuSendDateTime1Click(Sender: TObject);
    procedure mnuControlVersion1Click(Sender: TObject);
    procedure mnu1DelRecClick(Sender: TObject);
    procedure mnu1DelRecRptClick(Sender: TObject);
    procedure mnu1AmagarClick(Sender: TObject);
    procedure mnu1EntrExitRptClick(Sender: TObject);
    procedure mnu1DiffRptClick(Sender: TObject);
    procedure tmrCarTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnu1ExitNoCardClick(Sender: TObject);
    procedure mnu1ExitNoCardRptClick(Sender: TObject);
    procedure mnu1BackupClick(Sender: TObject);
    procedure mnu1RestoreClick(Sender: TObject);
    procedure mnu1ReadetStateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnu1FreeDBSClick(Sender: TObject);
    procedure mnu1DisplayClick(Sender: TObject);
    procedure mnu1ArchiveClick(Sender: TObject);
    procedure mnu1OutPrintClick(Sender: TObject);
    procedure mnu1HelpClick(Sender: TObject);
    procedure mnu1ChangeUserClick(Sender: TObject);
    procedure mnu2InOutCoRptClick(Sender: TObject);
    procedure mnu2AmperRptClick(Sender: TObject);
    procedure mnuSendMessage1Click(Sender: TObject);
    procedure mnu1InOutAmarRptClick(Sender: TObject);
    procedure mnu1OnLineClick(Sender: TObject);
    procedure mnu1ReadArchiveClick(Sender: TObject);
    procedure mnu1EditEnterClick(Sender: TObject);
    procedure mnu1InOutPrcntRptClick(Sender: TObject);
    procedure mnu1InOutCstRptClick(Sender: TObject);
    procedure mnuCarsStatusClick(Sender: TObject);
    procedure mnuChangeAddr1Click(Sender: TObject);
    procedure mnuBaud1Click(Sender: TObject);
    procedure mnuControls1Click(Sender: TObject);
    procedure mnuClockNewRec1Click(Sender: TObject);
    procedure mnuRecovery1Click(Sender: TObject);
    procedure mnuRdrInitial1Click(Sender: TObject);
    procedure mnuMsg1Click(Sender: TObject);
    procedure mnu1EditExitNoCardClick(Sender: TObject);
    procedure mnu1EditRialExitClick(Sender: TObject);
    procedure mnu1OpenDoorClick(Sender: TObject);
    procedure mnu1ReportClick(Sender: TObject);
    procedure mnuCreateDBsClick(Sender: TObject);
    procedure mnu1CoCarClick(Sender: TObject);
    procedure mnu1InOutCoRptClick(Sender: TObject);
    procedure mnu1AmperRptClick(Sender: TObject);
    procedure mnu1CoCarsRptClick(Sender: TObject);
  private
    { Private declarations }

    procedure SetWinF;
    procedure SetMenuItems;

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Unit1, Code_Sys, CarStat;



{$R *.DFM}

procedure TfrmMain.SetWinF;
var i, j : Byte;
begin
  for i := 0 to mnuAllPark.Items.Count-1 do
  begin
    mnuAllPark.Items[i].Caption := (mnuAllPark.Items[i].Caption);
    for j := 0 to mnuAllPark.Items[i].Count-1 do
      mnuAllPark.Items[i].Items[j].Caption := (mnuAllPark.Items[i].Items[j].Caption);
  end;
end;

function GetFieldName(txt : String) : String;
begin
  txt := Copy(txt, 4, Length(txt)-3);
  GetFieldName := txt
end;

procedure TfrmMain.SetMenuItems;
var
  i, j, k, dif : Byte;
  MnuBarVal : Integer;
  MnuItemVal : LongInt;
  SepValid : Boolean;
  qry : TAdoQuery;
begin
 if UpperCase(g_options.UserName) <> ADMIN_NAME then
 begin
  qry := TAdoQuery.Create(self);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Security WHERE UserName = ''' + g_options.UserName + '''');
  qry.Open;
  MnuBarVal := qry.FieldByName('MenuBar').AsInteger;
  for i := MNU_BASE to Self.Menu.Items.Count -1 do
  begin
    case i of
      MNU_BASE     : dif := 2;
      MNU_RELATION : dif := 1;
      MNU_TRANSFER : dif := 1;
      MNU_SPECIAL  : dif := 1;
      MNU_REPORT   : dif := 1;
      MNU_TOOLS    : dif := 5;
      else           dif := 1;
    end;

    if UpperCase(g_options.UserName) = ADMIN_NAME then
    begin
      if Self.Menu.Items[i].Count = 0 then
      begin
        Self.Menu.Items[i].Visible := False;
        Continue;
      end
      else
        Self.Menu.Items[i].Visible := True;
      for j := 0 to Self.Menu.Items[i].Count-dif do
        Self.Menu.Items[i].Items[j].Visible := True;
    end
    else if ((Trunc(Power(2, i)) and MnuBarVal) <> 0) or (i in [MNU_BASE, MNU_TOOLS]) then
    begin
      Self.Menu.Items[i].Visible := True;
      MnuItemVal := qry.Fields[i+4].AsInteger;
      k := 0;
      SepValid := False;
      if Self.Menu.Items[i].Count = 0 then
      begin
        Self.Menu.Items[i].Visible := False;
        Continue;
      end;
      for j := 0 to Self.Menu.Items[i].Count-dif do
      begin
        if Self.Menu.Items[i].Items[j].Caption <> '-' then
        begin
          if (Trunc(Power(2, k)) and MnuItemVal) <> 0 then
          begin
            Self.Menu.Items[i].Items[j].Visible := True;
            SepValid := True;
          end
          else
            Self.Menu.Items[i].Items[j].Visible := False;

          Inc(k);
        end
        else
        begin
          if not SepValid then
            Self.Menu.Items[i].Items[j].Visible := False;
          SepValid := False;
        end;
      end;
    end
    else
      Self.Menu.Items[i].Visible := False;
  end;
  
  qry.Close;
  qry.Free;
 end;

{$ifdef POSBase}
  Self.Menu.Items[0].Items[0].Enabled := True;
  Self.Menu.Items[0].Items[2].Enabled := False;
  Self.Menu.Items[0].Items[3].Enabled := False;
  Self.Menu.Items[0].Items[4].Enabled := False;
  Self.Menu.Items[1].Enabled := True;
  Self.Menu.Items[2].Items[0].Enabled := False;
  Self.Menu.Items[2].Items[1].Enabled := False;
  Self.Menu.Items[2].Items[2].Enabled := False;
  Self.Menu.Items[2].Items[3].Enabled := False;
  Self.Menu.Items[2].Items[4].Enabled := True;
  Self.Menu.Items[2].Items[5].Enabled := True;
  Self.Menu.Items[2].Items[6].Enabled := True;
{$endif POSBase}

{$ifdef PCBase}
  Self.Menu.Items[0].Items[0].Enabled := False;
  Self.Menu.Items[0].Items[2].Enabled := True;
  Self.Menu.Items[0].Items[3].Enabled := True;
  Self.Menu.Items[0].Items[4].Enabled := True;
  Self.Menu.Items[1].Enabled := True;
  Self.Menu.Items[2].Items[0].Enabled := True;
  Self.Menu.Items[2].Items[1].Enabled := True;
  Self.Menu.Items[2].Items[2].Enabled := True;
  Self.Menu.Items[2].Items[3].Enabled := True;
  Self.Menu.Items[2].Items[4].Enabled := True;
  Self.Menu.Items[2].Items[5].Enabled := True;
  Self.Menu.Items[2].Items[6].Enabled := False;
{$endif PCBase}

  Self.Menu.Items[0].Items[5].Visible := True;
  Self.Menu.Items[0].Items[6].Visible := False;
  Self.Menu.Items[0].Items[7].Visible := False;
  Self.Menu.Items[0].Items[8].Enabled := True;
  Self.Menu.Items[0].Items[9].Enabled := True;
  Self.Menu.Items[0].Items[10].Enabled := False;
  Self.Menu.Items[0].Items[12].Visible := True;
  Self.Menu.Items[0].Items[11].Enabled := True;
  Self.Menu.Items[2].Items[7].Enabled := False;
  Self.Menu.Items[2].Items[11].Visible := False;
  Self.Menu.Items[3].Items[0].Enabled := False;
  Self.Menu.Items[3].Items[1].Enabled := False;
  Self.Menu.Items[3].Items[2].Enabled := False;
  Self.Menu.Items[4].Items[2].Enabled := False;
  Self.Menu.Items[4].Items[4].Enabled := False;
  Self.Menu.Items[4].Items[5].Enabled := True;
  Self.Menu.Items[4].Items[6].Enabled := False;
  Self.Menu.Items[4].Items[7].Enabled := False;
  Self.Menu.Items[4].Items[8].Enabled := False;
  Self.Menu.Items[4].Items[10].Enabled := False;
  Self.Menu.Items[5].Items[4].Visible := False;
  Self.Menu.Items[5].Items[5].Visible := False;
  Self.Menu.Items[5].Items[9].Visible := False;
  Self.Menu.Items[5].Items[10].Visible := False;
  Self.Menu.Items[5].Items[11].Visible := False;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Left := 0;
  Self.Width := Screen.Width;
  Self.Height := Screen.Height - 25;
  self.WindowState := wsMaximized;

{$ifdef POSBase}
  Caption := (Caption) + ' ' + g_options.CoName + ' نسخه 6.1';
{$endif POSBase}
{$ifdef PCBase}
  Caption := (Caption) + ' ' + g_options.CoName + ' نسخه 6.2';
{$endif PCBase}
  if g_options.Shobeh <> '' then
    Caption := Caption + '-' + g_options.Shobeh;

//kaveh  if UpperCase(g_options.UserName) <> ADMIN_NAME then
    SetMenuItems;

{{$ifdef POSBase}{
  Self.Menu.Items[0].Items[2].Enabled := False;
  Self.Menu.Items[0].Items[3].Enabled := False;
  Self.Menu.Items[0].Items[4].Enabled := False;
  Self.Menu.Items[1].Enabled := True;

{$endif POSBase}
{{$ifdef PCBase}   {
  Self.Menu.Items[0].Items[2].Enabled := True;
  Self.Menu.Items[0].Items[3].Enabled := True;
  Self.Menu.Items[0].Items[4].Enabled := True;
  Self.Menu.Items[1].Enabled := False;

{$endif PCBase}   {
  Self.Menu.Items[0].Items[0].Visible := False;
  Self.Menu.Items[0].Items[5].Visible := False;
  Self.Menu.Items[0].Items[6].Visible := False;
  Self.Menu.Items[0].Items[7].Visible := False;
  Self.Menu.Items[0].Items[11].Visible := False;   }

  {if FileExists(g_options.ProgramPath + 'Parking.Jpg') then
    imgPicture.Picture.LoadFromFile(g_options.ProgramPath + 'Parking.Jpg')
  else if FileExists(g_options.ProgramPath + 'Parking.Bmp') then
    imgPicture.Picture.LoadFromFile(g_options.ProgramPath + 'Parking.Bmp');}


  Mouse_Wait;                 

//  StatusBar1.Panels[0].Text := ConvertToFarsi(('سيستم كنترل تردد خودرو - محصولي از شركت پرورش داده‌ها - تلفن 8712451 - فاكس 8722159***** ')) + #254;
  StatusBar1.Panels[0].Text := ConvertToFarsi(('سيستم كنترل تردد خودرو - محصولي از شركت طرح و پردازش غدیر - تلفن 4-88312732(021)  - فاكس 88312072(021)  www.ghadirco.net')) + #254;
  StatusBar.Panels[1].Text := CurrentDate;
  StatusBar.Panels[2].Text := ('‏كاربر:') + UpperCase(g_options.UserName) + '‏';
  StatusBar.Panels[3].Text := ('.....مقداردهي سيستم');
  stsAmar.Hint := (stsAmar.Hint);

  if (g_options.WinType = WIN_SINA_SYS) and FileExists(g_options.ProgramPath + 'SParking.Hlp') then
    Application.HelpFile := g_options.ProgramPath + 'SParking.Hlp'
  else if (g_options.WinType = WIN_MICROSOFT_SYS) and FileExists(g_options.ProgramPath + 'MParking.Hlp') then
    Application.HelpFile := g_options.ProgramPath + 'MParking.Hlp';

  LoadExit_Park;
  OpenTestFile;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Refresh;
  InitVariables;
  {Timer1.Enabled := True;}
  tmrCar.Enabled := True;
  SetWinF;
  Application.CreateForm(TfrmReaderState, frmReaderState);
  Application.CreateForm(TfrmPlayMessage, frmPlayMessage);

  UpdateMachinesCount(CurrentDate,0,AllParkNo,DayParkNo,DayAriveNo,DayExitNo);
  Mouse_NoWait;

end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not ConfirmMessage('آيا مي‌‌خواهيد از برنامه خارج شويد؟') then
    CanClose := False
  else
  begin
    frmReaderState.Free;
    frmPlayMessage.Free;
    CloseTestFile;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F4) and (Shift = []) then
    begin
      mnu1EnterCarClick(self);
    end;
  if (Key = VK_F5) and (Shift = []) then
    begin
      mnu1ExitCarClick(self);
    end;
  if (Key = VK_F8) and (Shift = []) then
    begin
      mnu1OpenDoorClick(self);
    end;
  if (Shift = [ssCtrl]) and (Key = 119) then
  begin
    { Ctrl + F8 }
    Key := 0;
    IsTest := not IsTest;
  end
  else if (Shift = [ssCtrl]) and (Key = 117) then
  begin
    {  Ctrl + F6  }
    tmrCar.Enabled := False;
    QuickReport1.Query1.connection := frmDBS.adoConnect;
    QuickReport1.Query1.Open;
    QuickReport1.Preview;
    QuickReport1.Query1.Close;
    tmrCar.Enabled := True;
  end;
end;

procedure TfrmMain.mnu1HelpClick(Sender: TObject);
begin
  Application.HelpCommand(1, 2);
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  StatusBar.Panels[0].Text := TimeToStr(Time);
  StatusBar.Panels[0].Text := CurrentTimes;
  StatusBar.Panels[1].Text := CurrentDate;
  StatusBar.Panels[3].Text := g_options.CoName;
  Mouse_NoWait;
end;

procedure TfrmMain.tmrCarTimer(Sender: TObject);
begin
  ControlReaders;
  stsAmar.Panels[2].Text := ('ورود روز = ') + IntToStr(DayAriveNo) +
                            ('       پارك شده روز = ') + IntToStr(DayParkNo);
  stsAmar.Panels[1].Text := ('خروج روز = ') + IntToStr(DayExitNo);
  stsAmar.Panels[0].Text := ('پارك شده كل = ') + IntToStr(AllParkNo);
end;

{ Base }
procedure TfrmMain.mnu1ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.mnu1PersonsClick(Sender: TObject);
var frmPersons : TfrmPersons;
begin
  Application.CreateForm(TfrmPersons, frmPersons);
  frmPersons.ShowModal;
  frmPersons.Free;
end;

procedure TfrmMain.mnu1CarsClick(Sender: TObject);
var frmCarTypes : TfrmCarTypes;
begin
  Application.CreateForm(TfrmCarTypes, frmCarTypes);
  frmCarTypes.ShowModal;
  frmCarTypes.Free;
end;

procedure TfrmMain.mnu1CarNameClick(Sender: TObject);
var frmCars : TfrmCars;
begin
  Application.CreateForm(TfrmCars, frmCars);
  frmCars.ShowModal;
  frmCars.Free;
end;

procedure TfrmMain.mnu1CoCarClick(Sender: TObject);
var frmCoCars : TfrmCoCars;
begin
  Application.CreateForm(TfrmCoCars, frmCoCars);
  frmCoCars.ShowModal;
  frmCoCars.Free;

end;

procedure TfrmMain.mnu1CoCarsRptClick(Sender: TObject);
{var
  frmPrnType : TfrmPrnType;
  frmRptCoCars: TfrmRptCoCars;}
begin
{  Application.CreateForm(TfrmPrnType, frmPrnType);
  Application.CreateForm(TfrmRptCoCars,frmRptCoCars);
  frmPrnType.ShowModal;
  frmRptCoCars.bndCoName.Enabled := frmPrnType.chkCoName.Checked;
  frmRptCoCars.tblCoCars.Open;
  SetUserControl;
  if frmPrnType.rdoScreen.Checked then
    frmRptCoCars.qrptCoCars.Preview
  else
    frmRptCoCars.qrptCoCars.Print;
  UserControl := False;
  frmRptCoCars.tblCoCars.Close;
  frmRptCoCars.Free;
  frmPrnType.Free; }
end;

procedure TfrmMain.mnu1ColorsClick(Sender: TObject);
var frmColors : TfrmColors;
begin
  Application.CreateForm(TfrmColors, frmColors);
  frmColors.ShowModal;
  frmColors.Free;
end;

procedure TfrmMain.mnu1CitiesClick(Sender: TObject);
//var frmCities : TfrmCities;
var frmDepartments : TfrmDepartments;
begin
  Application.CreateForm(TfrmDepartments, frmDepartments);
  frmDepartments.ShowModal;
  frmDepartments.Free;

//  Application.CreateForm(TfrmCities, frmCities);
//  frmCities.ShowModal;
//  frmCities.Free;
end;

procedure TfrmMain.mnu1CapacityClick(Sender: TObject);
var frmCapacity : TfrmCapacity;
begin
  Application.CreateForm(TfrmCapacity, frmCapacity);
  frmCapacity.ShowModal;
  frmCapacity.Free;
end;

procedure TfrmMain.mnu1CardClick(Sender: TObject);
var frmBarCodes : TfrmBarCodes;
begin
  Application.CreateForm(TfrmBarCodes, frmBarCodes);
  frmBarCodes.ShowModal;
  frmBarCodes.Free;
end;

procedure TfrmMain.mnu1CustomsClick(Sender: TObject);
var frmNewPersons : TfrmNewPersons;
begin
  Application.CreateForm(TfrmNewPersons, frmNewPersons);
  frmNewPersons.ShowModal;
  frmNewPersons.Free;

//  Application.CreateForm(TfrmCustoms, frmCustoms);
//  frmCustoms.ShowModal;
//  frmCustoms.Free;
end;

procedure TfrmMain.mnu1SpecialClick(Sender: TObject);
var frmSpecials : TfrmSpecials;
begin
  Application.CreateForm(TfrmSpecials, frmSpecials);
  frmSpecials.SpcType := MB_TAKHFIF;
  frmSpecials.ShowModal;
  frmSpecials.Free;
end;

procedure TfrmMain.mnu1OutPrintClick(Sender: TObject);
var frmParams: TfrmParams;
begin
  Application.CreateForm(TfrmParams, frmParams);
  frmParams.ShowModal;
  frmParams.Free;
end;

{ Relation Operation }
procedure TfrmMain.mnuRdrInitial1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_INITIAL;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuRecovery1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_RECOVERY;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuRelationTest1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_TEST;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuChangeAddr1Click(Sender: TObject);
var frmChngAddr : TfrmChngAddr;
begin
  Application.CreateForm(TfrmChngAddr, frmChngAddr);
  frmChngAddr.ShowModal;
  frmChngAddr.Free;
end;

procedure TfrmMain.mnuClockNewRec1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_COLLECT;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuBaud1Click(Sender: TObject);
var frmChngBaud: TfrmChngBaud;
begin
  Application.CreateForm(TfrmChngBaud, frmChngBaud);
  frmChngBaud.ShowModal;
  frmChngBaud.Free;
end;

procedure TfrmMain.mnuReset1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_RESTART;
  frmRelations.ShowModal;
  frmRelations.Free;
end;


procedure TfrmMain.mnuSendDateTime1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_DATETIME;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuControls1Click(Sender: TObject);
var frmReaders : TfrmReaders;
begin
  Application.CreateForm(TfrmReaders, frmReaders);
  frmReaders.ShowModal;
  frmReaders.Free;
end;

procedure TfrmMain.mnuControlVersion1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_VER;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuCreateDBsClick(Sender: TObject);
begin
  //Creation Tables
//  AddUserAction(mnuCreateDBs.Caption);
  Application.CreateForm(TfrmCreateTables, frmCreateTables);
  frmCreateTables.ShowModal;
  frmCreateTables.Free;
end;

procedure TfrmMain.mnuMsg1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_MSG;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuSendMessage1Click(Sender: TObject);
var frmRelations : TfrmRelations;
begin
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_MSG;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnu1OpenDoorClick(Sender: TObject);
begin
//  Readers[1].R_Type := RDR_CLK6000;
  if (g_Options.ActiveRdrCode > 0) AND (g_Options.ActiveRdrCode < 256) then
  begin
    Mouse_Wait;
    MSG_Wait('در حال بازکردن بالابر (دستگاه ' + IntToStr(g_Options.ActiveRdrCode) + ')...');
    SetOpenDoor_All(Readers[FindReaderCodeIdx(g_Options.ActiveRdrCode)], '1000');
    Sleep(3000);
    SetOpenDoor_Normal(Readers[FindReaderCodeIdx(g_Options.ActiveRdrCode)], 3);
    Mouse_NoWait;
    MSG_NoWait;
  end
  else
    InformationMessage('دستگاه فعال برای بالابر انتخاب نشده است.');
end;

procedure TfrmMain.mnu1EditRialExitClick(Sender: TObject);
var frmEditInputRiali : TfrmEditInputRiali;
begin
  Application.CreateForm(TfrmEditInputRiali, frmEditInputRiali);
  frmEditInputRiali.ShowModal;
  frmEditInputRiali.Free;
end;

procedure TfrmMain.mnu1EditExitNoCardClick(Sender: TObject);
var frmExitNoCardEdit : TfrmExitNoCardEdit;
begin
{  Application.CreateForm(TfrmExitNoCardEdit, frmExitNoCardEdit);
  frmExitNoCardEdit.ShowModal;
  frmExitNoCardEdit.Free; }
end;

procedure TfrmMain.mnu1DisplayClick(Sender: TObject);
var frmDisplay : TfrmDisplay;
begin
  Application.CreateForm(TfrmDisplay, frmDisplay);
  frmDisplay.ShowModal;
  frmDisplay.Free;
end;

procedure TfrmMain.mnu1OnLineClick(Sender: TObject);
begin
//  mnu1OnLine.Checked := not mnu1OnLine.Checked;
//  tmrCar.Enabled := mnu1OnLine.Checked;
end;

{ Translate Operation }
procedure TfrmMain.mnu1EnterCarClick(Sender: TObject);
var
  frmArival : TfrmArival;
  s : String;
begin
  Application.CreateForm(TfrmArival, frmArival);
  s := mnu1EnterCar.Caption; 
  Delete(s, Pos('&', s), 1);
  Delete(s, Pos('...', s), 3);
  frmArival.Caption := s;
  frmArival.ShowModal;
  frmArival.Free;
end;

procedure TfrmMain.mnu1ExitCarClick(Sender: TObject);
var
  frmExitCar : TfrmExitCar;
  s : String;
begin
  Application.CreateForm(TfrmExitCar, frmExitCar);
  s := mnu1ExitCar.Caption;
  Delete(s, Pos('&', s), 1);
  Delete(s, Pos('...', s), 3);
  frmExitCar.Caption := s;
  frmExitCar.ShowModal;
  frmExitCar.Free;
end;

procedure TfrmMain.mnu1EditEnterClick(Sender: TObject);
var frmEditInput : TfrmEditInput;
begin
  Application.CreateForm(TfrmEditInput, frmEditInput);
  frmEditInput.ShowModal;
  frmEditInput.Free;
end;

procedure TfrmMain.mnu1DelRecClick(Sender: TObject);
var frmDelete: TfrmDelete;
begin
  Application.CreateForm(TfrmDelete, frmDelete);
  frmDelete.ShowModal;
  frmDelete.Free;
end;

procedure TfrmMain.mnu1ExitNoCardClick(Sender: TObject);
var frmExitNoCard : TfrmExitNoCard;
begin
  Application.CreateForm(TfrmExitNoCard, frmExitNoCard);
  frmExitNoCard.ShowModal;
  frmExitNoCard.Free;
end;

procedure TfrmMain.mnuCarsStatusClick(Sender: TObject);
begin
  if frmCarsStatus.WindowState <> wsNormal then
    frmCarsStatus.WindowState := wsNormal;
  frmCarsStatus.Show;
end;




procedure TfrmMain.mnu1ReadetStateClick(Sender: TObject);
begin
  mnu1ReadetState.Checked := not mnu1ReadetState.Checked;
  if not frmReaderState.Showing then
    frmReaderState.Show
  else
    frmReaderState.Hide;
end;



procedure TfrmMain.mnu1ReportClick(Sender: TObject);
begin

end;

{ Special Operation }
procedure TfrmMain.mnu1NoExitClick(Sender: TObject);
var frmSpecials : TfrmSpecials;
begin
  Application.CreateForm(TfrmSpecials, frmSpecials);
  frmSpecials.SpcType := MB_NOTEXIT;
  frmSpecials.ShowModal;
  frmSpecials.Free;
end;

procedure TfrmMain.mnu1MotavariClick(Sender: TObject);
var frmSpecials : TfrmSpecials;
begin
  Application.CreateForm(TfrmSpecials, frmSpecials);
  frmSpecials.SpcType := MB_MOTAVARI;
  frmSpecials.ShowModal;
  frmSpecials.Free;
end;

procedure TfrmMain.mnu1AmagarClick(Sender: TObject);
var frmDiff : TfrmDiff;
begin
  Application.CreateForm(TfrmDiff, frmDiff);
  frmDiff.ShowModal;
  frmDiff.Free;
end;


procedure TfrmMain.mnu1AmperRptClick(Sender: TObject);
//var frmAmperRpt : TfrmAmperRpt;
begin
{  Application.CreateForm(TfrmAmperRpt, frmAmperRpt);
  frmAmperRpt.ShowModal;
  frmAmperRpt.Free;}
end;

{ Reports }
procedure TfrmMain.mnu2InOutCoRptClick(Sender: TObject);
var frmInOutCoRpt : TfrmInOutCoRpt;
begin
  Application.CreateForm(TfrmInOutCoRpt, frmInOutCoRpt);
  frmInOutCoRpt.ShowModal;
  frmInOutCoRpt.Free;
end;


procedure TfrmMain.mnu1EntrExitRptClick(Sender: TObject);
var frmInOutRpt : TfrmInOutRpt;
begin
  Application.CreateForm(TfrmInOutRpt, frmInOutRpt);
  frmInOutRpt.ShowModal;
  frmInOutRpt.Free;
end;

procedure TfrmMain.mnu1InOutAmarRptClick(Sender: TObject);
var frmInOutAmarRpt: TfrmInOutAmarRpt;
begin
  Application.CreateForm(TfrmInOutAmarRpt, frmInOutAmarRpt);
  frmInOutAmarRpt.ShowModal;
  frmInOutAmarRpt.Free;
end;

procedure TfrmMain.mnu1InOutPrcntRptClick(Sender: TObject);
var frmInOutPrcntRpt: TfrmInOutPrcntRpt;
begin
  Application.CreateForm(TfrmInOutPrcntRpt, frmInOutPrcntRpt);
  frmInOutPrcntRpt.ShowModal;
  frmInOutPrcntRpt.Free;
end;

procedure TfrmMain.mnu2AmperRptClick(Sender: TObject);
var frmAmperRpt : TfrmAmperRpt;
begin
  Application.CreateForm(TfrmAmperRpt, frmAmperRpt);
  frmAmperRpt.ShowModal;
  frmAmperRpt.Free;
end;

procedure TfrmMain.mnu1DarAmadRptClick(Sender: TObject);
var frmGetPriceRpt : TfrmGetPriceRpt;
begin
  Application.CreateForm(TfrmGetPriceRpt, frmGetPriceRpt);
  frmGetPriceRpt.ShowModal;
  frmGetPriceRpt.Free;
end;

procedure TfrmMain.mnu1InOutCoRptClick(Sender: TObject);
var frmInOutCoRpt : TfrmInOutCoRpt;
begin
  Application.CreateForm(TfrmInOutCoRpt, frmInOutCoRpt);
  frmInOutCoRpt.ShowModal;
  frmInOutCoRpt.Free;
end;

procedure TfrmMain.mnu1InOutCstRptClick(Sender: TObject);
var frmInOutCstRpt : TfrmInOutCstRpt;
begin
  Application.CreateForm(TfrmInOutCstRpt, frmInOutCstRpt);
  frmInOutCstRpt.ShowModal;
  frmInOutCstRpt.Free;
end;

procedure TfrmMain.mnu1CustomRptClick(Sender: TObject);
var frmCustomsRpt : TfrmCustomsRpt;
begin
  Application.CreateForm(TfrmCustomsRpt, frmCustomsRpt);
  frmCustomsRpt.ShowModal;
  frmCustomsRpt.Free;
end;

procedure TfrmMain.mnu1CardsRptClick(Sender: TObject);
var frmBarCodeRpt : TfrmBarCodeRpt;
begin
  Application.CreateForm(TfrmBarCodeRpt, frmBarCodeRpt);
  frmBarCodeRpt.ShowModal;
  frmBarCodeRpt.Free;
end;

procedure TfrmMain.mnu1SpcRptClick(Sender: TObject);
var frmSpecialRpt : TfrmSpecialRpt;
begin
  Application.CreateForm(TfrmSpecialRpt, frmSpecialRpt);
  frmSpecialRpt.ShowModal;
  frmSpecialRpt.Free;
end;

procedure TfrmMain.mnu1DiffRptClick(Sender: TObject);
var frmDiffRpt : TfrmDiffRpt;
begin
  Application.CreateForm(TfrmDiffRpt, frmDiffRpt);
  frmDiffRpt.ShowModal;
  frmDiffRpt.Free;
end;

procedure TfrmMain.mnu1DelRecRptClick(Sender: TObject);
var frmDeleRecRpt : TfrmDeleRecRpt;
begin
  Application.CreateForm(TfrmDeleRecRpt, frmDeleRecRpt);
  frmDeleRecRpt.ShowModal;
  frmDeleRecRpt.Free;
end;

procedure TfrmMain.mnu1ExitNoCardRptClick(Sender: TObject);
var frmExitNoCardRpt : TfrmExitNoCardRpt;
begin
  Application.CreateForm(TfrmExitNoCardRpt, frmExitNoCardRpt);
  frmExitNoCardRpt.ShowModal;
  frmExitNoCardRpt.Free;
end;

{ Tools }
procedure TfrmMain.mnu1UserDefClick(Sender: TObject);
var frmAdmin : TfrmAdmin;
begin
  Application.CreateForm(TfrmAdmin, frmAdmin);
  frmAdmin.mnus := Menu;
  frmAdmin.ShowModal;
  frmAdmin.Free;
end;

procedure TfrmMain.mnu1ChangePassClick(Sender: TObject);
var frmChangePassword : TfrmChangePassword;
begin
  Application.CreateForm(TfrmChangePassword, frmChangePassword);
  frmChangePassword.ShowModal;
  frmChangePassword.Free;
end;

procedure TfrmMain.mnu1ChangeUserClick(Sender: TObject);
var frmLogin : TfrmLogin;
begin
  Application.CreateForm(TfrmLogin, frmLogin);
  frmLogin.ShowModal;
  if frmLogin.LoginValid then
  begin
    SetMenuItems;
    StatusBar.Panels[2].Text := '‏كاربر:' + UpperCase(g_options.UserName) + '‏';
  end;

  frmLogin.Free;
end;

procedure TfrmMain.mnu1BackupClick(Sender: TObject);
var frmBackupRestore : TfrmBackupRestore;
begin
  Application.CreateForm(TfrmBackupRestore, frmBackupRestore);
  frmBackupRestore.BackRst := MB_BACKUP;
  frmBackupRestore.ShowModal;
  frmBackupRestore.Free;
end;

procedure TfrmMain.mnu1RestoreClick(Sender: TObject);
var frmBackupRestore : TfrmBackupRestore;
begin
  Application.CreateForm(TfrmBackupRestore, frmBackupRestore);
  frmBackupRestore.BackRst := MB_RESTORE;
  frmBackupRestore.ShowModal;
  frmBackupRestore.Free;
end;

procedure TfrmMain.mnu1ArchiveClick(Sender: TObject);
var frmArchive : TfrmArchive;
begin
  Application.CreateForm(TfrmArchive, frmArchive);
  frmArchive.ShowModal;
  frmArchive.Free;
end;

procedure TfrmMain.mnu1ReadArchiveClick(Sender: TObject);
var frmReadArchive : TfrmReadArchive;
begin
  Application.CreateForm(TfrmReadArchive, frmReadArchive);
  frmReadArchive.ShowModal;
  frmReadArchive.Free;
end;

procedure TfrmMain.mnu1FreeDBSClick(Sender: TObject);
var frmFreeDBase : TfrmFreeDBase;
begin
  Application.CreateForm(TfrmFreeDBase, frmFreeDBase);
  frmFreeDBase.ShowModal;
  frmFreeDBase.Free;
end;

procedure TfrmMain.mnu1SetDateTimeClick(Sender: TObject);
var
  frmDateTime : TfrmDateTime;
  {zFileName : array[0..79] of Char;}
begin
  {ShellExecute(Handle, nil, StrPCopy(zFileName, 'TimeDate.Exe'), nil,
               nil, SW_RESTORE);}
  Application.CreateForm(TfrmDateTime, frmDateTime);
  frmDateTime.ShowModal;
  frmDateTime.Free;
  mnu1StatusBarClick(Sender);
  mnu1StatusBarClick(Sender);
end;

procedure TfrmMain.mnu1AboutClick(Sender: TObject);
var frmAbout : TfrmAbout;
begin
  Application.CreateForm(TfrmAbout, frmAbout);
  frmAbout.ShowModal;
  frmAbout.Free;
end;

procedure TfrmMain.mnu1StatusBarClick(Sender: TObject);
begin
  mnu1StatusBar.Checked := not mnu1StatusBar.Checked;
  StatusBar.Visible := mnu1StatusBar.Checked;
  StatusBar1.Visible := mnu1StatusBar.Checked;
  Timer1.Enabled := mnu1StatusBar.Checked;
end;



end.
