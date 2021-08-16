unit RdrKey;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard;

type
  TfrmRdrKey = class(TForm)
    grpAll: TGroupBox;
    dbgRdrKey: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaRdrKey: TDataSource;
    tblRdrKey: TAdoTable;
    lbl1: TLabel;
    tblRdrKeyRK_RdrCode: TSmallintField;
    tblRdrKeyRK_Keys: TStringField;
    tblRdrKeyRdrName: TStringField;
    tblRdrKeyRdrKey: TStringField;
    cmbRdrs: TComboBox;
    cmdK1: TBitBtn;
    cmdK2: TBitBtn;
    cmdK3: TBitBtn;
    cmdK4: TBitBtn;
    cmdK5: TBitBtn;
    cmdK6: TBitBtn;
    cmdK7: TBitBtn;
    cmdK: TBitBtn;
    cmdK8: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgRdrKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmdK1Click(Sender: TObject);
    procedure tblRdrKeyCalcFields(DataSet: TDataSet);
    procedure cmbRdrsKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmRdrKey.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  lbl1.Caption := (lbl1.Caption);
  dbgRdrKey.Columns[0].Title.Caption := (dbgRdrKey.Columns[0].Title.Caption); 
  dbgRdrKey.Columns[1].Title.Caption := (dbgRdrKey.Columns[1].Title.Caption); 
end;

