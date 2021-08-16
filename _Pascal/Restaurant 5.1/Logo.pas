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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogo: TfrmLogo;

implementation


Uses
  Globals, Modem, DBS_Proc, DateProc;


{$R *.DFM}

procedure TfrmLogo.Timer1Timer(Sender: TObject);
begin
  if F_Params.Mdm_Active = MB_TRUE then
  begin
    Timer1.Enabled := False;
    //InitialModem;
  end;
  Close;
end;

procedure TfrmLogo.FormShow(Sender: TObject);
begin
  g_options.RunDate := CurrentDate;
end;

end.
