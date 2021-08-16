unit AllFodRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,slctPart,
  MSGs, Keyboard, RpAllFod, RpAllFod2, RpAllFdp;

type
  TfrmAllFoodsRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    txtFromDate: TEdit;
    Label7: TLabel;
    txtToDate: TEdit;
    chkSign: TCheckBox;
    Label2: TLabel;
    Label6: TLabel;
    cmbJobs: TComboBox;
    Label8: TLabel;
    cmbBuilding: TComboBox;
    Label9: TLabel;
    cmbTerminal: TComboBox;
    BitBtn2: TBitBtn;
    txtParts: TEdit;
    BitBtn1: TBitBtn;
    cmbreserve7: TComboBox;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    rbdate: TRadioButton;
    rbpart: TRadioButton;
    rbpartdate: TRadioButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
   partcode:string; { Public declarations }
  end;


implementation

uses
  ComTools, DBS_Proc;

{$R *.DFM}

procedure TfrmAllFoodsRpt.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label7.Caption := (Label7.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmAllFoodsRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

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

  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM readers');
  qry.Open;
  while not qry.Eof do
  begin
    cmbTerminal.Items.Add(qry.FieldByName('r_Code').AsString + '-' + qry.FieldByName('r_Name').AsString);
    qry.Next;
  end;
  qry.Close;

  qry.Free;

end;

procedure TfrmAllFoodsRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmAllFoodsRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmAllFoodsRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmAllFoodsRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoScreen.Checked then
      rdoScreen.SetFocus
    else
      rdoPrinter.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmAllFoodsRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmAllFoodsRpt.BitBtn1Click(Sender: TObject);
begin
  PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);

end;

procedure TfrmAllFoodsRpt.chkSignKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmAllFoodsRpt.cmdPrintClick(Sender: TObject);
var
  frmRptAllFood : TfrmRptAllFood;
  frmRptAllFood2 : TfrmRptAllFood2;
  frmRptAllFoodpart : TfrmRptAllFoodpart;
  part_lcode:string;
  qry : TADOQuery;
  i : integer;
  s : string;
begin
  if rbpart.Checked
  then begin
    part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';
    if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
    begin
      ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
      txtFromDate.SetFocus;
    end
    else if (txtToDate.Text <> '') and not IsTrueDate(txtToDate.Text) then
    begin
      ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
      txtToDate.SetFocus;
    end
    else
    begin
      Mouse_Wait;
      Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');
      Application.CreateForm(TfrmRptAllFoodpart, frmRptAllFoodpart);
      with frmRptAllFoodpart do
      begin
        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := ' «  «—ÌŒ :' + txtToDate.Text
        else
          lblRepDate.Caption := '';

        lblRepDate.Caption := (lblRepDate.Caption);

        with qry do
        begin
          qry := TADOQuery.Create(Application);
          Connection := frmDBS.DBConnection;
          SQL.Add('select * from parts where len(p_code) = 2 order by p_code');
          open;
        end;
        qryAllFood.SQL.Clear;

        qry.First;
        i := 1;
        s := 'guest';
