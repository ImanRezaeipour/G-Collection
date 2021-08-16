unit OnlyCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Buttons, Menus, DosMove;

type
  TfrmOnlyCard = class(TForm)
    grd: TDBGrid;
    dtaOnlyCard: TDataSource;
    adoTblOnlyCard: TADOTable;
    adoTblOnlyCardBarCode: TWideStringField;
    adoTblOnlyCardRdrCode: TSmallintField;
    adoTblOnlyCardFamilyName: TStringField;
    Label1: TLabel;
    cmbBarCode: TComboBox;
    Label2: TLabel;
    grpBtns: TGroupBox;
    cmdTic: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    grdRdrs: TStringGrid;
    BitBtn3: TBitBtn;
    pmnu: TPopupMenu;
    N1: TMenuItem;
    DosMove1: TDosMove;
    lbl2: TLabel;
    cmbOperate: TComboBox;
    cmdOk: TBitBtn;
    lblCount: TLabel;
    lbl14: TLabel;
    txtDelay: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure adoTblOnlyCardCalcFields(DataSet: TDataSet);
    procedure cmdTicClick(Sender: TObject);
    procedure grdRdrsDblClick(Sender: TObject);
    procedure grdRdrsClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure grdDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure FillGrid;
    procedure InitialGridCels;
    Procedure SetOnlyCardList;
    Procedure GetOnlyCardList;
    Procedure DeleteOnlyCardList;
    procedure updateCount;    
  public
    { Public declarations }
  end;


implementation

uses DBS,Globals, Users, Funcs, Modem, MSGs, RunCmnds;

{$R *.dfm}

procedure TfrmOnlyCard.FormCreate(Sender: TObject);
var
  adoQry : TADOQuery;
begin
  adoQry := TADOQuery.Create(self);
  adoQry.Connection := frmDBS.DBConnection;
  adoTblOnlyCard.Connection := frmDBS.DBConnection;
  adoTblOnlyCard.Open;
  with adoQry do
  begin
    SQL.Clear;
    SQL.Add('select * from persons order by P_Code');
    Open;
    first;
    cmbBarCode.Clear;
    while not eof do
    begin
      cmbBarCode.Items.Add(DelLeftZero(adoQry.FieldByName('P_code').AsString));
      Next;
    end;
  end;
  adoQry.Free;

  InitialGridCels;
  FillGrid;
  grdRdrs.Row := 1;
  grdRdrsClick(sender);
end;

procedure TfrmOnlyCard.InitialGridCels;
begin
  if TotalReader = 0 then
  begin
    grdRdrs.FixedRows := 0;
    grdRdrs.RowCount := 1;
  end
  else
  begin
    grdRdrs.FixedRows := 1;
    grdRdrs.RowCount := TotalReader + 1;
  end;
  grdRdrs.FixedCols := 0;
  grdRdrs.ColCount := 3;

  grdRdrs.Cols[0].Add(' ');
  grdRdrs.ColWidths[0] := 30;

  grdRdrs.Cols[1].Add(('ﬂœ œ” ê«Â'));
  grdRdrs.ColWidths[1] := 55;

  grdRdrs.Cols[2].Add(('‰«„ œ” ê«Â'));
  grdRdrs.ColWidths[2] := grdRdrs.Width -
                          grdRdrs.ColWidths[1] -
                          grdRdrs.ColWidths[0] - 10;
end;

procedure TfrmOnlyCard.FillGrid;
var i : Byte;
begin
  for i := 1 to TotalReader do
  begin
    grdRdrs.Cells[0, i] := '';
    grdRdrs.Cells[1, i] := IntToStr(Readers[i].R_Code);
    grdRdrs.Cells[2, i] := Readers[i].R_Name;
    grdRdrs.Cells[3, i] := '';
  end;
end;

procedure TfrmOnlyCard.adoTblOnlyCardCalcFields(DataSet: TDataSet);
begin
  adoTblOnlyCard.FieldByName('FamilyName').AsString := GetPersonFamilyName(adoTblOnlyCard.FieldByName('BarCode').AsString); 
end;

procedure TfrmOnlyCard.cmdTicClick(Sender: TObject);
begin
  if grdRdrs.Row > 0 then
  begin
    if grdRdrs.Cells[0, grdRdrs.Row] = 'X' then
      grdRdrs.Cells[0, grdRdrs.Row] := ''
    else
      grdRdrs.Cells[0, grdRdrs.Row] := 'X';
  end;
end;

