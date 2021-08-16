unit vt;

interface

uses
  SysUtils, VirtualTrees, Classes, Menus, StdCtrls, partDef, Forms, Controls, ADODB, Dialogs, DBS_Proc , Funcs;

type
TBasicNodeData = class
  protected
    cName : ShortString;       // The name of a part
    cId   : String;             // id that is generated automatically by the program
    ccId  : String;            //id that is assigned manually by the user
  public
    constructor Create(vName: ShortString; vId: String; vCustomId : string);

    property Name: ShortString read cName write cName;
    property ID: String read cId write cId;         //id that is generated automatically by the program
    property CustomId: String read ccId write ccId; //id that is assigned manually by the user
  end;

type
  rTreeData = record
    NodeD : TBasicNodeData;
  end;

type
  PrTreeData = ^rTreeData;

type
  TGHVTPopupMenu = class(TPopupMenu)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); overload;override;
    constructor Create(AOwner : TComponent; EditClick : TNotifyEvent;
                                           AddChildClick : TNotifyEvent;
                                           AddSiblingClick : TNotifyEvent;
                                           SaveTreeClick : TNotifyEvent;
                                           DeleteClick : TNotifyEvent);overload;
  published
    { Published declarations }
  end;

type
  TGHVirtualStringTree = class(TVirtualStringTree)
  private
    { Private declarations }
    _showCode : Boolean;
    _getInformationForm : TfrmPartDef;
    _partTable : TADOTable;                      // the table for storing the tree in a database
    _tempNodes : array[1..5000] of PVirtualNode;  // An array to hold the nodes retrieved from database to be used during the LoadTree method to improve performance.
//    _getText : TVSTGetTextEvent;
    function GetPartInformation(addType : String ; inputPartName : String = ''; inputPartCCID : String = '') : TBasicNodeData;
    function FindFatherInTable(fatherID: string) : Boolean;
    function FindFatherNode : PVirtualNode;
    procedure _onGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    function AddChildPartWithNodeData(fatherNode : PVirtualNode; NodeD : TBasicNodeData; Mode: TVTNodeAttachMode) : PVirtualNode;
    function FindIDInTable(strId: string): integer;
    function LevelIsBelow(primaryID: String; secondaryID : String): Boolean;
    procedure ClearTempNodes;
    function GetShowCode: Boolean;
    procedure SetShowCode(const Value: Boolean);

  protected
    procedure SetNodeData(Node : PVirtualNode; NodeData : TBasicNodeData);
    procedure AddChildPart(Sender : TObject);
    procedure AddSiblingPart(Sender : TObject);
    procedure EditNode(Sender : TObject);
    procedure DeleteNode(Sender : TObject); overload;
    procedure ClearTable;
    procedure InsertNodeToTable(newNode : PVirtualNode);
    function  GetNewID(fatherNode : PVirtualNode) : String;
    function IsCustomIdRepeated(strCustomId : String) : Boolean;
    function LocateCustomIdInTree(strCustomId : String) : Boolean;
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); overload; override;
    constructor Create(AOwner : TComponent; table : TADOTable); overload;
    procedure LoadTree(Sender : TObject);
    procedure SaveTree(Sender : TObject);
    procedure LoadSubTree(strID: String; selectedID : String='-1');
  published
    property ShowCode : Boolean read GetShowCode write SetShowCode default False;

    { Published declarations }
  end;

implementation

{ TGHVirtualStringTree }

procedure TGHVirtualStringTree._onGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  nodeData : PrTreeData;
begin
  nodeData := GetNodeData(Node);

  if (Assigned(nodeData) and Assigned(nodeData.NodeD)) then
    if nodeData.NodeD.CustomId = '0' then
      CellText := nodeData.NodeD.Name
    else
      if _showCode then
        CellText := nodeData.NodeD.Name + ' (' + nodeData.NodeD.CustomId + ')'
      else
        CellText := nodeData.NodeD.Name;
end;

