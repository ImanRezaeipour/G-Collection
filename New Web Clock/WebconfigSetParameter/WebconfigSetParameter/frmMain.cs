using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Configuration;
using System.ServiceProcess;

namespace WebconfigSetParameter
{
    public partial class frmMain : Form
    {

        public frmMain()
        {
            InitializeComponent();
        }







        private void btnTestCnn_Click_1(object sender, EventArgs e)
        {
            try
            {
                string serverName = txtServerName.Text.Trim();
                string databaseName = txtDatabaseName.Text.Trim();
                string userName = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();
                string connString = "Data Source=" + serverName + ";Initial Catalog=" + databaseName + ";User ID=" + userName + ";Password=" + password;
                SqlConnection cnn = new SqlConnection(connString);
                cnn.Open();
                cnn.Close();
                MessageBox.Show("ارتباط با موفقیت برقرار شد.", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("خطا در ارتباط. " + ex.Message, "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
        }

        private void btnSaveCnn_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtCCAddress.Text == "")
                {
                    MessageBox.Show("لطفا آدرس فایل CC را مشخص نمایید. " , "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return;
                }

                string serverName = txtServerName.Text.Trim();
                string databaseName = txtDatabaseName.Text.Trim();
                string userName = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();
                //****************

                //*****************
                string connString = "Data Source=" + serverName + ";Initial Catalog=" + databaseName + ";User ID=" + userName + ";Password=" + password;
                string webConfigAddressApplication = AppDomain.CurrentDomain.BaseDirectory + "web.Config";
                string webConfigAddressCCService = AppDomain.CurrentDomain.BaseDirectory + @"\CCService\CCWindowsService.exe.config";
                string ccConfigAddress = @"C:\cs.txt";
                System.IO.File.WriteAllText(ccConfigAddress, "Provider=SQLOLEDB.1;Persist Security Info=True;Initial Catalog=" + databaseName + ";Data Source=" + serverName + ";user ID=" + userName + ";password=" + password);
                
                
                XmlDocument xmlDocApplication = new XmlDocument();
                xmlDocApplication.Load(webConfigAddressApplication);
                xmlDocApplication.SelectSingleNode("configuration/connectionStrings/add").Attributes["connectionString"].Value = connString;
                //*****************
                string ccUseService = chbCCService.Checked.ToString();
                string threatCount = txtThreatCount.Text;
                string ccAddress =txtCCAddress.Text;
                 
                foreach (XmlNode item in xmlDocApplication.SelectSingleNode("configuration/appSettings"))
                {
                    switch (item.Attributes["key"].Value)
                    {
                        case "UseCCService":
                            {
                                item.Attributes["value"].Value = ccUseService;
                                break;
                            }
                        case "ThreadCount":
                            {
                                item.Attributes["value"].Value = threatCount;
                                break;
                            }
                        case "CCFilePath":
                            {
                                item.Attributes["value"].Value = ccAddress;
                                break;
                            }

                        default:
                            break;
                    }

                }

                xmlDocApplication.Save(webConfigAddressApplication);


                XmlDocument xmlDocCCService = new XmlDocument();
                xmlDocCCService.Load(webConfigAddressCCService);
                xmlDocCCService.SelectSingleNode("configuration/connectionStrings/add").Attributes["connectionString"].Value = connString;
                foreach (XmlNode item in xmlDocCCService.SelectSingleNode("configuration/appSettings"))
                {
                    switch (item.Attributes["key"].Value)
                    {

                        case "ThreadCount":
                            {
                                item.Attributes["value"].Value = threatCount;
                                break;
                            }
                        case "CCFilePath":
                            {
                                item.Attributes["value"].Value = ccAddress;
                                break;
                            }

                        default:
                            break;
                    }

                }
                xmlDocCCService.Save(webConfigAddressCCService);
                ServiceController sc = new ServiceController();
                sc.ServiceName = "CCService";
                sc.Stop();
                sc.WaitForStatus(ServiceControllerStatus.Stopped);
                sc.Start();
                sc.WaitForStatus(ServiceControllerStatus.Running);
                MessageBox.Show("اطلاعات با موفقیت ثبت شد.", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.Close();

                
            }
            catch (Exception ex)
            {

                MessageBox.Show("خطا در ثبت اطلاعات.لطفا بعدا سعی نمایید. " + ex.Message, "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            try
            {


                string webConfigAddressApplication = AppDomain.CurrentDomain.BaseDirectory + "web.Config";
                XmlDocument xmlDocApplication = new XmlDocument();
                xmlDocApplication.Load(webConfigAddressApplication);
                foreach (XmlNode item in xmlDocApplication.SelectSingleNode("configuration/appSettings"))
                {
                    switch (item.Attributes["key"].Value)
                    {
                        case "UseCCService":
                            {
                                chbCCService.Checked = Convert.ToBoolean(item.Attributes["value"].Value);
                                break;
                            }
                        case "ThreadCount":
                            {
                                txtThreatCount.Text = item.Attributes["value"].Value;
                                break;
                            }
                        case "CCFilePath":
                            {
                                //txtCCAddress.Text = item.Attributes["value"].Value;
                                break;
                            }

                        default:
                            break;
                    }

                }
            }
            catch (Exception ex)
            {

              
            }
            txtServerName.Focus();

        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnSelectCC_Click(object sender, EventArgs e)
        {
            if (ofd1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                txtCCAddress.Text = ofd1.FileName;
            }
        }


    }
}
