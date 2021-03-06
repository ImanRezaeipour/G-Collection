//#define iooc
//#define Payvast
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.ServiceProcess;
using System.Text;
using System.IO;
using System.Timers;
using System.Collections;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Threading;
using System.Net;
using System.Net.NetworkInformation;

namespace Restaurant_Service
{
    public partial class Service1 : ServiceBase
    {
//////        Thread testTh;
        SqlConnection myConnection;
        //EventLog e_l = new EventLog();
//        long e_l_counter = 0;
//        long e_l_counter2 = 0;
        Boolean collectDevice_or_replyAnswer = true;
        string folder_path = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles);
        Ghadir_UI.Z84Family Device = new Ghadir_UI.Z84Family();
        System.Timers.Timer timer;// = new System.Timers.Timer();
        System.Timers.Timer redeemerTimer;// = new System.Timers.Timer();
        //        Timer timer2 = new Timer(); //restkk2
        ArrayList device_detail = new ArrayList();
        int current_device_index = -1;
        int timerInterval = 2000; //restkk 5000;
        int redeemerTimerInterval = 10000; //restkk
        //x//Boolean directPrintCompleted = false;
        Boolean directPrintWait = false;
        //x//byte directPrintCounter = 0;
        Thread[] devicesThreads;// = new Thread[device_detail.Count];
        ArrayList redeemerThreadsDT = new ArrayList();

        public class Encryption64
        {
            private byte[] key = { };
            private byte[] IV = { 0xe2, 0x74, 0xcf, 0x49, 0x53, 0xa4, 0x19, 0xc3, 0x26, 0x5f, 0xe1, 0x93, 0xb4, 0x10, 0x7d, 0x63 };
            public string Decrypt(string stringToDecrypt, string sEncryptionKey)
            {
                byte[] inputByteArray = new byte[stringToDecrypt.Length + 1];
                try
                {
                    key = System.Text.Encoding.UTF8.GetBytes(sEncryptionKey.Substring(0, 8));
                    RijndaelManaged rndCrypt = new RijndaelManaged();
                    //                    DESCryptoServiceProvider des = new DESCryptoServiceProvider();
                    inputByteArray = Convert.FromBase64String(stringToDecrypt);
                    MemoryStream ms = new MemoryStream();
                    CryptoStream cs = new CryptoStream(ms, rndCrypt.CreateDecryptor(key, IV), CryptoStreamMode.Write);
                    cs.Write(inputByteArray, 0, inputByteArray.Length);
                    cs.FlushFinalBlock();
                    System.Text.Encoding encoding = System.Text.Encoding.UTF8; return encoding.GetString(ms.ToArray());
                }

                catch (Exception e)
                {
                    return e.Message;
                }

            }

            public string Encrypt(string stringToEncrypt, string SEncryptionKey)
            {
                try
                {
                    key = System.Text.Encoding.UTF8.GetBytes(SEncryptionKey.Substring(0, 8));
                    RijndaelManaged rndCrypt = new RijndaelManaged();
                    //                    DESCryptoServiceProvider des = new DESCryptoServiceProvider();
                    byte[] inputByteArray = Encoding.UTF8.GetBytes(stringToEncrypt);
                    MemoryStream ms = new MemoryStream();
                    CryptoStream cs = new CryptoStream(ms, rndCrypt.CreateEncryptor(key, IV), CryptoStreamMode.Write);
                    cs.Write(inputByteArray, 0, inputByteArray.Length);
                    cs.FlushFinalBlock();
                    return Convert.ToBase64String(ms.ToArray());
                }
                catch (Exception e)
                {
                    return e.Message;
                }

            }

        }

        private void update_device_detail_list_FromDB()
        {
            if (myConnection.State == ConnectionState.Open)
            {
                SqlDataReader myReader = null;
                try
                {
                    int[] bauds = { 50, 70, 150, 200, 300, 600, 1200, 2400, 4800, 9600, 19200, 38400 };
                    //restkk                    SqlCommand myCommand = new SqlCommand("select * from Readers where R_Active = 't' or R_Active = 'T' or R_Active = '1'", myConnection);
                    SqlCommand myCommand = new SqlCommand("SELECT * FROM readers WHERE ((R_Active = 1) AND (R_OnLine = 1) AND (R_Type = 0))", myConnection); //restkk

                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before ExecuteReader of select readers");                
                    myReader = myCommand.ExecuteReader();
                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  ExecuteReader of select readers");
                    
                    DeviceDetail temp = new DeviceDetail();
                    device_detail.Clear();
                    while (myReader.Read())
                    {
                        temp = new DeviceDetail();
                        temp.Address = Convert.ToUInt32(myReader["R_Code"].ToString());
                        temp.Name = myReader["R_Name"].ToString();
                        //restkk                        temp.Type = DeviceDetail.DeviceType.CLK6000;
                        temp.Type = DeviceDetail.DeviceType.MTT5000; //restkk

                        //restkk                        switch (myReader["R_COMType"].ToString())
                        switch (myReader["R_IsCom"].ToString()) //restkk
                        {
                            case "True": //COM
                                temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                                temp.BaudRate = bauds[Convert.ToInt32(myReader["R_BaudNo"].ToString())];
                                temp.COMPort = "COM" + myReader["R_Port"].ToString();
                                break;
                            case "False": //Network
                                temp.ConnectionType = DeviceDetail.DeviceCommunicationType.NETWORK;
                                temp.IP = Utility.GetIPAddress(myReader["R_IP"].ToString());
                                temp.Port = 1001;
                                break;
                        }
                        /*                        if (Convert.ToBoolean(myReader["R_IsCom"].ToString()))
                                                {
                                                    temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                                                    temp.BaudRate = bauds[Convert.ToInt32(myReader["R_BaudNo"].ToString())];
                                                    temp.COMPort = "COM" + myReader["R_Port"].ToString();
                                                }
                                                else
                                                {
                                                    temp.ConnectionType = DeviceDetail.DeviceCommunicationType.NETWORK;
                                                    temp.IP = Utility.GetIPAddress(myReader["R_IP"].ToString());
                                                    temp.Port = 1001;
                                                } */

                        ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before add temp to device_detail");
                        device_detail.Add(temp);
                        ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  add temp to device_detail");

                    }
//                    myReader.Close();
                }
                catch (Exception e)
                {
                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on update_device_detail_list_FromDB");
                    Console.WriteLine(e.ToString());
                }
                finally
                {
                    myReader.Close();
                }
            }
            else
            {
                try
                {
                    myConnection.Open();
                }
                catch (Exception ex)
                {
                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on update_device_detail_list_FromDB at myConnection.Open");
                    Console.WriteLine(ex.ToString());
                    //e_l.WriteEntry("Connection Fail  : " + e.Message);                
                }
            }
        }

        private void update_device_detail_list()
        {
            update_device_detail_list_FromDB();
            return;
            /* //restkk
                        DeviceDetail temp = new DeviceDetail();
                        device_detail.Clear();

            //restkk            if (!Directory.Exists(Constant.ConfigFileDirectory))
            //restkk                Directory.CreateDirectory(Constant.ConfigFileDirectory);

                        if (!File.Exists(Constant.ConfigFilePath))
                            return;
                        string[] detail = File.ReadAllLines(Constant.ConfigFilePath);

                        if (detail.Length < 11)
                            return;

                        for (int t = 0; t < detail.Length; t++)
                        {
                            if (detail[t].Equals("NEW DEVICE DETAIL START"))
                                temp = new DeviceDetail();
                            if (detail[t].Equals("TYPE:"))
                                if (detail[t + 1] == DeviceDetail.DeviceType.CLK6000.ToString())
                                    temp.Type = DeviceDetail.DeviceType.CLK6000;
                                else if (detail[t + 1] == DeviceDetail.DeviceType.MTT5000.ToString())
                                    temp.Type = DeviceDetail.DeviceType.MTT5000;
                                else if (detail[t + 1] == DeviceDetail.DeviceType.ACC1000.ToString())
                                    temp.Type = DeviceDetail.DeviceType.ACC1000;
                            if (detail[t].Equals("NAME:"))
                                temp.Name = detail[t + 1];
                            if (detail[t].Equals("Address:"))
                                temp.Address = Convert.ToUInt32(detail[t + 1]);
                            if (detail[t].Equals("SERIAL:"))
                            {
                                temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                                temp.COMPort = detail[t + 1];
                                temp.BaudRate = Convert.ToInt32(detail[t + 2]);
                            }
                            if (detail[t].Equals("NETWORK:"))
                            {
                                temp.ConnectionType = DeviceDetail.DeviceCommunicationType.NETWORK;
                                temp.IP = Utility.GetIPAddress(detail[t + 1]);
                                temp.Port = Convert.ToInt32(detail[t + 2]);
                            }
                            if (detail[t].Equals("NEW DEVICE DETAIL END"))
                                device_detail.Add(temp);
                        }
            */
            //restkk
        }

