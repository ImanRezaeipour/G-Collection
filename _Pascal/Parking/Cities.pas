unit Cities;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS;

type
  TfrmCities = class(TForm)
    grpAll: TGroupBox;
    dbgCities: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    txtName: TEdit;
    txtCode: TEdit;
    Label2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaCities: TDataSource;
    tblCities: TAdoTable;
    txtSearch: TEdit;
    Label3: TLabel;
    tblCitiesCity_Name: TStringField;
    tblCitiesCity_Code: TSmallintField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgCitiesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchChange(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCities.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblCitiesCity_Name.DisplayLabel := (tblCitiesCity_Name.DisplayLabel);
  tblCitiesCity_Code.DisplayLabel := (tblCitiesCity_Code.DisplayLabel);
end;

procedure TfrmCities.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmCities.AreValidFields : Boolean;
begin
  if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ ‘Â— Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('«Ê·ÊÌ  ‘Â— Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('Cities', 'City_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblCities.FieldByName('City_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ ‘Â—  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('Cities', 'City_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblCities.FieldByName('City_Code').AsString <> txtCode.Text))) then
  begin
    if not ConfirmMessage('«Ê·ÊÌ  ‘Â—  ﬂ—«—Ì «” . ¬Ì« „ÌùŒÊ«ÂÌœ ¬‰—« À»  ‰„«ÌÌœø') then
    begin
      AreValidFields := False;
      txtCode.SetFocus;
    end
    else
    begin
      ChngIntegerField('Cities', 'City_Code', StrToInt(txtCode.Text), 1);
      AreValidFields := True;
    end;
  end
  else
    AreValidFields := True;
end;

procedure TfrmCities.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtSearch.Handle);
  SetDirectionFarsi(txtName.Handle);
  tblCities.connection := frmDBS.adoConnect;
  tblCities.Open;
end;

procedure TfrmCities.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmCities.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblCities.Close;
end;

procedure TfrmCities.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgCities.SetFocus;
  end;
end;

procedure TfrmCities.txtSearchChange(Sender: TObject);
begin
  tblCities.Locate('City_Name',txtSearch.Text,[loPartialKey]); //kaveh
//kaveh  tblCities.FindNearest([txtSearch.Text]);
end;

procedure TfrmCities.dbgCitiesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmCities.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtName.Text := '';
  txtCode.Text := IntToStr(GetNewNumber('Cities', 'City_Code'));
  txtName.SetFocus;
end;

procedure TfrmCities.cmdEditClick(Sender: TObject);
begin
  if not tblCities.EOF then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtName.Text := tblCities.FieldByName('City_Name').AsString;
    txtCode.Text := tblCities.FieldByName('City_Code').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmCities.cmdDeleteClick(Sender: TObject);
var t : Integer;
begin
  if not tblCities.EOF then
  begin
    if not InCircleCity(tblCities.FieldByName('City_Name').AsString) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› ‘Â— «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        t := tblCities.FieldByName('City_Code').AsInteger;
        tblCities.Delete;
        ChngIntegerField('Cities', 'City_Code', t, -1);
        tblCities.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ ‘Â— œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmCities.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtCode.SetFocus;
  end;
end;

procedure TfrmCities.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmCities.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblCities.Append
    else if Flag = MB_EDIT then
    begin
      if InCircleCity(tblCities.FieldByName('City_Name').AsString) and
         (tblCities.FieldByName('City_Name').AsString <> txtName.Text) then
      begin
        InformationMessage('‘Â— „Ê—œ ‰Ÿ— œ— ê—œ‘ „Ìù»«‘œ. Ê   €ÌÌ— ¬‰ „Ì”— ‰Ì” .');
        FormInEdit(False);
        Exit;
      end;

      tblCities.Edit;
    end;
    tblCities.FieldByName('City_Name').AsString := txtName.Text;
    tblCities.FieldByName('City_Code').AsString := txtCode.Text;
    tblCities.Post;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('Cities', 'City_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgCities.SetFocus;
    end;
  end;
end;

procedure TfrmCities.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCities.SetFocus;
end;







end.
