using ASPWebClock.DAL.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.Infrastructure.Utility;
using System.Data.SqlClient;
using ASPWebclock.AppCode;

namespace ASPWebclock.Admin
{
    public partial class log : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionHandler.CheckSessionTimeOut(this.Page);
            RefererValidation.CheckReferer();
            if (!IsPostBack)
            {
                ToDate.Text = Utility.MiladiToShamsiDate(DateTime.Now);
                FromDate.Text = ToDate.Text.Substring(0, 4) + "/" + ToDate.Text.Substring(5, 2) + "/01";
            }
           
            

        }
        private bool DeleteGritdItem(List<object> SL)
        {
            bool Result = new ASPWebClock.Infrastructure.Business.BLog().DeleteLog(SL);
            return Result;
        }


        private void FillGridViewLog(DateTime toDate,DateTime fromDate,string searchKey, LogSearchFields searchField)
        {

            try
            {
                ASPxGridViewLog.DataSource= new ASPWebClock.Infrastructure.Business.BLog().GetLog(fromDate, toDate, searchKey, searchField);
                ASPxGridViewLog.DataBind();
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        protected void ASPxComboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ASPxButtonSearchKey_Click(object sender, EventArgs e)
        {
            DateTime fromDate = Utility.ToMildiDate(FromDate.Text);
            
            DateTime toDate = Utility.ToMildiDate(ToDate.Text);
            toDate=new DateTime(toDate.Year,toDate.Month,toDate.Day,DateTime.Now.Hour,DateTime.Now.Minute,DateTime.Now.Second);
            string searchKey = ASPxTextBoxSearchKey.Text;
            LogSearchFields searchField = (LogSearchFields)Enum.Parse(typeof(LogSearchFields), ASPxComboBoxSearchField.SelectedItem.Value.ToString());
            FillGridViewLog(toDate,fromDate, searchKey, searchField);
        }

        protected void ASPxButtonDelete_Click(object sender, EventArgs e)
        {
            List<object> SelectedList = ASPxGridViewLog.GetSelectedFieldValues("ID");
            DeleteGritdItem(SelectedList);
            DateTime fromDate = Utility.ToMildiDate(FromDate.Text);
            DateTime toDate = Utility.ToMildiDate(ToDate.Text);
            string searchKey = ASPxTextBoxSearchKey.Text;
            LogSearchFields searchField = (LogSearchFields)Enum.Parse(typeof(LogSearchFields), ASPxComboBoxSearchField.SelectedItem.Value.ToString());
            FillGridViewLog(toDate, fromDate, searchKey, searchField);
        }

        

       
    }
}