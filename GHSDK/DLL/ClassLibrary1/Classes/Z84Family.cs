using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Windows.Forms;
using System.Timers;
using System.Net;
using System.Threading;

namespace Ghadir_UI
{
    public class Z84Family
    {      
        /// <summary>
        /// enum
        /// </summary>
        public enum RecordingType
        {
            CreateXMLFile,
            CreateTXTFile,
            AppendToTXTFile
        }

        public enum DeviceCommand
        {
            LinkTest,
            Collection,            
            Acknowledge,
            SetAccessCode,
            ClearAccessCode,
            SetTimeAndDate,
            Reset,
            GetAccessCode,
            ReadVersion,
            SetTerminalAddress,
            DisplayRowMessage,
            ClearScreen,
            NoneAcknowledge,
            ShortMessage,
            ChangeKeypadPassword,
            EnterSelfPrograming,
            ClearErrorBuffer,
            GetErrorBuffer,
            ReInitialization,
            GetTimeAndDate,
            SetAlarms,
            ClearAlarms,
            GetAlarms,
            SetNoneAuthorizeCards,
            ClearNonAuthorizeCards,
            GetNonAuthorizeCards,
            OpenDoor,
            LockDoor,
            UnLockDoor,
            SetBaudRate,
            RecoveryByDate,
            GetImage,
            PermanentRecovery,
            Setpolling,
            FastCollection,
            SetFunctionKeys,
            SetCardLimit,
            GetOnlyCardList,
            ClearOnlyCardList,
            SetOnlycardlist,
            ClearAllMessage,
            SetMessage,
            GetMessage,
            ClearOneCardMessage,
            SetParameter,          
            GetParameter,
            SetTimeLimit,
            GetTimeLimit,
            MultiBeep,
            GetAuthorityList,
            ClearAuthorityList,
            SetAuthorityList,
            SetPreCard,
            GetPreCard,          
            GetStartAddressTable,
            GetTableSpecification,
            DownloadBlockData,
            DownloadLastBlock,
            GetTable,
            SetDoorBuzzer,
            SetWorkMode,
            PrintData,
            DirectPrint,
            ReadOneRecord,
            SetPrinter
        }

        public enum TerminalFunctionKeyMode
        {
            EnableFunctionKey = 1,
            DisableFunctionKey
        }

        public enum TerminalTableSpecification
        {
            NumberOfBlocks = 0,
            BlockSize,
            DestinationTableNumber
        }

        public enum TerminalBuzzerDoor
        {
            Enable = 1,
            Disable
        }

        public enum TerminalWorkMode
        {
            OnLine = 1,
            OffLine
        }

        public enum TerminalPrinter
        {
            LX_Printer = 0,
            LQ_Printer,
            Star_Printer
        }

        public enum TerminalBaudRate
        {
            BaudRaate_50 = 0,
            BaudRaate_75,
            BaudRaate_150,
            BaudRaate_200,
            BaudRaate_300,
            BaudRaate_600,
            BaudRaate_1200,
            BaudRaate_2400,
            BaudRaate_4800,
            BaudRaate_9600,
            BaudRaate_19200,
            BaudRaate_38400
        }

        private enum media_reserv_type
        {
            collection,
            recovery,
            self_programming,
            none
        }

        public enum TerminalPollingMode
        {
            ActivePolling = 1,
            InactivePolling
        }

        public enum TerminalFontType
        {
            Font8_16 = 1
        }

        public enum TerminalError
        {
            PointerError = 1,
            RamError
        }

        [Flags]
        public enum TerminalOutput
        {
            ErrorLED = 0x01,
            OkLED = 0x02,
            ReadyLED = 0x04,
            Buzzer = 0x08,
            Relay1 = 0x10,
            Relay2 = 0x20
        }

        public enum Z84UnderLayingMedia
        {
            Serial = 1,
            Network,
            Modem
        }

        public enum Z84ClassError
        {
            NoErrorOccur = 0,
            NoPhysicalMediaAssign,
            ErrorOnCreateSerialMedia,
            ErrorOnCreateNetworkMedia,
            ErrorOnSendPacket,
        }

        public enum CollectFinishState
        {
            Success,
            Unsuccess
        }


        /// <summary>
        /// element member
        /// </summary>         
        protected DeviceCommand last_command;
        private RecordingType recording_type = RecordingType.CreateXMLFile;
        private Boolean reserv_media_flag = false;      
        private media_reserv_type reserv_media_cause = media_reserv_type.none;
        private Boolean wait_for_responce = new Boolean();
        private Boolean media_assign = false;
        private System.Timers.Timer timer;// = new System.Timers.Timer();       
        private UInt64 address;
        private IOBase media;
        private Boolean show_message_on_collection = true;
        private int max_error = 3;
        private int trail_error = 0;
        private Thread externThread;
        private Boolean printComplete = false;

        private ErrorTable errors = new ErrorTable();
        public PacketInfo Information = new PacketInfo();
        private ArrayList expected_data = new ArrayList();
        protected Z84Frame frame_to_send = new Z84Frame(1);
        protected Z84Frame received_frame = new Z84Frame();
        public CollectedRecords collected_data = new CollectedRecords();
        public CollectedRecords last_twenty_collected_data = new CollectedRecords();
        public OneRecord last_collected_record = new OneRecord();
        public OneRecord last_collected_online_record = new OneRecord(); //restkk
        public UInt64 last_received_status = new UInt64();

        /// <summary>
        /// delegate
        /// </summary>
        /// <param name="SendPacket"></param>
        public delegate void SendEvent(Z84Frame SendPacket);
        public delegate void ReceiveEvent(ArrayList ReceivePacket);
        public delegate void NotResponceEvent(ArrayList LastSentCommand);
        public delegate void ErrorOnReceiveEvent(Z84Frame.Z84PacketErrors Error);
        public delegate void ReceiveSuccessEvent(PacketInfo Info, UInt64 PacketCount, UInt64 PacketLenght);
        public delegate void CollectFinishEvent(CollectFinishState state,int Count);
        public delegate void OneCollectFinishEvent();
        public delegate void TwentyCollectFinishEvent(int Count);
        public delegate void OneOnlineCollectFinishEvent(); //restkk
        public delegate void MultiBadPacketEvent();
        public delegate void NoMoreRecordsFound();
        public delegate void DirectPrintCompleteEvent();

        public delegate void NotResponceEventTh(ArrayList LastSentCommand, Thread iThread); //restkk
        public delegate void CollectFinishEventTh(CollectFinishState state, int Count, Thread iThread); //restkk
        public delegate void OneOnlineCollectFinishEventTh(object sender, Thread iThread); //restkk Ghadir_UI.Z84Family retDevice,
        public delegate void MultiBadPacketEventTh(Thread iThread); //restkk
        public delegate void NoMoreRecordsFoundTh(Thread iThread); //restkk
        public delegate void DirectPrintCompleteEventTh(Thread iThread); //restkk

        /// <summary>
        /// event
        /// </summary>      
        public event ReceiveSuccessEvent CommandDone;
        public event ErrorOnReceiveEvent BadReceivePacket;
        public event SendEvent SendComplete;
        public event ReceiveEvent ReceiveComplete;
        public event NotResponceEvent NotResponse;
        public event CollectFinishEvent CollectFinish;
        public event OneCollectFinishEvent OneCollectFinish;
        public event TwentyCollectFinishEvent TwentyCollectFinish;
        public event OneOnlineCollectFinishEvent OneOnlineCollectFinish; //restkk
        public event MultiBadPacketEvent MultiErrorOnReceive;
        public event NoMoreRecordsFound NoMoreRecords;
        public event DirectPrintCompleteEvent DirectPrintComplete; //restkk