        private Boolean creat_appropriate_media()
        {
            Boolean temp = true;
            try
            {
                Device.DestroyMedia();
                System.Net.IPEndPoint net_address;
                int icurrent_device_index;
                icurrent_device_index = current_device_index;

                if (!(icurrent_device_index >= 0 && icurrent_device_index < device_detail.Count))
                    return false;

                switch (((DeviceDetail)device_detail[icurrent_device_index]).Type)
                {
                    case DeviceDetail.DeviceType.CLK6000:
                        Device = new Ghadir_UI.CLK6000();
                        break;

                    case DeviceDetail.DeviceType.MTT5000:
                        Device = new Ghadir_UI.MTT5000();
                        break;

                    case DeviceDetail.DeviceType.ACC1000:
                        Device = new Ghadir_UI.ACC1000();
                        break;
                }

                switch (((DeviceDetail)device_detail[icurrent_device_index]).ConnectionType)
                {
                    case DeviceDetail.DeviceCommunicationType.SERIAL:
                        if (!Device.CreateSerialMedia(((DeviceDetail)device_detail[icurrent_device_index]).COMPort, ((DeviceDetail)device_detail[icurrent_device_index]).BaudRate))
                            temp = false;
                        break;
                    case DeviceDetail.DeviceCommunicationType.NETWORK:
                        net_address = new System.Net.IPEndPoint(((DeviceDetail)device_detail[icurrent_device_index]).IP, ((DeviceDetail)device_detail[icurrent_device_index]).Port);
                        if (!Device.CreateNetworkMedia(net_address))
                            temp = false;
                        break;
                }
                if (temp)
                {
                    Device.TerminalAddress = ((DeviceDetail)device_detail[icurrent_device_index]).Address;
                    //                Device.TXTFilePath = Constant.ConfigFileDirectory + "\\" + ((DeviceDetail)device_detail[icurrent_device_index]).Name + ".rec";
                    Device.Recording = Ghadir_UI.Z84Family.RecordingType.AppendToTXTFile;
                    Device.CollectFinish += new Ghadir_UI.Z84Family.CollectFinishEvent(Device_CollectFinish);
                    Device.TwentyCollectFinish += new Ghadir_UI.Z84Family.TwentyCollectFinishEvent(Device_TwentyCollectFinish);

                    Device.OneOnlineCollectFinish += new Ghadir_UI.Z84Family.OneOnlineCollectFinishEvent(Device_OneOnlineCollectFinish);

                    Device.NoMoreRecords += new Ghadir_UI.Z84Family.NoMoreRecordsFound(Device_NoMoreRecords);
                    Device.NotResponse += new Ghadir_UI.Z84Family.NotResponceEvent(Device_NotResponse);
                    Device.MultiErrorOnReceive += new Ghadir_UI.Z84Family.MultiBadPacketEvent(Device_MultiErrorOnReceive);
                    Device.ShowMessageOnCollection = false;
//////                    Device.Media.LogPath = "d:";
//////                    Device.Media.LogFileOption = Ghadir_UI.LogPacket.LogFileMode.LogInOutRecordsAndAllPackets;
//                    Device.DirectPrintComplete += new Ghadir_UI.Z84Family.DirectPrintCompleteEvent(Device_DirectPrintComplete);
                }
                current_device_index = icurrent_device_index;
                return temp;
            }
            catch (Exception e)
            {
                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on creat_appropriate_media");
                Console.WriteLine(e.ToString());
                return false;
            }
        }

        private Boolean creat_a_media_Th(DeviceDetail iDeviceDetail, ref Ghadir_UI.Z84Family iDevice, Thread iThread)
        {
            Boolean temp = true;
            try
            {
                iDevice.DestroyMedia();
                System.Net.IPEndPoint net_address;
                //int icurrent_device_index;
                //icurrent_device_index = current_device_index;

                //if (!(icurrent_device_index >= 0 && icurrent_device_index < device_detail.Count))
                //    return false;

                switch (iDeviceDetail.Type)
                {
                    case DeviceDetail.DeviceType.CLK6000:
                        iDevice = new Ghadir_UI.CLK6000();
                        break;

                    case DeviceDetail.DeviceType.MTT5000:
                        iDevice = new Ghadir_UI.MTT5000();
                        break;

                    case DeviceDetail.DeviceType.ACC1000:
                        iDevice = new Ghadir_UI.ACC1000();
                        break;
                }

                switch (iDeviceDetail.ConnectionType)
                {
                    case DeviceDetail.DeviceCommunicationType.SERIAL:
                        if (!iDevice.CreateSerialMedia(iDeviceDetail.COMPort, iDeviceDetail.BaudRate))
                            temp = false;
                        break;
                    case DeviceDetail.DeviceCommunicationType.NETWORK:
                        net_address = new System.Net.IPEndPoint(iDeviceDetail.IP, iDeviceDetail.Port);
                        if (!iDevice.CreateNetworkMedia(net_address))
                            temp = false;
                        break;
                }
                if (temp)
                {
                    iDevice.TerminalAddress = iDeviceDetail.Address;
                    //                iDevice.TXTFilePath = Constant.ConfigFileDirectory + "\\" + iDeviceDetail.Name + ".rec";
                    iDevice.Recording = Ghadir_UI.Z84Family.RecordingType.AppendToTXTFile;

                    //x//iDevice.CollectFinish += new Ghadir_UI.Z84Family.CollectFinishEvent(Device_CollectFinish);
                    iDevice.CollectFinishTh += new Ghadir_UI.Z84Family.CollectFinishEventTh(Device_CollectFinish);

                    //x//iDevice.TwentyCollectFinish += new Ghadir_UI.Z84Family.TwentyCollectFinishEvent(Device_TwentyCollectFinish);

                    //x//iDevice.OneOnlineCollectFinish += new Ghadir_UI.Z84Family.OneOnlineCollectFinishEvent(Device_OneOnlineCollectFinish);
                    iDevice.OneOnlineCollectFinishTh += new Ghadir_UI.Z84Family.OneOnlineCollectFinishEventTh(Device_OneOnlineCollectFinish);

                    //x//iDevice.NoMoreRecords += new Ghadir_UI.Z84Family.NoMoreRecordsFound(Device_NoMoreRecords);
                    iDevice.NoMoreRecordsTh += new Ghadir_UI.Z84Family.NoMoreRecordsFoundTh(Device_NoMoreRecords);

                    //x//iDevice.NotResponse += new Ghadir_UI.Z84Family.NotResponceEvent(Device_NotResponse);
                    iDevice.NotResponseTh += new Ghadir_UI.Z84Family.NotResponceEventTh(Device_NotResponse);

                    //x//iDevice.MultiErrorOnReceive += new Ghadir_UI.Z84Family.MultiBadPacketEvent(Device_MultiErrorOnReceive);
                    iDevice.MultiErrorOnReceiveTh += new Ghadir_UI.Z84Family.MultiBadPacketEventTh(Device_MultiErrorOnReceive);

                    //x//iDevice.DirectPrintComplete += new Ghadir_UI.Z84Family.DirectPrintCompleteEvent(Device_DirectPrintComplete);
                    iDevice.DirectPrintCompleteTh += new Ghadir_UI.Z84Family.DirectPrintCompleteEventTh(Device_DirectPrintComplete);

                    iDevice.ShowMessageOnCollection = false;

                    iDevice.ExternThread = iThread;
                    //////                    iDevice.Media.LogPath = "d:";
                    //////                    iDevice.Media.LogFileOption = Ghadir_UI.LogPacket.LogFileMode.LogInOutRecordsAndAllPackets;
                    //                    iDevice.DirectPrintComplete += new Ghadir_UI.Z84Family.DirectPrintCompleteEvent(Device_DirectPrintComplete);
                }
                //current_device_index = icurrent_device_index;
                return temp;
            }
            catch (Exception e)
            {
                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on creat_appropriate_media");
                Console.WriteLine(e.ToString());
                return false;
            }
        }

        void Device_NoMoreRecords()
        {
//            collect_if_there_is_device();
            collectDevice_replyAnswer();
        }

        void Device_NoMoreRecords(Thread iThread)
        {
            //            collect_if_there_is_device();
            //x//collectDevice_replyAnswer();
            Boolean testIsAlive = false;
            while (!testIsAlive)
            {
                try
                {
                    iThread.Resume();
                    testIsAlive = true;
                }
                catch (Exception e)
                {
                    testIsAlive = false;
                }
            }
            //Monitor.Pulse(devicesThreads[0]);
        }

        void Device_TwentyCollectFinish(int Count)
        {
            //            Device_Save(Device.collected_data.Records);
            //restkk            Device_Save(Device.last_twenty_collected_data.Records);
            //restkk            Device.Acknowledge();

        }

        void Device_OneOnlineCollectFinish() //restkk is
        {
            //            Device_Save(Device.collected_data.Records);
            Device_Save(Device.last_collected_online_record, Device.last_received_status);
            collectDevice_replyAnswer();
            //Device.Acknowledge();

            //restkk ie
        }

        void Device_OneOnlineCollectFinish(object sender,Thread iThread) //restkk is
        {
            //            Device_Save(Device.collected_data.Records);
            Boolean testIsAlive = false;
            Ghadir_UI.Z84Family tempDevice = new Ghadir_UI.Z84Family();
            tempDevice = (Ghadir_UI.Z84Family)sender;
            Device_Save(tempDevice.last_collected_online_record, tempDevice.last_received_status);
            while (!testIsAlive)
            {
                try
                {
                    iThread.Resume();
                    testIsAlive = true;
                }
                catch (Exception e)
                {
                    testIsAlive = false;
                }
            }

            //x//collectDevice_replyAnswer();
            //Device.Acknowledge();

            //restkk ie
        }

        void Device_DirectPrintComplete()
        {
            //e_l.WriteEntry("Bad Responce On " + ((DeviceDetail)device_detail[current_device_index]).Name);
//            collect_if_there_is_device();
//            if (collectDevice_or_replyAnswer)
            //x//directPrintCompleted = true;
            collectDevice_replyAnswer();
        }

        void Device_DirectPrintComplete(Thread iThread)
        {
            //e_l.WriteEntry("Bad Responce On " + ((DeviceDetail)device_detail[current_device_index]).Name);
            //            collect_if_there_is_device();
            //            if (collectDevice_or_replyAnswer)
            //x//directPrintCompleted = true;
            //x//collectDevice_replyAnswer();
            Boolean testIsAlive = false;
            while (!testIsAlive)
            {
                try
                {
                    iThread.Resume();
                    testIsAlive = true;
                }
                catch (Exception e)
                {
                    testIsAlive = false;
                }
            }
        }

        void Device_MultiErrorOnReceive()
        {
            //e_l.WriteEntry("Bad Responce On " + ((DeviceDetail)device_detail[current_device_index]).Name);
//            collect_if_there_is_device();
//            if (collectDevice_or_replyAnswer)
//            directPrintWait = false;
//            collectDevice_replyAnswer();
            if (collectDevice_or_replyAnswer)
            {
                collectDevice_replyAnswer();
            }
            else
            {
                if (directPrintWait)
                {
                    directPrintWait = false;
                    collectDevice_replyAnswer();
                }
            }
        }

