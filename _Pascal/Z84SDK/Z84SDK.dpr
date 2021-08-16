library Z84SDK;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  ExceptionLog,
  SysUtils,
  Classes,
  Z84_Cmd in 'Z84_Cmd.pas',
  ComTools in 'ComTools.pas' {frmComTools},
  Code_Sys in '..\Shared\Code_Sys.pas',
  DateProc in '..\Shared\DateProc.pas',
  TCP_UDP in 'TCP_UDP.pas' {frmTcpUdp},
  Funcs in '..\Shared\Funcs.pas',
  Msgs in '..\Shared\Msgs.pas' {frmMsgBox};

{$R *.RES}

exports
//  FreeStringMem,
  Z84_LinkTest,
  Z84_ReStart,

  Z84_Initial,
  Z84_ReadVersion,

  Z84_SendDateTime,
  Z84_GetDateTime,

  Z84_ChangeAddress,
  Z84_ChangeBaudRate,

  Z84_SendLimitTime,
  Z84_GetLimitTime,

  Z84_SendReaderMsg,
  Z84_SendPersonMsg,
  Z84_GetPersonMsg,
  Z84_DelPersonMsg,
  Z84_DeleteAllReaderMessage,

  Z84_SetOpenDoor_Normal,
  Z84_SetOpenDoor_All,
  Z84_SetCloseDoor,

  Z84_SetAlarmTimes,
  Z84_GetAlarmTimes,
  Z84_DelAlarmTimes,

  Z84_SetInvalidCards,
  Z84_GetInvalidCards,
  Z84_DelInvalidCards,

  Z84_SetAccessCode,
  Z84_GetAccessCode,
  Z84_DelAccessCode,

  Z84_SetFunctionKeys,
  Z84_GetFunctionKeys,
  Z84_ChangeFunctionKeysActive,

  Z84_SetPishCard,
  Z84_GetPishCard,

  Z84_SetLimitCard,
  Z84_GetLimitCard,

  Z84_ChangeOnOffMode,
  Z84_ReadOnOffMode,

  Z84_GetRecord,
  Z84_GetRecordI,
  Z84_GetRecordInFile,

  MTT_OnLineRec,
  Z84_PrintToReaders,
  Z84_PrintToPrinter,
  Z84_CutPrint,
  Z84_SendBeep,
  Z84_SetOnlyCards,
  Z84_GetOnlyCards,
  Z84_SetAuthority,
  Z84_GetAuthority,

  Z84_LinkTest_LAN,
  Z84_ReStart_LAN,

  Z84_Initial_LAN,
  Z84_ReadVersion_LAN,

  Z84_SendDateTime_LAN,
  Z84_GetDateTime_LAN,

  Z84_ChangeAddress_LAN,

  Z84_SendLimitTime_LAN,
  Z84_GetLimitTime_LAN,

  Z84_SendReaderMsg_LAN,
  Z84_SendPersonMsg_LAN,
  Z84_GetPersonMsg_LAN,
  Z84_DelPersonMsg_LAN,
  Z84_DeleteAllReaderMessage_LAN,

  Z84_SetOpenDoor_Normal_LAN,
  Z84_SetOpenDoor_All_LAN,
  Z84_SetCloseDoor_LAN,

  Z84_SetAlarmTimes_LAN,
  Z84_GetAlarmTimes_LAN,
  Z84_DelAlarmTimes_LAN,

  Z84_SetInvalidCards_LAN,
  Z84_GetInvalidCards_LAN,
  Z84_DelInvalidCards_LAN,

  Z84_SetAccessCode_LAN,
  Z84_GetAccessCode_LAN,
  Z84_DelAccessCode_LAN,

  Z84_SetFunctionKeys_LAN,
  Z84_GetFunctionKeys_LAN,
  Z84_ChangeFunctionKeysActive_LAN,

  Z84_SetPishCard_LAN,
  Z84_GetPishCard_LAN,

  Z84_SetLimitCard_LAN,
  Z84_GetLimitCard_LAN,

  Z84_ChangeOnOffMode_LAN,
  Z84_ReadOnOffMode_LAN,

  Z84_GetRecord_LAN,
  Z84_GetRecordI_LAN,
  Z84_GetRecordInFile_LAN,

  MTT_OnLineRec_LAN,
  Z84_PrintToReaders_LAN,
  Z84_PrintToPrinter_LAN,
  Z84_CutPrint_LAN,
  Z84_SendBeep_LAN,
  Z84_SetOnlyCards_LAN,
  Z84_GetOnlyCards_LAN;
begin
end.
