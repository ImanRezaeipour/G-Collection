unit FishLst1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Globals, ExtCtrls, AdoDB, DateProc, MakeDb;

type
  TfrmFishLst1 = class(TForm)
    grdFishLst: TStringGrid;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure grdFishLstKeyPress(Sender: TObject; var Key: Char);
    procedure grdFishLstKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }

    procedure UpdateSize;

  public
    { Public declarations }

    procedure ViewFish1;

  end;

var
  frmFishLst1: TfrmFishLst1;

implementation


{$R *.DFM}

uses
  Main, DBS_Proc;

type
  fishtype = record
    col_id : integer;
    col_fishno : integer;
    col_pno : string[10];
    col_familyname : string [40];
    col_reader : string [40];
    col_food : string [40];
    col_date : string[10];
    col_time : string[6];
  end;
var
  lastfish : fishtype;
  lastid : integer;
  qry : TAdoQuery;
  rdrName4Fish : string;
procedure TfrmFishLst1.UpdateSize;
var
  l : integer;
begin
  l:=grdFishLst.Width-27;
  grdFishLst.ColWidths[0] :=( 7* l) div 100;
  grdFishLst.ColWidths[1] :=(10* l) div 100;
  grdFishLst.ColWidths[2] :=(15* l) div 100;
  grdFishLst.ColWidths[3] :=(12* l) div 100;
  grdFishLst.ColWidths[4] :=(40* l) div 100;
  grdFishLst.ColWidths[5] :=(10* l) div 100;
  grdFishLst.ColWidths[6] :=( 6* l) div 100;
end;

procedure TfrmFishLst1.ViewFish1;
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
  grdFishLst.Cells[0, grdFishLst.Row] := IntToStr(lastFish.col_FishNo);
  grdFishLst.Cells[1, grdFishLst.Row] := DelLeftZero(lastFish.col_PNo);
  grdFishLst.Cells[2, grdFishLst.Row] := lastFish.col_FamilyName;
  grdFishLst.Cells[3, grdFishLst.Row] := lastFish.col_Reader;
  grdFishLst.Cells[4, grdFishLst.Row] := lastFish.col_food;
  grdFishLst.Cells[5, grdFishLst.Row] := lastFish.col_Date;
  grdFishLst.Cells[6, grdFishLst.Row] := lastFish.col_time;
end;

procedure TfrmFishLst1.FormCreate(Sender: TObject);
begin
  if not tblExists('collect') then
    CreateTbl('collect');

  grdFishLst.Cells[0, 0] := ('فيش');
  grdFishLst.Cells[1, 0] := ('شماره پرسنلي');
  grdFishLst.Cells[2, 0] := ('نام خانوادگي - نام');
  grdFishLst.Cells[3, 0] := ('دستگاه');
  grdFishLst.Cells[4, 0] := ('غذاي مصرفي');
  grdFishLst.Cells[5, 0] := ('تاریخ');
  grdFishLst.Cells[6, 0] := ('زمان');
  UpdateSize;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;

  lastid:=0;
//kaveh is
  with qry do
  begin
    SQL.Clear;
    SQL.Add('SELECT security.rdrCode4Fish, readers.R_Name ');
    SQL.Add('FROM security LEFT OUTER JOIN ');
    SQL.Add('readers ON security.rdrCode4Fish = readers.R_Code ');
    SQL.Add('WHERE UserName = ''' + g_Options.UserName + ''' ');
//    SQL.Add('SELECT UserName, rdrCode4Fish From Security');
//    SQL.Add('WHERE UserName = ''' + g_Options.UserName + ''' ');
    Open;
    if (RecordCount > 0) and (FieldByName('rdrCode4Fish').AsInteger <> 0) then
      rdrName4Fish := FieldByName('R_Name').AsString
    else
      rdrName4Fish := '';
    close;
  end;
//kaveh ie

end;

procedure TfrmFishLst1.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  UpdateSize;
end;

procedure TfrmFishLst1.grdFishLstKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '+' then
    grdFishLst.Font.Size := grdFishLst.Font.Size + 1
  else if Key = '-' then
    grdFishLst.Font.Size := grdFishLst.Font.Size - 1;
  grdFishLst.DefaultRowHeight := grdFishLst.Canvas.TextHeight(grdFishLst.Cells[0, 0])+3;
end;

procedure TfrmFishLst1.Timer1Timer(Sender: TObject);
var
  ctime : string;
  st: string;
  h : integer;
begin
  timer1.Enabled:=false;
  if lastid=0
  then begin
    ctime:=currenttime;
    h:=strtoint(copy(ctime,1,2));
    if h>0
    then begin
         dec(h);
         str(h:2,st);
         if st[1]=''
         then st[1]:='0';
         ctime:=st+copy(ctime,3,3);
    end
    else ctime:='00:00';
  end
  else ctime:='00:00';
  qry.sql.clear;
  qry.sql.add('select * from collect');
  qry.sql.add('where col_date='''+currentdate+'''');
  qry.sql.add('and col_id>'+inttostr(lastid));
//kaveh is
  if rdrName4Fish <> '' then
    qry.sql.add('and Col_Reader = ''' + rdrName4Fish + ''' ');
//kaveh ie
  qry.sql.add('order by col_id');
  qry.open;
  while not qry.eof do
  begin
    lastfish.col_id:=qry.fieldbyname('col_id').asinteger;
    lastfish.col_fishno:=qry.fieldbyname('col_fishno').asinteger;
    lastfish.col_pno:=qry.fieldbyname('col_pno').asstring;
    lastfish.col_familyname:=qry.fieldbyname('col_familyname').asstring;
    lastfish.col_reader:=qry.fieldbyname('col_reader').asstring;
    lastfish.col_food:=qry.fieldbyname('col_food').asstring;
    lastfish.col_date:=qry.fieldbyname('col_date').asstring;
    lastfish.col_time:=qry.fieldbyname('col_time').asstring;
    lastid:=lastfish.col_id;
    if lastfish.col_time>=ctime
     then ViewFish1;
    qry.next;
  end;
  qry.close;
  timer1.Enabled:=true;
end;

procedure TfrmFishLst1.grdFishLstKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 67) then
    grdFishLst.RowCount := 1;
end;

procedure TfrmFishLst1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {
  qry.Free;
  timer1.Enabled:=false;
  }
end;

procedure TfrmFishLst1.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  frmMain.mnuFishLst1.Checked := False;
end;

procedure TfrmFishLst1.FormShow(Sender: TObject);
begin
  timer1.Enabled:=true;
  frmMain.mnuFishLst1.Checked := True;
end;

end.
