unit Fish;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, Printers, Globals, MSGs, DateProc, DBS_Proc, Keyboard,
  DB, ADODB, ComCtrls, StrUtils;

type
  TfrmPersonFish = class(TForm)
    lbl03: TLabel;
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
    lbl01: TLabel;
    cmdSave: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    tmrTime: TTimer;
    pnlType: TPanel;
    txtDate: TEdit;
    grpPrn: TGroupBox;
    lbl05: TLabel;
    lbl04: TLabel;
    txtLineFeed: TEdit;
    cmbPrinters: TComboBox;
    cmdInitPrn: TBitBtn;
    cmdPrnFarsi: TBitBtn;
    chkPrintFish: TCheckBox;
    cmbPCode: TComboBox;
    lbl06: TLabel;
    txtFishMany: TEdit;
    txtPrint: TRichEdit;
    lbl02: TLabel;
    txtTime: TEdit;
    rdoVadeh: TRadioGroup;
    chkReadOnline: TCheckBox;
    GroupBox1: TGroupBox;
    lblHelp: TLabel;
    Label2: TLabel;
    cmbRdrName: TComboBox;
    cmdStartRead: TBitBtn;
    cmdStopRead: TBitBtn;
    qryReaders: TADOQuery;
    tmrReadOnline: TTimer;
    cmbRdrCode: TComboBox;
    cmdReadNext: TBitBtn;
    lbl1_2: TLabel;
    lbl3_2: TLabel;
    lbl2_2: TLabel;
    lbl4_2: TLabel;
    lbl5_2: TLabel;
    lbl7_2: TLabel;
    lbl6_2: TLabel;
    lbl8_2: TLabel;
    cmdDel: TButton;
    qry: TADOQuery;
    lbl1count: TLabel;
    lbl3count: TLabel;
    lbl5count: TLabel;
    lbl7count: TLabel;
    lbl8count: TLabel;
    lbl6count: TLabel;
    lbl4count: TLabel;
    lbl2count: TLabel;
    Shape1: TShape;
    imgPicture: TImage;
    procedure FormCreate(Sender: TObject);
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
    procedure cmdInitPrnClick(Sender: TObject);
    procedure chkPrintFishClick(Sender: TObject);
    procedure cmbPrintersClick(Sender: TObject);
    procedure cmdPrnFarsiClick(Sender: TObject);
    procedure txtLineFeedKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPCodeExit(Sender: TObject);
    procedure cmbPCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtFishManyKeyPress(Sender: TObject; var Key: Char);
    procedure rdoVadehClick(Sender: TObject);
    procedure chkReadOnlineClick(Sender: TObject);
    procedure cmdStartReadClick(Sender: TObject);
    procedure cmdStopReadClick(Sender: TObject);
    procedure tmrReadOnlineTimer(Sender: TObject);
    procedure cmbRdrNameChange(Sender: TObject);
    procedure cmdReadNextClick(Sender: TObject);
    procedure cmdDelClick(Sender: TObject);
  private
    { Private declarations }
    lbls : array[1..8] of TLabel;
    lbls_2 : array[1..8] of TLabel; //kaveh
    Keys : array[1..8] of Boolean;
    PersonFish : TFish;
    code_food:integer;
    readOnlineStarted : Boolean; //kaveh
    DTTM4ReadOnline : string; //kaveh
    iRdrCode : integer; //kaveh
    GuestOnly4Fish : Boolean; //kaveh

//kaveh    DTTM4ReadOnlineSec : Integer; //kaveh
    procedure ClearFields;
    procedure SetFields;
    procedure SetFields_2;
    procedure PrintFish(p : TPerson);
    procedure FishPrntForm(var ST : String; DblWidth, Clr : Boolean);
    Procedure SetVadeh;
  public
    { Public declarations }
  end;
var
  rdrReadOnline : TReaders;
  
implementation

uses
  PrnDevic, Code_Sys, FishLst, ComTools, BioStation;

{$R *.DFM}

procedure TfrmPersonFish.ClearFields;
var i : Byte;
begin
  for i := 1 to 8 do
  begin
    PersonFish.Fish_Foods[i] := 0;
    lbls[i].Caption := '';
  end;
  cmbPCode.Text := '';
  pnlType.Caption := '';
  imgPicture.Picture.Bitmap := nil; //kaveh
  txtFishMany.Text := '';
  PersonFish.Keys := 0;
  PersonFish.Fish_RdrCode:=0;
  for i := 1 to 8 do Keys[i] := False;
{$ifdef OperatorBase}
//kaveh {$ifndef Bank MarkaziVis}
//kaveh   cmbPCode.Enabled := False;
//kaveh   lbl06.Enabled := False;
//kaveh   txtFishMany.Enabled := False;
  lbl06.Visible := False;
  txtFishMany.Visible := False;
  txtDate.ReadOnly := True;
  txtTime.ReadOnly := True;
//kaveh {$endif Bank MarkaziVis}
  lbl1count.Caption := '0';
  lbl2count.Caption := '0';
  lbl3count.Caption := '0';
  lbl4count.Caption := '0';
  lbl5count.Caption := '0';
  lbl6count.Caption := '0';
  lbl7count.Caption := '0';
  lbl8count.Caption := '0';
{$endif OperatorBase}

end;

procedure TfrmPersonFish.SetFields;
var i : Byte;
begin
  for i := 1 to 8 do
  begin
    lbls[i].Caption := GetFoodNameInRam(PersonFish.Fish_Foods[i]);
    SetFields_2;
  end;
{ $ifdef Bank Markazi}
//  if lbl1.Caption = '' then begin {lbl1count.Visible := False;} lbl1count.Caption := '0'; end else lbl1count.Visible := True;
//  if lbl2.Caption = '' then begin {lbl2count.Visible := False;} lbl2count.Caption := '0'; end else lbl2count.Visible := True;
//  if lbl3.Caption = '' then begin {lbl3count.Visible := False;} lbl3count.Caption := '0'; end else lbl3count.Visible := True;
//  if lbl4.Caption = '' then begin {lbl4count.Visible := False;} lbl4count.Caption := '0'; end else lbl4count.Visible := True;
//  if lbl5.Caption = '' then begin {lbl5count.Visible := False;} lbl5count.Caption := '0'; end else lbl5count.Visible := True;
//  if lbl6.Caption = '' then begin {lbl6count.Visible := False;} lbl6count.Caption := '0'; end else lbl6count.Visible := True;
//  if lbl7.Caption = '' then begin {lbl7count.Visible := False;} lbl7count.Caption := '0'; end else lbl7count.Visible := True;
//  if lbl8.Caption = '' then begin {lbl8count.Visible := False;} lbl8count.Caption := '0'; end else lbl8count.Visible := True;
{ $endif Bank Markazi}
end;

//kaveh is
procedure TfrmPersonFish.SetFields_2;
var i : Byte;
begin
  for i := 1 to 8 do
    if lbls[i].Caption <> '' then
      lbls_2[i].Caption := lbls[i].Caption;
  if lbl1_2.Caption = 'Lable Foods' then lbl1_2.Visible := False else lbl1_2.Visible := True;
  if lbl2_2.Caption = 'Lable Foods' then lbl2_2.Visible := False else lbl2_2.Visible := True;
  if lbl3_2.Caption = 'Lable Foods' then lbl3_2.Visible := False else lbl3_2.Visible := True;
  if lbl4_2.Caption = 'Lable Foods' then lbl4_2.Visible := False else lbl4_2.Visible := True;
  if lbl5_2.Caption = 'Lable Foods' then lbl5_2.Visible := False else lbl5_2.Visible := True;
  if lbl6_2.Caption = 'Lable Foods' then lbl6_2.Visible := False else lbl6_2.Visible := True;
  if lbl7_2.Caption = 'Lable Foods' then lbl7_2.Visible := False else lbl7_2.Visible := True;
  if lbl8_2.Caption = 'Lable Foods' then lbl8_2.Visible := False else lbl8_2.Visible := True;

