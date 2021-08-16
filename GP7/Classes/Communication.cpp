#include        "COMMUNICATION.H"
#include        "NETWORK.H"
#include        "COM.H"
#include        "SETTING.H"
#include        "DIGITALDATA.H"
#include        "DATETIME.H"
#include        "FS.H"
#include        "UTILITY.H"
#include        "PERSONAL.H"
#include  	"STATUS.H"
#include  	"VIEW.H"
#include        "lcd.h"
#include        "Control.h"
#include        "Finger.h"
#include        "Hardware.h"
#include        "ShowTime.h"
#include        "Notify.h"

//extern IAP_return_TypeDef iap_return;
ConnectionType Communication::communication_type;

CommunicationPacket Communication::send_packet;
CommunicationPacket Communication::receive_packet;

OS_TIMER Communication::time_out;

bool Communication::is_busy;
char Communication::KindCode;
Activity Communication::activity;
DWORD Communication::FINGERID;
DWORD Communication::indexTemplate = 0;
BYTE Communication::BUFF[408];

OS_STACKPTR int Communication::stack_fill[384];
OS_TASK Communication::tcb_fill;

DWORD Communication::record_index;
DWORD Communication::from_dt;
DWORD Communication::to_dt;

OS_CSEMA Communication::sema;

RTCTime Communication::from, Communication::to;

Communication::Communication ()
{

}

Communication::~Communication ()
{

}

void Communication::Initial (void)
{
        Network lan;
        COM com;
        Setting set;
        Finger  f;

        OS_CreateCSema (&sema,1);

        communication_type = CT_None;

        send_packet.Clear();
        receive_packet.Clear();

        is_busy = false;
        KindCode = 0;
        activity = A_Enable;

        lan.ClearBuffers();
        com.ClearBuffers();

        com.AnalyzePermission(true);

        set.SetCommandExecuteSuccessEventforCOMMService(command_execute_successfully);
        set.SetCommandExecuteFailEventforCOMMService(command_execute_fail);

        com.SetReceiveCompleteEvent (com_packet_is_available);
        com.SetReceiveByteCompleteEvent(receive_byte_complete_com);
        lan.SetReceiveSuccessEvent (lan_packet_is_available);
        
        f.SetETXSuccessEvent(command_execute_successfully);
        f.SetETXfailEvent(command_ETX_fail);
        f.SetETXFingerExistEvent(command_ETX_finger_exist_fail);

        OS_CreateTimer(&time_out, timer_elapse_time_out, 10000);
}

void Communication::SetActivity (Activity A)
{
        activity = A;
}

void Communication::lan_packet_is_available (void)
{
        Network lan;
        Finger f;
        
        if (activity == A_Disable)
                return;

        communication_type = CT_LAN;

        receive_packet = (CommunicationPacket) lan.GetReceivedData();
        lan.ClearReceiveBuffer();

/*        if(Finger::FingerTemplateMode)
        {
          BYTE* str = receive_packet.GetStartAddress();
          if(strncmp((char*)str,"$$$$$$$$$$",10) == 0)
          {
              send_packet.Clear();
              receive_packet.SetCommand(CC_DisableFingerTemplateMode);
              f.SetFingerTemplateMode(false);
              send_simple_command_execute_success();
              //CounterDisableFinger = 0;
              return;
          }
          f.Send(str,receive_packet.Size());
          send_packet.Clear();
          return;
         }*/
        
        if (is_busy)
        {
                send_busy_packet();
                return;
        }

        if (!receive_packet.IsValid())
        {
                send_packet_error();
                return;
        }

        send_packet.Clear();

        handle_received_packet();
}

void Communication::com_packet_is_available (void)
{
        COM com;

        if (activity == A_Disable)
                return;

        communication_type = CT_COM;

        receive_packet = com.GetReceivedData();
        com.ClearReceiveBuffer();

        if (is_busy)
        {
                send_busy_packet();
                return;
        }

        if (!receive_packet.IsValid())
        {
                send_packet_error();
                return;
        }

        send_packet.Clear();

        handle_received_packet();
}

