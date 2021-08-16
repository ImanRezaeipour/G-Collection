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

using System.Drawing;
using System.Collections;
using DevExpress.Web.ASPxClasses;
using ASPWebClock.Infrastructure.Business;
using ASPWebClock.Infrastructure.Model;
using ASPWebclock.AppCode;
using DevExpress.Web.ASPxGridView.Helper;
using DevExpress.Web.ASPxClasses.Internal;
using System.Web;
using ASPWebclock.AppCode;
using ASPWebClock.Infrastructure.Business;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;



namespace ASPWebclock
{
    public partial class Dashbord : System.Web.UI.Page
    {
        private BRequest BReq = new BRequest();

        private enum ActionType
        {
            Filter = 1,
            Confirm = 2,
            Reject = 3,
            Delete=4
        }

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
       
        private class RequestStat
        {
            public string date_ { get; set; }
            public Int32 stat { get; set; }
        }
        List<RequestStat> lrs = new List<RequestStat>();
        public BRole roleBusiness
        {
            get
            {
                return new BRole();
            }
        }
        public BWebpassUser userBussines
        {
            get
            {
                return new BWebpassUser();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionHandler.CheckSessionTimeOut(this.Page);
            RefererValidation.CheckReferer();
           

            if (!this.IsPostBack && !this.IsCallback)
            {
                ToDate.Text = Utility.MiladiToShamsiDate(Utility.GetEndOfPersianMonth(DateTime.Now));
                FromDate.Text = ToDate.Text.Substring(0, 4) + "/" + ToDate.Text.Substring(5, 2) + "/01";
                ValidateAccessControls();
                DashbordCallbackParam DashbordParam=new DashbordCallbackParam();
                if (Request.QueryString["date"] != null)
                {

                    switch (Request.QueryString["date"])
                    {
                        case "selected":
                            {
                                ToDate.Text = Utility.MiladiToShamsiDate(DateTime.Now);
                                FromDate.Text = ToDate.Text.Substring(0, 4) + "/" + ToDate.Text.Substring(5, 2) + "/01";
                                break;
                            }
                        case "all":
                            {
                                ToDate.Text = "";
                                FromDate.Text = "";
                                break;
                            }
                        default:
                            break;
                    }

                                if (Request.QueryString["Filter"] != null)
                                {
                                    switch (Request.QueryString["Filter"])
                                    {
                                        case "Confirm":
                                            {
                                                DashbordParam = SpilitDashbordCallbackParam("1;false;true;false;false;;All;All");
                                                ASPxRadioButtonListFilterView.SelectedIndex = 1;
                                                break;
                                            }
                                        case "UnderView":
                                            {
                                                DashbordParam = SpilitDashbordCallbackParam("1;true;false;false;false;;All;All");
                                                ASPxRadioButtonListFilterView.SelectedIndex = 0;
                                                break;
                                            }
                                        case "Reject":
                                            {
                                                DashbordParam = SpilitDashbordCallbackParam("1;false;false;true;false;;All;All");
                                                ASPxRadioButtonListFilterView.SelectedIndex = 2;
                                                break;
                                            }
                                        default:
                                            {
                                                DashbordParam = SpilitDashbordCallbackParam("1;true;false;false;false;;All;All");
                                                break;
                                            }
                                    }
                                }


                     
                }
                else
                {
                    DashbordParam = SpilitDashbordCallbackParam("1;true;false;false;false;;All;All");
                }
            

                
                this.Session["DashbordParam"] = DashbordParam;
                this.DashbordGridFilter(DashbordParam);
                FillUnderManagmentPersonnel(Convert.ToDecimal(Session["PostID"]), "NewLoad");
                FillPishcard(Convert.ToDecimal(Session["PostID"]));
                ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditUnderMangmentPerson.FindControl("ASPxGridView5")).FocusedRowIndex = -1;
                ((DevExpress.Web.ASPxEditors.ASPxCheckBox)ASPxDropDownEditUnderMangmentPerson.FindControl("ASPxCheckBoxSelectAllPerson")).Checked = true;
            }
            if (DashbordsGridView.IsCallback)
            {
               
                if (Session["PersonRequest_PersonRequestDashboard"] != null)
                {
                    DashbordsGridView.DataSource = (DataTable)Session["PersonRequest_PersonRequestDashboard"];
                    DashbordsGridView.DataBind();
                }
            }
            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditUnderMangmentPerson.FindControl("ASPxGridView5")).IsCallback)
                FillUnderManagmentPersonnel(Convert.ToDecimal(Session["PostID"].ToString()),"Callback");
        }
        private void FillUnderManagmentPersonnel(decimal webPassID,string state)
        {
            if (state == "NewLoad")
            {
                Session["UnserMangmentPerson_Dashboard"] = null;
            }
            if (Session["UnserMangmentPerson_Dashboard"] == null)
            {
                Session["UnserMangmentPerson_Dashboard"] = new BPerson().GetUnderManagmentPersonnel(webPassID, (IList<decimal>)Session["ListPostIDInsteadMan"]);
                
            }
            
                ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditUnderMangmentPerson.FindControl("ASPxGridView5")).DataSource =Session["UnserMangmentPerson_Dashboard"];
                ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditUnderMangmentPerson.FindControl("ASPxGridView5")).DataBind();
               
            
            
            
        }
        private void FillPishcard(decimal webPassID)
        {
            try
            {

            
            if (Session["Pishcards_Dashboard"] == null)
            {
                Session["Pishcards_Dashboard"] = new BPishcard().GetActivePishCardUserAccessAllowed(webPassID);

            }

            ASPxComboBoxPishcard.DataSource = Session["Pishcards_Dashboard"];
            ASPxComboBoxPishcard.TextField = "Name";
            ASPxComboBoxPishcard.ValueField = "Code";
            ASPxComboBoxPishcard.DataBind();
            ASPxComboBoxPishcard.Items.Insert (0,new ListEditItem("همه درخواست ها", "All"));
            ASPxComboBoxPishcard.SelectedItem = ASPxComboBoxPishcard.Items.FindByValue("All");

            }
            catch (Exception ex)
            {

                throw ex;
            }



        }
        protected void cbAll_Init(object sender, EventArgs e)
        {

            ASPxCheckBox chk = sender as ASPxCheckBox;

            ASPxGridView grid = (chk.NamingContainer as GridViewHeaderTemplateContainer).Grid;

            chk.Checked = (grid.Selection.Count == grid.VisibleRowCount);

        }
        private void ValidateAccessControls()
        {
            try
            {

            
            List<int> listUserInsteadManStatus = new List<int>();
            IList<decimal> ListPostIDInsteadMan = (IList<decimal>)Session["ListPostIDInsteadMan"];
            for (int i = 0; i < ListPostIDInsteadMan.Count; i++)
            {
                int userStatus = userBussines.GetUserStatusBywebPassId(ListPostIDInsteadMan[i]);
                if (!listUserInsteadManStatus.Any(status => status == userStatus))
                    listUserInsteadManStatus.Add(userStatus);
            }
            for (int k = 0; k < listUserInsteadManStatus.Count; k++)
            {
                PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), listUserInsteadManStatus[k].ToString());
                DataTable dtResult = roleBusiness.GetAccessRoleNavbarByUserRoleName(US.ToString());

                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    if (ASPxButton3_Dashbord.ID == dtResult.Rows[i]["navbar_Name"].ToString())
                    {
                        ASPxButton3_Dashbord.ClientEnabled = true;
                    }
                    if (ASPxButton4_Dashbord.ID == dtResult.Rows[i]["navbar_Name"].ToString())
                    {
                        ASPxButton4_Dashbord.ClientEnabled = true;
                    }
                    if (ASPxButtonDelete_Dashbord.ID == dtResult.Rows[i]["navbar_Name"].ToString())
                    {
                        ASPxButtonDelete_Dashbord.ClientEnabled = true;
                    }

                }
            }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void DashbordsCallbackPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            
        }

        private DashbordCallbackParam SpilitDashbordCallbackParam(string Dashborparams)
        {
            DashbordCallbackParam Result = new DashbordCallbackParam();
            string[] DSParams = Dashborparams.Split(';');
            Result.ActionType = (ActionType)Convert.ToInt32(DSParams[0]);
            Result.UnderReview = Convert.ToBoolean(DSParams[1]);
            Result.Confirmed = Convert.ToBoolean(DSParams[2]);
            Result.Rejected = Convert.ToBoolean(DSParams[3]);
            Result.Deleted = Convert.ToBoolean(DSParams[4]);
            Result.FromDate = FromDate.Text;
            Result.ToDate = ToDate.Text;
            if (DSParams[5] != "undefined" && DSParams[5] != "")
            {
                Result.ListConfirmRequest = new List<ConfirmRequestInfo>();
                foreach (string id in DSParams[5].Split(','))
                {
                    if (id != "")
                    {
                       decimal managerId= Convert.ToDecimal(DashbordsGridView.GetRowValues(DashbordsGridView.FindVisibleIndexByKeyValue(id),"ManagerID"));
                        ConfirmRequestInfo confirmItem=new ConfirmRequestInfo();
                        confirmItem.ManagerID=managerId;
                        confirmItem.RequestID=Convert.ToDecimal(id);
                        confirmItem.StatusID=new BWebpassUser().GetUserStatusBywebPassId(managerId);
                        Result.ListConfirmRequest.Add(confirmItem);
                    }
                }
            }
            Result.selctedBarcode = DSParams[6].ToString();
            Result.selectedPishcard = DSParams[7].ToString();
            return Result;
        }

        private void DashbordGridFilter(DashbordCallbackParam DashbordParam)
        {
            try
            {

           
            DashbordGridViewDataBind(DashbordParam);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private string DashbordGridConfirm(DashbordCallbackParam DashbordParam)
        {
            try
            {

           
            string Result = "";
           
            decimal userWebPassID =Convert.ToDecimal(Session["PostID"]);

            Person prs = (new BWebpassUser()).GetPersonByPostID(Convert.ToInt32(Session["PostID"]));
            Result = BReq.ConfirmPersonRequest(prs, DashbordParam.ListConfirmRequest, userWebPassID);
            DashbordGridViewDataBind(DashbordParam);
            return Result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private string DashbordGridReject(DashbordCallbackParam DashbordParam)
        {
            try
            {

            
            string Result = "";
            Person prs = (new BWebpassUser()).GetPersonByPostID(Convert.ToInt32(Session["PostID"]));
            Result = BReq.RejectPersonRequest(prs, DashbordParam.ListConfirmRequest);
            DashbordGridViewDataBind(DashbordParam);
            return Result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private string DashbordGridDelete(DashbordCallbackParam DashbordParam)
        {
            try
            {

            
            string Result = "";
            Person prs = (new BWebpassUser()).GetPersonByPostID(Convert.ToInt32(Session["PostID"]));
            Result = BReq.DeleteRequestCartable(prs, DashbordParam.ListConfirmRequest);
            DashbordGridViewDataBind(DashbordParam);
            return Result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void DashbordsGridView_PageIndexChanged(object sender, EventArgs e)
        {
            object DashbordParamObj = this.Session["DashbordParam"];
            if (DashbordParamObj != null)
            {
                DashbordCallbackParam DashbordParam = (DashbordCallbackParam)DashbordParamObj;
                DashbordGridFilter(DashbordParam);
            }
        }

        private void DashbordGridViewDataBind(DashbordCallbackParam DashbordParam)
        {
            try
            {

           
            DataTable dtResult = BReq.GetPersonRequest(DashbordParam.UnderReview, DashbordParam.Confirmed, DashbordParam.Rejected, DashbordParam.FromDate, DashbordParam.ToDate, Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"],DashbordParam.selctedBarcode,DashbordParam.selectedPishcard);
            Session.Add("PersonRequest_PersonRequestDashboard", dtResult);
            DashbordsGridView.DataSource =(DataTable)Session["PersonRequest_PersonRequestDashboard"];
            DashbordsGridView.DataBind();
            DashbordsGridView.Settings.ShowVerticalScrollBar = false;
            DashbordsGridView.Settings.ShowHorizontalScrollBar = false;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void DashbordsGridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {

          
            string Result = "";
           

            DashbordCallbackParam DashbordParam = SpilitDashbordCallbackParam(e.Parameters);
            this.Session["DashbordParam"] = DashbordParam;

            switch (DashbordParam.ActionType)
            {
                case ActionType.Filter:
                    DashbordGridFilter(DashbordParam);
                    
                    break;
                case ActionType.Confirm:
                    Result = DashbordGridConfirm(DashbordParam);
                   DashbordsGridView.JSProperties.Add("cpCallbackMsg", Result);
                 
                    break;
                case ActionType.Reject:
                    Result = DashbordGridReject(DashbordParam);
                    DashbordsGridView.JSProperties.Add("cpCallbackMsg", Result);
                    break;
                case ActionType.Delete:
                    Result = DashbordGridDelete(DashbordParam);
                    DashbordsGridView.JSProperties.Add("cpCallbackMsg", Result);
                    break;
            }
            DashbordsGridView.Selection.UnselectAll();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

    }
}