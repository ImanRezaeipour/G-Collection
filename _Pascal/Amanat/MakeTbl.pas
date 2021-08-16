unit MakeTbl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst;

type
  TfrmCreateTables = class(TForm)
    chklstTables: TCheckListBox;
    btnSelect: TBitBtn;
    btnCreateTables: TBitBtn;
    btnRepairTables: TBitBtn;
    btnHelp: TBitBtn;
    btnClose: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnCreateTablesClick(Sender: TObject);
    procedure chklstTablesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRepairTablesClick(Sender: TObject);
    procedure checkchanges; //kaveh
  private
    { Private declarations }

    procedure SetWinF;

  public
    { Public declarations }
  end;

var
  frmCreateTables: TfrmCreateTables;


implementation

uses
  Funcs, DBS, MSGs, FntSel;

{$R *.dfm}

procedure TfrmCreateTables.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmCreateTables));

  chklstTables.Hint := ('انتخاب معكوس = Ctrl+A');
end;

procedure TfrmCreateTables.FormCreate(Sender: TObject);
begin
  SetWinF;
//  SelectedAll := False;
{  checkchanges;}
end;

procedure TfrmCreateTables.btnRepairTablesClick(Sender: TObject);
var i : Byte;
begin
  if ConfirmMessage('آيا براي بازسازی جداول اطلاعاتي اطمينان داريد؟') then
  begin
    for i := 0 to chklstTables.Count-1 do
      if chklstTables.Checked[i] then
        case i of
          0: UpgradeTable('Department');
          1: UpgradeTable('Units');
          2: UpgradeTable('CoPosts');
          3: UpgradeTable('Parts');
          4: UpgradeTable('Services');

          5:
          begin
            UpgradeTable('Discount');
            UpgradeTable('DscntDtl');
          end;
          6: UpgradeTable('Employee');
          7:begin
             UpgradeTable('ChargeDtl');
             UpgradeTable('ChargeGrp');
            end;
          8:
          begin
            UpgradeTable('Receipt1');
            UpgradeTable('Receipt2');
          end;
          9: UpgradeTable('Readers');
          10: UpgradeTable('Users');
          11: UpgradeTable('UserStat');
          12: UpgradeTable('LostCard');
          13: UpgradeTable('MoRanges'); //kaveh
          14: UpgradeTable('Params'); //kaveh

        end;
    InformationMessage('جداول اطلاعاتي بازسازی شدند.');
  end;
end;

procedure TfrmCreateTables.btnSelectClick(Sender: TObject);
var i : Byte;
begin
  for i := 0 to chklstTables.Count-1 do
    chklstTables.Checked[i] := not chklstTables.Checked[i];
end;

procedure TfrmCreateTables.btnCreateTablesClick(Sender: TObject);
var i : Byte;
begin
  if ConfirmMessage('آيا براي ايجاد جداول اطلاعاتي اطمينان داريد؟') then
  begin
    for i := 0 to chklstTables.Count-1 do
      if chklstTables.Checked[i] then
        case i of
          0: CreateTable('Department');
          1: CreateTable('Units');
          2: CreateTable('CoPosts');
          3: CreateTable('Parts');
          4: CreateTable('Services');

          5:
          begin
            CreateTable('Discount');
            CreateTable('DscntDtl');
          end;
          6: CreateTable('Employee');
          7:
          begin
           CreateTable('ChargeDtl');
           CreateTable('ChargeGrp');

           end;
          8:
          begin
            CreateTable('Receipt1');
            CreateTable('Receipt2');
          end;
          9: CreateTable('Readers');
          10: CreateTable('Users');
          11: CreateTable('UserStat');
          12: CreateTable('LostCard');
          13: CreateTable('MoRanges'); //kaveh
          14: CreateTable('Params'); //kaveh

        end;
    InformationMessage('جداول اطلاعاتي ايجاد شدند.');
  end;
end;

procedure TfrmCreateTables.chklstTablesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 65) and (Shift = [ssCtrl]) then
    btnSelectClick(Sender);
end;

//kaveh ie
procedure TfrmCreateTables.checkchanges;
{var
//  adoTbl : TAdoTable;
  i : integer;
  fname : string;
  code : integer;}
begin
{    Mouse_Wait;
    chklstTables.Checked[0] :=
      changedtbl('Department');

    chklstTables.Checked[1] :=
      changedtbl('Units');

    chklstTables.Checked[2] :=
      changedtbl('CoPosts');

    chklstTables.Checked[3] :=
      changedtbl('Parts');

    chklstTables.Checked[4] :=
      changedtbl('Services');

    chklstTables.Checked[5] :=
      changedtbl('Discount') or
      changedtbl('DscntDtl');

    chklstTables.Checked[6] :=
      changedtbl('Employee');

    chklstTables.Checked[7] :=
      changedtbl('ChargeDtl') or
      changedtbl('ChargeGrp');


    chklstTables.Checked[8] :=
      changedtbl('Receipt1') or
      changedtbl('Receipt2');
      
    chklstTables.Checked[9] :=
      changedtbl('Readers');

    chklstTables.Checked[10] :=
      changedtbl('Users');

    chklstTables.Checked[11] :=
      changedtbl('UserStat');

    chklstTables.Checked[12] :=
      changedtbl('LostCard');

    chklstTables.Checked[13] :=
      changedtbl('MoRanges');

    chklstTables.Checked[14] :=
      changedtbl('Params');

    Mouse_NoWait; }
end;
//kaveh ie
end.
