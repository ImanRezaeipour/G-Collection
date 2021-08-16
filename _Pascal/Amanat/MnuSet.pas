unit MnuSet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Math, Menus, Globals,
  CheckLst;

type
  TfrmMnuItemList = class(TForm)
    pnlButton: TPanel;
    cmdCancel: TBitBtn;
    cmdSave: TBitBtn;
    cmdAll: TBitBtn;
    cmdHelp: TBitBtn;
    chklstSubPrg: TCheckListBox;
    procedure FormActivate(Sender: TObject);
    procedure cmdAllClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
    mnus       : TMainMenu;
    mnuBarIdx  : Byte;
    MnuItemVal : String[50];
  end;


var
  frmMnuItemList : TfrmMnuItemList;

implementation

uses
  Funcs, FntSel;

{$R *.DFM}


procedure TfrmMnuItemList.SetWinF;
begin
  SetFontColor(TForm(frmMnuItemList));

  cmdAll.Caption := (cmdAll.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;



procedure TfrmMnuItemList.FormActivate(Sender: TObject);
var i, j : Byte;
begin
  SetWinF;
  if Length(MnuItemVal) < 50 then
    MnuItemVal := FixLen(MnuItemVal, '0', 50);

  j := 0;
  for i := 0 to mnus.Items[mnuBarIdx].Count-1 do
    if (mnus.Items[mnuBarIdx].Items[i].Caption <> '-') and (mnus.Items[mnuBarIdx].Items[i].Visible <> false) then
    begin
      chklstSubPrg.Items.Add(DelShortCut(mnus.Items[mnuBarIdx].Items[i].Caption));
      Inc(j);
      chklstSubPrg.Checked[j-1] := (MnuItemVal[j] = '1');
    end;

  if mnuBarIdx = 0 then
    j := chklstSubPrg.Count-1
  else if mnuBarIdx = 4 then
    j := chklstSubPrg.Count-4
  else
    j := chklstSubPrg.Count;

  if j < chklstSubPrg.Count then
    for i := j to chklstSubPrg.Count-1 do
    begin
      chklstSubPrg.ItemEnabled[i] := False;
      chklstSubPrg.Checked[i] := True;
    end;

end;

procedure TfrmMnuItemList.cmdAllClick(Sender: TObject);
var i : Byte;
begin
  for i := 0 to chklstSubPrg.Count-1 do
    if chklstSubPrg.ItemEnabled[i] then
      chklstSubPrg.Checked[i] := not chklstSubPrg.Checked[i];
end;

procedure TfrmMnuItemList.cmdSaveClick(Sender: TObject);
var i : Byte;
begin
  MnuItemVal := '';
  for i := 0 to chklstSubPrg.Count-1 do
    if chklstSubPrg.Checked[i] then
      MnuItemVal := MnuItemVal + '1'
    else
      MnuItemVal := MnuItemVal + '0';

  MnuItemVal := FixLen(MnuItemVal, '0', 50);
end;

procedure TfrmMnuItemList.cmdCancelClick(Sender: TObject);
begin
  MnuItemVal := '';
  MnuItemVal := FixLen(MnuItemVal, '0', 50);
end;

end.
