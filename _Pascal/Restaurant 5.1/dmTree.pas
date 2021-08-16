unit dmTree;

interface

uses
  SysUtils, Classes, VirtualTrees, Contnrs, ADODB, Dialogs, DB, DBTables,
  Parts, Windows, IDglobal;

const MAX = 5000;

type
  TTableFld = record
    FatherID : Longint;
    MesID : Longint;
    GhadirID : String;
    Node : PVirtualNode;
    Name : String;
  end;

type
  recTmpNode = record
    Code : string;
    CustomCode : string;
    Name : string;
    LChild : string;
    RSibling : string;
    Father : string;
    Node : PVirtualNode;
  end;

type arrTmpTreeTbl = array[1..MAX] of recTmpNode;
type arrTmpTbl = array[1..MAX,1..6] of string;

type
  TTreeDM = class(TDataModule)
    adoqryTemp: TADOQuery;
//    procedure tblTempCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure LocateNodeInTable(Tree : TVirtualStringTree ; Node : PVirtualNode; adoTbl : TADOTable);
    procedure DelSubTreeFromTable(strRootID: String ; adoTbl : TADOTable);
    procedure AddExistNode(Tree : TVirtualStringTree ; Node:PVirtualNode ; adoTbl : TADOTable); overload;
    procedure AddExistNode(Tree : TVirtualStringTree ; Node:PVirtualNode ; var arrTbl : arrTmpTbl; index : integer); overload;
{ TODO :
If we don't need this function we can delete this prototype and 
delete the function declaration too. }
    //function GetNewGhadirID(Tree : TVirtualStringTree;FatherNode : PVirtualNode) : string;
    { Private declarations }
  public
    procedure SaveSubTree2(Tree : TVirtualStringTree; Root   : PVirtualNode; adoTbl : TADOTable );
    procedure SaveSubTree(Tree : TVirtualStringTree; Root   : PVirtualNode; adoTbl : TADOTable );
    procedure LoadSubTree2(Tree : TVirtualStringTree; adoTbl : TADOTAble   ; strID  : String='00');
    procedure LoadSubTree(Tree : TVirtualStringTree; adoTbl : TADOTAble   ; strID  : String='00');
//    procedure LoadMesTree(Tree : TVirtualStringTree; strID  : String='00');
    function CopyTreeTblToArr(adoTbl : TADOTable; var TempTree1 : arrTmpTreeTbl) : integer;
    function FindIdOnArr(TempTree1 : arrTmpTreeTbl; strId : string) : integer;
    function FindFatherOfNode(idxCurFather : integer; idxCurNode : integer; arrTable : array  of TTableFld) : integer;
    { Public declarations }
  end;



type
  TStrStack = class
  private
    str : array[1..10000] of String;
    top : integer;
  public
    procedure Push(strSource : String);
    Constructor Create;
    function Pop : String;
    function AtLeastOne : Boolean;
end;


type
TBasicNodeData = class
  protected
    cName : ShortString;       // The name of a part
    cId   : String;             // id that is generated automatically by the program
    ccId  : String;            //id that is assigned manually by the user
  public
    constructor Create(vName: ShortString; vId: String; VCustomId : string);

    property Name: ShortString read cName write cName;
    property id: String read cId write cId;         //id that is generated automatically by the program
    property CustomId: String read ccId write ccId; //id that is assigned manually by the user
  end;

  rTreeData = record
    BasicND: TBasicNodeData;
  end;

var
  TreeDM: TTreeDM;

implementation

uses Funcs,dbs_proc;


{$R *.dfm}

{ TTree }


procedure TTreeDM.LoadSubTree2(Tree: TVirtualStringTree; adoTbl : TADOTable ; strID: String='00');
  { This procedure gets a tree and the id of the root of a sub tree. then it
    loads the sub tree from the table. }
