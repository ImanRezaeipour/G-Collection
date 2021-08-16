unit amrTabkh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, RpTabkh, RpTabkhF, RpTabkhFP, RpTabkhFP1, DATEPROC, db , AdoDB, Msgs, globals,
  KeyBoard, DBS_Proc, FarsiApi,Makedb,slctpart, ExtCtrls;

type
  TfrmAmarTabkh = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    chkSign: TCheckBox;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    lbl1: TLabel;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    lbl2: TLabel;
    Table1: TAdoTable;
    grptafkik: TGroupBox;
    rdovadeh: TRadioButton;
    rdofood: TRadioButton;
    rdofoods: TRadioButton;
    cmbparts: TBitBtn;
    txtParts: TEdit;
    cmbJobs: TComboBox;
    cmbBuilding: TComboBox;
    cmbreserve7: TComboBox;
    Label10: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    rdoSort: TRadioGroup;
    rdofoodsnoeat: TRadioButton;
    rdofoodprice: TRadioButton;
    rdofoodpricenoeat: TRadioButton;
    procedure cmbpartsClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtToDateExit(Sender: TObject);
    procedure MakeAmarTabkh;
    procedure MakeAmarTabkhnoeat;
  private
    { Private declarations }
  public
    { Public declarations }
    partcode:string;
  end;



implementation

{$R *.dfm}

procedure TfrmAmarTabkh.cmbpartsClick(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);
end;

procedure TfrmAmarTabkh.cmdPrintClick(Sender: TObject);
var
  frmRptamarTabkh : TfrmRptAmarTabkh;
  frmRptamarTabkhF : TfrmRptAmarTabkhF;
  frmRptamarTabkhFP : TfrmRptAmarTabkhFP;
  frmRptamarTabkhFP1: TfrmRptAmarTabkhFP1;
  foodname:string;
  qry : tadoquery;
  i : integer;
  n : Longint;
  dt : string;  
  sobhanehCnt , NaharCnt , ShamCnt : integer;
  part_lcode:string;
