unit ReadText;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Globals, RunCmnds, DB, DBTables, DosMove;

type
  TfrmReadText = class(TForm)
    lbl1: TLabel;
    txtInput: TEdit;
    cmdSelFile: TButton;
    lbl2: TLabel;
    cmbInputType: TComboBox;
    rdoSave: TRadioGroup;
    lblCount: TLabel;
    cmdRecovery: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    opnFile: TOpenDialog;
    lblErrCount: TLabel;
    Table1: TTable;
    DosMove1: TDosMove;
    cmdStop: TBitBtn;
    procedure cmdStopClick(Sender: TObject);
    procedure cmdRecoveryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdSelFileClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
    procedure AnalizData(recType : Byte; s : string; var ClkRec : TTerminalRec; var ErrData : Boolean);
  public
    doCancel : boolean;
    { Public declarations }
  end;

implementation

uses
  MSGs, DBS, TimeTool,DateProc, Funcs, ADODB;

{$R *.DFM}

procedure TfrmReadText.SetWinF;
begin
end;

procedure TfrmReadText.AnalizData(recType : Byte; s : string; var ClkRec : TTerminalRec; var ErrData : Boolean);
begin
  ClkRec.rdrCardCode := '';
  ClkRec.rdrDate := '';
  ClkRec.rdrTime := 0;
  ClkRec.rdrStatus := 0;
  ClkRec.rdrCode := 0;
  ClkRec.rdrChng := 0;

  ErrData := False;
  case recType of
    0:
    begin
      if Length(s) = 27 then
      begin
        ClkRec.rdrCardCode := Copy(s, 1, 8);
        ClkRec.rdrDate := Copy(s, 9, 10);
        ClkRec.rdrTime := TimeToInt(Copy(s, 19, 5));
        ClkRec.rdrStatus := StrToInt(Copy(s, 24, 2));
        ClkRec.rdrCode := StrToInt(Copy(s, 26, 2));
      end
      else
        ErrData := True;
    end;
    1:
    begin
      if Length(s) = 22 then
      begin
        ClkRec.rdrCardCode := Copy(s, 1, 8);
        ClkRec.rdrDate := BeautifulDate(Copy(s, 09, 2) + '/' +
                                         Copy(s, 11, 2) + '/' +
                                         Copy(s, 13, 2));
        ClkRec.rdrTime := TimeToInt(Copy(s, 15, 2) + ':' +
                                     Copy(s, 17, 4));
        ClkRec.rdrStatus := StrToInt(Copy(s, 19, 2));
        ClkRec.rdrCode := StrToInt(Copy(s, 21, 2));
      end
      else
        ErrData := True;
    end;
    2:
    begin
      if Length(s) = 50 then
      begin
        ClkRec.rdrCardCode := Copy(s, 43, 8);
        if IsNumeric(Copy(s, 7, 6)) then
          ClkRec.rdrDate := BeautifulDate(Copy(s, 07, 2) + '/' +
                                           Copy(s, 09, 2) + '/' +
                                           Copy(s, 11, 2))
        else
          ErrData := True;

        if ISNumeric(Copy(s, 14, 4)) then
          ClkRec.rdrTime := TimeToInt(Copy(s, 14, 2) + ':' +
                                       Copy(s, 16, 4))
        else
          ErrData := True;
        if IsNumeric(Copy(s, 4, 2)) then
          ClkRec.rdrStatus := StrToInt(Copy(s, 4, 2))
        else
          ErrData := True;
        if IsNumeric(Copy(s, 1, 2)) then
          ClkRec.rdrCode := StrToInt(Copy(s, 1, 2))
        else
          ErrData := True;
      end
      else
        ErrData := True;
    end;
    7:
    begin
      if Length(s) = 58 then
      begin
        ClkRec.rdrCardCode := Copy(s, 1, 8);
        if IsNumeric(Copy(s, 9, 8)) then
          ClkRec.rdrDate := BeautifulDate(Copy(s, 9, 4) + '/' +
                                           Copy(s, 13, 2) + '/' +
                                           Copy(s, 15, 2))
        else
          ErrData := True;

        if ISNumeric(Copy(s, 17, 4)) then
          ClkRec.rdrTime := TimeToInt(Copy(s, 17, 2) + ':' +
                                       Copy(s, 19, 2))
        else
          ErrData := True;
        if IsNumeric(Copy(s, 21, 3)) then
          ClkRec.rdrCode := StrToInt(Copy(s, 21, 3))
        else
          ErrData := True;
        if IsNumeric(Copy(s, 24, 2)) then
          ClkRec.rdrStatus := StrToInt(Copy(s, 24, 2))
        else
          ErrData := True;
        if IsNumeric(Copy(s, 26, 1)) then
          ClkRec.rdrChng := StrToInt(Copy(s, 26, 1))
        else
          ErrData := True;
        if IsNumeric(Copy(s, 27, 8)) then
          ClkRec.rdrBDate := BeautifulDate(Copy(s, 27, 4) + '/' +
                                           Copy(s, 31, 2) + '/' +
                                           Copy(s, 33, 2))
        else
          ErrData := True;
        if ISNumeric(Copy(s, 35, 4)) then
          ClkRec.rdrBTime := TimeToInt(Copy(s, 35, 2) + ':' +
                                       Copy(s, 37, 2))
        else
          ErrData := True;
        if IsNumeric(Copy(s, 39, 3)) then
          ClkRec.rdrBRdrCode := StrToInt(Copy(s, 39, 3))
        else
          ErrData := True;
        if IsNumeric(Copy(s, 42, 2)) then
          ClkRec.rdrBStatus := StrToInt(Copy(s, 42, 2))
        else
          ErrData := True;
        ClkRec.rdrUser := Copy(s, 44, 15);
      end
      else
        ErrData := True;
    end;
    8 : // import sohasan text file
    begin
      if Length(s) = 27 then
      begin
        ClkRec.rdrCardCode := Copy(s, 1, 6);
        ClkRec.rdrDate := Copy(s, 9, 8);
        ClkRec.rdrTime := TimeToInt(Copy(s, 19, 5));