var
  NodeD : ^rTreeData;
  FatherNode, tmpNode : PVirtualNode;
  stkFather : TStack;
  strstkLChild : TStrStack;
  strTempId, strTempLChildId : String;
  TempTree1 : arrTmpTreeTbl;
  ixTempTree : integer;
begin

  if strID = '' then strID := '00';
  adoTbl.IndexFieldNames := 'P_Code';
  if adoTbl.IsEmpty then
    exit;

  CopyTreeTblToArr(adoTbl, TempTree1);

// begin initialization
  stkFather := TStack.Create;
  strstkLChild := TStrStack.Create;
  Tree.Clear;
// end initialization

  ixTempTree := FindIdOnArr(TempTree1, strId);
  repeat
    while stkFather.AtLeast(1) do
      stkFather.Pop;
// begin Add the first node as the root
    tmpNode := Tree.AddChild(nil);
    NodeD := Tree.GetNodeData(tmpNode);
    NodeD.BasicND := TBasicNodeData.Create(TempTree1[ixTempTree].Name, TempTree1[ixTempTree].Code, TempTree1[ixTempTree].CustomCode);
// end Add the first node as the root

    strTempLChildId := TempTree1[ixTempTree].LChild;
    stkFather.Push(tmpNode);
    strstkLChild.Push(strTempLChildId);
    while strstkLChild.AtLeastOne do
      begin
  // The first child of the last sibling. (At the first the last sibling is the root itself)
        strTempId:=strstkLChild.Pop;
  // If it is NOT the root
      if stkFather.AtLeast(1) then
        FatherNode := stkFather.Pop
  // If it is the root
      else
        FatherNode := nil;
  // if there is any child
      if (strTempId<>'-1') then
        begin
        ixTempTree := FindIdOnArr(TempTree1, strTempId);
  // begin add node to the Tree
        tmpNode := Tree.MakeNewNode;
        Tree.InternalConnectNode(tmpNode, FatherNode, Tree, amAddChildLast);
        NodeD := Tree.GetNodeData(tmpNode);
        NodeD.BasicND := TBasicNodeData.Create(TempTree1[ixTempTree].Name, TempTree1[ixTempTree].Code, TempTree1[ixTempTree].CustomCode);
  // end add node to the Tree

  // begin provide pTempLChildId to push the LeftChild to the strstkLChild

        strTempLChildId := TempTree1[ixTempTree].LChild;
  // end provide pTempLChildId to push the LeftChild to the strstkLChild

        stkFather.Push(tmpNode);
        strstkLChild.Push(strTempLChildId);

  // begin trace the Tree to the last sibling of the current child
        while (TempTree1[ixTempTree].RSibling<>'-1') do
          begin
  // go to the right sibling
          ixTempTree := FindIdOnArr(TempTree1, TempTree1[ixTempTree].RSibling);
  // begin add node to the Tree
          tmpNode := Tree.MakeNewNode;
          Tree.InternalConnectNode(tmpNode, FatherNode, Tree, amAddChildLast);
          NodeD := Tree.GetNodeData(tmpNode);
          NodeD.BasicND := TBasicNodeData.Create(TempTree1[ixTempTree].Name, TempTree1[ixTempTree].Code, TempTree1[ixTempTree].CustomCode);
  // end add node to the Tree
  // id of the current sibling
          strTempId := TempTree1[ixTempTree].Code;
  // begin provide pTempLChildId to push the LeftChild to the strstkLChild
          strTempLChildId := TempTree1[ixTempTree].LChild;
  // end provide pTempLChildId to push the LeftChild to the strstkLChild

          stkFather.Push(tmpNode);
          strstkLChild.Push(strTempLChildId);
          end;
  // end trace the Tree to the last sibling of the current child
        end;
      end;
    strId := FixLeft(IntToStr(StrToInt(strID)+1), '0', 2);
    ixTempTree := FindIdOnArr(TempTree1, strId);
    until (ixTempTree = -1);
  stkFather.Free;
  strstkLChild.Free;
  adoTbl.IndexFieldNames := '';
end;

