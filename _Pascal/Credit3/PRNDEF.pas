unit PrnDef;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Globals, Keyboard;

type
  TfrmPrnParam = class(TForm)
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    grpPrn: TGroupBox;
    lbl2: TLabel;
    txtLineFeed: TEdit;
    chkPrintFish: TCheckBox;
    cmbPrinters: TComboBox;
    lbl1: TLabel;
    chkAllFihPrc: TCheckBox;
    procedure cmdOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkPrintFishClick(Sender: TObject);
    procedure chkPrintFishKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

uses
    Funcs,z84_cmd;

{$R *.DFM}

procedure TfrmPrnParam.SetWinF;
begin
  Caption := (Caption);
  chkPrintFish.Caption := (chkPrintFish.Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  chkAllFihPrc.Caption := (chkAllFihPrc.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmPrnParam.FormCreate(Sender: TObject);
const
{  PrinterName : array [PRN_LX..PRN_ITHACA] of string =
                ('LX Series', 'LQ Series', 'CITIZEN3551', 'CITIZEN3541', 'ithaca');}
  PrinterName : array [prntypetype] of string =
                ('LX Series', 'LQ Series', 'CITIZEN3551', 'CITIZEN3541', 'ithaca');

var i : Prntypetype;
begin
  SetWinF;
  for i := PRN_LX to PRN_ITHACA do cmbPrinters.Items.Add(PrinterName[i]);
  chkPrintFish.Checked := (GParams.PrintFish);
  cmbPrinters.ItemIndex := ord(GParams.PrnType);
  txtLineFeed.Text := IntToStr(GParams.LineFeed);
  chkAllFihPrc.Checked := (GParams.AllFishPrc);
  grpPrn.Enabled := chkPrintFish.Checked;
end;

procedure TfrmPrnParam.cmdOKClick(Sender: TObject);
var
   i:byte;
   ii:prntypetype absolute i;
begin
  if chkPrintFish.Checked then
    GParams.PrintFish := TRUE
  else
    GParams.PrintFish := FALSE;
  i:=cmbPrinters.ItemIndex;
  GParams.PrnType :=ii;
  if txtLineFeed.Text <> '' then
    GParams.LineFeed := StrToInt(txtLineFeed.Text)
  else
    GParams.LineFeed := 0;

  if chkAllFihPrc.Checked then
    GParams.AllFishPrc := TRUE
  else
    GParams.AllFishPrc := FALSE;

  SaveParams;
end;

procedure TfrmPrnParam.chkPrintFishClick(Sender: TObject);
begin
  grpPrn.Enabled := chkPrintFish.Checked;
end;

procedure TfrmPrnParam.chkPrintFishKeyPress(Sender: TObject;
  var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, False);
    tp.SetFocus;
  end;
end;

end.
