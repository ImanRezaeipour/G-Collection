unit CarType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, Keyboard, DBS, TimeTool, DateProc, ComCtrls;

type
  TfrmCarTypes = class(TForm)
    grpAll: TGroupBox;
    dbgTypes: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    txtTypeCode: TEdit;
    txtTypeName: TEdit;
    Label2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaTypes: TDataSource;
    tblTypes: TAdoTable;
    tblTypesType_Code: TSmallintField;
    tblTypesType_Name: TStringField;
    tblTypesType_Vorood: TCurrencyField;
    tblTypesType_FirstPrice: TCurrencyField;
    tblTypesType_FirstTime1: TSmallintField;
    tblTypesType_SecondTime: TIntegerField;
    tblTypesType_SecondTime2: TSmallintField;
    tblTypesType_SecondPrice: TCurrencyField;
    tblTypesType_LastTime: TIntegerField;
    tblTypesType_LastTime3: TSmallintField;
    tblTypesType_LastPrice: TCurrencyField;
    tblTypesType_FirstTime: TIntegerField;
    chkDefault: TCheckBox;
    tblTypesType_FirstRounding: TSmallintField;
    tblTypesType_SecondIsFirst: TBooleanField;
    tblTypesType_SecondRounding: TSmallintField;
    tblTypesType_LastIsFirst: TBooleanField;
    tblTypesType_LastRounding: TSmallintField;
    grpPrice: TGroupBox;
    Label17: TLabel;
    txtVorood: TEdit;
    Label18: TLabel;
    cmbLastRounding: TComboBox;
    cmbSecondRounding: TComboBox;
    cmbFirstRounding: TComboBox;
    chkSecondIsFirst: TCheckBox;
    chkLastIsFirst: TCheckBox;
    Label16: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    txtFirstPrice: TEdit;
    txtSecondPrice: TEdit;
    txtLastPrice: TEdit;
    Label15: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    txtFirstTime1: TEdit;
    txtSecondTime2: TEdit;
    txtLastTime3: TEdit;
    Label14: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    txtFirstTime: TEdit;
    txtSecondTime: TEdit;
    txtLastTime: TEdit;
    Label13: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    txtThirdTime: TEdit;
    Label9: TLabel;
    txtThirdTime3: TEdit;
    Label19: TLabel;
    txtThirdPrice: TEdit;
    Label20: TLabel;
    chkThirdIsFirst: TCheckBox;
    cmbThirdRounding: TComboBox;
    tblTypesType_ThirdTime: TIntegerField;
    tblTypesType_ThirdTime3: TSmallintField;
    tblTypesType_ThirdIsFirst: TBooleanField;
    tblTypesType_ThirdRounding: TSmallintField;
    tblTypesType_ThirdPrice: TCurrencyField;
    tblTypesType_DailyPrice: TCurrencyField;
    Label21: TLabel;
    txtdailyprice: TEdit;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtTypeCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtTypeNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtVoroodKeyPress(Sender: TObject; var Key: Char);
    procedure txtFirstTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtFirstTime1KeyPress(Sender: TObject; var Key: Char);
    procedure txtFirstPriceKeyPress(Sender: TObject; var Key: Char);
    procedure txtSecondTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgTypesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure txtSecondTime2KeyPress(Sender: TObject; var Key: Char);
    procedure txtSecondPriceKeyPress(Sender: TObject; var Key: Char);
    procedure txtLastTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtLastTime3KeyPress(Sender: TObject; var Key: Char);
    procedure txtLastPriceKeyPress(Sender: TObject; var Key: Char);
    procedure chkDefaultKeyPress(Sender: TObject; var Key: Char);
    procedure chkSecondIsFirstKeyPress(Sender: TObject; var Key: Char);
    procedure cmbSecondRoundingKeyPress(Sender: TObject; var Key: Char);
    procedure txtThirdTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtThirdTime3KeyPress(Sender: TObject; var Key: Char);
    procedure txtThirdPriceKeyPress(Sender: TObject; var Key: Char);
    procedure chkThirdIsFirstKeyPress(Sender: TObject; var Key: Char);
    procedure cmbThirdRoundingKeyPress(Sender: TObject; var Key: Char);
    procedure cmbLastRoundingKeyPress(Sender: TObject; var Key: Char);
    procedure chkLastIsFirstKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFirstRoundingKeyPress(Sender: TObject; var Key: Char);
    procedure txtdailypriceKeyPress(Sender: TObject; var Key: Char);
    procedure dbgTypesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgTypesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgTypesTitleClick(Column: TColumn);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    procedure ClearScrFields;
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmCarTypes.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  chkDefault.Caption := (chkDefault.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblTypesType_Code.DisplayLabel := (tblTypesType_Code.DisplayLabel);
  tblTypesType_Name.DisplayLabel := (tblTypesType_Name.DisplayLabel);
  Label17.Caption := (Label17.Caption);
  Label18.Caption := (Label18.Caption);
  Label8.Caption := (Label8.Caption);
  Label5.Caption := (Label5.Caption);
  Label13.Caption := (Label13.Caption);
  Label4.Caption := (Label4.Caption);
  Label3.Caption := (Label3.Caption);
  Label6.Caption := (Label6.Caption);
  Label14.Caption := (Label14.Caption);
  Label9.Caption := (Label9.Caption);
  Label10.Caption := (Label10.Caption);
  Label11.Caption := (Label11.Caption);
  Label15.Caption := (Label15.Caption);
  Label19.Caption := (Label19.Caption);
  Label7.Caption := (Label7.Caption);
  Label12.Caption := (Label12.Caption);
  Label16.Caption := (Label16.Caption);
  Label20.Caption := (Label20.Caption);
  Label21.Caption := (Label21.Caption);
  chkSecondIsFirst.Caption := (chkSecondIsFirst.Caption);
  chkThirdIsFirst.Caption := (chkThirdIsFirst.Caption);
  chkLastIsFirst.Caption := (chkLastIsFirst.Caption);
  for i := 0 to cmbFirstRounding.Items.Count - 1 do
    cmbFirstRounding.Items.Strings[i] := (cmbFirstRounding.Items.Strings[i]);
  for i := 0 to cmbSecondRounding.Items.Count - 1 do
    cmbSecondRounding.Items.Strings[i] := (cmbSecondRounding.Items.Strings[i]);
  for i := 0 to cmbThirdRounding.Items.Count - 1 do
    cmbThirdRounding.Items.Strings[i] := (cmbThirdRounding.Items.Strings[i]);
  for i := 0 to cmbLastRounding.Items.Count - 1 do
    cmbLastRounding.Items.Strings[i] := (cmbLastRounding.Items.Strings[i]);
end;

procedure TfrmCarTypes.FormInEdit(vis : Boolean);
begin
  grpAll.Visible := not vis;
  grpEdit.Visible := vis;

  if vis then
    Height := grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 45; 
end;

procedure TfrmCarTypes.ClearScrFields;
begin
  txtTypeCode.Text := '';
  txtTypeName.Text := '';
  txtVorood.Text := '1000';
  txtFirstTime.Text := '23:59';
  txtFirstTime1.Text := '60';
  txtFirstPrice.Text := '1000';
  txtSecondTime.Text := '23:59';
  txtSecondTime2.Text := '5';
  txtSecondPrice.Text := '0';
  txtThirdTime.Text := '23:59';
  txtThirdTime3.Text := '5';
  txtThirdPrice.Text := '0';
  txtLastTime.Text := '23:59';
  txtLastTime3.Text := '5';
  txtLastPrice.Text := '0';
  txtDailyPrice.Text := '20000';
end;

function TfrmCarTypes.AreValidFields : Boolean;
begin
  if txtTypeCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ‰Ê⁄ Ê«—œ ‰‘œÂ «” .');
    txtTypeCode.SetFocus;
  end
  else if txtTypeName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰Ê⁄ ŒÊœ—Ê Ê«—œ ‰‘œÂ «” .');
    txtTypeName.SetFocus;
  end
  else if (txtVorood.Text = '')
      and (txtFirstPrice.Text = '') and (txtSecondPrice.Text = '')
      and (txtThirdPrice.Text = '') and (txtLastPrice.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('ÂÌç ‰—ŒÌ  ⁄ÌÌ‰ ‰‘œÂ «” .');
    txtVorood.SetFocus;
  end
  else if (txtFirstPrice.Text <> '') and
    ((txtFirstTime1.Text = '') or (StrToInt(txtFirstTime1.Text) = 0)) then
  begin
    AreValidFields := False;
    ErrorMessage('“„«‰ „⁄ »— ‰Ì” .');
    txtFirstTime1.SetFocus;
  end
  else if not istruetime(txtfirsttime.text)
  then begin
    AreValidFields := False;
    ErrorMessage('“„«‰ „⁄ »— ‰Ì” .');
    txtFirstTime.SetFocus;
  end
  else if (txtSecondPrice.Text <> '') and
    ((txtSecondTime2.Text = '') or (StrToInt(txtSecondTime2.Text) = 0)) then
  begin
    AreValidFields := False;
    ErrorMessage('“„«‰ „⁄ »— ‰Ì” .');
    txtSecondTime2.SetFocus;
  end
  else if not istruetime(txtSecondTime.text)
  then begin
    AreValidFields := False;
    ErrorMessage('“„«‰ „⁄ »— ‰Ì” .');
    txtSecondTime.SetFocus;
  end
  else if (txtThirdPrice.Text <> '') and
    ((txtThirdTime3.Text = '') or (StrToInt(txtThirdTime3.Text) = 0)) then
  begin
    AreValidFields := False;
    ErrorMessage('“„«‰ „⁄ »— ‰Ì” .');
    txtThirdTime3.SetFocus;
  end
  else if not istruetime(txtThirdTime.text)
  then begin
    AreValidFields := False;
    ErrorMessage('“„«‰ „⁄ »— ‰Ì” .');
    txtThirdTime.SetFocus;
  end
  else if (txtLastPrice.Text <> '') and
    ((txtLastTime3.Text = '') or (StrToInt(txtLastTime3.Text) = 0)) then
  begin
    AreValidFields := False;
    ErrorMessage('“„«‰ „⁄ »— ‰Ì” .');
    txtLastTime3.SetFocus;
  end
  else if not istruetime(txtLastTime.text)
  then begin
    AreValidFields := False;
    ErrorMessage('“„«‰ „⁄ »— ‰Ì” .');
    txtLastTime.SetFocus;
  end
  else if (txtDailyPrice.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('‰—Œ ‘»«‰Â —Ê“ Ê«—œ ‰‘œÂ «” .');
    txtDailyprice.SetFocus;
  end
  else if IsExistsRec_Num('CarTypes', 'Type_Code', StrToInt(txtTypeCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblTypes.FieldByName('Type_Code').AsString <> txtTypeCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ ‰Ê⁄  ﬂ—«—Ì «” .');
    txtTypeCode.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmCarTypes.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtTypeName.Handle);
  tblTypes.connection := frmDBS.adoConnect;
  FormInEdit(False);
  tblTypes.Open;
  Top := 80;
  grpEdit.Align := alTop;
end;

procedure TfrmCarTypes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblTypes.Close;
  Load_Cars_Type;
end;


procedure TfrmCarTypes.dbgTypesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var //kaveh is
  iValue:Byte;
begin
    iValue := dbgTypes.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgTypes.canvas.brush.color :=ClBlue;
      dbgTypes.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgTypes.Canvas.Brush.Color := $00D1D9DC;
      0: dbgTypes.Canvas.Brush.Color := clWhite;
    end;
    dbgTypes.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//kaveh ie
end;

procedure TfrmCarTypes.dbgTypesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmCarTypes.dbgTypesMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const selectedTitelColor = clWindow; //kaveh is
var
  pt: TGridcoord;
  columensLeft : Integer;
  function clbtncol():Boolean;
  begin
{    TDBGrid(dbgTypes).Columns[6].Title.Color := clBtnFace;
    TDBGrid(dbgTypes).Columns[5].Title.Color := clBtnFace;
    TDBGrid(dbgTypes).Columns[4].Title.Color := clBtnFace;
    TDBGrid(dbgTypes).Columns[3].Title.Color := clBtnFace;
    TDBGrid(dbgTypes).Columns[2].Title.Color := clBtnFace; }
    TDBGrid(dbgTypes).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgTypes).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgTypes.MouseCoord(x, y);
  if pt.y=0 then
   begin
    columensLeft := dbgTypes.Width - ({TDBGrid(dbgTypes).Columns[6].Width + TDBGrid(dbgTypes).Columns[5].Width +
                                       TDBGrid(dbgTypes).Columns[4].Width + TDBGrid(dbgTypes).Columns[3].Width +
                                       TDBGrid(dbgTypes).Columns[2].Width +} TDBGrid(dbgTypes).Columns[1].Width +
                                       TDBGrid(dbgTypes).Columns[0].Width + 39);
//    dbgTypes.Cursor:=crHandPoint;
    if (x > columensLeft) and (x < columensLeft + TDBGrid(dbgTypes).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgTypes).Columns[1].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgTypes).Columns[1].Width) and (x < columensLeft + TDBGrid(dbgTypes).Columns[1].Width + TDBGrid(dbgTypes).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgTypes).Columns[0].Title.Color := selectedTitelColor;
    end
{
    else if (x > columensLeft + TDBGrid(dbgTypes).Columns[5].Width) and (x < columensLeft + TDBGrid(dbgTypes).Columns[6].Width + TDBGrid(dbgTypes).Columns[5].Width + TDBGrid(dbgTypes).Columns[4].Width) then
     begin
       clbtncol();
       TDBGrid(dbgTypes).Columns[4].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgTypes).Columns[4].Width) and (x < columensLeft + TDBGrid(dbgTypes).Columns[6].Width + TDBGrid(dbgTypes).Columns[5].Width + TDBGrid(dbgTypes).Columns[4].Width + TDBGrid(dbgTypes).Columns[3].Width) then
     begin
       clbtncol();
       TDBGrid(dbgTypes).Columns[3].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgTypes).Columns[3].Width) and (x < columensLeft + TDBGrid(dbgTypes).Columns[6].Width + TDBGrid(dbgTypes).Columns[5].Width + TDBGrid(dbgTypes).Columns[4].Width + TDBGrid(dbgTypes).Columns[3].Width + TDBGrid(dbgTypes).Columns[2].Width) then
     begin
       clbtncol();
       TDBGrid(dbgTypes).Columns[2].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgTypes).Columns[2].Width) and (x < columensLeft + TDBGrid(dbgTypes).Columns[6].Width + TDBGrid(dbgTypes).Columns[5].Width + TDBGrid(dbgTypes).Columns[4].Width + TDBGrid(dbgTypes).Columns[3].Width + TDBGrid(dbgTypes).Columns[2].Width + TDBGrid(dbgTypes).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgTypes).Columns[1].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgTypes).Columns[1].Width) and (x < columensLeft + TDBGrid(dbgTypes).Columns[6].Width + TDBGrid(dbgTypes).Columns[5].Width + TDBGrid(dbgTypes).Columns[4].Width + TDBGrid(dbgTypes).Columns[3].Width + TDBGrid(dbgTypes).Columns[2].Width + TDBGrid(dbgTypes).Columns[1].Width + TDBGrid(dbgTypes).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgTypes).Columns[0].Title.Color := selectedTitelColor;
     end;  }

   end
  else
   begin
    dbgTypes.Cursor:=crDefault;
    clbtncol();
   end;
   
