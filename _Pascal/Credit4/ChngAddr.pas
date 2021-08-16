unit ChngAddr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ComTools, MSGs, Globals,
  Keyboard, DBS, RunCmnds, ADODB, DosMove;

type
  TfrmChngAddr = class(TForm)
    lbl2: TLabel;
    lbl1: TLabel;
    cmdOK: TBitBtn;
    cmdExit: TBitBtn;
    txtReaderCode: TEdit;
    cmdHelp: TBitBtn;
    lblMsg: TLabel;
    lstReader: TListBox;
    DosMove1: TDosMove;
    procedure txtReaderCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure txtReaderCodeChange(Sender: TObject);
    procedure lstReaderClick(Sender: TObject);
    procedure lstReaderKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;
    function  AreValidFields : Boolean;
  public
    { Public declarations }
  end;


implementation

uses
  Funcs;

{$R *.DFM}

var
   Addr_Set : set of 0..255 = [];



procedure TfrmChngAddr.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

function TfrmChngAddr.AreValidFields : Boolean;
var idx : Byte;
begin
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
  else
  begin
    idx := FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex]);
    if StrToInt(txtReaderCode.Text) in Addr_Set-[Readers[idx].R_Code] then
    begin
      AreValidFields := False;
      ErrorMessage('¬œ—” œ” ê«Â  ﬂ—«—Ì «” .');
      txtReaderCode.SetFocus;
    end
    else
      AreValidFields := True;
  end;
end;

procedure TfrmChngAddr.FormCreate(Sender: TObject);
var i : Byte;
begin
  Addr_Set := [];
  SetWinF;
  for i := 1 to TotalReader do
    with Readers[i] do
     begin
    if Readers[i].R_Active and
       (Readers[i].R_Type in [RDR_CLK6000]) then
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
  idx : Byte;
begin
  if AreValidFields then
  begin
    Mouse_Wait;
    idx := FindReaderNameIdx(lstReader.Items.Strings[lstReader.ItemIndex]);
    lblMsg.Caption := ('œ— Õ«· «— »«ÿ »« œ” ê«Â');
    lblMsg.Refresh;
    SetUserControl;
    if ChangeAddress(Readers[idx], StrToInt(txtReaderCode.Text)) then
    begin
     with qry do
      begin
        qry := TAdoQuery.Create(Application);
        Connection := frmDBS.DBConnection;
        SQL.Clear;
        SQL.Add('UPDATE Readers SET R_Code = ' + txtReaderCode.Text);
        SQL.Add('WHERE R_Code = ' + IntToStr(Readers[idx].R_Code));
        ExecSQL;

        Addr_Set := Addr_Set-[Readers[idx].R_Code]+[StrToInt(txtReaderCode.Text)];
        curRdrCode := StrToInt(txtReaderCode.Text);
        Readers[idx].R_Code := StrToInt(txtReaderCode.Text);
      end;
      lblMsg.Caption := (' €ÌÌ— ¬œ—” «‰Ã«„ ‘œ.');
      LoadReaders;
    end
    else
      lblMsg.Caption := ('«— »«ÿ »—ﬁ—«— ‰Ì” .');
    UserControl := False;
    lblMsg.Refresh;
    Mouse_NoWait;
  end;
end;


end.

