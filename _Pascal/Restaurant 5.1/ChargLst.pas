unit ChargLst;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls,xpman, Mask, ComCtrls,
  DB, ADODB, DosMove;

type
  TfrmchargLst = class(TForm)
    Pan_dbg: TPanel;
    adoQrycharge: TADOQuery;
    DosMove1: TDosMove;
    dtaCharge: TDataSource;
    d: TDBGrid;
    pan_con: TPanel;
    btnnewd: TBitBtn;
    btn_del: TBitBtn;
    adoQrychargech_Date: TWideStringField;
    adoQrychargech_time: TIntegerField;
    adoQrychargech_barcode: TWideStringField;
    adoQrychargetime: TStringField;
    cmdClose: TBitBtn;
    adoQrychargech_User: TWideStringField;
    adoQrychargech_Price: TBCDField;
    grpAll: TGroupBox;
    Label6: TLabel;
    Label9: TLabel;
    txtSrchDate: TEdit;
    txtSrchPCode: TEdit;
    adoQrychargeFamilyName: TWideStringField;
    cmbSort: TComboBox;
    lbl06: TLabel;
    cmbSort2: TComboBox;
    procedure adoQrychargeCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure btnnewdClick(Sender: TObject);
    procedure txtSrchDateExit(Sender: TObject);
    procedure txtSrchDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmbSortChange(Sender: TObject);
  

  private
    { Private declarations }
      procedure checkpan(fl:integer);

  public

    { Public declarations }

  end;

var
  frmchargLst: TfrmchargLst;


implementation

uses ADODB_TLB, ADOX_TLB, Code_Sys, ComTools, DateProc, Farsiapi,
  FntSel, Funcs, Keyboard, Login, Msgs, 
  TimeTool,charge, DBS_Proc;


{$R *.dfm}

procedure TfrmchargLst.btnnewdClick(Sender: TObject);
var frmcharge: Tfrmcharge ;
begin
  Application.CreateForm(Tfrmcharge , frmcharge );
  frmcharge.ShowModal;
  frmcharge.Free;
  adoQrycharge.Requery([]);
end;

procedure TfrmchargLst.btn_delClick(Sender: TObject);
var
  atbl : TADOTable;
  aqryDel : TADOQuery;
begin
  if (adoQrycharge.RecordCount > 0) and ConfirmMessage('آيا براي حذف اطمينان داريد؟') then
  begin
    atbl := TADOTable.Create(Application);
    aqryDel := TADOQuery.Create(Application);
    aqryDel.SQL.Clear;
    aqryDel.sql.Add('delete from charge where ch_date = ''' + adoQrycharge.FieldByName('ch_date').AsString +
                                      ''' and ch_time = ' + adoQrycharge.FieldByName('ch_time').AsString+
                                      '   and ch_barcode = ''' + adoQrycharge.FieldByName('ch_barcode').AsString + '''');
    atbl.Connection := frmDBS.DBConnection;
    aqryDel.Connection := frmDBS.DBConnection;
    atbl.TableName := 'persons';
    atbl.Open;
    if atbl.Locate('p_Barcode',adoQrycharge.FieldByName('ch_Barcode').AsString,[loPartialKey]) then
    begin
      if atbl.FieldByName('p_credit').AsCurrency >= adoQrycharge.FieldByName('ch_price').AsCurrency then
      begin
//**********************these operation handled with Triggers*************************************************
//        atbl.Edit;
//        atbl.FieldByName('p_credit').AsCurrency := atbl.FieldByName('p_credit').AsCurrency - adoQrycharge.FieldByName('ch_Price').AsCurrency;
//        atbl.Post;
//**********************these operation handled with Triggers*************************************************
        aQryDel.ExecSQL;
      end
      else
        ErrorMessage('از اين اعتبار استفاده شده است و امکان حذف آن از سيستم وجود ندارد .');
    end
    else
    begin
      aQryDel.ExecSQL;
      ErrorMessage('فرد مورد نظر در ليست پرسنل وجود ندارد !');
    end;
    adoQrycharge.Requery;
 end;
end;




procedure TfrmchargLst.checkpan(fl:integer);
begin

end;


procedure TfrmchargLst.cmbSortChange(Sender: TObject);
begin
  if cmbSort2.ItemIndex = 0 then
  begin
    case cmbSort.ItemIndex of
      0:adoQrycharge.Sort := 'ch_Date ASC, ch_time ASC';
      1:adoQrycharge.Sort := 'FamilyName ASC';
      2:adoQrycharge.Sort := 'ch_barcode ASC';
      3:adoQrycharge.Sort := 'ch_Price ASC';
      4:adoQrycharge.Sort := 'ch_User ASC';
    end;
  end
  else
  begin
    case cmbSort.ItemIndex of
      0:adoQrycharge.Sort := 'ch_Date DESC, ch_time DESC';
      1:adoQrycharge.Sort := 'FamilyName DESC';
      2:adoQrycharge.Sort := 'ch_barcode DESC';
      3:adoQrycharge.Sort := 'ch_Price DESC';
      4:adoQrycharge.Sort := 'ch_User DESC';
    end;
  end;
end;

procedure TfrmchargLst.FormCreate(Sender: TObject);
begin
  adoQrycharge.Connection := frmDBS.DBConnection;
  with adoQrycharge do
  begin
    SQL.Clear;
    close;
    SQL.Add('SELECT Charge.*,FamilyName = persons.p_family + '' - '' + persons.p_name  FROM Charge,persons');
    SQL.Add('where ch_barcode = p_barcode');
    SQL.Add('order by ch_date, ch_Time');

    Open ;
  end;
  cmbSort.ItemIndex := 0;
  cmbSort2.ItemIndex := 0;
end;

procedure TfrmchargLst.txtSrchDateExit(Sender: TObject);
begin
  txtSrchDate.Text := BeautifulDate(txtSrchDate.Text);
  with adoQrycharge do
  begin
    filtered := false;
    Filter := '';
    if (txtSrchDate.Text <> '//') and(txtSrchDate.Text <> '') then
      Filter := 'ch_date = ' + txtSrchDate.Text;
    if txtSrchPCode.Text <> '' then
    begin
      if filter <> '' then
        filter := filter + ' and ';
      Filter := Filter + ' ch_barcode = ' + FixLeft(txtSrchPCode.Text,'0',8);
    end;

    filtered := true;
  end;
end;

procedure TfrmchargLst.txtSrchDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtSrchPCode.SetFocus
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmchargLst.adoQrychargeCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('ch_Time').AsString <> '' then
     DataSet.FieldByName('time').AsString  :=inttotime(strtoint(DataSet.FieldByName('ch_Time').AsString ));
end;

end.
