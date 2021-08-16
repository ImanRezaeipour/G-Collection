unit Logo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, MPlayer, jpeg;

type
  TfrmLogo = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogo: TfrmLogo;

implementation

{$R *.DFM}

procedure TfrmLogo.Timer1Timer(Sender: TObject);
begin
  Close;
end;

end.
