unit uPersonelScope;
{$I Features}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, Buttons, ADODB, Globals, DB,
  ComCtrls, ExtCtrls, KeyBoard, Funcs, TimeTool,DateProc, msgs,
  ImgList, DosMove, WideStrings;

type
  TfrmPrsnScp = class(TForm)
    grpPrintType: TGroupBox;
    grpDateTime: TGroupBox;
    txtToDate: TEdit;
    lbl7: TLabel;
    Label5: TLabel;
    txtFromDate: TEdit;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    txtSTime: TEdit;
    lbl9: TLabel;
    lbl10: TLabel;
    txtETime: TEdit;
    rdoOneSelect: TRadioButton;
    grpOne: TGroupBox;
    cmbName: TComboBox;
    cmbFamily: TComboBox;
    lbl3: TLabel;
    lbl2: TLabel;
    cmdSelect: TBitBtn;
    DosMove1: TDosMove;
    rdoVariousSelect: TRadioButton;
    lbl1: TLabel;
    cmbBarCode: TComboBox;
    rdoStartdate: TRadioButton;
    rdoEndDate: TRadioButton;
    procedure cmbreserve7KeyPress(Sender: TObject; var Key: Char);
    procedure cmbProxiKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure SendTab(var Key : Char);
    procedure txtToDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtSTimeExit(Sender: TObject);
    procedure txtSTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtETimeExit(Sender: TObject);
    procedure txtETimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBarCodeClick(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbNameClick(Sender: TObject);
    procedure cmbNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFamilyClick(Sender: TObject);
    procedure cmbFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure cmbJobKeyPress(Sender: TObject; var Key: Char);
    procedure cmbGroupKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCoPostsKeyPress(Sender: TObject; var Key: Char);
    procedure TabSheet2Enter(Sender: TObject);
    procedure TabSheet1Enter(Sender: TObject);
    procedure pgPersonsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure partTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure rdoOneSelectClick(Sender: TObject);
    procedure rdoGrpSelectClick(Sender: TObject);
    procedure grpGroupClick(Sender: TObject);
    procedure cmdSelectClick(Sender: TObject);
    procedure cmbBarCodeChange(Sender: TObject);
    procedure rdoVariousSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbRuleKeyPress(Sender: TObject; var Key: Char);
    procedure cmbStationsKeyPress(Sender: TObject; var Key: Char);
  private
    ht : integer;
    { Private declarations }
  public
    { Public declarations }
    SeveralMonth : boolean ;
    sTime, eTime : integer;
    PartCode : string;
    procedure addPersonsLimit(sql : TWideStrings);
    function isReady : boolean;
  end;

var
  frmPrsnScp: TfrmPrsnScp;

implementation

uses DBS, Select, Math;

{$R *.dfm}



procedure TfrmPrsnScp.addPersonsLimit(SQL : TWideStrings);
var
  i : Integer;
begin
  if (SelFlag = True) and (frmSelect.lstSelect.Items.Count > 0) then
  begin
    SQL.Add('And P_Code IN (');
    for i := 0 to frmSelect.lstSelect.Items.Count -1 do
    begin
      SQL.Add(''''+frmSelect.lstSelect.Items.Strings[i]+'''');
      if i = frmSelect.lstSelect.Items.Count -1 then
        SQL.Add(')')
      else
        SQL.Add(',');
    end;
  end;

  if frmPrsnScp.cmbBarCode.Text <> '' then
    SQL.Add('AND P_Code = ''' + frmPrsnScp.cmbBarCode.Text + '''');
end;

procedure TfrmPrsnScp.SendTab(var Key: Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmPrsnScp.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmPrsnScp.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmPrsnScp.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmPrsnScp.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmPrsnScp.txtSTimeExit(Sender: TObject);
begin
  with txtstime do
    if Text <> '' then
      Text := BeautifulTime(Text);
end;

procedure TfrmPrsnScp.txtSTimeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmPrsnScp.txtETimeExit(Sender: TObject);
begin
  with txtetime do
    if Text <> '' then
      Text := BeautifulTime(Text);
end;

procedure TfrmPrsnScp.txtETimeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Time(Key);
end;

procedure TfrmPrsnScp.cmbBarCodeClick(Sender: TObject);
begin
  with cmbBarCode do
  begin
    if Text <> '' then
      ItemIndex := Items.IndexOf(FixLeft(Text, '0', 8))
    else
      ItemIndex := -1;

      cmbName.ItemIndex := ItemIndex;
      cmbFamily.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmPrsnScp.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Integer(Key);
end;

procedure TfrmPrsnScp.cmbNameClick(Sender: TObject);
begin
  with cmbName do
  begin
    if Text <> '' then
    begin
      if ItemIndex = -1 then
        ItemIndex := Items.IndexOf(Text);
    end
    else
      ItemIndex := -1;

      cmbBarCode.ItemIndex := ItemIndex;
      cmbFamily.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmPrsnScp.cmbNameKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPrsnScp.cmbProxiKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Hex(Key);
end;

procedure TfrmPrsnScp.cmbFamilyClick(Sender: TObject);
begin
  with cmbFamily do
  begin
    if Text <> '' then
    begin
      if ItemIndex = -1 then
        ItemIndex := Items.IndexOf(Text);
    end
    else
      ItemIndex := -1;

      cmbBarCode.ItemIndex := ItemIndex;
      cmbName.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmPrsnScp.cmbFamilyKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPrsnScp.cmbJobKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPrsnScp.cmbGroupKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPrsnScp.cmbCoPostsKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

function TfrmPrsnScp.isReady: boolean;
begin
  G_FromDate := txtFromDate.Text;
  G_ToDate := txtToDate.Text;

  with txtstime do
    if Text = '' then
      stime := -720
    else
      stime := TimeToInt(Text);
  with txtetime do
    if Text = '' then
      etime := 2160
    else
      etime := TimeToInt(Text);

  if not IsTrueDate(txtFromDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ «‘ »«Â «” ');
    txtFromDate.SetFocus;
    Result := false;
  end
  else if not IsTrueDate(txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ Å«Ì«‰ «‘ »«Â «” ');
    txtToDate.SetFocus;
    Result := false;
  end
  else if (not SeveralMonth) and (DifferDate(txtFromDate.Text, txtToDate.Text) > 370) then
  begin
    ErrorMessage('„œ  «“ Ìﬂ ”«· »Ì‘ — ‘œÂ «” ');
    txtToDate.SetFocus;
    Result := false;
  end
  else
    Result := True;
end;


procedure TfrmPrsnScp.TabSheet2Enter(Sender: TObject);
begin
  SelFlag := false;
end;

procedure TfrmPrsnScp.TabSheet1Enter(Sender: TObject);
begin
  SelFlag := true;
end;

procedure TfrmPrsnScp.pgPersonsContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  SelFlag := true;
end;

procedure TfrmPrsnScp.partTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  ImageIndex := 1   //partTree.GetNodeLevel(Node);
end;

procedure TfrmPrsnScp.rdoOneSelectClick(Sender: TObject);
begin
  SelFlag := false;
  grpOne.Enabled := true;
  lbl1.Enabled  := true;
  lbl2.Enabled  := true;
  lbl3.Enabled  := True;
  cmdSelect.Enabled := false;
end;

procedure TfrmPrsnScp.rdoGrpSelectClick(Sender: TObject);
begin
  SelFlag := false;
  grpOne.Enabled := false;
  cmbBarCode.ItemIndex := -1;
  cmbName.ItemIndex := -1;
  cmbFamily.ItemIndex := -1;
  lbl1.Enabled  := false;
  lbl2.Enabled  := false;
  lbl3.Enabled  := false;
  cmdSelect.Enabled := false;
end;

procedure TfrmPrsnScp.grpGroupClick(Sender: TObject);
begin
  rdoGrpSelectClick(self);
end;

procedure TfrmPrsnScp.cmdSelectClick(Sender: TObject);
begin
  if frmSelect.ShowModal = mrOk then
    SelFlag := True;
end;

procedure TfrmPrsnScp.cmbreserve7KeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPrsnScp.cmbBarCodeChange(Sender: TObject);
begin
  SelFlag := False;
end;

procedure TfrmPrsnScp.rdoVariousSelectClick(Sender: TObject);
begin
  SelFlag := True;
  grpOne.Enabled := false;
  lbl1.Enabled  := false;
  lbl2.Enabled  := false;
  lbl3.Enabled  := false;
  cmdSelect.Enabled := true;
end;

procedure TfrmPrsnScp.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
  i : byte;
  f : textfile;
begin

  if not viewDateTime then
  begin
    Height := Height - grpDateTime.Height;
    grpDateTime.hide;
  end
  else
  if not viewTime then
  begin
    grpDateTime.Height := grpDateTime.Height - 25;
    Height := Height - 25;
  end;
  lbl9.Visible     := viewTime;
  lbl10.Visible    := viewTime;
  txtSTime.Visible := viewTime;
  txtETime.Visible := viewTime;


  txtFromDate.Text:=G_FromDate;
  txtToDate.Text:=G_ToDate;

  with qry do
  begin
    qry := TAdoQuery.Create(Application);
    connection := frmDBS.DBConnection;
    SQL.Clear;
//kaveh    SQL.Add('SELECT P_Code, P_Name, P_Family FROM Persons ');//WHERE P_IsValid <> 0');
//kaveh    SQL.Add('ORDER BY P_Family');
//kaveh is
    SQL.Add('SELECT nP_Code, nP_Name, nP_Family FROM nPersons ');//WHERE P_IsValid <> 0');
    SQL.Add('ORDER BY nP_Family');
//kaveh ie

    Open;
    while not Eof do
    begin
      cmbBarCode.Items.Add(FieldByName('nP_Code').AsString);
      cmbName.Items.Add(FieldByName('nP_Name').AsString);
      cmbFamily.Items.Add(FieldByName('nP_Family').AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TfrmPrsnScp.cmbRuleKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmPrsnScp.cmbStationsKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

end.

