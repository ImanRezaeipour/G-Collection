unit reserve7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard;

type
  TfrmReserve7 = class(TForm)
    grpAll: TGroupBox;
    dbgreserve7: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lbl2: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtareserve7: TDataSource;
    tblreserve7: TADOTable;
    tblreserve7rsrv7_name: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgreserve7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    Flag : Byte;

    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmReserve7.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  //Height := Height + 25;
  Height := Height + 35;
end;

function TfrmReserve7.AreValidFields : Boolean;
begin
  if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Str('reserve7', 'rsrv7_name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblreserve7.FieldByName('rsrv7_name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„   ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmReserve7.FormCreate(Sender: TObject);
begin
  SetDirectionFarsi(txtName.Handle);
  tblreserve7.connection := frmDBS.DBConnection;
  tblreserve7.Open;
end;

procedure TfrmReserve7.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmReserve7.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblreserve7.Close;
end;

procedure TfrmReserve7.dbgreserve7KeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmReserve7.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtName.Text := '';
  txtName.SetFocus;
end;

procedure TfrmReserve7.cmdEditClick(Sender: TObject);
begin
  if tblreserve7.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtname.Text := tblreserve7.FieldByName('rsrv7_name').AsString;
    txtName.SetFocus;
  end;
end;

procedure TfrmReserve7.cmdDeleteClick(Sender: TObject);
begin
  if tblreserve7.RecordCount > 0 then
  begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–›  «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        tblreserve7.Delete;
      end;
  end;
end;

procedure TfrmReserve7.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmReserve7.cmdSaveClick(Sender: TObject);
var
  Oldreserve7 : String;
  qry : TAdoQuery;
begin
  if AreValidFields then
  begin
    Oldreserve7 := tblreserve7.FieldByName('rsrv7_name').AsString;
    if Flag = MB_NEW then
      tblreserve7.Append
    else if Flag = MB_EDIT then
      tblreserve7.Edit;

    tblreserve7.FieldByName('rsrv7_name').AsString := txtName.Text;
    tblreserve7.Post;

    if Flag = MB_NEW then
    begin

    end
    else
    begin
      FormInEdit(False);
      dbgreserve7.SetFocus;
    end;
  end;
end;

procedure TfrmReserve7.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgreserve7.SetFocus;
end;







end.
