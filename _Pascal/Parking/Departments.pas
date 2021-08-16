unit Departments;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS, ComCtrls;

type
  TfrmDepartments = class(TForm)
    grpAll: TGroupBox;
    dbgDepartment: TDBGrid;
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
    txtSearch: TEdit;
    Label3: TLabel;
    StatusBar1: TStatusBar;
    tblDepartment: TADOTable;
    tblDepartmentDepart_Code: TIntegerField;
    tblDepartmentDepart_Name: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchChange(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDepartmentDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDepartmentMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgDepartmentTitleClick(Column: TColumn);
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

procedure TfrmDepartments.SetWinF;
begin
{  Caption := (Caption);
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
  tblDepartmentClr_Name.DisplayLabel := (tblDepartmentClr_Name.DisplayLabel);
  tblDepartmentClr_Code.DisplayLabel := (tblDepartmentClr_Code.DisplayLabel);}
end;

procedure TfrmDepartments.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height + StatusBar1.Height
  else
    Height := grpAll.Height + StatusBar1.Height;
  Height := Height + 25;
end;

function TfrmDepartments.AreValidFields : Boolean;
begin
  if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ „Õ· Œœ„  Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('òœ „Õ· Œœ„  Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Department', 'Depart_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblDepartment.FieldByName('Depart_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ „Õ· Œœ„   ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Department', 'Depart_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblDepartment.FieldByName('Depart_Code').AsString <> txtCode.Text))) then
  begin
    if not ConfirmMessage('òœ „Õ· Œœ„   ﬂ—«—Ì «” . ¬Ì« „ÌùŒÊ«ÂÌœ ¬‰—« À»  ‰„«ÌÌœø') then
    begin
      AreValidFields := False;
      txtCode.SetFocus;
    end
    else
    begin
      ChngIntegerField('Department', 'Depart_Code', StrToInt(txtCode.Text), 1);
      AreValidFields := True;
    end;
  end
  else
    AreValidFields := True;
end;

procedure TfrmDepartments.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtSearch.Handle);
  SetDirectionFarsi(txtName.Handle);
  tblDepartment.connection := frmDBS.adoConnect;
  tblDepartment.Open;
end;

procedure TfrmDepartments.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmDepartments.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblDepartment.Close;
end;

procedure TfrmDepartments.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgDepartment.SetFocus;
  end;
end;

procedure TfrmDepartments.txtSearchChange(Sender: TObject);
begin
  tblDepartment.Locate('Depart_Name',txtSearch.Text,[loPartialKey]); //kaveh
//kaveh  tblDepartment.FindNearest([txtSearch.Text]);
end;

procedure TfrmDepartments.dbgDepartmentDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var //kaveh is
  iValue:Byte;
begin
    iValue := dbgDepartment.DataSource.DataSet.RecNo mod 2;
    If (gdFocused in State) or (gdSelected in State) then
     begin
      dbgDepartment.canvas.brush.color :=ClBlue;
      dbgDepartment.Canvas.Font.Color :=clWhite;
     end
    else
    case iValue of
      1: dbgDepartment.Canvas.Brush.Color := $00D1D9DC;
      0: dbgDepartment.Canvas.Brush.Color := clWhite;
    end;
    dbgDepartment.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//kaveh ie
end;

procedure TfrmDepartments.dbgDepartmentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmDepartments.dbgDepartmentMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const selectedTitelColor = clWindow; //kaveh is
var
  pt: TGridcoord;
  columensLeft : Integer;
  function clbtncol():Boolean;
  begin
    TDBGrid(dbgDepartment).Columns[1].Title.Color := clBtnFace;
    TDBGrid(dbgDepartment).Columns[0].Title.Color := clBtnFace;
  end;

begin
  pt:= dbgDepartment.MouseCoord(x, y);
  if pt.y=0 then
   begin
    columensLeft := dbgDepartment.Width - ( TDBGrid(dbgDepartment).Columns[1].Width +
                                       TDBGrid(dbgDepartment).Columns[0].Width + 39);
//    dbgDepartment.Cursor:=crHandPoint;
    if (x > columensLeft) and (x < columensLeft + TDBGrid(dbgDepartment).Columns[1].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDepartment).Columns[1].Title.Color := selectedTitelColor;
     end

    else if (x > columensLeft + TDBGrid(dbgDepartment).Columns[1].Width) and (x < columensLeft + TDBGrid(dbgDepartment).Columns[1].Width + TDBGrid(dbgDepartment).Columns[0].Width) then
     begin
       clbtncol();
       TDBGrid(dbgDepartment).Columns[0].Title.Color := selectedTitelColor;
    end

   end
  else
   begin
    dbgDepartment.Cursor:=crDefault;
    clbtncol();
   end;

//kaveh ie
end;

procedure TfrmDepartments.dbgDepartmentTitleClick(Column: TColumn);
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
   tblDepartment.Sort := Column.FieldName + ' DESC';
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
   tblDepartment.Sort := Column.FieldName + ' ASC';
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

procedure TfrmDepartments.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtName.Text := '';
  txtCode.Text := IntToStr(GetNewNumber('Department', 'Depart_Code'));
  txtName.SetFocus;
end;

procedure TfrmDepartments.cmdEditClick(Sender: TObject);
begin
  if not tblDepartment.EOF then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := tblDepartment.FieldByName('Depart_Name').AsString;
    txtCode.Text := tblDepartment.FieldByName('Depart_Code').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmDepartments.cmdDeleteClick(Sender: TObject);
var t : Integer;
begin
  if not tblDepartment.EOF then
  begin
    if not InCircleDepartment(tblDepartment.FieldByName('Depart_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› „Õ· Œœ„  «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        t := tblDepartment.FieldByName('Depart_Code').AsInteger;
        tblDepartment.Delete;
        //ChngIntegerField('Department', 'Depart_Code', t, -1);
        //tblDepartment.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ „Õ· Œœ„  ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmDepartments.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtCode.SetFocus;
  end;
end;

procedure TfrmDepartments.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmDepartments.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblDepartment.Append
    else if Flag = MB_EDIT then
    begin
      {if InCircleCity(tblDepartment.FieldByName('Depart_Name').AsString) and
         (tblDepartment.FieldByName('Depart_Name').AsString <> txtName.Text) then
      begin
        InformationMessage('—‰ê „Ê—œ ‰Ÿ— œ— ê—œ‘ „Ìù»«‘œ. Ê   €ÌÌ— ¬‰ „Ì”— ‰Ì” .');
        FormInEdit(False);
        Exit;
      end; }

      tblDepartment.Edit;
    end;
    tblDepartment.FieldByName('Depart_Name').AsString := txtName.Text;
    tblDepartment.FieldByName('Depart_Code').AsString := txtCode.Text;
    tblDepartment.Post;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Department', 'Depart_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgDepartment.SetFocus;
    end;
  end;
end;

procedure TfrmDepartments.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgDepartment.SetFocus;
end;

end.
