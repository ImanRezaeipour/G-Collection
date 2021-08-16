unit slctPart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, vt, virtualTrees, ExtCtrls, ImgList, dmTree, DB,
  ADODB, globals, msgs, DosMove;

type
  TfrmSlctPart = class(TForm)
    cmdSelect: TBitBtn;
    cmdCancel: TBitBtn;
    imgsTree: TImageList;
    dtaParts: TDataSource;
    adoTblParts: TADOTable;
    chkViewCode: TCheckBox;
    GroupBox1: TGroupBox;
    txtName: TLabeledEdit;
    txtCode: TLabeledEdit;
    DosMove1: TDosMove;
    procedure cmdSelectClick(Sender: TObject);
    procedure partTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure chkViewCodeClick(Sender: TObject);
    procedure partTreeDblClick(Sender: TObject);
    procedure txtCodeChange(Sender: TObject);
    procedure txtNameEnter(Sender: TObject);
    procedure txtCodeEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    partCode : string;
    partTree : TGHVirtualStringTree;
    inSearch , doSearch , found : boolean;
  end;

function GetPart(init : string = '0') : string;

implementation

uses DBS_Proc ;

{$R *.dfm}



function GetPart(init: string = '0'): string;
var
  frmSlctPart: TfrmSlctPart;
begin
  Application.CreateForm(TfrmSlctPart, frmSlctPart);
  if frmSlctPart.ShowModal = mrOk then
    result := frmSlctPart.PartCode
  else
    result := init;
  frmSlctPart.Free;
end;


procedure TfrmSlctPart.cmdSelectClick(Sender: TObject);
var
  NodeD : ^rTreeData;
begin
  with PartTree do

  begin
    NodeD := partTree.GetNodeData(FocusedNode);
    if Assigned(FocusedNode) then
    begin
      partCode := NodeD.BasicND.CustomId;
//      if partCode <> '0' then
        ModalResult := mrOk;
    end
    else
    begin
      InformationMessage('»Œ‘Ì «‰ Œ«» ‰‘œÂ «”  .');
    end;

  end;
end;

procedure TfrmSlctPart.partTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  NodeD : ^rTreeData;
begin
{  NodeD := partTree.GetNodeData(Node);
  if (Assigned(noded) and Assigned(noded.basicnd)) then
    if NodeD.BasicND.CustomId = '0' then
    begin
      if doSearch and inSearch then
      begin
        doSearch := false;
        inSearch := false;
      end;
      CellText := NodeD.BasicND.Name;
      if doSearch then
      begin
        inSearch := not inSearch;
        found := false;
      end;
    end
    else
    begin
      if inSearch then
      begin
        if (NodeD.BasicND.CustomId = txtCode.Text) or (pos(txtName.Text , NodeD.BasicND.Name) <> 0) then
        begin
          found := true;
          inSearch := false;
          doSearch := false;
          partTree.Selected[Node] := true;
        end;
      end;
      if chkViewCode.Checked then
        CellText := NodeD.BasicND.Name + ' (' + NodeD.BasicND.CustomId + ')'
      else
        CellText := NodeD.BasicND.Name;
    end;
}
end;

procedure TfrmSlctPart.chkViewCodeClick(Sender: TObject);
begin
  partTree.ShowCode := chkViewCode.Checked;
end;

procedure TfrmSlctPart.partTreeDblClick(Sender: TObject);
begin
//  cmdSelect.Click;
end;

procedure TfrmSlctPart.txtCodeChange(Sender: TObject);
begin
  partTree.FullCollapse;
  partTree.FullExpand;
  doSearch := true;
  partTree.Refresh;
  partTree.Refresh;
end;

procedure TfrmSlctPart.txtNameEnter(Sender: TObject);
begin
  txtName.Text := '';
end;

procedure TfrmSlctPart.txtCodeEnter(Sender: TObject);
begin
  txtName.Text := '';
end;

procedure TfrmSlctPart.FormShow(Sender: TObject);
begin
//  TreeDM.LoadSubTree(partTree, adoTblParts, GetPartCode(g_Options.userParts));
{  if g_Options.userParts <> '' then
    partTree.LoadSubTree(IntToStr(GetPartCode(g_Options.userParts), '1')
  else
}
  if g_Options.userParts = ''
  then partTree.LoadSubTree('-1')
  else partTree.LoadSubTree(GetPartCode(g_Options.userParts));

  found := false;
  doSearch := false;
  inSearch := false;
end;

procedure TfrmSlctPart.FormCreate(Sender: TObject);
begin
  partTree := TGHVirtualStringTree.Create(Self, adotblParts);
  partTree.Width := 416;
  partTree.Height := 337;
  partTree.Left := 2;
  partTree.Top := 60;
  partTree.Parent := Self;
  partTree.Visible := True;

//  partTree.NodeDataSize := SizeOf(rTreeData);
  adoTblParts.Connection := frmDBS.DBConnection ;
  adoTblParts.Open;
end;

end.

object partTree: TVirtualStringTree
  Left = 2
  Top = 60
  Width = 416
  Height = 337
  BorderStyle = bsNone
  Color = clInfoBk
  DrawSelectionMode = smBlendedRectangle
  Header.AutoSizeIndex = -1
  Header.Font.Charset = DEFAULT_CHARSET
  Header.Font.Color = clWindowText
  Header.Font.Height = -11
  Header.Font.Name = 'MS Sans Serif'
  Header.Font.Style = []
  Header.MainColumn = -1
  Header.Options = [hoColumnResize, hoDrag]
  HintMode = hmTooltip
  Images = imgsTree
  IncrementalSearch = isAll
  IncrementalSearchTimeout = 2000
  Indent = 20
  ParentShowHint = False
  RootNodeCount = 1
  ShowHint = False
  TabOrder = 4
  TreeOptions.AnimationOptions = [toAnimatedToggle]
  TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
  TreeOptions.SelectionOptions = [toFullRowSelect, toLevelSelectConstraint, toRightClickSelect]
  OnDblClick = partTreeDblClick
  OnGetText = partTreeGetText
  Columns = <>
  WideDefaultText = 'root'
end