procedure TGHVirtualStringTree.AddChildPart(Sender: TObject);
// This procedure is to be used as an event handler. It adds a new node as a child to the focused node
// the data for this new node is that user enters in the _getInformationForm
var
  NodeD : TBasicNodeData;
  ghadirId : string;
begin
  // The next line was only added for giving the user a new id. This id is our background id (ghadirid).
  ghadirId := GetNewID(FocusedNode);
  NodeD := GetPartInformation('AddChild', '', ghadirId);
  if Assigned(NodeD) then
    if not IsCustomIdRepeated(NodeD.ccId) then
      AddChildPartWithNodeData(FocusedNode, NodeD, amAddChildLast)
    else
      ShowMessage('ﬂœÌ ﬂÂ «Œ ’«’ œ«œÂ «Ìœ  ﬂ—«—Ì „Ì »«‘œ');
end;

constructor TGHVirtualStringTree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NodeDataSize := SizeOf(rTreeData);
  PopupMenu := TGHVTPopupMenu.Create(AOwner, EditNode, AddChildPart, AddSiblingPart, SaveTree, DeleteNode);
  TreeOptions.SelectionOptions := [toRightClickSelect];
  BiDiMode := bdRightToLeft;

  OnGetText := Self._onGetText;
end;


function TGHVirtualStringTree.FindFatherNode : PVirtualNode;
// This method supposes that the current record of the parts table represents the node which we want to find its father.
// But note that it does not change the RecNo.
var
  fatherID: string;
  iTempRecNo: Integer;
begin
  if _partTable.FieldByName('P_Father').AsString <> '-1' then
    begin
    fatherID := _partTable.FieldByName('P_Father').AsString;
    iTempRecNo := _partTable.RecNo;
    if (FindFatherInTable(fatherID)) then
      begin
      if Assigned(_tempNodes[_partTable.RecNo]) then                 
        Result := _tempNodes[_partTable.RecNo]
      else
// This condition occurs when we want to show a subtree. So the first node should be showed as the child of RootNode.
        Result := RootNode;
      end
    else
      begin
      ShowMessage('The parts table is corrupted.');
      exit;
      end;
    _partTable.RecNo := iTempRecNo;
    end
  else
    Result := RootNode;
end;

function TGHVirtualStringTree.FindFatherInTable(fatherID: string) : Boolean;
begin
// We suppose that _partTable.RecNo has the value related to the current node (The node that we want to find its father).
  while (not _partTable.Bof) and (_partTable.FieldByName('P_Code').AsString <> fatherID) do
    _partTable.Prior;
  if(_partTable.FieldByName('P_Code').AsString = fatherID) then
    Result := True
  else
    Result := False;
end;

function TGHVirtualStringTree.GetPartInformation(addType : String;
                                                inputPartName : String = '';
                                                inputPartCCID : String = '') : TBasicNodeData;
// This method shows the user a form to enter part information. then if he click ok on that form,
// this method will return the information which user entered. Note we supposed that the FocusedNode
// is the father of the node we are getting its information from user. so calling GetNewID is based
// on this suppose.

var
  partName : String;
  partCCID : String;
  partID : String;
begin
  _getInformationForm := TfrmPartDef.Create(Self);
  if(inputPartName<>'')then
    _getInformationForm.txtName.Text:=inputPartName;
  if(inputPartCCID<>'')then
    _getInformationForm.txtCode.Text:=inputPartCCID;

  if _getInformationForm.ShowModal = mrOk then
    begin
    partName := _getInformationForm.txtName.Text;
    partCCID := _getInformationForm.txtCode.Text;
    if addType = 'AddChild' then
      begin
      if Assigned(FocusedNode) then
        partID := GetNewID(FocusedNode)
      else
        partID := GetNewID(RootNode);
      end
    else if addType = 'AddSibling' then
      begin
      if Assigned(FocusedNode) then
        partID := GetNewID(FocusedNode.Parent)
      end
    else if addType = 'Edit' then
      begin
        // do nothing
      end;
    Result := TBasicNodeData.Create(partName, partID, partCCID);
    end
  else
    Result := nil;
end;

procedure TGHVirtualStringTree.SaveTree(Sender: TObject);
var
  CurNode {Current Node} : PVirtualNode;
  index : integer;