        public event NotResponceEventTh NotResponseTh; //restkk
        public event CollectFinishEventTh CollectFinishTh; //restkk
        public event OneOnlineCollectFinishEventTh OneOnlineCollectFinishTh; //restkk
        public event MultiBadPacketEventTh MultiErrorOnReceiveTh; //restkk
        public event NoMoreRecordsFoundTh NoMoreRecordsTh; //restkk
        public event DirectPrintCompleteEventTh DirectPrintCompleteTh; //restkk
        /// <summary>
        /// properties
        /// </summary>
        ///  

        public int MaxError
        {
            get
            {
                return max_error;
            }
            set
            {
                max_error = value;
            }
        }

        public Thread ExternThread
        {
            get
            {
                return externThread;
            }
            set
            {
                externThread = value;
            }
        }

        public Boolean PrintComplete
        {
            get
            {
                return printComplete;
            }
            set
            {
                printComplete = value;
            }
        }

        public Boolean MediaAssign
        {
            get
            {
                return media_assign;
            }
        } 

        public IOBase Media
        {
            get
            {
                return media;
            }
        }

        public UInt64 TerminalAddress
        {
            set
            {
                address = value;
                frame_to_send.Address = (Byte)value;
            }
            get
            {
                return address;
            }
        }
        
        public UInt64 TimeOut
        {
            set
            {
//                destroyTimer();
//                createTimer();
//                timer.Stop();
//                timer.Interval = Convert.ToUInt64(value);

            }
            get
            {
                return Convert.ToUInt64(timer.Interval);
            }
        }

        public DeviceCommand LastCommand
        {
            get
            {
                return last_command;
            }
        }

        public RecordingType Recording
        {
            set
            {
                recording_type = value;
            }
        }

        public string XMLFilePath
        {
            get
            {
                return collected_data.XMLFilePath;
            }
            set
            {

                collected_data.XMLFilePath = value;
            }
        }

        public string TXTFilePath
        {
            get
            {
                return collected_data.TXTFilePath;
            }
            set
            {

                collected_data.TXTFilePath = value;
            }
        }
       
        public Boolean MediaIsReserve
        {
            get
            {
                return reserv_media_flag;
            }
        }

        public Boolean WaitForReceive
        {
            set
            {
                wait_for_responce = value;
            }
            get
            {
                return wait_for_responce;
            }
        }

        public Z84Frame LastSentPacket
        {
            get
            {
                return frame_to_send;
            }
        }

        public Z84Frame LastReceivedPacket
        {
            get
            {
                return received_frame;
            }
        }

        public Boolean ShowMessageOnCollection
        {
            set
            {
                show_message_on_collection = value;
            }
        }


        // virtual function
        
        /// <summary>
        /// ACC1000 functions
        /// </summary>
        public virtual void ShortMessage(UInt64 BeepCount, string Message)
        {
        }
        public virtual void SetFunctionKeys(Char Mode)
        {
        }
        public virtual void SetFunctionKeys(TerminalFunctionKeyMode Mode)
        {
        }
        public virtual void ClearAllMessage()
        {
        }
        public virtual void SetMessage(CardNumber CardNumber, string Message)
        {
        }
        public virtual void GetMessage(CardNumber Number)
        {
        }
        public virtual void ClearOneCardMessage(CardNumber Number)
        {
        }
        public virtual void SetParameter(char MealType, char Status, char FoodCOde, char len, string data, char defaultFood)
        {
        }
        public virtual void SetTimeLimit(string From1, string To1, string From2, string To2, string From3, string To3)
        {
        }
        public virtual void GetParameter(char MealType, char Status, char FoodCode)
        {
        }
        public virtual void GetTimeLimit()
        {
        }
        public virtual void GetStartAddressTable()
        {
        }
        public virtual void GetTableSpecification(TerminalTableSpecification Data)
        {
        }
        public virtual void DownloadBlockData(UInt64 BlockNumber, Byte[] Data)
        {
        }
        public virtual void DownloadBlockData(UInt64 BlockNumber, ArrayList Data)
        {
        }
        public virtual void DownloadBlockData(UInt64 BlockNumber, string Data)
        {
        }
        public virtual void DownloadLastBlock(UInt64 BlockNumber, Byte[] Data)
        {
        }
        public virtual void DownloadLastBlock(UInt64 BlockNumber, string Data)
        {
        }
        public virtual void DownloadLastBlock(UInt64 BlockNumber, ArrayList Data)
        {
        }
        public virtual void DownloadLastBlock(UInt64 BlockNumber)
        {
        }
        public virtual void GetTable()
        {
        }
        public virtual void SetDoorBuzzer(Char Buzzer)
        {
        }
        public virtual void SetDoorBuzzer(TerminalBuzzerDoor Buzzer)
        {
        }
        /// <summary>
        /// CLK6000 functions
        /// </summary>       
        public virtual void FastCollection()
        {
        }
        /*public virtual void SetFunctionKeys(Char Mode)
        {
        }
        public virtual void SetFunctionKeys(TerminalFunctionKeyMode Mode)
        {
        }
        public virtual void ClearAllMessage()
        {
        }
        public virtual void SetMessage(CardNumber CardNumber, string Message)
        {
        }
        public virtual void GetMessage(CardNumber Number)
        {
        }
        public virtual void SetParameter()
        {
        }
        public virtual void GetParameter()
        {
        }
        public virtual void ClearOneCardMessage(CardNumber Number)
        {
        }
                 
                 
         */
        public virtual void GetPreCard(UInt64 Location)
        {
        }
        public virtual void SetPreCard(UInt64 Locatin, CardNumber CardNumber, UInt64 Code)
        {
        }
        public virtual void SetAuthorityList(AuthorityListGroup Group)
        {
        }
        public virtual void ClearAuthorityList()
        {
        }
        public virtual void GetAuthorityList()
        {
        }
        public virtual void MultiBeep(UInt64 Count)
        {
        }
        public virtual void SetOnlycardlist(CardListGroup Group)
        {
        }
        public virtual void SetOnlycardlist(AuthorityListGroup Group)
        {
        }
        public virtual void ClearOnlyCardList()
        {
        }
        public virtual void GetOnlyCardList()
        {
        }
        public virtual void SetCardLimit(UInt64 Location, CardNumber Start, CardNumber End)
        {
        }
        /// <summary>
        /// MTT5000 functions
        /// </summary>
        public virtual void SetWorkMode(Char Mode)
        {
        }
        public virtual void SetWorkMode(TerminalWorkMode Mode)
        {
        }
        public virtual void PrintData(byte[] Message)
        {
        }
        public virtual void PrintData(string Message)
        {
        }
        public virtual void DirectPrint(ArrayList Buffer)
        {
        }
        public virtual void ReadOneRecord()
        {
        }
        public virtual void SetPrinter(TerminalPrinter Printer)
        {
        }

        /*          
        public virtual void SetCardLimit(UInt64 Location, CardNumber Start, CardNumber End)
        {
        } 
        public virtual void SetParameter()
        {
        }
        public virtual void GetParameter()
        {
        }          
        */






       /// <summary>
       /// proc
       /// </summary>
       /// <param name="type"></param>
        public Boolean IsCommandDone = false;
        private void reserve_media(media_reserv_type type)
        {
            reserv_media_flag = true;
            reserv_media_cause = type;
        }

        private void free_media()
        {
            reserv_media_flag = false;
            reserv_media_cause = media_reserv_type.none;
        }

        protected void send_frame()
        {
            if (wait_for_responce)
                return;
            if (reserv_media_flag)
                return;
            if (!media_assign)
            {
                on_error_occur(Z84ClassError.NoPhysicalMediaAssign);
                return;
            }     
            try
            {
                media.SendToClient(frame_to_send.MakeFrame());
                wait_for_responce = true;               
            }
            catch
            {
                on_error_occur(Z84ClassError.ErrorOnSendPacket);
            }
            createTimer();
//            timer.Start();
        }

