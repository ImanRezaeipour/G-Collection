unit CmdTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DosMove, Mask, ExtCtrls;

type
  TfrmCmndTest = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblResult: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    txtRdrCode: TEdit;
    cmbBaudRate: TComboBox;
    cmbComPort: TComboBox;
    cmbCommands: TComboBox;
    cmdRun: TBitBtn;
    txtNRdrCode: TEdit;
    cmbNBDR: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    mskFTime1: TMaskEdit;
    mskTTime1: TMaskEdit;
    mskFTime2: TMaskEdit;
    mskTTime2: TMaskEdit;
    mskFTime3: TMaskEdit;
    mskTTime3: TMaskEdit;
    Label16: TLabel;
    txtMsg1: TEdit;
    txtMsg2: TEdit;
    txtMsg3: TEdit;
    txtMsg4: TEdit;
    Label17: TLabel;
    txtCardCode: TEdit;
    Label18: TLabel;
    txtMessage: TEdit;
    Bevel1: TBevel;
    Label19: TLabel;
    txtFCardLimit: TEdit;
    Label20: TLabel;
    txtTCardLimit: TEdit;
    chkOnLine: TCheckBox;
    mskDate: TMaskEdit;
    mskTime: TMaskEdit;
    Label21: TLabel;
    Label22: TLabel;
    txtFName: TEdit;
    lstData: TListBox;
    tmrOnline: TTimer;
    lblRecNo: TLabel;
    procedure cmdRunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrOnlineTimer(Sender: TObject);
  private
    { Private declarations }
    onLineRecCount : Integer;
    procedure MTT_Proc;
  public
    { Public declarations }
  end;

var
  frmCmndTest: TfrmCmndTest;

implementation

uses
//  Z84_Cmd,
  Cnstants;

{$R *.dfm}

var
  RdrCode,          //Reader code (1..255)
  ComNo,            //Com port    (1=COM1, 2=COM2, ...)
  Prtcl : Byte;     //Reader porotocol type (100=Z80, 101=z84, 102=Proxi)
  BD_R : LongInt;   //Baud rate (2400, 4800, 9600, 19200, 38400)





