unit SelPath;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FileCtrl;

type
  TfrmSelPath = class(TForm)
    Label1: TLabel;
    dirList: TDirectoryListBox;
    drvList: TDriveComboBox;
    Label2: TLabel;
    lblPath: TStaticText;
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
    procedure drvListChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dirListChange(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

var
  frmSelPath: TfrmSelPath;

implementation

uses
  Globals;

{$R *.DFM}

procedure TfrmSelPath.SetWinF;
begin
  Caption := (Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmSelPath.FormActivate(Sender: TObject);
begin
  lblPath.Caption := dirList.Directory;
  SetWinF;
end;

procedure TfrmSelPath.drvListChange(Sender: TObject);
begin
  dirList.Drive := drvList.Drive;
end;


procedure TfrmSelPath.dirListChange(Sender: TObject);
begin
  lblPath.Caption := dirList.Directory;
end;

end.