        void Device_MultiErrorOnReceive(Thread iThread)
        {
            //e_l.WriteEntry("Bad Responce On " + ((DeviceDetail)device_detail[current_device_index]).Name);
            //            collect_if_there_is_device();
            //            if (collectDevice_or_replyAnswer)
            //            directPrintWait = false;
            //            collectDevice_replyAnswer();
            /*//x//if (collectDevice_or_replyAnswer)
            {
                collectDevice_replyAnswer();
            }
            else
            {
                if (directPrintWait)
                {
                    directPrintWait = false;
                    collectDevice_replyAnswer();
                }
            }*/
            Boolean testIsAlive = false;
            while (!testIsAlive)
            {
                try
                {
                    iThread.Resume();
                    testIsAlive = true;
                }
                catch (Exception e)
                {
                    testIsAlive = false;
                }
            }
        }

        void Device_CollectFinish(Ghadir_UI.Z84Family.CollectFinishState state, int Count)
        {
            //e_l.WriteEntry("Collection Finish On " + ((DeviceDetail)device_detail[current_device_index]).Name);
            //880223            Device_Save(Device.collected_data.Records);
//            collect_if_there_is_device();
            collectDevice_replyAnswer();
        }

        void Device_CollectFinish(Ghadir_UI.Z84Family.CollectFinishState state, int Count, Thread iThread)
        {
            //e_l.WriteEntry("Collection Finish On " + ((DeviceDetail)device_detail[current_device_index]).Name);
            //880223            Device_Save(Device.collected_data.Records);
//            collect_if_there_is_device();
            //x//collectDevice_replyAnswer();
            Boolean testIsAlive = false;
            while (!testIsAlive)
            {
                try
                {
                    iThread.Resume();
                    testIsAlive = true;
                }
                catch (Exception e)
                {
                    testIsAlive = false;
                }
            }
        }

        string Get_Person_Code(string Proxi)
        {
            string res = "";
            if (myConnection.State == ConnectionState.Open)
            {
                try
                {
                    SqlDataReader myReader = null;
                    SqlCommand myCommand = new SqlCommand("select p_Barcode from Persons where p_Proxi = '" + Proxi.PadLeft(8, '0') + "'", myConnection);
                    myReader = myCommand.ExecuteReader();
                    while (myReader.Read())
                    {
                        res = Convert.ToString(myReader["p_Barcode"].ToString()).PadLeft(8, '0');
                    }
                    myReader.Close();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
                }

            }
            if (res == "")
                res = Proxi.PadLeft(8, '0');
            return res;
        }

        string Shamsi2Milady(string MDate)
        {
            //byte p;
            int p, y, m, d;
            string s;
            s = "";
            y = 0;
            m = 0;
            d = 0;
            if (MDate != "")
            {
                p = MDate.IndexOf('/');
                //p := pos('/', MDate);
                if (p > 0)
                {
                    y = Convert.ToInt32(MDate.Substring(0, p));
                    MDate = MDate.Substring(p + 1, MDate.Length - (p + 1));
                    //MDate.Remove(0, p);
                    //y = StrToInt(Copy(MDate, 1, p-1));
                    //Delete(MDate, 1, p);
                }
                p = MDate.IndexOf('/');
                //p := pos('/', MDate);
                if (p > 0)
                {
                    m = Convert.ToInt32(MDate.Substring(0, p));
                    MDate = MDate.Substring(p + 1, MDate.Length - (p + 1));
                    //MDate.Remove(0, p);
                    //m := StrToInt(Copy(MDate, 1, p-1));
                    //Delete(MDate, 1, p);
                }

                if (MDate != "")
                    d = Convert.ToInt32(MDate);
                //d := StrToInt(MDate);
            }
            s = ShToM(y, m, d);
            s = s.Substring(0, 4) + '/' + s.Substring(4, 2) + '/' + s.Substring(6, 2);
            return s;
        }

        string ShToM(int Y, int M, int D)
        {
            string y, m, d;
            byte[] A = { 0, 10, 11, 9, 11, 10, 10, 9, 9, 9, 8, 9, 9, 10, 11, 9 };
            byte[] B = { 0, 20, 19, 20, 20, 21, 21, 22, 22, 22, 22, 21, 21, 20, 19, 20 };
            if (Y % 4 == 3)
                D--;
            if (Y % 4 == 2)
                A[15] = 10;
            M = M + 3;
            if (D > A[M])
                D = D - A[M];
            else
            {
                M--;
                D = D + B[M];
            }
            if (M > 12)
                M = M - 12;
            else
                Y--;
            if (Y < 1000)
                Y = (Y + 22) % 100;
            else
                Y = Y + 622;
            y = Convert.ToString(Y);
            if (M < 10)
                m = "0" + Convert.ToString(M);
            else
                m = Convert.ToString(M);
            if (D < 10)
                d = "0" + Convert.ToString(D);
            else
                d = Convert.ToString(D);
            return (y + m + d);
            //A[15] = 9;
        }

