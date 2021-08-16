unit FreeDBS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, MSGs, DateProc, Keyboard,
  DBS_Proc;

type
  TfrmFreeDBase = class(TForm)
    cmdDel: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    chkFish: TCheckBox;
    chkProgram: TCheckBox;
    Label1: TLabel;
    txtFromFish: TEdit;
    Label2: TLabel;
    txtToFish: TEdit;
    Label3: TLabel;
    txtFromProg: TEdit;
    Label4: TLabel;
    txtToProg: TEdit;
    chkPricing: TCheckBox;
    chkFoods: TCheckBox;
    Label5: TLabel;
    txtFromPrice: TEdit;
    Label6: TLabel;
    txtToPrice: TEdit;
    chkGuest: TCheckBox;
    chkPersons: TCheckBox;
    chkParts: TCheckBox;
    chkJobType: TCheckBox;
    chkUnits: TCheckBox;
    procedure cmdDelClick(Sender: TObject);
    procedure chkFishClick(Sender: TObject);
    procedure txtFromFishKeyPress(Sender: TObject; var Key: Char);
    procedure chkProgramClick(Sender: TObject);
    procedure chkPricingClick(Sender: TObject);
    procedure chkFishKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromFishExit(Sender: TObject);
    procedure txtToFishExit(Sender: TObject);
    procedure txtFromProgExit(Sender: TObject);
    procedure txtToProgExit(Sender: TObject);
    procedure txtFromPriceExit(Sender: TObject);
    procedure txtToPriceExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    procedure SendTab(var Key : Char);
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}


