unit LostCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Buttons, Menus, DosMove,dateproc,KeyBoard,
  QuickRpt, grimgctrl, ExtCtrls, DBCtrls;

type
  TfrmLostCard = class(TForm)
    grd: TDBGrid;
    dtaLostCard: TDataSource;
    adoTblLostCard: TADOTable;
    adoTblLostCardFamilyName: TStringField;
    pmnu: TPopupMenu;
    N1: TMenuItem;
    DosMove1: TDosMove;
    adoTblLostCardl_empId: TStringField;
    adoTblLostCardl_EmpCode: TStringField;
    adoTblLostCardl_Date: TStringField;
    adoTblLostCardl_RemoveDate: TStringField;
    adoTblLostCardl_Credit: TCurrencyField;
    rdoView: TRadioGroup;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    btnSave: TBitBtn;
    txtDate: TEdit;
    btnDelete: TBitBtn;
    lblCount: TLabel;
    DataSource2: TDataSource;
    DataSource1: TDataSource;
    ADOTable2: TADOTable;
    ADOTable2te: TStringField;
    ADOTable2Empl_No: TWideStringField;
    ADOTable2Empl_ID: TWideStringField;
    ADOTable2Empl_Name: TWideStringField;
    ADOTable2Empl_Family: TWideStringField;
    ADOTable2Empl_Active: TBooleanField;
    ADOTable2Empl_Department: TIntegerField;
    ADOTable2Empl_CoPost: TIntegerField;
    ADOTable2Empl_Part: TIntegerField;
    ADOTable2Empl_Dscnt: TIntegerField;
    ADOTable2Empl_ExpDate: TWideStringField;
    ADOTable2Empl_Balance: TBCDField;
    ADOTable1: TADOTable;
    ADOTable1te: TStringField;
    ADOTable1Empl_No: TWideStringField;
    ADOTable1Empl_ID: TWideStringField;
    ADOTable1Empl_Name: TWideStringField;
    ADOTable1Empl_Family: TWideStringField;
    ADOTable1Empl_Active: TBooleanField;
    ADOTable1Empl_Department: TIntegerField;
    ADOTable1Empl_CoPost: TIntegerField;
    ADOTable1Empl_Part: TIntegerField;
    ADOTable1Empl_Dscnt: TIntegerField;
    ADOTable1Empl_ExpDate: TWideStringField;
    ADOTable1Empl_Balance: TBCDField;
    cmbEmplCode: TDBLookupComboBox;
    cmbEmplName: TDBLookupComboBox;
    adoTblLostCardRemoved: TBooleanField;
    adoTblLostCardRemoveTime: TStringField;
    adoTblLostCardlost_RemoveTime: TWideStringField;
    procedure grdTitleClick(Column: TColumn);
    procedure rdoViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADOTable1CalcFields(DataSet: TDataSet);
    procedure btnDeleteClick(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure adoTblLostCardCalcFields(DataSet: TDataSet);
    procedure N1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure grdDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure FillGrid;
    procedure updateCount;
  public
    { Public declarations }
  end;

var
  frmLostCard : tfrmLostCard;
implementation

uses DBS,Globals, {Users, }Funcs, Modem, MSGs, RunCmnds;

{$R *.dfm}

procedure TfrmLostCard.FormCreate(Sender: TObject);
begin
  adoTblLostCard.Connection := frmDBS.adoConnect;;
  adoTblLostCard.Open;
  txtDate.Text := CurrentDate;
end;


procedure TfrmLostCard.FormShow(Sender: TObject);
begin
ADOTable1.Connection:=frmDBS.adoConnect ;
ADOTable2.Connection:=frmDBS.adoConnect ;
ADOTable1.Open;
ADOTable2.Open ;
end;

procedure TfrmLostCard.FillGrid;
begin
end;

procedure TfrmLostCard.ADOTable1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmLostCard.adoTblLostCardCalcFields(DataSet: TDataSet);
begin
  adoTblLostCard.FieldByName('FamilyName').AsString := GetFamilyName(adoTblLostCard.FieldByName('lost_EmplNo').AsString);
  adoTblLostCard.FieldByName('Removed').AsBoolean := (adoTblLostCard.FieldByName('Lost_RemoveDate').AsString <> '');
end;

procedure TfrmLostCard.N1Click(Sender: TObject);
begin
  if (adoTblLostCard.RecordCount <= 0) then
    exit;
//  if adoTblLostCard.FieldByName('Lost_RemoveDate').AsString <> '' then
//  begin
//    InformationMessage('ò«— Â«Ì »«ÿ· ‘œÂ ﬁ«»· Õ–› ‰Ì” ‰œ .');
//    exit;
//  end;
  if ConfirmMessage('¬Ì« »—«Ì Õ–› «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    adoTblLostCard.Delete;
    updateCount;
  end;
end;

procedure TfrmLostCard.rdoViewClick(Sender: TObject);
begin
  with adoTblLostCard do
  begin
    Filtered := false;
    case rdoView.ItemIndex of
      0 : Filter := '';
      1 : Filter := 'Lost_RemoveDate = ''''';
      2 : Filter := 'Lost_RemoveDate <> ''''';
    end;
    Filtered := True;
  end;
end;

procedure TfrmLostCard.BitBtn3Click(Sender: TObject);
var
  code : string;
  empl : TEmployee;
begin
  code := FixLeft(cmbEmplCode.Text,'0',8);
  if cmbEmplCode.Text = '' then
    exit;
  empl := GetEmployee(code , false);
  if (empl.EmplID <> '') then
  begin
    with adoTblLostCard do
      if not Locate('lost_EmplNo;lost_Date' , VarArrayOf([code,txtDate.Text]) , [loCaseInsensitive]) then
      begin
        Append;
        FieldByName('lost_EmplNo').AsString := code;
        FieldByName('lost_Date').AsString := txtDate.Text;
        FieldByName('lost_EmplID').AsString := empl.EmplID;
        Post;
      end
      else
        InformationMessage('—òÊ—œ „Ê—œ ‰Ÿ— ÊÃÊœ œ«—œ .');
  end
  else
  begin
    ErrorMessage('.›—œ „Ê—œ ‰Ÿ— ›«ﬁœ ‘„«—Â ò«—  „Ì»«‘œ ');
  end;
  cmbEmplCode.SetFocus;
  updateCount;
end;


procedure TfrmLostCard.btnDeleteClick(Sender: TObject);
begin
  N1Click(self);
end;

procedure TfrmLostCard.updateCount;
begin
  lblCount.Caption := ' ⁄œ«œ :' + IntToStr(adoTblLostCard.RecordCount);
end;

procedure TfrmLostCard.grdDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  updateCount;
end;


procedure TfrmLostCard.grdTitleClick(Column: TColumn);
var
  ASC_Sort: string;
  DESC_Sort: string;
begin
  ASC_Sort := Column.FieldName + ' ASC';
  DESC_Sort := Column.FieldName + ' DESC';
  if adoTblLostCard.Sort = ASC_Sort then
    adoTblLostCard.Sort := DESC_Sort
  else
    adoTblLostCard.Sort := ASC_Sort;
end;

procedure TfrmLostCard.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmLostCard.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

end.