void Communication::handle_received_packet (void)
{
        DigitalData d;
        DateTime date;
        LCD lcd(Medium,Farsi);
        Setting s;
        RTCTime time;
        StatusBar st;
        View v;
        char bBuff[5];
        char cActive;
        Control c;
        bool bln;
        BYTE * ptr;
        Finger f;
        Personal pn;
        static int OparationMode;
        int RecCnt;
        
        send_packet.Clear();
        
        switch (receive_packet.GetCommand())
        {
                case CC_TestConnect:
                        send_packet.Clear();
                        send_packet.SetBroadCastFlag(false);
                        send_packet.SetAcknowledgeRequestFlag(false);
                        send_packet.SetMultiPacketFlag(false);
                        send_packet.SetLastPacketFlag(true);
                        send_packet.SetSecurityFlag(false);     //should be changed
                        send_packet.SetResponseRequest(false);               
                        send_packet.SetFrameNumber(0);
                        send_packet.SetDestinationID(receive_packet.GetSourceID());                
                        send_packet.SetFlag(CF_CommandExecuteSuccessfully); 
                        if(Device::TypeDevice.Mifare && Device::TypeDevice.Finger)
                                send_packet.SetExtraData (3);
                        else if(Device::TypeDevice.Finger)
                                send_packet.SetExtraData (1);
                        else if(Device::TypeDevice.Mifare)
                                send_packet.SetExtraData (2);
                        else
                                send_packet.SetExtraData (0);
                        send_packet.DeleteData();               
                        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());
                        send_packet.Make();
                        send_to_media();  
                break;
                case CC_EnableFingerTemplateMode:
                        if(Device::TypeDevice.Finger)
                        {
                                command_execute_successfully();
                        }
                        else
                                command_execute_fail();
                break;
                
                case CC_EnablePeripheral:
                        EnablePeripheral();
                break;
                
                case CC_DisablePeripheral:
                        DisablePeripheral();
                break;
               // case CC_DisableFingerTemplateMode:
                //        f.SetFingerTemplateMode(false);
               //         command_execute_successfully();
              //  break;
                case CC_SetUniqueCode:                          //kkk
                d.SetDword (receive_packet.GetExtraData());
                bBuff[0] = d.GetByte(0);
                bBuff[1] = d.GetByte(1);
                bBuff[2] = d.GetByte(2);
                bBuff[3] = d.GetByte(3);
                
                d.SetDword (receive_packet.GetFrameNumber());
                cActive = d.GetByte(0);
                /*
                if(! strncmp(bBuff,"GetS",4))
                {
                 if(c.read_serial_number()) 
                  send_Serial_Number_IC();
                 else
                  command_execute_fail(); 
                }
                */
                if(! strncmp(bBuff,"TrsU",4))
                  KindCode = 2;
                else if(! strncmp(bBuff,"TrsE",4))
                  KindCode = 1;
                else if(KindCode == 1)
                {
                  bln=c.Send_unique("TrsE",bBuff); 
                  if(bln == TRUE)
                  {                  
                   s.SetDeviceID(bBuff[3]*256*256*256 + bBuff[2]*256*256 + bBuff[1]*256 + bBuff[0]);
                   bBuff[0] = cActive;
                   bln=c.Send_unique("TrsA",bBuff);
                   if(bln == TRUE)
                    { 
                   if(cActive & 1)
                     Device::TypeDevice.Mifare = true;
                   else
                     Device::TypeDevice.Mifare = false;
                   if(cActive & 2)
                     Device::TypeDevice.GP8 = true;
                   else
                     Device::TypeDevice.GP8 = false;
                   if(cActive & 4)
                     Device::TypeDevice.Barcode = true;
                   else
                     Device::TypeDevice.Barcode = false;
                   if(cActive & 8)
                     Device::TypeDevice.Finger = true;
                   else
                     Device::TypeDevice.Finger = false;
                   
                     command_execute_successfully();
                     lcd.Clear();  
                     lcd.Write(A_Center, 3,"ÚãáíÇÊ ãæÝÞ");
                     lcd.font.SetSize(Small);
                   //f.SetSize(Small);
                     lcd.Write(A_Center, 6,"ÏÓÊÇå ÑÇ ÑíÓÊ äãÇííÏ");
                    }
                  }
                  else
                  {
                    lcd.Clear();
                    lcd.Write(A_Center, 3,"ÚãáíÇÊ äÇãæÝÞ"); 
                  }
                  KindCode = 0;
                }
                else if(KindCode == 2)
                {
                  bln=c.Send_unique("TrsU",bBuff); 
                  if(bln != TRUE)
                  {
                    lcd.Clear();
                    lcd.Write(A_Center, 3,"ÚãáíÇÊ äÇãæÝÞ");
                  }
                  KindCode = 0;
                 }
                break;

                case CC_SetTime:

                d.SetDword (receive_packet.GetExtraData());

                time.RTC_Sec = d.GetByte(0);
                time.RTC_Min = d.GetByte(1);
                time.RTC_Hour = d.GetByte(2);

                s.SetTime(time);

                v.Refresh();

                command_execute_successfully();

                break;

                case CC_SetDate:

                d.SetDword (receive_packet.GetExtraData());

                time.RTC_Mday = d.GetByte(0);
                time.RTC_Mon = d.GetByte(1);
                time.RTC_Year = d.GetWord(1);
                time.RTC_Wday = date.CalculateWday(time);
                              
                s.SetDate(time);

                st.Refresh();

                command_execute_successfully();

                break;

                case CC_SetDeviceMode:

                d.SetDword (receive_packet.GetExtraData());
                s.SetDeviceMode((PersonalIdentifyScenario) d.GetByte(0));
                s.SaveSettingsforCOMMService();

                break;

                case CC_SetFingerFreeScan:

                d.SetDword (receive_packet.GetExtraData());
                s.SetFingerFreeScanActivity(d.GetByte(0)==0?A_Disable:A_Enable);
                s.SaveSettingsforCOMMService();

                break;

                case CC_SetPreCard:

                d.SetDword (receive_packet.GetExtraData());
                s.SetDevicePreCard((PreCard) d.GetByte(0));
                s.SaveSettingsforCOMMService();

                break;

                case CC_GetTime:
                case CC_GetDate:
                case CC_GetDeviceMode:
                case CC_GetFingerFreeScan:
                case CC_GetPreCard:

                send_packet.SetBroadCastFlag(false);
                send_packet.SetAcknowledgeRequestFlag(false);
                send_packet.SetMultiPacketFlag(false);
                send_packet.SetLastPacketFlag(true);
                send_packet.SetSecurityFlag(false);     //should be changed
                send_packet.SetResponseRequest(false);

                send_packet.SetFrameNumber(0);
                send_packet.SetDestinationID(receive_packet.GetSourceID());

                send_packet.SetFlag(CF_CommandExecuteSuccessfully);

                send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

                send_packet.DeleteData();
                send_packet.SetExtraData (0);

                if (receive_packet.GetCommand() == CC_GetTime)
                {
                        d.SetByte(0, (BYTE) DateTime::Now().RTC_Sec);
                        d.SetByte(1, (BYTE) DateTime::Now().RTC_Min);
                        d.SetByte(2, (BYTE) DateTime::Now().RTC_Hour);
                        d.SetByte(3, (BYTE) 0);

                        send_packet.SetExtraData (d.GetDword());
                }

                if (receive_packet.GetCommand() == CC_GetDate)
                {
                        d.SetByte(0, (BYTE) DateTime::Now().RTC_Mday);
                        d.SetByte(1, (BYTE) DateTime::Now().RTC_Mon);
                        d.SetWord(1, (WORD) DateTime::Now().RTC_Year);

                        send_packet.SetExtraData (d.GetDword());
                }

                if (receive_packet.GetCommand() == CC_GetDeviceMode)
                {
                        d.SetByte(0, (BYTE) s.GetSettings().DeviceMode);
                        d.SetByte(1, (BYTE) 0);
                        d.SetByte(2, (BYTE) 0);
                        d.SetByte(3, (BYTE) 0);

                        send_packet.SetExtraData (d.GetDword());
                }

                if (receive_packet.GetCommand() == CC_GetFingerFreeScan)
                {
                        d.SetByte(0, (BYTE) s.GetSettings().FingerFreeScanActivity);
                        d.SetByte(1, (BYTE) 0);
                        d.SetByte(2, (BYTE) 0);
                        d.SetByte(3, (BYTE) 0);

                        send_packet.SetExtraData (d.GetDword());
                }

                if (receive_packet.GetCommand() == CC_GetPreCard)
                {
                        d.SetByte(0, (BYTE) s.GetSettings().DevicePreCard);
                        d.SetByte(1, (BYTE) 0);
                        d.SetByte(2, (BYTE) 0);
                        d.SetByte(3, (BYTE) 0);

                        send_packet.SetExtraData (d.GetDword());
                }

                send_packet.Make();

                //codding

                send_to_media();

                break;

                case CC_Collect:
                        if (receive_packet.GetError() != CF_CollectionAcknowledge)
                        {
                                send_packet.SetFrameNumber(0);
                                
                                ptr = receive_packet.GetStartAddressofData();                                                                
                                d.SetByte (3, *(ptr+3));                                                                                               
                                d.SetByte (2, *(ptr+2));                                                                                             
                                d.SetByte (1, *(ptr+1));                                                                                             
                                d.SetByte (0, *ptr);
                                
                                from_dt = d.GetDword();
                                from = DateTime::GetRealDateTime(d.GetDword());
                                from.RTC_Year = from.RTC_Year%100;
                                
                                d.SetByte (3, *(ptr+7));
                                d.SetByte (2, *(ptr+6));
                                d.SetByte (1, *(ptr+5));
                                d.SetByte (0, *(ptr+4));
                                
                                to_dt = d.GetDword();                           
                                to = DateTime::GetRealDateTime(d.GetDword());
                                to.RTC_Year = to.RTC_Year%100;

                                if (OS_IsTask(&tcb_fill))
                                        return;
                                
                                record_index = 0;
                                OparationMode = CC_Collect;

                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*) &OparationMode);
                        }

                        else if (receive_packet.GetError() == CF_CollectionAcknowledge)
                        {
                                if (OS_IsTask(&tcb_fill))
                                        return;
                                OparationMode = CC_Collect;
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                        }

                break;
                
                case CC_GetPersonalCnt:
                        RecCnt = 0;
                        if (is_file_exist("Personal", "Master.INF"))
                              RecCnt =  get_records_count("Personal", "Master.INF", sizeof(PersonInformation));

                        send_packet.SetExtraData(RecCnt);
        
                        send_records();
                  
                  break;
                  
                case CC_GetFingerCnt:
                        RecCnt = 0;
                        if (is_file_exist("Personal", "Finger.INF"))
                              RecCnt =  get_records_count("Personal", "Finger.INF", sizeof(IDPerson));

                        send_packet.SetExtraData(RecCnt);
        
                        send_records();
                  
                  break;
                  
                case CC_GetCardCnt:
                        RecCnt = 0;
                        if (is_file_exist("Personal", "Card.INF"))
                              RecCnt =  get_records_count("Personal", "Card.INF", sizeof(IDPerson));

                        send_packet.SetExtraData(RecCnt);
        
                        send_records();
                  
                  break;
                
                case CC_GetPersonalFile: 
                        OparationMode = CC_GetPersonalFile;
                         if (receive_packet.GetError() != CF_CollectionAcknowledge)
                        {
                                if (OS_IsTask(&tcb_fill))
                                        return;
                                
                                record_index = 0;
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                        }
                        else if (receive_packet.GetError() == CF_CollectionAcknowledge)
                        {
                                if (OS_IsTask(&tcb_fill))
                                        return; 
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                        }
                break;
                 
                case CC_SetPersonalFile:
                        bln = true;
                        if (receive_packet.GetError() == CF_CollectionFinish)
                        {
                                command_execute_successfully();
                        }
                        else
                        {
                                if (!is_file_exist("Personal","Master.INF"))
                                        bln &= pn.create_file("Personal", "Master.INF");
                
                                bln &= pn.append ("Personal", "Master.INF", receive_packet.GetStartAddressofData(), receive_packet.GetDataLength());
                                if(bln)
                                        send_Acknowledge_success();
                                else
                                        command_execute_fail(); 
                        }
                break;
                 
                case CC_GetFingerFile:
                        OparationMode = CC_GetFingerFile;
                         if (receive_packet.GetError() != CF_CollectionAcknowledge)
                        {
                                if (OS_IsTask(&tcb_fill))
                                        return;
                                
                                record_index = 0;
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                        }
                        else if (receive_packet.GetError() == CF_CollectionAcknowledge)
                        {
                                if (OS_IsTask(&tcb_fill))
                                        return; 
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                        }
                break;
          
                case CC_SetFingerFile:
                        bln = true;
                        if (receive_packet.GetError() == CF_CollectionFinish)
                        {
                                command_execute_successfully();
                        }
                        else
                        {
                                if (!is_file_exist("Personal","Finger.INF"))
                                        bln &= pn.create_file("Finger", "Master.INF");
                
                                bln &= pn.append ("Personal", "Finger.INF", receive_packet.GetStartAddressofData(), receive_packet.GetDataLength());
                                if(bln)
                                        send_Acknowledge_success();
                                else
                                        command_execute_fail(); 
                        }
                break;
                
                case CC_GetCardFile:
                         OparationMode = CC_GetCardFile;
                         if (receive_packet.GetError() != CF_CollectionAcknowledge)
                        {
                                if (OS_IsTask(&tcb_fill))
                                        return;
                                
                                record_index = 0;
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                        }
                        else if (receive_packet.GetError() == CF_CollectionAcknowledge)
                        {
                                if (OS_IsTask(&tcb_fill))
                                        return; 
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                        }
                break;
                
                case CC_SetCardFile:
                        bln = true;
                        if (receive_packet.GetError() == CF_CollectionFinish)
                        {
                                command_execute_successfully();
                        }
                        else
                        {
                                if (!is_file_exist("Personal","Card.INF"))
                                        bln &= pn.create_file("Personal", "Card.INF");
                
                                bln &= pn.append ("Personal", "Card.INF", receive_packet.GetStartAddressofData(), receive_packet.GetDataLength());
                                if(bln)
                                        send_Acknowledge_success();
                                else
                                        command_execute_fail(); 
                        } 
                break;
                
                case CC_DeletePersonalFile:
                         if (!is_file_exist("Personal","Master.INF"))
                           command_execute_successfully();
                         else
                         {
                           if(FS_Remove ("Personal\\Master.INF") == 0)
                             command_execute_successfully();
                           else
                             command_execute_fail(); 
                         }
                break;
                
                case CC_DeleteFingerFile:
                         if (!is_file_exist("Personal","Finger.INF"))
                           command_execute_successfully();
                         else
                         {
                           if(FS_Remove ("Personal\\Finger.INF") == 0)
                             command_execute_successfully();
                           else
                             command_execute_fail(); 
                         }
                break;
                
                case CC_DeleteCardFile:
                         if (!is_file_exist("Personal","Card.INF"))
                           command_execute_successfully();
                         else
                         {
                           if(FS_Remove ("Personal\\Card.INF") == 0)
                             command_execute_successfully();
                           else
                             command_execute_fail(); 
                         }
                break;
                case CC_SetPersonInfo:
                        PersonInformation pi;
                        DWORD NumofTemplate;
                        
                        if (receive_packet.GetError() == CF_None)
                        {
                            pi = receive_packet.GetPersonInfoWithConvertFingerIDtoUserID();
                            if(pn.IsUserExit(pi.PersonNumber))
                            {
                              send_command_With_ErrFlag(CF_PersonIsRepetitive);
                              break;
                            }
                            if(pn.IsCardRepet(pi.CardID))
                            {
                              send_command_With_ErrFlag(CF_CardIsRepetitive);
                              break;
                            }
                            if(!pn.AddPersonInfo(pi))
                            {
                              command_execute_fail();
                              break;
                            } 
                            else
                              FINGERID = pi.FingerID;
                            
                            NumofTemplate = receive_packet.GetExtraData();
                            if(NumofTemplate)
                            {
                                f.startEnrollTemplate(pi.FingerID);
                                send_Acknowledge_success();
                            }
                            else
                                command_execute_successfully();   
                        }
                        else if (receive_packet.GetError() == CF_CollectionAcknowledge)
                        {
                                if (OS_IsTask(&tcb_fill))
                                        return;
                                OparationMode = CC_SetPersonInfo;
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                        }
                        else if (receive_packet.GetError() == CF_CollectionFinish)
                        {
                                f.AppendFingerTemplate(receive_packet.GetStartAddressofData(), receive_packet.GetDataLength());
                                f.SendEnrollFinger(); 
                        }
                break; 
                case CC_GetPersonInfo:
                        DWORD Userid;
                        
                        if (receive_packet.GetError() == CF_None)
                        {
                            Userid = receive_packet.GetExtraData();
                            pi = pn.get_person_information(Userid);
                            FINGERID = pi.FingerID;
                            if(pi.PersonNumber && FINGERID == 0)
                            {
                                send_packet.AddData((void*)&pi, sizeof(pi));
                                send_packet.SetExtraData (0);
                                send_records(CF_CollectionFinish);
                            }
                            else if(pi.PersonNumber)
                            {
                                indexTemplate = 0;
                                send_packet.AddData((void*)&pi, sizeof(pi));
                                f.GetNumOfTemplate(FINGERID);
                             }
                            else
                            {
                                send_packet.AddData((void*)&pi, sizeof(pi));
                                send_packet.SetExtraData (0);
                                send_records(CF_CollectionFinish); 
                            }
                        }
                        else if (receive_packet.GetError() == CF_CollectionAcknowledge)
                        {
                            if(indexTemplate == 0)
                                f.GetTemplate(FINGERID, receive_packet.GetExtraData());
                            else
                            {
                                if (OS_IsTask(&tcb_fill))
                                        return;
                                OparationMode = CC_GetPersonInfo;
                                OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OparationMode);
                            }
                        }
                        //else if (receive_packet.GetError() == CF_CollectionFinish)
                        //    f.SendFingerTemplate(NunofTemplate);          
                break;
                case CC_DeletePerson:
                        Userid = receive_packet.GetExtraData();
                        if(pn.DeleteUser(Userid))
                            command_execute_successfully();
                        else
                            command_execute_fail();
                  break;
                  case CC_DeleteAllPerson:
                        if(pn.DeleteAllUser())
                            command_execute_successfully();
                        else
                            command_execute_fail();
                  break;
        }
}

