//#define iooc
//#define Payvast
#define Rash
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
using System.Net.NetworkInformation;
using System.Net;

namespace Ghadir_Service
{
    public partial class Service1 : ServiceBase
    {
        SqlConnection myConnection;     
        //EventLog e_l = new EventLog();
        string folder_path = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles);
        Ghadir_UI.Z84Family Device = new Ghadir_UI.Z84Family();
        System.Timers.Timer timer;//xxxx = new Timer();
        ArrayList device_detail = new ArrayList();
        int current_device_index = -1;
        int timerInterval = 2000;
        
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
                try
                {
                    SqlDataReader myReader = null;
                    int[] bauds = { 2400, 4800, 9600, 19200, 38400 };
                    SqlCommand myCommand = new SqlCommand("select * from Readers where (R_Type = 2) and (R_Active = 't' or R_Active = 'T' or R_Active = '1') ", myConnection);
                    myReader = myCommand.ExecuteReader();
                    DeviceDetail temp = new DeviceDetail();
                    device_detail.Clear();
                    while (myReader.Read())
                    {
                        temp = new DeviceDetail();
                        temp.Address = Convert.ToUInt32(myReader["R_Code"].ToString());
                        temp.Name = myReader["R_Name"].ToString();
                        temp.Type = DeviceDetail.DeviceType.CLK6000;

                        switch (myReader["R_COMType"].ToString())
                        {
                            case "0": //COM
                                temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                                temp.BaudRate = bauds[Convert.ToInt32(myReader["R_BaudNo"].ToString())];
                                temp.COMPort = "COM" + myReader["R_Port"].ToString();
                                break;
                            case "1": //Network
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
                        device_detail.Add(temp);
                    }
                    myReader.Close();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
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
                    //e_l.WriteEntry("Connection Fail  : " + e.Message);                
                }
            }
        }

        private void update_device_detail_list()
        {
            update_device_detail_list_FromDB();
            return; 
            DeviceDetail temp = new DeviceDetail();
            device_detail.Clear();

            if (!Directory.Exists(Constant.ConfigFileDirectory))
                Directory.CreateDirectory(Constant.ConfigFileDirectory);

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
        }

        private Boolean creat_appropriate_media()
        { 
            Device.DestroyMedia();
            Boolean temp = true;
            System.Net.IPEndPoint net_address;

            if (!(current_device_index >= 0 && current_device_index < device_detail.Count))
                return false;

           

            switch (((DeviceDetail)device_detail[current_device_index]).Type)
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

            switch (((DeviceDetail)device_detail[current_device_index]).ConnectionType)
            {
                case DeviceDetail.DeviceCommunicationType.SERIAL:
                    if (!Device.CreateSerialMedia(((DeviceDetail)device_detail[current_device_index]).COMPort, ((DeviceDetail)device_detail[current_device_index]).BaudRate))
                        temp = false;
                    break;
                case DeviceDetail.DeviceCommunicationType.NETWORK:
                    net_address = new System.Net.IPEndPoint(((DeviceDetail)device_detail[current_device_index]).IP, ((DeviceDetail)device_detail[current_device_index]).Port);
                    if (!Device.CreateNetworkMedia(net_address))
                        temp = false;
                    break;
            }
            if (temp)
            {
                Device.TerminalAddress = ((DeviceDetail)device_detail[current_device_index]).Address;
//                Device.TXTFilePath = Constant.ConfigFileDirectory + "\\" + ((DeviceDetail)device_detail[current_device_index]).Name + ".rec";
                Device.Recording = Ghadir_UI.Z84Family.RecordingType.AppendToTXTFile;
                Device.CollectFinish += new Ghadir_UI.Z84Family.CollectFinishEvent(Device_CollectFinish);
                Device.TwentyCollectFinish += new Ghadir_UI.Z84Family.TwentyCollectFinishEvent(Device_TwentyCollectFinish);
                Device.OneCollectFinish += new Ghadir_UI.Z84Family.OneCollectFinishEvent(Device_OneCollectFinish);
                Device.NoMoreRecords += new Ghadir_UI.Z84Family.NoMoreRecordsFound(Device_NoMoreRecords);
                Device.NotResponse += new Ghadir_UI.Z84Family.NotResponceEvent(Device_NotResponse);
                Device.MultiErrorOnReceive += new Ghadir_UI.Z84Family.MultiBadPacketEvent(Device_MultiErrorOnReceive);
                Device.ShowMessageOnCollection = false;
                //Device.Media.LogPath = "d:";
                //Device.Media.LogFileOption = Ghadir_UI.LogPacket.LogFileMode.LogInOutRecordsAndAllPackets;
            }
            return temp;
        }

        void Device_NoMoreRecords()
        {
            collect_if_there_is_device();
        }

        void Device_TwentyCollectFinish(int Count)
        {
//            Device_Save(Device.collected_data.Records);
            Device_Save(Device.last_twenty_collected_data.Records);
            Device.Acknowledge();        
        }

        void Device_OneCollectFinish()
        {
            //            Device_Save(Device.collected_data.Records);
            Ghadir_UI.CollectedRecords temprecs = new Ghadir_UI.CollectedRecords();
            temprecs.AddRecord(Device.last_collected_record);
            Device_Save(temprecs.Records);
            Device.Acknowledge();

        }


        void Device_MultiErrorOnReceive()
        {
            //e_l.WriteEntry("Bad Responce On " + ((DeviceDetail)device_detail[current_device_index]).Name);
            collect_if_there_is_device();
        }

        void Device_CollectFinish(Ghadir_UI.Z84Family.CollectFinishState state, int Count)
        {
            //e_l.WriteEntry("Collection Finish On " + ((DeviceDetail)device_detail[current_device_index]).Name);
//880223            Device_Save(Device.collected_data.Records);
            collect_if_there_is_device();
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
                res =  Proxi.PadLeft(8, '0');
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

        void Device_Save(Ghadir_UI.OneRecord[] recs)
        {
            if (myConnection.State == ConnectionState.Open)
            {
                try
                {
                    string cmnd;
                    string TableName;
                    SqlCommand myCommand;
                    foreach (Ghadir_UI.OneRecord rec in recs)
                    {
                        #if iooc
                        #warning iooc is defined; only use for Iranian Offshore Oil Co.
                                                TableName = "Ciooc";
                        #elif Payvast
                        #warning Payvast is defined; only use for Payvast Co.
                                                TableName = "__TshOnlineClockInfo__"; 
                        #elif Rash
                        #warning Rash is defined; only use for Rash Co.
                                                TableName = "tbl_ClockRecord"; 
                        #else
                        #warning iooc, Payvast and Rash NOT defined; don't use for Iranian Offshore Oil Co or Payvast Co or Rash Co.
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
                        cmnd = /*cmnd +*/ "if (select max(Code) from " + TableName+ " ) is not null "   
                               + "INSERT into " + TableName + " (Code, PreCart, tDate, tHour, IO, prsID, status,  ClockCode) "
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
                        #if Rash //Region for Rash Co.
                        //rec.CardNumber = Get_Person_Code(rec.CardNumber);
                        //end Region for Rash Co.
                        #else
                        rec.CardNumber = Get_Person_Code(rec.CardNumber);
                        #endif
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
                        //cmnd = "insert into c13" + rec.Date.Substring(0, 2) + rec.Date.Substring(3, 2) + " (clock_barcode ,clock_bdate,clock_btime,clock_brdrCode,clock_brecState, clock_date,clock_time,clock_rdrCode,clock_recState,clock_chg,clock_user) values ('" + rec.CardNumber + "','13" + rec.Date + "'," + rec.Time + "," + rec.TerminalAddress + "," + rec.CardStstus + ",'13" + rec.Date + "'," + rec.Time + "," + rec.TerminalAddress + "," + rec.CardStstus + ",0, 'service')";
                        myCommand = new SqlCommand(cmnd, myConnection);
                        myCommand.ExecuteNonQuery();
                        myCommand.Dispose();
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
                }
            }
        }

        void Device_NotResponse(ArrayList LastSentCommand)
        {
            //e_l.WriteEntry("Not Responding On " + ((DeviceDetail)device_detail[current_device_index]).Name);
            collect_if_there_is_device();
        }


        Boolean  all_devices_has_been_pooled()
        {           
            if (current_device_index < device_detail.Count)
                return false;
            else
            {
                //e_l.WriteEntry("All Devices Have Been Polled");
                //xxxxtimer.Start();
                createTimer();
                return true;
            }
        }


        void collect_if_there_is_device()
        {
            Boolean tempBoll = true;
            while (tempBoll)
            {
                Device.DestroyMedia();
                current_device_index++;
                if (all_devices_has_been_pooled())
                {
                    tempBoll = false;
                    return;
                }
                while (((DeviceDetail)device_detail[current_device_index]).Type != DeviceDetail.DeviceType.CLK6000)
                {
                    current_device_index++;
                    if (all_devices_has_been_pooled())
                    {
                        tempBoll = false;
                        return;
                    }
                }


                switch (((DeviceDetail)device_detail[current_device_index]).ConnectionType)
                {
                    case DeviceDetail.DeviceCommunicationType.SERIAL:
                        while (!creat_appropriate_media())
                        {
                            current_device_index++;
                            if (all_devices_has_been_pooled())
                            {
                                tempBoll = false;
                                return;
                            }
                        }
                        tempBoll = false;
                        Device.CollectionAllRecords();
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
                                    tempBoll = false;
                                    return;
                                }
                            }
                            tempBoll = false;
                            Device.CollectionAllRecords();
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
                            //xxxxreturn;
                            tempBoll = true;
                        }
                        break;
                }
            }


