unit Parts;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, Buttons, Menus, ADODB,
  VirtualTrees, ImgList, partDef, funcs, vt, DosMove;

type
  TfrmParts = class(TForm)
    dtaPart1: TDataSource;
    dtaPart2: TDataSource;
    pop1: TPopupMenu;
    mnuPop1New: TMenuItem;
    mnuPop1Edit: TMenuItem;
    mnuPop1Delete: TMenuItem;
    pop2: TPopupMenu;
    mnuPop2New: TMenuItem;
    mnuPop2Save: TMenuItem;
    mnuPop2Delete: TMenuItem;
    dtaPart3: TDataSource;
    pop4: TPopupMenu;
    mnuPop4New: TMenuItem;
    mnuPop4Save: TMenuItem;
    mnuPop4Delete: TMenuItem;
    pop3: TPopupMenu;
    mnuPop3New: TMenuItem;
    mnuPop3Save: TMenuItem;
    mnuPop3Delete: TMenuItem;
    dtaPart4: TDataSource;
    adoTblPart1: TADOTable;
    adoTblPart2: TADOTable;
    adoTblPart3: TADOTable;
    adoTblPart4: TADOTable;
    grpTree: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    grpGrid: TGroupBox;
    dbgPart4: TDBGrid;
    dbgPart3: TDBGrid;
    dbgPart2: TDBGrid;
    dbgPart1: TDBGrid;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    adotblParts: TADOTable;
    dtsParts: TDataSource;
    pmnuTree: TPopupMenu;
    pmnuAddChild: TMenuItem;
    pmnuAddNode: TMenuItem;
    N2: TMenuItem;
    pmnuDelete: TMenuItem;
    imgsPMnu: TImageList;
    cmdEdit: TBitBtn;
    cmdNewChild: TBitBtn;
    cmdNewNode: TBitBtn;
    lbl2: TLabel;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    imgsTree: TImageList;
    cmdDelete: TBitBtn;
    chkViewCode: TCheckBox;
    DosMove1: TDosMove;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tblPart1NewRecord(DataSet: TDataSet);
    procedure tblPart2NewRecord(DataSet: TDataSet);
    procedure dbgPart1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPart2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tblPart1BeforeEdit(DataSet: TDataSet);
    procedure tblPart1AfterPost(DataSet: TDataSet);
    procedure tblPart2AfterPost(DataSet: TDataSet);
    procedure tblPart2BeforeEdit(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tblPart1BeforePost(DataSet: TDataSet);
    procedure tblPart2BeforePost(DataSet: TDataSet);
    procedure mnuPop1NewClick(Sender: TObject);
    procedure mnuPop1EditClick(Sender: TObject);
    procedure mnuPop1DeleteClick(Sender: TObject);
    procedure mnuPop2NewClick(Sender: TObject);
    procedure mnuPop2SaveClick(Sender: TObject);
    procedure mnuPop2DeleteClick(Sender: TObject);
    procedure mnuPop3NewClick(Sender: TObject);
    procedure mnuPop3SaveClick(Sender: TObject);
    procedure mnuPop4NewClick(Sender: TObject);
    procedure mnuPop4SaveClick(Sender: TObject);
    procedure mnuPop4DeleteClick(Sender: TObject);
    procedure dbgPart3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuPop3DeleteClick(Sender: TObject);
    procedure dbgPart4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tblPart3AfterPost(DataSet: TDataSet);
    procedure tblPart3BeforeEdit(DataSet: TDataSet);
    procedure tblPart3BeforePost(DataSet: TDataSet);
    procedure tblPart3NewRecord(DataSet: TDataSet);
    procedure tblPart4AfterPost(DataSet: TDataSet);
    procedure tblPart4BeforeEdit(DataSet: TDataSet);
    procedure tblPart4BeforePost(DataSet: TDataSet);
    procedure tblPart4NewRecord(DataSet: TDataSet);
    procedure pmnuDeleteClick(Sender: TObject);
    procedure partTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure partTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure cmdNewChildClick(Sender: TObject);
    procedure pmnuAddChildClick(Sender: TObject);
    procedure pmnuAddNodeClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure chkViewCodeClick(Sender: TObject);
    procedure addNode(father : string);
  private
    { Private declarations }
    P1Code, P2Code, P3Code, P4Code : Integer;
    EditP1, EditP2, EditP3, EditP4 : Boolean;
    partTree : TGHVirtualStringTree;
  end;


implementation

uses
  Globals, MSGs, DBS_Proc , DBLogin, dmTree;

{$R *.DFM}

procedure TfrmParts.FormCreate(Sender: TObject);
var
  NodeD : ^rTreeData;
  title : string;
begin
{$IFDEF TreeParts}
  partTree := TGHVirtualStringTree.Create(Self, adotblParts);
  partTree.Width := 329;
  partTree.Height := 378;
  partTree.Left := 122;
  partTree.Top := 15;
  partTree.Parent := Self;
  partTree.Visible := True;

  adotblParts.connection := frmDBS.DBConnection ;
  adotblParts.Open;

  grpGrid.Visible := False;
  Height := grpTree.Height+20;
  Width := grpTree.Width;
  grpTree.Visible := True;
  grpGrid.Visible := false;
  partTree.LoadTree(Sender);
//  TreeDM.LoadSubTree(partTree , adotblParts , GetPartCode(g_Options.userParts));
{  NodeD := partTree.GetNodeData(partTree.RootNode.FirstChild);
  title := g_Options.CoName;
  if g_Options.Shobeh <> '' then
    title := title + '-' + g_Options.Shobeh;
  NodeD.BasicND := TBasicNodeData.Create( title , '00' , '0');}
  partTree.Expanded[partTree.RootNode] := true;
{$ELSE}
  adoTblPart1.Connection := frmDBS.DBConnection;
  adoTblPart2.Connection := frmDBS.DBConnection;
  adoTblPart3.Connection := frmDBS.DBConnection;
  adoTblPart4.Connection := frmDBS.DBConnection;

  dtaPart1.DataSet := adoTblPart1;
  dtaPart2.DataSet := adoTblPart2;
  dtaPart3.DataSet := adoTblPart3;
  dtaPart4.DataSet := adoTblPart4;

  P1Code := 0;
  P2Code := 0;
  P3Code := 0;
  P4Code := 0;

  EditP1 := False;
  EditP2 := False;
  EditP3 := False;
  EditP4 := False;

  lbl1.Caption := F_Params.Part1;
  lbl2.Caption := F_Params.Part2;
  lbl3.Caption := F_Params.Part3;
  lbl4.Caption := F_Params.Part4;

  adoTblPart1.Open;
  adoTblPart2.Open;
  adoTblPart3.Open;
  adoTblPart4.Open;

  Height := grpGrid.Height;
  Width := grpGrid.Width;
  grpTree.Visible := false;
  grpGrid.Visible := True;
{$ENDIF}

{  xpmnu := frmMsgBox.XPMnu;
  xpmnu := TXPMenu.Create(self);
  xpmnu.Active := true;
  Height := Height + 25;
  Width :=  Width + 12;
}
end;

procedure TfrmParts.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{$IFDEF TreePart}
  if EditP then
    if ConfirmMessage('ÂíÇ ÊÛííÑÇÊ ËÈÊ ÔæäÏ¿') then
    begin
      cmdSave.Click;
    end;
  adoTblParts.Close;
{$ELSE}
  if EditP1 or EditP2 or EditP3 or EditP4 then
    if ConfirmMessage('ÂíÇ ÊÛííÑÇÊ ËÈÊ ÔæäÏ¿') then
    begin
      if EditP1 then adoTblPart1.Post;
      if EditP2 then adoTblPart2.Post;
      if EditP3 then adoTblPart3.Post;
      if EditP4 then adoTblPart4.Post;
    end;
  adoTblPart1.Close;
  adoTblPart2.Close;
  adoTblPart3.Close;
  adoTblPart4.Close;
{$ENDIF}
end;


procedure TfrmParts.mnuPop1NewClick(Sender: TObject);
begin
  adoTblPart1.Append;
  dbgPart1.SetFocus;
end;

procedure TfrmParts.mnuPop1EditClick(Sender: TObject);
begin
  if EditP1 then adoTblPart1.Post;
end;

procedure TfrmParts.mnuPop1DeleteClick(Sender: TObject);
begin
  if (adoTblPart1.RecordCount > 0) then
    if IsExistsRec_Num('Persons', 'P_Part1', adoTblPart1.FieldByName('P1_Code').AsInteger) then
      ErrorMessage('Çíä ÈÎÔ ÏÑ ÑÏÔ ÈæÏå æ ÍÐÝ Âä ãíÓÑ äíÓÊ.')
    else if ConfirmMessage('ÂíÇ ÈÑÇí ÍÐÝ ÈÎÔ ÇÕáí æ ÇÌÒÇÁ Âä ÇØãíäÇä ÏÇÑíÏ¿') then
    begin
      while adoTblPart2.RecordCount > 0 do adoTblPart2.Delete;
      adoTblPart1.Delete;
    end;
end;

procedure TfrmParts.dbgPart1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 45 then
    Key := 0
  else if (Key = 46) and not EditP1 then
  begin
    Key := 0;
    mnuPop1DeleteClick(Sender);
  end
  else if Key = 9 then
  begin
    Key := 0;
    dbgPart2.Setfocus;
  end;
end;

procedure TfrmParts.tblPart1NewRecord(DataSet: TDataSet);
begin
  EditP1 := True;
  P1Code := 0;
  DataSet.FieldByName('P1_Code').AsInteger := GetNewNumber('Part1', 'P1_Code');
end;

procedure TfrmParts.tblPart1BeforeEdit(DataSet: TDataSet);
begin
  if DataSet.RecordCount > 0 then
    P1Code := DataSet.FieldByName('P1_Code').AsInteger;
  EditP1 := True;
end;

procedure TfrmParts.tblPart1AfterPost(DataSet: TDataSet);
begin
  if P1Code <> DataSet.FieldByName('P1_Code').AsInteger then
  begin
    frmDBS.adoQryG.SQL.Clear;
    frmDBS.adoQryG.SQL.Add('UPDATE Part2 SET P2_P1Code = ' + IntToStr(DataSet.FieldByName('P1_Code').AsInteger));
    frmDBS.adoQryG.SQL.Add('WHERE P2_P1Code = ' + IntToStr(P1Code));
    frmDBS.adoQryG.ExecSQL;
    frmDBS.adoQryG.Close;
  end;
  EditP1 := False;
end;

procedure TfrmParts.tblPart1BeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('P1_Code').AsInteger <> P1Code) and
     IsExistsRec_Num('Part1', 'P1_Code', DataSet.FieldByName('P1_Code').AsInteger) then
  begin
    ErrorMessage('ÔãÇÑå ÈÎÔ ÊßÑÇÑí ÇÓÊ.');
    if P1Code = 0 then
      DataSet.FieldByName('P1_Code').AsInteger := GetNewNumber('Part1', 'P1_Code')
    else
      DataSet.FieldByName('P1_Code').AsInteger := P1Code;
  end;
