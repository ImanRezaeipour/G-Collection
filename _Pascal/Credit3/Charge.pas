unit Charge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DosMove, ExtCtrls, Grids, XStringGrid, DB,
  DBTables, DBGrids, farsi, ComCtrls, ADODB, DBCtrls;

type
  TfrmCharge = class(TForm)
    DosMove1: TDosMove;
    grpRight: TGroupBox;
    DataSource1: TDataSource;
    Table1: TTable;
    Table1FIELD1: TStringField;
    Table1EmplNo: TStringField;
    Table1EmplName: TStringField;
    Table1EmplFamily: TStringField;
    Table1EmplPart: TStringField;
    rdoTextFile: TRadioButton;
    rdoScope: TRadioButton;
    rdoChargeType: TRadioGroup;
    OpenDialog1: TOpenDialog;
    Table1RowNo: TStringField;
    Label2: TLabel;
    pagcharg: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    grpFile: TGroupBox;
    lblNo2: TLabel;
    lbl9: TLabel;
    lblRecNo: TLabel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    btnOk2: TBitBtn;
    txtPath: TEdit;
    cmdPath: TButton;
    grpScope: TGroupBox;
    lblNo: TLabel;
    cmbCode: TComboBox;
    cmbName: TComboBox;
    cbzero: TCheckBox;
    GroupBox1: TGroupBox;
    txtExpireDate: TEdit;
    rdoNoLimit: TRadioButton;
    rdoExpireDate: TRadioButton;
    cmbCardType: TRadioGroup;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    TabControl1: TTabControl;
    GroupBox2: TGroupBox;
    lbl1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    txtDate: TEdit;
    txtCharge: TEdit;
    txtTime: TEdit;
    DataSource2: TDataSource;
    ADOQuery1: TADOQuery;
    lbl10: TLabel;
    cmbCoPosts: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeExit(Sender: TObject);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure btnOk2Click(Sender: TObject);
    procedure cmdPathClick(Sender: TObject);
    procedure rdoTextFileClick(Sender: TObject);
    procedure Table1CalcFields(DataSet: TDataSet);
    procedure cmbCardTypeClick(Sender: TObject);
    procedure txtExpireDateExit(Sender: TObject);
    procedure txtExpireDateKeyPress(Sender: TObject; var Key: Char);
    procedure rdoExpireDateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbCodeClick(Sender: TObject);
    procedure cmbNameClick(Sender: TObject);
    procedure cmbCodeExit(Sender: TObject);
    procedure cmbNameExit(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateExit(Sender: TObject);
    procedure txtChargeKeyPress(Sender: TObject; var Key: Char);
    procedure btnOKClick(Sender: TObject);
    procedure cmbCoPostsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    procedure SetWinF;
    procedure FillComboBoxes;

  public
    { Public declarations }
  end;

var
  frmCharge: TfrmCharge;


implementation

uses
  Funcs, DateProc, DBS,{ ADODB,} Globals, Keyboard, MSGs, FntSel, Code_Sys;



{$R *.dfm}

procedure TfrmCharge.SetWinF;
begin
end;


procedure TfrmCharge.FillComboBoxes;
begin
  cmbCode.Clear;
  cmbName.Clear;

  cmbCode.Enabled := (cmbCardType.ItemIndex <> 0);
  cmbName.Enabled := cmbCode.Enabled;
  if cmbCardType.ItemIndex <> 0 then
  begin
    with frmDBS.adoQryG do
    begin
      SQL.Clear;
      if cmbCardType.ItemIndex = 1 then
      begin
        SQL.Add('SELECT Empl_No, Empl_Family, Empl_Name FROM Employee WHERE Empl_Active <> ' + IntToStr(MB_FALSE));
        if gOptions.UserDepart <> 0 then
          SQL.Add('AND Empl_Department = ' + IntToStr(gOptions.UserDepart));
        SQL.Add('ORDER BY Empl_Family, Empl_Name');
      end
      else if cmbCardType.ItemIndex = 2 then
        SQL.Add('SELECT CoPost_Code, CoPost_Name FROM CoPosts ORDER BY CoPost_Name')
      else if cmbCardType.ItemIndex = 3 then
        SQL.Add('SELECT Part_Code, Part_Name FROM Parts ORDER BY Part_Name')
      else if cmbCardType.ItemIndex = 4 then
        SQL.Add('SELECT Dscnt_No, Dscnt_Name FROM Discount ORDER BY Dscnt_Name');
      Open;
      while not Eof do
      begin
        if cmbCardType.ItemIndex = 1 then
        begin
          cmbCode.Items.Add(FieldByName('Empl_No').AsString);
          cmbName.Items.Add(FieldByName('Empl_Family').AsString + '-' + FieldByName('Empl_Name').AsString);
        end
        else if cmbCardType.ItemIndex = 2 then
        begin
          cmbCode.Items.Add(FieldByName('CoPost_Code').AsString);
          cmbName.Items.Add(FieldByName('CoPost_Name').AsString);
        end
        else if cmbCardType.ItemIndex = 3 then
        begin
          cmbCode.Items.Add(FieldByName('Part_Code').AsString);
          cmbName.Items.Add(FieldByName('Part_Name').AsString);
        end
        else if cmbCardType.ItemIndex = 4 then
        begin
          cmbCode.Items.Add(FieldByName('Dscnt_No').AsString);
          cmbName.Items.Add(FieldByName('Dscnt_Name').AsString);
        end;

        Next;
      end;
      Close;
    end;
    cmbCode.ItemIndex := 0;
    cmbName.ItemIndex := 0;
  end;
end;

procedure TfrmCharge.FormCreate(Sender: TObject);
begin
  SetFontColor(TForm(frmCharge));
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT CoPost_Code, CoPost_Name FROM CoPosts');
    Open;
    while not EOF do
    begin
      cmbCoPosts.Items.Add(FieldByName('CoPost_Code').AsString + '-' + FieldByName('CoPost_Name').AsString);
      Next;
    end;
    Close;
  end;

  //txtDate.Text := CurrentDate;
  //txtTime.Text := CurrentTime;
  //txtCharge.Text := FloatToStr(gParams.chargePrice);


  rdoTextFile.Checked := true;
end;

procedure TfrmCharge.FormActivate(Sender: TObject);
begin
  FillComboBoxes;
end;

procedure TfrmCharge.cmbCodeClick(Sender: TObject);
begin
  cmbName.ItemIndex := cmbCode.ItemIndex;
end;

procedure TfrmCharge.cmbNameClick(Sender: TObject);
begin
  cmbCode.ItemIndex := cmbName.ItemIndex;
end;

procedure TfrmCharge.cmbCodeExit(Sender: TObject);
begin
  if (cmbCode.Text <> '') and (cmbCode.ItemIndex = -1)
  then begin
    cmbCode.Text:=FixLeft(cmbCode.Text,'0',8);
    cmbCode.ItemIndex := cmbCode.Items.IndexOf(cmbCode.Text);
  end;
  cmbName.ItemIndex := cmbCode.ItemIndex;
end;

procedure TfrmCharge.cmbCoPostsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbCoPosts.ItemIndex := -1;
  end;
end;

procedure TfrmCharge.cmbNameExit(Sender: TObject);
begin
  if (cmbName.Text <> '') and (cmbName.ItemIndex = -1) then
    cmbName.ItemIndex := cmbName.Items.IndexOf(cmbName.Text);
  cmbCode.ItemIndex := cmbName.ItemIndex;
end;

procedure TfrmCharge.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCharge.txtDateExit(Sender: TObject);
begin
  if txtDate.Text <> '' then
    txtDate.Text := BeautifulDate(txtDate.Text);
end;

procedure TfrmCharge.txtChargeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmCharge.btnOKClick(Sender: TObject);
var
   adoQry : TADOQuery;
   expDate : string;
   y:integer;
begin
y:=1;
if txtDate.Text = '' then
 begin
    ErrorMessage(' «—ÌŒ „‘Œ’ ‰‘œÂ «” .');
    txtDate.SetFocus;
  end
  else if txtTime.Text = '' then
  begin
    ErrorMessage('“„«‰ „‘Œ’ ‰‘œÂ «” .');
    txtTime.SetFocus;
  end
  else if txtCharge.Text = '' then
  begin
    ErrorMessage('„»·€ ‘«—é ﬂ«—  „‘Œ’ ‰‘œÂ «” .');
    txtCharge.SetFocus;
  end
  else if cmbCode.Enabled and (cmbCode.Text = '') then
  begin
    ErrorMessage('ÂÌç «‰ Œ«»Ì ’Ê—  ‰ê—› Â «” .');
    cmbCode.SetFocus;
  end
  else  if cmbCode.Enabled and (cmbCode.ItemIndex = -1) then
  begin
    ErrorMessage('«‰ Œ«» ‰«œ—”  «” !');
    cmbCode.SetFocus;
  end
  else if rdoExpireDate.Checked and (txtExpireDate.Text = '') then
  begin
    ErrorMessage(' «—ÌŒ Å«Ì«‰ «⁄ »«— „‘Œ’ ‰‘œÂ «”  .');
    txtExpireDate.SetFocus;
  end
  else
  begin
    if rdoNoLimit.Checked then
        expDate := ''
    else
        expDate := txtExpireDate.Text;
    if cmbCardType.ItemIndex = 1 then
    begin
      if not ChargeEmployee(cmbCode.Text,strtoint(Label2.Caption)  ,txtTime.Text, StrToFloat(txtCharge.Text),expDate ,cbzero.Checked ) then
        ErrorMessage('»—«Ì «Ì‰ ﬂ«—  ﬁ»·«  «„Ì‰ «⁄ »«— ‘œÂ «” .');
    end
    else
    begin
      adoQry := TADOQuery.Create(Application);
      with adoQry do
      begin
        Connection := frmDBS.adoConnect;
        SQL.Clear;
        SQL.Add('SELECT Empl_No FROM Employee WHERE Empl_Active <> ' + IntToStr(MB_FALSE));
        if gOptions.UserDepart <> 0 then
          SQL.Add('AND Empl_Department = ' + IntToStr(gOptions.UserDepart));

        if cmbCardType.ItemIndex = 2 then
          begin
          SQL.Add('AND Empl_CoPost = ' + cmbCode.Text);
          y:=5;
          end;

        if cmbCardType.ItemIndex = 3 then
          SQL.Add('AND Empl_Part = ' + cmbCode.Text)
        else if cmbCardType.ItemIndex = 4 then
          SQL.Add('AND Empl_Dscnt = ' + cmbCode.Text);
        Open;
        lblNo.Visible := True;
        Mouse_Wait;
      while not Eof do
        begin
          lblNo.Caption := IntToStr(RecNo) + '/' + IntToStr(RecordCount);
          lblNo.Refresh;
          if (StrToInt(txtCharge.Text) > 0) then
            ChargeEmployee(FieldByName('Empl_No').AsString , strtoint(Label2.Caption)  , txtTime.Text, StrToFloat(txtCharge.Text),expDate,cbzero.Checked  );
          Next;
        end;
        Close;
        lblNo.Visible := False;
        Mouse_NoWait;
      end;
    end;
    InformationMessage('‘«—é ﬂ«— Â« «‰Ã«„ ‘œ.');
   if y = 5 then
    begin
    frmCharge.Close;
    end;

 end;

end;

procedure TfrmCharge.rdoExpireDateClick(Sender: TObject);
begin
   txtExpireDate.Enabled := rdoExpireDate.Checked;
end;

procedure TfrmCharge.txtExpireDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmCharge.txtExpireDateExit(Sender: TObject);
begin
  if txtExpireDate.Text <> '' then
    txtExpireDate.Text := BeautifulDate(txtExpireDate.Text);
end;

procedure TfrmCharge.cmbCardTypeClick(Sender: TObject);
begin
FillComboBoxes;
end;

procedure TfrmCharge.Table1CalcFields(DataSet: TDataSet);
var
  s : string;
  empl : TEmployee;
  function GetField(st :string ; fieldNo : integer) : string;
  var
    i : integer;
  begin
    for i:= 1 to fieldNo-1 do
      delete(st,1,pos(',',st));
    delete(st,pos(',',st),length(st)-pos(',',st)+1);
    Result := Trim(st);
  end;
begin
  s := SysToWinRToL(table1.FieldByName('field1').AsString);
  Table1.FieldByName('RowNo').AsString := GetField(s,4{7});
  Table1.FieldByName('EmplNo').AsString := GetField(s,5{7});
  empl := GetEmployee(Table1.FieldByName('EmplNo').AsString , False);
  Table1.FieldByName('EmplNameInDB').AsString := empl.EmplFamily + ' - ' + empl.EmplName;
  Table1.FieldByName('EmplNameInFile').AsString := GetField(s,2{4}) + ' - ' + GetField(s,3{5});
  Table1.FieldByName('EmplPart').AsString := GetField(s,1{1});
end;

procedure TfrmCharge.rdoTextFileClick(Sender: TObject);
begin
{  if (sender as TRadioButton).Name = 'rdoTextFile' then
  begin
    grpScope.Align := alNone;
    grpScope.Hide;
    grpFile.Show;
    grpFile.Align := alClient;
  end
  else
  begin
    grpScope.Align := alClient;
    grpScope.Show;
    grpFile.Hide;
    grpFile.Align := alClient;
  end  }
end;

procedure TfrmCharge.cmdPathClick(Sender: TObject);
begin
 if OpenDialog1.Execute then
  begin
    try
      Table1.CLOSE;
      txtPath.Text := OpenDialog1.FileName;
      Table1.TableName := txtPath.Text;
      Table1.Open;
      lblRecNo.Caption := IntToStr(Table1.RecordCount);
    except
      on E: Exception do
        ErrorMessage('»«“ê‘«ÌÌ ›«Ì· ‰«„Ê›ﬁ »Êœ ' + #13 + e.Message);
    end;
  end; 
end;

procedure TfrmCharge.BitBtn1Click(Sender: TObject);
begin
    frmCharge.Close;
end;

procedure TfrmCharge.btnCancelClick(Sender: TObject);
begin
frmCharge.Close;
  
end;

procedure TfrmCharge.btnOk2Click(Sender: TObject);
var
   expDate : string;
   i,s : integer;
   adoTbl :  TADOTable;
   adoQry : TADOQuery;
begin
  adoTbl := TADOTable.Create(Application);
  adoTbl.Connection := frmDBS.adoConnect;
  adoQry := TADOQuery.Create(Application);
  adoQry.Connection := frmDBS.adoConnect;
  Table1.DisableControls;
  expDate := '';
  if txtDate.Text = '' then
  begin
    ErrorMessage(' «—ÌŒ „‘Œ’ ‰‘œÂ «” .');
    txtDate.SetFocus;
  end
  else if txtTime.Text = '' then
  begin
    ErrorMessage('“„«‰ „‘Œ’ ‰‘œÂ «” .');
    txtTime.SetFocus;
  end
  else if txtCharge.Text = '' then
  begin
    ErrorMessage('„»·€ ‘«—é ﬂ«—  „‘Œ’ ‰‘œÂ «” .');
    txtCharge.SetFocus;
  end
  else if not Table1.Active then
  begin
    ErrorMessage('›«Ì· «‰ Œ«» ‰‘œÂ «”  .');
    cmdPath.SetFocus;
  end
  else
  begin
    with Table1 do
    begin
      lblNo2.Visible := True;
      Mouse_Wait;
//    Table1.DisableControls;
      First;
      i := 0;
      while not Eof do
      begin
        lblNo2.Caption := IntToStr(i) + '/' + IntToStr(RecordCount);
        lblNo2.Refresh;
        if (FieldByName('EmplNameInDB').AsString <> ' - ') or
           ((FieldByName('EmplNameInDB').AsString = ' - ') and
           (ConfirmMessage('„‘Œ’«  «Ì‰ —òÊ—œ œ— »«‰ò «ÿ·«⁄« Ì ÊÃÊœ ‰œ«—œ .' +
           #13 + '¬Ì« „ÌŒÊ«ÂÌœ ›—œ ÃœÌœ »Â »«‰ò «ÿ·«⁄« Ì «÷«›Â ê—œœ .')))
        then
        begin
          if (FieldByName('EmplNameInDB').AsString = ' - ') then
          begin
            with adoQry do
            begin
              try
                Table1.EnableControls;
                SQL.Clear;
                sql.Add('INSERT INTO Employee (Empl_No,Empl_ID,Empl_Name,Empl_Family,Empl_Active,Empl_Part,Empl_CoPost) VALUES (');
                sql.Add('N''' + FixLeft(Table1.FieldByName('EmplNo').AsString,'0',8) + ''',');
                sql.Add('N''00000000'',');
                s := pos('-' , table1.FieldByName('EmplNameInFile').AsString);
                sql.Add('N''' + Trim(copy(table1.FieldByName('EmplNameInFile').AsString , 1,s-1)) + ''',');
                sql.Add('N''' + Trim(copy(table1.FieldByName('EmplNameInFile').AsString , s+1,length(table1.FieldByName('EmplNameInFile').AsString)-s)) + ''',');
                sql.Add('1,');
                sql.Add(table1.FieldByName('EmplPart').AsString + ',');
                sql.Add(Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1) + ')');
                ExecSQL;
//              TableName := 'Employee';
//              open;
//              append;
//              FieldByName('empl_No').AsString := ;
//              s := pos('-' , table1.FieldByName('EmplNameInFile').AsString);
//              FieldByName('empl_ID').AsString := '00000000';
//              FieldByName('empl_Name').AsString := Trim(copy(table1.FieldByName('EmplNameInFile').AsString , s+1,length(table1.FieldByName('EmplNameInFile').AsString)-s));
//              FieldByName('empl_Family').AsString := Trim(copy(table1.FieldByName('EmplNameInFile').AsString , 1,s-1));
//              FieldByName('empl_Part').AsString := table1.FieldByName('EmplPart').AsString;
//              FieldByName('empl_Active').AsBoolean := true;
//              Post;
                InformationMessage('›—œ ÃœÌœ »« „Ê›ﬁÌ  »Â »«‰ò «÷«›Â ‘œ .');
              except
                InformationMessage('⁄„·Ì«  ‰«„Ê›ﬁ.');
              end;
              Table1.DisableControls;
            end;
          end
          else
          begin
            with adoQry do
            begin
              try
                SQL.Clear;
                sql.Add('UPDATE Employee');
                sql.Add('SET Empl_Part=' + table1.FieldByName('EmplPart').AsString);
                sql.Add(', Empl_CoPost=' + Copy(cmbCoPosts.Text, 1, Pos('-', cmbCoPosts.Text)-1) + ' WHERE');
                sql.Add('Empl_No= ' + FixLeft(Table1.FieldByName('EmplNo').AsString,'0',8));
                ExecSQL;

//                TableName := 'Employee';
//                open;
//                if Locate('empl_no',FixLeft(Table1.FieldByName('EmplNo').AsString,'0',8),[loPartialKey]) then
//                begin
//                  Edit;
//                  FieldByName('empl_Part').AsString := table1.FieldByName('EmplPart').AsString;
//                  Post;
//                end;
//                Close;
              except
                InformationMessage('⁄„·Ì«  ‰«„Ê›ﬁ.');
              end;
            end;
          end;
          if (StrToInt(txtCharge.Text) > 0) then
            ChargeEmployee(FieldByName('EmplNo').AsString  ,strtoint(Label2.Caption)  , txtTime.Text, StrToFloat(txtCharge.Text),expDate,cbzero.Checked );
          inc(i);
        end;
        Next;
      end;
//      Table1.EnableControls;
      Close;
      lblNo2.Visible := False;
      Mouse_NoWait;
    end;
    InformationMessage('‘«—é ﬂ«— Â« «‰Ã«„ ‘œ.');
    frmCharge.Close;
  end;
  Table1.EnableControls;  
end;
procedure TfrmCharge.Table1AfterScroll(DataSet: TDataSet);
begin
  lblNo2.Caption := IntToStr(Table1.RecNo);
end;

procedure TfrmCharge.txtTimeExit(Sender: TObject);
begin
  if txtTime.Text <> '' then
    txtTime.Text := BeautifulTime(txtTime.Text);
end;

procedure TfrmCharge.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

end.



