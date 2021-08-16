unit Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DateProc, Keyboard, ExtCtrls, ComCtrls,ADODB;

type
  TfrmParams = class(TForm)
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl6: TLabel;
    lbl9: TLabel;
    lbl3: TLabel;
    chkMokhalafat: TCheckBox;
    chkSobhaneh: TCheckBox;
    chkNahar: TCheckBox;
    chkSham: TCheckBox;
    txtFromSobh: TEdit;
    txtToSobh: TEdit;
    txtFromNahar: TEdit;
    txtToNahar: TEdit;
    txtFromSham: TEdit;
    txtToSham: TEdit;
    txtNaharKeyNo: TEdit;
    txtShamKeyNo: TEdit;
    txtSobhKeyNo: TEdit;
    grp3: TGroupBox;
    lbl11: TLabel;
    cmbFirstPriceGuest: TComboBox;
    chkSecondFoodGuest: TCheckBox;
    cmbSecondPriceGuest: TComboBox;
    grp2: TGroupBox;
    lbl10: TLabel;
    cmbFirstPricePerson: TComboBox;
    chkSecondFoodPerson: TCheckBox;
    cmbSecondPricePerson: TComboBox;
    grp5: TGroupBox;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    cmbControlBase: TComboBox;
    chkClockOnLine: TCheckBox;
    txtCycle: TEdit;
    grp4: TGroupBox;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    txtEnd4: TEdit;
    txtEnd3: TEdit;
    txtEnd2: TEdit;
    txtEnd1: TEdit;
    chkNaharMaxIn: TCheckBox;
    chkShamMaxIn: TCheckBox;
    chkSobhanehMaXIn: TCheckBox;
    txtSobhanehMaxIn: TEdit;
    txtNaharMaxIn: TEdit;
    txtShamMaxIn: TEdit;
    chkOffOutTime: TCheckBox;
    GroupBox1: TGroupBox;
    rdoFromRdr: TRadioButton;
    rdoFromDB: TRadioButton;
    lblSQLPass: TLabel;
    txtSqlPass: TEdit;
    txtSqlUser: TEdit;
    lblSqlUser: TLabel;
    lblServer: TLabel;
    txtServer: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtNaharFirstFish: TEdit;
    txtShamFirstFish: TEdit;
    txtSobhFirstFish: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    txtfish4: TEdit;
    txtfish3: TEdit;
    txtfish2: TEdit;
    txtfish1: TEdit;
    txtfish5: TEdit;
    Label11: TLabel;
    cb1: TCheckBox;
    cb2: TCheckBox;
    cb3: TCheckBox;
    cb4: TCheckBox;
    cb5: TCheckBox;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    cmbBuilding: TComboBox;
    chkMustReserve: TCheckBox;
    chkRunReserve: TCheckBox;
    rdoOwnBuilding: TRadioButton;
    rdoAllBuilding: TRadioButton;
    txtRestCycle: TEdit;
    Label13: TLabel;
    txtMinCredit: TEdit;
    Label14: TLabel;
    chkSobhInSham: TCheckBox;
    GroupBox4: TGroupBox;
    cmbUsers: TComboBox;
    Label15: TLabel;
    chkKasr: TCheckBox;
    txtdatabasename: TEdit;
    lbldatabasename: TLabel;
    lblPrsImgsFld: TLabel;
    txtPrsImgsFld: TEdit;
    chkPrsImgsFld: TCheckBox;
    GroupBox5: TGroupBox;
    lblAutoLoginUser: TLabel;
    lblAutoLoginPass: TLabel;
    cmbAutoLoginUser: TComboBox;
    txtAutoLoginPass: TEdit;
    chkAutoLogin: TCheckBox;
    lblAutoFishLstPicsRdrCodeR: TLabel;
    cmbAutoFishLstPicsRdrCodeR: TComboBox;
    chkAutoFishLstPics: TCheckBox;
    lblAutoFishLstPicsRdrCodeL: TLabel;
    cmbAutoFishLstPicsRdrCodeL: TComboBox;
    procedure chkRunReserveClick(Sender: TObject);
    procedure txtSobhKeyNoKeyPress(Sender: TObject; var Key: Char);
    procedure txtSobhFirstFishKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure chkSobhanehKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromSobhKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromSobhExit(Sender: TObject);
    procedure txtToSobhExit(Sender: TObject);
    procedure txtFromNaharExit(Sender: TObject);
    procedure txtToNaharExit(Sender: TObject);
    procedure txtFromShamExit(Sender: TObject);
    procedure txtToShamExit(Sender: TObject);
    procedure chkSobhanehClick(Sender: TObject);
    procedure chkNaharClick(Sender: TObject);
    procedure chkShamClick(Sender: TObject);
    procedure txtNaharKeyNoKeyPress(Sender: TObject; var Key: Char);
    procedure chkClockOnLineClick(Sender: TObject);
    procedure txtEnd1KeyPress(Sender: TObject; var Key: Char);
    procedure chkSobhanehMaXInClick(Sender: TObject);
    procedure chkNaharMaxInClick(Sender: TObject);
    procedure chkShamMaxInClick(Sender: TObject);
    procedure rdoFromDBClick(Sender: TObject);
    procedure rdoFromRdrClick(Sender: TObject);
    procedure txtSobhanehMaxInExit(Sender: TObject);
    procedure txtNaharMaxInExit(Sender: TObject);
    procedure txtShamMaxInExit(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkPrsImgsFldClick(Sender: TObject);
    procedure chkAutoLoginClick(Sender: TObject);
    procedure chkAutoFishLstPicsClick(Sender: TObject);
  private
    { Private declarations }
    procedure SendTab(var Key : Char);

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

uses
  Globals, DBS_Proc, main;

procedure TfrmParams.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmParams.FormCreate(Sender: TObject);
var
  adoQry: TAdoQuery;
  i : integer;
begin
  with F_Params do
  begin
    chkSobhaneh.Checked := (Vadeh[MB_SOBH] = MB_TRUE);
    txtFromSobh.Text := FromSobh;
    txtToSobh.Text := ToSobh;
    txtSobhKeyNo.Text := IntToStr(SobhKeyNo);

    chkNahar.Checked := (Vadeh[MB_NAHAR] = MB_TRUE);
    txtFromNahar.Text := FromNahar;
    txtToNahar.Text := ToNahar;
    txtNaharKeyNo.Text := IntToStr(NaharKeyNo);

    chkSham.Checked := (Vadeh[MB_SHAM] = MB_TRUE);
    txtFromSham.Text := FromSham;
    txtToSham.Text := ToSham;
    txtShamKeyNo.Text := IntToStr(ShamKeyNo);

    chkMokhalafat.Checked := (Mokhlafat = MB_TRUE);
    chkSobhInSham.Checked := (SobhInSham = MB_TRUE);
    chkKasr.Checked := (Kasr = MB_TRUE);

    chkOffOutTime.Checked := (OffOutTime = MB_TRUE);


    cmbFirstPricePerson.ItemIndex := FirstFoodPrcPerson;
    chkSecondFoodPerson.Checked := (SecondFoodPrcPerson >= 0);
    cmbSecondPricePerson.ItemIndex := SecondFoodPrcPerson;

    cmbFirstPriceGuest.ItemIndex := FirstFoodPrcGuest;
    chkSecondFoodGuest.Checked := (SecondFoodPrcGuest >= 0);
    cmbSecondPriceGuest.ItemIndex := SecondFoodPrcGuest;

    cmbControlBase.ItemIndex := ControlBase;
    chkClockOnLine.Checked := (ClockOnLine = MB_TRUE);
    txtCycle.Text := Format('%.2f', [ClockCycle / 59]);

//  txtRestCycle.Text := IntToStr(restCycle);

    txtEnd1.Text := EndRep1;
    txtEnd2.Text := EndRep2;
    txtEnd3.Text := EndRep3;
    txtEnd4.Text := EndRep4;

    txtfish1.Text := Endfish1;
    txtfish2.Text := Endfish2;
    txtfish3.Text := Endfish3;
    txtfish4.Text := Endfish4;
    txtfish5.Text := Endfish5;

    cb1.checked := Endfishactive1;
    cb2.checked := Endfishactive2;
    cb3.checked := Endfishactive3;
    cb4.checked := Endfishactive4;
    cb5.checked := Endfishactive5;



    if SobhaneMaxIn <> '' then
    begin
      txtSobhanehMaxIn.Text := SobhaneMaxIn;
      chkSobhanehMaXIn.Checked := true;
    end;
    if NaharMaxIn <> '' then
    begin
      txtNaharMaxIn.Text := NaharMaxIn;
      chkNaharMaxIn.Checked := true;
    end;
    if ShamMaxIn <> '' then
    begin
      txtShamMaxIn.Text := ShamMaxIn;
      chkShamMaxIn.Checked := true;
    end;
    txtSobhFirstFish.Text  := IntToStr(SobhFirstFish);
    txtNaharFirstFish.Text := IntToStr(NaharFirstFish);
    txtShamFirstFish.Text  := IntToStr(ShamFirstFish);
    txtMinCredit.Text := CurrToStr(MinCredit);

    if CollectFrom = 0 then
      rdoFromRdr.Checked := true
    else
      rdoFromDB.Checked := true;

    txtServer.Text  := cLkServerName;
    txtdatabasename.Text  := cLkdatabasename;
    txtSqlUser.Text := clkSqlUseName;
    txtSqlPass.Text := clkSqlPassword;
    cmbBuilding.Items.Clear;
    adoQry := TAdoQuery.Create(Application);
    with adoQry do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM building');
      Open;
      while not EOF do
      begin
        cmbBuilding.Items.Add(FieldByName('building_Code').AsString + '-' + FieldByName('building_Name').AsString);
        Next;
      end;
      Close;
    end;
    cmbBuilding.ItemIndex := -1;
    if cmbBuilding.Items.Count > 0 then
      for i := 0 to cmbBuilding.Items.Count-1 do
        if StrToInt(Copy(cmbBuilding.Items.Strings[i], 1, Pos('-', cmbBuilding.Items.Strings[i])-1)) = Building then
          cmbBuilding.ItemIndex := i;

    cmbUsers.Clear;
    with adoQry do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM SECURITY');
      Open;
      while not Eof do
      begin
        cmbUsers.Items.Add(UpperCase(FieldByName('UserName').AsString));
        Next;
      end;
      Close;
    end;
    cmbUsers.ItemIndex := -1;
    if cmbUsers.Items.Count > 0 then
    begin
      i := cmbUsers.Items.IndexOf(UpperCase(CollectUser));
      if i=-1 then
        i := cmbUsers.Items.IndexOf('ADMIN');
      if i=-1 then
        cmbUsers.Text := ''
      else
        cmbUsers.ItemIndex := i;
    end;
    chkRunReserve.Checked := (RunReserve=1);
    chkMustReserve.Checked := (MustReserve=1);
    if (ValidInAllBuilding=1) then
      rdoAllBuilding.Checked := true
    else
      rdoOwnBuilding.Checked := true;
    chkPrsImgsFld.Checked := PrsImgsFldActive; //kaveh
    txtPrsImgsFld.Text := PrsImgsFld; //kaveh
    txtPrsImgsFld.Enabled := PrsImgsFldActive; //kaveh
    lblPrsImgsFld.Enabled := PrsImgsFldActive; //kaveh

    cmbUsers.Clear;
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add(' SELECT UserName FROM SECURITY ORDER BY UserName');
      Open;
      while not Eof do
      begin
        cmbAutoLoginUser.Items.Add(FieldByName('UserName').AsString);
        Next;
      end;
      Close;
    end;
    chkAutoLogin.Checked := AutoLoginActive;
    cmbAutoLoginUser.ItemIndex := cmbAutoLoginUser.Items.IndexOf(AutoLoginUser);
    txtAutoLoginPass.Text := AutoLoginPass;
    cmbAutoLoginUser.Enabled := chkAutoLogin.Checked;
    lblAutoLoginUser.Enabled := chkAutoLogin.Checked;
    txtAutoLoginPass.Enabled := chkAutoLogin.Checked;
    lblAutoLoginPass.Enabled := chkAutoLogin.Checked;

    cmbUsers.Clear;
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      SQL.Add('SELECT R_Name, R_Code ');
      SQL.Add('FROM readers ');
      SQL.Add('Order by R_Code ');
      Open;
      while not Eof do
      begin
        cmbAutoFishLstPicsRdrCodeR.Items.Add(FieldByName('R_Name').AsString);
        cmbAutoFishLstPicsRdrCodeL.Items.Add(FieldByName('R_Name').AsString);
        Next;
      end;
      Close;
    end;
    chkAutoFishLstPics.Checked := AutoFishLstPicsActive;
    cmbAutoFishLstPicsRdrCodeR.ItemIndex := cmbAutoFishLstPicsRdrCodeR.Items.IndexOf(AutoFishLstPicsRdrCodeR);
    cmbAutoFishLstPicsRdrCodeL.ItemIndex := cmbAutoFishLstPicsRdrCodeL.Items.IndexOf(AutoFishLstPicsRdrCodeL);
    cmbAutoFishLstPicsRdrCodeR.Enabled := chkAutoFishLstPics.Checked;
    lblAutoFishLstPicsRdrCodeR.Enabled := chkAutoFishLstPics.Checked;
    cmbAutoFishLstPicsRdrCodeL.Enabled := chkAutoFishLstPics.Checked;
    lblAutoFishLstPicsRdrCodeL.Enabled := chkAutoFishLstPics.Checked;
  end;
end;

procedure TfrmParams.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if shift=[ssShift,ssCtrl,ssRight] then
  begin
    PageControl1.ActivePage := TabSheet1;
    chkSobhInSham.Visible := true;
    chkKasr.Visible := true;    
    chkSobhInSham.SetFocus;
  end;
  
end;

procedure TfrmParams.chkSobhanehClick(Sender: TObject);
begin
  txtFromSobh.Enabled := chkSobhaneh.Checked;
  txtToSobh.Enabled := chkSobhaneh.Checked;
  txtSobhKeyNo.Enabled := chkSobhaneh.Checked;
  txtSobhFirstFish.Enabled := chkSobhaneh.Checked;
end;

procedure TfrmParams.chkSobhanehKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmParams.txtFromSobhKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmParams.txtFromSobhExit(Sender: TObject);
begin
  if txtFromSobh.Text <> '' then txtFromSobh.Text := BeautifulTime(txtFromSobh.Text);
end;

procedure TfrmParams.txtToSobhExit(Sender: TObject);
begin
  if txtToSobh.Text <> '' then txtToSobh.Text := BeautifulTime(txtToSobh.Text);
end;

procedure TfrmParams.chkNaharClick(Sender: TObject);
begin
  txtFromNahar.Enabled := chkNahar.Checked;
  txtToNahar.Enabled := chkNahar.Checked;
  txtNaharKeyNo.Enabled := chkNahar.Checked;
  txtNaharFirstFish.Enabled := chkNahar.Checked;
end;

procedure TfrmParams.txtFromNaharExit(Sender: TObject);
begin
  if txtFromNahar.Text <> '' then txtFromNahar.Text := BeautifulTime(txtFromNahar.Text);
end;

procedure TfrmParams.txtToNaharExit(Sender: TObject);
begin
  if txtToNahar.Text <> '' then txtToNahar.Text := BeautifulTime(txtToNahar.Text);
end;

procedure TfrmParams.txtNaharKeyNoKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Number(Key, txtNaharKeyNo.Text);
end;

procedure TfrmParams.chkShamClick(Sender: TObject);
begin
  txtFromSham.Enabled := chkSham.Checked;
  txtToSham.Enabled := chkSham.Checked;
  txtShamKeyNo.Enabled := chkSham.Checked;
  txtShamFirstFish.Enabled := chkSham.Checked;
end;

procedure TfrmParams.txtFromShamExit(Sender: TObject);
begin
  if txtFromSham.Text <> '' then txtFromSham.Text := BeautifulTime(txtFromSham.Text);
end;

procedure TfrmParams.txtToShamExit(Sender: TObject);
begin
  if txtToSham.Text <> '' then txtToSham.Text := BeautifulTime(txtToSham.Text);
end;

procedure TfrmParams.chkAutoFishLstPicsClick(Sender: TObject);
begin
  cmbAutoFishLstPicsRdrCodeR.Enabled := chkAutoFishLstPics.Checked;
  lblAutoFishLstPicsRdrCodeR.Enabled := chkAutoFishLstPics.Checked;
  cmbAutoFishLstPicsRdrCodeL.Enabled := chkAutoFishLstPics.Checked;
  lblAutoFishLstPicsRdrCodeL.Enabled := chkAutoFishLstPics.Checked;
end;

procedure TfrmParams.chkAutoLoginClick(Sender: TObject);
begin
  cmbAutoLoginUser.Enabled := chkAutoLogin.Checked;
  lblAutoLoginUser.Enabled := chkAutoLogin.Checked;
  txtAutoLoginPass.Enabled := chkAutoLogin.Checked;
  lblAutoLoginPass.Enabled := chkAutoLogin.Checked;
end;

procedure TfrmParams.chkClockOnLineClick(Sender: TObject);
begin
  txtCycle.Enabled := chkClockOnLine.Checked
end;

procedure TfrmParams.cmdOKClick(Sender: TObject);
begin
  with F_Params do
  begin
    if chkSobhaneh.Checked then Vadeh[MB_SOBH] := MB_TRUE
    else                        Vadeh[MB_SOBH] := MB_FALSE;
    FromSobh := txtFromSobh.Text;
    ToSobh := txtToSobh.Text;
    if txtSobhKeyNo.Text <> '' then
      SobhKeyNo := StrToInt(txtSobhKeyNo.Text)
    else
      SobhKeyNo := 0;

    if chkNahar.Checked then Vadeh[MB_NAHAR] := MB_TRUE
    else                     Vadeh[MB_NAHAR] := MB_FALSE;
    FromNahar := txtFromNahar.Text;
    ToNahar := txtToNahar.Text;
    if txtNaharKeyNo.Text <> '' then
      NaharKeyNo := StrToInt(txtNaharKeyNo.Text)
    else
      NaharKeyNo := 0;

    if chkSham.Checked then Vadeh[MB_SHAM] := MB_TRUE
    else                    Vadeh[MB_SHAM] := MB_FALSE;
    FromSham := txtFromSham.Text;
    ToSham := txtToSham.Text;
    if txtShamKeyNo.Text <> '' then
      ShamKeyNo := StrToInt(txtShamKeyNo.Text)
    else
      ShamKeyNo := 0;

    if chkMokhalafat.Checked then Mokhlafat := MB_TRUE
    else                          Mokhlafat := MB_FALSE;

    if chkSobhInSham.Checked then SobhInSham := MB_TRUE
    else                          SobhInSham := MB_FALSE;

    if chkKasr.Checked then Kasr := MB_TRUE
    else                          Kasr := MB_FALSE;

    if chkOffOutTime.Checked then OffOutTime := MB_TRUE
    else                          OffOutTime := MB_FALSE;

    FirstFoodPrcPerson := cmbFirstPricePerson.ItemIndex;
    if chkSecondFoodPerson.Checked then
      SecondFoodPrcPerson := cmbSecondPricePerson.ItemIndex
    else
      SecondFoodPrcPerson := -1;

    FirstFoodPrcGuest := cmbFirstPriceGuest.ItemIndex;
    if chkSecondFoodGuest.Checked then
      SecondFoodPrcGuest := cmbSecondPriceGuest.ItemIndex
    else
      SecondFoodPrcGuest := -1;

    MinCredit := StrToCurr(txtMinCredit.Text);
    ControlBase := cmbControlBase.ItemIndex;
    if chkClockOnLine.Checked then
    begin
      ClockOnLine := MB_TRUE;
      if txtCycle.Text <> '' then
        ClockCycle := Round(StrToFloat(txtCycle.Text) * 59)
      else
        ClockCycle := 0;
    end
    else
    begin
      ClockOnLine := MB_FALSE;
      ClockCycle:= 0;
    end;

//    if txtRestCycle.Text <> '' then
//      restCycle := StrToint(txtRestCycle.Text)
//    else
//      restCycle := 0;
//
    EndRep1 := txtEnd1.Text;
    EndRep2 := txtEnd2.Text;
    EndRep3 := txtEnd3.Text;
    EndRep4 := txtEnd4.Text;

    Endfish1 := txtfish1.Text;
    Endfish2 := txtfish2.Text;
    Endfish3 := txtfish3.Text;
    Endfish4 := txtfish4.Text;
    Endfish5 := txtfish5.Text;

    Endfishactive1 := cb1.checked;
    Endfishactive2 := cb2.checked;
    Endfishactive3 := cb3.checked;
    Endfishactive4 := cb4.checked;
    Endfishactive5 := cb5.checked;

{    if txtSobhanehMaxIn.Text = '' then SobhaneMaxIn := '00:00'
    else} SobhaneMaxIn := txtSobhanehMaxIn.Text;

{    if txtNaharMaxIn.Text = '' then NaharMaxIn := '00:00'
    else} NaharMaxIn := txtNaharMaxIn.Text;

{    if txtShamMaxIn.Text = '' then ShamMaxIn := '00:00'
    else} ShamMaxIn := txtShamMaxIn.Text;


    if IsNumeric(txtSobhFirstFish.text) then
      sobhFirstFish := StrToInt(txtSobhFirstFish.text)
    else
      sobhFirstFish := 1;

    if IsNumeric(txtNaharFirstFish.text) then
      naharFirstFish := StrToInt(txtNaharFirstFish.text)
    else
      NaharFirstFish := 1;

    if IsNumeric(txtShamFirstFish.text) then
      shamFirstFish := StrToInt(txtShamFirstFish.text)
    else
      shamFirstFish := 1;

    if rdoFromRdr.Checked then
      CollectFrom := 0
    else
      CollectFrom := 1;
    cLkServerName := txtServer.Text;
    cLkdatabasename := txtdatabasename.Text;
    clkSqlUseName := txtSqlUser.Text;
    clkSqlPassword := txtSqlPass.Text;
    if cmbBuilding.Text <> '' then
      Building := StrToInt(Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1))
    else
      Building := 0;

    if chkRunReserve.Checked then
      RunReserve := 1
    else
      RunReserve := 0;
    if chkMustReserve.Checked then
      MustReserve := 1
    else
      MustReserve := 0;
    if rdoAllBuilding.Checked then
      ValidInAllBuilding := 1
    else
      ValidInAllBuilding := 0;
    CollectUser := cmbUsers.Text;

    PrsImgsFldActive := chkPrsImgsFld.Checked; //kaveh
    PrsImgsFld := txtPrsImgsFld.Text; //kaveh

    AutoLoginActive := chkAutoLogin.Checked;
    AutoLoginUser := cmbAutoLoginUser.Text;
    AutoLoginPass := txtAutoLoginPass.Text;

    AutoFishLstPicsActive := chkAutoFishLstPics.Checked;
    AutoFishLstPicsRdrCodeR := cmbAutoFishLstPicsRdrCodeR.Text;
    AutoFishLstPicsRdrCodeL := cmbAutoFishLstPicsRdrCodeL.Text;
  end;
  SaveIniFile;
  LoadFishsNo(g_Options.RunDate);
