unit updateDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, MSGs, DateProc, Keyboard,
  DBS_Proc, DB, ExtCtrls;

type
  TfrmUpdateDB = class(TForm)
    cmdDel: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    chkPersons: TCheckBox;
    chkParts: TCheckBox;
    chkJobType: TCheckBox;
    GroupBox1: TGroupBox;
    lblSQLPass: TLabel;
    lblSqlUser: TLabel;
    lblServer: TLabel;
    txtSqlPass: TEdit;
    txtSqlUser: TEdit;
    txtServer: TEdit;
    lblPersons: TLabel;
    lblParts: TLabel;
    lblJobType: TLabel;
    chkAdd: TCheckBox;
    Bevel1: TBevel;
    chkDelete: TCheckBox;
    Bevel2: TBevel;
    lblreserve7: TLabel;
    chkreserve7: TCheckBox;
    txtdatabasename: TEdit;
    Label1: TLabel;
    procedure cmdDelClick(Sender: TObject);
    procedure txtFromFishKeyPress(Sender: TObject; var Key: Char);
    procedure chkFishKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure incLbl(lbl : TLabel);
    procedure SendTab(var Key : Char);

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}



procedure TfrmUpdateDB.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := Self.FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmUpdateDB.chkFishKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmUpdateDB.txtFromFishKeyPress(Sender: TObject;
  var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmUpdateDB.cmdDelClick(Sender: TObject);
var
  qry : TAdoQuery;
  tbl : TAdoTable;
  adoQry : TADOQuery;
begin
  F_Params.cLkServerName := txtServer.Text;
  F_Params.cLkdatabasename := txtdatabasename.Text;
  F_Params.clkSqlUseName := txtSqlUser.Text;
  F_Params.clkSqlPassword := txtSqlPass.Text;
  lblPersons.Caption := '';
  lblParts.Caption := '';
  lblJobType.Caption := '';
  lblreserve7.Caption := '';
  SaveIniFile;

  if ConfirmMessage('¬Ì« »—«Ì »—Ê“ —”«‰Ì «ÿ·«⁄«  «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    Mouse_Wait;
    qry := TAdoQuery.Create(Application);
    tbl := TAdoTable.Create(Application);
    adoQry := TADOQuery.Create(Application);

    qry.connection := frmDBS.DBConnection;
    tbl.connection := frmDBS.DBConnection;

    adoQry.ConnectionString := 'Provider=SQLOLEDB.1; Persist Security Info=True;Initial Catalog=Clock;'+
                               'Data Source=' + txtServer.Text +
                               ';User ID=' + txtSqlUser.Text +
                               ';Password=' + txtSqlPass.Text;

    if chkPersons.Checked then
    begin
      tbl.Close;
      tbl.TableName := 'persons';
      tbl.Open;


      adoQry.SQL.Clear;
      adoQry.SQL.add('SELECT * FROM PERSONS');
      adoQry.Open;
      adoqry.First;
      while not adoQry.eof do
      begin
        if tbl.Locate('p_barcode' , adoQry.fieldByName('p_barcode').AsString , [loPartialKey]) then
        begin
          tbl.edit;
          tbl.FieldByName('p_Proxi').AsString := adoQry.fieldByName('p_Proxi').AsString;
          tbl.FieldByName('p_name').AsString := adoQry.fieldByName('p_name').AsString;
          tbl.FieldByName('p_Family').AsString := adoQry.fieldByName('p_Family').AsString;
          tbl.FieldByName('P_JobCode').AsInteger := adoQry.fieldByName('P_JobCode').AsInteger;
          tbl.FieldByName('P_parts').AsString := adoQry.fieldByName('P_parts').AsString;
          tbl.FieldByName('P_reserve7').AsString := adoQry.fieldByName('P_reserve7').AsString;
          tbl.FieldByName('P_IsValid').AsBoolean := adoQry.fieldByName('P_IsValid').AsBoolean;
          tbl.post;
          incLbl(lblPersons);
        end
        else if chkAdd.Checked then
        begin
          tbl.Insert;
          tbl.FieldByName('p_barcode').AsString := adoQry.fieldByName('p_barcode').AsString;
          tbl.FieldByName('p_Proxi').AsString := adoQry.fieldByName('p_Proxi').AsString;
          tbl.FieldByName('p_name').AsString := adoQry.fieldByName('p_name').AsString;
          tbl.FieldByName('p_Family').AsString := adoQry.fieldByName('p_Family').AsString;
          tbl.FieldByName('P_JobCode').AsInteger := adoQry.fieldByName('P_JobCode').AsInteger;
          tbl.FieldByName('P_parts').AsString := adoQry.fieldByName('P_parts').AsString;
          tbl.FieldByName('P_reserve7').AsString := adoQry.fieldByName('P_reserve7').AsString;
          tbl.FieldByName('P_IsValid').AsBoolean := adoQry.fieldByName('P_IsValid').AsBoolean;
          tbl.FieldByName('P_Isguest').AsBoolean := false;

          tbl.FieldByName('P_ShiftGroup').AsInteger := 0;
          tbl.FieldByName('P_CashType').AsInteger := 0;
          tbl.FieldByName('P_ValidTest').AsBoolean := false;
          tbl.FieldByName('P_Pricable').AsBoolean := false;
          tbl.FieldByName('P_Sobhaneh').AsBoolean := false;
          tbl.FieldByName('P_Nahar').AsBoolean := false;
          tbl.FieldByName('P_Sham').AsBoolean := false;
          tbl.FieldByName('P_Rejim').AsBoolean := False;
          tbl.FieldByName('P_DblFood').AsBoolean := false;

          tbl.post;
          incLbl(lblPersons);
        end;
        adoQry.Next;
      end;
      if chkDelete.Checked then
      begin
        tbl.First;
        while not tbl.eof do
        begin
          if (not adoQry.Locate('p_barcode' , tbl.fieldByName('p_barcode').AsString , [loPartialKey])) and (not tbl.fieldByName('p_isGuest').AsBoolean) then
            tbl.Delete
          else
            tbl.Next;
        end;
      end;
    end;

    if chkParts.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Parts');
      qry.ExecSQL;

      tbl.Close;
      tbl.TableName := 'parts';
      tbl.Open;
      tbl.First;

      adoQry.Close;
      adoQry.SQL.Clear;
      adoQry.SQL.add('SELECT * FROM parts');
      adoQry.Open;
      while not adoQry.Eof do
      begin
        tbl.Insert;
        tbl.FieldByName('P_Code').AsString := adoQry.FieldByName('P_Code').AsString;
        tbl.FieldByName('P_CustomCode').AsString := adoQry.FieldByName('P_CustomCode').AsString;
        tbl.FieldByName('P_Name').AsString := adoQry.FieldByName('P_Name').AsString;
        tbl.FieldByName('P_LChild').AsString := adoQry.FieldByName('P_LChild').AsString;
        tbl.FieldByName('P_RSibling').AsString := adoQry.FieldByName('P_RSibling').AsString;
        tbl.FieldByName('P_Father').AsString := adoQry.FieldByName('P_Father').AsString;
        tbl.post;
        adoQry.Next;
        incLbl(lblParts);
      end;
    end;

    if chkJobType.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM JobType');
      qry.ExecSQL;

      tbl.Close;
      tbl.TableName := 'JobType';
      tbl.Open;
      tbl.First;

      adoQry.Close;
      adoQry.SQL.Clear;
      adoQry.SQL.add('SELECT * FROM JobType');
      adoQry.Open;

      while not adoQry.Eof do
      begin
        tbl.Insert;
        tbl.FieldByName('job_Code').AsInteger := adoQry.FieldByName('job_Code').AsInteger;
        tbl.FieldByName('job_Name').AsString := adoQry.FieldByName('job_Name').AsString;
        tbl.post;
        adoQry.Next;
        incLbl(lblJobType);
      end;
    end;

    if chkreserve7.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM reserve7');
      qry.ExecSQL;

      tbl.Close;
      tbl.TableName := 'reserve7';
      tbl.Open;
      tbl.First;

      adoQry.Close;
      adoQry.SQL.Clear;
      adoQry.SQL.add('SELECT * FROM reserve7');
      adoQry.Open;

      while not adoQry.Eof do
      begin
        tbl.Insert;
        tbl.FieldByName('rsrv7_Name').AsString := adoQry.FieldByName('rsrv7_Name').AsString;
        tbl.post;
        adoQry.Next;
        incLbl(lblReserve7);
      end;
    end;

    tbl.Free;
    qry.Free;
    InitVariables(False);
    Mouse_NoWait;
  end;
end;

procedure TfrmUpdateDB.FormCreate(Sender: TObject);
begin
  txtServer.Text  := F_Params.cLkServerName;
  txtdatabasename.Text  := F_Params.cLkdatabasename;
  txtSqlUser.Text := F_Params.clkSqlUseName;
  txtSqlPass.Text := F_Params.clkSqlPassword;
  lblPersons.Caption := '';
  lblParts.Caption := '';
  lblJobType.Caption := '';
  lblReserve7.Caption := '';
end;

procedure TfrmUpdateDB.incLbl(lbl: TLabel);
begin
  if lbl.Caption <> '' then
    lbl.Caption := IntToStr(StrToInt(lbl.Caption) + 1)
  else
    lbl.Caption := '1';
  Refresh;
end;

end.
