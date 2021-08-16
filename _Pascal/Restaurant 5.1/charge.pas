unit charge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, ADODB, DBCtrls, DosMove,Keyboard,DateProc,
  ComCtrls, Buttons,TimeTool, slctPart;

type
  Tfrmcharge = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DosMove1: TDosMove;
    ADOTable1: TADOTable;
    ADOTable2: TADOTable;
    ADOTable1P_BarCode: TWideStringField;
    ADOTable1P_Proxi: TWideStringField;
    ADOTable1P_Name: TWideStringField;
    ADOTable1P_Family: TWideStringField;
    ADOTable1P_Parts: TWideStringField;
    ADOTable1P_JobCode: TSmallintField;
    ADOTable1P_IsValid: TBooleanField;
    ADOTable1P_ValidTest: TBooleanField;
    ADOTable1P_Pricable: TBooleanField;
    ADOTable1P_Sobhaneh: TBooleanField;
    ADOTable1P_Nahar: TBooleanField;
    ADOTable1P_Sham: TBooleanField;
    ADOTable1P_Rejim: TBooleanField;
    ADOTable1P_IsGuest: TBooleanField;
    ADOTable1P_Special: TSmallintField;
    ADOTable1P_ManyFish: TSmallintField;
    ADOTable1P_EtebarFish: TWideStringField;
    ADOTable1P_DblFood: TBooleanField;
    ADOTable1P_CashType: TSmallintField;
    ADOTable1P_DeserNoFood: TBooleanField;
    ADOTable1P_Building: TSmallintField;
    ADOTable1P_Sex: TSmallintField;
    ADOTable1p_prepaid: TBooleanField;
    ADOTable2P_BarCode: TWideStringField;
    ADOTable2P_Proxi: TWideStringField;
    ADOTable2P_Name: TWideStringField;
    ADOTable2P_Family: TWideStringField;
    ADOTable2P_Parts: TWideStringField;
    ADOTable2P_JobCode: TSmallintField;
    ADOTable2P_shiftGroup: TSmallintField;
    ADOTable2P_IsValid: TBooleanField;
    ADOTable2P_ValidTest: TBooleanField;
    ADOTable2P_Pricable: TBooleanField;
    ADOTable2P_Sobhaneh: TBooleanField;
    ADOTable2P_Nahar: TBooleanField;
    ADOTable2P_Sham: TBooleanField;
    ADOTable2P_Rejim: TBooleanField;
    ADOTable2P_IsGuest: TBooleanField;
    ADOTable2P_Special: TSmallintField;
    ADOTable2P_ManyFish: TSmallintField;
    ADOTable2P_EtebarFish: TWideStringField;
    ADOTable2P_DblFood: TBooleanField;
    ADOTable2P_CashType: TSmallintField;
    ADOTable2P_DeserNoFood: TBooleanField;
    ADOTable2P_Building: TSmallintField;
    ADOTable2P_Sex: TSmallintField;
    ADOTable2p_prepaid: TBooleanField;
    ADOTable1te: TStringField;
    ADOTable2te: TStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    txt_time: TEdit;
    txt_date: TEdit;
    txt_price: TEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    cmbCardType: TRadioGroup;
    lbl1: TLabel;
    cmbEmplCode: TDBLookupComboBox;
    cmbEmplName: TDBLookupComboBox;
    ADOTable1P_ShiftGroup: TSmallintField;
    ADOTable2P_Credit: TBCDField;
    ADOTable1P_Credit: TBCDField;
    lblParts: TLabel;
    txtParts: TEdit;
    BitBtnParts: TBitBtn;
    lblBarCode: TLabel;
    cmbPCode: TComboBox;
    lblFamily: TLabel;
    cmbFamilyName: TComboBox;
    procedure cmbCardTypeClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure ADOTable2CalcFields(DataSet: TDataSet);
    procedure ADOTable1CalcFields(DataSet: TDataSet);
    procedure txt_priceKeyPress(Sender: TObject; var Key: Char);
    procedure txt_dateKeyPress(Sender: TObject; var Key: Char);
    procedure txt_timeKeyPress(Sender: TObject; var Key: Char);
    procedure txt_timeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txt_dateExit(Sender: TObject);
    procedure BitBtnPartsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbPCodeExit(Sender: TObject);
    procedure cmbPCodeClick(Sender: TObject);
    procedure cmbPCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFamilyNameClick(Sender: TObject);
    procedure cmbFamilyNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFamilyNameExit(Sender: TObject);
//    procedure ChargPersons(code:string);
  private
  public
    { Public declarations }
    partcode:string;
  end;


implementation
   uses MSGs,DBS_Proc,globals;

{$R *.dfm}
procedure Tfrmcharge.cmbCardTypeClick(Sender: TObject);
begin
  if cmbCardType.ItemIndex = 0 then
  begin
//    ADOTable1.close;
//    ADOTable2.close;
    txtParts.Enabled := False;
    BitBtnParts.Enabled := False;
    lblParts.Enabled := False;
    lblBarCode.Enabled := False;
    cmbPCode.Enabled := False;
    lblFamily.Enabled := False;
    cmbFamilyName.Enabled := False;
  end
  else if cmbCardType.ItemIndex = 1 then
  begin
