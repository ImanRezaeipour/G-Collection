unit GustRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, DateProc, MSGs, Keyboard, RpGust,slctpart ;

type
  TfrmGustCardRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    cmbBarCode: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    chkgrp: TCheckBox;
    cmbFamily: TComboBox;
    chkSign: TCheckBox;
    txtParts: TEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmbPartKeyPress(Sender: TObject; var Key: Char);
    procedure chkgrpKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFamilyKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBarCodeClick(Sender: TObject);
    procedure cmbFamilyClick(Sender: TObject);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
  public
   PartCode:string;
    { Public declarations }
  end;


implementation

uses DBS_Proc;

{$R *.DFM}


procedure TfrmGustCardRpt.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label4.Caption := (Label4.Caption);
  chkgrp.Caption := (chkgrp.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  chkSign.Caption := (chkSign.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmGustCardRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
    connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT P_BarCode, P_Family FROM Persons WHERE P_IsGuest = 1');
    Open;
    while not EOF do
    begin
      cmbBarCode.Items.Add(DelLeftZero(FieldByName('P_BarCode').AsString));
      cmbFamily.Items.Add(FieldByName('P_Family').AsString);
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure TfrmGustCardRpt.cmbBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmbFamily.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmGustCardRpt.cmbBarCodeClick(Sender: TObject);
begin
  cmbFamily.ItemIndex := cmbBarCode.ItemIndex;
end;

procedure TfrmGustCardRpt.cmbFamilyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;

  end;
end;

procedure TfrmGustCardRpt.cmbFamilyClick(Sender: TObject);
begin
  cmbBarCode.ItemIndex := cmbFamily.ItemIndex;
end;

procedure TfrmGustCardRpt.cmbPartKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkGrp.SetFocus;
  end;
end;

procedure TfrmGustCardRpt.BitBtn1Click(Sender: TObject);
begin
   PartCode := GetPart;
  if (PartCode <> '') and (GetPartNam(PartCode) <> '') then
    txtParts.Text := PartCode + ' - ' + GetPartNam(PartCode);

end;

procedure TfrmGustCardRpt.chkgrpKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if rdoScreen.Checked then
      rdoScreen.SetFocus
    else
      rdoPrinter.SetFocus;
  end;
end;

procedure TfrmGustCardRpt.rdoScreenKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmGustCardRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdPrint.SetFocus;
  end;
end;

procedure TfrmGustCardRpt.cmdPrintClick(Sender: TObject);
var frmRptGust: TfrmRptGust;
part_lcode:string;
begin
  Application.CreateForm(TfrmRptGust, frmRptGust);
  with frmRptGust do
  begin
    bndSign.Enabled := chkSign.Checked;
    lblEndRep1.Caption := F_Params.EndRep1;
    lblEndRep2.Caption := F_Params.EndRep2;
    lblEndRep3.Caption := F_Params.EndRep3;
    lblEndRep4.Caption := F_Params.EndRep4;
    part_lcode:= GetPartCode(Copy(txtParts.Text, 1, Pos('-', txtParts.Text)-2)) +'% ';
    qryGuest.SQL.Clear;
    qryGuest.SQL.Add('SELECT * FROM Persons');
    qryGuest.SQL.Add('WHERE P_IsGuest = 1');

    if cmbBarCode.Text <> '' then
      qryGuest.SQL.Add('AND P_BarCode = ''' + FixLeft(cmbBarCode.Text, '0', 8) + '''');

    if cmbFamily.Text <> '' then
      qryGuest.SQL.Add('AND P_Family = ''' + cmbFamily.Text + '''');

    if txtParts.Text <> '' then
      qryGuest.SQL.Add('AND P_parts like ' + '''' + part_lcode +'''');

    if chkgrp.Checked then
    begin
      grpPart.Expression := 'qryGuest.P_parts';
      qryGuest.SQL.Add('ORDER BY P_parts, P_BarCode');
    end
    else
      grpPart.Expression := '';

    qryGuest.Open;
    if qryGuest.RecordCount > 0 then
    begin
      if rdoScreen.Checked then
        qrptPerson.Preview
      else
        qrptPerson.Print;
    end
    else
      InformationMessage('ÂÌç ﬂ«— Ì »—«Ì „ÌÂ„«‰«‰  ⁄—Ì› ‰‘œÂ «” .');
    Close;
    Free;
  end;
end;

end.
