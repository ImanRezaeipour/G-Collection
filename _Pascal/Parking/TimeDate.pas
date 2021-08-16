unit TimeDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DateProc, MSGs, Keyboard, ExtCtrls;

type
  TfrmDateTime = class(TForm)
    txtDate: TEdit;
    txtTime: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
    tmrTime: TTimer;
    procedure cmdOKClick(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure txtDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtTimeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrTimeTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  Globals;

{$R *.DFM}

procedure TfrmDateTime.FormCreate(Sender: TObject);
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  txtDate.Text := CurrentDate;
  txtTime.Text := CurrentTime;
end;

procedure TfrmDateTime.tmrTimeTimer(Sender: TObject);
begin
  txtTime.Text := CurrentTime;
end;

procedure TfrmDateTime.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then
    Keyboard_Date(Key);
end;

procedure TfrmDateTime.txtDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if Shift = [ssCtrl] then
      txtDate.Text := CurrentDate
    else
      txtTime.SetFocus;
  end;
end;

procedure TfrmDateTime.txtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then
  begin
    tmrTime.Enabled := False;
    Keyboard_Time(Key);
  end;
end;

procedure TfrmDateTime.txtTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if Shift = [ssCtrl] then
      txtTime.Text := CurrentTime
    else
    begin
      Key := 0;
      cmdOK.SetFocus;
    end;
  end;
end;

procedure TfrmDateTime.cmdOKClick(Sender: TObject);
begin
  if not IsTrueDate(txtDate.Text) THEN
  begin
    ErrorMessage(' «—ÌŒ «‘ »«Â «” ');
    txtDate.SetFocus;
  end
  else if not IsTrueTime(txtTime.Text) then
  begin
    ErrorMessage('“„«‰ «‘ »«Â «” ');
    txtTime.SetFocus;
  end
  else
  begin
    SetDate(BeautifulDate(txtDate.Text));
    SetTime(BeautifulTime(txtTime.Text));
    InformationMessage(' ‰ŸÌ„  «—ÌŒ Å” «“ —«Â «‰œ«“Ì „Ãœœ ﬂ«„ÅÌÊ — Ÿ«Â— „Ìùê—œœ.');
    Close;
  end;
end;

end.
