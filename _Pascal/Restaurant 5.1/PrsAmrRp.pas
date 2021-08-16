unit PrsAmrRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,slctpart,
  MSGs, Keyboard, RpPrsAmr,RpPrsAmrYaraneh;

type
  TfrmPrsAmarRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    txtPCode: TEdit;
    Label4: TLabel;
    txtFamily: TEdit;
    Label5: TLabel;
    txtName: TEdit;
    rdoSort: TRadioGroup;
    cmbJobs: TComboBox;
    Label6: TLabel;
    rdoPerson: TRadioGroup;
    grpTafkik: TGroupBox;
    chkPart: TCheckBox;
    chkJob: TCheckBox;
    chkSign: TCheckBox;
    Label8: TLabel;
    cmbBuilding: TComboBox;
    Label9: TLabel;
    cmbTerminal: TComboBox;
    txtParts: TEdit;
    BitBtn1: TBitBtn;
    cmbreserve7: TComboBox;
    Label10: TLabel;
    chkYaraneh: TCheckBox;
    grp1: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    grp2: TGroupBox;
    Label11: TLabel;
    cmbYear: TComboBox;
    Label12: TLabel;
    cmbMonth: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure cmbPartKeyPress(Sender: TObject; var Key: Char);
    procedure txtPCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmbJobsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkPartKeyPress(Sender: TObject; var Key: Char);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
    procedure chkYaranehClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
  partcode:string ; { Public declarations }
  end;


implementation

uses
  ComTools, DBS_Proc;

{$R *.DFM}


procedure TfrmPrsAmarRpt.SetWinF;
var i : Byte;
begin
end;

procedure TfrmPrsAmarRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtFamily.Handle);
  SetDirectionFarsi(txtFamily.Handle);

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

procedure TfrmPrsAmarRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmPrsAmarRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text;
end;

procedure TfrmPrsAmarRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmPrsAmarRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtPCode.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmPrsAmarRpt.txtPCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtFamily.SetFocus;
  end;
end;

procedure TfrmPrsAmarRpt.txtFamilyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtName.SetFocus;
  end;
end;

procedure TfrmPrsAmarRpt.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbJobs.SetFocus;
  end;
end;

procedure TfrmPrsAmarRpt.cmbJobsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbJobs.ItemIndex := -1;
  end;
end;

procedure TfrmPrsAmarRpt.cmbPartKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    rdoPerson.SetFocus;
  end;
end;

procedure TfrmPrsAmarRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);

end;

procedure TfrmPrsAmarRpt.chkPartKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
  end;
end;

procedure TfrmPrsAmarRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmPrsAmarRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmPrsAmarRpt.chkYaranehClick(Sender: TObject);
begin
  grp1.Visible := not (chkYaraneh.Checked);
  grp2.Visible := (chkYaraneh.Checked);
end;

procedure TfrmPrsAmarRpt.cmdPrintClick(Sender: TObject);
var
  frmRptPrsAmar : TfrmRptPrsAmar;
  frmRptPrsAmarY : TfrmRptPrsAmarYaraneh;
