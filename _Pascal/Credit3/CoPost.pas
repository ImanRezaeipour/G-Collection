unit CoPost;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, XStringGrid;

type
  TfrmCoPost = class(TForm)
    grpAll: TGroupBox;
    dbgCoPost: TDBGrid;
    grpEdit: TGroupBox;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lbl2: TLabel;
    txtName: TEdit;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    dtaCoPost: TDataSource;
    lbl1: TLabel;
    txtCode: TEdit;
    adotblCoPost: TADOTable;
    grdPrices: TXStringGrid;
    EditCellEditor1: TEditCellEditor;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgCoPostKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Flag : Byte;

    procedure SetWinF;
    procedure FormInEdit(vis : Boolean);
    function  AreValidFields : Boolean;
  public
    { Public declarations }
  end;


var
  frmCoPost : TfrmCoPost;


implementation

uses
  Funcs, MSGs, DBS, FarsiApi, Keyboard, FntSel;

{$R *.DFM}

procedure TfrmCoPost.SetWinF;
var i : Byte;
begin
  SetFontColor(TForm(frmCoPost));

  Caption := (Caption);
  for i := 0 to dbgCoPost.Columns.Count-1 do
    dbgCoPost.Columns[i].Title.Caption := (dbgCoPost.Columns[i].Title.Caption);
  cmdNew.Caption := (cmdNew.Caption);
  cmdEdit.Caption := (cmdEdit.Caption);
  cmdDelete.Caption := (cmdDelete.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);

  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  cmdSave.Caption := (cmdSave.Caption);
  cmdCancel.Caption := (cmdCancel.Caption);
end;

procedure TfrmCoPost.FormInEdit(vis : Boolean);
begin
  grpAll.Enabled := not vis;
  grpEdit.Visible := vis;
  if vis then
    Height := grpAll.Height + grpEdit.Height
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

function TfrmCoPost.AreValidFields : Boolean;
begin
  if txtCode.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('كد جايگاه وارد نشده است.');
    txtCode.SetFocus;
  end
  else if (strtoint(txtCode.Text)<10) or (strtoint(txtCode.Text)>60)
  then
  begin
    AreValidFields := False;
    ErrorMessage('كد جايگاه باید بین 10 تا 60 باشد.');
    txtCode.SetFocus;
  end
  else if txtName.Text = '' then
  begin
    AreValidFields := False;
    ErrorMessage('عنوان جايگاه وارد نشده است.');
    txtName.SetFocus;
  end
  else if IsExistsRec_Num('CoPosts', 'CoPost_Code', StrToInt(txtCode.Text)) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblCoPost.FieldByName('CoPost_Code').AsString <> txtCode.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('كد جايگاه تكراري است.');
    txtCode.SetFocus;
  end
  else if IsExistsRec_Str('CoPosts', 'CoPost_Name', txtName.Text) and
    ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (adotblCoPost.FieldByName('CoPost_Name').AsString <> txtName.Text))) then
  begin
    AreValidFields := False;
    ErrorMessage('عنوان جايگاه تكراري است.');
    txtName.SetFocus;
  end
  else
    AreValidFields := True;
end;

procedure TfrmCoPost.FormCreate(Sender: TObject);
var
  qry : TAdoQuery;
  i : integer;
begin
  SetWinF;
  SetDirectionFarsi(txtName.Handle);
  adotblCoPost.Connection := frmDBS.adoConnect;
  adotblCoPost.Open;
//  grdPrices.RowS[0].DelimitedText := ',شنا,کاراته,تکواندو,کشتی,بدنسازی,تیراندازی,پینگ-پنگ';
  grdPrices.Cells[0,1] := 'قیمت';
  grdPrices.Cells[0,0] := 'خدمات';

  i:=0;
  qry := TAdoQuery.Create(Application);
  qry.connection := frmDBS.adoConnect;
  qry.SQL.Add('SELECT * FROM services');
  qry.Open;
  grdPrices.ColCount:=qry.RecordCount+1;
  while not qry.Eof do
  begin
    inc(i);
    grdPrices.Columns[i].Editor:=EditCellEditor1;
//    grdPrices.ColCount:=i+1;
    grdPrices.Cells[i,0]:=qry.fieldbyname('s_code').asstring+'-'+qry.fieldbyname('s_name').asstring;
    qry.Next;
  end;
  qry.Close;
  qry.Free;
end;

procedure TfrmCoPost.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
end;

procedure TfrmCoPost.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adotblCoPost.Close;
end;

procedure TfrmCoPost.dbgCoPostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmCoPost.cmdNewClick(Sender: TObject);
var
  i : integer;
begin
  FormInEdit(True);
  Flag := MB_NEW;
  txtCode.Text := IntToStr(GetNewNumber('CoPosts', 'CoPost_Code'));
  txtName.Text := '';
  for I := 1 to grdPrices.colCount - 1 do
    grdPrices.Cells[i,1]:='0';
//  grdPrices.RowS[1].DelimitedText := 'قیمت(ریال),0,0,0,0,0,0,0';
  txtName.SetFocus;
end;

procedure TfrmCoPost.cmdEditClick(Sender: TObject);
var
  qry : TAdoQuery;
  i,s,pr : integer;
  st : string;