begin
  part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';

  if (txtFromDate.Text <> '') and (txtToDate.Text <> '') and
     (txtFromDate.Text > txtToDate.Text) then
  begin
    ErrorMessage('تاريخ ابتدا از تاريخ انتها بزرگتر است.');
    txtFromDate.SetFocus;
  end
  else if (txtFromDate.Text <> '') and not IsTruedate(txtFromDate.Text) then
  begin
    ErrorMessage('تاريخ ابتدا نادرست است.');
    txtFromDate.SetFocus;
  end
  else if (txtToDate.Text <> '') and not IsTruedate(txtToDate.Text) then
  begin
    ErrorMessage('تاريخ انتها نادرست است.');
    txtFromDate.SetFocus;
  end
  else if rdovadeh.Checked
  then begin
    Application.CreateForm(TfrmRptAmarTabkh, frmRptAmarTabkh);
    with frmRptAmarTabkh do
    begin
      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('از تاريخ : ' + txtFromDate.Text + ' تا تاريخ : ' + txtToDate.Text)
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('از تاريخ : ' + txtFromDate.Text)
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := ('تا تاريخ :' + txtToDate.Text)
      else
        lblFromToDate.Caption := '';

      qry := TADOQuery.create(application);
      qry.Connection := frmDBS.DBConnection;
      if not tblExists('AmarTabkh') then
        CreateTbl('AmarTabkh')
      else
      begin
        qry.SQL.Add('delete from AmarTabkh');
        qry.ExecSQL;
        qry.Close;
      end;
      qry.SQL.Clear;
      qry.SQL.Add('Select * from AmarTabkh');
      qry.Open;
      dt := txtFromDate.Text;
      n := DifferDate(txtFromDate.Text , txtToDate.Text) + 1;
      for i := 1 to n do
      begin
        qry.Append;
        qry.FieldByName('Date').AsString := dt;
        qry.Post;
        dt := AddDate(dt , 1);
      end;
      qryAmarTabkh.Close;
      qryAmarTabkh.SQL.Clear;
      qryAmarTabkh.SQL.Add('select * from AmarTabkh');
      qryAmarTabkh.Open;
      if qryAmarTabkh.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptAmarTabkh.Preview
        else
          qrptAmarTabkh.Print;
      end
      else
        InformationMessage('گزارش تهي است .');
      qry.Close;
      qry.free;
      Close;
      Free;
    end;
  end
  else if rdofood.Checked
  then begin
    Application.CreateForm(TfrmRptAmarTabkhF, frmRptAmarTabkhF);
    with frmRptAmarTabkhF do
    begin
      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('از تاريخ : ' + txtFromDate.Text + ' تا تاريخ : ' + txtToDate.Text)
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('از تاريخ : ' + txtFromDate.Text)
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := ('تا تاريخ :' + txtToDate.Text)
      else
        lblFromToDate.Caption := '';

      MakeAmarTabkh;

      qryAmarTabkhF.SQL.Clear;
      qryAmarTabkhF.SQL.Add('select building , VADEH,date,food,sum(cnt) as cnts from AmarTabkhF group by building , date , food , vadeh order by date, vadeh ');
      qryAmarTabkhF.Open;

      if qryAmarTabkhF.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptAmarTabkhF.Preview
        else
          qrptAmarTabkhF.Print;
      end
      else
        InformationMessage('گزارش تهي است .');
      Close;
      Free;
    end;
  end
  else if rdofoodprice.Checked or rdofoodpricenoeat.Checked 
  then begin
    Application.CreateForm(TfrmRptAmarTabkhFP1, frmRptAmarTabkhFP1);
    with frmRptAmarTabkhFP1 do
    begin
      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('از تاريخ : ' + txtFromDate.Text + ' تا تاريخ : ' + txtToDate.Text)
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('از تاريخ : ' + txtFromDate.Text)
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := ('تا تاريخ :' + txtToDate.Text)
      else
        lblFromToDate.Caption := '';

      if rdofoodprice.Checked
      then begin
           MakeAmarTabkh;
           lblname.Caption:='گزارش مشروح ریالی پيش بيني آمار طبخ انواع غذا';
      end
      else begin
           MakeAmarTabkhnoeat;
           lblname.Caption:='گزارش ریالی افرادی که غذا رزرو کرده و نخورده اند';
      end;

      qryAmarTabkhFP1.SQL.Clear;
      qryAmarTabkhFP1.SQL.Add('select * from AmarTabkhF,persons ');
      qryAmarTabkhFP1.SQL.Add('where p_barcode=personno ');
      case rdosort.ItemIndex of
           0:qryAmarTabkhFP1.SQL.Add('order by date, personno');
           1:qryAmarTabkhFP1.SQL.Add('order by date, p_family');
      end;
      qryAmarTabkhFP1.Open;

      if qryAmarTabkhFP1.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptAmarTabkhFP1.Preview
        else
          qrptAmarTabkhFP1.Print;
      end
      else
        InformationMessage('گزارش تهي است .');
      Close;
      Free;
    end;
  end
  else begin
    Application.CreateForm(TfrmRptAmarTabkhFP, frmRptAmarTabkhFP);
    with frmRptAmarTabkhFP do
    begin
      bndSign.Enabled := chkSign.Checked;
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('از تاريخ : ' + txtFromDate.Text + ' تا تاريخ : ' + txtToDate.Text)
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('از تاريخ : ' + txtFromDate.Text)
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := ('تا تاريخ :' + txtToDate.Text)
      else
        lblFromToDate.Caption := '';

      if rdofoods.Checked
      then begin
           MakeAmarTabkh;
           lblname.Caption:='گزارش مشروح پيش بيني آمار طبخ انواع غذا';
      end
      else begin
           MakeAmarTabkhnoeat;
           lblname.Caption:='گزارش افرادی که غذا رزرو کرده و غذا نخورده اند';
      end;

      qryAmarTabkhFP.SQL.Clear;
      qryAmarTabkhFP.SQL.Add('select * from AmarTabkhF,persons ');
      qryAmarTabkhFP.SQL.Add('where p_barcode=personno ');
      case rdosort.ItemIndex of
           0:qryAmarTabkhFP.SQL.Add('order by date, personno');
           1:qryAmarTabkhFP.SQL.Add('order by date, p_family');
      end;
      qryAmarTabkhFP.Open;

      if qryAmarTabkhFP.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          qrptAmarTabkhFP.Preview
        else
          qrptAmarTabkhFP.Print;
      end
      else
        InformationMessage('گزارش تهي است .');
      Close;
      Free;
    end;
  end;
end;

