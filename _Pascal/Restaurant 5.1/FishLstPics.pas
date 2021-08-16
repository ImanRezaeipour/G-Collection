unit FishLstPics;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Globals, ExtCtrls, AdoDB, DateProc, MakeDb, StdCtrls;

type
  TfrmFishLstPics = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Shape1: TShape;
    imgPicture1: TImage;
    grdFishLst1: TStringGrid;
    Panel2: TPanel;
    Shape2: TShape;
    imgPicture2: TImage;
    grdFishLst2: TStringGrid;
    cmbRdrCode1: TComboBox;
    lblRdrCode1: TLabel;
    lblRdrCode2: TLabel;
    cmbRdrCode2: TComboBox;
    lblName1ca: TLabel;
    lblPNo1ca: TLabel;
    lblName1: TLabel;
    lblPNo1: TLabel;
    lblName2ca: TLabel;
    lblName2: TLabel;
    lblPNo2: TLabel;
    lblPNo2ca: TLabel;
    ShapeRight: TShape;
    ShapeLeft: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure grdFishLst1KeyPress(Sender: TObject; var Key: Char);
    procedure grdFishLst1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure grdFishLst2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdFishLst2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    procedure UpdateSize;

  public
    { Public declarations }

    procedure ViewFishPics(isFish : Boolean);

  end;

var
  frmFishLstPics: TfrmFishLstPics;

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
  lastid, lastErrLogid : integer;
  ctime : string;
  qry, qry2 : TAdoQuery;
  rdrName4Fish : string;
procedure TfrmFishLstPics.UpdateSize;
var
  l : integer;
begin
  l:=grdFishLst1.Width-27;
  grdFishLst1.ColWidths[0] :=( 7* l) div 100;
  grdFishLst1.ColWidths[1] :=(10* l) div 100;
  grdFishLst1.ColWidths[2] :=(15* l) div 100;
  grdFishLst1.ColWidths[3] :=(12* l) div 100;
  grdFishLst1.ColWidths[4] :=(40* l) div 100;
  grdFishLst1.ColWidths[5] :=(10* l) div 100;
  grdFishLst1.ColWidths[6] :=( 6* l) div 100;

  grdFishLst2.ColWidths[0] :=( 7* l) div 100;
  grdFishLst2.ColWidths[1] :=(10* l) div 100;
  grdFishLst2.ColWidths[2] :=(15* l) div 100;
  grdFishLst2.ColWidths[3] :=(12* l) div 100;
  grdFishLst2.ColWidths[4] :=(40* l) div 100;
  grdFishLst2.ColWidths[5] :=(10* l) div 100;
  grdFishLst2.ColWidths[6] :=( 6* l) div 100;

end;

procedure TfrmFishLstPics.ViewFishPics(isFish : Boolean);
var
  i, j : Byte;
  s : String;
  iPictureName : string;  
begin
  iPictureName := '';
  if cmbRdrCode1.ItemIndex > -1 then
    if lastfish.col_reader = cmbRdrCode1.Text  then
    begin
      if isFish then
        ShapeRight.Brush.Color := clGreen
      else
        ShapeRight.Brush.Color := clRed;
    //  if grdFishLst1.RowCount <= 10 then
      grdFishLst1.RowCount := grdFishLst1.RowCount + 1;
      grdFishLst1.FixedRows := 1;
      if grdFishLst1.RowCount > 2 then
        for j := grdFishLst1.RowCount-1 downto 1  do
          grdFishLst1.Rows[j] := grdFishLst1.Rows[j-1];
      grdFishLst1.Rows[1].Clear;
      grdFishLst1.Row := 1;
      if isFish then
        grdFishLst1.Cells[0, grdFishLst1.Row] := IntToStr(lastFish.col_FishNo)
      else
        grdFishLst1.Cells[0, grdFishLst1.Row] := '-';
      grdFishLst1.Cells[1, grdFishLst1.Row] := DelLeftZero(lastFish.col_PNo);
      lblPNo1.Caption := DelLeftZero(lastFish.col_PNo); 
      grdFishLst1.Cells[2, grdFishLst1.Row] := lastFish.col_FamilyName;
      lblName1.Caption := lastFish.col_FamilyName;
      grdFishLst1.Cells[3, grdFishLst1.Row] := lastFish.col_Reader;
      grdFishLst1.Cells[4, grdFishLst1.Row] := lastFish.col_food;
      grdFishLst1.Cells[5, grdFishLst1.Row] := lastFish.col_Date;
      grdFishLst1.Cells[6, grdFishLst1.Row] := lastFish.col_time;
