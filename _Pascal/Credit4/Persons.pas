unit Persons;
{$I Features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Db, DBTables, ExtCtrls, Globals,
  FarsiApi, MSGs, Keyboard, TimeTool,DateProc, DBS, SelPic, RunCmnds,
  ComTools, DBCtrls, FileCtrl, Code_Sys, ComCtrls, TabNotBk, ADODB,
  Variants, Wwdbigrd, Wwdbgrid, VirtualTrees,Tcp_Udp, ExtDlgs, 
  Z80_CMD, DosMove;

type
  TfrmPersons = class(TForm)
    dtaPersons: TDataSource;
    adoQryPrs: TADOQuery;
    tabInfo: TTabbedNotebook;
    lbl7: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    cmdSave: TBitBtn;
    cmdCancel: TBitBtn;
    txtCode: TEdit;
    grpAll: TGroupBox;
    Bevel1: TBevel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblRecCount: TLabel;
    dbgPersons: TDBGrid;
    cmdNew: TBitBtn;
    cmdEdit: TBitBtn;
    cmdDelete: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    txtSrchName: TEdit;
    txtSrchFamily: TEdit;
    cmdSearch: TBitBtn;
    Label6: TLabel;
    txtAccountNo: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    txtContractNo: TEdit;
    Label10: TLabel;
    txtAccountBranch: TEdit;
    Label11: TLabel;
    txtDeposite: TEdit;
    Label12: TLabel;
    txtContractDate: TEdit;
    Label13: TLabel;
    txtContractEndDate: TEdit;
    Label14: TLabel;
    Bevel6: TBevel;
    cmbBoxNo: TComboBox;
    cmbAccountType: TComboBox;
    Label15: TLabel;
    txtBimeh: TEdit;
    chkColleague: TCheckBox;
    cmbBoxType: TComboBox;
    grpV1: TGroupBox;
    txtV1Name: TEdit;
    Label3: TLabel;
    Label16: TLabel;
    txtV1Family: TEdit;
    Label17: TLabel;
    txtV1IdNo: TEdit;
    txtV1Father: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    cmbV1FromPlace: TComboBox;
    Label20: TLabel;
    txtV1ExpireDate: TEdit;
    Label21: TLabel;
    txtV1ProxyID: TEdit;
    adoTblProxy: TADOTable;
    Bevel7: TBevel;
    cmdSave2: TBitBtn;
    cmdCancel2: TBitBtn;
    chkBlock: TCheckBox;
    grpBlock: TGroupBox;
    Label22: TLabel;
    txtBlockDesc: TEdit;
    txtBlockDate: TEdit;
    Label30: TLabel;
    cmdSave4: TBitBtn;
    cmdCancel4: TBitBtn;
    Bevel8: TBevel;
    cmbType: TComboBox;
    Label31: TLabel;
    Bevel9: TBevel;
    lblColleague: TLabel;
    lblnonColleague: TLabel;
    lblBusyBox: TLabel;
    lblAllBox: TLabel;
    lblFreeBox: TLabel;
    Shape2: TShape;
    Label33: TLabel;
    imgVakil: TImage;
    GroupBox1: TGroupBox;
    Shape3: TShape;
    Label40: TLabel;
    imgVakil2: TImage;
    BitBtn6: TBitBtn;
    cmdSave3: TBitBtn;
    cmdCancel3: TBitBtn;
    txtV2Name: TEdit;
    txtV2Family: TEdit;
    txtV2IdNo: TEdit;
    txtV2Father: TEdit;
    cmbV2FromPlace: TComboBox;
    txtV2ExpireDate: TEdit;
    txtV2ProxyID: TEdit;
    Label1: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    BitBtn7: TBitBtn;
    BitBtn9: TBitBtn;
    GroupBox2: TGroupBox;
    txtSignName: TLabel;
    txtSignFamily: TLabel;
    txtSignIDNO: TLabel;
    txtSignContractNo: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    txtSignName2: TLabel;
    txtSignFamily2: TLabel;
    txtSignIDNO2: TLabel;
    txtSignContractNo2: TLabel;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    grpProvisionalBlock: TGroupBox;
    Label29: TLabel;
    Label34: TLabel;
    txtProvisionalBlockDesc: TEdit;
    txtProvisionalBlockDate: TEdit;
    chkProvisionalBlock: TCheckBox;
    adoQryHistory: TADOQuery;
    adoQryHistoryp_code: TWideStringField;
    adoQryHistoryp_Proxi: TWideStringField;
    adoQryHistoryp_NAME: TWideStringField;
    adoQryHistoryp_FAMILY: TWideStringField;
    adoQryHistoryp_IDNO: TWideStringField;
    adoQryHistoryP_Picture: TWideStringField;
    adoQryHistoryp_FATHER: TWideStringField;
    adoQryHistoryp_NATION: TWideStringField;
    adoQryHistoryp_IsMarried: TIntegerField;
    adoQryHistoryp_POST: TWideStringField;
    adoQryHistoryp_BirthDate: TWideStringField;
    adoQryHistoryp_BirthPlace: TWideStringField;
    adoQryHistoryp_ADDRESS: TWideStringField;
    adoQryHistoryp_HomeTel: TWideStringField;
    adoQryHistoryp_WorkTel: TWideStringField;
    adoQryHistoryp_MOBILE: TWideStringField;
    adoQryHistoryp_BoxNo: TIntegerField;
    adoQryHistoryp_contractno: TWideStringField;
    adoQryHistoryp_DEPOSITE: TWideStringField;
    adoQryHistoryp_BIMEH: TWideStringField;
    adoQryHistoryp_AccountNo: TWideStringField;
    adoQryHistoryp_AccountType: TIntegerField;
    adoQryHistoryp_AccountBranch: TWideStringField;
    adoQryHistoryp_ContractDate: TWideStringField;
    adoQryHistoryp_ContractEndDate: TWideStringField;
    adoQryHistoryp_IsBlocked: TBooleanField;
    adoQryHistoryp_IsColleague: TBooleanField;
    adoQryHistoryp_BlockDate: TWideStringField;
    adoQryHistoryp_BlockDesc: TWideStringField;
    adoQryHistoryp_SignPicture: TWideStringField;
    adoQryHistoryp_IsProvisionalBlocked: TBooleanField;
    adoQryHistoryp_ProvisionalBlockDate: TWideStringField;
    adoQryHistoryp_ProvisionalBlockDesc: TWideStringField;
    cmdRevival: TBitBtn;
    Label35: TLabel;
    cmbSrchBoxNo: TComboBox;
    cmbBoxPlace: TComboBox;
    Label36: TLabel;
    chkCommonBox: TCheckBox;
    RadioButton4: TRadioButton;
    OpenPictureDialog1: TOpenPictureDialog;
    rdoCommonType1: TRadioButton;
    rdoCommonType2: TRadioButton;
    rdoCommonType3: TRadioButton;
    dbgPPersons: TDBGrid;
    Bevel15: TBevel;
    Bevel16: TBevel;
    cmdDeleteP: TBitBtn;
    cmdEditP: TBitBtn;
    cmdNewP: TBitBtn;
    chkLegalCustomer: TCheckBox;
    txtCoName: TEdit;
    lblCoName: TLabel;
    dtaPersons2: TDataSource;
    adoQryPrs2: TADOQuery;
    pnlPerson: TPanel;
    Shape1: TShape;
    imgPicture: TImage;
    lbl6: TLabel;
    lbl5: TLabel;
    Label32: TLabel;
    Bevel4: TBevel;
    lbl17: TLabel;
    lbl19: TLabel;
    lbl22: TLabel;
    Bevel5: TBevel;
    lbl26: TLabel;
    lbl13: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl29: TLabel;
    lbl30: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel17: TBevel;
    txtFamily: TEdit;
    txtName: TEdit;
    txtProxi: TEdit;
    btnGetCardNo: TBitBtn;
    txtNation: TEdit;
    txtFather: TEdit;
    txtIDNO: TEdit;
    cmbMarry: TComboBox;
    txtPost: TEdit;
    txtBirthDate: TEdit;
    cmbFromPlace: TComboBox;
    txtAddress: TEdit;
    txtHomeTel: TEdit;
    txtWorkTel: TEdit;
    txtMobile: TEdit;
    cmdPCancel: TBitBtn;
    cmdPSave: TBitBtn;
    Shape4: TShape;
    imgSign: TImage;
    Label41: TLabel;
    Bevel3: TBevel;
    Label66: TLabel;
    lblLastKey: TLabel;
    Shape5: TShape;
    imgVakilSign: TImage;
    Label37: TLabel;
    Shape6: TShape;
    imgVakil2Sign: TImage;
    Label38: TLabel;
    Bevel10: TBevel;
    Label39: TLabel;
    txtV1CardNo: TEdit;
    txtV2CardNo: TEdit;
    Label42: TLabel;
    chkMemberCommonBoxType3: TCheckBox;
    lblBranchCode: TLabel;
    procedure cmbBoxTypeChange(Sender: TObject);
    procedure btnGetCardNoClick(Sender: TObject);
    procedure imgVakilDblClick(Sender: TObject);
    procedure cmbBoxNoChange(Sender: TObject);
    procedure cmbTypeChange(Sender: TObject);
    procedure txtBlockDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtBlockDateExit(Sender: TObject);
    procedure chkBlockClick(Sender: TObject);
    procedure txtBimehKeyPress(Sender: TObject; var Key: Char);
    procedure txtDepositeKeyPress(Sender: TObject; var Key: Char);
    procedure txtContractEndDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtContractDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtContractEndDateExit(Sender: TObject);
    procedure txtContractDateExit(Sender: TObject);
    procedure txtBirthDateExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure dbgPersonsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tblPrsCalcFields(DataSet: TDataSet);
    procedure txtSearchCodeKeyPress(Sender: TObject; var Key: Char);
    procedure txtSearchCodeExit(Sender: TObject);
    procedure txtProxiKeyPress(Sender: TObject; var Key: Char);
    procedure imgPictureDblClick(Sender: TObject);
    procedure txtJobDateKeyPress(Sender: TObject; var Key: Char);
    procedure cmbFromPlaceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure cmbBirthPlaceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtEndJobDateExit(Sender: TObject);

    procedure tabInfoClick(Sender: TObject);
    procedure cmbMarryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPersonsTitleClick(Column: TColumn);


    procedure adoQryPrsCalcFields(DataSet: TDataSet);
    procedure Z84GetRecord(rdrInfo : TReaders);
    procedure imgVakil2DblClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure imgSignDblClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure chkProvisionalBlockClick(Sender: TObject);
    procedure txtProvisionalBlockDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtProvisionalBlockDateExit(Sender: TObject);
    procedure cmdRevivalClick(Sender: TObject);
    procedure cmbBoPlaceChange(Sender: TObject);
    procedure tabInfoChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure txtBirthDateKeyPress(Sender: TObject; var Key: Char);
    procedure txtBirthDateSecKeyPress(Sender: TObject; var Key: Char);
    procedure cmbMarrySecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure imgPictureSecDblClick(Sender: TObject);
    procedure chkCommonBoxClick(Sender: TObject);
    procedure cmdNewPClick(Sender: TObject);
    procedure cmdPCancelClick(Sender: TObject);
    procedure chkLegalCustomerClick(Sender: TObject);
    procedure cmdEditPClick(Sender: TObject);
    procedure dbgPPersonsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeletePClick(Sender: TObject);
    procedure dbgPPersonsTitleClick(Column: TColumn);
    procedure adoQryPrs2CalcFields(DataSet: TDataSet);
    procedure dtaPersons2DataChange(Sender: TObject; Field: TField);
    procedure cmdPSaveClick(Sender: TObject);
    procedure imgVakilSignDblClick(Sender: TObject);
    procedure imgVakil2SignDblClick(Sender: TObject);

  private
    { Private declarations }
    Flag, Flag2,
    proxiIdx : Byte;
    PictureName : String;
    PictureNameChanged : Boolean;
//    tempPictureName : String; //kaveh
    PictureNameSec : String; //kaveh
    SignPictureName : String;
    SignPictureNameChanged : Boolean;
//    tempSignPictureName : String;//kaveh
    SignPictureNameSec : String; //kaveh

    VakilPictureName : String;
    VakilPictureNameChanged : Boolean;
    VakilSignPictureName : String;
    VakilSignPictureNameChanged : Boolean;
    Vakil2PictureName : String;
    Vakil2PictureNameChanged : Boolean;
    Vakil2SignPictureName : String;
    Vakil2SignPictureNameChanged : Boolean;
    ErrRec : Boolean;
    RecSaved : Boolean;
    procedure ReOpenTable;
    procedure FormInEdit(vis : Boolean);
    procedure ClearScrFields;
    procedure ClearPeScrFields;
    procedure SetScrFields{(iRecNo : Integer)};
    procedure SetPeScrFields; //kaveh
    function  AreValidFields : Boolean;
    procedure AddRecToDB(DBName, data : String);
    procedure DelRecFromDB(DBName, FldName, data : String);
    procedure LoadFreeBoxes(code : integer);
    procedure Statistic;
    function  chgComponentsEnabled(TF1, TF2, TF3 : boolean):Boolean; //kaveh
  public
    boxNo : integer;
  end;

  Tcode = class(Tobject)
    Id : integer;
    Place : string;
    BoxType : integer;
  end;

implementation

uses
  Search, Funcs, MakeDB, Math,MF_cmd;

{$R *.DFM}

procedure TfrmPersons.RadioButton1Click(Sender: TObject);
{var
  tbl : TADOQuery; }
begin
{  tbl := adoQryPrs;
  if RadioButton1.Checked then
  begin
    if Flag = MB_NEW then
    begin
      txtSignName2.Caption := txtName.Text;
      txtSignFamily2.Caption := txtFamily.Text;
      txtSignIDNO2.Caption := txtIDNO.Text;
      txtSignContractNo2.Caption := txtContractNo.Text;
      if (SignPictureName <> '') and FileExists(SignPictureName)
      then begin
        imgSign.Picture.LoadFromFile(SignPictureName);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
      end
      else
        imgSign.Picture.Bitmap := nil;      
    end
    else if Flag = MB_EDIT then
    begin
      txtSignName2.Caption := tbl.FieldByName('P_Name').AsString;
      txtSignFamily2.Caption := tbl.FieldByName('P_Family').AsString;
      txtSignIDNO2.Caption := tbl.FieldByName('P_IDNo').AsString;
      txtSignContractNo2.Caption := tbl.FieldByName('P_ContractNo').AsString;
      if (tbl.FieldByName('p_SignPicture').AsString <> '') then
        SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + tbl.FieldByName('p_SignPicture').AsString;
      if (SignPictureName <> '') and FileExists(SignPictureName)
      then begin
        imgSign.Picture.LoadFromFile(SignPictureName);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
      end
      else
        imgSign.Picture.Bitmap := nil;
    end;
  end
  else if RadioButton4.Checked then
  begin
    if Flag = MB_NEW then
    begin
//      txtSignName2.Caption := txtNameSec.Text;
//      txtSignFamily2.Caption := txtFamilySec.Text;
//      txtSignIDNO2.Caption := txtIDNOSec.Text;
      txtSignContractNo2.Caption := txtContractNo.Text;
      if (SignPictureNameSec <> '') and FileExists(SignPictureNameSec)
      then begin
        imgSign.Picture.LoadFromFile(SignPictureNameSec);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
      end
      else
        imgSign.Picture.Bitmap := nil;      
    end
    else if Flag = MB_EDIT then
    begin
      txtSignName2.Caption := tbl.FieldByName('P_Name_Sec').AsString;
      txtSignFamily2.Caption := tbl.FieldByName('P_Family_Sec').AsString;
      txtSignIDNO2.Caption := tbl.FieldByName('P_IDNo_Sec').AsString;
      txtSignContractNo2.Caption := tbl.FieldByName('P_ContractNo').AsString;
      if (tbl.FieldByName('p_SignPicture_Sec').AsString <> '') then
        SignPictureNameSec := g_options.ProgramPath + PICTURE_PATH + '\' + tbl.FieldByName('p_SignPicture_Sec').AsString;
      if (SignPictureNameSec <> '') and FileExists(SignPictureNameSec)
      then begin
        imgSign.Picture.LoadFromFile(SignPictureNameSec);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
      end
      else
        imgSign.Picture.Bitmap := nil;
    end;
  end
  else if RadioButton2.Checked then
  begin
    if Flag = MB_NEW then
    begin
      txtSignName2.Caption := txtV1Name.Text;
      txtSignFamily2.Caption := txtV1Family.Text;
      txtSignIDNO2.Caption := txtV1IdNo.Text;
      txtSignContractNo2.Caption := txtV1ProxyID.Text;
      if (VakilSignPictureName <> '') and FileExists(VakilSignPictureName)
      then begin
        imgSign.Picture.LoadFromFile(VakilSignPictureName);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
      end
      else
        imgSign.Picture.Bitmap := nil;
    end
    else if Flag = MB_EDIT then
    begin
      txtSignName2.Caption := adoTblProxy.FieldByName('P_V1Name').AsString;
      txtSignFamily2.Caption := adoTblProxy.FieldByName('P_V1Family').AsString;
      txtSignIDNO2.Caption := adoTblProxy.FieldByName('P_V1IDNo').AsString;
      txtSignContractNo2.Caption := adoTblProxy.FieldByName('P_V1ProxyID').AsString;
      if (adoTblProxy.FieldByName('P_V1SignPicture').AsString <> '') then
        VakilSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + adoTblProxy.FieldByName('P_V1SignPicture').AsString;
      if (VakilSignPictureName <> '') and FileExists(VakilSignPictureName)
      then begin
        imgSign.Picture.LoadFromFile(VakilSignPictureName);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
      end
      else
        imgSign.Picture.Bitmap := nil;
    end;
  end
  else if RadioButton3.Checked then
  begin
    if Flag = MB_NEW then
    begin
      txtSignName2.Caption := txtV2Name.Text;
      txtSignFamily2.Caption := txtV2Family.Text;
      txtSignIDNO2.Caption := txtV2IdNo.Text;
      txtSignContractNo2.Caption := txtV2ProxyID.Text;
      if (Vakil2SignPictureName <> '') and FileExists(Vakil2SignPictureName)
      then begin
        imgSign.Picture.LoadFromFile(Vakil2SignPictureName);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
      end
      else
        imgSign.Picture.Bitmap := nil;      
    end
    else if Flag = MB_EDIT then
    begin
      txtSignName2.Caption := adoTblProxy.FieldByName('P_V2Name').AsString;
      txtSignFamily2.Caption := adoTblProxy.FieldByName('P_V2Family').AsString;
      txtSignIDNO2.Caption := adoTblProxy.FieldByName('P_V2IDNo').AsString;
      txtSignContractNo2.Caption := adoTblProxy.FieldByName('P_V2ProxyID').AsString;
      if (adoTblProxy.FieldByName('P_V2SignPicture').AsString <> '') then
        Vakil2SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + adoTblProxy.FieldByName('P_V2SignPicture').AsString;
      if (Vakil2SignPictureName <> '') and FileExists(Vakil2SignPictureName)
      then begin
        imgSign.Picture.LoadFromFile(Vakil2SignPictureName);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
      end
      else
        imgSign.Picture.Bitmap := nil;
    end;
  end;    }
end;

procedure TfrmPersons.ReOpenTable;
var
  s : String;
  boxNoi : integer;
begin
  s := '';
  if txtSrchName.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
//kaveh 1391/02/10    s := s + ' P_Name like ''%' + txtSrchName.Text + '%''';
    s := s + ' nP_Name like ''%' + txtSrchName.Text + '%''';
  end;

  if txtSrchFamily.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
//kaveh 1391/02/10    s := s + ' P_Family like ''%' + txtSrchFamily.Text + '%''';
    s := s + ' np_FAMILY like ''%' + txtSrchFamily.Text + '%''';
  end;

//kaveh 1391/02/10
{
  if cmbSrchBoxNo.itemindex <> -1 then
    boxNoi := (cmbSrchBoxNo.Items.Objects[cmbSrchBoxNo.itemindex] as tcode).id
  else
    boxNoi := -1;

  if boxNoi <> -1 then
  begin
    if s <> '' then s := s + ' AND ';
    s := s + ' p_BoxNo = ' + IntToStr(boxNoi) + '';
  end;
}
//kaveh 1391/02/10
  if cmbSrchBoxNo.Text <> '' then
  begin
    if s <> '' then s := s + ' AND ';
    s := s + ' cCashe like ''%' + cmbSrchBoxNo.Text + '%''';
  end;

  adoQryPrs.Filtered := False;
  adoQryPrs.Filter := s;
  adoQryPrs.Filtered := True;
  Statistic;
end;

procedure TfrmPersons.FormInEdit(vis : Boolean);
var
  i, j : Byte;
begin
  grpAll.Visible := not vis;
  tabInfo.Visible := vis;
  if vis then
  begin
    Height := tabInfo.Height;
    tabInfo.BringToFront;
  end
  else
    Height := grpAll.Height;
  Height := Height + 25;
end;

//kaveh is
function TfrmPersons.chgComponentsEnabled(TF1, TF2, TF3 : boolean):Boolean;
begin
  if TF1 then
  begin
    cmdSave.Enabled := True;
    cmdSave2.Enabled := True;
    cmdSave3.Enabled := True;
    cmdSave4.Enabled := True;
//      txtCode.Enabled := True;
    cmbBoxType.Enabled := True;
    cmbBoxPlace.Enabled := True;
    cmbBoxNo.Enabled := True;
    chkColleague.Enabled := True;
    txtAccountNo.Enabled := True;
    cmbAccountType.Enabled := True;
    txtAccountBranch.Enabled := True;
    txtDeposite.Enabled := True;
    txtContractNo.Enabled := True;
    txtContractDate.Enabled := True;
    txtBimeh.Enabled := True;
    chkLegalCustomer.Enabled := True;
    txtCoName.Enabled := chkLegalCustomer.Checked;
    lblCoName.Enabled := chkLegalCustomer.Checked;
    chkCommonBox.Enabled := True;
    rdoCommonType1.Enabled := chkCommonBox.Checked;
    rdoCommonType2.Enabled := chkCommonBox.Checked;
    rdoCommonType3.Enabled := chkCommonBox.Checked;

    txtV1Name.Enabled := True;
    txtV1Family.Enabled := True;
    txtV1IdNo.Enabled := True;
    txtV1Father.Enabled := True;
    cmbV1FromPlace.Enabled := True;
    txtV1ExpireDate.Enabled := True;
    txtV1ProxyID.Enabled := True;
    txtV1CardNo.Enabled := True;
    imgVakil.Enabled := True;
    imgVakilSign.Enabled := True;
    BitBtn7.Enabled := True;
    txtV2Name.Enabled := True;
    txtV2Family.Enabled := True;
    txtV2IdNo.Enabled := True;
    txtV2Father.Enabled := True;
    cmbV2FromPlace.Enabled := True;
    txtV2ExpireDate.Enabled := True;
    txtV2ProxyID.Enabled := True;
    txtV2CardNo.Enabled := True;
    imgVakil2.Enabled := True;
    imgVakil2Sign.Enabled := True;
    BitBtn9.Enabled := True;

    chkBlock.Enabled := True;
    grpBlock.Enabled := chkBlock.Checked and chkBlock.Enabled;
//    txtBlockDate.Enabled := True and chkBlock.Checked;
//    txtBlockDesc.Enabled := True and chkBlock.Checked;
    chkProvisionalBlock.Enabled := True;
    grpProvisionalBlock.Enabled := chkProvisionalBlock.Checked and chkProvisionalBlock.Enabled;
//    txtProvisionalBlockDate.Enabled := True and chkProvisionalBlock.Checked;
//    txtProvisionalBlockDesc.Enabled := True and chkProvisionalBlock.Checked;

  end
  else
  begin
    cmdSave.Enabled := False;
    cmdSave2.Enabled := False;
    cmdSave3.Enabled := False;
    cmdSave4.Enabled := False;
//      txtCode.Enabled := False;
    cmbBoxType.Enabled := False;
    cmbBoxPlace.Enabled := False;
    cmbBoxNo.Enabled := False;
    chkColleague.Enabled := False;
    txtAccountNo.Enabled := False;
    cmbAccountType.Enabled := False;
    txtAccountBranch.Enabled := False;
    txtDeposite.Enabled := False;
    txtContractNo.Enabled := False;
    txtContractDate.Enabled := False;
    txtBimeh.Enabled := False;
    chkLegalCustomer.Enabled := False;
    txtCoName.Enabled := False;
    lblCoName.Enabled := False;
    chkCommonBox.Enabled := False;
    rdoCommonType1.Enabled := False;
    rdoCommonType2.Enabled := False;
    rdoCommonType3.Enabled := False;

    txtV1Name.Enabled := False;
    txtV1Family.Enabled := False;
    txtV1IdNo.Enabled := False;
    txtV1Father.Enabled := False;
    cmbV1FromPlace.Enabled := False;
    txtV1ExpireDate.Enabled := False;
    txtV1ProxyID.Enabled := False;
    txtV1CardNo.Enabled := False;
    imgVakil.Enabled := False;
    imgVakilSign.Enabled := False;
    BitBtn7.Enabled := False;
    txtV2Name.Enabled := False;
    txtV2Family.Enabled := False;
    txtV2IdNo.Enabled := False;
    txtV2Father.Enabled := False;
    cmbV2FromPlace.Enabled := False;
    txtV2ExpireDate.Enabled := False;
    txtV2ProxyID.Enabled := False;
    txtV2CardNo.Enabled := False;
    imgVakil2.Enabled := False;
    imgVakil2Sign.Enabled := False;
    BitBtn9.Enabled := False;

    chkBlock.Enabled := False;
    grpBlock.Enabled := chkBlock.Checked and chkBlock.Enabled;
//    txtBlockDate.Enabled := False;
//    txtBlockDesc.Enabled := False;
    chkProvisionalBlock.Enabled := False;
    grpProvisionalBlock.Enabled := chkProvisionalBlock.Checked and chkProvisionalBlock.Enabled;
//    txtProvisionalBlockDate.Enabled := False;
//    txtProvisionalBlockDesc.Enabled := False;

  end;
  if TF2 then
  begin
    dbgPPersons.Enabled := True;
    cmdNewP.Enabled := True and TF3;
    cmdEditP.Enabled := True;
    cmdDeleteP.Enabled := True;
  end
  else
  begin
    dbgPPersons.Enabled := False;
    cmdNewP.Enabled := False;
    cmdEditP.Enabled := False;
    cmdDeleteP.Enabled := False;
  end;
  
end;
//kaveh ie

procedure TfrmPersons.ClearScrFields;
begin
  RecSaved := False;
  cmdRevival.Enabled := False;
  txtcode.Text := inttostr(GetNewNumber('persons','p_code'));
  lblBranchCode.Caption := '-' + F_Params.BranchCode;
  txtProxi.Text := '';
  txtName.Text := '';
  txtFamily.Text := '';
  txtIDNo.Text := '';
  txtFather.Text := '';
  txtNation.Text := '';
  cmbMarry.ItemIndex := -1;
  txtPost.Text := '';
  txtBirthDate.Text := '';
  cmbFromPlace.ItemIndex := -1;
  txtAddress.Text := '';
  txtHomeTel.Text := '';
  txtWorkTel.Text := '';
  txtMobile.Text := '';
  txtAccountNo.Text := '';
  cmbBoxNo.ItemIndex := -1;
  cmbBoxPlace.ItemIndex := -1;
  cmbAccountType.ItemIndex := -1;
  txtContractNo.Text := '';
  txtAccountBranch.Text := '';
  txtDeposite.Text := '';
  txtBimeh.Text := '';
  chkColleague.Checked := false;
  cmbBoxType.ItemIndex := -1;
  LoadFreeBoxes(-1);
  txtContractDate.Text := '';
  txtContractEndDate.Text := '';
  PictureName := '';
  SignPictureName := ''; //kaveh
  VakilPictureName := '';
  VakilPictureNameChanged := False;
  VakilSignPictureName := ''; //kaveh
  VakilSignPictureNameChanged := False;
  Vakil2PictureName := '';
  Vakil2PictureNameChanged := False;
  Vakil2SignPictureName := ''; //kaveh
  Vakil2SignPictureNameChanged := False;

  imgPicture.Picture.Bitmap := nil;
  imgVakil.Picture.Bitmap := nil;
  imgVakil2.Picture.Bitmap := nil;
  
  imgVakilSign.Picture.Bitmap := nil;
  imgVakil2Sign.Picture.Bitmap := nil;

        
  PictureNameSec := '';
  SignPictureNameSec := ''; //kaveh

  chkBlock.Checked := false;
  grpBlock.Enabled := false;
  txtBlockDate.Text := '';
  txtBlockDesc.Text := '';

  chkProvisionalBlock.Checked := false;
  grpProvisionalBlock.Enabled := false;
  txtProvisionalBlockDate.Text := '';
  txtProvisionalBlockDesc.Text := '';

  txtV1Name.Text := '';
  txtV1Family.Text := '';
  txtV1IdNo.Text := '';
  txtV1Father.Text := '';
  cmbV1FromPlace.ItemIndex := -1;
  txtV1ExpireDate.Text := '';
  txtV1ProxyID.Text := '';

  txtV2Name.Text := '';
  txtV2Family.Text := '';
  txtV2IdNo.Text := '';
  txtV2Father.Text := '';
  cmbV2FromPlace.ItemIndex := -1;
  txtV2ExpireDate.Text := '';
  txtV2ProxyID.Text := '';

  RadioButton1.Checked := False;
  RadioButton2.Checked := False;
  RadioButton3.Checked := False;
  RadioButton4.Checked := False;
  RadioButton4.Enabled := False;
  txtSignName2.Caption := '';
  txtSignFamily2.Caption := '';
  txtSignIDNO2.Caption := '';
  txtSignContractNo2.Caption := '';
  imgSign.Picture.Bitmap := nil;

  tabInfo.PageIndex := 0;
//kaveh901224  txtProxi.SetFocus;
  if cmbBoxType.Enabled then cmbBoxType.SetFocus;

//  chkCommonBox.Checked := false; //kaveh

  rdoCommonType1.Enabled := False;
  rdoCommonType2.Enabled := False;
  rdoCommonType3.Enabled := False;
  rdoCommonType1.Checked := False;
  rdoCommonType2.Checked := False;
  rdoCommonType3.Checked := False;

  //kaveh is
//  txtNameSec.Text := '';
//  txtFamilySec.Text := '';
//  txtIDNoSec.Text := '';
//  txtFatherSec.Text := '';
//  txtNationSec.Text := '';
//  cmbMarrySec.ItemIndex := -1;
//  txtPostSec.Text := '';
//  txtBirthDateSec.Text := '';
//  cmbFromPlaceSec.ItemIndex := -1;
//  txtAddressSec.Text := '';
//  txtHomeTelSec.Text := '';
//  txtWorkTelSec.Text := '';
//  txtMobileSec.Text := '';

  cmbFromPlace.Items.Clear;
//  cmbFromPlaceSec.Items.Clear;
  cmbV1FromPlace.Items.Clear;
  cmbV2FromPlace.Items.Clear;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT c_Name FROM Cities ORDER BY C_Name');
    Open;
    while not EOF do
    begin
      cmbFromPlace.Items.Add(FieldByName('C_Name').AsString);
//      cmbFromPlaceSec.Items.Add(FieldByName('C_Name').AsString); //kaveh
      cmbV1FromPlace.Items.Add(FieldByName('C_Name').AsString);
      cmbV2FromPlace.Items.Add(FieldByName('C_Name').AsString);
      Next;
    end;
    Close;
  end;

  with adoQryPrs2 do
  begin
    Connection := frmDBS.DBConnection;
    SQL.clear;

//kaveh 1391/02/10    adoQryPrs.SQL.Add('select * from persons where p_IsBlocked =0');

    SQL.Add('SELECT * from nPersons ');
    SQL.Add('where np_code = ''' + txtCode.Text + ''' ');
//    SQL.Add('order by p_code ');
    Open;
  end;

  chkLegalCustomer.Checked := False;
  lblCoName.Enabled := False;
  txtCoName.Enabled := False;
  txtCoName.Text := '';

  cmdNewP.Enabled := False;
  cmdEditP.Enabled := False;
  cmdDeleteP.Enabled := False;

  tabInfo.Refresh;
  //kaveh ie
end;

procedure TfrmPersons.ClearPeScrFields;
begin
//  cmdRevival.Enabled := False;
//  txtcode.Text := inttostr(GetNewNumber('persons','p_code'));
  txtProxi.Text := '';
  txtName.Text := '';
  txtFamily.Text := '';
  txtIDNo.Text := '';
  txtFather.Text := '';
  txtNation.Text := '';
  cmbMarry.ItemIndex := -1;
  txtPost.Text := '';
  txtBirthDate.Text := '';
  cmbFromPlace.ItemIndex := -1;
  txtAddress.Text := '';
  txtHomeTel.Text := '';
  txtWorkTel.Text := '';
  txtMobile.Text := '';
//  txtAccountNo.Text := '';
//  cmbBoxNo.ItemIndex := -1;
//  cmbBoxPlace.ItemIndex := -1;
//  cmbAccountType.ItemIndex := -1;
//  txtContractNo.Text := '';
//  txtAccountBranch.Text := '';
//  txtDeposite.Text := '';
//  txtBimeh.Text := '';
//  chkColleague.Checked := false;
//  cmbBoxType.ItemIndex := -1;
//  LoadFreeBoxes(-1);
//  txtContractDate.Text := '';
//  txtContractEndDate.Text := '';
  PictureName := '';
  PictureNameChanged := False;
  SignPictureName := ''; //kaveh
  SignPictureNameChanged := False;

//  VakilPictureName := '';
//  VakilSignPictureName := ''; //kaveh
//  Vakil2PictureName := '';
//  Vakil2SignPictureName := ''; //kaveh
  imgPicture.Picture.Bitmap := nil;
  imgSign.Picture.Bitmap := nil;
  lblLastKey.Caption := '';

  chkMemberCommonBoxType3.Checked := False;
//  imgVakil.Picture.Bitmap := nil;
//  imgVakil2.Picture.Bitmap := nil;

//  PictureNameSec := '';
//  SignPictureNameSec := ''; //kaveh

//  chkBlock.Checked := false;
//  grpBlock.Enabled := false;
//  txtBlockDate.Text := '';
//  txtBlockDesc.Text := '';

//  chkProvisionalBlock.Checked := false;
//  grpProvisionalBlock.Enabled := false;
//  txtProvisionalBlockDate.Text := '';
//  txtProvisionalBlockDesc.Text := '';

//  txtV1Name.Text := '';
//  txtV1Family.Text := '';
//  txtV1IdNo.Text := '';
//  txtV1Father.Text := '';
//  cmbV1FromPlace.ItemIndex := -1;
//  txtV1ExpireDate.Text := '';
//  txtV1ProxyID.Text := '';

//  txtV2Name.Text := '';
//  txtV2Family.Text := '';
//  txtV2IdNo.Text := '';
//  txtV2Father.Text := '';
//  cmbV2FromPlace.ItemIndex := -1;
//  txtV2ExpireDate.Text := '';
//  txtV2ProxyID.Text := '';

//  RadioButton1.Checked := False;
//  RadioButton2.Checked := False;
//  RadioButton3.Checked := False;
//  RadioButton4.Checked := False;
//  RadioButton4.Enabled := False;
//  txtSignName2.Caption := '';
//  txtSignFamily2.Caption := '';
//  txtSignIDNO2.Caption := '';
//  txtSignContractNo2.Caption := '';
//  imgSign.Picture.Bitmap := nil;

//  tabInfo.PageIndex := 0;
  txtProxi.SetFocus;
//  cmbBoxType.SetFocus;

//  chkCommonBox.Checked := false; //kaveh

  //kaveh is
//  txtNameSec.Text := '';
//  txtFamilySec.Text := '';
//  txtIDNoSec.Text := '';
//  txtFatherSec.Text := '';
//  txtNationSec.Text := '';
//  cmbMarrySec.ItemIndex := -1;
//  txtPostSec.Text := '';
//  txtBirthDateSec.Text := '';
//  cmbFromPlaceSec.ItemIndex := -1;
//  txtAddressSec.Text := '';
//  txtHomeTelSec.Text := '';
//  txtWorkTelSec.Text := '';
//  txtMobileSec.Text := '';

  cmbFromPlace.Items.Clear;
//  cmbFromPlaceSec.Items.Clear;
//  cmbV1FromPlace.Items.Clear;
//  cmbV2FromPlace.Items.Clear;
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT c_Name FROM Cities ORDER BY C_Name');
    Open;
    while not EOF do
    begin
      cmbFromPlace.Items.Add(FieldByName('C_Name').AsString);
//      cmbFromPlaceSec.Items.Add(FieldByName('C_Name').AsString); //kaveh
//      cmbV1FromPlace.Items.Add(FieldByName('C_Name').AsString);
//      cmbV2FromPlace.Items.Add(FieldByName('C_Name').AsString);
      Next;
    end;
    Close;
  end;

//  tabInfo.Refresh;
  //kaveh ie
end;

procedure TfrmPersons.SetScrFields{(iRecNo : Integer)};
var
  tbl, tempQry : TADOQuery;
  i : integer;
begin
  tbl := adoQryPrs;
  with tbl do
  begin
{    if iRecNo <> -1 then
    begin
      tbl.RecNo := iRecNo;
      adoQryPrs.RecNo := iRecNo;
    end; }

//kaveh 1391/02/10    SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_SignPicture').AsString; //kaevh
//kaveh 1391/02/10    SignPictureNameSec := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_SignPicture_Sec').AsString; //kaevh

    txtCode.Text := FieldByName('P_Code').AsString;

    adoQryPrs2.Connection := frmDBS.DBConnection;
    adoQryPrs2.SQL.clear;

//kaveh 1391/02/10    adoQryPrs.SQL.Add('select * from persons where p_IsBlocked =0');

    adoQryPrs2.SQL.Add('SELECT * from nPersons ');
    adoQryPrs2.SQL.Add('where np_code = ''' + FieldByName('P_Code').AsString + ''' ');
//    SQL.Add('order by p_code ');
    adoQryPrs2.Open;

//kaveh 1391/02/10    txtProxi.Text := FieldByName('P_Proxi').AsString;
//kaveh 1391/02/10    txtName.Text := FieldByName('P_Name').AsString;
//kaveh 1391/02/10    txtFamily.Text := FieldByName('P_Family').AsString;
//kaveh 1391/02/10    txtIDNo.Text := FieldByName('P_IDNo').AsString;
//kaveh 1391/02/10    txtFather.Text := FieldByName('P_Father').AsString;
//kaveh 1391/02/10    txtNation.Text := FieldByName('P_Nation').AsString;
//kaveh 1391/02/10    cmbMarry.ItemIndex := FieldByName('P_IsMarried').Asinteger;
//kaveh 1391/02/10    txtPost.Text := FieldByName('P_Post').AsString;
//kaveh 1391/02/10    txtBirthDate.Text := FieldByName('P_BirthDate').AsString;
//kaveh 1391/02/10    cmbFromPlace.Text := FieldByName('P_BirthPlace').AsString;
//kaveh 1391/02/10    txtAddress.Text := FieldByName('P_Address').AsString;
//kaveh 1391/02/10    txtHomeTel.Text := FieldByName('P_HomeTel').AsString;
//kaveh 1391/02/10    txtWorkTel.Text := FieldByName('P_WorkTel').AsString;
//kaveh 1391/02/10    txtMobile.Text := FieldByName('P_Mobile').AsString;
    txtAccountNo.Text := FieldByName('P_AccountNo').AsString;
    LoadFreeBoxes(adoQryPrs.FieldByName('p_BoxNo').AsInteger);

    //kaveh is

    chkCommonBox.Checked := FieldByName('p_IsCommonBox').AsBoolean; //kaveh

//kaveh 1391/02/10
    rdoCommonType1.Enabled := chkCommonBox.Checked and chkCommonBox.Enabled;
    rdoCommonType2.Enabled := chkCommonBox.Checked and chkCommonBox.Enabled;
    rdoCommonType3.Enabled := chkCommonBox.Checked and chkCommonBox.Enabled;
    if chkCommonBox.Checked then
    begin
      case FieldByName('p_CommonBoxType').AsInteger of
        0:  rdoCommonType1.Checked := True;
        1:  rdoCommonType2.Checked := True;
        2:  rdoCommonType3.Checked := True;
        else  rdoCommonType2.Checked := True;
      end;
//      txtNameSec.Text := FieldByName('P_Name_Sec').AsString;
//      txtFamilySec.Text := FieldByName('P_Family_Sec').AsString;
//      txtIDNoSec.Text := FieldByName('P_IDNo_Sec').AsString;
//      txtFatherSec.Text := FieldByName('P_Father_Sec').AsString;
//      txtNationSec.Text := FieldByName('P_Nation_Sec').AsString;
//      cmbMarrySec.ItemIndex := FieldByName('P_IsMarried_Sec').Asinteger;
//      txtPostSec.Text := FieldByName('P_Post_Sec').AsString;
//      txtBirthDateSec.Text := FieldByName('P_BirthDate_Sec').AsString;
//      cmbFromPlaceSec.Text := FieldByName('P_BirthPlace_Sec').AsString;
//      txtAddressSec.Text := FieldByName('P_Address_Sec').AsString;
//      txtHomeTelSec.Text := FieldByName('P_HomeTel_Sec').AsString;
//      txtWorkTelSec.Text := FieldByName('P_WorkTel_Sec').AsString;
//      txtMobileSec.Text := FieldByName('P_Mobile_Sec').AsString;
//      PictureNameSec := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_Picture_Sec').AsString;
    end

    else
    begin
      rdoCommonType1.Checked := False;
      rdoCommonType2.Checked := False;
      rdoCommonType3.Checked := False;
//      txtNameSec.Text := '';
//      txtFamilySec.Text := '';
//      txtIDNoSec.Text := '';
//      txtFatherSec.Text := '';
//      txtNationSec.Text := '';
//      cmbMarrySec.ItemIndex := -1;
//      txtPostSec.Text := '';
//      txtBirthDateSec.Text := '';
//      cmbFromPlaceSec.ItemIndex := -1;
//      txtAddressSec.Text := '';
//      txtHomeTelSec.Text := '';
//      txtWorkTelSec.Text := '';
//      txtMobileSec.Text := '';
//      PictureNameSec := '';
    end;
//    if (PictureNameSec <> '') and FileExists(PictureNameSec)
//    then begin
//      imgPictureSec.Picture.LoadFromFile(PictureNameSec);
//      imgPictureSec.Width:=round(imgPictureSec.Height*imgPictureSec.Picture.Width/imgPictureSec.Picture.Height);
//    end
//    else
//      imgPictureSec.Picture.Bitmap := nil;

//kaveh 1391/02/10
    //kaveh ie

    cmbBoxNo.ItemIndex := -1;
    boxNo := FieldByName('P_BoxNo').asinteger;
    for i := 0 to cmbBoxNo.Items.Count - 1 do
    begin
      if (cmbBoxNo.Items.Objects[i] as tcode).id = FieldByName('P_BoxNo').asinteger then
      begin
        cmbBoxNo.ItemIndex := i;
        Break;
      end;
    end;

    cmbBoxPlace.ItemIndex := -1;
    if cmbBoxNo.ItemIndex <> -1 then
      for i := 0 to cmbBoxPlace.Items.Count - 1 do
        if (cmbBoxNo.Items.Objects[cmbBoxNo.ItemIndex] as tcode).Place = cmbBoxPlace.Items[i] then
        begin
          cmbBoxPlace.ItemIndex := i;
          Break;
        end;

    if cmbBoxNo.ItemIndex <> -1 then
      cmbBoxNo.OnChange(self);
    cmbAccountType.ItemIndex := FieldByName('P_AccountType').AsInteger;
    txtContractNo.Text := FieldByName('P_ContractNo').AsString;
    txtAccountBranch.Text := FieldByName('P_AccountBranch').AsString;
    txtDeposite.Text := FieldByName('P_Deposite').AsString;
    txtBimeh.Text := FieldByName('P_Bimeh').AsString;


    txtContractDate.Text := FieldByName('P_ContractDate').AsString;
    txtContractEndDate.Text := FieldByName('P_ContractEndDate').AsString;

//kaveh 1391/02/10
{
    PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_Picture').AsString;
    if (PictureName <> '') and FileExists(PictureName)
    then begin
      imgPicture.Picture.LoadFromFile(PictureName);
      imgPicture.Width:=round(imgPicture.Height*imgPicture.Picture.Width/imgPicture.Picture.Height);
    end
    else
      imgPicture.Picture.Bitmap := nil;
}
//kaveh 1391/02/10

    chkColleague.Checked := FieldByName('P_IsColleague').AsBoolean;
    chkBlock.Checked := FieldByName('P_IsBlocked').AsBoolean;
    if chkBlock.Checked then
    begin
      txtBlockDate.Text := FieldByName('P_BlockDate').AsString;
      txtBlockDesc.Text := FieldByName('P_BlockDesc').AsString;
    end;
//kaveh is
    chkProvisionalBlock.Checked := FieldByName('P_IsProvisionalBlocked').AsBoolean;
    if chkProvisionalBlock.Checked then
    begin
      txtProvisionalBlockDate.Text := FieldByName('P_ProvisionalBlockDate').AsString;
      txtProvisionalBlockDesc.Text := FieldByName('P_ProvisionalBlockDesc').AsString;
    end;
//kaveh ie
    tabInfo.PageIndex := 0;
//kaveh901224   txtProxi.SetFocus;

    chkLegalCustomer.Checked := FieldByName('p_IsLegalCustomer').AsBoolean;
    txtCoName.Text := FieldByName('p_CoName').AsString;

    tempQry := TADOQuery.Create(Application);
//    with  do
//    begin
    tempQry.Connection := frmDBS.DBConnection;
    tempQry.SQL.Clear;

    tempQry.SQL.Add('select * from nProxies ');
    tempQry.SQL.Add('where nP_CustomerCode = ''' + FieldByName('P_Code').AsString + ''' ');
    tempQry.SQL.Add('order by np_VProxi ');
    tempQry.Open;
//      tempQry.SQL.Add(' ');
    while not tempQry.Eof do
    begin
      if tempQry.FieldByName('np_VProxi').AsString = '1' then
      begin
        txtV1Name.Text := tempQry.FieldByName('nP_VName').AsString;
        txtV1Family.Text := tempQry.FieldByName('nP_VFamily').AsString;
        txtV1IdNo.Text := tempQry.FieldByName('nP_VIDNo').AsString;
        txtV1Father.Text := tempQry.FieldByName('nP_VFather').AsString;
        cmbV1FromPlace.Text := tempQry.FieldByName('nP_VBirthPlace').AsString;
        txtV1ExpireDate.Text := tempQry.FieldByName('nP_VExpireDate').AsString;
        txtV1ProxyID.Text := tempQry.FieldByName('nP_VProxyID').AsString;
        VakilPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + tempQry.FieldByName('nP_VPicture').AsString;
        VakilSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + tempQry.FieldByName('np_VSignPicture').AsString; //kaveh
        if (VakilPictureName <> '') and FileExists(VakilPictureName) then
        begin
          imgVakil.Picture.LoadFromFile(VakilPictureName);
          imgVakil.Width:=round(imgVakil.Height*imgVakil.Picture.Width/imgVakil.Picture.Height);
        end
        else
          imgVakil.Picture.Bitmap := nil;
        if (VakilSignPictureName <> '') and FileExists(VakilSignPictureName) then
        begin
          imgVakilSign.Picture.LoadFromFile(VakilSignPictureName);
          imgVakilSign.Width:=round(imgVakilSign.Height*imgVakilSign.Picture.Width/imgVakilSign.Picture.Height);
        end
        else
          imgVakilSign.Picture.Bitmap := nil;

      end
      else if tempQry.FieldByName('np_VProxi').AsString = '2' then
      begin
        txtV2Name.Text := tempQry.FieldByName('nP_VName').AsString;
        txtV2Family.Text := tempQry.FieldByName('nP_VFamily').AsString;
        txtV2IdNo.Text := tempQry.FieldByName('nP_VIDNo').AsString;
        txtV2Father.Text := tempQry.FieldByName('nP_VFather').AsString;
        cmbV2FromPlace.Text := tempQry.FieldByName('nP_VBirthPlace').AsString;
        txtV2ExpireDate.Text := tempQry.FieldByName('nP_VExpireDate').AsString;
        txtV2ProxyID.Text := tempQry.FieldByName('nP_VProxyID').AsString;
        Vakil2PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + tempQry.FieldByName('nP_VPicture').AsString;
        Vakil2SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + tempQry.FieldByName('np_VSignPicture').AsString; //kaveh
        if (Vakil2PictureName <> '') and FileExists(Vakil2PictureName) then
        begin
          imgVakil2.Picture.LoadFromFile(Vakil2PictureName);
          imgVakil2.Width:=round(imgVakil2.Height*imgVakil2.Picture.Width/imgVakil2.Picture.Height);
        end
        else
          imgVakil2.Picture.Bitmap := nil;
        if (Vakil2SignPictureName <> '') and FileExists(Vakil2SignPictureName) then
        begin
          imgVakil2Sign.Picture.LoadFromFile(Vakil2SignPictureName);
          imgVakil2Sign.Width:=round(imgVakil2Sign.Height*imgVakil2Sign.Picture.Width/imgVakil2Sign.Picture.Height);
        end
        else
          imgVakil2Sign.Picture.Bitmap := nil;
      
      end;
           
      tempQry.Next;
    end;
      
    tempQry.ExecSQL;
    tempQry.close;
    tempQry.free;

//    end;






  end;

  if cmbBoxType.Enabled then cmbBoxType.SetFocus;
  {
  with adoTblProxy do
  begin
    if not eof then
    begin
      txtV1Name.Text := FieldByName('P_V1Name').AsString;
      txtV1Family.Text := FieldByName('P_V1Family').AsString;
      txtV1IdNo.Text := FieldByName('P_V1IDNo').AsString;
      txtV1Father.Text := FieldByName('P_V1Father').AsString;
      cmbV1FromPlace.Text := FieldByName('P_V1BirthPlace').AsString;
      txtV1ExpireDate.Text := FieldByName('P_V1ExpireDate').AsString;
      txtV1ProxyID.Text := FieldByName('P_V1ProxyID').AsString;
      VakilSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_V1SignPicture').AsString; //kaveh     
      VakilPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_V1Picture').AsString;
      if (VakilPictureName <> '') and FileExists(VakilPictureName)
      then begin
        imgVakil.Picture.LoadFromFile(VakilPictureName);
        imgVakil.Width:=round(imgVakil.Height*imgVakil.Picture.Width/imgVakil.Picture.Height);
      end
      else
        imgVakil.Picture.Bitmap := nil;

      txtV2Name.Text := FieldByName('P_V2Name').AsString;
      txtV2Family.Text := FieldByName('P_V2Family').AsString;
      txtV2IdNo.Text := FieldByName('P_V2IDNo').AsString;
      txtV2Father.Text := FieldByName('P_V2Father').AsString;
      cmbV2FromPlace.Text := FieldByName('P_V2BirthPlace').AsString;
      txtV2ExpireDate.Text := FieldByName('P_V2ExpireDate').AsString;
      txtV2ProxyID.Text := FieldByName('P_V2ProxyID').AsString;
      Vakil2SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_V2SignPicture').AsString; //kaveh     
      Vakil2PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_V2Picture').AsString;
      if (Vakil2PictureName <> '') and FileExists(Vakil2PictureName)
      then begin
        imgVakil2.Picture.LoadFromFile(Vakil2PictureName);
        imgVakil2.Width:=round(imgVakil2.Height*imgVakil2.Picture.Width/imgVakil2.Picture.Height);
      end
      else
        imgVakil2.Picture.Bitmap := nil;
    end;
  end;
  }

  tabInfo.Refresh;
end;

procedure TfrmPersons.SetPeScrFields;
var
  tbl : TADOQuery;
  i : integer;
begin
  tbl := adoQryPrs2;
  with tbl do
  begin

//kaveh 1391/02/10    SignPictureNameSec := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_SignPicture_Sec').AsString; //kaevh

//    txtCode.Text := FieldByName('P_Code').AsString;
    txtProxi.Text := FieldByName('nP_Proxi').AsString;
    txtName.Text := FieldByName('nP_Name').AsString;
    txtFamily.Text := FieldByName('nP_Family').AsString;
    txtIDNo.Text := FieldByName('nP_IDNo').AsString;
    txtFather.Text := FieldByName('nP_Father').AsString;
    txtNation.Text := FieldByName('nP_Nation').AsString;
    cmbMarry.ItemIndex := FieldByName('nP_IsMarried').Asinteger;
    txtPost.Text := FieldByName('nP_Post').AsString;
    txtBirthDate.Text := FieldByName('nP_BirthDate').AsString;
    cmbFromPlace.Text := FieldByName('nP_BirthPlace').AsString;
    txtAddress.Text := FieldByName('nP_Address').AsString;
    txtHomeTel.Text := FieldByName('nP_HomeTel').AsString;
    txtWorkTel.Text := FieldByName('nP_WorkTel').AsString;
    txtMobile.Text := FieldByName('nP_Mobile').AsString;
//    txtAccountNo.Text := FieldByName('P_AccountNo').AsString;
//    LoadFreeBoxes(adoQryPrs.FieldByName('p_BoxNo').AsInteger);

    //kaveh is

//    chkCommonBox.Checked := FieldByName('p_IsCommonBox').AsBoolean; //kaveh

//kaveh 1391/02/10
{
    if chkCommonBox.Checked then
    begin

      txtNameSec.Text := FieldByName('P_Name_Sec').AsString;
      txtFamilySec.Text := FieldByName('P_Family_Sec').AsString;
      txtIDNoSec.Text := FieldByName('P_IDNo_Sec').AsString;
      txtFatherSec.Text := FieldByName('P_Father_Sec').AsString;
      txtNationSec.Text := FieldByName('P_Nation_Sec').AsString;
      cmbMarrySec.ItemIndex := FieldByName('P_IsMarried_Sec').Asinteger;
      txtPostSec.Text := FieldByName('P_Post_Sec').AsString;
      txtBirthDateSec.Text := FieldByName('P_BirthDate_Sec').AsString;
      cmbFromPlaceSec.Text := FieldByName('P_BirthPlace_Sec').AsString;
      txtAddressSec.Text := FieldByName('P_Address_Sec').AsString;
      txtHomeTelSec.Text := FieldByName('P_HomeTel_Sec').AsString;
      txtWorkTelSec.Text := FieldByName('P_WorkTel_Sec').AsString;
      txtMobileSec.Text := FieldByName('P_Mobile_Sec').AsString;
      PictureNameSec := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_Picture_Sec').AsString;
    end
    else
    begin
      txtNameSec.Text := '';
      txtFamilySec.Text := '';
      txtIDNoSec.Text := '';
      txtFatherSec.Text := '';
      txtNationSec.Text := '';
      cmbMarrySec.ItemIndex := -1;
      txtPostSec.Text := '';
      txtBirthDateSec.Text := '';
      cmbFromPlaceSec.ItemIndex := -1;
      txtAddressSec.Text := '';
      txtHomeTelSec.Text := '';
      txtWorkTelSec.Text := '';
      txtMobileSec.Text := '';
      PictureNameSec := '';
    end;
    if (PictureNameSec <> '') and FileExists(PictureNameSec)
    then begin
      imgPictureSec.Picture.LoadFromFile(PictureNameSec);
      imgPictureSec.Width:=round(imgPictureSec.Height*imgPictureSec.Picture.Width/imgPictureSec.Picture.Height);
    end
    else
      imgPictureSec.Picture.Bitmap := nil;
}
//kaveh 1391/02/10
    //kaveh ie

//    cmbBoxNo.ItemIndex := -1;
//    boxNo := FieldByName('P_BoxNo').asinteger;
//    for i := 0 to cmbBoxNo.Items.Count - 1 do
//    begin
//      if (cmbBoxNo.Items.Objects[i] as tcode).id = FieldByName('P_BoxNo').asinteger then
//      begin
//        cmbBoxNo.ItemIndex := i;
//        Break;
//      end;
//    end;
//
//    cmbBoxPlace.ItemIndex := -1;
//    if cmbBoxNo.ItemIndex <> -1 then
//      for i := 0 to cmbBoxPlace.Items.Count - 1 do
//        if (cmbBoxNo.Items.Objects[cmbBoxNo.ItemIndex] as tcode).Place = cmbBoxPlace.Items[i] then
//        begin
//          cmbBoxPlace.ItemIndex := i;
//          Break;
//        end;

//    if cmbBoxNo.ItemIndex <> -1 then
//      cmbBoxNo.OnChange(self);
//    cmbAccountType.ItemIndex := FieldByName('P_AccountType').AsInteger;
//    txtContractNo.Text := FieldByName('P_ContractNo').AsString;
//    txtAccountBranch.Text := FieldByName('P_AccountBranch').AsString;
//    txtDeposite.Text := FieldByName('P_Deposite').AsString;
//    txtBimeh.Text := FieldByName('P_Bimeh').AsString;


//    txtContractDate.Text := FieldByName('P_ContractDate').AsString;
//    txtContractEndDate.Text := FieldByName('P_ContractEndDate').AsString;

    PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('nP_Picture').AsString;
    if (PictureName <> '') and FileExists(PictureName)
    then begin
      imgPicture.Picture.LoadFromFile(PictureName);
      imgPicture.Width:=round(imgPicture.Height*imgPicture.Picture.Width/imgPicture.Picture.Height);
    end
    else
      imgPicture.Picture.Bitmap := nil;


    SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('np_SignPicture').AsString; //kaevh
//
//    PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('nP_Picture').AsString;
    if (SignPictureName <> '') and FileExists(SignPictureName)
    then begin
      imgSign.Picture.LoadFromFile(SignPictureName);
      imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
    end
    else
      imgSign.Picture.Bitmap := nil;

    lblLastKey.Caption := FieldByName('nP_Proxi').AsString + FieldByName('nP_Name').AsString + FieldByName('nP_Family').AsString + FieldByName('nP_IDNo').AsString + FieldByName('nP_Father').AsString;

    chkMemberCommonBoxType3.Checked := FieldByName('np_IsMemberCommonBoxType3').AsBoolean; //kaveh
        
//    chkColleague.Checked := FieldByName('P_IsColleague').AsBoolean;
//    chkBlock.Checked := FieldByName('P_IsBlocked').AsBoolean;
//    if chkBlock.Checked then
//    begin
//      txtBlockDate.Text := FieldByName('P_BlockDate').AsString;
//      txtBlockDesc.Text := FieldByName('P_BlockDesc').AsString;
//    end;
//kaveh is
//    chkProvisionalBlock.Checked := FieldByName('P_IsProvisionalBlocked').AsBoolean;
//    if chkProvisionalBlock.Checked then
//    begin
//      txtProvisionalBlockDate.Text := FieldByName('P_ProvisionalBlockDate').AsString;
//      txtProvisionalBlockDesc.Text := FieldByName('P_ProvisionalBlockDesc').AsString;
//    end;
//kaveh ie
//    tabInfo.PageIndex := 0;
//kaveh901224   txtProxi.SetFocus;
  end;


//  with adoQryPrs2 do
//  begin
//    Connection := frmDBS.DBConnection;
//    SQL.clear;
//
////kaveh 1391/02/10    adoQryPrs.SQL.Add('select * from persons where p_IsBlocked =0');
//
//    SQL.Add('SELECT * from nPersons ');
//    SQL.Add('where np_code = ''' + txtCode.Text + ''' ');
////    SQL.Add('order by p_code ');
//    Open;
//  end;
  txtProxi.SetFocus;

{
  with adoTblProxy do
  begin
    if not eof then
    begin
      txtV1Name.Text := FieldByName('P_V1Name').AsString;
      txtV1Family.Text := FieldByName('P_V1Family').AsString;
      txtV1IdNo.Text := FieldByName('P_V1IDNo').AsString;
      txtV1Father.Text := FieldByName('P_V1Father').AsString;
      cmbV1FromPlace.Text := FieldByName('P_V1BirthPlace').AsString;
      txtV1ExpireDate.Text := FieldByName('P_V1ExpireDate').AsString;
      txtV1ProxyID.Text := FieldByName('P_V1ProxyID').AsString;
      VakilSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_V1SignPicture').AsString; //kaveh     
      VakilPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_V1Picture').AsString;
      if (VakilPictureName <> '') and FileExists(VakilPictureName)
      then begin
        imgVakil.Picture.LoadFromFile(VakilPictureName);
        imgVakil.Width:=round(imgVakil.Height*imgVakil.Picture.Width/imgVakil.Picture.Height);
      end
      else
        imgVakil.Picture.Bitmap := nil;

      txtV2Name.Text := FieldByName('P_V2Name').AsString;
      txtV2Family.Text := FieldByName('P_V2Family').AsString;
      txtV2IdNo.Text := FieldByName('P_V2IDNo').AsString;
      txtV2Father.Text := FieldByName('P_V2Father').AsString;
      cmbV2FromPlace.Text := FieldByName('P_V2BirthPlace').AsString;
      txtV2ExpireDate.Text := FieldByName('P_V2ExpireDate').AsString;
      txtV2ProxyID.Text := FieldByName('P_V2ProxyID').AsString;
      Vakil2SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('p_V2SignPicture').AsString; //kaveh     
      Vakil2PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + FieldByName('P_V2Picture').AsString;
      if (Vakil2PictureName <> '') and FileExists(Vakil2PictureName)
      then begin
        imgVakil2.Picture.LoadFromFile(Vakil2PictureName);
        imgVakil2.Width:=round(imgVakil2.Height*imgVakil2.Picture.Width/imgVakil2.Picture.Height);
      end
      else
        imgVakil2.Picture.Bitmap := nil;
    end;
  end;
  tabInfo.Refresh; }
end;

procedure TfrmPersons.Statistic;
var
  a : integer;
begin
  with TADOQuery.Create(Application) do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Add('select 	sum(case p_IsColleague when 1 then 1 else 0 end) as Coleague ,');
    SQL.Add('         sum(case p_IsColleague when 1 then 0 else 1 end) as nonColeague,');
    SQL.Add('         Count(*) as AllCount');
    SQL.Add('from persons');
    SQL.Add('WHERE p_IsBlocked = 0');
    open;
    lblRecCount.Caption         := 'تعداد کل مشتريان  = ' + IntToStr(FieldByName('AllCount').asinteger);
    a := FieldByName('AllCount').asinteger;
    lblColleague.Caption        := 'تعداد همکار     = ' + IntToStr(FieldByName('Coleague').asinteger);
    lblnonColleague.Caption     := 'تعداد غير همکار = ' + IntToStr(FieldByName('nonColeague').asinteger);
    close;
    SQL.clear;
    SQL.Add('select *,smallUnUsed=smallAll-smallUsed,medUnUsed=medAll-medUsed,LargeUnUsed=LargeAll-LargeUsed,AllUnUsed=AllCash-AllUsed from');
    SQL.Add(' (select AllUsed  = sum(case c_type when 0 then 1 else 1 end)');
    SQL.Add('        ,smallUsed= sum(case c_type when 0 then 1 else 0 end)');
    SQL.Add('	       ,medUsed  = sum(case c_type when 1 then 1 else 0 end)');
    SQL.Add('        ,largeUsed= sum(case c_type when 2 then 1 else 0 end)');
    SQL.Add('  from persons,cashes WHERE p_boxNo=c_Code and p_IsBlocked = 0');
    SQL.Add('  )a');
    SQL.Add(' ,(select AllCash = sum(case c_type when 0 then 1 else 1 end)');
    SQL.Add('        , smallAll= sum(case c_type when 0 then 1 else 0 end)');
    SQL.Add('	       , medAll  = sum(case c_type when 1 then 1 else 0 end)');
    SQL.Add('        , largeAll= sum(case c_type when 2 then 1 else 0 end)');
    SQL.Add('   from cashes');
    SQL.Add('  )b');
    open;
    lblBusyBox.Caption := Fixright('صندوقهاي واگذارشده = ' + FieldByName('AllUsed').AsString,' ',32)
                        + Fixright('کوچک :' + FieldByName('smallUsed').asstring,' ',13)
                        + Fixright('متوسط:' +FieldByName('medUsed').asstring,' ',13)
                        + Fixright('بزرگ :' + FieldByName('largeUsed').asstring,' ',13);
    lblFreeBox.Caption := Fixright('صندوقهاي واگذار نشده = ' + FieldByName('AllUnUsed').asstring,' ',32)
                        + Fixright('کوچک :' + FieldByName('smallUnUsed').asstring,' ',13)
                        + Fixright('متوسط:' +FieldByName('medUnUsed').asstring,' ',13)
                        + Fixright('بزرگ :' + FieldByName('largeUnUsed').asstring,' ',13);

    lblAllBox.Caption :=  Fixright('تعداد کل صندوقها = ' + FieldByName('AllCash').asstring,' ',32)
                        + Fixright('کوچک :' + FieldByName('SmallAll').asstring,' ',13)
                        + Fixright('متوسط: '+ FieldByName('medAll').asstring,' ',13)
                        + Fixright('بزرگ :' + FieldByName('LargeAll').asstring,' ',13);

    close;
    free;
  end;
end;

function TfrmPersons.AreValidFields : Boolean;
var
  qry : TADOQuery;
begin
  with adoQryPrs do
  begin
//    if (txtName.Visible) and (txtName.Text = '') then
//    begin
//      AreValidFields := False;
//      ErrorMessage('نام وارد نشده است.');
//      tabInfo.PageIndex := 0;
//      txtName.SetFocus;
//    end
//    else
//
//    if txtFamily.Visible and (txtFamily.Text = '') then
//    begin
//      AreValidFields := False;
//      ErrorMessage('نام خانوادگي وارد نشده است.');
//      tabInfo.PageIndex := 0;
//      txtFamily.SetFocus;
//    end
//    else
    if IsExistsRec_Str('Persons', 'P_Code', FixLeft(txtCode.Text, '0', 8)) and
      ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (FieldByName('P_Code').AsString <> FixLeft(txtCode.Text, '0', 8)))) then
    begin
      AreValidFields := False;
      ErrorMessage('شماره مشتري تكراري است.');
      tabInfo.PageIndex := 0;
      cmdSave.SetFocus;
    end
//    else if IsExistsRec_Str('Persons', 'P_Proxi', FixLeft(txtProxi.Text, '0', 8)) and
//      ((Flag = MB_NEW) or ((Flag = MB_EDIT) and (FieldByName('P_Proxi').AsString <> FixLeft(txtProxi.Text, '0', 8)))) then
//    begin
//      AreValidFields := False;
//      ErrorMessage('شماره كارت تكراري است.');
//      tabInfo.PageIndex := 0;
//      txtProxi.SetFocus;
//    end
    else if (txtContractDate.Text<>'') and not IsTrueDate(txtContractDate.Text)
    then begin
      ErrorMessage('تاريخ اشتباه است');
      tabInfo.PageIndex := 0;
      txtContractDate.SetFocus;
    end
    else if (txtContractEndDate.Text<>'') and not IsTrueDate(txtContractEndDate.Text)
    then begin
      ErrorMessage('تاريخ اشتباه است');
      tabInfo.PageIndex := 0;
      txtContractEndDate.SetFocus;
    end
    else if (txtV1ExpireDate.Text<>'') and not IsTrueDate(txtV1ExpireDate.Text)
    then begin
      ErrorMessage('تاريخ اشتباه است');
      tabInfo.PageIndex := 1;
      txtV1ExpireDate.SetFocus;
    end
    else if (txtV2ExpireDate.Text<>'') and not IsTrueDate(txtV2ExpireDate.Text)
    then begin
      ErrorMessage('تاريخ اشتباه است');
      tabInfo.PageIndex := 2;
      txtV2ExpireDate.SetFocus;
    end
    else if (cmbBoxNo.ItemIndex = -1) then
    begin
      ErrorMessage('صندوق انتخاب نشده است .');
      tabInfo.PageIndex := 1;
      cmbBoxNo.SetFocus;
    end
    else
        AreValidFields := True;
//    begin
//      qry := TADOQuery.Create(Application);
//      qry.Connection := frmDBS.DBConnection;
//      qry.SQL.Add('select p_BoxNo from persons where  p_IsBlocked <> 1 and p_boxNo = ' + IntToStr(boxNo));
//      qry.Open;
//      if not qry.eof then
//      begin
//        ErrorMessage('صندوق مورد نظر اشغال ميباشد . لطفا صندوق ديگري را انتخاب نماييد .');
//        tabInfo.PageIndex := 1;
//        txtV2ExpireDate.SetFocus;
//      end
//      else
//        AreValidFields := True;
//    end;
  end;
end;

procedure TfrmPersons.cmdPCancelClick(Sender: TObject);
begin
  pnlPerson.Align := alNone;
  pnlPerson.Enabled := False;
  pnlPerson.Visible := False;
  tabInfo.Enabled := True;
  tabInfo.Visible := True;
end;

procedure TfrmPersons.cmdPSaveClick(Sender: TObject);
var
  tempQry : TADOQuery;
  nCode : string;
  Saved : Boolean;
  PictureSaved : Boolean;
  SignSaved : Boolean;
  tempPictureName : string;
  tempSignPictureName : string;
//  tempRecNo : Integer;

function AreValidFields2 : Boolean;
//var
//  qry : TADOQuery;
begin
  with adoQryPrs2 do
  begin
    if (txtName.Visible) and (txtName.Text = '') then
    begin
      AreValidFields2 := False;
      ErrorMessage('نام وارد نشده است.');
      tabInfo.PageIndex := 0;
      txtName.SetFocus;
    end
    else

    if txtFamily.Visible and (txtFamily.Text = '') then
    begin
      AreValidFields2 := False;
      ErrorMessage('نام خانوادگي وارد نشده است.');
      tabInfo.PageIndex := 0;
      txtFamily.SetFocus;
    end

    else if IsExistsRec_Str('nPersons', 'nP_Proxi', FixLeft(txtProxi.Text, '0', 8)) and
      ((Flag2 = MB_NEW) or ((Flag2 = MB_EDIT) and (FieldByName('nP_Proxi').AsString <> FixLeft(txtProxi.Text, '0', 8)))) then
    begin
      AreValidFields2 := False;
      ErrorMessage('شماره كارت تكراري است.');
      tabInfo.PageIndex := 0;
      txtProxi.SetFocus;
    end

    else if (txtBirthDate.Text<>'') and not IsTrueDate(txtBirthDate.Text)
    then begin
      AreValidFields2 := False;
      ErrorMessage('تاريخ اشتباه است');
      tabInfo.PageIndex := 0;
      txtBirthDate.SetFocus;
    end
    else
      AreValidFields2 := True;
  end;
end;

begin
  Saved := False;
  PictureSaved := False;
  SignSaved := False;
  tempQry := TADOQuery.Create(Application);
//  tempRecNo := adoQryPrs.RecNo;

  if AreValidFields2 then
  begin
//    frmDBS.adoTblPersons.Close;
//    if Flag2 = MB_NEW then
//    begin
//      bPCode := FixLeft(txtCode.Text, '0', 8);
//    end
//    else if Flag2 = MB_EDIT then
//    begin
//      bPCode := adoQryPrs.FieldByName('P_Code').AsString;
//    end;
    nCode := FixLeft(txtCode.Text, '0', 8);

//    if (copyfile(Pchar(tempPictureName),pchar(PictureName),false))
//    { and (copyfile(Pchar(tempSignPictureName),pchar(SignPictureName),false)) }then

    tempPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + '_' + DelLeftZero(txtProxi.Text) {//kaveh  txtCode.Text } + '.jpg';
    tempSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + '_' + DelLeftZero(txtProxi.Text) {//kaveh  txtCode.Text } + 'S.jpg';

    if PictureNameChanged then
    begin
      if copyfile(Pchar(PictureName),pchar(tempPictureName),false) then
      begin
        PictureSaved := True;
        PictureName := tempPictureName;
      end
      else
      begin
        ErrorMessage('اشکال در کپی تصویر چهره!');
        Saved := False;
        PictureSaved := False;
      end;
    end
    else
      PictureSaved := True;

    if SignPictureNameChanged then
    begin
      if copyfile(Pchar(SignPictureName),pchar(tempSignPictureName),false) then
      begin
        SignSaved := True;
        SignPictureName := tempSignPictureName;
      end
      else
      begin
        ErrorMessage('اشکال در کپی نمونه امضاء!');
        Saved := False;
        SignSaved := False;
      end;
    end
    else
      SignSaved := True;



//    if copyfile(Pchar(PictureName),pchar(tempPictureName),false) then
    if (PictureSaved) and (SignSaved) then
    begin
//      if copyfile(Pchar(SignPictureName),pchar(tempSignPictureName),false) then
//      begin
//      PictureName := tempPictureName;
//      SignPictureName := tempSignPictureName;
      if Flag2 = MB_NEW then
      begin
        with tempQry do
        begin
          Connection := frmDBS.DBConnection;
          SQL.Clear;
          if Flag2 = MB_NEW then
          begin
            SQL.Add('insert into nPersons ');
            SQL.Add('(nP_Code, np_Proxi, np_NAME, np_FAMILY, np_IDNO, nP_Picture, ');
            SQL.Add('np_FATHER, np_NATION, np_IsMarried, np_POST, np_BirthDate, ');
            SQL.Add('np_BirthPlace, np_ADDRESS, np_HomeTel, np_WorkTel, np_MOBILE, ');
            SQL.Add('np_SignPicture, np_IsMemberCommonBoxType3 ');
            SQL.Add(') ');
            SQL.Add('values ');
            SQL.Add('( ''' + nCode + ''', ''' + FixLeft(txtProxi.Text,'0',8) + ''', ''' + txtName.Text + ''', ');
            SQL.Add('''' + txtFamily.Text + ''', ''' + txtIDNO.Text + ''', ''' + ExtractFileName(PictureName) + ''', ');
            SQL.Add('''' + txtFather.Text + ''', ''' + txtNation.Text + ''', ' + IntToStr(cmbMarry.ItemIndex) + ', ');
            SQL.Add('''' + txtPost.Text + ''', ''' + txtBirthDate.Text + ''', ''' + cmbFromPlace.Text + ''', ');
            SQL.Add('''' + txtAddress.Text + ''', ''' + txtHomeTel.Text + ''', ''' + txtWorkTel.Text + ''', ');
            SQL.Add('''' + txtMobile.Text + ''', ''' + ExtractFileName(SignPictureName) + ''', ' + BoolToStr(chkMemberCommonBoxType3.Checked) + ' ');
            SQL.Add(') ');
          end;
          ExecSQL;
          Saved := True;
          close;
          free;
        end;
      end;


      if Flag2 = MB_EDIT then
      begin
        with tempQry do
        begin
          Connection := frmDBS.DBConnection;
          SQL.Clear;
          if Flag2 = MB_EDIT then
          begin
            SQL.Add('Update nPersons set ');
  //          SQL.Add('nP_Code = ''' + nCode + ''', ');
            SQL.Add('np_Proxi = ''' + FixLeft(txtProxi.Text,'0',8) + ''', ');
            SQL.Add('np_NAME = ''' + txtName.Text + ''', ');
            SQL.Add('np_FAMILY = ''' + txtFamily.Text + ''', ');
            SQL.Add('np_IDNO = ''' + txtIDNO.Text + ''', ');
            SQL.Add('nP_Picture = ''' + ExtractFileName(PictureName) + ''', ');
            SQL.Add('np_FATHER = ''' + txtFather.Text + ''', ');
            SQL.Add('np_NATION = ''' + txtNation.Text + ''', ');
            SQL.Add('np_IsMarried = ' + IntToStr(cmbMarry.ItemIndex) + ', ');
            SQL.Add('np_POST = ''' + txtPost.Text + ''', ');
            SQL.Add('np_BirthDate = ''' + txtBirthDate.Text + ''', ');
            SQL.Add('np_BirthPlace = ''' + cmbFromPlace.Text + ''', ');
            SQL.Add('np_ADDRESS = ''' + txtAddress.Text + ''', ');
            SQL.Add('np_HomeTel = ''' + txtHomeTel.Text + ''', ');
            SQL.Add('np_WorkTel = ''' + txtWorkTel.Text + ''', ');
            SQL.Add('np_MOBILE = ''' + txtMobile.Text + ''', ');
            SQL.Add('np_SignPicture = ''' + ExtractFileName(SignPictureName) + ''', ');
            SQL.Add('np_IsMemberCommonBoxType3 = ' + BoolToStr(chkMemberCommonBoxType3.Checked) + ' ');
            SQL.Add('where nP_Code+nP_Proxi+nP_Name+nP_Family+nP_IDNo+nP_Father = ''' + nCode+lblLastKey.Caption + ''' ');

          end;
          ExecSQL;
          Saved := True;
          close;
          free;
        end;
      end;

//      end;
//      else
//      begin
//        ErrorMessage('اشکال در کپی نمونه امضاء!');
//        Saved := False;
//      end;
    end;
//    else
//    begin
//      ErrorMessage('اشکال در کپی تصویر چهره!');
//      Saved := False;
//    end;

  end;
  if Saved then
  begin
//    ClearScrFields;
    pnlPerson.Align := alNone;
    pnlPerson.Enabled := False;
    pnlPerson.Visible := False;
    tabInfo.Enabled := True;
    tabInfo.Visible := True;

//    chgComponentsEnabled(False, True);

    SetScrFields{(tempRecNo)};
  end;
end;

procedure TfrmPersons.BitBtn7Click(Sender: TObject);
begin
  if ConfirmMessage('آيا براي حذف وکيل اول اطمينان داريد؟') then
  begin
    txtV1Name.Text := '';
    txtV1Family.Text := '';
    txtV1IdNo.Text := '';
    txtV1Father.Text := '';
    cmbV1FromPlace.text := '';
    cmbV1FromPlace.ItemIndex := -1;
    txtV1ExpireDate.Text := '';
    txtV1ProxyID.Text := '';
    imgVakil.Picture.Bitmap := nil;
  end;
end;

procedure TfrmPersons.BitBtn9Click(Sender: TObject);
begin
  if ConfirmMessage('آيا براي حذف وکيل دوم اطمينان داريد؟') then
  begin
    txtV2Name.Text := '';
    txtV2Family.Text := '';
    txtV2IdNo.Text := '';
    txtV2Father.Text := '';
    cmbV2FromPlace.text := '';
    cmbV2FromPlace.ItemIndex := -1;
    txtV2ExpireDate.Text := '';
    txtV2ProxyID.Text := '';
    imgVakil2.Picture.Bitmap := nil;
  end;
end;

procedure TfrmPersons.btnGetCardNoClick(Sender: TObject);
var
  cardno : string;
begin
  if Readers[1].R_Type = RDR_CLK6000 then
    if Readers[1].R_IsCom THEN
    begin
      if ComPortInitial(Readers[1]) then
        Z84GetRecord(Readers[1]);
    end;
end;

procedure TfrmPersons.chkBlockClick(Sender: TObject);
begin
  grpBlock.Enabled := chkBlock.Checked;
end;

procedure TfrmPersons.chkCommonBoxClick(Sender: TObject);
begin
  rdoCommonType1.Enabled := chkCommonBox.Checked and chkCommonBox.Enabled;
  rdoCommonType2.Enabled := chkCommonBox.Checked and chkCommonBox.Enabled;
  rdoCommonType3.Enabled := chkCommonBox.Checked and chkCommonBox.Enabled;
////  rdoCommonType1.Enabled := chkCommonBox.Checked;
////  rdoCommonType2.Enabled := chkCommonBox.Checked;
////  rdoCommonType3.Enabled := chkCommonBox.Checked;
  if chkCommonBox.Checked then
  begin
////    RadioButton4.Enabled := True;
//    if RecSaved then
//      cmdNewP.Enabled := True
//    else if adoQryPrs2.RecordCount > 0 then
//      cmdNewP.Enabled := True
//    else
//      cmdNewP.Enabled := False;
    case adoQryPrs.FieldByName('p_CommonBoxType').AsInteger of
      0:  rdoCommonType1.Checked := True;
      1:  rdoCommonType2.Checked := True;
      2:  rdoCommonType3.Checked := True;
      else  rdoCommonType2.Checked := True;
    end;
  end
  else
  begin
////    RadioButton4.Enabled := False;
//    rdoCommonType1.Checked := False;
//    rdoCommonType2.Checked := False;
//    rdoCommonType3.Checked := False;
    if adoQryPrs2.RecordCount > 1 then
    begin
      ErrorMessage('تعداد صاحبان صندوق بیش از یکی است');
      chkCommonBox.Checked := True;
////      chkCommonBoxClick(self);
    end
    else if adoQryPrs2.RecordCount <= 1 then
    begin
      rdoCommonType1.Checked := False;
      rdoCommonType2.Checked := False;
      rdoCommonType3.Checked := False;

//      cmdNewP.Enabled := False;
    end;
  end;
end;

procedure TfrmPersons.chkLegalCustomerClick(Sender: TObject);
begin
  if chkLegalCustomer.Checked then
  begin
    lblCoName.Enabled := True;
    txtCoName.Enabled := True;
  end
  else
  begin
    lblCoName.Enabled := False;
    txtCoName.Enabled := False;
    txtCoName.Text := '';
  end;

end;

procedure TfrmPersons.chkProvisionalBlockClick(Sender: TObject);
begin
  grpProvisionalBlock.Enabled := chkProvisionalBlock.Checked;
end;

procedure TfrmPersons.AddRecToDB(DBName, data : String);
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO ' + DBName + ' VALUES(''' + data +''')');
    ExecSQL;
    Close;
  end;
end;

procedure TfrmPersons.dbgPPersonsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewPClick(Sender)
  else if Key = 46 then
    cmdDeletePClick(Sender)
  else if Key = 13 then
    cmdEditPClick(Sender);
end;

procedure TfrmPersons.dbgPPersonsTitleClick(Column: TColumn);
var
  i : integer;
begin
  if LowerCase(Column.FieldName) = LowerCase('nP_Name') then
    adoQryPrs2.Sort := 'nP_Name ASC'
  else
  if LowerCase(Column.FieldName) = LowerCase('nP_Family') then
    adoQryPrs2.Sort := 'nP_Family ASC'
//  else
//  if Column.FieldName = 'np_ContractDate' then
//    adoQryPrs2.Sort := 'nP_ContractDate ASC'
  else
  with dbgPPersons do
  begin
    for i := 0 to Columns.Count - 1 do
      Columns[i].color := clWhite;
  end;
  Column.Color := clInfoBk;
end;

procedure TfrmPersons.DelRecFromDB(DBName, FldName, data : String);
begin
  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('DELETE FROM ' + dbname + ' WHERE ' + FldName + ' = ''' + data +'''');
    ExecSQL;
    close;
  end;
end;

procedure TfrmPersons.dtaPersons2DataChange(Sender: TObject; Field: TField);
begin
//  if True then
//    cmdNewP.Enabled := cmdNewP.Enabled
  if (adoQryPrs2.RecordCount > 0) and (not chkCommonBox.Checked) then
    cmdNewP.Enabled := False
  else
    cmdNewP.Enabled := True and cmdEditP.Enabled;
end;

procedure TfrmPersons.FormCreate(Sender: TObject);
var
  i : Byte;
  tmp : Tcode;
begin
  RecSaved := False;
//  Font.Name := 'tahoma';
//  Font.Size := 8;

  tabInfo.Align := alTop;
  SetDirectionFarsi(txtName.Handle);
  SetDirectionFarsi(txtFamily.Handle);

//  lbl5.Font.Color := clRed;
//  lbl6.Font.Color := clRed;
//  lbl7.Font.Color := clRed;
//  lbl14.Font.Color := clRed;
//  lbl15.Font.Color := clRed;

  with frmDBS.adoQryG do
  begin
    SQL.Clear;
    SQL.Add('SELECT c_Name FROM Cities ORDER BY C_Name');
    Open;
    while not EOF do
    begin
      cmbFromPlace.Items.Add(FieldByName('C_Name').AsString);
//      cmbFromPlaceSec.Items.Add(FieldByName('C_Name').AsString); //kaveh
      cmbV1FromPlace.Items.Add(FieldByName('C_Name').AsString);
      cmbV2FromPlace.Items.Add(FieldByName('C_Name').AsString);
      Next;
    end;
    Close;
//    SQL.Clear;
//    SQL.Add('SELECT * FROM Cashes ORDER BY c_type,C_Place,C_Name');
//    Open;
//    cmbBoxNo.Items.Clear;
//    while not EOF do
//    begin
//      tmp := Tcode.Create;
//      tmp.Id := FieldByName('C_Code').AsInteger;
//      tmp.BoxType := FieldByName('C_Type').AsInteger;
//      tmp.Place := FieldByName('C_Place').AsString;
//      cmbBoxNo.Items.AddObject(FieldByName('C_Place').AsString + '-' + fixleft(FieldByName('C_Name').AsString,'0',2) ,tmp);
//      tmp := nil;
//      tmp.Free;
//      Next;
//    end;
//    Close;
  end;
//  cmbBoxNo.Sorted := true;

  with adoQryPrs do
  begin
    Connection := frmDBS.DBConnection;
    SQL.clear;

//kaveh 1391/02/10    adoQryPrs.SQL.Add('select * from persons where p_IsBlocked =0');

    SQL.Add('SELECT Persons.p_code, Cashes.c_Place + ''-'' + Cashes.c_name as cCashe, ');
    SQL.Add('case(Persons.p_IsCommonBox) ');
    SQL.Add('when 0 then ''صندوق انفرادی'' ');
    SQL.Add('else ');
    SQL.Add('	case (Persons.p_CommonBoxType) ');
    SQL.Add('	when 0 then ''صندوق مشترک گروهی'' ');
    SQL.Add('	when 1 then ''صندوق مشترک فردی'' ');
    SQL.Add('	when 2 then ''صندوق مشترک ترکیبی'' ');
    SQL.Add('	end ');
    SQL.Add('end as CommBoxType, ');
    SQL.Add('nPersons.np_FAMILY, nPersons.np_NAME, nPersons.np_IDNO, Persons.p_contractno, Persons.p_ContractDate, ');
    SQL.Add('p_ContractEndDate, ');
    SQL.Add('P_AccountNo, p_BoxNo, p_IsCommonBox, P_AccountType, P_ContractNo, P_AccountBranch, P_Deposite, P_Bimeh, ');
    SQL.Add('P_IsColleague, P_IsBlocked, P_BlockDate, P_BlockDesc, P_IsProvisionalBlocked, P_ProvisionalBlockDate, P_ProvisionalBlockDesc, ');
    SQL.Add('p_CommonBoxType, ');
    SQL.Add('p_IsLegalCustomer, ');
    SQL.Add('p_CoName, ');
    SQL.Add('case(Persons.p_IsBlocked) ');
    SQL.Add('when 0 then ');
    SQL.Add('	case(Persons.p_IsProvisionalBlocked) ');
    SQL.Add('	when 0 then ''فعال'' ');
    SQL.Add('	else ''انسداد موقت'' ');
    SQL.Add('	end ');
    SQL.Add('else ''فسخ قرارداد'' ');
    SQL.Add('end as cStatus ');
    SQL.Add('FROM Persons LEFT OUTER JOIN ');
    SQL.Add('Cashes ON Persons.p_BoxNo = Cashes.c_code LEFT OUTER JOIN ');
    SQL.Add('nPersons ON Persons.p_code = nPersons.np_code ');
    SQL.Add('where Persons.p_IsBlocked = 0 ');
    SQL.Add('order by p_code ');
    Open;
  end;
  adoTblProxy.Connection := frmDBS.DBConnection;
  adoTblProxy.Open;

  with TADOQuery.Create(Application) do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * from Cashes');// where ((c_code not in (select p_boxNo from persons where  p_IsBlocked <> 1))');

    Open;
    cmbSrchBoxNo.Items.Clear;
    cmbBoxPlace.Items.Clear;
    while not EOF do
    begin
      tmp := Tcode.Create;
      tmp.Id := FieldByName('C_Code').AsInteger;
      tmp.BoxType := FieldByName('C_Type').AsInteger;
      tmp.Place := FieldByName('C_Place').AsString;
      cmbSrchBoxNo.Items.AddObject(FieldByName('C_Place').AsString + '-' + {FixLeft(}FieldByName('C_Name').AsString{,'0',2)} ,tmp);

      if cmbBoxPlace.Items.IndexOf(tmp.Place) = -1 then
        cmbBoxPlace.Items.Add(tmp.Place);
      tmp := nil;
      tmp.Free;
      Next;
    end;
    cmbSrchBoxNo.itemIndex := -1;
    cmbBoxPlace.itemIndex := -1;
    
    Close;    
  end;
  cmbSrchBoxNo.Sorted := true;
  cmbBoxPlace.Sorted := true;


end;

procedure TfrmPersons.FormActivate(Sender: TObject);
begin
  FormInEdit(False);
  ReOpenTable;
end;

procedure TfrmPersons.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  adoQryPrs.Close;
end;

procedure TfrmPersons.tblPrsCalcFields(DataSet: TDataSet);
begin
//  with DataSet do
//  begin
//    FieldByName('PCode').AsString := DelLeftZero(FieldByName('P_BarCode').AsString);
//  end;
end;

procedure TfrmPersons.txtSearchCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmPersons.txtSearchCodeExit(Sender: TObject);
begin
  ReOpenTable;
end;

procedure TfrmPersons.dbgPersonsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    cmdNewClick(Sender)
  else if Key = 46 then
    cmdDeleteClick(Sender)
  else if Key = 13 then
    cmdEditClick(Sender);
end;

procedure TfrmPersons.cmdNewClick(Sender: TObject);
begin
  FormInEdit(True);
  Flag := MB_NEW;

  chgComponentsEnabled(True, False, False); //kaveh

  ClearScrFields;

  chkCommonBox.Checked := False;
  cmbBoxType.ItemIndex := 0;
  cmbBoxType.OnChange(self);
end;

procedure TfrmPersons.cmdNewPClick(Sender: TObject);
begin
  if (chkCommonBox.Checked) or((not chkCommonBox.Checked) and (adoQryPrs2.RecordCount < 1)) then
  begin
    pnlPerson.Align := alClient;
    pnlPerson.Enabled := True;
    pnlPerson.Visible := True;
    tabInfo.Enabled := False;
    tabInfo.Visible := False;

  //  FormInEdit(True);
    Flag2 := MB_NEW;
    ClearPeScrFields;
    if (chkCommonBox.Checked) and (rdoCommonType3.Checked) then
      chkMemberCommonBoxType3.Enabled := True
    else
      chkMemberCommonBoxType3.Enabled := False;
    
  //  cmbBoxType.ItemIndex := 0;
  //  cmbBoxType.OnChange(self);
  end
  else
    ErrorMessage('صندوق از نوع مشترک نمیباشد.');

end;

procedure TfrmPersons.cmdRevivalClick(Sender: TObject);
begin
  if txtContractDate.Text <> ''
  then begin
       txtContractDate.Text := BeautifulDate(txtContractDate.Text);
       txtContractDate.Text := AddDate(txtContractDate.text,365);
       txtContractEndDate.Text := AddDate(txtContractDate.text,365);
  end;
end;

procedure TfrmPersons.cmdEditClick(Sender: TObject);
//var
//  tempRecNo : Integer;
begin
  if adoQryPrs.RecordCount > 0 then
  begin
    FormInEdit(True);
    Flag := MB_EDIT;
    ClearScrFields;
    cmdRevival.Enabled := True;
//    cmdNewP.Enabled := True;
//    cmdEditP.Enabled := True;
//    cmdDeleteP.Enabled := True;

//    chgComponentsEnabled(True, True, False); //kaveh
    chgComponentsEnabled(True, False, False); //kaveh
//    tempRecNo := adoQryPrs.RecNo;
    SetScrFields{(tempRecNo)};

  end;
end;

procedure TfrmPersons.cmdEditPClick(Sender: TObject);
begin
  if adoQryPrs2.RecordCount > 0 then
  begin

    pnlPerson.Align := alClient;
    pnlPerson.Enabled := True;
    pnlPerson.Visible := True;
    tabInfo.Enabled := False;
    tabInfo.Visible := False;

//    FormInEdit(True);
    Flag2 := MB_EDIT;

    ClearPeScrFields;

//    cmdRevival.Enabled := True;
    SetPeScrFields;
    
    if (chkCommonBox.Checked) and (rdoCommonType3.Checked) then
      chkMemberCommonBoxType3.Enabled := True
    else
      chkMemberCommonBoxType3.Enabled := False;
  end;


end;

procedure TfrmPersons.cmdDeleteClick(Sender: TObject);
begin
  with adoQryPrs do
  begin
    if RecordCount > 0 then
    begin
      if ConfirmMessage('آيا براي حذف  اطمينان داريد؟') then
      begin
        adoTblProxy.delete;
        Delete;
        Refresh;
        Statistic;
      end;
    end;
  end;
end;

procedure TfrmPersons.cmdDeletePClick(Sender: TObject);
begin
  with adoQryPrs2 do
  begin
    if RecordCount > 0 then
    begin
      if ConfirmMessage('آيا براي حذف  اطمينان داريد؟') then
      begin
//        adoTblProxy.delete;
        Delete;
//        Refresh;
//        Statistic;
      end;
    end;
  end;
end;

procedure TfrmPersons.txtBimehKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmPersons.txtBirthDateExit(Sender: TObject);
begin
  if txtBirthDate.Text <> ''
  then begin
       txtBirthDate.Text := BeautifulDate(txtBirthDate.Text);
  end;
end;

procedure TfrmPersons.txtBirthDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmPersons.txtBirthDateSecKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmPersons.txtBlockDateExit(Sender: TObject);
begin
  if txtBlockDate.Text <> ''
  then begin
       txtBlockDate.Text := BeautifulDate(txtBlockDate.Text);
  end;
end;

procedure TfrmPersons.txtBlockDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmPersons.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmPersons.txtContractDateExit(Sender: TObject);
begin
  if txtContractDate.Text <> ''
  then begin
       txtContractDate.Text := BeautifulDate(txtContractDate.Text);
       txtContractEndDate.Text := AddDate(txtContractDate.text,365);
  end;
end;

procedure TfrmPersons.txtContractDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);

end;

procedure TfrmPersons.txtContractEndDateExit(Sender: TObject);
begin
  if txtContractEndDate.Text <> ''
  then begin
       txtContractEndDate.Text := BeautifulDate(txtContractEndDate.Text);
  end;
end;

procedure TfrmPersons.txtContractEndDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmPersons.txtDepositeKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Integer(Key);
end;

procedure TfrmPersons.txtProvisionalBlockDateExit(Sender: TObject);
begin
  if txtProvisionalBlockDate.Text <> ''
  then begin
       txtProvisionalBlockDate.Text := BeautifulDate(txtProvisionalBlockDate.Text);
  end;
end;

procedure TfrmPersons.txtProvisionalBlockDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmPersons.txtProxiKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Hex(Key);
end;

procedure TfrmPersons.txtJobDateKeyPress(Sender: TObject; var Key: Char);
begin
  Keyboard_Date(Key);
end;

procedure TfrmPersons.txtEndJobDateExit(Sender: TObject);
begin
//  if txtEndJobDate.Text <> '' then txtEndJobDate.Text := BeautifulDate(txtEndJobDate.Text);
end;

procedure TfrmPersons.cmdSaveClick(Sender: TObject);
var
  bPCode, nCode : String;
  i : Byte;
  yr,cyr,mn : integer;
  yrst,mnst:string[4];
  fname:string;
//kaveh is
  h_BoxNo_i, tempRecNo : integer;
  h_BlockDate_i, h_BlockDesc_i, h_ProvisionalBlockDate_i, h_ProvisionalBlockDesc_i : string;
//kaveh ie
  tempQry : TADOQuery;

  tempVakilPictureName, tempVakilSignPictureName, tempVakil2PictureName, tempVakil2SignPictureName : string;
  VakilPictureSaved, VakiSignSaved, Vakil2PictureSaved, Vaki2SignSaved : Boolean;

begin
  tempQry := TADOQuery.Create(Application);

  VakilPictureSaved := False;
  VakiSignSaved := False;
  Vakil2PictureSaved := False;
  Vaki2SignSaved := False;
  RecSaved := False;

  adoQryHistory.Connection := frmDBS.DBConnection;

  if cmbBoxNo.itemindex <> -1 then
    boxNo := (cmbBoxNo.Items.Objects[cmbBoxNo.itemindex] as tcode).id
  else
    boxNo := -1;

  if AreValidFields then
  begin
    frmDBS.adoTblPersons.Close;
    if Flag = MB_NEW then
    begin
      bPCode := FixLeft(txtCode.Text, '0', 8);
//      adoQryPrs.Append
    end
    else if Flag = MB_EDIT then
    begin
      bPCode := adoQryPrs.FieldByName('P_Code').AsString;
//      adoQryPrs.Edit;
    end;
    nCode := FixLeft(txtCode.Text, '0', 8);



///////////////////


    tempVakilPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + 'V.jpg';
    tempVakilSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + 'VS.jpg';
    tempVakil2PictureName := g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + 'V2.jpg';
    tempVakil2SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + 'VS2.jpg';

    if VakilPictureNameChanged then
    begin
      if copyfile(Pchar(VakilPictureName),pchar(tempVakilPictureName),false) then
      begin
        VakilPictureSaved := True;
      end
      else
      begin
        ErrorMessage('اشکال در کپی تصویر چهره!');
        RecSaved := False;
        VakilPictureSaved := False;
      end;
    end
    else
      VakilPictureSaved := True;

    if VakilSignPictureNameChanged then
    begin
      if copyfile(Pchar(VakilSignPictureName),pchar(tempVakilSignPictureName),false) then
      begin
        VakiSignSaved := True;
      end
      else
      begin
        ErrorMessage('اشکال در کپی نمونه امضاء!');
        RecSaved := False;
        VakiSignSaved := False;
      end;
    end
    else
      VakiSignSaved := True;

      
    if Vakil2PictureNameChanged then
    begin
      if copyfile(Pchar(Vakil2PictureName),pchar(tempVakil2PictureName),false) then
      begin
        Vakil2PictureSaved := True;
      end
      else
      begin
        ErrorMessage('اشکال در کپی تصویر چهره!');
        RecSaved := False;
        Vakil2PictureSaved := False;
      end;
    end
    else
      Vakil2PictureSaved := True;

    if Vakil2SignPictureNameChanged then
    begin
      if copyfile(Pchar(Vakil2SignPictureName),pchar(tempVakil2SignPictureName),false) then
      begin
        Vaki2SignSaved := True;
      end
      else
      begin
        ErrorMessage('اشکال در کپی نمونه امضاء!');
        RecSaved := False;
        Vaki2SignSaved := False;
      end;
    end
    else
      Vaki2SignSaved := True;



    if (VakilPictureSaved) and (VakiSignSaved) and (Vakil2PictureSaved) and (Vaki2SignSaved) then
    begin
      VakilPictureName := tempVakilPictureName;
      VakilSignPictureName := tempVakilSignPictureName;
      Vakil2PictureName := tempVakil2PictureName;
      Vakil2SignPictureName := tempVakil2SignPictureName;

      if Flag = MB_NEW then
      begin
        with tempQry do
        begin
          Connection := frmDBS.DBConnection;
          SQL.Clear;
          if Flag = MB_NEW then
          begin
            SQL.Add('insert into Persons ');
            SQL.Add('(P_Code, P_AccountNo, P_IsBlocked, P_BoxNo, P_BlockDate, P_BlockDesc, ');
            SQL.Add('p_IsProvisionalBlocked, p_ProvisionalBlockDate, p_ProvisionalBlockDesc, ');
            SQL.Add('P_AccountType, P_ContractNo, P_AccountBranch, P_Deposite, P_Bimeh, ');
            SQL.Add('P_ContractDate, P_ContractEndDate, P_IsColleague, p_IsCommonBox, p_CommonBoxType, ');
            SQL.Add('p_IsLegalCustomer, p_CoName ');

            SQL.Add(') ');
            SQL.Add('values ');
            SQL.Add('( ''' + nCode + ''', ''' + txtAccountNo.Text + ''', ' + BoolToStr(chkBlock.Checked) + ', ');
            if chkBlock.Checked then
              SQL.Add('-1, ''' + txtBlockDate.Text + ''', ''' + txtBlockDesc.Text + ''', ')
            else
              SQL.Add(IntToStr(boxNo) + ', '''', '''', ');
            SQL.Add(BoolToStr(chkProvisionalBlock.Checked) + ', ');
            if chkProvisionalBlock.Checked then
              SQL.Add('''' + txtProvisionalBlockDate.Text + ''', ''' + txtProvisionalBlockDesc.Text + ''', ')
            else
              SQL.Add(''''', '''', ');

            SQL.Add(IntToStr(cmbAccountType.ItemIndex) + ', ''' + txtContractNo.Text + ''', ''' + txtAccountBranch.Text + ''', ');
            SQL.Add('''' + txtDeposite.Text + ''', ''' + txtBimeh.Text + ''', ''' + txtContractDate.Text + ''', ''' + txtContractEndDate.Text + ''', ');
            SQL.Add(BoolToStr(chkColleague.Checked) + ', ' + BoolToStr(chkCommonBox.Checked) + ', ');

            if chkCommonBox.Checked then
            begin
              if rdoCommonType1.Checked then
                SQL.Add('0 ')
              else if rdoCommonType2.Checked then
                SQL.Add('1 ')
              else if rdoCommonType3.Checked then
                SQL.Add('2 ')
              else
                SQL.Add('1 ');
            end
            else
            begin
              SQL.Add('0 ');
            end;
            SQL.Add(', ');
            SQL.Add(BoolToStr(chkLegalCustomer.Checked) + ', ''' + txtCoName.Text + ''' ' );
            SQL.Add(') ');

          end;
          ExecSQL;
          close;

          
          if Flag = MB_NEW then
          begin
            SQL.Clear;
            SQL.Add('insert into nProxies ');
            SQL.Add('(nP_CustomerCode, nP_VNAME, nP_VFAMILY, ');
            SQL.Add('nP_VIDNO, nP_VFATHER, nP_VBirthPlace, ');
            SQL.Add('nP_VExpireDate, nP_VProxyID, np_VPicture, ');
            SQL.Add('np_VSignPicture, np_VProxi ');
            SQL.Add(') ');
            SQL.Add('values ');
            SQL.Add('( ''' + nCode + ''', ''' + txtV1Name.Text + ''', ''' + txtV1Family.Text + ''', ');
            SQL.Add('''' + txtV1IdNo.Text + ''', ''' + txtV1Father.Text + ''', ''' + cmbV1FromPlace.Text + ''', ');
            SQL.Add('''' + txtV1ExpireDate.Text + ''', ''' + txtV1ProxyID.Text + ''', ''' + ExtractFileName(VakilPictureName) + ''', ');
            SQL.Add('''' + ExtractFileName(VakilSignPictureName) + ''', ''1'' ');
            SQL.Add(') ');
            ExecSQL;
            close;

            SQL.Clear;
            SQL.Add('insert into nProxies ');
            SQL.Add('(nP_CustomerCode, nP_VNAME, nP_VFAMILY, ');
            SQL.Add('nP_VIDNO, nP_VFATHER, nP_VBirthPlace, ');
            SQL.Add('nP_VExpireDate, nP_VProxyID, np_VPicture, ');
            SQL.Add('np_VSignPicture, np_VProxi ');
            SQL.Add(') ');
            SQL.Add('values ');
            SQL.Add('( ''' + nCode + ''', ''' + txtV2Name.Text + ''', ''' + txtV2Family.Text + ''', ');
            SQL.Add('''' + txtV2IdNo.Text + ''', ''' + txtV2Father.Text + ''', ''' + cmbV2FromPlace.Text + ''', ');
            SQL.Add('''' + txtV2ExpireDate.Text + ''', ''' + txtV2ProxyID.Text + ''', ''' + ExtractFileName(Vakil2PictureName) + ''', ');
            SQL.Add('''' + ExtractFileName(Vakil2SignPictureName) + ''', ''2'' ');
            SQL.Add(') ');
            ExecSQL;
            close;
          end;

          free;
        end;


  //kaveh is
        with adoQryHistory do
        begin
          if chkBlock.Checked then
          begin
            h_BoxNo_i := -1;
            h_BlockDate_i := txtBlockDate.Text;
            h_BlockDesc_i := txtBlockDesc.Text;
          end
          else
          begin
            h_BoxNo_i := boxNo;
            h_BlockDate_i := '';
            h_BlockDesc_i := '';
          end;

        if chkProvisionalBlock.Checked then
        begin
          h_ProvisionalBlockDate_i := txtProvisionalBlockDate.Text;
          h_ProvisionalBlockDesc_i := txtProvisionalBlockDesc.Text;
        end
        else
        begin
          h_ProvisionalBlockDate_i := '';
          h_ProvisionalBlockDesc_i := '';
        end;
          SQL.Clear;
          SQL.Add('INSERT INTO History ');
          SQL.Add('(h_Code, h_Date, h_Time, h_BoxNo, h_ContractNo, h_ContractDate, h_ContractEndDate,');
          SQL.Add(' h_IsBlocked, h_BlockDate, h_BlockDesc,');
          SQL.Add(' h_IsProvisionalBlocked, h_ProvisionalBlockDate, h_ProvisionalBlockDesc) ');
          SQL.Add('values(''' + nCode + ''', ''' + CurrentDate + ''', ' + IntToStr(TimeToInt(CurrentTime)) + ', ' + IntToStr(h_BoxNo_i)+ ', ''' + txtContractNo.Text + ''', ''' + txtContractDate.Text + ''', ''' + txtContractEndDate.Text + ''', ');
          SQL.Add('       ' + BoolToStr(chkBlock.Checked) + ', ''' + h_BlockDate_i + ''', ''' + h_BlockDesc_i + ''',');
          SQL.Add('       ' + BoolToStr(chkProvisionalBlock.Checked) + ', ''' + h_ProvisionalBlockDate_i + ''', ''' + h_ProvisionalBlockDesc_i + ''')');
          ExecSQL;
        end;


        if (adoQryPrs2.RecordCount > 0) and (not chkCommonBox.Checked) then
          chgComponentsEnabled(False, True, False)
        else
          chgComponentsEnabled(False, True, True);

  //      cmdSave.Enabled := False;


  //kaveh ie

        RecSaved := True;

        cmbTypeChange(self);
        adoQryPrs.Last;

  //      cmdNewP.Enabled := True;
  //      cmdEditP.Enabled := True;
  //      cmdDeleteP.Enabled := True;

      end
      else if Flag = MB_EDIT then
      begin
        with tempQry do
        begin
          Connection := frmDBS.DBConnection;
          SQL.Clear;
          if Flag = MB_EDIT then
          begin
            SQL.Add('Update Persons set ');
            SQL.Add('P_AccountNo = ''' + txtAccountNo.Text + ''', ');
            SQL.Add('P_IsBlocked = ' + BoolToStr(chkBlock.Checked) + ', ');
            if chkBlock.Checked then
            begin
              SQL.Add('P_BoxNo = -1, ');
              SQL.Add('P_BlockDate = ''' + txtBlockDate.Text + ''', ');
              SQL.Add('P_BlockDesc = ''' + txtBlockDesc.Text + ''', ');
            end
            else
            begin
              SQL.Add('P_BoxNo = ' + IntToStr(boxNo) + ', ');
              SQL.Add('P_BlockDate = '''', ');
              SQL.Add('P_BlockDesc = '''', ');
            end;
            SQL.Add('p_IsProvisionalBlocked = ' + BoolToStr(chkProvisionalBlock.Checked) + ', ');
            if chkProvisionalBlock.Checked then
            begin
              SQL.Add('p_ProvisionalBlockDate = ''' + txtProvisionalBlockDate.Text + ''', ');
              SQL.Add('p_ProvisionalBlockDesc = ''' + txtProvisionalBlockDesc.Text + ''', ');
            end
            else
            begin
              SQL.Add('p_ProvisionalBlockDate = '''', ');
              SQL.Add('p_ProvisionalBlockDesc = '''', ');
            end;
            SQL.Add('P_AccountType = ' + IntToStr(cmbAccountType.ItemIndex) + ', ');
            SQL.Add('P_ContractNo = ''' + txtContractNo.Text + ''', ');
            SQL.Add('P_AccountBranch = ''' + txtAccountBranch.Text + ''', ');
            SQL.Add('P_Deposite = ''' + txtDeposite.Text + ''', ');
            SQL.Add('P_Bimeh = ''' + txtBimeh.Text + ''', ');
            SQL.Add('P_ContractDate = ''' + txtContractDate.Text + ''', ');
            SQL.Add('P_ContractEndDate = ''' + txtContractEndDate.Text + ''', ');
            SQL.Add('P_IsColleague = ' + BoolToStr(chkColleague.Checked) + ', ');
            SQL.Add('p_IsCommonBox = ' +  BoolToStr(chkCommonBox.Checked) + ', ');
            if chkCommonBox.Checked then
            begin
              if rdoCommonType1.Checked then
                SQL.Add('p_CommonBoxType = 0 ')
              else if rdoCommonType2.Checked then
                SQL.Add('p_CommonBoxType = 1 ')
              else if rdoCommonType3.Checked then
                SQL.Add('p_CommonBoxType = 2 ')
              else
                SQL.Add('p_CommonBoxType = 1 ');
            end
            else
            begin
              SQL.Add('p_CommonBoxType = 0 ');
            end;
            SQL.Add(', ');
            SQL.Add('p_IsLegalCustomer = ' + BoolToStr(chkLegalCustomer.Checked) + ', ');
            SQL.Add('p_CoName = ''' + txtCoName.Text + ''' ');

            SQL.Add('where P_Code = ''' + nCode + ''' ');
  //P_Code = '00000024',
          end;

          ExecSQL;
          tempRecNo := adoQryPrs.RecNo;
          close;

          if Flag = MB_EDIT then
          begin
            SQL.Clear;
            SQL.Add('update nProxies set ');
//            SQL.Add('nP_CustomerCode = ''' + nCode + ''', ');
            SQL.Add('nP_VNAME = ''' + txtV1Name.Text + ''', ');
            SQL.Add('nP_VFAMILY = ''' + txtV1Family.Text + ''', ');
            SQL.Add('nP_VIDNO = ''' + txtV1IdNo.Text + ''', ');
            SQL.Add('nP_VFATHER = ''' + txtV1Father.Text + ''', ');
            SQL.Add('nP_VBirthPlace = ''' + cmbV1FromPlace.Text + ''', ');
            SQL.Add('nP_VExpireDate = ''' + txtV1ExpireDate.Text + ''', ');
            SQL.Add('nP_VProxyID = ''' + txtV1ProxyID.Text + ''', ');
            SQL.Add('np_VPicture = ''' + ExtractFileName(VakilPictureName) + ''', ');
            SQL.Add('np_VSignPicture = ''' + ExtractFileName(VakilSignPictureName) + ''' ');
//            SQL.Add('np_VProxi = ''1'' ');
            SQL.Add('where nP_CustomerCode = ''' + nCode + ''' and  np_VProxi = ''1'' ');
            ExecSQL;
            close;

            SQL.Clear;
            SQL.Add('update nProxies set ');
//            SQL.Add('nP_CustomerCode = ''' + nCode + ''', ');
            SQL.Add('nP_VNAME = ''' + txtV2Name.Text + ''', ');
            SQL.Add('nP_VFAMILY = ''' + txtV2Family.Text + ''', ');
            SQL.Add('nP_VIDNO = ''' + txtV2IdNo.Text + ''', ');
            SQL.Add('nP_VFATHER = ''' + txtV2Father.Text + ''', ');
            SQL.Add('nP_VBirthPlace = ''' + cmbV2FromPlace.Text + ''', ');
            SQL.Add('nP_VExpireDate = ''' + txtV2ExpireDate.Text + ''', ');
            SQL.Add('nP_VProxyID = ''' + txtV2ProxyID.Text + ''', ');
            SQL.Add('np_VPicture = ''' + ExtractFileName(Vakil2PictureName) + ''', ');
            SQL.Add('np_VSignPicture = ''' + ExtractFileName(Vakil2SignPictureName) + ''' ');
//            SQL.Add('np_VProxi = ''2'' ');
            SQL.Add('where nP_CustomerCode = ''' + nCode + ''' and  np_VProxi = ''2'' ');
            ExecSQL;
            close;           
          end;

          free;
        end;


  //kaveh is
        with adoQryHistory do
        begin
          if chkBlock.Checked then
          begin
            h_BoxNo_i := -1;
            h_BlockDate_i := txtBlockDate.Text;
            h_BlockDesc_i := txtBlockDesc.Text;
          end
          else
          begin
            h_BoxNo_i := boxNo;
            h_BlockDate_i := '';
            h_BlockDesc_i := '';
          end;

        if chkProvisionalBlock.Checked then
        begin
          h_ProvisionalBlockDate_i := txtProvisionalBlockDate.Text;
          h_ProvisionalBlockDesc_i := txtProvisionalBlockDesc.Text;
        end
        else
        begin
          h_ProvisionalBlockDate_i := '';
          h_ProvisionalBlockDesc_i := '';
        end;
          SQL.Clear;
          SQL.Add('INSERT INTO History ');
          SQL.Add('(h_Code, h_Date, h_Time, h_BoxNo, h_ContractNo, h_ContractDate, h_ContractEndDate,');
          SQL.Add(' h_IsBlocked, h_BlockDate, h_BlockDesc,');
          SQL.Add(' h_IsProvisionalBlocked, h_ProvisionalBlockDate, h_ProvisionalBlockDesc) ');
          SQL.Add('values(''' + nCode + ''', ''' + CurrentDate + ''', ' + IntToStr(TimeToInt(CurrentTime)) + ', ' + IntToStr(h_BoxNo_i)+ ', ''' + txtContractNo.Text + ''', ''' + txtContractDate.Text + ''', ''' + txtContractEndDate.Text + ''', ');
          SQL.Add('       ' + BoolToStr(chkBlock.Checked) + ', ''' + h_BlockDate_i + ''', ''' + h_BlockDesc_i + ''',');
          SQL.Add('       ' + BoolToStr(chkProvisionalBlock.Checked) + ', ''' + h_ProvisionalBlockDate_i + ''', ''' + h_ProvisionalBlockDesc_i + ''')');
          ExecSQL;
        end;

        if (adoQryPrs2.RecordCount > 0) and (not chkCommonBox.Checked) then
          chgComponentsEnabled(False, True, False)
        else
          chgComponentsEnabled(False, True, True);

  //      cmdSave.Enabled := False;


  //kaveh ie


        RecSaved := True;

        cmbTypeChange(self);
        adoQryPrs.RecNo := tempRecNo;


  //      cmdNewP.Enabled := True;
  //      cmdEditP.Enabled := True;
  //      cmdDeleteP.Enabled := True;


      end;
    end;










//    adoQryPrs.FieldByName('P_Code').AsString := nCode;
//    adoQryPrs.FieldByName('P_AccountNo').AsString := txtAccountNo.Text;
//    adoQryPrs.FieldByName('P_IsBlocked').AsBoolean := chkBlock.Checked;
//    if chkBlock.Checked then
//    begin
//      adoQryPrs.FieldByName('P_BoxNo').AsInteger := -1;
//      adoQryPrs.FieldByName('P_BlockDate').AsString := txtBlockDate.Text;
//      adoQryPrs.FieldByName('P_BlockDesc').AsString := txtBlockDesc.Text;
//    end
//    else
//    begin
//      adoQryPrs.FieldByName('P_BoxNo').AsInteger := boxNo;
//      adoQryPrs.FieldByName('P_BlockDate').AsString := '';
//      adoQryPrs.FieldByName('P_BlockDesc').AsString := '';
//    end;
//kaveh is
//    adoQryPrs.FieldByName('p_IsProvisionalBlocked').AsBoolean := chkProvisionalBlock.Checked;
//    if chkProvisionalBlock.Checked then
//    begin
//      adoQryPrs.FieldByName('p_ProvisionalBlockDate').AsString := txtProvisionalBlockDate.Text;
//      adoQryPrs.FieldByName('p_ProvisionalBlockDesc').AsString := txtProvisionalBlockDesc.Text;
//    end
//    else
//    begin
//      adoQryPrs.FieldByName('p_ProvisionalBlockDate').AsString := '';
//      adoQryPrs.FieldByName('p_ProvisionalBlockDesc').AsString := '';
//    end;
//kaveh ie
//    adoQryPrs.FieldByName('P_AccountType').AsInteger := cmbAccountType.ItemIndex;
//    adoQryPrs.FieldByName('P_ContractNo').AsString := txtContractNo.Text;
//    adoQryPrs.FieldByName('P_AccountBranch').AsString := txtAccountBranch.Text;
//    adoQryPrs.FieldByName('P_Deposite').AsString := txtDeposite.Text;
//    adoQryPrs.FieldByName('P_Bimeh').AsString := txtBimeh.Text;
//    adoQryPrs.FieldByName('P_ContractDate').AsString := txtContractDate.Text;
//    adoQryPrs.FieldByName('P_ContractEndDate').AsString := txtContractEndDate.Text;
//    adoQryPrs.FieldByName('P_IsColleague').AsBoolean := chkColleague.Checked;


//    adoQryPrs.FieldByName('p_IsCommonBox').AsBoolean := chkCommonBox.Checked;

//    if chkCommonBox.Checked then
//    begin
//      if rdoCommonType1.Checked then
//        adoQryPrs.FieldByName('p_CommonBoxType').AsInteger := 0
//      else if rdoCommonType2.Checked then
//        adoQryPrs.FieldByName('p_CommonBoxType').AsInteger := 1
//      else if rdoCommonType3.Checked then
//        adoQryPrs.FieldByName('p_CommonBoxType').AsInteger := 2
//      else
//        adoQryPrs.FieldByName('p_CommonBoxType').AsInteger := 1;
//    end
//    else
//    begin
//        adoQryPrs.FieldByName('p_CommonBoxType').AsInteger := 0;
//    end;






//    adoQryPrs.Post;
//    adoQryPrs.Close;
//    adoQryPrs.Open;
    frmDBS.adoTblPersons.Open;



{
    with adoTblProxy do
    begin
      if eof then
        Append
      else
        Edit;
      FieldByName('P_V1Name').AsString := txtV1Name.Text;
      FieldByName('P_V1Family').AsString := txtV1Family.Text;
      FieldByName('P_V1IDNo').AsString := txtV1IdNo.Text;
      FieldByName('P_V1Father').AsString := txtV1Father.Text;
      FieldByName('P_V1BirthPlace').AsString := cmbV1FromPlace.Text;
      FieldByName('P_V1ExpireDate').AsString := txtV1ExpireDate.Text;
      FieldByName('P_V1ProxyID').AsString := txtV1ProxyID.Text;
      FieldByName('P_V1Picture').AsString := ExtractFileName(VakilPictureName);
      FieldByName('p_V1SignPicture').AsString := ExtractFileName(VakilSignPictureName); //kaveh

      FieldByName('P_V2Name').AsString := txtV2Name.Text;
      FieldByName('P_V2Family').AsString := txtV2Family.Text;
      FieldByName('P_V2IDNo').AsString := txtV2IdNo.Text;
      FieldByName('P_V2Father').AsString := txtV2Father.Text;
      FieldByName('P_V2BirthPlace').AsString := cmbV2FromPlace.Text;
      FieldByName('P_V2ExpireDate').AsString := txtV2ExpireDate.Text;
      FieldByName('P_V2ProxyID').AsString := txtV2ProxyID.Text;
      FieldByName('P_V2Picture').AsString := ExtractFileName(Vakil2PictureName);
      FieldByName('p_V2SignPicture').AsString := ExtractFileName(Vakil2SignPictureName); //kaveh
      
      Post;
    end;
}

{
    if Flag = MB_NEW then
    begin
      ClearScrFields;
    end
    else
      FormInEdit(false);  }
  end;
//  Statistic;
end;

procedure TfrmPersons.cmbTypeChange(Sender: TObject);
begin
  adoQryPrs.Close;
  adoQryPrs.SQL.clear;
  adoQryPrs.SQL.Add('SELECT Persons.p_code, Cashes.c_Place + ''-'' + Cashes.c_name as cCashe, ');
  adoQryPrs.SQL.Add('case(Persons.p_IsCommonBox) ');
  adoQryPrs.SQL.Add('when 0 then ''صندوق انفرادی'' ');
  adoQryPrs.SQL.Add('else ');
  adoQryPrs.SQL.Add('	case (Persons.p_CommonBoxType) ');
  adoQryPrs.SQL.Add('	when 0 then ''صندوق مشترک گروهی'' ');
  adoQryPrs.SQL.Add('	when 1 then ''صندوق مشترک فردی'' ');
  adoQryPrs.SQL.Add('	when 2 then ''صندوق مشترک ترکیبی'' ');
  adoQryPrs.SQL.Add('	end ');
  adoQryPrs.SQL.Add('end as CommBoxType, ');
  adoQryPrs.SQL.Add('nPersons.np_FAMILY, nPersons.np_NAME, nPersons.np_IDNO, Persons.p_contractno, Persons.p_ContractDate, ');
  adoQryPrs.SQL.Add('Persons.p_ContractEndDate, ');
  adoQryPrs.SQL.Add('P_AccountNo, p_BoxNo, p_IsCommonBox, P_AccountType, P_ContractNo, P_AccountBranch, P_Deposite, P_Bimeh, ');
  adoQryPrs.SQL.Add('P_IsColleague, P_IsBlocked, P_BlockDate, P_BlockDesc, P_IsProvisionalBlocked, P_ProvisionalBlockDate, P_ProvisionalBlockDesc, ');
  adoQryPrs.SQL.Add('p_CommonBoxType, ');
  adoQryPrs.SQL.Add('p_IsLegalCustomer, ');
  adoQryPrs.SQL.Add('p_CoName, ');
  adoQryPrs.SQL.Add('case(Persons.p_IsBlocked) ');
  adoQryPrs.SQL.Add('when 0 then ');
  adoQryPrs.SQL.Add('	case(Persons.p_IsProvisionalBlocked) ');
  adoQryPrs.SQL.Add('	when 0 then ''فعال'' ');
  adoQryPrs.SQL.Add('	else ''انسداد موقت'' ');
  adoQryPrs.SQL.Add('	end ');
  adoQryPrs.SQL.Add('else ''فسخ قرارداد'' ');
  adoQryPrs.SQL.Add('end as cStatus ');
  adoQryPrs.SQL.Add('FROM Persons LEFT OUTER JOIN ');
  adoQryPrs.SQL.Add('Cashes ON Persons.p_BoxNo = Cashes.c_code LEFT OUTER JOIN ');
  adoQryPrs.SQL.Add('nPersons ON Persons.p_code = nPersons.np_code ');

  case cmbType.ItemIndex of
    0 : begin
      adoQryPrs.SQL.Add('where Persons.p_IsBlocked = 0 ');
//kaveh 1391/02/10      adoQryPrs.SQL.Add('select * from persons where p_IsBlocked =0');
    end;
    1 : begin
      adoQryPrs.SQL.Add('where Persons.p_IsBlocked = 1 ');
//kaveh 1391/02/10    adoQryPrs.SQL.Add('select * from persons where p_IsBlocked =1');
    end;
  end;
  adoQryPrs.SQL.Add('order by p_code ');
  adoQryPrs.Open;
  Statistic;
end;

procedure TfrmPersons.cmdCancelClick(Sender: TObject);
begin
  if (RecSaved) and (adoQryPrs2.RecordCount < 1) then
  begin
    if ConfirmMessage('صاحب صندوق تعریف نشده است. آیا خارج میشوید؟') then
    begin
      FormInEdit(False);
      dbgPersons.SetFocus;
      Statistic;
      cmbTypeChange(self);
    end;
  end
  else
  begin
    FormInEdit(False);
    dbgPersons.SetFocus;
    Statistic;
    cmbTypeChange(self);
  end;
end;


procedure TfrmPersons.imgPictureDblClick(Sender: TObject);
//var
//  lastPictureName : string;
begin
  PictureNameChanged := False;
  if OpenPictureDialog1.Execute then
  begin
//      lastPictureName :=  OpenPictureDialog1.FileName;
//      PictureName:= g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + '_' + DelLeftZero(txtProxi.Text) {//kaveh  txtCode.Text } + '.jpg';
      PictureName :=  OpenPictureDialog1.FileName;
//    if (PictureName <> '') and FileExists(lastPictureName)
    if (PictureName <> '') then
      if FileExists(PictureName) then
      begin
  //      if copyfile(Pchar(lastPictureName),pchar(PICTUREName),false) then
  //      begin
  //      imgPicture.Picture.LoadFromFile(PictureName);
        PictureNameChanged := True;
        imgPicture.Picture.LoadFromFile(PictureName);
        imgPicture.Width:=round(imgPicture.Height*imgPicture.Picture.Width/imgPicture.Picture.Height);
  //      end;
      end
      else
        ErrorMessage('تصویر مورد نظر یافت نشد!');
//        imgPicture.Picture.Bitmap := nil;

  end;
end;


procedure TfrmPersons.imgPictureSecDblClick(Sender: TObject);
var
  lastPictureName : string;
begin
  if OpenPictureDialog1.Execute then
  begin
      lastPictureName :=  OpenPictureDialog1.FileName;
      PictureNameSec:= g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) {//kaveh txtCode.Text } + 'Sec.jpg';
    if (PictureNameSec <> '') and FileExists(lastPictureName)
    then begin
      if copyfile(Pchar(lastPictureName),pchar(PictureNameSec),false) then
      begin
//        imgPictureSec.Picture.LoadFromFile(PictureNameSec);
//        imgPictureSec.Width:=round(imgPictureSec.Height*imgPictureSec.Picture.Width/imgPictureSec.Picture.Height);
        True;
      end;
    end;
//    else
//      imgPictureSec.Picture.Bitmap := nil
  end;
end;

procedure TfrmPersons.imgSignDblClick(Sender: TObject);
//var
//  lastPictureName{, tempPictureName} : string;
begin
  SignPictureNameChanged := False;
  if OpenPictureDialog1.Execute then
  begin
//      lastPictureName :=  OpenPictureDialog1.FileName;
//      PictureName:= g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + '_' + DelLeftZero(txtProxi.Text) {//kaveh  txtCode.Text } + '.jpg';
      SignPictureName :=  OpenPictureDialog1.FileName;
//    if (PictureName <> '') and FileExists(lastPictureName)
    if (SignPictureName <> '') then
      if FileExists(SignPictureName) then
      begin
  //      if copyfile(Pchar(lastPictureName),pchar(PICTUREName),false) then
  //      begin
  //      imgPicture.Picture.LoadFromFile(PictureName);
        SignPictureNameChanged := True;
        imgSign.Picture.LoadFromFile(SignPictureName);
        imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
  //      end;
      end
      else
        ErrorMessage('تصویر مورد نظر یافت نشد!');
//        imgSign.Picture.Bitmap := nil
  end;

//  if OpenPictureDialog1.Execute then
//  begin
//      lastPictureName :=  OpenPictureDialog1.FileName;
//      SignPictureName:= g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) + '_' + DelLeftZero(txtProxi.Text) {//kaveh  txtCode.Text } + 'S.jpg';
//    if (SignPictureName <> '') and FileExists(lastPictureName)
//    then begin
////      if copyfile(Pchar(lastPictureName),pchar(PICTUREName),false) then
////      begin
////      imgPicture.Picture.LoadFromFile(PictureName);
////      tempSignPictureName := lastPictureName;
//      imgPicture.Picture.LoadFromFile(lastPictureName);
//      imgPicture.Width:=round(imgPicture.Height*imgPicture.Picture.Width/imgPicture.Picture.Height);
////      end;
//    end
//    else
//      imgPicture.Picture.Bitmap := nil
//  end;

{

  if (not RadioButton1.Checked) and (not RadioButton2.Checked) and (not RadioButton3.Checked) and (not RadioButton4.Checked)then
  begin
        ErrorMessage('هیچکس انتخاب نشده است.');
  end
  else
  begin
    if OpenPictureDialog1.Execute then
    begin
      lastPictureName :=  OpenPictureDialog1.FileName;
      if RadioButton1.Checked then
      begin
        SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' +  DelLeftZero(txtCode.Text) {//kaveh txtCode.Text }  {+ 'S.jpg';
{        tempPictureName := SignPictureName;
      end

      else if RadioButton4.Checked then
      begin
        SignPictureNameSec := g_options.ProgramPath + PICTURE_PATH + '\' +  DelLeftZero(txtCode.Text) {//kaveh txtCode.Text } { + 'SS.jpg';
{        tempPictureName := SignPictureNameSec;
      end

      else if RadioButton2.Checked then
      begin
        VakilSignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' +  DelLeftZero(txtCode.Text) {//kaveh txtCode.Text } { + 'SV.jpg';
{        tempPictureName := VakilSignPictureName;
      end
      else if RadioButton3.Checked then
      begin
        Vakil2SignPictureName := g_options.ProgramPath + PICTURE_PATH + '\' +  DelLeftZero(txtCode.Text) {//kaveh txtCode.Text } { + 'SV2.jpg';
{        tempPictureName := Vakil2SignPictureName;
      end;
      if (tempPictureName <> '') and FileExists(lastPictureName)
      then begin
        if copyfile(Pchar(lastPictureName),pchar(tempPictureName),false) then
        begin
          imgSign.Picture.LoadFromFile(tempPictureName);
          imgSign.Width:=round(imgSign.Height*imgSign.Picture.Width/imgSign.Picture.Height);
        end;
      end
      else
        imgSign.Picture.Bitmap := nil
    end;
  end;  }
end;

procedure TfrmPersons.imgVakilDblClick(Sender: TObject);
//var
//  lastPictureName : string;
begin
  VakilPictureNameChanged := False;
  if OpenPictureDialog1.Execute then
  begin
//      lastPictureName :=  OpenPictureDialog1.FileName;
//      VakilPictureName:= g_options.ProgramPath + PICTURE_PATH + '\' + DelLeftZero(txtCode.Text) {//kaveh txtCode.Text } + 'V.jpg';
    VakilPictureName := OpenPictureDialog1.FileName;
//    if (VakilPictureName <> '') and FileExists(lastPictureName)
    if (VakilPictureName <> '') then
      if FileExists(VakilPictureName) then
      begin
//      if copyfile(Pchar(lastPictureName),pchar(VakilPictureName),false) then
//      begin
        VakilPictureNameChanged := True;
        imgVakil.Picture.LoadFromFile(VakilPictureName);
        imgVakil.Width:=round(imgVakil.Height*imgVakil.Picture.Width/imgVakil.Picture.Height);
//      end;
      end
      else
        ErrorMessage('تصویر مورد نظر یافت نشد!');
//      imgVakil.Picture.Bitmap := nil
  end;
end;


procedure TfrmPersons.imgVakil2SignDblClick(Sender: TObject);
begin
  Vakil2SignPictureNameChanged := False;
  if OpenPictureDialog1.Execute then
  begin
    Vakil2SignPictureName := OpenPictureDialog1.FileName;
    if (Vakil2SignPictureName <> '') then
      if FileExists(Vakil2SignPictureName) then
      begin
        Vakil2SignPictureNameChanged := True;
        imgVakil2Sign.Picture.LoadFromFile(Vakil2SignPictureName);
        imgVakil2Sign.Width:=round(imgVakil2Sign.Height*imgVakil2Sign.Picture.Width/imgVakil2Sign.Picture.Height);
      end
      else
        ErrorMessage('تصویر مورد نظر یافت نشد!');
  end;
end;

procedure TfrmPersons.imgVakilSignDblClick(Sender: TObject);
begin
  VakilSignPictureNameChanged := False;
  if OpenPictureDialog1.Execute then
  begin
    VakilSignPictureName := OpenPictureDialog1.FileName;
    if (VakilSignPictureName <> '') then
      if FileExists(VakilSignPictureName) then
      begin
        VakilSignPictureNameChanged := True;
        imgVakilSign.Picture.LoadFromFile(VakilSignPictureName);
        imgVakilSign.Width:=round(imgVakilSign.Height*imgVakilSign.Picture.Width/imgVakilSign.Picture.Height);
      end
      else
        ErrorMessage('تصویر مورد نظر یافت نشد!');
  end;
end;

//var frmSelPicture: TfrmSelPicture;
//begin
//  if DirectoryExists(g_options.ProgramPath + PICTURE_PATH) then
//  begin
//    Application.CreateForm(TfrmSelPicture, frmSelPicture);
//    frmSelPicture.FileListBox1.Directory := g_options.ProgramPath + PICTURE_PATH;
//    if frmSelPicture.Execute then
//    begin
//      VakilPictureName := frmSelPicture.FileSel;
//      if (VakilPictureName <> '') and FileExists(VakilPictureName)
//      then begin
//        imgVakil.Picture.LoadFromFile(VakilPictureName);
//        imgVakil.Width:=round(imgVakil.Height*imgVakil.Picture.Width/imgVakil.Picture.Height);
//      end
//      else
//        imgVakil.Picture.Bitmap := nil
//    end;
//    frmSelPicture.Free;
//  end
//  else
//    ErrorMessage('شاخه ' +
//                 Chr(13) + g_options.ProgramPath + PICTURE_PATH + Chr(13) +
//                 ' وجود ندارد.');
//end;

procedure TfrmPersons.LoadFreeBoxes(code: integer);
var
  tmp : Tcode;
  i, i2 : integer;
begin
  with TADOQuery.Create(Application) do
  begin
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('select * from Cashes where ((c_code not in (select p_boxNo from persons where  p_IsBlocked <> 1))');
    if code <> -1 then
      SQL.Add('or c_code = ' + inttostr(code) + ' )')
    else
      SQL.Add(')');
    if cmbBoxType.ItemIndex <> -1 then
      SQL.Add('and c_Type = ' + inttostr(cmbBoxType.ItemIndex));
    SQL.Add('ORDER BY c_type,C_Place,C_Name');
    Open;
    cmbBoxNo.Items.Clear;
    while not EOF do
    begin
      tmp := Tcode.Create;
      tmp.Id := FieldByName('C_Code').AsInteger;
      tmp.BoxType := FieldByName('C_Type').AsInteger;
      tmp.Place := FieldByName('C_Place').AsString;
      cmbBoxNo.Items.AddObject(FieldByName('C_Place').AsString + '-' + FixLeft(FieldByName('C_Name').AsString,'0',2) ,tmp);
      tmp := nil;
      tmp.Free;
      Next;
    end;
    Close;
    cmbBoxNo.itemIndex := 0;
    for i := 0 to cmbBoxNo.Items.Count - 1 do
    begin
      if (cmbBoxNo.Items.Objects[i] as tcode).id = BOXNO then
        cmbBoxNo.ItemIndex := i;
    end;

    cmbBoxPlace.ItemIndex := -1;
    if cmbBoxNo.ItemIndex <> -1 then
      for i := 0 to cmbBoxPlace.Items.Count - 1 do
        if (cmbBoxNo.Items.Objects[cmbBoxNo.ItemIndex] as tcode).Place = cmbBoxPlace.Items[i] then
          begin
            cmbBoxPlace.ItemIndex := i;
            Break;
          end;
    
  end;
  cmbBoxNo.Sorted := true;
end;

procedure TfrmPersons.cmbFromPlaceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s : String;
  cmb: TComboBox;
begin
  cmb := Sender as TComboBox;
  if (Key = 45) and (cmb.Text <> '') then
  begin
    if ConfirmMessage('آيا مي خواهيد گزينه جديد را به بانك اضافه نماييد؟') then
      if not IsExistsRec_Str('Cities', 'C_Name', cmb.Text) then
      begin
        AddRecToDB('Cities', cmb.Text);
        cmb.Items.Add(cmb.Text);
        //kaveh is
        cmbFromPlace.Items.Clear;
//        cmbFromPlaceSec.Items.Clear;
        cmbV1FromPlace.Items.Clear;
        cmbV2FromPlace.Items.Clear;
        with frmDBS.adoQryG do
        begin
          SQL.Clear;
          SQL.Add('SELECT c_Name FROM Cities ORDER BY C_Name');
          Open;
          while not EOF do
          begin
            cmbFromPlace.Items.Add(FieldByName('C_Name').AsString);
//            cmbFromPlaceSec.Items.Add(FieldByName('C_Name').AsString); //kaveh
            cmbV1FromPlace.Items.Add(FieldByName('C_Name').AsString);
            cmbV2FromPlace.Items.Add(FieldByName('C_Name').AsString);
            Next;
          end;
          Close;
        end;  
        //kaveh ie
      end
      else
        ErrorMessage('محل صدور تكراري است.');        
  end
  else if (Shift = [ssCtrl]) and (Key = 46) and (cmb.Text <> '') then
  begin
    if ConfirmMessage('آيا مي خواهيد محل صدور را از بانك حذف نماييد؟') then
    begin
      s := cmb.Text;
      cmb.Items.Delete(cmb.Items.IndexOf(s));
      DelRecFromDB('Cities', 'C_Name', s);
      //kaveh is
      cmbFromPlace.Items.Clear;
//      cmbFromPlaceSec.Items.Clear;
      cmbV1FromPlace.Items.Clear;
      cmbV2FromPlace.Items.Clear;
      with frmDBS.adoQryG do
      begin
        SQL.Clear;
        SQL.Add('SELECT c_Name FROM Cities ORDER BY C_Name');
        Open;
        while not EOF do
        begin
          cmbFromPlace.Items.Add(FieldByName('C_Name').AsString);
//          cmbFromPlaceSec.Items.Add(FieldByName('C_Name').AsString); //kaveh
          cmbV1FromPlace.Items.Add(FieldByName('C_Name').AsString);
          cmbV2FromPlace.Items.Add(FieldByName('C_Name').AsString);
          Next;
        end;
        Close;
      end;  
      //kaveh ie
    end;
  end;
end;

procedure TfrmPersons.cmbBirthPlaceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s : String;
begin
end;


procedure TfrmPersons.cmbBoxNoChange(Sender: TObject);
Var
  tmp : tcode;
  i : integer;
begin
  try
    tmp := (cmbBoxNo.Items.Objects[cmbBoxNo.ItemIndex] as Tcode);
    with tmp do
    begin
      cmbBoxType.ItemIndex := BoxType;

      cmbBoxPlace.ItemIndex := -1;
      if cmbBoxNo.ItemIndex <> -1 then
        for i := 0 to cmbBoxPlace.Items.Count - 1 do
          if (cmbBoxNo.Items.Objects[cmbBoxNo.ItemIndex] as tcode).Place = cmbBoxPlace.Items[i] then
            begin
              cmbBoxPlace.ItemIndex := i;
              Break;
            end;

    end;
  except
  end;
end;

procedure TfrmPersons.cmbBoPlaceChange(Sender: TObject);
Var
  i : integer;
begin
  try
    cmbBoxNo.ItemIndex := -1;
    for i := 0 to cmbBoxNo.Items.Count - 1 do
    begin
      if (cmbBoxNo.Items.Objects[i] as tcode).Place = cmbBoxPlace.Items[cmbBoxPlace.ItemIndex] then
      begin
        cmbBoxNo.ItemIndex := i;
        Break;
      end;
    end;
  except
  end;
end;

procedure TfrmPersons.cmbBoxTypeChange(Sender: TObject);
begin
  if  flag = MB_EDIT then
    LoadFreeBoxes(boxNo)
  else
    LoadFreeBoxes(-1)  
end;

procedure TfrmPersons.tabInfoChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
{if (NewTab = 0) and (IWantToDisableTab0) then
   AllowChange := False;}


//  if (NewTab = 1) and (not chkCommonBox.Checked)then { and (IWantToDisableTab1) then}
//    AllowChange := False
//  else
//    AllowChange := True;
//  else
  if (NewTab = 3) or (((NewTab = 1) or (NewTab = 2) {or (NewTab = 3)}) and (chkCommonBox.Checked))then { and (IWantToDisableTab1) then}
    AllowChange := False
  else
    AllowChange := True;

end;

procedure TfrmPersons.tabInfoClick(Sender: TObject);
begin
  if (tabInfo.PageIndex = 0) and (cmbBoxType.Enabled) then
//kaveh901224    txtProxi.SetFocus;
    cmbBoxType.SetFocus;
//  if tabInfo.PageIndex = 1 then
//  begin
////    txtCodeSec.Text := txtCode.Text;
////    txtProxiSec.Text := txtProxi.Text;
////    cmbBoxTypeSec.ItemIndex := cmbBoxType.ItemIndex;
////    cmbBoxPlaceSec.ItemIndex := cmbBoxPlace.ItemIndex;
////    cmbBoxPlaceSec.Text := cmbBoxPlace.Text;
////    cmbBoxNoSec.ItemIndex := cmbBoxNo.ItemIndex;
////    cmbBoxNoSec.Text := cmbBoxNo.Text;
////    chkColleagueSec.Checked := chkColleague.Checked;
////    txtAccountNoSec.Text := txtAccountNo.Text;
////    cmbAccountTypeSec.ItemIndex := cmbAccountType.ItemIndex;
////    txtAccountBranchSec.Text := txtAccountBranch.Text;
////    txtDepositeSec.Text := txtDeposite.Text;
////    txtContractNoSec.Text := txtContractNo.Text;
////    txtContractDateSec.Text := txtContractDate.Text;
////    txtContractEndDateSec.Text := txtContractEndDate.Text;
////    txtBimehSec.Text := txtBimeh.Text;
//  end;

end;


procedure TfrmPersons.cmbMarryKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
    cmbMarry.ItemIndex := -1;
  end;
end;

procedure TfrmPersons.cmbMarrySecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    Key := 0;
//    cmbMarrySec.ItemIndex := -1;
  end;
end;

procedure TfrmPersons.FormKeyPress(Sender: TObject; var Key: Char);
var t : TWinControl;
begin
  if Key = #13 then
  begin
    Key := #0;
    t := FindNextControl(ActiveControl,True, True, False);
    t.SetFocus;
  end;
end;

procedure TfrmPersons.imgVakil2DblClick(Sender: TObject);
//var
//  lastPictureName : string;
begin
  Vakil2PictureNameChanged := False;
  if OpenPictureDialog1.Execute then
  begin
//      lastPictureName :=  OpenPictureDialog1.FileName;
//      Vakil2PictureName:= g_options.ProgramPath + PICTURE_PATH + '\' +  DelLeftZero(txtCode.Text) {//kaveh txtCode.Text } + 'V2.jpg';
    Vakil2PictureName := OpenPictureDialog1.FileName;
//    if (Vakil2PictureName <> '') and FileExists(lastPictureName)
    if (Vakil2PictureName <> '') then
      if FileExists(Vakil2PictureName) then
      begin
//      if copyfile(Pchar(lastPictureName),pchar(Vakil2PictureName),false) then
//      begin
        Vakil2PictureNameChanged := True;
        imgVakil2.Picture.LoadFromFile(Vakil2PictureName);
        imgVakil2.Width:=round(imgVakil2.Height*imgVakil2.Picture.Width/imgVakil2.Picture.Height);
//      end;
      end
      else
//        imgVakil2.Picture.Bitmap := nil
        ErrorMessage('تصویر مورد نظر یافت نشد!');
  end;
end;

procedure TfrmPersons.dbgPersonsTitleClick(Column: TColumn);
var
  i : integer;
begin
  if LowerCase(Column.FieldName) = LowerCase('nP_Name') then
    adoQryPrs.Sort := 'nP_Name ASC'
  else
  if LowerCase(Column.FieldName) = LowerCase('nP_Family') then
    adoQryPrs.Sort := 'nP_Family ASC'
  else
  if LowerCase(Column.FieldName) = LowerCase('p_code') then
    adoQryPrs.Sort := 'p_code ASC'
  else
  if LowerCase(Column.FieldName) = LowerCase('p_ContractDate') then
    adoQryPrs.Sort := 'P_ContractDate ASC'
  else
  with dbgPersons do
  begin
    for i := 0 to Columns.Count - 1 do
      Columns[i].color := clWhite;
  end;
  Column.Color := clInfoBk;
end;

procedure TfrmPersons.adoQryPrs2CalcFields(DataSet: TDataSet);
begin
//  if (adoQryPrs2.RecordCount > 0) and (not chkCommonBox.Checked) then
//    cmdNewP.Enabled := False
//  else
//    cmdNewP.Enabled := True;  
end;

procedure TfrmPersons.adoQryPrsCalcFields(DataSet: TDataSet);
{var
  qry : TADOQuery; }
begin
{  qry := TADOQuery.Create(Application);
  qry.Connection := frmDBS.DBConnection;
//  if not dataset.eof then
  begin
    qry.SQL.add('select * from cashes');
    if DataSet.FieldByName('P_boxNo').AsString <> '' then
    begin
      qry.SQL.add('where c_code = ' + DataSet.FieldByName('P_boxNo').AsString);
      qry.Open;
      with  DataSet do
      begin
        if not qry.Eof then
          FieldByName('Box').AsString := qry.FieldByName('c_Place').AsString + '-' + qry.FieldByName('c_name').AsString
        else
          FieldByName('Box').AsString := '';
      end;
    end;
  end;
  qry.close;
  qry.Free;}
end;
procedure TfrmPersons.Z84GetRecord(rdrInfo : TReaders);
var
  getVal : Byte;
  PK, DT : String;
  ClkRec : TTerminalRec;
  p : TPerson;
  n : integer;
begin
  DT := CurrentDate;
//  Z84_MakePocket(PK, curRdrCode, $30, 0, Copy(DT, 3, 2)+Copy(DT, 6, 2)+Copy(DT, 9, 2));
//  if SendPocket(PK) then
//  begin
//    Z84_GetPocket(PK, 30, 60, getVal);
//    if (getVal = ERR_NONE) and (Ord(PK[3]) = curRdrCode) then
//    begin
//      if Ord(PK[4]) =  4 then
//      begin
//        ClkRec := Z84_AnalizeData(PK, ErrRec);
//        p := GetPerson(ClkRec.rdrCardCode, True);
//        if p.P_Code <> '' then
//          ClkRec.rdrCardCode := p.P_Code;
//        Z84_MakePocket(PK, curRdrCode, $06, 0, '');
//        if SendPocket(PK) then
//          begin
//            txtProxi.Text := DelLeftZero(ClkRec.rdrCardCode);
//          end;
//      end;
//    end
//  end;
  {$region 'get first Record'}

  Z84_MakePocket(PK, rdrInfo.R_Code, $30,  0, Copy(DT, 3, 2)+Copy(Dt, 6, 2)+Copy(Dt, 9, 2));

  if rdrInfo.r_IsCom and not SendPocket(PK) then
    GetVal := ERR_OFF
  else if not rdrInfo.r_IsCom and rdrInfo.r_TCP and not TCPSendData(PK, rdrInfo.r_IP) then
    GetVal := ERR_OFF
  else if not rdrInfo.r_IsCom and not rdrInfo.r_TCP and not UDPSendData(PK, rdrInfo.r_IP) then
    GetVal := ERR_OFF
  else
  begin
    if rdrInfo.r_IsCom then
      Z84_GetPocket(PK, 30 , 60, getVal)
    else if rdrInfo.r_TCP then
    begin
      Sleep(4000);
      TCPReadData(PK, getVal)
    end
    else
    begin
      UDPReadData(PK, getVal);
    end;

    if (getVal = ERR_NONE) and (Ord(PK[3]) = rdrInfo.R_Code) then
    begin
      case Ord(PK[4]) of
        $03: //Buffer Empty
          GetVal := MB_BUFFEMPTY;

        $04: //Record Exists
          begin
            {$region 'one Record in one Packet'}
            GetVal := MB_TRUEREC;
            ClkRec := Z84_AnalizeData(PK, ErrRec);

            p := GetPerson(ClkRec.rdrCardCode, True);
            if p.P_Code <> '' then
              ClkRec.rdrCardCode := p.P_Code;
            txtProxi.Text := DelLeftZero(ClkRec.rdrCardCode);
            txtproxi.refresh;
            {$endregion 'one Record in one Packet'}
          end;
        {$region 'other'}
        $15:
          GetVal := MB_TRUEREC
        else //Error in read data
          GetVal := MB_BADREC;
        {$endregion 'other'}
      end;
    end
    else if getVal = ERR_OFF then
      GetVal := ERR_OFF
    else
      GetVal := MB_BADREC;
  end;
  {$endregion 'get first Record'}
  n := 0;
  while (GetVal <> MB_BUFFEMPTY) and (n <= 3) do
  begin
    {$region 'get other Record'}
    if GetVal = MB_TRUEREC then
    begin
      Z84_MakePocket(PK, rdrInfo.r_Code, $06, 0, '');
      n := 0;
    end
    else if GetVal = MB_BADREC then
      Z84_MakePocket(PK, rdrInfo.r_Code, $15, 0, '')
    else if GetVal = ERR_OFF then
      PK := '';


    if rdrInfo.r_IsCom and not SendPocket(PK) then
      GetVal := ERR_OFF
    else if (PK <> '') and not rdrInfo.r_IsCom and rdrInfo.r_TCP and not TCPSendData(PK, rdrInfo.r_IP) then
      GetVal := ERR_OFF
    else if (PK <> '') and not rdrInfo.r_IsCom and not rdrInfo.r_TCP and not UDPSendData(PK, rdrInfo.r_IP) then
      GetVal := ERR_OFF
    else
    begin
      if rdrInfo.r_IsCom then
        Z84_Getpocket(PK, 0, 300, getVal)
      else if rdrInfo.r_TCP then
      begin
        Sleep(100);
        TCPReadData(PK, getVal)
      end
      else
      begin
//        Sleep(50);
        UDPReadData(PK, getVal);
      end;

      if (getVal = ERR_NONE) and (Ord(PK[3]) = rdrInfo.r_Code) then
      begin
        case Ord(PK[4]) of
          $03: //Buffer Empty
            GetVal := MB_BUFFEMPTY;

          $04: //Record Exists
          begin
            GetVal := MB_TRUEREC;
            n := 0;
            ClkRec := Z84_AnalizeData(PK,  ErrRec);

            p := GetPerson(ClkRec.rdrCardCode, True);
            if p.P_Code <> '' then
              ClkRec.rdrCardCode := p.P_Code;
            txtProxi.Text := DelLeftZero(ClkRec.rdrCardCode);
            txtproxi.refresh;
          end;
          $15:
            GetVal := MB_TRUEREC;

          else //Error in read data
            GetVal := MB_BADREC;
        end;
      end
      else if getVal = ERR_OFF then
        GetVal := ERR_OFF
      else
        GetVal := MB_BADREC;
    end;
    if GetVal in [ERR_OFF, MB_BADREC] then
    begin
      Inc(n);
      Sleep(1000);
    end;
    n:= n +1;
    {$endregion 'get other Record'}
  end;
end;

end.
