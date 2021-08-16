unit EmpSrvRp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DosMove, XStringGrid, Grids,
  ExtCtrls, DB, ADODB, DBCtrls;

type
  TfrmEmployeeServiceRpt = class(TForm)
    lbl1: TLabel;
    cmbEmplCode2: TComboBox;
    cmbEmplName2: TComboBox;
    btnEmplSel: TBitBtn;
    lbl2: TLabel;
    cmbParts: TComboBox;
    lbl3: TLabel;
    cmbDepartment: TComboBox;
    lbl4: TLabel;
    cmbCoPosts: TComboBox;
    lbl6: TLabel;
    lbl7: TLabel;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    chkSign: TCheckBox;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    DosMove1: TDosMove;
    rdoSort: TRadioGroup;
    txtFDate: TEdit;
    txtTDate: TEdit;
    rdoReportType: TRadioGroup;
    rdoGroup: TRadioGroup;
    lbl8: TLabel;
    txtdescribe: TEdit;
    BitBtn1: TBitBtn;
    rdoreport: TRadioGroup;
    cmbEmplCode: TDBLookupComboBox;
    cmbEmplName: TDBLookupComboBox;
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
    DataSource2: TDataSource;
    DataSource1: TDataSource;
    SpeedButton1: TSpeedButton;
    chkViewManfi: TCheckBox;
    chkViewZero: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cmbEmplNameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cmbEmplCodeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ADOTable1CalcFields(DataSet: TDataSet);
    procedure ADOTable2CalcFields(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbEmplCode2Click(Sender: TObject);
    procedure cmbEmplName2Click(Sender: TObject);
    procedure cmbEmplCode2Exit(Sender: TObject);
    procedure cmbEmplName2Exit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnEmplSelClick(Sender: TObject);
    procedure rdoReportTypeClick(Sender: TObject);
    procedure txtFDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFDateExit(Sender: TObject);
    procedure txtTDateExit(Sender: TObject);
    procedure rdoreportClick(Sender: TObject);
  private
    { Private declarations }
    fla:integer;
    emplSelected : String;
     departSelected:string;
    procedure SetWinF;

  public
    { Public declarations }
  end;


var
  frmEmployeeServiceRpt : TfrmEmployeeServiceRpt;



implementation

uses Funcs, Globals, DBS, MSGS, Keyboard, DateProc, Select, FntSel,
  RpSrvEm1,RpSrvEm5,RpSrvEm6, RpSrvEm2, RpSrvEm3, RpSrvEm4, QuickRpt;

{$R *.dfm}

procedure TfrmEmployeeServiceRpt.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmEmployeeServiceRpt));
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  btnEmplSel.Caption := (btnEmplSel.Caption);
  rdoGroup.Caption := (rdoGroup.Caption);
  rdoReportType.Caption := (rdoReportType.Caption);
  for i := 0 to rdoReportType.Items.Count-1 do
    rdoReportType.Items.Strings[i] := (rdoReportType.Items.Strings[i]);
  for i := 0 to rdoGroup.Items.Count-1 do
    rdoGroup.Items.Strings[i] := (rdoGroup.Items.Strings[i]);
  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count-1 do
    rdoSort.Items.Strings[i] := (rdoSort.Items.Strings[i]);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  lbl8.Caption := (lbl8.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;



procedure TfrmEmployeeServiceRpt.SpeedButton1Click(Sender: TObject);
begin
ADOTable1.Close;
ADOTable2.Close;
end;

procedure TfrmEmployeeServiceRpt.FormCreate(Sender: TObject);
begin
ADOTable1.Connection:=frmDBS.adoConnect;
ADOTable2.Connection:=frmDBS.adoConnect;
ADOTable1.Open;
ADOTable2.Open;      
  fla:=2;
  SetWinF;
  Application.CreateForm(TfrmSelect, frmSelect);

      departSelected := '';

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empl_No, Empl_Name, Empl_Family FROM Employee');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Empl_Department = ' + IntToStr(gOptions.UserDepart));
    SQL.Add('ORDER BY Empl_Family, Empl_Name, Empl_No');
    Open;
 {  while not Eof do
    begin
      cmbEmplCode.Items.Add(FieldByName('Empl_No').AsString);
      cmbEmplName.Items.Add(FieldByName('Empl_Family').AsString + '-' +
                            FieldByName('Empl_Name').AsString);
      Next;
    end;
   }
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Parts');
    SQL.Add('ORDER BY Part_Name');
    Open;
    while not Eof do
    begin
      cmbParts.Items.Add(FieldByName('Part_Code').AsString + '-' +
                         FieldByName('Part_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM CoPosts');
    SQL.Add('ORDER BY CoPost_Name');
    Open;
    while not Eof do
    begin
      cmbCoPosts.Items.Add(FieldByName('CoPost_Code').AsString + '-' +
                           FieldByName('CoPost_Name').AsString);
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM Discount');
    SQL.Add('ORDER BY Dscnt_Name');
    Open;
    SQL.Clear;
    SQL.Add('SELECT * FROM Department');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE Depart_Code = ' + IntToStr(gOptions.UserDepart));
    SQL.Add('ORDER BY Depart_Name');
    Open;
    while not Eof do
    begin
      cmbDepartment.Items.Add(FieldByName('Depart_Code').AsString + '-' +
                              FieldByName('Depart_Name').AsString);
      Next;
    end;
    Close;

  end;

  txtFDate.Text := gOptions.fromDate;
  txtTDate.Text := gOptions.toDate;

end;

procedure TfrmEmployeeServiceRpt.cmbEmplCode2Click(Sender: TObject);
begin
//  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure TfrmEmployeeServiceRpt.cmbEmplName2Click(Sender: TObject);
begin
//  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure TfrmEmployeeServiceRpt.cmbEmplCode2Exit(Sender: TObject);
begin
{ if (cmbEmplCode.Text <> '') and (cmbEmplCode.ItemIndex = -1) then
    cmbEmplCode.ItemIndex := cmbEmplCode.Items.IndexOf(cmbEmplCode.Text);
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
 }
end;

procedure TfrmEmployeeServiceRpt.cmbEmplCodeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ADOTable1.Open;
ADOTable2.Open;
end;

procedure TfrmEmployeeServiceRpt.cmbEmplName2Exit(Sender: TObject);
begin
{  if (cmbEmplName.Text <> '') and (cmbEmplName.ItemIndex = -1) then
    cmbEmplName.ItemIndex := cmbEmplName.Items.IndexOf(cmbEmplName.Text);
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;}
end;

procedure TfrmEmployeeServiceRpt.cmbEmplNameMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ADOTable1.Open;
ADOTable2.Open;
end;

procedure TfrmEmployeeServiceRpt.cmdPrintClick(Sender: TObject);
var
  qrptEmplSrvc1: TqrptEmplSrvc1;
  qrptEmplSrvc2: TqrptEmplSrvc2;
  qrptEmplSrvc3: TqrptEmplSrvc3;
  qrptEmplSrvc4: TqrptEmplSrvc4;
  qrptEmplSrvc5: TqrptEmplSrvc5;

  c:integer;
  s,s2 : String;
begin
  if (txtFDate.Text <> '') and not IsTrueDate(txtFDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ ê“«—‘ ‰«œ—”  «” .');
    txtFDate.SetFocus;
  end
  else if (txtTDate.Text <> '') and not IsTrueDate(txtTDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ Œ« „Â ê“«—‘ ‰«œ—”  «” .');
    txtTDate.SetFocus;
  end
  else if (txtFDate.Text <> '') and (txtTDate.Text <> '') and
          (txtFDate.Text > txtTDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ ê“«—‘ «“  «—ÌŒ Œ« „Â° »“—ê — «” .');
    txtFDate.SetFocus
  end
  else
  if rdoreport.ItemIndex =0 then
  begin
    if rdoReportType.ItemIndex = 0 then
    {$region 'EmplSrvc1'}
    begin
      gOptions.fromDate := txtFDate.Text;
      gOptions.toDate := txtTDate.Text;
      Application.CreateForm(TqrptEmplSrvc1, qrptEmplSrvc1);
      with qrptEmplSrvc1 do
      begin
        SetWinF_Rpt;
        lblDescribe.Caption := txtdescribe.Text;
        bndDescribe.Enabled := (txtdescribe.Text <> '');
        lblCoName.Caption := gOptions.CoName;
        if gOptions.Shobeh <> '' then
          lblCoName.Caption := lblCoName.Caption + '-' + gOptions.Shobeh;
        lblDate.Caption := CurrentDate;
        bndSign.Enabled := chkSign.Checked;
        if chkSign.Checked then
        begin
          lblReptSign1.Caption := gParams.rptSign1;
          lblReptSign2.Caption := gParams.rptSign2;
          lblReptSign3.Caption := gParams.rptSign3;
          lblReptSign4.Caption := gParams.rptSign4;
          lblReptSign5.Caption := gParams.rptSign5;
        end;
        if (txtFDate.Text <> '') and (txtTDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ') + txtFDate.Text + ('      «  «—ÌŒ : ') + txtTDate.Text
        else if txtFDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ')
        else if txtTDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ : ') + txtTDate.Text
        else
          lblRepDate.Caption := '';
        grpPub.Enabled := (rdoGroup.ItemIndex <> 0);
        grpPub.Height := 0;

        aqryEmplSrvc.Connection := frmDBS.adoConnect;
        aqryEmplSrvc.SQL.Clear;
        aqryEmplSrvc.SQL.Add('SELECT SUM(Recit1_TotalPrice) AS Total, SUM(Recit1_Credit) AS Credit, SUM(Recit1_Cash) AS Cash');
        aqryEmplSrvc.SQL.Add(', Empl_No, Empl_Family, Empl_Name');

        case rdoGroup.ItemIndex of
          0:
          begin
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo');

          end;

          1:
          begin
            aqryEmplSrvc.SQL.Add(', Part_Name');
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1, Parts');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo AND Empl_Part = Part_Code');
          end;

          2:
          begin
            aqryEmplSrvc.SQL.Add(', CoPost_Name');
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1, CoPosts');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo AND Empl_CoPost = CoPost_Code');
          end;

          3:
          begin
            aqryEmplSrvc.SQL.Add(', Dscnt_Name');
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1, Discount');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo AND Empl_Dscnt = Dscnt_No');
          end;

          4:
          begin
            aqryEmplSrvc.SQL.Add(', Depart_Name');
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1, Department');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo AND Empl_Department = Depart_Code');
          end;
        end;
        if gOptions.UserDepart <> 0 then
          if cmbEmplCode.Text <> '' then
            aqryEmplSrvc.SQL.Add('AND Empl_No = ''' + cmbEmplCode.Text + '''')
          else if emplSelected <> '' then
            aqryEmplSrvc.SQL.Add('And Empl_No IN (' + emplSelected + ')');
        if cmbParts.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_Part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1));

        if cmbCoPosts.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));

//        if cmbDepartment.Text <> '' then
//          aqryEmplSrvc.SQL.Add('AND Recit1_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));

        if txtFDate.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Recit1_Date >= ''' + txtFDate.Text + '''');
        if txtTDate.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Recit1_Date <= ''' + txtTDate.Text + '''');


        case rdoGroup.ItemIndex of
          0:
          begin
            aqryEmplSrvc.SQL.Add('GROUP BY Empl_No, Empl_Family, Empl_Name');
            aqryEmplSrvc.SQL.Add('ORDER BY');
            lblPub.Caption := '';
            grpPub.Expression := '';
          end;

          1:
          begin
            aqryEmplSrvc.SQL.Add('GROUP BY Part_Name, Empl_No, Empl_Family, Empl_Name');
            aqryEmplSrvc.SQL.Add('ORDER BY Part_Name,');
            grpPub.Expression := 'aqryEmplSrvc.Part_Name';
            lblPub.Caption := (':„Õ· Œœ„ ');
            txtGroup.DataField := 'Part_Name';
          end;

          2:
          begin
            aqryEmplSrvc.SQL.Add('GROUP BY CoPost_Name, Empl_No, Empl_Family, Empl_Name');
            aqryEmplSrvc.SQL.Add('ORDER BY CoPost_Name,');
            grpPub.Expression := 'aqryEmplSrvc.CoPost_Name';
            lblPub.Caption := (':Ã«Ìê«Â «›—«œ');
            txtGroup.DataField := 'CoPost_Name';
          end;

          3:
          begin
            aqryEmplSrvc.SQL.Add('GROUP BY Dscnt_Name, Empl_No, Empl_Family, Empl_Name');
            aqryEmplSrvc.SQL.Add('ORDER BY Dscnt_Name,');
            grpPub.Expression := 'aqryEmplSrvc.Dscnt_Name';
            lblPub.Caption := (':ê—ÊÂ  Œ›Ì›');
            txtGroup.DataField := 'Dscnt_Name';
          end;

          4:
          begin
            aqryEmplSrvc.SQL.Add('GROUP BY Depart_Name, Empl_No, Empl_Family, Empl_Name');
            aqryEmplSrvc.SQL.Add('ORDER BY Depart_Name,');
            grpPub.Expression := 'aqryEmplSrvc.Depart_Name';
            lblPub.Caption := (':„—ﬂ“ Œœ„« ');
            txtGroup.DataField := 'Depart_Name';
          end;
        end;

        case rdoSort.ItemIndex of
          0: aqryEmplSrvc.SQL.Add('Empl_No');
          1: aqryEmplSrvc.SQL.Add('Empl_Family, Empl_Name');
        end;

        try
          aqryEmplSrvc.Open;
          if aqryEmplSrvc.RecordCount > 0 then
          begin
            if rdoScreen.Checked then
              Preview
            else
              Print;

            aqryEmplSrvc.Close;
          end
          else
            ErrorMessage('ê“«—‘Ì »—«Ì Œœ„«  «” ›«œÂ ‘œÂ Å—”‰· ÊÃÊœ ‰œ«—œ.');
        finally
          Free;
        end
      end;
    end
    {$endregion 'EmplSrvc1'}
    else if rdoReportType.ItemIndex = 1 then
    {$region 'EmplSrvc2'}
    begin
      gOptions.fromDate := txtFDate.Text;
      gOptions.toDate := txtTDate.Text;
      Application.CreateForm(TqrptEmplSrvc2, qrptEmplSrvc2);
      with qrptEmplSrvc2 do
      begin
        SetWinF_Rpt;
        lblDescribe.Caption := txtdescribe.Text;
        bndDescribe.Enabled := (txtdescribe.Text <> '');
        lblCoName.Caption := gOptions.CoName;
        if gOptions.Shobeh <> '' then
          lblCoName.Caption := lblCoName.Caption + '-' + gOptions.Shobeh;
        lblDate.Caption := CurrentDate;
        bndSign.Enabled := chkSign.Checked;
        if chkSign.Checked then
        begin
          lblReptSign1.Caption := gParams.rptSign1;
          lblReptSign2.Caption := gParams.rptSign2;
          lblReptSign3.Caption := gParams.rptSign3;
          lblReptSign4.Caption := gParams.rptSign4;
          lblReptSign5.Caption := gParams.rptSign5;
        end;

        if (txtFDate.Text <> '') and (txtTDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ') + txtFDate.Text + ('      «  «—ÌŒ : ') + txtTDate.Text
        else if txtFDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ')
        else if txtTDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ : ') + txtTDate.Text
        else
          lblRepDate.Caption := '';

        grpPub.Enabled := (rdoGroup.ItemIndex <> 0);
        grpPub.Height := 0;
        grpDate.Height := 0;

        aqryEmplSrvc.Connection := frmDBS.adoConnect;
        aqryEmplSrvc.SQL.Clear;

//kaveh        aqryEmplSrvc.SQL.Add('SELECT EN as EMPL_NO , CR  AS FEE, DT as _DATE, TM as _TIME ,rec as _rec,recc as _recc, empl_Name , empl_Family');
        aqryEmplSrvc.SQL.Add('SELECT EN as EMPL_NO , CR  AS FEE, DT as _DATE, TM as _TIME ,rec as _rec,recc as _recc,  ST as _Status, empl_Name , empl_Family'); //kaveh
        s := ' From ( ';
//kaveh        s:=s+' SELECT ChargeDtl.DTLEMPLNO AS EN, ChargeGrp.GRPPRICE AS CR, ChargeGrp.GrpDATE AS DT, ChargeGrp.GRPTIME AS TM, Readers.Rdr_Name AS rec,Readers.Rdr_Code AS recc ';
        s:=s+' SELECT ChargeDtl.DTLEMPLNO AS EN, ChargeGrp.GRPPRICE AS CR, ChargeGrp.GrpDATE AS DT, ChargeGrp.GRPTIME AS TM, Readers.Rdr_Name AS rec,Readers.Rdr_Code AS recc, 10 as ST '; //kaveh
        s:=s+' FROM Readers INNER JOIN (ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No=ChargeDtl.DTLEMPLNO) ON ';
        s:=s+' ChargeGrp.GRPCODE=ChargeDtl.DTLCODE) ON Readers.Rdr_Code=ChargeDtl.DtlRdr ';

      // s := s + 'SELECT CHARGE_EMPLNO as EN ,  CHARGE_PRICE as CR,CHARGE_DATE as DT,CHARGE_time as TM FROM CHARGE ';
        s := s + 'UNION ';
        s2 := '';
//kaveh        s := s + 'SELECT RECEIPT1.Recit1_EmplNo AS EN, -RECIT1_TOTALPRICE AS CR, RECEIPT1.Recit1_Date AS DT, RECEIPT1.Recit1_Time AS TM, Readers.Rdr_Name AS rec, Readers.Rdr_Code AS recc FROM Readers INNER JOIN RECEIPT1 ON Readers.Rdr_Code = RECEIPT1.Recit1_Rdr ';
        s := s + 'SELECT RECEIPT1.Recit1_EmplNo AS EN, -RECIT1_TOTALPRICE AS CR, RECEIPT1.Recit1_Date AS DT, RECEIPT1.Recit1_Time AS TM, Readers.Rdr_Name AS rec, Readers.Rdr_Code AS recc, '; //kaveh
        s := s + 'RECEIPT1.Recit1_Status as ST FROM Readers INNER JOIN RECEIPT1 ON Readers.Rdr_Code = RECEIPT1.Recit1_Rdr '; //kaveh

        s := s + ')as a';
       // SQL.Add('WHERE dt = ''' + aqryEmplSrvc.FieldByName('Recit1_Date').AsString + '''');
       // SQL.Add('AND en = ''' + aqryEmplSrvc.FieldByName('Empl_No').AsString + '''');

        //aqryEmplSrvc.SQL.Add('SELECT Recit1_No, Recit1_TotalPrice, Recit1_Date, Empl_No, Empl_Family, Empl_Name');

        case rdoGroup.ItemIndex of
          0:
          begin
            aqryEmplSrvc.SQL.Add(s);
            aqryEmplSrvc.SQL.Add(',Employee');
            aqryEmplSrvc.SQL.Add('WHERE Employee.Empl_No = EN');
          end;

          1:
          begin
            aqryEmplSrvc.SQL.Add(', Part_Name');
            aqryEmplSrvc.SQL.Add(s);
            aqryEmplSrvc.SQL.Add(', Employee, Parts');
            aqryEmplSrvc.SQL.Add('WHERE Employee.Empl_No = EN AND Employee.Empl_Part = Part_Code ');
          end;

          2:
          begin
            aqryEmplSrvc.SQL.Add(', CoPost_Name');
            aqryEmplSrvc.SQL.Add(s);
            aqryEmplSrvc.SQL.Add(', Employee, CoPosts ');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = en AND Empl_CoPost = CoPost_Code');
          end;

          3:
          begin
            aqryEmplSrvc.SQL.Add(', Dscnt_Name');
            aqryEmplSrvc.SQL.Add(s);
            aqryEmplSrvc.SQL.Add(',Employee,  Discount  ');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = en AND Empl_Dscnt = Dscnt_No ');
          end;

          4:
          begin
            aqryEmplSrvc.SQL.Add(', Depart_Name');
            aqryEmplSrvc.SQL.Add(s);
            aqryEmplSrvc.SQL.Add(',Employee, Department,Readers ');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = en AND Empl_Department = Depart_Code and Readers.Rdr_Code= rdc');
          end;
        end;

        if {gOptions.UserDepart}cmbDepartment.Text  <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_Department = '+ Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));// + IntToStr(gOptions.UserDepart));

        if cmbEmplCode.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_No = ''' + cmbEmplCode.Text + '''')
        else if emplSelected <> '' then
          aqryEmplSrvc.SQL.Add('And Empl_No IN (' + emplSelected + ')');

        if cmbParts.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_Part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1));


        if cmbCoPosts.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));


        if txtFDate.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND DT >= ''' + txtFDate.Text + '''');
        if txtTDate.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND DT <= ''' + txtTDate.Text + '''');


        case rdoSort.ItemIndex of
          0: aqryEmplSrvc.SQL.Add('ORDER BY Empl_No,');
          1: aqryEmplSrvc.SQL.Add('Empl_Family, Empl_Name,');
        end;

        case rdoGroup.ItemIndex of
          0:
          begin
            aqryEmplSrvc.SQL.Add('dt,tm');
            lblPub.Caption := '';
            txtGroup.DataField := '';
            grpPub.Expression := '';
          end;

          1:
          begin
            aqryEmplSrvc.SQL.Add('Part_Name,dt,tm');
            grpPub.Expression := 'aqryEmplSrvc.Part_Name';
            lblPub.Caption := (':„Õ· Œœ„ ');
            txtGroup.DataField := 'Part_Name';
          end;

          2:
          begin
            aqryEmplSrvc.SQL.Add('CoPost_Name,dt,tm');
            grpPub.Expression := 'aqryEmplSrvc.CoPost_Name';
            lblPub.Caption := (':Å”  ”«“„«‰Ì');
            txtGroup.DataField := 'CoPost_Name';
          end;

          3:
          begin
            aqryEmplSrvc.SQL.Add('Dscnt_Name,dt,tm');
            grpPub.Expression := 'aqryEmplSrvc.Dscnt_Name';
            lblPub.Caption := (':ê—ÊÂ  Œ›Ì›');
            txtGroup.DataField := 'Dscnt_Name';
          end;

          4:
          begin
            aqryEmplSrvc.SQL.Add('Depart_Name,dt,tm');
            grpPub.Expression := 'aqryEmplSrvc.Depart_Name';
            lblPub.Caption := (':„—ﬂ“ Œœ„« ');
            txtGroup.DataField := 'Depart_Name';
          end;
        end;

  //      aqryEmplSrvc.SQL.Add('DT,');


        try
          aqryEmplSrvc.Open;

          if aqryEmplSrvc.RecordCount > 0 then
          begin
            if rdoScreen.Checked then
              Preview
            else
              Print;

            aqryEmplSrvc.Close;
          end
          else
            ErrorMessage('ê“«—‘Ì »—«Ì Œœ„«  «” ›«œÂ ‘œÂ Å—”‰· ÊÃÊœ ‰œ«—œ.');
        finally
          Free;
        end
      end;
    end
    {$EndRegion 'EmplSrvc1'}
    else if rdoReportType.ItemIndex = 2 then
    {$region 'EmplSrvc3'}
    begin
      gOptions.fromDate := txtFDate.Text;
      gOptions.toDate := txtTDate.Text;

      Application.CreateForm(TqrptEmplSrvc3, qrptEmplSrvc3);
      with qrptEmplSrvc3 do
      begin
        SetWinF_Rpt;
        lblDescribe.Caption := txtdescribe.Text;
        bndDescribe.Enabled := (txtdescribe.Text <> '');
        lblCoName.Caption := gOptions.CoName;
        if gOptions.Shobeh <> '' then
          lblCoName.Caption := lblCoName.Caption + '-' + gOptions.Shobeh;
        lblDate.Caption := CurrentDate;
        bndSign.Enabled := chkSign.Checked;
        if chkSign.Checked then
        begin
          lblReptSign1.Caption := gParams.rptSign1;
          lblReptSign2.Caption := gParams.rptSign2;
          lblReptSign3.Caption := gParams.rptSign3;
          lblReptSign4.Caption := gParams.rptSign4;
          lblReptSign5.Caption := gParams.rptSign5;
        end;

        if (txtFDate.Text <> '') and (txtTDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ') + txtFDate.Text + ('      «  «—ÌŒ : ') + txtTDate.Text
        else if txtFDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ')
        else if txtTDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ : ') + txtTDate.Text
        else
          lblRepDate.Caption := '';

        grpEmpl.Height := 0;

        aqryEmplSrvc.Connection := frmDBS.adoConnect;
        aqryEmplSrvc.SQL.Clear;
        aqryEmplSrvc.SQL.Add('SELECT Recit1_No, Recit1_Department, Recit1_TotalPrice, Recit1_Date, Empl_No, Empl_Family, Empl_Name');

        case rdoGroup.ItemIndex of
          0:
          begin
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo');
          end;

          1:
          begin
            aqryEmplSrvc.SQL.Add(', Part_Name');
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1, Parts');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo AND Empl_Part = Part_Code');
          end;

          2:
          begin
            aqryEmplSrvc.SQL.Add(', CoPost_Name');
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1, CoPosts');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo AND Empl_CoPost = CoPost_Code');
          end;

          3:
          begin
            aqryEmplSrvc.SQL.Add(', Dscnt_Name');
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1, Discount');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo AND Empl_Dscnt = Dscnt_No');
          end;

          4:
          begin
            aqryEmplSrvc.SQL.Add(', Depart_Name');
            aqryEmplSrvc.SQL.Add('FROM Employee, Receipt1, Department');
            aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit1_EmplNo AND Empl_Department = Depart_Code');
          end;
        end;

        if gOptions.UserDepart <> 0 then
          aqryEmplSrvc.SQL.Add('AND Empl_Department = ' + IntToStr(gOptions.UserDepart));

        if cmbEmplCode.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_No = ''' + cmbEmplCode.Text + '''')
        else if emplSelected <> '' then
          aqryEmplSrvc.SQL.Add('And Empl_No IN (' + emplSelected + ')');

        if cmbParts.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_Part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1));

        if cmbDepartment.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));

        if cmbCoPosts.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));


        if txtFDate.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Recit1_Date >= ''' + txtFDate.Text + '''');
        if txtTDate.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Recit1_Date <= ''' + txtTDate.Text + '''');


        case rdoSort.ItemIndex of
          0:
          begin
            aqryEmplSrvc.SQL.Add('ORDER BY Empl_No');
            grpEmpl.Expression := 'aqryEmplSrvc.Empl_No';
          end;
          1:
          begin
            aqryEmplSrvc.SQL.Add('ORDER BY Empl_Family, Empl_Name');
            grpEmpl.Expression := 'aqryEmplSrvc.Empl_Family + aqryEmplSrvc.Empl_Family.Empl_Name';
          end;
        end;


        aqryEmplSrvc.SQL.Add(', Recit1_Date');


        try
          aqryEmplSrvc.Open;
          if aqryEmplSrvc.RecordCount > 0 then
          begin
            if rdoScreen.Checked then
              Preview
            else
              Print;

            aqryEmplSrvc.Close;
          end
          else
            ErrorMessage('ê“«—‘Ì »—«Ì Œœ„«  «” ›«œÂ ‘œÂ Å—”‰· ÊÃÊœ ‰œ«—œ.');
        finally
          Free;
        end
      end;
    end
    {$EndRegion 'EmplSrvc3'}
    else if rdoReportType.ItemIndex = 3 then
    {$region 'EmplSrvc4'}
    begin
      gOptions.fromDate := txtFDate.Text;
      gOptions.toDate := txtTDate.Text;

      Application.CreateForm(TqrptEmplSrvc4, qrptEmplSrvc4);
      with qrptEmplSrvc4 do
      begin
        SetWinF_Rpt;
        lblDescribe.Caption := txtdescribe.Text;
        bndDescribe.Enabled := (txtdescribe.Text <> '');
        lblCoName.Caption := gOptions.CoName;
        if gOptions.Shobeh <> '' then
          lblCoName.Caption := lblCoName.Caption + '-' + gOptions.Shobeh;
        lblDate.Caption := CurrentDate;
        bndSign.Enabled := chkSign.Checked;
        if chkSign.Checked then
        begin
          lblReptSign1.Caption := gParams.rptSign1;
          lblReptSign2.Caption := gParams.rptSign2;
          lblReptSign3.Caption := gParams.rptSign3;
          lblReptSign4.Caption := gParams.rptSign4;
          lblReptSign5.Caption := gParams.rptSign5;
        end;

        if (txtFDate.Text <> '') and (txtTDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ') + txtFDate.Text + ('      «  «—ÌŒ : ') + txtTDate.Text
        else if txtFDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ')
        else if txtTDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ : ') + txtTDate.Text
        else
          lblRepDate.Caption := '';

        aqryEmplSrvc.Connection := frmDBS.adoConnect;
        aqryEmplSrvc.SQL.Clear;
        aqryEmplSrvc.SQL.Add('SELECT SUM(Recit2_SrvcNo) AS srvcNo, SUM(Recit2_SrvcNo * Recit2_Price) AS srvcPrc');
        aqryEmplSrvc.SQL.Add(', Empl_No, Empl_Family, Empl_Name, S_Code, S_Name');
        aqryEmplSrvc.SQL.Add('FROM Employee, Receipt2, Services');
        aqryEmplSrvc.SQL.Add('WHERE Empl_No = Recit2_EmplNo AND Recit2_Srvc = S_Code');

        if gOptions.UserDepart <> 0 then
          aqryEmplSrvc.SQL.Add('AND Empl_Department = ' + IntToStr(gOptions.UserDepart));

        if cmbEmplCode.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_No = ''' + cmbEmplCode.Text + '''')
        else if emplSelected <> '' then
          aqryEmplSrvc.SQL.Add('And Empl_No IN (' + emplSelected + ')');

        if cmbParts.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_Part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1));

        if cmbDepartment.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));

        if cmbCoPosts.Text <> '' then
          aqryEmplSrvc.SQL.Add('AND Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));


  //      if txtFDate.Text <> '' then
  //        aqryEmplSrvc.SQL.Add('AND Recit2_Date >= ''' + txtFDate.Text + '''');
  //      if txtTDate.Text <> '' then
  //        aqryEmplSrvc.SQL.Add('AND Recit2_Date <= ''' + txtTDate.Text + '''');


        aqryEmplSrvc.SQL.Add('GROUP BY Empl_No, Empl_Family, Empl_Name, S_Code, S_Name ');

        case rdoSort.ItemIndex of
          0:
          begin
            aqryEmplSrvc.SQL.Add('ORDER BY Empl_No, S_Code');
            grpEmpl.Expression := 'aqryEmplSrvc.Empl_No';
          end;

          1:
          begin
            aqryEmplSrvc.SQL.Add('ORDER BY Empl_Family, Empl_Name, S_Code');
            grpEmpl.Expression := 'aqryEmplSrvc.Empl_Family + aqryEmplSrvc.Empl_Name';
          end;
        end;

        try
          aqryEmplSrvc.Open;
          if aqryEmplSrvc.RecordCount > 0 then
          begin
            if rdoScreen.Checked then
              Preview
            else
              Print;

            aqryEmplSrvc.Close;
          end
          else
            ErrorMessage('ê“«—‘Ì »—«Ì Œœ„«  «” ›«œÂ ‘œÂ Å—”‰· ÊÃÊœ ‰œ«—œ.');
        finally
          Free;
        end
      end;
    end;
  {$Endregion 'EmplSrvc4'}
  end
  else
  {$region 'EmplSrvc5'}
  begin
    Application.CreateForm(TqrptEmplSrvc5,qrptEmplSrvc5);
    with  qrptEmplSrvc5 do
    begin
      lblCoName.Caption := gOptions.CoName;
      lblDate.Caption := CurrentDate;
      lblDescribe.Caption := txtdescribe.Text;
//kaveh is
      if cmbParts.ItemIndex <> -1 then
      begin
        lblPart.Caption :=  '„Õ· Œœ„  : ' + Copy(cmbParts.Text, Pos('-', cmbParts.Text)+1,Length(cmbParts.Text)-Pos('-', cmbParts.Text));
        QRLabel1.Enabled := False;
        QRShape3.Enabled := False;
        QRDBText3.Enabled := False;
        QRShape4.Enabled := False;
      end
      else
      begin
        lblPart.Caption :=  '';
        QRLabel1.Enabled := True;
        QRShape3.Enabled := True;
        QRDBText3.Enabled := True;
        QRShape4.Enabled := True;
      end;
//kaveh ie
      if (txtFDate.Text <> '') and (txtTDate.Text <> '') then
        lblRepDate.Caption := ('«“  «—ÌŒ : ') + txtFDate.Text + ('      «  «—ÌŒ : ') + txtTDate.Text
      else if txtFDate.Text <> '' then
        lblRepDate.Caption := ('«“  «—ÌŒ : ')
      else if txtTDate.Text <> '' then
        lblRepDate.Caption := (' «  «—ÌŒ : ') + txtTDate.Text
      else
        lblRepDate.Caption := '';
  //    gOptions.fromDate := txtfDate.Text;
      aqryEmplSrvc.Connection := frmDBS.adoConnect;
      aqryEmplSrvc.Close;
      aqryEmplSrvc.sql.Clear ;
      if (chkViewManfi.Checked) or (chkViewZero.Checked) then
        aqryEmplSrvc.SQL.Add('SELECT * from (');
      aqryEmplSrvc.SQL.Add('SELECT EN as EMPL_NO ,sum(case when CR>0 then CR else 0 end) as Charge ,sum(case when CR<0 then -CR else 0 end) as Buy, sum(case when CR2<0 then -CR2 else 0 end) as DelRemain ,sum(cr + CR2) as remain, empl_Name , empl_Family ,empl_part  from'+
                           '( '+
                             'select * from '+
                             '( '+
                               'SELECT ChargeDtl.DTLEMPLNO AS EN, ChargeGrp.GRPPRICE AS CR, 0 AS CR2, ChargeGrp.GrpDATE AS DT, ChargeGrp.GRPTIME AS TM '+
                               'FROM Readers ,ChargeGrp ,Employee,ChargeDtl '+
                               'where Employee.Empl_No=ChargeDtl.DTLEMPLNO and ChargeGrp.GRPCODE=ChargeDtl.DTLCODE and  Readers.Rdr_Code=ChargeDtl.DtlRdr '+
                               'UNION '+
//kaveh                               'SELECT RECEIPT1.Recit1_EmplNo AS EN, (case when RECEIPT1.Recit1_Status <> 14 then -RECIT1_TOTALPRICE else 0 end) As CR, (case when RECEIPT1.Recit1_Status = 14 then -RECIT1_TOTALPRICE else 0 end) As CR2, '+
                               'SELECT RECEIPT1.Recit1_EmplNo AS EN, (case when (RECEIPT1.Recit1_Status <> 14 or RECEIPT1.Recit1_Status is null) then -RECIT1_TOTALPRICE else 0 end) As CR, (case when RECEIPT1.Recit1_Status = 14 then -RECIT1_TOTALPRICE else 0 end) As CR2, '+
                               'RECEIPT1.Recit1_Date AS DT, RECEIPT1.Recit1_Time AS TM FROM RECEIPT1 '+
                             ')as dtCntrl where 1=1');
{kaveh
      aqryEmplSrvc.SQL.Add('SELECT EN as EMPL_NO ,sum(case when CR>0 then CR else 0 end) as Charge ,sum(case when CR<0 then -CR else 0 end) as Buy ,sum(cr) as remain, empl_Name , empl_Family ,empl_part  from'+
                           '( '+
                             'select * from '+
                             '( '+
                               'SELECT ChargeDtl.DTLEMPLNO AS EN, ChargeGrp.GRPPRICE AS CR, ChargeGrp.GrpDATE AS DT, ChargeGrp.GRPTIME AS TM '+
                               'FROM Readers ,ChargeGrp ,Employee,ChargeDtl '+
                               'where Employee.Empl_No=ChargeDtl.DTLEMPLNO and ChargeGrp.GRPCODE=ChargeDtl.DTLCODE and  Readers.Rdr_Code=ChargeDtl.DtlRdr '+
                               'UNION '+
                               'SELECT RECEIPT1.Recit1_EmplNo AS EN, -RECIT1_TOTALPRICE AS CR, RECEIPT1.Recit1_Date AS DT, RECEIPT1.Recit1_Time AS TM FROM RECEIPT1 '+
                             ')as dtCntrl where 1=1');
kaveh}
                             if txtFDate.Text <> '' then
                               aqryEmplSrvc.SQL.Add('AND DT >= ''' + txtFDate.Text + '''');
                             if txtTDate.Text <> '' then
                               aqryEmplSrvc.SQL.Add('AND DT <= ''' + txtTDate.Text + '''');
                           aqryEmplSrvc.SQL.Add(')as a ,Employee WHERE Employee.Empl_No = EN ');
      c:=1;
      if cmbEmplCode.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Employee.Empl_No = ''' + cmbEmplCode.Text + '''')
      else
      if emplSelected <> '' then
        aqryEmplSrvc.SQL.Add('And Employee.Empl_No IN (' + emplSelected + ')');

  //    if emplSelected <> '' then
  //      aqryEmplSrvc.SQL.Add('And Employee.Empl_No IN (' + emplSelected + ')');

      if cmbParts.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Employee.Empl_Part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1));

      if cmbDepartment.Text <> '' then
        aqryEmplSrvc.SQL.Add(' AND Employee.Empl_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));


      if cmbCoPosts.Text <> '' then
        aqryEmplSrvc.SQL.Add(' AND Employee.Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));

      aqryEmplSrvc.SQL.Add('group by EN , empl_Name , empl_Family,empl_part');
      if (chkViewManfi.Checked) and (chkViewZero.Checked) then
        aqryEmplSrvc.SQL.Add(')b where (remain < 0) and (Buy <> 0 ) ')
      else if (chkViewManfi.Checked) then
        aqryEmplSrvc.SQL.Add(')b where remain < 0')
      else if (chkViewZero.Checked) then
        aqryEmplSrvc.SQL.Add(')b where Buy <> 0');

      aqryEmplSrvc.Open;
      if aqryEmplSrvc.RecordCount > 0 then
      begin
        if rdoScreen.Checked then
          Preview
        else
          Print;
        free;
      end
      else
      begin
        ErrorMessage('ê“«—‘Ì »—«Ì Œœ„«  «” ›«œÂ ‘œÂ Å—”‰· ÊÃÊœ ‰œ«—œ.');
        free;
      end;
    end;
  end;
  {$EndRegion 'EmplSrvc5'}
end;

procedure TfrmEmployeeServiceRpt.btnEmplSelClick(Sender: TObject);
begin
ADOTable1.Close;
ADOTable2.Close;
//  if cmbEmplCode.Items.Count > 0 then
//  begin
    frmSelect.selType := SEL_PRS;
    if frmSelect.ShowModal = mrOK then
      begin
      emplSelected := frmSelect.dataSelected ;

//    else
//      emplSelected := '';
      end;

end;

procedure TfrmEmployeeServiceRpt.rdoreportClick(Sender: TObject);
begin
  chkViewManfi.Enabled :=(rdoreport.ItemIndex = 1);
  chkViewZero.Enabled :=(rdoreport.ItemIndex = 1);
end;

procedure TfrmEmployeeServiceRpt.rdoReportTypeClick(Sender: TObject);
begin
  rdoGroup.Enabled := (rdoReportType.ItemIndex < 3);
end;

procedure TfrmEmployeeServiceRpt.txtFDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmEmployeeServiceRpt.txtFDateExit(Sender: TObject);
begin
  with txtFDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmEmployeeServiceRpt.txtTDateExit(Sender: TObject);
begin
  with txtTDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmEmployeeServiceRpt.FormDestroy(Sender: TObject);
begin
  frmSelect.Free;
end;

procedure TfrmEmployeeServiceRpt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_DELETE  then
begin
ADOTable1.Close;
ADOTable2.Close;
end;

end;

procedure TfrmEmployeeServiceRpt.ADOTable1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmEmployeeServiceRpt.ADOTable2CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('te').AsString := DataSet.FieldByName('Empl_Family').AsString + '-' +
                                                DataSet.FieldByName('Empl_Name').AsString;
end;

procedure TfrmEmployeeServiceRpt.BitBtn1Click(Sender: TObject);

var
 qrptEmplSrvc6: TqrptEmplSrvc6;
 s:string;
 begin
     frmSelect.selType := SEL_DORE;
     if frmSelect.ShowModal = mrOK then
      BEGIN
      departSelected := frmSelect.dataSelected ;

      END
      else
      BEGIN
       departSelected := '';
      END;
      IF   departSelected <> '' THEN
       BEGIN
         Application.CreateForm(TqrptEmplSrvc6, qrptEmplSrvc6);
         with qrptEmplSrvc6 do
          begin
            ADOTable1.Connection :=frmDBS.adoConnect ;
            ADOTable2.Connection :=frmDBS.adoConnect ;
            ADOTable3.Connection :=frmDBS.adoConnect ;
            ADOTable1.Open;
            ADOTable2.Open;
            ADOTable3.Open;

            //   if Edit1.Text <> ''   then
            //     begin
            //      if Edit2.Text <> '' then
            //       begin
            //       s:='GrpCode > = ''' + Edit1.Text   +'''';
            //       s:=s+ ' and GrpCode <= '''+ Edit2.Text  +'''';
            ADOTable1.Filtered:=false;
            ADOTable1.Filter:= 'grpcode= '+ departSelected;

            ADOTable1.Filtered:=true;

            //       end;
            //    end;
            Preview;

            Free;
         end;
      END;

   end;

procedure TfrmEmployeeServiceRpt.Button1Click(Sender: TObject);
begin

    frmSelect.selType := SEL_DORE;

    if frmSelect.ShowModal = mrOK then
      BEGIN
      departSelected := frmSelect.dataSelected ;

      END
      else
      BEGIN
       departSelected := '';
      END;
end;

end.
{
SELECT EN as EMPL_NO , CR  AS FEE, DT as _DATE, TM as _TIME ,rec as _rec,recc as _recc From, empl_Name , empl_Family
(
  SELECT ChargeDtl.DTLEMPLNO AS EN, ChargeGrp.GRPPRICE AS CR, ChargeGrp.GrpDATE AS DT, ChargeGrp.GRPTIME AS TM, Readers.Rdr_Name AS rec,Readers.Rdr_Code AS recc  FROM Readers
  INNER JOIN
  (
    ChargeGrp INNER JOIN
    (
      Employee INNER JOIN ChargeDtl ON Employee.Empl_No=ChargeDtl.DTLEMPLNO
    ) ON  ChargeGrp.GRPCODE=ChargeDtl.DTLCODE
  ) ON Readers.Rdr_Code=ChargeDtl.DtlRdr
  UNION
  SELECT RECEIPT1.Recit1_EmplNo AS EN, -RECIT1_TOTALPRICE AS CR, RECEIPT1.Recit1_Date AS DT, RECEIPT1.Recit1_Time AS TM, Readers.Rdr_Name AS rec, Readers.Rdr_Code AS recc FROM Readers INNER JOIN RECEIPT1 ON Readers.Rdr_Code = RECEIPT1.Recit1_Rdr
)as a ,Employee
WHERE Employee.Empl_No = EN AND Empl_No = '20209440' AND DT >= '1385/11/01' AND DT <= '1385/11/01'
ORDER BY Empl_No,dt,tm

}