        protected void send_directprintframe(ArrayList directprintframe)
        {
            if (wait_for_responce)
                return;
            if (reserv_media_flag)
                return;
            if (!media_assign)
            {
                on_error_occur(Z84ClassError.NoPhysicalMediaAssign);
                return;
            }     
            try
            {
                frame_to_send.SetEntireFrame(directprintframe);
                media.SendToClient(directprintframe);
                wait_for_responce = true;               
            }
            catch
            {
                on_error_occur(Z84ClassError.ErrorOnSendPacket);
            }
            createTimer();
//            timer.Start();
        }

        private void internal_send_frame()
        {
            if (!media_assign)
            {
                on_error_occur(Z84ClassError.NoPhysicalMediaAssign);
                return;
            }
            try
            {
                media.SendToClient(frame_to_send.MakeFrame());
                wait_for_responce = true;
            }
            catch
            {
                on_error_occur(Z84ClassError.ErrorOnSendPacket);
            }
            createTimer();
//            timer.Start();
        }

        private void internal_send_frame(UInt64 Command)
        {
            frame_to_send.Command = Command;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            internal_send_frame();
        }

        private void internal_send_frame(UInt64 Command, UInt64 Status)
        {
            frame_to_send.Command = Command;
            frame_to_send.Status = Status;
            frame_to_send.EmptyDataField();
            internal_send_frame();
        }

        public ErrorTable GetErrors()
        {
            return errors;
        }

        private void on_error_occur(Error Error)
        {
            errors.Add(Error);
        }

        private void on_error_occur(Z84ClassError ErrorValue)
        {
            Error temp = new Error(ErrorValue);
            errors.Add(temp);
        }

        protected void send_frame(UInt64 Command)
        {
            frame_to_send.Command = Command;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            send_frame();
        }
       
        protected void send_frame(UInt64 Command ,UInt64 Status)
        {
            frame_to_send.Command = Command;
            frame_to_send.Status = Status;
            frame_to_send.EmptyDataField();
            send_frame();
        }           
       
        public void DestroyMedia()
        {
            if (media == null)
                return;
            if (media.GetType() == typeof(SerialIO))
                ((SerialIO)media).DestroySerialIO();

            if (media.GetType() == typeof(Network))
                ((Network)media).DestroyNetworkIO();
        }

        private void on_send_complete()
        {
            IsCommandDone = false;
            if (frame_to_send.Command == 0x07 || frame_to_send.Command == 0x08 || frame_to_send.Command == 0x15 || frame_to_send.Command == 0x1b || frame_to_send.Command == 0x1d)
                wait_for_responce = false;
            if (SendComplete != null)    
                SendComplete(frame_to_send);
        }

        private void on_receive_ack()
        {
            if (last_command == DeviceCommand.DirectPrint)
            {
                free_media();
                printComplete = true;
                if (DirectPrintComplete != null)
                    DirectPrintComplete();
                if (DirectPrintCompleteTh != null)
                    DirectPrintCompleteTh(externThread);
            }
        }

        private void on_receive_none_ack()
        {
            if (last_command == DeviceCommand.ReadOneRecord || last_command == DeviceCommand.DirectPrint)
            {
                free_media();
                if (MultiErrorOnReceive != null)
                    MultiErrorOnReceive();
                if (MultiErrorOnReceiveTh != null)
                    MultiErrorOnReceiveTh(externThread);
            }
            else
            {
                if (trail_error > max_error)
                {
                    free_media();
                    if (MultiErrorOnReceive != null)
                        MultiErrorOnReceive();
                    if (MultiErrorOnReceiveTh != null)
                        MultiErrorOnReceiveTh(externThread);
                }
                else
                {
                    if (reserv_media_cause == media_reserv_type.collection || reserv_media_cause == media_reserv_type.recovery)
                        this.NoneAcknowledge();
                    trail_error++;
                }
            }
        }

        private void fill_receive_info(UInt64 command_index, string command_name, string description)
        {
            Information.Reset();

            Information.Command = command_index;
            Information.Name = command_name;
            Information.Description = description;            
        }
    
        private void on_get_0x01()
        {
            fill_receive_info(0x01, "Link Test", "Device Is Connected");
            Information.DataCell = 0;
            Information.DataCluster = 0;
        }

        private void on_get_0x03()
        {
            fill_receive_info(0x03,"Buffer Is Empty","There Is No Record For Collection");
            Information.DataCell = 0;
            Information.DataCluster = 0;
           
            if (MediaIsReserve && reserv_media_cause == media_reserv_type.collection)
            {
                if (collected_data.Count==0)
                { 
                    if (CollectFinish!=null)
                        CollectFinish(CollectFinishState.Success,0);
                    if (CollectFinishTh != null)
                        CollectFinishTh(CollectFinishState.Success, 0, externThread);
                    //if (show_message_on_collection)
                    //    MessageBox.Show("Collected Buffer Is Empty");
                    free_media();
                    return;
                }

                if (recording_type == RecordingType.CreateTXTFile)
                    if (collected_data.MakeTXTFile())
                    {
                        if (CollectFinish != null)
                            CollectFinish(CollectFinishState.Success,collected_data.Count);
                        if (CollectFinishTh != null)
                            CollectFinishTh(CollectFinishState.Success, collected_data.Count, externThread);
                        //if (show_message_on_collection)
                        //    MessageBox.Show("TXT File Create On \n" + collected_data.TXTFilePath);
                    }
                    else
                    {
                        if (CollectFinish != null)
                            CollectFinish(CollectFinishState.Unsuccess,0);
                        if (CollectFinishTh != null)
                            CollectFinishTh(CollectFinishState.Unsuccess, 0, externThread);
                        //if (show_message_on_collection)
                        //    MessageBox.Show("TXT File Creation Fail");
                    }

                if (recording_type == RecordingType.AppendToTXTFile)
                    if(collected_data.AppendToTXTFile())
                    {
                        if (CollectFinish != null)
                            CollectFinish(CollectFinishState.Success,collected_data.Count);
                        if (CollectFinishTh != null)
                            CollectFinishTh(CollectFinishState.Success, collected_data.Count, externThread);
                        //if (show_message_on_collection)
                        //    MessageBox.Show("TXT File Appended On \n" + collected_data.TXTFilePath);
                    }
                    else
                    {
                        if (CollectFinish != null)
                            CollectFinish(CollectFinishState.Unsuccess,0);
                        if (CollectFinishTh != null)
                            CollectFinishTh(CollectFinishState.Unsuccess, 0, externThread);
                        //if (show_message_on_collection)
                        //    MessageBox.Show("TXT File Appending Failed");
                    } 


                if (recording_type == RecordingType.CreateXMLFile)
                    if (collected_data.MakeXMLFile())
                    {
                        if (CollectFinish != null)
                            CollectFinish(CollectFinishState.Success,collected_data.Count);
                        if (CollectFinishTh != null)
                            CollectFinishTh(CollectFinishState.Success, collected_data.Count, externThread);
                        //if (show_message_on_collection)
                        //  MessageBox.Show("XML File Created On \n" + collected_data.XMLFilePath);
                    }
                    else
                    {
                        if (CollectFinish != null)
                            CollectFinish(CollectFinishState.Unsuccess,0);
                        if (CollectFinishTh != null)
                            CollectFinishTh(CollectFinishState.Unsuccess, 0, externThread);
                        //if (show_message_on_collection)
                        //  MessageBox.Show("XML File Creation Failed");
                    }

                
            }
            free_media();

            if (NoMoreRecords != null)
                NoMoreRecords();
            if (NoMoreRecordsTh != null)
                NoMoreRecordsTh(externThread);
        }