part_lcode:string;
begin
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
    SetUserControl;
    if chkYaraneh.Checked then
    begin
      Application.CreateForm(TfrmRptPrsAmarYaraneh, frmRptPrsAmarY);
      with frmRptPrsAmarY do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;
        SDate := txtFromDate.Text;
        EDate := txtToDate.Text;
        grpBarCode.Height := 0;
        bndDetail.Height := 0;

        grpPartJob.Enabled := (chkPart.Checked OR chkJob.Checked);

        if (txtFromDate.Text <> '') then
          lblRepDate.Caption := '»—Ã ' + copy(txtFromDate.text,6,2);
        if (txtToDate.Text <> '') and (copy(txtToDate.text,6,2)<>copy(txtFromDate.text,6,2)) then
          lblRepDate.Caption := lblRepDate.Caption  + ' « »—Ã ' + copy(txtToDate.text,6,2);
        with qryPrsFish do
        begin
          SQL.Clear;
          SQL.Add('select z.*,P_Family,p_Name,p_barcode,p_jobcode,p_parts from persons,');
          SQL.Add('(');
          SQL.Add('select fish_pcode');
          SQL.Add(',mnth=y.m,yr=y.yr');
          SQL.Add(',y_workdays=(case when y_workdays is null then 0 else y_workdays end)');
          SQL.Add(',fishcount,fishprice');
          SQL.Add(',Y_AteYaraneh=(case when Y_AteYaraneh is null then 0 else Y_AteYaraneh end)');
          SQL.Add(',Y_NotAteYaraneh=(case when Y_NotAteYaraneh is null then 0 else Y_NotAteYaraneh end)');
          SQL.Add('from');
          SQL.Add('( select * from yaraneh');
          SQL.Add(') x');
          SQL.Add('right outer join');
          SQL.Add('(');
          SQL.Add('select m.*,f.fishcount from');
          SQL.Add('(');
          SQL.Add('select fish_pcode,m=substring(fish_date,6,2),count(fish_no) as FishCount from fish');
          SQL.Add('where substring(fish_date,1,7) = ''' + cmbYear.Text + '/' + cmbMonth.Text + '''');
//          SQL.Add('where substring(fish_date,6,2) >= ''' + copy(txtFromDate.Text,6,2) + '''');
//          SQL.Add('AND substring(fish_date,6,2) <= ''' +copy(txtToDate.Text,6,2)+ '''');
          SQL.Add('group by fish_pcode,substring(fish_date,6,2)');
          SQL.Add(') f ,');
          SQL.Add('(');
          SQL.Add('SELECT  fish_Pcode,SUM(FF_Price * FF_No)as FishPrice,m=substring(ff_date,6,2),yr = substring(ff_date,1,4) FROM Fish, FishFood');
          SQL.Add('WHERE FF_FishNo = Fish_No AND FF_Type = Fish_Type AND FF_Date = Fish_Date');
          SQL.Add('AND substring(fish_date,1,7) = ''' + cmbYear.Text + '/' + cmbMonth.Text + '''');
//          SQL.Add('AND substring(fish_date,6,2) >= ''' +copy(txtFromDate.Text,6,2)+ '''');
//          SQL.Add('AND substring(fish_date,6,2) <= ''' +copy(txtToDate.Text,6,2)+ '''');
          SQL.Add('and fish_PCode in (select p_BArcode from persons where p_isguest=0)');
          SQL.Add('group by fish_PCode,substring(ff_date,6,2),substring(ff_date,1,4)');
          SQL.Add(')m');
          SQL.Add('where f.fish_pcode=m.fish_pcode and f.m=m.m');
          SQL.Add(') y');
          SQL.Add('on y.fish_pcode = x.y_pcode and y.m =x.y_Month and y.Yr =x.y_Year');
          SQL.Add(') z');
          SQL.Add('where z.fish_pcode=persons.p_Barcode');

          if txtPCode.Text <> '' then
            qryPrsFish.SQL.Add('AND P_BarCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''');

          if txtFamily.Text <> '' then
            SQL.Add('AND P_Family = ''' + txtFamily.Text + '''');

          if txtName.Text <> '' then
            SQL.Add('AND P_Name = ''' + txtName.Text + '''');

          if cmbJobs.Text <> '' then
            qryPrsFish.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));

          if txtParts.Text <> '' then
            qryPrsFish.SQL.Add('AND P_parts  like ' +''''+ part_lcode +'''' ) ;

          if cmbBuilding.Text <> '' then
            qryPrsFish.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));

          if cmbreserve7.Text <> '' then
            qryPrsFish.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

          case rdoPerson.ItemIndex of
            1: qryPrsFish.SQL.Add('AND P_Rejim = 0 AND P_IsGuest = 0');
            2: qryPrsFish.SQL.Add('AND P_Rejim = 1');
            3: qryPrsFish.SQL.Add('AND P_IsGuest = 1');
          end;

          if not grpPartJob.Enabled then
          begin
           grpPartJob.Expression := '';
           qryPrsFish.SQL.Add('ORDER BY ');
          end
          else if chkPart.Checked and chkJob.Checked then
          begin
            grpPartJob.Expression := 'qryPrsFish.P_parts + qryPrsFish.P_JobCode';
            qryPrsFish.SQL.Add('ORDER BY P_parts, P_JobCode, ');
          end
          else if chkPart.Checked then
          begin
            grpPartJob.Expression := 'qryPrsFish.P_parts';
            lblJob.Enabled := False;
            qryPrsFish.SQL.Add('ORDER BY P_parts, ');
          end
          else if chkJob.Checked then
          begin
            grpPartJob.Expression := 'qryPrsFish.P_JobCode';
            lblPart.Enabled := False;
            qryPrsFish.SQL.Add('ORDER BY P_JobCode, ');
          end;

          case rdoSort.ItemIndex of
            0: qryPrsFish.SQL.Add('P_BarCode');
            1: qryPrsFish.SQL.Add('P_Family, P_Name, P_BarCode');
          end;

//          SQL.Add(') p right outer join ');
//          SQL.Add('(SELECT fish_Pcode,SUM(FF_Price * FF_No)as FishPrice,count(fish_no)as FishCount,substring(ff_date,6,2)as m FROM Fish, FishFood');
//          SQL.Add('WHERE FF_FishNo = Fish_No AND FF_Type = Fish_Type AND FF_Date = Fish_Date');
//          if txtFromDate.Text <> '' then
//            SQL.Add('AND substring(ff_date,6,2) >= ''' + copy(txtFromDate.Text,6,2) + '''');
//          if txtToDate.Text <> '' then
//            SQL.Add('AND substring(ff_Date,6,2) <= ''' + copy(txtToDate.Text,6,2) + '''');
//          if cmbTerminal.Text <> '' then
//            SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));
//          SQL.Add('and fish_PCode in (select p_barcode from persons where p_isguest=0)');
//          SQL.Add('group by fish_PCode,substring(ff_date,6,2)');
//          SQL.Add(') a');
//          SQL.Add('on a.fish_pcode = p.Y_Pcode and a.m =p.y_Month');
        end;

//        case rdoPerson.ItemIndex of
//          1: qryPrsFish.SQL.Add('AND P_Rejim = 0 AND P_IsGuest = 0');
//          2: qryPrsFish.SQL.Add('AND P_Rejim = 1');
//          3: qryPrsFish.SQL.Add('AND P_IsGuest = 1');
//        end;

//        if not grpPartJob.Enabled then
//        begin
//         grpPartJob.Expression := '';
//         qryPrsFish.SQL.Add('ORDER BY ');
//        end
//        else if chkPart.Checked and chkJob.Checked then
//        begin
//          grpPartJob.Expression := 'qryPrsFish.P_parts + qryPrsFish.P_JobCode';
//          qryPrsFish.SQL.Add('ORDER BY P_parts, P_JobCode, ');
//        end
//        else if chkPart.Checked then
//        begin
//          grpPartJob.Expression := 'qryPrsFish.P_parts';
//          lblJob.Enabled := False;
//          qryPrsFish.SQL.Add('ORDER BY P_parts, ');
//        end
//        else if chkJob.Checked then
//        begin
//          grpPartJob.Expression := 'qryPrsFish.P_JobCode';
//          lblPart.Enabled := False;
//          qryPrsFish.SQL.Add('ORDER BY P_JobCode, ');
//        end;
//
//        case rdoSort.ItemIndex of
//          0: qryPrsFish.SQL.Add('P_BarCode');
//          1: qryPrsFish.SQL.Add('P_Family, P_Name, P_BarCode');
//        end;

        qryPrsFish.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryPrsFish.RecordCount > 0 then
        begin
          if rdoScreen.Checked then qrptPrsFish.Preview
          else qrptPrsFish.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryPrsFish.Close;
        Free;
      end;
    end
    else
    begin
      Application.CreateForm(TfrmRptPrsAmar, frmRptPrsAmar);
      with frmRptPrsAmar do
      begin
        Mouse_Wait;
        Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;
        SDate := txtFromDate.Text;
        EDate := txtToDate.Text;
        grpBarCode.Height := 0;
        bndDetail.Height := 0;

        grpPartJob.Enabled := (chkPart.Checked OR chkJob.Checked);

        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('«“  «—ÌŒ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := (' «  «—ÌŒ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qryPrsFish.SQL.Clear;
        qryPrsFish.SQL.Add('SELECT * FROM Fish, Persons WHERE Fish_PCode = P_BarCode');

        if txtFromDate.Text <> '' then
          qryPrsFish.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qryPrsFish.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

        if txtPCode.Text <> '' then
          qryPrsFish.SQL.Add('AND Fish_PCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''');

        if txtFamily.Text <> '' then
          qryPrsFish.SQL.Add('AND P_Family = ''' + txtFamily.Text + '''');

        if txtName.Text <> '' then
          qryPrsFish.SQL.Add('AND P_Name = ''' + txtName.Text + '''');

        if cmbJobs.Text <> '' then
          qryPrsFish.SQL.Add('AND P_JobCode = ' + Copy(cmbJobs.Text, 1, Pos('-', cmbJobs.Text)-1));

        if txtParts.Text <> '' then
          qryPrsFish.SQL.Add('AND P_parts  like ' +''''+ part_lcode +'''' ) ;

        if cmbBuilding.Text <> '' then
          qryPrsFish.SQL.Add('AND P_Building = ' + Copy(cmbBuilding.Text, 1, Pos('-', cmbBuilding.Text)-1));

        if cmbreserve7.Text <> '' then
          qryPrsFish.SQL.Add('AND P_reserve7 = ''' + cmbreserve7.Text+'''');

        if cmbTerminal.Text <> '' then
          qryPrsFish.SQL.Add('AND fish_rdrCode = ' + Copy(cmbTerminal.Text, 1, Pos('-', cmbTerminal.Text)-1));

        case rdoPerson.ItemIndex of
          1: qryPrsFish.SQL.Add('AND P_Rejim = 0 AND P_IsGuest = 0');
          2: qryPrsFish.SQL.Add('AND P_Rejim = 1');
          3: qryPrsFish.SQL.Add('AND P_IsGuest = 1');
        end;

        if not grpPartJob.Enabled then
        begin
         grpPartJob.Expression := '';
         qryPrsFish.SQL.Add('ORDER BY ');
        end
        else if chkPart.Checked and chkJob.Checked then
        begin
          grpPartJob.Expression := 'qryPrsFish.P_parts + qryPrsFish.P_JobCode';
          qryPrsFish.SQL.Add('ORDER BY P_parts, P_JobCode, ');
        end
        else if chkPart.Checked then
        begin
          grpPartJob.Expression := 'qryPrsFish.P_parts';
          lblJob.Enabled := False;
          qryPrsFish.SQL.Add('ORDER BY P_parts, ');
        end
        else if chkJob.Checked then
        begin
          grpPartJob.Expression := 'qryPrsFish.P_JobCode';
          lblPart.Enabled := False;
          qryPrsFish.SQL.Add('ORDER BY P_JobCode, ');
        end;

        case rdoSort.ItemIndex of
          0: qryPrsFish.SQL.Add('P_BarCode');
          1: qryPrsFish.SQL.Add('P_Family, P_Name, P_BarCode');
        end;

        qryPrsFish.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qryPrsFish.RecordCount > 0 then
        begin
          if rdoScreen.Checked then qrptPrsFish.Preview
          else qrptPrsFish.Print;
        end
        else
          InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
        qryPrsFish.Close;
        Free;
      end;
    end;
    USERCONTROL := False;
  end;
end;

end.



