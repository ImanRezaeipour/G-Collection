using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Ghadir_UI
{
    public partial class Collection : Form
    {
        CollectedRecords all_records = new CollectedRecords();
           
        private enum complicat_jobs
        {
            none,
            collection_alla_record,
            recovery_all_record
        };
        private complicat_jobs complicate_job;
        public delegate void add_to_list_view(string TerminalAddress, string Status, string Date, string time, string CardNumber);

        public add_to_list_view AddToViewList;   

      
        public Collection()
        {
            InitializeComponent();
            AddToViewList = new add_to_list_view(add_to_list);
   
            list_view_collection.LargeImageList = list_view_collection.SmallImageList = view_list_images;

        }
        private void add_to_list(string TerminalAddress,string Status,string Date,string time,string CardNumber)
        {
            OneRecord new_record = new OneRecord();
            if ( CardNumber == "0")
            {
                ListViewItem temp1 = new ListViewItem("No Record");
                temp1.ImageIndex = 1;
                list_view_collection.Items.Add(temp1);
                complicate_job = complicat_jobs.none;
                return;
            }
            ListViewItem temp2 = new ListViewItem(CardNumber);
          
          

            temp2.SubItems.Add(TerminalAddress);
            temp2.SubItems.Add(Status);
            temp2.SubItems.Add(Date);
            temp2.SubItems.Add(time);
            temp2.ImageIndex = 0;
            new_record.CardNumber = CardNumber;
            new_record.CardStstus = Status;
            new_record.Date = Date;
            new_record.TerminalAddress = TerminalAddress;
            new_record.Time = time;
            all_records.AddRecord(new_record);
            temp2.SubItems.Add(((int)(list_view_collection.Items.Count+1)).ToString());

            list_view_collection.Items.Add(temp2);
        
        }

              private void Collection_FormClosing(object sender, FormClosingEventArgs e)
        {
            e.Cancel = true;
                
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            list_view_collection.View = View.LargeIcon;
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            list_view_collection.View = View.SmallIcon;
        }

        private void toolStripMenuItem3_Click(object sender, EventArgs e)
        {
            list_view_collection.View = View.Details;
        }

        private void toolStripMenuItem4_Click(object sender, EventArgs e)
        {
            list_view_collection.View = View.List;
        }

        private void tileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            list_view_collection.View = View.Tile;
        }

        private void list_view_collection_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            list_view_collection.Items.Clear();
        }

        

        private void newToolStripButton_Click(object sender, EventArgs e)
        {
            list_view_collection.Items.Clear();
            all_records.Clear();
        }

        private void button4_Click_1(object sender, EventArgs e)
        {
            complicate_job = complicat_jobs.collection_alla_record;
            //form1.Device.Collection();
        }
        public void MediaNotRespond()
        {
            complicate_job = complicat_jobs.none;

        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            if (complicate_job != complicat_jobs.none)
            {
                MessageBox.Show("Complicated Job Is Working. Please First Stop Job");
                return;
            }
            if (common_save_dialog.ShowDialog() == DialogResult.OK)
            {
                all_records.XMLFilePath = common_save_dialog.FileName;              
                all_records.MakeXMLFile();
            }         

        }

       

        private void saveToolStripButton_Click(object sender, EventArgs e)
        {
            if (common_save_dialog.ShowDialog() == DialogResult.OK)
            {
                all_records.TXTFilePath = common_save_dialog.FileName;
                all_records.MakeTXTFile();
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
           /* if (Utility.IsDateString(recovery_date.Text))
            {
                DateTime r = new DateTime(1,1,1);
                r = r.AddYears(Convert.ToInt32(recovery_date.Text.Substring(0, 2)) - 1);
                r = r.AddMonths(Convert.ToInt32(recovery_date.Text.Substring(3, 2))-1);
                r = r.AddDays(Convert.ToInt32(recovery_date.Text.Substring(6, 2))-1);
               // form1.Device.Recovery(r);
            }
            else 
                MessageBox.Show("Enter Valid Date");*/
        }

        private void button5_Click(object sender, EventArgs e)
        {
           /* if (Utility.IsDateString(recovery_date.Text))
            {
                DateTime r = new DateTime(1, 1, 1);
                r = r.AddYears(Convert.ToInt32(recovery_date.Text.Substring(0, 2)) - 1);
                r = r.AddMonths(Convert.ToInt32(recovery_date.Text.Substring(3, 2)) - 1);
                r = r.AddDays(Convert.ToInt32(recovery_date.Text.Substring(6, 2)) - 1);
               // form1.Device.PermanentRecovery(r);
            }
            else
                MessageBox.Show("Enter Valid Date");*/
        }
        
    }
}