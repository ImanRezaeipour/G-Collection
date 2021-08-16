unit IORdrRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBTables, ExtCtrls, db, ADODB, DosMove;


type
  TfrmInOutReaderRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    lbl1: TLabel;
    rdoSort: TRadioGroup;
    lbl4: TLabel;
    lbl5: TLabel;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    cmbReaders: TComboBox;
    lbl2: TLabel;
    cmbBarCode: TComboBox;
    cmbFamily: TComboBox;
    cmdSelect: TBitBtn;
    chkEndRep: TCheckBox;
    lbl6: TLabel;
    lbl7: TLabel;
    txtSTime: TEdit;
    txtETime: TEdit;
    lbl3: TLabel;
    cmbType: TComboBox;
    DosMove1: TDosMove;
    cmbBox: TComboBox;
    Label1: TLabel;
    procedure cmbBoxExit(Sender: TObject);
    procedure cmbBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure cmbReadersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbBarCodeExit(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFamilyExit(Sender: TObject);
    procedure cmbBarCodeChange(Sender: TObject);
    procedure cmdSelectClick(Sender: TObject);
    procedure txtSTimeExit(Sender: TObject);
    procedure txtETimeExit(Sender: TObject);
    procedure txtETimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Tcode = class(Tobject)
    Id : integer;
    Place : string;
    BoxType : integer;
  end;

implementation

uses
  DBS, Funcs, Globals, Keyboard, MSGs, Select, TimeTool,DateProc,
  RpIORdr, RpIORdrP, RpIORdrR;


{$R *.DFM}

procedure TfrmInOutReaderRpt.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
  i : byte;
  tmp : Tcode;
begin
  with qry do
  begin
    qry := TAdoQuery.Create(Application);
    Connection := frmDBS.DBConnection;

    SQL.Clear;
    SQL.Add('SELECT P_Code, nP_Name, nP_Family , c_Name , C_Place, C_Code, C_Type, p_BoxNo ');
//kaveh    SQL.Add('FROM Persons left Join cashes on p_BoxNo = c_code WHERE P_IsBlocked = 0');
//kaveh    SQL.Add('ORDER BY P_Family, P_Name');
//kaveh is
    SQL.Add('FROM Persons LEFT OUTER JOIN ');
    SQL.Add('nPersons ON dbo.Persons.p_code = nPersons.np_code LEFT OUTER JOIN ');
    SQL.Add('Cashes ON dbo.Persons.p_BoxNo = Cashes.c_code ');
//kaveh ie
    Open;
    while not Eof do
    begin
      cmbBarCode.Items.Add(FieldByName('P_Code').AsString);
      cmbFamily.Items.Add(FieldByName('nP_Family').AsString + '-' + FieldByName('nP_Name').AsString);
      //cmbBox.Items.Add(FieldByName('c_Name').AsString);
      tmp := Tcode.Create;
      tmp.Id := FieldByName('C_Code').AsInteger;
      tmp.BoxType := FieldByName('C_Type').AsInteger;
      tmp.Place := FieldByName('C_Place').AsString;
      cmbBox.Items.AddObject(FieldByName('C_Place').AsString + '-' + FixLeft(FieldByName('C_Name').AsString,'0',2) ,tmp);
      tmp := nil;
      tmp.Free;
      Next;
    end;
    Close;

    Free;
  end;
  txtFromDate.Text:=G_FromDate;
  txtToDate.Text:=G_ToDate;

/////////??????????
{
    with TADOQuery.Create(Application) do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * from Cashes');// where ((c_code not in (select p_boxNo from persons where  p_IsBlocked <> 1))');

    Open;
    cmbSrchBoxNo.Items.Clear;
    while not EOF do
    begin
      tmp := Tcode.Create;
      tmp.Id := FieldByName('C_Code').AsInteger;
      tmp.BoxType := FieldByName('C_Type').AsInteger;
      tmp.Place := FieldByName('C_Place').AsString;
      cmbSrchBoxNo.Items.AddObject(FieldByName('C_Place').AsString + '-' + FixLeft(FieldByName('C_Name').AsString,'0',2) ,tmp);
      tmp := nil;
      tmp.Free;
      Next;
    end;
    Close;
    cmbSrchBoxNo.itemIndex := -1;

  end;
  cmbSrchBoxNo.Sorted := true;
}
/////////??????????

  for i := 1 to TotalReader do
    cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);
end;

