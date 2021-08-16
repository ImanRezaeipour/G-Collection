unit Select;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, ADODb, DBTables, CheckLst;

type
  TfrmSelect = class(TForm)
    GroupBox1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cmbFromNo: TComboBox;
    cmbFromName: TComboBox;
    cmbToNo: TComboBox;
    cmbToName: TComboBox;
    cmdSelect: TBitBtn;
    cmdDelete: TBitBtn;
    cmdDeleteAll: TBitBtn;
    cmdOK: TBitBtn;
    cmdHelp: TBitBtn;
    cmdCancel: TBitBtn;
    chkListData: TCheckListBox;
    cmdSelectAll: TBitBtn;
    lstCodeNameSelected: TListBox;
    procedure cmbFromNoExit(Sender: TObject);
    procedure cmdSelectClick(Sender: TObject);
    procedure cmdDeleteAllClick(Sender: TObject);
    procedure cmdSelectAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbFromNoClick(Sender: TObject);
    procedure cmbFromNameClick(Sender: TObject);
    procedure cmbFromNameExit(Sender: TObject);
    procedure cmbToNoClick(Sender: TObject);
    procedure cmbToNoExit(Sender: TObject);
    procedure cmbToNameClick(Sender: TObject);
    procedure cmbToNameExit(Sender: TObject);
    procedure chkListPrsClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    oldSelType : Byte;
    procedure ReadDBS;
  public
    { Public declarations }
    selType : Byte;
    dataSelected : String;

  end;

var
  frmSelect: TfrmSelect;

const
  SEL_SRVC  = 10;
  SEL_RDR   = 11;
  SEL_PRS   = 12;
  SEL_DEPRT = 13;
  SEL_DORE  = 14;
  SEL_khed   =15;


implementation

uses
  MSGs, DBS, Funcs, FntSel, Globals;


{$R *.DFM}
procedure TfrmSelect.ReadDBS;
var
  qry : TAdoQuery;
  code : String;
begin
  if (oldSelType <> selType) and (selType in [SEL_SRVC..SEL_DEPRT,sel_dore,sel_khed]) then
  begin

    oldSelType := selType;
    cmbFromNo.Clear;
    cmbToNo.Clear;
    cmbFromName.Clear;
    cmbToName.Clear;
    chkListData.Clear;
    lstCodeNameSelected.Clear;

    qry := TAdoQuery.Create(Application);
    with qry do
    begin
      Connection := frmDBS.adoConnect;

      SQL.Clear;
      case selType of
        SEL_SRVC:
        begin
          Caption := ('انتخاب خدمات');
          SQL.Add('SELECT S_Code AS fld1, S_Name AS fld2 FROM Services');
        end;
        SEL_RDR:
        begin
          Caption := ('انتخاب كارتخوانها');
          SQL.Add('SELECT Rdr_Code AS fld1, Rdr_Name AS fld2 FROM Readers');
        end;
        SEL_PRS:
        begin
          Caption := ('انتخاب پرسنل');
          SQL.Add('SELECT Empl_No AS fld1, (Empl_Family + ''-'' + Empl_Name) AS fld2 FROM Employee');
          if gOptions.UserDepart <> 0 then
            SQL.Add('WHERE Empl_Department = ' + IntToStr(gOptions.UserDepart));
        end;
        SEL_DEPRT:
        begin
          Caption := ('انتخاب مركز');
          SQL.Add('SELECT Depart_Code AS fld1, Depart_Name AS fld2 FROM Department');
          if gOptions.UserDepart <> 0 then
            SQL.Add('WHERE Depart_Code = ' + IntToStr(gOptions.UserDepart));
        end;
         SEL_DORE :
        begin
          Caption := ('انتخاب دوره');
          SQL.Add('SELECT   GrpCode AS fld1, ''تاریخ:''+GrpDate AS fld2 FROM ChargeGrp');
          if gOptions.UserDepart <> 0 then
            SQL.Add('WHERE GrpCode = ' + IntToStr(gOptions.UserDepart));
        end;
          SEL_khed :
        begin
          Caption := ('انتخاب محل خدمت');
          SQL.Add('SELECT   Part_Code AS fld1, ''نام:''+Part_Name AS fld2 FROM parts');
          if gOptions.UserDepart <> 0 then
            SQL.Add('WHERE Part_Code = ' + IntToStr(gOptions.UserDepart));

        end;
      end;
      //SQL.Add('ORDER BY fld1');
      Open;
      while not Eof do
      begin
        code := FieldByName('fld1').AsString;
        cmbFromNo.Items.Add(code);
        cmbFromName.Items.Add(FieldByName('fld2').AsString);

        chkListData.Items.Add(code + '-' + FieldByName('fld2').AsString);
        Next;
      end;
      cmbToNo.Items := cmbFromNo.Items;
      cmbToName.Items := cmbFromName.Items;

      cmbFromNo.ItemIndex := -1;
      cmbFromName.ItemIndex := -1;
      cmbToNo.ItemIndex := -1;
      cmbToName.ItemIndex := -1;

      Close;
      Free;
    end;
  end;

END;
procedure TfrmSelect.FormCreate(Sender: TObject);
begin
  dataSelected := '';
end;

procedure TfrmSelect.cmdSelectClick(Sender: TObject);
var
  sLoop, eLoop : Integer;