void Communication::EnablePeripheral()
{
        Hardware h;
        ShowTime sh;
        View v;
        StatusBar s;
        NotifyBar n;
        Finger  f;
        
        h.UART2EnableInterrupt();
        //h.UART3EnableInterrupt();
        h.EnableKeyInterrupt();
        if(Device::TypeDevice.Finger)
                f.FreeScanMode(On);
        
        sh.UpdateScreenPermission(true);
        v.Refresh();
	n.Refresh();
	s.Refresh();
        command_execute_successfully();
}

void Communication::DisablePeripheral()
{
        Hardware h;
        ShowTime sh;
        LCD lcd(Farsi);
        Finger f;
        
        h.UART2DisableInterrupt();
        //h.UART3DisableInterrupt();
        h.DisableKeyInterrupt();
        if(Device::TypeDevice.Finger)
                f.FreeScanMode(Off);
        
        sh.UpdateScreenPermission(false);
        lcd.Clear();
        //lcd.SetPixelFormat(PF_Invert);
        lcd.Write("ÏÓÊÇå ÏÑ ãÏ ÇäÊÞÇá ...");
        //lcd.SetPixelFormat(PF_Normal);
        command_execute_successfully();
}

void Communication::command_execute_successfully (void)
{
        switch (receive_packet.GetCommand())
        {
                case CC_SetTime:
                case CC_SetDate:
                case CC_SetDeviceMode:
                case CC_SetFingerFreeScan:
                case CC_SetPreCard:
                case CC_SetUniqueCode:
                case CC_TestConnect: 
                case CC_EnableFingerTemplateMode:
                //case CC_DisableFingerTemplateMode:
                case CC_SetPersonalFile:  
                case CC_SetFingerFile:
                case CC_SetCardFile:
                case CC_DeletePersonalFile:
                case CC_DeleteFingerFile:
                case CC_DeleteCardFile:
                case CC_EnablePeripheral:
                case CC_DisablePeripheral:
                case CC_SetPersonInfo:
                case CC_DeletePerson:
                case CC_DeleteAllPerson:

                send_simple_command_execute_success();

                break;
        }
}

