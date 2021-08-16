unit CarStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DB, AdoDB, DosMove, ComCtrls, FarsiApi,
  Buttons;

type
  TfrmCarsStatus = class(TForm)
    grpSearch: TGroupBox;
    dbgMachines: TDBGrid;
    pnlStatus: TPanel;
    DataSource1: TDataSource;
    qryMachines: TAdoQuery;
    edlblNumber: TLabeledEdit;
    edlblCardCode: TLabeledEdit;
    lbl1: TLabel;
    cmbStatus: TComboBox;
    edlblToDate: TLabeledEdit;
    edlblFromDate: TLabeledEdit;
    lbl2: TLabel;
    cmbSort: TComboBox;
    DosMove1: TDosMove;
    StatusBar1: TStatusBar;
    cmbBarCode: TComboBox;
    Label2: TLabel;
    Label8: TLabel;
    txtIDate: TEdit;
    Label5: TLabel;
    txtNumber: TEdit;
    Label12: TLabel;
    txtODate: TEdit;
    cmdCancelFilter: TBitBtn;
    cmbDriver: TComboBox;
    cmbDriverCode: TComboBox;
    Label7: TLabel;
    procedure FormResize(Sender: TObject);
    procedure edlblCardCodeExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure edlblFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure edlblFromDateExit(Sender: TObject);
    procedure edlblToDateExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgMachinesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgMachinesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgMachinesTitleClick(Column: TColumn);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure txtIDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtIDateExit(Sender: TObject);
    procedure txtIDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtODateExit(Sender: TObject);
    procedure txtODateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtODateKeyPress(Sender: TObject; var Key: Char);
    procedure cmdCancelFilterClick(Sender: TObject);
    procedure cmbBarCodeChange(Sender: TObject);
    procedure txtNumberExit(Sender: TObject);
    procedure cmbDriverChange(Sender: TObject);
    procedure cmbDriverKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure SearchData;
  public
    { Public declarations }
  end;

var
  frmCarsStatus: TfrmCarsStatus;

implementation

uses
  Globals, DBS, Keyboard, DateProc;

{$R *.dfm}
procedure TfrmCarsStatus.SearchData;
var
 lastSort : string;
begin
  with qryMachines do
  begin
    lastSort := Sort;
    if Active then
      Close;

    AddRecToMachine;
    SQL.Clear;
//kaveh    SQL.Add('SELECT M_BarCode, M_Number, M_IDate, M_ITime, M_ODate, M_OTime, M_IsPark FROM Machines');
    case cmbStatus.ItemIndex of
      0:
      begin
//kaveh        SQL.Add('WHERE (M_IsPark = ' + IntToStr(CNST_TRUE) + ' OR M_IsPark = ' + IntToStr(CNST_FALSE) + ' )');
        SQL.Add('SELECT l1.M_BarCode, l1.M_Number, l1.M_IDate, l1.M_ITime, l1.M_ODate, l1.M_OTime, NewPersons.P_Family + ''-'' + NewPersons.P_Name AS P_Family_Name ' +
                'FROM (SELECT M_BarCode, M_Number + '' ('' + M_Serial + '')'' AS M_Number, M_IDate, M_ITime, M_ODate, M_OTime, M_IsPark, M_IsDeleted, M_Driver ' +
                'FROM Machines ' +
                'WHERE (M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ') AND (M_EntranceDepart = ' + IntToStr(g_Options.Department) + ') ' +
                'UNION ' +
                'SELECT M_BarCode, M_Number + '' ('' + M_Serial + '')'' AS M_Number, M_IDate, M_ITime, M_ODate, M_OTime, M_IsPark, M_IsDeleted, M_Driver ' +
                'FROM InputCar ' +
                'WHERE (M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ') AND (M_EntranceDepart = ' + IntToStr(g_Options.Department) + ') ' +
                ') l1 LEFT OUTER JOIN ' +
                'NewPersons ON l1.M_Driver = NewPersons.P_Code ');
