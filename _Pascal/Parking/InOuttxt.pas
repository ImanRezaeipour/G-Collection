unit InOuttxt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, DateProc, MSGs, FarsiApi, Globals,
  Keyboard, RpInOut, DBS, RunCmnds, ExtCtrls, DosMove;

type
  TfrmInOuttxt = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtFromDate: TEdit;
    txtToDate: TEdit;
    txtNumber: TEdit;
    txtSerial: TEdit;
    cmbCarName: TComboBox;
    cmbCity: TComboBox;
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
    grpType: TGroupBox;
    rdoBoth: TRadioButton;
    rdoArival: TRadioButton;
    rdoExit: TRadioButton;
    DosMove1: TDosMove;
    rdoSort: TRadioGroup;
    label12: TLabel;
    txtfilename: TEdit;
    qryMachines: TAdoQuery;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure txtFromDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarNameEnter(Sender: TObject);
    procedure cmbCarNameKeyPress(Sender: TObject; var Key: Char);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtFromDateExit(Sender: TObject);
    procedure txtToDateExit(Sender: TObject);
    procedure txtFromTimeExit(Sender: TObject);
    procedure txtToTimeExit(Sender: TObject);
  private
    { Private declarations }
    SrchStr : String;
    
    function AreValidControls : Boolean;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

uses
  Printers, QuickRpt;

{$R *.DFM}

procedure TfrmInOuttxt.SetWinF;
var
  i : Byte;
