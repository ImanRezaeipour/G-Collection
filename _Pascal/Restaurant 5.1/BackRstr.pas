unit BackRstr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FileCtrl, ComCtrls, Globals, ExtCtrls, MSGs, DateProc,
  IOTools, CpyDisks;

type
  TfrmBackupRestore = class(TForm)
    lstDirectory: TDirectoryListBox;
    cmbDrive: TDriveComboBox;
    lblPath: TLabel;
    Label1: TLabel;
    cmdBackup: TBitBtn;
    cmdExit: TBitBtn;
    lblType: TLabel;
    cmdRestore: TBitBtn;
    txtPath: TEdit;
    lstFiles: TFileListBox;
    Label2: TLabel;
    lblFreeSpace: TLabel;
    Label3: TLabel;
    lblRequiredSpace: TLabel;
    cmdHelp: TBitBtn;
    cmdDelDir: TBitBtn;
    flstDel: TFileListBox;
    procedure cmdBackupClick(Sender: TObject);
    procedure cmdRestoreClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lstDirectoryChange(Sender: TObject);
    procedure cmbDriveChange(Sender: TObject);
    procedure cmdDelDirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FreeSpace, RequiredSpace : Int64;
    
    procedure SetFreeSpace(Drive : Byte);
    procedure SetRequiredSpqce;
    procedure CopyFiles(SourcePath, TargetPath : String);
    procedure SetWinF;

  public
    { Public declarations }
  end;

implementation

uses DBS_Proc;

{$R *.DFM}

