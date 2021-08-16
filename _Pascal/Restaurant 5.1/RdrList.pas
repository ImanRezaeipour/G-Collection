unit RdrList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, DBS_Proc,
  MSGs, RdrInf;

type
  TfrmReaderList = class(TForm)
    grpAll: TGroupBox;
    dbgRdrList: TDBGrid;
    cmdNew: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    dtaRdrList: TDataSource;
    qryRdrList: TAdoQuery;
    cmdEdit: TBitBtn;
    qryRdrListR_Code: TSmallintField;
    qryRdrListR_Name: TStringField;
    qryRdrListR_Port: TSmallintField;
    qryRdrListR_BaudNo: TSmallintField;
    qryRdrListActiveType: TStringField;
    qryRdrListR_Type: TSmallintField;
    qryRdrListR_Active: TBooleanField;
    qryRdrListR_OnLine: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure dbgRdrListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure qryRdrListCalcFields(DataSet: TDataSet);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgRdrListDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TfrmReaderList.FormCreate(Sender: TObject);
begin
  qryRdrList.connection := frmDBS.DBConnection;
  qryRdrList.Open;
end;

procedure TfrmReaderList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  qryRdrList.Close;
end;

procedure TfrmReaderList.qryRdrListCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('R_Active').Asboolean then
    DataSet.FieldByName('ActiveType').AsString := ('›⁄«·')
  else
    DataSet.FieldByName('ActiveType').AsString := ('€Ì— ›⁄«·');
end;

procedure TfrmReaderList.dbgRdrListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender);
end;

procedure TfrmReaderList.dbgRdrListDblClick(Sender: TObject);
begin
  if qryRdrList.RecordCount > 0 then
  begin
    qryRdrList.Edit;
    qryRdrList.FieldByName('R_Active').AsBoolean := not qryRdrList.FieldByName('R_Active').AsBoolean; 
    qryRdrList.Post;
    LoadReaders(False);
  end;
end;

procedure TfrmReaderList.cmdNewClick(Sender: TObject);
var frmReaderInf : TfrmReaderInf;
begin
  Application.CreateForm(TfrmReaderInf, frmReaderInf);
  frmReaderInf.Flag := MB_NEW;
  frmReaderInf.ShowModal;
  frmReaderInf.Free;
  qryRdrList.requery();
end;

procedure TfrmReaderList.cmdEditClick(Sender: TObject);
var frmReaderInf : TfrmReaderInf;
begin
  if qryRdrList.RecordCount > 0 then
  begin
    Application.CreateForm(TfrmReaderInf, frmReaderInf);
    frmReaderInf.Flag := MB_EDIT;
    frmReaderInf.Code := qryRdrList.FieldByName('R_Code').AsInteger;
    frmReaderInf.ShowModal;
    frmReaderInf.Free;
    qryRdrList.requery();
  end;
end;

procedure TfrmReaderList.cmdDeleteClick(Sender: TObject);
begin
  if not qryRdrList.EOF then
  begin
    if not IsExistsRec_Str('Persons', 'P_BarCode', qryRdrList.FieldByName('R_Name').AsString) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› œ” ê«Â «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        qryRdrList.Delete;
//        qryRdrList.Refresh;
      end;
    end
    else
      InformationMessage('œ” ê«Â „Ê—œ ‰Ÿ— ˛œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;


end.
