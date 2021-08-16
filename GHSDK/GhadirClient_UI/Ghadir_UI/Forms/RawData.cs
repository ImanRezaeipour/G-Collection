using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using System.IO;

namespace Ghadir_UI
{
    public partial class RawData : Form
    {
        public delegate void add_to_list(ArrayList RawDate,PaketType Type);
     
        public add_to_list AddToRawDataList;

        public enum PaketType
        {
            SentPacket,
            ReceivedPacket
        }

        public RawData()
        {
            InitializeComponent();
            AddToRawDataList = new add_to_list(AddToList);
        }

        private void RawData_FormClosing(object sender, FormClosingEventArgs e)
        {
                e.Cancel = true;              
        }

        private void RawData_Load(object sender, EventArgs e)
        {  
            

        }

        public void AddToList(ArrayList RawData,PaketType Type)
        {
            string temp1 = string.Empty;
            string temp2 = string.Empty;
            Char temp3;
            DateTime time = DateTime.Now;


           foreach (Object temp in RawData)
            {
                temp3 = Convert.ToChar(temp);
                if (Char.IsDigit(temp3) || Char.IsLetter(temp3) || Char.IsPunctuation(temp3) || Char.IsWhiteSpace(temp3))
                    temp1 += temp3;
                else
                    temp1 += "-";
                temp2 += Convert.ToByte(temp).ToString() + " ";
            }
            raw_data.Items.Add("[" + Type.ToString() + "]  "+time.ToString());
            raw_data.Items.Add(temp1);
            raw_data.Items.Add(temp2);
            raw_data.Items.Add(string.Empty);
        }

        private void newToolStripButton_Click(object sender, EventArgs e)
        {
            raw_data.Items.Clear();
        }

        private void saveToolStripButton_Click(object sender, EventArgs e)
        {
            if (save_raw_data_dialog.ShowDialog() == DialogResult.OK)
            {
                /*string[] temp = new string[raw_data.Items.Count];
                for (int t = 0; t < raw_data.Items.Count; t++)
                    temp[t] = raw_data.Items[t].ToString();

                File.WriteAllLines(save_raw_data_dialog.FileName, temp); */
            }

        }
        public void MediaNotRespond()
        {

        }
       

       

        


        
    }
}