//        if not qry.eof then
//          s := s + ' , p1';
//        qry.Next;
//        i := i+1;
        while not qry.eof do
        begin
          s := s + ' + p' + inttostr(i);
          i := i+1;
          qry.Next;
        end;


        qryAllFood.SQL.Add('SELECT *, (' + S + ') AS Total from');

        qryAllFood.SQL.Add(' (SELECT fish_date');
        qryAllFood.SQL.Add('  ,SUM (CASE p_isGuest WHEN 1 THEN amount ELSE 0 END) AS Guest');
        qry.First;
        i := 1;
        while not qry.eof do
        begin
          qryAllFood.SQL.Add('  ,SUM (CASE p_parts WHEN ' +  IntToStr(i) + ' THEN amount ELSE 0 END) AS P' +  IntToStr(i));
          i := i+1;
          qry.Next;
        end;

        qryAllFood.SQL.Add('  FROM(SELECT p_isGuest,p_parts ,fish_date,count(*) as amount');
        qryAllFood.SQL.Add('       FROM Persons, Fish, FishFood');
        qryAllFood.SQL.Add('       WHERE Fish_PCode = P_BarCode');
        qryAllFood.SQL.Add('       AND Fish_Date = FF_Date');
        qryAllFood.SQL.Add('       AND Fish_Type = FF_Type');
        qryAllFood.SQL.Add('       AND Fish_No = FF_FishNo');
        if cmbJobs.Text <> '' then
          qryAllFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));

        if txtParts.Text <> '' then
          qryAllFood.SQL.Add('AND P_Parts like ' + ''''+ part_lcode +'''');

        if cmbBuilding.Text <> '' then
          qryAllFood.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));

        if cmbreserve7.Text <> '' then
          qryAllFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        if cmbTerminal.Text <> '' then
          qryAllFood.SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));

        if txtFromDate.Text <> '' then
          qryAllFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryAllFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        qryAllFood.SQL.Add('       group by p_parts , fish_date,p_isGuest');
        qryAllFood.SQL.Add('      )a');
        qryAllFood.SQL.Add('  GROUP BY fish_date');
        qryAllFood.SQL.Add(' ) p');

        qryAllFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryAllFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptAllFoodpart.Preview
          else qrptAllFoodpart.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryAllFood.Close;
        Free;
      end;
    end;
  end
  else if rbdate.Checked
  then begin
    part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';
    if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
    begin
      ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
      txtFromDate.SetFocus;
    end
    else if (txtToDate.Text <> '') and not IsTrueDate(txtToDate.Text) then
    begin
      ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
      txtToDate.SetFocus;
    end
    else
    begin
      Mouse_Wait;
      Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');
      Application.CreateForm(TfrmRptAllFood, frmRptAllFood);
      with frmRptAllFood do
      begin
        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := ' «  «—ÌŒ :' + txtToDate.Text
        else
          lblRepDate.Caption := '';

        lblRepDate.Caption := (lblRepDate.Caption);

        qryAllFood.SQL.Clear;
        qryAllFood.SQL.Add('SELECT P_BarCode, P_Rejim, P_IsGuest, Fish_Date, FF_Price, FF_Pay, FF_Type, FF_FishNo');
        qryAllFood.SQL.Add('FROM Persons, Fish, FishFood');
        qryAllFood.SQL.Add('WHERE Fish_PCode = P_BarCode');
        qryAllFood.SQL.Add('AND Fish_Date = FF_Date');
        qryAllFood.SQL.Add('AND Fish_Type = FF_Type');
        qryAllFood.SQL.Add('AND Fish_No = FF_FishNo');

        if cmbJobs.Text <> '' then
          qryAllFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));

        if txtParts.Text <> '' then
          qryAllFood.SQL.Add('AND P_Parts like ' + ''''+ part_lcode +'''');

        if cmbBuilding.Text <> '' then
          qryAllFood.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));

        if cmbreserve7.Text <> '' then
          qryAllFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        if cmbTerminal.Text <> '' then
          qryAllFood.SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));

        if txtFromDate.Text <> '' then
          qryAllFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryAllFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        qryAllFood.SQL.Add('ORDER BY Fish_Date, P_Rejim, P_IsGuest, FF_Type, FF_FishNo');

        qryAllFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryAllFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptAllFood.Preview
          else qrptAllFood.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryAllFood.Close;
        Free;
      end;
    end;
  end
  else if rbpartdate.Checked
  then begin
    part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'%';
    if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
    begin
      ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
      txtFromDate.SetFocus;
    end
    else if (txtToDate.Text <> '') and not IsTrueDate(txtToDate.Text) then
    begin
      ErrorMessage(' «—ÌŒ «‘ »«Â «” .');
      txtToDate.SetFocus;
    end
    else
    begin
      Mouse_Wait;
      Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');
      Application.CreateForm(TfrmRptAllFood2, frmRptAllFood2);
      with frmRptAllFood2 do
      begin
        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := ' «  «—ÌŒ :' + txtToDate.Text
        else
          lblRepDate.Caption := '';

        lblRepDate.Caption := (lblRepDate.Caption);

        qryAllFood.SQL.Clear;
        qryAllFood.SQL.Add('SELECT P_BarCode, p_parts, P_Rejim, P_IsGuest, Fish_Date, FF_Price, FF_Pay, FF_Type, FF_FishNo');
        qryAllFood.SQL.Add('FROM Persons, Fish, FishFood');
        qryAllFood.SQL.Add('WHERE Fish_PCode = P_BarCode');
        qryAllFood.SQL.Add('AND Fish_Date = FF_Date');
        qryAllFood.SQL.Add('AND Fish_Type = FF_Type');
        qryAllFood.SQL.Add('AND Fish_No = FF_FishNo');

        if cmbJobs.Text <> '' then
          qryAllFood.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));

        if txtParts.Text <> '' then
          qryAllFood.SQL.Add('AND P_Parts like ' + ''''+ part_lcode +'''');

        if cmbBuilding.Text <> '' then
          qryAllFood.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));

        if cmbreserve7.Text <> '' then
          qryAllFood.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        if cmbTerminal.Text <> '' then
          qryAllFood.SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));

        if txtFromDate.Text <> '' then
          qryAllFood.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryAllFood.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        qryAllFood.SQL.Add('ORDER BY Fish_Date, P_Rejim, P_IsGuest, FF_Type, FF_FishNo');

        qryAllFood.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryAllFood.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptAllFood2.Preview
          else qrptAllFood2.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryAllFood.Close;
        Free;
      end;
    end;
  end;
end;

end.






SELECT *, (p1 + p2 + p3 + p4) AS Total from
 (SELECT fish_date,
  SUM (CASE p_parts WHEN 1 THEN amount ELSE 0 END) AS P1
  SUM (CASE p_parts WHEN 2 THEN amount ELSE 0 END) AS P2
  SUM (CASE p_parts WHEN 3 THEN amount ELSE 0 END) AS P3
  FROM(SELECT p_parts ,fish_date,count(*) as amount
       FROM Persons, Fish, FishFood
       WHERE Fish_PCode = P_BarCode
       AND Fish_Date = FF_Date
       AND Fish_Type = FF_Type
       AND Fish_No = FF_FishNo
       AND Fish_Date >= '1385/12/19'
       AND Fish_Date <= '1385/12/21'
       group by p_parts , fish_date
       )a
       GROUP BY fish_date
) p






SELECT *, (part1 + part2 + part3) AS Total from
(
	SELECT fish_date,
	    SUM(CASE p_parts WHEN 01 THEN amount ELSE 0 END) AS part1,
	    SUM(CASE p_parts WHEN 02 THEN amount ELSE 0 END) AS part2,
	    SUM(CASE p_parts WHEN 03 THEN amount ELSE 0 END) AS part3
	FROM
	(
		SELECT p_parts ,fish_date,count(*) as amount
		FROM Persons, Fish, FishFood
		WHERE Fish_PCode = P_BarCode
		AND Fish_Date = FF_Date
		AND Fish_Type = FF_Type
		AND Fish_No = FF_FishNo
		group by p_parts , fish_date
	)a
	GROUP BY fish_date
) p