//  frmMain.tmrRdr.Interval := F_Params.RestCycle;
end;

procedure TfrmParams.txtEnd1KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;
procedure TfrmParams.chkSobhanehMaXInClick(Sender: TObject);
begin
  txtSobhanehMaxIn.Enabled := chkSobhanehMaXIn.Checked;
  if not chkSobhanehMaXIn.Checked then
    txtSobhanehMaxIn.Text := '';

end;

procedure TfrmParams.chkNaharMaxInClick(Sender: TObject);
begin
  txtNaharMaxIn.Enabled := chkNaharMaxIn.Checked;
  if not chkNaharMaxIn.Checked then
    txtNaharMaxIn.Text := '';
end;

procedure TfrmParams.chkPrsImgsFldClick(Sender: TObject);
begin
  lblPrsImgsFld.Enabled := chkPrsImgsFld.Checked;
  txtPrsImgsFld.Enabled := chkPrsImgsFld.Checked;
end;

procedure TfrmParams.chkRunReserveClick(Sender: TObject);
begin
  chkMustReserve.Enabled := chkRunReserve.Checked;
  if not chkRunReserve.Checked then
    chkMustReserve.Checked := false;
end;

procedure TfrmParams.chkShamMaxInClick(Sender: TObject);
begin
  txtShamMaxIn.Enabled := chkShamMaxIn.Checked;
  if not chkShamMaxIn.Checked then
    txtShamMaxIn.Text := '';