procedure TfrmOnlyCard.grdRdrsDblClick(Sender: TObject);
begin
  cmdTicClick(Sender);
end;

procedure TfrmOnlyCard.grdRdrsClick(Sender: TObject);
begin
  with adoTblOnlyCard do
  begin
    Filter := 'rdrcode = ' + grdRdrs.Cells[1,grdRdrs.Row];
    Filtered := true;
  end;
end;

procedure TfrmOnlyCard.N1Click(Sender: TObject);
begin
  adoTblOnlyCard.Delete;
//  updateCount;
end;

procedure TfrmOnlyCard.BitBtn3Click(Sender: TObject);
var
  code : string;
begin
  if adoTblOnlyCard.RecordCount >= 255 then
  begin
    errorMessage(' ⁄œ«œ ·Ì”  «›—«œ ›ﬁÿ «À— «‰ê‘  »—«Ì Â— œ” ê«Â Õœ«òÀ— 255 ‰›— „Ì »«‘œ .');
    exit;
  end;
  code := FixLeft(cmbBarCode.Text,'0',8);
  if cmbBarCode.Text = '' then
    exit;
  if GetPerson(code , false).P_Code <> '' then
  begin
    with adoTblOnlyCard do
      if not Locate('barcode;rdrcode' , VarArrayOf([code,grdRdrs.Cells[1 , grdRdrs.Row]]) , [loCaseInsensitive]) then
      begin
        Append;
        FieldByName('barcode').AsString := code;
        FieldByName('rdrCode').AsString := grdRdrs.Cells[1 , grdRdrs.Row];
        Post;
      end;
  end
  else
  begin
    ErrorMessage('‘„«—Â Å—”‰·Ì „Ê—œ ‰Ÿ— „ÊÃÊœ ‰„Ì »«‘œ .');
    cmbBarCode.Text := '';
  end;
  cmbBarCode.SetFocus;
//  updateCount;
end;

procedure TfrmOnlyCard.SetOnlyCardList;
var
  i : integer;
  sel : boolean;
  r : integer;
  lst : TStringList;
begin
  if not IsNumeric(txtDelay.Text) then
    txtDelay.Text := '200';
  adoTblOnlyCard.DisableControls;
  r := grdRdrs.Row;

  lst := TStringList.Create;
  lst.Clear;
  sel := false;
  for i := 1 to grdRdrs.RowCount-1 do
  begin
    Application.ProcessMessages;
    if grdRdrs.Cells[0,i] = 'X' then
    begin
      Mouse_Wait;
      MSG_Wait('œ— Õ«· «—”«· »Â œ” ê«Â ' + grdRdrs.Cells[2,i]);
      grdRdrs.Row := i;
      sel := true;
      with adoTblOnlyCard do
      begin
        first;
        while not eof do
        begin
          Application.ProcessMessages;
          lst.Add(getperson(fieldByName('BarCode').AsString , false).p_Proxi);
          Next;
        end;
      end;
      Msg_NoWait;
      Mouse_NoWait;

      if SetOnlyCards( Readers[FindReaderCodeIdx(StrToInt(grdRdrs.Cells[1,i]))], lst ,StrToInt(txtDelay.text)) then
        InformationMessage('·Ì”  œ” ê«Â ' + grdRdrs.Cells[2,grdRdrs.Row] + ' »« „Ê›ﬁÌ  «—”«· ‘œ . ')
      else
        ErrorMessage('«—”«· »Â œ” ê«Â ' + grdRdrs.Cells[2,grdRdrs.Row] + ' ‰«„Ê›ﬁ »Êœ . ')
    end;
  end;
  if not sel then
    ErrorMessage('ÂÌç œ” ê«ÂÌ «‰ Œ«» ‰‘œÂ «”  .');

  grdRdrs.Row := r;
  adoTblOnlyCard.EnableControls;
end;

procedure TfrmOnlyCard.cmdOkClick(Sender: TObject);
begin
  case cmbOperate.ItemIndex of
    0 : // Set Only Card List
        SetOnlyCardList;
    1 : // Get Only Card List
        GetOnlyCardList;
    2 : // Delete Only Card List
        DeleteOnlyCardList;
  end;
end;

procedure TfrmOnlyCard.GetOnlyCardList;
var
  i : integer;
  rslt : boolean;
  lst : TStringList;
  rdr : TReaders;
  _barcode, _rdrCode : string;
