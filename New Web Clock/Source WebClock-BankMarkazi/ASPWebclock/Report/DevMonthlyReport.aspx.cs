using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.Data;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxCallbackPanel;
using DevExpress.Web.ASPxRoundPanel;
using System.Drawing;
using System.Collections;
using System.Text;
using System.Globalization;
using ASPWebClock.Infrastructure.Business;
using System.Diagnostics;
using System.Web.UI.HtmlControls;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Business;
using ASPWebclock.AppCode;
using System.Web.Configuration;
using System.ServiceModel;
using ASPWebClock.Infrastructure.Utility;
using ASPWebClock.Infrastructure.Repository;



namespace ASPWebclock
{
    public partial class DevMonthlyReport : System.Web.UI.Page
    {
        
        public BRequest requestBussines
        {
            get
            {
                return new BRequest();
            }
        }
        public BWebpassUser userBussines
        {
            get
            {
                return new BWebpassUser();
                
            }
        }
        public BRole roleBusiness
        {
            get
            {
                return new BRole();
            }
        }
       
        
        private class RequestStat
        {
            
            public string date_ { get; set; }
            public Int32 stat { get; set; }
        }
        List<RequestStat> lrs = new List<RequestStat>();

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionHandler.CheckSessionTimeOut(this.Page);
            RefererValidation.CheckReferer();