end;

procedure TfrmParams.rdoFromDBClick(Sender: TObject);
var
  flag : boolean;
begin
  flag := rdoFromDB.Checked;

  lblServer.Enabled  := flag;
  lbldatabasename.Enabled  := flag;
  lblSqlUser.Enabled := flag;
  lblSQLPass.Enabled := flag;
  txtServer.Enabled  := flag;
  txtdatabasename.Enabled  := flag;
  txtSqlUser.Enabled := flag;
  txtSqlPass.Enabled := flag;
end;

procedure TfrmParams.rdoFromRdrClick(Sender: TObject);
var
  flag : boolean;
begin
  flag := rdoFromDB.Checked;

  lblServer.Enabled  := flag;
  lbldatabasename.Enabled  := flag;
  lblSqlUser.Enabled := flag;
  lblSQLPass.Enabled := flag;
  txtServer.Enabled  := flag;
  txtdatabasename.Enabled  := flag;
  txtSqlUser.Enabled := flag;
  txtSqlPass.Enabled := flag;
end;

procedure TfrmParams.txtSobhanehMaxInExit(Sender: TObject);
begin
  if txtSobhanehMaxIn.Text <> '' then txtSobhanehMaxIn.Text := BeautifulTime(txtSobhanehMaxIn.Text);
end;

procedure TfrmParams.txtNaharMaxInExit(Sender: TObject);
begin
  if txtNaharMaxIn.Text <> '' then txtNaharMaxIn.Text := BeautifulTime(txtNaharMaxIn.Text);
end;

procedure TfrmParams.txtShamMaxInExit(Sender: TObject);
begin
  if txtShamMaxIn.Text <> '' then txtShamMaxIn.Text := BeautifulTime(txtShamMaxIn.Text);
end;

procedure TfrmParams.txtSobhFirstFishKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Number(Key, txtNaharFirstFish.Text);
end;

procedure TfrmParams.txtSobhKeyNoKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Number(Key,(Sender as TEdit).Text);
end;

end.