end;
//kavedh ie

procedure TfrmPersonFish.SetVadeh;
var
  nowTime : string;
begin
  nowTime := CurrentTime;
  if (nowTime >= F_Params.FromSobh) and (nowTime <= F_Params.ToSobh) then
    rdoVadeh.ItemIndex := MB_SOBH-1
  else if (nowTime >= F_Params.FromNahar) and (nowTime <= F_Params.ToNahar) then
    rdoVadeh.ItemIndex := MB_NAHAR-1
  else if (nowTime >= F_Params.FromSham) and (nowTime <= F_Params.ToSham) then
    rdoVadeh.ItemIndex := MB_SHAM-1;

end;

procedure TfrmPersonFish.FishPrntForm(var ST : String; DblWidth, Clr : Boolean);
begin
  ST := StrRev(WinToDos(ST, g_options.WinType, DOS_IR_SYS)) + #13#10;

  case cmbPrinters.ItemIndex of
    PRN_LX:
    begin
      ST := #27#120#0 + ST;
      if DblWidth then ST := #14 + ST;
    end;

    PRN_LQ:
    begin
      ST := #27#120#1 + ST;
      if DblWidth then ST := #14 + ST;
    end;

    PRN_CITIZEN3541,
    PRN_CITIZEN3551:
    begin
      ST := #27'1' + ST;
      if DblWidth then ST := #14 + ST + #20;
      if Clr then
      begin
        if cmbPrinters.ItemIndex = PRN_CITIZEN3551 then
          ST := #27'4' + ST + #27'5'
        else
          ST := #$13+ST;
      end;
    end;

    PRN_ITHACA:
    begin
      if DblWidth then ST := #27'W'#1 + ST + #27'W'#0;
      if Clr then
        ST := #27'c'#1 + ST
      else
        ST := #27'c'#0 + ST;
    end;
  end;
end;


procedure TfrmPersonFish.PrintFish(p : TPerson);
var
  ST : String;
  i : Byte;
  FP : Currency;
  X, Y : Integer;
  tmp : String;
