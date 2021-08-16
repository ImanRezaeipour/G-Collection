unit PrgPrs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard, ExtCtrls, Ertebat, DateProc;

type
  TfrmPrgPerson = class(TForm)
    grpAll: TGroupBox;
    dbgPrgPrs: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lblBarCode: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaPrgPrs: TDataSource;
    tblPrgPrs: TAdoTable;
    lblName: TLabel;
    txtDate: TEdit;
    lblFamily: TLabel;
    cmbPCode: TComboBox;
    cmbFamilyName: TComboBox;
    Label7: TLabel;
    cmbSrchType: TComboBox;
    txtSrchDate: TEdit;
    Label6: TLabel;
    Label1: TLabel;
    cmbType: TComboBox;
    Bevel1: TBevel;
    lblRecNo: TLabel;
    Label9: TLabel;
    txtSrchPCode: TEdit;
    tblPrgPrsPP_Date: TStringField;
    tblPrgPrsPP_Type: TSmallintField;
    tblPrgPrsPP_PCode: TStringField;
    tblPrgPrsType: TStringField;
    tblPrgPrsPCode: TStringField;
    tblPrgPrsKeys: TStringField;
    grdPrg: TStringGrid;
    tblPrgPrsPP_Key1: TBooleanField;
    tblPrgPrsPP_Key2: TBooleanField;
    tblPrgPrsPP_Key3: TBooleanField;
    tblPrgPrsPP_Key4: TBooleanField;
    tblPrgPrsPP_Key5: TBooleanField;
    tblPrgPrsPP_Key6: TBooleanField;
    tblPrgPrsPP_Key7: TBooleanField;
    tblPrgPrsPP_Key8: TBooleanField;
    tblPrgPrsPP_Keys: TSmallintField;
    cmbBuilding: TComboBox;
    Label2: TLabel;
    tblPrgPrsPP_Building: TIntegerField;
    tblPrgPrsPP_Price: TBCDField;
    btnUpdate: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgPrgPrsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbSrchTypeClick(Sender: TObject);
    procedure tblPrgPrsCalcFields(DataSet: TDataSet);
    procedure txtSrchDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtSrchDateExit(Sender: TObject);
    procedure txtSrchPCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbSrchTypeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbSrchTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtDateExit(Sender: TObject);
    procedure cmbTypeClick(Sender: TObject);
    procedure cmbPCodeClick(Sender: TObject);
    procedure cmbFamilyNameClick(Sender: TObject);
    procedure cmbPCodeExit(Sender: TObject);
    procedure grdPrgDblClick(Sender: TObject);
    procedure grdPrgKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPCodeKeyPress(Sender: TObject; var Key: Char);
    procedure btnUpdateClick(Sender: TObject);
  private
    { Private declarations }
    Flag : Byte;
    FodCodes : array[MB_SOBH..MB_SHAM, 1..8] of Integer;

    procedure SendTab(var Key : Char);
    procedure ReOpenTable;
    procedure FormInEdit(vis : Boolean);
    procedure ClearScrFields;
    procedure SetScrFields;
    function  AreValidFields : Integer;
    procedure LoadPrgFood(TD : String);
    procedure FillGrdPrg(typ : Byte);
    function  IsExistsRec(TD, PCode: String; typ : Byte) : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation
uses ComTools;
{$R *.DFM}

procedure TfrmPrgPerson.SetWinF;
begin
end;

