unit Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Globals, FarsiApi, AdoDB;

type
  TfrmParams = class(TForm)
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
    cmdHelp: TBitBtn;
    grpPrint: TGroupBox;
    rdoAllPrint: TRadioButton;
    rdoPrcPrint: TRadioButton;
    rdoNoPrint: TRadioButton;
    grpFeature: TGroupBox;
    txtLine1: TEdit;
    txtLine4: TEdit;
    txtLine2: TEdit;
    txtLine3: TEdit;
    txtLine5: TEdit;
    grpInput: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    chkInputOff: TCheckBox;
    txtMaxOff: TEdit;
    chkOffRpt: TCheckBox;
    lbl4: TLabel;
    cmbActiveRdrOpenDoor: TComboBox;
    cmbActiveRdrOpenDoorCode: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure chkInputOffClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbActiveRdrOpenDoorChange(Sender: TObject);
    procedure cmbActiveRdrOpenDoorCodeChange(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

uses
  DBS;

procedure TfrmParams.SetWinF;
begin
  Caption := (Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
  chkOffRpt.Caption := (chkOffRpt.Caption);
  chkInputOff.Caption := (chkInputOff.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  grpInput.Caption := (grpInput.Caption);
  grpFeature.Caption := (grpFeature.Caption);
  grpPrint.Caption := (grpPrint.Caption);
  rdoAllPrint.Caption := (rdoAllPrint.Caption);
  rdoPrcPrint.Caption := (rdoPrcPrint.Caption);
  rdoNoPrint.Caption := (rdoNoPrint.Caption);
end;

procedure TfrmParams.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
begin
  SetWinF;
  SetDirectionFarsi(txtLine1.Handle);
  SetDirectionFarsi(txtLine2.Handle);
  SetDirectionFarsi(txtLine3.Handle);
  SetDirectionFarsi(txtLine4.Handle);
  SetDirectionFarsi(txtLine5.Handle);

  if g_options.OutPutLines[1] <> #10 then
    txtLine1.Text := g_options.OutPutLines[1]
  else
    txtLine1.Text := '';

  if g_options.OutPutLines[2] <> #10 then
    txtLine2.Text := g_options.OutPutLines[2];

  if g_options.OutPutLines[3] <> #10 then
    txtLine3.Text := g_options.OutPutLines[3];

  if g_options.OutPutLines[4] <> #10 then
    txtLine4.Text := g_options.OutPutLines[4];

  if g_options.OutPutLines[5] <> #10 then
    txtLine5.Text := g_options.OutPutLines[5];

  case g_options.OutPrint of
    MB_ALLPRINT: rdoAllPrint.Checked := True;
    MB_PRCPRINT: rdoPrcPrint.Checked := True;
    MB_NOPRINT : rdoNoPrint.Checked := True;
  end;

  chkInputOff.Checked := not (g_options.MaxOffReader = 0);
  txtMaxOff.Text := IntToStr(g_options.MaxOffReader div 60);
  chkOffRpt.Checked := (g_options.RdrOff_Rpt = MB_TRUE);

  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
      
  qry.SQL.Clear;
  qry.SQL.Add('SELECT * FROM Readers ');
  qry.SQL.Add('WHERE (R_Active = ''T'' OR R_Active = ''t'') AND R_Type = 1 AND R_Depart = ' + IntToStr(g_Options.Department) + ' ');
  qry.SQL.Add('ORDER BY R_Name ');
  qry.Open;
  while not qry.EOF do
  begin
    cmbActiveRdrOpenDoor.Items.Add(qry.FieldByName('R_Name').AsString);
    cmbActiveRdrOpenDoorCode.Items.Add(qry.FieldByName('R_Code').AsString);
    qry.Next;
  end;
  qry.Close;

  cmbActiveRdrOpenDoorCode.ItemIndex := cmbActiveRdrOpenDoorCode.Items.IndexOf(IntToStr(g_Options.ActiveRdrCode));
  cmbActiveRdrOpenDoor.ItemIndex := cmbActiveRdrOpenDoorCode.ItemIndex;

  qry.Free;  
end;

procedure TfrmParams.FormShow(Sender: TObject);
begin
  Height := 106;
end;

procedure TfrmParams.chkInputOffClick(Sender: TObject);
begin
  txtMaxOff.Enabled := chkInputOff.Checked;
end;

procedure TfrmParams.cmbActiveRdrOpenDoorChange(Sender: TObject);
begin
  cmbActiveRdrOpenDoorCode.ItemIndex := cmbActiveRdrOpenDoor.ItemIndex; 
end;

procedure TfrmParams.cmbActiveRdrOpenDoorCodeChange(Sender: TObject);
begin
  cmbActiveRdrOpenDoor.ItemIndex := cmbActiveRdrOpenDoorCode.ItemIndex;
end;

procedure TfrmParams.cmdOKClick(Sender: TObject);
begin
{  if txtLine1.Text <> '' then
    g_options.OutPutLines[1] := txtLine1.Text
  else
    g_options.OutPutLines[1] := #10;

  if txtLine2.Text <> '' then
    g_options.OutPutLines[2] := txtLine2.Text
  else
    g_options.OutPutLines[2] := #10;

  if txtLine3.Text <> '' then
    g_options.OutPutLines[3] := txtLine3.Text
  else
    g_options.OutPutLines[3] := #10;

  if txtLine4.Text <> '' then
    g_options.OutPutLines[4] := txtLine4.Text
  else
    g_options.OutPutLines[4] := #10;

  if txtLine1.Text <> '' then
    g_options.OutPutLines[5] := txtLine5.Text
  else
    g_options.OutPutLines[5] := #10;

  if rdoAllPrint.Checked then
    g_options.OutPrint := MB_ALLPRINT
  else if rdoPrcPrint.Checked then
    g_options.OutPrint := MB_PRCPRINT
  else
    g_options.OutPrint := MB_NOPRINT;

  if chkInputOff.Checked and (txtMaxOff.Text <> '') then
    g_options.MaxOffReader := StrToInt(txtMaxOff.Text) * 60
  else
    g_options.MaxOffReader := 0;

  if chkOffRpt.Checked then
    g_options.RdrOff_Rpt := MB_TRUE
  else
    g_options.RdrOff_Rpt := MB_FALSE;
  SaveIniFile;
  LoadExit_Park;}

  if cmbActiveRdrOpenDoorCode.ItemIndex > -1 then 
    g_Options.ActiveRdrCode := StrToInt(cmbActiveRdrOpenDoorCode.Text);
  Close;
end;






end.