//        SQL.Add('select * from (SELECT M_BarCode, M_Number, M_IDate, M_ITime, M_ODate,' +
//                ' M_OTime, M_IsPark FROM Machines union SELECT M_BarCode, M_Number,' +
//                ' M_IDate, M_ITime, M_ODate, M_OTime, M_IsPark from InputCar )  l1' );
      end;
      1:
      begin
//kaveh        SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_TRUE));
        SQL.Add('SELECT InputCar.M_BarCode, InputCar.M_Number + '' ('' + InputCar.M_Serial + '')'' AS M_Number, InputCar.M_IDate, InputCar.M_ITime, ' +
                'InputCar.M_ODate, InputCar.M_OTime, InputCar.M_IsPark, InputCar.M_IsDeleted, InputCar.M_Driver, ' +
                'NewPersons.P_Family + ''-'' + NewPersons.P_Name AS P_Family_Name ' +
                'FROM InputCar LEFT OUTER JOIN ' +
                'NewPersons ON InputCar.M_Driver = NewPersons.P_Code ' +
                'WHERE InputCar.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' AND InputCar.M_EntranceDepart = ' + IntToStr(g_Options.Department) + ' ');
//        SQL.Add('SELECT M_BarCode, M_Number,' +
//                ' M_IDate, M_ITime, M_ODate, M_OTime, M_IsPark from InputCar' );
      end;
      2:
      begin
//kaveh        SQL.Add('WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
        SQL.Add('SELECT Machines.M_BarCode, Machines.M_Number + '' ('' + Machines.M_Serial + '')'' AS M_Number, Machines.M_IDate, Machines.M_ITime, ' +
                'Machines.M_ODate, Machines.M_OTime, Machines.M_IsPark, Machines.M_IsDeleted, Machines.M_Driver, ' +
                'NewPersons.P_Family + ''-'' + NewPersons.P_Name AS P_Family_Name ' +
                'FROM Machines LEFT OUTER JOIN ' +
                'NewPersons ON Machines.M_Driver = NewPersons.P_Code ' +
                'WHERE Machines.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' AND Machines.M_EntranceDepart = ' + IntToStr(g_Options.Department) + ' ');
//        SQL.Add('SELECT M_BarCode, M_Number, M_IDate, M_ITime, M_ODate, M_OTime,' +
//                ' M_IsPark FROM Machines' );
      end;
      3:
      begin
        SQL.Add('SELECT InputCar.M_BarCode, InputCar.M_Number + '' ('' + InputCar.M_Serial + '')'' AS M_Number, InputCar.M_IDate, InputCar.M_ITime, ' +
                'InputCar.M_ODate, InputCar.M_OTime, InputCar.M_IsPark, InputCar.M_IsDeleted, InputCar.M_Driver, ' +
                'NewPersons.P_Family + ''-'' + NewPersons.P_Name AS P_Family_Name ' +
                'FROM InputCar LEFT OUTER JOIN ' +
                'NewPersons ON InputCar.M_Driver = NewPersons.P_Code ' +
                'WHERE InputCar.M_IsDeleted <> ' + IntToStr(CNST_TRUE) + ' AND InputCar.M_EntranceDepart = ' + IntToStr(g_Options.Department) + ' AND M_IsPark = ' + IntToStr(CNST_TRUE) + ' ');

//        SQL.Add('SELECT M_BarCode, M_Number, M_IDate, M_ITime, M_ODate, M_OTime, M_IsPark from InputCar WHERE (m_barcode <> '''' AND M_IsPark = ' + inttostr(CNST_TRUE) + ' )');
      end;
    end;

    if cmbStatus.ItemIndex = 0 then
      SQL.Add(' WHERE m_barcode <> ''''');

    if cmbBarCode.Text <> '' then
      SQL.Add(' AND M_BarCode = ''' + cmbBarCode.Text + '''');
//kaveh new    if edlblCardCode.Text <> '' then
//kaveh new      SQL.Add('AND M_BarCode = ''' + edlblCardCode.Text + '''');
    if txtNumber.Text <> '' then
      SQL.Add(' AND M_Number Like ''' + txtNumber.Text + '%''');
//kaveh new    if edlblNumber.Text <> '' then
//kaveh new      SQL.Add('AND M_Number = ''' + edlblNumber.Text + '''');
    if (txtIDate.Text <> '') and (txtODate.Text <> '') then
      begin
        SQL.Add(' AND ((M_IDate between ''' + txtIDate.Text + ''' AND ''' + txtODate.Text + ''' )');
        SQL.Add(' OR (M_ODate between ''' + txtIDate.Text + ''' AND ''' + txtODate.Text + ''' ))');
      end;

    if cmbDriver.ItemIndex <> -1 then
      SQL.Add(' AND M_Driver = ' + cmbDriverCode.Text + ' ');

//kaveh new    if edlblFromDate.Text <> '' then
//kaveh new      SQL.Add('AND (M_IDate between ''' + edlblFromDate.Text + ''' AND ''' + edlblToDate.Text + ''' )');
//kaveh      SQL.Add('AND (M_IDate >= ''' + edlblFromDate.Text + ''' OR M_ODate >= ''' + edlblFromDate.Text + ''')');
//kaveh new    if edlblToDate.Text <> '' then
//kaveh new      SQL.Add('OR (M_ODate between ''' + txtIDate.Text + ''' AND ''' + txtODate.Text + ''' )');
//kaveh new      SQL.Add('OR (M_ODate between ''' + edlblFromDate.Text + ''' AND ''' + edlblToDate.Text + ''' )');
//kaveh      SQL.Add('AND (M_IDate <= ''' + edlblToDate.Text + ''' OR M_ODate <= ''' + edlblToDate.Text + ''')');
{kaveh new    case cmbSort.ItemIndex of
      1 : SQL.Add(' ORDER BY M_BarCode, M_IDate, M_ITime');
      2 : SQL.Add(' ORDER BY M_Number, M_IDate, M_ITime');
      3 : SQL.Add(' ORDER BY M_IDate, M_ITime');
      4 : SQL.Add(' ORDER BY M_ODate, M_OTime');
    end; kaveh}
    Open;
    Sort := lastSort;

    if (edlblNumber.Text = '') and (edlblCardCode.Text = '') then
      pnlStatus.Caption := (' ⁄œ«œ ŒÊœ—ÊÂ« = ') + IntToStr(RecordCount)
    else if RecordCount > 0 then
    begin
      Last;
      if FieldByName('M_IsPark').AsBoolean then
        pnlStatus.Caption := ('ŒÊœ—Ê œ— Å«—ﬂÌ‰ê „Ìù»«‘œ')
      else
        pnlStatus.Caption := ('ŒÊœ—Ê Œ«—Ã ‘œÂ «” ');

    end
    else
      pnlStatus.Caption := ('ŒÊœ—ÊÌÌ ÊÃÊœ ‰œ«—œ');
  end;
end;

procedure TfrmCarsStatus.txtIDateExit(Sender: TObject);
begin
  if txtIDate.Text <> '' then
    txtIDate.Text := BeautifulDate(txtIDate.Text);
  SearchData;
end;

procedure TfrmCarsStatus.txtIDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtIDate.Text := CurrentDate;
  end;
end;

procedure TfrmCarsStatus.txtIDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCarsStatus.txtNumberExit(Sender: TObject);
begin
  SearchData;
end;

procedure TfrmCarsStatus.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmCarsStatus.txtODateExit(Sender: TObject);
begin
  if txtODate.Text <> '' then
    txtODate.Text := BeautifulDate(txtODate.Text);
  SearchData;
end;

procedure TfrmCarsStatus.txtODateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtODate.Text := CurrentDate;
  end;
end;

procedure TfrmCarsStatus.txtODateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCarsStatus.FormResize(Sender: TObject);
var
  w : Integer;
  i : Byte;
begin
  w := (dbgMachines.Width-40) div 7;
  for i := 0 to dbgMachines.Columns.Count-1 do
    dbgMachines.Columns[i].Width := w;

{kaveh new  edlblCardCode.Left := grpSearch.Width - 140;
  edlblNumber.Left := (grpSearch.Width div 2) - 50;

  edlblFromDate.Left := edlblCardCode.Left;
  edlblToDate.Left := edlblNumber.Left;  kaveh new}
end;

procedure TfrmCarsStatus.FormCreate(Sender: TObject);
var i : Byte;
    qry : TAdoQuery;
begin
  Caption := (Caption);
  grpSearch.Caption := (grpSearch.Caption);
  edlblCardCode.EditLabel.Caption := (edlblCardCode.EditLabel.Caption);
  edlblNumber.EditLabel.Caption := (edlblNumber.EditLabel.Caption);
  lbl1.Caption := (lbl1.Caption);


  //SetDirectionFarsi(cmbName.Handle);
  //SetDirectionFarsi(cmbColor.Handle);
  SetDirectionFarsi(txtNumber.Handle);
  //SetDirectionFarsi(cmbCity.Handle);
  //SetDirectionFarsi(cmbIDoor.Handle);
  //SetDirectionFarsi(cmbIPerson.Handle);
  //SetDirectionFarsi(cmbODoor.Handle);
  //SetDirectionFarsi(cmbOPerson.Handle);

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT Card_Code FROM BarCodes WHERE Card_State = ' + IntToStr(MB_NORMAL));
  qry.Open;
  while not qry.EOF do
  begin
    cmbBarCode.Items.Add((qry.FieldByName('Card_Code').AsString));
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_Code, P_Name, P_Family ');
  qry.SQL.Add('FROM NewPersons ');
//  qry.SQL.Add('SELECT P_Code,P_Name,P_Family FROM NewPersons');
//  qry.SQL.Add('WHERE (P_Depart <> ' + IntToStr(g_Options.Department) + ') OR (P_Depart is NULL) ');
  qry.SQL.Add('ORDER BY P_Family, P_Name, P_Code ');
  qry.Open;
  while not qry.EOF do
  begin
    cmbDriver.Items.Add(qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString + ' (' + qry.FieldByName('P_Code').AsString + ')' );
    cmbDriverCode.Items.Add(qry.FieldByName('P_Code').AsString);
    qry.Next;
  end;
  qry.Close;

  for i := 0 to cmbStatus.Items.Count-1 do
    cmbStatus.Items.Strings[i] := (cmbStatus.Items.Strings[i]);
  cmbStatus.ItemIndex := 0;
  edlblFromDate.EditLabel.Caption := (edlblFromDate.EditLabel.Caption);
  edlblToDate.EditLabel.Caption := (edlblToDate.EditLabel.Caption);
  lbl2.Caption := (lbl2.Caption);
  for i := 0 to cmbSort.Items.Count-1 do
    cmbSort.Items.Strings[i] := (cmbSort.Items.Strings[i]);
  cmbSort.ItemIndex := 3;
  for i := 0 to dbgMachines.Columns.Count-1 do
    dbgMachines.Columns[i].Title.Caption := (dbgMachines.Columns[i].Title.Caption); 
  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
  qry.Free;
end;

procedure TfrmCarsStatus.FormActivate(Sender: TObject);
begin
  qryMachines.connection := frmDBS.adoConnect;
  edlblFromDate.Text := CurrentDate;
  edlblToDate.Text := CurrentDate;
  txtIDate.Text := CurrentDate; //kaveh i
  txtODate.Text := CurrentDate; //kaveh i
  cmbDriver.ItemIndex := -1;
  cmbDriverCode.ItemIndex := -1;
  SearchData;
end;

//kaveh is
procedure TfrmCarsStatus.cmbBarCodeChange(Sender: TObject);
begin
  SearchData;
end;

procedure TfrmCarsStatus.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Hex(Key);
end;

procedure TfrmCarsStatus.cmbDriverChange(Sender: TObject);
begin
  cmbDriverCode.ItemIndex := cmbDriver.ItemIndex;
  SearchData;
end;

procedure TfrmCarsStatus.cmbDriverKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Shift = []) then
    begin
      cmbDriver.ItemIndex := -1;
      cmbDriverCode.ItemIndex := -1;
      SearchData;
    end;
end;

procedure TfrmCarsStatus.cmdCancelFilterClick(Sender: TObject);
begin
    if (cmbBarCode.ItemIndex > -1) or (txtNumber.Text <> '') or (txtIDate.Text <> '') or (txtODate.Text <> '') then
     begin
      cmbBarCode.ItemIndex := -1;
      txtNumber.Text := '';
      txtIDate.Text := CurrentDate;
      txtODate.Text := CurrentDate;
      cmbDriver.ItemIndex := -1;
      cmbDriverCode.ItemIndex := -1;
      SearchData;
     end;
end;

procedure TfrmCarsStatus.dbgMachinesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  iValue:Byte;
begin
    iValue := dbgMachines.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgMachines.canvas.brush.color :=ClBlue;
      dbgMachines.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgMachines.Canvas.Brush.Color := $00D1D9DC;
      0: dbgMachines.Canvas.Brush.Color := clWhite;
    end;
    dbgMachines.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
//kaveh ie

//kaveh is
procedure TfrmCarsStatus.dbgMachinesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
const selectedTitelColor = clWindow;
var
  pt: TGridcoord;
  columensLeft : Integer;
  function clbtncol():Boolean;
  begin
    TDBGrid(dbgMachines).Columns[6].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[5].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[4].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[3].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[2].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgMachines).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgMachines.MouseCoord(x, y);
  if pt.y=0 then
   begin
    columensLeft := dbgMachines.Width - (TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width +
                                       TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width +
                                       TDBGrid(dbgMachines).Columns[2].Width + TDBGrid(dbgMachines).Columns[1].Width +
                                       TDBGrid(dbgMachines).Columns[0].Width + 39);
//    dbgMachines.Cursor:=crHandPoint;
    if (x > columensLeft) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[6].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[6].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[5].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[5].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[4].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[4].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[3].Title.Color := selectedTitelColor;
    end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[3].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width + TDBGrid(dbgMachines).Columns[2].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[2].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[2].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width + TDBGrid(dbgMachines).Columns[2].Width + TDBGrid(dbgMachines).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[1].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgMachines).Columns[1].Width) and (x < columensLeft + TDBGrid(dbgMachines).Columns[6].Width + TDBGrid(dbgMachines).Columns[5].Width + TDBGrid(dbgMachines).Columns[4].Width + TDBGrid(dbgMachines).Columns[3].Width + TDBGrid(dbgMachines).Columns[2].Width + TDBGrid(dbgMachines).Columns[1].Width + TDBGrid(dbgMachines).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgMachines).Columns[0].Title.Color := selectedTitelColor;
     end;

   end
  else
   begin
    dbgMachines.Cursor:=crDefault;
    clbtncol();
   end;
end;
//kaveh ie

//kaveh is
procedure TfrmCarsStatus.dbgMachinesTitleClick(Column: TColumn);
var i: integer;
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
   qryMachines.Sort := Column.FieldName + ' DESC';
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
   qryMachines.Sort := Column.FieldName + ' ASC';
//   SearchData(Column,False);
   for i:=0 to TDBGrid(Column.Grid).Columns.Count-1 do
    begin
      TDBGrid(Column.Grid).Columns[i].Title.Font.Style:=[];
      TDBGrid(Column.Grid).Columns[i].Title.Font.Color:= clWindowText;
    end;
   Column.Title.Font.Style:=[fsbold];
   Column.Title.Font.Color:= clBlue;
  end;
end;
//kaveh ie

procedure TfrmCarsStatus.edlblCardCodeExit(Sender: TObject);
begin
  SearchData;
end;

procedure TfrmCarsStatus.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  qryMachines.Close;
  DelRecFromMachine;
end;

procedure TfrmCarsStatus.FormDestroy(Sender: TObject);
begin
  qryMachines.Close;
  DelRecFromMachine;
end;

procedure TfrmCarsStatus.edlblFromDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCarsStatus.edlblFromDateExit(Sender: TObject);
begin
  if edlblFromDate.Text <> '' then
    edlblFromDate.Text := BeautifulDate(edlblFromDate.Text);
  SearchData;
end;

procedure TfrmCarsStatus.edlblToDateExit(Sender: TObject);
begin
  if edlblToDate.Text <> '' then
    edlblToDate.Text := BeautifulDate(edlblToDate.Text);
  SearchData;
end;

end.
