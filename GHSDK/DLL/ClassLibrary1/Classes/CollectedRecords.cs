using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Xml.Serialization;
using System.IO;
using System.Windows.Forms;

namespace Ghadir_UI
{
    public class CollectedRecords
    {
        private  OneRecord[] records =new OneRecord[0];

        private string file_path_xml = Environment.CurrentDirectory.ToString() + "\\Records.XML";
        private string file_path_txt = Environment.CurrentDirectory.ToString() + "\\Records.TXT";
       
        
        [XmlIgnore]
        public string XMLFilePath
        {
            get
            {
                return file_path_xml;
            }
            set
            {
                file_path_xml = value;
            }
        }

        [XmlIgnore]
        public string TXTFilePath
        {
            get
            {
                return file_path_txt;
            }
            set
            {
                file_path_txt = value;
            }
        }

        [XmlIgnore]
        public int Count
        {
            get
            {
                return records.Length;
            }
        }


        public void AddRecord(OneRecord Record)
        {
            Array.Resize(ref records, records.Length + 1);
            records[records.Length - 1] = Record;
        }

        public void AddRecord(string TerminalAress,string CardStatus, string Date,string Time , string CardNumber)
        {
            OneRecord temp = new OneRecord();
            temp.CardNumber = CardNumber;
            temp.CardStstus = CardStatus;
            temp.Date = Date;
            temp.Time = Time;
            temp.TerminalAddress = TerminalAress;

            Array.Resize(ref records, records.Length + 1);
            records[records.Length - 1] = temp;
        }
        public OneRecord[] Records
        {
            get
            {
                if (records.Length > 0)
                {
                    OneRecord[] temp = new OneRecord[records.Length];
                    temp = (OneRecord[])records.Clone();
                    return temp;
                }
                else
                    return new OneRecord[0];
            }

            set
            {

            }
        }

        public OneRecord GetSpecialRecord(int index)
        {
            if (index <records.Length)
            {
                OneRecord temp = new OneRecord();
                temp = records[index];
                return temp;
            }
            else 
                return new OneRecord();
        }

        public int GetRecordQuantity()
        {
            if (records.Length>0)
                return records.Length;
            else 
                return 0;
            

        }


        public Boolean MakeXMLFile()
        {

            try
            {
                FileStream fs = new FileStream(file_path_xml, FileMode.Create);
                XmlSerializer xml_ser = new XmlSerializer(this.GetType());
                xml_ser.Serialize(fs, this);
                fs.Close();
                return true;

            }
            catch
            {
                return false;
            }
        }

        public Boolean MakeTXTFile()
        {

            string[] temp = new string[records.Length * 7];
            int count = 0;

            try
            {
                foreach (OneRecord t in records)
                {
                    temp[count++] = "Record [" + (count / 7 + 1).ToString() + "]";
                    temp[count++] = t.TerminalAddress;
                    temp[count++] = t.CardStstus;
                    temp[count++] = t.Date;
                    temp[count++] = t.Time;
                    temp[count++] = t.CardNumber;
                    temp[count++] = string.Empty;
                }
                File.WriteAllLines(file_path_txt, temp);
                return true;
            }
            catch
            {
                return false;
            }

        }

        public Boolean AppendToTXTFile()
        {

            try
            {
                StreamWriter ss = File.AppendText(file_path_txt);
                foreach (OneRecord t in records)
                {
                    ss.WriteLine("Record [New]");
                    ss.WriteLine(t.TerminalAddress);
                    ss.WriteLine(t.CardStstus);
                    ss.WriteLine(t.Date);
                    ss.WriteLine(t.Time);
                    ss.WriteLine(t.CardNumber);
                    ss.WriteLine(string.Empty);
                }
                ss.Flush();
                ss.Close();
                return true;

            }
            catch
            {
                return false;
            }
        }
        
        public void Clear()
        {
            Array.Resize(ref records, 0);
        }


        

    }
}
