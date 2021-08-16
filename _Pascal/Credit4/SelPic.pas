unit SelPic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, FileCtrl, DosMove;

type
  TfrmSelPicture = class(TForm)
    FileListBox1: TFileListBox;
    FilterComboBox1: TFilterComboBox;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
    Panel1: TPanel;
    imgPreview: TImage;
    DosMove1: TDosMove;
    procedure FileListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FilterComboBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetWinF;
    function  Execute : Boolean;
    function  FileSel : String;
  end;


implementation

uses
  Globals, Funcs;
  
{$R *.DFM}

procedure TfrmSelPicture.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

function TfrmSelPicture.Execute : Boolean;
begin
  Execute := (Self.ShowModal = mrOK);
end;

function TfrmSelPicture.FileSel : String;
begin
  if FileListBox1.ItemIndex > -1 then
    FileSel := FileListBox1.FileName
  else
    FileSel := '';
end;

procedure TfrmSelPicture.FileListBox1Click(Sender: TObject);
begin
  if FileListBox1.ItemIndex > -1 then
    imgPreview.Picture.LoadFromFile(FileListBox1.FileName);
end;

procedure TfrmSelPicture.FormCreate(Sender: TObject);
begin
  SetWinF;
  FileListBox1.Mask := FilterComboBox1.Mask;
end;

procedure TfrmSelPicture.FilterComboBox1Click(Sender: TObject);
begin
  imgPreview.Picture := nil;
end;

end.