//kaveh ie
end;

procedure TfrmCarTypes.dbgTypesTitleClick(Column: TColumn);
var i: integer; //kaveh is
begin
{ with qryInput do
 begin
   if Active then
    Close;

   SQL.Clear;
   SQL.Add('SELECT M_BarCode, M_Number, M_Serial, M_IDate, M_ITime, M_IsPark FROM InputCar');
   if DESC then
    SQL.Add('ORDER BY ' + ColumnT.FieldName + ' desc')
   else
    SQL.Add('ORDER BY ' + ColumnT.FieldName);
   Open;
 end;   }

//kaveh new  SearchData(Column,True);
 if (Column.Title.Font.Style = [fsbold]) and (Column.Title.Font.Color = clBlue)then
  begin
   tblTypes.Sort := Column.FieldName + ' DESC';
//   SearchData(Column,True);
   for i:=0 to TDBGrid(Column.Grid).Columns.Count-1 do
    begin
     TDBGrid(Column.Grid).Columns[i].Title.Font.Style:=[];
     TDBGrid(Column.Grid).Columns[i].Title.Font.Color:= clWindowText;
    end;
   Column.Title.Font.Style:=[fsbold];
   Column.Title.Font.Color:= clred;
  end
 else
  begin 
   tblTypes.Sort := Column.FieldName + ' ASC';
