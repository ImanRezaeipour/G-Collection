unit EmpSrvRp2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, DosMove, XStringGrid, Grids,
  ExtCtrls;

type
  TfrmEmployeeServiceRpt2 = class(TForm)
    lbl1: TLabel;
    cmbEmplCode: TComboBox;
    cmbEmplName: TComboBox;
    btnEmplSel: TBitBtn;
    lbl2: TLabel;
    cmbParts: TComboBox;
    lbl3: TLabel;
    cmbDepartment: TComboBox;
    lbl4: TLabel;
    cmbCoPosts: TComboBox;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    chkSign: TCheckBox;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    DosMove1: TDosMove;
    rdoSort: TRadioGroup;
    rdoReportType: TRadioGroup;
    rdoGroup: TRadioGroup;
    lbl8: TLabel;
    txtdescribe: TEdit;
    BitBtn1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbEmplCodeClick(Sender: TObject);
    procedure cmbEmplNameClick(Sender: TObject);
    procedure cmbEmplCodeExit(Sender: TObject);
    procedure cmbEmplNameExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnEmplSelClick(Sender: TObject);
    procedure rdoReportTypeClick(Sender: TObject);
    procedure txtFDateKeyPress(Sender: TObject; var Key: Char);
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
  frmEmployeeServiceRpt2 : TfrmEmployeeServiceRpt2;



implementation

uses Funcs, Globals, DBS, MSGS, Keyboard, DateProc, Select, FntSel,
  RpSrvEm1,RpSrvEm5,RpSrvEm6, RpSrvEm2, RpSrvEm3, RpSrvEm4, QuickRpt;

{$R *.dfm}

procedure TfrmEmployeeServiceRpt2.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmEmployeeServiceRpt2));
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
 // lbl6.Caption := (lbl6.Caption);
 // lbl7.Caption := (lbl7.Caption);
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



procedure TfrmEmployeeServiceRpt2.FormCreate(Sender: TObject);
begin

  SetWinF;
  Application.CreateForm(TfrmSelect, frmSelect);
  emplSelected := '';
  departSelected := '';

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM chargegrp');
    if gOptions.UserDepart <> 0 then
      SQL.Add('WHERE GrpCode = ' + IntToStr(gOptions.UserDepart));
    SQL.Add('ORDER BY GrpCode');
    Open;
    while not Eof do
    begin

      cmbEmplCode.Items.Add(inttostr(FieldByName('GrpCode').Asinteger));
      cmbEmplName.Items.Add(FieldByName('Grpdate').AsString );


      Next;
    end;
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

 end;

procedure TfrmEmployeeServiceRpt2.cmbEmplCodeClick(Sender: TObject);
begin
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure TfrmEmployeeServiceRpt2.cmbEmplNameClick(Sender: TObject);
begin
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure TfrmEmployeeServiceRpt2.cmbEmplCodeExit(Sender: TObject);
begin
  if (cmbEmplCode.Text <> '') and (cmbEmplCode.ItemIndex = -1) then
    cmbEmplCode.ItemIndex := cmbEmplCode.Items.IndexOf(cmbEmplCode.Text);
  cmbEmplName.ItemIndex := cmbEmplCode.ItemIndex;
end;

procedure TfrmEmployeeServiceRpt2.cmbEmplNameExit(Sender: TObject);
begin
  if (cmbEmplName.Text <> '') and (cmbEmplName.ItemIndex = -1) then
    cmbEmplName.ItemIndex := cmbEmplName.Items.IndexOf(cmbEmplName.Text);
  cmbEmplCode.ItemIndex := cmbEmplName.ItemIndex;
end;

procedure TfrmEmployeeServiceRpt2.cmdPrintClick(Sender: TObject);
var
  qrptEmplSrvc1: TqrptEmplSrvc1;
  qrptEmplSrvc2: TqrptEmplSrvc2;
  qrptEmplSrvc3: TqrptEmplSrvc3;
  qrptEmplSrvc4: TqrptEmplSrvc4;
  qrptEmplSrvc5: TqrptEmplSrvc5;


  s : string;
begin






  if rdoReportType.ItemIndex = 0 then
  begin
   // gOptions.fromDate := txtFDate.Text;
   // gOptions.toDate := txtTDate.Text;

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
        aqryEmplSrvc.SQL.Add('AND Empl_Department = ' + IntToStr(gOptions.UserDepart));

      if cmbEmplCode.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Empl_No = ''' + cmbEmplCode.Text + '''')
      else if emplSelected <> '' then
        aqryEmplSrvc.SQL.Add('And Empl_No IN (' + emplSelected + ')');

      if cmbParts.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Empl_Part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1));

      if cmbCoPosts.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));


      if cmbDepartment.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Recit1_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));

     

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
  else if rdoReportType.ItemIndex = 1 then
  begin
