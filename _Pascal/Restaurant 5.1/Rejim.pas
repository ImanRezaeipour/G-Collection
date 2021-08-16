unit Rejim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc;

type
  TfrmRejim = class(TForm)
    grpAll: TGroupBox;
    dbgRejim: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    Label1: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaRejim: TDataSource;
    cmbPersonCode: TComboBox;
    cmbPersonName: TComboBox;
    tblRejim: TAdoQuery;
    tblRejimP_BarCode: TStringField;
    tblRejimP_Family: TStringField;
    tblPerson: TAdoTable;
    tblRejimP_Rejim: TBooleanField;
    Label2: TLabel;
    tblRejimP_Name: TStringField;
    tblRejimNames: TStringField;
    tblRejimPCode: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure dbgRejimKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPersonCodeClick(Sender: TObject);
    procedure cmbPersonNameClick(Sender: TObject);
    procedure cmbPersonCodeExit(Sender: TObject);
    procedure cmbPersonNameExit(Sender: TObject);
    procedure tblRejimCalcFields(DataSet: TDataSet);
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

procedure TfrmRejim.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  tblRejimPCode.DisplayLabel := (tblRejimPCode.DisplayLabel);
  tblRejimNames.DisplayLabel := (tblRejimNames.DisplayLabel);
end;

procedure TfrmRejim.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmRejim.AreValidFields : Boolean;
begin
  if cmbPersonCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('Å—”‰· „‘Œ’ ‰‘œÂ «” .');
    cmbPersonCode.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmRejim.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(cmbPersonName.Handle);
  tblRejim.connection := frmDBS.DBConnection;
  tblPerson.connection := frmDBS.DBConnection;

  tblRejim.SQL.add('select * from persons where p_rejim = 1');

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT P_BarCode, P_Family, P_Name FROM Persons WHERE P_IsGuest = 0');
  qry.Open;
  while not qry.EOF do
  begin
    cmbPersonCode.Items.Add(qry.FieldByName('P_BarCode').AsString);
    cmbPersonName.Items.Add(qry.FieldByName('P_Family').AsString + '-' + qry.FieldByName('P_Name').AsString);
    qry.Next;
  end;
  qry.Close;
  qry.Free;
  tblRejim.Open;
  tblPerson.Open;
end;

procedure TfrmRejim.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmRejim.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblRejim.Close;
  tblPerson.Close;
end;

procedure TfrmRejim.tblRejimCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('PCode').AsString := DelLeftZero(FieldByName('P_BarCode').AsString);
    FieldByName('Names').AsString := FieldByName('P_Family').AsString + '-' + FieldByName('P_Name').AsString;
  end;
end;

procedure TfrmRejim.dbgRejimKeyDown(Sender: TObject; var Key: Word;
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
    cmdDeleteClick(Sender);
end;

procedure TfrmRejim.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  cmbPersonCode.ItemIndex := -1;
  cmbPersonName.ItemIndex := -1;
  cmbPersonCode.SetFocus;
end;

procedure TfrmRejim.cmdDeleteClick(Sender: TObject);
begin
  if tblRejim.RecordCount > 0 then
  begin
    if ConfirmMessage('¬Ì« »—«Ì Õ–› Å—”‰· «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      tblRejim.Edit;
      tblRejim.FieldByName('P_Rejim').AsBoolean := false;
      tblRejim.Post;
      tblRejim.Requery([]);
      tblRejim.EnableControls;
    end;
  end;
end;

procedure TfrmRejim.cmbPersonCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmRejim.cmbPersonCodeClick(Sender: TObject);
begin
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmRejim.cmbPersonNameClick(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonName.ItemIndex;
end;

procedure TfrmRejim.cmbPersonCodeExit(Sender: TObject);
begin
  cmbPersonCode.ItemIndex := cmbPersonCode.Items.IndexOf(FixLeft(cmbPersonCode.Text, '0', 8));
  cmbPersonName.ItemIndex := cmbPersonCode.ItemIndex;
end;

procedure TfrmRejim.cmbPersonNameExit(Sender: TObject);
begin
  cmbPersonName.ItemIndex := cmbPersonName.Items.IndexOf(cmbPersonName.Text);
  cmbPersonCode.ItemIndex := cmbPersonName.ItemIndex;
end;

procedure TfrmRejim.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if tblPerson.Locate('p_barcode', FixLeft(cmbPersonCode.Text, '0', 8),[loPartialKey]) then
    begin
      frmDBS.tblPersons.Close;
      tblPerson.Edit;
      tblPerson.FieldByName('P_Rejim').AsBoolean := true;
      tblPerson.Post;
      tblRejim.Requery([]);

      cmbPersonCode.ItemIndex := -1;
      cmbPersonName.ItemIndex := -1;
      cmbPersonCode.SetFocus;
      frmDBS.tblPersons.Open;
    end;
  end;
end;

procedure TfrmRejim.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgRejim.SetFocus;
end;







end.