procedure TTreeDM.SaveSubTree2(Tree: TVirtualStringTree; Root: PVirtualNode ; adoTbl : TADOTable);
  { This procedure gets a tree and a node of it as the root of a sub tree.
    Then it add this subtree to the table in the proper places. So the table
    will be updated after calling this procedure.}
var
  CurNode{Current Node} : PVirtualNode;
  sNodes : TStack;
  NodeD {Node Data}: ^rTreeData;
  strID : String;

begin
  sNodes := TStack.Create;

//  make new table with the specified tree
  CurNode := Root;

  adoTbl.First;
  if not adoTbl.IsEmpty then
    begin
    LocateNodeInTable(Tree, Root, adoTbl);
    // if Root has any child, that child is new, so the leftchild of Root should be changed
    // check if Root has new child
    if Assigned(CurNode.FirstChild) then
      begin
      // push the new child to stack to add it to the table, later
      sNodes.Push(CurNode.FirstChild);
      // begin change LChild of Root to point to the new child
      NodeD := Tree.GetNodeData(CurNode.FirstChild);
      if Assigned(NodeD) then
        begin
        adoTbl.Edit;
        adoTbl.FieldByName('P_LChild').AsString := NodeD.BasicND.ID;
        end;
      end;
      // end change LChild of Root to point to the new child
    end
  else
    // if the table is empty, it means that Root is not in the table so push it to stack
    // to add it to the table later
    if CurNode = Tree.RootNode then
      sNodes.Push(CurNode.FirstChild)
    else
      sNodes.Push(CurNode);

  while sNodes.AtLeast(1) do
    begin
    CurNode := sNodes.Pop;
    if Assigned(CurNode) then
      AddExistNode(Tree, CurNode, adoTbl);
    repeat
      noded := Tree.GetNodeData(CurNode);
      if Assigned(CurNode.FirstChild) then
        sNodes.Push(CurNode.FirstChild);
      if Assigned(CurNode.NextSibling) then
        AddExistNode(Tree, CurNode.NextSibling, adoTbl);
      CurNode := CurNode.NextSibling;
     if assigned(noded) then
      strid := noded.basicnd.cid;
    until not Assigned(CurNode) ;
    end;
  sNodes.Free;
//  make new table with the specified tree
end;

procedure TTreeDM.DelSubTreeFromTable(strRootID: String ; adoTbl : TADOTable);

  { This procedure gets a tree and a node of it as the root of a sub tree.
    Then it only Removes this subtree from the table. So the table
    will be updated after calling this procedure. }

var
//  strstkID : TStack;
  strstkID : TStrStack;
  strRSibId : String;
//  pTempID, pTempLChildId : ^String;
  strTempID, strTempLChildId : String;
begin
  strstkID := TStrStack.Create;

  if not adoTbl.Locate('P_Code', strRootID, []) then
    exit;
// we should start from the first child, not the root.(the root should not be deleted)
  if adoTbl.FieldByName('P_LChild').AsString <> '-1' then
    begin
    adoTbl.Edit;
    strTempId := adoTbl.FieldByName('P_LChild').AsString;
    adoTbl.FieldByName('P_LChild').AsString := '-1';
    strstkID.Push(strTempId);
    end;

  while strstkID.AtLeastOne do
    begin
    strTempId := strstkID.Pop;
    if (strTempId<>'-1') then
      begin
      adoTbl.Locate('P_Code', strTempId, []);

      strTempLChildId := adoTbl.FieldByName('P_LChild').AsString;
      strstkID.Push(strTempLChildId);
      strRSibId := adoTbl.FieldByName('P_RSibling').AsString;
      if not adoTbl.IsEmpty then
        adoTbl.Delete;
      while (strRSibId<>'-1') do
        begin
        adoTbl.Locate('P_Code', strRSibId, []);
        strTempId := adoTbl.FieldByName('P_Code').AsString;
        strTempLChildId := adoTbl.FieldByName('P_LChild').AsString;
        strRSibId := adoTbl.FieldByName('P_RSibling').AsString;
        if not adoTbl.IsEmpty then
          adoTbl.Delete;
        strstkID.Push(strTempLChildId);
        end;
      end;
    end;
  strstkID.Free;
