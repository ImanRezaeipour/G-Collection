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
using ASPWebClock.DAL.Repository;
using System.Drawing;
using System.Collections;
using System.Text;
using System.Globalization;
using ASPWebClock.Infrastructure.Business;
using System.Diagnostics;
using System.Web.UI.HtmlControls;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.DAL.Business;
using ASPWebclock.AppCode;
using System.Web.Configuration;
using System.ServiceModel;



namespace ASPWebclock
{
    public partial class DevMonthlyReport : System.Web.UI.Page
    {
        public DateTime Shamsi2Miladi(string _date)
        {
            int year = int.Parse(_date.Substring(0, 4));
            int month = int.Parse(_date.Substring(5, 2));
            int day = int.Parse(_date.Substring(8, 2));
            PersianCalendar p = new PersianCalendar();
            DateTime date = p.ToDateTime(year, month, day, 0, 0, 0, 0);
            return date;
        }
        public BRequest requestBussines
        {
            get
            {
                return new BRequest();
            }
        }
        public BUser userBussines
        {
            get
            {
                return new BUser();
            }
        }
        public BRole roleBusiness
        {
            get
            {
                return new BRole();
            }
        }
        public string ShamsiDate(DateTime MiladiDate)
        {
            PersianCalendar jc = new PersianCalendar();

            DateTime thisDate = MiladiDate;
            return jc.GetYear(thisDate).ToString() + "/" + (jc.GetMonth(thisDate) < 10 ? "0" : "") + jc.GetMonth(thisDate).ToString() + "/" + (jc.GetDayOfMonth(thisDate) < 10 ? "0" : "") + jc.GetDayOfMonth(thisDate).ToString();
        }
        private class RequestStat
        {
            public string date_ { get; set; }
            public Int32 stat { get; set; }
        }
        List<RequestStat> lrs = new List<RequestStat>();