end;






procedure TfrmParts.mnuPop2NewClick(Sender: TObject);
begin
  adoTblPart2.Append;
  dbgPart2.SetFocus;
end;

procedure TfrmParts.mnuPop2SaveClick(Sender: TObject);
begin
  if EditP2 then adoTblPart2.Post;

end;

procedure TfrmParts.mnuPop2DeleteClick(Sender: TObject);
begin
  if (adoTblPart2.RecordCount > 0) then
    if IsExistsRec_Num('Persons', 'P_Part1', adoTblPart2.FieldByName('P2_P1Code').AsInteger) and
       IsExistsRec_Num('Persons', 'P_Part2', adoTblPart2.FieldByName('P2_Code').AsInteger) then
      ErrorMessage('Çíä ÈÎÔ ÏÑ ÑÏÔ ÈæÏå æ ÍÐÝ Âä ãíÓÑ äíÓÊ.')
    else if ConfirmMessage('ÂíÇ ÈÑÇí ÍÐÝ ÒíÑ ÈÎÔ ÇØãíäÇä ÏÇÑíÏ¿') then
    begin
      while adoTblPart3.RecordCount > 0 do adoTblPart3.Delete;
      adoTblPart2.Delete;
    end;
end;

procedure TfrmParts.dbgPart2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 45 then
    Key := 0
  else if (Key = 46) and not EditP2 then
  begin
    Key := 0;
    mnuPop2DeleteClick(Sender);
  end
  else if Key = 9 then
  begin
    Key := 0;
    dbgPart3.Setfocus;
  end;
