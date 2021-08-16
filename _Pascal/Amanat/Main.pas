unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ComCtrls, jpeg, StdCtrls;

type
  TfrmMain = class(TForm)
    Bevel1: TBevel;
    imgPicture: TImage;
    pnl: TPanel;
    StatusBar: TStatusBar;
    Timer1: TTimer;
    mnuCredit: TMainMenu;
    mnuDefinition: TMenuItem;
    mnuUnit: TMenuItem;
    mnuCoPost: TMenuItem;
    mnuParts: TMenuItem;
    mnuEmployee: TMenuItem;
    mnuService: TMenuItem;
    mnuSep1_2: TMenuItem;
    mnuExit: TMenuItem;
    mnuOperation: TMenuItem;
    mnuCharge: TMenuItem;
    mnuSep2_2: TMenuItem;
    mnuCredReciept: TMenuItem;
    mnuReport: TMenuItem;
    mnuPersonRpt: TMenuItem;
    mnuSep3_1: TMenuItem;
    mnuRelation: TMenuItem;
    mnuReaders: TMenuItem;
    mnuSep1_1: TMenuItem;
    mnuLinkTest: TMenuItem;
    mnuTools: TMenuItem;
    mnuUserDef: TMenuItem;
    mnuChangePass: TMenuItem;
    mnuUserAction: TMenuItem;
    mnuSep5_1: TMenuItem;
    mnuPersonConvery: TMenuItem;
    mnuCreateDBs: TMenuItem;
    mnuSep5_3: TMenuItem;
    mnuPortTest: TMenuItem;
    mnuSep5_4: TMenuItem;
    mnuReportFont: TMenuItem;
    mnuSep5_5: TMenuItem;
    mnuChangeUser: TMenuItem;
    mnuAbout: TMenuItem;
    mnuHelp: TMenuItem;
    mnuGroups: TMenuItem;
    mnuEditCharge: TMenuItem;
    mnuReadVersion: TMenuItem;
    mnuSep4_1: TMenuItem;
    mnuReset: TMenuItem;
    mnuConfiguration: TMenuItem;
    mnuSep4_2: TMenuItem;
    mnuReaderDateTime: TMenuItem;
    mnuChngBaudRate: TMenuItem;
    mnuChngAddress: TMenuItem;
    mnuSep4_3: TMenuItem;
    mnuLimitTime: TMenuItem;
    mnuLimitCard: TMenuItem;
    mnuAccessCode: TMenuItem;
    mnuRptUsedService: TMenuItem;
    mnuSep2_3: TMenuItem;
    mnuDelReceipt: TMenuItem;
    mnuSep4_4: TMenuItem;
    mnuAuthority: TMenuItem;
    mnuSep4_5: TMenuItem;
    mnuOnLine: TMenuItem;
    tmrOnline: TTimer;
    mnuParams: TMenuItem;
    mnuSep2_1: TMenuItem;
    mnuSep4_6: TMenuItem;
    mnuWinSetup: TMenuItem;
    mnuDepartment: TMenuItem;
    mnuSrvcLstRpt: TMenuItem;
    mnuRptEmplSrvc: TMenuItem;
    mnuRptDepartSrvc: TMenuItem;
    mnuMain: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    mnuSearch: TMenuItem;
    MenuItem65: TMenuItem;
    mnuReaderOnline: TMenuItem;
    mnuprnparam: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    mnuBarcodeRpt: TMenuItem;
    mnuInitCard: TMenuItem;
    mnuCollectNew: TMenuItem;
    mnuModem: TMenuItem;
    mnudial: TMenuItem;
    mnuRecovery: TMenuItem;
    N3: TMenuItem;
    mnuLostCard: TMenuItem;
    mnuSendLostCard: TMenuItem;
    lott: TMenuItem;
    mnuRptamar3: TMenuItem;
    mnuRptamar2: TMenuItem;
    mnuRptamar1: TMenuItem;
    mnuRptamar4: TMenuItem;
    mnuMoRange: TMenuItem;
    procedure lottClick(Sender: TObject);
    procedure mnuSendLostCardClick(Sender: TObject);
    procedure mnuLostCardClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure mnuRecoveryClick(Sender: TObject);
    procedure mnuModemClick(Sender: TObject);
    procedure mnudialClick(Sender: TObject);
    procedure mnuCollectNewClick(Sender: TObject);
    procedure mnuInitCardClick(Sender: TObject);
    procedure mnuBarcodeRptClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure mnuUnitClick(Sender: TObject);
    procedure mnuCoPostClick(Sender: TObject);
    procedure mnuPartsClick(Sender: TObject);
    procedure mnuEmployeeClick(Sender: TObject);
    procedure mnuServiceClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuChargeClick(Sender: TObject);
    procedure mnuPersonRptClick(Sender: TObject);
    procedure mnuReadersClick(Sender: TObject);
    procedure mnuLinkTestClick(Sender: TObject);
    procedure mnuUserDefClick(Sender: TObject);
    procedure mnuChangePassClick(Sender: TObject);
    procedure mnuUserActionClick(Sender: TObject);
    procedure mnuPersonConveryClick(Sender: TObject);
    procedure mnuCreateDBsClick(Sender: TObject);
    procedure mnuGroupsClick(Sender: TObject);
    procedure mnuEditChargeClick(Sender: TObject);
    procedure mnuReadVersionClick(Sender: TObject);
    procedure mnuResetClick(Sender: TObject);
    procedure mnuConfigurationClick(Sender: TObject);
    procedure mnuReaderDateTimeClick(Sender: TObject);
    procedure mnuChngBaudRateClick(Sender: TObject);
    procedure mnuChngAddressClick(Sender: TObject);
    procedure mnuLimitTimeClick(Sender: TObject);
    procedure mnuLimitCardClick(Sender: TObject);
    procedure mnuAccessCodeClick(Sender: TObject);
    procedure mnuAboutClick(Sender: TObject);
    procedure mnuPortTestClick(Sender: TObject);
    procedure mnuChangeUserClick(Sender: TObject);
    procedure mnuDelReceiptClick(Sender: TObject);
    procedure mnuOnLineClick(Sender: TObject);
    procedure mnuAuthorityClick(Sender: TObject);
    procedure tmrOnlineTimer(Sender: TObject);
    procedure mnuParamsClick(Sender: TObject);
    procedure mnuWinSetupClick(Sender: TObject);
    procedure mnuRptUsedServiceClick(Sender: TObject);
    procedure mnuCredRecieptClick(Sender: TObject);
    procedure mnuDepartmentClick(Sender: TObject);
    procedure mnuReportFontClick(Sender: TObject);
    procedure mnuSrvcLstRptClick(Sender: TObject);
    procedure mnuHelpClick(Sender: TObject);
    procedure mnuRptEmplSrvcClick(Sender: TObject);
    procedure mnuRptDepartSrvcClick(Sender: TObject);
    procedure mnuSearchClick(Sender: TObject);
    procedure mnuReaderOnlineClick(Sender: TObject);
    procedure mnuprnparamClick(Sender: TObject);
    procedure mnuRptamar3Click(Sender: TObject);
    procedure mnuRptamar2Click(Sender: TObject);
    procedure mnuRptamar1Click(Sender: TObject);
    procedure mnuRptamar4Click(Sender: TObject);
    procedure mnuMoRangeClick(Sender: TObject);
  private
    { Private declarations }
    rdrIdx : Byte;

    procedure SetCodePageItems;
    procedure SetMenuItems;
    procedure AddUserAction(Actn : String);

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  {global units}
  Globals, Funcs, FarsiApi, DBS, DateProc, Code_Sys, MSGs, ComTools, Login,

  {Definition menu}
  Deprtmnt, Units, Parts, CoPost, Groups, Employee, EmplSrch,Services, MoRange,


  {Operation menu}
  Params, PrnDef, Charge,ChargGrp, EditChrg, Fish, DelRecit,initCard ,frmlottar,

  {Reports menu}
  EmplRp, SrvcLsRp, SrvcUsRp, EmpSrvRp,EmpSrvRp2,amar1rp, amar2rp, amar3rp, amar4rp, SrvDepRp,barcodeRp, LostCard,

  {Readers menu}
  RdrList, Relation, ChngAddr, LmitCard, AcesCode, SendTbl, WinSetup,Modem,

  {Tools menu}
  Admin, ChngPass, MakeTbl, ReLogin, About, Online, FntSel, DprtActv,PrsnCnvr,
  ADODB_TLB, ADOX_TLB, Keyboard, RunCmnds, Select, SelPath, TimeTool,
  Z80_CMD, Z84_cmd;