begin
  ClearTable;
  CurNode := RootNode.FirstChild;
  index := 1;

  while Assigned(CurNode) do
    begin
    InsertNodeToTable(CurNode);
    CurNode := GetNext(CurNode);
    Inc(index);
    end;
end;

function TGHVirtualStringTree.AddChildPartWithNodeData(fatherNode:PVirtualNode; NodeD : TBasicNodeData; Mode: TVTNodeAttachMode) : PVirtualNode;
var
  tmpNode: PVirtualNode;
begin
  tmpNode := InsertNode(fatherNode, Mode);
  SetNodeData(tmpNode, NodeD);
  Result := tmpNode;
end;

procedure TGHVirtualStringTree.AddSiblingPart(Sender: TObject);
// This procedure is to be used as an event handler. It adds a new node as a sibling to the focused node
// the data for this new node is the one that user enters in the _getInformationForm
var
  NodeD : TBasicNodeData;
  ghadirId : String;
begin
  if Assigned(FocusedNode) then
    begin
    // The next line was only added for giving the user a new id. This id is our background id (ghadirid).
    ghadirId := GetNewID(FocusedNode.Parent);
    NodeD := GetPartInformation('AddSibling', '', ghadirId);
    if Assigned(NodeD) then
      if not IsCustomIdRepeated(NodeD.ccId) then
        AddChildPartWithNodeData(FocusedNode, NodeD, amInsertAfter)
      else
        ShowMessage('ﬂœÌ ﬂÂ «Œ ’«’ œ«œÂ «Ìœ  ﬂ—«—Ì „Ì »«‘œ');
    end;
{ TODO -oMahdyar : It is good that in the else section we inform the user that he can not add a child as a sibling in a clear tree }
end;

procedure TGHVirtualStringTree.EditNode(Sender: TObject);
// This procedure is to be used as an event handler. It edits the focused node.
// the new data for this node is the one that user enters in the _getInformationForm
var
  nodeData : PrTreeData;
  tmpNodeD : TBasicNodeData;

begin
  if Assigned(FocusedNode) then
    begin
    nodeData := GetNodeData(FocusedNode);
    tmpNodeD := GetPartInformation('Edit', nodeData.NodeD.Name, nodeData.NodeD.CustomId);
    if Assigned(tmpNodeD) then
      begin
// we should not change the ID. So we use the old ID.
      tmpNodeD.ID := nodeData.NodeD.ID;
      nodeData.NodeD := tmpNodeD;
      end;
    end;
{ TODO -oMahdyar : It is good that in the else section of (if Assigned(FocusedNode) then) we inform the user that he should select a part in order to edit it. }
end;

function TGHVirtualStringTree.GetNewID(fatherNode : PVirtualNode): String;
// This function will return a unique code for cId of the new child of fatherNode. 
var
  nodeData : PrTreeData;
  tmpStr : String;
begin
  Result := '';
  if Assigned(fatherNode) then
    begin
    if (fatherNode <> RootNode) then
      begin
      nodeData := GetNodeData(fatherNode);
      Result := nodeData.NodeD.ID;
      end;
    tmpStr := IntToStr(fatherNode.ChildCount);
    tmpStr := FixLeft(tmpStr, '0', 2);
    Result := Result + tmpStr;
    end
  else
    begin
    tmpStr := IntToStr(RootNode.ChildCount);
    tmpStr := FixLeft(tmpStr, '0', 2);
    Result := tmpStr;
    end;
end;

procedure TGHVirtualStringTree.InsertNodeToTable(newNode: PVirtualNode);
var
  nodeData: PrTreeData;
  strLChildId, strFatherId, strRSibId, strId, strCustomId : String;
  sName : String;
