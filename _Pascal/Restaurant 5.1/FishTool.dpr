program FishTool;

uses
  Forms,
  FshConv in 'FshConv.pas' {Form1},
  DBS_Proc in 'DBS_Proc.pas' {frmDBS};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmDBS, frmDBS);
  Application.Run;
end.