begin
  if cmbPrinters.ItemIndex <= PRN_ITHACA then
  begin
    if PrinterReady = PRN_OK then
    begin
      ST := FixLen(g_options.CoName, ' ', 30);
      FishPrntForm(ST, False, False);
      PrintString(ST);

      if p.P_IsGuest then
          ST := FixLen((')ميهمان( ') + p.P_Family, ' ', 21)
      else
        ST := FixLen(p.P_Name + '-' + p.P_Family, ' ', 21);

      ST := FixLen(StrRev(PersonFish.Fish_PCode), ' ', 8) + ' ' + ST;
      FishPrntForm(ST, False, False);
      PrintString(ST);

      if p.P_Rejim then
      begin
        if p.P_IsGuest then
          ST := FixLen('ميهمان رژيمي', ' ', 15)
        else
          ST := FixLen('پرسنل رژيمي', ' ', 15);
        ST := (ST);
        FishPrntForm(ST, True, True);
        PrintString(ST);
      end;

      ST := FixLen((FoodName[PersonFish.Fish_Type]) + ' ' + StrRev(PersonFish.Fish_Date), ' ', 30);
      FishPrntForm(ST, False, False);
      PrintString(ST);

      for i := 1 to 8 do
        if PersonFish.Fish_Foods[i] <> 0 then
        begin
          ST := FixLen(GetFoodNameInRam(PersonFish.Fish_Foods[i]), ' ', 30);
          FishPrntForm(ST, False, False);
          PrintString(ST);
        end;

      if p.P_PriceAble or (F_Params.AllFishPrc = MB_TRUE) then
      begin
        Fp := 0;
        for i := 1 to 8 do
          FP := FP + PersonFish.Fish_Price[i];
          ST := FixLen(('قيمت = ') + StrRev(FloatToStr(FP)), ' ', 30);
          FishPrntForm(ST, False, True);
          PrintString(ST);
      end;

      if PersonFish.ManySel > 1 then
        ST := FixLen('شماره' + StrRev(IntToStr(PersonFish.Fish_No-PersonFish.ManySel+1)) + 'تا' + StrRev(IntToStr(PersonFish.Fish_No)), ' ', 15)
      else
        ST := FixLen('شماره' + StrRev(IntToStr(PersonFish.Fish_No)), ' ', 15);
      FishPrntForm(ST, True, False);
      PrintString(ST);

      if F_Params.Endfishactive1
      then begin
          st:=F_Params.Endfish1;
          FishPrntForm(ST, True, False);
          PrintString(ST);
      end;
      if F_Params.Endfishactive2
      then begin
          st:=F_Params.Endfish2;
          FishPrntForm(ST, True, False);
          PrintString(ST);
      end;
      if F_Params.Endfishactive3
      then begin
          st:=F_Params.Endfish3;
          FishPrntForm(ST, True, False);
          PrintString(ST);
      end;
      if F_Params.Endfishactive4
      then begin
          st:=F_Params.Endfish4;
          FishPrntForm(ST, True, False);
          PrintString(ST);
      end;
      if F_Params.Endfishactive5
      then begin
          st:=F_Params.Endfish5;
          FishPrntForm(ST, True, False);
          PrintString(ST);
      end;

      if (txtLineFeed.Text <> '') and
         (StrToInt(txtLineFeed.Text) > 0) then
      begin
        ST := '';
        for i := 1 to StrToInt(txtLineFeed.Text) do ST := ST + #10;
        FishPrntForm(ST, False, False);
        PrintString(ST);
      end;

      if cmbPrinters.ItemIndex = PRN_CITIZEN3551 then
        PrintString(#27'd0')
      else if cmbPrinters.ItemIndex = PRN_CITIZEN3541 then
        PrintString(#27'P'#0)
      else if cmbPrinters.ItemIndex = PRN_ITHACA then
        PrintString(#27'd'#8#27'v');
    end
    else
      ErrorMessage('چاپگر آماده نيست.');
  end
  else
  begin
    txtPrint.Clear;
    ST := g_options.CoName;
    txtPrint.Lines.Add(ST);

    if PersonFish.ManySel > 1 then
      ST := 'شماره فیش : ' + FixLeft(StrRev(IntToStr(PersonFish.Fish_No-PersonFish.ManySel+1)) + 'تا' + StrRev(IntToStr(PersonFish.Fish_No)), ' ', 20) + '(دستی)'
    else
      ST := 'شماره فیش : ' + FixLeft(IntToStr(PersonFish.Fish_No), '0', 5) + '(دستی)';
    txtPrint.Lines.Add(ST);

    ST := FixLeft('', '-', 50);
    txtPrint.Lines.Add(ST);

    if p.P_IsGuest then
      ST := (')ميهمان( ') + p.P_Family
    else
      ST := p.P_Name + '-' + p.P_Family;

    ST := ST + '-' + FixLeft(personFish.Fish_PCode , ' ', 8);
    txtPrint.Lines.Add(ST);

    if p.P_Rejim then
    begin
      ST := FixLeft(('پرسنل رژيمي'), ' ', 15);
      txtPrint.Lines.Add(ST);
    end;

    ST := 'وعده ' + (FoodName[PersonFish.Fish_Type]) + ' ' + PersonFish.Fish_Date + '  *  ' + PersonFish.Fish_Time; 
    txtPrint.Lines.Add(ST);


    tmp := '';
    for i := 1 to 8 do
      if PersonFish.Fish_Foods[i] <> 0 then
      begin
        ST := GetFoodNameInRam(PersonFish.Fish_Foods[i]);
{            if GetFoodType(PersonFish.Fish_Foods[i]) = MB_GHAZA then
          PrintToReader(FixLeft(ST, ' ', 40) , True, True, OK)
        else
}            begin
          if tmp <> '' then
            tmp := tmp + '-';
          tmp := tmp + ST;
        end;
      end;
    txtPrint.Lines.Add(tmp);

    if F_Params.Endfishactive1  then
    begin
      ST := FixLeft(F_Params.Endfish1 , ' ', 38);
      txtPrint.Lines.Add(ST);
    end;

    if F_Params.Endfishactive2  then
    begin
      ST := FixLeft(F_Params.Endfish2 , ' ', 38);
      txtPrint.Lines.Add(ST);

    end;

    if F_Params.Endfishactive3  then
    begin
      ST := FixLeft(F_Params.Endfish3 , ' ', 38);
      txtPrint.Lines.Add(ST);
    end;

    if F_Params.Endfishactive4  then
    begin
      ST := FixLeft(F_Params.Endfish4 , ' ', 38);
      txtPrint.Lines.Add(ST);
    end;

    if F_Params.Endfishactive5  then
    begin
      ST := FixLeft(F_Params.Endfish5 , ' ', 38);
      txtPrint.Lines.Add(ST);
    end;


    ST := FixLeft('', '-', 50);
    txtPrint.Lines.Add(ST);

    if p.P_PriceAble or (F_Params.AllFishPrc = MB_TRUE) then
    begin
      Fp := 0;
      for i := 1 to 8 do
        FP := FP + PersonFish.Fish_Price[i];
      ST := ('قيمت = ') + FloatToStr(FP) + ' ریال ';
      txtPrint.Lines.Add(ST);
    end;
    if F_Params.LineFeed > 0 then
    begin
      ST := '';
      for i := 1 to F_Params.LineFeed do txtPrint.Lines.Add('.');
    end;


    txtPrint.Print('');

    {    ST := FixLen(g_options.CoName, ' ', 30);
    Printer.Canvas.TextOut(X, Y, ST);
    Y := Y + Printer.Canvas.TextHeight(ST) + 5;

    if p.P_IsGuest then
      ST := ('ميهمان (') + p.P_Family + ')‏'
    else
      ST := FixLen(p.P_Name + '،' + p.P_Family, ' ', 21);

    ST := #254 + FixLen(PersonFish.Fish_PCode, ' ', 8) + '-' + ST;
    Printer.Canvas.TextOut(X, Y, ST);
    Y := Y + Printer.Canvas.TextHeight(ST) + 5;

    if p.P_Rejim then
    begin
      if p.P_IsGuest then
        ST := FixLen('ميهمان رژيمي', ' ', 15)
      else
        ST := FixLen('پرسنل رژيمي', ' ', 15);
      ST := (ST);
      Printer.Canvas.TextOut(X, Y, ST);
      Y := Y + Printer.Canvas.TextHeight(ST) + 5;
    end;

    ST := FixLen(FoodName[PersonFish.Fish_Type] + '-' + PersonFish.Fish_Date, ' ', 30);
    ST := (ST);
    Printer.Canvas.TextOut(X, Y, ST);

    Y := Y + Printer.Canvas.TextHeight(ST) + 5;

    for i := 1 to 8 do
      if PersonFish.Fish_Foods[i] <> 0 then
      begin
        ST := FixLen(GetFoodNameInRam(PersonFish.Fish_Foods[i]), ' ', 30);
        Printer.Canvas.TextOut(X, Y, ST);
        Y := Y + Printer.Canvas.TextHeight(ST) + 5;
      end;

    if p.P_PriceAble then
    begin
      Fp := 0;
      for i := 1 to 8 do
        FP := FP + PersonFish.Fish_Price[i];
      ST := FixLen('قيمت = ' + FloatToStr(FP), ' ', 30);
      ST := (ST);
      Printer.Canvas.TextOut(X, Y, ST);
      Y := Y + Printer.Canvas.TextHeight(ST) + 5;
    end;

    if PersonFish.ManySel > 1 then
      ST := FixLen('شماره' + ':' +IntToStr(PersonFish.Fish_No-PersonFish.ManySel+1) + ' تا ' + IntToStr(PersonFish.Fish_No), ' ', 15)
    else
      ST := FixLen('شماره' + ':' + IntToStr(PersonFish.Fish_No), ' ', 15);
    ST := (ST);
    Printer.Canvas.TextOut(X, Y, ST);
    Y := Y + Printer.Canvas.TextHeight(ST) + 5;
////////////////////////////////////
    if (txtLineFeed.Text <> '') and
       (StrToInt(txtLineFeed.Text) > 0) then
    begin
      ST := '';
      for i := 1 to StrToInt(txtLineFeed.Text) do ST := ST + #10;
      ST := (ST);
      Printer.Canvas.TextOut(X, Y, ST);
    end;
}
//    Printer.EndDoc;
  end;
end;

procedure TfrmPersonFish.rdoVadehClick(Sender: TObject);
var i : Byte;
begin
  for i := 1 to 8 do
  begin
    PersonFish.Fish_Foods[i] := 0;
    lbls[i].Caption := '';
  end;
end;

procedure TfrmPersonFish.FormActivate(Sender: TObject);
const
  PrinterName : array [PRN_LX..PRN_ITHACA+1] of string =
                ('LX Series', 'LQ Series', 'CITIZEN-3551', 'CITIZEN-3541', 'ithaca', 'Windows Printer');
var
  i : Byte;
  rdrCode4Fish : Integer;
begin
  for i := PRN_LX to PRN_ITHACA+1 do cmbPrinters.Items.Add(PrinterName[i]);
//  chkPrintFish.Checked := (F_Params.PrintFish = MB_TRUE);
  cmbPrinters.ItemIndex := cmbPrinters.Items.Count-1;
  txtLineFeed.Text := IntToStr(F_Params.LineFeed);
  grpPrn.Enabled := chkPrintFish.Checked;
  cmdPrnFarsi.Enabled := (cmbPrinters.ItemIndex = PRN_LQ);
//kaveh is
  with qry do
  begin
    SQL.Clear;
    SQL.Add('SELECT UserName, rdrCode4Fish, GuestOnly4Fish From Security');
    SQL.Add('WHERE UserName = ''' + g_Options.UserName + ''' ');
    Open;
    rdrCode4Fish := FieldByName('rdrCode4Fish').AsInteger;
    GuestOnly4Fish := FieldByName('GuestOnly4Fish').AsBoolean;
    close;
  end;
//kaveh ie
  frmDBS.tblPersons.open;
  frmDBS.tblPersons.First;
  while not frmDBS.tblPersons.Eof do
  begin
    if not GuestOnly4Fish then
      cmbPCode.Items.Add(DelLeftZero(frmDBS.tblPersons.FieldByName('P_BarCode').AsString))
    else if frmDBS.tblPersons.FieldByName('P_IsGuest').AsBoolean then
      cmbPCode.Items.Add(DelLeftZero(frmDBS.tblPersons.FieldByName('P_BarCode').AsString));
    frmDBS.tblPersons.Next;
  end;
  chkPrintFishClick(Sender);

  lbls[1] := lbl1;
  lbls[2] := lbl2;
  lbls[3] := lbl3;
  lbls[4] := lbl4;
  lbls[5] := lbl5;
  lbls[6] := lbl6;
  lbls[7] := lbl7;
  lbls[8] := lbl8;
//kaveh is
  lbls_2[1] := lbl1_2;
  lbls_2[2] := lbl2_2;
  lbls_2[3] := lbl3_2;
  lbls_2[4] := lbl4_2;
  lbls_2[5] := lbl5_2;
  lbls_2[6] := lbl6_2;
  lbls_2[7] := lbl7_2;
  lbls_2[8] := lbl8_2;
{$ifdef OperatorBase}
  lbl1count.Visible := True;
  lbl2count.Visible := True;
  lbl3count.Visible := True;
  lbl4count.Visible := True;
  lbl5count.Visible := True;
  lbl6count.Visible := True;
  lbl7count.Visible := True;
  lbl8count.Visible := True;
{$endif OperatorBase}
//kaveh ie
  txtDate.Text := CurrentDate;
  ClearFields;
  SetVadeh;
//kaveh is
  with qryReaders do
  begin
//    SQL.Clear;
//    SQL.Add('SELECT UserName, rdrCode4Fish From Security');
//    SQL.Add('WHERE UserName = ''' + g_Options.UserName + ''' ');
//    Open;
//    rdrCode4Fish := FieldByName('rdrCode4Fish').AsInteger;
    SQL.Clear;
    SQL.Add('SELECT * FROM Readers ');
    SQL.Add('WHERE ((R_Active = 1) and ((R_Type = 5) or (R_Type = 6) or (R_Type = 7))) ');
    if rdrCode4Fish > 0 then
      SQL.Add(' and (R_Code = ' + IntToStr(rdrCode4Fish) + ')');
    Open;
    while not Eof do
    begin
      cmbRdrName.Items.Add(FieldByName('R_Name').AsString);
      cmbRdrCode.Items.Add(FieldByName('R_Code').AsString);
      Next;
    end;
    close;
  end;
  cmd9Click(self);
//  cmd0Click(self);
  cmdDelClick(self);
  iRdrCode := 0;
//kaveh ie
end;

procedure TfrmPersonFish.FormCreate(Sender: TObject);
begin
  code_food:=-1;
  qryReaders.connection := frmDBS.DBConnection;
  qry.connection := frmDBS.DBConnection;
  readOnlineStarted := False;
end;

procedure TfrmPersonFish.tmrReadOnlineTimer(Sender: TObject);
var
  clkRecord : TTerminalRec;
  bsRet : BS_RET_CODE;
  y,m,d,hh,mm,ss,ms : word;
  findRec : Boolean;
  tempSec : Integer;
begin
//  txtDate.Text := CurrentDate;
//  txtTime.Text := '';
//  cmbPCode.ItemIndex := -1;
  tmrReadOnline.Enabled := False;
  findRec := False;
  iRdrCode := 0;
  bsRet := ReadFirstLogPCode_BS(rdrReadOnline,Shamsi2Milady(LeftStr(DTTM4ReadOnline,10)) + RightStr(DTTM4ReadOnline,9),'',clkRecord, findRec);
  if bsRet <> BS_SUCCESS then
  begin
    lblHelp.Caption := 'خطا! ارتباط با دستگاه قطع ميباشد';
    tmrReadOnline.Enabled := True;
  end
  else
  begin
    lblHelp.Caption := 'در حال خواندن اطلاعات از دستگاه';

    if findRec then
    begin
      if clkRecord.rdrCardCode <> '' then
      begin
//        clkRecord.rdrCode := StrToInt(cmbRdrCode.Text);
        iRdrCode := StrToInt(cmbRdrCode.Text);
        lblHelp.Caption := 'آماده دريافت ليست غذا و ثبت اطلاعات';
        cmbPCode.ItemIndex := cmbPCode.Items.IndexOf(DelLeftZero(clkRecord.rdrCardCode));
        cmbPCodeExit(self);
        txtDate.Text := clkRecord.rdrDate;
        txtTime.Text := FixLeft(IntToStr(clkRecord.rdrTime div 60),'0',2) + ':' + FixLeft(IntToStr(clkRecord.rdrTime mod 60),'0',2);
  //      tmrReadOnline.Enabled := False;
        tempSec := clkRecord.rdrTimeSec + 2;
        DTTM4ReadOnline := txtDate.Text + ' ' + FixLeft(IntToStr(tempSec div 3600),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 3600) div 60),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 60)),'0',2);
  //kaveh      DTTM4ReadOnlineSec := clkRecord.rdrTimeSec;
        cmdSave.SetFocus;
      end
      else
      begin
        lblHelp.Caption := 'كارت غير معتبر';
        tempSec := clkRecord.rdrTimeSec + 2;
        DTTM4ReadOnline := clkRecord.rdrDate + ' ' + FixLeft(IntToStr(tempSec div 3600),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 3600) div 60),'0',2) + ':' + FixLeft(IntToStr((tempSec mod 60)),'0',2);
        tmrReadOnline.Enabled := True;
      end;
    end
    else
    begin
//kaveh      DTTM4ReadOnlineSec := DTTM4ReadOnlineSec + 2;
//kaveh      DecodeDate(MSecToDateTime(DTTM4ReadOnlineSec),y,m,d);
//kaveh      DecodeTime(MSecToDateTime(DTTM4ReadOnlineSec),hh,mm,ss,ms);
//kaveh      DTTM4ReadOnline := Milady2Shamsi(FixLeft(IntToStr(y),'0',4)+'/'+FixLeft(IntToStr(m),'0',2)+'/'+FixLeft(IntToStr(d),'0',2)) + ' ' + (FixLeft(IntToStr(hh),'0',2)+':'+FixLeft(IntToStr(mm),'0',2)+':'+FixLeft(IntToStr(ss),'0',2));
      tmrReadOnline.Enabled := True;
    end;
  end;
end;

procedure TfrmPersonFish.tmrTimeTimer(Sender: TObject);
begin
//  txtTime.Text := CurrentTime;
//  if (txtTime.Text >= F_Params.FromSobh) and (txtTime.Text <= F_Params.ToSobh) then
//    F_Type := MB_SOBH
//  else if (txtTime.Text >= F_Params.FromNahar) and (txtTime.Text <= F_Params.ToNahar) then
//    F_Type := MB_NAHAR
//  else if (txtTime.Text >= F_Params.FromSham) and (txtTime.Text <= F_Params.ToSham) then
//    F_Type := MB_SHAM;
end;

procedure TfrmPersonFish.cmd1Click(Sender: TObject);
var y:Currency ; 
begin
{$ifndef OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    Keys[1] := not Keys[1];
    if PersonFish.Fish_Foods[1] = 0 then
      PersonFish.Fish_Foods[1] := DayFoodList[rdoVadeh.itemindex+1].Keys[1]
    else
      PersonFish.Fish_Foods[1] := 0;
    SetFields;
    code_food:= PersonFish.Fish_Foods[1];
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$else OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    if lbl1count.Caption = '0' then
    begin
      Keys[1] := not Keys[1];
      if PersonFish.Fish_Foods[1] = 0 then
        PersonFish.Fish_Foods[1] := DayFoodList[rdoVadeh.itemindex+1].Keys[1];
      SetFields;
      code_food:= PersonFish.Fish_Foods[1];
    end;
    if PersonFish.Fish_Foods[1] <> 0 then
      lbl1count.Caption :=IntToStr(StrToInt(lbl1count.Caption) + 1)
    else
      lbl1count.Caption := '0';
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$endif OperatorBase}
end;

procedure TfrmPersonFish.cmd2Click(Sender: TObject);
begin
{$ifndef OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    Keys[2] := not Keys[2];
    if PersonFish.Fish_Foods[2] = 0 then
      PersonFish.Fish_Foods[2] := DayFoodList[rdoVadeh.itemindex+1].Keys[2]
    else
      PersonFish.Fish_Foods[2] := 0;
    SetFields;
    code_food:= PersonFish.Fish_Foods[2];
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$else OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    if lbl2count.Caption = '0' then
    begin
      Keys[2] := not Keys[2];
      if PersonFish.Fish_Foods[2] = 0 then
        PersonFish.Fish_Foods[2] := DayFoodList[rdoVadeh.itemindex+1].Keys[2];
      SetFields;
      code_food:= PersonFish.Fish_Foods[2];
    end;
    if PersonFish.Fish_Foods[2] <> 0 then
      lbl2count.Caption :=IntToStr(StrToInt(lbl2count.Caption) + 1)
    else
      lbl2count.Caption := '0';
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$endif OperatorBase}
end;

procedure TfrmPersonFish.cmd3Click(Sender: TObject);
begin
{$ifndef OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    Keys[3] := not Keys[3];
    if PersonFish.Fish_Foods[3] = 0 then
      PersonFish.Fish_Foods[3] := DayFoodList[rdoVadeh.itemindex+1].Keys[3]
    else
      PersonFish.Fish_Foods[3] := 0;
    SetFields;
    code_food:= PersonFish.Fish_Foods[3];
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$else OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    if lbl3count.Caption = '0' then
    begin
      Keys[3] := not Keys[3];
      if PersonFish.Fish_Foods[3] = 0 then
        PersonFish.Fish_Foods[3] := DayFoodList[rdoVadeh.itemindex+1].Keys[3];
      SetFields;
      code_food:= PersonFish.Fish_Foods[3];
    end;
    if PersonFish.Fish_Foods[3] <> 0 then
      lbl3count.Caption :=IntToStr(StrToInt(lbl3count.Caption) + 1)
    else
      lbl3count.Caption := '0';
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$endif OperatorBase}
end;

procedure TfrmPersonFish.cmd4Click(Sender: TObject);
begin
{$ifndef OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    Keys[4] := not Keys[4];
    if PersonFish.Fish_Foods[4] = 0 then
      PersonFish.Fish_Foods[4] := DayFoodList[rdoVadeh.itemindex+1].Keys[4]
    else
      PersonFish.Fish_Foods[4] := 0;
    SetFields;
    code_food:= PersonFish.Fish_Foods[4];
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$else OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    if lbl4count.Caption = '0' then
    begin
      Keys[4] := not Keys[4];
      if PersonFish.Fish_Foods[4] = 0 then
        PersonFish.Fish_Foods[4] := DayFoodList[rdoVadeh.itemindex+1].Keys[4];
      SetFields;
      code_food:= PersonFish.Fish_Foods[4];
    end;
    if PersonFish.Fish_Foods[4] <> 0 then
      lbl4count.Caption :=IntToStr(StrToInt(lbl4count.Caption) + 1)
    else
      lbl4count.Caption := '0';
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$endif OperatorBase}
end;

procedure TfrmPersonFish.cmd5Click(Sender: TObject);
begin
{$ifndef OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    Keys[5] := not Keys[5];
    if PersonFish.Fish_Foods[5] = 0 then
      PersonFish.Fish_Foods[5] := DayFoodList[rdoVadeh.itemindex+1].Keys[5]
    else
      PersonFish.Fish_Foods[5] := 0;
    SetFields;
    code_food:= PersonFish.Fish_Foods[5];
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$else OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    if lbl5count.Caption = '0' then
    begin
      Keys[5] := not Keys[5];
      if PersonFish.Fish_Foods[5] = 0 then
        PersonFish.Fish_Foods[5] := DayFoodList[rdoVadeh.itemindex+1].Keys[5];
      SetFields;
      code_food:= PersonFish.Fish_Foods[5];
    end;
    if PersonFish.Fish_Foods[5] <> 0 then
      lbl5count.Caption :=IntToStr(StrToInt(lbl5count.Caption) + 1)
    else
      lbl5count.Caption := '0';
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$endif OperatorBase}
end;

procedure TfrmPersonFish.cmd6Click(Sender: TObject);
begin
{$ifndef OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    Keys[6] := not Keys[6];
    if PersonFish.Fish_Foods[6] = 0 then
      PersonFish.Fish_Foods[6] := DayFoodList[rdoVadeh.itemindex+1].Keys[6]
    else
      PersonFish.Fish_Foods[6] := 0;
    SetFields;
    code_food:= PersonFish.Fish_Foods[6];
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$else OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    if lbl6count.Caption = '0' then
    begin
      Keys[6] := not Keys[6];
      if PersonFish.Fish_Foods[6] = 0 then
        PersonFish.Fish_Foods[6] := DayFoodList[rdoVadeh.itemindex+1].Keys[6];
      SetFields;
      code_food:= PersonFish.Fish_Foods[6];
    end;
    if PersonFish.Fish_Foods[6] <> 0 then
      lbl6count.Caption :=IntToStr(StrToInt(lbl6count.Caption) + 1)
    else
      lbl6count.Caption := '0';
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$endif OperatorBase}
end;

procedure TfrmPersonFish.cmd7Click(Sender: TObject);
begin
{$ifndef OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    Keys[7] := not Keys[7];
    if PersonFish.Fish_Foods[7] = 0 then
      PersonFish.Fish_Foods[7] := DayFoodList[rdoVadeh.itemindex+1].Keys[7]
    else
      PersonFish.Fish_Foods[7] := 0;
    SetFields;
    code_food:= PersonFish.Fish_Foods[7];
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$else OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    if lbl7count.Caption = '0' then
    begin
      Keys[7] := not Keys[7];
      if PersonFish.Fish_Foods[7] = 0 then
        PersonFish.Fish_Foods[7] := DayFoodList[rdoVadeh.itemindex+1].Keys[7];
      SetFields;
      code_food:= PersonFish.Fish_Foods[7];
    end;
    if PersonFish.Fish_Foods[7] <> 0 then
      lbl7count.Caption :=IntToStr(StrToInt(lbl7count.Caption) + 1)
    else
      lbl7count.Caption := '0';
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$endif OperatorBase}
    
end;

procedure TfrmPersonFish.cmd8Click(Sender: TObject);
begin
{$ifndef OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    Keys[8] := not Keys[8];
    if PersonFish.Fish_Foods[8] = 0 then
      PersonFish.Fish_Foods[8] := DayFoodList[rdoVadeh.itemindex+1].Keys[8]
    else
      PersonFish.Fish_Foods[8] := 0;
    SetFields;
    code_food:= PersonFish.Fish_Foods[8];
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$else OperatorBase}
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    if lbl8count.Caption = '0' then
    begin
      Keys[8] := not Keys[8];
      if PersonFish.Fish_Foods[8] = 0 then
        PersonFish.Fish_Foods[8] := DayFoodList[rdoVadeh.itemindex+1].Keys[8];
      SetFields;
      code_food:= PersonFish.Fish_Foods[8];
    end;
    if PersonFish.Fish_Foods[8] <> 0 then
      lbl8count.Caption :=IntToStr(StrToInt(lbl8count.Caption) + 1)
    else
      lbl8count.Caption := '0';
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
{$endif OperatorBase}
end;

procedure TfrmPersonFish.cmd9Click(Sender: TObject);
var i : Byte;
begin
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    for i := 1 to 8 do
      if (Pow2(i) AND DayFoodList[rdoVadeh.itemindex+1].Keys[9]) <> 0 then
      begin
        PersonFish.Fish_Foods[i] := DayFoodList[rdoVadeh.itemindex+1].Keys[i];
        Keys[i] := True;
      end
      else
      begin
        PersonFish.Fish_Foods[i] := 0;
        Keys[i] := False;
      end;

      SetFields;
{$ifdef OperatorBase}
      if PersonFish.Fish_Foods[1] <> 0 then lbl1count.Caption := '1' else lbl1count.Caption := '0';
      if PersonFish.Fish_Foods[2] <> 0 then lbl2count.Caption := '1' else lbl2count.Caption := '0';
      if PersonFish.Fish_Foods[3] <> 0 then lbl3count.Caption := '1' else lbl3count.Caption := '0';
      if PersonFish.Fish_Foods[4] <> 0 then lbl4count.Caption := '1' else lbl4count.Caption := '0';
      if PersonFish.Fish_Foods[5] <> 0 then lbl5count.Caption := '1' else lbl5count.Caption := '0';
      if PersonFish.Fish_Foods[6] <> 0 then lbl6count.Caption := '1' else lbl6count.Caption := '0';
      if PersonFish.Fish_Foods[7] <> 0 then lbl7count.Caption := '1' else lbl7count.Caption := '0';
      if PersonFish.Fish_Foods[8] <> 0 then lbl8count.Caption := '1' else lbl8count.Caption := '0';
{$endif OperatorBase}
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');

end;

procedure TfrmPersonFish.cmd0Click(Sender: TObject);
var i : Byte;
begin
  LoadDayProg(txtDate.text);
  if rdoVadeh.itemindex+1 <> 0 then
  begin
    for i := 1 to 8 do
      if (Pow2(i) AND DayFoodList[rdoVadeh.itemindex+1].Keys[0]) <> 0 then
      begin
        PersonFish.Fish_Foods[i] := DayFoodList[rdoVadeh.itemindex+1].Keys[i];
        Keys[i] := True;
      end
      else
      begin
        PersonFish.Fish_Foods[i] := 0;
        Keys[i] := False;
      end;

      SetFields;
{$ifdef OperatorBase}
      if PersonFish.Fish_Foods[1] <> 0 then lbl1count.Caption := '1' else lbl1count.Caption := '0';
      if PersonFish.Fish_Foods[2] <> 0 then lbl2count.Caption := '1' else lbl2count.Caption := '0';
      if PersonFish.Fish_Foods[3] <> 0 then lbl3count.Caption := '1' else lbl3count.Caption := '0';
      if PersonFish.Fish_Foods[4] <> 0 then lbl4count.Caption := '1' else lbl4count.Caption := '0';
      if PersonFish.Fish_Foods[5] <> 0 then lbl5count.Caption := '1' else lbl5count.Caption := '0';
      if PersonFish.Fish_Foods[6] <> 0 then lbl6count.Caption := '1' else lbl6count.Caption := '0';
      if PersonFish.Fish_Foods[7] <> 0 then lbl7count.Caption := '1' else lbl7count.Caption := '0';
      if PersonFish.Fish_Foods[8] <> 0 then lbl8count.Caption := '1' else lbl8count.Caption := '0';
{$endif OperatorBase}
  end
  else
    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');
end;

procedure TfrmPersonFish.cmbPCodeExit(Sender: TObject);
var
  p : TPerson;
  iPictureName : string;
begin
  PersonFish.Fish_PCode := FixLeft(cmbPCode.Text, '0', 8);
  PersonFish.IsProxi := False;
  p := GetPerson(PersonFish.Fish_PCode, False);
  if (p.P_BarCode = '') or (not p.p_exist) then
  begin
    pnlType.Caption := '';
    imgPicture.Picture.Bitmap := nil; //kaveh
  end
  else if not p.P_IsGuest and p.P_Rejim then
  begin
    pnlType.Caption := ('پرسنل رژيمي' + '   ' + p.P_Family + ' - ' + p.P_Name);
    if p.P_Picture = '' then
      iPictureName := F_Params.PrsImgsFld + '\' + DelLeftZero(p.P_BarCode) + '.jpg'
    else
      iPictureName := F_Params.PrsImgsFld + '\' + p.P_Picture;
    if (iPictureName <> '') and FileExists(iPictureName)
    then begin
      imgPicture.Picture.LoadFromFile(iPictureName);
    end
    else
      imgPicture.Picture.Bitmap := nil;
  end
  else if p.P_IsGuest and not p.P_Rejim then
  begin
    pnlType.Caption := ('ميهمان عادي');
    if p.P_Picture = '' then
      iPictureName := F_Params.PrsImgsFld + '\' + DelLeftZero(p.P_BarCode) + '.jpg'
    else
      iPictureName := F_Params.PrsImgsFld + '\' + p.P_Picture;
    if (iPictureName <> '') and FileExists(iPictureName)
    then begin
      imgPicture.Picture.LoadFromFile(iPictureName);
    end
    else
      imgPicture.Picture.Bitmap := nil;
  end
  else if p.P_IsGuest and p.P_Rejim then
  begin
    pnlType.Caption := ('ميهمان رژيمي');
    if p.P_Picture = '' then
      iPictureName := F_Params.PrsImgsFld + '\' + DelLeftZero(p.P_BarCode) + '.jpg'
    else
      iPictureName := F_Params.PrsImgsFld + '\' + p.P_Picture;
    if (iPictureName <> '') and FileExists(iPictureName)
    then begin
      imgPicture.Picture.LoadFromFile(iPictureName);
    end
    else
      imgPicture.Picture.Bitmap := nil;    
  end
  else
  begin
    pnlType.Caption := ('پرسنل عادي' + '   ' + p.P_Family + ' - ' + p.P_Name);
    if p.P_Picture = '' then
      iPictureName := F_Params.PrsImgsFld + '\' + DelLeftZero(p.P_BarCode) + '.jpg'
    else
      iPictureName := F_Params.PrsImgsFld + '\' + p.P_Picture;
    if (iPictureName <> '') and FileExists(iPictureName)
    then begin
      imgPicture.Picture.LoadFromFile(iPictureName);
    end
    else
      imgPicture.Picture.Bitmap := nil;
  end;
//kaveh is
{$ifdef OperatorBase}
  cmdSave.SetFocus;
{$endif OperatorBase}
  if ((cmbPCode.Text <> '') or (cmbPCode.ItemIndex > -1)) and (GuestOnly4Fish) and (not p.P_IsGuest) then
  begin
    pnlType.Caption := '';
    imgPicture.Picture.Bitmap := nil; //kaveh
    cmbPCode.ItemIndex := -1;
    cmbPCode.Text := '';
    ErrorMessage('تنها کارتهای میهمان قابل انتخاب میباشند.');
    cmbPCode.SetFocus;
  end;  
//kaveh ie
end;

procedure TfrmPersonFish.cmdSaveClick(Sender: TObject);
var
  i, FishM : Byte;
  retVal,priceperson,pricefree : Integer;
  p : TPerson;
{$ifdef OperatorBase}
  KeysMaxCount, iMax : integer;
{$endif OperatorBase}
begin
  if cmbPCode.Text = '' then
  begin
    if readOnlineStarted then
    begin
      tmrReadOnline.Enabled := False;
      ErrorMessage('شماره كارت وارد نشده است.');
      tmrReadOnline.Enabled := True;
    end
    else
      ErrorMessage('شماره كارت وارد نشده است.');
  end
  else
  begin
    {if chkPrintFish.Checked then
    begin
      if PrinterInitial <> PRN_OK then
      begin
        ErrorMessage('چاپگر آماده نيست.');
        chkPrintFish.SetFocus;
        Exit;
      end;
    end;}

    LoadDayProg(txtDate.text);
    SetUserControl;
    PersonFish.Fish_Type := rdoVadeh.ItemIndex + 1;
    case PersonFish.Fish_Type of
      1 : PersonFish.Fish_No := Sobh_Fish_No;
      2 : PersonFish.Fish_No := Nahar_Fish_No;
      3 : PersonFish.Fish_No := Sham_Fish_No;
    end;
//    PersonFish.Fish_Time := CurrentTime;
    PersonFish.Keys := 0;
    PersonFish.IsProxi := False;

{$ifdef OperatorBase}
    KeysMaxCount := 0;
    if StrToInt(lbl1count.Caption)>KeysMaxCount then
      KeysMaxCount := StrToInt(lbl1count.Caption);
    if StrToInt(lbl2count.Caption)>KeysMaxCount then
      KeysMaxCount := StrToInt(lbl2count.Caption);
    if StrToInt(lbl3count.Caption)>KeysMaxCount then
      KeysMaxCount := StrToInt(lbl3count.Caption);
    if StrToInt(lbl4count.Caption)>KeysMaxCount then
      KeysMaxCount := StrToInt(lbl4count.Caption);
    if StrToInt(lbl5count.Caption)>KeysMaxCount then
      KeysMaxCount := StrToInt(lbl5count.Caption);
    if StrToInt(lbl6count.Caption)>KeysMaxCount then
      KeysMaxCount := StrToInt(lbl6count.Caption);
    if StrToInt(lbl7count.Caption)>KeysMaxCount then
      KeysMaxCount := StrToInt(lbl7count.Caption);
    if StrToInt(lbl8count.Caption)>KeysMaxCount then
      KeysMaxCount := StrToInt(lbl8count.Caption);

    for iMax := 0 to KeysMaxCount - 1 do
    begin

    for i := 1 to 8 do
      Keys[i] := False;

    if lbl1count.Caption <> '0' then begin Keys[1] := True; lbl1count.Caption := IntToStr(StrToInt(lbl1count.Caption)-1); end;
//    else Keys[1] := False;
    if lbl2count.Caption <> '0' then begin Keys[2] := True; lbl2count.Caption := IntToStr(StrToInt(lbl2count.Caption)-1); end;
//    else Keys[2] := False;
    if lbl3count.Caption <> '0' then begin Keys[3] := True; lbl3count.Caption := IntToStr(StrToInt(lbl3count.Caption)-1); end;
//    else Keys[3] := False;
    if lbl4count.Caption <> '0' then begin Keys[4] := True; lbl4count.Caption := IntToStr(StrToInt(lbl4count.Caption)-1); end;
//    else Keys[4] := False;
    if lbl5count.Caption <> '0' then begin Keys[5] := True; lbl5count.Caption := IntToStr(StrToInt(lbl5count.Caption)-1); end;
//    else Keys[5] := False;
    if lbl6count.Caption <> '0' then begin Keys[6] := True; lbl6count.Caption := IntToStr(StrToInt(lbl6count.Caption)-1); end;
//    else Keys[6] := False;
    if lbl7count.Caption <> '0' then begin Keys[7] := True; lbl7count.Caption := IntToStr(StrToInt(lbl7count.Caption)-1); end;
//    else Keys[7] := False;
    if lbl8count.Caption <> '0' then begin Keys[8] := True; lbl8count.Caption := IntToStr(StrToInt(lbl8count.Caption)-1); end;
//    else Keys[8] := False;
    PersonFish.Keys := 0;
{$endif OperatorBase}

    for i := 1 to 8 do
      if Keys[i] then
        PersonFish.Keys := PersonFish.Keys OR Pow2(i);
    PersonFish.Fish_Date := txtDate.Text;
    if txtTime.Text=''
    then PersonFish.Fish_Time := CurrentTime
    else PersonFish.Fish_Time := txtTime.Text;

    for i := 1 to 8 do
      PersonFish.Fish_FoodsNo[i] := 1;
    PersonFish.Fish_UCode := 0;
    PersonFish.Fish_UKhadamat := 0;
    PersonFish.Fish_UPrc := 0;
    PersonFish.Fish_UPay := 0;
//kaveh is
{$ifdef OperatorBase}
    if cmbRdrCode.ItemIndex < 0 then
      with qry do
      begin
        SQL.Clear;
        SQL.Add('SELECT UserName, rdrCode4Fish From Security');
        SQL.Add('WHERE UserName = ''' + g_Options.UserName + ''' ');
        Open;
        iRdrCode := FieldByName('rdrCode4Fish').AsInteger;
        close;
        if iRdrCode < 1 then
        begin
          ErrorMessage('هیچ دستگاهی انتخاب نشده است.');
          UserControl := False;
          cmdSave.SetFocus;
          Exit;
        end;
      end
    else if iRdrCode < 1 then
      iRdrCode := StrToInt(cmbRdrCode.Text);
{$endif OperatorBase}
    PersonFish.Fish_RdrCode := iRdrCode;

//    if GuestOnly4Fish then

//    if not GuestOnly4Fish then
//      cmbPCode.Items.Add(DelLeftZero(frmDBS.tblPersons.FieldByName('P_BarCode').AsString))
//    else if frmDBS.tblPersons.FieldByName('P_IsGuest').AsBoolean then
//      cmbPCode.Items.Add(DelLeftZero(frmDBS.tblPersons.FieldByName('P_BarCode').AsString));
//    frmDBS.tblPersons.Next;


//kaveh ie
    if txtFishMany.Text <> '' then
      FishM := StrToInt(txtFishMany.Text)
    else
      FishM := 1;

    for i := 1 to FishM do
    begin
      retVal := CreateFish(PersonFish, p, True);
      if not (retVal in [0, 2 , 3]) then
      begin
        ErrorMessage(ErrMsg[retVal]);
{$ifdef OperatorBase}
        cmdSave.SetFocus;
{$else OperatorBase}
        cmbPCode.SetFocus;
{$endif OperatorBase}
        UserControl := False;
        Exit;
      end
      else if ((retVal in [2,3]) and ConfirmMessage(ErrMsg[retVal] + ' آيا مي خواهيد فيش را صادر نماييد؟')) or
               (retVal = 0) then
      begin
        SaveFish(PersonFish);
        if chkPrintFish.Checked then
        begin
          PrintFish(P);
          InformationMessage('فیش را بردارید...');
        end;
        frmFishLst.ViewFish(PersonFish, p, retVal);
      end
      else
        frmFishLst.ViewFish(PersonFish, p, retVal);
    end;
    UserControl := False;
    if readOnlineStarted then
    begin
      lblHelp.Caption := 'در حال خواندن اطلاعات از دستگاه';
      txtDate.Text := CurrentDate;
      txtTime.Text := '';
      cmbPCode.ItemIndex := -1;
      tmrReadOnline.Enabled := True;
    end;


{$ifdef OperatorBase}

    end;
{$endif OperatorBase}
  end;

  ClearFields;
  if readOnlineStarted then
    cmdSave.SetFocus
  else
{$ifdef OperatorBase}
    cmdSave.SetFocus;
{$else OperatorBase}
    cmbPCode.SetFocus;
{$endif OperatorBase}
  USERCONTROL := False;
end;




procedure TfrmPersonFish.cmdStartReadClick(Sender: TObject);
begin
  if cmbRdrName.ItemIndex = -1 then
  begin
    ErrorMessage('دستگاهي انتخاب نشده است');
    cmbRdrName.SetFocus;
  end
  else
  begin
    with qryReaders do
    begin
      SQl.Clear;
      SQL.Add('SELECT * FROM Readers ');
      SQL.Add('WHERE R_Active = 1 and R_Code = ' + cmbRdrCode.Text);
      Open;
      if FieldByName('R_Code').AsString <> '' then
      begin
        rdrReadOnline.R_Code := FieldByName('R_Code').AsInteger;
        rdrReadOnline.R_Name := FieldByName('R_Name').AsString;
        rdrReadOnline.R_Active := FieldByName('R_Active').AsBoolean;
        rdrReadOnline.R_Port := FieldByName('R_Port').AsInteger;
        rdrReadOnline.R_BaudNo := FieldByName('R_BaudNo').AsInteger;
        rdrReadOnline.R_Type := FieldByName('R_Type').AsInteger;
        rdrReadOnline.R_IsCom := FieldByName('R_IsCom').AsBoolean;
        rdrReadOnline.R_IP := FieldByName('R_IP').AsString;
        cmdStopRead.Enabled := True;
        cmdReadNext.Enabled := True;
        cmdStartRead.Enabled := False;
        cmbRdrName.Enabled := False;
        chkReadOnline.Enabled := False;
        DTTM4ReadOnline := CurrentDate + ' ' + CurrentTimeWithSec;
//kaveh        DTTM4ReadOnlineSec := DateTimeToMSec(Shamsi2Milady(LeftStr(DTTM4ReadOnline,10)) + RightStr(DTTM4ReadOnline,9));
        SendDateTime_BS(rdrReadOnline,CurrentDate,CurrentTimes); //kaveh
        readOnlineStarted := True;
        lblHelp.Caption := 'در حال خواندن اطلاعات از دستگاه';
        cmdStopRead.SetFocus;
        tmrReadOnline.Enabled := True;
      end
      else
      begin
        ErrorMessage('دستگاهي مورد نظر يافت نشد');
        cmbRdrName.SetFocus;
      end;

    end;
  end;

end;

procedure TfrmPersonFish.cmdStopReadClick(Sender: TObject);
begin
  cmdStartRead.Enabled := True;
  cmdStopRead.Enabled := False;
  cmdReadNext.Enabled := False;
  readOnlineStarted := False;
  tmrReadOnline.Enabled := False;
  cmbRdrName.Enabled := True;
  chkReadOnline.Enabled := True;

  txtDate.Text := CurrentDate;
  txtTime.Text := '';
  cmbPCode.ItemIndex := -1;
  pnlType.Caption := '';
  imgPicture.Picture.Bitmap := nil; //kaveh
  lblHelp.Caption := 'آماده آغاز خواندن اطلاعات از دستگاه';
  cmdStartRead.SetFocus;
end;

procedure TfrmPersonFish.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
{$ifdef OperatorBase}
    cmdSave.SetFocus;
{$else OperatorBase}
    cmbPCode.SetFocus;
{$endif OperatorBase}
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmPersonFish.txtDateExit(Sender: TObject);
begin
  with txtDate do
    if Text <> '' then
      Text := BeautifulDate(Text);

  if g_options.RunDate <> txtDate.text then
  begin
    g_options.RunDate := txtDate.text;
    InitVariables(False);
  end;
end;

procedure TfrmPersonFish.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
//  if Key = #13 then
//  begin
//    Key := #0;
//{$ifdef Bank Markazi}
//    cmdSave.SetFocus;
//{$else Bank Markazi}
//    cmbPCode.SetFocus;
//{$endif Bank Markazi}
//  end
//  else if Key in ['0'..'9', #8, ':'] then
//  begin
//    tmrTime.Enabled := False;
    Keyboard_Time(Key);
//  end;
//
//  if (txtTime.Text >= F_Params.FromSobh) and (txtTime.Text <= F_Params.ToSobh) then
//    rdoVadeh.itemindex+1 := MB_SOBH
//  else if (txtTime.Text >= F_Params.FromNahar) and (txtTime.Text <= F_Params.ToNahar) then
//    F_Type := MB_NAHAR
//  else if (txtTime.Text >= F_Params.FromSham) and (txtTime.Text <= F_Params.ToSham) then
//    F_Type := MB_SHAM;
end;

procedure TfrmPersonFish.txtTimeExit(Sender: TObject);
begin
  if txtTime.Text <> '' then
    txtTime.Text := BeautifulTime(txtTime.Text);

//  if (txtTime.Text >= F_Params.FromSobh) and (txtTime.Text <= F_Params.ToSobh) then
//    F_Type := MB_SOBH
//  else if (txtTime.Text >= F_Params.FromNahar) and (txtTime.Text <= F_Params.ToNahar) then
//    F_Type := MB_NAHAR
//  else if (txtTime.Text >= F_Params.FromSham) and (txtTime.Text <= F_Params.ToSham) then
//    F_Type := MB_SHAM;
//
//  if g_options.RunDate <> txtDate.Text then
//  begin
//    g_options.RunDate := txtDate.Text;
//    InitVariables(False);
//  end;
end;

procedure TfrmPersonFish.cmdInitPrnClick(Sender: TObject);
var c : Byte;
begin
  c := PrinterInitial;
  if c <> PRN_OK then
    InformationMessage('چاپگر آماده نيست!')
  else
    InformationMessage('چاپگر آماده است.');
end;

procedure TfrmPersonFish.chkReadOnlineClick(Sender: TObject);
begin
  Label2.Enabled := chkReadOnline.Checked;
  cmbRdrName.Enabled := chkReadOnline.Checked;
  cmdStartRead.Enabled := chkReadOnline.Checked;
  cmdStopRead.Enabled := False;
  cmdReadNext.Enabled := False;
  if not chkReadOnline.Checked then
    tmrReadOnline.Enabled := False;
  lblHelp.Enabled := chkReadOnline.Checked;
  if chkReadOnline.Checked then
    lblHelp.Caption := 'آماده آغاز خواندن اطلاعات از دستگاه'
  else
    lblHelp.Caption := '...';
end;

procedure TfrmPersonFish.cmdDelClick(Sender: TObject);
var i : Byte;
begin
//      if (Pow2(i) AND DayFoodList[rdoVadeh.itemindex+1].Keys[9]) <> 0 then
  LoadDayProg(txtDate.text);
//  if rdoVadeh.itemindex+1 <> 0 then
//  begin
  for i := 1 to 8 do
//      if (Pow2(i) AND DayFoodList[rdoVadeh.itemindex+1].Keys[0]) <> 0 then
//      begin
//        PersonFish.Fish_Foods[i] := DayFoodList[rdoVadeh.itemindex+1].Keys[i];
//        Keys[i] := True;
//      end
//      else
  begin
    PersonFish.Fish_Foods[i] := 0;
    Keys[i] := False;
  end;

  SetFields;

{$ifdef OperatorBase}
  lbl1count.Caption := '0';
  lbl2count.Caption := '0';
  lbl3count.Caption := '0';
  lbl4count.Caption := '0';
  lbl5count.Caption := '0';
  lbl6count.Caption := '0';
  lbl7count.Caption := '0';
  lbl8count.Caption := '0';
{$endif OperatorBase}
//  end
//  else
//    ErrorMessage('محدوده زماني در محدوده هاي صبحانه و ناهار و شام نمي‌باشد.');

end;

procedure TfrmPersonFish.chkPrintFishClick(Sender: TObject);
begin
  grpPrn.Enabled := chkPrintFish.Checked;
  if chkPrintFish.Checked then
    cmdSave.Caption := ('&ثبت و چاپ فيش')
  else
    cmdSave.Caption := ('&ثبت فيش');
end;

procedure TfrmPersonFish.cmbPrintersClick(Sender: TObject);
begin
  cmdPrnFarsi.Enabled := (cmbPrinters.ItemIndex = PRN_LQ);
end;

procedure TfrmPersonFish.cmbRdrNameChange(Sender: TObject);
begin
  cmbRdrCode.ItemIndex := cmbRdrName.ItemIndex;
  iRdrCode := StrToInt(cmbRdrCode.Text);
end;

procedure TfrmPersonFish.cmdPrnFarsiClick(Sender: TObject);
begin
  if DownLoadFarsiPrint then
    InformationMessage('چاپگر فارسي شد.')
  else
    InformationMessage('فارسي نمودن چاپگر امكان پذير نيست!')

end;

procedure TfrmPersonFish.cmdReadNextClick(Sender: TObject);
begin
  if readOnlineStarted then
  begin
    lblHelp.Caption := 'در حال خواندن اطلاعات از دستگاه';
    txtDate.Text := CurrentDate;
    txtTime.Text := '';
    cmbPCode.ItemIndex := -1;
    pnlType.Caption := '';
    imgPicture.Picture.Bitmap := nil; //kaveh
    tmrReadOnline.Enabled := True;
  end;
end;

procedure TfrmPersonFish.txtLineFeedKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmPersonFish.cmbPCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmd1.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmPersonFish.txtFishManyKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Integer(Key);
end;

end.
