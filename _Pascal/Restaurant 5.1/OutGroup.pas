unit OutGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard, QuickRpt, Qrctrls, DateProc;

type
  TfrmOutGroup = class(TForm)
    grpAll: TGroupBox;
    dbgOutGrp: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    txtBarCode: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaOutGrp: TDataSource;
    tblOutGrp: TAdoTable;
    Label6: TLabel;
    txtDate: TEdit;
    cmbVadeh: TComboBox;
    Label2: TLabel;
    lblName: TLabel;
    tblOutGrpOG_Date: TStringField;
    tblOutGrpOG_PCode: TStringField;
    tblOutGrpOG_Vadeh: TSmallintField;
    tblOutGrpVadeh: TStringField;
    tblOutGrpfamilyName: TStringField;
    lblRecNo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgOutGrpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tblOutGrpCalcFields(DataSet: TDataSet);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure txtBarCodeExit(Sender: TObject);
    procedure cmbVadehKeyPress(Sender: TObject; var Key: Char);
    procedure dbgOutGrpDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    Flag : Byte;

    procedure ReOpenTable;
    procedure FormInEdit(vis : Boolean);
    procedure ClearScrFields;
    procedure SetScrFields;
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmOutGroup.SetWinF;
begin
  Caption := (Caption);
  Label6.Caption := (Label6.Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblOutGrpOG_Date.DisplayLabel := (tblOutGrpOG_Date.DisplayLabel);
  tblOutGrpOG_PCode.DisplayLabel := (tblOutGrpOG_PCode.DisplayLabel);
  tblOutGrpVadeh.DisplayLabel := (tblOutGrpVadeh.DisplayLabel);
end;

procedure TfrmOutGroup.ReOpenTable;
begin
  tblOutGrp.Filtered := False;
  if txtDate.Text <> '' then
    tblOutGrp.Filter := 'OG_Date = ''' + txtDate.Text + ''''
  else
    tblOutGrp.Filter := '';
  tblOutGrp.Filtered := True;
end;

procedure TfrmOutGroup.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

procedure TfrmOutGroup.ClearScrFields;
begin
  txtBarcode.Text := '';
  lblName.Caption := '';
  txtBarCode.SetFocus;
end;

procedure TfrmOutGroup.SetScrFields;
begin
  txtBarcode.Text := tblOutGrp.FieldByName('OG_PCode').AsString;
// if frmDBS.tblPersons.findKey([tblOutGrp.FieldByName('OG_PCode').AsString]) then
  if frmDBS.tblPersons.Locate('p_Barcode',FixLeft(tblOutGrp.FieldByName('OG_PCode').AsString,'0',8),[loPartialKey]) then
    lblName.Caption := frmDBS.tblPersons.FieldByName('P_Name').AsString + ' ' +
                       frmDBS.tblPersons.FieldByName('P_Family').AsString
  else
    lblName.Caption := '';
  cmbVadeh.ItemIndex := tblOutGrp.FieldByName('OG_Vadeh').AsInteger-1;
  txtBarCode.SetFocus;
end;

function TfrmOutGroup.AreValidFields : Boolean;
var qry : TAdoQuery;
begin
  if txtBarCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‘„«—Â Å—”‰·Ì Ê«—œ ‰‘œÂ «” .');
    txtBarCode.SetFocus;
  end
  else if cmbVadeh.ItemIndex = -1 then
  begin
    AreValidFields := False;
    ErrorMessage('Ê⁄œÂ €–«ÌÌ „‘Œ’ ‰Ì” .');
    cmbVadeh.SetFocus;
  end
//  else if not frmDBS.tblPersons.FindKey([FixLeft(txtBarCode.Text,'0',8)]) then
  else if not frmDBS.tblPersons.Locate('p_Barcode',FixLeft(txtBarCode.Text,'0',8),[loPartialKey]) then
  begin
    AreValidFields := False;
    ErrorMessage('ç‰Ì‰ ›—œÌ  ⁄—Ì› ‰‘œÂ «” .');
    txtBarCode.SetFocus;
  end
  else
  begin
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.DBConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM OutGroup WHERE og_date = ''' + txtDate.Text + ''' and og_pcode = ''' + FixLeft(txtBarCode.Text,'0',8) + '''');
    qry.Open;
    if not qry.EOF then
    begin
      AreValidFields := False;
      ErrorMessage('‘„«—Â Å—”‰·Ì  ò—«—Ì «”  .');
      txtBarCode.SetFocus;
    end
    else
      AreValidFields := True;
    qry.Close;
    qry.Free;
  end
end;

procedure TfrmOutGroup.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  tblOutGrp.connection := frmDBS.DBConnection;
  for i := MB_SOBH to MB_SHAM do
    cmbVadeh.Items.Add((FoodName[i]));
  lblName.Caption := '';
  txtDate.Text := CurrentDate;

  tblOutGrp.Open;
end;

procedure TfrmOutGroup.FormActivate(Sender: TObject);
begin
  frmDBS.TblPersons.Open;
  FormInEdit(False);

end;

procedure TfrmOutGroup.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblOutGrp.Close;
end;

procedure TfrmOutGroup.tblOutGrpCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('Vadeh').AsString := (FoodName[FieldByName('OG_Vadeh').AsInteger]);
    FieldByName('FamilyName').AsString := GetPersonFamilyName(FieldByName('OG_Pcode').AsString);
  end;
end;

procedure TfrmOutGroup.txtDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgOutGrp.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmOutGroup.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text)
  else
    txtDate.Text := CurrentDate;
  ReOpenTable;
end;

procedure TfrmOutGroup.dbgOutGrpKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmOutGroup.cmdNewClick(Sender: TObject);
begin
  if txtDate.Text <> '' then
  begin
    FormInEdit(True);
    Flag := MB_NEW;
    ClearScrFields;
  end
  else
    ErrorMessage(' «—ÌŒ „‘Œ’ ‰‘œÂ «” .');
end;

procedure TfrmOutGroup.cmdEditClick(Sender: TObject);
begin
  if tblOutGrp.RecordCount > 0 then
  begin
    if txtDate.Text <> '' then
    begin
      FormInEdit(True);
      Flag := MB_EDIT;
      SetScrFields;
    end
    else
      ErrorMessage(' «—ÌŒ „‘Œ’ ‰‘œÂ «” .');
  end;
end;

procedure TfrmOutGroup.cmdDeleteClick(Sender: TObject);
begin
  if tblOutGrp.RecordCount > 0 then
  begin
    if ConfirmMessage('¬Ì« »—«Ì Õ–› Å—”‰· «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      tblOutGrp.Delete;
//      tblOutGrp.Refresh;
    end;
  end;
end;

procedure TfrmOutGroup.txtBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbVadeh.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmOutGroup.txtBarCodeExit(Sender: TObject);
begin
  if frmDBS.tblPersons.Locate('p_Barcode',FixLeft(txtBarCode.Text,'0',8),[loPartialKey]) then
    lblName.Caption := frmDBS.tblPersons.FieldByName('P_Name').AsString + ' ' +
                       frmDBS.tblPersons.FieldByName('P_Family').AsString
  else
    lblName.Caption := '';
end;

procedure TfrmOutGroup.cmbVadehKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end
end;

procedure TfrmOutGroup.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblOutGrp.Append
    else if Flag = MB_EDIT then
      tblOutGrp.Edit;

    tblOutGrp.FieldByName('OG_Date').AsString := txtDate.Text;
    tblOutGrp.FieldByName('OG_PCode').AsString := FixLeft(txtBarcode.Text,'0',8);
    tblOutGrp.FieldByName('OG_Vadeh').AsInteger := cmbVadeh.ItemIndex+1;
    tblOutGrp.Post;

    if Flag = MB_NEW then
      ClearScrFields
    else
    begin
      FormInEdit(False);
      dbgOutGrp.SetFocus;
    end;
  end;
end;

procedure TfrmOutGroup.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgOutGrp.SetFocus;
end;


procedure TfrmOutGroup.dbgOutGrpDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  lblRecNo.Caption := (' ⁄œ«œ : ' + IntToStr(tblOutGrp.RecordCount));
end;

end.
