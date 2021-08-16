unit CreateDB;
{$I features}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CheckLst, DateProc;


type
  TfrmCreateDBs = class(TForm)
    cmdAll: TBitBtn;
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    chklstDBS: TCheckListBox;
    Label1: TLabel;
    cbyear: TComboBox;
    Label2: TLabel;
    chklstmonth: TCheckListBox;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdAllClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure checkchanges;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    SelectedAll : Boolean;

    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  DBTables, DB, ADODB, Globals, MSGs, DBS_proc, Funcs, MakeDB;

{$R *.DFM}


procedure TfrmCreateDBs.SetWinF;
var i : Byte;
begin
end;

procedure TfrmCreateDBs.FormCreate(Sender: TObject);
begin
  appType := appResturant;
  SelectedAll := False;
  cbyear.itemindex:=strtoint(copy(CurrentDate,1,4))-1379;
  SetWinF;
{$ifdef SaveErrorLogs}
  chklstDBS.Items.Add('»«‰ò Œÿ«Â«Ì  ÂÌÂ ›Ì‘');
{$endif SaveErrorLogs}
  checkChanges;
end;

procedure TfrmCreateDBs.BitBtn1Click(Sender: TObject);
var
  adoQRY : TADOQuery;
begin
  adoQRY := TADOQuery.Create(Application);
  with adoQRY do
  begin
    Connection := frmDBS.DBConnection;
    adoQRY.SQL.Clear;
    SQL.Add('update persons set p_credit = 0');
    ExecSQL;
  end;
  UpgradeTableOLD('fishfood',false);
  UpgradeTableOLD('prgprs',false);
  UpgradeTableOLD('charge',false);
end;

procedure TfrmCreateDBs.checkchanges;
begin
  Mouse_Wait;
  chklstDBS.Checked[0] := changedTbl('building');
  chklstDBS.Checked[1] := changedTbl('fish') or changedTbl('fishfood') or changedTbl('dblfish') or changedTbl('collect');
  chklstDBS.Checked[2] := changedTbl('foodlist');
  chklstDBS.Checked[3] := changedTbl('foodpric');
  chklstDBS.Checked[4] := changedTbl('groups') or changedTbl('outgroup');
  chklstDBS.Checked[5] := changedTbl('jobtype');
  chklstDBS.Checked[6] := changedTbl('parts');
  chklstDBS.Checked[7] := changedTbl('Persons');
  chklstDBS.Checked[8] := changedTbl('prgprs');
  chklstDBS.Checked[9] := changedTbl('rdrkey');
{$ifndef OperatorBase}
  chklstDBS.Checked[10] := changedTbl('readers');
{$endif OperatorBase}
  chklstDBS.Checked[11] := changedTbl('Security') or changedTbl('userstat');
  chklstDBS.Checked[12] := changedTbl('units');
  chklstDBS.Checked[13] := changedTbl('week');
  chklstDBS.Checked[14] := changedTbl('clckrecs');
  chklstDBS.Checked[15] := changedTbl('charge');
  chklstDBS.Checked[16] := changedTbl('reserve7');
  chklstDBS.Checked[17] := changedTbl('yaraneh');
  chklstDBS.Checked[18] := changedTbl('ghfish');
  chklstDBS.Checked[19] := changedTbl('stations');
{$ifdef SaveErrorLogs}
  chklstDBS.Checked[20] := changedTbl('errorlogs');
{$endif SaveErrorLogs}  
  Mouse_NoWait;
end;

procedure TfrmCreateDBs.cmdAllClick(Sender: TObject);
var i : Byte;
begin
  if not SelectedAll then
    cmdAll.Caption := ('Â&Ìçﬂœ«„')
  else
    cmdAll.Caption := ('Â&„Â');

  SelectedAll := not SelectedAll;
  for i := 0 to chklstDBS.Items.Count-1 do
    chklstDBS.Checked[i] := SelectedAll;
  {for i := 0 to chklstmonth.Items.Count-1 do
    chklstmonth.Checked[i] := SelectedAll;}
end;

procedure TfrmCreateDBs.cmdOKClick(Sender: TObject);
var
  adoTbl : TAdoTable;
  i : integer;
  fname : string;
  code : integer;