//   SearchData(Column,False);
   for i:=0 to TDBGrid(Column.Grid).Columns.Count-1 do
    begin
      TDBGrid(Column.Grid).Columns[i].Title.Font.Style:=[];
      TDBGrid(Column.Grid).Columns[i].Title.Font.Color:= clWindowText;
    end;
   Column.Title.Font.Style:=[fsbold];
   Column.Title.Font.Color:= clBlue;
  end;
  
//kaveh ie
end;


procedure TfrmCarTypes.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearScrFields;
  txtTypeCode.Text := IntToStr(GetNewNumber('CarTypes', 'Type_Code'));
  txtTypeCode.SetFocus;
  if tblTypes.RecordCount = 0 then
    chkDefault.Checked := True; 
end;

procedure TfrmCarTypes.cmdEditClick(Sender: TObject);
begin
  if not tblTypes.EOF then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtTypeCode.Text := IntToStr(tblTypes.FieldByName('Type_Code').AsInteger);
    txtTypeName.Text := tblTypes.FieldByName('Type_Name').AsString;
    if g_options.DefaultType = tblTypes.FieldByName('Type_Code').AsInteger then
      chkDefault.Checked := True
    else
      chkDefault.Checked := False;

    txtVorood.Text := FloatToStr(tblTypes.FieldByName('Type_Vorood').AsCurrency);

    txtFirstTime.Text := IntToTime(tblTypes.FieldByName('Type_FirstTime').AsInteger);
    txtFirstTime1.Text := IntToStr(tblTypes.FieldByName('Type_FirstTime1').AsInteger);
    txtFirstPrice.Text := FloatToStr(tblTypes.FieldByName('Type_FirstPrice').AsCurrency);
    cmbFirstRounding.ItemIndex := tblTypes.FieldByName('Type_FirstRounding').AsInteger;

    txtSecondTime.Text := IntToTime(tblTypes.FieldByName('Type_SecondTime').AsInteger);
    txtSecondTime2.Text := IntToStr(tblTypes.FieldByName('Type_SecondTime2').AsInteger);
    txtSecondPrice.Text := FloatToStr(tblTypes.FieldByName('Type_SecondPrice').AsCurrency);
    chkSecondIsFirst.Checked := tblTypes.FieldByName('Type_SecondIsFirst').AsBoolean;
    cmbSecondRounding.ItemIndex := tblTypes.FieldByName('Type_SecondRounding').AsInteger;

    txtThirdTime.Text := IntToTime(tblTypes.FieldByName('Type_ThirdTime').AsInteger);
    txtThirdTime3.Text := IntToStr(tblTypes.FieldByName('Type_ThirdTime3').AsInteger);
    txtThirdPrice.Text := FloatToStr(tblTypes.FieldByName('Type_ThirdPrice').AsCurrency);
    chkThirdIsFirst.Checked := tblTypes.FieldByName('Type_ThirdIsFirst').AsBoolean;
    cmbThirdRounding.ItemIndex := tblTypes.FieldByName('Type_ThirdRounding').AsInteger;

    txtLastTime.Text := IntToTime(tblTypes.FieldByName('Type_LastTime').AsInteger);
    txtLastTime3.Text := IntToStr(tblTypes.FieldByName('Type_LastTime3').AsInteger);
    txtLastPrice.Text := FloatToStr(tblTypes.FieldByName('Type_LastPrice').AsCurrency);
    chkLastIsFirst.Checked := tblTypes.FieldByName('Type_LastIsFirst').AsBoolean;
    cmbLastRounding.ItemIndex := tblTypes.FieldByName('Type_LastRounding').AsInteger;

    txtdailyPrice.Text := FloatToStr(tblTypes.FieldByName('Type_DailyPrice').AsCurrency);

    txtTypeCode.SetFocus;
  end;
