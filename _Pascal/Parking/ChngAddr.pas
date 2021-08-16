unit ChngAddr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, AdoDB, StdCtrls, Buttons, ComTools, RunCmnds, MSGs, Globals,
  DBS, Keyboard, Z84_CMD;

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
    function AreValidFields : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

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
var
  idx : Byte;
  s : String;
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
    s := lstReader.Items.Strings[lstReader.ItemIndex];
    idx := FindReaderCodeIdx(StrToInt(Copy(s, 1, Pos('-', s)-1)));
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
  SetWinF;
  for i := 1 to TotalReader do
    with Readers[i] do
     begin
       if R_Active then
         lstReader.Items.Add(IntToStr(R_Code) + '-' + R_Name);
       Addr_Set := Addr_Set + [R_Code];
    end;
end;

procedure TfrmChngAddr.lstReaderClick(Sender: TObject);
var
  i : Byte;
  s : String;
begin
  lblMsg.Caption := '';
  s := lstReader.Items.Strings[lstReader.ItemIndex];
  i := FindReaderCodeIdx(StrToInt(Copy(s, 1, Pos('-', s)-1)));
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
  s : String;
begin
  if AreValidFields then
  begin
    Mouse_Wait;
    s := lstReader.Items.Strings[lstReader.ItemIndex];
    idx := FindReaderCodeIdx(StrToInt(Copy(s, 1, Pos('-', s)-1)));
    lblMsg.Caption := ('œ— Õ«· «— »«ÿ »« œ” ê«Â');
    lblMsg.Refresh;
    SetUserControl;
    if SwitchReader(idx) then
    begin
      if ChangeAddress(Readers[idx],StrToInt(txtReaderCode.Text)) then
      begin
        qry := TAdoQuery.Create(Application);
        with qry do
        begin
          connection := frmDBS.adoConnect;
          SQL.Clear;
          SQL.Add('UPDATE Readers SET R_Code = ' + txtReaderCode.Text);
          SQL.Add('WHERE R_Code = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE Machines SET M_IDoor = ' + txtReaderCode.Text);
          SQL.Add('WHERE M_IDoor = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE Machines SET M_ODoor = ' + txtReaderCode.Text);
          SQL.Add('WHERE M_ODoor = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE InputCar SET M_IDoor=  ' + txtReaderCode.Text);
          SQL.Add('WHERE M_IDoor = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE InputCar SET M_ODoor = ' + txtReaderCode.Text);
          SQL.Add('WHERE M_ODoor = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE Deleted SET D_IDoor = ' + txtReaderCode.Text);
          SQL.Add('WHERE D_IDoor = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE Deleted SET D_ODoor = ' + txtReaderCode.Text);
          SQL.Add('WHERE D_ODoor = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE InOutCo SET IO_IDoor = ' + txtReaderCode.Text);
          SQL.Add('WHERE IO_IDoor = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;

          SQL.Clear;
          SQL.Add('UPDATE InOutCo SET IO_ODoor = ' + txtReaderCode.Text);
          SQL.Add('WHERE IO_ODoor = ' + IntToStr(Readers[idx].R_Code));
          ExecSQL;
          Free;

          Addr_Set := Addr_Set-[Readers[idx].R_Code]+[StrToInt(txtReaderCode.Text)];
          curRdrCode := StrToInt(txtReaderCode.Text);
          Readers[idx].R_Code := StrToInt(txtReaderCode.Text);
        end;
        s := IntToStr(Readers[idx].R_Code) + '-' + Readers[idx].R_Name;
        lstReader.Items.Strings[lstReader.ItemIndex] := s;
        lstReader.SetFocus;
        lblMsg.Caption := (' €ÌÌ— ¬œ—” «‰Ã«„ ‘œ.')
      end
      else
        lblMsg.Caption := ('«— »«ÿ »—ﬁ—«— ‰Ì” .');
    end;
    lblMsg.Refresh;
    Mouse_NoWait;
    UserControl := False;
  end;
end;


end.

