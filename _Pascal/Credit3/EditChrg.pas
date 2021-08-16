unit EditChrg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, StdCtrls, ADODB, Buttons, DosMove, ComCtrls,
  ExtCtrls, DBCtrls, Menus, Mask;

type
  TfrmEditCharge = class(TForm)
    dtaCharge: TDataSource;
    grpEdit: TGroupBox;
    atblCharge: TADOTable;
    DosMove1: TDosMove;
    lbl3: TLabel;
    txtCharge: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    atblChargeCharge_Date: TWideStringField;
    atblChargeCharge_EmplNo: TWideStringField;
    atblChargeCharge_Price: TBCDField;
    atblChargeFamilyName: TStringField;
    atblChargeCharge_ExpireDate: TWideStringField;
    txtExpDate: TEdit;
    Label1: TLabel;
    atblChargeCharge_Time: TWideStringField;
    atblChargeCharge_Moved: TBooleanField;
    atblChargeMoved: TStringField;
    atblChargeTime: TStringField;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Edit1: TEdit;
    txtdate: TEdit;
    Pagefind: TPageControl;
    TabSheet1: TTabSheet;
    grpAll: TGroupBox;
    lbl2: TLabel;
    lbl1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    TabSheet2: TTabSheet;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    cmdClose: TBitBtn;
    cmdHelp: TBitBtn;
    dbgCharge: TDBGrid;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    cmbCardName: TComboBox;
    Edit4: TEdit;
    cmbCardCode: TComboBox;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    ADOQuery2: TADOQuery;
    DataSource2: TDataSource;
    ADOQuery3: TADOQuery;
    DataSource3: TDataSource;
    ADOQuery1familyname: TStringField;
    ADOQuery1Empl_ID: TWideStringField;
    ADOQuery1Dtlmoved: TBooleanField;
    ADOQuery1DtlCode: TIntegerField;
    ADOQuery1Empl_Name: TWideStringField;
    ADOQuery1Empl_Family: TWideStringField;
    ADOQuery1Empl_No: TWideStringField;
    ADOQuery1active: TStringField;
    cmbcode: TDBLookupComboBox;
    cmbname: TDBLookupComboBox;
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
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    cmbcode1: TComboBox;
    cmbname1: TComboBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    qryupdate: TADOQuery;
    DataSource6: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    BitBtn3: TBitBtn;
    N3: TMenuItem;
    N4: TMenuItem;
    grpChangeGrp: TGroupBox;
    Label7: TLabel;
    btnChangeGrp: TBitBtn;
    cmbNewGrp: TComboBox;
    ADOQuery1GRPPRICE: TBCDField;
    SpeedButton3: TSpeedButton;
    BitBtn4: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure btnChangeGrpClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure cmbnameClick(Sender: TObject);
    procedure cmbcodeClick(Sender: TObject);
    procedure ADOTable2CalcFields(DataSet: TDataSet);
    procedure ADOTable1CalcFields(DataSet: TDataSet);
    procedure ADOQuery1CalcFields(DataSet: TDataSet);
    procedure cmbcode1Click(Sender: TObject);
    procedure cmbCardNameChange(Sender: TObject);
    procedure cmbname1Change(Sender: TObject);
    procedure PagefindChange(Sender: TObject);
    procedure cmbcode1Change(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure cmbCardCodeChange(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure atblChargeCalcFields(DataSet: TDataSet);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure cmbCardCodeClick(Sender: TObject);
    procedure cmbCardCodeExit(Sender: TObject);
    procedure dbgChargeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure txtChargeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCardNameKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
    procedure findd;
    procedure SetWinF;
    procedure FormInEdit(edt : Boolean);
    procedure FilterData;
    procedure  FillCombo;
    procedure   fillfindcombo;
    procedure  updatecharge(flag:Boolean);
    procedure  DeleteCharge;
    procedure  EditMode(stat : boolean);
  public
    { Public declarations }
    procedure  fillgrid;    
  end;


var
  frmEditCharge: TfrmEditCharge;


implementation

uses
  Funcs, DBS, Globals, TimeTool, Keyboard, DateProc, MSGs, FntSel;

{$R *.dfm}
 procedure TfrmEditCharge.fillgrid;
 begin
       ADOQuery1.sql.Clear;
       ADOQuery1.Close;
       ADOQuery1.SQL.Add('SELECT Employee.Empl_ID, ChargeDtl.Dtlmoved, ChargeDtl.DtlCode, Employee.Empl_Name, Employee.Empl_Family, Employee.Empl_No ,ChargeGrp.grpprice'+
      ' FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode where Employee.Empl_No = '+ ''''+ cmbcode.Text + ''''   +' ORDER BY ChargeDtl.DtlCode');

       ADOQuery1.Open;
 end;


 procedure TfrmEditCharge.findd;
var s,d,f:string;
begin

    f:=cmbCardCode.Text+'%';
    ADOQuery1.SQL.Clear;
    ADOQuery1.Close;
    ADOQuery1.sql.Add(' SELECT Employee.Empl_ID, ChargeDtl.Dtlmoved, ChargeDtl.DtlCode, Employee.Empl_Name, Employee.Empl_Family, Employee.Empl_No ,ChargeGrp.grpprice'+
    'FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode where ChargeDtl.DtlCode = '+ComboBox1.Text +' and  Employee.Empl_No like '+'''' +  f + ''''  );
    ADOQuery1.Open;

        begin
 if ADOQuery1.FieldByName('Empl_Name').AsString <> '' then
        cmbCardName.text:=ADOQuery1.FieldByName('Empl_Family').AsString + '-' +
                             ADOQuery1. FieldByName('Empl_Name').AsString ;

        cmbCardName.Text:= ADOQuery1.FieldByName('Empl_Family').AsString + '-' +
                             ADOQuery1. FieldByName('Empl_Name').AsString ;
         end;
end;
procedure TfrmEditCharge.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmEditCharge));

  Caption := (Caption);
  grpAll.Caption := (grpAll.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  for i := 0 to dbgCharge.Columns.Count-1 do
    dbgCharge.Columns[i].Title.Caption := (dbgCharge.Columns[i].Title.Caption);

  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);

  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmEditCharge.SpeedButton1Click(Sender: TObject);
begin
FillCombo;

end;

procedure TfrmEditCharge.SpeedButton3Click(Sender: TObject);
begin
  EditMode(false);	
end;

procedure TfrmEditCharge.FormInEdit(edt : Boolean);
begin
  grpAll.Enabled := not edt;
  grpEdit.Enabled := edt;
  if edt then
    Height := grpAll.Height + grpEdit.Height + 25
  else
    Height := grpAll.Height + 25;
end;

procedure TfrmEditCharge.N1Click(Sender: TObject);
begin
updatecharge(true); 
end;

procedure TfrmEditCharge.N2Click(Sender: TObject);
begin
updatecharge(false);
end;

procedure TfrmEditCharge.N4Click(Sender: TObject);
begin
  EditMode(true);
end;

procedure TfrmEditCharge.PagefindChange(Sender: TObject);
begin
  if Pagefind.TabIndex=0 then
  begin
    if ComboBox1.Text <> ''  then
      begin
      FillCombo;
     
      end;
  end;
  if Pagefind.TabIndex=1 then
  begin
     fillgrid;
   { if cmbCode.Items.Count > 0 then
    begin
      cmbCode.ItemIndex := 0;
      cmbName.ItemIndex := 0;
    end;}

//    ADOQuery1.sql.Clear;
//    ADOQuery1.Close;
//    ADOQuery1.SQL.Add('SELECT Employee.Empl_ID, ChargeDtl.Dtlmoved, ChargeDtl.DtlCode, Employee.Empl_Name, Employee.Empl_Family, Employee.Empl_No '+
//    ' FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode where Employee.Empl_No = '+ ''''+ cmbcode.Text + ''''  );
//    ADOQuery1.Open;
  end;
end;

procedure TfrmEditCharge.fillfindcombo ;
begin
  ADOQuery2.SQL.Clear;
  ADOQuery2.Close;
  ADOQuery2.sql.Add('select * from Employee where Empl_No= '+ ''''+ cmbcode.Text + ''' and Empl_Active = ' + IntToStr(MB_TRUE));
  ADOQuery2.Open;
//  if ADOQuery2.FieldByName('Empl_Name').AsString <> '' then
//    cmbName.text:=ADOQuery2.FieldByName('Empl_Family').AsString + '-' + ADOQuery2. FieldByName('Empl_Name').AsString;
//  cmbName.Text:= ADOQuery2.FieldByName('Empl_Family').AsString + '-' +  ADOQuery2. FieldByName('Empl_Name').AsString ;
end;

procedure TfrmEditCharge.FillCombo ;
var s:string;
begin
  s:=combobox1.text;
  if ComboBox1.Text = ''  then
  begin
    s :='00213012230342302303402303425' ;
  end;
  ADOQuery1.SQL.Clear;
  ADOQuery1.Close;
  ADOQuery1.sql.Add('SELECT Employee.Empl_ID, ChargeDtl.Dtlmoved, ChargeDtl.DtlCode, Employee.Empl_Name, Employee.Empl_Family, Employee.Empl_No ,ChargeGrp.grpprice' +
  ' FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode  where  ChargeDtl.DtlCode= ' + s +' ORDER BY ChargeDtl.DtlCode'    );
  ADOQuery1.Open;

  cmbCardCode.Clear ;
  cmbCardName.Clear ;
  ADOQuery1.First;
  cmbCardCode.Text :=  (ADOQuery1.FieldByName('Empl_No').AsString);
  cmbCardName.Text:= ADOQuery1.FieldByName('Empl_Family').AsString + '-' + ADOQuery1. FieldByName('Empl_Name').AsString ;
  while not ADOQuery1.Eof   do
  begin
    cmbCardCode.Items.Add(ADOQuery1.FieldByName('Empl_No').AsString);
    cmbCardName.items.add (ADOQuery1.FieldByName('Empl_Family').AsString + '-' + ADOQuery1. FieldByName('Empl_Name').AsString);
    ADOQuery1.Next;
  end;
end;
procedure TfrmEditCharge.FilterData;
var s : String;
begin
  s := '';

  if txtDate.Text <> '' then
    s := s + 'Charge_Date = ''' + txtDate.Text + '''';
  if cmbCardCode.Text <> '' then

  begin
    if s <> '' then s := s + ' AND ';
    s := s + 'Charge_EmplNo = ''' + cmbCardCode.Text + '''';
  end;

  atblCharge.Filtered := False;
  atblCharge.Filter := s;
  atblCharge.Filtered := True;
end;



procedure TfrmEditCharge.FormCreate(Sender: TObject);
var f:string;
begin
  ADOTable1.Connection:=frmDBS.adoConnect;
  ADOTable2.Connection:=frmDBS.adoConnect;
  ADOTable1.Open;
  ADOTable2.Open;
  SetWinF;
  SetFontColor(TForm(frmEditCharge  ));
  ADOQuery2.Connection := frmDBS.adoConnect;
  ADOQuery1.Connection := frmDBS.adoConnect ;
  ADOQuery3.Connection := frmDBS.adoConnect ;
  Pagefind.TabIndex:=0;
  EditMode(false);
 //FormInEdit(False);
  {
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee');
    SQL.Add('WHERE Empl_Active <> ' + IntToStr(MB_FALSE));
    if gOptions.UserDepart <> 0 then
      SQL.Add('AND Empl_Department = ' + IntToStr(gOptions.UserDepart));

    SQL.Add('ORDER BY Empl_Family, Empl_Name');
    Open;
    while not Eof do
    begin
      cmbCardCode.Items.Add(FieldByName('Empl_No').AsString);
      if FieldByName('Empl_Name').AsString <> '' then
        cmbCardName.Items.Add(FieldByName('Empl_Family').AsString + '-' +
                              FieldByName('Empl_Name').AsString)
      else
        cmbCardName.Items.Add(FieldByName('Empl_Family').AsString);
      Next;
    end;
    Close;
  end;

  atblCharge.Connection := frmDBS.adoConnect;
  atblCharge.Open;

  FilterData;  }
end;


procedure TfrmEditCharge.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//  atblCharge.Close;
end;

procedure TfrmEditCharge.ADOQuery1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('FamilyName').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;



  with DataSet do
  begin
    if FieldByName('DtlMoved').AsBoolean then
      FieldByName('active').Asstring  := ('»·Ì')
    else
     FieldByName('active').Asstring   := ('ŒÌ—');
end;


end;



procedure TfrmEditCharge.ADOTable1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmEditCharge.ADOTable2CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmEditCharge.atblChargeCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('FamilyName').AsString := GetFamilyName(DataSet.FieldByName('Charge_EmplNo').AsString);
  DataSet.FieldByName('Time').AsString := IntToTime(DataSet.FieldByName('Charge_time').AsInteger);
  if DataSet.FieldByName('Charge_Moved').AsBoolean then
    DataSet.FieldByName('Moved').AsString := '»·Ì'
  else
    DataSet.FieldByName('Moved').AsString := 'ŒÌ—';
end;

procedure TfrmEditCharge.BitBtn3Click(Sender: TObject);
begin
  EditMode(true);
end;

procedure TfrmEditCharge.BitBtn4Click(Sender: TObject);
begin
  if ConfirmMessage('¬Ì« »—«Ì Õ–› «ÿ„Ì‰«‰ œ«—Ìœø') then
    DeleteCharge;
end;

procedure TfrmEditCharge.btnChangeGrpClick(Sender: TObject);
begin
  qryupdate.Connection:=frmDBS.adoConnect;
  with qryupdate  do
  begin
    close;
    sql.Clear ;
    sql.Add('select * from chargedtl where dtlcode = ' + cmbnewGrp.text + ' and dtlemplno = ''' + ADOQuery1.FieldByName('empl_no').AsString  +'''');
    open;
    first;
    if eof then
    begin
      close;
      sql.Clear ;
      sql.Add('update chargedtl set dtlCode= '+ cmbnewGrp.text);
      sql.add(' where DTLCODE = ' + inttostr(ADOQuery1.FieldByName('DtlCode').asinteger));
      sql.Add(' and DTLEMPLNO = '+ ''''+ADOQuery1.FieldByName('empl_no').AsString  +'''');
      ExecSQL;
      ADOQuery1.Close;
      ADOQuery1.Open;
    end
    else
      ErrorMessage('«Ì‰ ›—œ œ— œÊ—Â ‘«—é «‰ Œ«» ‘œÂ ÊÃÊœ œ«—œ .');
  end;
  EditMode(false);
end;

procedure TfrmEditCharge.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmEditCharge.updatecharge(flag:Boolean);
var r:integer;
begin
  qryupdate.Connection:=frmDBS.adoConnect;
  with qryupdate  do
  begin
    close;
    sql.Clear ;
    sql.Add('update chargedtl set dtlmoved='+ BoolToStr(flag) );
    sql.add(' where DTLCODE='+inttostr(ADOQuery1.FieldByName('DtlCode').asinteger));
    sql.Add(' and DTLEMPLNO='+ ''''+ADOQuery1.FieldByName('empl_no').AsString  +'''');
    ExecSQL;
    r:=ADOQuery1.RecNo;
    ADOQuery1.Close;
    ADOQuery1.Open;
    ADOQuery1.RecNo:=r;
  end;
end;

procedure TfrmEditCharge.DeleteCharge;
var r:integer;
begin
  qryupdate.Connection:=frmDBS.adoConnect;
  with qryupdate  do
  begin
  close;
  sql.Clear ;
  sql.Add('delete from chargeDtl' );
  sql.add(' where DTLCODE='+inttostr(ADOQuery1.FieldByName('DtlCode').asinteger));
  sql.Add(' and DTLEMPLNO='+ ''''+ADOQuery1.FieldByName('empl_no').AsString  +'''');
  ExecSQL;
  r:=ADOQuery1.RecNo;
  ADOQuery1.Close;
  ADOQuery1.Open;
  ADOQuery1.RecNo:=r;
end;

end;

procedure TfrmEditCharge.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
  FilterData;
end;

procedure TfrmEditCharge.cmbCardCodeChange(Sender: TObject);
begin
try
 findd;
except
ErrorMessage('·ÿ›« œÊ—Â —« «‰ Œ«» ﬂ‰Ìœ');
ComboBox1.SetFocus;  
end;
 end;

procedure TfrmEditCharge.cmbCardCodeClick(Sender: TObject);
begin
  cmbCardName.ItemIndex := cmbCardCode.ItemIndex;
  FilterData;
 
end;

procedure TfrmEditCharge.cmbCardCodeExit(Sender: TObject);
begin
  if (cmbCardCode.Text <> '') and (cmbCardCode.ItemIndex = -1) then
    cmbCardCode.ItemIndex := cmbCardCode.Items.IndexOf(cmbCardCode.Text);

  if cmbCardName.ItemIndex <> cmbCardCode.ItemIndex then
  begin
    cmbCardName.ItemIndex := cmbCardCode.ItemIndex;
    FilterData;
  end;
end;

procedure TfrmEditCharge.dbgChargeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    cmdEditClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender);
end;

procedure TfrmEditCharge.Edit1Change(Sender: TObject);
begin
{ADOQuery1.SQL.Clear;
ADOQuery1.Close;
ADOQuery1.sql.Add('SELECT Employee.Empl_ID, ChargeDtl.Dtlmoved, ChargeDtl.DtlCode, Employee.Empl_Name, Employee.Empl_Family, Employee.Empl_No ' +
' FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode  where ChargeDtl.DtlCode ='+ Edit1.Text   );
ADOQuery1.Open;

  ADOQuery1.First;
while not ADOQuery1.Eof   do
   begin
 cmbCardCode.Items.Add(ADOQuery1.FieldByName('Empl_No').AsString);
  ADOQuery1.Next;
   end; }
   FillCombo;

end;

procedure TfrmEditCharge.Edit2Change(Sender: TObject);
begin
findd;
end;

procedure TfrmEditCharge.Edit3Change(Sender: TObject);
begin
findd;
end;

procedure TfrmEditCharge.Edit4Change(Sender: TObject);
begin
  findd ;
end;

procedure TfrmEditCharge.EditMode(stat: boolean);
var   qry :  TADOQuery;
begin
  qry := TADOQuery.Create(self);
  qry.Connection := frmDBS.adoConnect;
  with qry  do
  begin
    close;
    sql.Clear ;
    sql.Add('select * from chargeGrp order by grpCode');
    open;
    first;
    cmbNewGrp.Clear;
    while not eof do
    begin
      cmbNewGrp.Items.Add(FieldByName('grpCode').AsString);
      Next;
    end;
    close;
    free;
  end;
  grpChangeGrp.Visible := stat;
  Panel1.Enabled := not stat;
  TabSheet1.Enabled := not stat;
end;

procedure TfrmEditCharge.cmdEditClick(Sender: TObject);
begin
{  if atblCharge.RecordCount > 0 then
  begin
    txtCharge.Text := FloatToStr(atblCharge.FieldByName('Charge_Price').AsCurrency);
    txtExpDate.Text := atblCharge.FieldByName('Charge_ExpireDate').AsString;
    FormInEdit(True);
    txtCharge.SetFocus;
  end;  }
end;

procedure TfrmEditCharge.cmdDeleteClick(Sender: TObject);
var
  p : Currency;
  emplNo : String;
begin
  with atblCharge do
    if (RecordCount > 0) and ConfirmMessage('¬Ì« »«Ì Õ–› «⁄ »«— «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      emplNo := FieldByName('Charge_EmplNo').AsString;
      p := -FieldByName('Charge_Price').AsCurrency;
      if GetCreditCardPrice(emplNo) >= -p then
      begin
        Delete;
      end
      else
        ErrorMessage('Õ–› «⁄ »«— „ÊÃ» „‰›Ì ‘œ‰ „ÊÃÊœÌ „Ìùê—œœ.');
    end;
end;

procedure TfrmEditCharge.cmdSaveClick(Sender: TObject);
var
  p : Currency;
  bmark : TBookMark;
begin
  if txtCharge.Text = '' then
  begin
    ErrorMessage('„»·€ ‘«—é „‘Œ’ ‰‘œÂ «” .');
    txtCharge.SetFocus;
  end
  else
  begin
    p := StrToFloat(txtCharge.Text) - atblCharge.FieldByName('Charge_Price').AsCurrency;
    if (GetCreditCardPrice(atblCharge.FieldByName('Charge_EmplNo').AsString) + p) < 0 then
    begin
      ErrorMessage(' €ÌÌ— „»·€ ‘«—é »«⁄À „‰›Ì ‘œ‰ „«‰œÂ «⁄ »«— ﬂ«—  ŒÊ«Âœ ‘œ.');
      txtCharge.SetFocus;
    end
    else
    begin
      atblCharge.Edit;
      atblCharge.FieldByName('Charge_Price').AsCurrency := StrToFloat(txtCharge.Text);
      atblCharge.FieldByName('Charge_ExpireDate').AsString := txtExpDate.Text;
      atblCharge.FieldByName('Charge_Date').AsString := CurrentDate;
      atblCharge.Post;

      bmark := atblCharge.GetBookmark;
      atblCharge.Close;
      atblCharge.Open;
      atblCharge.GotoBookmark(bmark);
      atblCharge.FreeBookmark(bmark);

      FormInEdit(False);
      dbgCharge.SetFocus;
    end;
  end;
end;

procedure TfrmEditCharge.ComboBox1Click(Sender: TObject);
begin
FillCombo;
//findd;
end;

procedure TfrmEditCharge.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCharge.SetFocus;
end;

procedure TfrmEditCharge.txtChargeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmEditCharge.cmbCardNameChange(Sender: TObject);
begin
try
 cmbCardCode.ItemIndex:=cmbCardName.ItemIndex ;
 findd;
except
 ErrorMessage('·ÿ›« œÊ—Â —« «‰ Œ«» ﬂ‰Ìœ');
 ComboBox1.SetFocus;
end;

 end;

procedure TfrmEditCharge.cmbCardNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_XP(Key);
end;

procedure TfrmEditCharge.cmbcode1Change(Sender: TObject);
begin

  fillgrid;
               
end;

procedure TfrmEditCharge.cmbcode1Click(Sender: TObject);
begin
fillfindcombo;
end;

procedure TfrmEditCharge.cmbcodeClick(Sender: TObject);
begin
 fillgrid;
end;

procedure TfrmEditCharge.cmbname1Change(Sender: TObject);
begin
//cmbcode.ItemIndex :=cmbname.ItemIndex ;
 fillgrid; 
end;

procedure TfrmEditCharge.cmbnameClick(Sender: TObject);
begin
 fillgrid;
end;

end.
