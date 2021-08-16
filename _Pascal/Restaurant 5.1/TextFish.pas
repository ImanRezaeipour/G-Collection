unit TextFish;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls;

type
  TfrmTextFish = class(TForm)
    Label1: TLabel;
    txtFromDate: TEdit;
    Label2: TLabel;
    txtToDate: TEdit;
    Label3: TLabel;
    cmbRptType: TComboBox;
    lstFields: TListBox;
    Label4: TLabel;
    txtFileName: TEdit;
    Label5: TLabel;
    cmbFonts: TComboBox;
    Label6: TLabel;
    txtCode: TEdit;
    Label7: TLabel;
    txtMap: TEdit;
    cmdRun: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    Label8: TLabel;
    chkTitle: TCheckBox;
    cmdAll: TBitBtn;
    cmdDel: TBitBtn;
    prgBar: TProgressBar;
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbRptTypeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cmbRptTypeClick(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdRunClick(Sender: TObject);
    procedure txtCodeChange(Sender: TObject);
    procedure txtMapChange(Sender: TObject);
    procedure cmdAllClick(Sender: TObject);
    procedure cmdDelClick(Sender: TObject);
    procedure lstFieldsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FldNames : array[0..8] of String;
    MaxFld : Byte;

    procedure SendTab(var Key : Char);
    procedure ListBoxFieldSet;

    procedure CreateAllTextFile;
    procedure CreateAllVadehTextFile;
    procedure CreateAllDayTextFile;
    procedure CreateTafsiliTextFile;
    procedure CreateAllTextPerson;
    procedure CreateAllAmarRiali; //kaveh
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

uses
  AdoDB, MSGs, Keyboard, DateProc, Globals, Code_Sys, DBS_Proc;


{$R *.DFM}

procedure TfrmTextFish.SetWinF;
var i : byte;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label7.Caption := (Label7.Caption);
  Label8.Caption := (Label8.Caption);
  chkTitle.Caption := (chkTitle.Caption);
  cmdAll.Caption := (cmdAll.Caption);
  cmdDel.Caption := (cmdDel.Caption);
  cmdRun.Caption := (cmdRun.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  for i := 0 to cmbFonts.Items.Count - 1 do
    cmbFonts.Items.Strings[i] := (cmbFonts.Items.Strings[i]);
  for i := 0 to cmbRptType.Items.Count -1 do
    cmbRptType.Items.Strings[i] := (cmbRptType.Items.Strings[i]);    
end;

procedure TfrmTextFish.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmTextFish.ListBoxFieldSet;
var i : Byte;
begin
  lstFields.Clear;
  case cmbRptType.ItemIndex of
    0:
    begin
      lstFields.Items.Add('شماره پرسنلي');
      lstFields.Items.Add('مبلغ هزينه شده');
      lstFields.Items.Add('مبلغ پرداخت شده');
      lstFields.Items.Add('تعداد فيشها');
      FldNames[0] := 'Fish_PCode';
      FldNames[1] := 'Prc';
      FldNames[2] := 'Pay';
      FldNames[3] := 'C';
      MaxFld := 3
    end;

    1:
    begin
      lstFields.Items.Add('شماره پرسنلي');
      lstFields.Items.Add('وعده غذايي');
      lstFields.Items.Add('مبلغ هزينه شده');
      lstFields.Items.Add('مبلغ پرداخت شده');
      lstFields.Items.Add('تعداد فيشها');
      FldNames[0] := 'Fish_PCode';
      FldNames[1] := 'FF_Type';
      FldNames[2] := 'Prc';
      FldNames[3] := 'Pay';
      FldNames[4] := 'C';
      MaxFld := 4;
    end;

    2:
    begin
      lstFields.Items.Add('شماره پرسنلي');
      lstFields.Items.Add('تاريخ');
      lstFields.Items.Add('وعده غذايي');
      lstFields.Items.Add('مبلغ هزينه شده');
      lstFields.Items.Add('مبلغ پرداخت شده');
      lstFields.Items.Add('تعداد فيشها');
      FldNames[0] := 'Fish_PCode';
      FldNames[1] := 'FF_Date';
      FldNames[2] := 'FF_Type';
      FldNames[3] := 'Prc';
      FldNames[4] := 'Pay';
      FldNames[5] := 'C';
      MaxFld := 5;
    end;

    3:
    begin
      lstFields.Items.Add('شماره پرسنلي');
      lstFields.Items.Add('تاريخ');
      lstFields.Items.Add('ساعت');
      lstFields.Items.Add('وعده غذايي');
      lstFields.Items.Add('كد غذا');
      lstFields.Items.Add('مبلغ هزينه شده');
      lstFields.Items.Add('مبلغ پرداخت شده');
      FldNames[0] := 'Fish_PCode';
      FldNames[1] := 'FF_Date';
      FldNames[2] := 'Fish_Time';
      FldNames[3] := 'FF_Type';
      FldNames[4] := 'FF_Food';
      FldNames[5] := 'FF_Price';
      FldNames[6] := 'FF_Pay';
      MaxFld := 6;
    end;

    4:
    begin
      lstFields.Items.Add('شماره پرسنلي');
      lstFields.Items.Add('نام');
      lstFields.Items.Add('نام خانوادگي');
      lstFields.Items.Add('نوع استخدام');
      lstFields.Items.Add('بخش');
      lstFields.Items.Add('ميهمان/عادي');
      lstFields.Items.Add('مبلغ هزينه شده');
      lstFields.Items.Add('مبلغ پرداخت شده');
      lstFields.Items.Add('تعداد فيشها');
      FldNames[0] := 'Fish_PCode';
      FldNames[1] := 'P_Name';
      FldNames[2] := 'P_Family';
      FldNames[3] := 'Job_Name';
      FldNames[4] := 'Part_Name';
      FldNames[5] := 'P_IsGuest';
      FldNames[6] := 'Prc';
      FldNames[7] := 'Pay';
      FldNames[8] := 'C';
      MaxFld := 8;
    end;
//kaveh is
    5:
    begin
      lstFields.Items.Add('ردیف');
      lstFields.Items.Add('شماره پرسنلي');
      lstFields.Items.Add('نام');
      lstFields.Items.Add('مرکز هزینه');
      lstFields.Items.Add('جمع');

      FldNames[0] := 'row';
      FldNames[1] := 'Fish_PCode';
      FldNames[2] := 'Name';
//      FldNames[2] := 'P_Family';
      FldNames[3] := 'Station';
      FldNames[4] := 'Prc';
      MaxFld := 4;
    end;
//kaveh ie

  end;

  for i := 0 to lstFields.Items.Count-1 do
    lstFields.Items.Strings[i] := (lstFields.Items.Strings[i]);
end;

procedure TfrmTextFish.CreateAllTextFile;
var
  qry, qry1 : TAdoQuery;
  fp : TextFile;
  s : String;
  i : Byte;
begin
  Mouse_Wait;
  MSG_Wait('در حال ايجاد فايل متني...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry1 := TAdoQuery.Create(Application);
  qry1.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Fish_PCode, SUM(FF_Price * FF_No) AS Prc, SUM(FF_Pay * FF_No) AS Pay FROM Fish, FishFood');
  qry.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
  if txtFromDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
  if txtToDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

  qry.SQL.Add('GROUP BY Fish_PCode');
  qry.Open;
  AssignFile(fp, txtFileName.Text);
  ReWrite(fp);

  if chkTitle.Checked then
  begin
    s := '';
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if cmbFonts.ItemIndex > 1 then
        s := s + StrRev(ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1)) + txtMap.Text
      else
        s := ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1) + txtMap.Text + s;
    end;
    WriteLn(fp, s);
  end;

  prgBar.Max := qry.RecordCount;
  while not qry.Eof do
  begin
    prgBar.Position := prgBar.Position + 1;
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if FldNames[i] = 'C' then
      begin
        qry1.SQL.Clear;
        qry1.SQL.Add('SELECT COUNT(Fish_No) AS C FROM Fish');
        qry1.SQL.Add('WHERE Fish_PCode = ''' + qry.FieldByName('Fish_PCode').AsString + '''');
        if txtFromDate.Text <> '' then
          qry1.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qry1.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');
        qry1.Open;
        Write(fp, qry1.FieldByName('C').AsString, txtMap.Text);
        qry1.Close;
      end
      else
      begin
        s := ChangeFromWin(qry.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);
        Write(fp, s, txtMap.Text)
      end;
    end;

    WriteLn(fp);
    qry.Next;
  end;
  qry.Close;
  CloseFile(fp);
  qry.Free;
  qry1.Free;
  Mouse_NoWait;
  Msg_NoWait;
end;

procedure TfrmTextFish.CreateAllVadehTextFile;
var
  qry, qry1 : TAdoQuery;
  fp : TextFile;
  s : String;
  i : Byte;
begin
  Mouse_Wait;
  MSG_Wait('در حال ايجاد فايل متني...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry1 := TAdoQuery.Create(Application);
  qry1.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Fish_PCode, FF_Type, SUM(FF_Price * FF_No) AS Prc, SUM(FF_Pay * FF_No) AS Pay FROM Fish, FishFood');
  qry.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
  if txtFromDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
  if txtToDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

  qry.SQL.Add('GROUP BY FF_Type, Fish_PCode');
  qry.Open;
  AssignFile(fp, txtFileName.Text);
  ReWrite(fp);
  if chkTitle.Checked then
  begin
    s := '';
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if cmbFonts.ItemIndex > 1 then
        s := s + StrRev(ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1)) + txtMap.Text
      else
        s := ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1) + txtMap.Text + s;
    end;
    WriteLn(fp, s);
  end;

  prgBar.Max := qry.RecordCount;
  while not qry.Eof do
  begin
    prgBar.Position := prgBar.Position + 1;
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if FldNames[i] = 'C' then
      begin
        qry1.SQL.Clear;
        qry1.SQL.Add('SELECT COUNT(Fish_No) AS C FROM Fish');
        qry1.SQL.Add('WHERE Fish_PCode = ''' + qry.FieldByName('Fish_PCode').AsString + '''');
        qry1.SQL.Add('AND Fish_Type = ' + qry.FieldByName('FF_Type').AsString);
        if txtFromDate.Text <> '' then
          qry1.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qry1.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');
        qry1.Open;
        Write(fp, qry1.FieldByName('C').AsString, txtMap.Text);
        qry1.Close;
      end
      else
      begin
        if FldNames[i] = 'FF_Type' then
        begin
          if cmbFonts.ItemIndex > 1 then
            s := StrRev(ChangeFromWin(FoodName[qry.FieldByName(FldNames[i]).AsInteger], g_options.WinType, cmbFonts.ItemIndex+1))
          else
            s := ChangeFromWin(FoodName[qry.FieldByName(FldNames[i]).AsInteger], g_options.WinType, cmbFonts.ItemIndex+1);
        end
        else
          s := ChangeFromWin(qry.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);

        Write(fp, s, txtMap.Text);
      end;
    end;

    WriteLn(fp);
    qry.Next;
  end;
  qry.Close;
  CloseFile(fp);
  qry.Free;
  qry1.Free;
  Mouse_NoWait;
  Msg_NoWait;
end;

procedure TfrmTextFish.CreateAllDayTextFile;
var
  qry, qry1 : TAdoQuery;
  fp : TextFile;
  s : String;
  i : Byte;
begin
  Mouse_Wait;
  MSG_Wait('در حال ايجاد فايل متني...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry1 := TAdoQuery.Create(Application);
  qry1.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Fish_PCode, FF_Date, FF_Type, SUM(FF_Price * FF_No) AS Prc, SUM(FF_Pay * FF_No) AS Pay FROM Fish, FishFood');
  qry.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
  if txtFromDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
  if txtToDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

  qry.SQL.Add('GROUP BY FF_Date, FF_Type, Fish_PCode');
  qry.Open;
  AssignFile(fp, txtFileName.Text);
  ReWrite(fp);
  if chkTitle.Checked then
  begin
    s := '';
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if cmbFonts.ItemIndex > 1 then
        s := s + StrRev(ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1)) + txtMap.Text
      else
        s := ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1) + txtMap.Text + s;
    end;
    WriteLn(fp, s);
  end;

  prgBar.Max;
  while not qry.Eof do
  begin
    prgBar.Position := prgBar.Position + 1;
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if FldNames[i] = 'C' then
      begin
        qry1.SQL.Clear;
        qry1.SQL.Add('SELECT COUNT(Fish_No) AS C FROM Fish');
        qry1.SQL.Add('WHERE Fish_PCode = ''' + qry.FieldByName('Fish_PCode').AsString + '''');
        qry1.SQL.Add('AND Fish_Type = ' + qry.FieldByName('FF_Type').AsString);
        qry1.SQL.Add('AND Fish_Date = ''' + qry.FieldByName('FF_Date').AsString + '''');
        if txtFromDate.Text <> '' then
          qry1.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qry1.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');
        qry1.Open;
        Write(fp, qry1.FieldByName('C').AsString, txtMap.Text);
        qry1.Close;
      end
      else
      begin
        if FldNames[i] = 'FF_Type' then
        begin
          if cmbFonts.ItemIndex > 1 then
            s := StrRev(ChangeFromWin(FoodName[qry.FieldByName(FldNames[i]).AsInteger], g_options.WinType, cmbFonts.ItemIndex+1))
          else
            s := ChangeFromWin(FoodName[qry.FieldByName(FldNames[i]).AsInteger], g_options.WinType, cmbFonts.ItemIndex+1);
        end
        else
          s := ChangeFromWin(qry.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);

        Write(fp, s, txtMap.Text);
      end;
    end;

    WriteLn(fp);
    qry.Next;
  end;
  qry.Close;
  CloseFile(fp);
  qry.Free;
  qry1.Free;
  Mouse_NoWait;
  Msg_NoWait;
end;

procedure TfrmTextFish.CreateTafsiliTextFile;
var
  qry : TAdoQuery;
  fp : TextFile;
  s : String;
  i : Byte;
begin
  Mouse_Wait;
  MSG_Wait('در حال ايجاد فايل متني...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Fish_PCode, Fish_Time, FishFood.* FROM Fish, FishFood');
  qry.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
  if txtFromDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
  if txtToDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

  qry.SQL.Add('ORDER BY FF_Date, FF_Type, Fish_PCode, Fish_Time');
  qry.Open;
  AssignFile(fp, txtFileName.Text);
  ReWrite(fp);
  if chkTitle.Checked then
  begin
    s := '';
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if cmbFonts.ItemIndex > 1 then
        s := s + StrRev(ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1)) + txtMap.Text
      else
        s := ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1) + txtMap.Text + s;
    end;
    WriteLn(fp, s);
  end;

  prgBar.Max := qry.RecordCount;
  while not qry.Eof do
  begin
    prgBar.Position := prgBar.Position + 1;
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if FldNames[i] = 'FF_Type' then
      begin
        if cmbFonts.ItemIndex > 1 then
          s := StrRev(ChangeFromWin(FoodName[qry.FieldByName(FldNames[i]).AsInteger], g_options.WinType, cmbFonts.ItemIndex+1))
        else
          s := ChangeFromWin(FoodName[qry.FieldByName(FldNames[i]).AsInteger], g_options.WinType, cmbFonts.ItemIndex+1);
      end
      else if (FldNames[i] = 'FF_Price') or (FldNames[i] = 'FF_Pay') then
        s := ChangeFromWin(IntToStr(qry.FieldByName(FldNames[i]).AsInteger * qry.FieldByName('FF_No').AsInteger), g_options.WinType, cmbFonts.ItemIndex+1)
      else
        s := ChangeFromWin(qry.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);

      Write(fp, s, txtMap.Text);
    end;

    WriteLn(fp);
    qry.Next;
  end;
  qry.Close;
  CloseFile(fp);
  qry.Free;
  Mouse_NoWait;
  Msg_NoWait;
end;

procedure TfrmTextFish.CreateAllTextPerson;
var
  qry, qry1, qryP : TAdoQuery;
  fp : TextFile;
  s : String;
  i : Byte;
begin
  Mouse_Wait;
  MSG_Wait('در حال ايجاد فايل متني...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry1 := TAdoQuery.Create(Application);
  qry1.connection := frmDBS.DBConnection;
  qryP := TAdoQuery.Create(Application);
  qryP.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Fish_PCode, SUM(FF_Price * FF_No) AS Prc, SUM(FF_Pay * FF_No) AS Pay FROM Fish, FishFood');
  qry.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
  if txtFromDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
  if txtToDate.Text <> '' then
    qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

  qry.SQL.Add('GROUP BY Fish_PCode');
  qry.Open;
  AssignFile(fp, txtFileName.Text);
  ReWrite(fp);

  if chkTitle.Checked then
  begin
    s := '';
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if cmbFonts.ItemIndex > 1 then
        s := s + StrRev(ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1)) + txtMap.Text
      else
        s := ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1) + txtMap.Text + s;
    end;
    WriteLn(fp, s);
  end;

  prgBar.Max := qry.RecordCount;
  while not qry.Eof do
  begin
    prgBar.Position := prgBar.Position + 1;
    qryP.SQL.Clear;
    qryP.SQL.Add('SELECT * FROM Persons WHERE P_BarCode = ''' + qry.FieldByName('Fish_PCode').AsString + '''');
    qryP.Open;
    for i := 0 to lstFields.Items.Count-1 do
    begin
      if FldNames[i] = 'C' then
      begin
        qry1.SQL.Clear;
        qry1.SQL.Add('SELECT COUNT(Fish_No) AS C FROM Fish');
        qry1.SQL.Add('WHERE Fish_PCode = ''' + qry.FieldByName('Fish_PCode').AsString + '''');
        if txtFromDate.Text <> '' then
          qry1.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qry1.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');
        qry1.Open;
        Write(fp, qry1.FieldByName('C').AsString, txtMap.Text);
        qry1.Close;
      end
      else if (FldNames[i] = 'P_Name') or
              (FldNames[i] = 'P_Family') then
      begin
        s := ChangeFromWin(qryP.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);
        if cmbFonts.ItemIndex > 1 then
          s := StrRev(s);
        Write(fp, s, txtMap.Text)
      end
      else if (FldNames[i] = 'P_IsGuest') then
      begin
        if qryP.FieldByName(FldNames[i]).AsBoolean then
          s := ChangeFromWin(('ميهمان'), g_options.WinType, cmbFonts.ItemIndex+1)
        else
          s := ChangeFromWin(('پرسنل'), g_options.WinType, cmbFonts.ItemIndex+1);
        if cmbFonts.ItemIndex > 1 then
          s := StrRev(s);
        Write(fp, s, txtMap.Text)
      end
      else if (FldNames[i] = 'Part_Name') then
      begin
        qry1.SQL.Clear;
        qry1.SQL.Add('SELECT Part_Name FROM Parts');
        qry1.Open;
        s := ChangeFromWin(qry1.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);
        if cmbFonts.ItemIndex > 1 then
          s := StrRev(s);
        Write(fp, s, txtMap.Text);
        qry1.Close;
      end
      else if (FldNames[i] = 'Job_Name') then
      begin
        qry1.SQL.Clear;
        qry1.SQL.Add('SELECT Job_Name FROM JobType');
        qry1.Open;
        s := ChangeFromWin(qry1.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);
        if cmbFonts.ItemIndex > 1 then
          s := StrRev(s);
        Write(fp, s, txtMap.Text);
        qry1.Close;
      end
      else
      begin
        s := ChangeFromWin(qry.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);
        Write(fp, s, txtMap.Text)
      end;
    end;

    WriteLn(fp);
    qry.Next;
    qryP.Close;
  end;
  qry.Close;
  CloseFile(fp);
  qry.Free;
  qry1.Free;
  Mouse_NoWait;
  Msg_NoWait;
end;

//kaveh is
procedure TfrmTextFish.CreateAllAmarRiali;
var
  qry, qry1, qryP : TAdoQuery;
  fp : TextFile;
  s : String;
  i : Byte;
begin
  Mouse_Wait;
  MSG_Wait('در حال ايجاد فايل متني...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry1 := TAdoQuery.Create(Application);
  qry1.connection := frmDBS.DBConnection;
  qryP := TAdoQuery.Create(Application);
  qryP.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT RANK() over(order by Fish_PCode, R_Station) as row, Fish_PCode, SUM(FF_Price * FF_No) AS Prc, ISNULL(R_Station, 0) as Station'); //kaveh
  qry.SQL.Add(' FROM readers RIGHT OUTER JOIN'); //kaveh
  qry.SQL.Add(' fish INNER JOIN'); //kaveh
  qry.SQL.Add(' fishfood ON Fish_Date = FF_Date AND Fish_Type = FF_Type AND'); //kaveh
  qry.SQL.Add(' Fish_No = FF_FishNo ON R_Code = Fish_RdrCode'); //kaveh
  qry.SQL.Add(' WHERE 1=1'); //kaveh
//kaveh  qry.SQL.Add('SELECT Fish_PCode, SUM(FF_Price * FF_No) AS Prc, SUM(FF_Pay * FF_No) AS Pay FROM Fish, FishFood');
//kaveh  qry.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
  if txtFromDate.Text <> '' then
    qry.SQL.Add(' AND Fish_Date >= ''' + txtFromDate.Text + '''');
  if txtToDate.Text <> '' then
    qry.SQL.Add(' AND Fish_Date <= ''' + txtToDate.Text + '''');
//kaveh  qry.SQL.Add('GROUP BY Fish_PCode');
  qry.SQL.Add(' GROUP BY Fish_PCode, R_Station'); //kaveh
  qry.Open;
  AssignFile(fp, txtFileName.Text);
  ReWrite(fp);

  if chkTitle.Checked then
  begin
    s := '';
//kaveh    for i := 0 to lstFields.Items.Count-1 do
    for i := lstFields.Items.Count-1 downto 0 do
    begin
      if cmbFonts.ItemIndex > 1 then
        s := s + StrRev(ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1)) + txtMap.Text
      else
        s := ChangeFromWin(lstFields.Items.Strings[i], g_options.WinType, cmbFonts.ItemIndex+1) + txtMap.Text + s;
    end;
    WriteLn(fp, s);
  end;
//      FldNames[0] := 'row';
//      FldNames[1] := 'Fish_PCode';
//      FldNames[2] := 'Name';
////      FldNames[2] := 'P_Family';
//      FldNames[3] := 'Station';
//      FldNames[4] := 'Prc';
  prgBar.Max := qry.RecordCount;
  while not qry.Eof do
  begin
    prgBar.Position := prgBar.Position + 1;
    qryP.SQL.Clear;
    qryP.SQL.Add('SELECT * FROM Persons WHERE P_BarCode = ''' + qry.FieldByName('Fish_PCode').AsString + '''');
    qryP.Open;
    for i := 0 to lstFields.Items.Count-1 do
    begin
//      if FldNames[i] = 'C' then
//      begin
//        qry1.SQL.Clear;
//        qry1.SQL.Add('SELECT COUNT(Fish_No) AS C FROM Fish');
//        qry1.SQL.Add('WHERE Fish_PCode = ''' + qry.FieldByName('Fish_PCode').AsString + '''');
//        if txtFromDate.Text <> '' then
//          qry1.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
//        if txtToDate.Text <> '' then
//          qry1.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');
//        qry1.Open;
//        Write(fp, qry1.FieldByName('C').AsString, txtMap.Text);
//        qry1.Close;
//      end
//      else
      if (FldNames[i] = 'Name') then
//       or (FldNames[i] = 'P_Family') then
      begin
        s := ChangeFromWin(qryP.FieldByName('P_Name').AsString + ' ' + qryP.FieldByName('P_Family').AsString, g_options.WinType, cmbFonts.ItemIndex+1);
        if cmbFonts.ItemIndex > 1 then
          s := StrRev(s);
        Write(fp, s, txtMap.Text)
      end
//      else if (FldNames[i] = 'P_IsGuest') then
//      begin
//        if qryP.FieldByName(FldNames[i]).AsBoolean then
//          s := ChangeFromWin(('ميهمان'), g_options.WinType, cmbFonts.ItemIndex+1)
//        else
//          s := ChangeFromWin(('پرسنل'), g_options.WinType, cmbFonts.ItemIndex+1);
//        if cmbFonts.ItemIndex > 1 then
//          s := StrRev(s);
//        Write(fp, s, txtMap.Text)
//      end
//      else if (FldNames[i] = 'Part_Name') then
//      begin
//        qry1.SQL.Clear;
//        qry1.SQL.Add('SELECT Part_Name FROM Parts');
//        qry1.Open;
//        s := ChangeFromWin(qry1.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);
//        if cmbFonts.ItemIndex > 1 then
//          s := StrRev(s);
//        Write(fp, s, txtMap.Text);
//        qry1.Close;
//      end
//      else if (FldNames[i] = 'Job_Name') then
//      begin
//        qry1.SQL.Clear;
//        qry1.SQL.Add('SELECT Job_Name FROM JobType');
//        qry1.Open;
//        s := ChangeFromWin(qry1.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);
//        if cmbFonts.ItemIndex > 1 then
//          s := StrRev(s);
//        Write(fp, s, txtMap.Text);
//        qry1.Close;
//      end
      else
      begin
        s := ChangeFromWin(qry.FieldByName(FldNames[i]).AsString, g_options.WinType, cmbFonts.ItemIndex+1);
        Write(fp, s, txtMap.Text)
      end;
    end;

    WriteLn(fp);
    qry.Next;
    qryP.Close;
  end;
  qry.Close;
  CloseFile(fp);
  qry.Free;
  qry1.Free;
  Mouse_NoWait;
  Msg_NoWait;
end;
//kaveh ie

procedure TfrmTextFish.FormCreate(Sender: TObject);
begin
  cmbRptType.ItemIndex := 0;
  cmbFonts.ItemIndex := 0;
  ListBoxFieldSet;
  SetWinF;
  cmbRptType.ItemIndex := 0;
  cmbFonts.ItemIndex := 0;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;
{$ifdef BankMarkazi}
  txtFileName.Text := 'c:\AmarRiali.csv';
  chkTitle.Checked := True;
  txtMap.Text := ';';
  cmbFonts.ItemIndex := 1;
  cmbRptType.ItemIndex := 5;
  ListBoxFieldSet;
{$endif BankMarkazi}
end;

procedure TfrmTextFish.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmTextFish.txtFromDateExit(Sender: TObject);
begin
  with txtFromDate do
  begin
    if Text <> '' then
      Text := BeautifulDate(Text);
    g_options.RptFDate := Text;
  end;
end;

procedure TfrmTextFish.txtToDateExit(Sender: TObject);
begin
  with txtToDate do
  begin
    if Text <> '' then
      Text := BeautifulDate(Text);
    g_options.RptTDate := Text
  end;
end;

procedure TfrmTextFish.cmbRptTypeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmTextFish.cmdAllClick(Sender: TObject);
begin
  ListBoxFieldSet;
end;

procedure TfrmTextFish.cmdDelClick(Sender: TObject);
var i : Byte;
begin
  if (lstFields.Items.Count > 0) and (lstFields.ItemIndex > -1) then
  begin
    for i := lstFields.ItemIndex to MaxFld-1 do
      FldNames[i] := FldNames[i+1];
    FldNames[MaxFld] := '';
    lstFields.Items.Delete(lstFields.ItemIndex);
  end;
end;

procedure TfrmTextFish.lstFieldsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmdDelClick(Sender);
  end;
end;

procedure TfrmTextFish.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key)
end;

procedure TfrmTextFish.cmbRptTypeClick(Sender: TObject);
begin
  ListBoxFieldSet;
end;

procedure TfrmTextFish.txtCodeChange(Sender: TObject);
begin
  if txtCode.Text <> '' then
    txtMap.Text := Chr(StrToInt(txtCode.Text))
  else
    txtMap.Text := '';
end;

procedure TfrmTextFish.txtMapChange(Sender: TObject);
var c : Char;
begin
  if txtMap.Text <> '' then
    c := txtMap.Text[1]
  else
    c := #0;

  txtCode.Text := IntToStr(Ord(c));
end;

procedure TfrmTextFish.cmdRunClick(Sender: TObject);
begin
  if cmbRptType.Text = '' then
  begin
    ErrorMessage('نوع گزارش مشخص نيست.');
    cmbRptType.SetFocus;
  end
  else if lstFields.Items.Count = 0 then
  begin
    ErrorMessage('فيلدهاي گزارش وجود ندارد.');
    lstFields.SetFocus;
  end
  else if txtFileName.Text = '' then
  begin
    ErrorMessage('نام فايل مشخص نشده است.');
    txtFileName.SetFocus;
  end
  else if cmbFonts.Text = '' then
  begin
    ErrorMessage('سيستم فونت مشخص نشده است.');
    cmbFonts.SetFocus;
  end
  else if txtCode.Text = '' then
  begin
    ErrorMessage('جدا ساز فيلدها مشخص نشده است.');
    txtCode.SetFocus;
  end
  else
  begin
    prgBar.Position := 0;
    case cmbRptType.ItemIndex of
      0: CreateAllTextFile;
      1: CreateAllVadehTextFile;
      2: CreateAllDayTextFile;
      3: CreateTafsiliTextFile;
      4: CreateAllTextPerson;
      5: CreateAllAmarRiali;
    end;
  end;
end;

end.