procedure TfrmPrgPerson.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmPrgPerson.ReOpenTable;
var s : String;
begin
  s := '';
  if txtSrchDate.Text <> '' then
    s := 'PP_Date = ''' + txtSrchDate.Text + '''';

  if cmbSrchType.Text <> '' then
    if s = '' then
      s := 'PP_Type = ' + IntToStr(cmbSrchType.ItemIndex + 1)
    else
      s := s + ' AND PP_Type = ' + IntToStr(cmbSrchType.ItemIndex + 1);

  if txtSrchPCode.Text <> '' then
    if s = '' then
      s := 'PP_PCode = ''' + FixLeft(txtSrchPCode.Text, '0', 8) + ''''
    else
      s := s + ' AND PP_PCode = ''' + txtSrchPCode.Text+ '''';

  tblPrgPrs.Filtered := False;
  tblPrgPrs.Filter := s;
  tblPrgPrs.Filtered := True;
  lblRecNo.Caption := ('تعداد : ') + IntToStr(tblPrgPrs.RecordCount);
end;

procedure TfrmPrgPerson.FormInEdit(vis : Boolean);
begin
  grpAll.Visible := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

procedure TfrmPrgPerson.btnUpdateClick(Sender: TObject);
var
  i : Byte;
  sumPrice  : Currency;
  adoQry : TADOQuery;
  lastDate : string;
begin
  tblPrgPrs.DisableControls;
  tblPrgPrs.First;
  while not tblPrgPrs.eof do
  begin
    tblPrgPrs.Edit;
    sumPrice := 0;
    if tblPrgPrs.FieldByName('PP_Date').AsString <> lastDate then
      LoadPrgFood(tblPrgPrs.FieldByName('PP_Date').AsString);
    Lastdate := tblPrgPrs.FieldByName('PP_Date').AsString;
    for i := 1 to 8 do
      if tblPrgPrs.FieldByName('PP_Key' + IntToStr(i)).AsBoolean then
        sumPrice := sumPrice + GetFoodPriceInDB(FodCodes[tblPrgPrs.FieldByName('PP_Type').AsInteger][i] ,lastDate).PriceFee;
    tblPrgPrs.FieldByName('PP_Price').AsCurrency := sumPrice;
    tblPrgPrs.Post;
    tblPrgPrs.Next;
  end;
  tblPrgPrs.EnableControls;
end;


procedure TfrmPrgPerson.ClearScrFields;
begin
  cmbType.ItemIndex := 0;
  txtDate.SetFocus;
  cmbPCode.ItemIndex := 0;
  cmbFamilyName.ItemIndex := 0;
  LoadPrgFood(txtDate.Text);
  FillGrdPrg(MB_SOBH);
end;

procedure TfrmPrgPerson.SetScrFields;
var i : Byte;
begin
  txtDate.Text := tblPrgPrs.FieldByName('PP_Date').AsString;
  cmbType.ItemIndex := tblPrgPrs.FieldByName('PP_Type').AsInteger-1;
  cmbPCode.ItemIndex := cmbPCode.Items.IndexOf(tblPrgPrs.FieldByName('PCode').AsString);
  cmbFamilyName.ItemIndex := cmbPCode.ItemIndex;
  cmbBuilding.ItemIndex := -1;
  for I := 0 to cmbBuilding.Items.Count - 1 do
    if tblPrgPrs.FieldByName('pp_Building').AsString = copy(cmbBuilding.Items[i],1,pos('-',cmbBuilding.Items[i])-1) then
      cmbBuilding.ItemIndex := i;
  LoadPrgFood(txtDate.Text);
  FillGrdPrg(cmbType.ItemIndex+1);
  for i := 1 to 8 do
    if tblPrgPrs.FieldByName('PP_Key'+IntToStr(i)).AsBoolean then
      grdPrg.Cells[3, i] := 'X'
    else
      grdPrg.Cells[3, i] := '';
  txtDate.SetFocus;
end;

function TfrmPrgPerson.AreValidFields : Integer;
const
  KEY2VADEH : array[0..7] of Byte =
             (0, 2, 4, 8, 6, 12, 10, 14);
var
  i : Byte;
  find : Boolean;
  p : TPerson;
  sumPrice  : Currency;
begin
  if txtDate.Text = '' then
  begin
    AreValidFields := -1;
    ErrorMessage('تاريخ وارد نشده است.');
    txtDate.SetFocus;
    exit;
  end;
  if not IsTrueDate(txtDate.Text) then
  begin
    AreValidFields := -1;
    ErrorMessage('تاريخ نادرست است.');
    txtDate.SetFocus;
    exit;
  end;
  if cmbType.Text = '' then
  begin
    AreValidFields := -1;
    ErrorMessage('وعده غذايي انتخاب نشده است.');
    cmbType.SetFocus;
    exit;
  end;
  if cmbPCode.Text = '' then
  begin
    AreValidFields := -1;
    ErrorMessage('شماره پرسنلي وارد نشده است.');
    cmbPCode.SetFocus;
    exit;
  end;
  if cmbPCode.Items.IndexOf(cmbPCode.Text) = -1 then
  begin
    AreValidFields := -1;
    ErrorMessage('چنين پرسنلي وجود ندارد.');
    cmbPCode.SetFocus;
    exit;
  end;
  if IsExistsRec(txtDate.Text, cmbPCode.Text, cmbType.ItemIndex + 1) and
    ((Flag = MB_NEW) or
     ((Flag = MB_EDIT) and (tblPrgPrs.FieldByName('PP_Date').AsString <> txtDate.Text) and
                           (tblPrgPrs.FieldByName('PP_Type').AsInteger <> cmbType.ItemIndex + 1) and
                           (tblPrgPrs.FieldByName('PP_PCode').AsString <> FixLeft(cmbPCode.Text, '0', 8)))) then
  begin
    AreValidFields := -1;
    ErrorMessage('انتخاب غذاي فرد در اين وعده تكراري است.');
    cmbPCode.SetFocus;
    exit;
  end;


////////////////
{$REGION 'Check Card Validation'}
  if True then
  begin
    p := GetPerson(cmbPCode.Text, False);
    if p.P_BarCode=''
    then
    begin
      p := GetPerson(cmbPCode.Text, True);
    end;
    if not p.P_exist then
    begin
      {Invalid Card}
      AreValidFields := 1;
      cmbPCode.SetFocus;
      exit;
    end;
  end;
{$ENDREGION 'Check Card Validation'}

{$REGION 'No serve this vadeh'}
  if (cmbType.ItemIndex in [MB_SOBH..MB_SOBHNEXT]) and
     (F_Params.Vadeh[cmbType.ItemIndex + 1] = MB_FALSE) then
  begin
    {No serve this vadeh}
    AreValidFields := (cmbType.ItemIndex + 1) - ((cmbType.ItemIndex +1) DIV 4) * 3  + 5;
    cmbType.SetFocus;
    Exit;
  end;
{$ENDREGION}

{$REGION 'Food Program not set'}
  for i := 1 to 8 do
    if DayFoodList[cmbType.ItemIndex + 1].Keys[i] <> 0 then
      Break;
  if i = 9 then
  begin
    {Food Program not set}
    AreValidFields := 10;
    cmbType.SetFocus;
    Exit;
  end;
{$ENDREGION}

{$REGION 'Reserve Food'}
  if F_Params.ValidInAllBuilding = MB_FALSE then
  begin
    if cmbBuilding.ItemIndex = -1 then
    begin
      {Reserved in No Building}
      AreValidFields := 20;
      cmbBuilding.SetFocus;
      exit;
    end;
    if p.p_building <> StrToInt(Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1)) then
    begin
      {Reserved in Other Building}
      AreValidFields := 19;
      cmbBuilding.SetFocus;
      exit;
    end;
  end;
{$ENDREGION}

{$REGION 'Check Many Fish'}
//  PersonFish.IsPayed := p.P_PriceAble;
//  for i := 1 to 8 do PersonFish.Fish_Foods[i] := 0;
//  if p.P_Special <> MB_NORMAL then
//  begin
//    PersonFish.ManySel := p.P_ManyFish;
//
//    if ErrTest and ((p.P_Special = MB_DATECARD) or (p.P_Special = MB_ANYDATECARD)) then
//    begin
//      if (p.P_ManyFish = 0) or
//         (p.P_EtebarFish < CurrentDate) then
//      begin
//        {Card Etebar}
//        CreateFish := 14;
//        Exit;
//      end;
//    end;
//  end
//  else
//    PersonFish.ManySel := 1;
{$ENDREGION}

{$REGION 'Food Not Selected'}
//  if PersonFish.Keys = 0 then
//  begin
//    {food not select}
//    if p.P_Rejim and (DayFoodList[PersonFish.Fish_Type].Keys[0] <> 0) then
//      PersonFish.Keys := 1
//
//    else
//      if DayFoodList[PersonFish.Fish_Type].Keys[9] <> 0 then
//      begin
//        if (F_Params.RunReserve=0) or ((F_Params.RunReserve=1) and (F_Params.MustReserve=0)) then
//          PersonFish.Keys := Pow2(9)
//        else
//        begin
//          {Food Program not set}
//          CreateFish := 15;
//          Exit;
//        end
//      end
//      else
//      begin
//        {Food Program not set}
//        CreateFish := 10;
//        Exit;
//      end;
//  end;
{$ENDREGION}

{$REGION 'check Key pressed'}
//  if (PersonFish.Keys AND Pow2(0)) <> 0 then
//  begin
//    {Rejimi key pressed}
//    if not p.P_Rejim and ErrTest then
//    begin
//      {Invalid Food Select}
//      CreateFish := 15;
//      Exit;
//    end
//    else
//      for i := 1 to 8 do
//        if (Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[0]) <> 0 then
//          PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
//  end
//  else if (PersonFish.Keys AND Pow2(9)) <> 0 then
//  begin
//    {Default Key Pressed}
//    if p.P_Rejim and ErrTest then
//    begin
//      {Invalid Food Select}
//      CreateFish := 15;
//      Exit;
//    end
//    else
//      for i := 1 to 8 do
//        if (Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[9]) <> 0 then
//          PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
//  end
//  else
//  begin
//    {any Key pressed}
//    FoodSel := False;
//    for i := 1 to 8 do
//      if ((PersonFish.Keys AND Pow2(i)) <> 0) and
//         (DayFoodList[PersonFish.Fish_Type].Keys[i] <> 0) then
//      begin
//        FoodSel := True;
//        Break;
//      end;
//  
//    if FoodSel then
//    begin
//      for i := 1 to 8 do
//        if (PersonFish.Keys AND Pow2(i)) <> 0 then
//        begin
//          if (p.P_Rejim and ((Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[9]) <> 0) and ((Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[0]) = 0)) or
//             (not p.P_Rejim and ((Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[0]) <> 0) and ((Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[9]) = 0)) and
//             ErrTest then
//          begin
//            {Invalid Food Select}
//            CreateFish := 15;
//            Exit;
//          end
//          else
//            PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
//        end;
//    end
//    else if not FoodSel and ErrTest then
//    begin
//      {Invalid Food Select}
//      CreateFish := 15;
//      Exit;
//    end;
//  end;
{$ENDREGION}

{$REGION 'prepaid persons'}
  sumPrice := 0;
  for i := 1 to 8 do
  begin
    if grdPrg.Cells[3, i] = 'X' then
    begin
      sumPrice := sumPrice + strtoint(grdPrg.Cells[2, i]);
    end;
  end;
  if  p.p_prepaid = true  then
  begin
    if p.p_credit <  (sumPrice + F_Params.MinCredit) then
    begin
      {credit not enough}
      AreValidFields := 18;
      Exit;
    end ;
  end;
{$endregion}

{$REGION 'Foods not exist'}
//  if ErrTest then
//  begin
//    for i := 1 to 8 do
//    begin
//      if (PersonFish.Fish_Foods[i] <> 0) and
//         ((UsedFoods[PersonFish.Fish_Type][i]+PersonFish.Fish_FoodsNo[i] > DayFoodList[PersonFish.Fish_Type].FoodAmar[i]) or
//          ((p.P_Special = MB_ANYCARD) and (UsedFoods[PersonFish.Fish_Type][i]+PersonFish.ManySel > DayFoodList[PersonFish.Fish_Type].FoodAmar[i]))) then
//      begin
//        {Foods not exist}
//        CreateFish := 11;
//        Exit;
//      end;
//    end;
//    CreateFish := CreateOnLineFish(PersonFish, P);
//  end;
{$ENDREGION}

{$REGION 'Other Policies'}
  if not p.P_exist then
  begin
    {Invalid card}
    AreValidFields := 1;
    cmbPCode.SetFocus;
    Exit;
  end;

  if not p.P_Isvalid then
  begin
    {Invalid card - no transmit}
    AreValidFields := 12;
    cmbPCode.SetFocus;
    Exit;
  end;


//  if not p.P_IsGuest and isFoodSel and
//          (dblCount >= 1)  and
//          ((F_Params.SecondFoodPrcPerson < 0) or not p.P_DblFood or (dblcount>p.P_dblFoodMax)) then
//  begin
//    {don't serve another food}
//    AreValidFields := 5;
//    grdPrg.SetFocus;
//    Exit;
//  end;
//
//  if p.P_IsGuest and isFoodSel and
//          (dblCount >= 1) and
//          ((F_Params.SecondFoodPrcGuest < 0) or not p.P_DblFood or (dblcount>p.P_dblFoodMax)) then
//  begin
//    {don't serve another food}
//    AreValidFields := 5;
//    grdPrg.SetFocus;
//    Exit;
//  end;

  if not p.P_Vadeh[(cmbType.ItemIndex + 1) - ((cmbType.ItemIndex + 1) DIV 4)*3] then
  begin
    {person don't select this vadeh}
    AreValidFields := 9;
    cmbType.SetFocus;
    Exit;
  end;

  if not p.P_IsGuest and p.P_ValidTest and not PersonArived(p.P_Proxi,(cmbType.ItemIndex + 1) - ((cmbType.ItemIndex + 1) DIV 4)*3) then
  begin
    {person not arived}
    AreValidFields := 2;
    if AutoCONTROL = 1 then
    cmbPCode.SetFocus;
    Exit;
//    frmFishLst.ViewFish(PersonFish, p, 2);
  end;

  if (not p.P_IsGuest) and (p.P_ShiftGroup <> 0) and
          ((KEY2VADEH[DayGroup.code] AND Pow2((cmbType.ItemIndex + 1) - ((cmbType.ItemIndex + 1) DIV 4)*3)) = 0) and
          (GetAddWork(p.P_BarCode) <> (cmbType.ItemIndex + 1) - ((cmbType.ItemIndex + 1) DIV 4)*3) then
  begin
    {Personel group not serve this vadeh and not in AddWork}
    if F_Params.kasr = mb_false then
    begin
      AreValidFields := 13;
      cmbType.SetFocus;
      Exit;
    end
    else
      F_Params.kasrshavad := true;
  end;

//  if result = 0 then
//  begin
//    case (cmbType.ItemIndex + 1) of
//      MB_NAHAR: j := F_Params.NaharKeyNo;
//      MB_SHAM : j := F_Params.ShamKeyNo;
//      else      j := 0;
//    end;
//    FoodN := 0;
//    for i := 1 to j do
//    begin
//      if (PersonFish.Fish_Foods[i] <> 0) and (FoodN > 0) then
//      begin
//        {Can not select any Foods}
//        AreValidFields := 4;
//        Exit;
//      end
//      else if PersonFish.Fish_Foods[i] <> 0 then
//        Inc(FoodN);
//    end;
//  end;
{$ENDREGION}

////////////////
  if True then
  begin
    find := False;
    for i := 1 to 8 do
      if grdPrg.Cells[3, i] = 'X' then
      begin
        find := True;
        Break;
      end;
    if not find then
    begin
      AreValidFields := -1;
      ErrorMessage('هيچ غذايي انتخاب نشده است.');
      grdPrg.SetFocus;
      exit;
    end
    else
      AreValidFields := 0;
  end;
end;

procedure TfrmPrgPerson.LoadPrgFood(TD : String);
var
  qry : TAdoQuery;
  i, j : Byte;
begin
  for i := 1 to 3 do
    for j := 1 to 8 do
      FodCodes[i][j] := 0;


  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Week');
  qry.SQL.Add('WHERE Week_Date = ''' + TD + '''');
  qry.Open;
  while not qry.EOF do
  begin
    i := qry.FieldByName('Week_Type').AsInteger;
    for j := 1 to 8 do
      FodCodes[i][j] := qry.FieldByName('Week_Key'+IntToStr(j)).AsInteger;
    qry.Next;
  end;
  qry.Close;
  qry.Free;
end;

procedure TfrmPrgPerson.FillGrdPrg(typ : Byte);
var i : Byte;
begin
  for i := 1 to 8 do
  begin
    grdPrg.Cells[1, i] := GetFoodNameInDB(FodCodes[typ][i]);
    grdPrg.Cells[2, i] := CurrToStr(GetFoodPriceInDB(FodCodes[typ][i],txtDate.Text).PriceFee);
    grdPrg.Cells[3, i] := '';
  end;
end;

function TfrmPrgPerson.IsExistsRec(TD, PCode: String; typ : Byte) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM PrgPrs WHERE PP_Date = ''' + TD + '''');
  qry.SQL.Add('AND PP_Type = ' + IntToStr(typ));
  qry.SQL.Add('AND PP_PCode = ''' + FixLeft(PCode, '0', 8) + '''');
  qry.Open;
  IsExistsRec := not qry.EOF;
  qry.Close;
  qry.Free;
end;



procedure TfrmPrgPerson.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
  i : Byte;
begin
  SetWinF;
  grpEdit.Align := alTop;

  grdPrg.ColWidths[0] := 80;
  grdPrg.ColWidths[1] := 200;
  grdPrg.ColWidths[2] := 80;
  grdPrg.ColWidths[3] := 60;

  grdPrg.Cells[0, 0] := ('شماره كليد');
  grdPrg.Cells[1, 0] := ('                         نام غذا');
  grdPrg.Cells[2, 0] := ('     قيمت');
  grdPrg.Cells[3, 0] := ('انتخاب فرد');

  for i := 1 to 8 do
    grdPrg.Cells[0, i] := '     ' + IntToStr(i);

  tblPrgPrs.connection := frmDBS.DBConnection;

  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT P_BarCode, P_Name, P_Family FROM Persons');
    SQL.Add('WHERE P_IsGuest = 0');
    Open;
    while not EOF do
    begin
      cmbPCode.Items.Add(DelLeftZero(FieldByName('P_BarCode').AsString));
      cmbFamilyName.Items.Add(FieldByName('P_Family').AsString +  '-' +
                              FieldByName('P_Name').AsString);
      Next;
    end;
    Close;
  end;

  cmbBuilding.Items.Clear;
  with qry do
  begin
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

  for i := MB_SOBH to MB_SHAM do
  begin
    cmbSrchType.Items.Add((FoodName[i]));
    cmbType.Items.Add((FoodName[i]));
  end;
  tblPrgPrs.Open;
  txtDate.Text := CurrentDate;
  txtSrchDate.Text := CurrentDate;
  lblRecNo.Caption := ('تعداد : ' )+ IntToStr(tblPrgPrs.RecordCount);
end;

procedure TfrmPrgPerson.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
  ReOpenTable;
end;

procedure TfrmPrgPerson.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblPrgPrs.Close;
end;

procedure TfrmPrgPerson.tblPrgPrsCalcFields(DataSet: TDataSet);
var
  i : Byte;
  s : String;
begin
  with DataSet do
  begin
    FieldByName('PCode').AsString := DelLeftZero(FieldByName('PP_PCode').AsString);
    FieldByName('Type').AsString := (FoodName[FieldByName('PP_Type').AsInteger]);
    s := '';
    for i := 1 to 8 do
      if FieldByName('PP_Key' + IntToStr(i)).AsBoolean then
      begin
        if s <> '' then s := s + ' - ';
        s := s + IntToStr(i);
      end;
    FieldByName('Keys').AsString := s;
  end;
end;

procedure TfrmPrgPerson.txtSrchDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmPrgPerson.cmbSrchTypeKeyPress(Sender: TObject;
  var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPrgPerson.grdPrgKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  if Key in [#49..#56] then
  begin
    grdPrg.Row := Ord(Key) - 48;
    Key := #32;
  end;

  if Key = #32 then
    grdPrgDblClick(Sender);
end;

procedure TfrmPrgPerson.grdPrgDblClick(Sender: TObject);
begin
  if (grdPrg.Row in [1..8]) and
     (grdPrg.Cells[1, grdPrg.Row] <> '') then
    if grdPrg.Cells[3, grdPrg.Row] <> 'X' then
      grdPrg.Cells[3, grdPrg.Row] := 'X'
    else
      grdPrg.Cells[3, grdPrg.Row] := '';
end;

procedure TfrmPrgPerson.txtDateExit(Sender: TObject);
begin
  with txtDate do
  begin
    if Text <> '' then
    begin
      Text := BeautifulDate(Text);
      LoadPrgFood(Text);
    end;

    if (Flag = MB_NEW) or (Text <> tblPrgPrs.FieldByName('PP_Date').AsString) then
      FillGrdPrg(cmbType.ItemIndex + 1);
  end;
end;

procedure TfrmPrgPerson.cmbTypeClick(Sender: TObject);
begin
  if (Flag = MB_NEW) or (cmbType.ItemIndex + 1 <> tblPrgPrs.FieldByName('PP_Type').AsInteger) then
    FillGrdPrg(cmbType.ItemIndex + 1);
end;

procedure TfrmPrgPerson.cmbSrchTypeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbSrchType.ItemIndex := -1;
  end;
end;

procedure TfrmPrgPerson.txtSrchPCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmPrgPerson.cmbPCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    grdPrg.SetFocus;
  end;
  Keyboard_Integer(Key);
end;

procedure TfrmPrgPerson.cmbPCodeExit(Sender: TObject);
begin
  if cmbPCode.Text <> '' then
  begin
    cmbPCode.ItemIndex := cmbPCode.Items.IndexOf(cmbPCode.Text);
    cmbFamilyName.ItemIndex := cmbPCode.ItemIndex;
  end;
end;

procedure TfrmPrgPerson.cmbPCodeClick(Sender: TObject);
begin
  cmbFamilyName.ItemIndex := cmbPCode.ItemIndex;
end;

procedure TfrmPrgPerson.cmbFamilyNameClick(Sender: TObject);
begin
  cmbPCode.ItemIndex := cmbFamilyName.ItemIndex;
end;


procedure TfrmPrgPerson.txtSrchDateExit(Sender: TObject);
begin
  with txtSrchDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
  ReOpenTable;
end;

procedure TfrmPrgPerson.cmbSrchTypeClick(Sender: TObject);
begin
  ReOpenTable;
end;

procedure TfrmPrgPerson.dbgPrgPrsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 9 then
  begin
    Key := 0;
    cmdNew.SetFocus;
  end
  else if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmPrgPerson.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearScrFields;
  txtDate.Text := CurrentDate;
end;

procedure TfrmPrgPerson.cmdEditClick(Sender: TObject);
begin
  if tblPrgPrs.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetScrFields;
  end;
end;

procedure TfrmPrgPerson.cmdDeleteClick(Sender: TObject);
begin
  if (tblPrgPrs.RecordCount > 0) and
      ConfirmMessage('آيا براي حذف برنامه غذايي فرد اطمينان داريد؟') then
  begin
    tblPrgPrs.Delete;
//    tblPrgPrs.Refresh;
    lblRecNo.Caption := ('تعداد : ' )+ IntToStr(tblPrgPrs.RecordCount);
  end;
end;

procedure TfrmPrgPerson.cmdSaveClick(Sender: TObject);
var
  i : Byte;
  Keys : LongInt;
  sumPrice  : Currency;
  adoQry : TADOQuery;
  iRetVal : Integer;
begin
  adoQry := TADOQuery.Create(Application);
  adoQry.Connection := frmDBS.DBConnection;

  iRetVal := AreValidFields;
  if iRetVal = 0 then
  begin
    if Flag = MB_NEW then
      tblPrgPrs.Insert
    else
      tblPrgPrs.Edit;

    tblPrgPrs.FieldByName('PP_Date').AsString := txtDate.Text;
    tblPrgPrs.FieldByName('PP_Type').AsInteger := cmbType.ItemIndex + 1;
    tblPrgPrs.FieldByName('PP_PCode').AsString := FixLeft(cmbPCode.Text, '0', 8);
    Keys := 0;
    sumPrice := 0;
    for i := 1 to 8 do
    begin
      if grdPrg.Cells[3, i] = 'X' then
      begin
        tblPrgPrs.FieldByName('PP_Key' + IntToStr(i)).AsBoolean := True;
        sumPrice := sumPrice + strtoint(grdPrg.Cells[2, i]);
        Keys := Keys OR Pow2(i);
      end
      else
        tblPrgPrs.FieldByName('PP_Key' + IntToStr(i)).AsBoolean := False;
    end;
    tblPrgPrs.FieldByName('PP_Keys').AsInteger := Keys;
    tblPrgPrs.FieldByName('PP_Price').AsCurrency := sumPrice;
    if cmbBuilding.Text <> '' then
      tblPrgPrs.FieldByName('PP_Building').AsInteger := StrToInt(copy(cmbBuilding.Text,1,pos('-',cmbBuilding.Text)-1))
    else
      tblPrgPrs.FieldByName('PP_Building').AsInteger := 0;
    tblPrgPrs.Post;
    lblRecNo.Caption := ('تعداد : ' )+ IntToStr(tblPrgPrs.RecordCount);

    if Flag = MB_NEW then
    begin
      cmbPCode.ItemIndex := 0;
      cmbFamilyName.ItemIndex := 0;
      FillGrdPrg(cmbType.ItemIndex+1);
      cmbPCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgPrgPrs.SetFocus;
    end;
  end
  else
    if iRetVal <> -1 then
      ErrorMessage(ErrMsg[iRetVal]);

end;

procedure TfrmPrgPerson.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgPrgPrs.SetFocus;
end;


end.
