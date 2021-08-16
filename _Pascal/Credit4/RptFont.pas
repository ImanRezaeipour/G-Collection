unit RptFont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,dbs;

type
  TfrmReportFont = class(TForm)
    lbl1: TLabel;
    fntSelect: TFontDialog;
    lbl2: TLabel;
    txtTitrSize: TEdit;
    cmdTitrSel: TButton;
    txtTitleFont: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    txtReportSize: TEdit;
    cmdFontSel: TButton;
    txtReportFont: TEdit;
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdTitrSelClick(Sender: TObject);
    procedure cmdFontSelClick(Sender: TObject);
    procedure txtTitrSizeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
 Globals, Keyboard, MSGs, Funcs;

{$R *.dfm}

procedure TfrmReportFont.FormCreate(Sender: TObject);
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);

  if F_Params.RptTitleFont <> '' then txtTitleFont.Text := F_Params.RptTitleFont;
  if F_Params.RptTitleFntSize <> 0 then txtTitrSize.Text := IntToStr(F_Params.RptTitleFntSize);

  if F_Params.RptFont <> '' then txtReportFont.Text := F_Params.RptFont;
  if F_Params.RptFntSize <> 0 then txtReportSize.Text := IntToStr(F_Params.RptFntSize);
end;

procedure TfrmReportFont.cmdTitrSelClick(Sender: TObject);
begin
  if fntSelect.Execute then
  begin
    txtTitleFont.Text := fntSelect.Font.Name;
    txtTitrSize.Text := IntToStr(fntSelect.Font.Size);
  end;
end;

procedure TfrmReportFont.cmdFontSelClick(Sender: TObject);
begin
  if fntSelect.Execute then
  begin
    txtReportFont.Text := fntSelect.Font.Name;
    txtReportSize.Text := IntToStr(fntSelect.Font.Size);
  end;
end;

procedure TfrmReportFont.txtTitrSizeKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmReportFont.cmdOKClick(Sender: TObject);
begin
  if txtTitleFont.Text = '' then
  begin
    ErrorMessage('›Ê‰   Ì — ê“«—‘ „‘Œ’ ‰‘œÂ «” .');
    txtTitleFont.SetFocus;
  end
  else if txtTitrSize.Text = '' then
  begin
    ErrorMessage('«‰œ«“Â  Ì — ê“«—‘ „‘Œ’ ‰‘œÂ «” .');
    txtTitrSize.SetFocus;
  end
  else if txtReportFont.Text = '' then
  begin
    ErrorMessage('›Ê‰  „ ‰ ê“«—‘ „‘Œ’ ‰‘œÂ «” .');
    txtReportFont.SetFocus;
  end
  else if txtReportSize.Text = '' then
  begin
    ErrorMessage('«‰œ«“Â „ ‰ ê“«—‘ „‘Œ’ ‰‘œÂ «” .');
    txtReportSize.SetFocus;
  end
  else
  begin
    F_Params.RptTitleFont := txtTitleFont.Text;
    F_Params.RptTitleFntSize := StrToInt(txtTitrSize.Text);
    F_Params.RptFont := txtReportFont.Text;
    F_Params.RptFntSize := StrToInt(txtReportSize.Text);

    SaveIniFileDB;
    Close;
  end;
end;

end.