//    ADOTable1.Open;
//    ADOTable2.Open;
//    ADOTable1.Sort := 'P_BarCode';
//    ADOTable2.Sort := 'P_BarCode';
    lblBarCode.Enabled := True;
    cmbPCode.Enabled := True;
    lblFamily.Enabled := True;
    cmbFamilyName.Enabled := True;
    txtParts.Enabled := False;
    BitBtnParts.Enabled := False;
    lblParts.Enabled := False;
  end
  else if cmbCardType.ItemIndex = 2 then
  begin
//    ADOTable1.close;
//    ADOTable2.close;
    txtParts.Enabled := True;
    BitBtnParts.Enabled := True;
    lblParts.Enabled := True;
    lblBarCode.Enabled := False;
    cmbPCode.Enabled := False;
    lblFamily.Enabled := False;
    cmbFamilyName.Enabled := False;
  end;
end;

procedure Tfrmcharge.cmbFamilyNameClick(Sender: TObject);
begin
  cmbPCode.ItemIndex := cmbFamilyName.ItemIndex;
end;

procedure Tfrmcharge.cmbFamilyNameExit(Sender: TObject);
begin
  if cmbFamilyName.Text <> '' then
  begin
    if cmbFamilyName.Items.IndexOf(cmbFamilyName.Text) < 0 then
    begin
      ErrorMessage('نام موجود نمیباشد.');
      cmbFamilyName.SetFocus;
    end
    else
    begin
      cmbFamilyName.ItemIndex := cmbFamilyName.Items.IndexOf(cmbFamilyName.Text);
      cmbPCode.ItemIndex := cmbFamilyName.ItemIndex;
    end;
  end;
end;

procedure Tfrmcharge.cmbFamilyNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnOK.SetFocus;
  end;
end;

procedure Tfrmcharge.cmbPCodeClick(Sender: TObject);
begin
  cmbFamilyName.ItemIndex := cmbPCode.ItemIndex;
end;

procedure Tfrmcharge.cmbPCodeExit(Sender: TObject);
begin
  if cmbPCode.Text <> '' then
  begin
    if cmbPCode.Items.IndexOf(cmbPCode.Text) < 0 then
    begin
      ErrorMessage('شماره پرسنلی موجود نمیباشد.');
      cmbPCode.SetFocus;
    end
    else
    begin
      cmbPCode.ItemIndex := cmbPCode.Items.IndexOf(cmbPCode.Text);
      cmbFamilyName.ItemIndex := cmbPCode.ItemIndex;
    end;
  end;
end;

procedure Tfrmcharge.cmbPCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnOK.SetFocus;
  end;
  Keyboard_Integer(Key);
end;

procedure Tfrmcharge.ADOTable1CalcFields(DataSet: TDataSet);
begin
DataSet.FieldByName('te').AsString := DataSet.FieldByName('p_Family').AsString + '-' +
                                                DataSet.FieldByName('p_Name').AsString;
// DataSet.FieldByName('Barcode').AsString := DelLeftZero(DataSet.FieldByName('p_barcode').AsString);
end;

procedure Tfrmcharge.ADOTable2CalcFields(DataSet: TDataSet);
begin
 DataSet.FieldByName('te').AsString := DataSet.FieldByName('p_Family').AsString + '-' +
                                                DataSet.FieldByName('p_Name').AsString;
// DataSet.FieldByName('Barcode').AsString := DelLeftZero(DataSet.FieldByName('p_barcode').AsString);

end;

procedure Tfrmcharge.BitBtnPartsClick(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);
end;

procedure Tfrmcharge.btnOKClick(Sender: TObject);
var  codep:string;
adoper:TADOQuery ;
ttimeint:integer;
begin
  if txt_Date.Text = '' then
  begin
    ErrorMessage('تاريخ مشخص نشده است.');
    txt_Date.SetFocus;
  end
  else if txt_Time.Text = '' then
  begin
    ErrorMessage('زمان مشخص نشده است.');
    txt_Time.SetFocus;
  end
  else if txt_price.Text = '' then
  begin
    ErrorMessage('مبلغ شارژ كارت مشخص نشده است.');
    txt_price.SetFocus;
  end

  
  else if (cmbCardType.ItemIndex = 1) and (cmbPCode.Items.IndexOf(cmbPCode.Text) < 0) then
  begin
    ErrorMessage('شماره پرسنلی موجود نمیباشد.');
    cmbPCode.SetFocus;
  end

  else if (cmbCardType.ItemIndex = 1) and (cmbFamilyName.Items.IndexOf(cmbFamilyName.Text) < 0) then
  begin
    ErrorMessage('نام موجود نمیباشد.');
    cmbFamilyName.SetFocus;
  end

  else if (cmbCardType.ItemIndex = 2) and (GetPartCode(PartCode) = '') then
  begin
    ErrorMessage('بخش موجود نمیباشد و یا انتخاب نشده است.');
    txtParts.SetFocus;
  end


  else
  begin
    try
      adoper := TADOQuery.Create(Application);
      adoper.Connection := frmDBS.DBConnection;
      with adoper do
      begin
        ttimeint:=TimeToInt(txt_time.Text );
        close;
        sql.Clear;
