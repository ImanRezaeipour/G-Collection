unit partDef;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, FarsiApi, funcs, DosMove;

type
  TfrmPartDef = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    txtCode: TEdit;
    txtName: TEdit;
    cmdSave: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdSaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
  public
    flag : Byte;
    preCode : string;
  end;


implementation

uses Keyboard, MSGs, DBS_Proc ;

{$R *.dfm}

procedure TfrmPartDef.FormCreate(Sender: TObject);
begin
  SetDirectionFarsi(txtCode.Handle);
end;

procedure TfrmPartDef.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmPartDef.cmdSaveClick(Sender: TObject);
begin
  if txtCode.Text = '' then
  begin
    ErrorMessage('·ÿ›« òœ »Œ‘ —« Ê«—œ ‰„«ÌÌœ .');
    txtCode.SetFocus;
  end
  else
  if txtName.Text = '' then
  begin
    ErrorMessage('·ÿ›« ‰«„ »Œ‘ —« Ê«—œ ‰„«ÌÌœ .');
    txtName.SetFocus;
  end
  else
  if IsExistsRec_Str('parts', 'P_CustomCode', txtCode.Text) and
  ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (preCode <> txtCode.Text))) then
  begin
    ErrorMessage('òœ »Œ‘  ﬂ—«—Ì «” .');
    txtCode.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TfrmPartDef.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #0 then
    cmdSaveClick(Sender);
end;

end.