void Communication::send_simple_command_execute_success (void)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(false);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(0);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_CommandExecuteSuccessfully);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //codding

        send_to_media();
}

void Communication::send_Acknowledge_success (void)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(false);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(0);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_CollectionAcknowledge);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //codding

        send_to_media();
}

void Communication::command_execute_fail (void)
{
        switch (receive_packet.GetCommand())
        {
                case CC_SetTime:
                case CC_SetDate:
                case CC_SetDeviceMode:
                case CC_SetFingerFreeScan:
                case CC_SetPreCard:
                case CC_SetUniqueCode:
                case CC_EnableFingerTemplateMode:
                case CC_SetPersonalFile:  
                case CC_SetFingerFile:
                case CC_SetCardFile:
                case CC_DeletePersonalFile:
                case CC_DeleteFingerFile:
                case CC_DeleteCardFile:
                case CC_SetPersonInfo:
                case CC_GetPersonInfo:
                case CC_DeletePerson:
                case CC_DeleteAllPerson:

                send_simple_command_execute_fail();

                break;
        }
}

void Communication::send_simple_command_execute_fail (void)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(false);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(0);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_CommandExecuteFail);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //codding

        send_to_media();
}

void Communication::send_command_With_ErrFlag (COMMFlag flg)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(false);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(0);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(flg);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //codding

        send_to_media();
}