begin
  nodeData := GetNodeData(newNode);
  strID := nodeData.NodeD.id;
  strCustomId := nodeData.NodeD.CustomId;
  sName := nodeData.NodeD.Name;

  nodeData := GetNodeData(newNode.NextSibling);
  if Assigned(nodeData) then
    strRSibId := nodeData.NodeD.id
  else
    strRSibId := '-1';

  nodeData := GetNodeData(newNode.FirstChild);
  if Assigned(nodeData) then
    strLChildId := nodeData.NodeD.id
  else
    strLChildId := '-1';

  if newNode.Parent <> RootNode then
    begin
    nodeData := GetNodeData(newNode.Parent);
    strFatherId := nodeData.NodeD.id;
    end
  else
    strFatherId := '-1';

  _partTable.InsertRecord([strID, strCustomId, sName, strLChildId, strRSibId, strFatherId]);
end;

procedure TGHVirtualStringTree.ClearTable;
var
  adoqryTemp : TADOQuery;
begin
  adoqryTemp := TADOQuery.Create(Self);
  adoqryTemp.Connection := frmDBS.DBConnection  ;
  if not _partTable.IsEmpty then
    begin
    adoqryTemp.SQL.Add('Delete from parts');
    adoqryTemp.ExecSQL;
    end;
end;

procedure TGHVirtualStringTree.LoadTree(Sender: TObject);
begin
  LoadSubTree('-1', '');
end;

procedure TGHVirtualStringTree.LoadSubTree(strID : String; selectedID : String = '-1');
// The selectedID is the id of the node which we want to be selected after loading the tree.
// You (as the user of this method) can send nothing as the selectedID if you do not want any
// node be selected after loading tree.
var
  NodeD : TBasicNodeData;
  fatherNode, newNode: PVirtualNode;
begin
  ClearTempNodes;
// Clear the tree
  Clear;
  if _partTable.IsEmpty then
    exit;
  _partTable.IndexFieldNames := 'P_Code';

// if strID is -1 it means that we want to load all the tree. else we want to load only a subtree.
  if strID<>'-1' then
    begin
    if (FindIDInTable(strID)=-1) then
      begin
      MessageDlg('The node you are searching is not in the table.', mtWarning, [mbOK], 0);
      exit;
      end;

    while not _partTable.Eof do
      begin
      NodeD := TBasicNodeData.Create(_partTable.FieldByName('P_Name').AsString,
                                     _partTable.FieldByName('P_Code').AsString,
                                     _partTable.FieldByName('P_CustomCode').AsString);
      fatherNode := FindFatherNode;

      if not LevelIsBelow(strID, NodeD.ID) then
        begin
        _partTable.IndexFieldNames := '';
        exit;
        end;
      newNode := AddChildPartWithNodeData(fatherNode, NodeD, amAddChildLast);
      if NodeD.ID = selectedID then
        Selected[newNode] := True;
      _tempNodes[_partTable.RecNo] := newNode;
      _partTable.Next;
      end;
    end

  else
    begin
    _partTable.First;
    while not _partTable.Eof do
      begin
      NodeD := TBasicNodeData.Create(_partTable.FieldByName('P_Name').AsString,
                                     _partTable.FieldByName('P_Code').AsString,
                                     _partTable.FieldByName('P_CustomCode').AsString);
      fatherNode := FindFatherNode;
      newNode := AddChildPartWithNodeData(fatherNode, NodeD, amAddChildLast);
      if NodeD.ID = selectedID then
        Selected[newNode] := True;
      _tempNodes[_partTable.RecNo] := newNode;
      _partTable.Next;
      end;
    end;

  _partTable.IndexFieldNames := '';
end;

function TGHVirtualStringTree.FindIDInTable(strId: string) : integer;
var
  i : integer;
  retry: Boolean;
begin
  retry := True;
  _partTable.First;
  Result := -1;
  while not _partTable.Eof and retry do
    begin
    if _partTable.FieldByName('P_Code').AsString = strId then
      begin
      Result := _partTable.RecNo;
      retry := False;
      end;
    if retry then
      _partTable.Next;
    end;
end;

function TGHVirtualStringTree.LevelIsBelow(primaryID:String; secondaryID:String) : Boolean;
begin
  if primaryID = secondaryID then
    Result := True
  else
    begin
    if Length(primaryID)<Length(secondaryID) then
      Result := True
    else
      Result := False;
    end;
