unit ChngAddr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, StdCtrls, Buttons, Ertebat, MSGs, Globals,
  DBS_Proc, Keyboard;

type
  TfrmChngAddr = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cmdOK: TBitBtn;
    cmdExit: TBitBtn;
    txtReaderCode: TEdit;
    cmdHelp: TBitBtn;
    lblMsg: TLabel;
    lstReader: TListBox;
    procedure txtReaderCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure txtReaderCodeChange(Sender: TObject);
    procedure lstReaderClick(Sender: TObject);
    procedure lstReaderKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function  AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}
uses ComTools;
var
   Addr_Set : set of 0..255 = [];


procedure TfrmChngAddr.SetWinF;
begin
  Caption := (Caption);
  Label2.Caption := (Label2.Caption);
  Label1.Caption := (Label1.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

function TfrmChngAddr.AreValidFields : Boolean;
var idx : Byte;
begin
  idx := FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex]);
  if lstReader.ItemIndex < 0 then
  begin
    AreValidFields := False;
    ErrorMessage('œ” ê«Â „‘Œ’ ‰‘œÂ «” .');
    lstReader.SetFocus;
  end
  else if txtReaderCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('ﬂœ œ” ê«Â „‘Œ’ ‰‘œÂ «” .');
    txtReaderCode.SetFocus;
  end
  else if not (StrToInt(txtReaderCode.Text) in [1..255]) then
  begin
    AreValidFields := False;
    ErrorMessage('¬œ—” »«Ìœ œ— „ÕœÊœÂ 1  « 255 »«‘œ.');
    txtReaderCode.SetFocus;
  end
  else if StrToInt(txtReaderCode.Text) in Addr_Set-[Readers[idx].R_Code] then
  begin
    AreValidFields := False;
    ErrorMessage('¬œ—” œ” ê«Â  ﬂ—«—Ì «” .');
    txtReaderCode.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmChngAddr.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  for i := 1 to TotalReader do
    with Readers[i] do
     begin
       if R_Active then
         lstReader.Items.Add(R_Name);
       Addr_Set := Addr_Set + [R_Code];
    end;
end;

procedure TfrmChngAddr.lstReaderClick(Sender: TObject);
var i : Byte;
begin
  lblMsg.Caption := '';
  i := FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex]);
  if i <> 0 then
    txtReaderCode.Text := IntToStr(Readers[i].R_Code);
end;

procedure TfrmChngAddr.lstReaderKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtReaderCode.SetFocus;
  end;
end;

procedure TfrmChngAddr.txtReaderCodeChange(Sender: TObject);
begin
  lblMsg.Caption := '';
end;

procedure TfrmChngAddr.txtReaderCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdOK.SetFocus;
  end
  else
    Keyboard_Integer(Key);
end;

procedure TfrmChngAddr.cmdOKClick(Sender: TObject);
var
  qry : TAdoQuery;
  idx, STAT : Byte;
  OK : Boolean;
  PK : String;
begin
  if AreValidFields then
  begin
    Mouse_Wait;
    idx := FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex]);
    lblMsg.Caption := ('œ— Õ«· «— »«ÿ »« œ” ê«Â');
    lblMsg.Refresh;
    SetUserControl;
    if SwitchReader(idx) then
    begin
      MakePocket(PK, MicroAddress, $0F, 0, Chr(StrToInt(txtReaderCode.Text)));
      if not SendPocket(PK) then
        OK := False
      else
      begin
        GetPocket(PK, True, STAT);
        if (STAT = 0) and (length(PK)>3) then
          OK := (Ord(PK[4]) = $06)
        else
          OK := False;
      end;
    end
    else
      OK := False;

    if OK then
    begin
      qry := TAdoQuery.Create(Application);
      with qry do
      begin
        connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('UPDATE Readers SET R_Code = ' + txtReaderCode.Text);
        SQL.Add('WHERE R_Code = ' + IntToStr(Readers[idx].R_Code));
        ExecSQL;

        SQL.Clear;
        SQL.Add('UPDATE Fish SET Fish_RdrCode = ' + txtReaderCode.Text);
        SQL.Add('WHERE Fish_RdrCode = ' + IntToStr(Readers[idx].R_Code));
        ExecSQL;
        Free;

        Addr_Set := Addr_Set-[Readers[idx].R_Code]+[StrToInt(txtReaderCode.Text)];
        MicroAddress := StrToInt(txtReaderCode.Text);
        Readers[idx].R_Code := StrToInt(txtReaderCode.Text);
      end;
    end;
    UserControl := False;
    if OK then
      lblMsg.Caption := (' €ÌÌ— ¬œ—” «‰Ã«„ ‘œ.')
    else
      lblMsg.Caption := ('«— »«ÿ »—ﬁ—«— ‰Ì” .');
    lblMsg.Refresh;
    Mouse_NoWait;
  end;
end;


end.