void Communication::send_busy_packet (void)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(false);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(0);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_DeviceIsBusy);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //Coding

        send_to_media();
}

void Communication::send_time_out_packet (void)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(false);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(0);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_ReceiveTimeout);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //Coding

        send_to_media();
}

void Communication::send_packet_error (void)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(false);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(0);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_PacketError);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //Coding

        send_to_media();
}

void Communication::collection_end_detection (void)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(true);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(receive_packet.GetFrameNumber()+1);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_CollectionFinish);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //Coding

        send_to_media();
}

void Communication::send_records (void)
{
        //send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(true);
        send_packet.SetMultiPacketFlag(true);
        send_packet.SetLastPacketFlag(false);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(receive_packet.GetFrameNumber()+1);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_CommandExecuteSuccessfully);

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //Coding

        send_to_media();
}

void Communication::send_records (COMMFlag flag)
{
        //send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(true);
        send_packet.SetMultiPacketFlag(true);
        send_packet.SetLastPacketFlag(false);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(receive_packet.GetFrameNumber()+1);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(flag);

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //Coding

        send_to_media();
}

void Communication::send_records (COMMFlag flag, bool LastRecord)
{
        //send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(true);
        send_packet.SetMultiPacketFlag(true);
        send_packet.SetLastPacketFlag(LastRecord);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(receive_packet.GetFrameNumber()+1);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(flag);

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //Coding

        send_to_media();
}

