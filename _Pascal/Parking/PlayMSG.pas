unit PlayMSG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MPlayer, Globals;

type
  TfrmPlayMessage = class(TForm)
    playMSG: TMediaPlayer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


const
  MSG_NOTEXIT  = 1;
  MSG_MOTAVARI = 2;

procedure PlayMessage(MsgCode : Byte);

var
  frmPlayMessage: TfrmPlayMessage;

implementation

{$R *.DFM}


procedure PlayMessage(MsgCode : Byte);
const
  MsgFile : array[MSG_NOTEXIT..MSG_MOTAVARI] of String =
    ('NotExit.Wav', 'Motavari.Wav');
begin
  with frmPlayMessage do
  begin
    playMSG.Close;
    playMSG.FileName := g_options.ProgramPath + MsgFile[MsgCode];
    playMSG.Open;
    playMSG.Play;
  end;
end;



end.
