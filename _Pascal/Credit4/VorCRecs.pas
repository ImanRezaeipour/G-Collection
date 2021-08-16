unit VorCRecs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Globals, Buttons, Grids, ComCtrls, RunCmnds, DB,
  ADODB, MPlayer, VrControls, VrAnalog,msgs, DBGrids;

type
  TfrmVorCRecs = class(TForm)
    pnlPicture: TPanel;
    imgPicture: TImage;
    dbgVakil: TDBGrid;
    adoVakil: TADOQuery;
    dtaVakil: TDataSource;
    pnlSignPicture: TPanel;
    imgSignPicture: TImage;
    Label33: TLabel;
    Label37: TLabel;
    lblCKind: TLabel;
    adoPersons: TADOQuery;
    dtaPersons: TDataSource;
    dbgPersons: TDBGrid;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure dtaVakilDataChange(Sender: TObject; Field: TField);
    procedure dtaPersonsDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    Procedure InitDB;
    Procedure dbgVakilClick;
    Procedure InitCKind;
  public
    { Public declarations }
    iP_Code : String[8];
    iVorC : Boolean;
    iCKind : Byte;
    iCoName : string;
  end;


implementation

uses
  DBS, Z84_CMD, Z80_CMD, ComTools, TimeTool,DateProc, Funcs, TCP_UDP,request,main;


{$R *.DFM}

procedure TfrmVorCRecs.FormShow(Sender: TObject);
begin
  if iVorC then
    frmVorCRecs.Caption := 'لیست وکلا'
  else
    frmVorCRecs.Caption := 'لیست صاحبان صندوق';

  initDB;
  InitCKind;
end;

procedure TfrmVorCRecs.dtaPersonsDataChange(Sender: TObject; Field: TField);
begin
  dbgVakilClick;
end;

procedure TfrmVorCRecs.dtaVakilDataChange(Sender: TObject; Field: TField);
begin
  dbgVakilClick;
end;

procedure TfrmVorCRecs.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  iP_Code := ' ';
  iVorC := False;

end;

procedure TfrmVorCRecs.InitDB;
begin
  if iVorC then
  begin
    dbgPersons.Visible := False;
    dbgVakil.Visible := True;
    with adoVakil do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
      SQL.Add('select * from nProxies ');
      SQL.Add('where nP_CustomerCode = ''' + iP_Code + ''' ');
      SQL.Add('order by np_VProxi ');
      Open;
    end;
  end
  else
  begin
    dbgVakil.Visible := False;
    dbgPersons.Visible := True;
    with adoPersons do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
      SQL.Add('select * ');
      if iCKind <> 4 then
        SQL.Add(',''دارد'' as Permit ')
      else
      begin
        SQL.Add(',case(np_IsMemberCommonBoxType3) ');
        SQL.Add('when 0 then ''ندارد'' ');
        SQL.Add('when 1 then ''دارد'' ');
        SQL.Add('else ''ندارد'' ');
        SQL.Add('end as Permit ');
      end;
      SQL.Add('from nPersons ');
      SQL.Add('where np_code = ''' + iP_Code + ''' ');
      SQL.Add('order by np_FAMILY, np_NAME, np_Proxi ');
      Open;
    end;
  end;
end;

procedure TfrmVorCRecs.dbgVakilClick;
var
  tempPictureName, tempSignPictureName : string;
begin
  if iVorC then
  begin
    tempPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + adoVakil.FieldByName('np_VPicture').AsString;
    tempSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + adoVakil.FieldByName('np_VSignPicture').AsString;
  end
  else
  begin
    tempPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + adoPersons.FieldByName('np_Picture').AsString;
    tempSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + adoPersons.FieldByName('np_SignPicture').AsString;
  end;

  if (tempPictureName <> '') and FileExists(tempPictureName) then
  begin
    imgPicture.Picture.LoadFromFile(tempPictureName);
    imgPicture.Width:=round(imgPicture.Height*imgPicture.Picture.Width/imgPicture.Picture.Height);
  end
  else
    imgPicture.Picture.Bitmap := nil;
    
  if (tempSignPictureName <> '') and FileExists(tempSignPictureName) then
  begin
    imgSignPicture.Picture.LoadFromFile(tempSignPictureName);
    imgSignPicture.Width:=round(imgSignPicture.Height*imgSignPicture.Picture.Width/imgSignPicture.Picture.Height);
  end
  else
    imgSignPicture.Picture.Bitmap := nil;

end;


procedure TfrmVorCRecs.InitCKind;
begin
  lblCKind.Caption :=  'شناسه مشتری : ' + iP_Code + '-' + F_Params.BranchCode + '          ';
  case iCKind of
    0:lblCKind.Caption := lblCKind.Caption + 'صندوق انفرادی';
    1:lblCKind.Caption := lblCKind.Caption + 'مشتری حقوقی - شرکت ' + iCoName;
    2:lblCKind.Caption := lblCKind.Caption + 'صندوق مشترک گروهی';
    3:lblCKind.Caption := lblCKind.Caption + 'صندوق مشترک فردی';
    4:lblCKind.Caption := lblCKind.Caption + 'صندوق مشترک ترکیبی';
  end;
end;
end.