begin
  Caption := (Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label5.Caption := (Label5.Caption);
  Label6.Caption := (Label6.Caption);
  Label7.Caption := (Label7.Caption);
  Label8.Caption := (Label8.Caption);
  Label9.Caption := (Label9.Caption);
  Label10.Caption := (Label10.Caption);
  Label11.Caption := (Label11.Caption);
  Label12.Caption := (Label12.Caption);
  Label13.Caption := (Label13.Caption);
  Label14.Caption := (Label14.Caption);
  grpType.Caption := (grpType.Caption);
  rdoBoth.Caption := (rdoBoth.Caption);
  rdoArival.Caption := (rdoArival.Caption);
  rdoExit.Caption := (rdoExit.Caption);
  rdoSort.Caption := (rdoSort.Caption);
  for i := 0 to rdoSort.Items.Count - 1 do
    rdoSort.Items.Strings[i] := (rdoSort.Items.Strings[i]);
  cmdPrint.Caption := (cmdPrint.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

function TfrmInOuttxt.AreValidControls : Boolean;
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
  else if (txtfilename.Text = '') then
  begin
    ErrorMessage('‰«„ ›«Ì· Ê«—œ ‰‘œÂ «” ');
    AreValidControls := False;
    txtfilename.SetFocus;
  end
  else
    AreValidControls := True;
end;


procedure TfrmInOuttxt.FormCreate(Sender: TObject);
var qry : TAdoQuery;
begin
  InitVariables;
  SetWinF;
  txtFromDate.Text := CurrentDate;
  txtToDate.Text := CurrentDate;
  qry := TAdoQuery.Create(Application);
  with qry do
  begin
     connection := frmDBS.adoConnect;
     SQL.Clear;
     SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
     Open;
     cmbCity.Items.Clear;
     while not EOF do
     begin
       cmbCity.Items.Add(FieldByName('City_Name').AsString);
       Next;
     end;

     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Cars ORDER BY Car_Code');
     Open;
     cmbCarName.Items.Clear;
     while not EOF do
     begin
       cmbCarName.Items.Add(FieldByName('Car_Name').AsString);
       Next;
     end;

     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Readers');
     Open;
     cmbIDoor.Items.Clear;
     cmbODoor.Items.Clear;
     while not EOF do
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
     end;

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
  SetDirectionFarsi(cmbCarName.Handle);
  SetDirectionFarsi(txtNumber.Handle);
  SetDirectionFarsi(cmbCity.Handle);
  SetDirectionFarsi(cmbIDoor.Handle);
  SetDirectionFarsi(cmbIPerson.Handle);
  SetDirectionFarsi(cmbODoor.Handle);
  SetDirectionFarsi(cmbOPerson.Handle);
  SetDirectionEnglish(txtfilename.Handle);
end;

procedure TfrmInOuttxt.txtFromDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmInOuttxt.txtFromDateExit(Sender: TObject);
begin
  if txtFromDate.Text <> '' then
    txtFromDate.Text := BeautifulDate(txtFromDate.Text);
end;

procedure TfrmInOuttxt.txtToDateExit(Sender: TObject);
begin
  if txtToDate.Text <> '' then
    txtToDate.Text := BeautifulDate(txtToDate.Text);
end;

procedure TfrmInOuttxt.txtFromTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Time(Key);
end;

procedure TfrmInOuttxt.txtFromTimeExit(Sender: TObject);
begin
  if txtFromTime.Text <> '' then
    txtFromTime.Text := BeautifulTime(txtFromTime.Text);
end;

procedure TfrmInOuttxt.txtToTimeExit(Sender: TObject);
begin
  if txtToTime.Text <> '' then
    txtToTime.Text := BeautifulTime(txtToTime.Text);
end;

procedure TfrmInOuttxt.cmbCarNameEnter(Sender: TObject);
begin
  SrchStr := '';
end;

procedure TfrmInOuttxt.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmInOuttxt.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);
  Key := #0;
end;

procedure TfrmInOuttxt.cmbCityKeyPress(Sender: TObject; var Key: Char);
begin
  SrchNearst(SrchStr, cmbCity, Key);
end;

procedure TfrmInOuttxt.cmdPrintClick(Sender: TObject);
var
  f:textfile;
  mcolor,mnumber,mcity,mname:string;
begin
  if AreValidControls then
  begin
      if (txttodate.Text<>'')and(txttodate.Text[4]>'3')
      or (currentdate[4]>'3')
      then begin
           close;
           exit;
      end;
      if g_options.RdrOff_Rpt = MB_TRUE then
      SetUserControl;
      AddRecToMachine;
      with qryMachines do
      begin
        Close;
        with SQL do
        begin
          Clear;
          if rdoArival.Checked then
            Add('SELECT * FROM InputCar')
          else
            Add('SELECT * FROM Machines');

          if rdoArival.Checked then
            Add('WHERE M_IsPark = ' + IntToStr(CNST_TRUE))
          else if rdoExit.Checked then
            Add('WHERE M_IsPark = False')
          else
            Add('WHERE (M_IsPark = False OR M_IsPark = ' + IntToStr(CNST_TRUE) + ' )');

          if rdoArival.Checked then
          begin
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
          end
          else if rdoExit.Checked then
          begin
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              Add('AND (M_ODate > ''' + txtFromDate.Text + '''');
              Add('OR (M_ODate = ''' + txtFromDate.Text + '''');
              Add('AND M_OTime >= ''' + txtFromTime.Text + '''))');

              Add('AND (M_ODate < ''' + txtToDate.Text + '''');
              Add('OR (M_ODate = ''' + txtToDate.Text + '''');
              Add('AND M_OTime <= ''' + txtToTime.Text + '''))');
            end
            else
            begin
              if txtFromDate.Text <> '' then
                Add('AND M_ODate >= ''' + txtFromDate.Text + '''');
              if txtFromTime.Text <> '' then
                Add('AND M_OTime >= ''' + txtFromTime.Text + '''');
              if txtToDate.Text <> '' then
                Add('AND M_ODate <= ''' + txtToDate.Text + '''');
              if txtToTime.Text <> '' then
                Add('AND M_OTime <= ''' + txtToTime.Text + '''');
            end;
          end
          else
          begin
            if (txtFromDate.Text <> txtToDate.Text) and
               (txtFromTime.Text <> txtToTime.Text) then
            begin
              Add('AND (M_IDate > ''' + txtFromDate.Text + '''');
              Add('OR (M_IDate = ''' + txtFromDate.Text + '''');
              Add('AND M_ITime >= ''' + txtFromTime.Text + '''))');

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
          end;

          if cmbCarName.Text <> '' then
            Add('AND M_CarName = ''' + cmbCarName.Text + '''');

          if txtNumber.Text <> '' then
            Add('AND M_Number = ''' + txtNumber.Text + '''');

          if cmbCity.Text <> '' then
            Add('AND M_CityName = ''' + cmbCity.Text + '''');

          if txtSerial.Text <> '' then
            Add('AND M_Serial = ''' + txtSerial.Text + '''');

          if cmbIDoor.Text <> '' then
            Add('AND M_IDoor = ' + IntToStr(GetDoorCode(cmbIDoor.Text)));
          if cmbIPerson.Text <> '' then
            Add('AND M_IPerson = ''' + GetPersonCode(cmbIPerson.Text) + '''');

          if cmbODoor.Text <> '' then
            Add('AND M_ODoor = ' + IntToStr(GetDoorCode(cmbODoor.Text)));
          if cmbOPerson.Text <> '' then
            Add('AND M_OPerson = ''' + GetPersonCode(cmbOPerson.Text) + '''');

          case rdoSort.ItemIndex of
            0: Add('ORDER BY M_IDate, M_ITime, M_IDoor, M_BarCode');
            1: Add('ORDER BY M_ODate, M_OTime, M_ODoor, M_BarCode');
            2: Add('ORDER BY M_BarCode, M_IDate, M_ITime');
            3: Add('ORDER BY M_Number, M_IDate, M_ITime');
            4: Add('ORDER BY M_CarName, M_IDate, M_ITime');
          end;

        end;
        Open;
        assignfile(f,txtfilename.text);
        rewrite(f);
        while not eof do
        begin
           mnumber:=Fieldbyname('M_Number').AsString;
           mcity:=Fieldbyname('M_CityName').AsString;
           mname:=Fieldbyname('M_CarName').AsString;
           mcolor:=Fieldbyname('M_Color').AsString;
           if (mname<>'') and (mnumber<>'') and (mcolor<>'') and (mcity<>'')
           then begin
             write(f,Fieldbyname('M_BarCode').AsString,'|');
             write(f,Fieldbyname('M_CarName').AsString,'|');
             write(f,Fieldbyname('M_Number').AsString,'|');
             write(f,Fieldbyname('M_CityName').AsString,'-');
             write(f,Fieldbyname('M_Serial').AsString,'|');
             write(f,Fieldbyname('M_Color').AsString,'|');
             write(f,Fieldbyname('M_IDate').AsString,'|');
             write(f,Fieldbyname('M_ITime').AsString,'|');
             write(f,getdoorname(Fieldbyname('M_IDoor').Asinteger),'|');
             write(f,Fieldbyname('M_IPerson').AsString,'|');
             write(f,Fieldbyname('M_ODate').AsString,'|');
             write(f,Fieldbyname('M_OTime').AsString,'|');
             write(f,getdoorname(Fieldbyname('M_ODoor').Asinteger),'|');
             write(f,Fieldbyname('M_OPerson').AsString,'|');
             writeln(f);
           end;
           next;
        end;
        closefile(f);
        Close;
      end;
      DelRecFromMachine;
      {if g_options.RdrOff_Rpt = MB_TRUE then
        UserControl := False;}
  end;
  close;
end;



end.