end;

constructor TGHVirtualStringTree.Create(AOwner: TComponent; table: TADOTable);
begin
  Create(AOwner);
  if (Assigned(table)) then
    _partTable := table
  else
    ShowMessage('The table is nil.');
end;



procedure TGHVirtualStringTree.SetNodeData(Node: PVirtualNode;
  NodeData: TBasicNodeData);
var
  tmpNodeData : PrTreeData;
begin
  tmpNodeData := GetNodeData(Node);
  tmpNodeData.NodeD := NodeData;
end;

procedure TGHVirtualStringTree.DeleteNode(Sender: TObject);
begin
if Assigned(FocusedNode) then
  DeleteNode(FocusedNode);
end;

procedure TGHVirtualStringTree.ClearTempNodes;
var
  i : integer;
begin
  for i:=1 to 5000 do
    _tempNodes[i] := nil;
end;

function TGHVirtualStringTree.GetShowCode: Boolean;
begin
  Result := _showCode;
end;

procedure TGHVirtualStringTree.SetShowCode(const Value: Boolean);
begin
  _showCode := Value;
  Refresh;
end;

function TGHVirtualStringTree.IsCustomIdRepeated(strCustomId: String): Boolean;
// this function check that if the customid parameter has been allocated before or not by searching it
// in both table and tree.
begin
  Result := _partTable.Locate('P_CustomCode', strCustomId, []) or LocateCustomIdInTree(strCustomId);
end;

function TGHVirtualStringTree.LocateCustomIdInTree(
  strCustomId: String): Boolean;
var
  CurNode : PVirtualNode;
  nodeData : PrTreeData;
begin
  CurNode := RootNode.FirstChild;
  Result := False;

  while Assigned(CurNode) do
    begin
    nodeData := GetNodeData(CurNode);
    if Assigned(nodeData) then
      if nodeData.NodeD.ccId = strCustomId then
        begin
        Result := True;
        Break;
        end;
    CurNode := GetNext(CurNode);
    end;
end;

{ TGHVTPopupMenu }

constructor TGHVTPopupMenu.Create(AOwner: TComponent; EditClick, AddChildClick,
  AddSiblingClick, SaveTreeClick, DeleteClick: TNotifyEvent);
begin
  Create(AOwner);
// We assumed that all the TNotifyEvent parameters of this method are not nil.
  Items[0].OnClick := AddChildClick;
  Items[1].OnClick := AddSiblingClick;
  Items[2].OnClick := SaveTreeClick;
  Items[3].OnClick := EditClick;
  Items[4].OnClick := DeleteClick;
end;

constructor TGHVTPopupMenu.Create(AOwner: TComponent);
var
  mnuItemTemps : array[1..5] of TMenuItem;
  i : integer;
begin
  inherited;
  for i:= 1 to 5 do
    begin
    mnuItemTemps[i] := TMenuItem.Create(Owner);
    end;

  with mnuItemTemps[1] do
    begin
    MenuIndex := 0;
    Name := 'mnuAddChild';
    Caption := '“Ì— »Œ‘ ÃœÌœ';
    end;

  with mnuItemTemps[2] do
    begin
    MenuIndex := 1;
    Name := 'mnuAddSibling';
    Caption := '»Œ‘ ÃœÌœ';
    end;

  with mnuItemTemps[3] do
    begin
    MenuIndex := 2;
    Name := 'mnuSaveTree';
    Caption := '–ŒÌ—Â';
    end;

  with mnuItemTemps[4] do
    begin
    MenuIndex := 3;
    Name := 'mnuEdit';
    Caption := '«’·«Õ';
    end;

  with mnuItemTemps[5] do
    begin
    MenuIndex := 4;
    Name := 'mnuDelete';
    Caption := 'Õ–›';
    end;

  Items.Add(mnuItemTemps);
end;

{ TBasicNodeData }

constructor TBasicNodeData.Create(vName: ShortString; vId, vCustomId: string);
begin
  cName := vName;
  cId := vId;
  ccId := vCustomId;
end;


end.
