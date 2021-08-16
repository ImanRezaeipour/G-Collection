using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ConvertorDataFromOWCToNWC.DAL;

namespace ConvertorDataFromOWCToNWC
{
    
    public partial class frmMain : Form
    {
        
        public frmMain()
        {
            InitializeComponent();
            backgroundWorkerCreateTables.DoWork += new DoWorkEventHandler(CreateTables);
            backgroundWorkerConvertData.DoWork += new DoWorkEventHandler(ConvertData);
            
           
        }
        public Repository RepositoryObj
        {
            get
            {
                return new Repository();
            }
        }
        private void ShowLoadingPanel()
        {
            pbLoading.Visible = true;
            lblLoading.Visible = true;
        }
        private void HideLoadingPanel()
        {
            pbLoading.Visible = false;
            lblLoading.Visible = false;
        }
        private int GetNumberOfMonth(string monthName)
        {
            switch (monthName)
            {
                case "فروردین":
                    {
                        return 1;
                        
                    }
                case "اردیبهشت":
                    {
                        return 2;

                    }
                case "خرداد":
                    {
                        return 3;

                    }
                    case "تیر":
                    {
                        return 4;
                        
                    }
                    case "مرداد":
                    {
                        return 5;
                        
                    }
                    case "شهریور":
                    {
                        return 6;
                        
                    }
                    case "مهر":
                    {
                        return 7;
                        
                    }
                    case "آبان":
                    {
                        return 8;
                        
                    }
                    case "آذر":
                    {
                        return 9;
                        
                    }
                    case "دی":
                    {
                        return 10;
                        
                    }
                    case "بهمن":
                    {
                        return 11;

                    }
                    case "اسفند":
                    {
                        return 12;

                    }
                default:
                    return 0;
                    
            }
        }
        private void btnConnetDatabase_Click(object sender, EventArgs e)
        {
            try
            {
               
                if (RepositoryObj.ConnectToDatabase())
                {
                    gbCreateTable.Enabled = true;
                    gbConvertData.Enabled = true;
                    btnDisconnectDatabase.Enabled = true;
                    btnConnetDatabase.Enabled = false;
                    MessageBox.Show("ارتباط برقرار شد.", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message, "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
             
            }
            
        }
       
        private void btnDisconnectDatabase_Click(object sender, EventArgs e)
        {
            gbCreateTable.Enabled = false;
            btnConnetDatabase.Enabled = true;
            btnDisconnectDatabase.Enabled = false;
            gbConvertData.Enabled = false;
            btnDisconnectDatabase.Enabled = false;
        }
        void CreateTables(object sender, DoWorkEventArgs e)
        {
            try
            {
                switch (e.Argument.ToString())
                {
                    case "CreateT":
                        {
                            bool result = RepositoryObj.CreateTablesNewWebClock();
                            MessageBox.Show("جداول با موفقیت ایجاد شد.", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            break;
                        }
                    case "InsertData":
                        {
                            bool result = RepositoryObj.InsertDefaultDataNewWebClock();
                            MessageBox.Show("اطلاعات با موفقیت ایجاد شد.", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            break;
                        }
                    case "CreateF":
                        {
                            bool result = RepositoryObj.CreateFunctionsNewWebClock();
                            MessageBox.Show("توابع با موفقیت ایجاد شد.", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            break;
                        }
                    default:
                        break;
                }
           
            
            
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        void ConvertData(object sender, DoWorkEventArgs e)
        {
            try
            {

                int year = Convert.ToInt32((((object[])e.Argument)[0]).ToString() == "" ? 0 : ((object[])e.Argument)[0]);
                int month = Convert.ToInt32((((object[])e.Argument)[1]).ToString() == "" ? 0 : ((object[])e.Argument)[1]);
                bool resultLogin = true;
                bool resultWebPass = true;
                bool resultWebpassPersons = true;
                bool resultAgree = true;
                bool resultRequest=true;
                List<string> tableNameFailedConvertList = new List<string>();
                if(chbWebPass.Checked==true)
                {
                    resultLogin =RepositoryObj.ConvertDataFromTbl_WebPassToTbl_NW_Login();
                    if (resultLogin == false)
                        tableNameFailedConvertList.Add("WebPassLogin");
                    resultWebPass=RepositoryObj.ConvertDataFromTbl_WebPassToTbl_NW_WebPass();
                    if (resultWebPass == false)
                        tableNameFailedConvertList.Add("WebPass");

                }
                if(chbWebPassPersons.Checked==true)
                {
                    resultWebpassPersons=RepositoryObj.ConvertDataFromTbl_WebpassPersonsToTbl_NW_WebpassPersons();
                    if (resultWebpassPersons == false)
                        tableNameFailedConvertList.Add("WebPassPersons");
                }
                if(chbAgree.Checked==true)
                {
                    resultAgree=RepositoryObj.ConvertDataFromTbl_AgreeToTbl_NW_Agree();
                    if (resultAgree == false)
                        tableNameFailedConvertList.Add("Agree");
                }
                if(chbRequests.Checked==true)
                {
                    resultRequest = RepositoryObj.ConvertDataFromTbl_TCToTbl_NW_Requests(month, year);
                }

                if (tableNameFailedConvertList.Count == 0)
                    MessageBox.Show("اطلاعات با موفقیت انتقال یافت.", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
                else
                {
                    string tableName=string.Empty;
                    for (int i = 0; i < tableNameFailedConvertList.Count; i++)
			        {
                        if (i != tableNameFailedConvertList.Count - 1)
                            tableName += tableNameFailedConvertList[i] + ",";
                        else
                            tableName += tableNameFailedConvertList[i];
			        }
                       
                       
                    
                        string strTableName = string.Format("انتقال اطلاعات جداول {0} با مشکل مواجه شد.",tableName);
                    MessageBox.Show(strTableName, "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private void btnCreateTables_Click(object sender, EventArgs e)
        {
            try
            {
                ShowLoadingPanel();
                DisableAllPanels();
                backgroundWorkerCreateTables.RunWorkerAsync("CreateT");
                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Error);
                throw ex;
            }
            finally
            {
            
            }
           
        }

        private void backgroundWorkerCreateTables_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            HideLoadingPanel();
            EnablesAllPanels();
        }
        private void DisableAllPanels()
        {
            gbConvertData.Enabled = false;
            gbCreateTable.Enabled = false;
            gbConnectToDatabase.Enabled = false;
        }
        private void EnablesAllPanels()
        {
            gbConvertData.Enabled = true; ;
            gbCreateTable.Enabled = true; ;
            gbConnectToDatabase.Enabled = true;
        }
        
        private void btnConvertData_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("کلیه اطلاعات جداول انتخاب شده حذف می شود .آیا ادامه می دهید ؟", "پیغام", MessageBoxButtons.YesNo, MessageBoxIcon.Asterisk) == System.Windows.Forms.DialogResult.Yes)
                {
                    if (chbWebPass.Checked == false && chbWebPassPersons.Checked == false && chbRequests.Checked == false && chbAgree.Checked == false)
                    {
                        MessageBox.Show("لطفا یک جدول را انتخاب نمایید", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                    if (chbRequests.Checked == true && (cbMonth.SelectedIndex < 0 || cbYear.SelectedIndex < 0))
                    {
                        MessageBox.Show("لطفا ماه و سال را انتخاب نمایید", "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    ShowLoadingPanel();
                    DisableAllPanels();
                    object param1;
                    object param2 ;
                    if(chbRequests.Checked==true)
                    {
                    param1 = (object)cbYear.SelectedItem;
                    param2 = (object)GetNumberOfMonth(cbMonth.SelectedItem.ToString());
                    }
                    else
                        {
                        param1="";
                        param2 = "";
                        }
                    object[] paramss = new object[2];
                    paramss[0] = param1;
                    paramss[1] = param2;
                    backgroundWorkerConvertData.RunWorkerAsync(paramss);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void frmMain_Load(object sender, EventArgs e)
        {

        }

        private void backgroundWorkerConvertData_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            HideLoadingPanel();
            EnablesAllPanels();
        }

        private void chbRequests_CheckedChanged(object sender, EventArgs e)
        {
            lblRequestConditions.Enabled = chbRequests.Checked;
            lblRequestCondition2.Enabled = chbRequests.Checked;
            cbYear.Enabled = chbRequests.Checked;
            cbMonth.Enabled = chbRequests.Checked;

            if(chbRequests.Checked==true)
            {
                chbWebPass.Checked=true;
                chbWebPassPersons.Checked = true;
                chbAgree.Checked = true;
            }

        }

        private void chbAgree_CheckedChanged(object sender, EventArgs e)
        {
            if (chbAgree.Checked == true)
            {
                chbWebPass.Checked = true;
                
                
            }
        }

        private void chbWebPassPersons_CheckedChanged(object sender, EventArgs e)
        {
            if (chbWebPassPersons.Checked == true)
            {
                chbWebPass.Checked = true;
                

            }
        }

        private void chbWebPass_CheckedChanged(object sender, EventArgs e)
        {
            if (chbWebPass.Checked == false)
            {
                chbRequests.Checked = false;
                chbWebPassPersons.Checked = false;
                chbAgree.Checked = false;
            }
        }

        private void btnInsertDefaultData_Click(object sender, EventArgs e)
        {
            try
            {
                ShowLoadingPanel();
                DisableAllPanels();
                backgroundWorkerCreateTables.RunWorkerAsync("InsertData");

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Error);
                throw ex;
            }
            finally
            {

            }
        }

        private void btnCreateFunctions_Click(object sender, EventArgs e)
        {
            try
            {
                ShowLoadingPanel();
                DisableAllPanels();
                backgroundWorkerCreateTables.RunWorkerAsync("CreateF");

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "پیغام", MessageBoxButtons.OK, MessageBoxIcon.Error);
                throw ex;
            }
            finally
            {

            }
        }

       
    }
}
