using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.IO;

namespace Ghadir_UI
{
    public class LogPacket
    {
        private string log_file_path;
        private ErrorTable errors = new ErrorTable();

//        private const string InOutRecordsAndAllPackets_extention_path = @"\Log\InOutRecordsAndAllPackets.INF"; 
        private const string InOutRecords_extention_path = @"\Log\InOutRecords.INF";
        private const string general_extention_path = @"\Log\AllPackets.INF";
        private const string send_extention_path = @"\Log\SendPakets.INF";
        private const string receive_extention_path = @"\Log\ReceivedPackets.INF";

        private LogFileMode log_mode;

        private static int countReceivePackets = 0;
        private static int countSendPackets = 0; 

        public enum LogFileMode
        {
            None =1,
            LogSendPackets,
            LogReceivedPackets,
            LogSendAndReceivedPackets,
            LogInOutRecords,
            LogInOutRecordsAndAllPackets
        }

        public enum LogFileError
        {
            CanNotWriteLog = 1,
        }

        public LogPacket()
        {
            log_file_path = Environment.CurrentDirectory;
            log_mode = LogFileMode.None;
        }

        public LogPacket(string Path)
        {
            log_file_path = Path;
            log_mode = LogFileMode.None;
        }
        public LogPacket(string Path , LogFileMode Mode)
        {
            log_file_path = Path;
            log_mode = Mode;
        }
        public LogFileMode Mode
        {
            set
            {
                log_mode = value;
            }
            get
            {
                return log_mode;
            }
        }
    
        public string Path
        {
            set
            {
                log_file_path = value;
            }
            get
            {
                return log_file_path;
            }
        }

        public ErrorTable GetErrors()
        {                
            return errors;
        }
        
        private string return_appropriate_path()
        {
            if (Mode == LogFileMode.LogSendPackets)
                return log_file_path + send_extention_path;
            if (Mode == LogFileMode.LogReceivedPackets)
                return log_file_path + receive_extention_path;
            if (Mode == LogFileMode.LogSendAndReceivedPackets)
                return log_file_path + general_extention_path;
            if (Mode == LogFileMode.LogInOutRecords)
                return log_file_path + InOutRecords_extention_path;
            if (Mode == LogFileMode.LogInOutRecordsAndAllPackets)
                return log_file_path + InOutRecords_extention_path;
            else
                return string.Empty;
        }
        
        public void LogGeneralData(ArrayList Buffer ,string Index)
        {
            try
            {
                FileInfo File = new FileInfo(return_appropriate_path());
                DirectoryInfo Directory = File.Directory;
                if (!Directory.Exists)
                    Directory.Create();
                StreamWriter SW = File.AppendText();
                DateTime DT = DateTime.Now;
                SW.Write("{" + Index + "}");
                SW.WriteLine();
                SW.Write("[Instance]:");
                SW.WriteLine();
                SW.WriteLine(DT.ToString());
                SW.Write("[Values]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj);
                    SW.Write(" ");
                }
                SW.WriteLine();
                SW.Write("[String]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj.ToString());
                }
                SW.WriteLine();
                SW.WriteLine();
                SW.WriteLine();
                SW.Close();
            }
            catch
            {
                on_error_occur(LogFileError.CanNotWriteLog);
            }
        }

