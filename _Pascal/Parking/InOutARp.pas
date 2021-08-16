unit InOutARp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, DateProc, MSGs, FarsiApi, Globals,
  Keyboard, RpInOutA, RpI_OAmr, DBS, RunCmnds, DosMove;

type
  TfrmInOutAmarRpt = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    txtFromTime: TEdit;
    txtToTime: TEdit;
    cmdClose: TBitBtn;
    cmdPrint: TBitBtn;
    cmdHelp: TBitBtn;
    cmbIDoor: TComboBox;
    cmbODoor: TComboBox;
    cmbIPerson: TComboBox;
    cmbOPerson: TComboBox;
    grpPrintType: TGroupBox;
    rdoScreen: TRadioButton;
    rdoPrinter: TRadioButton;
    grpType: TGroupBox;
    rdoEnter: TRadioButton;
    rdoExit: TRadioButton;
    rdoEnterExit: TRadioButton;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromTimeKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtFromTimeExit(Sender: TObject);
    procedure txtToTimeExit(Sender: TObject);
  private
    { Private declarations }

    function  AreValidControls : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmInOutAmarRpt.SetWinF;
begin
  Caption := (Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label13.Caption := (Label13.Caption);
  Label14.Caption := (Label14.Caption);
  Label9.Caption := (Label9.Caption);
  Label10.Caption := (Label10.Caption);
  Label8.Caption := (Label8.Caption);
  Label11.Caption := (Label11.Caption);
  grpType.Caption := (grpType.Caption);
  rdoEnter.Caption := (rdoEnter.Caption);
  rdoExit.Caption := (rdoExit.Caption);
  rdoEnterExit.Caption := (rdoEnterExit.Caption);
  grpPrintType.Caption := (grpPrintType.Caption);
  rdoScreen.Caption := (rdoScreen.Caption);
  rdoPrinter.Caption := (rdoPrinter.Caption);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;


function TfrmInOutAmarRpt.AreValidControls : Boolean;
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


procedure TfrmInOutAmarRpt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  SetWinF;
  rdoPrinter.Enabled := g_options.AcesPrint;
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := CurrentDate;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
     connection := frmDBS.adoConnect;
     SQL.Clear;
     SQL.Add('SELECT * FROM Readers');
     Open;
     cmbIDoor.Items.Clear;
     cmbODoor.Items.Clear;
{     while not EOF do
     begin
       case FieldByName('R_Kind').AsInteger of
         MB_IN  : cmbIDoor.Items.Add(FieldByName('R_Name').AsString);
         MB_OUT : cmbODoor.Items.Add(FieldByName('R_Name').AsString);
         MB_INOUT :
         begin
           cmbIDoor.Items.Add(FieldByName('R_Name').AsString);
           cmbODoor.Items.Add(FieldByName('R_Name').AsString);
         end;
       end;
       Next;
     end; }

     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Persons');
     Open;
     cmbIPerson.Items.Clear;
     cmbOPerson.Items.Clear;
     while not EOF do
     begin
       cmbIPerson.Items.Add(FieldByName('P_Name').AsString);
       cmbOPerson.Items.Add(FieldByName('P_Name').AsString);
       Next;
     end;
    Close;
    Free;
  end;
  SetDirectionFarsi(cmbIDoor.Handle);
  SetDirectionFarsi(cmbIPerson.Handle);
  SetDirectionFarsi(cmbODoor.Handle);
  SetDirectionFarsi(cmbOPerson.Handle);
end;

procedure TfrmInOutAmarRpt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmInOutAmarRpt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmInOutAmarRpt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmInOutAmarRpt.txtFromTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmInOutAmarRpt.txtFromTimeExit(Sender: TObject);
begin
  if txtFromTime.Text <> '' then
    txtFromTime.Text := BeautifulTime(txtFromTime.Text);
end;

procedure TfrmInOutAmarRpt.txtToTimeExit(Sender: TObject);
begin
  if txtToTime.Text <> '' then
    txtToTime.Text := BeautifulTime(txtToTime.Text);
end;

procedure TfrmInOutAmarRpt.cmdPrintClick(Sender: TObject);
var
  frmRptI_OAmar : TfrmRptI_OAmar;
  frmRptInOutAmar : TfrmRptInOutAmar;
begin
  if AreValidControls then
  begin
    if g_options.RdrOff_Rpt = MB_TRUE then
      SetUserControl;
    AddRecToMachine;
    if not rdoEnterExit.Checked then
    begin
      Application.CreateForm(TfrmRptI_OAmar, frmRptI_OAmar);
      with frmRptI_OAmar do
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
            if rdoEnter.Checked then
            begin
              IsArive := True;
              lblRptName.Caption := ('ê“«—‘ ¬„«— Ê—Êœ ŒÊœ—ÊÂ«');
              qrptIOAmar.ReportTitle := ('ê“«—‘ ¬„«— Ê—Êœ ŒÊœ—ÊÂ«');
{kaveh 880126              grpDoor.Expression := 'qryMachines.M_IDoor';
              grpPerson.Expression := 'qryMachines.M_IPerson';}
              grpDoor.Expression := 'qryMachines.M_rdrCode'; //kaveh 880126
              grpPerson.Expression := 'qryMachines.M_BarCode';//kaveh 880126
              Add('SELECT M_rdrCode, M_BarCode, R_Name FROM InputCar, Readers');
              Add('WHERE M_rdrCode = R_Code');
              if (txtFromDate.Text <> txtToDate.Text) and
                 (txtFromTime.Text <> txtToTime.Text) then
              begin
                Add('AND (M_IDate > ''' + txtFromDate.Text + ''' ');
                Add('OR (M_IDate = ''' + txtFromDate.Text + ''' ');
                Add('AND M_ITime >= ''' + txtFromTime.Text + ''' )) ');

                Add('AND (M_IDate < ''' + txtToDate.Text + ''' ');
                Add('OR (M_IDate = ''' + txtToDate.Text + ''' ');
                Add('AND M_ITime <= ''' + txtToTime.Text + ''' )) ');
              end
              else
              begin
                if txtFromDate.Text <> '' then
                  Add('AND M_IDate >= ''' + txtFromDate.Text + ''' ');
                if txtFromTime.Text <> '' then
                  Add('AND M_ITime >= ''' + txtFromTime.Text + ''' ');
                if txtToDate.Text <> '' then
                  Add('AND M_IDate <= ''' + txtToDate.Text + ''' ');
                if txtToTime.Text <> '' then
                  Add('AND M_ITime <= ''' + txtToTime.Text + ''' ');
              end;
            end

{          if rdoArival.Checked then
          begin
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              Add(' AND (M_IDate > ''' + txtFromDate.Text + ''' ');
              Add(' OR (M_IDate = ''' + txtFromDate.Text + ''' ');
              Add(' AND M_ITime >= ''' + txtFromTime.Text + ''' )) ');

              Add(' AND (M_IDate < ''' + txtToDate.Text + ''' ');
              Add(' OR (M_IDate = ''' + txtToDate.Text + ''' ');
              Add(' AND M_ITime <= ''' + txtToTime.Text + ''' )) ');
            end  //ok
            else
            begin
              if txtFromDate.Text <> '' then
                Add(' AND M_IDate >= ''' + txtFromDate.Text + ''' ');
              if txtToDate.Text <> '' then
                Add(' AND M_IDate <= ''' + txtToDate.Text + ''' ');
              if txtFromTime.Text <> '' then
                Add(' AND M_ITime >= ''' + txtFromTime.Text + ''' ');
              if txtToTime.Text <> '' then
                Add(' AND M_ITime <= ''' + txtToTime.Text + ''' ');
            end;
          end //ok    }

            else if rdoExit.Checked then
            begin
              IsArive := False;
              lblRptName.Caption := ('ê“«—‘ ¬„«— Œ—ÊÃ ŒÊœ—ÊÂ«');
              qrptIOAmar.ReportTitle := ('ê“«—‘ ¬„«— Œ—ÊÃ ŒÊœ—ÊÂ«');
{kaveh 880126              Add('SELECT M_ODoor, M_OPerson, R_Name FROM Machines, Readers');
              Add('WHERE M_ODoor = R_Code AND M_IsPark = ' + IntToStr(CNST_FALSE));
              grpDoor.Expression := 'qryMachines.M_ODoor';
              grpPerson.Expression := 'qryMachines.M_OPerson';}

              grpDoor.Expression := 'qryMachines.M_rdrCode'; //kaveh 880126
              grpPerson.Expression := 'qryMachines.M_BarCode';//kaveh 880126
              Add('SELECT M_rdrCode, M_BarCode, R_Name FROM Machines, Readers');
              Add('WHERE M_rdrCode = R_Code AND M_IsPark = ' + IntToStr(CNST_FALSE));

              if (txtFromDate.Text <> txtToDate.Text) and
                 (txtFromTime.Text <> txtToTime.Text) then
              begin
                Add('AND (M_ODate > ''' + txtFromDate.Text + ''' ');
                Add('OR (M_ODate = ''' + txtFromDate.Text + ''' ');
                Add('AND M_OTime >= ''' + txtFromTime.Text + ''' )) ');

                Add('AND (M_ODate < ''' + txtToDate.Text + ''' ');
                Add('OR (M_ODate = ''' + txtToDate.Text + ''' ');
                Add('AND M_OTime <= ''' + txtToTime.Text + ''' )) ');
              end
              else
              begin
                if txtFromDate.Text <> '' then
                  Add('AND M_ODate >= ''' + txtFromDate.Text + ''' ');
                if txtFromTime.Text <> '' then
                  Add('AND M_OTime >= ''' + txtFromTime.Text + ''' ');
                if txtToDate.Text <> '' then
                  Add('AND M_ODate <= ''' + txtToDate.Text + ''' ');
                if txtToTime.Text <> '' then
                  Add('AND M_OTime <= ''' + txtToTime.Text + ''' ');
              end;
            end;

            if cmbIDoor.Text <> '' then
              Add('AND M_IDoor = ' + IntToStr(GetDoorCode(cmbIDoor.Text)));
            if cmbIPerson.Text <> '' then
              Add('AND M_IPerson = ''' + GetPersonCode(cmbIPerson.Text) + '''');

            if cmbODoor.Text <> '' then
              Add('AND M_ODoor = ' + IntToStr(GetDoorCode(cmbODoor.Text)));
            if cmbOPerson.Text <> '' then
              Add('AND M_OPerson = ''' + GetPersonCode(cmbOPerson.Text) + '''');

            if rdoEnter.Checked then
              Add('ORDER BY M_IDoor, M_IPerson')
            else
              Add('ORDER BY M_ODoor, M_OPerson');
          end;
          Open;
          if RecordCount > 0 then
          begin
            if rdoScreen.Checked then
              qrptIOAmar.Preview
            else
              qrptIOAmar.Print;
          end
          else
          begin
            if rdoEnter.Checked then
              InformationMessage('ÂÌç Ê—ÊœÌ ÊÃÊœ ‰œ«—œ.')
            else
              InformationMessage('Â‰Ê“ ŒÊœ—ÊÌÌ Œ«—Ã ‰‘œÂ «” .');
          end;
          Close;
        end;
        Free;
      end;
    end
    else
    begin
      Application.CreateForm(TfrmRptInOutAmar, frmRptInOutAmar);
      with frmRptInOutAmar do
      begin
        if (txtFromDate.Text <> '') and (txtToDate.Text <> '') then
          lblFromToDate.Caption := ('«“  «—ÌŒ: ' )+ txtFromDate.Text + ('     «  «—ÌŒ: ' )+ txtToDate.Text
        else if txtFromDate.Text <> '' then
          lblFromToDate.Caption := ('«“  «—ÌŒ: ') + txtFromDate.Text
        else if txtToDate.Text <> '' then
          lblFromToDate.Caption := (' «  «—ÌŒ: ') + txtToDate.Text
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
            Add('SELECT M_IsPark FROM Machines');
            Add('WHERE (M_IsPark = ' + IntToStr(CNST_TRUE) + ' OR M_IsPark = ' + IntToStr(CNST_FALSE) + ' )');
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              Add('AND (M_IDate > ''' + txtFromDate.Text + '''');
              Add('OR (M_IDate = ''' + txtFromDate.Text + '''');
              Add('AND M_ITime >= ''' + txtFromTime.Text + '''))');
              Add('AND (M_IDate < ''' + txtToDate.Text + '''');
              Add('OR (M_IDate = ''' + txtToDate.Text + '''');
              Add('AND M_ITime <= ''' + txtToTime.Text + '''))');

              Add('AND (M_ODate < ''' + txtToDate.Text + '''');
              Add('OR (M_ODate = ''' + txtToDate.Text + '''');
              Add('AND M_OTime <= ''' + txtToTime.Text + '''))');
            end
            else
            begin
              if txtFromDate.Text <> '' then
                Add('AND M_IDate >= ''' + txtFromDate.Text + '''');
              if txtFromTime.Text <> '' then
                Add('AND M_ITime >= ''' + txtFromTime.Text + '''');
              if txtToDate.Text <> '' then
                Add('AND M_ODate <= ''' + txtToDate.Text + '''');
              if txtToTime.Text <> '' then
                Add('AND M_OTime <= ''' + txtToTime.Text + '''');
            end;

            if cmbIDoor.Text <> '' then
              Add('AND M_IDoor = ' + IntToStr(GetDoorCode(cmbIDoor.Text)));
            if cmbIPerson.Text <> '' then
              Add('AND M_IPerson = ''' + GetPersonCode(cmbIPerson.Text) + '''');

            if cmbODoor.Text <> '' then
              Add('AND M_ODoor = ' + IntToStr(GetDoorCode(cmbODoor.Text)));
            if cmbOPerson.Text <> '' then
              Add('AND M_OPerson = ''' + GetPersonCode(cmbOPerson.Text) + '''');

            Add('ORDER BY M_IsPark');
          end;
          Open;
          if RecordCount > 0 then
          begin
            if rdoScreen.Checked then
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
    end;
    DelRecFromMachine;
    if g_options.RdrOff_Rpt = MB_TRUE then
      UserControl := False;
  end;
end;


end.
