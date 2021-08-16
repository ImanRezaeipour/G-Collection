unit PrnType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmPrnType = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdPrint: TBitBtn;
    chkCoName: TCheckBox;
    procedure cmdPrintClick(Sender: TObject);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure chkCoNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}



procedure TfrmPrnType.cmdPrintClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrnType.rdoScreenKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkCoName.SetFocus;
  end;
end;

procedure TfrmPrnType.chkCoNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

end.
