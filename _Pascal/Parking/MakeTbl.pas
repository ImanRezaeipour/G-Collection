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
//kaveh  SetFontColor(TForm(frmCreateTables));

  chklstTables.Hint := ('انتخاب معكوس = Ctrl+A');
end;

procedure TfrmCreateTables.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

procedure TfrmCreateTables.btnRepairTablesClick(Sender: TObject);
var i : Byte;
begin
  if ConfirmMessage('آيا براي بازسازی جداول اطلاعاتي اطمينان داريد؟') then
  begin
    for i := 0 to chklstTables.Count-1 do
      if chklstTables.Checked[i] then
        case i of
          0: UpgradeTable('BarCodes');
          1: UpgradeTable('Capacity');
          2:
          begin
            UpgradeTable('CarPark');
            UpgradeTable('Diff');
          end;
          3: UpgradeTable('Cars');
          4:
          begin
            UpgradeTable('CarTypes');
            UpgradeTable('NewCarTypes');
          end;
          5: UpgradeTable('Cities');
          6: UpgradeTable('CoCars');
          7: UpgradeTable('Colors');
          8:
          begin
            UpgradeTable('Customs');
            UpgradeTable('PayCust');
          end;
          9: UpgradeTable('Deleted');
          10: UpgradeTable('InOutCo');
          11: UpgradeTable('InputCar');
          12: UpgradeTable('Machines');
          13: UpgradeTable('NoCard');
          14: UpgradeTable('Persons');
          15: UpgradeTable('Readers');
          16: UpgradeTable('Security');
          17: UpgradeTable('Specials');
          18: UpgradeTable('Department');
          19: UpgradeTable('NewPersons');

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
          0: CreateTable('BarCodes', False);
          1: CreateTable('Capacity', False);
          2:
          begin
            CreateTable('CarPark', False);
            CreateTable('Diff', False);
          end;
          3: CreateTable('Cars', False);
          4:
          begin
            CreateTable('CarTypes', False);
            CreateTable('NewCarTypes', False);
          end;
          5: CreateTable('Cities', False);
          6: CreateTable('CoCars', False);
          7: CreateTable('Colors', False);
          8:
          begin
            CreateTable('Customs', False);
            CreateTable('PayCust', False);
          end;
          9: CreateTable('Deleted', False);
          10: CreateTable('InOutCo', False);
          11: CreateTable('InputCar', False);
          12: CreateTable('Machines', False);
          13: CreateTable('NoCard', False);
          14: CreateTable('Persons', False);
          15: CreateTable('Readers', False);
          16: CreateTable('Security', False);
          17: CreateTable('Specials', False);
          18: CreateTable('Department', False);
          19: CreateTable('NewPersons', False);

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

end.