//      ClkRec.rdrStatus := StrToInt(Copy(s, 24, 2));
        ClkRec.rdrCode := StrToInt(Copy(s, 32, 1));
      end
      else
        ErrData := True;
    end;
  end;
  if not IsTrueDate(ClkRec.rdrDate) or
     not IsTrueTime(IntToTime(ClkRec.rdrTime)) then
    ErrData := True;
end;


procedure TfrmReadText.FormCreate(Sender: TObject);
begin
  SetWinF;
  opnFile.InitialDir := g_options.DataBasePath;
  cmbInputType.ItemIndex := 0;
end;

procedure TfrmReadText.cmdSelFileClick(Sender: TObject);
begin
  case cmbInputType.ItemIndex of
    0..2,6,7 : opnFile.Filter := 'Text Files|*.TXT|All Files|*.*';
    3        : opnFile.Filter := 'DBF Files|*.DBF|All Files|*.*';
    4        : opnFile.Filter := 'DBF Files|*.DBF|All Files|*.*';
    5:    opnFile.Filter := 'DB Files|*.DB|All Files|*.*';
  end;

  if opnFile.Execute then
    txtInput.Text := opnFile.FileName;
end;

procedure TfrmReadText.cmdStopClick(Sender: TObject);
begin
  doCancel := true;
end;

function PWtoDPtype(Code:integer):integer;
begin
   result:=0;
   case code of
        54:result:=61;
        55:result:=62;
        56:result:=63;
        57:result:=41;
        59:result:=31;
        60:result:=42;
        61:result:=43;
        62:result:=32;
        63:result:=33;
        65:result:=45;
   end;
end;

procedure TfrmReadText.cmdRecoveryClick(Sender: TObject);
var
  tbl : TTable;
  f : TextFile;
  s, e, sDate, eDate, t : String;
  l, errL : Integer;
  RecTest : Byte;
  ErrData : Boolean;
  ClkRec : TTerminalRec;
  p : TPerson;
  TEMP:INTEGER;