        private void on_get_0x04()
        {
            fill_receive_info(0x04,"Record Collection", "One Record Is Collected");
            Information.DataCluster = 8; // 5;
            Information.DataCell = 1;

            int temp = 0;

            last_collected_record.CardNumber = "";
            last_collected_record.CardStstus = "";
            last_collected_record.Date = "";
            last_collected_record.Time = "";
            last_collected_record.TerminalAddress = "";

            string temp_sttring = "";
            int temp_integer = 0;

            /*Information.AddData(received_frame.GetFrameDataAsString(temp, 1).ToString());
            last_collected_record.TerminalAddress = received_frame.GetFrameDataAsString(temp, 1).ToString();
            temp ++;*/
            Information.AddData(received_frame.GetFrameDataAsString(temp, 3).ToString());
            last_collected_record.TerminalAddress = received_frame.GetFrameDataAsString(temp, 3).ToString();
            temp += 3;

            /*Information.AddData(received_frame.GetFrameDataAsNumber(temp, 1).ToString());
            last_collected_record.CardStstus = received_frame.GetFrameDataAsNumber(temp, 1).ToString();
            temp++;*/
            Information.AddData(received_frame.GetFrameDataAsString(temp, 2).ToString());
            last_collected_record.CardStstus = received_frame.GetFrameDataAsString(temp, 2).ToString();
            /*temp_sttring = string.Empty;
            temp_sttring = received_frame.GetFrameDataAsNumber(temp + 1, 1).ToString();
            temp_integer = Convert.ToInt32(temp_sttring) * 256;
            temp_sttring = received_frame.GetFrameDataAsNumber(temp, 1).ToString();
            temp_integer = temp_integer + Convert.ToInt32(temp_sttring);
            temp_sttring = temp_integer.ToString();
            Information.AddData(temp_sttring);
            last_collected_record.CardStstus = temp_sttring;*/
            temp += 2;

            /*temp_sttring = string.Empty;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp_sttring += @"/";
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp_sttring += @"/";
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            Information.AddData(temp_sttring);
            last_collected_record.Date = temp_sttring;*/
            temp_sttring = string.Empty;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp_sttring += @"/";
            temp += 2;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp_sttring += @"/";
            temp += 2;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp += 2;
            Information.AddData(temp_sttring);
            last_collected_record.Date = temp_sttring;

            /*temp_sttring = string.Empty;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp_sttring += @":";
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            Information.AddData(temp_sttring);
            last_collected_record.Time = temp_sttring;*/
            temp_sttring = string.Empty;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp_sttring += @":";
            temp += 2;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp += 2;
            Information.AddData(temp_sttring);
            last_collected_record.Time = temp_sttring;

            /*temp_sttring = string.Empty;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            Information.AddData(temp_sttring);
            last_collected_record.CardNumber = temp_sttring;*/
            temp_sttring = string.Empty;
            //            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            //            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            //            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            //            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            Information.AddData(temp_sttring);
            last_collected_record.CardNumber = temp_sttring;

            if (OneCollectFinish != null)
            {
                free_media();
                OneCollectFinish();
            }

//            Information.DataCell += 1;
//            Information.DataCluster = 5;

/*
            Information.AddData(received_frame.GetFrameDataAsString(0, 3));
            Information.AddData(received_frame.GetFrameDataAsString(3, 2));
            temp = string.Empty;
            temp += received_frame.GetFrameDataAsString(5, 2);
            temp += @"/";
            temp += received_frame.GetFrameDataAsString(7, 2);
            temp += @"/";
            temp += received_frame.GetFrameDataAsString(9, 2);
            Information.AddData(temp);
            temp = string.Empty;
            temp += received_frame.GetFrameDataAsString(11, 2);
            temp += @":";
            temp += received_frame.GetFrameDataAsString(13, 2);
            Information.AddData(temp);
            Information.AddData(received_frame.GetFrameDataAsString(15, 8));
            if (MediaIsReserve && reserv_media_cause == media_reserv_type.collection)
                internal_acknowledge();
*/

        }

        private void on_get_0x05()
        {
            Information.Command = 0x05;
            Information.Description = "Keypad Data Received";
            Information.Name = "Return Keypad Data";
            Information.DataCell = 1;
            Information.DataCluster = 1;
            Information.AddData(received_frame.GetFrameDataAsString());           
        }

        private void on_get_0x06()
        {
            fill_receive_info(0x06,"Acknowledge","Command Successfully Done");
            Information.DataCell =0;
            Information.DataCluster =0;

            on_receive_ack();
        }
        private void on_get_0x10()
        {
            fill_receive_info(0x10, "Record", "Read One Record Online.");
//restkk            Information.DataCell = 1;
//restkk            Information.DataCluster = 1;

//restkk is
//            fill_receive_info(0x04, "Record Collection", "One Record Is Collected");
            Information.DataCluster = 8;
            Information.DataCell = 1;

            int temp = 0;
//            last_twenty_collected_data.Clear();
            last_collected_online_record.CardNumber = "";
            last_collected_online_record.CardStstus = "";
            last_collected_online_record.Date = "";
            last_collected_online_record.Time = "";
            last_collected_online_record.TerminalAddress = "";
            string temp_sttring = "";
            int temp_integer = 0;
////            OneRecord one_record_data = new OneRecord();

//            Information.AddData(received_frame.GetFrameDataAsNumber(temp, 1).ToString());
//            last_collected_online_record.TerminalAddress = received_frame.GetFrameDataAsNumber(temp, 1).ToString();
            Information.AddData(received_frame.GetFrameDataAsString(temp,3).ToString());
            last_collected_online_record.TerminalAddress = received_frame.GetFrameDataAsString(temp,3).ToString();
            temp += 3;
//            Information.AddData(received_frame.GetFrameDataAsNumber(temp, 1).ToString());
//            last_collected_online_record.CardStstus = received_frame.GetFrameDataAsNumber(temp, 1).ToString();

            temp_sttring = string.Empty;
            temp_sttring = received_frame.GetFrameDataAsNumber(temp + 1, 1).ToString();
            temp_integer = Convert.ToInt32(temp_sttring) * 256;
            temp_sttring = received_frame.GetFrameDataAsNumber(temp, 1).ToString();
            temp_integer = temp_integer + Convert.ToInt32(temp_sttring);
            temp_sttring = temp_integer.ToString();
            Information.AddData(temp_sttring);
            last_collected_online_record.CardStstus = temp_sttring;
            temp += 2;
/*            temp_sttring = string.Empty;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp_sttring += @"/";
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp_sttring += @"/";
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;*/

            temp_sttring = string.Empty;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp_sttring += @"/";
            temp += 2;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp_sttring += @"/";
            temp += 2;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp += 2;
            Information.AddData(temp_sttring);
            last_collected_online_record.Date = temp_sttring;

/*            temp_sttring = string.Empty;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp_sttring += @":";
            temp++;
            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;*/

            temp_sttring = string.Empty;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp_sttring += @":";
            temp += 2;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 2).ToString();
            temp += 2;
            Information.AddData(temp_sttring);
            last_collected_online_record.Time = temp_sttring;


            temp_sttring = string.Empty;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 1);
            //            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            //temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 1);
//            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            //temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 1);
//            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            //temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 1);
//            temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
            //temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 1);
            //temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 1);
//            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 1);
//            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            temp_sttring += received_frame.GetFrameDataAsString(temp, 1);
//            temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
            temp++;

            Information.AddData(temp_sttring);
            last_collected_online_record.CardNumber = temp_sttring;

////            Information.AddData(received_frame.GetFrameDataAsString(temp, 8).ToString());
////            last_collected_online_record.CardNumber = received_frame.GetFrameDataAsString(temp, 8).ToString();
////            temp += 8;

//            Information.DataCell += 1;
//            Information.DataCluster = 5;
//            collected_data.AddRecord(one_record_data);
//            last_twenty_collected_data.AddRecord(one_record_data);
//            last_collected_record = one_record_data;
//            last_collected_online_record.AddRecord(one_record_data);

//            if (MediaIsReserve && reserv_media_cause == media_reserv_type.collection)
//                internal_acknowledge();

