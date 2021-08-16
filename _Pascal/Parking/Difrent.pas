unit Difrent;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdoDB, Db, StdCtrls, Buttons, Grids, DBGrids, Globals, DateProc,
  FarsiApi, MSGs, DBS, Keyboard;

type
  TfrmDiff = class(TForm)
    btbottom: TBitBtn;
    bttop: TBitBtn;
    btbaad: TBitBtn;
    btghabl: TBitBtn;
    btsearch: TBitBtn;
    btdelete: TBitBtn;
    btinsert: TBitBtn;
    btescape: TBitBtn;
    btsave: TBitBtn;
    btexit: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    txtSerial: TEdit;
    txtNumber: TEdit;
    cmbCity: TComboBox;
    tblDiff: TAdoTable;
    qry: TAdoQuery;
    Label2: TLabel;
    cmbColor: TComboBox;
    Label3: TLabel;
    cmbCarName: TComboBox;
    Label4: TLabel;
    txtDate: TEdit;
    BTCLEAR: TBitBtn;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    TEDADLBL: TLabel;
    DataSource1: TDataSource;
    btedit: TBitBtn;
    cmdHelp: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure bttopClick(Sender: TObject);
    procedure btbottomClick(Sender: TObject);
    procedure btghablClick(Sender: TObject);
    procedure btbaadClick(Sender: TObject);
    procedure btsearchClick(Sender: TObject);
    procedure btinsertClick(Sender: TObject);
    procedure btdeleteClick(Sender: TObject);
    procedure btsaveClick(Sender: TObject);
    procedure btescapeClick(Sender: TObject);
    procedure txtDateKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTCLEARClick(Sender: TObject);
    procedure txtNumberExit(Sender: TObject);
    procedure cmbCityExit(Sender: TObject);
    procedure txtSerialExit(Sender: TObject);
    procedure cmbColorExit(Sender: TObject);
    procedure cmbCarNameExit(Sender: TObject);
    procedure txtNumberKeyPress(Sender: TObject; var Key: Char);
    procedure bteditClick(Sender: TObject);
    procedure cmbCityKeyPress(Sender: TObject; var Key: Char);
    procedure txtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure cmbColorKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCarNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCityEnter(Sender: TObject);
  private
    isnew : boolean;
    SrchStr : String;
    

    { Private declarations }
    procedure viewrecord;
    procedure clearrecord;
    procedure setbuts;
    procedure setnewmode;
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfrmDiff.SetWinF;
begin
  Caption := (Caption);
  Label1.Caption := (Label1.Caption);
  Label7.Caption := (Label7.Caption);
  Label10.Caption := (Label10.Caption);
  Label2.Caption := (Label2.Caption);
  Label3.Caption := (Label3.Caption);
  Label4.Caption := (Label4.Caption);
  Label6.Caption := (Label6.Caption);
  bttop.Caption := (bttop.Caption);
  btbottom.Caption := (btbottom.Caption);
  btbaad.Caption := (btbaad.Caption);
  btghabl.Caption := (btghabl.Caption);
  btedit.Caption := (btedit.Caption);
  btsearch.Caption := (btsearch.Caption);
  btdelete.Caption := (btdelete.Caption);
  btinsert.Caption := (btinsert.Caption);
  btescape.Caption := (btescape.Caption);
  btsave.Caption := (btsave.Caption);
  BTCLEAR.Caption := (BTCLEAR.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  btexit.Caption := (btexit.Caption);
end;

procedure TfrmDiff.setnewmode;
begin
   with tblDiff do
   isnew:=(recordcount=0);
end;

procedure TfrmDiff.setbuts;
begin
   case isnew of
      false:begin
               bttop.enabled:=true;
               btbottom.enabled:=true;
               btghabl.enabled:=true;
               btbaad.enabled:=true;
               btEDIT.enabled:=true;
               btsearch.enabled:=true;
               btdelete.enabled:=true;
               btinsert.enabled:=true;
               btsave.enabled:=false;
               btescape.enabled:=false;
               btclear.enabled:=true;
            end;
      true :begin
               bttop.enabled:=false;
               btbottom.enabled:=false;
               btghabl.enabled:=false;
               btbaad.enabled:=false;
               btEDIT.enabled:=FALSE;
               btsearch.enabled:=false;
               btdelete.enabled:=false;
               btinsert.enabled:=false;
               btsave.enabled:=true;
               btescape.enabled:=true;
               btclear.enabled:=false;
            end;
   end;
   TEDADLBL.CAPTION:=INTTOSTR(tblDiff.RECORDCOUNT);
end;

procedure TfrmDiff.clearrecord;
begin
  begin
     cmbCarName.text:='';
     cmbColor.text:='';
     cmbCity.text:='';
     txtNumber.text:='';
     txtSerial.text:='';
     txtDate.text:=currentdate;
  end;
end;

procedure TfrmDiff.viewrecord;
begin
  with tblDiff do
  begin
    cmbCarName.text:=fieldbyname('P_CarName').asstring;
    cmbColor.text:=fieldbyname('P_Color').asstring;
    cmbCity.text:=fieldbyname('P_City').asstring;
    txtNumber.text:=fieldbyname('P_Number').asstring;
    txtSerial.text:=fieldbyname('P_Serial').asstring;
    txtDate.text:=fieldbyname('P_Date').asstring;
  end;
end;

procedure TfrmDiff.FormCreate(Sender: TObject);
begin
  SetWinF;
  tblDiff.connection := frmDBS.adoConnect;
  qry.connection := frmDBS.adoConnect;

  with qry do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Cars ORDER BY Car_Code');
    Open;
    with cmbCarName.Items do
    begin
      Clear;
      while not EOF do
      begin
        Add(FieldByName('Car_Name').AsString);
        Next;
      end;
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Colors ORDER BY Clr_Code');
    Open;
    with cmbColor.Items do
    begin
      Clear;
      while not EOF do
      begin
        Add(FieldByName('Clr_Name').AsString);
        Next;
      end;
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Cities ORDER BY City_Code');
    Open;
    with cmbCity.Items do
    begin
      Clear;
      while not EOF do
      begin
        Add(FieldByName('City_Name').AsString);
        Next;
      end;
    end;
    Close;
  end;

  with tblDiff do
  begin
    TableName := 'CarPark';
    Open;
    IF NOT EOF
    THEN viewrecord
    ELSE CLEARRECORD;
    setnewmode;
    setbuts;
  end;
  SetDirectionFarsi(txtNumber.Handle);
end;

procedure TfrmDiff.bttopClick(Sender: TObject);
begin
   tblDiff.First;
   viewrecord;
end;

procedure TfrmDiff.btbottomClick(Sender: TObject);
begin
   tblDiff.last;
   viewrecord;
end;

procedure TfrmDiff.btghablClick(Sender: TObject);
begin
   tblDiff.Prior;
   viewrecord;
end;

procedure TfrmDiff.btbaadClick(Sender: TObject);
begin
  tblDiff.Next;
  viewrecord;
end;

procedure TfrmDiff.btsearchClick(Sender: TObject);
begin
{/////kaveh   with tblDiff do
   begin
     setkey;
     fieldbyname('P_Number').asstring:=txtNumber.text;
     gotonearest;
   end;
   viewrecord;kaveh}
end;

procedure TfrmDiff.btinsertClick(Sender: TObject);
begin
   isnew:=true;
   clearrecord;
   setbuts;
   activecontrol:=txtNumber;
end;

procedure TfrmDiff.btdeleteClick(Sender: TObject);
begin
  with tblDiff do
  if not isnew
   then if confirmmessage('¬Ì« »—«Ì Õ–› «ÿ„Ì‰«‰ œ«—Ìœø')
   then delete;
  viewrecord;
  setnewmode;
  setbuts;
end;

procedure TfrmDiff.btsaveClick(Sender: TObject);
begin
  IF ISNEW
  THEN IF ISEXISTSCAR('CarPark','P_Number','P_City','P_serial'
                             ,txtNumber.TEXT,cmbCity.TEXT,txtSerial.TEXT)
  THEN BEGIN
    ERRORMESSAGE('„‘Œ’«  „«‘Ì‰  ﬂ—«—Ì «” ');
    ACTIVECONTROL:=txtNumber;
    EXIT;
  END;
  IF txtNumber.TEXT=''
  THEN BEGIN
     ERRORMESSAGE('‘„«—Â „«‘Ì‰ Ê«—œ ‰‘œÂ «” ');
     ACTIVECONTROL:=txtNumber;
     EXIT;
  END;
  IF cmbCity.TEXT=''
  THEN BEGIN
     ERRORMESSAGE('‰«„ ‘Â— Ê«—œ ‰‘œÂ «” ');
     ACTIVECONTROL:=cmbCity;
     EXIT;
  END;
  IF cmbColor.TEXT=''
  THEN BEGIN
     ERRORMESSAGE('—‰ê Ê«—œ ‰‘œÂ «” ');
     ACTIVECONTROL:=cmbColor;
     EXIT;
  END;
  IF cmbCarName.TEXT=''
  THEN BEGIN
     ERRORMESSAGE('«”„ „«‘Ì‰ Ê«—œ ‰‘œÂ «” ');
     ACTIVECONTROL:=cmbCarName;
     EXIT;
  END;
  with tblDiff do
  begin
    if isnew
    then append
    else edit;
    fieldbyname('P_number').asstring:=txtNumber.text;
    fieldbyname('P_city').asstring:=cmbCity.text;
    fieldbyname('P_serial').asstring:=txtSerial.text;
    fieldbyname('P_carname').asstring:=cmbCarName.text;
    fieldbyname('P_color').asstring:=cmbColor.text;
    fieldbyname('P_date').asstring:=txtDate.text;
    post;
    setnewmode;
    setbuts;
  end;
end;

procedure TfrmDiff.btescapeClick(Sender: TObject);
begin
   viewrecord;
   setnewmode;
   setbuts;
end;

procedure TfrmDiff.txtDateKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if btSave.Enabled then
      btSave.SetFocus;
    Key := #0;
  end
  else
    Keyboard_Date(Key);
end;

procedure TfrmDiff.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   tblDiff.close;
end;

procedure TfrmDiff.BTCLEARClick(Sender: TObject);
begin
  if confirmmessage('¬Ì« »—«Ì Õ–› ﬂ· ·Ì”  «ÿ„Ì‰«‰ œ«—Ìœø')
  THEN BEGIN
    WITH tblDiff DO
    BEGIN
      FIRST;
      WHILE NOT EOF DO DELETE;
    END;
    viewrecord;
    setnewmode;
    setbuts;
  END;
end;

procedure TfrmDiff.txtNumberExit(Sender: TObject);
begin
   txtNumber.text:=trim(txtNumber.text);
end;

procedure TfrmDiff.cmbCityExit(Sender: TObject);
begin
   cmbCity.text:=trim(cmbCity.text);
end;

procedure TfrmDiff.txtSerialExit(Sender: TObject);
begin
   txtSerial.text:=trim(txtSerial.text);
end;

procedure TfrmDiff.cmbColorExit(Sender: TObject);
begin
   cmbColor.text:=trim(cmbColor.text);
end;

procedure TfrmDiff.cmbCarNameExit(Sender: TObject);
begin
   cmbCarName.text:=trim(cmbCarName.text);
end;

procedure TfrmDiff.txtNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    cmbCity.SetFocus
  else
    txtNumber.Text := Key_CarNumber(txtNumber.Text, Key, txtNumber.SelLength);

  Key := #0;
end;


procedure TfrmDiff.bteditClick(Sender: TObject);
begin
   isnew:=FALSE;
   bttop.enabled:=false;
   btbottom.enabled:=false;
   btghabl.enabled:=false;
   btbaad.enabled:=false;
   btEDIT.enabled:=FALSE;
   btsearch.enabled:=false;
   btdelete.enabled:=false;
   btinsert.enabled:=false;
   btsave.enabled:=true;
   btescape.enabled:=true;
   btclear.enabled:=false;
   activecontrol:=txtNumber;
end;

procedure TfrmDiff.cmbCityKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtSerial.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCity, Key);
end;

procedure TfrmDiff.txtSerialKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbColor.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmDiff.cmbColorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    cmbCarName.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbColor, Key);
end;

procedure TfrmDiff.cmbCarNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    txtDate.SetFocus;
    Key := #0;
  end
  else
    SrchNearst(SrchStr, cmbCarName, Key);
end;

procedure TfrmDiff.cmbCityEnter(Sender: TObject);
begin
  SrchStr := '';
end;


end.
