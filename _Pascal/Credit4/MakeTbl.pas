unit MakeTbl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ADODB;

type
  TfrmCreateTables = class(TForm)
    chklstTables: TCheckListBox;
    btnSelect: TBitBtn;
    btnCreateTables: TBitBtn;
    btnRepairTables: TBitBtn;
    btnHelp: TBitBtn;
    btnClose: TBitBtn;
    btnTransfer2NewTables: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnCreateTablesClick(Sender: TObject);
    procedure chklstTablesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRepairTablesClick(Sender: TObject);
    procedure btnTransfer2NewTablesClick(Sender: TObject);
  private
    { Private declarations }

    procedure SetWinF;

  public
    { Public declarations }
  end;

var
  frmCreateTables: TfrmCreateTables;


implementation

uses
  Funcs, DBS, MSGs, FntSel;

{$R *.dfm}

procedure TfrmCreateTables.SetWinF;
var i : Byte;
begin
//kaveh  SetFontColor(TForm(frmCreateTables));

  chklstTables.Hint := ('انتخاب معكوس = Ctrl+A');
end;

procedure TfrmCreateTables.FormCreate(Sender: TObject);
var
  tempQry : TADOQuery;
begin
  SetWinF;

  tempQry := TADOQuery.Create(Application);
  with tempQry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select top 1 * from Persons ');
    SQL.Add('where (p_FAMILY <> '''') or (p_NAME <> '''') or (p_FAMILY_Sec <> '''') or (p_NAME_Sec <> '''') ');
    Open;
    if FieldByName('p_code').AsString <> '' then
      btnTransfer2NewTables.Enabled := True
    else
    begin
      SQL.Clear;
      SQL.Add('select top 1 * from Proxies ');
      SQL.Add('where (P_V1FAMILY <> '''') or (P_V1NAME <> '''') or (P_V2FAMILY <> '''') or (P_V2NAME <> '''') ');
      Open;
      if FieldByName('P_CustomerCode').AsString <> '' then
        btnTransfer2NewTables.Enabled := True
      else
      begin
        SQL.Clear;
        SQL.Add('select COUNT(*) as cnt from Persons ');
        SQL.Add('where p_code not in ( ');
        SQL.Add('SELECT nP_CustomerCode ');
        SQL.Add('FROM nProxies ) ');
        Open;
        if FieldByName('cnt').AsInteger > 0 then
          btnTransfer2NewTables.Enabled := True
        else
          btnTransfer2NewTables.Enabled := False;
      end;
    end;
    close;
    free;
  end;
end;

procedure TfrmCreateTables.btnRepairTablesClick(Sender: TObject);
var i : Byte;
begin
  if ConfirmMessage('آيا براي بازسازی جداول اطلاعاتي اطمينان داريد؟') then
  begin
    for i := 0 to chklstTables.Count-1 do
      if chklstTables.Checked[i] then
        case i of
          0: UpgradeTable('Cashes');
          1: UpgradeTable('Cities');
          2: UpgradeTable('init');
          3: UpgradeTable('pishcard');
          4: UpgradeTable('Persons');
          5: UpgradeTable('Proxies');
          6: UpgradeTable('IORdr');
          7: UpgradeTable('readers');
          8:
          begin
            UpgradeTable('security');
            UpgradeTable('users');
          end;
          9: UpgradeTable('History');
          10: UpgradeTable('nPersons');
          11: UpgradeTable('nProxies');
        end;
    InformationMessage('جداول اطلاعاتي بازسازی شدند.');
  end;
end;

procedure TfrmCreateTables.btnSelectClick(Sender: TObject);
var i : Byte;
begin
  for i := 0 to chklstTables.Count-1 do
    chklstTables.Checked[i] := not chklstTables.Checked[i];
end;

procedure TfrmCreateTables.btnTransfer2NewTablesClick(Sender: TObject);
var
  srcQry, srcQry2, destQry : TADOQuery;
