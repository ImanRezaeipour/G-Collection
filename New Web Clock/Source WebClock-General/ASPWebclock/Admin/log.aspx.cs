using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.Infrastructure.Utility;
using System.Data.SqlClient;
using ASPWebClock.Infrastructure.Model;
using ASPWebclock.AppCode;
using System.Web.Script.Serialization;
using DevExpress.Web.ASPxGridView;
using ASPWebClock.Infrastructure.Business;

namespace ASPWebclock.Admin
{
    public partial class log : System.Web.UI.Page
    {
        internal class SearchProxy
        {
            public string State { get; set; }
            public string SearchField { get; set; }
            public string SearchValue { get; set; }
            public string FromDate { get; set; }
            public string ToDate { get; set; }
        }

        public JavaScriptSerializer JsSerializer
        {
            get
            {
                return new JavaScriptSerializer();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            SessionHandler.CheckSessionTimeOut(Page);
            if (!IsPostBack)
            {
                ToDate.Text = Utility.MiladiToShamsiDate(DateTime.Now);
                FromDate.Text = ToDate.Text.Substring(0, 4) + "/" + ToDate.Text.Substring(5, 2) + "/01";
            }

            if (ASPxGridViewLog.IsCallback)
                FillGridViewLog(StateGridViewLog.CallBack, new DateTime(), new DateTime(), "", new LogSearchFields());
          
        }
        public enum StateGridViewLog{
            Fill,
            CallBack
        }
        private bool DeleteGritdItem(List<object> SL)
        {
            bool Result = new BLog().DeleteLog(SL);
            return Result;
        }

               
        private void FillGridViewLog(StateGridViewLog state,DateTime toDate, DateTime fromDate, string searchKey, LogSearchFields searchField)
        {

            try
            {
                if (state == StateGridViewLog.Fill)
                {
                    Session["FillGridViewLog_Log"] = new BLog().GetLog(toDate, fromDate, searchKey, searchField);
                }
                if(Session["FillGridViewLog_Log"] !=null)
                {
                    ASPxGridViewLog.DataSource = (List<LogProxy>)Session["FillGridViewLog_Log"];
                    ASPxGridViewLog.DataBind();
                }
                   
               
               
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        ///changed to client side
        ///********************
        //protected void ASPxButtonDelete_Click(object sender, EventArgs e)
        //{
        //    List<object> SelectedList = ASPxGridViewLog.GetSelectedFieldValues("ID");
        //    DeleteGritdItem(SelectedList);
        //    DateTime fromDate = Utility.ToMildiDate(FromDate.Text);
        //    DateTime toDate = Utility.ToMildiDate(ToDate.Text);
        //    string searchKey = ASPxTextBoxSearchKey.Text;
        //    LogSearchFields searchField = (LogSearchFields)Enum.Parse(typeof(LogSearchFields), ASPxComboBoxSearchField.SelectedItem.Value.ToString());
        //    FillGridViewLog(toDate, fromDate, searchKey, searchField);
        //}

        protected void ASPxGridViewLog_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {
                SearchProxy searchProxy = this.JsSerializer.Deserialize<SearchProxy>(e.Parameters);
                if (searchProxy.State == "show")
                {
                    DateTime fromDate = Utility.ToMildiDate(searchProxy.FromDate);
                    DateTime toDate = Utility.ToMildiDate(searchProxy.ToDate);
                    toDate = new DateTime(toDate.Year, toDate.Month, toDate.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
                    LogSearchFields searchField = (LogSearchFields)Enum.Parse(typeof(LogSearchFields), searchProxy.SearchField);
                    FillGridViewLog(StateGridViewLog.Fill, toDate, fromDate, searchProxy.SearchValue, searchField);
                }
                else
                {
                    List<object> SelectedList = ASPxGridViewLog.GetSelectedFieldValues("ID");
                    DeleteGritdItem(SelectedList);
                    DateTime fromDate = Utility.ToMildiDate(searchProxy.FromDate);
                    DateTime toDate = Utility.ToMildiDate(searchProxy.ToDate);
                    toDate = new DateTime(toDate.Year, toDate.Month, toDate.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
                    LogSearchFields searchField = (LogSearchFields)Enum.Parse(typeof(LogSearchFields), searchProxy.SearchField);
                    FillGridViewLog(StateGridViewLog.Fill, toDate, fromDate, searchProxy.SearchValue, searchField);
                }
            }
            catch (MyExceptionHandler ex)
            {
                ((ASPxGridView)sender).JSProperties.Add("cpError", ex.Message);
            }
        }
    }
}