/*
//xxxx
            while (!creat_appropriate_media())
            {
                current_device_index++;
                if (all_devices_has_been_pooled())
                    return;
            }
            //e_l.WriteEntry("Start Collection");
            Device.CollectionAllRecords();
            //Device.Collection();
//xxxx
*/

        }


        public Service1()
        {
            InitializeComponent();
            if (!Directory.Exists(Constant.ConfigFileDirectory))
                Directory.CreateDirectory(Constant.ConfigFileDirectory);

            if (!File.Exists(Constant.DBConfigFilePath))
                return;
            string[] detail = File.ReadAllLines(Constant.DBConfigFilePath);
            string ConnStr = "Trusted_Connection=no;connection timeout=10;";
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
            myConnection = new SqlConnection(ConnStr);
            try
            {
                myConnection.Open();
            }
            catch (Exception e)
            {
                //e_l.WriteEntry("Connection Fail  : " + e.Message);                
            }
        }

        protected override void OnStart(string[] args)
        {
        //    if(!EventLog.SourceExists("Ghadir.CO.LTD"))
        //        EventLog.CreateEventSource("Ghadir.CO.LTD", "Ghadir.CO");

        //e_l.Source = "Ghadir.CO.LTD";

            //xxxxtimer.Interval = timerInterval;
            //xxxxtimer.AutoReset = true;
            //xxxxtimer.Enabled = true;
            //xxxxtimer.Elapsed += new ElapsedEventHandler(timer_Elapsed);
            //xxxxtimer.Start();
            createTimer();

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

        void timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            //xxxxtimer.Stop();
            destroyTimer();
            try
            {
                update_device_detail_list();
                current_device_index = -1;
                collect_if_there_is_device();
                //xxxxtimer.Start();
                //xxxxcreateTimer();
            }
            catch (Exception ex)
            {
                //xxxxtimer.Start();
                createTimer();
            }
        }

        protected override void OnStop()
        {
            //e_l.WriteEntry("Ghadir Service had been Stoped ");
            //xxxxtimer.Stop();
            destroyTimer();
            //xxxxtimer.Enabled = false;
            // TODO: Add code here to perform any tear-down necessary to stop your service.
        }
    }
}
