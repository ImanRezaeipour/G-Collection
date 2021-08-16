unit PersonRp;
{$I Features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBTables, ExtCtrls, Db, CheckLst, DosMove, ADODB, uPersonelScope
  ,ComObj;

type
  TfrmPersonRpt = class(TForm)
    grpEtc: TGroupBox;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lblwidth: TLabel;
    lbl10: TLabel;
    Lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    cmdExit: TBitBtn;
    cmdHelp: TBitBtn;
    cmdPrint: TBitBtn;
    clFields: TCheckListBox;
    cbpaper: TComboBox;
    cmdAll: TBitBtn;
    edlen: TEdit;
    txtRptTitle: TEdit;
    edleft: TEdit;
    edbottom: TEdit;
    DosMove1: TDosMove;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    lbl16: TLabel;
    cmbState: TComboBox;
    BitBtn1: TBitBtn;
    procedure calcullength;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure clFieldsClickCheck(Sender: TObject);
    procedure cmdAllClick(Sender: TObject);
    procedure cmdSelectClick(Sender: TObject);
    procedure cmbBarCodeChange(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure clFieldsClick(Sender: TObject);
    procedure clFieldsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edlenChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
  public
    procedure ExporttoExl(TheDataset : TDataSet);
    procedure fitForm;
  end;


implementation

uses
  Globals, TimeTool,DateProc, MSGs, Keyboard, RpPerson, Printers, DBS, Select,  Funcs;


{$R *.DFM}

var qrptPersons : TqrptPersons;



procedure TfrmPersonRpt.BitBtn1Click(Sender: TObject);
var
   i1:byte;
   i : Integer;
  fldName: string;
const
   pahna:array[0..2] of integer = (200,290,290);
begin
  qrptPersons.DataSet := qrptPersons.adoQryPersons;
  i1:=cbpaper.itemindex;
  if pahna[i1]<strtoint(lblwidth.caption)
  then if not confirmmessage('⁄—÷ ﬂ«€– «‰ Œ«» ‘œÂ »—«Ì ›Ì·Â«Ì «‰ Œ«» ‘œÂ ﬂ›«Ì  ‰„Ìﬂ‰œ.«œ«„Â Ì«»œø')
    then begin
       cbpaper.setfocus;
       exit;
    end;
  with qrptPersons do
  begin
    lblCoName.Caption := g_options.CoName;
    lblName.Caption := txtRptTitle.Text;
    if g_options.Shobeh <> '' then lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
    lblDate.Caption := CurrentDate;

    bndSum.Enabled := False;

    placeselects;
    while Ord(Page.PaperSize) > 8 do
      Page.PaperSize := Pred(Page.PaperSize);
    case cbpaper.itemindex of
         0:begin
              Page.PaperSize := Succ(Page.PaperSize);
              Page.Orientation := poPortrait;
           end;
         1:begin
              Page.PaperSize := Succ(Page.PaperSize);
              Page.Orientation := poLandscape;
           end;
         2:begin
              Page.Orientation := poPortrait;
           end;
         3:begin
           Page.PaperSize := Succ(Page.PaperSize);
           Page.Orientation := poPortrait;
           Page.BottomMargin := 30;
         end;
    end;
    if edleft.text=''
    then page.leftmargin:=10
    else page.leftmargin:=strtoint(edleft.text);
    if edbottom.text=''
    then page.bottommargin:=5
    else page.bottommargin:=strtoint(edbottom.text);

    placeothers;
    with adoQryPersons do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
//kaveh      SQL.Add('SELECT * FROM Persons left join  cashes on p_BoxNo = c_Code');
//kaveh is
//      SQL.Add('SELECT * FROM Persons LEFT OUTER JOIN ');
//      SQL.Add('nPersons ON dbo.Persons.p_code = nPersons.np_code LEFT OUTER JOIN ');
//      SQL.Add('Cashes ON dbo.Persons.p_BoxNo = Cashes.c_code ');
      SQL.Add('SELECT Persons.p_code, Persons.p_BoxNo, Persons.p_contractno, Persons.p_DEPOSITE ');
      SQL.Add(', Persons.p_BIMEH, Persons.p_AccountNo, Persons.p_AccountType, Persons.p_AccountBranch ');
      SQL.Add(', Persons.p_ContractDate, Persons.p_ContractEndDate, Persons.p_IsBlocked ');
      SQL.Add(', Persons.p_IsColleague, Persons.p_BlockDate, Persons.p_BlockDesc ');
      SQL.Add(', Persons.p_IsProvisionalBlocked, Persons.p_ProvisionalBlockDate ');
      SQL.Add(', Persons.p_ProvisionalBlockDesc, Persons.p_IsCommonBox, Persons.p_CommonBoxType ');
      SQL.Add(', Persons.p_IsLegalCustomer, Persons.p_CoName ');
      SQL.Add(', nPersons.np_Proxi, nPersons.np_NAME, nPersons.np_FAMILY, nPersons.np_IDNO ');
      SQL.Add(', nPersons.nP_Picture, nPersons.np_FATHER, nPersons.np_NATION, nPersons.np_IsMarried ');
      SQL.Add(', nPersons.np_POST, nPersons.np_BirthDate, nPersons.np_BirthPlace, nPersons.np_ADDRESS ');
      SQL.Add(', nPersons.np_HomeTel, nPersons.np_WorkTel, nPersons.np_MOBILE, nPersons.np_SignPicture ');
      SQL.Add(', nPersons.np_IsMemberCommonBoxType3 ');
      SQL.Add(', Cashes.c_name, Cashes.c_Place, Cashes.c_Type ');
      SQL.Add('FROM Persons LEFT OUTER JOIN ');
      SQL.Add('nPersons ON dbo.Persons.p_code = nPersons.np_code LEFT OUTER JOIN ');
      SQL.Add('Cashes ON dbo.Persons.p_BoxNo = Cashes.c_code ');
//kaveh ie
      case cmbState.ItemIndex of
        0 : SQL.Add('where P_isBlocked = 0');
        1 : SQL.Add('where P_isBlocked <> 0');
      end;
      if frmPrsnScp.rdoStartdate.Checked then
        fldName := 'P_ContractDate'
      else
        fldName := 'P_ContractEndDate';

      if frmPrsnScp.txtFromDate.Text  <> '' then
        SQL.Add('AND '+ fldName +' >= ''' + frmPrsnScp.txtFromDate.Text + '''');
      if frmPrsnScp.txtToDate.Text <> '' then
        SQL.Add('AND '+ fldName +' <= ''' + frmPrsnScp.txtToDate.Text + '''');

      frmPrsnScp.addPersonsLimit(SQL);

      Open;
      ExporttoExl(adoQryPersons);
    end;
  end;
end;

procedure TfrmPersonRpt.calcullength;
var
   l,l1:integer;
   i:byte;
begin
   //l:=0;
   l1:=0;
   qrptpersons.selcount:=0;
   with qrptpersons do
   with clFields do
   for i:=0 to Items.Count-1 do
    if checked[i]
    then begin
         //inc(l,qrptpersons.vec[i+1].vecwidth);
         inc(l1,flen[i+1]);
         inc(qrptpersons.selcount);
         qrptpersons.vselect[qrptpersons.selcount]:=i+1;
    end;
  {l:=round(l/3.78);}
  {if qrptpersons.lencustom then } l:=l1;
  lblwidth.Caption:=inttostr(l);

  l:=qrptpersons.flen[clFields.ItemIndex+1];
  edlen.Text:=inttostr(l);
end;


{$J+}

procedure SavePersonDepth;
var
   f:textfile;
   i:integer;
begin
    assignfile(f,g_options.ProgramPath + 'persons.dep');
    rewrite(f);
    with qrptPersons do
    for i:=1 to veccount do writeln(f,flen[i]);
    closefile(f);
end;


procedure TfrmPersonRpt.FormCreate(Sender: TObject);
const
   selected : set of 0..32 = [0,1,6,12,13,16,18,19];

var
  qry : TAdoQuery;
  i : byte;
  f : textfile;
begin
  viewDateTime := True;
  viewTime := false;
  frmPrsnScp := TfrmPrsnScp.Create(self);
  frmPrsnScp.rdoStartdate.Visible := true;
  frmPrsnScp.rdoEndDate.Visible := true;

  frmPrsnScp.txtFromDate.Text :='';
  frmPrsnScp.txtToDate.Text :='';

  fitform;

  selected:=[];
  for i:=1 to length(PrsRptSetST) do
      selected:=selected+[ord(PrsRptSetST[i])-1];

  Application.CreateForm(TqrptPersons, qrptPersons);
  with qrptPersons do
  begin
    initcustomvec;
    clFields.Items.Clear;
    for i:=1 to veccount do
     clFields.items.add(vec[i].vectitle);
    for i:=0 to veccount-1 do if i in selected
      then clFields.Checked[i]:=true;
  end;
  with qrptPersons do
  begin
    for i:=1 to veccount do
    flen[i]:=round(vec[i].vecwidth/3.78);
    lencustom:=false;
    {$i-}
    assignfile(f,g_options.ProgramPath + 'persons.dep');
    reset(f);
    {$i+}
    if ioresult=0
    then begin
         lencustom:=false;
         i:=0;
         while not eof(f) do
         begin
              inc(i);
              readln(f,flen[i]);
         end;
         closefile(f);
    end;
  end;
  cmbState.ItemIndex := 0;
  cbpaper.itemindex:=0;
  calcullength;
  
  Application.CreateForm(TfrmSelect, frmSelect);
end;
procedure  TfrmPersonRpt.ExporttoExl(TheDataset : TDataSet);
var
  XApp:Variant;
  sheet:Variant;
  r,c:Integer;
  q:Integer;
  row,col:Integer;
  fildName:Integer;

begin
 try

  begin
    XApp:=CreateOleObject('Excel.Application');
//    XApp.Visible:=true;
  end;
 except
  showmessage('Unable to link with MS Excel,  it seems as it is not installed on this system.');
  exit;
 end;

XApp.WorkBooks.Add(-4167);  //open a new blank workbook
XApp.WorkBooks[1].WorkSheets[1].Name:='Sheet1';
          //give any name required to ExcelSheet
sheet:=XApp.WorkBooks[1].WorkSheets['Sheet1'];
 for fildName:=0 to TheDataset.FieldCount-1 do
         //TheDataset refer to the any dataset holding data

  begin
    q:=fildName+1;
    sheet.Cells[1,q]:=TheDataset.Fields[fildName].FieldName;   // enter the column headings
  end;

//now supply the data from table to excel sheet
TheDataset.First;
for r:=0 to TheDataset.RecordCount-1 do
begin
 for c:=0 to TheDataset.FieldCount-1 do
   begin
     row:=r+2;
     col:=c+1;
     sheet.Cells[row,col]:=TheDataset.Fields[c].AsString;
   end;
 TheDataset.Next;
end;


//set font attributes of required range if required
XApp.WorkSheets['Sheet1'].Range['A1:AA1'].Font.Bold:=True;
XApp.WorkSheets['Sheet1'].Range['A1:AA1'].Font.Color := clblue;
XApp.WorkSheets['Sheet1'].Range['A1:AA1'].Font.Color := clblue;
XApp.WorkSheets['Sheet1'].Range['A1:K1'].Borders.LineStyle :=13;

// set other attributes as below
XApp.WorkSheets['Sheet1'].Range['A1:K11'].HorizontalAlignment := 3;
// .Borders.LineStyle :=13;
XApp.WorkSheets['Sheet1'].Columns[1].ColumnWidth:=10;
XApp.WorkSheets['Sheet1'].Columns[2].ColumnWidth:=10;
XApp.WorkSheets['Sheet1'].Columns[3].ColumnWidth:=15;
XApp.WorkSheets['Sheet1'].Columns[4].ColumnWidth:=6;
XApp.WorkSheets['Sheet1'].Columns[5].ColumnWidth:=18;
XApp.WorkSheets['Sheet1'].Columns[6].ColumnWidth:=9;
XApp.WorkSheets['Sheet1'].Columns[7].ColumnWidth:=23;
XApp.WorkSheets['Sheet1'].Columns[8].ColumnWidth:=23;
XApp.WorkSheets['Sheet1'].Columns[9].ColumnWidth:=23;
XApp.WorkSheets['Sheet1'].Columns[10].ColumnWidth:=10;
xapp.caption := 'Exported from Demo programmed by SK Arora,the digitiger';
//XApp.WorkSheets['Sheet1'].name := 'Exported from ' + TheDataset.TableName;
//assuming dataset is TTable based its tablename can be given as title of worksheet
XApp.WorkSheets['Sheet1'].name := 'Exported from sssss';
XApp.Visible:=true;
close;
end;

procedure TfrmPersonRpt.cmdPrintClick(Sender: TObject);
var
   i1:byte;
   i : Integer;
  fldName: string;
const
   pahna:array[0..2] of integer = (200,290,290);
begin
  qrptPersons.DataSet := qrptPersons.adoQryPersons;
  i1:=cbpaper.itemindex;
  if pahna[i1]<strtoint(lblwidth.caption)
  then if not confirmmessage('⁄—÷ ﬂ«€– «‰ Œ«» ‘œÂ »—«Ì ›Ì·œÂ«Ì «‰ Œ«» ‘œÂ ﬂ›«Ì  ‰„Ìﬂ‰œ.«œ«„Â Ì«»œø')
    then begin
       cbpaper.setfocus;
       exit;
    end;
  with qrptPersons do
  begin
    lblCoName.Caption := g_options.CoName;
    lblName.Caption := txtRptTitle.Text;
    if g_options.Shobeh <> '' then lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
    lblDate.Caption := CurrentDate;

    bndSum.Enabled := False;

    placeselects;
    while Ord(Page.PaperSize) > 8 do
      Page.PaperSize := Pred(Page.PaperSize);
    case cbpaper.itemindex of
         0:begin
              Page.PaperSize := Succ(Page.PaperSize);
              Page.Orientation := poPortrait;
           end;
         1:begin
              Page.PaperSize := Succ(Page.PaperSize);
              Page.Orientation := poLandscape;
           end;
         2:begin
              Page.Orientation := poLandscape;//poPortrait;
           end;
         3:begin
           Page.PaperSize := Succ(Page.PaperSize);
           Page.Orientation := poLandscape;//poPortrait;
           Page.BottomMargin := 30;
         end;
    end;
    if edleft.text=''
    then page.leftmargin:=10
    else page.leftmargin:=strtoint(edleft.text);
    if edbottom.text=''
    then page.bottommargin:=5
    else page.bottommargin:=strtoint(edbottom.text);

    placeothers;
    with adoQryPersons do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
//kaveh      SQL.Add('SELECT * FROM Persons left join  cashes on p_BoxNo = c_Code');
//kaveh is
      SQL.Add('SELECT * FROM Persons LEFT OUTER JOIN ');
      SQL.Add('nPersons ON dbo.Persons.p_code = nPersons.np_code LEFT OUTER JOIN ');
      SQL.Add('Cashes ON dbo.Persons.p_BoxNo = Cashes.c_code ');
      SQL.Add(' ');
//kaveh ie
      case cmbState.ItemIndex of
        0 : SQL.Add('where P_isBlocked = 0');
        1 : SQL.Add('where P_isBlocked <> 0');
      end;
      if frmPrsnScp.rdoStartdate.Checked then
        fldName := 'P_ContractDate'
      else
        fldName := 'P_ContractEndDate';

      if frmPrsnScp.txtFromDate.Text  <> '' then
        SQL.Add('AND '+ fldName +' >= ''' + frmPrsnScp.txtFromDate.Text + '''');
      if frmPrsnScp.txtToDate.Text <> '' then
        SQL.Add('AND '+ fldName +' <= ''' + frmPrsnScp.txtToDate.Text + '''');

      frmPrsnScp.addPersonsLimit(SQL);

      Open;
//      ExporttoExl(adoQryPersons);
      if RecordCount > 0 then
      begin
        if frmPrsnScp.rdoScreen.Checked then
          Preview
        else
          Print;
      end
      else
        InformationMessage('„‘ —Ì   ⁄—Ì› ‰‘œÂ «” .');
      Close;
    end;
  end;
end;

procedure TfrmPersonRpt.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   i:byte;
begin
//  frmPrsnScp.Parent := nil;
  viewDateTime := true;
  viewTime := true;
  PrsRptSetST:='';
  with clFields do
   for i:=0 to Items.Count-1 do
    if checked[i]
     then PrsRptSetST:=PrsRptSetST+chr(i+1);
  SaveIniFileDB;
  SavePersonDepth;
  qrptPersons.Free;
  frmSelect.Free;  
end;

procedure TfrmPersonRpt.clFieldsClickCheck(Sender: TObject);
begin
   calcullength;
end;

procedure TfrmPersonRpt.cmdAllClick(Sender: TObject);
var i : Byte;
begin
  if cmdAll.Caption = ('Â&„Â') then
  begin
    for i := 0 to clFields.Items.Count-1 do
      clFields.Checked[i] := True;
    cmdAll.Caption := ('ÂÌç&ﬂœ«„');
  end
  else
  begin
    for i := 0 to clFields.Items.Count-1 do
      clFields.Checked[i] := False;
    cmdAll.Caption := ('Â&„Â');
  end;

  calcullength;
end;

procedure TfrmPersonRpt.cmdSelectClick(Sender: TObject);
begin
  if frmSelect.ShowModal = mrOk then
    SelFlag := True;
end;

procedure TfrmPersonRpt.cmbBarCodeChange(Sender: TObject);
begin
  SelFlag := False;
end;

procedure TfrmPersonRpt.clFieldsClick(Sender: TObject);
var
   l:integer;
begin
  l:=qrptpersons.flen[clFields.ItemIndex+1];
  edlen.Text:=inttostr(l);
end;

procedure TfrmPersonRpt.clFieldsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   l:integer;
begin
  l:=qrptpersons.flen[clFields.ItemIndex+1];
  edlen.Text:=inttostr(l);
end;

procedure TfrmPersonRpt.edlenChange(Sender: TObject);
var
   i:integer;
begin
  with edlen do
  begin
     if text<>''
     then begin
        i:=strtoint(text);
        if i=0 then i:=1;
        qrptpersons.flen[clFields.ItemIndex+1]:=i;
     end;
  end;
  calcullength;
end;

procedure TfrmPersonRpt.fitForm;
begin
  frmPrsnScp.Parent := Self;
  frmPrsnScp.Top := 0;
  frmPrsnScp.Left := 0;
  height := frmPrsnScp.Height + grpEtc.Height + 25;
end;

end.
