unit ChargeRp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, AdoDB, Globals, FarsiApi, DateProc,
  MSGs, Keyboard, Rpcharge, DB;

type
  TfrmChargeRpt = class(TForm)
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    Label1: TLabel;
    txtFromDate: TEdit;
    Label2: TLabel;
    txtToDate: TEdit;
    chkSign: TCheckBox;
    cbuser: TComboBox;
    Label3: TLabel;
    qry: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure rdoScreenKeyPress(Sender: TObject; var Key: Char);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtToDateKeyPress(Sender: TObject; var Key: Char);
    procedure chkSignKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  ComTools, DBS_Proc;

{$R *.DFM}

procedure TfrmChargeRpt.SetWinF;
begin
end;

procedure TfrmChargeRpt.FormCreate(Sender: TObject);
begin
  SetWinF;
  txtFromDate.Text := g_options.RptFDate;
  txtToDate.Text := g_options.RptTDate;

  qry.connection := frmDBS.DBConnection;
  qry.SQL.Clear;
  qry.SQL.Add('select * from security');
  qry.Open;
  while not qry.Eof do
  begin
      cbUser.Items.Add(qry.FieldByName('username').asstring);
      qry.Next;
  end;
  close;
end;

procedure TfrmChargeRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    txtToDate.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmChargeRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then txtFromDate.Text := BeautifulDate(txtFromDate.Text);
  g_options.RptFDate := txtFromDate.Text; 
end;

procedure TfrmChargeRpt.txtToDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cbuser.SetFocus;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmChargeRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then txtToDate.Text := BeautifulDate(txtToDate.Text);
  g_options.RptTDate := txtToDate.Text;
end;

procedure TfrmChargeRpt.rdoScreenKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    chkSign.SetFocus;
  end;
end;

procedure TfrmChargeRpt.chkSignKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    cmdprint.SetFocus;
  end;
end;

procedure TfrmChargeRpt.cmdPrintClick(Sender: TObject);
var
  frmRptcharge : TfrmRptcharge;
begin
  if (txtFromDate.Text <> '') and not IsTrueDate(txtFromDate.Text) then
  begin
    ErrorMessage('تاريخ اشتباه است.');
    txtFromDate.SetFocus;
  end
  else if (txtToDate.Text <> '') and not IsTrueDate(txtToDate.Text) then
  begin
    ErrorMessage('تاريخ اشتباه است.');
    txtToDate.SetFocus;
  end
  else if (txtFromDate.Text <> '') and (txtToDate.Text <> '') and
          (txtFromDate.Text > txtToDate.Text) then
  begin
    ErrorMessage('تاريخ ابتدا از تاريخ انتها بزرگتر است.');
    txtToDate.SetFocus;
  end
  else
  begin
      Application.CreateForm(TfrmRptcharge, frmRptcharge);
      with frmRptcharge do
      begin
        Mouse_Wait;
        Msg_Wait('در حال ايجاد گزارش');

        bndSign.Enabled := chkSign.Checked;
        lblEndRep1.Caption := F_Params.EndRep1;
        lblEndRep2.Caption := F_Params.EndRep2;
        lblEndRep3.Caption := F_Params.EndRep3;
        lblEndRep4.Caption := F_Params.EndRep4;

        EDate := txtToDate.Text;
        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblRepDate.Caption := ('از تاريخ : ' + txtFromDate.Text + '    تا تاريخ : ' + txtToDate.Text)
        else if txtFromDate.Text <> '' then
          lblRepDate.Caption := ('از تاريخ : ' + txtFromDate.Text)
        else if txtToDate.Text <> '' then
          lblRepDate.Caption := ('تا تاريخ :' + txtToDate.Text)
        else
          lblRepDate.Caption := '';
        qrycharge.SQL.Clear;

        qrycharge.SQL.Add('SELECT c.* , p.p_barcode,p.p_name,p.p_family FROM charge as c , persons as p');
        qrycharge.SQL.Add('WHERE c.ch_barcode = p.p_barcode');

        if txtFromDate.Text <> '' then
          qrycharge.SQL.Add('AND ch_Date >= ''' + txtFromDate.Text + '''');
        if txtToDate.Text <> '' then
          qrycharge.SQL.Add('AND ch_Date <= ''' + txtToDate.Text + '''');

        if cbuser.Text <> '' then
          qrycharge.SQL.Add('AND ch_user = ''' + cbuser.Text + '''');

        qrycharge.SQL.Add('ORDER by ch_Date, ch_user');

        qrycharge.Open;
        Mouse_NoWait;
        Msg_NoWait;
        if qrycharge.RecordCount > 0 then
        begin
          SetUserControl;
          if rdoScreen.Checked then qrptcharge.Preview
          else qrptcharge.Print;
          USERCONTROL := False;
        end
        else
          InformationMessage('گزارش تهی است.');
        qrycharge.Close;
        Free;
    end;
  end;
end;

end.