        public void LogSendPacket(ArrayList Buffer)
        {
            string extention_path_temp;
            countSendPackets++;
            try
            {
            if (Mode == LogFileMode.LogSendPackets || Mode == LogFileMode.LogSendAndReceivedPackets || Mode == LogFileMode.LogInOutRecordsAndAllPackets)
            {
                if (Mode == LogFileMode.LogInOutRecordsAndAllPackets)
                    extention_path_temp = log_file_path + send_extention_path;
                else
                    extention_path_temp = return_appropriate_path();
                FileInfo File = new FileInfo(extention_path_temp);
                DirectoryInfo Directory = File.Directory;
                if (!Directory.Exists)
                    Directory.Create();
                StreamWriter SW = File.AppendText();
                DateTime DT = DateTime.Now;
                if (Mode == LogFileMode.LogInOutRecordsAndAllPackets)
                {
                    SW.Write("s(" + countSendPackets.ToString() + ")"); 
                    SW.WriteLine();
                }
                SW.Write("{Send}");
                SW.WriteLine();
                SW.Write("[Instance]:");
                SW.WriteLine();
                SW.WriteLine(DT.ToString());
                SW.Write("[Values]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj);
                    SW.Write(" ");
                }
                SW.WriteLine();
                SW.Write("[String]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj.ToString());
                }
                SW.WriteLine();
                SW.WriteLine();
                SW.WriteLine();
                SW.Close();
            }
/*            if (Mode == LogFileMode.LogInOutRecords)
            {
                FileInfo File = new FileInfo(return_appropriate_path());
                DirectoryInfo Directory = File.Directory;
                if (!Directory.Exists)
                    Directory.Create();
                StreamWriter SW = File.AppendText();
                DateTime DT = DateTime.Now;
                SW.Write("{Send}");
                SW.WriteLine();
                SW.Write("[Instance]:");
                SW.WriteLine();
                SW.WriteLine(DT.ToString());
                SW.Write("[Values]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj);
                    SW.Write(" ");
                }
                SW.WriteLine();
                SW.Write("[String]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj.ToString());
                }
                SW.WriteLine();
                SW.WriteLine();
                SW.WriteLine();
                SW.Close();
            } */
            }
            catch
            {
                on_error_occur(LogFileError.CanNotWriteLog);
            }
        }
        public void LogReceivedPacket(ArrayList Buffer)
        {
            string extention_path_temp;
            countReceivePackets++;
            try
            {
            if (Mode == LogFileMode.LogReceivedPackets || Mode == LogFileMode.LogSendAndReceivedPackets || Mode == LogFileMode.LogInOutRecordsAndAllPackets)
            {
                if (Mode == LogFileMode.LogInOutRecordsAndAllPackets)
                    extention_path_temp = log_file_path + receive_extention_path;
                else
                    extention_path_temp = return_appropriate_path();

                FileInfo File = new FileInfo(extention_path_temp);
                DirectoryInfo Directory = File.Directory;
                if (!Directory.Exists)
                    Directory.Create();
                StreamWriter SW = File.AppendText();
                DateTime DT = DateTime.Now;
                if (Mode == LogFileMode.LogInOutRecordsAndAllPackets)
                {
                    SW.Write("r(" + countReceivePackets.ToString() + ")");
                    SW.WriteLine();
                }
                SW.Write("{Receive}");
                SW.WriteLine();
                SW.Write("[Instance]:");
                SW.WriteLine();
                SW.WriteLine(DT.ToString());
                SW.Write("[Values]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj);
                    SW.Write(" ");
                }
                SW.WriteLine();
                SW.Write("[String]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj.ToString());
                }
                SW.WriteLine();
                SW.WriteLine();
                SW.WriteLine();
                SW.Close();
            }
            if (Mode == LogFileMode.LogInOutRecords || Mode == LogFileMode.LogInOutRecordsAndAllPackets)
            {
                if (Mode == LogFileMode.LogInOutRecordsAndAllPackets)
                    extention_path_temp = log_file_path + InOutRecords_extention_path;
                else
                    extention_path_temp = return_appropriate_path();

                FileInfo File = new FileInfo(extention_path_temp);
                DirectoryInfo Directory = File.Directory;
                if (!Directory.Exists)
                    Directory.Create();
                StreamWriter SW = File.AppendText();
                DateTime DT = DateTime.Now;
/*                SW.Write("{Receive}");
                SW.WriteLine();
                SW.Write("[Instance]:");
                SW.WriteLine();
                SW.WriteLine(DT.ToString());
                SW.Write("[Values]:");
                SW.WriteLine(); */
                if (Buffer[0].ToString() == "2" && Buffer[3].ToString() == "90")
                {
                    for (int i = 0; i < (Convert.ToInt32(Buffer[1]) - 4)/11; i++)
                    {
                        string PersoneliCode = Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 12].ToString()),2);
                        PersoneliCode = PersoneliCode + Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 13].ToString()), 2);//PersoneliCode + Buffer[(i * 11) + 13].ToString();
                        PersoneliCode = PersoneliCode + Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 14].ToString()), 2); //PersoneliCode + Buffer[(i * 11) + 14].ToString();
                        PersoneliCode = PersoneliCode + Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 15].ToString()), 2); //PersoneliCode + Buffer[(i * 11) + 15].ToString();
                        string yyyy = "13" + Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 7].ToString()), 2);//Buffer[(i * 11) + 7].ToString();
                        string mm = Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 8].ToString()), 2); //Buffer[(i * 11) + 8].ToString();
                        string dd = Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 9].ToString()), 2); //Buffer[(i * 11) + 9].ToString();
                        string hh = Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 10].ToString()), 2); //Buffer[(i * 11) + 10].ToString();
                        string mi = Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 11].ToString()), 2); //Buffer[(i * 11) + 11].ToString();
                        string tt = Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 6].ToString()), 2); //Buffer[(i * 11) + 6].ToString();
                        string rr = Utility.ChangeToHex(Convert.ToUInt64(Buffer[(i * 11) + 5].ToString()), 2); //Buffer[(i * 11) + 5].ToString();

                        SW.Write(PersoneliCode + yyyy + "/" + mm + "/" + dd + hh + ":" + mi + tt + rr);
//                        if (i == (Convert.ToInt32(Buffer[1]) - 4) / 11 - 1)
//                            SW.Write(" (" + countReceivedPackets.ToString() + ")"); 
                        if (Mode == LogFileMode.LogInOutRecordsAndAllPackets)
                        {
                            SW.Write("  io(" + countReceivePackets.ToString() + ")");
                        }
                        if (i == (Convert.ToInt32(Buffer[1]) - 4) / 11 - 1)
                            SW.Write("  End " + ((Convert.ToInt32(Buffer[1]) - 4) / 11).ToString());
                        SW.WriteLine();
                    }
                }
               
/*                foreach (Object obj in Buffer)
                {
                    SW.Write(obj);
                    SW.Write(" ");
                }
                SW.WriteLine();
                SW.Write("[String]:");
                SW.WriteLine();
                foreach (Object obj in Buffer)
                {
                    SW.Write(obj.ToString());
                }
                SW.WriteLine();
                SW.WriteLine();
                SW.WriteLine();*/
                SW.Close();
            }

        }
        catch
        {
            on_error_occur(LogFileError.CanNotWriteLog);
        }
        }

        private void on_error_occur(LogFileError error)
        {
            Error temp = new Error(error);
            errors.Add(temp);
        }     
    }
}
