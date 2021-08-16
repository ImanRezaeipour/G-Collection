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

{$R *.DFM}

procedure TfrmPrnParam.SetWinF;
begin
end;

procedure TfrmPrnParam.FormCreate(Sender: TObject);
const
  PrinterName : array [PRN_LX..PRN_SAMSUNG350Plus] of string =
                ('LX Series', 'LQ Series', 'CITIZEN3551', 'CITIZEN3541', 'ithaca', 'Samsung BIXOLON 350' , 'Samsung BIXOLON 350 Plus');

var i : Byte;
begin
  SetWinF;
  for i := PRN_LX to PRN_SAMSUNG350Plus do cmbPrinters.Items.Add(PrinterName[i]);
  chkPrintFish.Checked := (F_Params.PrintFish = MB_TRUE);
  cmbPrinters.ItemIndex := F_Params.PrnType;
  txtLineFeed.Text := IntToStr(F_Params.LineFeed);
  chkAllFihPrc.Checked := (F_Params.AllFishPrc = MB_TRUE);
  grpPrn.Enabled := chkPrintFish.Checked;
end;

procedure TfrmPrnParam.cmdOKClick(Sender: TObject);
begin
  if chkPrintFish.Checked then
    F_Params.PrintFish := MB_TRUE
  else
    F_Params.PrintFish := MB_FALSE;
  F_Params.PrnType := cmbPrinters.ItemIndex;
  if txtLineFeed.Text <> '' then
    F_Params.LineFeed := StrToInt(txtLineFeed.Text)
  else
    F_Params.LineFeed := 0;

  if chkAllFihPrc.Checked then
    F_Params.AllFishPrc := MB_TRUE
  else
    F_Params.AllFishPrc := MB_FALSE;
    
  SaveIniFile;
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