begin
  if adotblCoPost.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    txtCode.Text := IntToStr(adotblCoPost.FieldByName('CoPost_Code').AsInteger);
    txtName.Text := adotblCoPost.FieldByName('CoPost_Name').AsString;
    {
    with grdPrices do
    begin
      Cells[1,1] := adotblCoPost.FieldByName('CoPost_S1').AsString;
      Cells[2,1] := adotblCoPost.FieldByName('CoPost_S2').AsString;
      Cells[3,1] := adotblCoPost.FieldByName('CoPost_S3').AsString;
      Cells[4,1] := adotblCoPost.FieldByName('CoPost_S4').AsString;
      Cells[5,1] := adotblCoPost.FieldByName('CoPost_S5').AsString;
      Cells[6,1] := adotblCoPost.FieldByName('CoPost_S6').AsString;
      Cells[7,1] := adotblCoPost.FieldByName('CoPost_S7').AsString;
    end;
    }
    for I := 1 to grdPrices.colCount - 1 do
      grdPrices.Cells[i,1]:='0';
    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
//    qry.SQL.Add('SELECT * FROM services,prices');
//    qry.SQL.Add('where p_service=s_code');
//    qry.SQL.Add('and p_service='+txtCode.Text);
    qry.SQL.Add('SELECT * FROM prices');
    qry.SQL.Add('where p_copost='+txtCode.Text);
    qry.Open;
    while not qry.Eof do
    begin
      s:=qry.fieldbyname('p_service').asinteger;
      pr:=qry.fieldbyname('p_price').asinteger;
      for I := 1 to grdPrices.colCount - 1 do
      begin
        st:=grdPrices.Cells[i,0];
        st:=copy(st,1,pos('-',st)-1);
        if inttostr(s)=st
        then begin
          grdPrices.Cells[i,1]:=inttostr(pr);
          break;
        end;
      end;
      qry.Next;
    end;
    qry.Close;
    qry.Free;

    txtName.SetFocus;
  end;
end;

procedure TfrmCoPost.cmdDeleteClick(Sender: TObject);
begin
  if adotblCoPost.RecordCount > 0 then
  begin
    if not IsExistsRec_Num('Employee', 'Empl_CoPost', adotblCoPost.FieldByName('CoPost_Code').AsInteger) then
    begin
      if ConfirmMessage('آيا براي حذف جايگاه اطمينان داريد؟') then
      begin
        adotblCoPost.Delete;
        adotblCoPost.Refresh;
      end;
    end
    else
      InformationMessage('اين جايگاه ‏در گردش بوده و حذف آن امكان پذير نيست.');
  end;
end;

procedure TfrmCoPost.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmCoPost.cmdSaveClick(Sender: TObject);
var
  OldPost : String;
  qry : TAdoQuery;
  i : integer;
  service,copost,price : string;
begin
  if AreValidFields then
  begin
    OldPost := adotblCoPost.FieldByName('CoPost_Code').AsString;
    if Flag = MB_NEW then
      adotblCoPost.Append
    else if Flag = MB_EDIT then
      adotblCoPost.Edit;

    adotblCoPost.FieldByName('CoPost_Code').AsInteger := StrToInt(txtCode.Text);
    adotblCoPost.FieldByName('CoPost_Name').AsString := txtName.Text;
    {
    with grdPrices do
    begin
      adotblCoPost.FieldByName('CoPost_S1').AsString := Cells[1,1];
      adotblCoPost.FieldByName('CoPost_S2').AsString := Cells[2,1];
      adotblCoPost.FieldByName('CoPost_S3').AsString := Cells[3,1];
      adotblCoPost.FieldByName('CoPost_S4').AsString := Cells[4,1];
      adotblCoPost.FieldByName('CoPost_S5').AsString := Cells[5,1];
      adotblCoPost.FieldByName('CoPost_S6').AsString := Cells[6,1];
      adotblCoPost.FieldByName('CoPost_S7').AsString := Cells[7,1];
    end;
    }
    adotblCoPost.Post;

    if (Flag = MB_EDIT) and (OldPost <> txtCode.Text) then
    begin
      frmDBS.adoQryG.SQL.Clear;
      frmDBS.adoQryG.SQL.Add('UPDATE Employee SET Empl_CoPost = ' + txtCode.Text);
      frmDBS.adoQryG.SQL.Add('WHERE Empl_CoPost = ' + OldPost);
      frmDBS.adoQryG.ExecSQL;
    end;

    qry := TAdoQuery.Create(Application);
    qry.connection := frmDBS.adoConnect;
    qry.SQL.Add('delete FROM prices');
    qry.SQL.Add('where p_copost='+txtCode.Text);
    qry.ExecSQL;
    qry.Close;
    for I := 1 to grdPrices.colCount - 1 do
    begin
      price:=grdPrices.Cells[i,1];
      if price<>''
      then begin
        service:=grdPrices.Cells[i,0];
        service:=copy(service,1,pos('-',service)-1);
        copost:=txtCode.Text;
        qry.SQL.clear;
        qry.SQL.Add('insert into prices (P_CoPost, p_service, p_price)');
        qry.SQL.Add('VALUES(' + copost + ',' + service + ',' + price + ')');
        qry.ExecSQL;
        qry.Close;
      end;
    end;
    qry.Free;

    if Flag = MB_NEW then
    begin
      txtName.Text := '';
      txtCode.Text := IntToStr(GetNewNumber('CoPosts', 'CoPost_Code'));
      txtName.SetFocus;
    end
    else
    begin
      FormInEdit(False);
      dbgCoPost.SetFocus;
    end;
  end;
end;

procedure TfrmCoPost.cmdCancelClick(Sender: TObject);
begin
  FormInEdit(False);
  dbgCoPost.SetFocus;
end;







procedure TfrmCoPost.txtNameKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_XP(Key);
end;

end.