begin
  sLoop := cmbFromNo.ItemIndex;
  eLoop := cmbToNo.ItemIndex;
  if (sLoop <> -1) then
  begin
    if eLoop = -1 then
      eLoop := sLoop
    else if eLoop < sLoop then
    begin
      ErrorMessage('کد انتها كمتر از ابتدا مي‌باشد.');
      Exit;
    end;

    Mouse_Wait;
    while sLoop <= eLoop do
    begin
      if not chkListData.Checked[sLoop] then
      begin
        chkListData.Checked[sLoop] := True;
        lstCodeNameSelected.Items.Add(chkListData.Items.Strings[sLoop]);
      end;
      Inc(sLoop);
    end;
    Mouse_NoWait;
  end
  else
    ErrorMessage('هيچ انتخابي انجام نشده است.');
end;

procedure TfrmSelect.cmdSelectAllClick(Sender: TObject);
var i : Integer;
begin
  for i := 0 to chkListData.Items.Count-1 do
    if not chkListData.Checked[i] then
    begin
      chkListData.Checked[i] := True;
      lstCodeNameSelected.Items.Add(chkListData.Items.Strings[i]);
    end;
end;


procedure TfrmSelect.cmdDeleteAllClick(Sender: TObject);
var i : Integer;
begin
  lstCodeNameSelected.Clear;
  for i := 0 to chkListData.Items.Count-1 do
    chkListData.Checked[i] := False;
end;

procedure TfrmSelect.cmbFromNoExit(Sender: TObject);
begin
  if cmbFromNo.ItemIndex = -1 then
  begin
    cmbFromNo.Text := '';
    cmbFromName.Text := '';
  end;
  cmbFromName.ItemIndex := cmbFromNo.ItemIndex;
end;

procedure TfrmSelect.cmbFromNoClick(Sender: TObject);
begin
  cmbFromName.ItemIndex := cmbFromNo.ItemIndex;
end;

procedure TfrmSelect.cmbFromNameClick(Sender: TObject);
begin
  cmbFromNo.ItemIndex := cmbFromName.ItemIndex;
end;

procedure TfrmSelect.cmbFromNameExit(Sender: TObject);
begin
  if cmbFromName.ItemIndex = -1 then
  begin
    cmbFromName.Text := '';
    cmbFromNo.Text := '';
  end;
  cmbFromNo.ItemIndex := cmbFromName.ItemIndex;
end;

procedure TfrmSelect.cmbToNoClick(Sender: TObject);
begin
  cmbToName.ItemIndex := cmbToNo.ItemIndex;
end;

procedure TfrmSelect.cmbToNoExit(Sender: TObject);
begin
  if cmbToNo.ItemIndex = -1 then
  begin
    cmbToNo.Text := '';
    cmbToName.Text := '';
  end;
  cmbToName.ItemIndex := cmbToNo.ItemIndex;
end;

procedure TfrmSelect.cmbToNameClick(Sender: TObject);
begin
  cmbToNo.ItemIndex := cmbToName.ItemIndex;
end;

procedure TfrmSelect.cmbToNameExit(Sender: TObject);
begin
  if cmbToName.ItemIndex = -1 then
  begin
    cmbToName.Text := '';
    cmbToNo.Text := '';
  end;
  cmbToNo.ItemIndex := cmbToName.ItemIndex;
end;

procedure TfrmSelect.chkListPrsClick(Sender: TObject);
begin
  if chkListData.Checked[chkListData.ItemIndex] then
    lstCodeNameSelected.Items.Add(chkListData.Items.Strings[chkListData.ItemIndex])
  else
    lstCodeNameSelected.Items.Delete(lstCodeNameSelected.Items.IndexOf(chkListData.Items.Strings[chkListData.ItemIndex]));
end;

procedure TfrmSelect.cmdDeleteClick(Sender: TObject);
begin
  if lstCodeNameSelected.ItemIndex > 0 then
  begin
    chkListData.Checked[chkListData.Items.IndexOf(lstCodeNameSelected.Items.Strings[lstCodeNameSelected.ItemIndex])] := False;
    lstCodeNameSelected.Items.Delete(lstCodeNameSelected.ItemIndex);
  end;
end;

procedure TfrmSelect.cmdOKClick(Sender: TObject);
var
  i : Integer;
  code : String;
begin
  dataSelected := '';
  for i := 0 to lstCodeNameSelected.Count-1 do
  begin
    code := copy(lstCodeNameSelected.Items.Strings[i], 1, pos('-', lstCodeNameSelected.Items.Strings[i])-1);
    if selType = SEL_PRS then code := '''' + code + '''';
    if dataSelected <> '' then
     begin
       if  selType=SEL_DORE then
         begin
         dataSelected :=dataSelected + ' or grpcode=';
         end
         else
           if  selType=SEL_khed then
         begin
         dataSelected :=dataSelected + ' or Employee.Empl_part=';
         end
         else
         begin
         dataSelected :=dataSelected + ',';
         end;


     end;
    dataSelected := dataSelected + code;


  end;
end;

procedure TfrmSelect.cmdCancelClick(Sender: TObject);
begin
  dataSelected := '';
end;

procedure TfrmSelect.FormShow(Sender: TObject);
begin
  ReadDBS;
end;

end.
