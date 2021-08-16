unit FreeDBS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, AdoDB, Globals, MSGs, DateProc, DBS, ExtCtrls;

type
  TfrmFreeDBase = class(TForm)
    cmdDel: TBitBtn;
    cmdHelp: TBitBtn;
    cmdExit: TBitBtn;
    rdoDelete: TRadioGroup;
    procedure cmdDelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;

var
  frmFreeDBase: TfrmFreeDBase;

implementation

{$R *.DFM}


procedure TfrmFreeDBase.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  for i := 0 to rdoDelete.Items.Count-1 do
    rdoDelete.Items.Strings[i] := (rdoDelete.Items.Strings[i]);
  cmdDel.Caption := (cmdDel.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmFreeDBase.cmdDelClick(Sender: TObject);
var
  qry : TAdoQuery;
begin
  if ConfirmMessage('¬Ì« »—«Ì Õ–› «ÿ·«⁄«  „—»Êÿ »Â ŒÊœ—ÊÂ« «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    Mouse_Wait;
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    if rdoDelete.ItemIndex = 0 then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM InputCar WHERE M_IsPark = ' + IntToStr(CNST_TRUE));
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_TRUE));
      qry.ExecSQL;
    end
    else if rdoDelete.ItemIndex = 1 then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM InputCar WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
      qry.ExecSQL;
    end
    else if rdoDelete.ItemIndex = 2 then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM InputCar');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Machines');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM PayCust');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Deleted');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM CarPark');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM Diff');
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM NoCard');
      qry.ExecSQL;

    end;
    qry.Free;
    InitVariables;
    Mouse_NoWait;
  end;
end;

procedure TfrmFreeDBase.FormCreate(Sender: TObject);
begin
  SetWinF;
end;

end.