//    gOptions.fromDate := txtFDate.Text;
 //   gOptions.toDate := txtTDate.Text;

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

   
        lblRepDate.Caption := '';

      grpPub.Enabled := (rdoGroup.ItemIndex <> 0);
      grpPub.Height := 0;
      grpDate.Height := 0;

      aqryEmplSrvc.Connection := frmDBS.adoConnect;
      aqryEmplSrvc.SQL.Clear;

      aqryEmplSrvc.SQL.Add('SELECT EN as EMPL_NO , CR  AS FEE, DT as _DATE , TM as  _TIME ,EMPLOYEE.*');
      s := ' From ( ';
      s:=s+' SELECT ChargeDtl.DtlEmplNo as EN, ChargeGrp.GrpPrice as CR, ChargeGrp.GrpDate as DT, ChargeGrp.GrpTime as TM ';
      s:=s+' FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode ';
    // s := s + 'SELECT CHARGE_EMPLNO as EN ,  CHARGE_PRICE as CR,CHARGE_DATE as DT,CHARGE_time as TM FROM CHARGE ';
      s := s + 'UNION ';
      s := s + 'SELECT RECIT1_EMPLNO as EN , -RECIT1_TOTALPRICE as CR , RECIT1_DATE as DT , RECIT1_TIME as TM FROM RECEIPT1 ';
      s := s + ')';
  //    SQL.Add('WHERE dt = ''' + aqryEmplSrvc.FieldByName('Recit1_Date').AsString + '''');
  //    SQL.Add('AND en = ''' + aqryEmplSrvc.FieldByName('Empl_No').AsString + '''');

//      aqryEmplSrvc.SQL.Add('SELECT Recit1_No, Recit1_TotalPrice, Recit1_Date, Empl_No, Empl_Family, Empl_Name');

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
          aqryEmplSrvc.SQL.Add('WHERE Employee.Empl_No = EN AND Employee.Empl_Part = Part_Code');
        end;

        2:
        begin
          aqryEmplSrvc.SQL.Add(', CoPost_Name');
          aqryEmplSrvc.SQL.Add(s);
          aqryEmplSrvc.SQL.Add(', Employee, CoPosts');
          aqryEmplSrvc.SQL.Add('WHERE Empl_No = en AND Empl_CoPost = CoPost_Code');
        end;

        3:
        begin
          aqryEmplSrvc.SQL.Add(', Dscnt_Name');
          aqryEmplSrvc.SQL.Add(s);
          aqryEmplSrvc.SQL.Add(',Employee,  Discount');
          aqryEmplSrvc.SQL.Add('WHERE Empl_No = en AND Empl_Dscnt = Dscnt_No');
        end;

        4:
        begin
          aqryEmplSrvc.SQL.Add(', Depart_Name');
          aqryEmplSrvc.SQL.Add(s);
          aqryEmplSrvc.SQL.Add(',Employee,  Department');
          aqryEmplSrvc.SQL.Add('WHERE Empl_No = en AND Empl_Department = Depart_Code');
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


      if cmbCoPosts.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));


     

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
  else if rdoReportType.ItemIndex = 2 then
  begin
   
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
  else if rdoReportType.ItemIndex = 3 then
  begin
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

 end
 else
 begin
 Application.CreateForm(TqrptEmplSrvc5,qrptEmplSrvc5);
 with  qrptEmplSrvc5 do
  begin
       
        lblDate.Caption := CurrentDate;
    
        aqryEmplSrvc.Connection := frmDBS.adoConnect;
        aqryEmplSrvc.Close;
        aqryEmplSrvc.sql.Clear ;
        aqryEmplSrvc.SQL.Add('SELECT ChargeDtl.DtlEmplNo, Sum(ChargeGrp.GrpPrice) AS SumOfGrpPrice, Employee.Empl_Name, Employee.Empl_Family, Employee.Empl_ID, Parts.Part_Name '+
                             'FROM ChargeGrp INNER JOIN (Parts INNER JOIN (Employee INNER JOIN ChargeDtl ON Employee.Empl_No = ChargeDtl.DtlEmplNo) ON Parts.Part_Code = Employee.Empl_Part) ON ChargeGrp.GrpCode = ChargeDtl.DtlCode ');

                           

       
      if gOptions.UserDepart <> 0 then


      if cmbEmplCode.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Employee.Empl_No = ''' + cmbEmplCode.Text + '''')
      else if emplSelected <> '' then
        aqryEmplSrvc.SQL.Add('And Employee.Empl_No IN (' + emplSelected + ')');

      if cmbParts.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Employee.Empl_Part = ' + Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1));

      if cmbDepartment.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Employee.Empl_Department = ' + Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1));

      if cmbCoPosts.Text <> '' then
        aqryEmplSrvc.SQL.Add('AND Employee.Empl_CoPost = ' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1));


        aqryEmplSrvc.SQL.Add(' GROUP BY ChargeDtl.DtlEmplNo, Employee.Empl_Name, Employee.Empl_Family, Employee.Empl_ID, Parts.Part_Name '+
                             ' ORDER BY Sum(ChargeGrp.GrpPrice)');


         aqryEmplSrvc.Open;
         if rdoScreen.Checked then
           begin
            Preview
           end
           else
           begin
             Print;
            end;
           free;
           end;


  end;

