using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Security.Cryptography;

namespace Ghadir_UI
{
    public partial class DB : Form
    {
        public DB()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

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
                    System.Text.Encoding encoding = System.Text.Encoding.UTF8;return encoding.GetString(ms.ToArray()); 
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

        private void button1_Click(object sender, EventArgs e)
        {
            string machineName = System.Environment.MachineName;
            if (machineName.Length > 50)
                machineName = machineName.Substring(0, 50);
            File.Delete(Constant.DBConfigFilePath);
            File.AppendAllText(Constant.DBConfigFilePath, "");
            StreamWriter sw = File.AppendText(Constant.DBConfigFilePath);
            sw.WriteLine("Server Name:");
            sw.WriteLine(txtServerName.Text.Trim());
            sw.WriteLine("Database Name:");
            sw.WriteLine(txtDBName.Text.Trim());
            sw.WriteLine("User Name:");
            sw.WriteLine(txtUser.Text.Trim());
            sw.WriteLine("Password:");
            Encryption64 oEs = new Encryption64();
            string txtPassText;
            txtPassText = oEs.Encrypt(txtPass.Text.Trim(), Constant.encryptKey);
            sw.WriteLine(txtPassText);
            sw.WriteLine("timerInterval:");
            if (txtInterval.Text == "")
                txtInterval.Text = "5";
            sw.WriteLine(Convert.ToString(Convert.ToInt32(txtInterval.Text.Trim()) * 1000));
            sw.WriteLine("GS_MachineName:");
            sw.WriteLine(machineName);
            sw.Close();
//            Startup.update_device_detail_list_FromDB;
//            Startup.update_data_grid_view();
//            Startup test = new Startup();
//            test.update_device_detail_list();
//            test.update_data_grid_view();
//            Startup.update_data_grid_view();
            this.Close();
        }

        private void DB_Load(object sender, EventArgs e)
        {
            if (!Directory.Exists(Constant.ConfigFileDirectory))
                Directory.CreateDirectory(Constant.ConfigFileDirectory);

            if (!File.Exists(Constant.DBConfigFilePath))
                return;
            string[] detail = File.ReadAllLines(Constant.DBConfigFilePath);

            for (int t = 0; t < detail.Length; t++)
            {
                if (detail[t].Equals("Server Name:"))
                    txtServerName.Text = detail[t+1].ToString();
                if (detail[t].Equals("Database Name:"))
                    txtDBName.Text = detail[t + 1].ToString();
                if (detail[t].Equals("User Name:"))
                    txtUser.Text = detail[t + 1].ToString();
                if (detail[t].Equals("Password:"))
                {
                    Encryption64 oEs = new Encryption64();
                    string txtPassText;
                    txtPassText = oEs.Decrypt(detail[t + 1].ToString(), Constant.encryptKey);
                    txtPass.Text = txtPassText;
                }
                if (detail[t].Equals("timerInterval:"))
                {
                    txtInterval.Text = Convert.ToString(Convert.ToInt32(detail[t + 1].ToString()) / 1000);
                    if (txtInterval.Text == "")
                        txtInterval.Text = "5";
                }
            
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();            
        }
    }
}
