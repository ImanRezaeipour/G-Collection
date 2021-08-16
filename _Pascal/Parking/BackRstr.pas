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
    lbl3: TLabel;
    cmdBackup: TBitBtn;
    cmdExit: TBitBtn;
    cmdRestore: TBitBtn;
    txtPath: TEdit;
    lstFiles: TFileListBox;
    lbl1: TLabel;
    lblFreeSpace: TLabel;
    lbl2: TLabel;
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

    procedure SetWinF;
    procedure SetFreeSpace(Drive : Byte);
    procedure SetRequiredSpqce;
    procedure CopyFiles(SourcePath, TargetPath : String);

  public
    { Public declarations }
    BackRst : Integer;
  end;

implementation

uses DBS;

{$R *.DFM}

procedure TfrmBackupRestore.SetWinF;
begin
  Caption := (Caption);
  lblPath.Caption := (lblPath.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  cmdDelDir.Caption := (cmdDelDir.Caption);
  cmdBackup.Caption := (cmdBackup.Caption);
  cmdRestore.Caption := (cmdRestore.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
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

  if BackRst = MB_BACKUP then
  begin
    if UpperCase(SourcePath) = UpperCase(TargetPath) then
      ErrorMessage('„”Ì— Å‘ Ì»«‰ »« „”Ì— »«‰ﬂ «ÿ·«⁄« Ì ”Ì” „ ÌﬂÌ «” .')
    else
    begin
      Application.CreateForm(TfrmCpyAnyDsk, frmCpyAnyDsk);
      frmCpyAnyDsk.filList.Mask := '*.db;*.px;*.xg?;*.yg?;';
      if frmCpyAnyDsk.Backup(SourcePath, TargetPath) then
        InformationMessage('Å‘ Ì»«‰êÌ—Ì »« „Ê›ﬁÌ  «‰Ã«„ ‘œ.')
      else
        InformationMessage('⁄„· Å‘ Ì»«‰êÌ—Ì ‰«„Ê›ﬁ »Êœ.');
    end;
  end
  else
  begin
    if UpperCase(SourcePath) = UpperCase(TargetPath) then
      ErrorMessage('„”Ì— »«“Ì«»Ì Ê »«‰ﬂ «ÿ·«⁄« Ì ”Ì” „ ÌﬂÌ «” .')
    else
    begin
      Application.CreateForm(TfrmCpyAnyDsk, frmCpyAnyDsk);
      if frmCpyAnyDsk.Restore(SourcePath, TargetPath) then
      begin
        InitVariables;
        InformationMessage('»«“Ì«»Ì »« „Ê›ﬁÌ  «‰Ã«„ ‘œ.');
      end
      else
        InformationMessage('⁄„· »«“Ì«»Ì ‰«„Ê›ﬁ »Êœ.');
    end;
  end;


end;


procedure TfrmBackupRestore.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

procedure TfrmBackupRestore.FormActivate(Sender: TObject);
begin
  txtPath.Text := lstDirectory.Directory;
  if BackRst = MB_BACKUP then
  begin
    HelpContext := 603;
    cmdRestore.Visible := False;
    txtPath.ReadOnly := False;
  end
  else if BackRst = MB_RESTORE then
  begin
    HelpContext := 604;
    Caption := ('»«“Ì«»Ì ›«Ì·Â«Ì Å‘ Ì»«‰');
    lblPath.Caption := ('&„”Ì— »«“Ì«»Ì');
    cmdBackup.Visible := False;
    cmdRestore.Top := cmdBackup.Top;
    cmdRestore.Left := cmdBackup.Left;
    cmdDelDir.Visible := False;
    txtPath.ReadOnly := True;
  end;
  lstFiles.Directory := g_options.DataBasePath;

  if BackRst = MB_BACKUP then
    SetFreeSpace(Ord(cmbDrive.Drive)-64)
  else
    SetFreeSpace(Ord(g_options.DatabasePath[1])-64);
  SetRequiredSpqce;
end;

procedure TfrmBackupRestore.cmdBackupClick(Sender: TObject);
begin
  if g_options.ProgramPath = (txtPath.Text + '\') then
  begin
    InformationMessage('Å‘ Ì»«‰ êÌ—Ì œ— „”Ì— «‰ Œ«» ‘œÂ „„ﬂ‰ ‰Ì” .');
    Exit;
  end;

  if lstFiles.Items.Count <= 0 then
    ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì œ— œ” —” ‰„Ì »«‘œ.')
  else
    CopyFiles(g_options.DataBasePath, txtPath.Text);
end;

procedure TfrmBackupRestore.cmdRestoreClick(Sender: TObject);
begin
  if lstFiles.Items.Count <= 0 then
    ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì œ— œ” —” ‰„Ì »«‘œ.')
  else if ConfirmMessage('¬Ì« »—«Ì »«“Ì«»Ì «ÿ„Ì‰«‰ œ«—Ìœø') then
    CopyFiles(lstDirectory.Directory, g_options.DataBasePath);
end;

procedure TfrmBackupRestore.lstDirectoryChange(Sender: TObject);
begin
  txtPath.Text := lstDirectory.Directory;
  if BackRst = MB_RESTORE then
  begin
    lstFiles.Directory := lstDirectory.Directory;
    SetRequiredSpqce;
  end;
end;

procedure TfrmBackupRestore.cmbDriveChange(Sender: TObject);
begin
  if IsDriveReady(cmbDrive.Drive) then
  begin
    lstDirectory.Drive := cmbDrive.Drive;
    if (cmbDrive.Drive in ['A', 'B']) and
       (BackRst = MB_RESTORE) then
      lstFiles.Mask := '*.*'
    else
      lstFiles.Mask := '*.db;*.px;*.xg?;*.yg?;';
  end
  else
  begin
    ErrorMessage('œ—«ÌÊ «‰ Œ«» ‘œÂ ¬„«œÂ ‰Ì” .');
    cmbDrive.Drive := lstDirectory.Drive;
  end;

  if BackRst = MB_BACKUP then
    SetFreeSpace(Ord(cmbDrive.Drive)-64)
  else
    SetFreeSpace(Ord(g_options.DatabasePath[1])-64);
end;

procedure TfrmBackupRestore.cmdDelDirClick(Sender: TObject);
var i : Integer;
begin
  if lstDirectory.ItemIndex > 0 then
  begin
  {$I-}
    if ConfirmMessage('¬Ì« »—«Ì Õ–› ‘«ŒÂ ' + Chr(10) + lstDirectory.Directory+lstDirectory.Items.Strings[lstDirectory.ItemIndex] + Chr(10) + ' «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
      flstDel.Directory := lstDirectory.Directory+lstDirectory.Items.Strings[lstDirectory.ItemIndex];
      Self.Refresh;
      Mouse_Wait;
      for i := 0 to flstDel.Items.Count - 1 do
        DeleteFile(flstDel.Items.Strings[i]);
      flstDel.Directory := lstDirectory.Directory;
      RmDir(lstDirectory.Directory+lstDirectory.Items.Strings[lstDirectory.ItemIndex]);
      if IOResult <> 0 then
        InformationMessage('Õ–› ‘«ŒÂ „Ì”— ‰Ì” .');
    end;
    lstDirectory.Update;
    if BackRst = MB_BACKUP then
      SetFreeSpace(Ord(cmbDrive.Drive)-64)
    else
      SetFreeSpace(Ord(g_options.DatabasePath[1])-64);
    Mouse_NoWait;
  {$I+}
  end;
end;


end.
