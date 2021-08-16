unit Backup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CheckLst, DosMove, DB, ADODB, ComCtrls, DBTables;


type
  TfrmBackup = class(TForm)
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lblDBS: TLabel;
    GroupBox1: TGroupBox;
    lbl1: TLabel;
    txtPath: TEdit;
    btnPath: TButton;
    aqryData: TADOQuery;
    DosMove1: TDosMove;
    tblData: TTable;
    cmBackup: TBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    txtPathRestore: TEdit;
    btnPath2: TButton;
    cmdRestore: TBitBtn;
    dlgRestore: TOpenDialog;
    procedure cmdRestoreClick(Sender: TObject);
    procedure btnPath2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmBackupClick(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
  private
    { Private declarations }
    SelectedAll : Boolean;

    procedure SetWinF;
    function  IsSelectedDBS : Boolean;
    procedure BackupData(tblName : String);

  public
    { Public declarations }
  end;


implementation

uses
  Globals, MSGs, DBS, Funcs, MakeDB, SelPath, TimeTool,DateProc, Keyboard;

{$R *.DFM}

procedure TfrmBackup.SetWinF;
begin
end;

function TfrmBackup.IsSelectedDBS : Boolean;
begin
end;

procedure TfrmBackup.BackupData(tblName : String);
begin
end;

procedure TfrmBackup.FormCreate(Sender: TObject);
begin
  aqryData.Connection := frmDBS.DBConnection;
end;

procedure TfrmBackup.cmBackupClick(Sender: TObject);
var
  bkFile : string;
begin
  if txtPath.Text = '' then
  begin
    ErrorMessage('مسير پشتيبان گيري مشخص نشده است.');
    txtPath.SetFocus;
  end
  else
  if FileExists(txtPath.Text) then
  begin
    ErrorMessage('فايل مورد نظر وجود دارد . نام فايل را تغيير دهيد .');
    txtPath.SetFocus;
  end
  else
  begin
    if not DirectoryExists(ExtractFilePath(txtPath.Text)) then
      if ConfirmMessage('مسير پشتيبان وجود ندارد. آيا براي ايجاد آن اطمينان داريد؟') then
      begin
        if not CreateDir(txtPath.Text) then
        begin
          ErrorMessage('ايجاد مسير پشتيبان ميسر نمي‌باشد.');
          Exit;
        end;
      end;
    with aqryData do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
//      sql.Add('USE master');
//      sql.Add('Exec sp_dropdevice ''amanat_1''');
//      bkFile := txtPath.Text + '\' + F_Params.DataBaseName + RemoveChar(CurrentDate,'/')+ '_' + RemoveChar(CurrentTimes,':') + '.BAK';
//      sql.Add('EXEC sp_addumpdevice ''disk'', ''amanat_1'',''' + bkFile + '''');
//      sql.Add('BACKUP DATABASE ' + F_Params.DataBaseName + ' TO amanat_1');
      bkFile := txtPath.Text + '\' + F_Params.DataBaseName + RemoveChar(CurrentDate,'/')+ '_' + RemoveChar(CurrentTimes,':') + '.BAK';
      sql.Add('BACKUP DATABASE ' + F_Params.DataBaseName + ' TO DISK = ''' + bkFile + '''');
      try
        ExecSQL;
        InformationMessage('پشتيبانگيري انجام شد.');
      except
        InformationMessage('پشتيبانگيري با مشکل مواجه شد .');
      end;
    end;
  end;
end;

procedure TfrmBackup.cmdRestoreClick(Sender: TObject);
var
  bkFile : string;
begin
  if not FileExists(txtPathRestore.Text) then
  begin
    ErrorMessage('فايل مورد نظر وجود ندارد');
    txtPathRestore.SetFocus;
  end
  else
  if ConfirmMessage('آيا براي بازيابي اطمينان داريد ؟') then
  begin
    with aqryData do
    begin

      ConnectionString := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Data Source=server';
      SQL.Clear;
      sql.Add('ALTER DATABASE amanat SET single_USER WITH ROLLBACK IMMEDIATE');
      sql.Add('RESTORE DATABASE ' + F_Params.DataBaseName + ' From DISK = ''' + txtPathRestore.Text + '''');
      try
        ExecSQL;
        InformationMessage('بازيابي انجام شد. لطفا از برنامه خارج شده و مجددا وارد شويد .');
        Application.Terminate;
      except
        ErrorMessage('بازيابي با مشکل مواجه شد .');
      end;
    end;
  end;
end;

procedure TfrmBackup.btnPath2Click(Sender: TObject);
begin
  if dlgRestore.Execute then
    txtPathRestore.Text := dlgRestore.FileName;
end;

procedure TfrmBackup.btnPathClick(Sender: TObject);
begin
  Application.CreateForm(TfrmSelPath, frmSelPath);
  frmSelPath.dirList.Directory := g_Options.ProgramPath;
  if frmSelPath.ShowModal = mrOK then
    txtPath.Text := frmSelPath.dirList.Directory;
  frmSelPath.Free;
end;

end.