procedure TfrmAmarTabkh.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
begin
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;
  SetDirectionFarsi(txtFromDate.Handle);

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM JobType');
  qry.Open;
  while not qry.Eof do
  begin
    cmbJobs.Items.Add(qry.FieldByName('Job_Code').AsString + '-' + qry.FieldByName('Job_Name').AsString);
    qry.Next;
  end;

  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM building');
  qry.Open;
  while not qry.Eof do
  begin
    cmbBuilding.Items.Add(qry.FieldByName('building_Code').AsString + '-' + qry.FieldByName('building_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM reserve7');
  qry.Open;
  while not qry.Eof do
  begin
    cmbreserve7.Items.Add(qry.FieldByName('rsrv7_name').AsString );
    qry.Next;
  end;
  qry.Close;

  qry.Free;
end;

procedure TfrmAmarTabkh.MakeAmarTabkh;
var
  qry,qry1 : TAdoQuery;
  i,j,vadeh,count,foodcode : integer;
  dt : string;
  n : Longint;
  part_lcode:string;
  foodname:string;
const
  days : array [1..7] of string = ('شنبه','يکشنبه','دوشنبه','سه شنبه','چهار شنبه','پنج شنبه','جمعه');

begin
  part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';
  qry := TADOQuery.create(application);
  qry.Connection := frmDBS.DBConnection;

  qry1 := TADOQuery.create(application);
  qry1.Connection := frmDBS.DBConnection;

//  if not tblExists('AmarTabkhF') then
//    CreateTbl('AmarTabkhF')
//  else
//  begin
//    qry1.SQL.Add('delete from AmarTabkhF');
//    qry1.ExecSQL;
//    qry1.Close;
//  end;
  UpgradeTable('AmarTabkhF');
  qry1.SQL.Add('delete from AmarTabkhF');
  qry1.ExecSQL;
  qry1.Close;

  qry1.SQL.Clear;
  qry1.SQL.Add('Select * from AmarTabkhF');
  {
  case rdosort.ItemIndex of
       0:qry1.SQL.Add('order by personno');
       1:qry1.SQL.Add('order by personno');
  end;
  }
  qry1.Open;

  dt := txtFromDate.Text;
  n := DifferDate(txtFromDate.Text , txtToDate.Text) + 1;
  for i := 1 to n do
  begin
    LoadFoodList(dt);
    qry.SQL.Clear;
    qry.SQL.Add('Select * from(');
    qry.SQL.Add('Select * from prgprs,persons');
    qry.SQL.Add('where pp_pcode=p_barcode');
    qry.SQL.Add('and pp_date='''+dt+'''');

    if cmbJobs.Text <> '' then
      qry.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));

    if txtparts.text <> '' then
      qry.SQL.Add('AND P_parts like  ' + ''''+ part_lcode+'''');

    if cmbBuilding.Text <> '' then
      qry.SQL.Add('AND pp_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));

    if cmbreserve7.Text <> '' then
      qry.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');
    qry.SQL.Add(')a left outer join building on pp_Building = Building_Code');
    {
    case rdosort.ItemIndex of
         0:qry1.SQL.Add('order by personno');
         1:qry1.SQL.Add('order by personno');
    end;
    }
    qry.Open;
    while not qry.Eof do
    begin
      vadeh:=qry.FieldByName('pp_type').asinteger;
      LoadDayProg(qry.FieldByName('pp_date').AsString);
      for j:=1 to 8 do
      begin
        if qry.FieldByName('pp_key'+inttostr(j)).AsBoolean
        then begin
             foodcode:=DayFoodList[vadeh].Keys[j];//   FoodsList[j].Food_Code;
             foodname:= GetFoodNameInRam(foodcode);
             count:=1;//GetFoodAmar(foodcode,vadeh,dt);
             qry1.Append;
             qry1.FieldByName('date').asstring:=dt;
             qry1.FieldByName('day').asstring:=days[dayOfWeek(M_Date(dt)+1)];
             qry1.FieldByName('Vadeh').asinteger:=vadeh;
             qry1.FieldByName('food').asstring:=foodname;
             qry1.FieldByName('cnt').asinteger:=count;
             qry1.FieldByName('prc').AsCurrency:=qry.FieldByName('pp_price').AsCurrency;
             qry1.FieldByName('personno').asstring:=qry.FieldByName('pp_pcode').AsString;
             qry1.FieldByName('building').AsString := qry.FieldByName('Building_name').AsString;;
             qry1.Post;
        end;
      end;
      qry.Next;
    end;
    qry.Close;
    dt := AddDate(dt , 1);
  end;
  qry.Close;
  qry.free;
  qry1.Close;
  qry1.free;
end;

procedure TfrmAmarTabkh.MakeAmarTabkhnoeat;
var
  qry,qry1,qry2 : TAdoQuery;
  i,j,vadeh,count,foodcode : integer;
  dt : string;
  n : Longint;
  pcode,part_lcode:string;
  foodname:string;
const
  days : array [1..7] of string = ('شنبه','يکشنبه','دوشنبه','سه شنبه','چهار شنبه','پنج شنبه','جمعه');

begin
  part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';
  qry := TADOQuery.create(application);
  qry.Connection := frmDBS.DBConnection;

  qry1 := TADOQuery.create(application);
  qry1.Connection := frmDBS.DBConnection;

  qry2 := TADOQuery.create(application);
  qry2.Connection := frmDBS.DBConnection;

  UpgradeTable('AmarTabkhF');
  qry1.SQL.Add('delete from AmarTabkhF');
  qry1.ExecSQL;
  qry1.Close;

  qry1.SQL.Clear;
  qry1.SQL.Add('Select * from AmarTabkhF');
  qry1.Open;

  dt := txtFromDate.Text;
  n := DifferDate(txtFromDate.Text , txtToDate.Text) + 1;
  for i := 1 to n do
  begin
    LoadFoodList(dt);
    qry.SQL.Clear;
    qry.SQL.Add('Select * from(');
    qry.SQL.Add('Select * from prgprs,persons');
    qry.SQL.Add('where pp_pcode=p_barcode');
    qry.SQL.Add('and pp_date='''+dt+'''');

    if cmbJobs.Text <> '' then
      qry.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));

    if txtparts.text <> '' then
      qry.SQL.Add('AND P_parts like  ' + ''''+ part_lcode+'''');

    if cmbBuilding.Text <> '' then
      qry.SQL.Add('AND pp_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));

    if cmbreserve7.Text <> '' then
      qry.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');
    qry.SQL.Add(')a left outer join building on pp_Building = Building_Code');
    qry.Open;
    while not qry.Eof do
    begin
      vadeh:=qry.FieldByName('pp_type').asinteger;
      LoadDayProg(qry.FieldByName('pp_date').AsString);
      pcode:=qry.FieldByName('pp_pcode').AsString;

      qry2.SQL.Clear;
      qry2.SQL.Add('Select * from Fish');
      qry2.SQL.Add('where fish_pcode='''+pcode+'''');
      qry2.SQL.Add('and fish_date='''+qry.FieldByName('pp_date').AsString+'''');
      qry2.SQL.Add('and fish_type='+inttostr(vadeh));
      qry2.Open;
      if qry2.recordcount=0 then
      for j:=1 to 8 do
      begin
        if qry.FieldByName('pp_key'+inttostr(j)).AsBoolean
        then begin
             foodcode:=DayFoodList[vadeh].Keys[j];//   FoodsList[j].Food_Code;
             foodname:= GetFoodNameInRam(foodcode);
             count:=1;//GetFoodAmar(foodcode,vadeh,dt);
             qry1.Append;
             qry1.FieldByName('date').asstring:=dt;
             qry1.FieldByName('day').asstring:=days[dayOfWeek(M_Date(dt)+1)];
             qry1.FieldByName('Vadeh').asinteger:=vadeh;
             qry1.FieldByName('food').asstring:=foodname;
             qry1.FieldByName('cnt').asinteger:=count;
             qry1.FieldByName('prc').AsCurrency:=qry.FieldByName('pp_price').AsCurrency;
             qry1.FieldByName('personno').asstring:=pcode;
             qry1.FieldByName('building').AsString := qry.FieldByName('Building_name').AsString;;
             qry1.Post;
        end;
      end;
      qry2.close;
      qry.Next;
    end;
    qry.Close;
    dt := AddDate(dt , 1);
  end;
  qry.Close;
  qry.free;
  qry1.Close;
  qry1.free;
  qry2.Close;
  qry2.free;
end;

procedure TfrmAmarTabkh.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);

  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmAmarTabkh.txtFromDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmAmarTabkh.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmAmarTabkh.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

end.
