unit Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Keyboard, ExtCtrls, msgs, Grids, DosMove,DBS,adodb;

type
  TfrmParams = class(TForm)
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    chkWin2000: TCheckBox;
    lbl4: TLabel;
    txtDelay2000: TEdit;
    lbl1: TLabel;
    txtManager: TEdit;
    lbl2: TLabel;
    txtBranchCode: TEdit;
    lbl3: TLabel;
    txtBranchName: TEdit;
    procedure txtarchivedayKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure txtDelay2000KeyPress(Sender: TObject; var Key: Char);
    procedure chkWin2000Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

uses
  Globals, FarsiApi, Code_Sys, TimeTool,DateProc, Funcs, ComTools;

const
   maxdays : array[1..12] of byte = (31,31,31,31,31,31,30,30,30,30,30,29) ;

procedure TfrmParams.SetWinF;
begin
end;


procedure TfrmParams.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (F_Params.BranchCode = '') or (F_Params.BranchName = '') then
    CanClose := False;
end;

procedure TfrmParams.FormCreate(Sender: TObject);
var
   i : byte;
  qry : TAdoQuery;
begin
  SetWinF;
  with F_Params do
  begin
    chkWin2000.Checked := (IsWin2000 = MB_TRUE);
    txtDelay2000.Enabled := chkWin2000.Checked;
    if txtDelay2000.Enabled then
      txtDelay2000.Text := IntToStr(TimeOut2000);
    txtManager.Text := Admin_User;
    txtBranchCode.Text := F_Params.BranchCode;
    txtBranchName.Text := F_Params.BranchName;
  end;
  if (txtBranchCode.Text <> '') and (txtBranchName.Text <> '') then
  begin
    txtBranchCode.Enabled := False;
    txtBranchName.Enabled := False;
  end;
  
end;

procedure TfrmParams.cmdOKClick(Sender: TObject);
begin
  with F_Params do
  begin
    if chkWin2000.Checked then
    begin
      IsWin2000 := MB_TRUE;
      if txtDelay2000.Text <> ''then
        TimeOut2000 := StrToInt(txtDelay2000.Text)
      else
        TimeOut2000 := 50;
    end
    else
    begin
      IsWin2000 := MB_FALSE;
      TimeOut2000 := 0;
    end;

    Is2000 := (IsWin2000 = MB_TRUE);
    delay2000 := TimeOut2000;
    Admin_User := txtManager.Text;

    BranchCode := txtBranchCode.Text;
    BranchName := txtBranchName.Text;
  end;

  SaveIniFileDB;
end;

procedure TfrmParams.txtDelay2000KeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmParams.chkWin2000Click(Sender: TObject);
begin
  txtDelay2000.Enabled := chkWin2000.Checked;
  if txtDelay2000.Enabled then
    txtDelay2000.Text := IntToStr(F_Params.TimeOut2000);
end;

procedure TfrmParams.txtarchivedayKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

end.
