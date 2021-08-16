unit DayProg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, MSGs, FarsiApi, DBS_Proc, DateProc,
  Keyboard;

type
  TfrmSobhInf = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cmb1: TComboBox;
    cmb2: TComboBox;
    cmb3: TComboBox;
    cmb4: TComboBox;
    cmb5: TComboBox;
    cmb6: TComboBox;
    cmb7: TComboBox;
    cmb8: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lstAll: TListBox;
    Label11: TLabel;
    lstRejim: TListBox;
    Label12: TLabel;
    cmdAddAll: TBitBtn;
    cmdDelAll: TBitBtn;
    cmdAddRejim: TBitBtn;
    cmdDelRejim: TBitBtn;
    cmdAll: TBitBtn;
    cmdNone: TBitBtn;
    cmdSave: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    lblDate: TLabel;
    cmdNext: TBitBtn;
    cmdPrior: TBitBtn;
    Label9: TLabel;
    txtAmar1: TEdit;
    txtAmar2: TEdit;
    txtAmar3: TEdit;
    txtAmar4: TEdit;
    txtAmar5: TEdit;
    txtAmar6: TEdit;
    txtAmar7: TEdit;
    txtAmar8: TEdit;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    procedure cmb1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmb1Enter(Sender: TObject);
    procedure cmb2Enter(Sender: TObject);
    procedure cmb3Enter(Sender: TObject);
    procedure cmb4Enter(Sender: TObject);
    procedure cmb5Enter(Sender: TObject);
    procedure cmb6Enter(Sender: TObject);
    procedure cmb7Enter(Sender: TObject);
    procedure cmb8Enter(Sender: TObject);
    procedure lstAllDblClick(Sender: TObject);
    procedure cmdAddAllClick(Sender: TObject);
    procedure cmdDelAllClick(Sender: TObject);
    procedure lstRejimDblClick(Sender: TObject);
    procedure cmdAddRejimClick(Sender: TObject);
    procedure cmdDelRejimClick(Sender: TObject);
    procedure cmdAllClick(Sender: TObject);
    procedure cmdNoneClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNextClick(Sender: TObject);
    procedure cmdPriorClick(Sender: TObject);
    procedure cmb1KeyPress(Sender: TObject; var Key: Char);
    procedure txtAmar1KeyPress(Sender: TObject; var Key: Char);
    procedure cmb2KeyPress(Sender: TObject; var Key: Char);
    procedure txtAmar2KeyPress(Sender: TObject; var Key: Char);
    procedure cmb3KeyPress(Sender: TObject; var Key: Char);
    procedure txtAmar3KeyPress(Sender: TObject; var Key: Char);
    procedure cmb4KeyPress(Sender: TObject; var Key: Char);
    procedure txtAmar4KeyPress(Sender: TObject; var Key: Char);
    procedure cmb5KeyPress(Sender: TObject; var Key: Char);
    procedure txtAmar5KeyPress(Sender: TObject; var Key: Char);
    procedure cmb6KeyPress(Sender: TObject; var Key: Char);
    procedure txtAmar6KeyPress(Sender: TObject; var Key: Char);
    procedure cmb7KeyPress(Sender: TObject; var Key: Char);
    procedure txtAmar7KeyPress(Sender: TObject; var Key: Char);
    procedure cmb8KeyPress(Sender: TObject; var Key: Char);
    procedure txtAmar8KeyPress(Sender: TObject; var Key: Char);
    procedure lstAllKeyPress(Sender: TObject; var Key: Char);
    procedure lstRejimKeyPress(Sender: TObject; var Key: Char);
    procedure lstAllKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstRejimKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    cmbs : array[1..8] of TComboBox;
    txts : array[1..8] of TEdit;
    ActiveCtrl : Byte;

    procedure FillDayProg;
    procedure SetComboIndex(idx : Byte; FCode : Integer);
    function  AreControlsValid : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
    FoodType : Byte;
  end;

implementation

{$R *.DFM}

