unit Cars;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS, ExtCtrls, ComCtrls;

type
  TfrmCars = class(TForm)
    grpAll: TGroupBox;
    dbgCars: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    txtName: TEdit;
    txtCode: TEdit;
    Label2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaCars: TDataSource;
    tblCars: TAdoTable;
    Label3: TLabel;
    cmbTypeCode: TComboBox;
    cmbTypeName: TComboBox;
    Label4: TLabel;
    txtSearch: TEdit;
    Bevel1: TBevel;
    tblCarsCar_Name: TStringField;
    tblCarsCar_Code: TSmallintField;
    tblCarsCar_Type: TSmallintField;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgCarsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmbTypeCodeClick(Sender: TObject);
    procedure cmbTypeNameClick(Sender: TObject);
    procedure cmbTypeCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure txtSearchChange(Sender: TObject);
    procedure dbgCarsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgCarsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgCarsTitleClick(Column: TColumn);
  private
    { Private declarations }
    Flag : Byte;

    procedure ReadData;
    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmCars.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblCarsCar_Name.DisplayLabel := (tblCarsCar_Name.DisplayLabel);
  tblCarsCar_Code.DisplayLabel := (tblCarsCar_Code.DisplayLabel);
end;

procedure TfrmCars.ReadData;
begin
  if cmbTypeCode.Text <> '' then
  begin
    tblCars.Filtered := False;
    tblCars.Filter := 'Car_Type = ' + cmbTypeCode.Text;
    tblCars.Filtered := True;
  end;
end;

procedure TfrmCars.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height + StatusBar1.Height
  else
    Height := grpAll.Height + StatusBar1.Height;
  Height := Height + 25;
end;

function TfrmCars.AreValidFields : Boolean;
begin
  if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ ŒÊœ—Ê Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('«Ê·ÊÌ  Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Cars', 'Car_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblCars.FieldByName('Car_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ ŒÊœ—Ê  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Cars', 'Car_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblCars.FieldByName('Car_Code').AsString <> txtCode.Text))) then
  begin
    if not ConfirmMessage('ﬂœ «Ê·ÊÌ   ﬂ—«—Ì «” . ¬Ì« „ÌùŒÊ«ÂÌœ ¬‰—« À»  ‰„«ÌÌœø') then
    begin
      AreValidFields := False;
      txtCode.SetFocus;
    end
    else
    begin
      ChngIntegerField('Cars', 'Car_Code', StrToInt(txtCode.Text), 1);
      AreValidFields := True;
    end;
  end
  else
    AreValidFields := True;
end;

procedure TfrmCars.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Type_Code, Type_Name FROM CarTypes');
  qry.Open;
  while not qry.EOF do
  begin
    cmbTypeCode.Items.Add(qry.FieldByName('Type_Code').AsString);
    cmbTypeName.Items.Add(qry.FieldByName('Type_Name').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;

  cmbTypeCode.ItemIndex := 0;
  cmbTypeName.ItemIndex := 0;

  SetDirectionFarsi(txtSearch.Handle);
  SetDirectionFarsi(txtName.Handle);
  tblCars.connection := frmDBS.adoConnect;
  tblCars.Open;
  ReadData;
end;

procedure TfrmCars.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmCars.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblCars.Close;
  Load_Cars_Type;
end;

procedure TfrmCars.cmbTypeCodeClick(Sender: TObject);
begin
  cmbTypeName.ItemIndex := cmbTypeCode.ItemIndex;
  ReadData;
end;

procedure TfrmCars.cmbTypeNameClick(Sender: TObject);
begin
  cmbTypeCode.ItemIndex := cmbTypeName.ItemIndex;
  ReadData;
end;

procedure TfrmCars.cmbTypeCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtSearch.SetFocus;
  end;
end;

procedure TfrmCars.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgCars.SetFocus;
  end;
end;

procedure TfrmCars.txtSearchChange(Sender: TObject);
begin
  tblCars.Locate('Car_Name',txtSearch.Text,[loPartialKey]); //kaveh
//kaveh  tblCars.FindNearest([txtSearch.Text]);
end;

procedure TfrmCars.dbgCarsDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var //kaveh is
  iValue:Byte;
begin
    iValue := dbgCars.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgCars.canvas.brush.color :=ClBlue;
      dbgCars.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgCars.Canvas.Brush.Color := $00D1D9DC;
      0: dbgCars.Canvas.Brush.Color := clWhite;
    end;
    dbgCars.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//kaveh ie
end;

procedure TfrmCars.dbgCarsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmCars.dbgCarsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const selectedTitelColor = clWindow; //kaveh is
var
  pt: TGridcoord;
  columensLeft : Integer;
  function clbtncol():Boolean;
  begin
    TDBGrid(dbgCars).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgCars).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgCars.MouseCoord(x, y);
  if pt.y=0 then
   begin
    columensLeft := dbgCars.Width - ( TDBGrid(dbgCars).Columns[1].Width +
                                       TDBGrid(dbgCars).Columns[0].Width + 39);