end;

procedure TfrmParts.tblPart2NewRecord(DataSet: TDataSet);
begin
  EditP2 := True;
  P2Code := 0;
  DataSet.FieldByName('P2_Code').AsInteger := GetNewNumber('Part2', 'P2_Code');
end;

procedure TfrmParts.tblPart2AfterPost(DataSet: TDataSet);
begin
  EditP2 := False;
end;

procedure TfrmParts.tblPart2BeforeEdit(DataSet: TDataSet);
begin
  if DataSet.RecordCount > 0 then
    P2Code := DataSet.FieldByName('P2_Code').AsInteger;
  EditP2 := True;
end;

procedure TfrmParts.tblPart2BeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('P2_Code').AsInteger <> P2Code) and
     IsExistsRec_2Num('Part2', 'P2_P1Code', 'P2_Code',
                      DataSet.FieldByName('P2_P1Code').AsInteger,
                      DataSet.FieldByName('P2_Code').AsInteger) then
  begin
    ErrorMessage('ÔãÇÑå ÒíÑ ÈÎÔ ÊßÑÇÑí ÇÓÊ.');
    if P2Code = 0 then
      DataSet.FieldByName('P2_Code').AsInteger := GetNewNumber('Part2', 'P2_Code')
    else
      DataSet.FieldByName('P2_Code').AsInteger := P2Code;
  end;
