unit OilRpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Grids, ExtCtrls,db;

type
  TfrmOilRpt = class(TForm)
    lbl1: TLabel;
    txtFromDate: TEdit;
    lbl2: TLabel;
    txtToDate: TEdit;
    lbl3: TLabel;
    txtFileName: TEdit;
    lbl6: TLabel;
    cmdRun: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    lbl5: TLabel;
    prgBar: TProgressBar;
    txtFld1: TEdit;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    txtFld2: TEdit;
    lbl7: TLabel;
    txtFld3: TEdit;
    txtFld4: TEdit;
    txtFld7: TEdit;
    txtFld9: TEdit;
    lbl4: TLabel;
    cmbJobType: TComboBox;
    chkFreeDBS: TCheckBox;
    rdoOutPut: TRadioGroup;
    chkSign: TCheckBox;
    rdobase: TRadioGroup;
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdRunClick(Sender: TObject);
    procedure txtFileNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbJobTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdoOutPutClick(Sender: TObject);
  private
    { Private declarations }
    FldNames : array[1..9] of String;

    procedure SendTab(var Key : Char);

    procedure CreateDBFFile;
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

uses
  AdoDB, MSGs, Keyboard, DateProc, Globals, RPOil, ComTools,DBTables,
  Code_Sys, DBS_Proc;


{$R *.DFM}

procedure TfrmOilRpt.SetWinF;
begin
end;

procedure TfrmOilRpt.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;



procedure TfrmOilRpt.CreateDBFFile;
var
  qry : TAdoQuery;
  tbl : TTable;
  F_Path, F_Name : String;
