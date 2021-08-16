unit BarCods;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, ExtCtrls, Globals,
  FarsiApi, MSGs, DBS, Keyboard, SrchCard;

type
  TfrmBarCodes = class(TForm)
    grpAll: TGroupBox;
    dbgBarCodes: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lblFromCode: TLabel;
    txtFromCode: TEdit;
    lblState: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaBarCodes: TDataSource;
    tblBarCodes: TAdoTable;
    txtSearch: TEdit;
    Label3: TLabel;
    tblBarCodesCard_Code: TStringField;
    tblBarCodesCard_State: TSmallintField;
    tblBarCodesStName: TStringField;
    rdo: TRadioGroup;
    cmdSearch: TBitBtn;
    cmbState: TComboBox;
    txtToCode: TEdit;
    lblToCode: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtFromCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbStateKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgBarCodesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchChange(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure tblBarCodesCalcFields(DataSet: TDataSet);
    procedure txtToCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdSearchClick(Sender: TObject);
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

procedure TfrmBarCodes.SetWinF;
var
  i : Byte;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdSearch.Caption := (cmdSearch.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  Label3.Caption := (Label3.Caption);
  lblToCode.Caption := (lblToCode.Caption);
  lblState.Caption := (lblState.Caption);
  for i:= 0 to rdo.Items.Count - 1 do
    rdo.Items.Strings[i] := (rdo.Items.Strings[i]);
  tblBarCodesCard_Code.DisplayLabel := (tblBarCodesCard_Code.DisplayLabel);
  tblBarCodesStName.DisplayLabel := (tblBarCodesStName.DisplayLabel);
end;

procedure TfrmBarCodes.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmBarCodes.AreValidFields : Boolean;
var qry : TAdoQuery;
begin
  if txtFromCode.Text = '' then
  begin
    AreValidFields := False;
    if rdo.ItemIndex = 0 then
      ErrorMessage('ﬂœ Ê«—œ ‰‘œÂ «” .')
    else
      ErrorMessage('ﬂœ «» œ« Ê«—œ ‰‘œÂ «” .');
    txtFromCode.SetFocus;
  end
  else if (rdo.ItemIndex = 1) and (txtToCode.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ «‰ Â« „‘Œ’ ‰‘œÂ «” .');
    txtToCode.SetFocus;
  end
  else if (rdo.ItemIndex = 1) and
          (StrToInt(txtToCode.Text) < StrToInt(txtFromCode.Text)) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ «‰ Â« «“ ﬂœ «» œ« ﬂÊçﬂ — «” .');
    txtToCode.SetFocus;
  end
  else if (Flag <> MB_DELETE) and (cmbState.Text = '') then
  begin
    AreValidFields := False;
    ErrorMessage('Ê÷⁄Ì  „‘Œ’ ‰‘œÂ «” .');
    cmbState.SetFocus;
  end
  else if (rdo.ItemIndex = 0) and IsExistsRec_Str('BarCodes', 'Card_Code', txtFromCode.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblBarCodes.FieldByName('Card_Code').AsString <> txtFromCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ  ﬂ—«—Ì «” .');
    txtFromCode.SetFocus;
  end
  else if Flag = MB_NEW then
  begin
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM BarCodes');
    qry.SQL.Add('WHERE Card_Code >= ''' + txtFromCode.Text + '''');
    qry.SQL.Add('AND Card_Code <= ''' + txtToCode.Text + '''');
    qry.Open;
    if not qry.EOF then
    begin
      AreValidFields := False;
      ErrorMessage('«Ì‰ „ÕœÊœÂ œ«—«Ì ﬂœÂ«Ì  ﬂ—«—Ì „Ìù»«‘œ.');
      txtToCode.SetFocus;
    end
    else
      AreValidFields := True;
    qry.Close;
    qry.Free;
  end
  else
    AreValidFields := True;
end;

procedure TfrmBarCodes.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  tblBarCodes.connection := frmDBS.adoConnect;
  tblBarCodes.Open;
  for i := MB_NORMAL to MB_LOST do
    cmbState.Items.Add((StName[i]));
end;

procedure TfrmBarCodes.FormActivate(Sender: TObject);
begin
  SetDirectionFarsi(cmbState.Handle);
  cmbState.SetFocus;
  cmbState.ItemIndex := 0;
  txtSearch.SetFocus;
  FormInEdit(False);
end;

procedure TfrmBarCodes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblBarCodes.Close;
end;

procedure TfrmBarCodes.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgBarCodes.SetFocus;
  end;
end;

procedure TfrmBarCodes.txtSearchChange(Sender: TObject);
begin
  tblBarCodes.Locate('Card_Code',txtSearch.Text,[loPartialKey]); //kaveh
//kaveh  tblBarCodes.FindNearest([txtSearch.Text]);
end;

procedure TfrmBarCodes.dbgBarCodesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmBarCodes.cmdNewClick(Sender: TObject);
begin
  if rdo.ItemIndex = 0 then
  begin
    lblFromCode.Caption := ('&ﬂœ');
    lblToCode.Visible := False;
    txtToCode.Visible := False;
  end
  else
  begin
    lblFromCode.Caption := ('«“ &ﬂœ');
    lblToCode.Visible := True;
    txtToCode.Visible := True;
  end;
  FormInEdit(True);
  Flag := MB_NEW;
  txtFromCode.Text := '';
  txtToCode.Text := '';
  cmbState.ItemIndex := 0;
  txtFromCode.SetFocus;
end;

procedure TfrmBarCodes.cmdEditClick(Sender: TObject);
begin
  if tblBarCodes.RecordCount > 0 then
  begin
    if rdo.ItemIndex = 0 then
    begin
      lblFromCode.Caption := ('&ﬂœ');
      lblToCode.Visible := False;
      txtToCode.Visible := False;
    end
    else
    begin
      lblFromCode.Caption := ('«“ &ﬂœ');
      lblToCode.Visible := True;
      txtToCode.Visible := True;
    end;
    FormInEdit(True);
    Flag := MB_EDIT;
    txtFromCode.Text := tblBarCodes.FieldByName('Card_Code').AsString;
    txtToCode.Text := tblBarCodes.FieldByName('Card_Code').AsString;;
    cmbState.ItemIndex := tblBarCodes.FieldByName('Card_State').AsInteger - MB_NORMAL;
    txtFromCode.SetFocus;
  end;
end;

procedure TfrmBarCodes.cmdDeleteClick(Sender: TObject);
begin
  if tblBarCodes.RecordCount > 0 then
  begin
    if (rdo.ItemIndex = 0) then
    begin
      if not InCircleCard(tblBarCodes.FieldByName('Card_Code').AsString) then
      begin
        if ConfirmMessage('¬Ì« »—«Ì Õ–› ﬂœ «ÿ„Ì‰«‰ œ«—Ìœø') then
          tblBarCodes.Delete
      end
      else
        InformationMessage('«Ì‰ ﬂœ ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
    end
    else if rdo.ItemIndex = 1 then
    begin
      lblFromCode.Caption := ('«“ &ﬂœ');
      lblToCode.Visible := True;
      txtToCode.Visible := True;
      lblState.Visible := False;
      cmbState.Visible := False;
      cmdSave.Caption := ('&Õ–›');
      FormInEdit(True);
      Flag := MB_DELETE;
      txtFromCode.Text := tblBarCodes.FieldByName('Card_Code').AsString;
      txtToCode.Text := tblBarCodes.FieldByName('Card_Code').AsString;;
      cmbState.ItemIndex := MB_NORMAL - tblBarCodes.FieldByName('Card_State').AsInteger;
      txtFromCode.SetFocus;
    end;
  end;
end;

procedure TfrmBarCodes.cmdSearchClick(Sender: TObject);
var frmSearchCard : TfrmSearchCard;
begin
  Application.CreateForm(TfrmSearchCard, frmSearchCard);
  frmSearchCard.ShowModal;
  tblBarCodes.Filtered := False;
  tblBarCodes.Filter := frmSearchCard.SqlStmt;
  tblBarCodes.Filtered := True;
begin

end;

end;

procedure TfrmBarCodes.txtFromCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if txtToCode.Visible then
      txtToCode.SetFocus
    else
      cmbState.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmBarCodes.txtToCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if cmbState.Visible then
      cmbState.SetFocus
    else
      cmdSave.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmBarCodes.cmbStateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmBarCodes.cmdSaveClick(Sender: TObject);
var
  i : LongInt;
  qry : TAdoQuery;
begin
  if AreValidFields then
  begin
    if rdo.ItemIndex = 0 then
    begin
      if Flag = MB_NEW then
        tblBarCodes.Append
      else if Flag = MB_EDIT then
      begin
        if InCircleCard(tblBarCodes.FieldByName('Card_Code').AsString) and
           (tblBarCodes.FieldByName('Card_Code').AsString <> txtFromCode.Text) then
        begin
          InformationMessage('ﬂ«—  „Ê—œ ‰Ÿ— œ— ê—œ‘ „Ìù»«‘œ. Ê   €ÌÌ— ¬‰ „Ì”— ‰Ì” .');
          FormInEdit(False);
          Exit;
        end;

        tblBarCodes.Edit;
      end;
      tblBarCodes.FieldByName('Card_Code').AsString := txtFromCode.Text;
      tblBarCodes.FieldByName('Card_State').AsInteger := cmbState.ItemIndex + MB_NORMAL;
      tblBarCodes.Post;

      if Flag = MB_NEW then
      begin
        txtFromCode.Text := '';
        txtToCode.Text := '';
        cmbState.ItemIndex := 0;
        txtFromCode.SetFocus;
      end
      else
      begin
        FormInEdit(False);
        dbgBarCodes.SetFocus;
      end;
    end
    else if rdo.ItemIndex = 1 then
    begin
      if Flag = MB_NEW then
      begin
        Mouse_Wait;
        for i := StrToInt(txtFromCode.Text) to StrToInt(txtToCode.Text) do
        begin
          tblBarCodes.Append;
          tblBarCodes.FieldByName('Card_Code').AsString := IntToStr(i);
          tblBarCodes.FieldByName('Card_State').AsInteger := cmbState.ItemIndex + MB_NORMAL;
          tblBarCodes.Post;
        end;
        Mouse_NoWait;
      end
      else if Flag = MB_EDIT then
      begin
        qry := TAdoQuery.Create(Application);
        qry.connection := frmDBS.adoConnect;
        qry.SQL.Clear;
        qry.SQL.Add('UPDATE BarCodes SET Card_State = ' + IntToStr(cmbState.ItemIndex+MB_NORMAL));
        qry.SQL.Add('WHERE Card_Code >= ''' + txtFromCode.Text + '''');
        qry.SQL.Add('AND Card_Code <= ''' + txtToCode.Text + '''');
        qry.ExecSQL;
        qry.Free;
        tblBarCodes.Refresh;
      end
      else if Flag = MB_DELETE then
      begin
        qry := TAdoQuery.Create(Application);
        qry.connection := frmDBS.adoConnect;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT M_BarCode FROM Machines');
        qry.SQL.Add('WHERE M_BarCode >= ''' + txtFromCode.Text + '''');
        qry.SQL.Add('AND M_BarCode <= ''' + txtToCode.Text + '''');
        qry.Open;
        if qry.EOF then
        begin
          if ConfirmMessage('¬Ì« »—«Ì Õ–› „ÕœÊœÂ ﬂœÂ« «ÿ„Ì‰«‰ œ«—Ìœø') then
          begin
            Mouse_Wait;
            qry.Close;
            qry.SQL.Clear;
            qry.SQL.Add('DELETE FROM BarCodes');
            qry.SQL.Add('WHERE Card_Code >= ''' + txtFromCode.Text + '''');
            qry.SQL.Add('AND Card_Code <= ''' + txtToCode.Text + '''');
            qry.ExecSQL;
            Mouse_NoWait;
          end;
        end
        else
          ErrorMessage('»⁄÷Ì «“ ﬂœÂ« œ— «Ì‰ „ÕœÊœÂ œ«—«Ì ê—œ‘ »ÊœÂ Ê Õ–› ¬‰Â« „„ﬂ‰ ‰Ì” .');
        qry.Close;
        qry.Free;
        tblBarCodes.Refresh;
        lblState.Visible := True;
        cmbState.Visible := True;
        cmdSave.Caption := ('&À» ');
      end;

      FormInEdit(False);
      dbgBarCodes.SetFocus;
    end;
  end;
end;

procedure TfrmBarCodes.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgBarCodes.SetFocus;
end;

procedure TfrmBarCodes.tblBarCodesCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('Card_State').AsInteger in [MB_NORMAL..MB_LOST] then
     DataSet.FieldByName('StName').AsString := (StName[DataSet.FieldByName('Card_State').AsInteger]);
end;




end.