end;






procedure TfrmParts.mnuPop3NewClick(Sender: TObject);
begin
  adoTblPart3.Append;
  dbgPart3.SetFocus;
end;

procedure TfrmParts.mnuPop3SaveClick(Sender: TObject);
begin
  if EditP3 then adoTblPart3.Post;
end;

procedure TfrmParts.mnuPop3DeleteClick(Sender: TObject);
begin
  if (adoTblPart3.RecordCount > 0) then
    if IsExistsRec_Num('Persons', 'P_Part1', adoTblPart3.FieldByName('P3_P1Code').AsInteger) and
       IsExistsRec_Num('Persons', 'P_Part2', adoTblPart3.FieldByName('P3_P2Code').AsInteger) and
       IsExistsRec_Num('Persons', 'P_Part3', adoTblPart3.FieldByName('P3_Code').AsInteger) then
      ErrorMessage('Çíä ÈÎÔ ÏÑ ÑÏÔ ÈæÏå æ ÍÐÝ Âä ãíÓÑ äíÓÊ.')
    else if ConfirmMessage('ÂíÇ ÈÑÇí ÍÐÝ ÒíÑ ÈÎÔ ÇØãíäÇä ÏÇÑíÏ¿') then
    begin
      while adoTblPart4.RecordCount > 0 do adoTblPart4.Delete;
      adoTblPart3.Delete;
    end;
end;

procedure TfrmParts.dbgPart3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    Key := 0
  else if (Key = 46) and not EditP3 then
  begin
    Key := 0;
    mnuPop3DeleteClick(Sender);
  end
  else if Key = 9 then
  begin
    Key := 0;
    dbgPart4.Setfocus;
  end;
end;

procedure TfrmParts.tblPart3AfterPost(DataSet: TDataSet);
begin
  EditP3 := False;
end;