procedure TfrmBackupRestore.SetWinF;
begin
  Caption := (Caption);
  lblPath.Caption := (lblPath.Caption);
  Label2.Caption := (Label2.Caption);
  lblFreeSpace.Caption := (lblFreeSpace.Caption);
  Label3.Caption := (Label3.Caption);
  lblRequiredSpace.Caption := (lblRequiredSpace.Caption);
  Label1.Caption := (Label1.Caption);
  cmdRestore.Caption := (cmdRestore.Caption);
  cmdBackup.Caption := (cmdBackup.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
  cmdDelDir.Caption := (cmdDelDir.Caption);
end;

procedure TfrmBackupRestore.SetFreeSpace(Drive : Byte);
begin
  FreeSpace := DiskFree(Drive);
  lblFreeSpace.Caption := Coma(IntToStr(FreeSpace div 1024)) + ' KB';
end;

procedure TfrmBackupRestore.SetRequiredSpqce;
var i : Integer;
begin
  RequiredSpace := 0;
  for i := 0 to lstFiles.Items.Count - 1 do
    if lstFiles.Directory[length(lstFiles.Directory)] <> '\' then
      RequiredSpace := RequiredSpace + FileLen(lstFiles.Directory + '\' + lstFiles.Items.Strings[i])
    else
      RequiredSpace := RequiredSpace + FileLen(lstFiles.Directory + lstFiles.Items.Strings[i]);

  lblrequiredSpace.Caption := Coma(IntToStr(RequiredSpace div 1024)) + ' KB';
end;

procedure TfrmBackupRestore.CopyFiles(SourcePath, TargetPath : String);
begin
  if SourcePath[Length(SourcePath)] <> '\' then
    SourcePath := SourcePath + '\';
  if TargetPath[Length(TargetPath)] <> '\' then
    TargetPath := TargetPath + '\';

  if lblType.Caption = MB_BACKUP then
  begin
    if UpperCase(SourcePath) = UpperCase(TargetPath) then
      ErrorMessage('���� ������� �� ���� ���� �������� ����� ��� ���.')
    else
    begin
      Application.CreateForm(TfrmCpyAnyDsk, frmCpyAnyDsk);
      if frmCpyAnyDsk.Backup(SourcePath, TargetPath) then
        InformationMessage('���������� �� ������ ����� ��.')
      else
        InformationMessage('��� ���������� ������ ���.');
    end;
  end
  else
  begin
    if UpperCase(SourcePath) = UpperCase(TargetPath) then
      ErrorMessage('���� ������� � ���� �������� ����� ��� ���.')
    else
    begin
      Application.CreateForm(TfrmCpyAnyDsk, frmCpyAnyDsk);
      if frmCpyAnyDsk.Restore(SourcePath, TargetPath) then
        InformationMessage('������� �� ������ ����� ��.')
      else
        InformationMessage('��� ������� ������ ���.');
    end;
  end;


end;


procedure TfrmBackupRestore.FormActivate(Sender: TObject);
begin
  txtPath.Text := lstDirectory.Directory;
  if lblType.Caption = MB_BACKUP then
  begin
    HelpContext := 504;
    cmdRestore.Visible := False;
    txtPath.ReadOnly := False;
  end
  else if lblType.Caption = MB_RESTORE then
  begin
    HelpContext := 505;
    Caption := ('������� ������� �������');
    lblPath.Caption := ('&���� �������');
    cmdBackup.Visible := False;
    cmdRestore.Top := cmdBackup.Top;
    cmdDelDir.Visible := False;
    txtPath.ReadOnly := True;
  end;
  lstFiles.Directory := g_options.DataBasePath;

  if lblType.Caption = MB_BACKUP then
    SetFreeSpace(Ord(cmbDrive.Drive)-64)
  else
    SetFreeSpace(Ord(g_options.DatabasePath[1])-64);
  SetRequiredSpqce;
end;

procedure TfrmBackupRestore.cmdBackupClick(Sender: TObject);
begin
  if g_options.ProgramPath = (txtPath.Text + '\') then
  begin
    InformationMessage('������� ���� �� ���� ������ ��� ���� ����.');
    Exit;
  end;

  if lstFiles.Items.Count <= 0 then
    ErrorMessage('���� �������� �� ����� ��� ����.')
  else
    CopyFiles(g_options.DataBasePath, txtPath.Text);
end;

procedure TfrmBackupRestore.cmdRestoreClick(Sender: TObject);
begin

  if lstFiles.Items.Count <= 0 then
    ErrorMessage('���� �������� �� ����� ��� ����.')
  else if ConfirmMessage('��� ���� ������� ������� ����Ͽ') then
  begin
    frmDBS.tblFish.Close;
    frmDBS.tblFishFood.Close;
    frmDBS.tblPersons.Close;

    CopyFiles(lstDirectory.Directory, g_options.DataBasePath);

    InitVariables(True);
    frmDBS.tblFish.Open;
    frmDBS.tblFishFood.Open;
    frmDBS.tblPersons.Open;
  end;
end;

procedure TfrmBackupRestore.lstDirectoryChange(Sender: TObject);
begin
  txtPath.Text := lstDirectory.Directory;
  if lblType.Caption = MB_RESTORE then
  begin
    lstFiles.Directory := lstDirectory.Directory;
    SetRequiredSpqce;
  end;
end;

procedure TfrmBackupRestore.cmbDriveChange(Sender: TObject);
begin
  if IsDriveReady(cmbDrive.Drive) then
  begin
    if lblType.Caption = MB_RESTORE then
      lstFiles.Mask := '*.*'
    else
      lstFiles.Mask := '*.db;*.px;*.xg?;*.yg?;';
    lstDirectory.Drive := cmbDrive.Drive
  end
  else
  begin
    ErrorMessage('����� ������ ��� ����� ����.');
    cmbDrive.Drive := lstDirectory.Drive;
  end;

  if lblType.Caption = MB_BACKUP then
    SetFreeSpace(Ord(cmbDrive.Drive)-64)
  else
    SetFreeSpace(Ord(g_options.DatabasePath[1])-64);
end;

procedure TfrmBackupRestore.cmdDelDirClick(Sender: TObject);
var
  i : Integer;
  p : String;
begin
  p := lstDirectory.Directory;
  if lstDirectory.ItemIndex > 0 then
  begin
  {$I-}
    if p[Length(p)] <> '\' then
      p := p + '\';
    p := p + lstDirectory.Items.Strings[lstDirectory.ItemIndex];
    if ConfirmMessage('��� ���� ��� ���� ' + Chr(10) + p + Chr(10) + ' ������� ����Ͽ') then
    begin
      flstDel.Directory := p;
      flstDel.Update;
      Self.Refresh;
      Mouse_Wait;
      for i := 0 to flstDel.Items.Count - 1 do
        DeleteFile(flstDel.Items.Strings[i]);
      flstDel.Directory := lstDirectory.Directory;
      RmDir(p);
      if IOResult <> 0 then
        InformationMessage('��� ���� ���� ����.');
    end;
    lstDirectory.Update;
    if lblType.Caption = MB_BACKUP then
      SetFreeSpace(Ord(cmbDrive.Drive)-64)
    else
      SetFreeSpace(Ord(g_options.DatabasePath[1])-64);
    Mouse_NoWait;
  {$I+}
  end
  else
  begin
    flstDel.Drive := cmbDrive.Drive;
    flstDel.Directory := p;
    flstDel.Update;
    flstDel.Refresh;
    if flstDel.Items.Count > 0 then
    begin
      if ConfirmMessage('��� ���� ��� ������� ���� ' + Chr(10) + p + Chr(10) + ' ������� ����Ͽ') then
      begin
        Self.Refresh;
        Mouse_Wait;
        {$I-}
        for i := 0 to flstDel.Items.Count - 1 do
        begin
          DeleteFile(p + flstDel.Items.Strings[i]);
          if IOResult <> 0 then
          begin
            InformationMessage('��� ������ ���� ����.');
            Break;
          end
        end;
        {$I+}
      end;
      flstDel.Update;
      flstDel.Refresh;
      lstDirectory.Update;
      if lblType.Caption = MB_BACKUP then
        SetFreeSpace(Ord(cmbDrive.Drive)-64)
      else
        SetFreeSpace(Ord(g_options.DatabasePath[1])-64);
      Mouse_NoWait;
    end;
  end;
end;


procedure TfrmBackupRestore.FormCreate(Sender: TObject);
begin
    SetWinF;
end;

end.