        protected void Page_Load(object sender, EventArgs e)
        {

            RefererValidation.CheckReferer();
            

            if (!Page.IsPostBack)
            {
                string barcodeCurrentUser = new UserRepository().GetBarcodeByUserName(this.User.Identity.Name);
                FillYearMonthDate(DateTime.Today);
                LoadCCAndFillGridViewMonthly(barcodeCurrentUser);
                FillAspxGridView2(barcodeCurrentUser, ShamsiDate(DateTime.Today));

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
                    ASPxGridView1.SettingsDetail.ShowDetailRow = true;
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

            ASPxComboBoxYear.Value = ShamsiDate(dateSelected).Substring(0, 4);
            ASPxComboBoxMonth.Value = ShamsiDate(dateSelected).Substring(5, 2);
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
        private void FillGridViewRepotMonthlyByUser(string barcode, string yearMonthSelected)
        {
            try
            {

           
            Session["pcode"] = barcode;
            SqlDataSourceGetExistTable.SelectCommand = "IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[p" + yearMonthSelected + "]') AND type in (N'U')) select 'True' else select 'False'";
            SqlDataSource1.SelectCommand = CreateSqlCommandReportMonthly(barcode, yearMonthSelected);
            SqlDataSourceGetExistTable.ConnectionString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
            DataView dtExistTable = (DataView)SqlDataSourceGetExistTable.Select(DataSourceSelectArguments.Empty);
            bool resultExistTable = Convert.ToBoolean(dtExistTable.Table.Rows[0][0]);
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
                ASPxGridView1.Columns[04].Visible = true;
                ASPxGridView1.Columns[05].Visible = true;
                ASPxGridView1.Columns[06].Visible = true;
                ASPxGridView1.Columns[07].Visible = true;
                ASPxGridView1.Columns[08].Visible = true;
                ASPxGridView1.Columns[09].Visible = true;
                ASPxGridView1.Columns[10].Visible = true;
                ASPxGridView1.Columns[11].Visible = true;
                //---------------------------------------------------------------
                string startDate = yearMonthSelected.Substring(0, 4) + "/" + yearMonthSelected.Substring(4, 2) + "/01";
                string endDate = yearMonthSelected.Substring(0, 4) + "/" + yearMonthSelected.Substring(4, 2) + "/31";
                DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                if (dv.Table.Rows.Count > 0)
                {
                    if ((string)dv.Table.Rows[0][09] == "2I") ASPxGridView1.Columns[04].Visible = false;
                    if ((string)dv.Table.Rows[0][10] == "2O") ASPxGridView1.Columns[05].Visible = false;

                    if ((string)dv.Table.Rows[0][11] == "3I") ASPxGridView1.Columns[06].Visible = false;
                    if ((string)dv.Table.Rows[0][12] == "3O") ASPxGridView1.Columns[07].Visible = false;

                    if ((string)dv.Table.Rows[0][13] == "4I") ASPxGridView1.Columns[08].Visible = false;
                    if ((string)dv.Table.Rows[0][14] == "4O") ASPxGridView1.Columns[09].Visible = false;

                    if ((string)dv.Table.Rows[0][15] == "5I") ASPxGridView1.Columns[10].Visible = false;
                    if ((string)dv.Table.Rows[0][16] == "5O") ASPxGridView1.Columns[11].Visible = false;


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
                    ASPxGridView1.SettingsText.EmptyDataRow = "هیچ آیتمی یافت نشد";
                }
                if (con.State == ConnectionState.Open)
                    con.Close();
                Session["lrs"] = lrs;
            }
            ASPxGridView1.ExpandAll();
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
            object row= ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEdit2.FindControl("ASPxGridView5")).GetRow(rowSelected);
            ASPxLabelBarcode.Text = ((System.Data.DataRowView)row).Row[0].ToString();
            ASPxLabelName.Text = ((System.Data.DataRowView)row).Row[1].ToString();
            ASPxLabelFamily.Text=((System.Data.DataRowView)row).Row[2].ToString();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            
        }
        private string CreateSqlCommandReportMonthly(string barcode, string dateSelected)
        {
            string query = " if object_id('tempdb..#_t') is not null drop table #_t" +
" select * into #_t  from " +
" (SELECT" +
" dbo.PishCardFullName(prc_kind,prc_type) AS PishCardFullName" +
" ,prc_kind AS PishCard, prc_type, Prc_PCode,prc_date,prc_date DateSort" +
" ,dbo.FARSI_WEEK_DAY(prc_date) AS FARSI_WEEK_DAY " +
" ,dbo.MToHTaraddod(prc_FirstIn) AS prc_FirstIn, dbo.MToHTaraddod(Prc_FirstOut) AS Prc_FirstOut" +
" ,dbo.MToHTaraddod(Prc_SecondIn)AS Prc_SecondIn,dbo.MToHTaraddod(Prc_SecondOut) AS Prc_SecondOut" +
" ,dbo.MToHTaraddod(Prc_ThirdIn) AS Prc_ThirdIn,dbo.MToHTaraddod(Prc_ThirdOut) AS Prc_ThirdOut" +
" ,dbo.MToHTaraddod(Prc_FourthIn) AS Prc_FourthIn,dbo.MToHTaraddod(Prc_FourthOut) AS Prc_FourthOut" +
" ,dbo.MToHTaraddod(Prc_FifthIn) AS Prc_FifthIn,dbo.MToHTaraddod(Prc_FifthOut) AS Prc_FifthOut" +
" ,dbo.MToH(Prc_PresenceWork) AS HozurEVagheie" +
" ,dbo.MToH(Prc_NormWork) AS HozurELazem" +
" ,dbo.MToH(Prc_keshiktime) as Keshik" +
" ,dbo.MToH(Prc_ValidAddWork) as Ezafehkar" +
" ,dbo.MToH(Prc_InvalidAddWork) as EzafehkarGheiremojaz" +
" ,dbo.MToH(Prc_HourAbsence+Prc_HourDayAbsence) AS kasrekar" +
" ,dbo.zerotospace(Prc_DayAbsence) AS GheibatRuz" +
" ,dbo.MToH(Prc_HourMission) AS MamHour" +
" ,dbo.zerotospace(Prc_DayMission) AS MamRuz" +
" ,dbo.zerotospace(Prc_DaySleaveSalary) AS  MorDarRuzB " +
" ,dbo.zerotospace(Prc_DayleaveSalary44) AS MorDarRuz" +
" ,dbo.MToH(Prc_HourEleaveSalary) AS Ezterar" +
" ,dbo.zerotospace(Prc_DayEleaveSalary)AS MorEstRuz" +
" ,dbo.zerotospace(Prc_DayleaveNoSalary) AS MorBiHoghRuz" +
" ,dbo.MToH(Prc_HourleaveSalary27) AS MorSaati" +
" ,Prc_DayeleaveRemain AS DayMandeMorakhasi " +
" ,dbo.MToH(Prc_HourEleaveRemain) AS HourMandeMorakhasi" +
" ,Prc_AbsenceNaghes as Prc_AbsenceNaghes" +
" FROM p" + dateSelected +
" WHERE Prc_PCode= '" + barcode + "' AND " +
" SUBSTRING(Prc_Date, 9, 2) <> '00' ) L40" +
" insert into #_t" +
" SELECT " +
" '' PishCardFullName" +
" ,'' AS PishCard,'' prc_type,'' Prc_PCode,'' Prc_Date, '9999/99/99' AS DateSort" +
" ,'جمع ماه' FARSI_WEEK_DAY" +
" ,'' AS prc_FirstIn, '' AS Prc_FirstOut" +
" ,'' AS Prc_SecondIn, '' AS Prc_SecondOut" +
" ,'' AS Prc_ThirdIn, '' AS Prc_ThirdOut" +
" ,'' AS Prc_FourthIn, '' AS Prc_FourthOut" +
" ,'' AS Prc_FifthIn, '' AS Prc_FifthOut" +
" ,dbo.MToH(Prc_PresenceWork) AS HozurEVagheie" +
" ,dbo.MToH(Prc_NormWork) AS HozurELazem" +
" ,dbo.MToH(Prc_keshiktime) as Keshik" +
" ,dbo.MToH(Prc_ValidAddWork) as Ezafehkar" +
" ,dbo.MToH(Prc_InvalidAddWork) as EzafehkarGheiremojaz" +
" ,dbo.MToH(Prc_HourAbsence+Prc_HourDayAbsence) AS kasrekar" +
" ,Prc_DayAbsence AS GheibatRuz" +
" ,dbo.MToH(Prc_HourMission) AS MamHour" +
" ,Prc_DayMission AS MamRuz" +
" ,Prc_DaySleaveSalary AS MorDarRuz" +
" ,Prc_DayleaveSalary44 as MorDarRuzB" +
" ,dbo.MToH(Prc_HourEleaveSalary) AS Ezterar" +
" ,Prc_DayEleaveSalary AS MorEstRuz" +
" ,Prc_DayleaveNoSalary AS MorBiHoghRuz" +
" ,dbo.MToH(Prc_HourleaveSalary27) AS MorSaati" +
" ,Prc_DayeleaveRemain AS DayMandeMorakhasi" +
" ,dbo.MToH(Prc_HourEleaveRemain) AS HourMandeMorakhasi " +
" ,Prc_AbsenceNaghes as Prc_AbsenceNaghes" +
" From p" + dateSelected + " WHERE Prc_PCode= '" + barcode + "' AND SUBSTRING(Prc_Date, 9, 2) = '00'" +

" if not exists( select prc_secondin from #_t where prc_secondin<>'') update #_t set prc_secondin='2I'" +
" if not exists( select prc_secondout from #_t where prc_secondout<>'') update #_t set prc_secondout='2O'" +
" if not exists( select prc_thirdin from #_t where prc_thirdin<>'') update #_t set prc_thirdin='3I'" +
" if not exists( select prc_thirdout from #_t where prc_thirdout<>'') update #_t set prc_thirdout='3O'" +
" if not exists( select prc_fourthin from #_t where prc_fourthin<>'') update #_t set prc_fourthin='4I'" +
" if not exists( select prc_fourthout from #_t where prc_fourthout<>'') update #_t set prc_fourthout='4O'" +

" if not exists( select prc_fifthin from #_t where prc_fifthin<>'') update #_t set prc_fifthin='5I'" +
" if not exists( select prc_fifthout from #_t where prc_fifthout<>'') update #_t set prc_fifthout='5O'" +


" select * from #_t order by DateSort";
            return query;
        }




        protected void ASPxGridView1_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs e)
        {

            if (e.GetValue("PishCardFullName") != null)
            {
                string holiday = e.GetValue("PishCardFullName").ToString();
                if (holiday == "تعطيل رسمي")
                {

                    e.Row.ForeColor = System.Drawing.Color.Red;
                }
            }
            if (e.VisibleIndex == ASPxGridView1.VisibleRowCount - 1)
            {
                e.Row.ForeColor = System.Drawing.Color.Purple;
                e.Row.Font.Bold = true;
                e.Row.Font.Size = new FontUnit(10); ;

            }
            lrs = (List<RequestStat>)Session["lrs"];
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

        protected void ASPxGridView1_DetailRowGetButtonVisibility(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewDetailRowButtonEventArgs e)
        {

            object rowValue = ASPxGridView1.GetRowValuesByKeyValue(e.KeyValue, new string[] { "FARSI_WEEK_DAY" });


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
                bool resultAgreeOverTime = new BUser().CheckAgreeOverTimeAccess(Session["PostID"].ToString());
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

                string RetMessage = requestBussines.InsertRequestPerson(selectedDate, ShamsiDate(DateTime.Now), "", ftToMinute, ttToMinute
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
                //ServiceReference1.CCServiceLibraryClient ccService = new ServiceReference1.CCServiceLibraryClient();
                //List<string> listBarcode = new List<string>();
                //listBarcode.Add(barcode);
                //bool result = ccService.CallThreats(listBarcode.ToArray(), ASPxComboBoxYear.Value.ToString(), ASPxComboBoxMonth.Value.ToString());


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
            catch (System.Exception ex)
            {
                throw ex;

            }
            try
            {

            
            FillGridViewRepotMonthlyByUser(barcode, ASPxComboBoxYear.Value.ToString() + ASPxComboBoxMonth.Value.ToString());
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
        protected void aspxgridview1_htmldatacellprepared(object sender, ASPxGridViewTableDataCellEventArgs e)
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