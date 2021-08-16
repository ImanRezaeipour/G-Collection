unit LmitCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids;

type
  TfrmLimitCard = class(TForm)
    cmbReaders: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cmbOperate: TComboBox;
    cmdOk: TBitBtn;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    grdPishCard: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure cmbReadersKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOkClick(Sender: TObject);
    procedure grdPishCardKeyPress(Sender: TObject; var Key: Char);
    procedure grdPishCardEnter(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    procedure InitialGrid;
    
  public
    { Public declarations }
  end;

var
  frmLimitCard : TfrmLimitCard;

implementation

uses
  Globals, Keyboard, DateProc, MSGs, RunCmnds, Funcs, FntSel;

{$R *.DFM}


procedure TfrmLimitCard.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmLimitCard));

  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  for i := 0 to cmbOperate.Items.Count-1 do
    cmbOperate.Items.Strings[i] := (cmbOperate.Items.Strings[i]);
  cmdOK.Caption := (cmdOK.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdExit.Caption := (cmdExit.Caption);
end;

procedure TfrmLimitCard.InitialGrid;
var i : Byte;
begin
  grdPishCard.ColCount := 3;
  grdPishCard.RowCount := 13;

  grdPishCard.ColWidths[0] := 50;
  grdPishCard.Cells[0, 0] := ('ÑÏíİ');

  grdPishCard.ColWidths[1] := 100;
  grdPishCard.Cells[1, 0] := ('ÔÑæÚ ßÇÑÊåÇ');

  grdPishCard.ColWidths[2] := 100;
  grdPishCard.Cells[2, 0] := ('ÇíÇä ßÇÑÊåÇ');
  for i := 1 to 8 do grdPishCard.Cells[0, i] := IntToStr(i);
end;

procedure TfrmLimitCard.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  if rdrCount > 0 then
    for i := 0 to rdrCount-1 do
      cmbReaders.Items.Add(IntToStr(Readers[i].R_Code) + '-' + Readers[i].R_Name);

  cmbReaders.ItemIndex := 0;
  cmbOperate.ItemIndex := 0;
  InitialGrid;
end;

procedure TfrmLimitCard.cmbReadersKeyPress(Sender: TObject; var Key: Char);
var tp : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    tp := Self.FindNextControl(Self.ActiveControl, True, True, True);
    tp.SetFocus;
  end;
end;

procedure TfrmLimitCard.cmdOkClick(Sender: TObject);
const
  SET_LIMITCARD = 0;
  GET_LIMITCARD = 1;

var
  i : Byte;
  OK : Boolean;
  ST1, ST2 : String;
begin
  if cmbReaders.Text = '' then
  begin
    ErrorMessage('ÊÑãíäÇá ãÔÎÕ äÔÏå ÇÓÊ.');
    cmbReaders.SetFocus;
  end
  else if cmbOperate.Text = '' then
   begin
    ErrorMessage('ÚãáíÇÊ ãÔÎÕ äÔÏå ÇÓÊ.');
    cmbReaders.SetFocus;
  end
  else
  begin
    case cmbOperate.ItemIndex of
      SET_LIMITCARD:
      begin
        Mouse_Wait;
        MSG_Wait('ÏÑ ÍÇá ÊäÙíã ãÍÏæÏå ßÇÑÊåÇ...');
        OK := True;
        for i := 1 to 8 do
        begin
          OK := (OK AND SetLimitCard(Readers[cmbReaders.ItemIndex], i, grdPishCard.Cells[1, i], grdPishCard.Cells[2, i]));
          if not OK then Break;
        end;
        Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ãÍÏæÏå İÚÇáíÊ ßÇÑÊåÇ Èå ÊÑãíäÇá ÇÑÓÇá ÔÏ.')
        else
          InformationMessage('ÇÑÓÇá ãÍÏæÏå İÚÇáíÊ ˜Ï ' + IntToStr(i) + ' Èå ÊÑãíäÇá äÇãæİŞ ÈæÏ.');
      end;

      GET_LIMITCARD:
      begin
        Mouse_Wait;
        //MSG_Wait('ÏÑ ÍÇá ãÍÏæÏå İÚÇáíÊ ßÇÑÊåÇ...');
        for i := 1 to 8 do
        begin
          grdPishCard.Cells[1, i] := '';
          grdPishCard.Cells[2, i] := '';
        end;

        grdPishCard.Refresh;
        for i := 1 to 8 do
        begin
          if GetLimitCard(Readers[cmbReaders.ItemIndex], i, ST1, ST2) then
          begin
            OK := True;
            //if ST1 <> '00000000' then
            begin
              grdPishCard.Cells[1, i] := ST1;
              grdPishCard.Cells[2, i] := ST2;
              grdPishCard.Refresh;
            end;
          end
          else
          begin
            OK := False;
            InformationMessage('ÎæÇäÏä ãÍÏæÏå İÚÇáíÊ ßÇÑÊåÇ ÏÑ ÑÏíİ '+ IntToStr(i) + ' ÊÑãíäÇá äÇãæİŞ ÈæÏ.');
            Break;
          end;
        end;

        //Msg_NoWait;
        Mouse_NoWait;
        if OK then
          InformationMessage('ãÍÏæÏå İÚÇáíÊ ßÇÑÊåÇí ÊÑãíäÇá ÎæÇäÏå ÔÏ.');
        {else
          InformationMessage('ÎæÇäÏä ãÍÏæÏå İÚÇáíÊ ßÇÑÊ ÑÏíİ '+ IntToStr(i) + ' ÊÑãíäÇá äÇãæİŞ ÈæÏ.');}
      end;

    end;
  end;
end;

procedure TfrmLimitCard.grdPishCardKeyPress(Sender: TObject; var Key: Char);
var s : String;
begin
  grdPishCardEnter(Sender);
  if grdPishCard.Col <> 0 then
  begin
    Keyboard_Hex(Key);
    s := grdPishCard.Cells[grdPishCard.Col, grdPishCard.Row];
    if (Length(s) = 8) and not (Key in [#13, #8]) then Key := #0;
  end;
end;

procedure TfrmLimitCard.grdPishCardEnter(Sender: TObject);
begin
  if grdPishCard.Col = 0 then
    grdPishCard.Options := grdPishCard.Options - [goEditing]
  else
    grdPishCard.Options := grdPishCard.Options + [goEditing];

  grdPishCard.Refresh;
end;

end.