void Communication::error_detect_on_collection (void)
{
        send_packet.Clear();

        send_packet.SetBroadCastFlag(false);
        send_packet.SetAcknowledgeRequestFlag(false);
        send_packet.SetMultiPacketFlag(true);
        send_packet.SetLastPacketFlag(true);
        send_packet.SetSecurityFlag(false);     //should be changed
        send_packet.SetResponseRequest(false);

        send_packet.SetFrameNumber(receive_packet.GetFrameNumber()+1);
        send_packet.SetDestinationID(receive_packet.GetSourceID());

        send_packet.SetFlag(CF_CollectionError);

        send_packet.SetExtraData (0);
        send_packet.DeleteData();

        send_packet.SetCommand((COMMCommand)receive_packet.GetCommand());

        send_packet.Make();

        //Coding

        send_to_media();
}

void Communication::send_to_media (void)
{
        COM com;
        Network lan;

        if (send_packet.GetAcknowledgeRequestFlag())
                OS_RetriggerTimer(&time_out);

        if (communication_type == CT_COM)
                com.Send (&send_packet);

        if (communication_type == CT_LAN)
                lan.Send (&send_packet);
}

void Communication::timer_elapse_time_out (void)
{
        Network lan;
        COM com;

        if (communication_type == CT_None)
                return;

        send_time_out_packet ();

        communication_type = CT_None;

        is_busy = false;
}

