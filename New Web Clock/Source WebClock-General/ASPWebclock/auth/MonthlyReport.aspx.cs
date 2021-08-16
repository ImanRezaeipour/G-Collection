using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;

namespace WebApplication1
{
    public partial class MonthlyReport : System.Web.UI.Page
    {
        string cnn = ConfigurationManager.ConnectionStrings["cnn"].ToString();
        int year = 0;//int.Parse(this.cmbYear.SelectedItem.Text);
        int month = 0;// int.Parse(this.cmbMonth.SelectedItem.Value);
        string sessionKey = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Page.IsPostBack)
            //{
            //    this.FillcmbYear();
            //    this.UpdateBaseInfo();
            //    this.FillMonthlyReportGrid();
            //}
            this.year = int.Parse(this.Request.Params["year"]);
            this.month = int.Parse(this.Request.Params["month"]);
            this.sessionKey = String.Format("{0};{1}", this.year.ToString(), this.month.ToString());
                this.FillMonthlyReportGrid();           
        }

        //private void UpdateBaseInfo()
        //{
        //    PersianCalendar pcal = new PersianCalendar();
        //    int year = pcal.GetYear(DateTime.Now);
        //    this.cmbYear.SelectedIndex = int.Parse(this.cmbYear.Items.FindByText(year.ToString()).Value);
        //    int month = pcal.GetMonth(DateTime.Now);
        //    this.cmbMonth.SelectedIndex = month - 1;
        //}

        //private void FillcmbYear()
        //{
        //    int iCounter = 0;
        //    for (int i = 1380; i < 1421; i++)
        //    {
        //        ListItem li = new ListItem();
        //        li.Text = i.ToString();
        //        li.Value = iCounter.ToString();
        //        this.cmbYear.Items.Add(li);
        //        iCounter++;
        //    }
        //}

        private void FillMonthlyReportGrid()
        {
            try
            {
                string currentBarCode = this.Page.User.Identity.Name.PadLeft(8,'0');

                //if (year != null && month != null)
                {
/*
                    if (Page.Session[this.sessionKey] == null || ((bool)Page.Session[this.sessionKey]) == false)
                    {
                        ASPWebclock.ClockEngWSServiceRefrence.ClockEngWSSoapClient ClockEngWSSoapClientService = new ASPWebclock.ClockEngWSServiceRefrence.ClockEngWSSoapClient();
                        ClockEngWSSoapClientService.Execute(currentBarCode, year, month);
                        Page.Session[this.sessionKey] = true;
                    }
*/
//----------------------
                    SqlConnection con2 = new SqlConnection(this.cnn);
                    SqlCommand myCommand = new SqlCommand("xp_cmdshell "+"'c:\\ghadirco\\clocktest\\cc "+currentBarCode +" "+ year +" "+ month+"'", con2);
                    myCommand.Connection.Open();
                    myCommand.ExecuteNonQuery();
                    con2.Close();
//---------------------
                    
                    
                    
                    string p = "p" + year.ToString() + month.ToString().PadLeft(2, '0');

                    SqlConnection con = new SqlConnection(this.cnn);
                    string CommandStr = "if object_id('tempdb..#_t') is not null drop table #_t " +
                                        "select * into #_t  from  " +
                                        "(SELECT " +
                                        "dbo.PishCardFullName(prc_kind,prc_type) AS PishCardFullName " +
                                        ",prc_kind AS PishCard, prc_type, Prc_PCode, substring(Prc_Date,9,2)+'/'+substring(Prc_Date,6,2)+'/'+substring(Prc_Date,1,4)  prc_date,prc_date DateSort " +
                                        ",dbo.FARSI_WEEK_DAY(prc_date) AS FARSI_WEEK_DAY  " +
                                        ",dbo.MToHTaraddod(prc_FirstIn) AS prc_FirstIn, dbo.MToHTaraddod(Prc_FirstOut) AS Prc_FirstOut " +
                                        ",dbo.MToHTaraddod(Prc_SecondIn)AS Prc_SecondIn,dbo.MToHTaraddod(Prc_SecondOut) AS Prc_SecondOut " +
                                        ",dbo.MToHTaraddod(Prc_ThirdIn) AS Prc_ThirdIn,dbo.MToHTaraddod(Prc_ThirdOut) AS Prc_ThirdOut " +
                                        ",dbo.MToHTaraddod(Prc_FourthIn) AS Prc_FourthIn,dbo.MToHTaraddod(Prc_FourthOut) AS Prc_FourthOut " +
                                        ",dbo.MToHTaraddod(Prc_FifthIn) AS Prc_FifthIn,dbo.MToHTaraddod(Prc_FifthOut) AS Prc_FifthOut " +
                                        ",dbo.MToH(Prc_PresenceWork) AS HozurEVagheie " +
                                        ",dbo.MToH(Prc_NormWork) AS HozurELazem " +
                                        ",dbo.MToH(Prc_keshiktime) as Keshik " +
                                        ",dbo.MToH(Prc_ValidAddWork) as Ezafehkar " +
                                        ",dbo.MToH(Prc_InvalidAddWork) as EzafehkarGheiremojaz " +
                                        ",dbo.MToH(Prc_HourAbsence+Prc_HourDayAbsence) AS kasrekar " +
                                        ",Prc_DayAbsence AS GheibatRuz " +
                                        ",dbo.MToH(Prc_HourMission) AS MamHour " +
                                        ",Prc_DayMission AS MamRuz " +
                                        ",Prc_DaySleaveSalary AS  MorDarRuzB" +
                                        ",Prc_DayleaveSalary44 AS MorDarRuz " +
                                        ",dbo.MToH(Prc_HourEleaveSalary) AS Ezterar " +
                                        ",Prc_DayEleaveSalary AS MorEstRuz " +
                                        ",Prc_DayleaveNoSalary AS MorBiHoghRuz " +
                                        ",dbo.MToH(Prc_HourleaveSalary27) AS MorSaati " +
                                        ",Prc_DayeleaveRemain AS DayMandeMorakhasi " + 
                                        ",dbo.MToH(Prc_HourEleaveRemain) AS HourMandeMorakhasi " +

                                        "  FROM  " + p + " " +
                                        "WHERE Prc_PCode= '" + currentBarCode + "' " +
                                        "AND  " +
                                               "SUBSTRING(Prc_Date, 9, 2) <> '00' ) L40 " +

                                        "insert into #_t " +
                                        "SELECT " +
                                        "'' PishCardFullName " +
                                        ",'' AS PishCard,'' prc_type,'' Prc_PCode,'' Prc_Date, '9999/99/99' AS DateSort " +
                                        ",'جمع ماه' FARSI_WEEK_DAY " +
                                        ",'' AS prc_FirstIn, '' AS Prc_FirstOut " +
                                        ",'' AS Prc_SecondIn, '' AS Prc_SecondOut " +
                                        ",'' AS Prc_ThirdIn, '' AS Prc_ThirdOut " +
                                        ",'' AS Prc_FourthIn, '' AS Prc_FourthOut " +
                                        ",'' AS Prc_FifthIn, '' AS Prc_FifthOut " +

                                        ",dbo.MToH(Prc_PresenceWork) AS HozurEVagheie " +
                                        ",dbo.MToH(Prc_NormWork) AS HozurELazem " +
                                        ",dbo.MToH(Prc_keshiktime) as Keshik " +
                                        ",dbo.MToH(Prc_ValidAddWork) as Ezafehkar " +
                                        ",dbo.MToH(Prc_InvalidAddWork) as EzafehkarGheiremojaz " +
                                        ",dbo.MToH(Prc_HourAbsence+Prc_HourDayAbsence) AS kasrekar " +
                                        ",Prc_DayAbsence AS GheibatRuz " +
                                        ",dbo.MToH(Prc_HourMission) AS MamHour " +
                                        ",Prc_DayMission AS MamRuz " +
                                        ",Prc_DaySleaveSalary AS MorDarRuz " +
                                        ",Prc_DayleaveSalary44 as MorDarRuzB " +
                                        ",dbo.MToH(Prc_HourEleaveSalary) AS Ezterar " +
                                        ",Prc_DayEleaveSalary AS MorEstRuz " +
                                        ",Prc_DayleaveNoSalary AS MorBiHoghRuz " +
                                        ",dbo.MToH(Prc_HourleaveSalary27) AS MorSaati " +
                                        ",Prc_DayeleaveRemain AS DayMandeMorakhasi " +
                                        ",dbo.MToH(Prc_HourEleaveRemain) AS HourMandeMorakhasi " + 
                                        "From " + p + " WHERE Prc_PCode= '" + currentBarCode + "' AND SUBSTRING(Prc_Date, 9, 2) = '00' " +

                                        "if not exists( select prc_secondin from #_t where prc_secondin<>'') update #_t set prc_secondin='F' " +
                                        "if not exists( select prc_secondout from #_t where prc_secondout<>'') update #_t set prc_secondout='F' " +
                                        "if not exists( select prc_thirdin from #_t where prc_thirdin<>'') update #_t set prc_thirdin='F' " +
                                        "if not exists( select prc_thirdout from #_t where prc_thirdout<>'') update #_t set prc_thirdout='F' " +
                                        "if not exists( select prc_fourthin from #_t where prc_fourthin<>'') update #_t set prc_fourthin='F' " +
                                        "if not exists( select prc_fourthout from #_t where prc_fourthout<>'') update #_t set prc_fourthout='F' " +

                                        "if not exists( select prc_fifthin from #_t where prc_fifthin<>'') update #_t set prc_fifthin='F' " +
                                        "if not exists( select prc_fifthout from #_t where prc_fifthout<>'') update #_t set prc_fifthout='F' " +


                                        "select * from #_t order by DateSort";
                    SqlDataAdapter da = new SqlDataAdapter(CommandStr, con);
                    DataTable dt = new DataTable("dt");
                    da.Fill(dt);
                    this.UpdateMonthlyReportGrid(dt);
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        //protected void btnApplyConditions_Click(object sender, EventArgs e)
        //{
        //    this.FillMonthlyReportGrid();
        //}

        private void UpdateMonthlyReportGrid(DataTable dt)
        {
            DataRow row1 = dt.Select("DateSort = '9999/99/99'").FirstOrDefault();
            if (row1 != null)
            {
                lblDayMondeMor.Text = row1["DayMandeMorakhasi"].ToString();
                lblHourMondeMor.Text = row1["HourMandeMorakhasi"].ToString();
            }

            for (int i = 0; i < this.MonthlyReportGrid.Columns.Count; i++)
            {
                this.MonthlyReportGrid.Columns[i].Visible = true;
            }
            if (dt.Select("prc_FirstIn <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[2].Visible = false;
            if (dt.Select("Prc_FirstOut <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[3].Visible = false;
            if (dt.Select("Prc_SecondIn <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[4].Visible = false;
            if (dt.Select("Prc_SecondOut <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[5].Visible = false;
            if (dt.Select("Prc_ThirdIn <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[6].Visible = false;
            if (dt.Select("Prc_ThirdOut <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[7].Visible = false;
            if (dt.Select("Prc_FourthIn <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[8].Visible = false;
            if (dt.Select("Prc_FourthOut <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[9].Visible = false;
            if (dt.Select("Prc_FifthIn <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[10].Visible = false;
            if (dt.Select("Prc_FifthOut <> 'F'").Count() == 0)
                this.MonthlyReportGrid.Columns[11].Visible = false;

            this.MonthlyReportGrid.DataSource = dt;
            this.MonthlyReportGrid.DataBind();

            foreach (GridViewRow gvr in this.MonthlyReportGrid.Rows)
            {
                if (gvr.Cells[0].Controls.Count > 0)
                {
                    LinkButton selectControl = gvr.Cells[0].Controls[0] as LinkButton;
                    if (selectControl != null)
                    {
                        if (gvr.Cells[2].Text != "&nbsp;")
                        {
                            selectControl.Text = "انتخاب";
                            selectControl.ForeColor = System.Drawing.Color.DarkSlateGray;
                        }
                        else
                            gvr.Cells[0].Controls.Remove(selectControl);
                    }
                }

                for (int i = 0; i < this.MonthlyReportGrid.Columns.Count; i++)
                {
                    gvr.Cells[i + 1].ToolTip = this.MonthlyReportGrid.Columns[i].HeaderText;
                }

                PersianCalendar pCal = new PersianCalendar();
                if (gvr.Cells[2].Text != "&nbsp;")
                {
                    Dictionary<string, int> DateDic = this.GetPersianDateParts(gvr.Cells[2].Text);
                    gvr.Cells[2].Text = DateDic["year"] + "/" + DateDic["month"] + "/" + DateDic["day"];
                    if (pCal.GetDayOfWeek(pCal.ToDateTime((int)DateDic["year"], (int)DateDic["month"], (int)DateDic["day"], 0, 0, 0, 0)) == DayOfWeek.Friday)
                    {
                        gvr.BackColor = gvr.Cells[1].BackColor = gvr.Cells[2].BackColor = System.Drawing.Color.DeepPink;
                    }
                }
                else
                {
                    gvr.BackColor = gvr.Cells[1].BackColor = gvr.Cells[2].BackColor = System.Drawing.Color.Moccasin;
                    gvr.Cells[1].ToolTip = string.Empty;
                    gvr.Cells[1].ForeColor = System.Drawing.Color.Black;
                }


            }
        }

        private Dictionary<string, int> GetPersianDateParts(string strDate)
        {
            Dictionary<string, int> DateDic = new Dictionary<string, int>();
            string[] strDateParts = strDate.Split(new char[] { '/' });
            DateDic.Add("day", int.Parse(strDateParts[0]));
            DateDic.Add("month", int.Parse(strDateParts[1]));
            DateDic.Add("year", int.Parse(strDateParts[2]));
            return DateDic;
        }

        //protected void btnReturn_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("main.aspx");
        //}

    }
}