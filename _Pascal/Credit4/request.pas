unit request;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,globals,adodb;

type
  TfrmRequest = class(TForm)
    GroupBox1: TGroupBox;
    lblBoxNo: TLabel;
    lblContractEndDate: TLabel;
    lblName: TLabel;
    pnlPicture: TPanel;
    imgPicture: TImage;
    lblCredit: TLabel;
    btnYes: TButton;
    btnNo: TButton;
    btnVorC: TButton;
    btnPrint: TButton;
    btnSign: TButton;
    lblCommonBox: TLabel;
    lblCoNamei: TLabel;
    procedure btnPrintClick(Sender: TObject);
    procedure btnVorCClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure btnYesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSignClick(Sender: TObject);
  private
    { Private declarations }
    btnVorCState : Boolean;
  public
    p : TPerson;
    stat :(prsn,prsnSec,Vakil1,Vakil2);
    stat2 :(pic,sign);
  end;

var
  frmRequest: TfrmRequest;

implementation

{$R *.dfm}
uses
  main,dateproc, DBS,funcs,runCmnds,RpEnter, QuickRpt;

procedure TfrmRequest.btnNoClick(Sender: TObject);
begin
  free;
end;

procedure TfrmRequest.btnYesClick(Sender: TObject);
begin
  if  frmPicRec.authorized.IndexOf(FixLeft(p.P_Code,'0',8)) = -1 then
    frmPicRec.authorized.Append(FixLeft(p.P_Code,'0',8));
  if frmPicRec.SendAuthority then
    free;
end;

procedure TfrmRequest.btnPrintClick(Sender: TObject);
var
  rptEnter: TqrptEnter;
  tblName : string;
begin
  Application.CreateForm(TqrptEnter, rptEnter);
  tblName := 'C' + copy(CurrentDate,1,4)+ copy(CurrentDate,6,2);
  with rptEnter do
  begin
    RPTSetWinF;
    ADOQuery1.connection := frmdbs.DBConnection;
    ADOQuery1.SQL.Clear;
    if tblExists(tblName) then
      ADOQuery1.SQL.Add('select code=count(clock_RdrCode)+1 from ' + tblName + ' where clock_RdrCode=1')
    else
      ADOQuery1.SQL.Add('select code=1');

    ADOQuery1.Open;
    lblCoName.Caption := g_options.CoName;
    if g_options.Shobeh <> '' then lblCoName.Caption := lblCoName.Caption + ' - ' + g_options.Shobeh;
    lblDate.Caption := CurrentDate + '  ' + LongDayNames[DayOfWeek(Date)];
    name.Caption := p.P_Name;
    family.Caption := p.P_Family;
    Code.Caption := F_Params.BranchCode + '-' + p.P_Code;
    BranchCode.Caption := F_Params.BranchCode;
    BranchName.Caption := F_Params.BranchName;

//    IDNo.Caption := p.P_IDNO;
//    Father.Caption := p.P_FatherName;
//    BirthDate.Caption := p.p_BirthDate;
    Box.Caption := p.P_Box;
    contract.Caption := p.P_ContractNo;
    print;
    free;
  end;
end;

procedure TfrmRequest.btnSignClick(Sender: TObject);
begin
 case stat2 of
  pic:
  begin
   case stat of
    prsn:
    begin
      if FileExists(p.P_SignPicture)
      then begin
        imgPicture.Picture.LoadFromFile(p.P_SignPicture);
      end
      else
        imgPicture.Picture.Bitmap := nil;
    end;
//    prsnSec:
//    begin
//      if FileExists(p.P_SignPictureSec)
//      then begin
//        imgPicture.Picture.LoadFromFile(p.P_SignPictureSec);
//      end
//      else
//        imgPicture.Picture.Bitmap := nil;
//    end;
//    Vakil1:
//    begin
//      if FileExists(p.P_VakilSignPicture)
//      then begin
//        imgPicture.Picture.LoadFromFile(p.P_VakilSignPicture);
//      end
//      else
//        imgPicture.Picture.Bitmap := nil;
//    end;
//    Vakil2:
//    begin
//      if FileExists(p.P_Vakil2SignPicture)
//      then begin
//        imgPicture.Picture.LoadFromFile(p.P_Vakil2SignPicture);
//      end
//      else
//        imgPicture.Picture.Bitmap := nil;
//    end;
   end;
   btnSign.Caption := 'نمایش عکس';
   stat2 := sign;
  end;
  sign:
  begin
   case stat of
    prsn:
    begin
      if FileExists(p.P_Picture)
      then begin
        imgPicture.Picture.LoadFromFile(p.P_Picture);
      end
      else
        imgPicture.Picture.Bitmap := nil;
    end;