void Communication::task_fill_packet_with_records (void* OperationMode)
{
        OS_WaitCSema(&sema);

        OS_EnterRegion();

        char fn[30];
        string str;
        Finger f;
        FS_FILE   *fp;
        int record_count = 0, collected_records = 0 ;
        
 while (1)
 {       
        //send_packet.DeleteData();
        switch(*(int*) OperationMode)
        {
        case CC_Collect:
                TrafficInformation partial_information;
                while (1)
                {
                       // if (from.RTC_Year > to.RTC_Year ||
                       //     from.RTC_Mon  > to.RTC_Mon  ||
                       //     from.RTC_Mday > to.RTC_Mday)
                        if (from.RTC_Year > to.RTC_Year ||
                           (from.RTC_Mon  > to.RTC_Mon && from.RTC_Year >= to.RTC_Year)  ||
                           (from.RTC_Mday > to.RTC_Mday && from.RTC_Mon  >= to.RTC_Mon && from.RTC_Year >= to.RTC_Year))
                        {
                                collection_end_detection();
                                OS_LeaveRegion();
                                OS_SignalCSema(&sema);
                                OS_Terminate(0);
                        }
                        
                        //str.clear();
                        str = "";
                        str += Utility::ToString(from.RTC_Year%100);
                	str += "_";
                	str += Utility::ToString(from.RTC_Mon);
                	str += "_";
                	str += Utility::ToString(from.RTC_Mday);	
                        str += ".RCD";

                        Utility::ToCharArray(str, fn);
                        
                        if (is_file_exist("Traffic", fn))
                        {
                                record_count =  get_records_count("Traffic", fn, sizeof(TrafficInformation));     
                                break;           
                        }                                               
                        
                        record_index = 0;
                        
                        from.RTC_Mday ++;

                        if (from.RTC_Mday > 31)
                        {
                                from.RTC_Mday = 1;
                                from.RTC_Mon ++;
                        }

                        if (from.RTC_Mon > 12)
                        {
                                from.RTC_Mon = 1;
                                from.RTC_Year ++;
                        }              
                };

                //str.clear();
                //str = "Traffic\\";
                str = Utility::ToString(from.RTC_Year%100);
                str += "_";
                str += Utility::ToString(from.RTC_Mon);
                str += "_";
                str += Utility::ToString(from.RTC_Mday);	
                str += ".RCD";
                
                //i = str.length();
                fn[0]=0;
                strcpy(fn,"Traffic\\");
                Utility::ToCharArray(str, &fn[8]);
                //str = "Traffic\\";
                //for (ctr=0;ctr<str.length();ctr++)
                //        fn[ctr] = str[ctr];
                //fn[ctr]=0;
                               
                fp = FS_FOpen (fn, "rb");

                if (fp == NULL)
                {
                        error_detect_on_collection();
                        OS_LeaveRegion();
                        OS_SignalCSema(&sema);
                        OS_Terminate(0);
                }

                FS_FSeek(fp, record_index * sizeof(TrafficInformation), FS_SEEK_SET);

                while ((record_index < record_count) && (collected_records < 10))
                {
                        FS_Read(fp, (void*) &partial_information, sizeof(TrafficInformation));
                        
                        if (from_dt <= partial_information.DT && to_dt >= partial_information.DT)
                        {
                                send_packet.AddData(&partial_information, 10);  
                                
                                collected_records++;
                        }
                        
                        record_index ++;
                }
                
                if (record_index == record_count)
                {                
                        from.RTC_Mday ++;

                        if (from.RTC_Mday > 31)
                        {
                                from.RTC_Mday = 1;
                                from.RTC_Mon ++;
                        }

                        if (from.RTC_Mon > 12)
                        {
                                from.RTC_Mon = 1;
                                from.RTC_Year ++;
                        }     
                        
                        record_index = 0;
                }
                
                send_packet.SetExtraData(collected_records);
                
                FS_FClose (fp);

                send_records();

                OS_SignalCSema(&sema);

                OS_LeaveRegion();

                OS_Terminate(0);
        
          break;
        case CC_GetPersonalFile:
                PersonInformation person;
                if (is_file_exist("Personal", "Master.INF"))
                              record_count =  get_records_count("Personal", "Master.INF", sizeof(PersonInformation));
                
                if(record_index >= record_count)
                {
                        collection_end_detection();
                        OS_LeaveRegion();
                        OS_SignalCSema(&sema);
                        OS_Terminate(0);
                }
                
                fp = FS_FOpen ("Personal\\Master.INF","rb");
                if (fp == NULL)
                {
                        error_detect_on_collection();
                        OS_LeaveRegion();
                        OS_SignalCSema(&sema);
                        OS_Terminate(0);
                }
                
                FS_FSeek(fp, record_index * sizeof(PersonInformation), FS_SEEK_SET);
               // while (record_index <= record_count)
               // {
                while ((record_index < record_count) && (collected_records < 5))
                {
                        FS_Read(fp, (void*) &person, sizeof(PersonInformation));
                        send_packet.AddData(&person, sizeof(PersonInformation));  
                        collected_records++;
                        record_index ++;
                }
                send_packet.SetExtraData(collected_records);
                //}
                                
                FS_FClose (fp);
        
                send_records();
                
                OS_SignalCSema(&sema);
        
                OS_LeaveRegion();
        
                OS_Terminate(0);
          break;
        case CC_GetFingerFile:
                IDPerson idp;
                if (is_file_exist("Personal", "Finger.INF"))
                              record_count =  get_records_count("Personal", "Finger.INF", sizeof(IDPerson));
                
                if(record_index >= record_count)
                {
                        collection_end_detection();
                        OS_LeaveRegion();
                        OS_SignalCSema(&sema);
                        OS_Terminate(0);
                }
                
                fp = FS_FOpen ("Personal\\Finger.INF","rb");
                if (fp == NULL)
                {
                        error_detect_on_collection();
                        OS_LeaveRegion();
                        OS_SignalCSema(&sema);
                        OS_Terminate(0);
                }
                
                FS_FSeek(fp, record_index * sizeof(IDPerson), FS_SEEK_SET);
               // while (record_index <= record_count)
               // {
                while ((record_index < record_count) && (collected_records < 12))
                {
                        FS_Read(fp, (void*) &idp, sizeof(IDPerson));
                        send_packet.AddData(&idp, sizeof(IDPerson));  
                        collected_records++;
                        record_index ++;
                }
                send_packet.SetExtraData(collected_records);
                //}
                                
                FS_FClose (fp);
        
                send_records();
                
                OS_SignalCSema(&sema);
        
                OS_LeaveRegion();
        
                OS_Terminate(0);
          break;
         case CC_GetCardFile:
                IDPerson iper;
                if (is_file_exist("Personal", "Card.INF"))
                              record_count =  get_records_count("Personal", "Card.INF", sizeof(IDPerson));
                
                if(record_index >= record_count)
                {
                        collection_end_detection();
                        OS_LeaveRegion();
                        OS_SignalCSema(&sema);
                        OS_Terminate(0);
                }
                
                fp = FS_FOpen ("Personal\\Card.INF","rb");
                if (fp == NULL)
                {
                        error_detect_on_collection();
                        OS_LeaveRegion();
                        OS_SignalCSema(&sema);
                        OS_Terminate(0);
                }
                
                FS_FSeek(fp, record_index * sizeof(IDPerson), FS_SEEK_SET);
               // while (record_index <= record_count)
               // {
                while ((record_index < record_count) && (collected_records < 12))
                {
                        FS_Read(fp, (void*) &iper, sizeof(IDPerson));
                        send_packet.AddData(&iper, sizeof(IDPerson));  
                        collected_records++;
                        record_index ++;
                }
                send_packet.SetExtraData(collected_records);
                //}
                                
                FS_FClose (fp);
        
                send_records();
                
                OS_SignalCSema(&sema);
        
                OS_LeaveRegion();
        
                OS_Terminate(0);
          break;
        case CC_SetPersonInfo:
          
                f.AppendFingerTemplate(receive_packet.GetStartAddressofData(), receive_packet.GetDataLength());
                send_Acknowledge_success();
                OS_SignalCSema(&sema);
                OS_LeaveRegion();
                OS_Terminate(0);
          break;
        case CC_GetPersonInfo:         
               // if(indexTemplate == 0)
                   
               // else
               // {
                     if(indexTemplate < FP_TemplateSize + 4 - FP_PackSendSize)
                        send_packet.AddData((void*)&BUFF[indexTemplate], FP_PackSendSize); 
                     else
                        send_packet.AddData((void*)&BUFF[indexTemplate], 
                                            FP_TemplateSize + 4 - indexTemplate);
                     send_packet.SetExtraData(0);
                     if(indexTemplate > FP_TemplateSize + 4 - FP_PackSendSize)
                     {
                        indexTemplate = 0;
                        send_records(CF_CollectionFinish, true);
                     }
                     else
                     {
                        indexTemplate+=FP_PackSendSize;
                        send_records(CF_CollectionAcknowledge);
                     } 
              // }
                OS_SignalCSema(&sema);
        
                OS_LeaveRegion();
        
                OS_Terminate(0);
          break;
  }
 }
}

