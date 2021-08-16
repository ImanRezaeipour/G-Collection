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
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure drvListChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dirListChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelPath: TfrmSelPath;

implementation

{$R *.DFM}


procedure TfrmSelPath.FormActivate(Sender: TObject);
begin
  lblPath.Caption := dirList.Directory;
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
