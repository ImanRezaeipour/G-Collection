unit Intlgnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DosMove;

type
  TfrmIntelligentFile = class(TForm)
    lbl1: TLabel;
    txtFileName: TEdit;
    btnOpenFile: TButton;
    lbl2: TLabel;
    txtFromDate: TEdit;
    lbl3: TLabel;
    txtToDate: TEdit;
    cmdRun: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    lblCount: TLabel;
    opnFile: TOpenDialog;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
    procedure cmdRunClick(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

uses
  Globals, MSGs, Keyboard, DateProc, DBS_Proc;

{$R *.dfm}


procedure TfrmIntelligentFile.SetWinF;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  cmdRun.Caption := (cmdRun.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmIntelligentFile.FormCreate(Sender: TObject);
begin
  SetWinF;
  lblCount.Caption := '';
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := txtFromDate.Text;
end;

procedure TfrmIntelligentFile.btnOpenFileClick(Sender: TObject);
begin
  opnFile.InitialDir := g_Options.ProgramPath;
  if opnFile.Execute then
    txtFileName.Text := opnFile.FileName;
end;

procedure TfrmIntelligentFile.cmdRunClick(Sender: TObject);
var
  f : TextFile;
  recBuff : String;
  P_Fish : TFish;
  p : TPerson;
  recCount : Integer;
  i : Byte;
begin
  if txtFileName.Text = '' then
  begin
    ErrorMessage('‰«„ ›«Ì· „‘Œ’ ‰‘œÂ «” .');
    txtFileName.SetFocus;
  end
  else if not FileExists(txtFileName.Text) then
  begin
    ErrorMessage('›«Ì· ÊÃÊœ ‰œ«—œ.');
    txtFileName.SetFocus;
  end
  else
  begin
    lblCount.Caption := '';
    recCount := 0;
    AssignFile(f, txtFileName.Text);
    Reset(f);
    while not Eof(f) do
    begin
      Readln(f, recBuff);
      P_Fish.Fish_RdrCode := StrToInt(Copy(recBuff, 1, 2));
      P_Fish.Keys := Ord(recBuff[5]) * 256 + Ord(recBuff[4]);
      P_Fish.Fish_Date := BeautifulDate(Copy(recBuff, 7, 2) + '/' +
                                        Copy(recBuff, 9, 2) + '/' +
                                        Copy(recBuff, 11, 2));
      P_Fish.Fish_Time := BeautifulTime(Copy(recBuff, 14, 2) + ':' +
                                        Copy(recBuff, 16, 2));
      P_Fish.Fish_PCode := Copy(recBuff, 43, 8);
      P_Fish.ManySel := 1;

      if (P_Fish.Fish_Date >= txtFromDate.Text) and (P_Fish.Fish_Date <= txtToDate.Text) then
      begin
        Inc(recCount);
        lblCount.Caption := IntToStr(recCount);
        lblCount.Refresh;

        if g_options.RunDate <> P_Fish.Fish_Date then
        begin
          g_options.RunDate := P_Fish.Fish_Date;
          InitVariables(False);
        end;
        for i := 1 to 8 do
          P_Fish.Fish_FoodsNo[i] := 1;
        P_Fish.Fish_UCode := 0;
        P_Fish.Fish_UKhadamat := 0;
        P_Fish.Fish_UPrc := 0;
        P_Fish.Fish_UPay := 0;
        P_Fish.IsProxi := True;
        CreateFish(P_Fish, p, False);
        SaveFish(P_Fish);
      end;
    end;
    CloseFile(f);
    InformationMessage(' ⁄œ«œ ' + IntToStr(recCount) + ' ›Ì‘ «“ ›«Ì· ŒÊ«‰œÂ ‘œ.');
  end;
end;

procedure TfrmIntelligentFile.txtFromDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmIntelligentFile.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmIntelligentFile.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

end.