//    dbgCars.Cursor:=crHandPoint;
    if (x > columensLeft) and (x < columensLeft + TDBGrid(dbgCars).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgCars).Columns[1].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgCars).Columns[1].Width) and (x < columensLeft + TDBGrid(dbgCars).Columns[1].Width + TDBGrid(dbgCars).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgCars).Columns[0].Title.Color := selectedTitelColor;
    end

   end
  else
   begin
    dbgCars.Cursor:=crDefault;
    clbtncol();
   end;

//kaveh ie
end;

procedure TfrmCars.dbgCarsTitleClick(Column: TColumn);
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
   tblCars.Sort := Column.FieldName + ' DESC';
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
   tblCars.Sort := Column.FieldName + ' ASC';
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

procedure TfrmCars.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtName.Text := '';
  txtCode.Text := IntToStr(GetNewNumber('Cars', 'Car_Code'));
  txtName.SetFocus;
end;

procedure TfrmCars.cmdEditClick(Sender: TObject);
begin
  if not tblCars.EOF then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := tblCars.FieldByName('Car_Name').AsString;
    txtCode.Text := tblCars.FieldByName('Car_Code').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmCars.cmdDeleteClick(Sender: TObject);
var t : Integer;
begin
  if not tblCars.EOF then
  begin
    if not InCircleCar(tblCars.FieldByName('Car_Name').AsString) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ŒÊœ—Ê «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        t := tblCars.FieldByName('Car_Code').AsInteger;
        tblCars.Delete;
        // ChngIntegerField('Cars', 'Car_Code', t, -1);
        // tblCars.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ ŒÊœ—Ê œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmCars.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtCode.SetFocus;
  end;
end;

procedure TfrmCars.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmCars.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblCars.Append
    else if Flag = MB_EDIT then
    begin
      if InCircleCar(tblCars.FieldByName('Car_Name').AsString) and
         (tblCars.FieldByName('Car_Name').AsString <> txtName.Text) then
      begin
        InformationMessage('ŒÊœ—ÊÌ „Ê—œ ‰Ÿ— œ— ê—œ‘ „Ìù»«‘œ. Ê  €ÌÌ— ‰«„ ¬‰ „Ì”— ‰Ì” .');
        FormInEdit(False);
        Exit;
      end;

      tblCars.Edit;
    end;
    tblCars.FieldByName('Car_Name').AsString := txtName.Text;
    tblCars.FieldByName('Car_Code').AsString := txtCode.Text;
    tblCars.FieldByName('Car_Type').AsInteger := StrToInt(cmbTypeCode.Text);
    tblCars.Post;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Cars', 'Car_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgCars.SetFocus;
    end;
  end;
end;

procedure TfrmCars.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCars.SetFocus;
end;

end.
