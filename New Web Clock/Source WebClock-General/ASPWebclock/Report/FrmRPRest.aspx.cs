using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.XtraReports.UI;
using System.Data;
using System.Data.SqlClient;
using ASPWebClock.Infrastructure.Utility;
using System.Configuration;
using ASPWebClock.Infrastructure;


namespace ASPWebclock
{
    public partial class FrmRPRest : System.Web.UI.Page
    {
        private readonly string ConnStrKey = "cnn";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack && !this.IsCallback)
            {
                FillcmbYear();
            }
            if(this.IsCallback)
            {
                //--------------------------------------------    
                //string fromdate = cmbYear.SelectedItem.Text + "/" + _MonthString(int.Parse(cmbMonth.Text.ToString())) + "/01";
                //string todate = cmbYear.SelectedItem.Text + "/" + _MonthString(int.Parse(cmbMonth.Text.ToString())) + "/31";

                //DSRest ds1 = new DSRest();
                //ASPWebClock.Infrastructure.DSRestTableAdapters.DTRestTableAdapter ta = new ASPWebClock.Infrastructure.DSRestTableAdapters.DTRestTableAdapter();
               
                //ds1.Load(ta.GetData(this.Page.User.Identity.Name, fromdate, todate).CreateDataReader(), LoadOption.PreserveChanges, ds1.DTRest);
                //XtraReport report = XtraReport.FromFile("c:\\RPRest.repx", true);
                //report.DataSource = ds1;
                //ReportViewer1.Report = report;
                //--------------------------------------------
            }

        }

        protected void btnApplyConditions_Click(object sender, EventArgs e)
        {
            this.FillMonthlyReportGrid();
        }

        private void FillMonthlyReportGrid()
        {
            try
            {
                string currentBarCode = this.Page.User.Identity.Name.PadLeft(8, '0');

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        private void FillcmbYear()
        {
            int iCounter = 0;
            string PersianDT = PersianDateTime.ShamsiDate(DateTime.Now);
            for (int i = 1380; i < 1421; i++)
            {
                ListItem li = new ListItem();
                li.Text = i.ToString();
                li.Value = iCounter.ToString();
                if (li.Text == PersianDT.Split('/')[0])
                    li.Selected = true;
                this.cmbYear.Items.Add(li);
                iCounter++;
            }
            cmbMonth.Items.FindByValue(PersianDT.Split('/')[1]).Selected = true;

        }

        public string _MonthString(int _month)
        {
            if (_month < 10) return "0" + _month.ToString();
            else return _month.ToString();
        }
    }
}