procedure TfrmSobhInf.SetWinF;
begin
  Caption := (Caption);
  Label9.Caption := (Label9.Caption);
  Label11.Caption := (Label11.Caption);
  Label12.Caption := (Label12.Caption);
  Label10.Caption := (Label10.Caption);
  Label13.Caption := (Label13.Caption);
  Label14.Caption := (Label14.Caption);
  Label15.Caption := (Label15.Caption);
  Label16.Caption := (Label16.Caption);
  Label17.Caption := (Label17.Caption);
  Label18.Caption := (Label18.Caption);
  Label19.Caption := (Label19.Caption);
  cmdAll.Caption := (cmdAll.Caption);
  cmdNone.Caption := (cmdNone.Caption);
  cmdAddAll.Caption := (cmdAddAll.Caption);
  cmdDelAll.Caption := (cmdDelAll.Caption);
  cmdAddRejim.Caption := (cmdAddRejim.Caption);
  cmdDelRejim.Caption := (cmdDelRejim.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdPrior.Caption := (cmdPrior.Caption);
  cmdNext.Caption := (cmdNext.Caption);
end;

procedure TfrmSobhInf.FillDayProg;
var
  qry : TAdoQuery;
  i : Byte;
begin
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM Week WHERE Week_Date = ''' + lblDate.Caption + '''');
    SQL.Add('AND Week_Type = ' + IntToStr(FoodType));
    Open;
    for i := 1 to 8 do
    begin
      cmbs[i].ItemIndex := -1;
      txts[i].Text := '';
      lstAll.Items.Strings[i-1] := ' ';
      lstRejim.Items.Strings[i-1] := ' ';
    end;
    if RecordCount > 0 then
    begin
      for i := 1 to 8 do
      begin
        SetComboIndex(i, FieldByName('Week_Key'+IntToStr(i)).AsInteger);
        if txts[i].Visible then
          txts[i].Text := IntToStr(FieldByName('Week_N'+IntToStr(i)).AsInteger);

        if (FieldByName('Week_Key9').AsInteger AND Pow2(i)) <> 0 then
          lstAll.Items.Strings[i-1] := cmbs[i].Text;

        if (FieldByName('Week_Key0').AsInteger AND Pow2(i)) <> 0 then
          lstRejim.Items.Strings[i-1] := cmbs[i].Text;
      end;
    end;
    Free;
  end;
end;

procedure TfrmSobhInf.SetComboIndex(idx : Byte; FCode : Integer);
begin
  cmbs[idx].ItemIndex := cmbs[idx].Items.IndexOf(GetFoodNameInRam(FCode));
end;

function TfrmSobhInf.AreControlsValid : Boolean;
var i : Byte;
begin
  AreControlsValid := False;
  for i := 1 to 8 do
    if txts[i].Visible and (txts[i].Text = '') and (cmbs[i].Text <> '') then
    begin
      ErrorMessage('¬„«— €–«ÌÌ Ê«—œ ‰‘œÂ «” .');
      txts[i].SetFocus;
      Exit;
    end;

  for i := 1 to 8 do
    if cmbs[i].Text <> '' then
    begin
      AreControlsValid := True;
      Break;
    end;
end;

procedure TfrmSobhInf.FormActivate(Sender: TObject);
var
  i, n : Byte;
  qry : TAdoQuery;
begin
  Caption := Caption + ' ' + FoodName[FoodType];
  SetWinF;
  
  cmbs[1] := cmb1;
  cmbs[2] := cmb2;
  cmbs[3] := cmb3;
  cmbs[4] := cmb4;
  cmbs[5] := cmb5;
  cmbs[6] := cmb6;
  cmbs[7] := cmb7;
  cmbs[8] := cmb8;

  txts[1] := txtAmar1;
  txts[2] := txtAmar2;
  txts[3] := txtAmar3;
  txts[4] := txtAmar4;
  txts[5] := txtAmar5;
  txts[6] := txtAmar6;
  txts[7] := txtAmar7;
  txts[8] := txtAmar8;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;

  case FoodType of
    MB_SOBH :
    begin
      qry.SQL.Add('SELECT * FROM FoodList');
      qry.SQL.Add('WHERE Food_Type = ' + IntToStr(MB_SOBHANEH));
      qry.SQL.Add('order by Food_Name');
      qry.Open;
      if qry.RecordCount > 0 then
        while not qry.EOF do
        begin
          cmb1.Items.Add(qry.FieldByName('Food_Name').AsString);
          qry.Next;
        end;
      qry.Close;

      n := F_Params.SobhKeyNo;
      for i := 2 to n do
        cmbs[i].Items := cmb1.Items;

      for i := n+1 to 8 do
        txts[i].Visible := False;

      if (n < 8) and (F_Params.Mokhlafat = MB_TRUE) then
      begin
        qry.SQL.Clear;
        qry.SQL.Add('SELECT * FROM FoodList');
        qry.SQL.Add('WHERE Food_Type = ' + IntToStr(MB_MOKHALAFAT));
        qry.SQL.Add('order by Food_Name');
        qry.Open;
        if qry.RecordCount > 0 then
          while not qry.EOF do
          begin
            cmbs[n+1].Items.Add(qry.FieldByName('Food_Name').AsString);
            qry.Next;
          end;
        qry.Close;
      end;

      for i := n+2 to 8 do
        cmbs[i].Items := cmbs[n+1].Items;
    end;

    MB_Nahar,
    MB_SHAM :
    begin
      qry.SQL.Add('SELECT * FROM FoodList');
      qry.SQL.Add('WHERE Food_Type = ' + IntToStr(MB_GHAZA));
      qry.SQL.Add('order by Food_Name');
      qry.Open;
      if qry.RecordCount > 0 then
        while not qry.EOF do
        begin
          cmb1.Items.Add(qry.FieldByName('Food_Name').AsString);
          qry.Next;
        end;
      qry.Close;

      if FoodType = MB_NAHAR then
        n := F_Params.NaharKeyNo
      else
        n := F_Params.ShamKeyNo;

      for i := 2 to n do
        cmbs[i].Items := cmb1.Items;

      for i := n+1 to 8 do
        txts[i].Visible := False;

      if (n < 8) and (F_Params.Mokhlafat = MB_TRUE) then
      begin
        qry.SQL.Clear;
        qry.SQL.Add('SELECT * FROM FoodList');
        qry.SQL.Add('WHERE Food_Type = ' + IntToStr(MB_MOKHALAFAT));
        qry.SQL.Add('order by Food_Name');
        qry.Open;
        if qry.RecordCount > 0 then
          while not qry.EOF do
          begin
            cmbs[n+1].Items.Add(qry.FieldByName('Food_Name').AsString);
            qry.Next;
          end;
        qry.Close;
      end;

      for i := n+2 to 8 do
        cmbs[i].Items := cmbs[n+1].Items;
    end;
  end;
  qry.Free;
  FillDayProg;
end;

procedure TfrmSobhInf.cmb1Enter(Sender: TObject);
begin
  ActiveCtrl := 1;
end;

procedure TfrmSobhInf.cmb2Enter(Sender: TObject);
begin
  ActiveCtrl := 2;
end;

procedure TfrmSobhInf.cmb3Enter(Sender: TObject);
begin
  ActiveCtrl := 3;
end;

procedure TfrmSobhInf.cmb4Enter(Sender: TObject);
begin
  ActiveCtrl := 4;
end;

procedure TfrmSobhInf.cmb5Enter(Sender: TObject);
begin
  ActiveCtrl := 5;
end;

procedure TfrmSobhInf.cmb6Enter(Sender: TObject);
begin
  ActiveCtrl := 6;
end;

procedure TfrmSobhInf.cmb7Enter(Sender: TObject);
begin
  ActiveCtrl := 7;
end;

procedure TfrmSobhInf.cmb8Enter(Sender: TObject);
begin
  ActiveCtrl := 8;
end;

procedure TfrmSobhInf.cmb1Click(Sender: TObject);
var i : Byte;
begin
  if (FoodType = MB_NAHAR) and (ActiveCtrl <= F_Params.NaharKeyNo) then
  begin
    for i := 0 to F_Params.NaharKeyNo-1 do
      if lstAll.Items.Strings[i] <> ' ' then
        Exit;
    lstAll.Items.Strings[ActiveCtrl-1] := cmbs[ActiveCtrl].Text;
  end
  else if (FoodType = MB_SHAM) and (ActiveCtrl <= F_Params.ShamKeyNo) then
  begin
    for i := 0 to F_Params.ShamKeyNo-1 do
      if lstAll.Items.Strings[i] <> ' ' then
        Exit;
    lstAll.Items.Strings[ActiveCtrl-1] := cmbs[ActiveCtrl].Text;
  end
  else
    lstAll.Items.Strings[ActiveCtrl-1] := cmbs[ActiveCtrl].Text;
end;

procedure TfrmSobhInf.cmb1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtAmar1.Visible then
      txtAmar1.SetFocus
    else
      cmb2.SetFocus;
  end;
end;

procedure TfrmSobhInf.txtAmar1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmb2.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSobhInf.cmb2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtAmar2.Visible then
      txtAmar2.SetFocus
    else
      cmb3.SetFocus;
  end;
end;

procedure TfrmSobhInf.txtAmar2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmb3.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSobhInf.cmb3KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtAmar3.Visible then
      txtAmar3.SetFocus
    else
      cmb4.SetFocus;
  end;
end;

procedure TfrmSobhInf.txtAmar3KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmb4.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSobhInf.cmb4KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtAmar4.Visible then
      txtAmar4.SetFocus
    else
      cmb5.SetFocus;
  end;
end;

procedure TfrmSobhInf.txtAmar4KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmb5.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSobhInf.cmb5KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtAmar5.Visible then
      txtAmar5.SetFocus
    else
      cmb6.SetFocus;
  end;
end;

procedure TfrmSobhInf.txtAmar5KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmb6.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSobhInf.cmb6KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtAmar6.Visible then
      txtAmar6.SetFocus
    else
      cmb7.SetFocus;
  end;
end;

procedure TfrmSobhInf.txtAmar6KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmb7.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSobhInf.cmb7KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtAmar7.Visible then
      txtAmar7.SetFocus
    else
      cmb8.SetFocus;
  end;
end;

procedure TfrmSobhInf.txtAmar7KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmb8.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSobhInf.cmb8KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtAmar8.Visible then
      txtAmar8.SetFocus
    else
      lstAll.SetFocus;
  end;
end;

procedure TfrmSobhInf.txtAmar8KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    lstAll.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSobhInf.lstAllKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    lstRejim.SetFocus;
  end;
end;

procedure TfrmSobhInf.lstAllKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
  begin
    Key := 0;
    cmdAddAllClick(Sender);
  end
  else if Key = 46 then
  begin
    Key := 0;
    cmdDelAllClick(Sender);
  end;
end;

procedure TfrmSobhInf.lstRejimKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmSobhInf.lstRejimKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
  begin
    Key := 0;
    cmdAddRejimClick(Sender);
  end
  else if Key = 46 then
  begin
    Key := 0;
    cmdDelRejimClick(Sender);
  end;
end;

procedure TfrmSobhInf.lstAllDblClick(Sender: TObject);
begin
  if lstAll.Items.Strings[lstAll.ItemIndex] <> ' ' then
    cmdDelAllClick(Sender)
  else
    cmdAddAllClick(Sender);
end;

procedure TfrmSobhInf.cmdAddAllClick(Sender: TObject);
var i : Byte;
begin
  if lstAll.ItemIndex in [0..7] then
  begin
    if (FoodType = MB_NAHAR) and (lstAll.ItemIndex+1 <= F_Params.NaharKeyNo) then
    begin
      for i := 0 to F_Params.NaharKeyNo-1 do
        if lstAll.Items.Strings[i] <> ' ' then
          Exit;
      lstAll.Items.Strings[lstAll.ItemIndex] := cmbs[lstAll.ItemIndex+1].Text;
    end
    else if (FoodType = MB_SHAM) and (lstAll.ItemIndex+1 <= F_Params.ShamKeyNo) then
    begin
      for i := 0 to F_Params.ShamKeyNo-1 do
        if lstAll.Items.Strings[i] <> ' ' then
          Exit;
      lstAll.Items.Strings[lstAll.ItemIndex] := cmbs[lstAll.ItemIndex+1].Text;
    end
    else
      lstAll.Items.Strings[lstAll.ItemIndex] := cmbs[lstAll.ItemIndex+1].Text;
  end;
end;

procedure TfrmSobhInf.cmdDelAllClick(Sender: TObject);
begin
  if lstAll.ItemIndex in [0..7] then
    lstAll.Items.Strings[lstAll.ItemIndex] := ' ';
end;

procedure TfrmSobhInf.lstRejimDblClick(Sender: TObject);
begin
  if lstRejim.Items.Strings[lstRejim.ItemIndex] <> ' ' then
    cmdDelRejimClick(Sender)
  else
    cmdAddRejimClick(Sender);
end;

procedure TfrmSobhInf.cmdAddRejimClick(Sender: TObject);
var i : Byte;
begin
  if lstRejim.ItemIndex in [0..7] then
  begin
    if (FoodType = MB_NAHAR) and (lstRejim.ItemIndex+1 <= F_Params.NaharKeyNo) then
    begin
      for i := 0 to F_Params.NaharKeyNo-1 do
        if lstRejim.Items.Strings[i] <> ' ' then
          Exit;
      lstRejim.Items.Strings[lstRejim.ItemIndex] := cmbs[lstRejim.ItemIndex+1].Text;
    end
    else if (FoodType = MB_SHAM) and (lstRejim.ItemIndex+1 <= F_Params.ShamKeyNo) then
    begin
      for i := 0 to F_Params.ShamKeyNo-1 do
        if lstRejim.Items.Strings[i] <> ' ' then
          Exit;
      lstRejim.Items.Strings[lstRejim.ItemIndex] := cmbs[lstRejim.ItemIndex+1].Text;
    end
    else
      lstRejim.Items.Strings[lstRejim.ItemIndex] := cmbs[lstRejim.ItemIndex+1].Text;
  end;
end;

procedure TfrmSobhInf.cmdDelRejimClick(Sender: TObject);
begin
  if lstRejim.ItemIndex in [0..7] then
    lstRejim.Items.Strings[lstRejim.ItemIndex] := ' ';
end;

procedure TfrmSobhInf.cmdAllClick(Sender: TObject);
var i : Byte;
begin
  for i := 1 to 8 do
  begin
    lstAll.Items.Strings[i-1] := cmbs[i].Text;
    lstRejim.Items.Strings[i-1] := cmbs[i].Text;
  end;
end;

procedure TfrmSobhInf.cmdNoneClick(Sender: TObject);
var i : Byte;
begin
  for i := 1 to 8 do
  begin
    lstAll.Items.Strings[i-1] := ' ';
    lstRejim.Items.Strings[i-1] := ' ';
  end;
end;

procedure TfrmSobhInf.cmdSaveClick(Sender: TObject);
var
  qry : TAdoQuery;
  i : Byte;
  k : Integer;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('DELETE FROM Week WHERE Week_Date = ''' + lblDate.Caption + '''');
  qry.SQL.Add('AND Week_Type = ' + IntToStr(FoodType));
  qry.ExecSQL;

  if AreControlsValid then
  begin
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM Week');
    qry.Open;
    qry.Append;
    qry.FieldByName('Week_Date').AsString := lblDate.Caption;
    qry.FieldByName('Week_Type').AsInteger := FoodType;
    for i := 1 to 8 do
    begin
      qry.FieldByName('Week_Key'+IntToStr(i)).AsInteger := GetFoodCodeInRam(cmbs[i].Text);
      if txts[i].Visible and (txts[i].Text <> '') then
        qry.FieldByName('Week_N'+IntToStr(i)).AsInteger := StrToInt(txts[i].Text)
      else if txts[i].Visible and (txts[i].Text = '') then
        qry.FieldByName('Week_N'+IntToStr(i)).AsInteger := 0
      else if not txts[i].Visible then
        qry.FieldByName('Week_N'+IntToStr(i)).AsInteger := 32500;
    end;
    k := 0;
    for i := 1 to 8 do
      if lstAll.Items.Strings[i-1] <> ' ' then
        k := k + Pow2(i);
    qry.FieldByName('Week_Key9').AsInteger := k;
    k := 0;
    for i := 1 to 8 do
      if lstRejim.Items.Strings[i-1] <> ' ' then
        k := k + Pow2(i);
    qry.FieldByName('Week_Key0').AsInteger := k;
    qry.Post;
    qry.Close;
    InformationMessage('»—‰«„Â —Ì“Ì „Ê—œ ‰Ÿ— À»  ‘œ.');
  end;
  qry.Free;
end;

procedure TfrmSobhInf.cmdNextClick(Sender: TObject);
begin
  lblDate.Caption := AddDate(lblDate.Caption, 1);
  FillDayProg;
end;

procedure TfrmSobhInf.cmdPriorClick(Sender: TObject);
begin
  lblDate.Caption := AddDate(lblDate.Caption, -1);
  FillDayProg;
end;

end.