            if (OneOnlineCollectFinish != null)
            {
                free_media();
                OneOnlineCollectFinish();
            }
            if (OneOnlineCollectFinishTh != null)
            {
                free_media();
                OneOnlineCollectFinishTh(this, externThread);
            }
//restkk ie
        }

        private void on_get_0x0d()
        {
            fill_receive_info(0x0d,"Return Access Code","Access Code Read From Terminal");
            Information.DataCell = 1;
            Information.DataCluster = 5;

            string string_temp = "";
            Byte byte_temp = 0;

            byte_temp = received_frame.GetByte(0);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            byte_temp = received_frame.GetByte(1);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            Information.AddData(string_temp);

            string_temp = "";
            byte_temp = received_frame.GetByte(2);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            byte_temp = received_frame.GetByte(3);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            Information.AddData(string_temp);

            string_temp = "";
            byte_temp = received_frame.GetByte(4);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            byte_temp = received_frame.GetByte(5);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            Information.AddData(string_temp);

            string_temp = "";
            byte_temp = received_frame.GetByte(6);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            byte_temp = received_frame.GetByte(7);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            Information.AddData(string_temp);

            string_temp = "";
            byte_temp = received_frame.GetByte(8);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            byte_temp = received_frame.GetByte(9);
            byte_temp = Utility.SwapNibbles(byte_temp);
            string_temp += Utility.ChangeToHex(byte_temp);
            Information.AddData(string_temp);       
        }

        private void on_get_0x0e()
        {
            fill_receive_info(0x0e,"Read Version","Read Device Version Successfully Done");
            Information.DataCluster = 1;            
            Information.DataCell = 1;
            Information.AddData(received_frame.GetFrameDataAsString());
        }

        private void on_get_0x12()
        {
            fill_receive_info(0x12,"Terminal Status","Terminal Status Received");
            Information.AddData(received_frame.GetFrameDataAsString(0, 1));
            Information.DataCell = 1;
            Information.DataCluster = 1;
        }

        private void on_get_0x15()
        {
            fill_receive_info(0x015,"None Acknowledge","Last Command Failed");
            Information.DataCluster = 0;
            Information.DataCell = 0;

            on_receive_none_ack();
        }

        private void on_get_0x19()
        {
            fill_receive_info(0x19,"Return Card Number","Return Card Number And Output Device");
            Information.DataCell = 0;
            Information.DataCluster = 0;
        }

        private void on_get_0x21()
        {
            fill_receive_info(0x21,"Read Time And Date","Received Terminal Time And Date");
            Information.DataCluster = 2;
            Information.DataCell = 1;


            string temp = string.Empty;            
            temp += received_frame.GetFrameDataAsString(0, 2);
            temp += @"/";
            temp += received_frame.GetFrameDataAsString(2, 2);
            temp += @"/";
            temp += received_frame.GetFrameDataAsString(4, 2);
            Information.AddData(temp);
            temp = string.Empty;
            temp += received_frame.GetFrameDataAsString(6, 2);
            temp += @":";
            temp += received_frame.GetFrameDataAsString(8, 2);
            Information.AddData(temp);           
        }

        private void on_get_0x25()
        {
            fill_receive_info(0x25,"Return Alarm & Timers","Receive Terminal Alarms And Timers");

            int temp = 0;
            string str = string.Empty;
            
            for (; temp < received_frame.GetFrameDataAsBytes().Length; )
            {
                str = string.Empty;

                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                str += ":";
                temp++;
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                Information.AddData(str);
                Information.AddData(received_frame.GetFrameDataAsNumber(temp, 2).ToString());
                temp += 2;
                Information.DataCell += 1;
                Information.DataCluster = 2;
            }
        }

        private void on_get_0x29()
        {
            fill_receive_info(0x29,"Return None Authorized Card","Received None Authorized Card Group");

            int temp = 0;
            string str = string.Empty;
            
            for (; temp < received_frame.GetFrameDataAsBytes().Length; )
            {
                str = "";
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                Information.AddData(str);
                Information.DataCell += 1;
                Information.DataCluster = 1;
            }
        }

        private void on_get_0x36()
        {
            fill_receive_info(0x36,"Return Card Limit","Get Card Limit From Device");
            
            int temp = 0;
            string str = String.Empty;
           
            Information.AddData(received_frame.GetFrameDataAsNumber(0, 1).ToString());
            temp = 4;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            Information.AddData(str);
            temp = 8;
            str = "";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);

            Information.AddData(str);
            Information.DataCell = 1;
            Information.DataCluster = 3;
        }

        private void on_get_0x37()
        {
            fill_receive_info(0x37,"Return Card Limit","Get Card Limit From Device");
            Information.DataCluster = 1;
            Information.DataCell = 1;
            Information.AddData(received_frame.GetFrameDataAsNumber(0, 1).ToString());            
        }

        private void on_get_0x38()
        {
            fill_receive_info(0x38,"Request Billing","Request Billing");
            Information.DataCell = 0;
            Information.DataCluster = 0;
        }

        private void on_get_0x39()
        {
            fill_receive_info(0x39,"Return Card Limit","Get Card Limit From Device");
            Information.DataCluster = 0;
            Information.DataCell = 0;
            /*  Information.AddData(ReceivedFrame.GetFrameDataAsNumber(0, 1).ToString());
              PacketLenght = 1;
              PacketCount = 1;*/
        }

        private void on_get_0x3e()
        {
            fill_receive_info(0x3e,"Return Only Card List","Get Only Card List Group");

            int temp = 0;
            string str = string.Empty;
            
            for (; temp < received_frame.GetFrameDataAsBytes().Length; )
            {
                str = "";
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                str += received_frame.GetHighNibbleSymbolData(temp);
                str += received_frame.GetLowNibbleSymbolData(temp);
                temp++;

                Information.AddData(str);
                Information.DataCell += 1;
                Information.DataCluster = 1;
            }
        }

        private void on_get_0x42()
        {
            fill_receive_info(0x42,"Repeated Card Detect","Repeated Card Detect");
            Information.DataCluster = 0;
            Information.DataCell = 0;
        }

        private void on_get_0x43()
        {
            fill_receive_info(0x43,"Message Buffer Full","Message Buffer Full");
            Information.DataCell = 0;
            Information.DataCluster = 0;
        }

        private void on_get_0x45()
        {
            fill_receive_info(0x45,"Similar Card Not Found","Similar Card Not Found");
            Information.DataCell = 0;
            Information.DataCluster = 0;
        }

        private void on_get_0x46()
        {
            fill_receive_info(0x46,"Return Message","Return Message");

            int temp = 0;
            string str = string.Empty;
            
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            Information.AddData(str);
            Information.AddData(received_frame.GetFrameDataAsString(4, received_frame.GetFrameDataAsBytes().Length - 4));
            Information.DataCluster = 2;
            Information.DataCell = 1;
        }
        private void on_get_0x48()
        {
            fill_receive_info(0x48, "Get Time Limit", "Get Time Limit");

            int temp = 5;
            string str = string.Empty;

            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += ":";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += "   -   ";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += ":";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += "   -   ";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += ":";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += "   -   ";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += ":";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += "   -   ";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += ":";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += "   -   ";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += ":";
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            
            Information.AddData(str);
            //Information.AddData(received_frame.GetFrameDataAsString(4, received_frame.GetFrameDataAsBytes().Length - 4));
            Information.DataCluster = 1;
            Information.DataCell = 1;
        }

        private void on_get_0x4d()
        {
            fill_receive_info(0x4d,"Return Authority List","Return Authority List");
            Information.DataCell = 0;
            Information.DataCluster= 0 ;
        }

        private void on_get_0x51()
        {
            fill_receive_info(0x51,"Start Address In Ram","Get Start Address In Ram");
            Information.AddData(received_frame.GetFrameDataAsNumber().ToString());
            Information.DataCluster = 1;
            Information.DataCell = 1;
        }

        private void on_get_0x53()
        {
            fill_receive_info(0x53, "DownLoad", "DownLoad");
            ArrayList temp = new ArrayList();
            temp = received_frame.GetFrameDataAsArraylist();
            foreach (Object o in temp)
            {
                Information.AddData(o);               
            }
            Information.DataCell = 1;
            Information.DataCluster = 1;
        }

        private void on_get_0x54()
        {
            fill_receive_info(0x54, "DwonLoad End", "DwonLoad End");

            ArrayList temp = new ArrayList();
            temp = received_frame.GetFrameDataAsArraylist();
            foreach (Object o in temp)
            {
                Information.AddData(o);            
            }
            Information.DataCluster = 1;
            Information.DataCell = 1;
        }

        private void on_get_0x57()
        {
            fill_receive_info(0x57, "Precard", "Precard");

            int temp = 0;
            string str = string.Empty;

            Information.AddData(received_frame.GetFrameDataAsNumber(0, 1));

            temp++;

            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            temp++;
            str += received_frame.GetHighNibbleSymbolData(temp);
            str += received_frame.GetLowNibbleSymbolData(temp);
            Information.AddData(str);
            str = "";
            str += received_frame.GetHighNibbleSymbolData(5);
            str += received_frame.GetLowNibbleSymbolData(5);
            Information.AddData(str);

            Information.DataCell = 1;
            Information.DataCluster = 3;
        }

        private void on_get_0x5a()
        {
            fill_receive_info(0x5a, "Fast Collection", "Collect Some Record");

            int temp = 0;

            last_twenty_collected_data.Clear();

            string temp_sttring = "";
            while (temp < received_frame.GetFrameDataAsBytes().Length)
            {
                OneRecord one_record_data = new OneRecord();
                Information.AddData(received_frame.GetFrameDataAsNumber(temp, 1).ToString());
                one_record_data.TerminalAddress = received_frame.GetFrameDataAsNumber(temp, 1).ToString();
                temp++;
                Information.AddData(received_frame.GetFrameDataAsNumber(temp, 1).ToString());
                one_record_data.CardStstus = received_frame.GetFrameDataAsNumber(temp, 1).ToString();
                temp++;
                temp_sttring = string.Empty;
                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp_sttring += @"/";
                temp++;
                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp_sttring += @"/";
                temp++;
                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                Information.AddData(temp_sttring);
                one_record_data.Date = temp_sttring;
                temp_sttring = string.Empty;
                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp_sttring += @":";
                temp++;
                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                Information.AddData(temp_sttring);
                one_record_data.Time = temp_sttring;
                temp_sttring = string.Empty;
                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp++;

                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp++;

                temp_sttring += received_frame.GetHighNibbleSymbolData(temp);
                temp_sttring += received_frame.GetLowNibbleSymbolData(temp);
                temp++;
                Information.AddData(temp_sttring);
                one_record_data.CardNumber = temp_sttring;
                Information.DataCell += 1;
                Information.DataCluster = 5;
                collected_data.AddRecord(one_record_data);
                last_twenty_collected_data.AddRecord(one_record_data);
                //last_collected_record = one_record_data;
            }

            if (TwentyCollectFinish != null)
            {
                free_media();
                TwentyCollectFinish(last_twenty_collected_data.Count);
            }
//          if (MediaIsReserve && reserv_media_cause == media_reserv_type.collection)
//              internal_acknowledge();
        }

        private void on_receive_complete(ArrayList ReceivedPacket)
        {
            wait_for_responce = false;

//            timer.Stop();
            destroyTimer();
            received_frame.SetEntireFrame(ReceivedPacket);
            if (received_frame.PacketError == Z84Frame.Z84PacketErrors.NoError)
            {
                trail_error = 0;
                Information.Reset();
                last_received_status = received_frame.Status;

                if (received_frame.Command == 1)
                    if (received_frame.GetFrameDataAsString() == Convert.ToString(expected_data[0]))
                        on_get_0x01();

                if (received_frame.Command == 3)
                    on_get_0x03();

                if (received_frame.Command == 0x04)
                    on_get_0x04();

                if (received_frame.Command == 0x05)
                    on_get_0x05();

                if (received_frame.Command == 0x06)
                    on_get_0x06();

                if (received_frame.Command == 0x10)
                    on_get_0x10();

                if (received_frame.Command == 0x0d)
                    on_get_0x0d();

                if (received_frame.Command == 0x0e)
                    on_get_0x0e();

                if (received_frame.Command == 0x12)
                    on_get_0x12();

                if (received_frame.Command == 0x15)
                    on_get_0x15();

                if (received_frame.Command == 0x19)
                    on_get_0x19();

                if (received_frame.Command == 0x21)
                    on_get_0x21();

                if (received_frame.Command == 0x25)
                    on_get_0x25();

                if (received_frame.Command == 0x29)
                    on_get_0x29();

                if (received_frame.Command == 0x36)
                    on_get_0x36();

                if (received_frame.Command == 0x37)
                    on_get_0x37();

                if (received_frame.Command == 0x38)
                    on_get_0x38();

                if (received_frame.Command == 0x39)
                    on_get_0x39();

                if (received_frame.Command == 0x3e)
                    on_get_0x3e();

                if (received_frame.Command == 0x42)
                    on_get_0x42();

                if (received_frame.Command == 0x43)
                    on_get_0x43();

                if (received_frame.Command == 0x45)
                    on_get_0x45();

                if (received_frame.Command == 0x46)
                    on_get_0x46();

                if (received_frame.Command == 0x48)
                    on_get_0x48();

                if (received_frame.Command == 0x4d)
                    on_get_0x4d();

                if (received_frame.Command == 0x51)
                    on_get_0x51();

                if (received_frame.Command == 0x53)
                    on_get_0x53();

                if (received_frame.Command == 0x54)
                    on_get_0x54();

                if (received_frame.Command == 0x57)
                    on_get_0x57();

                if (received_frame.Command == 0x5a)
                    on_get_0x5a();

                IsCommandDone = true;
                if (CommandDone != null)
                    CommandDone(Information, Information.DataCell, Information.DataCluster);
            }
            else
            {
                if (trail_error > max_error)
                {
                    free_media();
                    if (MultiErrorOnReceive != null)
                        MultiErrorOnReceive();
                    if (MultiErrorOnReceiveTh != null)
                        MultiErrorOnReceiveTh(externThread);                    
                }
                else
                {
                    if (last_command == DeviceCommand.DirectPrint)
                    {
                        if (MultiErrorOnReceive != null)
                            MultiErrorOnReceive();
                        if (MultiErrorOnReceiveTh != null)
                            MultiErrorOnReceiveTh(externThread);
                    }
                    if (reserv_media_cause == media_reserv_type.collection || reserv_media_cause == media_reserv_type.recovery)
                        this.NoneAcknowledge();
                    trail_error++;
                }
                if (BadReceivePacket != null)
                    BadReceivePacket(received_frame.PacketError);
            }

            if (ReceiveComplete != null)
                ReceiveComplete(ReceivedPacket);
        }

        private void on_not_response(ArrayList LastCommand)
        {
            free_media();
            wait_for_responce = false;

            if (NotResponse != null)
                NotResponse(LastCommand);
            if (NotResponseTh != null)
                NotResponseTh(LastCommand, externThread);
        }         
               
        private void initial()
        {
/*            timer.Interval = 2000;
            timer.AutoReset = false;
            timer.Enabled = true;
            timer.Elapsed += new ElapsedEventHandler(Timer_Elapsed);
 */
//            createTimer();
//            timer.Stop();
            errors.Clear();
            
        }
        private void createTimer()
        {
            timer = new System.Timers.Timer();
            timer.Interval = 2000;
            timer.AutoReset = false;
//            timer.Enabled = true;
            timer.Elapsed += new ElapsedEventHandler(Timer_Elapsed);
            timer.Start();
        }

        private void destroyTimer()
        {
            timer.Stop();
            timer.Dispose();
            timer = null;
        }

        void Timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            destroyTimer();