procedure TfrmInOutReaderRpt.cmbBarCodeExit(Sender: TObject);
begin
  {cmbFamily.ItemIndex := cmbBarCode.ItemIndex;}
  with cmbBarCode do
  begin
    if Text <> '' then
      ItemIndex := Items.IndexOf(FixLeft(Text, '0', 8))
    else
      ItemIndex := -1;
    cmbFamily.ItemIndex := ItemIndex;
    cmbBox.ItemIndex := ItemIndex;
  end;
end;

procedure TfrmInOutReaderRpt.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmInOutReaderRpt.cmbBoxClick(Sender: TObject);
begin
  cmbBarCode.ItemIndex := cmbBox.ItemIndex;
  cmbFamily.ItemIndex := cmbBox.ItemIndex;
end;

procedure TfrmInOutReaderRpt.cmbBoxExit(Sender: TObject);
begin
  cmbBarCode.ItemIndex := cmbBox.ItemIndex;
  cmbFamily.ItemIndex := cmbBox.ItemIndex;
end;

procedure TfrmInOutReaderRpt.cmbFamilyExit(Sender: TObject);
begin
  cmbBarCode.ItemIndex := cmbFamily.ItemIndex;
  cmbBox.ItemIndex := cmbFamily.ItemIndex;  
end;

procedure TfrmInOutReaderRpt.cmbReadersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbReaders.ItemIndex := -1;
  end;
end;

procedure TfrmInOutReaderRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmInOutReaderRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmInOutReaderRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmInOutReaderRpt.cmdSelectClick(Sender: TObject);
begin
  if frmSelect.ShowModal = mrOk then
    SelFlag := True;
end;

procedure TfrmInOutReaderRpt.cmbBarCodeChange(Sender: TObject);
begin
  SelFlag := False;
end;

procedure TfrmInOutReaderRpt.txtSTimeExit(Sender: TObject);
begin
  with txtstime do
    if Text <> '' then
      Text := BeautifulTime(Text);
end;

procedure TfrmInOutReaderRpt.txtETimeExit(Sender: TObject);
begin
  with txtetime do
    if Text <> '' then
      Text := BeautifulTime(Text);
end;

procedure TfrmInOutReaderRpt.txtETimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmInOutReaderRpt.cmdPrintClick(Sender: TObject);
var
  qrptInOutRdrR : TqrptInOutRdrR;
  qrptInOutRdrP : TqrptInOutRdrP;
  qrptInOutRdr : TqrptInOutRdr;
  i : Byte;
