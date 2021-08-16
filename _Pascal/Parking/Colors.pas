unit Colors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS, ComCtrls;

type
  TfrmColors = class(TForm)
    grpAll: TGroupBox;
    dbgColors: TDBGrid;
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
    dtaColors: TDataSource;
    tblColors: TAdoTable;
    txtSearch: TEdit;
    Label3: TLabel;
    tblColorsClr_Name: TStringField;
    tblColorsClr_Code: TSmallintField;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgColorsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchChange(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure dbgColorsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgColorsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgColorsTitleClick(Column: TColumn);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmColors.SetWinF;
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
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblColorsClr_Name.DisplayLabel := (tblColorsClr_Name.DisplayLabel);
  tblColorsClr_Code.DisplayLabel := (tblColorsClr_Code.DisplayLabel);
end;

procedure TfrmColors.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height + StatusBar1.Height
  else
    Height := grpAll.Height + StatusBar1.Height;
  Height := Height + 25;
end;

function TfrmColors.AreValidFields : Boolean;
begin
  if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ —‰ê Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('«Ê·ÊÌ  —‰ê Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Colors', 'Clr_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblColors.FieldByName('Clr_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ —‰ê  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Colors', 'Clr_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblColors.FieldByName('Clr_Code').AsString <> txtCode.Text))) then
  begin
    if not ConfirmMessage('«Ê·ÊÌ  —‰ê  ﬂ—«—Ì «” . ¬Ì« „ÌùŒÊ«ÂÌœ ¬‰—« À»  ‰„«ÌÌœø') then
    begin
      AreValidFields := False;
      txtCode.SetFocus;
    end
    else
    begin
      ChngIntegerField('Colors', 'Clr_Code', StrToInt(txtCode.Text), 1);
      AreValidFields := True;
    end;
  end
  else
    AreValidFields := True;
end;

procedure TfrmColors.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtSearch.Handle);
  SetDirectionFarsi(txtName.Handle);
  tblColors.connection := frmDBS.adoConnect;
  tblColors.Open;
end;

procedure TfrmColors.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmColors.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblColors.Close;
end;

procedure TfrmColors.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgColors.SetFocus;
  end;
end;

procedure TfrmColors.txtSearchChange(Sender: TObject);
begin
  tblColors.Locate('Clr_Name',txtSearch.Text,[loPartialKey]); //kaveh
//kaveh  tblColors.FindNearest([txtSearch.Text]);
end;

procedure TfrmColors.dbgColorsDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var //kaveh is
  iValue:Byte;
begin
    iValue := dbgColors.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgColors.canvas.brush.color :=ClBlue;
      dbgColors.canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgColors.Canvas.Brush.Color := $00D1D9DC;
      0: dbgColors.Canvas.Brush.Color := clWhite;
    end;
    dbgColors.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//kaveh ie
end;

procedure TfrmColors.dbgColorsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmColors.dbgColorsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const selectedTitelColor = clWindow; //kaveh is
var
  pt: TGridcoord;
  columensLeft : Integer;
  function clbtncol():Boolean;
  begin
    TDBGrid(dbgColors).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgColors).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgColors.MouseCoord(x, y);
  if pt.y=0 then
   begin
    columensLeft := dbgColors.Width - ( TDBGrid(dbgColors).Columns[1].Width +
                                       TDBGrid(dbgColors).Columns[0].Width + 39);
//    dbgColors.Cursor:=crHandPoint;
    if (x > columensLeft) and (x < columensLeft + TDBGrid(dbgColors).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgColors).Columns[1].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgColors).Columns[1].Width) and (x < columensLeft + TDBGrid(dbgColors).Columns[1].Width + TDBGrid(dbgColors).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgColors).Columns[0].Title.Color := selectedTitelColor;
    end

   end
  else
   begin
    dbgColors.Cursor:=crDefault;
    clbtncol();
   end;

//kaveh ie
end;

procedure TfrmColors.dbgColorsTitleClick(Column: TColumn);
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
   tblColors.Sort := Column.FieldName + ' DESC';
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
   tblColors.Sort := Column.FieldName + ' ASC';
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

procedure TfrmColors.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtName.Text := '';
  txtCode.Text := IntToStr(GetNewNumber('Colors', 'Clr_Code'));
  txtName.SetFocus;
end;

procedure TfrmColors.cmdEditClick(Sender: TObject);
begin
  if not tblColors.EOF then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := tblColors.FieldByName('Clr_Name').AsString;
    txtCode.Text := tblColors.FieldByName('Clr_Code').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmColors.cmdDeleteClick(Sender: TObject);
var t : Integer;
begin
  if not tblColors.EOF then
  begin
    if not InCircleColor(tblColors.FieldByName('Clr_Name').AsString) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› —‰ê «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        t := tblColors.FieldByName('Clr_Code').AsInteger;
        tblColors.Delete;
        // ChngIntegerField('Colors', 'Clr_Code', t, -1);
        // tblColors.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ —‰ê ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmColors.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtCode.SetFocus;
  end;
end;

procedure TfrmColors.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmColors.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblColors.Append
    else if Flag = MB_EDIT then
    begin
      if InCircleColor(tblColors.FieldByName('Clr_Name').AsString) and
         (tblColors.FieldByName('Clr_Name').AsString <> txtName.Text) then
      begin
        InformationMessage('—‰ê „Ê—œ ‰Ÿ— œ— ê—œ‘ „Ìù»«‘œ. Ê   €ÌÌ— ¬‰ „Ì”— ‰Ì” .');
        FormInEdit(False);
        Exit;
      end;

      tblColors.Edit;
    end;
    tblColors.FieldByName('Clr_Name').AsString := txtName.Text;
    tblColors.FieldByName('Clr_Code').AsString := txtCode.Text;
    tblColors.Post;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Colors', 'Clr_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgColors.SetFocus;
    end;
  end;
end;

procedure TfrmColors.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgColors.SetFocus;
end;







end.
