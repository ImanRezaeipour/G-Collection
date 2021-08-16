program CmndTest;

uses
  ExceptionLog,
  Forms,         
  CmdTest in 'CmdTest.pas' {frmCmndTest},
  Cnstants in 'Cnstants.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCmndTest, frmCmndTest);
  Application.Run;
end.
