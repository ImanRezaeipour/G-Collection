unit FoodList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, AdoDB, Globals, FarsiApi,
  MSGs, DBS_Proc, Keyboard, DateProc;

type
  TfrmFoodList = class(TForm)
    grpAll: TGroupBox;
    dbgFood: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lbl3: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaFood: TDataSource;
    tblFood: TAdoTable;
    lbl1: TLabel;
    txtSearch: TEdit;
    cmdPrice: TBitBtn;
    tblFoodFood_Code: TSmallintField;
    tblFoodFood_Name: TStringField;
    cmdPrc: TBitBtn;
    grpPrice: TGroupBox;
    dbgPrice: TDBGrid;
    cmdNewPrice: TBitBtn;
    cmdEditPrice: TBitBtn;
    cmdDeletePrice: TBitBtn;
    cmdSavePrice: TBitBtn;
    txtDate: TEdit;
    txtPriceFee: TEdit;
    txtPricePerson: TEdit;
    dtaPrice: TDataSource;
    tblPrice: TAdoTable;
    tblPriceFP_Date: TStringField;
    tblPriceFP_PriceFee: TCurrencyField;
    tblPriceFP_PricePerson: TCurrencyField;
    cmdCanelPrice: TBitBtn;
    rdoSobh: TRadioButton;
    rdoFood: TRadioButton;
    rdoMokhalafat: TRadioButton;
    tblFoodFood_Type: TSmallintField;
    tblPriceFP_FoodCode: TSmallintField;
    rdoKhadamat: TRadioButton;
    lbl2: TLabel;
    txtCode: TEdit;
    grppriceall: TGroupBox;
    cmdsaveall: TBitBtn;
    txtdateall: TEdit;
    txtpercentall: TEdit;
    cmdcancelall: TBitBtn;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    cbroundall: TComboBox;
    cmdpriceall: TBitBtn;
    txtpercentallp: TEdit;
    lbl7: TLabel;
    btnUpdate: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgFoodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPriceClick(Sender: TObject);
    procedure cmdPrcClick(Sender: TObject);
    procedure dbgPriceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtPriceFeeKeyPress(Sender: TObject; var Key: Char);
    procedure txtPricePersonKeyPress(Sender: TObject; var Key: Char);
    procedure cmdCanelPriceClick(Sender: TObject);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewPriceClick(Sender: TObject);
    procedure cmdEditPriceClick(Sender: TObject);
    procedure cmdDeletePriceClick(Sender: TObject);
    procedure cmdSavePriceClick(Sender: TObject);
    procedure txtDateExit(Sender: TObject);
    procedure rdoSobhClick(Sender: TObject);
    procedure rdoFoodClick(Sender: TObject);
    procedure rdoMokhalafatClick(Sender: TObject);
    procedure rdoSobhKeyPress(Sender: TObject; var Key: Char);
    procedure txtSearchChange(Sender: TObject);
    procedure rdoKhadamatClick(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdpriceallClick(Sender: TObject);
    procedure cmdcancelallClick(Sender: TObject);
    procedure cmdsaveallClick(Sender: TObject);
    procedure txtdateallExit(Sender: TObject);
    procedure txtdateallKeyPress(Sender: TObject; var Key: Char);
    procedure txtpercentallpKeyPress(Sender: TObject; var Key: Char);
    procedure txtpercentallKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag, PrcFlag : Byte;
    //FoodCode : Integer;
    FoodType : Byte;

    procedure DBS_Set;
    procedure FormInEdit(vis : Boolean);
    procedure PriceInEdit(enbl : Boolean);
    procedure PriceInEditAll(enbl : Boolean);
    procedure FormPricing;
    procedure FormPricingAll;
    procedure ClearScrFields;
    procedure ClearPriceFields;
    procedure SetScreenFields;
    procedure SetPriceFields;
    function  GetFoodPriceInDB(FoodCode : Integer;TDate : String) : Boolean;
    function  AreValidFields : Boolean;
    procedure SetWinF;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmFoodList.SetWinF;
begin
end;

procedure TfrmFoodList.DBS_Set;
var s : String;
begin
  tblFood.Filtered := False;
  s := 'Food_Type = ' + IntToStr(FoodType);
  if txtSearch.Text <> '' then
    s := s + ' AND Food_Name like ''%' + txtSearch.Text + '%''';
  tblFood.Filter := s;
  tblFood.Filtered := True;
  tblFood.Close;
  tblFood.Open;
end;

procedure TfrmFoodList.FormInEdit(vis : Boolean);
begin
  if vis = False then
    Flag := MB_NONE;
  grpPrice.Visible := False;
  grpEdit.Visible := vis;
  grpAll.Visible := True;
  grpAll.Enabled := not vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

procedure TfrmFoodList.FormPricing;
begin
  grpAll.Visible := False;
  grpEdit.Visible := False;
  grpPrice.Align := alTop;
  grpPrice.Visible := True;
  Height := grpPrice.Height + 25;
  PriceInEdit(False);
  grpPrice.Caption := tblFood.FieldByName('Food_Name').AsString;
  tblPrice.Filtered := False;
  tblPrice.Filter := 'FP_FoodCode = ' + IntToStr(tblFood.FieldByName('Food_Code').AsInteger);
  tblPrice.Filtered := True;
  tblPrice.Open;
end;

procedure TfrmFoodList.FormPricingAll;
begin
  grpAll.Visible := False;
  grpEdit.Visible := False;
  grpPriceAll.Align := alTop;
  grpPriceAll.Visible := True;
  Height := grpPrice.Height + 25;
  PriceInEditAll(False);
  tblPrice.Filtered := False;
  tblPrice.Filter := 'FP_FoodCode = ' + IntToStr(tblFood.FieldByName('Food_Code').AsInteger);
  tblPrice.Filtered := True;
  tblPrice.Open;
end;

procedure TfrmFoodList.PriceInEdit(enbl : Boolean);
begin
  dbgPrice.Enabled := not enbl;
  cmdNewPrice.Enabled := not enbl;
  cmdEditPrice.Enabled := not enbl;
  cmdDeletePrice.Enabled := not enbl;
  cmdSavePrice.Enabled := enbl;
  txtdate.Enabled := enbl;
  txtPriceFee.Enabled := enbl;
  txtPricePerson.Enabled := enbl;
  if enbl then
    txtDate.SetFocus
  else
    dbgPrice.SetFocus;
end;

procedure TfrmFoodList.PriceInEditAll(enbl : Boolean);
begin
  dbgPrice.Enabled := not enbl;
  cmdNewPrice.Enabled := not enbl;
  cmdEditPrice.Enabled := not enbl;
  cmdDeletePrice.Enabled := not enbl;
  cmdSavePrice.Enabled := enbl;
  txtdate.Enabled := enbl;
  txtPriceFee.Enabled := enbl;
  txtPricePerson.Enabled := enbl;
  if enbl then
    dbgfood.SetFocus
  else
    txtDateAll.SetFocus;
end;

procedure TfrmFoodList.ClearScrFields;
begin
  txtCode.Text := IntToStr(GetNewNumber('FoodList', 'Food_Code'));
  txtName.Text := '';
  txtName.SetFocus;
end;

procedure TfrmFoodList.ClearPriceFields;
begin
  txtDate.Text := CurrentDate;
  txtPriceFee.Text := '';
  txtPricePerson.Text := '';
end;

procedure TfrmFoodList.SetScreenFields;
begin
  txtCode.Text := IntToStr(tblFood.FieldByName('Food_Code').AsInteger);
  txtName.Text := tblFood.FieldByName('Food_Name').AsString;
  txtName.SetFocus;
end;

procedure TfrmFoodList.SetPriceFields;
begin
  txtDate.Text := tblPrice.FieldByName('FP_Date').AsString;
  txtPriceFee.Text := FloatToStr(tblPrice.FieldByName('FP_PriceFee').AsFloat);
  txtPricePerson.Text := FloatToStr(tblPrice.FieldByName('FP_PricePerson').AsFloat);;
end;

function TfrmFoodList.GetFoodPriceInDB(FoodCode : Integer;TDate : String) : Boolean;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT FP_PriceFee, FP_PricePerson FROM FoodPric');
  qry.SQL.Add('WHERE FP_FoodCode = ' + IntToStr(FoodCode));
  qry.SQL.Add('AND FP_Date = ''' + TDate + '''');
  qry.Open;
  GetFoodPriceInDB := (qry.RecordCount > 0);
  qry.Close;
  qry.Free;
end;

function TfrmFoodList.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ €–« Ê«—œ ‰‘œÂ «” .');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ €–« Ê«—œ ‰‘œÂ «” .');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('FoodList', 'Food_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblFood.FieldByName('Food_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ €–«  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('FoodList', 'Food_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (tblFood.FieldByName('Food_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('‰«„ €–«  ﬂ—«—Ì «” .');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmFoodList.FormCreate(Sender: TObject);
begin
  SetWinF;
  SetDirectionFarsi(txtSearch.Handle);
  SetDirectionFarsi(txtName.Handle);
  tblFood.connection := frmDBS.DBConnection;
  tblPrice.connection := frmDBS.DBConnection;
  FoodType := MB_SOBHANEH;
end;

procedure TfrmFoodList.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
  DBS_Set;
end;

procedure TfrmFoodList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tblFood.Close;
end;

procedure TfrmFoodList.rdoSobhClick(Sender: TObject);
begin
  FoodType := MB_SOBHANEH;
  DBS_Set;
end;

procedure TfrmFoodList.rdoFoodClick(Sender: TObject);
begin
  FoodType := MB_GHAZA;
  DBS_Set;
end;

procedure TfrmFoodList.rdoMokhalafatClick(Sender: TObject);
begin
  FoodType := MB_MOKHALAFAT;
  DBS_Set;
end;

procedure TfrmFoodList.rdoKhadamatClick(Sender: TObject);
begin
  FoodType := MB_KHADAMAT;
  DBS_Set;
end;

procedure TfrmFoodList.rdoSobhKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtSearch.SetFocus;
  end;
end;

procedure TfrmFoodList.txtSearchChange(Sender: TObject);
begin
  DBS_Set;
end;

procedure TfrmFoodList.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgFood.SetFocus;
  end;
end;

procedure TfrmFoodList.dbgFoodKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmFoodList.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;
  ClearScrFields;
end;

procedure TfrmFoodList.cmdEditClick(Sender: TObject);
begin
  if tblFood.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    SetScreenFields;
  end;
end;

procedure TfrmFoodList.cmdDeleteClick(Sender: TObject);
var qry : TAdoQuery;
begin
  if tblFood.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('FishFood', 'FF_Food', tblFood.FieldByName('Food_Code').AsInteger) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì Õ–› €–« Ê ﬁÌ„ Â«Ì ¬‰ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        qry := TAdoQuery.Create(Application);
        with qry do
        begin
          connection := frmDBS.DBConnection;
          SQL.Clear;
          SQL.Add('DELETE FROM FoodPric WHERE FP_FoodCode = ' + IntToStr(tblFood.FieldByName('Food_Code').AsInteger));
          ExecSQL;
          Free;
        end;
        tblFood.Delete;
//        tblFood.Refresh;
      end;
    end
    else
      InformationMessage('«Ì‰ €–« œ— ê—œ‘ »ÊœÂ Ê Õ–› ¬‰ «„ﬂ«‰ Å–Ì— ‰Ì” .');
  end;
end;

procedure TfrmFoodList.cmdPrcClick(Sender: TObject);
begin
  if tblFood.RecordCount > 0 then
    FormPricing;
end;

procedure TfrmFoodList.cmdSaveClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblFood.Append
    else if Flag = MB_EDIT then
      tblFood.Edit;

    tblFood.FieldByName('Food_Code').AsInteger := StrToInt(txtCode.Text);
    tblFood.FieldByName('Food_Type').AsInteger := FoodType;
    tblFood.FieldByName('Food_Name').AsString := txtName.Text;
    tblFood.Post;

    if Flag = MB_NEW then
      ClearScrFields
    else
    begin
      FormInEdit(False);
      dbgFood.SetFocus;
    end;
  end;
end;

procedure TfrmFoodList.cmdPriceClick(Sender: TObject);
begin
  if AreValidFields then
  begin
    if Flag = MB_NEW then
      tblFood.Append
    else if Flag = MB_EDIT then
      tblFood.Edit;

    tblFood.FieldByName('Food_Code').AsInteger := StrToInt(txtCode.Text);
    tblFood.FieldByName('Food_Type').AsInteger := FoodType;
    tblFood.FieldByName('Food_Name').AsString := txtName.Text;
    tblFood.Post;

    if Flag = MB_NEW then
      ClearScrFields;

    FormPricing;
  end;

end;

procedure TfrmFoodList.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmFoodList.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmFoodList.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgFood.SetFocus;
end;




procedure TfrmFoodList.dbgPriceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 9 then
  begin
    Key := 0;
    cmdNewPrice.SetFocus;
  end
  else if Key = 45 then
    cmdNewPriceClick(Sender)
  else if Key = 46 then
    cmdDeletePriceClick(Sender)
  else if Key = 13 then
    cmdEditPriceClick(Sender);
end;

procedure TfrmFoodList.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPricePerson.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmFoodList.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmFoodList.txtPricePersonKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPriceFee.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmFoodList.txtPriceFeeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSavePrice.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmFoodList.cmdNewPriceClick(Sender: TObject);
begin
  PrcFlag := MB_NEW;
  PriceInEdit(True);
  ClearPriceFields;
end;

procedure TfrmFoodList.cmdEditPriceClick(Sender: TObject);
begin
  if tblPrice.RecordCount > 0 then
  begin
    PriceInEdit(True);
    PrcFlag := MB_EDIT;
    SetPriceFields;
  end;
end;

procedure TfrmFoodList.cmdDeletePriceClick(Sender: TObject);
begin
  if tblPrice.RecordCount > 0 then
  begin
    if ConfirmMessage('¬Ì« »—«Ì Õ–› ﬁÌ„  «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      tblPrice.Delete;
//      tblPrice.Refresh;
    end;
  end;
end;

procedure TfrmFoodList.cmdSavePriceClick(Sender: TObject);
begin
  if txtDate.Text = '' then
  begin
    ErrorMessage(' «—ÌŒ „‘Œ’ ‰‘œÂ «” .');
    txtDate.SetFocus;
  end
  else if not IsTrueDate(txtDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ‰«œ—”  «” .');
    txtDate.SetFocus;
  end
  else if txtPriceFee.Text = '' then
  begin
    ErrorMessage('„»·€ ÅÌ„«‰ﬂ«—Ì „‘Œ’ ‰‘œÂ «” .');
    txtPriceFee.SetFocus;
  end
  else if txtPricePerson.Text = '' then
  begin
    ErrorMessage('„»·€ Å—”‰·Ì „‘Œ’ ‰‘œÂ «” .');
    txtPricePerson.SetFocus;
  end
  else if GetFoodPriceInDB(tblFood.FieldByName('Food_Code').AsInteger, txtDate.Text) and
          ((PrcFlag = MB_NEW) or ((PrcFlag = MB_EDIT) and (tblPrice.FieldByName('FP_Date').AsString <> txtDate.Text))) then
  begin
    ErrorMessage('ﬁÌ„  ê–«—Ì œ— «Ì‰  «—ÌŒ «‰Ã«„ ‘œÂ «” .');
    txtDate.SetFocus;
  end
  else
  begin
    if PrcFlag = MB_NEW then
      tblPrice.Append
    else
      tblPrice.Edit;

    tblPrice.FieldByName('FP_FoodCode').AsInteger := tblFood.FieldByName('Food_Code').AsInteger;
    tblPrice.FieldByName('FP_Date').AsString := txtDate.Text;
    tblPrice.FieldByName('FP_PriceFee').AsCurrency := StrToFloat(txtPriceFee.Text);
    tblPrice.FieldByName('FP_PricePerson').AsCurrency := StrToFloat(txtPricePerson.Text);
    tblPrice.Post;

    ClearPriceFields;
    PriceInEdit((PrcFlag = MB_NEW));
  end;
end;

procedure TfrmFoodList.cmdCanelPriceClick(Sender: TObject);
begin
  tblPrice.Close;
  FormInEdit((Flag = MB_EDIT));
  if grpAll.Enabled then
    dbgFood.SetFocus
  else if txtName.Visible then
    txtName.SetFocus;
end;

procedure TfrmFoodList.cmdpriceallClick(Sender: TObject);
begin
  if tblFood.RecordCount > 0 then
    FormPricingAll;
end;

procedure TfrmFoodList.cmdcancelallClick(Sender: TObject);
begin
  tblPrice.Close;
  FormInEdit((Flag = MB_EDIT));
  grppriceall.Visible:=false;
  if grpAll.Enabled then
    dbgFood.SetFocus
  else if txtName.Visible then
    txtName.SetFocus;
end;

procedure TfrmFoodList.cmdsaveallClick(Sender: TObject);
var
   qry : TAdoQuery;
   vec : array[0..255] of
         record
            date1 : string[10];
            pricefee1: integer;
            priceperson1: integer;
            must1  : boolean;
         end;
   date2:string[10];
   pricefee2,priceperson2:integer;
   code2:integer;
   i:integer;
   date0:string[10];
   zarib0,zaribP0:real;
   round0,pricefee0,priceperson0:integer;
begin
  Mouse_Wait;
  zarib0:=strtoreal(txtpercentall.Text);
  zaribp0:=strtoreal(txtpercentallP.Text);
  round0:=strtoint(cbroundall.Items[cbroundall.ItemIndex]);
  date0:=txtdateall.text;
  for i:=0 to 255 do
  with vec[i] do
  begin
     must1:=true;
     date1:='';
     pricefee1:=0;
     priceperson1:=0;
  end;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT fp_date ,fp_foodcode, FP_PriceFee, FP_PricePerson FROM FoodPric');
  qry.Open;
  with qry do
  while not eof do
  begin
      date2:=fieldbyname('fp_date').AsString;
      pricefee2:=fieldbyname('FP_PriceFee').AsInteger;
      priceperson2:=fieldbyname('FP_PricePerson').AsInteger;
      code2:=fieldbyname('fp_foodcode').AsInteger;
      with vec[code2] do
      if date2=date0
      then begin
           must1:=false;
      end
      else begin
           if date2<date0
           then if date2>date1
           then begin
                date1:=date2;
                pricefee1:=pricefee2;
                priceperson1:=priceperson2;
           end;
      end;
      next;
  end;
  for i:=0 to 255 do
  with vec[i] do
  if must1
  then if date1<>''
  then if pricefee1>0
  then if priceperson1>0
  then begin
      pricefee0:=round(pricefee1*(1+zarib0/100.0));
      priceperson0:=round(priceperson1*(1+zaribp0/100.0));
      pricefee0:= round(pricefee0/round0) * round0;
      priceperson0:= round(priceperson0/round0) * round0;
      tblPrice.Append;
      tblPrice.FieldByName('FP_FoodCode').AsInteger := i;
      tblPrice.FieldByName('FP_Date').AsString := Date0;
      tblPrice.FieldByName('FP_PriceFee').AsCurrency :=pricefee0;
      tblPrice.FieldByName('FP_PricePerson').AsCurrency :=priceperson0;
      tblPrice.Post;
  end;
  qry.Close;
  qry.Free;
  Mouse_NoWait;
end;

procedure TfrmFoodList.txtdateallExit(Sender: TObject);
begin
  if txtDateall.Text <> '' then
    txtDateall.Text := BeautifulDate(txtDateall.Text);
end;

procedure TfrmFoodList.txtdateallKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtpercentall.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmFoodList.txtpercentallpKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cbroundall.SetFocus;
  end
  else
    Keyboard_Number(Key,text);
end;

procedure TfrmFoodList.txtpercentallKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtpercentallp.SetFocus;
  end
  else
    Keyboard_Number(Key,text);
end;

end.