bool Communication::is_file_exist (char file_path[], char file_name[])
{
	char path [100];
	FS_FILE   *fp;

	strcpy (path, "");

	strcat(path, file_path);
	strcat(path, "\\");
	strcat(path, file_name);
	
	fp = FS_FOpen(path,"rb");
	
	if (fp == NULL)
	{
		//FS_FClose(fp);
		return false;
	}
	
	else
	{
		FS_FClose(fp);
		return true;
	}
}

DWORD Communication::get_records_count (char file_path[], char file_name[], int record_length)
{
    if (!is_file_exist (file_path, file_name))
	    return 0;
	
	DWORD file_size;
	unsigned int  records_count;
	char path [100];
	FS_FILE   *fp;
	
	strcpy (path, "");

	strcat(path, file_path);
	strcat(path, "\\");
	strcat(path, file_name);
	
	fp = FS_FOpen(path,"rb");

        file_size = FS_GetFileSize(fp);
    	records_count = file_size / record_length;

	FS_FClose(fp);

	return  records_count;
}

SearchHit Communication::search (char file_path[], char file_name[], DWORD desire_data, int record_length)
{
	FS_FILE *fp;
	char path [100];
	int top, bottom, middle, records_count, index;
	DWORD   record;
	SearchHit sh;

	if (!is_file_exist (file_path, file_name))
	{
		sh.Hit = false;
		sh.Index = 0;
		
		return sh;
	}
	
	strcpy (path, "");

	strcat(path, file_path);
	strcat(path, "\\");	
	strcat(path, file_name);
	
	records_count = get_records_count(file_path, file_name, record_length);
	
	fp = FS_FOpen(path,"rb");
	
	top = records_count-1;
	bottom = 0;
	
	while(top>=bottom)
	{
		middle = (top+bottom) / 2;
		index = middle * record_length;

		FS_FSeek(fp, index, FS_SEEK_SET);
		FS_FRead(&record, sizeof(DWORD), 1, fp);
		
		if (record == desire_data)
		{
			sh.Hit = true;
			sh.Index = middle;
			sh.Value = record;

			FS_FClose(fp);
			return sh;
		}
		
		if (record < desire_data)
			bottom = middle+1;
		else
			top = middle-1;
	}	

	FS_FClose(fp);
	
	sh.Hit = false;
	sh.Index = middle;
	sh.Value = record;

	return sh;
}

void Communication::SendPersonRecordWithNumofFinger(DWORD num)
{
         send_packet.SetExtraData (num);
         send_records(CF_CollectionAcknowledge);
}

void Communication::SendBuffTemplateFinger(BYTE* buff)
{
         memcpy(BUFF, buff, sizeof(BUFF));
         static int OpMode;
         
         indexTemplate = 0;
         /*send_packet.AddData((void*)&BUFF[indexTemplate], FP_PackSendSize);  
         send_packet.SetExtraData(0);
         indexTemplate+=FP_PackSendSize;
         send_records(CF_CollectionAcknowledge);*/
         if (OS_IsTask(&tcb_fill))
            return;
         OpMode = CC_GetPersonInfo;
         OS_CREATETASK_EX(&tcb_fill, "Collection_Task", task_fill_packet_with_records, TP_RealTimePeriority, stack_fill, (void*)&OpMode);

}

void Communication::command_ETX_fail(void)
{
         Personal pn;
         
         if(!pn.DeleteUser(FINGERID))
            pn.DeleteUser(FINGERID);
         command_execute_fail();
}

void Communication::command_ETX_finger_exist_fail(void)
{
        Personal pn;
         
        if(!pn.DeleteUser(FINGERID))
            pn.DeleteUser(FINGERID);
        send_command_With_ErrFlag(CF_FingerIsRepetitive); 
}

void Communication::receive_byte_complete_com()
{       

}