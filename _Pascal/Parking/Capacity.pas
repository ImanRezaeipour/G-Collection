unit Capacity;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, AdoDB, Grids, DBGrids, Globals, Keyboard, MSGs,
  DBS, ExtCtrls;

type
  TfrmCapacity = class(TForm)
    grpAll: TGroupBox;
    Label1: TLabel;
    txtMaxPlan: TEdit;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    dbgCap: TDBGrid;
    dtaCap: TDataSource;
    qryCap: TAdoQuery;
    qryCapType_Name: TStringField;
    qryCapCap_Max: TSmallintField;
    qryCapCap_Plan: TSmallintField;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    grpEdit: TGroupBox;
    Label2: TLabel;
    cmbTypes: TComboBox;
    Label4: TLabel;
    txtPlan: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    Label3: TLabel;
    txtMany: TEdit;
    qryCapCap_MaxPlan: TSmallintField;
    qryCapCap_TypeCode: TSmallintField;
    Label5: TLabel;
    txtStartPlan: TEdit;
    Bevel1: TBevel;
    qryCapCap_StartPlan: TSmallintField;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure txtMaxPlanKeyPress(Sender: TObject; var Key: Char);
    procedure dbgCapKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure txtPlanKeyPress(Sender: TObject; var Key: Char);
    procedure txtManyKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTypesKeyPress(Sender: TObject; var Key: Char);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtStartPlanKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;
    BefPlan, BefStart : Integer;

    procedure FormInEdit(vis : Boolean);
    procedure ClearScreen;
    function  AreValidFields : Boolean;
    function  AllowPlanChange : Boolean;
    function  PlanNoSave : Integer;
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}
procedure TfrmCapacity.SetWinF;
begin
  Caption := (Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  qryCapCap_Plan.DisplayLabel := (qryCapCap_Plan.DisplayLabel);
  qryCapType_Name.DisplayLabel := (qryCapType_Name.DisplayLabel);
  qryCapCap_Max.DisplayLabel := (qryCapCap_Max.DisplayLabel);
end;

procedure TfrmCapacity.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

procedure TfrmCapacity.ClearScreen;
begin
  txtPlan.Text := '';
  txtMany.Text := '';
  cmbTypes.ItemIndex := -1;
end;

function TfrmCapacity.AreValidFields : Boolean;
var qry : TAdoQuery;
begin
  if txtMaxPlan.Text = '' then
  begin
    ErrorMessage(' ⁄œ«œ ÿ»ﬁ«  „‘Œ’ ‰‘œÂ «” .');
    AreValidFields := False;
  end
  else if txtStartPlan.Text = '' then
  begin
    ErrorMessage('Å«ÌÌ‰  —Ì‰ ÿ»ﬁÂ „‘Œ’ ‰‘œÂ «” .');
    AreValidFields := False;
  end
  else if txtPlan.Text = '' then
  begin
    ErrorMessage('ÿ»ﬁÂ „‘Œ’ ‰‘œÂ «” .');
    txtPlan.SetFocus;
    AreValidFields := False;
  end
  else if (StrToInt(txtPlan.Text) < StrToInt(txtStartPlan.Text)) or (ABS(StrToInt(txtStartPlan.Text) - StrToInt(txtPlan.Text)) >= StrToInt(txtMaxPlan.Text)) then
  begin
    ErrorMessage('‘„«—Â ÿ»ﬁÂ œ— ÿ»ﬁ«  ‰„Ìùê‰Ãœ.');
    txtPlan.SetFocus;
    AreValidFields := False;
  end
  else if txtMany.Text = '' then
  begin
    ErrorMessage(' ⁄œ«œ „‘Œ’ ‰‘œÂ «” .');
    txtMany.SetFocus;
    AreValidFields := False;
  end
  else if (cmbTypes.Text = '') or (cmbTypes.Items.IndexOf(cmbTypes.Text) = -1) then
  begin
    ErrorMessage('‰Ê⁄ ŒÊœ—Ê „‘Œ’ ‰‘œÂ «” .');
    cmbTypes.SetFocus;
    AreValidFields := False;
  end
  else
  begin
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM Capacity');
    qry.SQL.Add('WHERE Cap_Plan = ' + txtPlan.Text);
    qry.SQL.Add('AND Cap_TypeCode = ' + IntToStr(GetTypeCode(cmbTypes.Text)));
    qry.Open;
    if not qry.EOF and (Flag = MB_NEW) then
    begin
      ErrorMessage(' ⁄œ«œ ŒÊœ—Ê œ— «Ì‰ ÿ»ﬁÂ  ﬂ—«—Ì «” .');
      AreValidFields := False;
    end
    else
      AreValidFields := True;
    qry.Close;
    qry.Free;
  end;
end;

function TfrmCapacity.AllowPlanChange : Boolean;
var
  qry : TAdoQuery;
  dif : String;
begin
  AllowPlanChange := True;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  if qryCap.RecordCount > 0 then
  begin
    if BefPlan <> StrToInt(txtMaxPlan.Text) then
    begin
      if StrToInt(txtMaxPlan.Text) < PlanNoSave then
      begin
        InformationMessage('«» œ« ÿ»ﬁ«  «÷«›Ì —« Õ–› ‰„ÊœÂ Ê ”Å”  ⁄œ«œ ÿ»ﬁ«  —« ﬂ„ ﬂ‰Ìœ.');
        AllowPlanChange := False;
      end
      else
      begin
        if ConfirmMessage('¬Ì« »—«Ì  €ÌÌ— ÿ»ﬁ«  «ÿ„Ì‰«‰ œ«—Ìœø') then
        begin
          qry.SQL.Clear;
          qry.SQL.Add('UPDATE Capacity SET Cap_MaxPlan = ' + txtMaxPlan.Text);
          qry.ExecSQL;
          AllowPlanChange := True;
        end
        else
          txtMaxPlan.Text := IntToStr(BefPlan);
      end;
    end;

    if BefStart <> StrToInt(txtStartPlan.Text) then
    begin
      if ConfirmMessage('¬Ì« »—«Ì  €ÌÌ— Å«∆Ì‰ù —Ì‰ ÿ»ﬁÂ «ÿ„Ì‰«‰ œ«—Ìœø') then
      begin
        dif := IntToStr(StrToInt(txtStartPlan.Text) - BefStart);
        qry.SQL.Clear;
        qry.SQL.Add('UPDATE Capacity SET Cap_StartPlan = Cap_StartPlan + ' + dif);
        qry.ExecSQL;
        qry.SQL.Clear;
        qry.SQL.Add('UPDATE Capacity SET Cap_Plan = Cap_Plan + ' + dif);
        qry.ExecSQL;
        AllowPlanChange := True;
      end
      else
        txtStartPlan.Text := IntToStr(BefStart);
    end;
  end;
  qry.Free;
end;

function TfrmCapacity.PlanNoSave : Integer;
var qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT DISTINCT Cap_Plan FROM Capacity');
  qry.Open;
  PlanNoSave := qry.RecordCount;
  qry.Close;
  qry.Free;
end;

procedure TfrmCapacity.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  qryCap.connection := frmDBS.adoConnect;

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT Type_Name FROM CarTypes');
  qry.Open;
  while not qry.EOF do
  begin
    cmbTypes.Items.Add(qry.FieldByName('Type_Name').AsString);
    qry.Next;
  end;
  qry.Free;

  qryCap.Open;
  if not qryCap.EOF then
  begin
    txtMaxPlan.Text := IntToStr(qryCap.FieldByName('Cap_MaxPlan').AsInteger);
    txtStartPlan.Text := IntToStr(qryCap.FieldByName('Cap_StartPlan').AsInteger);
    BefPlan := qryCap.FieldByName('Cap_MaxPlan').AsInteger;
    BefStart := qryCap.FieldByName('Cap_StartPlan').AsInteger;
  end
  else
  begin
    BefPlan := 0;
    BefStart := 0;
  end;
end;

procedure TfrmCapacity.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmCapacity.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  qryCAp.Close;
end;

procedure TfrmCapacity.txtMaxPlanKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtStartPlan.SetFocus;
  end
  else
    Keyboard_Number(Key, txtMaxPlan.Text);
end;

procedure TfrmCapacity.txtStartPlanKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    dbgCap.SetFocus;
  end
  else
    Keyboard_Number(Key, txtStartPlan.Text);
end;

procedure TfrmCapacity.dbgCapKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
  begin
    Key := 0;
    cmdNewClick(Sender);
  end
  else if Key = 46 then
  begin
    Key := 0;
    cmdDeleteClick(Sender)
  end
  else if Key = 13 then
  begin
    Key := 0;
    cmdEditClick(Sender);
  end;
end;

procedure TfrmCapacity.cmdNewClick(Sender: TObject);
begin
  if AllowPlanChange  then
  begin
    FormInEdit(True);
    Flag := MB_NEW;
    ClearScreen;
    txtPlan.SetFocus;
  end;
end;

procedure TfrmCapacity.cmdEditClick(Sender: TObject);
begin
  if not qryCap.EOF then
  begin
    if AllowPlanChange then
    begin
      FormInEdit(True);
      Flag := MB_EDIT;
      txtPlan.Text := IntToStr(qryCap.FieldByName('Cap_Plan').AsInteger);
      txtMany.Text := IntToStr(qryCap.FieldByName('Cap_Max').AsInteger);
      cmbTypes.Text := qryCap.FieldByName('Type_Name').AsString;
      txtPlan.SetFocus;
   end;
  end;
end;

procedure TfrmCapacity.cmdDeleteClick(Sender: TObject);
var qry : TAdoQuery;
begin
  if not qryCap.EOF then
  begin
    if ConfirmMessage('¬Ì« »—«Ì Õ–› —ﬂÊ—œ «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      qry := TAdoQuery.Create(application);
      qry.connection := frmDBS.adoConnect;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Capacity');
      qry.SQL.Add('WHERE Cap_Plan = ' + IntToStr(qryCap.FieldByName('Cap_Plan').AsInteger));
      qry.SQL.Add('AND Cap_TypeCode = ' + IntToStr(qryCap.FieldByName('Cap_TypeCode').AsInteger));
      qry.ExecSQL;
      qry.Free;
      LoadCapacity;
      qryCap.Close;
      qryCap.Open;
    end;
  end;
end;


procedure TfrmCapacity.txtPlanKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtMany.SetFocus;
  end
  else
    Keyboard_Number(Key, txtPlan.Text);
end;

procedure TfrmCapacity.txtManyKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbTypes.SetFocus;
  end
  else
    Keyboard_Number(Key, txtMany.Text);
end;

procedure TfrmCapacity.cmbTypesKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSave.SetFocus;
  end;
end;

procedure TfrmCapacity.cmdSaveClick(Sender: TObject);
var tbl : TAdoTable;
begin
  if AreValidFields then
  begin
    tbl := TAdoTable.Create(Application);
    tbl.connection := frmDBS.adoConnect;
    tbl.TableName := 'Capacity.Db';
    tbl.ReadOnly := False;
    if Flag = MB_NEW then
    begin
      tbl.Open;
      tbl.Append;
    end
    else
    begin
      tbl.Filter := 'Cap_Plan = ' + IntToStr(qryCap.FieldByName('Cap_Plan').AsInteger) +
                    ' AND Cap_TypeCode = ' + IntToStr(qryCap.FieldByName('Cap_TypeCode').AsInteger);
      tbl.Filtered := True;
      tbl.Open;
      tbl.Edit;
    end;
    tbl.FieldByName('Cap_MaxPlan').AsInteger := StrToInt(txtMaxPlan.Text);
    tbl.FieldByName('Cap_StartPlan').AsInteger := StrToInt(txtStartPlan.Text);
    tbl.FieldByName('Cap_Plan').AsInteger := StrToInt(txtPlan.Text);
    tbl.FieldByName('Cap_TypeCode').AsInteger := GetTypeCode(cmbTypes.Text);
    tbl.FieldByName('Cap_Max').AsInteger := StrToInt(txtMany.Text);
    tbl.Post;
    tbl.Close;
    tbl.Free;
    qryCap.Close;
    qryCap.Open;
    BefPlan := StrToInt(txtMaxPlan.Text);
    BefStart := StrToInt(txtStartPlan.Text);
    LoadCapacity;

    if Flag = MB_NEW then
    begin
      ClearScreen;
      txtPlan.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgCap.SetFocus;
    end;
  end;
end;

procedure TfrmCapacity.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCap.SetFocus;
end;





end.