{$R *.dfm}


procedure TfrmMain.SetCodePageItems;
var
  i, j : Byte;
  departName : String;
begin

  Caption := ('”Ì” „ ﬂ«—  «⁄ »«—Ì ') + goptions.CoName;
  if gOptions.Shobeh <> '' then
    Caption := Caption + '-' + gOptions.Shobeh;

  departName := GetDepartmentName(gParams.department);
  if departName <> '' then
    Caption := Caption + '(' + departName + ')ù';


  pnl.Caption := ConvertToFarsi(('**”Ì” „ „ﬂ«‰Ì“Â ﬂ«—  «⁄ »«—Ì 2.0- „Õ’Ê·Ì «“ ‘—ﬂ  Å—Ê—‘ œ«œÂùÂ« -  ·›‰ 8712451 - ›«ﬂ” 8722159** ')) + #254;
  StatusBar.Panels[1].Text := CurrentDate;
  StatusBar.Panels[2].Text := ('˛ﬂ«—»—:') + UpperCase(gOptions.UserName) + '˛';
  StatusBar.Panels[3].Text := gOptions.CoName;
  if gOptions.Shobeh <> '' then
    StatusBar.Panels[3].Text := StatusBar.Panels[3].Text + '-' + gOptions.Shobeh;
  if departName <> '' then
    StatusBar.Panels[3].Text := StatusBar.Panels[3].Text + '(' + departName + ')ù';