begin
  if not IsTrueDate(txtFromDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ «‘ »«Â «” ');
    txtFromDate.SetFocus;
  end
  else if not IsTrueDate(txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ Å«Ì«‰ «‘ »«Â «” ');
    txtToDate.SetFocus;
  end
  else if txtFromDate.Text > txtToDate.Text then
  begin
    ErrorMessage(' «—ÌŒ «» œ« «“  «—ÌŒ Å«Ì«‰ »Ì‘ — «” !');
    txtToDate.SetFocus;
  end
  else if (txtSTime.Text <> '') and (txtETime.Text <> '') and
          (txtSTime.Text > txtETime.Text) then
  begin
    ErrorMessage('“„«‰ ‘—Ê⁄ «“ “„«‰ Å«Ì«‰ »Ì‘ — «” ');
    txtToDate.SetFocus;
  end
  else if cmbType.ItemIndex = 0 then
  begin
    Mouse_Wait;
    CreateInOutTbl(txtFromDate.Text, txtToDate.Text);
    G_FromDate := txtFromDate.Text;
    G_ToDate := txtToDate.Text;
    Application.CreateForm(TqrptInOutRdrR, qrptInOutRdrR);
    with qrptInOutRdrR do
    begin
      RPTSetWinF;
      lblCoName.Caption := g_options.CoName;
      if g_options.Shobeh <> '' then lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
      lblDate.Caption := CurrentDate;

      DataSet := adoQryIO;
      grpReader.Expression := 'adoQryIO.Clock_RdrCode';

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFTDate.Caption := ('«“  «—ÌŒ : ') + txtFromDate.Text + ('    «  «—ÌŒ : ') + txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFTDate.Caption := ('«“  «—ÌŒ : ') + txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFTDate.Caption := (' «  «—ÌŒ : ') + txtToDate.Text
      else
        lblFTDate.Caption := '';

      if chkEndRep.Checked then
      begin
        lblEndRep1.Caption := F_Params.EndRep01;
        lblEndRep2.Caption := F_Params.EndRep02;
        lblEndRep3.Caption := F_Params.EndRep03;
        lblEndRep4.Caption := F_Params.EndRep04;
        lblEndRep5.Caption := F_Params.EndRep05;
      end
      else
        bndSum.Enabled := False;

      with adoQryIO do
      begin
        Connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('SELECT * FROM IORdr');
        SQL.Add('WHERE NOT (Clock_BarCode IS NULL)');

        if (SelFlag = True) and (frmSelect.lstSelect.Items.Count > 0) then
        begin
          SQL.Add('And Clock_BarCode IN (');
          for i := 0 to frmSelect.lstSelect.Items.Count -1 do
          begin
            SQL.Add(''''+frmSelect.lstSelect.Items.Strings[i]+'''');
            if i = frmSelect.lstSelect.Items.Count -1 then
              SQL.Add(')')
            else
              SQL.Add(',');
          end;
        end;

        if cmbBarCode.Text <> '' then
          SQL.Add('AND Clock_BarCode = ''' + cmbBarCode.Text + '''');
        if cmbreaders.Text <> '' then
          SQL.Add('AND Clock_RdrCode = ' + Copy(cmbreaders.Text, 1, Pos('-', cmbreaders.Text)-1));
        if txtSTime.Text <> '' then
          SQL.Add('AND Clock_Time >= ' + IntToStr(TimeToInt(txtSTime.Text)));
        if txtETime.Text <> '' then
          SQL.Add('AND Clock_Time <= ' + IntToStr(TimeToInt(txtETime.Text)));

        if rdoSort.ItemIndex = 0 then
          SQL.Add('ORDER BY Clock_RdrCode, Clock_BarCode, Clock_Date, Clock_Time')
        else
          SQL.Add('ORDER BY Clock_RdrCode, Clock_Date, Clock_Time, Clock_BarCode');

        Open;
        Mouse_NoWait;
        if RecordCount > 0 then
        begin
          if rdoScreen.Checked then
            Preview
          else
            Print;
        end
        else
          InformationMessage(' —œœÌ ÊÃÊœ ‰œ«—œ. ');
        Close;
      end;
      Free;
    end;
  end
  else if cmbType.ItemIndex = 1 then
  begin
    Mouse_Wait;
    CreateInOutTbl(txtFromDate.Text, txtToDate.Text);
    G_FromDate := txtFromDate.Text;
    G_ToDate := txtToDate.Text;
    Application.CreateForm(TqrptInOutRdrP, qrptInOutRdrP);
    with qrptInOutRdrP do
    begin
      RPTSetWinF;
      lblCoName.Caption := g_options.CoName;
      if g_options.Shobeh <> '' then lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
      lblDate.Caption := CurrentDate;

      DataSet := adoQryIO;
      grpReader.Expression := 'adoQryIO.Clock_BarCode';

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFTDate.Caption := ('«“  «—ÌŒ : ') + txtFromDate.Text + ('    «  «—ÌŒ : ') + txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFTDate.Caption := ('«“  «—ÌŒ : ') + txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFTDate.Caption := (' «  «—ÌŒ : ') + txtToDate.Text
      else
        lblFTDate.Caption := '';

      if chkEndRep.Checked then
      begin
        lblEndRep1.Caption := F_Params.EndRep01;
        lblEndRep2.Caption := F_Params.EndRep02;
        lblEndRep3.Caption := F_Params.EndRep03;
        lblEndRep4.Caption := F_Params.EndRep04;
        lblEndRep5.Caption := F_Params.EndRep05;
      end
      else
        bndSum.Enabled := False;

      with adoQryIO do
      begin
        Connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('SELECT * FROM IORdr');
        SQL.Add('WHERE NOT (Clock_BarCode IS NULL)');

        if (SelFlag = True) and (frmSelect.lstSelect.Items.Count > 0) then
        begin
          SQL.Add('And Clock_BarCode IN (');
          for i := 0 to frmSelect.lstSelect.Items.Count -1 do
          begin
            SQL.Add(''''+frmSelect.lstSelect.Items.Strings[i]+'''');
            if i = frmSelect.lstSelect.Items.Count -1 then
              SQL.Add(')')
            else
              SQL.Add(',');
          end;
        end;

        if cmbBarCode.Text <> '' then
          SQL.Add('AND Clock_BarCode = ''' + cmbBarCode.Text + '''');
        if cmbreaders.Text <> '' then
          SQL.Add('AND Clock_RdrCode = ' + Copy(cmbreaders.Text, 1, Pos('-', cmbreaders.Text)-1));
        if txtSTime.Text <> '' then
          SQL.Add('AND Clock_Time >= ' + IntToStr(TimeToInt(txtSTime.Text)));
        if txtETime.Text <> '' then
          SQL.Add('AND Clock_Time <= ' + IntToStr(TimeToInt(txtETime.Text)));

        if rdoSort.ItemIndex = 0 then
          SQL.Add('ORDER BY Clock_RdrCode, Clock_BarCode, Clock_Date, Clock_Time')
        else
          SQL.Add('ORDER BY Clock_RdrCode, Clock_Date, Clock_Time, Clock_BarCode');

        Open;
        Mouse_NoWait;
        if RecordCount > 0 then
        begin
          if rdoScreen.Checked then
            Preview
          else
            Print;
        end
        else
          InformationMessage(' —œœÌ ÊÃÊœ ‰œ«—œ. ');
        Close;
      end;
      Free;
    end;
  end
  else if cmbType.ItemIndex = 2 then
  begin
    Mouse_Wait;
    CreateInOutTbl(txtFromDate.Text, txtToDate.Text);
    G_FromDate := txtFromDate.Text;
    G_ToDate := txtToDate.Text;
    Application.CreateForm(TqrptInOutRdr, qrptInOutRdr);
    with qrptInOutRdr do
    begin
      RPTSetWinF;
      lblCoName.Caption := g_options.CoName;
      if g_options.Shobeh <> '' then lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
      lblDate.Caption := CurrentDate;

      DataSet := adoQryIO;

      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFTDate.Caption := ('«“  «—ÌŒ : ') + txtFromDate.Text + ('    «  «—ÌŒ : ') + txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFTDate.Caption := ('«“  «—ÌŒ : ') + txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFTDate.Caption := (' «  «—ÌŒ : ') + txtToDate.Text
      else
        lblFTDate.Caption := '';

      if chkEndRep.Checked then
      begin
        lblEndRep1.Caption := F_Params.EndRep01;
        lblEndRep2.Caption := F_Params.EndRep02;
        lblEndRep3.Caption := F_Params.EndRep03;
        lblEndRep4.Caption := F_Params.EndRep04;
        lblEndRep5.Caption := F_Params.EndRep05;
      end
      else
        bndSum.Enabled := False;

      with adoQryIO do
      begin
        Connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('SELECT * FROM IORdr');
        SQL.Add('WHERE NOT (Clock_BarCode IS NULL)');

        if (SelFlag = True) and (frmSelect.lstSelect.Items.Count > 0) then
        begin
          SQL.Add('And Clock_BarCode IN (');
          for i := 0 to frmSelect.lstSelect.Items.Count -1 do
          begin
            SQL.Add(''''+frmSelect.lstSelect.Items.Strings[i]+'''');
            if i = frmSelect.lstSelect.Items.Count -1 then
              SQL.Add(')')
            else
              SQL.Add(',');
          end;
        end;

        if cmbBarCode.Text <> '' then
          SQL.Add('AND Clock_BarCode = ''' + cmbBarCode.Text + '''');
        if cmbreaders.Text <> '' then
          SQL.Add('AND Clock_RdrCode = ' + Copy(cmbreaders.Text, 1, Pos('-', cmbreaders.Text)-1));
        if txtSTime.Text <> '' then
          SQL.Add('AND Clock_Time >= ' + IntToStr(TimeToInt(txtSTime.Text)));
        if txtETime.Text <> '' then
          SQL.Add('AND Clock_Time <= ' + IntToStr(TimeToInt(txtETime.Text)));

        if rdoSort.ItemIndex = 0 then
          SQL.Add('ORDER BY Clock_BarCode, Clock_Date, Clock_Time')
        else
          SQL.Add('ORDER BY Clock_Date, Clock_Time, Clock_BarCode');

        Open;
        Mouse_NoWait;
        if RecordCount > 0 then
        begin
          if rdoScreen.Checked then
            Preview
          else
            Print;
        end
        else
          InformationMessage(' —œœÌ ÊÃÊœ ‰œ«—œ. ');
        Close;
      end;
      Free;
    end;
  end;
end;

end.