procedure TfrmRdrKey.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmRdrKey.AreValidFields : Boolean;
begin
  if cmbRdrs.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage(' —„Ì‰«· „‘Œ’ ‰‘œÂ «” .');
    cmbRdrs.SetFocus;
  end
  else if IsExistsRec_Num('RdrKey', 'RK_RdrCode', StrToInt(Copy(cmbRdrs.Text, 1, Pos('-', cmbRdrs.Text)-1))) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblRdrKey.FieldByName('RK_RdrCode').AsString <> Copy(cmbRdrs.Text, 1, Pos('-', cmbRdrs.Text)-1)))) then
  begin
    AreValidFields := False;
    ErrorMessage('»—«Ì «Ì‰  —„Ì‰«· ﬂ·Ìœ  ⁄—Ì› ‘œÂ «” .');
    cmbRdrs.SetFocus;
  end
  else if cmdK1.Glyph.Empty  and cmdK2.Glyph.Empty and
          cmdK3.Glyph.Empty  and cmdK4.Glyph.Empty and
          cmdK5.Glyph.Empty  and cmdK6.Glyph.Empty and
          cmdK7.Glyph.Empty  and cmdK8.Glyph.Empty then
  begin
    AreValidFields := False;
    ErrorMessage('ÂÌç ﬂ·ÌœÌ «‰ Œ«» ‰‘œÂ «” .');
    cmdK1.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmRdrKey.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  tblRdrKey.connection := frmDBS.DBConnection;
  tblRdrKey.Open;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers WHERE R_Type = ' + IntToStr(RDR_RESTZ84));
  qry.Open;
  while not qry.Eof do
  begin
    cmbRdrs.Items.Add(qry.FieldByName('R_Code').AsString + '-' + qry.FieldByName('R_Name').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;
  cmbRdrs.ItemIndex := 0;
end;

procedure TfrmRdrKey.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmRdrKey.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblRdrKey.Close;
  LoadReaders(False);
end;

procedure TfrmRdrKey.dbgRdrKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 9 then
  begin
    Key := 0;
    cmdNew.SetFocus;
  end
  else if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmRdrKey.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  cmbRdrs.SetFocus;
end;

procedure TfrmRdrKey.cmdEditClick(Sender: TObject);
var t : String;
begin
  if tblRdrKey.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    t := tblRdrKey.FieldByName('RK_Keys').AsString;
    if t[1] = '0' then cmdK1.Glyph := nil
    else               cmdK1.Glyph := cmdK.Glyph;

    if t[2] = '0' then cmdK2.Glyph := nil
    else               cmdK2.Glyph := cmdK.Glyph;

    if t[3] = '0' then cmdK3.Glyph := nil
    else               cmdK3.Glyph := cmdK.Glyph;

    if t[4] = '0' then cmdK4.Glyph := nil
    else               cmdK4.Glyph := cmdK.Glyph;

    if t[5] = '0' then cmdK5.Glyph := nil
    else               cmdK5.Glyph := cmdK.Glyph;

    if t[6] = '0' then cmdK6.Glyph := nil
    else               cmdK6.Glyph := cmdK.Glyph;

    if t[7] = '0' then cmdK7.Glyph := nil
    else               cmdK7.Glyph := cmdK.Glyph;

    if t[8] = '0' then cmdK8.Glyph := nil
    else               cmdK8.Glyph := cmdK.Glyph;

    t := tblRdrKey.FieldByName('RK_RdrCode').AsString + '-' + GetReaderNameInRam(tblRdrKey.FieldByName('RK_RdrCode').AsInteger);
    cmbRdrs.ItemIndex := cmbRdrs.Items.IndexOf(t);
    cmbRdrs.SetFocus;
  end;
end;

procedure TfrmRdrKey.cmdDeleteClick(Sender: TObject);
begin
  if (tblRdrKey.RecordCount > 0) and
     ConfirmMessage('¬Ì« »—«Ì Õ–› ﬂ·ÌœÂ«Ì  —„Ì‰«· «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    tblRdrKey.Delete;
//    tblRdrKey.Refresh;
  end;
end;

procedure TfrmRdrKey.cmdSaveClick(Sender: TObject);
var keys : String[8];
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblRdrKey.Append
    else if Flag = MB_EDIT then
      tblRdrKey.Edit;

    if cmdK1.Glyph.Empty then keys[1] := '0'
    else                      keys[1] := '1';

    if cmdK2.Glyph.Empty then keys[2] := '0'
    else                      keys[2] := '1';

    if cmdK3.Glyph.Empty then keys[3] := '0'
    else                      keys[3] := '1';

    if cmdK4.Glyph.Empty then keys[4] := '0'
    else                      keys[4] := '1';

    if cmdK5.Glyph.Empty then keys[5] := '0'
    else                      keys[5] := '1';

    if cmdK6.Glyph.Empty then keys[6] := '0'
    else                      keys[6] := '1';

    if cmdK7.Glyph.Empty then keys[7] := '0'
    else                      keys[7] := '1';

    if cmdK8.Glyph.Empty then keys[8] := '0'
    else                      keys[8] := '1';
    keys[0] := #8;

    tblRdrKey.FieldByName('RK_RdrCode').AsInteger := StrToInt(Copy(cmbRdrs.Text, 1, Pos('-', cmbRdrs.Text)-1));
    tblRdrKey.FieldByName('RK_Keys').AsString := keys;
    tblRdrKey.Post;

    if Flag = MB_NEW then
    begin
      cmdK1.Glyph := nil;
      cmdK2.Glyph := nil;
      cmdK3.Glyph := nil;
      cmdK4.Glyph := nil;
      cmdK5.Glyph := nil;
      cmdK6.Glyph := nil;
      cmdK7.Glyph := nil;
      cmdK8.Glyph := nil;
      cmbRdrs.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgRdrKey.SetFocus;
    end;
  end;
end;

procedure TfrmRdrKey.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgRdrKey.SetFocus;
end;







procedure TfrmRdrKey.cmdK1Click(Sender: TObject);
var t : TBitBtn;
begin
  t := TBitBtn(ActiveControl);
  if t.Glyph.Empty then
    t.Glyph := cmdK.Glyph
  else
    t.Glyph := nil;
end;

procedure TfrmRdrKey.tblRdrKeyCalcFields(DataSet: TDataSet);
var
  t, s : String;
  i : Byte;
begin
  t := DataSet.FieldByName('RK_Keys').AsString;
  if Length(t) = 8 then
  begin
    s := '';
    for i := 1 to 8 do
      if t[i] <> '0' then
      begin
        if s <> '' then s := s + '-';
        s := s + IntToStr(i);
      end;


    DataSet.FieldByName('RdrName').AsString := GetReaderNameInRam(DataSet.FieldByName('RK_RdrCode').AsInteger);
    DataSet.FieldByName('RdrKey').AsString := s;
  end;
end;

procedure TfrmRdrKey.cmbRdrsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdK1.SetFocus;
  end;
end;

end.
