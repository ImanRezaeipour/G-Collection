unit SendTbl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, XStringGrid;

type
  TfrmSendTable = class(TForm)
    lbl1: TLabel;
    cmbReaders: TComboBox;
    grdSerives: TXStringGrid;
    btnSel: TBitBtn;
    btnInvert: TBitBtn;
    btnClose: TBitBtn;
    btnSend: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnSelClick(Sender: TObject);
    procedure btnInvertClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    function  ServiceSelCount : Integer;

  public
    { Public declarations }
  end;


var
  frmSendTable: TfrmSendTable;

implementation

uses
  DBS, MSGs, Funcs, ADODB, DB, Globals, RunCmnds, Code_Sys, FntSel;

{$R *.dfm}

var
   tartib: byte;

procedure TfrmSendTable.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmSendTable));

  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  for i := 0 to grdSerives.ColCount-1 do
    grdSerives.Cells[i, 0] := (grdSerives.Cells[i, 0]);
  btnSel.Caption := (btnSel.Caption);
  btnInvert.Caption := (btnInvert.Caption);
  btnSend.Caption := (btnSend.Caption);
  btnClose.Caption := (btnClose.Caption);
end;

function TfrmSendTable.ServiceSelCount : Integer;
var
  i, cnt : Byte;
begin
  cnt := 0;
  if grdSerives.RowCount > 1 then
    for i := 1 to grdSerives.RowCount-1 do
      if grdSerives.Cells[0, i] <> '' then
        Inc(cnt);

  Result := cnt;
end;

procedure TfrmSendTable.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  tartib:=0;
  if rdrCount > 0 then
    for i := 0 to rdrCount-1 do
      cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT S_Code, S_Name FROM Services');
    Open;
    while not Eof do
    begin
      grdSerives.Cells[1, RecNo] := FieldByName('S_Code').AsString;
      grdSerives.Cells[2, RecNo] := FieldByName('S_Name').AsString;
      Next;
    end;
    grdSerives.RowCount := RecordCount+1;
    Close;

  end;
end;

procedure TfrmSendTable.btnSelClick(Sender: TObject);
var
   i:byte;
begin
  if grdSerives.Row > 0 then
  begin
    if grdSerives.Cells[0, grdSerives.Row] = ''
    then begin
      inc(tartib);
      grdSerives.Cells[0, grdSerives.Row] :=inttostr(tartib);
    end
    else if grdSerives.Cells[0, grdSerives.Row]=inttostr(tartib)
    then begin
      dec(tartib);
      grdSerives.Cells[0, grdSerives.Row] := '';
    end;
  end;
end;

procedure TfrmSendTable.btnInvertClick(Sender: TObject);
var i : Byte;
begin
  tartib:=0;
  if grdSerives.RowCount > 1 then
    for i := 1 to grdSerives.RowCount-1 do
      if grdSerives.Cells[0, i] = ''
      then begin
        inc(tartib);
        grdSerives.Cells[0, i] := inttostr(tartib);
      end
      else begin
        grdSerives.Cells[0, i] := '';
      end;
end;

procedure TfrmSendTable.btnSendClick(Sender: TObject);
var
  i,n, selCount, idx : Byte;
  OK : Boolean;
  s : String;
begin
  if cmbReaders.Text = '' then
  begin
    ErrorMessage('ÂÌç  —„Ì‰«·Ì «‰ Œ«» ‰‘œÂ «” .');
    cmbReaders.SetFocus;
  end
  else
  begin
    selCount := ServiceSelCount;
    if selCount = 0 then
    begin
      ErrorMessage('ÂÌç Œœ„« Ì «‰ Œ«» ‰‘œÂ «” .');
      grdSerives.SetFocus;
    end
    else if selCount > 20 then
    begin
      ErrorMessage('«—”«· »Ì‘ «“ 20 ‰Ê⁄ Œœ„«  „Ì”— ‰„Ìù»«‘œ.');
      grdSerives.SetFocus;
    end
    else
    begin
      OK := True;
      for n := 1 to tartib do
      for i := 1 to grdSerives.RowCount-1 do
      begin
        if OK and (grdSerives.Cells[0, i] = inttostr(n)) then
        begin
          s := WinToDos(NumReverse(grdSerives.Cells[2, i]), WinSysType, DOS_IR_SYS);
          s:=AlphaReverse(s);
          if n=tartib then
          begin
            idx:=StrToInt(grdSerives.Cells[0, i]) -1;
            OK := SendItems(Readers[cmbReaders.ItemIndex], 1, (idx OR $80), StrToInt(grdSerives.Cells[1, i]), 0, s);
            OK := (OK and SendLimitTime(Readers[cmbReaders.ItemIndex], '00:0000:00', '00:0023:59', '00:0000:00'));
            {Break;}
          end
          else
            idx:=StrToInt(grdSerives.Cells[0, i]) -1;
            OK := SendItems(Readers[cmbReaders.ItemIndex], 1, idx, StrToInt(grdSerives.Cells[1, i]), 0, s);
        end;
      end;

      if OK then
        InformationMessage('«—”«· Œœ„«  «‰Ã«„ ‘œ.')
      else
        ErrorMessage('«—”«· Œœ„«  ‰«„Ê›ﬁ »Êœ.');
    end;
  end;
end;

end.