end;

procedure TfrmEmployeeServiceRpt2.btnEmplSelClick(Sender: TObject);
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

procedure TfrmEmployeeServiceRpt2.rdoReportTypeClick(Sender: TObject);
begin
  rdoGroup.Enabled := (rdoReportType.ItemIndex < 3);
end;

procedure TfrmEmployeeServiceRpt2.txtFDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmEmployeeServiceRpt2.FormDestroy(Sender: TObject);
begin
  frmSelect.Free;
end;

procedure TfrmEmployeeServiceRpt2.BitBtn1Click(Sender: TObject);

var
 qrptEmplSrvc6: TqrptEmplSrvc6;
 s:string;
 a,b,c:string;

 begin
   if cmbEmplCode.Text  <> '' then
     begin
      departSelected:=cmbEmplCode.Text ;
     end;
      IF   departSelected <> '' THEN
       BEGIN
         Application.CreateForm(TqrptEmplSrvc6, qrptEmplSrvc6);
         with qrptEmplSrvc6 do
          begin
            SetWinF_Rpt;
            lblCoName.Caption := gOptions.CoName;
            ADOTable1.Connection :=frmDBS.adoConnect ;
            ADOTable2.Connection :=frmDBS.adoConnect ;
            ADOTable3.Connection :=frmDBS.adoConnect ;
            ADOTable1.Open;
            ADOTable2.Open;
            ADOTable3.Open;
            lblDate.Caption := CurrentDate;

            //   if Edit1.Text <> ''   then
            //     begin
            //      if Edit2.Text <> '' then
            //       begin
            //       s:='GrpCode > = ''' + Edit1.Text   +'''';
            //       s:=s+ ' and GrpCode <= '''+ Edit2.Text  +'''';
//            ADOTable3.Filtered:=false;
//            ADOTable3.Filter:= 'Empl_Part = '+QuotedStr (a) +'and Empl_CoPost='+QuotedStr(c) + ' and  Empl_Department='+QuotedStr(b) ;
//
//            ADOTable3.Filtered:=true;
//            ADOTable1.Filtered:=false;
//      if gOptions.UserDepart <> 0 then
//            b:= inttostr(gOptions.UserDepart);
//
//      if cmbParts.Text <> '' then
//        a:= Copy(cmbParts.Text, 1, Pos('-', cmbParts.Text)-1);
//
//      if cmbDepartment.Text <> '' then
//         b:= Copy(cmbDepartment.Text, 1, Pos('-', cmbDepartment.Text)-1);
//
//      if cmbCoPosts.Text <> '' then
//        c:= Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1);

            ADOTable1.Filter:= 'grpcode= '+ departSelected;

            ADOTable1.Filtered:=true;



            //    end;
            Preview;

            Free;
         end;
      END else
      begin
       Application.CreateForm(TqrptEmplSrvc6, qrptEmplSrvc6);
         with qrptEmplSrvc6 do
          begin
            SetWinF_Rpt;
            lblCoName.Caption := gOptions.CoName;
            ADOTable1.Connection :=frmDBS.adoConnect ;
            ADOTable2.Connection :=frmDBS.adoConnect ;
            ADOTable3.Connection :=frmDBS.adoConnect ;
            ADOTable1.Open;
            ADOTable2.Open;
            ADOTable3.Open;
            lblDate.Caption := CurrentDate;
            ADOTable1.Filter:= '';

            ADOTable1.Filtered:=true;
            //end;
            Preview;

            Free;

      end;
      end;

   end;

procedure TfrmEmployeeServiceRpt2.Button1Click(Sender: TObject);
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

SELECT EN as EMPL_NO , CR  AS FEE, DT as _DATE , TM as _TIME ,EMPLOYEE.* , Part_Name From
(
SELECT CHARGE_EMPLNO as EN ,  CHARGE_PRICE as CR,CHARGE_DATE as DT,CHARGE_time as TM FROM CHARGE
UNION
SELECT RECIT1_EMPLNO as EN , -RECIT1_TOTALPRICE as CR , RECIT1_DATE as DT , RECIT1_TIME as TM FROM RECEIPT1
) , Employee, Receipt1, Parts
WHERE Empl_No = Recit1_EmplNo AND Empl_Part = Part_Code AND Empl_No = '85304553' AND DT >= '1385/05/01' AND DT <= '1385/06/06'
ORDER BY Part_Name,dt,tm,DT,Empl_No