end;

procedure TfrmMain.SetMenuItems;
var
  i, j, k : Byte;
  SepValid : Boolean;
  fldName,
  mnuItemVal : String;
begin
  mnumain:=mnucredit;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM Users WHERE User_Name = ''' + gOptions.UserName + '''');
    Open;

    for i := 0 to mnuCredit.Items.Count -1 do
    begin
      if UpperCase(gOptions.UserName) = ADMIN_NAME then
      begin
        if mnuCredit.Items[i].Count = 0 then
          mnuCredit.Items[i].Visible := False
        else
        begin
          mnuCredit.Items[i].Visible := True;
          for j := 0 to mnuCredit.Items[i].Count-1 do
          begin
            mnuCredit.Items[i].Items[j].Visible := True;
            mnuCredit.Items[i].Items[j].ShortCut := mnuMain.Items[i].Items[j].ShortCut;
          end;
        end;
      end
      else
      begin
        fldName := 'User_Menu' + IntToStr(i+1);
        mnuItemVal := FieldByName(fldName).AsString;
        k := 0;
        SepValid := False;
        for j := 0 to mnuCredit.Items[i].Count-1 do
        begin
          if mnuCredit.Items[i].Items[j].Caption <> '-' then
          begin
            Inc(k);
            if mnuItemVal[k] <> '0' then
            begin
              mnuCredit.Items[i].Items[j].Visible := True;
              mnuCredit.Items[i].Items[j].ShortCut := mnuMain.Items[i].Items[j].ShortCut;
              SepValid := True;
            end
            else
            begin
              mnuCredit.Items[i].Items[j].Visible := False;
              mnuCredit.Items[i].Items[j].ShortCut := 0;
            end;

          end
          else if not SepValid then
          begin
            mnuCredit.Items[i].Items[j].Visible := False;
            SepValid := False;
          end;
        end;

        if not IsSelPrg(mnuItemVal) then
          mnuCredit.Items[i].Visible := False;
      end;
    end;
  end;
end;

procedure TfrmMain.AddUserAction(Actn : String);
var
  p : Byte;
begin
  p := Pos('...', Actn);
  if p > 0 then
    Delete(Actn, p, 3);

  p := Pos('&', Actn);
  if p > 0 then
    Delete(Actn, p, 1);

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO UserStat VALUES(''' + gOptions.UserName + ''', ''' +
              Actn + ''', ''' + CurrentDate + ''', ''' + CurrentTime + ''')');
    ExecSQL;
  end;
end;



procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Mouse_Wait;

  Self.Top := 0;
  Self.Left := 0;
  Self.Width := Screen.Width;
  Self.Height := Screen.Height - 25;

  if UpperCase(gOptions.UserName) <> ADMIN_NAME then
    SetMenuItems;

  gOptions.fromDate := CurrentDate;
  gOptions.toDate := gOptions.fromDate;
  gOptions.fromDate[10] := '1';
  gOptions.fromDate[9] := '0';
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
  Refresh;

  LoadParams;
  LoadWinSetup(gOptions.ProgramPath);

  if dbsInfo.dbsType = DBS_ACCESS then
    MB_TRUE := -1;

  LoadReaders;

//  tmrOnline.Enabled := (rdrCount > 0);

  SetCodePageItems;

  if FileExists(gOptions.ProgramPath + 'Credit1.Hlp') then
    Application.HelpFile := gOptions.ProgramPath + 'Credit1.Hlp';

  LogInLogOut(gParams.department, True);
  Mouse_NoWait;
end;

procedure TfrmMain.lottClick(Sender: TObject);
begin
  AddUserAction(mnuRptDepartSrvc.Caption);
  Application.CreateForm(tFrmlotter, Frmlotter );
  Frmlotter.ShowModal;
  Frmlotter.Free;
end;

procedure TfrmMain.mnuLostCardClick(Sender: TObject);
begin
  if EmployeeFull then exit;
  AddUserAction(mnuLostCard.Caption);
  Application.CreateForm(TfrmLostCard, frmLostCard);
  frmLostCard.ShowModal;
  frmLostCard.Free;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not ConfirmMessage('¬Ì« „ÌùùŒÊ«ÂÌœ «“ »—‰«„Â Œ«—Ã ‘ÊÌœø') then
    CanClose := False
  else
    LogInLogOut(gParams.department, False);
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 119) and (Shift = [ssCtrl]) then
  //Ctrl + F8
  begin
    IsTest := not  IsTest;
    if IsTest then OpenTestFile
    else           CloseTestFile;
  end;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
StatusBar.Panels[0].Text := TimeToStr(Time);
  StatusBar.Panels[1].Text := CurrentDate;  
end;

procedure TfrmMain.tmrOnlineTimer(Sender: TObject);
begin
//  if rdrCount > 0 then
//  begin
//    while not Readers[rdrIdx].R_Active do
//      if rdrIdx >= rdrCount-1 then
//        rdrIdx := 0
//      else
//        Inc(rdrIdx);
//
//    ProcessOnline(rdrIdx);
//    if rdrIdx >= rdrCount-1 then
//      rdrIdx := 0
//    else
//      Inc(rdrIdx);
//  end;
end;





(******************** D E F I N I T I O N ********************)
procedure TfrmMain.mnuDepartmentClick(Sender: TObject);
begin
  //units definition
  AddUserAction(mnuDepartment.Caption);
  Application.CreateForm(TfrmDepartment, frmDepartment);
  frmDepartment.ShowModal;
  frmDepartment.Free;
end;

procedure TfrmMain.mnuUnitClick(Sender: TObject);
begin
  //units definition
  AddUserAction(mnuUnit.Caption);
  Application.CreateForm(TfrmUnits, frmUnits);
  frmUnits.ShowModal;
  frmUnits.Free;
end;

procedure TfrmMain.mnuCoPostClick(Sender: TObject);
begin
  //Co posts definition
  AddUserAction(mnuCoPost.Caption);
  Application.CreateForm(TfrmCoPost, frmCoPost);
  frmCoPost.ShowModal;
  frmCoPost.Free;
end;

procedure TfrmMain.mnuPartsClick(Sender: TObject);
begin
  //Sections definition
  AddUserAction(mnuParts.Caption);
  Application.CreateForm(TfrmParts, frmParts);
  frmParts.ShowModal;
  frmParts.Free;
end;

procedure TfrmMain.mnuGroupsClick(Sender: TObject);
begin
  //Group definition
  AddUserAction(mnuGroups.Caption);
  Application.CreateForm(TfrmGroups, frmGroups);
  frmGroups.ShowModal;
  frmGroups.Free;
end;

procedure TfrmMain.mnuEmployeeClick(Sender: TObject);
begin
  //Employee definition
  AddUserAction(mnuEmployee.Caption);
  Application.CreateForm(TfrmEmployee, frmEmployee);
  frmEmployee.ShowModal;
  frmEmployee.Free;