//    prsnSec:
//    begin
//      if FileExists(p.P_PictureSec)
//      then begin
//        imgPicture.Picture.LoadFromFile(p.P_PictureSec);
//      end
//      else
//        imgPicture.Picture.Bitmap := nil;
//    end;
//    Vakil1:
//    begin
//      if FileExists(p.P_V1Picture)
//      then begin
//        imgPicture.Picture.LoadFromFile(p.P_V1Picture);
//      end
//      else
//        imgPicture.Picture.Bitmap := nil;
//    end;
//    Vakil2:
//    begin
//      if FileExists(p.P_V2Picture)
//      then begin
//        imgPicture.Picture.LoadFromFile(p.P_V2Picture);
//      end
//      else
//        imgPicture.Picture.Bitmap := nil;
//    end;
   end;
   btnSign.Caption := 'نمايش امضاء';
   stat2 := pic;
  end;
  end;
end;

procedure TfrmRequest.btnVorCClick(Sender: TObject);
begin
  frmVorCRecs.iP_Code := p.P_Code;
  frmVorCRecs.iVorC := btnVorCState;

  if p.P_IsCommonBox then
  begin
    if p.P_IsLegalCustomer then
    begin
      frmVorCRecs.iCKind := 1;
      frmVorCRecs.iCoName := p.p_CoName;
    end
    else
    begin
      case p.P_CommonBoxType of
        0:frmVorCRecs.iCKind := 2;
        1:frmVorCRecs.iCKind := 3;
        2:frmVorCRecs.iCKind := 4;
      end;
    end;
  end
  else
    frmVorCRecs.iCKind := 0;


  frmVorCRecs.ShowModal;

{  case stat of
    prsn:
    begin
      if p.P_IsCommonBox then
      begin
        if FileExists(p.P_PictureSec)
        then begin
          imgPicture.Picture.LoadFromFile(p.P_PictureSec);
        end
        else
          imgPicture.Picture.Bitmap := nil;
        stat := prsnSec;
        btnPic.Caption := 'مشخصات وکيل اول';
        lblName.Caption := p.P_FamilySec + '-' + p.P_NameSec;
      end
      else
      begin
        if FileExists(p.P_V1Picture)
        then begin
          imgPicture.Picture.LoadFromFile(p.P_V1Picture);
        end
        else
          imgPicture.Picture.Bitmap := nil;
        stat := Vakil1;
        btnPic.Caption := 'مشخصات وکيل دوم';
        lblName.Caption := p.P_V1Family + '-' + p.P_V1Name;
      end;
    end;

    prsnSec:
    begin
      if FileExists(p.P_V1Picture)
      then begin
        imgPicture.Picture.LoadFromFile(p.P_V1Picture);
      end
      else
        imgPicture.Picture.Bitmap := nil;
      stat := Vakil1;
      btnPic.Caption := 'مشخصات وکيل دوم';
      lblName.Caption := p.P_V1Family + '-' + p.P_V1Name;
    end;

    
    Vakil1:
    begin
      if FileExists(p.P_V2Picture)
      then begin
        imgPicture.Picture.LoadFromFile(p.P_V2Picture);
      end
      else
        imgPicture.Picture.Bitmap := nil;
      stat := Vakil2;
      btnPic.Caption := 'مشخصات مشتري';
      lblName.Caption := p.P_V2Family + '-' + p.P_V2Name;
    end;

    Vakil2:
    begin
      if p.P_IsCommonBox then
      begin
        if FileExists(p.P_Picture)
        then begin
          imgPicture.Picture.LoadFromFile(p.P_Picture);
        end
        else
          imgPicture.Picture.Bitmap := nil;
        stat := prsn;
        btnPic.Caption := 'مشخصات مشتري دوم';
        lblName.Caption := p.P_Family + '-' + p.P_Name;
      end
      else
      begin
        if FileExists(p.P_Picture)
        then begin
          imgPicture.Picture.LoadFromFile(p.P_Picture);
        end
        else
          imgPicture.Picture.Bitmap := nil;
        stat := prsn;
        btnPic.Caption := 'مشخصات وکيل اول';
        lblName.Caption := p.P_Family + '-' + p.P_Name;
      end;
    end;
  end;
  btnSign.Caption := 'نمايش امضاء';
  stat2 := pic; }




