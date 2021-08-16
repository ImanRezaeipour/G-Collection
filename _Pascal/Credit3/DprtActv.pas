unit DprtActv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls;

type
  TfrmDepartActive = class(TForm)
    dbgDepartActive: TDBGrid;
    dtaDepartActive: TDataSource;
    aqryDepartActive: TADOQuery;
    tmrDepartment: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmrDepartmentTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDepartActive: TfrmDepartActive;

implementation

uses
  Funcs, DBS, Globals;

{$R *.dfm}

procedure TfrmDepartActive.FormShow(Sender: TObject);
begin
  Caption := ('·Ì”  „—«ﬂ“ ›⁄«·');
  dbgDepartActive.Columns[0].Title.Caption := ('„—«ﬂ“ ›⁄«·');
  aqryDepartActive.Connection := frmDBS.adoConnect;
  tmrDepartment.Enabled := True;
end;

procedure TfrmDepartActive.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tmrDepartment.Enabled := False;
  aqryDepartActive.Close;
end;

procedure TfrmDepartActive.tmrDepartmentTimer(Sender: TObject);
begin
  with aqryDepartActive do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Department WHERE Depart_OnLine = ' + IntToStr(MB_TRUE));
    SQL.Add('AND Depart_Code <> ' + IntToStr(gParams.department));
    Open;
  end;
end;

end.

