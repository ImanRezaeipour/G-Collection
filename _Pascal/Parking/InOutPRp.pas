unit InOutPRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, DateProc, MSGs, FarsiApi, Globals,
  Keyboard, RpInOutP, DBS, RunCmnds, DosMove, ExtCtrls;

type
  TfrmInOutPrcntRpt = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    txtFromTime: TEdit;
    txtToTime: TEdit;
    cmdClose: TBitBtn;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    DosMove1: TDosMove;
    rdoPrintType: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtFromTimeExit(Sender: TObject);
    procedure txtToTimeExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }

    function  AreValidControls : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmInOutPrcntRpt.SetWinF;
var i : Byte;
begin
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  rdoPrintType.Caption := (rdoPrintType.Caption);
  for i := 0 to rdoPrintType.Items.Count-1 do
    rdoPrintType.Items.Strings[i] := (rdoPrintType.Items.Strings[i]);
    
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;


function TfrmInOutPrcntRpt.AreValidControls : Boolean;
begin
  if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ «‘ »«Â «” ');
    AreValidControls := False;
    txtFromDate.SetFocus;
  end
  else if (txtToDate.Text <> '') and not IsTrueDate(txtTodate.Text) then
  begin
    ErrorMessage(' «—ÌŒ Å«Ì«‰ «‘ »«Â «” ');
    AreValidControls := False;
    txtToDate.SetFocus;
  end
  else if (txtFromDate.Text <> '') and (txtToDate.Text <> '') and
          (txtFromDate.Text > txtToDate.Text) then
  begin
    ErrorMessage(' «—ÌŒ ‘—Ê⁄ «“ Å«Ì«‰ »“—ê — «” ');
    AreValidControls := False;
    txtToDate.SetFocus;
  end
  else if (txtFromTime.Text <> '') and not IsTrueTime(txtFromTime.Text) then
  begin
    ErrorMessage('“„«‰ ‘—Ê⁄ «‘ »«Â «” ');
    AreValidControls := False;
    txtFromTime.SetFocus;
  end
  else if (txtToTime.Text <> '') and not IsTrueTime(txtToTime.Text) then
  begin
    ErrorMessage('“„«‰ Å«Ì«‰ «‘ »«Â «” ');
    AreValidControls := False;
    txtToTime.SetFocus;
  end
  else
    AreValidControls := True;
end;


procedure TfrmInOutPrcntRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := txtFromDate.Text;
  
end;

procedure TfrmInOutPrcntRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmInOutPrcntRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmInOutPrcntRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmInOutPrcntRpt.txtFromTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmInOutPrcntRpt.txtFromTimeExit(Sender: TObject);
begin
  if txtFromTime.Text <> '' then
    txtFromTime.Text := BeautifulTime(txtFromTime.Text);
end;

procedure TfrmInOutPrcntRpt.txtToTimeExit(Sender: TObject);
begin
  if txtToTime.Text <> '' then
    txtToTime.Text := BeautifulTime(txtToTime.Text);
end;

procedure TfrmInOutPrcntRpt.cmdPrintClick(Sender: TObject);
var frmRptInOutPrcnt : TfrmRptInOutPrcnt;
begin
  if AreValidControls then
  begin
    if g_options.RdrOff_Rpt = MB_TRUE then
      SetUserControl;
    AddRecToMachine;
    Application.CreateForm(TfrmRptInOutPrcnt, frmRptInOutPrcnt);
    with frmRptInOutPrcnt do
    begin
      if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
        lblFromToDate.Caption := ('«“  «—ÌŒ: ' )+ txtFromDate.Text + ('     «  «—ÌŒ: ' )+ txtToDate.Text
      else if txtFromDate.Text <> '' then
        lblFromToDate.Caption := ('«“  «—ÌŒ: ' )+ txtFromDate.Text
      else if txtToDate.Text <> '' then
        lblFromToDate.Caption := (' «  «—ÌŒ: ' )+ txtToDate.Text
      else
        lblFromToDate.Caption := '';

      if (txtFromTime.Text <> '') and (txtToTime.Text <> '') then
        lblFromToTime.Caption := ('«“ ”«⁄ : ' )+ txtFromTime.Text + ('     « ”«⁄ : ' )+ txtToTime.Text
      else if txtFromTime.Text <> '' then
        lblFromToTime.Caption := ('«“ ”«⁄ : ' )+ txtFromTime.Text
      else if txtToTime.Text <> '' then
        lblFromToTime.Caption := (' « ”«⁄ : ' )+ txtToTime.Text
      else
        lblFromToTime.Caption := '';

      with qryMachines do
      begin
        Close;
        with SQL do
        begin
          Clear;
          Add('SELECT COUNT(M_BarCode) AS c, M_IDate FROM Machines WHERE M_IsPark = ' + IntToStr(CNST_FALSE));
          if (txtFromDate.Text <> txtToDate.Text) and
             (txtFromTime.Text <> txtToTime.Text) then
          begin
            Add('AND (M_IDate > ''' + txtFromDate.Text + '''');
            Add('OR (M_IDate = ''' + txtFromDate.Text + '''');
            Add('AND M_ITime >= ''' + txtFromTime.Text + '''))');

            Add('AND (M_IDate < ''' + txtToDate.Text + '''');
            Add('OR (M_IDate = ''' + txtToDate.Text + '''');
            Add('AND M_ITime <= ''' + txtToTime.Text + '''))');
          end
          else
          begin
            if txtFromDate.Text <> '' then
              Add('AND M_IDate >= ''' + txtFromDate.Text + '''');
            if txtToDate.Text <> '' then
              Add('AND M_IDate <= ''' + txtToDate.Text + '''');
            if txtFromTime.Text <> '' then
              Add('AND M_ITime >= ''' + txtFromTime.Text + '''');
            if txtToTime.Text <> '' then
              Add('AND M_ITime <= ''' + txtToTime.Text + '''');
          end;

          Add('GROUP BY M_IDate');
          Add('ORDER BY M_IDate');
        end;
        Open;
        if RecordCount > 0 then
        begin
          if rdoPrintType.ItemIndex = 0 then
            qrptMachines.Preview
          else
            qrptMachines.Print;
        end
        else
          InformationMessage('Ê—Êœ Ê Œ—ÊÃÌ ÊÃÊœ ‰œ«—œ.');
        Close;
      end;
      Free;
    end;
    DelRecFromMachine;
    if g_options.RdrOff_Rpt = MB_TRUE then
      UserControl := False;
  end;
end;

end.