end;

procedure TfrmRequest.FormShow(Sender: TObject);
var
  outofdate:boolean;
begin
  lblBoxNo.Caption := 'صندوق شماره : ' + p.P_Box;
  lblName.Caption := p.P_Family + '-' + p.P_Name;
  if p.P_IsLegalCustomer then
    lblCoNamei.Caption :='شرکت ' + p.p_CoName
  else
    lblCoNamei.Caption := 'مشتری حقیقی';
  lblContractEndDate.Caption := 'سررسيد قرارداد : ' + p.P_ContractEndDate;
  if (p.P_ContractEndDate<>'') and (p.P_ContractEndDate<currentdate) then
      outofdate:=true
  else
      outofdate:=false;

  lblCredit.Caption := 'فاقد اعتبار';
  lblCredit.Visible := outofdate;
  if p.P_IsBlocked then
  begin
    lblCredit.Caption := 'مسدود شده';
    lblCredit.Visible := True;
    btnYes.Enabled := False;
    btnPrint.Enabled := False;
//kaveh    btnNo.Visible := false;
  end
  else
  begin
    btnYes.Enabled := True;
    btnPrint.Enabled := True;
//    btnNo.Visible := true;
  end;
//kaveh is
  if not p.P_IsBlocked then
  begin
  if p.P_IsProvisionalBlocked then
  begin
    lblCredit.Caption := 'انسداد موقت';
    lblCredit.Visible := True;
    btnYes.Enabled := False;
    btnPrint.Enabled := False;
//kaveh    btnNo.Visible := false;
  end
  else
  begin
    btnYes.Enabled := True;
    btnPrint.Enabled := True;
//    btnNo.Visible := true;
  end;
  end;

  if (not p.P_IsBlocked) and (not p.P_IsProvisionalBlocked) then
    if {(p.P_IsLegalCustomer) and }(p.P_IsCommonBox) and (p.P_CommonBoxType = 2) then
      if not p.P_IsMemberCommonBoxType3 then
      begin
        lblCredit.Caption := 'فاقد مجوز';
        lblCredit.Visible := True;
        btnYes.Enabled := False;
        btnPrint.Enabled := False;
      end
      else
      begin
        btnYes.Enabled := True;
        btnPrint.Enabled := True;
      end;

  if p.P_IsCommonBox then
  begin
//    btnPic.Caption := 'مشخصات مشتري دوم';
    btnVorC.Caption := 'مشاهده صاحبان صندوق';
    btnVorCState := False;

    if p.P_IsLegalCustomer then
    begin
      lblCommonBox.Caption := 'مشتری حقوقی';
      lblCommonBox.Visible := True;
    end
    else
    begin
      case p.P_CommonBoxType of
        0:begin
          lblCommonBox.Caption := 'مشترک گروهی';
          lblCommonBox.Visible := True;
        end;
        1:begin
          lblCommonBox.Caption := 'مشترک فردی';
          lblCommonBox.Visible := True;
        end;
        2:begin
          lblCommonBox.Caption := 'مشترک ترکیبی';
          lblCommonBox.Visible := True;
        end;
      end;
    end;
    
//    lblCommonBox.Caption := 'صندوق مشترک';
//    lblCommonBox.Visible := true;
  end
  else
  begin
//    btnPic.Caption := 'مشخصات وکيل اول';
    btnVorC.Caption := 'مشاهده وکلا';
    btnVorCState := True;    
  end;

  
//kaveh ie

  if FileExists(p.P_Picture)
  then begin
    imgPicture.Picture.LoadFromFile(p.P_Picture);
  end
  else
    imgPicture.Picture.Bitmap := nil;
  stat := prsn;
  if outofdate
  then with frmPicRec.MP do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'credit.WAV';
    Open;
    Play;
  end;
end;

end.