//            timer.Stop();
            on_not_response(frame_to_send.GetEntireFrame());            
        }

        void Serial_SerialSendFinish()
        {
            on_send_complete();
        }

        ArrayList Serial_SerialReceiveFinish(ArrayList ReceivedPacket)
        {
            on_receive_complete(ReceivedPacket);
            received_frame.SetEntireFrame(ReceivedPacket);
            return ReceivedPacket; 
        }
        
        public Z84Family()
        {
            initial();
        }               
       
        public Boolean CreateSerialMedia(string PortName,int BaudRate)
        {
            try
            {
                media = new SerialIO();
                media_assign = ((SerialIO)media).CreateSerialMedia(PortName,BaudRate, 8, System.IO.Ports.Parity.None, System.IO.Ports.StopBits.Two);
                ((SerialIO)media).SerialReceiveFinish += new SerialIO.ReceiveEvent(Serial_SerialReceiveFinish);
                ((SerialIO)media).SerialSendFinish += new SerialIO.SendEvent(Serial_SerialSendFinish);
            }
            catch
            {
                on_error_occur(Z84ClassError.ErrorOnCreateSerialMedia);
            }
            return media_assign;
        }

        public Boolean CreateSerialMedia(string PortName, int BaudRate, int DataBits,System.IO.Ports.Parity Parity,System.IO.Ports.StopBits StopBits )
        {
            try
            {
                media = new SerialIO();
                media_assign = ((SerialIO)media).CreateSerialMedia(PortName, BaudRate, 8, System.IO.Ports.Parity.None, System.IO.Ports.StopBits.Two);
                ((SerialIO)media).SerialReceiveFinish += new SerialIO.ReceiveEvent(Serial_SerialReceiveFinish);
                ((SerialIO)media).SerialSendFinish += new SerialIO.SendEvent(Serial_SerialSendFinish);
            }
            catch
            {
                on_error_occur(Z84ClassError.ErrorOnCreateSerialMedia);
            }
            return media_assign;
        }

        public Boolean CreateNetworkMedia(string Address)
        {
            IPEndPoint myIPEndPoint = new IPEndPoint(IPAddress.Parse(Address), 1001);
            return CreateNetworkMedia(myIPEndPoint);
        }
        public Boolean CreateNetworkMedia(IPEndPoint Address)
        {
            try
            {
                media = new Network();
                media_assign = ((Network)media).CreateNetworkIO(Address);
                ((Network)media).NetworkReceiveFinish += new Network.ReceiveEvent(NetworkReceiveFinish);
                ((Network)media).NetworkSendFinish += new Network.SendEvent(NetworkSendFinish);
                
            }
            catch
            {
                on_error_occur(Z84ClassError.ErrorOnCreateNetworkMedia);
            }
            return media_assign;
        }

        void NetworkSendFinish()
        {
            on_send_complete();
        }

        ArrayList NetworkReceiveFinish(ArrayList ReceivedPacket)
        {
            on_receive_complete(ReceivedPacket);
            received_frame.SetEntireFrame(ReceivedPacket);
            return ReceivedPacket;
        }       
        
        public void DirectSend(ArrayList Buffer)
        {
            frame_to_send.SetEntireFrame(Buffer);
            media.SendToClient(Buffer);           
           
        }

        public void LinkTest()
        {
            last_command = DeviceCommand.LinkTest;
            frame_to_send.Command = 1;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField("Ghadir Co LTD . Written With SAP 1387/1/XX");
            expected_data.Add("Ghadir Co LTD . Written With SAP 1387/1/XX");
            send_frame();
        }

        public void LinkTest(string DesireString)
        {
            last_command = DeviceCommand.LinkTest;
            if (DesireString.Length > 64)
                DesireString = DesireString.Substring(64);
            frame_to_send.Command = 1;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(DesireString);
            expected_data.Add(DesireString);
            send_frame();
        }

        public void Collection()
        {
            last_command = DeviceCommand.Collection;
            send_frame(2);
        }        

        public void CollectionAllRecords()
        {
             last_command = DeviceCommand.FastCollection;
//            last_command = DeviceCommand.Collection;//added
            collected_data.Clear();
            send_frame(2, 0x55);
//            send_frame(2);//added
            reserve_media(media_reserv_type.collection);           
        }

        private void internal_collection_all_records()
        {
            last_command = DeviceCommand.Collection;
            internal_send_frame(2, 0x55);
        }

        public void Acknowledge()
        {
            last_command = DeviceCommand.Acknowledge;
            send_frame(6);
        }

        private void internal_acknowledge()
        {
            last_command = DeviceCommand.Acknowledge;
            internal_send_frame(6);
        }         
       
        public void SetAccessCode(AcccessCodeGroup Group)
        {
            last_command = DeviceCommand.SetAccessCode;
            frame_to_send.Command = 9;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            Byte temp;
            foreach (Object o in Group.GetGroup())
            {
                temp = Convert.ToByte(Convert.ToUInt64(o) / 256);
                temp = Utility.SwapNibbles(temp);
                frame_to_send.AddToDataField(temp);

                temp = Convert.ToByte(Convert.ToUInt64(o) % 256);
                temp = Utility.SwapNibbles(temp);
                frame_to_send.AddToDataField(temp);
            }
            send_frame();
        }

        public void ClearAccessCode()
        {
            last_command = DeviceCommand.ClearAccessCode;
            send_frame(0x0a);
        }

        public void SetTimeAndDate(string Instance)
        {
            last_command = DeviceCommand.SetTimeAndDate;
            frame_to_send.Command = 0x0b;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Instance,12);
            send_frame();
        }

        public void SetTimeAndDate(DateTime Instance)
        {
            last_command = DeviceCommand.SetTimeAndDate;
            frame_to_send.Command = 0xb;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            if (Instance.Year % 100 > 9)
                frame_to_send.AddToDataField(Convert.ToString(Instance.Year % 100));
            else
            {
                frame_to_send.AddToDataField("0");
                frame_to_send.AddToDataField(Convert.ToString(Instance.Year % 100));
            }
            if (Instance.Month > 9)
                frame_to_send.AddToDataField(Convert.ToString(Instance.Month));
            else
            {
                frame_to_send.AddToDataField("0");
                frame_to_send.AddToDataField(Convert.ToString(Instance.Month));
            }
            if (Instance.Day > 9)
                frame_to_send.AddToDataField(Convert.ToString(Instance.Day));
            else
            {
                frame_to_send.AddToDataField("0");
                frame_to_send.AddToDataField(Convert.ToString(Instance.Day));
            }
            if (Instance.Hour > 9)
                frame_to_send.AddToDataField(Convert.ToString(Instance.Hour));
            else
            {
                frame_to_send.AddToDataField("0");
                frame_to_send.AddToDataField(Convert.ToString(Instance.Hour));
            }
            if (Instance.Minute > 9)

                frame_to_send.AddToDataField(Convert.ToString(Instance.Minute));
            else
            {
                frame_to_send.AddToDataField("0");
                frame_to_send.AddToDataField(Convert.ToString(Instance.Minute));
            }
            if (Instance.Second > 9)

                frame_to_send.AddToDataField(Convert.ToString(Instance.Second));
            else
            {
                frame_to_send.AddToDataField("0");
                frame_to_send.AddToDataField(Convert.ToString(Instance.Second));
            }

            send_frame();
        }        

        public void Reset()
        {
            last_command = DeviceCommand.Reset;
            send_frame(0x0c);
        }

        public void GetAccessCode()
        {
            last_command = DeviceCommand.GetAccessCode;
            send_frame(0x0d);
        }

        public void ReadVersion()
        {
            last_command = DeviceCommand.ReadVersion;
            send_frame(0x0e);
        }

        public void SetTerminalAddress(UInt64 Address)
        {
            last_command = DeviceCommand.SetTerminalAddress;
            frame_to_send.Command = 0xf;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Address,1);
            send_frame();
        }
                        
        public void DisplayRowMessage(UInt64 x, UInt64 y,TerminalFontType Type, string Message)
        {
            last_command = DeviceCommand.DisplayRowMessage;
            frame_to_send.Command = 0x13;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(x,1);
            frame_to_send.AddToDataField(y,1);
            frame_to_send.AddToDataField(Convert.ToByte(Type));
            frame_to_send.AddToDataField(Message);
            send_frame();
        }

        public void ClearScreen()
        {
            last_command = DeviceCommand.ClearScreen;
            send_frame(0x14);
        }


        public void NoneAcknowledge()
        {
            last_command = DeviceCommand.NoneAcknowledge;
            send_frame(0x15);
        }

        public void NoneAcknowledge(byte MessageCommand)
        {
            last_command = DeviceCommand.NoneAcknowledge;
//restkk            send_frame(0x15);
            frame_to_send.Command = 0x15;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(MessageCommand);
            send_frame();
        }
           
        public void ChangeKeypadPassword(string Password)
        {
            last_command = DeviceCommand.ChangeKeypadPassword;
            if (Password.Length > 5)
                Password = Password.Substring(0, 5);
            frame_to_send.Command = 0x1a;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField('W');
            frame_to_send.AddToDataField(Password);
            send_frame();
        }

        public void ChangeKeypadPassword(UInt64 Digit1, UInt64 Digit2, UInt64 Digit3, UInt64 Digit4, UInt64 Digit5)
        {
            last_command = DeviceCommand.ChangeKeypadPassword;
            frame_to_send.Command = 0x1a;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField('W');
            frame_to_send.AddToDataField(Digit1.ToString(),1);
            frame_to_send.AddToDataField(Digit2.ToString(),1);
            frame_to_send.AddToDataField(Digit3.ToString(),1);
            frame_to_send.AddToDataField(Digit4.ToString(),1);
            frame_to_send.AddToDataField(Digit5.ToString(),1);
            send_frame();
        }

        public void EnterSelfPrograming()
        {
            last_command = DeviceCommand.EnterSelfPrograming;
            send_frame(0x1b);
        }     
        
        public void ClearErrorBuffer(TerminalError ErrorType)
        {
            last_command = DeviceCommand.ClearErrorBuffer;
            frame_to_send.Command = 0x1e;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField('C');
            frame_to_send.AddToDataField(Convert.ToByte(ErrorType));
            send_frame();
        }

        public void GetErrorBuffer(TerminalError ErrorType)
        {
            last_command = DeviceCommand.GetErrorBuffer;
            frame_to_send.Command = 0x1e;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField('R');
            frame_to_send.AddToDataField(Convert.ToByte(ErrorType));
            send_frame();
        }

        public void ReInitialization()
        {
            last_command = DeviceCommand.ReInitialization;
            frame_to_send.Command = 0x1f;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField("REINITIALIZATION");
            send_frame();
        }

        public void GetTimeAndDate()
        {
            last_command = DeviceCommand.GetTimeAndDate;
            send_frame(0x20);
        }

        public void SetAlarms(AlarmGroup Group)
        {
            last_command = DeviceCommand.SetAlarms;
            frame_to_send.Command = 0x22;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Group.GetGroup(), 4);
            send_frame();
        }

        public void ClearAlarms()
        {
            last_command = DeviceCommand.ClearAlarms;
            send_frame(0x23);
        }

        public void GetAlarms()
        {
            last_command = DeviceCommand.GetAlarms;
            send_frame(0x24);
        }
       
        public void SetNoneAuthorizeCards(AuthorizedCardGroup Group)
        {
            last_command = DeviceCommand.SetNoneAuthorizeCards;
            frame_to_send.Command = 0x26;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Group.GetGroup(),4);
            send_frame();
        }

        public void ClearNonAuthorizeCards()
        {
            last_command = DeviceCommand.ClearNonAuthorizeCards;
            send_frame(0x027);
        }

        public void GetNonAuthorizeCards()
        {
            last_command = DeviceCommand.GetNonAuthorizeCards;
            send_frame(0x028);
        }

        public void OpenDoor(UInt64 Duration)
        {
            last_command = DeviceCommand.OpenDoor;
            frame_to_send.Command = 0x2a;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Duration,2);
            send_frame();
        }

        public void LockDoor(UInt64 Duration)
        {
            last_command = DeviceCommand.LockDoor;
            frame_to_send.Command = 0x2b;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Duration,2);
            send_frame();
        }
       
        public void UnLockDoor(UInt64 Duration)
        {
            last_command = DeviceCommand.UnLockDoor;
            frame_to_send.Command = 0x2c;
            frame_to_send.Status = 0;
            frame_to_send.AddToDataField(Duration,1);
            send_frame();
        }
       
        public void SetBaudRate(TerminalBaudRate BaudRate)
        {
            last_command = DeviceCommand.SetBaudRate;
            frame_to_send.Command = 0x2d;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Convert.ToByte(BaudRate));
            send_frame();
        }

        public void RecoveryByDate(string Instance)
        {
            last_command = DeviceCommand.RecoveryByDate;
            frame_to_send.Command = 0x2e;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Instance);
            send_frame();
        }

        public void RecoveryByDate(DateTime Instance)
        {
            last_command = DeviceCommand.RecoveryByDate;
            string Temp = string.Empty;
            Temp += Convert.ToString(Instance.Year % 100);
            if (Instance.Month < 10)
                Temp += "0";
            Temp += Convert.ToString(Instance.Month);
            if (Instance.Day < 10)
                Temp += "0";
            Temp += Convert.ToString(Instance.Day);
            frame_to_send.Command = 0x2e;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Temp);
            send_frame();
        }

        public void GetImage()
        {
            last_command = DeviceCommand.GetImage;
            send_frame(0x2f);
        }

        public void PermanentRecovery(int Year,int Month,int Day)
        {
            last_command = DeviceCommand.PermanentRecovery;
            frame_to_send.Command = 0x30;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Year%100,1);
            frame_to_send.AddToDataField(Month,1);
            frame_to_send.AddToDataField(Day,1);
            send_frame();
        }

        public void PermanentRecovery(DateTime Instance)
        {
            last_command = DeviceCommand.PermanentRecovery;
            int Year = Convert.ToInt32(Instance.Year % 100);
            int Month = Convert.ToInt32(Instance.Month);
            int Day = Convert.ToInt32(Instance.Day);
            PermanentRecovery(Year, Month, Day);
        }        

        public void SetPolling(string Date)
        {
            last_command = DeviceCommand.Setpolling;
            /*Frame.Command = 0x32;
            Frame.Status = 0;
             * FrameToSend.EmptyDataField();
            Frame.AddToDataField(Date);
            SendFrame();*/
        }        

        public void SetPolling(TerminalPollingMode Mode,UInt64 Address)
        {
            last_command = DeviceCommand.Setpolling;
            /*Frame.Command = 0x32;
            Frame.Status = 0;
             * FrameToSend.EmptyDataField();
            Frame.AddToDataField(Date);
            SendFrame();*/
        }          
    }
}