        void Device_Save(Ghadir_UI.OneRecord/* //restkk [] recs*/ rec, UInt64 receivedStatus)
        {
            if (myConnection.State == ConnectionState.Open)
            {
                try
                {
                    string cmnd;
                    string TableName;
                    SqlCommand myCommand;
                    IAsyncResult IAsResultDS;

                    //restkk                    foreach (Ghadir_UI.OneRecord rec in recs)
                    //restkk                    {
                    /* //restkk
                                            #if iooc
                                            #warning iooc is defined; only use for Iranian Offshore Oil Co.
                                                                    TableName = "Ciooc";
                                            #elif Payvast
                                            #warning Payvast is defined; only use for Payvast Co.
                                                                    TableName = "__TshOnlineClockInfo__"; 
                                            #else
                                            #warning iooc and Payvast is NOT defined; don't use for Iranian Offshore Oil Co or Payvast Co.
                                                                    TableName = "C13" + rec.Date.Substring(0, 2) + rec.Date.Substring(3, 2);
                                            #endif
                                            #if Payvast //Region for Payvast Co.
                                            cmnd = "IF not EXISTS(SELECT name " +
                                                   "FROM sysobjects " +
                                                   "WHERE (name = '" + TableName + "'))" +
                                                   "create table " + TableName +
                                                   "(Code bigint, PreCart int, tDate DateTime," +
                                                   " tHour int, IO bit, prsID bigint, status int," +
                                                   " ClockCode int)";
                                            myCommand = new SqlCommand(cmnd, myConnection);
                                            myCommand.ExecuteNonQuery();
                                            myCommand.Dispose(); 
                                            rec.CardNumber = Get_Person_Code(rec.CardNumber); 
                                            rec.Time = Convert.ToString(60 * Convert.ToInt32(rec.Time.Substring(0, 2)) + Convert.ToInt32(rec.Time.Substring(3, 2)));// Convert.ToString(60 * ((Convert.ToInt32(rec.Time[0]) - 48) * 10 + (Convert.ToInt32(rec.Time[1]) - 48)) + ((Convert.ToInt32(rec.Time[3]) - 48) * 10 + (Convert.ToInt32(rec.Time[4]) - 48)));
                                            rec.Date = "13" + rec.Date;
                                            rec.CardStstus = String.Format("{0:x}", Convert.ToInt32(rec.CardStstus));                        

                    /*                        cmnd = "SELECT prsID, IO from " + TableName +
                                                   " where (Code = ( SELECT max(code) as mCode  From " + TableName + " WHERE prsID = " + rec.CardNumber + " ))";
                                            SqlDataReader myReader = null;
                                            myCommand = new SqlCommand(cmnd, myConnection);
                                            myReader = myCommand.ExecuteReader();
                                            Boolean io = false;
                                            while (myReader.Read())
                                            {
                                                io = !(Convert.ToBoolean(myReader["IO"].ToString()));
                                            }
                                            myReader.Close();
                                            myCommand.Dispose(); */

                    //cmnd = "IF not EXISTS(SELECT prsID " +
                    //       "FROM " + TableName + " " +
                    //       "WHERE  prsID = " + rec.CardNumber/*.PadLeft(8, '0')*/ + " " +
                    //       "AND tDate = " + rec.Date + " " +
                    //       "AND tHour = " + rec.Time + " ) ";
                    //restkk                        cmnd = /*cmnd +*/ "if (select max(Code) from " + TableName+ " ) is not null "   
                    /* //restkk                               + "INSERT into " + TableName + " (Code, PreCart, tDate, tHour, IO, prsID, status,  ClockCode) "
                                                   + "SELECT max(Code)+1, " //  from " + TableName + " , "
                                                   + rec.CardStstus + ", "
                                                   + "convert(datetime, '" + Shamsi2Milady(rec.Date) + "'), "
                                                   + rec.Time + ", "
                                                   + "0, " // Convert.ToByte(io) + ", " 
                                                   + Convert.ToInt64(rec.CardNumber, 16) + ", "
                                                   + "0, " 
                                                   + rec.TerminalAddress + " from " + TableName + " " 
                                                   + "else INSERT into " + TableName + " (Code, PreCart, tDate, tHour, IO, prsID, status,  ClockCode) "
                                                   + "Values ( 1, "
                                                   + rec.CardStstus + ", "
                                                   + "convert(datetime, '" + Shamsi2Milady(rec.Date) + "'), "
                                                   + rec.Time + ", "
                                                   + "0, " // Convert.ToByte(io) + ", " 
                                                   + Convert.ToInt64(rec.CardNumber, 16) + ", "
                                                   + "0, " 
                                                   + rec.TerminalAddress + " )"; 
                                            //end Region for Payvast Co.
                                            #else
                                            cmnd = "IF not EXISTS(SELECT name " +
                                                   "FROM sysobjects " +
                                                   "WHERE (name = '" + TableName + "'))" +
                                                   "create table " + TableName +
                                                   "(Clock_BarCode varchar(8), Clock_BDate varchar(10)," +
                                                   " Clock_BTime smallint, Clock_BRdrCode smallint," +
                                                   " Clock_BRecState smallint, Clock_Date varchar(10)," +
                                                   " Clock_Time smallint, Clock_RdrCode smallint," +
                                                   " Clock_Chg smallint, Clock_RecState smallint," +
                                                   " Clock_User varchar(15))";
                                            myCommand = new SqlCommand(cmnd, myConnection);
                                            myCommand.ExecuteNonQuery();
                                            myCommand.Dispose();                         
                                            rec.CardNumber = Get_Person_Code(rec.CardNumber); 
                                            rec.Time = Convert.ToString(60 * Convert.ToInt32(rec.Time.Substring(0, 2)) + Convert.ToInt32(rec.Time.Substring(3, 2)));// Convert.ToString(60 * ((Convert.ToInt32(rec.Time[0]) - 48) * 10 + (Convert.ToInt32(rec.Time[1]) - 48)) + ((Convert.ToInt32(rec.Time[3]) - 48) * 10 + (Convert.ToInt32(rec.Time[4]) - 48)));
                                            rec.Date = "13" + rec.Date;
                                            rec.CardStstus = String.Format("{0:x}", Convert.ToInt32(rec.CardStstus));
                                            cmnd = "IF not EXISTS(SELECT Clock_BarCode " +
                                                  "FROM " + TableName + " " +
                                                  "WHERE Clock_BarCode = '" + rec.CardNumber.PadLeft(8, '0') + "' " +
                                                  "AND Clock_Date = '" + rec.Date + "' ";
                                            cmnd = cmnd + "AND Clock_Time = " + rec.Time + ") ";
                                            cmnd = cmnd + "INSERT into " + TableName + " (clock_barcode ,clock_bdate,clock_btime,clock_brdrCode,clock_brecState, clock_date,clock_time,clock_rdrCode,clock_recState,clock_chg,clock_user) " +
                                                         "VALUES('" + rec.CardNumber + "', " +
                                                                "'" + rec.Date + "', "
                                                                     + rec.Time + "  , "
                                                                     + rec.TerminalAddress + "  , "
                                                                     + rec.CardStstus + "  , " +
                                                                "'" + rec.Date + "', "
                                                                     + rec.Time + "  , "
                                                                     + rec.TerminalAddress + "  , "
                                                                     + rec.CardStstus + "  , "
                                                                     + " 0  , "
                                                                     + "'service') ";
                                            #endif
                    */
                    //restkk                    

                    //restkk is
                    
                    TableName = "OnlineCollectedRecs";
                    /*//xxx// cmnd = "IF not EXISTS(SELECT name " +
                           "FROM sysobjects " +
                           "WHERE (name = '" + TableName + "' ))" +
                           "create table " + TableName + " " +
                           "(Rest_ID int IDENTITY (1, 1) NOT NULL," +
                           " Rest_BarCode varchar(8)," +
                           " Rest_Date varchar(10)," +
                           " Rest_Time smallint," +
                           " Rest_RdrCode smallint," +
                           " Rest_RecState smallint," +
                           " Rest_User varchar(15)," +
                           " Rest_IsPrint bit," +
                           " Rest_ReplyPacket varchar(1000), " +
                           " Rest_Status smallint )";
                    myCommand = new SqlCommand(cmnd, myConnection);
                    myCommand.ExecuteNonQuery();
                    myCommand.Dispose();*/

                    //                        rec.CardNumber = Get_Person_Code(rec.CardNumber);
                    rec.Time = Convert.ToString(60 * Convert.ToInt32(rec.Time.Substring(0, 2)) + Convert.ToInt32(rec.Time.Substring(3, 2)));// Convert.ToString(60 * ((Convert.ToInt32(rec.Time[0]) - 48) * 10 + (Convert.ToInt32(rec.Time[1]) - 48)) + ((Convert.ToInt32(rec.Time[3]) - 48) * 10 + (Convert.ToInt32(rec.Time[4]) - 48)));
                    rec.Date = "13" + rec.Date;
                    //restkk rec.CardStstus = String.Format("{0:x}", Convert.ToInt32(rec.CardStstus));
                    cmnd = "IF not EXISTS(SELECT Rest_BarCode " +
                           "FROM " + TableName + " " +
                           "WHERE (Rest_RdrCode = " + rec.TerminalAddress + ")) ";
                           /*"WHERE (Rest_BarCode = '" + rec.CardNumber.PadLeft(8, '0') + "' " +
                           "AND Rest_Date = '" + rec.Date + "' ";
                    cmnd = cmnd + "AND Rest_Time = " + rec.Time + " AND Rest_RdrCode = " + rec.TerminalAddress + " And  ((Rest_ReplyPacket is null) or (Rest_ReplyPacket = ''))  )) "; */
                    cmnd = cmnd + "INSERT into " + TableName + " (Rest_Barcode ,Rest_Date,Rest_Time,Rest_RdrCode,Rest_RecState,Rest_User,Rest_IsPrint,Rest_ReplyPacket,Rest_Status) " +
                                 "VALUES('" + rec.CardNumber + "', " +
                                        "'" + rec.Date + "', "
                                             + rec.Time + "  , "
                                             + rec.TerminalAddress + "  , "
                                             + rec.CardStstus + "  , "
                                             + "'service' , 0 , null , "
                                             + receivedStatus.ToString() + " ) ";
                    //restkk ie

                    //cmnd = "insert into c13" + rec.Date.Substring(0, 2) + rec.Date.Substring(3, 2) + " (clock_barcode ,clock_bdate,clock_btime,clock_brdrCode,clock_brecState, clock_date,clock_time,clock_rdrCode,clock_recState,clock_chg,clock_user) values ('" + rec.CardNumber + "','13" + rec.Date + "'," + rec.Time + "," + rec.TerminalAddress + "," + rec.CardStstus + ",'13" + rec.Date + "'," + rec.Time + "," + rec.TerminalAddress + "," + rec.CardStstus + ",0, 'service')";
                    myCommand = new SqlCommand(cmnd, myConnection);

                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before ExecuteNonQuery of INSERT into OnlineCollectedRecs");                
                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  ExecuteNonQuery of INSERT into OnlineCollectedRecs");                

                    //xxx//myCommand.ExecuteNonQuery();
                    IAsResultDS = myCommand.BeginExecuteNonQuery();

                    while (!IAsResultDS.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(10);
                    }

                    myCommand.EndExecuteNonQuery(IAsResultDS);

                    myCommand.Dispose();
                    //restkk                    }
                }
                catch (Exception e)
                {
                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on Device_Save");
                    Console.WriteLine(e.ToString());
                }
            }
        }

        void Device_NotResponse(ArrayList LastSentCommand)
        {
            //e_l.WriteEntry("Not Responding On " + ((DeviceDetail)device_detail[current_device_index]).Name);
//            collect_if_there_is_device();
            if (collectDevice_or_replyAnswer)
            {
                collectDevice_replyAnswer();
            }
            else
            {
                if (directPrintWait)
                {
                    directPrintWait = false;
                    collectDevice_replyAnswer();
                }
            }
        }

        void Device_NotResponse(ArrayList LastSentCommand, Thread iThread)
        {
            //e_l.WriteEntry("Not Responding On " + ((DeviceDetail)device_detail[current_device_index]).Name);
            //            collect_if_there_is_device();
            /*//x//if (collectDevice_or_replyAnswer)
            {
                collectDevice_replyAnswer();
            }
            else
            {
                if (directPrintWait)
                {
                    directPrintWait = false;
                    collectDevice_replyAnswer();
                }
            }*/
            Boolean testIsAlive = false;
            while (!testIsAlive)
            {
                try
                {
                    iThread.Resume();
                    testIsAlive = true;
                }
                catch (Exception e)
                {
                    testIsAlive = false;
                }
            }
            //Monitor.Pulse(devicesThreads[0]);
        }

        Boolean all_devices_has_been_pooled()
        {
            if (current_device_index < device_detail.Count)
                return false;
            else 
            {
                //e_l.WriteEntry("All Devices Have Been Polled");
                //////timer.Start();
                //                timer2.Start(); //restkk2
//                update_device_detail_list();
//                current_device_index = -1;
                return true;
            }
        }

        void collect_if_there_is_device()
        {
            try
            {
                Device.DestroyMedia();
                current_device_index++;
                if (all_devices_has_been_pooled())
                {
                    change_collect_or_reply();
                    reset_device_list();
                    //xxx//createTimer();
                    return;
                }
                while (((DeviceDetail)device_detail[current_device_index]).Type != DeviceDetail.DeviceType.MTT5000) //restkk
                {
                    current_device_index++;
                    if (all_devices_has_been_pooled())
                    {
                        change_collect_or_reply();
                        reset_device_list();
                        //xxx//createTimer();
                        return;
                    }
                }

                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before creat_appropriate_media");
                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  creat_appropriate_media");

                //e_l.WriteEntry("Start Collection");
                //restkk            Device.CollectionAllRecords();

                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before ReadOneRecord from Device");

                switch (((DeviceDetail)device_detail[current_device_index]).ConnectionType)
                {
                    case DeviceDetail.DeviceCommunicationType.SERIAL:
                        while (!creat_appropriate_media())
                        {
                            current_device_index++;
                            if (all_devices_has_been_pooled())
                            {
                                change_collect_or_reply();
                                reset_device_list();
                                //xxx//createTimer();
                                return;
                            }
                        }
                        Device.ReadOneRecord(); //restkk
                        break;
                    case DeviceDetail.DeviceCommunicationType.NETWORK:
//                        pReply = pinger.Send(((DeviceDetail)device_detail[current_device_index]).IP, 200);
//                        if (pReply.Status == IPStatus.Success)
                        if (pingDevice(((DeviceDetail)device_detail[current_device_index]).IP))
                        {
                            while (!creat_appropriate_media())
                            {
                                current_device_index++;
                                if (all_devices_has_been_pooled())
                                {
                                    change_collect_or_reply();
                                    reset_device_list();
                                    //xxx//createTimer();
                                    return;
                                }
                            }
                            Device.ReadOneRecord();
                        }
                        else
                        {
                            //current_device_index++;                            
                            //if (all_devices_has_been_pooled())
                            //{
                            //    change_collect_or_reply();
                            //    reset_device_list();
                            //}
                            //xxx//createTimer();
                            return;
                        }
                        break;
                }

                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  ReadOneRecord from Device");

                //Device.Collection();
            }
            catch (Exception e)
            {
                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on collect_if_there_is_device");
                Console.WriteLine(e.ToString());
                //xxx//createTimer();
            }
        }