procedure TfrmParts.tblPart3BeforeEdit(DataSet: TDataSet);
begin
  if DataSet.RecordCount > 0 then
    P3Code := DataSet.FieldByName('P3_Code').AsInteger;
  EditP3 := True;
end;

procedure TfrmParts.tblPart3BeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('P3_Code').AsInteger <> P3Code) and
     IsExistsRec_2Num('Part3', 'P3_P2Code', 'P3_Code', DataSet.FieldByName('P3_P2Code').AsInteger, DataSet.FieldByName('P3_Code').AsInteger) then
  begin
    ErrorMessage('ÔãÇÑå ÒíÑ ÈÎÔ ÊßÑÇÑí ÇÓÊ.');
    if P3Code = 0 then
      DataSet.FieldByName('P3_Code').AsInteger := GetNewNumber('Part3', 'P3_Code')
    else
      DataSet.FieldByName('P3_Code').AsInteger := P3Code;
  end;
end;

procedure TfrmParts.tblPart3NewRecord(DataSet: TDataSet);
begin
  EditP3 := True;
  P3Code := 0;
  DataSet.FieldByName('P3_Code').AsInteger := GetNewNumber('Part3', 'P3_Code');
end;



procedure TfrmParts.mnuPop4NewClick(Sender: TObject);
begin
  adoTblPart4.Append;
  dbgPart4.SetFocus;
end;

procedure TfrmParts.mnuPop4SaveClick(Sender: TObject);
begin
  if EditP4 then adoTblPart4.Post;
end;

procedure TfrmParts.mnuPop4DeleteClick(Sender: TObject);
begin
  if (adoTblPart4.RecordCount > 0) then
    if IsExistsRec_Num('Persons', 'P_Part1', adoTblPart4.FieldByName('P4_P1Code').AsInteger) and
       IsExistsRec_Num('Persons', 'P_Part2', adoTblPart4.FieldByName('P4_P2Code').AsInteger) and
       IsExistsRec_Num('Persons', 'P_Part3', adoTblPart4.FieldByName('P4_P3Code').AsInteger) and
       IsExistsRec_Num('Persons', 'P_Part4', adoTblPart4.FieldByName('P4_Code').AsInteger) then
      ErrorMessage('Çíä ÈÎÔ ÏÑ ÑÏÔ ÈæÏå æ ÍÐÝ Âä ãíÓÑ äíÓÊ.')
    else if ConfirmMessage('ÂíÇ ÈÑÇí ÍÐÝ ÒíÑ ÈÎÔ ÇØãíäÇä ÏÇÑíÏ¿') then
      adoTblPart4.Delete;
end;

procedure TfrmParts.dbgPart4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    Key := 0
  else if (Key = 46) and not EditP4 then
  begin
    Key := 0;
    mnuPop4DeleteClick(Sender);
  end
  else if Key = 9 then
  begin
    Key := 0;
    dbgPart1.Setfocus;
  end;
end;

procedure TfrmParts.tblPart4AfterPost(DataSet: TDataSet);
begin
  EditP4 := False;
end;

procedure TfrmParts.tblPart4BeforeEdit(DataSet: TDataSet);
begin
  if DataSet.RecordCount > 0 then
    P4Code := DataSet.FieldByName('P4_Code').AsInteger;
  EditP4 := True;
end;

procedure TfrmParts.tblPart4BeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('P4_Code').AsInteger <> P4Code) and
     IsExistsRec_2Num('Part4', 'P4_P3Code', 'P4_Code', DataSet.FieldByName('P4_P3Code').AsInteger, DataSet.FieldByName('P4_Code').AsInteger) then
  begin
    ErrorMessage('ÔãÇÑå ÒíÑ ÈÎÔ ÊßÑÇÑí ÇÓÊ.');
    if P4Code = 0 then
      DataSet.FieldByName('P4_Code').AsInteger := GetNewNumber('Part4', 'P4_Code')
    else
      DataSet.FieldByName('P4_Code').AsInteger := P4Code;
  end;
end;

