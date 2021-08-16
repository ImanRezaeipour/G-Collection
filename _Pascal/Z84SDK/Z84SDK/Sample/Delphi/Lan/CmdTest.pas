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
    cmbProtocol: TComboBox;
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
    txtIP: TEdit;
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
  Prtcl : Byte;     //Reader porotocol type (0 : udp ; 1:tcp ip)
  Ip_addr : string;
  ComNo,            //Com port    (1=COM1, 2=COM2, ...)
  BD_R : LongInt;   //Baud rate (2400, 4800, 9600, 19200, 38400)


PROCEDURE FreeStringMem(str : pchar);stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_LinkTest_LAN(RdrCode : Byte; prtcl : byte ; IP : string) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';


function  Z84_ReStart_LAN(RdrCode : Byte;prtcl : byte ; IP : string) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_Initial_LAN(RdrCode : Byte;prtcl : byte ; IP : string) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_ReadVersion_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var VersionST : pchar) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SendDateTime_LAN(RdrCode : Byte;prtcl : byte ; IP : string; DT, TM : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetDateTime_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var DT, TM : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_ChangeAddress_LAN(RdrCode : Byte;prtcl : byte ; IP : string; NewAddress : Byte) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SendLimitTime_LAN(RdrCode : Byte;prtcl : byte ; IP : string; ST1, ST2, ST3 : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetLimitTime_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var ST1, ST2, ST3 : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SendReaderMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : string; msg1 : STR_TYPE; msg2: STR_TYPE; msg3: STR_TYPE; msg4 : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_SendPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : string; CardCode, Msg : STR_TYPE) : Byte; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : string; CardCode : STR_TYPE; var Msg : STR_TYPE) : Byte; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DelPersonMsg_LAN(RdrCode : Byte;prtcl : byte ; IP : string; CardCode : STR_TYPE) : Byte; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DeleteAllReaderMessage_LAN(RdrCode : Byte;prtcl : byte ; IP : string) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetOpenDoor_Normal_LAN(RdrCode : Byte;prtcl : byte ; IP : string; DoorTime : Byte) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_SetOpenDoor_All_LAN(RdrCode : Byte;prtcl : byte ; IP : string; DoorTime : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_SetCloseDoor_LAN(RdrCode : Byte;prtcl : byte ; IP : string ; DoorTime : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : string; ST : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var ST : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DelAlarmTimes_LAN(RdrCode : Byte;prtcl : byte ; IP : string) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : string; ST : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var ST : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DelInvalidCards_LAN(RdrCode : Byte;prtcl : byte ; IP : string) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : string; ST : STR_TYPE) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var ST : STR_TYPE ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_DelAccessCode_LAN(RdrCode : Byte;prtcl : byte ; IP : string ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetFunctionKeys_LAN(RdrCode : Byte;prtcl : byte ; IP : string ; FKey1, FKey2, FKey3, FKey4 : Byte ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetFunctionKeys_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var FKey1, FKey2, FKey3, FKey4 : Byte ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_ChangeFunctionKeysActive_LAN(RdrCode : Byte;prtcl : byte ; IP : string; KeyActive : Boolean ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetPishCard_LAN(RdrCode : Byte;prtcl : byte ; IP : string; No : Byte; PishCard, CardNo : STR_TYPE ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetPishCard_LAN(RdrCode : Byte;prtcl : byte ; IP : string; No : Byte; var PishCard, CardNo : STR_TYPE ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_SetLimitCard_LAN(RdrCode : Byte;prtcl : byte ; IP : string; No : Byte; FromCard, ToCard : STR_TYPE ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_GetLimitCard_LAN(RdrCode : Byte;prtcl : byte ; IP : string; No : Byte; var FromCard, ToCard : STR_TYPE ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_ChangeOnOffMode_LAN(RdrCode : Byte;prtcl : byte ; IP : string; onLine : Boolean ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_ReadOnOffMode_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var onLine : Boolean ) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

procedure Z84_GetRecord_LAN(RdrCode : Byte;prtcl : byte ; IP : string; rType : Byte; DT : STR_TYPE; IsFirst : Boolean; var retVal : Byte; var Data : STR_TYPE ); stdcall;external '..\\..\\..\\Z84SDK.DLL';

procedure Z84_GetRecordI_LAN(RdrCode : Byte;prtcl : byte ; IP : string ;rType : Byte; DT : STR_TYPE; IsFirst : Boolean;
                         var retVal : Byte; var recType : Byte; var recDate : LongInt; var recTime : Integer; var recCard : LongInt ); stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_GetRecordInFile_LAN(RdrCode : Byte;prtcl : byte ; IP : string; rType : Byte; DT, FName : STR_TYPE; var retVal : Byte ) : Integer; stdcall;external '..\\..\\..\\Z84SDK.DLL';

procedure MTT_OnLineRec_LAN(RdrCode : Byte;prtcl : byte ; IP : string; isGetRec : Boolean; var data : STR_TYPE; var retCode : Byte ); stdcall;external '..\\..\\..\\Z84SDK.DLL';

function  Z84_PrintToReaders_LAN(RdrCode : Byte;prtcl : byte ; IP : string; printer_type : byte ; st : string; DblWidth , color :boolean):boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_PrintToPrinter_LAN(RdrCode : Byte;prtcl : byte ; IP : string; st : String ):boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';
function  Z84_CutPrint_LAN(RdrCode : Byte;prtcl : byte ; IP : string; printer_type : byte ):boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function Z84_SendBeep_LAN(RdrCode : Byte;prtcl : byte ; IP : string; count : Char) : Boolean; stdcall;external '..\\..\\..\\Z84SDK.DLL';

function Z84_SetOnlyCards_LAN(RdrCode : Byte;prtcl : byte ; IP : string; ST : string) : boolean;stdcall;external '..\\..\\..\\Z84SDK.DLL';
function Z84_GetOnlyCards_LAN(RdrCode : Byte;prtcl : byte ; IP : string; var ST : ansistring) : boolean;stdcall;external '..\\..\\..\\Z84SDK.DLL';



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
    MTT_OnLineRec_Lan(RdrCode, Prtcl, Ip_addr , True, data, ret);
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
        MTT_OnLineRec_LAN(RdrCode, Prtcl, Ip_addr, False, data, ret);
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
  Ver : pchar;
  tmp : pchar;
  fkey1, fkey2, fkey3, fkey4 : Byte;
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
  else if cmbProtocol.ItemIndex = -1 then
  begin
    MessageDlg('Protocol is invalid!', mtInformation, [mbOk], 0);
    cmbProtocol.SetFocus;
  end
  else if txtIP.Text = '' then
  begin
    MessageDlg('Ip address is invalid!', mtError, [mbOk], 0);
    txtIP.SetFocus;
  end
  else
  begin
    RdrCode := StrToInt(txtRdrCode.Text);
    Ip_addr := txtIP.Text;
    Prtcl := cmbProtocol.ItemIndex;
//    BD_R := StrToInt(cmbBaudRate.Text);

    case cmbCommands.ItemIndex of
      0: //Link Test
      begin
      if Z84_LinkTest_LAN(RdrCode, Prtcl, Ip_addr) then
          lblResult.Caption := 'Link test is Valid'
        else
          lblResult.Caption := 'Link test is inValid';
      end;

      1: //ReStart Reader
      begin
        if Z84_ReStart_LAN(RdrCode, Prtcl, Ip_addr) then
          lblResult.Caption := 'Reader is restarted.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      2: //Reader Configuration
      begin
        if Z84_Initial_LAN(RdrCode, Prtcl, Ip_addr) then
          lblResult.Caption := 'Reader is configured.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      3: //Reading Reader version
      begin
        if Z84_ReadVersion_LAN(RdrCode, Prtcl, Ip_addr, Ver) then
          lblResult.Caption := lblResult.Caption  + Ver
        else
          lblResult.Caption := 'Connection is invalid.';
//        FreeStringMem(Ver);
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
          if Z84_SendDateTime_LAN(RdrCode, Prtcl, Ip_addr, PCHAR(mskDate.Text),PCHAR(mskTime.Text)) then
            lblResult.Caption := 'Reader Date & Time are set.'
          else
            lblResult.Caption := 'Connection is invalid.';
        end;
      end;

      5: //Read Reader Date & Time
      begin
        if Z84_GetDateTime_LAN(RdrCode, Prtcl, Ip_addr,s1, s2) then
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
        else if Z84_ChangeAddress_LAN(RdrCode, Prtcl, Ip_addr, StrToInt(txtNRdrCode.Text)) then
          lblResult.Caption := 'Reader address is changed.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;
{
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
}
      8: //Set Limitation time
      begin
        if Z84_SendLimitTime_LAN(RdrCode, Prtcl, Ip_addr, PCHAR(mskFTime1.Text+mskTTime1.Text),
                                                          PCHAR(mskFTime2.Text+mskTTime2.Text),
                                                          PCHAR(mskFTime3.Text+mskTTime3.Text)) then
          lblResult.Caption := 'Limitation Time is set.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      9: //Read Limitation time
      begin
        if Z84_GetLimitTime_LAN(RdrCode, Prtcl, Ip_addr, s1, s2, s3) then
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
        if Z84_SendReaderMsg_LAN(RdrCode, Prtcl, Ip_addr, PCHAR(txtMsg1.Text),
                                                          PCHAR(txtMsg2.Text),
                                                          PCHAR(txtMsg3.Text),
                                                          PCHAR(txtMsg4.Text)) then
        begin
          lblResult.Caption := 'Messages are sent.';
        end
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      11: //Send Message To Person
      begin
        ret := Z84_SendPersonMsg_LAN(RdrCode, Prtcl, Ip_addr, PCHAR(txtCardCode.Text), PCHAR(txtMessage.Text));
        case ret of
          $06: lblResult.Caption := 'Message is sent.';
          $42: lblResult.Caption := 'Message is douplicated.';
          $43: lblResult.Caption := 'Memory is full.';
          else lblResult.Caption := 'Connection is invalid.';
        end;
      end;

      12: //Read Personal Message
      begin
        ret := Z84_GetPersonMsg_LAN(RdrCode, Prtcl, Ip_addr, txtCardCode.Text, S1);
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
        ret := Z84_DelPersonMsg_LAN(RdrCode, Prtcl, Ip_addr, PCHAR(txtCardCode.Text));
        case ret of
          $06: lblResult.Caption := 'Message is deleted.';
          $45: lblResult.Caption := 'Message not found.';
          else lblResult.Caption := 'Connection is invalid.';
        end;
      end;

      14: //Delete All Personal Message
      begin
        if Z84_DeleteAllReaderMessage_LAN(RdrCode, Prtcl, Ip_addr) then
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
        else if Z84_SetLimitCard_LAN(RdrCode, Prtcl, Ip_addr, 1, PCHAR(txtFCardLimit.Text), PCHAR(txtTCardLimit.Text)) then
          lblResult.Caption := 'Card limitation is set.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      16: //Read Card No. Limitation
      begin
        if Z84_GetLimitCard_LAN(RdrCode, Prtcl, Ip_addr, 1, s1, s2) then
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
        if Z84_ChangeOnOffMode_LAN(RdrCode, Prtcl, Ip_addr, chkOnLine.Checked) then
          lblResult.Caption := 'Relation mode is changed.'
        else
          lblResult.Caption := 'Connection is invalid.';
      end;

      18: //Read Relation Mode
      begin
        if Z84_ReadOnOffMode_LAN(RdrCode, Prtcl, Ip_addr,b) then
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
          tmp := StrAlloc(length(mskDate.Text)+1);
          StrPCopy(tmp , mskDate.Text);
          Z84_GetRecord_LAN(RdrCode, Prtcl, Ip_addr, recType, tmp, b, ret, s1);
          if ret = MB_TRUEREC then
          begin
            b := False;
            if (Ord(s1[4]) < 32) or (Ord(s1[5]) < 32) then
            begin
              k := Ord(s1[5]) * 256 + Ord(s1[4]);
              s1 := PCHAR(Copy(s1, 1, 3) + IntToStr(k) + Copy(s1, 6, 18));
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
        recCount := Z84_GetRecordInFile_LAN(RdrCode, Prtcl, Ip_addr, ALL_RECOVERY, PCHAR(mskDate.Text), PCHAR(txtFName.Text), ret);
        lblResult.Caption := IntToStr(recCount) + ' Records are read';
      end;
      24: //print to readers
      begin
        z84_PrintToReaders_LAN(RdrCode, Prtcl, Ip_addr, PRN_ITHACA , txtMsg1.Text , false,true);
        z84_PrintToReaders_LAN(RdrCode, Prtcl, Ip_addr, PRN_ITHACA , txtMsg2.Text , false,true);
        z84_PrintToReaders_LAN(RdrCode, Prtcl, Ip_addr, PRN_ITHACA , txtMsg3.Text , false,true);
        z84_PrintToReaders_LAN(RdrCode, Prtcl, Ip_addr, PRN_ITHACA , txtMsg4.Text , false,true);
      end;
      25: //cut print
      begin
        Z84_CutPrint_LAN(RdrCode, Prtcl, Ip_addr, PRN_ITHACA);
      end;
      26: //send beep
      begin
        Z84_SendBeep_LAN(RdrCode, Prtcl, Ip_addr, #9);
      end;
      27: //send Only cards
      begin
        Z84_SetOnlyCards_LAN(RdrCode, Prtcl, Ip_addr, txtCardCode.text + 'FFFFFFFF');
      end;
      28: //Get Only cards
      begin
        Z84_GetOnlyCards_LAN(RdrCode, Prtcl, Ip_addr, s4);
        for i :=0 to (length(s4) div 8)-2 do
          lstData.Items.Add(copy(s4,i*8 ,8));
      end;
      29: //Set Function Keys
      begin
        if (Z84_SetFunctionKeys_LAN(RdrCode, Prtcl, Ip_addr, StrToInt(txtMsg1.Text),StrToInt(txtMsg2.Text),StrToInt(txtMsg3.Text),StrToInt(txtMsg4.Text))) and
           (Z84_ChangeFunctionKeysActive_LAN(RdrCode, Prtcl, Ip_addr, True)) then
          lblResult.Caption := 'Set function keys completed.'
        else
          lblResult.Caption := 'Set function keys didn''t complete.';
      end;
      30: //Function Keys Deactive
      begin
        if Z84_ChangeFunctionKeysActive_LAN(RdrCode, Prtcl, Ip_addr, False) then
          lblResult.Caption := 'Function Keys Deactive completed.'
        else
          lblResult.Caption := 'Function Keys Deactive didn''t complete.';
      end;
      31: //Get Function Keys
      begin
        if Z84_GetFunctionKeys_LAN(RdrCode, Prtcl, Ip_addr, fkey1, fkey2, fkey3, fkey4) then
        begin
          txtMsg1.Text := IntToStr(fkey1);
          txtMsg2.Text := IntToStr(fkey2);
          txtMsg3.Text := IntToStr(fkey3);
          txtMsg4.Text := IntToStr(fkey4);
          lblResult.Caption := 'Get function keys completed.';
        end
        else
        begin
          lblResult.Caption := 'Get function keys didn''t complete.';
        end;
      end;
    end;
  end;
end;

procedure TfrmCmndTest.tmrOnlineTimer(Sender: TObject);
begin
   MTT_Proc;
end;

end.