end;

procedure TTreeDM.LocateNodeInTable(Tree : TVirtualStringTree ; Node : PVirtualNode ; adoTbl : TADOTable);
  { This procedure gets a tree and a node from that tree. Then it makes the record of
    that node, the active record in the table. }
var
  NodeD : ^rTreeData;
  strID : String;
begin
// Root Data
NodeD := Tree.GetNodeData(Tree.RootNode.FirstChild);
if Assigned(NodeD) then
  begin
  strID := NodeD.BasicND.ID;
  DelSubTreeFromTable(strID, adoTbl);
  adoTbl.Locate('P_Code', strId, []);
  end
else
  MessageDlg('The Node does not have any id. Please Look in TTree.LocateNodeInTable',mtWarning, [mbok],0);
end;

procedure TTreeDM.AddExistNode(Tree:TVirtualStringTree ; Node:PVirtualNode ; adoTbl : TADOTable);

  { This procedure gets an existance node of the SubTree. Then it adds this node
    to the table in the proper place.}

var
  NodeD: ^rTreeData;
  strLChildId, strFatherId, strRSibId, strId, strCustomId : String;
  sName : String;
begin
  NodeD := Tree.GetNodeData(Node);
  strID := NodeD.BasicND.id;
  strCustomId := NodeD.BasicND.CustomId;
  sName := NodeD.BasicND.Name;

  NodeD := Tree.GetNodeData(Node.NextSibling);
  if Assigned(NodeD) then
    strRSibId := NodeD.BasicND.id
  else
    strRSibId := '-1';

  NodeD := Tree.GetNodeData(Node.FirstChild);
  if Assigned(NodeD) then
    strLChildId := NodeD.BasicND.id
  else
    strLChildId := '-1';

  if Node.Parent <> Tree.RootNode then
    begin
    NodeD := Tree.GetNodeData(Node.Parent);
    strFatherId := NodeD.BasicND.id;
    end
  else
    strFatherId := '-1';

  adoTbl.InsertRecord([strID, strCustomId, sName, strLChildId, strRSibId, strFatherId]);
end;


constructor TBasicNodeData.Create(vName: ShortString; vId: String; VCustomId : string);
begin
  cName := vName;
  cId := vId;
  ccId := VCustomId;
end;


{ TStrStack }

function TStrStack.AtLeastOne: Boolean;
begin
  if top >= 2 then
    Result := True
  else
    Result := False;
end;

Constructor TStrStack.Create;
begin
  top:=1;
end;

function TStrStack.Pop: String;
begin
  if (top>=1) and (top<=10001) then
    begin
    if top>1 then
      top:=top-1;
    Result := str[top];
    end;
end;

procedure TStrStack.Push(strSource: String);
begin
if top>=10001 then
  begin
  MessageDlg('Number of parts is too large to support by the system. Please call the Ghadir Co.', mtError, [mbok],0);
  Halt;
  end
else
  begin
  str[top] := strSource;
  top := top + 1;
  end;
end;



function TTreeDM.CopyTreeTblToArr(adoTbl: TADOTable;
  var TempTree1: arrTmpTreeTbl) : integer;
var
  i : integer;
begin
  adoTbl.FindFirst;
  i := 1;
  while (not adoTbl.Eof) do
    begin
    TempTree1[i].Code := adoTbl.fieldbyname('P_Code').AsString;
    TempTree1[i].CustomCode := adoTbl.fieldbyname('P_CustomCode').AsString;
    TempTree1[i].Name := adoTbl.fieldbyname('P_Name').AsString;
    TempTree1[i].LChild := adoTbl.fieldbyname('P_LChild').AsString;
    TempTree1[i].RSibling := adoTbl.FieldByName('P_RSibling').AsString;
    TempTree1[i].Father := adoTbl.FieldByName('P_Father').AsString;
    i:=i+1;
    adoTbl.Next;
    end;
  Result := i-1;
  TempTree1[i].Code := '-1';
  TempTree1[i].CustomCode := '-1';
  TempTree1[i].Name := '-1';
  TempTree1[i].LChild := '-1';
  TempTree1[i].RSibling := '-1';
  TempTree1[i].Father := '-1';