begin
  appType := appResturant;
  if ConfirmMessage('¬Ì« »—«Ì »«“”«“Ì »«‰ﬂÂ« «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    Mouse_Wait;
    if chklstDBS.Checked[0] then
//      UpgradeTable('building');
      UpgradeTableOLD('building');

    if chklstDBS.Checked[1] then
    begin
//      UpgradeTable('fish');
//      UpgradeTable('fishfood');
//      UpgradeTable('dblfish');
//      UpgradeTable('collect');
      UpgradeTableOLD('fish');
      UpgradeTableOLD('fishfood');
      UpgradeTableOLD('dblfish');
      UpgradeTableOLD('collect');
    end;

    if chklstDBS.Checked[2] then
//      UpgradeTable('foodlist');
      UpgradeTableOLD('foodlist');

    if chklstDBS.Checked[3] then
//      UpgradeTable('foodpric');
      UpgradeTableOLD('foodpric');

    if chklstDBS.Checked[4] then
    begin
      if not Linked_To_Clock then
//        UpgradeTable('groups');
        UpgradeTableOLD('groups');
//      UpgradeTable('outgroup');
      UpgradeTableOLD('outgroup');
    end;

    if chklstDBS.Checked[5] then
      if not Linked_To_Clock then
//        UpgradeTable('jobtype');
        UpgradeTableOLD('jobtype');

    if chklstDBS.Checked[6] then
      if not Linked_To_Clock then
//        UpgradeTable('parts');
        UpgradeTableOLD('parts');
    if chklstDBS.Checked[7] then
    begin
      frmDBS.TblPersons.Close;
      if not Linked_To_Clock then
//        UpgradeTable('persons');
        UpgradeTableOLD('persons');
      frmDBS.TblPersons.Open;
    end;

    if chklstDBS.Checked[8] then
//      UpgradeTable('prgprs');
      UpgradeTableOLD('prgprs');

    if chklstDBS.Checked[9] then
//      UpgradeTable('rdrkey');
      UpgradeTableOLD('rdrkey');

{$ifndef OperatorBase}
    if chklstDBS.Checked[10] then
//      UpgradeTable('readers');
      UpgradeTableOLD('readers');

{$endif OperatorBase}

    if chklstDBS.Checked[11] then
    begin
//      UpgradeTable('Security');
      UpgradeTableOLD('Security');
//      UpgradeTable('userstat');
      UpgradeTableOLD('userstat');
      adoTbl := TAdoTable.Create(Application);
      adoTbl.Connection := frmDBS.DBConnection;
      adoTbl.TableName := 'Security';
      adoTbl.Open;
      if not adoTbl.Locate('UserName','Admin',[loPartialKey]) then
      begin
        adoTbl.Append;
        adoTbl.FieldByName('UserName').AsString := 'Admin';
        adoTbl.FieldByName('Entery').AsBoolean := True;
        adoTbl.FieldByName('AccessPrint').AsBoolean := True;
        adoTbl.Post;
      end;
      adoTbl.Close;
      adoTbl.Free;
    end;

    if chklstDBS.Checked[12] then
//      UpgradeTable('units');
      UpgradeTableOLD('units');

    if chklstDBS.Checked[13] then
//      UpgradeTable('week');
      UpgradeTableOLD('week');

    if chklstDBS.Checked[14] then
//      UpgradeTable('clckrecs');
      UpgradeTableOLD('clckrecs');

    if chklstDBS.Checked[15] then
//      UpgradeTable('charge');
      UpgradeTableOLD('charge');

    if chklstDBS.Checked[16] then
//      UpgradeTable('reserve7');
      UpgradeTableOLD('reserve7');

    if chklstDBS.Checked[17] then
//      UpgradeTable('yaraneh');
      UpgradeTableOLD('yaraneh');

    if chklstDBS.Checked[18] then
//      UpgradeTable('ghfish');
      UpgradeTableOLD('ghfish');

    if chklstDBS.Checked[19] then
//      UpgradeTable('stations');
      UpgradeTableOLD('stations');

{$ifdef SaveErrorLogs}
    if chklstDBS.Checked[20] then
      UpgradeTableOLD('ErrorLogs');
{$endif SaveErrorLogs}

    Mouse_NoWait;
  end;
end;

end.