begin
  srcQry := TADOQuery.Create(Application);
  with srcQry do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * from Persons ');
    SQL.Add('where (p_FAMILY <> '''') or (p_NAME <> '''') ');
    SQL.Add('order by p_code ');
    Open;
    if FieldByName('p_code').AsString <> '' then
    begin
      destQry := TADOQuery.Create(Application);
      destQry.Connection := frmDBS.DBConnection;
      while not EOF do
      begin
        destQry.SQL.Clear;
        destQry.SQL.Add('if not exists ( ');
        destQry.SQL.Add('select * from nPersons ');
        destQry.SQL.Add('where (np_code = ''' + FieldByName('p_code').AsString + ''') and (np_NAME = ''' + FieldByName('p_NAME').AsString + ''') and (np_FAMILY = ''' + FieldByName('p_FAMILY').AsString + ''') and (np_IDNO = ''' + FieldByName('p_IDNO').AsString + ''') ');
        destQry.SQL.Add(') ');
        destQry.SQL.Add('insert into nPersons (np_code, np_NAME, np_FAMILY, np_IDNO, np_Proxi, nP_Picture, ');
        destQry.SQL.Add('np_FATHER, np_NATION, np_IsMarried, np_POST, np_BirthDate, np_BirthPlace, ');
        destQry.SQL.Add('np_ADDRESS, np_HomeTel, np_WorkTel, np_MOBILE, np_SignPicture, np_IsMemberCommonBoxType3) ');
        destQry.SQL.Add('values(''' + FieldByName('p_code').AsString + ''', ''' + FieldByName('p_NAME').AsString + ''', ''' + FieldByName('p_FAMILY').AsString + ''', ''' + FieldByName('p_IDNO').AsString + ''', ''' + FieldByName('p_Proxi').AsString + ''', ''' + FieldByName('P_Picture').AsString + ''', ');
        destQry.SQL.Add('''' + FieldByName('p_FATHER').AsString + ''', ''' + FieldByName('p_NATION').AsString + ''', ' + FieldByName('p_IsMarried').AsString + ', ''' + FieldByName('p_POST').AsString + ''', ''' + FieldByName('p_BirthDate').AsString + ''', ''' + FieldByName('p_BirthPlace').AsString + ''', ');
        destQry.SQL.Add('''' + FieldByName('p_ADDRESS').AsString + ''', ''' + FieldByName('p_HomeTel').AsString + ''', ''' + FieldByName('p_WorkTel').AsString + ''', ''' + FieldByName('p_MOBILE').AsString + ''', ''' + FieldByName('p_SignPicture').AsString + ''', 0 ');
        destQry.SQL.Add(') ');
        destQry.ExecSQL;
        destQry.SQL.Clear;
        destQry.SQL.Add('update Persons ');
        destQry.SQL.Add('set ');
        destQry.SQL.Add('p_NAME = '''', ');
        destQry.SQL.Add('p_FAMILY = '''', ');
        destQry.SQL.Add('p_Proxi = '''', ');
        destQry.SQL.Add('p_IDNO = '''', ');
        destQry.SQL.Add('P_Picture = '''', ');
        destQry.SQL.Add('p_FATHER = '''', ');
        destQry.SQL.Add('p_NATION = '''', ');
        destQry.SQL.Add('p_IsMarried = 0, ');
        destQry.SQL.Add('p_POST = '''', ');
        destQry.SQL.Add('p_BirthDate = '''', ');
        destQry.SQL.Add('p_BirthPlace = '''', ');
        destQry.SQL.Add('p_ADDRESS = '''', ');
        destQry.SQL.Add('p_HomeTel = '''', ');
        destQry.SQL.Add('p_WorkTel = '''', ');
        destQry.SQL.Add('p_MOBILE = '''', ');
        destQry.SQL.Add('p_SignPicture = '''' ');
        destQry.SQL.Add('where (p_code = ''' + FieldByName('p_code').AsString + ''') and (p_NAME = ''' + FieldByName('p_NAME').AsString + ''') and (p_FAMILY = ''' + FieldByName('p_FAMILY').AsString + ''') and (p_IDNO = ''' + FieldByName('p_IDNO').AsString + ''') ');
        destQry.ExecSQL;
        Next;
      end;
      destQry.Close;
      destQry.Free;
    end;

    SQL.Clear;
    SQL.Add('select * from Persons ');
    SQL.Add('where (p_FAMILY_Sec <> '''') or (p_NAME_Sec <> '''') ');
    SQL.Add('order by p_code ');
    Open;
    if FieldByName('p_code').AsString <> '' then
    begin
      destQry := TADOQuery.Create(Application);
      destQry.Connection := frmDBS.DBConnection;
      while not EOF do
      begin
        destQry.SQL.Clear;
        destQry.SQL.Add('if not exists ( ');
        destQry.SQL.Add('select * from nPersons ');
        destQry.SQL.Add('where (np_code = ''' + FieldByName('p_code').AsString + ''') and (np_NAME = ''' + FieldByName('p_NAME_Sec').AsString + ''') and (np_FAMILY = ''' + FieldByName('p_FAMILY_Sec').AsString + ''') and (np_IDNO = ''' + FieldByName('p_IDNO_Sec').AsString + ''') ');
        destQry.SQL.Add(') ');
        destQry.SQL.Add('insert into nPersons (np_code, np_NAME, np_FAMILY, np_IDNO, np_Proxi, nP_Picture, ');
        destQry.SQL.Add('np_FATHER, np_NATION, np_IsMarried, np_POST, np_BirthDate, np_BirthPlace, ');
        destQry.SQL.Add('np_ADDRESS, np_HomeTel, np_WorkTel, np_MOBILE, np_SignPicture, np_IsMemberCommonBoxType3) ');
        destQry.SQL.Add('values(''' + FieldByName('p_code').AsString + ''', ''' + FieldByName('p_NAME_Sec').AsString + ''', ''' + FieldByName('p_FAMILY_Sec').AsString + ''', ''' + FieldByName('p_IDNO_Sec').AsString + ''', '''', ''' + FieldByName('P_Picture_Sec').AsString + ''', ');
        destQry.SQL.Add('''' + FieldByName('p_FATHER_Sec').AsString + ''', ''' + FieldByName('p_NATION_Sec').AsString + ''', ' + FieldByName('p_IsMarried_Sec').AsString + ', ''' + FieldByName('p_POST_Sec').AsString + ''', ''' + FieldByName('p_BirthDate_Sec').AsString + ''', ''' + FieldByName('p_BirthPlace_Sec').AsString + ''', ');
        destQry.SQL.Add('''' + FieldByName('p_ADDRESS_Sec').AsString + ''', ''' + FieldByName('p_HomeTel_Sec').AsString + ''', ''' + FieldByName('p_WorkTel_Sec').AsString + ''', ''' + FieldByName('p_MOBILE_Sec').AsString + ''', ''' + FieldByName('p_SignPicture_Sec').AsString + ''', 0 ');
        destQry.SQL.Add(') ');
        destQry.ExecSQL;
        destQry.SQL.Clear;
        destQry.SQL.Add('update Persons ');
        destQry.SQL.Add('set ');
        destQry.SQL.Add('p_NAME_Sec = '''', ');
        destQry.SQL.Add('p_FAMILY_Sec = '''', ');
        destQry.SQL.Add('p_IDNO_Sec = '''', ');
        destQry.SQL.Add('P_Picture_Sec = '''', ');
        destQry.SQL.Add('p_FATHER_Sec = '''', ');
        destQry.SQL.Add('p_NATION_Sec = '''', ');
        destQry.SQL.Add('p_IsMarried_Sec = 0, ');
        destQry.SQL.Add('p_POST_Sec = '''', ');
        destQry.SQL.Add('p_BirthDate_Sec = '''', ');
        destQry.SQL.Add('p_BirthPlace_Sec = '''', ');
        destQry.SQL.Add('p_ADDRESS_Sec = '''', ');
        destQry.SQL.Add('p_HomeTel_Sec = '''', ');
        destQry.SQL.Add('p_WorkTel_Sec = '''', ');
        destQry.SQL.Add('p_MOBILE_Sec = '''', ');
        destQry.SQL.Add('p_SignPicture_Sec = '''' ');
        destQry.SQL.Add('where (p_code = ''' + FieldByName('p_code').AsString + ''') and (p_NAME_Sec = ''' + FieldByName('p_NAME_Sec').AsString + ''') and (p_FAMILY_Sec = ''' + FieldByName('p_FAMILY_Sec').AsString + ''') and (p_IDNO_Sec = ''' + FieldByName('p_IDNO_Sec').AsString + ''') ');
        destQry.ExecSQL;
        Next;
      end;
      destQry.Close;
      destQry.Free;
    end;




    SQL.Clear;
    SQL.Add('select * from Persons ');
    SQL.Add('where (p_code <> '''')');
    SQL.Add('order by p_code ');
    Open;
//    if FieldByName('p_code').AsString <> '' then
    while not Eof do
    begin
      srcQry2 := TADOQuery.Create(Application);
      srcQry2.Connection := frmDBS.DBConnection;
      srcQry2.SQL.Clear;
      srcQry2.SQL.Add('select * from Proxies ');
      srcQry2.SQL.Add('where (P_CustomerCode = ''' + FieldByName('p_code').AsString + ''')');
//      srcQry2.SQL.Add(' ');
      srcQry2.Open;

      destQry := TADOQuery.Create(Application);
      destQry.Connection := frmDBS.DBConnection;
      if srcQry2.FieldByName('P_CustomerCode').AsString <> '' then
//      if not EOF then
      begin
        destQry.SQL.Clear;
        destQry.SQL.Add('if not exists ( ');
        destQry.SQL.Add('select * from nProxies ');
        destQry.SQL.Add('where (nP_CustomerCode = ''' + srcQry2.FieldByName('P_CustomerCode').AsString + ''') and (nP_VNAME = ''' + srcQry2.FieldByName('P_V1NAME').AsString + ''') and (nP_VFAMILY = ''' + srcQry2.FieldByName('P_V1FAMILY').AsString + ''') and (nP_VIDNO = ''' + srcQry2.FieldByName('P_V1IDNO').AsString + ''') and (np_VProxi = ''1'') ');
        destQry.SQL.Add(') ');
        destQry.SQL.Add('insert into nProxies (nP_CustomerCode, nP_VNAME, nP_VFAMILY, nP_VIDNO, nP_VFATHER, nP_VBirthPlace, ');
        destQry.SQL.Add('nP_VExpireDate, nP_VProxyID, np_VPicture, np_VSignPicture, np_VProxi ) ');
        destQry.SQL.Add('values(''' + srcQry2.FieldByName('P_CustomerCode').AsString + ''', ''' + srcQry2.FieldByName('P_V1NAME').AsString + ''', ''' + srcQry2.FieldByName('P_V1FAMILY').AsString + ''', ''' + srcQry2.FieldByName('P_V1IDNO').AsString + ''', ''' + srcQry2.FieldByName('P_V1FATHER').AsString + ''', ''' + srcQry2.FieldByName('P_V1BirthPlace').AsString + ''', ');
        destQry.SQL.Add('''' + srcQry2.FieldByName('P_V1ExpireDate').AsString + ''', ''' + srcQry2.FieldByName('P_V1ProxyID').AsString + ''', ''' + srcQry2.FieldByName('p_V1Picture').AsString + ''', ''' + srcQry2.FieldByName('p_V1SignPicture').AsString + ''', ''1'' ');
        destQry.SQL.Add(') ');
        destQry.ExecSQL;

        destQry.SQL.Clear;
        destQry.SQL.Add('if not exists ( ');
        destQry.SQL.Add('select * from nProxies ');
        destQry.SQL.Add('where (nP_CustomerCode = ''' + srcQry2.FieldByName('P_CustomerCode').AsString + ''') and (nP_VNAME = ''' + srcQry2.FieldByName('P_V2NAME').AsString + ''') and (nP_VFAMILY = ''' + srcQry2.FieldByName('P_V2FAMILY').AsString + ''') and (nP_VIDNO = ''' + srcQry2.FieldByName('P_V2IDNO').AsString + ''') and (np_VProxi = ''2'') ');
        destQry.SQL.Add(') ');
        destQry.SQL.Add('insert into nProxies (nP_CustomerCode, nP_VNAME, nP_VFAMILY, nP_VIDNO, nP_VFATHER, nP_VBirthPlace, ');
        destQry.SQL.Add('nP_VExpireDate, nP_VProxyID, np_VPicture, np_VSignPicture, np_VProxi ) ');
        destQry.SQL.Add('values(''' + srcQry2.FieldByName('P_CustomerCode').AsString + ''', ''' + srcQry2.FieldByName('P_V2NAME').AsString + ''', ''' + srcQry2.FieldByName('P_V2FAMILY').AsString + ''', ''' + srcQry2.FieldByName('P_V2IDNO').AsString + ''', ''' + srcQry2.FieldByName('P_V2FATHER').AsString + ''', ''' + srcQry2.FieldByName('P_V2BirthPlace').AsString + ''', ');
        destQry.SQL.Add('''' + srcQry2.FieldByName('P_V2ExpireDate').AsString + ''', ''' + srcQry2.FieldByName('P_V2ProxyID').AsString + ''', ''' + srcQry2.FieldByName('p_V2Picture').AsString + ''', ''' + srcQry2.FieldByName('p_V2SignPicture').AsString + ''', ''2'' ');
        destQry.SQL.Add(') ');
        destQry.ExecSQL;

//        destQry.SQL.Add(' ');

        destQry.SQL.Clear;
//        destQry.SQL.Add('update Proxies ');
//        destQry.SQL.Add('set ');
//        destQry.SQL.Add('P_V1FAMILY = '''', ');
//        destQry.SQL.Add('P_V1NAME = '''', ');
//        destQry.SQL.Add('P_V1IDNO = '''', ');
//        destQry.SQL.Add('P_V1FATHER = '''', ');
//        destQry.SQL.Add('P_V1BirthPlace = 0, ');
//        destQry.SQL.Add('P_V1ExpireDate = '''', ');
//        destQry.SQL.Add('P_V1ProxyID = '''', ');
//        destQry.SQL.Add('p_V1Picture = '''', ');
//        destQry.SQL.Add('p_V1SignPicture = '''' ');
//        destQry.SQL.Add('P_V2FAMILY = '''', ');
//        destQry.SQL.Add('P_V2NAME = '''', ');
//        destQry.SQL.Add('P_V2IDNO = '''', ');
//        destQry.SQL.Add('P_V2FATHER = '''', ');
//        destQry.SQL.Add('P_V2BirthPlace = 0, ');
//        destQry.SQL.Add('P_V2ExpireDate = '''', ');
//        destQry.SQL.Add('P_V2ProxyID = '''', ');
//        destQry.SQL.Add('p_V2Picture = '''', ');
//        destQry.SQL.Add('p_V2SignPicture = '''' ');

        destQry.SQL.Add('Delete from Proxies ');
        destQry.SQL.Add('where (P_CustomerCode = ''' + srcQry2.FieldByName('P_CustomerCode').AsString + ''') ');
//        destQry.SQL.Add('where (P_CustomerCode = ''' + FieldByName('P_CustomerCode').AsString + ''') and (P_V1NAME = ''' + FieldByName('P_V1NAME').AsString + ''') and (P_V1FAMILY = ''' + FieldByName('P_V1FAMILY').AsString + ''') and (P_V1IDNO = ''' + FieldByName('P_V1IDNO').AsString + ''') ');
        destQry.ExecSQL;

      end
      else
      begin
        destQry.SQL.Clear;
        destQry.SQL.Add('if not exists ( ');
        destQry.SQL.Add('select * from nProxies ');
        destQry.SQL.Add('where (nP_CustomerCode = ''' + FieldByName('p_code').AsString + ''') and (np_VProxi = ''1'') ');
        destQry.SQL.Add(') ');
        destQry.SQL.Add('insert into nProxies (nP_CustomerCode, nP_VNAME, nP_VFAMILY, nP_VIDNO, nP_VFATHER, nP_VBirthPlace, ');
        destQry.SQL.Add('nP_VExpireDate, nP_VProxyID, np_VPicture, np_VSignPicture, np_VProxi ) ');
        destQry.SQL.Add('values(''' + FieldByName('p_code').AsString + ''', '''', '''', '''', '''', '''', ');
        destQry.SQL.Add(' '''', '''', '''', '''', ''1'' ');
        destQry.SQL.Add(') ');
        destQry.ExecSQL;

        destQry.SQL.Clear;
        destQry.SQL.Add('if not exists ( ');
        destQry.SQL.Add('select * from nProxies ');
        destQry.SQL.Add('where (nP_CustomerCode = ''' + FieldByName('p_code').AsString + ''') and (np_VProxi = ''2'') ');
        destQry.SQL.Add(') ');
        destQry.SQL.Add('insert into nProxies (nP_CustomerCode, nP_VNAME, nP_VFAMILY, nP_VIDNO, nP_VFATHER, nP_VBirthPlace, ');
        destQry.SQL.Add('nP_VExpireDate, nP_VProxyID, np_VPicture, np_VSignPicture, np_VProxi ) ');
        destQry.SQL.Add('values(''' + FieldByName('p_code').AsString + ''', '''', '''', '''', '''', '''', ');
        destQry.SQL.Add(' '''', '''', '''', '''', ''2'' ');
        destQry.SQL.Add(') ');
        destQry.ExecSQL;

      end;
      destQry.Close;
      destQry.Free;

      next
    end;






{
    SQL.Clear;
    SQL.Add('select * from Proxies ');
    SQL.Add('where (P_V1FAMILY <> '''') or (P_V1NAME <> '''') ');
    SQL.Add('order by P_CustomerCode ');
    Open;
    if FieldByName('P_CustomerCode').AsString <> '' then
    begin
      destQry := TADOQuery.Create(Application);
      destQry.Connection := frmDBS.DBConnection;
      while not EOF do
      begin
        destQry.SQL.Clear;
        destQry.SQL.Add('if not exists ( ');
        destQry.SQL.Add('select * from nProxies ');
        destQry.SQL.Add('where (nP_CustomerCode = ''' + FieldByName('P_CustomerCode').AsString + ''') and (nP_VNAME = ''' + FieldByName('P_V1NAME').AsString + ''') and (nP_VFAMILY = ''' + FieldByName('P_V1FAMILY').AsString + ''') and (nP_VIDNO = ''' + FieldByName('P_V1IDNO').AsString + ''') ');
        destQry.SQL.Add(') ');
        destQry.SQL.Add('insert into nProxies (nP_CustomerCode, nP_VNAME, nP_VFAMILY, nP_VIDNO, nP_VFATHER, nP_VBirthPlace, ');
        destQry.SQL.Add('nP_VExpireDate, nP_VProxyID, np_VPicture, np_VSignPicture, np_VProxi ) ');
        destQry.SQL.Add('values(''' + FieldByName('P_CustomerCode').AsString + ''', ''' + FieldByName('P_V1NAME').AsString + ''', ''' + FieldByName('P_V1FAMILY').AsString + ''', ''' + FieldByName('P_V1IDNO').AsString + ''', ''' + FieldByName('P_V1FATHER').AsString + ''', ''' + FieldByName('P_V1BirthPlace').AsString + ''', ');
        destQry.SQL.Add('''' + FieldByName('P_V1ExpireDate').AsString + ''', ''' + FieldByName('P_V1ProxyID').AsString + ''', ''' + FieldByName('p_V1Picture').AsString + ''', ''' + FieldByName('p_V1SignPicture').AsString + ''', '''' ');
        destQry.SQL.Add(') ');
        destQry.ExecSQL;
        destQry.SQL.Clear;
        destQry.SQL.Add('update Proxies ');
        destQry.SQL.Add('set ');
        destQry.SQL.Add('P_V1FAMILY = '''', ');
        destQry.SQL.Add('P_V1NAME = '''', ');
        destQry.SQL.Add('P_V1IDNO = '''', ');
        destQry.SQL.Add('P_V1FATHER = '''', ');
        destQry.SQL.Add('P_V1BirthPlace = 0, ');
        destQry.SQL.Add('P_V1ExpireDate = '''', ');
        destQry.SQL.Add('P_V1ProxyID = '''', ');
        destQry.SQL.Add('p_V1Picture = '''', ');
        destQry.SQL.Add('p_V1SignPicture = '''' ');
        destQry.SQL.Add('where (P_CustomerCode = ''' + FieldByName('P_CustomerCode').AsString + ''') and (P_V1NAME = ''' + FieldByName('P_V1NAME').AsString + ''') and (P_V1FAMILY = ''' + FieldByName('P_V1FAMILY').AsString + ''') and (P_V1IDNO = ''' + FieldByName('P_V1IDNO').AsString + ''') ');
        destQry.ExecSQL;
        Next;
      end;
      destQry.Close;
      destQry.Free;
    end;

    SQL.Clear;
    SQL.Add('select * from Proxies ');
    SQL.Add('where (P_V2FAMILY <> '''') or (P_V2NAME <> '''') ');
    SQL.Add('order by P_CustomerCode ');
    Open;
    if FieldByName('P_CustomerCode').AsString <> '' then
    begin
      destQry := TADOQuery.Create(Application);
      destQry.Connection := frmDBS.DBConnection;
      while not EOF do
      begin
        destQry.SQL.Clear;
        destQry.SQL.Add('if not exists ( ');
        destQry.SQL.Add('select * from nProxies ');
        destQry.SQL.Add('where (nP_CustomerCode = ''' + FieldByName('P_CustomerCode').AsString + ''') and (nP_VNAME = ''' + FieldByName('P_V2NAME').AsString + ''') and (nP_VFAMILY = ''' + FieldByName('P_V2FAMILY').AsString + ''') and (nP_VIDNO = ''' + FieldByName('P_V2IDNO').AsString + ''') ');
        destQry.SQL.Add(') ');
        destQry.SQL.Add('insert into nProxies (nP_CustomerCode, nP_VNAME, nP_VFAMILY, nP_VIDNO, nP_VFATHER, nP_VBirthPlace, ');
        destQry.SQL.Add('nP_VExpireDate, nP_VProxyID, np_VPicture, np_VSignPicture, np_VProxi ) ');
        destQry.SQL.Add('values(''' + FieldByName('P_CustomerCode').AsString + ''', ''' + FieldByName('P_V2NAME').AsString + ''', ''' + FieldByName('P_V2FAMILY').AsString + ''', ''' + FieldByName('P_V2IDNO').AsString + ''', ''' + FieldByName('P_V2FATHER').AsString + ''', ''' + FieldByName('P_V2BirthPlace').AsString + ''', ');
        destQry.SQL.Add('''' + FieldByName('P_V2ExpireDate').AsString + ''', ''' + FieldByName('P_V2ProxyID').AsString + ''', ''' + FieldByName('p_V2Picture').AsString + ''', ''' + FieldByName('p_V2SignPicture').AsString + ''', '''' ');
        destQry.SQL.Add(') ');
        destQry.ExecSQL;
        destQry.SQL.Clear;
        destQry.SQL.Add('update Proxies ');
        destQry.SQL.Add('set ');
        destQry.SQL.Add('P_V2FAMILY = '''', ');
        destQry.SQL.Add('P_V2NAME = '''', ');
        destQry.SQL.Add('P_V2IDNO = '''', ');
        destQry.SQL.Add('P_V2FATHER = '''', ');
        destQry.SQL.Add('P_V2BirthPlace = 0, ');
        destQry.SQL.Add('P_V2ExpireDate = '''', ');
        destQry.SQL.Add('P_V2ProxyID = '''', ');
        destQry.SQL.Add('p_V2Picture = '''', ');
        destQry.SQL.Add('p_V2SignPicture = '''' ');
        destQry.SQL.Add('where (P_CustomerCode = ''' + FieldByName('P_CustomerCode').AsString + ''') and (P_V2NAME = ''' + FieldByName('P_V2NAME').AsString + ''') and (P_V2FAMILY = ''' + FieldByName('P_V2FAMILY').AsString + ''') and (P_V2IDNO = ''' + FieldByName('P_V2IDNO').AsString + ''') ');
        destQry.ExecSQL;
        Next;
      end;
      destQry.Close;
      destQry.Free;
    end;
}

    SQL.Clear;
    SQL.Add('select top 1 * from Persons ');
    SQL.Add('where (p_FAMILY <> '''') or (p_NAME <> '''') or (p_FAMILY_Sec <> '''') or (p_NAME_Sec <> '''') ');
    Open;
    if FieldByName('p_code').AsString <> '' then
      btnTransfer2NewTables.Enabled := True
    else
    begin
      SQL.Clear;
      SQL.Add('select top 1 * from Proxies ');
      SQL.Add('where (P_V1FAMILY <> '''') or (P_V1NAME <> '''') or (P_V2FAMILY <> '''') or (P_V2NAME <> '''') ');
      Open;
      if FieldByName('P_CustomerCode').AsString <> '' then
        btnTransfer2NewTables.Enabled := True
      else
      begin
        SQL.Clear;
        SQL.Add('select COUNT(*) as cnt from Persons ');
        SQL.Add('where p_code not in ( ');
        SQL.Add('SELECT nP_CustomerCode ');
        SQL.Add('FROM nProxies ) ');
        Open;
        if FieldByName('cnt').AsInteger > 0 then
          btnTransfer2NewTables.Enabled := True
        else
          btnTransfer2NewTables.Enabled := False;
      end;
    end;
    close;
    free;
  end;
end;

procedure TfrmCreateTables.btnCreateTablesClick(Sender: TObject);
var i : Byte;
begin
  if ConfirmMessage('آيا براي ايجاد جداول اطلاعاتي اطمينان داريد؟') then
  begin
    for i := 0 to chklstTables.Count-1 do
      if chklstTables.Checked[i] then
        case i of
          0: CreateTable('Cashes', False);
          1: CreateTable('Cities', False);
          2: CreateTable('init', False);
          3: CreateTable('pishcard', False);
          4: CreateTable('Persons', False);
          5: CreateTable('Proxies', False);
          6: CreateTable('IORdr', False);
          7: CreateTable('readers', False);
          8:
          begin
            CreateTable('security', False);
            CreateTable('users', False);
          end;
          9: CreateTable('History', False);
          10: CreateTable('nPersons', False);
          11: CreateTable('nProxies', False);
        end;
    InformationMessage('جداول اطلاعاتي ايجاد شدند.');
  end;
end;

procedure TfrmCreateTables.chklstTablesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 65) and (Shift = [ssCtrl]) then
    btnSelectClick(Sender);
end;

end.
