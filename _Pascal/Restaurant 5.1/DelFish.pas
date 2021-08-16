unit DelFish;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, AdoDB, Buttons, Grids, DBGrids;

type
  TfrmDelFish = class(TForm)
    Label1: TLabel;
    cmbType: TComboBox;
    Label2: TLabel;
    txtDate: TEdit;
    Label3: TLabel;
    txtFishNo: TEdit;
    dbgFish: TDBGrid;
    cmdDel: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    dtaFish: TDataSource;
    tblFish: TAdoTable;
    tblFishFish_Date: TStringField;
    tblFishFish_Type: TSmallintField;
    tblFishFish_No: TSmallintField;
    tblFishFish_PCode: TStringField;
    tblFishName: TStringField;
    Label4: TLabel;
    txtPCode: TEdit;
    lblRecCount: TLabel;
    tblFishPCode: TStringField;
    tblFishFish_UCode: TSmallintField;
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure cmbTypeClick(Sender: TObject);
    procedure cmbTypeKeyPress(Sender: TObject; var Key: Char);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure tblFishCalcFields(DataSet: TDataSet);
    procedure cmdDelClick(Sender: TObject);
    procedure txtDateExit(Sender: TObject);
  private
    { Private declarations }

    procedure SendTab(var Key : Char);
    procedure ReadData;
    procedure SetWinF;

  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

uses
  Globals, DateProc, Keyboard, DBS_Proc, MSGs;

procedure TfrmDelFish.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  tblFishFish_No.DisplayLabel := (tblFishFish_No.DisplayLabel);
  tblFishPCode.DisplayLabel := (tblFishPCode.DisplayLabel);
  tblFishName.DisplayLabel := (tblFishName.DisplayLabel);
  cmdDel.Caption := (cmdDel.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);
end;

procedure TfrmDelFish.ReadData;
var s : String;
begin
  s := 'Fish_Date = ''' + txtDate.Text + ''' AND Fish_Type = ' + IntToStr(cmbType.ItemIndex + 1);
  if txtFishNo.Text <> '' then
    s := s + ' AND Fish_No = ' + txtFishNo.Text;

  if txtPCode.Text <> '' then
    s := s + ' AND Fish_PCode = ''' + FixLeft(txtPCode.Text, '0', 8) + '''';
  s := s + ' AND Fish_UCode = 0';
  tblFish.Filtered := False;
  tblFish.Filter := s;
  tblFish.Filtered := True;
  lblRecCount.Caption := (' ⁄œ«œ ›Ì‘Â« = ' + IntToStr(tblFish.RecordCount));
end;

procedure TfrmDelFish.SendTab(var Key : Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl, True, True, False);
    t.SetFocus;
  end;
end;


procedure TfrmDelFish.FormCreate(Sender: TObject);
var i : Byte;
begin
  SetWinF;
  tblFish.connection := frmDBS.DBConnection;
  txtDate.Text := CurrentDate;
  for i := MB_SOBH to MB_SHAM do cmbType.Items.Add((FoodName[i]));
  cmbType.ItemIndex := 0;
  tblFish.Open;
  ReadData;
end;

procedure TfrmDelFish.FormDeactivate(Sender: TObject);
begin
  tblFish.Close;
end;

procedure TfrmDelFish.cmbTypeClick(Sender: TObject);
begin
  ReadData;
end;

procedure TfrmDelFish.cmbTypeKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
end;

procedure TfrmDelFish.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  SendTab(Key);
  Keyboard_Date(Key);
end;

procedure TfrmDelFish.txtDateExit(Sender: TObject);
begin
  with txtDate do
    if Text <> '' then
      Text := BeautifulDate(Text);
  ReadData;
end;

procedure TfrmDelFish.tblFishCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('Name'). AsString := GetPersonFamilyName(DataSet.FieldByName('Fish_PCode'). AsString);
  DataSet.FieldByName('PCode'). AsString := DelLeftZero(DataSet.FieldByName('Fish_PCode'). AsString);
end;

procedure TfrmDelFish.cmdDelClick(Sender: TObject);
var
   person_code:string;
   fl:integer;
  qry,qryu,qrys : TAdoQuery;
  fish_no,fish_pric,fish_type : Integer;

begin
  if tblFish.RecordCount > 0 then
  begin
    if ConfirmMessage('¬Ì« »—«Ì Õ–› ›Ì‘ «ÿ„Ì‰«‰ œ«—Ìœø') then
    begin
     try

      person_code:=tblfish.fieldbyname('fish_pcode').asstring;
      fish_no := tblFish.FieldByName('Fish_No').AsInteger;
      fish_type := tblFish.FieldByName('Fish_Type').AsInteger;
      qry := TAdoQuery.Create(Application);
      qry.connection := frmDBS.DBConnection;
      qrys := TAdoQuery.Create(Application);
      qrys.connection := frmDBS.DBConnection;
      qrys.Close;

      qrys.SQL.Clear;
      qrys.SQL.Add('select * from foodpric  where fp_date='+''''+txtDate.Text +'''');
      qrys.SQL.Add(' and FP_FoodCode='+ inttostr(fish_no));
      qrys.Open;
      fish_pric:=sumdelfish(fish_no,txtDate.Text,fish_type);
//      fish_p
      qry.Close;
      qry.sql.Clear;
//**********************these operation handled with Triggers*************************************************

//      qry.sql.Add(' DECLARE @ErrorVar int begin TRANSACTION tdelfish ');
//      qry.SQL.Add(' update persons set p_credit=p_credit+'+inttostr(fish_pric));
//      qry.SQL.Add(' where P_BarCode='+ ''''+ person_code + '''');
//
//      qry.sql.Add('SELECT @ErrorVar = @@error IF (@ErrorVar = 547) BEGIN   ROLLBACK TRANSACTION tdelfish end else begin begin TRANSACTION tdelfishh');
//**********************these operation handled with Triggers*************************************************

      qry.SQL.Add('DELETE FROM FishFood WHERE FF_FishNo = ' + IntToStr(fish_no));
      qry.SQL.Add('AND FF_Date = ''' + txtDate.Text + '''');
      qry.SQL.Add('AND FF_Type = ' + IntToStr(cmbType.ItemIndex + 1));
//**********************these operation handled with Triggers*************************************************
//      qry.SQL.Add( 'SELECT @ErrorVar = @@error IF (@ErrorVar = 547) BEGIN    ROLLBACK TRANSACTION tdelfish    ROLLBACK TRANSACTION tdelfishh '+
//                  ' end else begin commit tran tdelfishh commit tran tdelfish end end ');
//**********************these operation handled with Triggers*************************************************

     try
      qry.ExecSQL;
     except
        fl:=2;
     end;
     if fl<>2 then
      tblFish.Delete;

      except
       ErrorMessage('›Ì‘ Õ–› ‰‘œ');
     end;
     end;
  end;
end;

end.