            if (!Page.IsPostBack)
            {
                string barcodeCurrentUser = new WebpassUserRepository().GetBarcodeByUserName(this.User.Identity.Name);
                FillYearMonthDate(DateTime.Today);
                Session["pcode"] = barcodeCurrentUser;
                FillUnderManagmentPersonnel(Convert.ToDecimal(Session["PostID"]));
                FillPishCard(barcodeCurrentUser, "isDaily='False'");
            }

            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).IsCallback)
                FillUnderManagmentPersonnel(Convert.ToDecimal(Session["PostID"].ToString()));

            ValidateAccessControls();




            //---------------------------------------
        }
        private void ValidateAccessControls()
        {
            try
            {


                int userStatus = userBussines.GetUserStatusBywebPassId(Convert.ToDecimal(Session["PostID"]));
                PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), userStatus.ToString());
                DataTable dtResult = roleBusiness.GetAccessRoleNavbarByUserRoleName(US.ToString());
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {


                    if (dtResult.Rows[i]["navbar_Name"].ToString() == "AccessActionGridMonthly_DevMonthlyReport")
                    {
                        ASPxGridViewReportMonthly.SettingsDetail.ShowDetailRow = true;
                    }

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private void FillPishCard(string barcode, string sqlCommandCondition)
        {
            try
            {


                
                SqlDataSource3.SelectCommand = @"select pish_code, case when isnull(Pish_LastName,'')<>'' then Pish_LastName else Pish_Name end  PishName
                                        ,isDaily from pishcard where " + sqlCommandCondition +
                                             @" and Pish_Code<>99 and Pish_activeWeb='True' and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode='" + barcode + "') ";

                SqlDataSource3.Select(DataSourceSelectArguments.Empty);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private void FillYearMonthDate(DateTime dateSelected)
        {

            ASPxComboBoxYear.Value = Utility.MiladiToShamsiDate(dateSelected).Substring(0, 4);
            ASPxComboBoxMonth.Value = Utility.MiladiToShamsiDate(dateSelected).Substring(5, 2);
        }
        private void FillAspxGridView2(string selectedBarcode, string selectedDate)
        {
            try
            {


                SqlDataSource2.SelectCommand = @"SELECT Clock_Date as prc_date
                                          ,Clock_SendDate
                                          ,dbo.MToH(Clock_Time) Clock_Time
                                          ,dbo.MToH(Clock_eTime) Clock_eTime
                                          ,dbo.pish_lastname(Clock_User,Clock_RecState) pish_name
                                          ,convert(nvarchar(10), Clock_FirstlyAgree) + convert(nvarchar(10), Clock_SeconderyAgree) + convert(nvarchar(10),Clock_FinallyAgree) as agree
                                          ,Clock_RecDes,ID_PK,Clock_User
                                        FROM NW_Requests where Clock_date='" + selectedDate + "'  and clock_User='" + selectedBarcode + "'";
                SqlDataSource2.Select(DataSourceSelectArguments.Empty);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        private void FillGridViewRepotMonthlyByUser(string barcode, string year,string month)
        {
            try
            {

                Session["lrs"] = null;
                Session["pcode"] = barcode;
                DataTable dtResultReportMonthly = new BPerson().GetReportMonthlyPerson(barcode, year, month);
                ASPxGridViewReportMonthly.DataSource = dtResultReportMonthly;
                ASPxGridViewReportMonthly.DataBind();
                
                bool resultExistTable = new BValidations().checkExistTableP(year, month);
                if (resultExistTable == true)
                {
                    SqlCommand cmd = new SqlCommand("select  distinct(tc.clock_date) clock_date,agree from NW_Requests tc,(" +
                          "select clock_date, case when agreemax=2 then 2 else agreemin  end agree from" +
                          "(select Clock_Date,MAX(agree__) agreemax,MIN(agree__) agreemin from " +
                          "(select clock_date,case when Clock_FirstlyAgree=2 then 2 else Clock_FinallyAgree  end agree__ from NW_Requests where clock_User='" + barcode + "') l1 group by Clock_Date) l3" +
                          ") l5 where clock_User='" + barcode + "' and l5.Clock_Date=tc.Clock_Date");
                    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString());
                    cmd.Connection = con;
                    con.Open();
                    //---------------------------------------------------------------
                    ASPxGridViewReportMonthly.Columns[04].Visible = true;
                    ASPxGridViewReportMonthly.Columns[05].Visible = true;
                    ASPxGridViewReportMonthly.Columns[06].Visible = true;
                    ASPxGridViewReportMonthly.Columns[07].Visible = true;
                    ASPxGridViewReportMonthly.Columns[08].Visible = true;
                    ASPxGridViewReportMonthly.Columns[09].Visible = true;
                    ASPxGridViewReportMonthly.Columns[10].Visible = true;
                    ASPxGridViewReportMonthly.Columns[11].Visible = true;
                    //---------------------------------------------------------------
                    string startDate = year + "/" + month + "/01";
                    string endDate = year + "/" + month + "/31";
                    if (dtResultReportMonthly.Rows.Count > 0)
                    {
                        if (dtResultReportMonthly.Rows[0]["Prc_SecondIn"].ToString() == "2I") ASPxGridViewReportMonthly.Columns[04].Visible = false;
                        if (dtResultReportMonthly.Rows[0]["Prc_SecondOut"].ToString() == "2O") ASPxGridViewReportMonthly.Columns[05].Visible = false;

                        if (dtResultReportMonthly.Rows[0]["Prc_ThirdIn"].ToString() == "3I") ASPxGridViewReportMonthly.Columns[06].Visible = false;
                        if (dtResultReportMonthly.Rows[0]["Prc_ThirdOut"].ToString() == "3O") ASPxGridViewReportMonthly.Columns[07].Visible = false;

                        if (dtResultReportMonthly.Rows[0]["Prc_FourthIn"].ToString() == "4I") ASPxGridViewReportMonthly.Columns[08].Visible = false;
                        if (dtResultReportMonthly.Rows[0]["Prc_FourthOut"].ToString() == "4O") ASPxGridViewReportMonthly.Columns[09].Visible = false;

                        if (dtResultReportMonthly.Rows[0]["Prc_FifthIn"].ToString() == "5I") ASPxGridViewReportMonthly.Columns[10].Visible = false;
                        if (dtResultReportMonthly.Rows[0]["Prc_FifthOut"].ToString() == "5O") ASPxGridViewReportMonthly.Columns[11].Visible = false;


                        //---------------------------------------
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                RequestStat requestStat = new RequestStat();
                                requestStat.date_ = rdr["clock_date"] as string;
                                requestStat.stat = Convert.ToInt32(rdr["agree"]);
                                lrs.Add(requestStat);
                            }
                        }
                    }
                    else
                    {
                        ASPxGridViewReportMonthly.SettingsText.EmptyDataRow = "هیچ آیتمی یافت نشد";
                    }
                    if (con.State == ConnectionState.Open)
                        con.Close();
                    Session["lrs"] = lrs;
                }
                ASPxGridViewReportMonthly.ExpandAll();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        private void FillUnderManagmentPersonnel(decimal webPassID)
        {
            try
            {


                ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).DataSource = new BPerson().GetUnderManagmentPersonnelAndCurrentUser(webPassID, (IList<decimal>)Session["ListPostIDInsteadMan"]);
                ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).DataBind();

                int rowSelected = ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).FindVisibleIndexByKeyValue(Session["pcode"].ToString());
                ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).FocusedRowIndex = rowSelected;
                object row = ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).GetRow(rowSelected);
                ASPxLabelBarcode.Text = ((Person)row).Barcode.ToString();
                ASPxLabelName.Text = ((Person)row).Name.ToString();
                ASPxLabelFamily.Text = ((Person)row).Family.ToString();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        




        protected void ASPxGridViewReportMonthly_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs e)
        {

            if (e.GetValue("PishCardFullName") != null)
            {
                string holiday = e.GetValue("PishCardFullName").ToString();
                if (holiday == "تعطيل رسمي")
                {

                    e.Row.ForeColor = System.Drawing.Color.Red;
                }
            }
            if (e.VisibleIndex == ASPxGridViewReportMonthly.VisibleRowCount - 1)
            {
                e.Row.ForeColor = System.Drawing.Color.Purple;
                e.Row.Font.Bold = true;
                e.Row.Font.Size = new FontUnit(10); ;

            }
            if (Session["lrs"] != null)
            {
                lrs = (List<RequestStat>)Session["lrs"];
               // Session["lrs"] = null;
                if (e.KeyValue != null)
                {
                    if (lrs.Exists(c => c.date_ == e.KeyValue.ToString()))
                    {
                        int ss = (from item in lrs where item.date_ == e.KeyValue.ToString() select item.stat).First();
                        switch (ss)
                        {
                            case 0:
                                e.Row.BackColor = ColorTranslator.FromHtml("#8CA9FF");
                                break;
                            case 1:
                                e.Row.BackColor = ColorTranslator.FromHtml("#9DFF9D");
                                break;
                            case 2:
                                e.Row.BackColor = ColorTranslator.FromHtml("#FFFF6C");

                                break;
                        }
                    }
                }
            }


        }

        protected void ASPxGridViewReportMonthly_DetailRowGetButtonVisibility(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewDetailRowButtonEventArgs e)
        {

            object rowValue = ASPxGridViewReportMonthly.GetRowValuesByKeyValue(e.KeyValue, new string[] { "FARSI_WEEK_DAY" });


            if (rowValue.ToString().Contains("ماه"))
            {
                e.ButtonState = GridViewDetailRowButtonState.Hidden;
            }


        }

        protected void ASPxGridView2_BeforePerformDataSelect(object sender, EventArgs e)
        {
            try
            {


                string selectedBarcode = ((ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).GetRowValues(((ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).FocusedRowIndex, "Barcode").ToString();
                string selectedDate = Convert.ToString((sender as ASPxGridView).GetMasterRowFieldValues("prc_date"));
                FillAspxGridView2(selectedBarcode, selectedDate);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        protected void ASPxGridView2_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            int agreestat = Convert.ToInt32(e.GetValue("agree"));
            switch (agreestat)
            {
                case 0:
                    e.Row.BackColor = ColorTranslator.FromHtml("#8CA9FF");
                    break;
                case 1:
                    e.Row.BackColor = ColorTranslator.FromHtml("#9DFF9D");
                    break;
                case 2:
                    e.Row.BackColor = ColorTranslator.FromHtml("#FFFF6C");
                    break;
            }


        }

        protected void ASPxGridView2_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.DataColumn.FieldName == "agree")
            {
                int firstAgree = Convert.ToInt32(e.CellValue.ToString().Substring(0, 1));
                int secondAgree = Convert.ToInt32(e.CellValue.ToString().Substring(1, 1));
                int finalAgree = Convert.ToInt32(e.CellValue.ToString().Substring(2, 1));
                switch (firstAgree)
                {
                    case 0:
                        e.Cell.Text = "مشاهده نشده";
                        break;
                    case 1:

                        switch (secondAgree)
                        {
                            case 0:
                                e.Cell.Text = "تایید اولیه";
                                break;
                            case 1:
                                switch (finalAgree)
                                {
                                    case 0:
                                        e.Cell.Text = "تایید ثانویه";
                                        break;
                                    case 1:
                                        e.Cell.Text = "تایید نهایی";
                                        break;
                                    case 2:
                                        e.Cell.Text = "عدم تایید نهایی";
                                        break;
                                    default:
                                        break;
                                }

                                break;
                            case 2:
                                e.Cell.Text = "عدم تایید ثانویه";
                                break;
                            default:
                                break;
                        }
                        break;
                    case 2:
                        e.Cell.Text = "عدم تایید اولیه";
                        break;
                }
            }

        }



        protected void ASPxCallbackPanel1_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            ASPxCallbackPanel cbp = sender as ASPxCallbackPanel;
            switch (e.Parameter)
            {
                case "1":
                    {
                        ((DevExpress.Web.ASPxRoundPanel.ASPxRoundPanel)cbp.FindControl("ASPxRoundPanelHourly")).Visible = true;
                        ((DevExpress.Web.ASPxRoundPanel.ASPxRoundPanel)cbp.FindControl("ASPxRoundPanelValue")).Visible = false;
                        FillPishCard(Session["pcode"].ToString(), "isDaily='False'");
                        break;
                    }
                case "2":
                    {
                        ((DevExpress.Web.ASPxRoundPanel.ASPxRoundPanel)cbp.FindControl("ASPxRoundPanelHourly")).Visible = false;
                        ((DevExpress.Web.ASPxRoundPanel.ASPxRoundPanel)cbp.FindControl("ASPxRoundPanelValue")).Visible = false;
                        FillPishCard(Session["pcode"].ToString(), "isDaily='True'");
                        break;
                    }
                case "3":
                    {
                        ((DevExpress.Web.ASPxRoundPanel.ASPxRoundPanel)cbp.FindControl("ASPxRoundPanelHourly")).Visible = false;
                        ((DevExpress.Web.ASPxRoundPanel.ASPxRoundPanel)cbp.FindControl("ASPxRoundPanelValue")).Visible = true;
                        ((cbp.FindControl("ASPxRoundPanelPishcard") as ASPxRoundPanel).FindControl("ASPxComboBox3") as ASPxComboBox).Items.Clear();
                        ((cbp.FindControl("ASPxRoundPanelPishcard") as ASPxRoundPanel).FindControl("ASPxComboBox3") as ASPxComboBox).Items.Add("اضافه کار دستوری", "99");
                        break;
                    }
                default:
                    break;
            }

        }
        protected void ASPxGridView2_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            try
            {


                string ss = e.Keys["ID_PK"].ToString();
                SqlDataSource2.DeleteCommand = "delete NW_Requests where (Id_PK=@pk) and (Clock_FirstlyAgree=0)";
                SqlDataSource2.DeleteParameters.Add("pk", ss);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }



        protected void ASPxGridView2_RowInserting(object sender, ASPxDataInsertingEventArgs e)
        {
            try
            {

                string selectedBarcode = ((ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).GetRowValues(((ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).FocusedRowIndex, "Barcode").ToString();
                string selectedDate = Convert.ToString((sender as ASPxGridView).GetMasterRowFieldValues("prc_date"));
                ASPxGridView grid = sender as ASPxGridView;

                DevExpress.Web.ASPxRoundPanel.ASPxRoundPanel RP = grid.FindEditFormTemplateControl("ASPxRoundPanelInsertRequest") as DevExpress.Web.ASPxRoundPanel.ASPxRoundPanel;
                ASPxCallbackPanel cp = RP.FindControl("ASPxCallbackPanel1") as ASPxCallbackPanel;
                string ft = ((cp.FindControl("ASPxRoundPanelHourly") as ASPxRoundPanel).FindControl("ASPxTimeEdit5") as ASPxTimeEdit).Text;
                string tt = ((cp.FindControl("ASPxRoundPanelHourly") as ASPxRoundPanel).FindControl("ASPxTimeEdit6") as ASPxTimeEdit).Text;
                string tv = ((cp.FindControl("ASPxRoundPanelValue") as ASPxRoundPanel).FindControl("ASPxSpinOverTime") as ASPxSpinEdit).Text;
                string selectedType = (cp.FindControl("ASPxRadioButtonList1") as ASPxRadioButtonList).SelectedItem.Value.ToString();
                bool resultAgreeOverTime = new BWebpassUser().CheckAgreeOverTimeAccess(Session["PostID"].ToString());
                if (selectedType == "3" && resultAgreeOverTime == false)
                {

                    throw new Exception("شما مجوز دسترسی به این قسمت را ندارید.");
                }
                string pishcardSelected = (string)((cp.FindControl("ASPxRoundPanelPishcard") as ASPxRoundPanel).FindControl("ASPxComboBox3") as ASPxComboBox).Value;
                if (pishcardSelected == "")
                    throw new Exception("پیش کارت مورد نظر را انتخاب نمایید.");

                //************************
                if (ft == "")
                    ft = "00:00";
                if (tt == "")
                    tt = "00:00";
                int ftToMinute = (int.Parse((ft.Substring(0, 2))) * 60 + int.Parse((ft.Substring(3, 2))));
                int ttToMinute = (int.Parse((tt.Substring(0, 2))) * 60 + int.Parse((tt.Substring(3, 2))));

                string RetMessage = requestBussines.InsertRequestPerson(selectedDate, Utility.MiladiToShamsiDate(DateTime.Now), "", ftToMinute, ttToMinute
                , 0, Convert.ToInt32((cp.FindControl("ASPxRadioButtonList1") as ASPxRadioButtonList).Value), Convert.ToInt32(((cp.FindControl("ASPxRoundPanelPishcard") as ASPxRoundPanel).FindControl("ASPxComboBox3") as ASPxComboBox).Value), Session["pcode"].ToString(), ((cp.FindControl("ASPxRoundPanelExplain") as ASPxRoundPanel).FindControl("ASPxTextBox3") as ASPxTextBox).Text
                , 0, 0, "", 0, Session["PostID"].ToString(), Convert.ToInt32(tv) * 60, 1);
                e.Cancel = true;
                FillAspxGridView2(Session["pcode"].ToString(), selectedDate);
                ((ASPxGridView)sender).CancelEdit();

            }
               
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        protected void ASPxCallbackPanelGridReportMonthly_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            LoadCCAndFillGridViewMonthly(e.Parameter);

        }
        private void LoadCCAndFillGridViewMonthly(string barcode)
        {
            try
            {
                if (new BRequest().CheckTimeInsertRequestIsExpired(ASPxComboBoxYear.Value.ToString() + "/" + ASPxComboBoxMonth.Value.ToString() + "/01", 2) == false)
                {
                    if (Convert.ToBoolean(ConfigurationManager.AppSettings["UseCCService"]) == true)
                    {
                        CCWinService.CCServiceClient ccService = new CCWinService.CCServiceClient();
                        string encryptionCode = new CryptData().EncryptData(ASPxComboBoxYear.Value.ToString() + ASPxComboBoxMonth.Value.ToString());
                        bool result = ccService.CalculateOnePerson(barcode, ASPxComboBoxYear.Value.ToString(), ASPxComboBoxMonth.Value.ToString(), encryptionCode);
                    }
                    else
                    {


                        ProcessStartInfo startInfo;
                        Process process;
                        startInfo = new ProcessStartInfo(WebConfigurationManager.AppSettings["CCFilePath"].ToString());
                        startInfo.Arguments = barcode + " " + ASPxComboBoxYear.Value.ToString() + " " + ASPxComboBoxMonth.Value.ToString();
                        startInfo.UseShellExecute = false;
                        startInfo.CreateNoWindow = true;
                        startInfo.RedirectStandardOutput = true;
                        startInfo.RedirectStandardError = true;
                        startInfo.RedirectStandardInput = true;
                        process = new Process();
                        process.StartInfo = startInfo;
                        process.Start();
                        process.WaitForExit();


                    }


                }
            }
            catch (System.Exception ex)
            {
                throw ex;

            }
            try
            {


                FillGridViewRepotMonthlyByUser(barcode, ASPxComboBoxYear.Value.ToString() , ASPxComboBoxMonth.Value.ToString());
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void ASPxGridView2_InitNewRow(object sender, ASPxDataInitNewRowEventArgs e)
        {
            FillPishCard(Session["pcode"].ToString(), "isDaily='False'");
        }
        protected void ASPxGridViewReportMonthly_htmldatacellprepared(object sender, ASPxGridViewTableDataCellEventArgs e)
        {


            if (Session["TrafficColor"] == null)
                Session["TrafficColor"] = new BRequest().GetColorsTraffic();

            DataTable dtResult = (DataTable)Session["TrafficColor"];
            if (e.DataColumn.Name == "color")
            {
                if (e.GetValue("prc_date").ToString() != "")
                {

                    for (int i = 0; i < dtResult.Rows.Count; i++)
                    {
                        if (dtResult.Rows[i]["WebColor_Order"].ToString() == "0")
                        {
                            int taradodNaghes = Convert.ToInt32(e.GetValue("Prc_AbsenceNaghes"));
                            if (taradodNaghes == 1)
                            {
                                e.Cell.BackColor = ColorTranslator.FromHtml(dtResult.Rows[i]["WebColor_Color"].ToString());
                                break;
                            }

                        }
                        else
                        {
                            string columnName = dtResult.Rows[i]["WebColor_ColumnName"].ToString();
                            string cellValue = e.GetValue(columnName).ToString();
                            if (cellValue != "" && cellValue != "00:00")
                            {
                                e.Cell.BackColor = ColorTranslator.FromHtml(dtResult.Rows[i]["WebColor_Color"].ToString());
                                break;
                            }

                        }
                    }

                }
            }

        }
    }
}