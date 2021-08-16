unit FishUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, AdoDB, Globals, MSGs, DateProc, DBS_Proc, Keyboard,
  Grids;

type
  TfrmFishUnit = class(TForm)
    Label1: TLabel;
    cmd1: TButton;
    cmd2: TButton;
    cmd3: TButton;
    cmd4: TButton;
    cmd5: TButton;
    cmd6: TButton;
    cmd7: TButton;
    cmd8: TButton;
    cmd9: TButton;
    cmd0: TButton;
    Label2: TLabel;
    Label3: TLabel;
    cmdSave: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    tmrTime: TTimer;
    txtDate: TEdit;
    txtTime: TEdit;
    cmbUnits: TComboBox;
    Label4: TLabel;
    grdFood: TStringGrid;
    cmbKhadamat: TComboBox;
    cmbPrcType: TComboBox;
    chkIsPrice: TCheckBox;
    Label5: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure cmd1Click(Sender: TObject);
    procedure cmd2Click(Sender: TObject);
    procedure cmd3Click(Sender: TObject);
    procedure cmd4Click(Sender: TObject);
    procedure cmd5Click(Sender: TObject);
    procedure cmd6Click(Sender: TObject);
    procedure cmd7Click(Sender: TObject);
    procedure cmd8Click(Sender: TObject);
    procedure cmd9Click(Sender: TObject);
    procedure cmd0Click(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeExit(Sender: TObject);
    procedure cmbUnitsKeyPress(Sender: TObject; var Key: Char);
    procedure cmbKhadamatKeyPress(Sender: TObject; var Key: Char);
    procedure grdFoodKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    F_Type : Byte;
    PersonFish : TFish;


    procedure ClearFields;
    procedure SetFields;
    function  ValidFields : Boolean;
    function  CreateUnitFish(var PersonFish : TFish; var P : TPerson) : Integer;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmFishUnit.SetWinF;
var i : byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  cmd1.Caption := (cmd1.Caption);
  cmd2.Caption := (cmd2.Caption);
  cmd3.Caption := (cmd3.Caption);
  cmd4.Caption := (cmd4.Caption);
  cmd5.Caption := (cmd5.Caption);
  cmd6.Caption := (cmd6.Caption);
  cmd7.Caption := (cmd7.Caption);
  cmd8.Caption := (cmd8.Caption);
  cmd9.Caption := (cmd9.Caption);
  cmd0.Caption := (cmd0.Caption);
  chkIsPrice.Caption := (chkIsPrice.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  for i := 0 to cmbPrcType.Items.Count - 1 do
    cmbPrcType.Items.Strings[i] := (cmbPrcType.Items.Strings[i]);
end;

procedure TfrmFishUnit.ClearFields;
var i : Byte;
begin
  for i := 1 to 8 do
  begin
    PersonFish.Fish_Foods[i] := 0;
    grdFood.Cells[0, i] := '';
    grdFood.Cells[1, i] := '';
  end;
  PersonFish.Keys := 0;
end;

procedure TfrmFishUnit.SetFields;
var i : Byte;
begin
  for i := 1 to 8 do
    grdFood.Cells[0, i] := GetFoodNameInRam(PersonFish.Fish_Foods[i]);
end;

function TfrmFishUnit.ValidFields : Boolean;
var
  i : Byte;
  FoodSel : Boolean;
begin
  ValidFields := True;
  if cmbUnits.Text = '' then
  begin
    ErrorMessage('Ê«Õœ  «»⁄Â „‘Œ’ ‰Ì” .');
    cmbUnits.SetFocus;
    ValidFields := False;
  end
  else if cmbPrcType.Text = '' then
  begin
    ErrorMessage('‰Ê⁄ ﬁÌ„  ê–«—Ì „‘Œ’ ‰Ì” .');
    cmbPrcType.SetFocus;
    ValidFields := False;
  end
  else
  begin
    {qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.DBConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM Fish WHERE Fish_Date = ''' + txtDate.Text + '''');
    qry.SQL.Add('AND Fish_Type = ' + IntToStr(F_Type));
    qry.SQL.Add('AND Fish_UCode = ' + Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1));
    qry.Open;
    if not qry.Eof then
    begin
      ErrorMessage('»—«Ì «Ì‰ Ê«Õœ ›Ì‘ ’«œ— ‘œÂ «” .');
      cmbUnits.SetFocus;
      ValidFields := False;
      qry.Close;
      qry.Free;
    end
    else
    begin
      qry.Close;
      qry.Free;}

      FoodSel := False;
      for i := 1 to 8 do
      begin
        if (grdFood.Cells[0, i] <> '') then
        begin
          FoodSel := True;
          Break;
        end;
      end;

      if not FoodSel then
      begin
        ErrorMessage('ÂÌç €–«ÌÌ «‰ Œ«» ‰‘œÂ «” .');
        grdFood.SetFocus;
        ValidFields := False;
      end
      else
        for i := 1 to 8 do
        begin
          if (grdFood.Cells[0, i] <> '') and
             (grdFood.Cells[1, i] = '') then
          begin
            ErrorMessage('„ﬁœ«— „‘Œ’ ‰Ì” .');
            grdFood.SetFocus;
            ValidFields := False;
          end;
        end;     
    //end;
  end;
end;

function TfrmFishUnit.CreateUnitFish(var PersonFish : TFish; var P : TPerson) : Integer;
var
  i : Byte;
begin
  if g_options.RunDate <> PersonFish.Fish_Date then
  begin
    g_options.RunDate := PersonFish.Fish_Date;
    InitVariables(False);
  end;

  CreateUnitFish := 0;
  if (PersonFish.Fish_Time >= F_Params.FromSobh) and
     (PersonFish.Fish_Time <= F_Params.ToSobh) then
  begin
    PersonFish.Fish_Type := MB_SOBH;
    PersonFish.Fish_No := Sobh_Fish_No;
  end
  else if (PersonFish.Fish_Time >= F_Params.FromNahar) and
          (PersonFish.Fish_Time <= F_Params.ToNahar) then
  begin
    PersonFish.Fish_Type := MB_NAHAR;
    PersonFish.Fish_No := Nahar_Fish_No;
  end
  else if (PersonFish.Fish_Time >= F_Params.FromSham) and
          (PersonFish.Fish_Time <= F_Params.ToSham) then
  begin
    PersonFish.Fish_Type := MB_SHAM;
    PersonFish.Fish_No := Sham_Fish_No;
  end
  else
  begin
    {Out of time}
    CreateUnitFish := 3;
    Exit;
  end;

  {Date Test}
  if (PersonFish.Fish_Type in [MB_SOBH..MB_SHAM]) and
     (F_Params.Vadeh[PersonFish.Fish_Type] = MB_FALSE) then
  begin
    {No serve this vadeh}
    CreateUnitFish := PersonFish.Fish_Type + 5;
    Exit;
  end;

  for i := 1 to 8 do
    if DayFoodList[PersonFish.Fish_Type].Keys[i] <> 0 then
      Break;
  if i = 9 then
  begin
    {Food Program not set}
    CreateUnitFish := 10;
    Exit;
  end;

  PersonFish.Fish_PCode := p.P_BarCode;

  for i := 1 to 8 do PersonFish.Fish_Foods[i] := 0;
  PersonFish.ManySel := 1;

  if PersonFish.Keys = 0 then
  begin
    {food not select}
    if DayFoodList[PersonFish.Fish_Type].Keys[9] <> 0 then
      PersonFish.Keys := Pow2(9)
    else
    begin
      {Food Program not set}
      CreateUnitFish := 10;
      Exit;
    end;
  end;

  if (PersonFish.Keys AND Pow2(0)) <> 0 then
  begin
    {Default Key Pressed}
    for i := 1 to 8 do
      if (Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[0]) <> 0 then
        PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
  end
  else if (PersonFish.Keys AND Pow2(9)) <> 0 then
  begin
    {Rejimi key pressed}
    for i := 1 to 8 do
      if (Pow2(i) AND DayFoodList[PersonFish.Fish_Type].Keys[9]) <> 0 then
        PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
  end
  else
  begin
    {any Key pressed}
    for i := 1 to 8 do
      if (PersonFish.Keys AND Pow2(i)) <> 0 then
        PersonFish.Fish_Foods[i] := DayFoodList[PersonFish.Fish_Type].Keys[i];
  end;

  for i := 1 to 8 do
    if PersonFish.Fish_Foods[i] <> 0 then
    begin
      if cmbPrcType.ItemIndex = PRC_PERSON then
        PersonFish.Fish_Price[i] := GetFoodPricePersonInRam(PersonFish.Fish_Foods[i])
      else
        PersonFish.Fish_Price[i] := GetFoodPriceFeeInRam(PersonFish.Fish_Foods[i]);
    end
    else
      PersonFish.Fish_Price[i] := 0;


  for i := 1 to 8 do
  begin
      if (PersonFish.Fish_Foods[i] <> 0) and
         ((UsedFoods[PersonFish.Fish_Type][i]+PersonFish.Fish_FoodsNo[i] > DayFoodList[PersonFish.Fish_Type].FoodAmar[i])) then
    begin
      {Foods not exsist}
      CreateUnitFish := 11;
      Exit;
    end;
  end;
end;


procedure TfrmFishUnit.FormActivate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  txtDate.Text := CurrentDate;
  grdFood.ColWidths[0] := 200;
  grdFood.Cells[0, 0] := ('€–« Ê „Œ·›« ');
  grdFood.Cells[1, 0] := (' ⁄œ«œ');

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Units');
  qry.Open;
  while not qry.Eof do
  begin
    cmbUnits.Items.Add(qry.FieldByName('Unit_Code').AsString + '-' + qry.FieldByName('Unit_Name').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM FoodList WHERE Food_Type = ' + IntToStr(MB_KHADAMAT));
  qry.Open;
  while not qry.Eof do
  begin
    cmbKhadamat.Items.Add(qry.FieldByName('Food_Code').AsString + '-' +
                          qry.FieldByName('Food_Name').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;
  ClearFields;
  cmbPrcType.ItemIndex := PRC_PERSON;
end;

procedure TfrmFishUnit.tmrTimeTimer(Sender: TObject);
begin
  txtTime.Text := CurrentTime;
  if (txtTime.Text >= F_Params.FromSobh) and (txtTime.Text <= F_Params.ToSobh) then
    F_Type := MB_SOBH
  else if (txtTime.Text >= F_Params.FromNahar) and (txtTime.Text <= F_Params.ToNahar) then
    F_Type := MB_NAHAR
  else if (txtTime.Text >= F_Params.FromSham) and (txtTime.Text <= F_Params.ToSham) then
    F_Type := MB_SHAM;
end;

procedure TfrmFishUnit.cmd1Click(Sender: TObject);
begin
  if F_Type <> 0 then
  begin
    if PersonFish.Fish_Foods[1] = 0 then
      PersonFish.Fish_Foods[1] := DayFoodList[F_Type].Keys[1]
    else
      PersonFish.Fish_Foods[1] := 0;
    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd2Click(Sender: TObject);
begin
  if F_Type <> 0 then
  begin
    if PersonFish.Fish_Foods[2] = 0 then
      PersonFish.Fish_Foods[2] := DayFoodList[F_Type].Keys[2]
    else
      PersonFish.Fish_Foods[2] := 0;
    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd3Click(Sender: TObject);
begin
  if F_Type <> 0 then
  begin
    if PersonFish.Fish_Foods[3] = 0 then
      PersonFish.Fish_Foods[3] := DayFoodList[F_Type].Keys[3]
    else
      PersonFish.Fish_Foods[3] := 0;
    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd4Click(Sender: TObject);
begin
  if F_Type <> 0 then
  begin
    if PersonFish.Fish_Foods[4] = 0 then
      PersonFish.Fish_Foods[4] := DayFoodList[F_Type].Keys[4]
    else
      PersonFish.Fish_Foods[4] := 0;
    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd5Click(Sender: TObject);
begin
  if F_Type <> 0 then
  begin
    if PersonFish.Fish_Foods[5] = 0 then
      PersonFish.Fish_Foods[5] := DayFoodList[F_Type].Keys[5]
    else
      PersonFish.Fish_Foods[5] := 0;
    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd6Click(Sender: TObject);
begin
  if F_Type <> 0 then
  begin
    if PersonFish.Fish_Foods[6] = 0 then
      PersonFish.Fish_Foods[6] := DayFoodList[F_Type].Keys[6]
    else
      PersonFish.Fish_Foods[6] := 0;
    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd7Click(Sender: TObject);
begin
  if F_Type <> 0 then
  begin
    if PersonFish.Fish_Foods[7] = 0 then
      PersonFish.Fish_Foods[7] := DayFoodList[F_Type].Keys[7]
    else
      PersonFish.Fish_Foods[7] := 0;
    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd8Click(Sender: TObject);
begin
  if F_Type <> 0 then
  begin
    if PersonFish.Fish_Foods[8] = 0 then
      PersonFish.Fish_Foods[8] := DayFoodList[F_Type].Keys[8]
    else
      PersonFish.Fish_Foods[8] := 0;
    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd9Click(Sender: TObject);
var i : Byte;
begin
  if F_Type <> 0 then
  begin
    for i := 1 to 8 do
      if (Pow2(i) AND DayFoodList[F_Type].Keys[9]) <> 0 then
        PersonFish.Fish_Foods[i] := DayFoodList[F_Type].Keys[i]
      else
        PersonFish.Fish_Foods[i] := 0;

    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmd0Click(Sender: TObject);
var i : Byte;
begin
  if F_Type <> 0 then
  begin
    for i := 1 to 8 do
      if (Pow2(i) AND DayFoodList[F_Type].Keys[0]) <> 0 then
        PersonFish.Fish_Foods[i] := DayFoodList[F_Type].Keys[i]
      else
        PersonFish.Fish_Foods[i] := 0;

    SetFields;
  end
  else
    ErrorMessage('„ÕœÊœÂ “„«‰Ì œ— „ÕœÊœÂ Â«Ì ’»Õ«‰Â Ê ‰«Â«— Ê ‘«„ ‰„Ìù»«‘œ.');
end;

procedure TfrmFishUnit.cmbUnitsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbKhadamat.SetFocus;
  end;
end;

procedure TfrmFishUnit.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbUnits.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmFishUnit.txtDateExit(Sender: TObject);
begin
  with txtDate do
    if Text <> '' then
      Text := BeautifulDate(Text);

  if (txtTime.Text >= F_Params.FromSobh) and (txtTime.Text <= F_Params.ToSobh) then
    F_Type := MB_SOBH
  else if (txtTime.Text >= F_Params.FromNahar) and (txtTime.Text <= F_Params.ToNahar) then
    F_Type := MB_NAHAR
  else if (txtTime.Text >= F_Params.FromSham) and (txtTime.Text <= F_Params.ToSham) then
    F_Type := MB_SHAM;

  if g_options.RunDate <> txtDate.Text then
  begin
    g_options.RunDate := txtDate.Text;
    InitVariables(False);
  end;
end;

procedure TfrmFishUnit.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbUnits.SetFocus;
  end
  else if Key in ['0'..'9', #8, ':'] then
  begin
    tmrTime.Enabled := False;
    Keyboard_Time(Key);
  end;

  if (txtTime.Text >= F_Params.FromSobh) and (txtTime.Text <= F_Params.ToSobh) then
    F_Type := MB_SOBH
  else if (txtTime.Text >= F_Params.FromNahar) and (txtTime.Text <= F_Params.ToNahar) then
    F_Type := MB_NAHAR
  else if (txtTime.Text >= F_Params.FromSham) and (txtTime.Text <= F_Params.ToSham) then
    F_Type := MB_SHAM;
end;

procedure TfrmFishUnit.txtTimeExit(Sender: TObject);
begin
  with txtTime do
    if Text <> '' then
      Text := BeautifulTime(Text);

  if (txtTime.Text >= F_Params.FromSobh) and (txtTime.Text <= F_Params.ToSobh) then
    F_Type := MB_SOBH
  else if (txtTime.Text >= F_Params.FromNahar) and (txtTime.Text <= F_Params.ToNahar) then
    F_Type := MB_NAHAR
  else if (txtTime.Text >= F_Params.FromSham) and (txtTime.Text <= F_Params.ToSham) then
    F_Type := MB_SHAM;

  if g_options.RunDate <> txtDate.Text then
  begin
    g_options.RunDate := txtDate.Text;
    InitVariables(False);
  end;
end;

procedure TfrmFishUnit.grdFoodKeyPress(Sender: TObject; var Key: Char);
begin
  if (grdFood.Col = 1) and (grdFood.Row > 0) and
     (Length(grdFood.Cells[grdFood.Col, grdFood.Row]) < 5) then
    Keyboard_Integer(Key)
  else if (grdFood.Col = 0) and (grdFood.Row > 0) and
          (Key = #32) then
  begin
    Key := #0;
    if grdFood.Cells[0, grdFood.Row] = '' then
      PersonFish.Fish_Foods[grdFood.Row] := DayFoodList[F_Type].Keys[grdFood.Row]
    else
      PersonFish.Fish_Foods[grdFood.Row] := 0;
    SetFields;
  end
  else
    Key := #0;
end;

procedure TfrmFishUnit.cmbKhadamatKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmFishUnit.cmdSaveClick(Sender: TObject);
const
  ErrMsg : array[1..15] of string = (
    { 1}'ﬂ«—  €Ì— „Ã«“ „Ìù»«‘œ',
    { 2}'Ê—Êœ ›—œ À»  ‰‘œÂ «” ',
    { 3}'œ—ŒÊ«”  Œ«—Ã «“ „ÕœÊœÂ “„«‰Ì «” ',
    { 4}'«‰ Œ«» »Ì‘ «“ Ìﬂ €–« €Ì— „Ã«“ «” ',
    { 5}'€–«Ì «÷«›Ì ”—Ê ‰„Ìù‘Êœ',
    { 6}'’»Õ«‰Â ”—Ê ‰„Ìù‘Êœ',
    { 7}'‰«Â«— ”—Ê ‰„Ìù‘Êœ',
    { 8}'‘«„ ”—Ê ‰„Ìù‘Êœ',
    { 9}'›—œ Õﬁ «‰ Œ«» «Ì‰ Ê⁄œÂ —« ‰œ«—œ',
    {10}'»—‰«„Â €–«ÌÌ  ‰ŸÌ„ ‰‘œÂ «” ',
    {11}'€–«  „«„ ‘œ',
    {12}'«Ã«“Â  —œœ «“ ›—œ ”·» ‘œÂ «” ',
    {13}'«‰ Œ«» Ê⁄œÂ œ— ê—ÊÂ Ê «÷«›Â ﬂ«—Ì ‰„Ìù»«‘œ',
    {14}'«⁄ »«— ﬂ«—  »Â Å«Ì«‰ —”ÌœÂ «” .',
    {15}'«‰ Œ«» €–«Ì ‰«„Ã«“.');

var
  i : Byte;
  retVal : Integer;
  p : TPerson;
begin
  if ValidFields then
  begin
    p := GetPerson('', False);
    PersonFish.Keys := 0;
    PersonFish.Fish_UCode := StrToInt(Copy(cmbUnits.Text, 1, Pos('-', cmbUnits.Text)-1));
    if cmbKhadamat.Text <> '' then
      PersonFish.Fish_UKhadamat := StrToInt(Copy(cmbKhadamat.Text, 1, Pos('-', cmbKhadamat.Text)-1))
    else
      PersonFish.Fish_UKhadamat := 0;

    PersonFish.IsProxi := False;
    for i := 1 to 8 do
      if grdFood.Cells[0, i] <> '' then
      begin
        PersonFish.Keys := PersonFish.Keys OR Pow2(i);
        PersonFish.Fish_FoodsNo[i] := StrToInt(grdFood.Cells[1, i]);
      end
      else
        PersonFish.Fish_FoodsNo[i] := 0;

    PersonFish.Fish_Date := txtDate.Text;
    PersonFish.Fish_Time := txtTime.Text;
    p.P_BarCode := '';
    PersonFish.IsPayed := chkIsPrice.Checked;
    retVal := CreateUnitFish(PersonFish, p);
    if retVal <> 0 then
      ErrorMessage(ErrMsg[retVal])
    else
    begin
      if cmbKhadamat.Text <> '' then
      begin
        if cmbPrcType.ItemIndex = PRC_PERSON then
        begin
          if chkIsPrice.Checked then
          begin
            PersonFish.Fish_UPay := GetFoodPricePersonInRam(PersonFish.Fish_UKhadamat);
            PersonFish.Fish_UPrc := 0;
          end
          else
          begin
            PersonFish.Fish_UPay := 0;
            PersonFish.Fish_UPrc := GetFoodPricePersonInRam(PersonFish.Fish_UKhadamat);
          end;
        end
        else
        begin
          if chkIsPrice.Checked then
          begin
            PersonFish.Fish_UPay := GetFoodPriceFeeInRam(PersonFish.Fish_UKhadamat);
            PersonFish.Fish_UPrc := 0;
          end
          else
          begin
            PersonFish.Fish_UPay := 0;
            PersonFish.Fish_UPrc := GetFoodPriceFeeInRam(PersonFish.Fish_UKhadamat);
          end;
        end;
      end
      else
      begin
        PersonFish.Fish_UPay := 0;
        PersonFish.Fish_UPrc := 0;
      end;

      PersonFish.Fish_PCode := FixLeft(IntToStr(PersonFish.Fish_UCode), '#', 8);
      SaveFish(PersonFish);
      ClearFields;
      cmbUnits.SetFocus;
    end;
  end;
end;

end.
