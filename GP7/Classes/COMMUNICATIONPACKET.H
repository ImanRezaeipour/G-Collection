#ifndef 	__COMMUNICATIONPACKET__
#define 	__COMMUNICATIONPACKET__

#include 	"PACKET.H"
#include        "Personal.h"

enum COMMFlag
{
        CF_None = 0,
        CF_DeviceIsBusy,
        CF_PacketError,
        CF_CommandExecuteSuccessfully,
        CF_CommandExecuteFail,
        CF_ReceiveTimeout,
        CF_CollectionFinish,
        CF_CollectionError,
        CF_CollectionAcknowledge,
        CF_CardIsRepetitive,
        CF_FingerIsRepetitive,
        CF_PersonIsRepetitive
};

enum COMMCommand
{
        CC_SetTime = 1,
        CC_SetDate,
        CC_GetTime,
        CC_GetDate,
        CC_SetDeviceMode,
        CC_GetDeviceMode,
        CC_SetFingerFreeScan,
        CC_GetFingerFreeScan,
        CC_SetPreCard,
        CC_GetPreCard,
        CC_DeleteAllRecords,
        CC_Collect,
        CC_TestConnect,
        CC_GetPersonalCnt,
        CC_GetPersonalFile,
        CC_SetPersonalFile,
        CC_DeletePersonalFile,
        CC_GetFingerCnt,
        CC_GetFingerFile,
        CC_SetFingerFile,
        CC_DeleteFingerFile,
        CC_GetCardCnt,
        CC_GetCardFile,
        CC_SetCardFile,
        CC_DeleteCardFile,
        CC_EnableFingerTemplateMode,
        CC_EnablePeripheral,
        CC_DisablePeripheral,
        CC_SetPersonInfo,
        CC_GetPersonInfo,
        CC_DeletePerson,
        CC_DeleteAllPerson,
        CC_SetUniqueCode = 202
        //CC_DisableFingerTemplateMode
};

class CommunicationPacket : public Packet
{
public:
	CommunicationPacket ();
	~CommunicationPacket ();

	void SetBroadCastFlag (bool Flag);
       	void SetAcknowledgeRequestFlag (bool Flag);
	void SetMultiPacketFlag (bool Flag);
	void SetLastPacketFlag (bool Flag);
        void SetSecurityFlag (bool Flag);
        void SetResponseRequest (bool Flag);

	void SetFrameNumber (unsigned short int PacketNumber);
        void SetDestinationID (unsigned short int DestinationID);

        void SetCommand (COMMCommand C);
        void SetFlag (COMMFlag F);
        void SetExtraData (DWORD EXData);

        void SetData (Buffer * Data);
        void AddData (Buffer * Data);
        void AddData (void * Data, int Size);
        void DeleteData (void);
        	
       	bool GetBroadCastFlag (void);
	bool GetAcknowledgeRequestFlag (void);
	bool GetMultiPacketFlag (void);
	bool GetLastPacketFlag (void);
        bool GetSecurityFlag (void);
        bool GetSenderFlag (void);
        bool GetResponseRequest (void);

	unsigned short GetFrameNumber (void);
        unsigned short GetSourceID (void);
        unsigned short GetDestinationID (void);

        BYTE GetCommand (void);
        BYTE GetError (void);
        DWORD GetExtraData (void);

        BYTE GetDataLength (void);
        BYTE* GetStartAddressofData (void);

	bool IsValid (void);

	void Make (void);
        
        IDType CheckIdentityPerson(void);            //Transmit
        PersonInformation GetPersonInfoWithConvertFingerIDtoUserID(void);
	
private:
  	BYTE calculate_checksum (int first_location, int last_location);

	BYTE STX;
	BYTE ETX;
};

#endif