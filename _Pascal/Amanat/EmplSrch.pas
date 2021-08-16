unit EmplSrch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, CheckLst, DB, ExtCtrls, ADODB, DosMove,
  OleCtrls;

type
  TfrmEmplSrch = class(TForm)
    grpAll: TGroupBox;
    dbgPersons: TDBGrid;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    dtaPersons: TDataSource;
    txtSearchCode: TEdit;
    lbl1: TLabel;
    Bevel1: TBevel;
    lblRecNo: TLabel;
    lbl2: TLabel;
    txtSearchFamily: TEdit;
    adotblEmployee: TADOTable;
    DosMove1: TDosMove;
    adotblEmployeeEmpl_No: TWideStringField;
    adotblEmployeeEmpl_Name: TWideStringField;
    adotblEmployeeEmpl_Family: TWideStringField;
    adotblEmployeeEmpl_Active: TBooleanField;
    adotblEmployeeEmpl_CoPost: TIntegerField;
    adotblEmployeeEmpl_Part: TIntegerField;
    adotblEmployeeEmpl_Dscnt: TIntegerField;
    adotblEmployeeEmpl_Balance: TBCDField;
    adotblEmployeeDiscount: TStringField;
    adotblEmployeeFamilyName: TStringField;
    adotblEmployeeEmpl_ID: TWideStringField;
    adotblEmployeeEmpl_Department: TIntegerField;
    lbl3: TLabel;
    txtID: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchCodeExit(Sender: TObject);
    procedure adotblEmployeeCalcFields(DataSet: TDataSet);
  private
    { Private declarations }

    procedure ReOpenTable;
    procedure SetWinF;
  public
    { Public declarations }
  end;

var
  frmEmplSrch : TfrmEmplSrch;


implementation

uses
  Funcs, MSGs, DBS, Globals, Keyboard, FntSel{, ChngAll};

{$R *.DFM}


procedure TfrmEmplSrch.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmEmplSrch));

  Caption := (Caption);
  grpAll.Caption := (grpAll.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  for i := 0 to dbgPersons.Columns.Count-1 do
    dbgPersons.Columns[i].Title.Caption := (dbgPersons.Columns[i].Title.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

procedure TfrmEmplSrch.ReOpenTable;
var s : String;
begin
  s := '';
  if gOptions.UserDepart <> 0 then
    s := 'Empl_Department = ' + IntToStr(gOptions.UserDepart);

  if txtSearchCode.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
    s := s + 'Empl_No LIKE ''' + txtSearchCode.Text + '%''';
  end;

  if txtSearchFamily.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
    s := s + 'Empl_Family LIKE ''' + txtSearchFamily.Text + '*''';
  end;

  if txtID.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
    s := s + 'Empl_ID LIKE ''' + txtID.Text + '*''';
  end;

  adotblEmployee.Filtered := False;
  adotblEmployee.Filter := s;
  adotblEmployee.Filtered := True;
  lblRecNo.Caption := ('йзого : ' + IntToStr(adotblEmployee.RecordCount));
end;







procedure TfrmEmplSrch.FormCreate(Sender: TObject);
begin
  SetWinF;
  adotblEmployee.Connection := frmDBS.adoConnect;
  adotblEmployee.Open;
  ReOpenTable;
end;

procedure TfrmEmplSrch.FormActivate(Sender: TObject);
begin
  ReOpenTable;
end;

procedure TfrmEmplSrch.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adotblEmployee.Close;
end;

procedure TfrmEmplSrch.txtSearchCodeExit(Sender: TObject);
begin
  ReOpenTable;
end;

procedure TfrmEmplSrch.adotblEmployeeCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('FamilyName').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
  DataSet.FieldByName('Discount').AsString := GetDiscountName(DataSet.FieldByName('Empl_Dscnt').AsInteger);

end;

end.
