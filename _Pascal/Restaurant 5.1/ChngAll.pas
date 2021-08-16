unit ChngAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmAllChange = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    cmbValid: TComboBox;
    cmbClock: TComboBox;
    cmbPrice: TComboBox;
    cmbFood: TComboBox;
    cmbRejim: TComboBox;
    cmbSobh: TComboBox;
    cmbNahar: TComboBox;
    cmbSham: TComboBox;
    cmdChange: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    cmbGroups: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    procedure cmbValidKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cmdChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  AdoDB, Globals, MSGs, DBS_Proc;

{$R *.dfm}

procedure TfrmAllChange.cmbValidKeyPress(Sender: TObject; var Key: Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmAllChange.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
begin

  cmbValid.Items.Add(('���� �����'));
  cmbValid.Items.Add(('���� �� ����'));
  cmbValid.Items.Add(('��� ����� ����'));
  cmbValid.ItemIndex := 0;

  cmbClock.Items.Add(('���� �����'));
  cmbClock.Items.Add(('��� ����� ����'));
  cmbClock.Items.Add(('���� ����� ����'));
  cmbClock.ItemIndex := 0;

  cmbPrice.Items.Add(('���� �����'));
  cmbPrice.Items.Add(('�� ��� ���'));
  cmbPrice.Items.Add(('���� ��� ���'));
  cmbPrice.ItemIndex := 0;

  cmbFood.Items.Add(('���� �����'));
  cmbFood.Items.Add(('����� ���� �����'));
  cmbFood.Items.Add(('��� ��� ���� �����'));
  cmbFood.ItemIndex := 0;

  cmbRejim.Items.Add(('���� �����'));
  cmbRejim.Items.Add(('����� ю���'));
  cmbRejim.Items.Add(('����� ����'));
  cmbRejim.ItemIndex := 0;

  cmbSobh.Items.Add(('���� �����'));
  cmbSobh.Items.Add(('����� ��� ������'));
  cmbSobh.Items.Add(('��� ��� ������'));
  cmbSobh.ItemIndex := 0;

  cmbNahar.Items.Add(('���� �����'));
  cmbNahar.Items.Add(('����� ��� �����'));
  cmbNahar.Items.Add(('��� ��� �����'));
  cmbNahar.ItemIndex := 0;

  cmbSham.Items.Add(('���� �����'));
  cmbSham.Items.Add(('����� ��� ���'));
  cmbSham.Items.Add(('��� ��� ���'));
  cmbSham.ItemIndex := 0;

  cmbGroups.Items.Add(('���� �����'));
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT Grp_Code, Grp_Name FROM Groups');
    Open;
    while not EOF do
    begin
      cmbGroups.Items.Add(FieldByName('Grp_Code').AsString + '-' + FieldByName('Grp_Name').AsString);
      Next;
    end;
    Close;
    Free;
  end;
  cmbGroups.ItemIndex := 0;

end;

procedure TfrmAllChange.cmdChangeClick(Sender: TObject);
var
   qry : TAdoQuery;
   G   : integer;
begin
  if ConfirmMessage('������� �������� �� ��� ���� ����� ����� �� ���. ��� ���� ������� ������� ����Ͽ') then
  begin
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.DBConnection;

    if cmbValid.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbValid.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_IsValid = 1  where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_IsValid = 0  where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbClock.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbClock.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_ValidTest = 1 where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_ValidTest = 0  where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbPrice.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbPrice.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_Pricable = 1 where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_Pricable = 0 where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbFood.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbFood.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_DblFood = 1 where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_DblFood = 0 where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbRejim.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbRejim.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_Rejim = 1 where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_Rejim = 0 where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbRejim.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbRejim.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_Rejim = 1 where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_Rejim = 0 where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbSobh.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbSobh.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_Sobhaneh = 1 where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_Sobhaneh = 0 where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbNahar.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbNahar.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_Nahar = 1 where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_Nahar = 0 where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbSham.ItemIndex <> 0 then
    begin
      qry.SQL.Clear;
      if cmbSham.ItemIndex = 1 then
        qry.SQL.Add('UPDATE Persons SET P_Sham = 1 where p_Isguest = 0')
      else
        qry.SQL.Add('UPDATE Persons SET P_Sham = 0 where p_Isguest = 0');
      qry.ExecSQL;
    end;

    if cmbGroups.ItemIndex <> 0 then
    begin
      g:=StrToInt(Copy(cmbGroups.text, 1, Pos('-', cmbGroups.text)-1));
      qry.SQL.Clear;
      qry.SQL.Add('UPDATE Persons SET P_ShiftGroup ='+inttostr(g)+' where p_Isguest = 0');
      qry.ExecSQL;
    end;

    qry.Free;
    InformationMessage('������� ����� ��.');
  end;
end;

end.