begin
  doCancel := false;
  cmdStop.Enabled := true;
  if IsDemo then
    InformationMessage('»—‰«„Â ‰”ŒÂ ‰„«Ì‘Ì «”  Ê «„ﬂ«‰ »«“ŒÊ«‰Ì «ÿ·«⁄«  ÊÃÊœ ‰œ«—œ.')
  else if txtInput.Text = '' then
  begin
    ErrorMessage('›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
    txtInput.SetFocus;
  end
  else if not FileExists(txtInput.Text) then
  begin
    ErrorMessage('›«Ì· Ê—ÊœÌ ÊÃÊœ ‰œ«—œ.');
    txtInput.SetFocus;
  end
  else if cmbInputType.ItemIndex = -1 then
  begin
    ErrorMessage('›—„  ›«Ì· Ê—ÊœÌ „‘Œ’ ‰Ì” .');
    cmbInputType.SetFocus;
  end
  else
  begin
    lblCount.Caption := '0';
    lblCount.Visible := True;
    lblErrCount.Caption := '0';
    lblErrCount.Visible := True;
    l := 0;
    errL := 0;

    case rdoSave.ItemIndex of
      0: RecTest := REC_ADD;
      1: RecTest := REC_TEST;
      else RecTest := REC_EDIT;
    end;

    if cmbInputType.ItemIndex in[0..2,7..8] then
    begin
      AssignFile(f, txtInput.Text);
      ReSet(f);
      Mouse_Wait;
      while not (Eof(f) or doCancel) do
      begin
        ReadLn(f, s);
        AnalizData(cmbInputType.ItemIndex, s, ClkRec, ErrData);
        p := GetPerson(ClkRec.rdrCardCode, True);
        if p.P_Code <> '' then
          ClkRec.rdrCardCode := p.P_Code;
        if ErrData then
          Inc(errL)
        else if SaveClockRecord(ClkRec, RecTest, ErrData) then
          Inc(l);

        lblCount.Caption := ('’ÕÌÕ: ') + IntToStr(l);
        lblErrCount.Caption := ('Œÿ«: ') + IntToStr(errl);
        lblCount.Refresh;
        lblErrCount.Refresh;
        Application.ProcessMessages;
      end;
      CloseFile(f);
      //lblCount.Visible := False;
      Mouse_NoWait;
    end
    else if cmbInputType.ItemIndex = 3 then
    begin
      tbl := TTable.Create(Application);
      tbl.DatabaseName := ExtractFilePath(txtInput.Text);
//      tbl.SessionName := ActiveNet;
      tbl.TableName := ExtractFileName(txtInput.Text);
      tbl.Filter := 'date >= 790101 and date <= 991231';
      tbl.Filtered := true;
      tbl.Open;
      if (tbl.FindField('Date') = nil) or
         (tbl.FindField('emp_no'{'Card'}) = nil) or
         (tbl.FindField('Time') = nil) then
        ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì «‰ Œ«» ‘œÂ ‰«œ—”  «” .')
      else
      begin
        Mouse_Wait;
        while not (tbl.Eof or doCancel) do
        begin
          ClkRec.rdrCardCode := FixLeft(tbl.FieldByName('emp_no'{'Card'}).AsString, '0', 8);
          s := tbl.FieldByName('Date').AsString;
          Insert('/', s, 5);
          Insert('/', s, 3);
          ClkRec.rdrDate := BeautifulDate(s);
          temp:=tbl.FieldByName('Time').AsInteger;
          temp:=(temp div 100) * 60 + (temp mod 100);
          ClkRec.rdrTime := temp;
          if tbl.FieldByName('Modify').Asboolean then
            ClkRec.rdrChng := 1
          else
            ClkRec.rdrChng := 0;
          ClkRec.rdrCode := 0;
          ClkRec.rdrStatus := 0;
          p := GetPerson(ClkRec.rdrCardCode, True);
          if p.P_Code <> '' then
            ClkRec.rdrCardCode := p.P_Code;
          if SaveClockRecord(ClkRec, RecTest, ErrData) then
            Inc(l)
          else
            Inc(errL);
          lblCount.Caption := ('’ÕÌÕ: ') + IntToStr(l);
          lblErrCount.Caption := ('Œÿ«: ') + IntToStr(errL);
          lblCount.Refresh;
          lblErrCount.Refresh;
          tbl.Next;
          Application.ProcessMessages;
        end;
        Mouse_NoWait;
      end;
      tbl.Close;
      tbl.Free;
    end
    else if cmbInputType.ItemIndex = 4 then
    begin
      tbl := TTable.Create(Application);
      tbl.DatabaseName := ExtractFilePath(txtInput.Text);
//      tbl.SessionName := ActiveNet;
      tbl.TableName := ExtractFileName(txtInput.Text);   //mashkoook
      tbl.Open;
      if (tbl.FindField('Emp_no') = nil) or
         (tbl.FindField('S_Date') = nil) or
         (tbl.FindField('E_Date') = nil) or
         (tbl.FindField('Typ') = nil) then
        ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì «‰ Œ«» ‘œÂ ‰«œ—”  «” .')
      else
      begin
        Mouse_Wait;
        while not (tbl.Eof or doCancel) do
        begin
          s := tbl.FieldByName('S_Date').AsString;
          Insert('/', s, 5);
          Insert('/', s, 3);
          s:=BeautifulDate(s);
          e := tbl.FieldByName('E_Date').AsString;
          if (e='') or (e='0')
          then e:=s
          else begin
               Insert('/', e, 5);
               Insert('/', e, 3);
               e:=BeautifulDate(e);
          end;
          while s<=e do
          begin
            ClkRec.rdrCardCode := FixLeft(tbl.FieldByName('Emp_No').AsString, '0', 8);
            ClkRec.rdrDate := s;
            ClkRec.rdrTime := 720;
            ClkRec.rdrCode := 0;
            ClkRec.rdrChng:=2;
            ClkRec.rdrStatus := PWtoDPtype(tbl.FieldByName('Typ').Asinteger);
            p := GetPerson(ClkRec.rdrCardCode, True);
            if p.P_Code <> '' then
              ClkRec.rdrCardCode := p.P_Code;
            if SaveClockRecord(ClkRec, RecTest, ErrData) then
              Inc(l)
            else
              Inc(errL);
            lblCount.Caption := ('’ÕÌÕ: ') + IntToStr(l);
            lblErrCount.Caption := ('Œÿ«: ') + IntToStr(errL);
            lblCount.Refresh;
            lblErrCount.Refresh;
            s:=adddate(s,1);
          end;
          tbl.Next;
          Application.ProcessMessages;
        end;
        Mouse_NoWait;
      end;
      tbl.Close;
      tbl.Free;
    end
    else if cmbInputType.ItemIndex = 5 then
    begin
      tbl := TTable.Create(Application);
      tbl.DatabaseName := ExtractFilePath(txtInput.Text);
//      tbl.SessionName := ActiveNet;
      tbl.TableName := ExtractFileName(txtInput.Text);  //mashkoook
      tbl.Open;
      if (tbl.FindField('Clock_BarCode') = nil) or
         (tbl.FindField('Clock_Date') = nil) or
         (tbl.FindField('Clock_Time') = nil) or
         (tbl.FindField('Clock_RdrCode') = nil) or
         (tbl.FindField('Clock_RecState') = nil) then
        ErrorMessage('»«‰ﬂ «ÿ·«⁄« Ì «‰ Œ«» ‘œÂ ‰«œ—”  «” .')
      else
      begin
        Mouse_Wait;
        while not (tbl.Eof or doCancel) do
        begin
          ClkRec.rdrCardCode := FixLeft(tbl.FieldByName('Clock_BarCode').AsString, '0', 8);
          ClkRec.rdrDate := tbl.FieldByName('Clock_Date').AsString;
          ClkRec.rdrTime := tbl.FieldByName('Clock_Time').AsInteger;
          ClkRec.rdrCode := tbl.FieldByName('Clock_RdrCode').AsInteger;
          ClkRec.rdrStatus := tbl.FieldByName('Clock_RecState').AsInteger;
          if ClkRec.rdrStatus in [31..35, 41..45, 61..65, 71..75] then
            ClkRec.rdrChng := 2
          else if tbl.FindField('Clock_Chng') <> nil then
            ClkRec.rdrChng := tbl.FieldByName('Clock_Chng').AsInteger
          else
            ClkRec.rdrChng := 0;

          p := GetPerson(ClkRec.rdrCardCode, True);
          if p.P_Code <> '' then
            ClkRec.rdrCardCode := p.P_Code;
          if SaveClockRecord(ClkRec, RecTest, ErrData) then
            Inc(l)
          else
            Inc(errL);
          lblCount.Caption := ('’ÕÌÕ: ') + IntToStr(l);
          lblErrCount.Caption := ('Œÿ«: ') + IntToStr(errl);
          lblCount.Refresh;
          lblErrCount.Refresh;
          tbl.Next;
          Application.ProcessMessages;
        end;
        Mouse_NoWait;
      end;
      tbl.Close;
      tbl.Free;
    end
  end;
  cmdStop.Enabled := False;
end;


end.