//**********************these operation handled with Triggers*************************************************
//      sql.Add('update persons set p_credit=0 where p_credit is null');
//
//      sql.Add('DECLARE @ErrorVar int begin TRANSACTION updatePersons');
//      sql.Add('update persons set p_credit=p_credit+'+txt_price.Text);
//      sql.Add('where P_IsGuest=0 and p_prepaid=1 and p_barcode not in (select ch_barcode from charge where ch_time='+ inttostr(ttimeint ) + ' and ch_date= ' +''''+txt_date.Text +''')');
//      if cmbCardType.ItemIndex = 1 then
//        sql.Add('and p_barcode = ''' + FixLeft(cmbEmplCode.Text,'0',8) + '''');
//      sql.Add('SELECT @ErrorVar = @@error IF (@ErrorVar = 547) BEGIN   ROLLBACK TRANSACTION updatePersons end else begin begin TRANSACTION insertToCharge');
//**********************these operation handled with Triggers*************************************************

        sql.Add('INSERT INTO charge (ch_BarCode,ch_date,ch_time,ch_price,ch_User)');
        sql.Add ('SELECT P_BarCode,'+''''+txt_date.Text+'''');
        sql.Add(','+inttostr(ttimeint ));
        sql.add(','+txt_price.Text ) ;
        sql.add(','''+ g_Options.UserName +'''') ;
        sql.Add(' FROM persons  where P_IsGuest=0 and p_prepaid=1 and p_barcode not in (select ch_barcode from charge where ch_time='+ inttostr(ttimeint )+' and ch_date= ' +''''+txt_date.Text +''')');
        if cmbCardType.ItemIndex = 1 then
//          sql.Add('and p_barcode = ''' + FixLeft(cmbEmplCode.Text,'0',8) + '''')
          sql.Add('and p_barcode = ''' + FixLeft(cmbPCode.Text, '0', 8) + '''')
        else if cmbCardType.ItemIndex = 2 then
          sql.Add('and P_Parts = ''' + GetPartCode(PartCode) + '''');
//          tblPerson.FieldByName('P_Parts').AsString := GetPartCode(PartCode)
//          sql.Add('and P_Parts = ''' + cmbPartCode.Text + '''');

//**********************these operation handled with Triggers*************************************************
//      sql.Add( 'SELECT @ErrorVar = @@error IF (@ErrorVar = 547) BEGIN    ROLLBACK TRANSACTION updatePersons    ROLLBACK TRANSACTION insertToCharge '+
//                  ' end else begin commit tran insertToCharge commit tran updatePersons end end ');
//**********************these operation handled with Triggers*************************************************

        ExecSQL ;
      end;
      InformationMessage('شارژ كارتها انجام شد.');
    except
      ErrorMessage('انجام عمل شارژ با مشکل مواجه شد ');
    end;
    ModalResult := mrOk;
  end;
end;

procedure Tfrmcharge.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT P_BarCode, P_Name, P_Family FROM Persons');
    SQL.Add('WHERE P_IsGuest = 0 and p_prepaid = 1 ');
    Open;
    while not EOF do
    begin
      cmbPCode.Items.Add(DelLeftZero(FieldByName('P_BarCode').AsString));
      cmbFamilyName.Items.Add(FieldByName('P_Family').AsString +  '-' +
                              FieldByName('P_Name').AsString);
      Next;
    end;
    Close;
  end;
end;

procedure Tfrmcharge.FormShow(Sender: TObject);
begin
txt_Date.Text := CurrentDate;
txt_Time.Text := CurrentTime;
ADOTable1.Connection:=frmDBS.DBConnection ;
ADOTable2.Connection:=frmDBS.DBConnection ;

ADOTable1.Filtered:=false;
ADOTable1.Filter:='P_IsGuest=0 and p_prepaid=1';
ADOTable1.Filtered  :=true;

ADOTable2.Filtered:=false;
ADOTable2.Filter:='P_IsGuest=0 and p_prepaid=1 ';
ADOTable2.Filtered  :=true;

//  txtParts.Enabled := False;
//  BitBtnParts.Enabled := False;

  cmbCardTypeClick(self);
end;

procedure Tfrmcharge.txt_dateExit(Sender: TObject);
begin
 if txt_Date.Text <> '' then
    txt_Date.Text := BeautifulDate(txt_Date.Text);
end;

procedure Tfrmcharge.txt_dateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure Tfrmcharge.txt_priceKeyPress(Sender: TObject; var Key: Char);
begin
Keyboard_Integer(Key);
end;

procedure Tfrmcharge.txt_timeExit(Sender: TObject);
begin
  if txt_Time.Text <> '' then
    txt_Time.Text := BeautifulTime(txt_Time.Text);
end;

procedure Tfrmcharge.txt_timeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

end.