end;

function TTreeDM.FindIdOnArr(TempTree1: arrTmpTreeTbl;
  strId: string) : integer;
var
  i : integer;
begin
  i := 1;
  Result := -1;
  while (i <= MAX) and (TempTree1[i].Code<>'-1') do
    begin
    if TempTree1[i].Code = strId then
      begin
      Result := i;
      i := MAX + 1;
      end;
    i := i + 1;
    end;
end;


{procedure TTreeDM.tblTempCalcFields(DataSet: TDataSet);
var
  i, iEnd : integer;
  strTemp : string;
begin
  strTemp := tblTempIDNO.Asstring;
  i := Length(strTemp);
  while i >= 1 do
    begin
    if (strTemp[i]<>'0') then
      begin
      strTemp[i]:='0';
      i := 1;
      end;
    i := i-1;
    end;
  tblTempFatherID.Value := StrToInt(strTemp);
end;}

function TTreeDM.FindFatherOfNode(idxCurFather, idxCurNode: integer;  arrTable : array  of TTableFld): integer;
var
  i : integer;
  bAccess : Boolean;
begin
  bAccess := False;
  if (idxCurFather = 0) and (arrTable[idxCurNode-1].FatherID = 0) then
    Result := 0
  else if arrTable[idxCurNode-1].FatherID = arrTable[idxCurFather-1].MesID then
    Result := idxCurFather
  else if arrTable[idxCurNode-1].FatherID > arrTable[idxCurFather-1].MesID then
    begin
    i := idxCurFather+1;
    while arrTable[i-1].MesID<>-1 do
      begin
      if arrTable[i-1].MesID = arrTable[idxCurNode-1].FatherID then
        begin
        Result := i;
        Break;
        end;
      i := i+1;
      end;
    end
  else
    begin
    i := idxCurFather-1;
    while i>=1 do
      begin
      if arrTable[i-1].MesID = arrTable[idxCurNode-1].FatherID then
        begin
        Result := i;
        i:=1;
        bAccess := True;
        end;
      i := i-1;
      end;
    if not(bAccess) then
      Result := 0;
    end;
end;

{function TTreeDM.GetNewGhadirID(Tree : TVirtualStringTree ; FatherNode :PVirtualNode) : string;
var
  NodeD : ^rTreeData;
  tmpNode : PVirtualNode;
  iLength, a : integer;
  iTemp : Longint;
begin
  tmpNode := FatherNode.LastChild;
  if tmpNode <> nil then
    begin
    NodeD := Tree.GetNodeData(tmpNode);
    iLength := Length(NodeD.BasicND.id);
    if NodeD.BasicND.id = '00010102050200' then
      a:=0;
    iTemp := StrToInt64(NodeD.BasicND.id);
    iTemp := iTemp + 1+a;
    Result := IntToStr(iTemp);
    Result := FixLeft(Result, '0', iLength);
    end
  else
    begin
    NodeD := Tree.GetNodeData(FatherNode);
    Result := NodeD.BasicND.id + '00';
    end;
end; }

procedure TTreeDM.DataModuleCreate(Sender: TObject);
begin
  adoqryTemp.Connection := frmDBS.DBConnection ;
end;

procedure TTreeDM.LoadSubTree(Tree: TVirtualStringTree; adoTbl: TADOTAble;
  strID: String);
var
  TempNodes : array[1..5000] of PVirtualNode;
  FatherID : String;
  NodeD : ^rTreeData;
  FatherNode, tmpNode : PVirtualNode;
  iTempRecNo, alaki : integer;
