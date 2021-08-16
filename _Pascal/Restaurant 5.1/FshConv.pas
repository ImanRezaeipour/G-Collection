unit FshConv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables;

type
  TForm1 = class(TForm)
    Button1: TButton;
    lblRecNo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    txtFDate: TEdit;
    Label3: TLabel;
    txtTDate: TEdit;
    lblTotal: TLabel;
    tblF: TTable;
    tblFF: TTable;
    btnRepairDuplicate: TButton;
    procedure btnRepairDuplicateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFDateExit(Sender: TObject);
    procedure txtTDateExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

    prgPath : String;

    procedure RefreshData;
    procedure createFishFoodTable(tblNew: TTable);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  DateProc, Globals, DBS_Proc;

{$R *.dfm}

procedure TForm1.RefreshData;
begin
{  tblF.Filtered := False;
  tblF.Filter := 'Fish_Date >= ''' + txtFDate.Text +
                    ''' AND Fish_Date <= ''' + txtTDate.Text + '''';
  tblF.Filtered := True;

  lblTotal.Caption := IntToStr(tblF.RecordCount);;
  lblRecNo.Caption := '0';
}
end;

procedure TForm1.createFishFoodTable(tblNew: TTable);
begin
  with tblNew do
  begin
//    DatabaseName := g_options.DataBasePath;
    TableType := ttParadox;
    TableName := 'fishFood.db';
    FieldDefs.Clear;
    with FieldDefs.AddFieldDef do
    begin
      Name := 'ff_Date';
      DataType := ftString;
      Size := 10;
    end;
    with FieldDefs.AddFieldDef do
    begin
      Name := 'ff_Type';
      DataType := ftSmallint;
    end;
    with FieldDefs.AddFieldDef do
    begin
      Name := 'ff_FishNo';
      DataType := ftSmallint;
    end;
    with FieldDefs.AddFieldDef do
    begin
      Name := 'ff_Food';
      DataType := ftSmallint;
    end;
    with FieldDefs.AddFieldDef do
    begin
      Name := 'ff_Price';
      DataType := ftCurrency;
    end;
    with FieldDefs.AddFieldDef do
    begin
      Name := 'ff_pay';
      DataType := ftCurrency;
    end;
    with FieldDefs.AddFieldDef do
    begin
      Name := 'ff_No';
      DataType := ftSmallint;
    end;
    CreateTable;
    Active := false;
//    DatabaseName := g_options.DataBasePath;
    TableType := ttParadox;
    Active := True;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  prgPath := ExtractFilePath(Application.ExeName);
  txtFDate.Text := CurrentDate;
  txtTDate.Text := txtFDate.Text;

  if FileExists(prgPath + 'Fish.DB') and
     FileExists(prgPath + 'FishFood.DB') then
  begin
//    tblF.DatabaseName := prgPath;
//    tblFF.DatabaseName := prgPath;
    tblF.TableName := 'Fish';
    tblFF.TableName := 'FishFood';
    tblF.Open;
    tblFF.Open;
    RefreshData;
  end
  else
  begin
    lblTotal.Caption := '0';
    lblRecNo.Caption := '0';
  end;
end;

procedure TForm1.txtFDateExit(Sender: TObject);
begin
  with txtFDate do
    if Text <> '' then
      Text := BeautifulDate(Text);

  RefreshData;
end;

procedure TForm1.txtTDateExit(Sender: TObject);
begin
  with txtTDate do
    if Text <> '' then
      Text := BeautifulDate(Text);

  RefreshData;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, vadeh,
  recNo : Integer;
  p : TPerson;
begin
  if tblF.Active then
  begin
    recNo := 0;
    g_options.RunDate := '';
    while not tblF.Eof do
    begin
      Inc(recNo);
      lblRecNo.Caption := IntToStr(recNo);
      lblRecNo.Refresh;

      vadeh := tblF.FieldByName('Fish_Type').AsInteger;
      p := GetPerson(tblF.FieldByName('Fish_PCode').AsString, False);
      if g_options.RunDate <> tblF.FieldByName('Fish_Date').AsString then
      begin
        g_options.RunDate := tblF.FieldByName('Fish_Date').AsString;
        InitVariables(False);
      end;
      for i := 1 to 8 do
        if (not p.P_Rejim and
           ((Pow2(i) and  DayFoodList[vadeh].Keys[9])>0)) or
           (p.P_Rejim and
           ((Pow2(i) and  DayFoodList[vadeh].Keys[0])>0)) then
        begin
          if tblFF.Locate('FF_Date;FF_Type;FF_FishNo',VarArrayOf([tblF.FieldByName('Fish_Date').AsString,vadeh,tblF.FieldByName('Fish_No').AsInteger]) , [loCaseInsensitive]) then
            tblFF.Edit
          else
          begin
            tblFF.Append;
            tblFF.FieldByName('FF_Date').AsString := tblF.FieldByName('Fish_Date').AsString;
            tblFF.FieldByName('FF_Type').AsInteger := vadeh;
            tblFF.FieldByName('FF_FishNo').AsInteger := tblF.FieldByName('Fish_No').AsInteger;
            tblFF.FieldByName('FF_Food').AsInteger := DayFoodList[vadeh].Keys[i];
            tblFF.FieldByName('FF_Pay').AsCurrency := 0;
            tblFF.FieldByName('FF_No').AsInteger := 1;
          end;
          tblFF.FieldByName('FF_Price').AsCurrency := GetFoodPricePersonInRam(DayFoodList[vadeh].Keys[i]);
          tblFF.Post;
        end;


      tblF.Next;
      Application.ProcessMessages;
    end;
    tblFF.FlushBuffers;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  tblF.Close;
  tblFF.Close;
end;

procedure TForm1.btnRepairDuplicateClick(Sender: TObject);
var
  tblOld , tblNew : TTable;
  fld : TField;
  i : integer;
begin
  tblOld := TTable.Create(Application);
  tblNew := TTable.Create(Application);
  with tblOld do
  begin
//    DatabaseName := g_options.DataBasePath;
    TableType := ttParadox;
    TableName := 'fishfood.db';
    Active := True;
  end;
  tblOld.Close;
  if FileExists(g_options.DataBasePath + 'Temp.DB') then
    DeleteFile(g_options.DataBasePath + 'Temp.DB');
  if FileExists(g_options.DataBasePath + 'Temp.PX') then
    DeleteFile(g_options.DataBasePath + 'Temp.PX');
  tblOld.RenameTable('Temp');
  tblOld.Open;
{  tblold.Filtered := False;
  tblold.Filter := 'Ff_Date >= ''' + txtFDate.Text +
                    ''' AND Ff_Date <= ''' + txtTDate.Text + '''';
  tblold.Filtered := True;
}
  createFishFoodTable(tblNew);

  with tblNew do
    tblOld.First;
    while not tblOld.Eof do
    begin
      if not tblnew.Locate('ff_date;ff_fishno;ff_type;ff_food',
                VarArrayOf([tblOld.FieldByName('ff_date').AsString,
                           tblOld.FieldByName('ff_FishNo').AsString,
                           tblOld.FieldByName('ff_type').AsString,
                           tblOld.FieldByName('ff_food').AsString]),[loPartialKey])
      then
      begin
        tblNew.Append;
        for i := 0 to tblOld.FieldCount - 1 do
        begin
          fld := tblNew.FindField(tblOld.Fields[i].FieldName);
          if  fld <> nil then
          begin
            if tblNew.Fields[fld.FieldNo-1].DataType = tblOld.Fields[i].DataType then
              tblNew.FieldByName(tblOld.Fields[i].FieldName).Value := tblOld.Fields[i].Value;
          end;
        end;
        tblNew.Post;
      end;
      tblOld.Next;
      lblTotal.Caption := IntToStr(tblold.RecordCount);
      lblRecNo.Caption := IntToStr(tblold.RecNo);
      Application.ProcessMessages;
    end;
    tblOld.close;
    tblNew.Close;

//    tblOld.DeleteTable;

    tblOld.Destroy;
    tblNew.Destroy;
  end;

end.