        Boolean pingDevice(IPAddress deviceIP)
        {
            try
            {
                Ping pinger = new Ping();
                PingReply pReply;
                int pingTimeout = 600;

                pReply = pinger.Send(deviceIP, pingTimeout);
                if (pReply.Status == IPStatus.Success)
                    return true;
                else
                    return false;
                //return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return false;
            }
        }

        void reply_if_there_is_answer()
        {
            //restkk is
            if (myConnection.State == ConnectionState.Open)
            {
                SqlDataReader myReader = null;
                try
                {

                    string cmnd, iReplyPacket ,iBarCode, iDate;
                    string TableName;
                    int iRestID = 0;
                    uint iRdrCode, iTime;
                    //byte n;
                    Boolean iIsPrint = false;
                    int[] bauds = { 50, 70, 150, 200, 300, 600, 1200, 2400, 4800, 9600, 19200, 38400 };
                    SqlCommand myCommand;
                    Boolean tempBool = true;
                    Boolean tempBool2 = false;
                    System.Net.IPEndPoint net_address;
                    //SqlConnection tempConnection = new SqlConnection(myConnection.ConnectionString + "password=1234;");
                    //tempConnection.Open();
                    TableName = "OnlineCollectedRecs";
                    cmnd = "IF not EXISTS(SELECT name " +
                           "FROM sysobjects " +
                           "WHERE (name = '" + TableName + "' ))" +
                           "create table " + TableName + " " +
                           "(Rest_ID int IDENTITY (1, 1) NOT NULL," +
                           " Rest_BarCode varchar(8)," +
                           " Rest_Date varchar(10)," +
                           " Rest_Time smallint," +
                           " Rest_RdrCode smallint," +
                           " Rest_RecState smallint," +
                           " Rest_User varchar(15)," +
                           " Rest_IsPrint bit," +
                           " Rest_ReplyPacket varchar(1000), " +
                           " Rest_Status smallint )";
                    myCommand = new SqlCommand(cmnd, myConnection);
                    myCommand.ExecuteNonQuery();
                    myCommand.Dispose();

                    if(true)
                    {
                        cmnd = "SELECT *  " +
                               "FROM (SELECT * FROM  " +
                               "OnlineCollectedRecs  " +
                               "WHERE (Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> '')) as l1  " +
                               "WHERE Rest_ID = (SELECT min(Rest_ID)  " +
                               "FROM OnlineCollectedRecs  " +
                               "WHERE (Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> ''))  ";

                        /* xxxxx                   cmnd = "SELECT top 1 * " +
                                                   "FROM OnlineCollectedRecs " +
                        //                           "where (Rest_IsPrint = 0) and (Rest_SendingCount < 10) and ((Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> ''))";
                                                   "where (Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> '')"; */


                        //KXKXKX"where (Rest_ReplyPacket is null) or (Rest_ReplyPacket = '')";
                        myCommand = new SqlCommand(cmnd, myConnection);

                        ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before ExecuteReader of select top 1 * FROM OnlineCollectedRecs");
                        myReader = myCommand.ExecuteReader();
                        ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  ExecuteReader of select top 1 * FROM OnlineCollectedRecs");
                        if (myReader.Read())
                        {
                            iRdrCode = Convert.ToUInt32(myReader["Rest_RdrCode"].ToString());
                            iReplyPacket = myReader["Rest_ReplyPacket"].ToString();
                            iBarCode = myReader["Rest_BarCode"].ToString();
                            iDate = myReader["Rest_Date"].ToString();
                            iTime = Convert.ToUInt32(myReader["Rest_Time"].ToString());
                            iIsPrint = Convert.ToBoolean(myReader["Rest_IsPrint"].ToString());
                            iRestID = Convert.ToInt32(myReader["Rest_ID"].ToString());
                            myReader.Close();

                            cmnd = "SELECT * " +
                                   "FROM readers " +
                                   "WHERE (R_Code = " + iRdrCode.ToString() + ")";
                            myCommand.CommandText = cmnd;

                            DeviceDetail temp = new DeviceDetail();
                            ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before ExecuteReader of select readers for send packet");
                            myReader = myCommand.ExecuteReader();
                            ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  ExecuteReader of select readers for send packet");

                            if (myReader.Read())
                            {
                                temp.Address = iRdrCode; //Convert.ToUInt32(myReader["R_Code"].ToString());
                                temp.Name = myReader["R_Name"].ToString();
                                temp.Type = DeviceDetail.DeviceType.MTT5000;

                                switch (myReader["R_IsCom"].ToString())
                                {
                                    case "True": //COM
                                        temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                                        temp.BaudRate = bauds[Convert.ToInt32(myReader["R_BaudNo"].ToString())];
                                        temp.COMPort = "COM" + myReader["R_Port"].ToString();
                                        break;
                                    case "False": //Network
                                        temp.ConnectionType = DeviceDetail.DeviceCommunicationType.NETWORK;
                                        temp.IP = Utility.GetIPAddress(myReader["R_IP"].ToString());
                                        temp.Port = 1001;
                                        break;
                                }

                                myReader.Close();

                                //XXXX//

                                switch (temp.ConnectionType)
                                {
                                    case DeviceDetail.DeviceCommunicationType.SERIAL:
                                        tempBool2 = true;
                                        break;

                                    case DeviceDetail.DeviceCommunicationType.NETWORK:
                                        if (pingDevice(temp.IP))
                                            tempBool2 = true;
                                        else
                                            tempBool2 = false;
                                        break;

                                }


                                if (tempBool2)
                                {
                                    Device.DestroyMedia();

                                    Device = new Ghadir_UI.MTT5000();
                                    switch (temp.ConnectionType)
                                    {
                                        case DeviceDetail.DeviceCommunicationType.SERIAL:
                                            if (!Device.CreateSerialMedia(temp.COMPort, temp.BaudRate))
                                                tempBool = false;
                                            break;
                                        case DeviceDetail.DeviceCommunicationType.NETWORK:
                                            net_address = new System.Net.IPEndPoint(temp.IP, temp.Port);
                                            if (!Device.CreateNetworkMedia(net_address))
                                                tempBool = false;
                                            break;
                                    }
                                    if (tempBool)
                                    {
                                        Device.TerminalAddress = temp.Address;
                                        //                Device.TXTFilePath = Constant.ConfigFileDirectory + "\\" + ((DeviceDetail)device_detail[current_device_index]).Name + ".rec";
                                        Device.Recording = Ghadir_UI.Z84Family.RecordingType.AppendToTXTFile;
                                        //Device.CollectFinish += new Ghadir_UI.Z84Family.CollectFinishEvent(Device_CollectFinish);
                                        //Device.TwentyCollectFinish += new Ghadir_UI.Z84Family.TwentyCollectFinishEvent(Device_TwentyCollectFinish);

                                        //Device.OneOnlineCollectFinish += new Ghadir_UI.Z84Family.OneOnlineCollectFinishEvent(Device_OneOnlineCollectFinish);

                                        //Device.NoMoreRecords += new Ghadir_UI.Z84Family.NoMoreRecordsFound(Device_NoMoreRecords);
                                        Device.NotResponse += new Ghadir_UI.Z84Family.NotResponceEvent(Device_NotResponse);
                                        Device.MultiErrorOnReceive += new Ghadir_UI.Z84Family.MultiBadPacketEvent(Device_MultiErrorOnReceive);
                                        Device.DirectPrintComplete += new Ghadir_UI.Z84Family.DirectPrintCompleteEvent(Device_DirectPrintComplete);
                                        Device.ShowMessageOnCollection = false;
                                        //Device.Media.LogPath = "d:";
                                        //Device.Media.LogFileOption = Ghadir_UI.LogPacket.LogFileMode.LogInOutRecordsAndAllPackets;

                                        if (!directPrintWait)
                                        {

                                            string sTemp1;
                                            ArrayList sTemp2 = new ArrayList();
                                            ArrayList sTemp3 = new ArrayList();
                                            sTemp2.Clear();
                                            sTemp1 = "";
                                            //sTemp2.
                                            if (iIsPrint)
                                            {
                                                for (int i = 0; i < iReplyPacket.Length; i += 3)
                                                {
                                                    sTemp1 = iReplyPacket.Substring(i, 3);
                                                    sTemp2.Add(Convert.ToByte(Convert.ToUInt32(sTemp1)));
                                                    //Array.Resize(ref sTemp2, sTemp2.Length + 1);
                                                    //sTemp2[i] = Convert.ToByte(Convert.ToUInt32(sTemp1));

                                                    // += Convert.ToChar(Convert.ToUInt32(sTemp1));
                                                }
                                            }
                                            //iReplyPacket = sTemp2;

                                            ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before S endToClient packet");
                                            //KXKXKX Device.NoneAcknowledge(1); 
                                            ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  S endToClient packet");

                                            if (!iIsPrint)// && iReplyPacket == "DELETE THIS RECORD!")
                                            {
                                                //Thread.Sleep(150);
                                                directPrintWait = false;
                                                //x//directPrintCompleted = true;
                                                //Device.Media.SendToClient(sTemp2);
                                            }
                                            else
                                            {
                                                //x//directPrintCounter++;
                                                //Thread.Sleep(150);
                                                //x//if (directPrintCounter < 4)
                                                /*{
                                                    directPrintWait = true;
                                                    directPrintCompleted = false;
                                                    Device.DirectPrint(sTemp2);
                                                    return;
                                                }
                                                else
                                                {
                                                    directPrintWait = false;
                                                    directPrintCompleted = true;
                                                }*/
                                                //Device.Media.SendToClient(sTemp2);
                                            }
                                        }
                                    }
                                    else
                                    {
                                        //x//directPrintCounter++;
                                        /*//x//if (directPrintCounter < 4)
                                        {
                                            directPrintWait = false;
                                            directPrintCompleted = false;
                                            //xxx//createTimer();
                                        }
                                        else
                                        {
                                            directPrintWait = false;
                                            directPrintCompleted = true;
                                        }*/
                                    }
                                }
                                else
                                {
                                    //x//directPrintCounter++;
                                    /*//x//if (directPrintCounter < 4)
                                    {
                                        directPrintWait = false;
                                        directPrintCompleted = false;
                                        //xxx//createTimer();
                                    }
                                    else
                                    {
                                        directPrintWait = false;
                                        directPrintCompleted = true;
                                    }*/
                                }
                            }
                            else
                            {
                                //x//directPrintCounter++;
                                /*//x//if (directPrintCounter < 4)
                                {
                                    directPrintWait = false;
                                    directPrintCompleted = false;
                                    //xxx//createTimer();
                                }
                                else
                                {
                                    directPrintWait = false;
                                    directPrintCompleted = true;
                                }*/
                            }

                            //XXXX//

                            /*//x//if (directPrintCompleted)
                            {
                                directPrintCounter = 0;
                                cmnd = "DELETE " +
                                       "FROM OnlineCollectedRecs " +
                                       "WHERE Rest_ID = " + iRestID.ToString() + " ";
                                /*       "where ( ((Rest_BarCode = '" + iBarCode + "') OR (Rest_BarCode is null)) " +
                                       "and ((Rest_Date = '" + iDate + "') OR (Rest_Date is null)) " +
                                       "and (Rest_Time = " + iTime.ToString() + ") " +
                                       "and (Rest_RdrCode = " + iRdrCode.ToString() + ") " +
                                       "and (Rest_ReplyPacket = '" + iReplyPacket + "') ) ";//KXKXKX ") "; 
                                //x//* /

                                myCommand.CommandText = cmnd;

                                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before ExecuteReader of delete from OnlineCollectedRecs");
                                myReader = myCommand.ExecuteReader();
                                ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  ExecuteReader of delete from OnlineCollectedRecs");
                                myReader.Close();
                                directPrintWait = false;
                                directPrintCompleted = false;
                                //xxx//createTimer();                                    

                            }*/
                            /*
                                  SQL.Clear;
                                  SQL.Add('update OnlineCollectedRecs');
                            ////      SQL.Add('set Rest_ReplyPacket = ''' + PK + '''');
                                  SQL.Add('set Rest_ReplyPacket = ''' + tmp2 + '''');//:uParam');
                                  SQL.Add(' where ((Rest_BarCode = ''' + P_Fish.Fish_BarCode + ''')');
                                  SQL.Add(' and (Rest_Date = ''' + P_Fish.Fish_Date + ''')');
                                  SQL.Add(' and (Rest_Time = ' + P_Fish.Fish_mmTime + ')');
                                  SQL.Add(' and (Rest_RdrCode = ' + IntToStr(P_Fish.Fish_RdrCode) + ')');

                                  SQL.Add(' and ((Rest_ReplyPacket is null) or (Rest_ReplyPacket = '''')))'); 
                                                    */


                        }
                        else
                        {
                            myReader.Close();
                            change_collect_or_reply();
                            reset_device_list();
                            //xxx//createTimer();
                        }

                        /*
                        creat_appropriate_media();

                        SqlDataReader myReader = null;
                        int[] bauds = { 50, 70, 150, 200, 300, 600, 1200, 2400, 4800, 9600, 19200, 38400 };
                        SqlCommand myCommand = new SqlCommand("SELECT * FROM readers WHERE (R_Active = 1) AND (R_OnLine = 1) AND (R_Type = 0)", myConnection); //restkk
                        myReader = myCommand.ExecuteReader();
                        DeviceDetail temp = new DeviceDetail();
                        device_detail.Clear();
                        while (myReader.Read())
                        {
                            temp = new DeviceDetail();
                            temp.Address = Convert.ToUInt32(myReader["R_Code"].ToString());
                            temp.Name = myReader["R_Name"].ToString();
                            //restkk                        temp.Type = DeviceDetail.DeviceType.CLK6000;
                            temp.Type = DeviceDetail.DeviceType.MTT5000; //restkk

                            //restkk                        switch (myReader["R_COMType"].ToString())
                            switch (myReader["R_IsCom"].ToString()) //restkk
                            {
                                case "True": //COM
                                    temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                                    temp.BaudRate = bauds[Convert.ToInt32(myReader["R_BaudNo"].ToString())];
                                    temp.COMPort = "COM" + myReader["R_Port"].ToString();
                                    break;
                                case "False": //Network
                                    temp.ConnectionType = DeviceDetail.DeviceCommunicationType.NETWORK;
                                    temp.IP = Utility.GetIPAddress(myReader["R_IP"].ToString());
                                    temp.Port = 1001;
                                    break;
                            }
                            device_detail.Add(temp);
                        } 
                        myReader.Close();*/
                    }
                }
                catch (Exception e)
                {
                    collectDevice_or_replyAnswer = true;
                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on reply_if_there_is_answer");
                    if (!(myReader.IsClosed))
                    {
                        //myConnection.Close();
                        myReader.Close();
                    }
                    Console.WriteLine(e.ToString());
                    //xxx//createTimer();
                }
            }
            else
            {
                try
                { 
                    myConnection.Open();
                    //xxx//createTimer();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                    //xxx//createTimer();
                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on reply_if_there_is_answer at myConnection.Open(");
                    //e_l.WriteEntry("Connection Fail  : " + e.Message);                
                }
            }
            //restkk ie
        }

        public Service1()
        {
            InitializeComponent();
            //restkk            if (!Directory.Exists(Constant.ConfigFileDirectory))
            //restkk                Directory.CreateDirectory(Constant.ConfigFileDirectory);

            if (!File.Exists(Constant.DBConfigFilePath))
                return;
            string[] detail = File.ReadAllLines(Constant.DBConfigFilePath);
            string ConnStr = "MultipleActiveResultSets=true;Trusted_Connection=no;connection timeout=10;Asynchronous Processing=true;";
            /* //restkk
                        for (int t = 0; t < detail.Length; t++)
                        {
                            if (detail[t].Equals("Server Name:"))
                                ConnStr = ConnStr + "server=" + detail[t + 1].Trim() + ";";
                            if (detail[t].Equals("Database Name:"))
                                ConnStr = ConnStr + "database=" + detail[t + 1].Trim() + ";";
                            if (detail[t].Equals("User Name:"))
                                ConnStr = ConnStr + "user id=" + detail[t + 1].Trim() + ";";
                            if (detail[t].Equals("Password:"))
                            {
                                Encryption64 oEs = new Encryption64();
                                string txtPassText;
                                txtPassText = oEs.Decrypt(detail[t + 1].Trim(), Constant.encryptKey);
                                ConnStr = ConnStr + "password=" + txtPassText + ";";
            //                    ConnStr = ConnStr + "password=" + detail[t + 1].Trim() + ";";
                            }
                            if (detail[t].Equals("timerInterval:"))
                            {
                                timerInterval = Convert.ToInt32(detail[t + 1].Trim());
                                if (timerInterval == null || timerInterval == 0)
                                    timerInterval = 5000;
                            }
                        }
            */
            //restkk

            //restkk is
            timerInterval = 2000;
            ConnStr = ConnStr + "server=" + detail[2].Trim() + ";";
            ConnStr = ConnStr + "database=" + detail[1].Trim() + ";";
            ConnStr = ConnStr + "user id=" + detail[3].Trim() + ";";
            ConnStr = ConnStr + "password=" + detail[4].Trim() + ";";
            //restkk ie


            myConnection = new SqlConnection(ConnStr);
            try
            {
                myConnection.Open();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                //e_l.WriteEntry("Connection Fail  : " + e.Message);                
            }
        }

        protected override void OnStart(string[] args)
        {
            //    if(!EventLog.SourceExists("Ghadir.CO.LTD"))
            //        EventLog.CreateEventSource("Ghadir.CO.LTD", "Ghadir.CO");

            ////e_l.Source = "Ghadir.CO.LTD";
            while (!emptyOnlineCollectedRecs()) { }
            reset_device_list();
            createTimer();

//////            testTh = new Thread(new ThreadStart(this.test));
//////            testTh.Start();

            //            timer2.Interval = timerInterval; //restkk2
            //            timer2.AutoReset = true; //restkk2
            //            timer2.Enabled = true; //restkk2
            //            timer2.Elapsed += new ElapsedEventHandler(timer2_Elapsed); //restkk2
            //            timer2.Start(); //restkk2

        }

        private Boolean emptyOnlineCollectedRecs()
        {
            if (myConnection.State == ConnectionState.Open)
            {
                SqlDataReader myReader = null;
                try
                {
                    string cmnd;
                    SqlCommand myCommand;
                    string TableName = "OnlineCollectedRecs";

                    cmnd = "IF EXISTS(SELECT name " +
                           "FROM sysobjects " +
                           "WHERE (name = '" + TableName + "' )) " +
                           "TRUNCATE TABLE " + TableName;
                    myCommand = new SqlCommand(cmnd, myConnection);
                    myReader = myCommand.ExecuteReader();
                    myCommand.Dispose();
                    myReader.Close();

                    cmnd = "IF not EXISTS(SELECT name " +
                           "FROM sysobjects " +
                           "WHERE (name = '" + TableName + "' ))" +
                           "create table " + TableName + " " +
                           "(Rest_ID int IDENTITY (1, 1) NOT NULL," +
                           " Rest_BarCode varchar(8)," +
                           " Rest_Date varchar(10)," +
                           " Rest_Time smallint," +
                           " Rest_RdrCode smallint," +
                           " Rest_RecState smallint," +
                           " Rest_User varchar(15)," +
                           " Rest_IsPrint bit," +
                           " Rest_ReplyPacket varchar(1000), " +
                           " Rest_Status smallint )";
                    myCommand = new SqlCommand(cmnd, myConnection);
                    myReader = myCommand.ExecuteReader();
                    myCommand.Dispose();
                    myReader.Close();

                    return true;
                }
                catch (Exception e)
                {
                    if (!(myReader.IsClosed))
                    {
                        myReader.Close();
                    }
                    Console.WriteLine(e.ToString());
                    return false;
                }
            }
            else
            {
                try
                {
                    myConnection.Open();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
                }
                return false;
            }

        }
        private void createTimer()
        {
            if (timer != null)
                destroyTimer();
            timer = new System.Timers.Timer();
            timer.Interval = timerInterval;
            timer.AutoReset = false;
            //            timer.Enabled = true;
            timer.Elapsed += new ElapsedEventHandler(timer_Elapsed);
            timer.Start();
        }

        private void destroyTimer()
        {
            if (timer != null)
            {
                timer.Stop();
                timer.Dispose();
                timer = null;
            }
        }

        private class MultiThreadArgument{ 
            public DeviceDetail mtaDeviceDetail; 
            public Thread mtaThread;
            public int mtaThreadNo;
        }

        private void createDevicesThreads()
        {
            try
            {
                //ArrayList Device_Thread_toSend = new ArrayList();
                devicesThreads = new Thread[device_detail.Count];
                MultiThreadArgument mta = new MultiThreadArgument();
                //Dictionary <DeviceDetail, Thread> Device_Thread_dic = new Dictionary<DeviceDetail, Thread>();
                //int threadCtr;
                //foreach(Thread tempThread in devicesThreads)
                for (int i = 0; i <= device_detail.Count - 1; i++)
                {
                    //ThreadStart st = new ThreadStart(collectDevice_replyAnswer_thread);//((DeviceDetail)device_detail[i])));
                    devicesThreads[i] = new Thread(new ParameterizedThreadStart(collectDevice_replyAnswer_thread));
                    devicesThreads[i].TrySetApartmentState(ApartmentState.STA);
                    devicesThreads[i].IsBackground = true;
                    devicesThreads[i].Name = "Thread" + i.ToString();

                    //Device_Thread_toSend.Clear();
                    //Device_Thread_toSend.Add((DeviceDetail)device_detail[i]);
                    //Device_Thread_toSend.Add(devicesThreads[i]);
                    //Device_Thread_dic.Clear();
                    //Device_Thread_dic.Add((DeviceDetail)device_detail[i], devicesThreads[i]);
                    //devicesThreads[i].Start(Device_Thread_dic);
                    //devicesThreads[i].Start((DeviceDetail)device_detail[i]);//, devicesThreads[i]);
                    mta.mtaDeviceDetail = (DeviceDetail)device_detail[i];
                    mta.mtaThread = devicesThreads[i];
                    mta.mtaThreadNo = i;
                    redeemerThreadsDT.Add(DateTime.Now);
                    if (devicesThreads[i].ThreadState == (System.Threading.ThreadState.Background | System.Threading.ThreadState.Unstarted))
                        devicesThreads[i].Start(mta);
                    Thread.Sleep(250);
                }

                if (redeemerTimer != null)
                {
                    redeemerTimer.Stop();
                    redeemerTimer.Dispose();
                    redeemerTimer = null;
                    redeemerTimer = new System.Timers.Timer();
                    redeemerTimer.Interval = redeemerTimerInterval;
                    redeemerTimer.AutoReset = true;
                    redeemerTimer.Elapsed += new ElapsedEventHandler(redeemerTimer_Elapsed);
                    redeemerTimer.Start();
                }
                else
                {
                    redeemerTimer = new System.Timers.Timer();
                    redeemerTimer.Interval = redeemerTimerInterval;
                    redeemerTimer.AutoReset = true;
                    redeemerTimer.Elapsed += new ElapsedEventHandler(redeemerTimer_Elapsed);
                    redeemerTimer.Start();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        void collectDevice_replyAnswer_thread(object objDevice_Thread)//, curentThread)
        {
            //Dictionary<DeviceDetail, Thread> tempDevice_Thread_dic = new Dictionary<DeviceDetail, Thread>();
            //ArrayList tempDevice_Thread = new ArrayList();
            Boolean tempBoolAll = true;
            Boolean isConnected = true;
            //x//Boolean collectMode = true;
            DeviceDetail tempDevice; // = new DeviceDetail();
            Thread tempThread;
            int tempThreadNo;
            Ghadir_UI.Z84Family thDevice = new Ghadir_UI.Z84Family();     


            SqlDataReader myReader = null;
            SqlCommand myCommand = new SqlCommand();

            string cmnd, iReplyPacket, iBarCode, iDate;
            string TableName = "OnlineCollectedRecs";
            int iRestID = 0;
            uint iRdrCode, iTime;
            //byte n;
            Boolean iIsPrint = false;
            int[] bauds = { 50, 70, 150, 200, 300, 600, 1200, 2400, 4800, 9600, 19200, 38400 };
            Boolean tempBool = true;
            Boolean tempBool2 = false;
            System.Net.IPEndPoint net_address;
            string sTemp1;
            ArrayList sTemp2 = new ArrayList();
            byte directPrintCounter = 0;
            Boolean directPrintCompleted = false;
            Boolean existPrint = true;
            IAsyncResult IAsResult;

            MultiThreadArgument imta = (MultiThreadArgument)objDevice_Thread;
            tempDevice = imta.mtaDeviceDetail;
            tempThread = imta.mtaThread;
            tempThreadNo = imta.mtaThreadNo;



            //tempDevice_Thread = (ArrayList)objDevice_Thread;
            //tempDevice = (DeviceDetail)objDevice;
            //tempDevice_Thread_dic = (Dictionary<DeviceDetail, Thread>)objDevice_Thread_dic;
            //tempDevice = tempDevice_Thread_dic.T
            //int testInt = 0;
            while (tempBoolAll)
            {
                try
                {
                    thDevice.DestroyMedia();
                    if (tempDevice.Type == DeviceDetail.DeviceType.MTT5000)
                    {
                        switch (tempDevice.ConnectionType)
                        {
                            case DeviceDetail.DeviceCommunicationType.SERIAL:
                                if (creat_a_media_Th(tempDevice, ref thDevice, tempThread))
                                {
                                    isConnected = true;
                                }
                                else
                                {
                                    isConnected = false;
                                }
                                break;
                            case DeviceDetail.DeviceCommunicationType.NETWORK:
                                //                        pReply = pinger.Send(((DeviceDetail)device_detail[current_device_index]).IP, 200);
                                //                        if (pReply.Status == IPStatus.Success)
                                if (pingDevice(tempDevice.IP))
                                {
                                    if (creat_a_media_Th(tempDevice, ref thDevice, tempThread))
                                    {
                                        isConnected = true;
                                    }
                                    else
                                    {
                                        isConnected = false;
                                    }
                                }
                                else
                                {
                                    isConnected = false;
                                }
                                break;
                        }

                    }
                    else
                    {
                        isConnected = false;
                    }
                    //x//collectMode = true;
                    while (isConnected)
                    {
                        //x//if (collectMode)
                        //x//{
                            switch (tempDevice.ConnectionType)
                            {
                                case DeviceDetail.DeviceCommunicationType.SERIAL:
                                    thDevice.ReadOneRecord();
                                    redeemerThreadsDT[tempThreadNo] = DateTime.Now;
                                    tempThread.Suspend();
                                    break;
                                case DeviceDetail.DeviceCommunicationType.NETWORK:

                                    if (pingDevice(tempDevice.IP))
                                    {
                                        thDevice.ReadOneRecord();
                                        redeemerThreadsDT[tempThreadNo] = DateTime.Now;
                                        tempThread.Suspend();
                                    }
                                    else
                                    {
                                        isConnected = false;
                                    }
                                    break;
                            }
                        //x//}
                        //x//else
                        //x//{
                            Thread.Sleep(100);
                            if (myConnection.State == ConnectionState.Open)
                            {
                                try
                                {
                                    //SqlConnection tempConnection = new SqlConnection(myConnection.ConnectionString + "password=1234;");
                                    //tempConnection.Open();


                                    /*//x//cmnd = "IF not EXISTS(SELECT name " +
                                           "FROM sysobjects " +
                                           "WHERE (name = '" + TableName + "' ))" +
                                           "create table " + TableName + " " +
                                           "(Rest_ID int IDENTITY (1, 1) NOT NULL," +
                                           " Rest_BarCode varchar(8)," +
                                           " Rest_Date varchar(10)," +
                                           " Rest_Time smallint," +
                                           " Rest_RdrCode smallint," +
                                           " Rest_RecState smallint," +
                                           " Rest_User varchar(15)," +
                                           " Rest_IsPrint bit," +
                                           " Rest_ReplyPacket varchar(1000), " +
                                           " Rest_Status smallint )";
                                    myCommand = new SqlCommand(cmnd, myConnection);
                                    myCommand.ExecuteNonQuery();
                                    myCommand.Dispose();*/
                                    existPrint = true;
                                    while (existPrint)
                                    {
                                        try
                                        {
                                            cmnd = "SELECT *  " +
                                                   "FROM (SELECT * FROM  " +
                                                   "OnlineCollectedRecs  " +
                                                   "WHERE (Rest_RdrCode = " + thDevice.TerminalAddress.ToString() + " ) and ((Rest_ReplyPacket is not null) and (Rest_ReplyPacket <> '')) ) as l1 " +
                                                   //xxxx"WHERE (Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> '')) as l1 " +
                                                   "WHERE Rest_ID = (SELECT min(Rest_ID)  " +
                                                   "FROM OnlineCollectedRecs  " +
                                                //x//"WHERE (Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> ''))  ";
                                                   //xxxx"WHERE (Rest_RdrCode = " + thDevice.TerminalAddress.ToString() + " ) and ((Rest_ReplyPacket is not null) and (Rest_ReplyPacket <> '')))  ";
                                                   "WHERE (Rest_RdrCode = " + thDevice.TerminalAddress.ToString() + " ) ) ";

                                            /* xxxxx                   cmnd = "SELECT top 1 * " +
                                                                       "FROM OnlineCollectedRecs " +
                                            //                           "where (Rest_IsPrint = 0) and (Rest_SendingCount < 10) and ((Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> ''))";
                                                                       "where (Rest_ReplyPacket is not null) or (Rest_ReplyPacket <> '')"; */

                                            //KXKXKX"where (Rest_ReplyPacket is null) or (Rest_ReplyPacket = '')";


                                            //xxx///myCommand = new SqlCommand(cmnd, myConnection);
                                            myCommand.Connection = myConnection;
                                            myCommand.CommandText = cmnd;


                                            //xxx//myReader = myCommand.ExecuteReader();
                                            IAsResult = myCommand.BeginExecuteReader();

                                            while (!IAsResult.IsCompleted)
                                            {
                                                System.Threading.Thread.Sleep(10);
                                            }

                                            myReader = myCommand.EndExecuteReader(IAsResult);


                                            if (myReader.Read())
                                            {
                                                directPrintCompleted = false;
                                                iRdrCode = Convert.ToUInt32(myReader["Rest_RdrCode"].ToString());
                                                iReplyPacket = myReader["Rest_ReplyPacket"].ToString();
                                                iBarCode = myReader["Rest_BarCode"].ToString();
                                                iDate = myReader["Rest_Date"].ToString();
                                                iTime = Convert.ToUInt32(myReader["Rest_Time"].ToString());
                                                iIsPrint = Convert.ToBoolean(myReader["Rest_IsPrint"].ToString());
                                                iRestID = Convert.ToInt32(myReader["Rest_ID"].ToString());
                                                myReader.Close();

                                                //x//ArrayList sTemp3 = new ArrayList();
                                                sTemp2.Clear();
                                                sTemp1 = "";
                                                //sTemp2.
                                                if ((iIsPrint) || ((!iIsPrint) && (iReplyPacket != "DELETE THIS RECORD!")))
                                                {
                                                    for (int i = 0; i < iReplyPacket.Length; i += 3)
                                                    {
                                                        sTemp1 = iReplyPacket.Substring(i, 3);
                                                        sTemp2.Add(Convert.ToByte(Convert.ToUInt32(sTemp1)));
                                                        //Array.Resize(ref sTemp2, sTemp2.Length + 1);
                                                        //sTemp2[i] = Convert.ToByte(Convert.ToUInt32(sTemp1));
                                                        // += Convert.ToChar(Convert.ToUInt32(sTemp1));
                                                    }
                                                }
                                                //iReplyPacket = sTemp2;

                                                if ((iIsPrint) || ((!iIsPrint) && (iReplyPacket != "DELETE THIS RECORD!")))
                                                {
                                                    while (!directPrintCompleted)
                                                    {
                                                        directPrintCounter++;
                                                        //Thread.Sleep(150);
                                                        if (directPrintCounter < 4)
                                                        {
                                                            thDevice.PrintComplete = false;
                                                            thDevice.DirectPrint(sTemp2);
                                                            redeemerThreadsDT[tempThreadNo] = DateTime.Now;
                                                            //xxxx//if (iIsPrint)
                                                            //xxxx//{
                                                            tempThread.Suspend();
                                                            if (thDevice.PrintComplete)
                                                                directPrintCompleted = true;
                                                            else
                                                                directPrintCompleted = false;
                                                            //xxxx//}
                                                                //xxxx//else
                                                            //xxxx//{
                                                                //xxxx//tempThread.Suspend();
                                                                //xxxx//directPrintCompleted = true;
                                                            //xxxx//}
                                                        }
                                                        else
                                                        {
                                                            directPrintCompleted = true;
                                                        }
                                                        //Device.Media.SendToClient(sTemp2);
                                                    }
                                                }
                                                else
                                                {
                                                    directPrintCompleted = true;
                                                }

                                                //XXXX//

                                                if (directPrintCompleted)
                                                {
                                                    directPrintCounter = 0;
                                                    cmnd = "DELETE " +
                                                           "FROM OnlineCollectedRecs " +
                                                           "WHERE Rest_ID = " + iRestID.ToString() + " ";
                                                    /*       "where ( ((Rest_BarCode = '" + iBarCode + "') OR (Rest_BarCode is null)) " +
                                                           "and ((Rest_Date = '" + iDate + "') OR (Rest_Date is null)) " +
                                                           "and (Rest_Time = " + iTime.ToString() + ") " +
                                                           "and (Rest_RdrCode = " + iRdrCode.ToString() + ") " +
                                                           "and (Rest_ReplyPacket = '" + iReplyPacket + "') ) ";//KXKXKX ") "; 
                                                    */

                                                    myCommand.CommandText = cmnd;

                                                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Before ExecuteReader of delete from OnlineCollectedRecs");
                                                    myReader = myCommand.ExecuteReader();
                                                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  After  ExecuteReader of delete from OnlineCollectedRecs");
                                                    myReader.Close();
                                                    //x//directPrintWait = false;
                                                    //x//directPrintCompleted = false;
                                                    //x//createTimer();
                                                }
                                                Thread.Sleep(100);
                                            }
                                            else
                                            {
                                                myReader.Close();
                                                existPrint = false;
                                                //x//change_collect_or_reply();
                                                //x//reset_device_list();
                                                //x//createTimer();
                                            }
                                        }
                                        catch (Exception e)
                                        {
                                            try
                                            {
                                                if (!(myReader.IsClosed))
                                                {
                                                    myReader.Close();
                                                }
                                            }
                                            catch(Exception e2)
                                            {
                                                existPrint = true;
                                            }
                                            existPrint = true;
                                        }

                                    }
                                }
                                catch (Exception e)
                                {
                                    //xxx//collectDevice_or_replyAnswer = true;
                                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on reply_if_there_is_answer");
                                    if (!(myReader.IsClosed))
                                    {
                                        //myConnection.Close();
                                        myReader.Close();
                                    }
                                    Console.WriteLine(e.ToString());
                                    //xxx//createTimer();
                                }
                            }
                            else
                            {
                                try
                                {
                                    myConnection.Open();
                                    //x//createTimer();
                                }
                                catch (Exception ex)
                                {
                                    Console.WriteLine(ex.ToString());
                                    //x//createTimer();
                                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  ERROR on reply_if_there_is_answer at myConnection.Open(");
                                    //e_l.WriteEntry("Connection Fail  : " + e.Message);                
                                }
                            }

                        //x//}
                    }
                }
                catch (Exception e2)
                {
                    //tempBool2 = false;
                }
                //Thread.Sleep(100);

                //}
                Thread.Sleep(100);
            }
        }

        void timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            try
            {
                destroyTimer();
                Thread.Sleep(5000);
                timerInterval = 150;
                createDevicesThreads();
            }
            catch (Exception e2)
            //finally 
            {
                Console.WriteLine(e.ToString());
                //////                timer.Start();
            }

/*
//////            timer.Stop();
//            while (true)
//            {
                try
                {
//                    e_l_counter++;
//                    e_l_counter2 = 1;
                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "  Start the loop");
                    timerInterval = 150;
                    destroyTimer();
//xxx                    if(collectDevice_or_replyAnswer)
//xxx                        reset_device_list();
                    collectDevice_replyAnswer();
                    /*
                    Thread.Sleep(10);
                    update_device_detail_list();
                    current_device_index = -1;
                    Thread.Sleep(10);
                    collect_if_there_is_device();
                    Thread.Sleep(20);
                    reply_if_there_is_answer(); */
                    //////                timer.Start();

                    ////e_l.WriteEntry(Convert.ToString(e_l_counter) + " " + Convert.ToString(e_l_counter2++) + "   End  the loop");
            /*
                            }
                            catch (Exception e2)
                            //finally 
                            {
                                Console.WriteLine(e.ToString());
                                //xxx//createTimer();
                                //////                timer.Start();
                            }
            //            }
            */
        }

        void redeemerTimer_Elapsed(object sender, ElapsedEventArgs e)
        {
            //xxxx//DateTime tempDT, tempDT2 = DateTime.Now;
            try
            {
                for (int i = 0; i <= device_detail.Count - 1; i++)
                {
                    //xxxx//tempDT =redeemerThreadsDT[i].AddMilliseconds(10000);
                    //xxxx//tempDT2 = DateTime.Now;
                    if (((DateTime)redeemerThreadsDT[i]).AddMilliseconds(10000) < DateTime.Now)
                    {
                        devicesThreads[i].Resume();
                    }
                }
                //xxx//destroyTimer();
                //xxx//Thread.Sleep(1000);
                //xxx//timerInterval = 150;
                //xxx//createDevicesThreads();
            }
            catch (Exception e2)
            //finally 
            {
                Console.WriteLine(e.ToString());
                //////                timer.Start();
            }
        }

        void collectDevice_replyAnswer()
        {
//            Thread.Sleep(10);
/*            if (all_devices_has_been_pooled())
            {
                update_device_detail_list();
                current_device_index = -1;
            }*/

//            Thread.Sleep(10);
//            Thread.Sleep(20);
            if (collectDevice_or_replyAnswer)
            {
//                if (all_devices_has_been_pooled())
//                    reset_device_list();
                collect_if_there_is_device();
            }
            else
            {
                reply_if_there_is_answer();
            }
        }

        /*        void timer2_Elapsed(object sender, ElapsedEventArgs e) //restkk2
                {
                    timer2.Stop(); //restkk2
                    try
                    {
        //restkk2                update_device_detail_list();
        //restkk2                current_device_index = -1;
        //restkk2                collect_if_there_is_device();
                        timer2.Start();
                    }
                    catch (Exception ex) //restkk2
                    {
                        timer2.Start(); //restkk2
                    }
                }*/
        void reset_device_list()
        {
            update_device_detail_list();
            current_device_index = -1;
        }

        void change_collect_or_reply()
        {
            collectDevice_or_replyAnswer = !collectDevice_or_replyAnswer;
        }

        protected override void OnStop()
        {
            //e_l.WriteEntry("Restaurant Service had been Stoped ");
/////            timer.Stop();
/////            timer.Enabled = false;
            //            timer2.Stop(); //restkk2
            //            timer2.Enabled = false; //restkk2
            // TODO: Add code here to perform any tear-down necessary to stop your service.
        }
/*        private void test()
        {
            while (true)
            {

                try
                {
                    update_device_detail_list();
                    current_device_index = -1;
                    collect_if_there_is_device();
                    Thread.Sleep(50);
                    reply_if_there_is_answer();
                    //////                    timer.Start();
                }
                catch (Exception e2)
                //            finally 
                {
                    //////                    timer.Start();
                }
            }
        } */


    }
}