procedure TfrmParts.tblPart4NewRecord(DataSet: TDataSet);
begin
  EditP4 := True;
  P4Code := 0;
  DataSet.FieldByName('P4_Code').AsInteger := GetNewNumber('Part4', 'P4_Code');
end;

procedure TfrmParts.pmnuDeleteClick(Sender: TObject);
var
  Node, FatherNode, TempNode : PVirtualNode;
  NodeD : ^rTreeData;
  strTemp : String;
begin
  Node  := partTree.GetFirstSelected ;
  NodeD := partTree.GetNodeData(Node);
  if not Assigned(Node) then
    exit;

  if partTree.FocusedNode = partTree.RootNode.FirstChild then
    exit;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM PERSONS WHERE P_Parts like ''%' + NodeD.BasicND.id + '''');
    Open;
    First;
    if not Eof then
    begin
      ErrorMessage('ÊÚÏÇÏí ÑÓäá ÏÑ Çíä ÈÎÔ ÊÚÑíÝ ÔÏå ÇäÏ .' + #13 + 'áÐÇ Çã˜Çä ÍÐÝ Çíä ÈÎÔ æÌæÏ äÏÇÑÏ.');
      exit;
    end;
    Close;
  end;
  if Node.ChildCount > 0 then
  begin
    if ConfirmMessage('ÈÇ ÇäÌÇã Çíä Úãá ÒíÑÈÎÔåÇí ãæÌæÏ äíÒ ÍÐÝ ÎæÇåäÏ ÔÏ.'+ #13 + 'ÂíÇ ÈÑÇí ÍÐÝ ÇØãíäÇä ÏÇÑíÏ¿') then
      partTree.DeleteNode(Node);
  end
  else if ConfirmMessage('ÂíÇ ÈÑÇí ÍÐÝ ÈÎÔ ÇØãíäÇä ÏÇÑíÏ¿') then
    partTree.DeleteNode(Node);
  TreeDM.SaveSubTree(partTree, partTree.RootNode.FirstChild, adotblParts);
end;

procedure TfrmParts.partTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  NodeD : ^rTreeData;
begin
  NodeD := partTree.GetNodeData(Node);
  if (Assigned(NodeD) and Assigned(NodeD.basicnd)) then
    if NodeD.BasicND.CustomId = '0' then
      CellText := NodeD.BasicND.Name
    else
      if chkViewCode.Checked then
        CellText := NodeD.BasicND.Name + ' (' + NodeD.BasicND.CustomId + ')'
      else
        CellText := NodeD.BasicND.Name;
end;

procedure TfrmParts.partTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  ImageIndex := 1   //partTree.GetNodeLevel(Node);
end;

procedure TfrmParts.cmdNewChildClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeD: ^rTreeData;
  strId, customStrId, str : String;
  frmPartDef: TfrmPartDef;
begin
//  partTree.PopupMenu.Items[0].Click;
with partTree do
  begin
  if RootNodeCount > 0 then
  begin
    if Assigned(FocusedNode) then
    begin
      NodeD := partTree.GetNodeData(FocusedNode);
      strId := NodeD.BasicND.id;
      frmPartDef := TfrmPartDef.Create(self);
      frmPartDef.flag := MB_NEW;
      frmPartDef.txtCode.Text := IntToStr(GetNewNumber('parts' , 'P_CustomCode'));
      if (frmPartDef.ShowModal = mrOk) then
      begin
        if (Sender as TBitBtn).Name = 'cmdNewChild' then
        begin
          Node := partTree.AddChild(FocusedNode); // adds a node as the last child
          strId := strId + FixLeft(IntToStr(Node.Index),'0',2);

        end
        else
        begin
          if strId = '0' then
            Exit;
          NodeD := partTree.GetNodeData(FocusedNode.Parent);
          Node := partTree.AddChild(FocusedNode.Parent);
          strId := NodeD.BasicND.id + FixLeft(IntToStr(Node.Index),'0',2);
        end;
        customStrId := frmPartDef.txtCode.Text;
        NodeD := partTree.GetNodeData(Node);
        NodeD.BasicND := TBasicNodeData.Create(frmPartDef.txtName.text, strId , customStrId);
        Expanded[FocusedNode] := True;
      end;
      TreeDM.SaveSubTree(partTree, partTree.RootNode.FirstChild, adotblParts);
      frmPartDef.Free;
    end;
  end
{  else
    begin
    Node := partTree.AddChild(nil);
    NodeD := partTree.GetNodeData(Node);
    str := InputBox('Node Name', 'Node Name', 'node');
    NodeD.BasicND := TBasicNodeData.Create(str);
//    AddToTable(Node);
    end; }
  end;
  partTree.Refresh;
end;

procedure TfrmParts.pmnuAddChildClick(Sender: TObject);
begin
  cmdNewChild.Click;
end;

procedure TfrmParts.pmnuAddNodeClick(Sender: TObject);
begin
  cmdNewNode.Click;
end;

procedure TfrmParts.cmdEditClick(Sender: TObject);
var
  NodeD: ^rTreeData;
  strId, customStrId, str : String;
  frmPartDef: TfrmPartDef;
begin
  with partTree do
  begin
    if RootNodeCount > 0 then
    begin
      if Assigned(FocusedNode) then
      begin
        NodeD := partTree.GetNodeData(FocusedNode);
        strId := NodeD.BasicND.id;
        if strId = '0' then
          exit;
        with frmPartDef do
        begin
          frmPartDef := TfrmPartDef.Create(self);
          txtCode.Text := nodeD.basicND.customID;
          preCode := nodeD.basicND.customID;
          txtName.Text := noded.basicND.Name;
          flag := MB_EDIT;
        end;
        if (frmPartDef.ShowModal = mrOk) then
        begin
          NodeD.BasicND.CustomId := frmPartDef.txtCode.Text;
          NodeD.BasicND.Name := frmPartDef.txtName.Text;
        end;
        TreeDM.SaveSubTree(partTree, partTree.RootNode.FirstChild, adotblParts);
        frmPartDef.Free;
      end;
    end
  end;
end;

procedure TfrmParts.Button1Click(Sender: TObject);
begin
  cmdNewNode.Click;
end;

procedure TfrmParts.chkViewCodeClick(Sender: TObject);
begin
  partTree.ShowCode := chkViewCode.Checked;
end;

procedure TfrmParts.addNode(father: string);
var
  Node: PVirtualNode;
  NodeD: ^rTreeData;
  strId, customStrId, str : String;
  frmPartDef: TfrmPartDef;
begin
  with partTree do
    begin
    if RootNodeCount > 0 then
    begin

      begin
        NodeD := partTree.GetNodeData(FocusedNode);
        strId := NodeD.BasicND.id;
        frmPartDef := TfrmPartDef.Create(self);
        frmPartDef.flag := MB_NEW;
        frmPartDef.txtCode.Text := IntToStr(GetNewNumber('parts' , 'P_CustomCode'));
        if (frmPartDef.ShowModal = mrOk) then
        begin
          Node := partTree.AddChild(FocusedNode); // adds a node as the last child
          strId := strId + FixLeft(IntToStr(Node.Index),'0',2);
          customStrId := frmPartDef.txtCode.Text;
          NodeD := partTree.GetNodeData(Node);
          NodeD.BasicND := TBasicNodeData.Create(frmPartDef.txtName.text, strId , customStrId);
          Expanded[FocusedNode] := True;
        end;
        TreeDM.SaveSubTree(partTree, partTree.RootNode.FirstChild, adotblParts);
        frmPartDef.Free;
      end;
    end
  {  else
      begin
      Node := partTree.AddChild(nil);
      NodeD := partTree.GetNodeData(Node);
      str := InputBox('Node Name', 'Node Name', 'node');
      NodeD.BasicND := TBasicNodeData.Create(str);
  //    AddToTable(Node);
      end; }
    end;
    partTree.Refresh;
end;

procedure TfrmParts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  partTree.SaveTree(Sender);
end;

end.

