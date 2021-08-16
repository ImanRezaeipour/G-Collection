unit ChngAddr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ComTools, MSGs, Globals,
  Keyboard, DBS, RunCmnds, XStringGrid, Grids;

type
  TfrmChngAddr = class(TForm)
    cmdOK: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    grdReaders: TXStringGrid;
    EditCellEditor1: TEditCellEditor;
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    function  IsTrueNewCode(i : Byte) : Boolean;
  public
    { Public declarations }
  end;

var
  frmChngAddr : TfrmChngAddr;

implementation

uses
  Funcs, FntSel;

{$R *.DFM}




procedure TfrmChngAddr.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmChngAddr));

  Caption := (Caption);
  for i := 0 to grdReaders.ColCount-1 do
    grdReaders.Cells[i, 0] := (grdReaders.Cells[i, 0]);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

function TfrmChngAddr.IsTrueNewCode(i : Byte) : Boolean;
var j : Byte;
begin
  Result := True;
  if not IsNumeric(grdReaders.Cells[2, i]) then
  begin
    Result := False;
    grdReaders.Cells[3, i] := ('ﬂœ «‘ »«Â «” .');
  end
  else if (StrToInt(grdReaders.Cells[2, i]) < 1)  or
          (StrToInt(grdReaders.Cells[2, i]) > 255) then
  begin
    Result := False;
    grdReaders.Cells[3, i] := ('ﬂœ ﬂ«— ŒÊ«‰ »«Ì” Ì »Ì‰ 1 Ê 255 »«‘œ.');
  end
  else
  begin
    for j := 1 to grdReaders.RowCount-1 do
      if (j <> i) and (StrToInt(grdReaders.Cells[2, i]) = StrToInt(grdReaders.Cells[0, j])) then
      begin
        Result := False;
        grdReaders.Cells[3, i] := ('ﬂœ ﬂ«— ŒÊ«‰  ﬂ—«—Ì «” .');
        Break;
      end;
  end;
end;

procedure TfrmChngAddr.FormCreate(Sender: TObject);
var i : Byte;
begin
  grdReaders.RowCount := rdrCount+1;
  SetWinF;
  if rdrCount > 0 then
    for i := 0 to rdrCount-1 do
    begin
      grdReaders.Cells[0, i+1] := IntToStr(Readers[i].R_Code);
      grdReaders.Cells[1, i+1] := Readers[i].R_Name;
    end;
end;

procedure TfrmChngAddr.cmdOKClick(Sender: TObject);
var
  i : Byte;
begin
  SetUserControl;
  for i := 1 to grdReaders.RowCount-1 do
    if grdReaders.Cells[2, i] <> '' then
    begin
      grdReaders.Cells[3, i] := ('œ— Õ«·  €ÌÌ— ﬂœ...');
      grdReaders.Refresh;
      if IsTrueNewCode(i) then
      begin
        if ChangeAddress(Readers[i-1], StrToInt(grdReaders.Cells[2, i])) then
        begin
          with frmDBS.adoQryG do
          begin
            SQL.Clear;
            SQL.Add('UPDATE Readers SET Rdr_Code = ' + grdReaders.Cells[2, i]);
            SQL.Add('WHERE Rdr_Code = ' + grdReaders.Cells[0, i]);
            ExecSQL;
          end;
          Readers[i-1].R_Code := StrToInt(grdReaders.Cells[2, i]);
          grdReaders.Cells[0, i] := grdReaders.Cells[2, i];
          grdReaders.Cells[3, i] := ('ﬂœ ﬂ«— ŒÊ«‰  €ÌÌ— Ì«› .');
        end
        else
          grdReaders.Cells[3, i] := (' €ÌÌ— ﬂœ ﬂ«— ŒÊ«‰ „Ì”— ‰Ì” .');
      end;
    end
    else
      grdReaders.Cells[3, i] := '';

  LoadReaders;
  UserControl := False;
end;


end.