begin
  Mouse_Wait;
  MSG_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘...');
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  case rdobase.ItemIndex of
    0,1:begin
      //movaghar
      qry.SQL.Add('SELECT Fish_PCode, SUM(FF_Price * FF_No) AS Prc FROM Fish, FishFood, Persons');
      if rdobase.ItemIndex=1
      then begin
           qry.SQL.Add(', prgprs ');
      end;
      //qry.SQL.Add('SELECT Fish_PCode, SUM(FF_Pay * FF_No) AS Prc FROM Fish, FishFood, Persons');
      qry.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
      qry.SQL.Add('AND Fish_PCode = P_BarCode');
      if rdobase.ItemIndex=1
      then begin
           qry.SQL.Add('AND Fish_PCode = PP_Pcode');
           qry.SQL.Add('AND Fish_Type = PP_Type');
           qry.SQL.Add('AND Fish_Date = PP_Date');
      end;
      if cmbJobType.Text <> '' then
        qry.SQL.Add('AND P_JobCode = ' + Copy(cmbJobType.Text, 1, Pos('-', cmbJobType.Text)-1));

      if txtFromDate.Text <> '' then
        qry.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
      if txtToDate.Text <> '' then
        qry.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

      qry.SQL.Add('GROUP BY Fish_PCode');
    end;
    2: begin
      qry.SQL.Add('SELECT PP_PCode as Fish_PCode, SUM(PP_Price) AS Prc FROM prgprs, Persons');
      qry.SQL.Add('Where PP_PCode = P_BarCode');
      if cmbJobType.Text <> '' then
        qry.SQL.Add('AND P_JobCode = ' + Copy(cmbJobType.Text, 1, Pos('-', cmbJobType.Text)-1));

      if txtFromDate.Text <> '' then
        qry.SQL.Add('AND PP_Date >= ''' + txtFromDate.Text + '''');
      if txtToDate.Text <> '' then
        qry.SQL.Add('AND PP_Date <= ''' + txtToDate.Text + '''');

      qry.SQL.Add('GROUP BY PP_PCode');
    end;
  end;
  qry.Open;

  if (qry.RecordCount > 0) and
     (qry.FieldByName('Fish_PCode').AsString <> '') then
  begin
    F_Path := ExtractFilePath(txtFileName.Text);
    F_Name := ExtractFileName(txtFileName.Text);
    tbl := TTable.Create(Application);
    if F_Path <> '' then
      tbl.DatabaseName := F_Path
    else
      tbl.DatabaseName := g_options.DataBasePath;

    tbl.TableName := F_Name;
    tbl.TableType := ttFoxPro;
    if (not tbl.Exists) or chkFreeDBS.Checked then
    begin
      tbl.Active := False;
      tbl.FieldDefs.Clear;
      tbl.FieldDefs.Add(FldNames[1], ftString, 4, False);
      tbl.FieldDefs.Add(FldNames[2], ftString, 1, False);
      tbl.FieldDefs.Add(FldNames[3], ftString, 3, False);
      tbl.FieldDefs.Add(FldNames[4], ftString, 4, False);
      tbl.FieldDefs.Add(FldNames[5], ftString, 6, False);
      tbl.FieldDefs.Add(FldNames[6], ftString, 6, False);
      tbl.FieldDefs.Add(FldNames[7], ftString, 4, False);
      tbl.FieldDefs.Add(FldNames[8], ftWord, 0, False);
      tbl.FieldDefs.Add(FldNames[9], ftInteger, 0, False);
      tbl.CreateTable;
    end;

    tbl.Open;
    prgBar.Max := qry.RecordCount;
    while not qry.Eof do
    begin
      prgBar.Position := prgBar.Position + 1;
      tbl.Append;
      tbl.FieldByName(FldNames[1]).AsString := ChangeFromWin(txtFld1.Text, g_options.WinType, DOS_IR_SYS);
      tbl.FieldByName(FldNames[2]).AsString := txtFld2.Text;
      tbl.FieldByName(FldNames[3]).AsString := txtFld3.Text;
      tbl.FieldByName(FldNames[4]).AsString := txtFld4.Text;
      tbl.FieldByName(FldNames[5]).AsString := Copy(qry.FieldByName('Fish_PCode').AsString, 3, 6);
      tbl.FieldByName(FldNames[6]).AsString := Copy(txtFromDate.Text, 3, 2) + Copy(txtFromDate.Text, 6, 2) + '01';
      tbl.FieldByName(FldNames[7]).AsString := txtFld7.Text;
      tbl.FieldByName(FldNames[8]).AsInteger := qry.FieldByName('Prc').AsInteger;
      if txtFld9.Text <> '' then
        tbl.FieldByName(FldNames[9]).AsInteger := StrToInt(txtFld9.Text);
      tbl.Post;

      qry.Next;
    end;
    tbl.Close;
    tbl.Free;
    Msg_NoWait;
    Mouse_NoWait;
  end
  else
  begin
    Msg_NoWait;
    Mouse_NoWait;
    ErrorMessage('—ﬂÊ—œÌ ÊÃÊœ ‰œ«—œ.');
  end;

  qry.Close;
  qry.Free;
end;



procedure TfrmOilRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  FldNames[1] := 'Fld1';
  FldNames[2] := 'Fld2';
  FldNames[3] := 'Fld3';
  FldNames[4] := 'Fld4';
  FldNames[5] := 'Fld5';
  FldNames[6] := 'Fld6';
  FldNames[7] := 'Fld7';
  FldNames[8] := 'Fld8';
  FldNames[9] := 'Fld9';
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.DBConnection;
  with qry do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM JobType');
    Open;
    while not EOF do
    begin
      cmbJobType.Items.Add(FieldByName('Job_Code').AsString + '-' + FieldByName('Job_Name').AsString);
      Next;
    end;
    Close;
    Free;
  end;
  rdoOutPutClick(Sender);
end;

procedure TfrmOilRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmOilRpt.txtFromDateExit(Sender: TObject);
begin
  with txtFromDate do
  begin
    if Text <> '' then
      Text := BeautifulDate(Text);
    g_options.RptFDate := Text;
  end;
end;

procedure TfrmOilRpt.txtToDateExit(Sender: TObject);
begin
  with txtToDate do
  begin
    if Text <> '' then
      Text := BeautifulDate(Text);
    g_options.RptTDate := Text;
  end;
end;

procedure TfrmOilRpt.cmdRunClick(Sender: TObject);
var frmRptOil : TfrmRptOil;
begin
  if rdoOutPut.ItemIndex = 0 then
  begin
    if txtFileName.Text = '' then
    begin
      ErrorMessage('‰«„ ›«Ì· „‘Œ’ ‰‘œÂ «” .');
      txtFileName.SetFocus;
    end
    else
    begin
      prgBar.Position := 0;
      CreateDBFFile;
    end;
  end
  else
  begin
    Mouse_Wait;
    Msg_Wait('œ— Õ«· «ÌÃ«œ ê“«—‘');
    Application.CreateForm(TfrmRptOil, frmRptOil);
    with frmRptOil do
    begin
      lblCoName.Caption := g_options.CoName;
      bndSign.Enabled := chkSign.Checked;
      if cmbJobType.Text <> '' then
        lblJob.Caption := Copy(cmbJobType.Text, Pos('-', cmbJobType.Text)+1, Length(cmbJobType.Text))
      else
        lblJob.Caption := '';
      lblEndRep1.Caption := F_Params.EndRep1;
      lblEndRep2.Caption := F_Params.EndRep2;
      lblEndRep3.Caption := F_Params.EndRep3;
      lblEndRep4.Caption := F_Params.EndRep4;

      if g_options.Shobeh <> '' then
        lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text + '     «  «—ÌŒ : ' + txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblRepDate.Caption := '«“  «—ÌŒ : ' + txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblRepDate.Caption := ' «  «—ÌŒ :' + txtToDate.Text
      else
        lblRepDate.Caption := '';

      lblRepDate.Caption := (lblRepDate.Caption);

      lblDoc.Caption := txtFld1.Text;
      lblRamz.Caption := txtFld2.Text;
      lblUnit.Caption := txtFld3.Text;
      pass := txtFld7.Text;
      cnst := txtFld9.Text;


      qryPFish.SQL.Clear;
      case rdobase.ItemIndex of
        0,1:begin
          //Movaghar
          qryPFish.SQL.Add('SELECT Fish_PCode, P_Name, P_Family, SUM(FF_Price * FF_No) AS Prc FROM Fish, FishFood, Persons');
          //qryPFish.SQL.Add('SELECT Fish_PCode, P_Name, P_Family, SUM(FF_Pay * FF_No) AS Prc FROM Fish, FishFood, Persons');
          if rdobase.ItemIndex=1
          then begin
               qryPFish.SQL.Add(', prgprs ');
          end;
          qryPFish.SQL.Add('WHERE Fish_Date = FF_Date AND Fish_Type = FF_Type AND Fish_No = FF_FishNo');
          qryPFish.SQL.Add('AND Fish_PCode = P_BarCode');
          if rdobase.ItemIndex=1
          then begin
               qryPFish.SQL.Add('AND Fish_PCode = PP_Pcode');
               qryPFish.SQL.Add('AND Fish_Type = PP_Type');
               qryPFish.SQL.Add('AND Fish_Date = PP_Date');
          end;
          if cmbJobType.Text <> '' then
            qryPFish.SQL.Add('AND P_JobCode = ' + Copy(cmbJobType.Text, 1, Pos('-', cmbJobType.Text)-1));

          if txtFromDate.Text <> '' then
            qryPFish.SQL.Add('AND Fish_Date >= ''' + txtFromDate.Text + '''');
          if txtToDate.Text <> '' then
            qryPFish.SQL.Add('AND Fish_Date <= ''' + txtToDate.Text + '''');

          qryPFish.SQL.Add('GROUP BY Fish_PCode, P_Name, P_Family');
          qryPFish.SQL.Add('order BY P_Family,P_Name');
        end;
        2:begin
          qryPFish.SQL.Add('SELECT PP_Pcode as Fish_PCode, P_Name, P_Family, SUM(PP_Price) AS Prc FROM PrgPrs,Persons');
          qryPFish.SQL.Add('Where PP_PCode = P_BarCode');
          if cmbJobType.Text <> '' then
            qryPFish.SQL.Add('AND P_JobCode = ' + Copy(cmbJobType.Text, 1, Pos('-', cmbJobType.Text)-1));

          if txtFromDate.Text <> '' then
            qryPFish.SQL.Add('AND PP_Date >= ''' + txtFromDate.Text + '''');
          if txtToDate.Text <> '' then
            qryPFish.SQL.Add('AND PP_Date <= ''' + txtToDate.Text + '''');

          qryPFish.SQL.Add('GROUP BY PP_PCode, P_Name, P_Family');
          qryPFish.SQL.Add('order BY P_Family,P_Name');
        end;
      end;
      qryPFish.Open;
      Mouse_NoWait;
      Msg_NoWait;
      if qryPFish.RecordCount > 0 then
      begin
        SetUserControl;
        qrptPFish.Preview;
        USERCONTROL := False;
      end
      else
        InformationMessage('ÂÌç ›Ì‘Ì ’«œ— ‰‘œÂ «” .');
      qryPFish.Close;
      Free;
    end;
  end;
end;

procedure TfrmOilRpt.txtFileNameKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmOilRpt.cmbJobTypeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
  begin
    Key := 0;
    cmbJobType.ItemIndex := -1;
  end;
end;

procedure TfrmOilRpt.rdoOutPutClick(Sender: TObject);
begin
  txtFileName.Enabled := (rdoOutPut.ItemIndex = 0);
  chkFreeDBS.Visible := txtFileName.Enabled;
  chkSign.Visible := not chkFreeDBS.Visible;
end;

end.