//      if qry.eof then
//      begin
        qry2.sql.clear;
        qry2.sql.add('select P_Picture from Persons ');
        qry2.sql.add('where P_BarCode = ''' + lastfish.col_pno + ''' ');
        qry2.open;
        if not qry2.eof then
        begin
          if qry2.FieldByName('P_Picture').AsString = '' then
          begin
            iPictureName := F_Params.PrsImgsFld + '\' + DelLeftZero(lastfish.col_pno) + '.jpg';
            if not FileExists(iPictureName) then
              iPictureName := F_Params.PrsImgsFld + '\' + lastfish.col_pno + '.jpg';
          end
          else
            iPictureName := F_Params.PrsImgsFld + '\' + qry2.FieldByName('P_Picture').AsString;
          if (iPictureName <> '') and FileExists(iPictureName)
          then
            imgPicture1.Picture.LoadFromFile(iPictureName)
          else
            imgPicture1.Picture.Bitmap := nil;
        end
        else
          imgPicture1.Picture.Bitmap := nil;
        qry2.Close;
//      end;
    end;

  if cmbRdrCode2.ItemIndex > -1 then
    if lastfish.col_reader = cmbRdrCode2.Text  then
    begin
      if isFish then
        ShapeLeft.Brush.Color := clGreen
      else
        ShapeLeft.Brush.Color := clRed;
    //  if grdFishLst2.RowCount <= 10 then
      grdFishLst2.RowCount := grdFishLst2.RowCount + 1;
      grdFishLst2.FixedRows := 1;
      if grdFishLst2.RowCount > 2 then
        for j := grdFishLst2.RowCount-1 downto 1  do
          grdFishLst2.Rows[j] := grdFishLst2.Rows[j-1];
      grdFishLst2.Rows[1].Clear;
      grdFishLst2.Row := 1;
      if isFish then
        grdFishLst2.Cells[0, grdFishLst2.Row] := IntToStr(lastFish.col_FishNo)
      else
        grdFishLst2.Cells[0, grdFishLst2.Row] := '-';
      grdFishLst2.Cells[1, grdFishLst2.Row] := DelLeftZero(lastFish.col_PNo);
      lblPNo2.Caption := DelLeftZero(lastFish.col_PNo); 
      grdFishLst2.Cells[2, grdFishLst2.Row] := lastFish.col_FamilyName;
      lblName2.Caption := lastFish.col_FamilyName;
      grdFishLst2.Cells[3, grdFishLst2.Row] := lastFish.col_Reader;
      grdFishLst2.Cells[4, grdFishLst2.Row] := lastFish.col_food;
      grdFishLst2.Cells[5, grdFishLst2.Row] := lastFish.col_Date;
      grdFishLst2.Cells[6, grdFishLst2.Row] := lastFish.col_time;
//      if qry.eof then
//      begin
        qry2.sql.clear;
        qry2.sql.add('select P_Picture from Persons ');
        qry2.sql.add('where P_BarCode = ''' + lastfish.col_pno + ''' ');
        qry2.open;
        if not qry2.eof then
        begin
          if qry2.FieldByName('P_Picture').AsString = '' then
          begin
            iPictureName := F_Params.PrsImgsFld + '\' + DelLeftZero(lastfish.col_pno) + '.jpg';
            if not FileExists(iPictureName) then
              iPictureName := F_Params.PrsImgsFld + '\' + lastfish.col_pno + '.jpg';
          end
          else
            iPictureName := F_Params.PrsImgsFld + '\' + qry2.FieldByName('P_Picture').AsString;
          if (iPictureName <> '') and FileExists(iPictureName)
          then
            imgPicture2.Picture.LoadFromFile(iPictureName)
          else
            imgPicture2.Picture.Bitmap := nil;
        end
        else
          imgPicture2.Picture.Bitmap := nil;        
        qry2.Close;
//      end;
    end;
end;

procedure TfrmFishLstPics.FormCreate(Sender: TObject);
begin
  if not tblExists('collect') then
    CreateTbl('collect');

  grdFishLst1.Cells[0, 0] := ('فيش');
  grdFishLst1.Cells[1, 0] := ('شماره پرسنلي');
  grdFishLst1.Cells[2, 0] := ('نام خانوادگي - نام');
  grdFishLst1.Cells[3, 0] := ('دستگاه');
  grdFishLst1.Cells[4, 0] := ('غذاي مصرفي');
  grdFishLst1.Cells[5, 0] := ('تاریخ');
  grdFishLst1.Cells[6, 0] := ('زمان');

  grdFishLst2.Cells[0, 0] := ('فيش');
  grdFishLst2.Cells[1, 0] := ('شماره پرسنلي');
  grdFishLst2.Cells[2, 0] := ('نام خانوادگي - نام');
  grdFishLst2.Cells[3, 0] := ('دستگاه');
  grdFishLst2.Cells[4, 0] := ('غذاي مصرفي');
  grdFishLst2.Cells[5, 0] := ('تاریخ');
  grdFishLst2.Cells[6, 0] := ('زمان');

  UpdateSize;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;

  qry2 := TAdoQuery.Create(Application); //kaveh
  qry2.connection := frmDBS.DBConnection; //kaveh

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

procedure TfrmFishLstPics.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  UpdateSize;
end;

procedure TfrmFishLstPics.grdFishLst1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '+' then
    grdFishLst1.Font.Size := grdFishLst1.Font.Size + 1
  else if Key = '-' then
    grdFishLst1.Font.Size := grdFishLst1.Font.Size - 1;
  grdFishLst1.DefaultRowHeight := grdFishLst1.Canvas.TextHeight(grdFishLst1.Cells[0, 0])+3;
end;

procedure TfrmFishLstPics.grdFishLst2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 67) then
    grdFishLst2.RowCount := 1;
end;

procedure TfrmFishLstPics.grdFishLst2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '+' then
    grdFishLst2.Font.Size := grdFishLst2.Font.Size + 1
  else if Key = '-' then
    grdFishLst2.Font.Size := grdFishLst2.Font.Size - 1;
  grdFishLst2.DefaultRowHeight := grdFishLst2.Canvas.TextHeight(grdFishLst2.Cells[0, 0])+3;
end;

procedure TfrmFishLstPics.Timer1Timer(Sender: TObject);
var
  st: string;
  h : integer;
begin
  if (F_Params.AutoFishLstPicsActive) and (cmbRdrCode1.ItemIndex < 0) then
    cmbRdrCode1.ItemIndex := cmbRdrCode1.Items.IndexOf(F_Params.AutoFishLstPicsRdrCodeR);
  if (F_Params.AutoFishLstPicsActive) and (cmbRdrCode2.ItemIndex < 0) then
    cmbRdrCode2.ItemIndex := cmbRdrCode2.Items.IndexOf(F_Params.AutoFishLstPicsRdrCodeL);

  timer1.Enabled := False;
  timer1.Interval := 1000;
  Panel2.Width := (frmFishLstPics.ClientWidth div 2);
  Panel2.Align := alLeft;
  Panel1.Align := alClient;
//  if lastid = 0 then
//  begin
//    ctime := CurrentTime;
//    h := strtoint(copy(ctime,1,2));
//    if h > 0 then
//    begin
//      dec(h);
//      str(h:2,st);
//      if st[1] = '' then st[1] := '0';
//         ctime := st + copy(ctime,3,3);
//    end
//    else
//      ctime := '00:00';
//  end
//  else
//    ctime:='00:00';
//    ctime := '';

  qry.sql.clear;
  qry.sql.add('select * from collect ');
  qry.sql.add('where col_date = ''' + currentdate + ''' ');
  if lastid = 0 then
    qry.sql.add('and col_time >= ''' + ctime + ''' ')
  else
    qry.sql.add('and col_id > '+inttostr(lastid) + ' ');
  qry.sql.add('and (col_reader = ''' + cmbRdrCode1.Text + ''' or col_reader = ''' + cmbRdrCode2.Text + ''') ');
//kaveh is
//  if rdrName4Fish <> '' then
//    qry.sql.add('and Col_Reader = ''' + rdrName4Fish + ''' ');
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
    qry.next;
    if lastfish.col_time >= ctime then
      ViewFishPics(True);
  end;
  qry.close;

  qry.sql.clear;
  qry.sql.add('select * from errorlogs ');
  qry.sql.add('where errlog_date = ''' + currentdate + ''' ');
  if lastErrLogid = 0 then
    qry.sql.add('and errlog_time >= ''' + ctime + ''' ')
  else
    qry.sql.add('and errlog_id > '+inttostr(lastErrLogid) + ' ');
  qry.sql.add('and (errlog_reader = ''' + cmbRdrCode1.Text + ''' or errlog_reader = ''' + cmbRdrCode2.Text + ''') ');
  qry.sql.add('order by errlog_id');
  qry.open;
  while not qry.eof do
  begin
    lastfish.col_id:=qry.fieldbyname('errlog_id').asinteger;
    lastfish.col_fishno:= 0; //qry.fieldbyname('col_fishno').asinteger;
    lastfish.col_pno:=qry.fieldbyname('errlog_pno').asstring;
    lastfish.col_familyname:=qry.fieldbyname('errlog_familyname').asstring;
    lastfish.col_reader:=qry.fieldbyname('errlog_reader').asstring;
    lastfish.col_food:=qry.fieldbyname('errlog_caption').asstring;
    lastfish.col_date:=qry.fieldbyname('errlog_date').asstring;
    lastfish.col_time:=qry.fieldbyname('errlog_time').asstring;
    lastErrLogid:=lastfish.col_id;
    qry.next;
    if lastfish.col_time >= ctime then
      ViewFishPics(False);
  end;
  qry.close;
  timer1.Enabled:=true;
end;

procedure TfrmFishLstPics.grdFishLst1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 67) then
    grdFishLst1.RowCount := 1;
end;

procedure TfrmFishLstPics.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  timer1.Enabled := False;
  {
  qry.Free;
  timer1.Enabled:=false;
  }
end;

procedure TfrmFishLstPics.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  frmMain.mnuFishLst1.Checked := False;
  timer1.Enabled := False;
end;

procedure TfrmFishLstPics.FormShow(Sender: TObject);
begin
//kaveh is
  cmbRdrCode1.Clear;
  cmbRdrCode2.Clear;
  with qry do
  begin
    SQL.Clear;
    SQL.Add('SELECT R_Name FROM readers');
    Open;
    while not eof do
    begin
      cmbRdrCode1.Items.Add(FieldByName('R_Name').AsString);
      cmbRdrCode2.Items.Add(FieldByName('R_Name').AsString);
      Next;
    end;
    close;
  end;
//kaveh ie
  if lastid = 0 then
  begin
    ctime := CurrentTime;
  end
  else
    ctime := '';


  timer1.Enabled:=true;
  frmMain.mnuFishLst1.Checked := True;
  
end;

end.