end;

procedure TfrmMain.mnuSearchClick(Sender: TObject);
begin
  //Employee finding
  AddUserAction(mnuSearch.Caption);
  Application.CreateForm(TfrmEmplSrch, frmEmplSrch);
  frmEmplSrch.ShowModal;
  frmEmplSrch.Free;
end;

procedure TfrmMain.mnuSendLostCardClick(Sender: TObject);
begin
  if EmployeeFull then exit;
  AddUserAction(mnuSendLostCard.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_LOSTCARD;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuServiceClick(Sender: TObject);
begin
  //Foods definition
  AddUserAction(mnuService.Caption);
  Application.CreateForm(TfrmServices, frmServices);
  frmServices.ShowModal;
  frmServices.Free;
end;

procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
  Close;
end;







(******************** O P E R A T I O N ********************)
procedure TfrmMain.mnuParamsClick(Sender: TObject);
begin
  //Setup
  AddUserAction(mnuParams.Caption);
  Application.CreateForm(TfrmParams, frmParams);
  frmParams.ShowModal;
  frmParams.Free;
end;

procedure TfrmMain.mnuChargeClick(Sender: TObject);
begin
  //Charge credit cards
  if EmployeeFull then exit;
  AddUserAction(mnuCharge.Caption);
  Application.CreateForm(TfrmchargGrp, frmchargGrp  );
  frmchargGrp.ShowModal;
  frmchargGrp.Free;
end;

procedure TfrmMain.mnuEditChargeClick(Sender: TObject);
begin
  //Edit credit card charging
  if EmployeeFull then exit;
  AddUserAction(mnuEditCharge.Caption);
  Application.CreateForm(TfrmEditCharge, frmEditCharge);
  with frmEditCharge  do
   begin
     ADOQuery3.sql.Clear ;
  ADOQuery3.close;
  ADOQuery3.SQL.Add('SELECT * FROM ChargeGrp ');
  ADOQuery3.Open;
  ADOQuery3.First;
  while not ADOQuery3.Eof   do
  begin
  ComboBox1.Items.Add (inttostr(ADOQuery3.FieldByName('GrpCode').AsInteger));

    ADOQuery3.Next;
end;
 ADOQuery2.SQL.Clear;
    ADOQuery2.Close;
    ADOQuery2.sql.Add('select * from Employee where Empl_Active = ' + IntToStr(MB_TRUE));
    ADOQuery2.Open;
   {
   cmbCode.Clear ;
   cmbName.Clear ;
   ADOQuery2.First;
   while not ADOQuery2.Eof   do
    begin
      cmbCode.Items.Add(ADOQuery2.FieldByName('Empl_No').AsString);
      cmbName.items.add (ADOQuery2.FieldByName('Empl_Family').AsString + '-' +  ADOQuery2. FieldByName('Empl_Name').AsString) ;
      ADOQuery2.Next;
     end;
     }
    end;

   // frmEditCharge.ComboBox1.Text :=txt_Code.Text ;
   // frmEditCharge.Edit1.Text   :=txt_Code.Text ;

  frmEditCharge.ShowModal;
  frmEditCharge.Free;
end;

procedure TfrmMain.mnuCredRecieptClick(Sender: TObject);
begin
  //Manual receipt
  AddUserAction(mnuCredReciept.Caption);
  Application.CreateForm(TfrmFish, frmFish);
  frmFish.ShowModal;
  frmFish.Free;
end;

procedure TfrmMain.mnuDelReceiptClick(Sender: TObject);
begin
  //Delete Receipt
  AddUserAction(mnuDelReceipt.Caption);
  Application.CreateForm(TfrmDelRecit, frmDelRecit);
  frmDelRecit.ShowModal;
  frmDelRecit.Free;
end;









(******************** R E P O R T S ********************)
procedure TfrmMain.mnuPersonRptClick(Sender: TObject);
begin
  //Employee list
  AddUserAction(mnuPersonRpt.Caption);
  Application.CreateForm(TfrmEmployeeRpt, frmEmployeeRpt);
  frmEmployeeRpt.ShowModal;
  frmEmployeeRpt.Free;
end;

procedure TfrmMain.mnuSrvcLstRptClick(Sender: TObject);
begin
  //Service list
  AddUserAction(mnuSrvcLstRpt.Caption);
  Application.CreateForm(TfrmServiceRpt, frmServiceRpt);
  frmServiceRpt.ShowModal;
  frmServiceRpt.Free;
end;

procedure TfrmMain.mnuRptUsedServiceClick(Sender: TObject);
begin
  //used service report
  if EmployeeFull then exit;
  AddUserAction(mnuRptUsedService.Caption);
  Application.CreateForm(TfrmUsedServiceRpt, frmUsedServiceRpt);
  frmUsedServiceRpt.ShowModal;
  frmUsedServiceRpt.Free;
end;

procedure TfrmMain.mnuRptEmplSrvcClick(Sender: TObject);
begin
  //Employee services used
  if EmployeeFull then exit;
  AddUserAction(mnuRptEmplSrvc.Caption);
  Application.CreateForm(TfrmEmployeeServiceRpt, frmEmployeeServiceRpt);
  frmEmployeeServiceRpt.ShowModal;
  frmEmployeeServiceRpt.Free;
end;

procedure TfrmMain.mnuRptamar1Click(Sender: TObject);
begin
  //use report
  if EmployeeFull then exit;
  AddUserAction(mnuRptamar1.Caption);
  Application.CreateForm(Tfrmamar1Rp, frmamar1Rp);
  frmamar1Rp.ShowModal;
  frmamar1Rp.Free;
end;

procedure TfrmMain.mnuRptamar2Click(Sender: TObject);
begin
  //charge report
  if EmployeeFull then exit;
  AddUserAction(mnuRptamar2.Caption);
  Application.CreateForm(Tfrmamar2Rp, frmamar2Rp);
  frmamar2Rp.ShowModal;
  frmamar2Rp.Free;
end;

procedure TfrmMain.mnuRptamar3Click(Sender: TObject);
begin
  //charge and use report
  if EmployeeFull then exit;
  AddUserAction(mnuRptamar3.Caption);
  Application.CreateForm(Tfrmamar3Rp, frmamar3Rp);
  frmamar3Rp.ShowModal;
  frmamar3Rp.Free;
end;

procedure TfrmMain.mnuRptamar4Click(Sender: TObject);
begin
  //charge and use report Œ·«’Â
  if EmployeeFull then exit;
  AddUserAction(mnuRptamar4.Caption);
  Application.CreateForm(Tfrmamar4Rp, frmamar4Rp);
  frmamar4Rp.ShowModal;
  frmamar4Rp.Free;
end;

procedure TfrmMain.mnuRptDepartSrvcClick(Sender: TObject);
begin
  //Department service
  if EmployeeFull then exit;
  AddUserAction(mnuRptDepartSrvc.Caption);
  Application.CreateForm(TfrmDepartServiceRpt, frmDepartServiceRpt);
  frmDepartServiceRpt.ShowModal;
  frmDepartServiceRpt.Free;
end;








(******************** R E A D E R S ********************)
procedure TfrmMain.mnuReadersClick(Sender: TObject);
begin
  //Reader setting
  AddUserAction(mnuReaders.Caption);
  Application.CreateForm(TfrmReaders, frmReaders);
  frmReaders.ShowModal;
  frmReaders.Free;
end;

procedure TfrmMain.mnuLinkTestClick(Sender: TObject);
begin
  //Reader link test
  AddUserAction(mnuLinkTest.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_TEST;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuReadVersionClick(Sender: TObject);
begin
  //Reader version
  AddUserAction(mnuReadVersion.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_VER;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuResetClick(Sender: TObject);
begin
  //Reader Reset
  AddUserAction(mnuReset.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_RESTART;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuConfigurationClick(Sender: TObject);
begin
  //Reader Configuration
  AddUserAction(mnuConfiguration.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_INITIAL;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuReaderDateTimeClick(Sender: TObject);
begin
  //Reader Date & Time
  AddUserAction(mnuConfiguration.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_DATETIME;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuChngBaudRateClick(Sender: TObject);
begin
  //Change reader's baud-rate
  AddUserAction(mnuConfiguration.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_CHNGBAUD;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuChngAddressClick(Sender: TObject);
begin
  //Change reader's address
  AddUserAction(mnuChngAddress.Caption);
  Application.CreateForm(TfrmChngAddr, frmChngAddr);
  frmChngAddr.ShowModal;
  frmChngAddr.Free;
end;

procedure TfrmMain.mnuLimitTimeClick(Sender: TObject);
begin
  //Reader limitation time
  AddUserAction(mnuConfiguration.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_LIMITTIME;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuLimitCardClick(Sender: TObject);
begin
  //Reader limitation card
  AddUserAction(mnuLimitCard.Caption);
  Application.CreateForm(TfrmLimitCard, frmLimitCard);
  frmLimitCard.ShowModal;
  frmLimitCard.Free;
end;

procedure TfrmMain.mnuAccessCodeClick(Sender: TObject);
begin
  //reader access codes
  AddUserAction(mnuAccessCode.Caption);
  Application.CreateForm(TfrmAccessCode, frmAccessCode);
  frmAccessCode.ShowModal;
  frmAccessCode.Free;
end;

procedure TfrmMain.mnuAuthorityClick(Sender: TObject);
begin
  if ConfirmMessage('ﬁ»· «“ «—”«· ÃœÊ· ‘«—é° «ÿ·«⁄«  Â„Â œ” ê«Â Â« —« Ã„⁄ ¬Ê—Ì ﬂ‰Ìœ.¬Ì« «œ«„Â „ÌœÂÌœø') then //kaveh
  begin
    if EmployeeFull then exit;
    AddUserAction(mnuAuthority.Caption);
    Application.CreateForm(TfrmRelations, frmRelations);
    frmRelations.ActionType := RDR_CHARGE;
    frmRelations.ShowModal;
    frmRelations.Free;
  end;
end;

procedure TfrmMain.mnuOnLineClick(Sender: TObject);
begin
  //View online records
  if not frmOnline.Showing then
    frmOnLine.Show;
end;

procedure TfrmMain.mnuReaderOnlineClick(Sender: TObject);
begin
  if UpperCase(gOptions.UserName) <> ADMIN_NAME then
    InformationMessage('«Ì‰ ¬Ì „ ›ﬁÿ „Œ’Ê’ „œÌ— ”Ì” „ „Ìù»«‘œ.')
  else if not frmDepartActive.Showing then
  begin
    AddUserAction(mnuReaderOnline.Caption);
    frmDepartActive.Show;
  end;
end;

procedure TfrmMain.mnuWinSetupClick(Sender: TObject);
begin
  //send services to reader
  AddUserAction(mnuWinSetup.Caption);
  Application.CreateForm(TfrmWinSetup, frmWinSetup);
  frmWinSetup.ShowModal;
  frmWinSetup.Free;
end;










(******************** T O O L S ********************)
procedure TfrmMain.mnuUserDefClick(Sender: TObject);
begin
  //User Definition
  AddUserAction(mnuUserDef.Caption);
  Application.CreateForm(TfrmAdmin, frmAdmin);
  frmAdmin.mnus := mnuCredit;
  frmAdmin.ShowModal;
  frmAdmin.Free;
end;

procedure TfrmMain.mnuChangePassClick(Sender: TObject);
begin
  //Chage user password
  AddUserAction(mnuChangePass.Caption);
  Application.CreateForm(TfrmChangePassword, frmChangePassword);
  frmChangePassword.ShowModal;
  frmChangePassword.Free;
end;

procedure TfrmMain.mnuUserActionClick(Sender: TObject);
begin
  //Users activity
end;

procedure TfrmMain.mnuPersonConveryClick(Sender: TObject);
begin
  AddUserAction(mnuPersonConvery.Caption);
  Application.CreateForm(TfrmPersonConvert, frmPersonConvert);
  frmPersonConvert.ShowModal;
  frmPersonConvert.Free;
end;

procedure TfrmMain.mnuCreateDBsClick(Sender: TObject);
begin
  //Creation Tables
  AddUserAction(mnuCreateDBs.Caption);
  Application.CreateForm(TfrmCreateTables, frmCreateTables);
  frmCreateTables.ShowModal;
  frmCreateTables.Free;
end;

procedure TfrmMain.mnuPortTestClick(Sender: TObject);
begin
  //Com port checking
  AddUserAction(mnuPortTest.Caption);
  frmComTools.ShowModal;
end;

procedure TfrmMain.mnuReportFontClick(Sender: TObject);
begin
  //Change font
  frmFont.ShowModal;
end;

procedure TfrmMain.mnuChangeUserClick(Sender: TObject);
begin
  //change user
  AddUserAction(mnuChangeUser.Caption);
  Application.CreateForm(TfrmReLogin, frmReLogin);
  frmReLogin.ShowModal;
  if frmReLogin.LoginValid then
  begin
    SetMenuItems;
    StatusBar.Panels[2].Text := ('˛ﬂ«—»—:') + UpperCase(gOptions.UserName) + '˛';
  end;

  frmReLogin.Free;
end;

procedure TfrmMain.mnuAboutClick(Sender: TObject);
var
  frmAbout:TfrmAbout;
begin
  Application.CreateForm(TfrmAbout, frmAbout);
  frmAbout.ShowModal;
  frmAbout.Free;
end;

procedure TfrmMain.mnuHelpClick(Sender: TObject);
begin
  Application.HelpContext(1);
end;

procedure TfrmMain.mnuprnparamClick(Sender: TObject);
var
  frmPrnParam:TfrmPrnParam;
begin
  //Setup printer
  AddUserAction(mnuprnParam.Caption);
  Application.CreateForm(TfrmPrnParam, frmPrnParam);
  frmPrnParam.ShowModal;
  frmPrnParam.Free;
end;

procedure TfrmMain.mnuBarcodeRptClick(Sender: TObject);
var frmBarcodeRpt : TfrmBarcodeRpt;
begin
  if EmployeeFull then exit;
  AddUserAction(mnuBarcodeRpt.Caption);
  Application.CreateForm(TfrmBarcodeRpt, frmBarcodeRpt);
  frmBarcodeRpt.ShowModal;
  frmBarcodeRpt.Free;
end;

procedure TfrmMain.mnuInitCardClick(Sender: TObject);
begin
  if ConfirmMessage('ﬁ»· «“ ’œÊ— ﬂ«— ° «ÿ·«⁄«  Â„Â œ” ê«Â Â« —« Ã„⁄ ¬Ê—Ì ﬂ‰Ìœ.¬Ì« «œ«„Â „ÌœÂÌœø') then //kaveh
  begin
    if EmployeeFull then exit;
    AddUserAction(mnuInitCard.Caption);
    Application.CreateForm(TfrmInitCard, frmInitCard);
    frmInitCard.ShowModal;
    frmInitCard.Free;
  end;
end;

procedure TfrmMain.mnuCollectNewClick(Sender: TObject);
begin
  if EmployeeFull then exit;
  AddUserAction(mnuLinkTest.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_COLLECT;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnudialClick(Sender: TObject);
begin
  AddUserAction(mnuLinkTest.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_DIAL;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.mnuModemClick(Sender: TObject);
var frmModem : TfrmModem;
begin
  AddUserAction(mnuModem.Caption);
  Application.CreateForm(TfrmModem, frmModem);
  frmModem.ShowModal;
  frmModem.Free;
end;

procedure TfrmMain.mnuRecoveryClick(Sender: TObject);
begin
  if EmployeeFull then exit;
  AddUserAction(mnuLinkTest.Caption);
  Application.CreateForm(TfrmRelations, frmRelations);
  frmRelations.ActionType := RDR_RECOVERY;
  frmRelations.ShowModal;
  frmRelations.Free;
end;

procedure TfrmMain.N3Click(Sender: TObject);
begin
  if EmployeeFull then exit;
  AddUserAction(mnuRptEmplSrvc.Caption);
  Application.CreateForm(TfrmEmployeeServiceRpt2, frmEmployeeServiceRpt2);
  frmEmployeeServiceRpt2.ShowModal;
  frmEmployeeServiceRpt2.Free;
end;

procedure TfrmMain.mnuMoRangeClick(Sender: TObject);
begin
  //monthly range definition
  AddUserAction(mnuMoRange.Caption);
  Application.CreateForm(TfrmMoRange, frmMoRange);
  frmMoRange.ShowModal;
  frmMoRange.Free;
end;

end.