begin
// begin initialization
  Tree.Clear;
// end initialization
  if strID = '' then
    strID := '00';
  if adoTbl.IsEmpty then
    exit;

  adoTbl.First;
  while not adoTbl.eof{adoTbl.RecordCount <> adoTbl.RecNo} do
    begin
    if adoTbl.FieldByName('P_Father').AsString <> '-1' then
      begin
      FatherID := adoTbl.FieldByName('P_Father').AsString;
      iTempRecNo := adoTbl.RecNo;
    // begin Find Father of the new node
      while (adoTbl.RecNo>=1) and (adoTbl.FieldByName('P_Code').AsString <> FatherID) do
        adoTbl.FindPrior;

      if (adoTbl.FieldByName('P_Code').AsString = FatherID) then
        FatherNode := TempNodes[adoTbl.RecNo]
      else
        begin
        ShowMessage('The parts table is corrupted.');
        Halt;
        end;
      adoTbl.RecNo := iTempRecNo;
    // end Find Father of the new node
      end
    else
      FatherNode := Tree.RootNode;
  // begin add node to the Tree
    tmpNode := Tree.MakeNewNode;
    Tree.InternalConnectNode(tmpNode, FatherNode, Tree, amAddChildLast);
    NodeD := Tree.GetNodeData(tmpNode);
    NodeD.BasicND := TBasicNodeData.Create(adoTbl.FieldByName('P_Name').AsString, adoTbl.FieldByName('P_Code').AsString, adoTbl.FieldByName('P_CustomCode').AsString);
    TempNodes[adoTbl.RecNo] := tmpNode;
  // end add node to the Tree
//    if adoTbl.RecordCount <> adoTbl.RecNo then
     adoTbl.Next;
    end;
end;

procedure TTreeDM.SaveSubTree(Tree: TVirtualStringTree; Root: PVirtualNode;
  adoTbl: TADOTable);
var
  CurNode{Current Node} : PVirtualNode;
  arrTbl : arrTmpTbl;
  index : integer;
begin
  if not adoTbl.IsEmpty then
    begin
    adoqryTemp.SQL.clear;
    adoqryTemp.SQL.Add('Delete from parts');
    adoqryTemp.ExecSQL;
    end;
  CurNode := Tree.RootNode.FirstChild;
  index := 1;

  while Assigned(CurNode) do
    begin
    AddExistNode(Tree, CurNode, adoTbl);
    CurNode := Tree.GetNext(CurNode);
    Inc(index);
    end;
end;

procedure TTreeDM.AddExistNode(Tree: TVirtualStringTree;
  Node: PVirtualNode; var arrTbl: arrTmpTbl; index : integer);
var
  NodeD: ^rTreeData;
  strLChildId, strFatherId, strRSibId, strId, strCustomId : String;
  sName : String;
begin
  NodeD := Tree.GetNodeData(Node);
  strID := NodeD.BasicND.id;
  strCustomId := NodeD.BasicND.CustomId;
  sName := NodeD.BasicND.Name;

  NodeD := Tree.GetNodeData(Node.NextSibling);
  if Assigned(NodeD) then
    strRSibId := NodeD.BasicND.id
  else
    strRSibId := '-1';

  NodeD := Tree.GetNodeData(Node.FirstChild);
  if Assigned(NodeD) then
    strLChildId := NodeD.BasicND.id
  else
    strLChildId := '-1';

  if Node.Parent <> Tree.RootNode then
    begin
    NodeD := Tree.GetNodeData(Node.Parent);
    strFatherId := NodeD.BasicND.id;
    end
  else
    strFatherId := '-1';

  arrTbl[index,1] := strID;
  arrTbl[index,2] := strCustomId;
  arrTbl[index,3] := sName;
  arrTbl[index,4] := strLChildId;
  arrTbl[index,5] := strRSibId;
  arrTbl[index,6] := strFatherId;
end;

end.