function  Z84_LinkTest(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_ReStart(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_Initial(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_ReadVersion(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var VersionST : pchar;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SendDateTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DT, TM : STR_TYPE ;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_GetDateTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var DT, TM : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_ChangeAddress(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; NewAddress : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_ChangeBaudRate(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; NewBD_R : LongInt;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SendLimitTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST1, ST2, ST3 : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetLimitTime(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST1, ST2, ST3 : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SendReaderMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; msg1, msg2, msg3, msg4 : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_SendPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode, Msg : STR_TYPE;is98 : boolean) : Byte; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode : STR_TYPE; var Msg : STR_TYPE;is98 : boolean) : Byte; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DelPersonMsg(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; CardCode : STR_TYPE;is98 : boolean) : Byte; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DeleteAllReaderMessage(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetOpenDoor_Normal(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, DoorTime : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_SetOpenDoor_All(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DoorTime : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_SetCloseDoor(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; DoorTime : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DelAlarmTimes(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DelInvalidCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DelAccessCode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetFunctionKeys(RdrCode, BD_R, ComNo, Prtcl, FKey1, FKey2, FKey3, FKey4 : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetFunctionKeys(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var FKey1, FKey2, FKey3, FKey4 : Byte;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_ChangeFunctionKeysActive(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; KeyActive : Boolean;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetPishCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; PishCard, CardNo : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetPishCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; var PishCard, CardNo : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetLimitCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; FromCard, ToCard : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetLimitCard(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, No : Byte; var FromCard, ToCard : STR_TYPE;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function  Z84_ChangeOnOffMode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; onLine : Boolean;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_ReadOnOffMode(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var onLine : Boolean;is98 : boolean) : Boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

procedure Z84_GetRecord(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT : STR_TYPE; IsFirst : Boolean; var retVal : Byte; var Data : STR_TYPE;is98 : boolean); stdcall; external '..\\..\\..\\Z84SDK.DLL';
procedure Z84_GetRecordI(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT : STR_TYPE; IsFirst : Boolean;
                         var retVal : Byte; var recType : Byte; var recDate : LongInt; var recTime : Integer; var recCard : LongInt;is98 : boolean); stdcall; external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetRecordInFile(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl, rType : Byte; DT, FName : STR_TYPE; var retVal : Byte;is98 : boolean) : Integer; stdcall; external '..\\..\\..\\Z84SDK.DLL';

procedure MTT_OnLineRec(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; isGetRec : Boolean; var data : STR_TYPE; var retCode : Byte ; is98 : boolean); stdcall; external '..\\..\\..\\Z84SDK.DLL';

function Z84_PrintToReaders(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; printer_type : byte ; st : string; DblWidth , color , is98 : boolean):boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function Z84_PrintToPrinter(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; st : String ; is98 : boolean):boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function Z84_CutPrint(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; printer_type : byte ; is98 : boolean):boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';
function Z84_SendBeep(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; count : char ; is98 : boolean):boolean; stdcall; external '..\\..\\..\\Z84SDK.DLL';

function Z84_SetOnlyCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : string;is98 :boolean) : boolean;stdcall;external '..\\..\\..\\Z84SDK.DLL';
function Z84_GetOnlyCards(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : ansistring;is98 :boolean) : boolean;stdcall;external '..\\..\\..\\Z84SDK.DLL';

function Z84_SetAuthority(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; ST : string;is98 :boolean) : boolean;stdcall;external '..\\..\\..\\Z84SDK.DLL';
function Z84_GetAuthority(RdrCode : Byte; BD_R : LongInt; ComNo, Prtcl : Byte; var ST : ansistring;is98 :boolean) : boolean;stdcall;external '..\\..\\..\\Z84SDK.DLL';


procedure TfrmCmndTest.MTT_Proc;
var
  data : STR_TYPE;
  s : String;
  ret : Byte;
begin
  lblResult.Caption := '';
  Refresh;

  if cmbCommands.ItemIndex = 19 then
  begin
    MTT_OnLineRec(RdrCode, BD_R, ComNo, Prtcl, True, data, ret,false);
    case ret of
      MB_BUFFEMPTY:
        lblResult.Caption := 'There is no record';

      MB_TRUEREC:
      begin
        {Analyze dada
          Reader  code = 3 byte (1..3)
          Keyboard pressed = 2 byte (4..5) bit by bit
          date = 6 byte (6..11) yymmdd
          time = 4 byte (12..15) hhmm
          card no. = 8 byte (16..23)
        }
        s := Copy(data, 1, 3) + ' ' +                        //Reader code
             IntToStr(Ord(data[5])*256+Ord(data[4])) + ' ' + //Keypad pressed
             Copy(data, 6, 6) + ' ' +                        //Date
             Copy(data, 12, 4) + ' ' +                       //Time
             Copy(data, 16, 8);                              //Card No.
        Inc(onLineRecCount);
        lblRecNo.Caption := IntToStr(onLineRecCount);
        lstData.Items.Add(s);

        ret := 0; //Accept record
                  //Error Codes between 1..15
        MTT_OnLineRec(RdrCode, BD_R, ComNo, Prtcl, False, data, ret,false);
      end;

      MTT_OFFLINE:
        lblResult.Caption := 'Reader is on OffLine mode';
    end;
    Refresh;
  end;
end;


procedure TfrmCmndTest.FormCreate(Sender: TObject);
begin
  lblResult.Caption := '';
end;

procedure TfrmCmndTest.cmdRunClick(Sender: TObject);
var
  s1, s2, s3 : STR_TYPE;
  s4 : AnsiString;
  ret, n, recType : Byte;
  b : Boolean;
  recCount, k : Integer;
  i: Integer;
  ver : pchar;
  tmp: string;
begin
  tmrOnline.Enabled := False;
  lblResult.Caption := '';
  lstData.Items.Clear;
  Refresh;

  if txtRdrCode.Text = '' then
  begin
    MessageDlg('Reader code is invalid!', mtInformation, [mbOk], 0);
    txtRdrCode.SetFocus;
  end
  else if cmbBaudRate.ItemIndex = -1 then
  begin
    MessageDlg('Baud rate is invalid!', mtInformation, [mbOk], 0);
    cmbBaudRate.SetFocus;
  end
  else if cmbComPort.ItemIndex = -1 then
  begin
    MessageDlg('Com port is invalid!', mtError, [mbOk], 0);
    cmbComPort.SetFocus;
  end
  else
  begin
    RdrCode := StrToInt(txtRdrCode.Text);
    ComNo := cmbComPort.ItemIndex+1;
    Prtcl := RDR_Z84;
    BD_R := StrToInt(cmbBaudRate.Text);

    case cmbCommands.ItemIndex of
      0: //Link Test
      begin
      if Z84_LinkTest(RdrCode, BD_R, ComNo, Prtcl,false) then
          lblResult.Caption := 'Link test is Valid'
        else
          lblResult.Caption := 'Link test is inValid';
      end;

      1: //ReStart Reader
      begin
        if Z84_ReStart(RdrCode, BD_R, ComNo, Prtcl,false) then
          lblResult.Caption := 'Reader is restarted.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      2: //Reader Configuration
      begin
        if Z84_Initial(RdrCode, BD_R, ComNo, Prtcl,false) then
          lblResult.Caption := 'Reader is configured.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      3: //Reading Reader version
      begin
        if Z84_ReadVersion(RdrCode, BD_R, ComNo, Prtcl, ver,false) then
        begin
          i := 0;
          while (ver[I] <> #0) do
          begin
            lblResult.Caption := lblResult.Caption  + ver[i];
            Inc(I);
          end
        end
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      4: //Set Reader Date & Time
      begin
        if mskDate.Text = '' then
        begin
          MessageDlg('Date is invalid!', mtInformation, [mbOk], 0);
          mskDate.SetFocus;
        end
        else if mskTime.Text = '' then
        begin
          MessageDlg('Time is invalid!', mtInformation, [mbOk], 0);
          mskTime.SetFocus;
        end
        else
        begin
          if Z84_SendDateTime(RdrCode, BD_R, ComNo, Prtcl, pchar(mskDate.Text), pchar(mskTime.Text),false) then
            lblResult.Caption := 'Reader Date & Time are set.'
          else
            lblResult.Caption := 'Connection is invalid.';
        end;
      end;

      5: //Read Reader Date & Time
      begin
        if Z84_GetDateTime(RdrCode, BD_R, ComNo, Prtcl, s1, s2,false) then
        begin
          mskDate.Text := '13' + s1;
          mskTime.Text := copy(s2,1,5);
          lblResult.Caption := 'Reader Date & Time are red';
        end
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      6: //Change Reader's Code
      begin
        if txtNRdrCode.Text = '' then
        begin
          MessageDlg('New reader code is invalid!', mtInformation, [mbOk], 0);
          txtNRdrCode.SetFocus;
        end
        else if Z84_ChangeAddress(RdrCode, BD_R, ComNo, Prtcl, StrToInt(txtNRdrCode.Text),false) then
          lblResult.Caption := 'Reader address is changed.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      7: //Change Reader's Baud Rate
      begin
        if cmbNBDR.Text = '' then
        begin
          MessageDlg('New reader baud rate is invalid!', mtInformation, [mbOk], 0);
          cmbNBDR.SetFocus;
        end
        else if Z84_ChangeBaudRate(RdrCode, BD_R, ComNo, Prtcl, StrToInt(cmbNBDR.Text),false) then
          lblResult.Caption := 'Reader baud rate is changed.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      8: //Set Limitation time
      begin
        if Z84_SendLimitTime(RdrCode, BD_R, ComNo, Prtcl, pchar(mskFTime1.Text+mskTTime1.Text),
                                                          pchar(mskFTime2.Text+mskTTime2.Text),
                                                          pchar(mskFTime3.Text+mskTTime3.Text),false) then
          lblResult.Caption := 'Limitation Time is set.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      9: //Read Limitation time
      begin
        if Z84_GetLimitTime(RdrCode, BD_R, ComNo, Prtcl, s1, s2, s3,false) then
        begin
          mskFTime1.Text := Copy(s1, 1, 5);
          mskTTime1.Text := Copy(s1, 9, 5);
          mskFTime2.Text := Copy(s2, 1, 5);
          mskTTime2.Text := Copy(s2, 9, 5);
          mskFTime3.Text := Copy(s3, 1, 5);
          mskTTime3.Text := Copy(s3, 9, 5);
          lblResult.Caption := 'Limitation Time is set.';
        end
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      10: //Send Message To Reader
      begin
        if Z84_SendReaderMsg(RdrCode, BD_R, ComNo, Prtcl, pchar(txtMsg1.Text),
                                                          pchar(txtMsg2.Text),
                                                          pchar(txtMsg3.Text),
                                                          pchar(txtMsg4.Text),false) then
        begin
          lblResult.Caption := 'Messages are sent.';
        end
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      11: //Send Message To Person
      begin
        ret := Z84_SendPersonMsg(RdrCode, BD_R, ComNo, Prtcl, pchar(txtCardCode.Text), pchar(txtMessage.Text),false);
        case ret of
          $06: lblResult.Caption := 'Message is sent.';
          $42: lblResult.Caption := 'Message is douplicated.';
          $43: lblResult.Caption := 'Memory is full.';
          else lblResult.Caption := 'Connection is invalid.';
        end;
      end;

      12: //Read Personal Message
      begin
        ret := Z84_GetPersonMsg(RdrCode, BD_R, ComNo, Prtcl, pchar(txtCardCode.Text), S1,false);
        case ret of
          $45: lblResult.Caption := 'Message not found.';
          $46:
          begin
            txtMessage.Text := s1;
            lblResult.Caption := 'Message is red.';
          end;
          else lblResult.Caption := 'Connection is invalid.';
        end;
      end;

      13: //Delete Personal Message
      begin
        ret := Z84_DelPersonMsg(RdrCode, BD_R, ComNo, Prtcl, pchar(txtCardCode.Text),false);
        case ret of
          $06: lblResult.Caption := 'Message is deleted.';
          $45: lblResult.Caption := 'Message not found.';
          else lblResult.Caption := 'Connection is invalid.';
        end;
      end;

      14: //Delete All Personal Message
      begin
        if Z84_DeleteAllReaderMessage(RdrCode, BD_R, ComNo, Prtcl,false) then
          lblResult.Caption := 'All messages are deleted.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      15: //Set Card No. Limitation
      begin
        if Length(txtFCardLimit.Text) < 8 then
        begin
          MessageDlg('Length of card must be 8 character.', mtInformation, [mbOk], 0);
          txtFCardLimit.SetFocus;
        end
        else if Length(txtTCardLimit.Text) < 8 then
        begin
          MessageDlg('Length of card must be 8 character.', mtInformation, [mbOk], 0);
          txtTCardLimit.SetFocus;
        end
        else if Z84_SetLimitCard(RdrCode, BD_R, ComNo, Prtcl, 1, pchar(txtFCardLimit.Text), pchar(txtTCardLimit.Text),false) then
          lblResult.Caption := 'Card limitation is set.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      16: //Read Card No. Limitation
      begin
        if Z84_GetLimitCard(RdrCode, BD_R, ComNo, Prtcl, 1, s1, s2,false) then
        begin
          txtFCardLimit.Text := s1;
          txtTCardLimit.Text := s2;
          lblResult.Caption := 'Card limitation is read.';
        end
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      17: //Change Relation Mode
      begin
        if Z84_ChangeOnOffMode(RdrCode, BD_R, ComNo, Prtcl, chkOnLine.Checked,false) then
          lblResult.Caption := 'Relation mode is changed.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      18: //Read Relation Mode
      begin
        if Z84_ReadOnOffMode(RdrCode, BD_R, ComNo, Prtcl, b,false) then
        begin
          chkOnLine.Checked := b;
          lblResult.Caption := 'Relation mode is red.';
        end
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      19: //MTT online processing
      begin
        onLineRecCount := 0;
        tmrOnline.Enabled := True;
      end;

      20, 21, 22: //reading record from reader
      begin
        b := True;
        n := 0;
        recCount := 0;
        case cmbCommands.ItemIndex of
          20: recType := ALL_COLLECTION;
          21: recType := ALL_RECOVERY;
          22: recType := NEW_RECOVERY;
          else recType := ALL_COLLECTION;
        end;

        repeat
          Z84_GetRecord(RdrCode, BD_R, ComNo, Prtcl, recType, pchar(mskDate.Text), b, ret, s1,false);
          if ret = MB_TRUEREC then
          begin
            b := False;
            if (Ord(s1[4]) < 32) or (Ord(s1[5]) < 32) then
            begin
              k := Ord(s1[5]) * 256 + Ord(s1[4]);
              tmp := s1;
              s1 := pchar(Copy(s1, 1, 3) + IntToStr(k) + Copy(s1, 6, 18));
            end;
            lstData.Items.Add(s1);
            n := 0;
            Inc(recCount);
            lblResult.Caption := IntToStr(recCount);
            lblRecNo.Caption := IntToStr(recCount);
            Refresh;
          end
          else
          begin
            b := True;
            Inc(n);
          end;
        until (ret = MB_BUFFEMPTY) or (ret = ERR_OFF) or (n = 2);

        if ret = MB_BUFFEMPTY then
        begin
          if recCount = 0 then
            lblResult.Caption := 'There is no new record.'
          else
            lblResult.Caption := IntToStr(recCount) + ' Records is collected';
        end
        else
        begin
          if recCount = 0 then
            lblResult.Caption := 'Connection is invalid.'
          else
            lblResult.Caption := IntToStr(recCount) + ' Records is collected incompletly';
        end;
      end;

      23: //Read reader's record and save to file
      begin
        recCount := Z84_GetRecordInFile(RdrCode, BD_R, ComNo, Prtcl, ALL_RECOVERY, pchar(mskDate.Text), pchar(txtFName.Text), ret,false);
        lblResult.Caption := IntToStr(recCount) + ' Records are read';
      end;
      24: //print to readers
      begin
        z84_PrintToReaders(RdrCode, BD_R, ComNo, Prtcl, PRN_ITHACA , txtMsg1.Text + txtMsg2.Text + txtMsg3.Text + txtMsg4.Text , false,true,false);
      end;
      25: //cut print
      begin
        z84_CutPrint(RdrCode, BD_R, ComNo, Prtcl, PRN_ITHACA , false);
      end;
      26: //send beep
      begin
        Z84_SendBeep(RdrCode, BD_R, ComNo, Prtcl, #1 , false);
      end;
      27: //send Only cards
      begin
        Z84_SetOnlyCards(RdrCode, BD_R, ComNo, Prtcl, txtCardCode.text + 'FFFFFFFF' , false);
      end;
      28: //Get Only cards
      begin
        Z84_GetOnlyCards(RdrCode, BD_R, ComNo, Prtcl, s4 , false);
        for i :=0 to (length(s4) div 8)-2 do
          lstData.Items.Add(copy(s4,i*8 ,8));
      end;
      29: //send Only cards
      begin
        Z84_SetAuthority(RdrCode, BD_R, ComNo, Prtcl, txtCardCode.text + 'FFFFFFFF' , false);
      end;
      30: //Get Only cards
      begin
        Z84_GetAuthority(RdrCode, BD_R, ComNo, Prtcl, s4 , false);
        for i :=0 to (length(s4) div 8)-2 do
          lstData.Items.Add(copy(s4,i*8 ,8));
      end;

    end;
  end;
end;

procedure TfrmCmndTest.tmrOnlineTimer(Sender: TObject);
begin
  MTT_Proc;
end;

end.