procedure TfrmFreeDBase.SetWinF;
begin
  Caption := (Caption);
  chkFish.Caption := (chkFish.Caption);
  chkProgram.Caption := (chkProgram.Caption);
  chkPricing.Caption := (chkPricing.Caption);
  chkFoods.Caption := (chkFoods.Caption);
  chkParts.Caption := (chkParts.Caption);
  Label1.Caption := (Label1.Caption);
  Label3.Caption := (Label3.Caption);
  Label5.Caption := (Label5.Caption);
  chkGuest.Caption := (chkGuest.Caption);
  chkJobType.Caption := (chkJobType.Caption);
  Label2.Caption := (Label2.Caption);
  Label4.Caption := (Label4.Caption);
  Label6.Caption := (Label6.Caption);
  chkPersons.Caption := (chkPersons.Caption);
  chkUnits.Caption := (chkUnits.Caption);
  cmdDel.Caption := (cmdDel.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmFreeDBase.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := Self.FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmFreeDBase.chkFishClick(Sender: TObject);
begin
  txtFromFish.Enabled := chkFish.Checked;
  txtToFish.Enabled := chkFish.Checked;
end;

procedure TfrmFreeDBase.chkFishKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmFreeDBase.txtFromFishKeyPress(Sender: TObject;
  var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmFreeDBase.txtFromFishExit(Sender: TObject);
begin
  with txtFromFish do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmFreeDBase.txtToFishExit(Sender: TObject);
begin
  with txtToFish do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmFreeDBase.txtFromProgExit(Sender: TObject);
begin
  with txtFromProg do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmFreeDBase.txtToProgExit(Sender: TObject);
begin
  with txtToProg do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmFreeDBase.txtFromPriceExit(Sender: TObject);
begin
  with txtFromPrice do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmFreeDBase.txtToPriceExit(Sender: TObject);
begin
  with txtToPrice do
    if Text <> '' then
      Text := BeautifulDate(Text);
end;

procedure TfrmFreeDBase.chkProgramClick(Sender: TObject);
begin
  txtFromProg.Enabled := chkProgram.Checked;
  txtToProg.Enabled := chkProgram.Checked;
end;

procedure TfrmFreeDBase.chkPricingClick(Sender: TObject);
begin
  txtFromPrice.Enabled := chkPricing.Checked;
  txtToPrice.Enabled := chkPricing.Checked;
end;

procedure TfrmFreeDBase.cmdDelClick(Sender: TObject);
var
  qry : TAdoQuery;
begin
  if ConfirmMessage('¬Ì« »—«Ì Õ–› «ÿ·«⁄«  «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    Mouse_Wait;
    Msg_Wait('œ— Õ«· Õ–› ‰„Êœ‰ «ÿ·«⁄« ...');
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.DBConnection;
    if chkFish.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Fish');
      if (txtFromFish.Text <> '') and (txtToFish.Text <> '') then
      begin
        qry.SQL.Add('WHERE Fish_Date >= ''' + txtFromFish.Text + '''');
        qry.SQL.Add('AND Fish_Date <= ''' + txtToFish.Text + '''');
      end
      else if txtFromFish.Text <> '' then
        qry.SQL.Add('WHERE Fish_Date >= ''' + txtFromFish.Text + '''')
      else if txtToFish.Text <> '' then
        qry.SQL.Add('AND Fish_Date <= ''' + txtToFish.Text + '''');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM FishFood');
      if (txtFromFish.Text <> '') and (txtToFish.Text <> '') then
      begin
        qry.SQL.Add('WHERE FF_Date >= ''' + txtFromFish.Text + '''');
        qry.SQL.Add('AND FF_Date <= ''' + txtToFish.Text + '''');
      end
      else if txtFromFish.Text <> '' then
        qry.SQL.Add('WHERE FF_Date >= ''' + txtFromFish.Text + '''')
      else if txtToFish.Text <> '' then
        qry.SQL.Add('AND FF_Date <= ''' + txtToFish.Text + '''');
      qry.ExecSQL;
    end;

    if chkProgram.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Week');
      if (txtFromProg.Text <> '') and (txtToProg.Text <> '') then
      begin
        qry.SQL.Add('WHERE Week_Date >= ''' + txtFromProg.Text + '''');
        qry.SQL.Add('AND Week_Date <= ''' + txtToProg.Text + '''');
      end
      else if txtFromProg.Text <> '' then
        qry.SQL.Add('WHERE Week_Date >= ''' + txtFromProg.Text + '''')
      else if txtToProg.Text <> '' then
        qry.SQL.Add('AND Week_Date <= ''' + txtToProg.Text + '''');
      qry.ExecSQL;
    end;

    if chkPricing.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM FoodPric');
      if (txtFromPrice.Text <> '') and (txtToPrice.Text <> '') then
      begin
        qry.SQL.Add('WHERE FP_Date >= ''' + txtFromPrice.Text + '''');
        qry.SQL.Add('AND FP_Date <= ''' + txtToPrice.Text + '''');
      end
      else if txtFromPrice.Text <> '' then
        qry.SQL.Add('WHERE FP_Date >= ''' + txtFromPrice.Text + '''')
      else if txtToPrice.Text <> '' then
        qry.SQL.Add('AND FP_Date <= ''' + txtToPrice.Text + '''');
      qry.ExecSQL;
    end;

    if chkFoods.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM FoodList');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM FoodPric');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Fish');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM FishFood');
      qry.ExecSQL;
    end;

    if chkGuest.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Persons WHERE P_IsGuest = 1');
      qry.ExecSQL;
    end;

    if chkPersons.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Persons');
      qry.ExecSQL;
      Msg_NoWait;
      if ConfirmMessage('«ÿ·«⁄«  Å—”‰· Õ–› ‘œ . ¬Ì« „Ì ŒÊ«ÂÌœ ›Ì‘Â«Ì ’«œ— ‘œÂ »—«Ì «›—«œ ‰Ì“ Õ–› ê—œœ ø') then
      begin
        Msg_Wait('œ— Õ«· Õ–› ‰„Êœ‰ «ÿ·«⁄« ...');
        qry.SQL.Clear;
        qry.SQL.Add('DELETE FROM Fish');
        qry.ExecSQL;

        qry.SQL.Clear;
        qry.SQL.Add('DELETE FROM FishFood');
        qry.ExecSQL;
      end
      else
        Msg_Wait('œ— Õ«· Õ–› ‰„Êœ‰ «ÿ·«⁄« ...');
    end;

    if chkParts.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Parts');
      qry.ExecSQL;
    end;

    if chkJobType.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM JobType');
      qry.ExecSQL;
    end;

    if chkUnits.Checked then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Units');
      qry.ExecSQL;
    end;

    qry.Free;
    InitVariables(False);
    Mouse_NoWait;
    Msg_NoWait;
  end;
end;

procedure TfrmFreeDBase.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

end.
