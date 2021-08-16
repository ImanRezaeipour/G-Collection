unit SrchCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Globals, Keyboard;

type
  TfrmSearchCard = class(TForm)
    cmbState: TComboBox;
    lblState: TLabel;
    txtToCode: TEdit;
    lblToCode: TLabel;
    txtFromCode: TEdit;
    lblFromCode: TLabel;
    cmdCancel: TBitBtn;
    cmdSearch: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure txtFromCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtToCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbStateKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
    SqlStmt : String;
  end;


implementation

{$R *.DFM}

procedure TfrmSearchCard.SetWinF;
begin
  Caption := (Caption);
  lblFromCode.Caption := (lblFromCode.Caption);
  lblToCode.Caption := (lblToCode.Caption);
  cmdSearch.Caption := (cmdSearch.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  lblState.Caption := (lblState.Caption);
end;

procedure TfrmSearchCard.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  SqlStmt := '';
  for i := MB_NORMAL to MB_LOST do
    cmbState.Items.Add((StName[i]));
end;



procedure TfrmSearchCard.cmdSearchClick(Sender: TObject);
begin
  if (txtFromCode.Text <> '') and  (txtToCode.Text <> '') then
  begin
    SqlStmt := 'Card_Code >= ''' + txtFromCode.Text + '''';
    SqlStmt := SqlStmt + ' AND Card_Code <= ''' + txtToCode.Text + '''';
  end
  else if txtFromCode.Text <> '' then
    SqlStmt := SqlStmt + 'Card_Code >= ''' + txtFromCode.Text + ''''
  else if txtToCode.Text <> '' then
    SqlStmt := SqlStmt + 'Card_Code <= ''' + txtToCode.Text + '''';

  if cmbState.Text <> '' then
  begin
    if SqlStmt <> '' then
      SqlStmt := SqlStmt + ' AND ';

    SqlStmt := SqlStmt + 'Card_State = ' + IntToStr(cmbState.ItemIndex+MB_NORMAL); 
  end;
  
end;

procedure TfrmSearchCard.txtFromCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToCode.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSearchCard.txtToCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbState.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmSearchCard.cmbStateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdSearch.SetFocus;
  end;
end;

end.
