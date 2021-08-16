unit RdrStat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, comtools, Globals, FarsiApi;


type
  TfrmReaderState = class(TForm)
    grd: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    LeftWin : Integer;

    procedure InitialCols;
    procedure InitialRows;
    function  FindActiveRow(i : Byte) : Byte;
    procedure SetWinF;

  public
    { Public declarations }
    procedure ViewLastInOut(c : Byte);
  end;




var
  frmReaderState: TfrmReaderState;


implementation

{$R *.DFM}

procedure TfrmReaderState.SetWinF;
begin
  Caption := (Caption);
end;

procedure TfrmReaderState.InitialCols;
var
  i : Byte;
  w : Integer;
begin
  grd.FixedCols := 0;
  grd.ColCount := 8;

  grd.Cols[0].Add(('ßÏ æ äÇã ÏÓÊÇå'));
  grd.ColWidths[0] := 135;

  grd.Cols[1].Add(('ÚãáíÇÊ'));
  grd.ColWidths[1] := 90;

  grd.Cols[2].Add(('ÔãÇÑå ßÇÑÊ'));
  grd.ColWidths[2] := 60;

  grd.Cols[3].Add(('ÂÎÑíä ÊÑÏÏ'));
  grd.ColWidths[3] := 60;

  grd.Cols[4].Add(('ÔãÇÑå ÎæÏÑæ'));
  grd.ColWidths[4] := 70;

  grd.Cols[5].Add(('åÒíäå'));
  grd.ColWidths[5] := 70;

  grd.Cols[6].Add(('ÂÎÑíä ÇÑÊÈÇØ'));
  grd.ColWidths[6] := 65;

  grd. Cols[7].Add(('æÖÚ ÇÑÊÈÇØ'));
  grd.ColWidths[7] := 60;

  w := 20;
  for i := 0 to grd.ColCount-1 do
    Inc(w, grd.ColWidths[i]);
  Width := w;
  LeftWin := (Screen.Width - w) div 2;
  Left := LeftWin;
end;

procedure TfrmReaderState.InitialRows;
begin
  grd.RowCount := TotalActvRdr+1;
  if grd.RowCount > 1 then
    grd.FixedRows := 1;
  Height := (grd.RowCount+1) * grd.RowHeights[0] + grd.RowCount + 10;
  Top := Screen.Height - Height - 47;
  Left := LeftWin;
end;

function TfrmReaderState.FindActiveRow(i : Byte) : Byte;
var n, j : Byte;
begin
  n := 0;
  for j := 1 to i do
    if Readers[j].R_Active then
      Inc(n);
  FindActiveRow := n;
end;

procedure TfrmReaderState.ViewLastInOut(c : Byte);
var r : Byte;
begin
  if Showing then
  begin
    InitialRows;
    r := FindActiveRow(c);
    grd.Cells[0, r] := IntToStr(Readers[c].R_Code) + '-' + Readers[c].R_Name;
    grd.Cells[1, r] := ReadersLast[c].OP;
    grd.Cells[2, r] := ReadersLast[c].CardNo;
    grd.Cells[3, r] := ReadersLast[c].CarTime;
    grd.Cells[4, r] := ConvertToFarsi(ReadersLast[c].CarNumber);
    grd.Cells[5, r] := ReadersLast[c].ParkCost;
    grd.Cells[6, r] := ReadersLast[c].ComTime;
    grd.Cells[7, r] := ReadersLast[c].ComStat;
  end;
end;

procedure TfrmReaderState.FormShow(Sender: TObject);
var i : Byte;
begin
  InitialCols;
  for i := 1 to TotalReader do
    if Readers[i].R_Active then
      ViewLastInOut(i);
end;

procedure TfrmReaderState.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

end.

