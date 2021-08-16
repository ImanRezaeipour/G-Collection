unit FishLst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Globals;

type
  TfrmFishLst = class(TForm)
    grdFishLst: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure grdFishLstKeyPress(Sender: TObject; var Key: Char);
    procedure grdFishLstKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    procedure UpdateSize;

  public
    { Public declarations }

    procedure ViewFish(PersonFish : TFish; p : TPerson; ErrTest : Byte);

  end;

var
  frmFishLst: TfrmFishLst;

implementation


{$R *.DFM}

uses
  Main, DBS_Proc;

procedure TfrmFishLst.UpdateSize;
begin
  grdFishLst.ColWidths[0] := 40;
  grdFishLst.ColWidths[1] := 80;
  grdFishLst.ColWidths[2] := (grdFishLst.Width - 150) * 4 div 10;
  grdFishLst.ColWidths[3] := (grdFishLst.Width - 150) * 6 div 10;
end;

procedure TfrmFishLst.ViewFish(PersonFish : TFish; p : TPerson; ErrTest : Byte);
var
  i, j : Byte;
  s : String;
begin
//  if grdFishLst.RowCount <= 10 then
    grdFishLst.RowCount := grdFishLst.RowCount + 1;
  grdFishLst.FixedRows := 1;
  if grdFishLst.RowCount > 2 then
    for j := grdFishLst.RowCount-1 downto 1  do
      grdFishLst.Rows[j] := grdFishLst.Rows[j-1];
  grdFishLst.Rows[1].Clear;
  grdFishLst.Row := 1;
  grdFishLst.Cells[1, grdFishLst.Row] := DelLeftZero(PersonFish.Fish_PCode);
  grdFishLst.Cells[2, grdFishLst.Row] := p.P_Family + '-' + p.P_Name;
  if ErrTest <> 0 then
    grdFishLst.Cells[3, grdFishLst.Row] := (ErrMsg[ErrTest])
  else
  begin
    grdFishLst.Cells[0, grdFishLst.Row] := IntToStr(PersonFish.Fish_No);
    s := '';
    for i := 1 to 8 do
      if PersonFish.Fish_Foods[i] <> 0 then
      begin
        if s <> '' then s := s + '-';
        s := s + GetFoodNameInRam(PersonFish.Fish_Foods[i]);
      end;
    grdFishLst.Cells[3, grdFishLst.Row] := s;
  end;

end;

procedure TfrmFishLst.FormCreate(Sender: TObject);
begin
  Caption := (Caption);
  grdFishLst.Hint := (grdFishLst.Hint);

  grdFishLst.Cells[0, 0] := ('›Ì‘');
  grdFishLst.Cells[1, 0] := ('‘„«—Â Å—”‰·Ì');
  grdFishLst.Cells[2, 0] := ('‰«„ Œ«‰Ê«œêÌ - ‰«„');
  grdFishLst.Cells[3, 0] := ('€–«Ì „’—›Ì');
  UpdateSize;
end;

procedure TfrmFishLst.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  UpdateSize;
end;

procedure TfrmFishLst.grdFishLstKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '+' then
    grdFishLst.Font.Size := grdFishLst.Font.Size + 1
  else if Key = '-' then
    grdFishLst.Font.Size := grdFishLst.Font.Size - 1;
  grdFishLst.DefaultRowHeight := grdFishLst.Canvas.TextHeight(grdFishLst.Cells[0, 0])+3;
end;

procedure TfrmFishLst.grdFishLstKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 67) then
    grdFishLst.RowCount := 1;
end;

procedure TfrmFishLst.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  frmMain.mnuFishLst.Checked := False;
end;

procedure TfrmFishLst.FormShow(Sender: TObject);
begin
  frmMain.mnuFishLst.Checked := True;
end;

end.