begin
  adoTblOnlyCard.DisableControls;

  lst := TStringList.Create;
  lst.Clear;

  Mouse_Wait;
  MSG_Wait('œ— Õ«· ŒÊ«‰œ‰ ·Ì”  «“ œ” ê«Â ' + grdRdrs.Cells[2,grdRdrs.Row]);

  for i:= 1 to grdRdrs.RowCount-1 do
    grdRdrs.Cells[0,i] := '';

  rdr := Readers[FindReaderCodeIdx(StrToInt(grdRdrs.Cells[1,grdRdrs.Row]))];
  rslt := GetOnlyCards(rdr , lst);

  if ConfirmMessage('»« «‰Ã«„ «Ì‰ ò«— ·Ì”  œ—Ê‰ œ” ê«Â Ã«Ìê“Ì‰ ·Ì”  Õ«÷— ŒÊ«Âœ ‘œ ' + #13 + '»—«Ì «œ«„Â ò«— «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    adoTblOnlyCard.First;
    while not adoTblOnlyCard.Eof do
      adoTblOnlyCard.Delete;
    for i:=0 to lst.Count-1 do
    begin
      adoTblOnlyCard.Append;
      adoTblOnlyCard.FieldByName('barcode').AsString := getperson(FixLeft(lst.Strings[i] , '0',8),true).P_Code;
      adoTblOnlyCard.FieldByName('rdrCode').AsString := grdRdrs.Cells[1 , grdRdrs.Row];
      _barcode := adoTblOnlyCard.FieldByName('barcode').AsString;
      _rdrCode := adoTblOnlyCard.FieldByName('rdrCode').AsString;
      if not adoTblOnlyCard.Locate('barcode;rdrcode' , VarArrayOf([_barcode,_rdrCode]) , [loCaseInsensitive]) then
        adoTblOnlyCard.Post
      else
        adoTblOnlyCard.Cancel;
    end;
  end;

  Msg_NoWait;
  Mouse_NoWait;

  if rslt then
  begin
    InformationMessage('ŒÊ«‰œ‰ ·Ì”  «“ œ” ê«Â ' + grdRdrs.Cells[2,grdRdrs.Row] + ' »« „Ê›ﬁÌ  «‰Ã«„ ‘œ .')
  end
  else
    ErrorMessage('ŒÊ«‰œ‰ ·Ì”  «“ œ” ê«Â ' + grdRdrs.Cells[2,grdRdrs.Row] + ' ‰«„Ê›ﬁ »Êœ .');

  adoTblOnlyCard.EnableControls;
//  updateCount;
end;

procedure TfrmOnlyCard.updateCount;
begin
  lblCount.Caption := ' ⁄œ«œ :' + IntToStr(adoTblOnlyCard.RecordCount);
end;

procedure TfrmOnlyCard.grdDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  updateCount;
end;

procedure TfrmOnlyCard.DeleteOnlyCardList;
var
  i : integer;
  rslt : boolean;
  rdr : TReaders;
  lst : TStringList;
begin
  if not IsNumeric(txtDelay.Text) then
    txtDelay.Text := '200';

  adoTblOnlyCard.DisableControls;

  Mouse_Wait;
  MSG_Wait('œ— Õ«· Õ–› ·Ì”  «“ œ” ê«Â ' + grdRdrs.Cells[2,grdRdrs.Row]);

  for i:= 1 to grdRdrs.RowCount-1 do
    grdRdrs.Cells[0,i] := '';

  rdr := Readers[FindReaderCodeIdx(StrToInt(grdRdrs.Cells[1,grdRdrs.Row]))];

  if ConfirmMessage('»« «‰Ã«„ «Ì‰ ò«— ·Ì”  «›—«œ „ÊÃÊœ Õ–› ŒÊ«Âœ ‘œ .' + #13 + '»—«Ì «œ«„Â ò«— «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    lst := TStringList.Create;
    lst.Clear;
    rslt := SetOnlyCards(rdr ,lst,StrToInt(txtDelay.text));
    while not adoTblOnlyCard.Eof do
      adoTblOnlyCard.Delete;
  end;

  Msg_NoWait;
  Mouse_NoWait;

  if rslt then
  begin
    InformationMessage('Õ–› ·Ì”  «“ œ” ê«Â ' + grdRdrs.Cells[2,grdRdrs.Row] + ' »« „Ê›ﬁÌ  «‰Ã«„ ‘œ .')
  end
  else
    ErrorMessage('Õ–› ·Ì”  «“ œ” ê«Â ' + grdRdrs.Cells[2,grdRdrs.Row] + ' ‰«„Ê›ﬁ »Êœ .');

  adoTblOnlyCard.EnableControls;
end;

end.



