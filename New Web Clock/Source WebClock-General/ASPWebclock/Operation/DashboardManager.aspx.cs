using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.Infrastructure.Business;
using System.Globalization;
using System.Data;
using ASPWebClock.Infrastructure.Model;
using ASPWebclock.AppCode;


namespace ASPWebclock.Operation
{
   
    public partial class DashboardManager : System.Web.UI.Page
    {
        private struct DashbordCallbackParam
        {
            public ActionType ActionType;
            public bool UnderReview;
            public bool Confirmed;
            public bool Rejected;
            public bool Deleted;
            public string FromDate;
            public string ToDate;
            public string selctedBarcode;
            public string selectedPishcard;
            public List<ConfirmRequestInfo> ListConfirmRequest;


        }
        private enum ActionType
        {
            Filter = 1,
            Confirm = 2,
            Reject = 3,
            Delete = 4
        }
        public string ShamsiDate(DateTime MiladiDate)
        {
            PersianCalendar jc = new PersianCalendar();

            DateTime thisDate = MiladiDate;
            return jc.GetYear(thisDate).ToString() + "/" + (jc.GetMonth(thisDate) < 10 ? "0" : "") + jc.GetMonth(thisDate).ToString() + "/" + (jc.GetDayOfMonth(thisDate) < 10 ? "0" : "") + jc.GetDayOfMonth(thisDate).ToString();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            SessionHandler.CheckSessionTimeOut(Page);
            FillPersonStatus(Convert.ToDecimal(Session["PostID"]),(IList<decimal>)Session["ListPostIDInsteadMan"]);
            FillPersonRequests(Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"], ShamsiDate(DateTime.Now));
        }
        private void FillPersonStatus(decimal webPassid,IList<decimal> ListPostIDInsteadMan)
        {
            lblMangerPerson.Text = new BPerson().GetUnderManagmentPersonnel(webPassid, ListPostIDInsteadMan).Count.ToString() + " نفر";
            lblPersonPersent.Text = (new BPerson().GetUnderManagmentPersonnelPersentNowCount(webPassid, ListPostIDInsteadMan, ShamsiDate(DateTime.Now))).ToString() + " نفر";
            lblPersonLeaveDaily.Text=(new BPerson().GetUnderManagmentPersonnelLeaveDailyCount(webPassid, ListPostIDInsteadMan, ShamsiDate(DateTime.Now))).ToString() + " نفر";
            lblPersonLeaveHourly.Text = (new BPerson().GetUnderManagmentPersonnelLeaveHourlyCount(webPassid, ListPostIDInsteadMan, ShamsiDate(DateTime.Now))).ToString() + " نفر";
        }
        private void FillPersonRequests(decimal webPassid, IList<decimal> ListPostIDInsteadMan,string dateNow)
        {
            DashbordCallbackParam DashbordParam = new DashbordCallbackParam();
            DashbordParam.ActionType = ActionType.Filter;
            DashbordParam.Confirmed = false;
            DashbordParam.Rejected = false;
            DashbordParam.Deleted = false;
            DashbordParam.UnderReview = true;
            DashbordParam.ToDate = "";
            DashbordParam.FromDate="";
            DashbordParam.selctedBarcode = "";
            DashbordParam.selectedPishcard = "All";
            DashbordParam.ListConfirmRequest = null;
            
            int underViewAll =new BRequest().GetPersonRequest(DashbordParam.UnderReview, DashbordParam.Confirmed, DashbordParam.Rejected, DashbordParam.FromDate, DashbordParam.ToDate, Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"], DashbordParam.selctedBarcode,DashbordParam.selectedPishcard).Rows.Count;
            lblPersonRequestsWaitAll.Text = underViewAll.ToString();

            DashbordParam.ToDate = dateNow;
            DashbordParam.FromDate = dateNow.Substring(0, 4) + "/" + dateNow.Substring(5, 2) + "/01";
            int underView = new BRequest().GetPersonRequest(DashbordParam.UnderReview, DashbordParam.Confirmed, DashbordParam.Rejected, DashbordParam.FromDate, DashbordParam.ToDate, Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"], DashbordParam.selctedBarcode, DashbordParam.selectedPishcard).Rows.Count;
            lblPersonRequestsWait.Text = underView.ToString();
            
            DashbordParam.UnderReview = false;
            DashbordParam.Confirmed = true;
            DashbordParam.Rejected = false;

            int confirm = new BRequest().GetPersonRequest(DashbordParam.UnderReview, DashbordParam.Confirmed, DashbordParam.Rejected, DashbordParam.FromDate, DashbordParam.ToDate, Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"], DashbordParam.selctedBarcode, DashbordParam.selectedPishcard).Rows.Count;
            lblPersonRequestsConfirm.Text = confirm.ToString();
            
            DashbordParam.UnderReview = false;
            DashbordParam.Confirmed = false;
            DashbordParam.Rejected = true;
            int reject = new BRequest().GetPersonRequest(DashbordParam.UnderReview, DashbordParam.Confirmed, DashbordParam.Rejected, DashbordParam.FromDate, DashbordParam.ToDate, Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"], DashbordParam.selctedBarcode, DashbordParam.selectedPishcard).Rows.Count;
            lblPersonRequestsReject.Text = reject.ToString();
            
            
        }
        
    }
}