unit PrnTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmPrnTest = class(TForm)
    Label1: TLabel;
    txtL1: TEdit;
    chkW1: TCheckBox;
    chkClr1: TCheckBox;
    Label2: TLabel;
    txtL2: TEdit;
    chkW2: TCheckBox;
    chkClr2: TCheckBox;
    Label3: TLabel;
    txtL3: TEdit;
    chkW3: TCheckBox;
    chkClr3: TCheckBox;
    cmdPrint: TButton;
    chkCut: TCheckBox;
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  PrnDevic, Code_Sys, Globals;

{$R *.dfm}

procedure TfrmPrnTest.cmdPrintClick(Sender: TObject);
var s : String;
begin
  s := FixLeft(StrRev(WinSina_To_IR(txtL1.Text)), ' ', 30);
  if chkW1.Checked then
    s := #27'W'#1 + s + #27'W'#0;
  if chkClr1.Checked then
    s := #27'c'#1 + s + #27'c'#0;
  s := s + #10#13;
  PrintString(s);

  s := FixLeft(StrRev(WinSina_To_IR(txtL2.Text)), ' ', 30);
  if chkW2.Checked then
    s := #27'W'#1 + s + #27'W'#0;
  if chkClr2.Checked then
    s := #27'c'#1 + s + #27'c'#0;
  s := s + #10#13;
  PrintString(s);

  s := FixLeft(StrRev(WinSina_To_IR(txtL3.Text)), ' ', 30);
  if chkW3.Checked then
    s := #27'W'#1 + s + #27'W'#0;
  if chkClr3.Checked then
    s := #27'c'#1 + s + #27'c'#0;
  s := s + #10#13;
  PrintString(s);

  if chkCut.Checked then
  begin
    s := #27'd' + chr(10) + #27'v';
    PrintString(s);
  end;
end;

end.
