unit RdrStat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ComTools, Globals;

type TReCGrd = record
  CodeName   : String[25];
  CardNumber : String[8];
  NameFamily : String[25];
  FishNumber : String[6];
  FishTime   : String[5];
  RdrTime    : String[8];
  RdrState   : String[8];
end;


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
    procedure FillRow(RowNo : Integer; rdrData : TRecGrd);
  public
    { Public declarations }
    procedure ViewLastInOut(rdr :TReaders);
  end;




var
  frmReaderState: TfrmReaderState;


implementation

{$R *.DFM}


procedure TfrmReaderState.InitialCols;
var
  i : Byte;
  w : Integer;
begin

  grd.FixedCols := 0;
  grd.ColCount := 7;

  grd.Cols[0].Add(('      ßÏ æ äÇã ÏÓÊÇå'));
  grd.ColWidths[0] := 140;

  grd.Cols[1].Add((' ÔãÇÑå ßÇÑÊ'));
  grd.ColWidths[1] := 70;

  grd.Cols[2].Add(('           äÇã æ äÇã ÎÇäæÇÏí'));
  grd.ColWidths[2] := 155;

  grd.Cols[3].Add(('ÔãÇÑå ÝíÔ'));
  grd.ColWidths[3] := 65;

  grd.Cols[4].Add(('ÒãÇä ÕÏæÑ'));
  grd.ColWidths[4] := 60;

  grd.Cols[5].Add(('ÒãÇä ÇÑÊÈÇØ'));
  grd.ColWidths[5] := 60;

  grd. Cols[6].Add(('æÖÚ ÇÑÊÈÇØ'));
  grd.ColWidths[6] := 60;

  w := 20;
  for i := 0 to grd.ColCount-1 do
    Inc(w,+ grd.ColWidths[i]);
  Width := w;
  LeftWin := (Screen.Width - w) div 2;
end;

procedure TfrmReaderState.InitialRows;
begin
  grd.RowCount := TotalOnLineRdr+1;
  if grd.RowCount > 1 then
    grd.FixedRows := 1;
  Height := (grd.RowCount+1) * grd.RowHeights[0] + grd.RowCount + 40;
  Top := Screen.Height - Height - 30;
  Left := LeftWin;
end;

procedure TfrmReaderState.FillRow(RowNo : Integer; rdrData : TRecGrd);
begin
  grd.Cells[0, RowNo] := rdrData.CodeName;
  grd.Cells[1, RowNo] := DelLeftZero(rdrData.CardNumber);
  grd.Cells[2, RowNo] := rdrData.NameFamily;
  grd.Cells[3, RowNo] := rdrData.FishNumber;
  grd.Cells[4, RowNo] := rdrData.FishTime;
  grd.Cells[5, RowNo] := rdrData.RdrTime;
  grd.Cells[6, RowNo] := rdrData.RdrState;
  grd.Update;
end;

procedure TfrmReaderState.ViewLastInOut(rdr : Treaders);
var
  rdrData : TRecGrd;
begin
  if Showing then
  begin
    InitialRows;
    rdrData.CodeName := #254 + IntToStr(rdr.R_Code) + '-' + #254 + rdr.R_Name;
    rdrData.CardNumber := rdr.CardNumber;
    rdrData.NameFamily := rdr.NameFamily;
    rdrData.FishNumber := rdr.FishNumber;
    rdrData.FishTime := rdr.FishTime;
    rdrData.RdrTime := rdr.RdrTime;
    rdrData.RdrState := rdr.RdrState;
    FillRow(rdr.OnLineIdx, rdrData);
  end;
end;

procedure TfrmReaderState.FormCreate(Sender: TObject);
begin
  Caption := (Caption);
end;

procedure TfrmReaderState.FormShow(Sender: TObject);
var i : Byte;
begin
  InitialCols;
  if TotalOnLineRdr = 0 then
    InitialRows;
  for i := 1 to TotalReader do
    if Readers[i].R_Active and Readers[i].R_OnLine then
      ViewLastInOut(Readers[i]);
end;

end.