end;

procedure TfrmCarTypes.cmdDeleteClick(Sender: TObject);
begin
  if not tblTypes.EOF then
  begin
    if not InCircleCarType(tblTypes.FieldByName('Type_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ‰Ê⁄ ŒÊœ—Ê «ÿ„Ì‰«‰ œ«—Ìœø') then
        tblTypes.Delete;
    end
    else
      InformationMessage('«Ì‰ ‰Ê⁄ ŒÊœ—Ê œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmCarTypes.txtTypeCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtTypeName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.txtTypeNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkDefault.SetFocus;
  end;
end;

procedure TfrmCarTypes.chkDefaultKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if grpPrice.Visible then
      txtVorood.SetFocus
    else
      cmdSave.SetFocus;
  end;
end;

procedure TfrmCarTypes.txtVoroodKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtFirstTime.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.txtFirstTimeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtFirstTime1.SetFocus;
  end
  else
    Keyboard_Time(Key);
end;

procedure TfrmCarTypes.txtFirstTime1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtFirstPrice.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.txtFirstPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbFirstRounding.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.cmbFirstRoundingKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtSecondTime.SetFocus;
  end;
end;

procedure TfrmCarTypes.txtSecondTimeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtSecondTime2.SetFocus;
  end
  else
    Keyboard_Time(Key);
end;

procedure TfrmCarTypes.txtSecondTime2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtSecondPrice.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.txtSecondPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSecondIsFirst.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.chkSecondIsFirstKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbSecondRounding.SetFocus;
  end;
end;

procedure TfrmCarTypes.cmbSecondRoundingKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtThirdTime.SetFocus;
  end;
end;

procedure TfrmCarTypes.txtThirdTimeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtThirdTime3.SetFocus;
  end
  else
    Keyboard_Time(Key);
end;

procedure TfrmCarTypes.txtThirdTime3KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtThirdPrice.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.txtThirdPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkThirdIsFirst.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.chkThirdIsFirstKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbThirdRounding.SetFocus;
  end;
end;

procedure TfrmCarTypes.cmbThirdRoundingKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtLastTime.SetFocus;
  end;
end;

procedure TfrmCarTypes.txtLastTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtLastTime3.SetFocus;
  end
  else
    Keyboard_Time(Key);
end;

procedure TfrmCarTypes.txtLastTime3KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtLastPrice.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.txtLastPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkLastIsFirst.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmCarTypes.chkLastIsFirstKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbLastRounding.SetFocus;
  end;
end;

procedure TfrmCarTypes.cmbLastRoundingKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtdailyprice.SetFocus;
  end;
end;

procedure TfrmCarTypes.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblTypes.Append
    else if Flag = MB_EDIT then
    begin
      if tblTypes.FieldByName('Type_Code').AsInteger <> StrToInt(txtTypeCode.Text) then
        ChangeDBSNum('Cars', 'Car_Type', tblTypes.FieldByName('Type_Code').AsInteger, StrToInt(txtTypeCode.Text));
      tblTypes.Edit;
    end;
    tblTypes.FieldByName('Type_Code').AsInteger := StrToInt(txtTypeCode.Text);
    tblTypes.FieldByName('Type_Name').AsString := txtTypeName.Text;
     if txtVorood.Text <> '' then
       tblTypes.FieldByName('Type_Vorood').AsCurrency := StrToFloat(txtVorood.Text);

     if txtFirstTime.Text <> '' then
       tblTypes.FieldByName('Type_FirstTime').AsInteger := TimeToInt(txtFirstTime.Text);
     if txtFirstTime1.Text <> '' then
       tblTypes.FieldByName('Type_FirstTime1').AsInteger := StrToInt(txtFirstTime1.Text);
     if txtFirstPrice.Text <> '' then
       tblTypes.FieldByName('Type_FirstPrice').AsCurrency := StrToFloat(txtFirstPrice.Text);
    tblTypes.FieldByName('Type_FirstRounding').AsInteger := cmbFirstRounding.ItemIndex;

     if txtSecondTime.Text <> '' then
       tblTypes.FieldByName('Type_SecondTime').AsInteger := TimeToInt(txtSecondTime.Text);
     if txtSecondTime2.Text <> '' then
       tblTypes.FieldByName('Type_SecondTime2').AsInteger := StrToInt(txtSecondTime2.Text);
     if txtSecondPrice.Text <> '' then
       tblTypes.FieldByName('Type_SecondPrice').AsCurrency := StrToFloat(txtSecondPrice.Text);
    tblTypes.FieldByName('Type_SecondIsFirst').AsBoolean := chkSecondIsFirst.Checked;
    tblTypes.FieldByName('Type_SecondRounding').AsInteger := cmbSecondRounding.ItemIndex;

     if txtThirdTime.Text <> '' then
       tblTypes.FieldByName('Type_ThirdTime').AsInteger := TimeToInt(txtThirdTime.Text);
     if txtThirdTime3.Text <> '' then
       tblTypes.FieldByName('Type_ThirdTime3').AsInteger := StrToInt(txtThirdTime3.Text);
     if txtThirdPrice.Text <> '' then
       tblTypes.FieldByName('Type_ThirdPrice').AsCurrency := StrToFloat(txtThirdPrice.Text);
    tblTypes.FieldByName('Type_ThirdIsFirst').AsBoolean := chkThirdIsFirst.Checked;
    tblTypes.FieldByName('Type_ThirdRounding').AsInteger := cmbThirdRounding.ItemIndex;

     if txtLastTime.Text <> '' then
       tblTypes.FieldByName('Type_LastTime').AsInteger := TimeToInt(txtLastTime.Text);
     if txtLastTime3.Text <> '' then
       tblTypes.FieldByName('Type_LastTime3').AsInteger := StrToInt(txtLastTime3.Text);
     if txtLastPrice.Text <> '' then
       tblTypes.FieldByName('Type_LastPrice').AsCurrency := StrToFloat(txtLastPrice.Text);
    tblTypes.FieldByName('Type_LastIsFirst').AsBoolean := chkLastIsFirst.Checked;
    tblTypes.FieldByName('Type_LastRounding').AsInteger := cmbLastRounding.ItemIndex;

    tblTypes.FieldByName('Type_DailyPrice').AsCurrency := StrToFloat(txtDailyPrice.Text);

    tblTypes.Post;

    if chkDefault.Checked = True then
    begin
      g_options.DefaultType := tblTypes.FieldByName('Type_Code').AsInteger;
      SaveIniFile;
    end;


    if Flag = MB_NEW then
    begin
      ClearScrFields;
      txtTypeCode.Text := IntToStr(GetNewNumber('CarTypes', 'Type_Code'));
      txtTypeCode.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgTypes.SetFocus;
    end;
  end;
end;

procedure TfrmCarTypes.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgTypes.SetFocus;
end;

procedure TfrmCarTypes.txtdailypriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdsave.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

end.
