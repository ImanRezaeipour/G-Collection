using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.Infrastructure;
using ASPWebClock.Infrastructure.Business;
using System.Web.Script.Serialization;
using ASPWebclock.AppCode;
using ASPWebClock.Infrastructure.Model;
using System.Data;
using DevExpress.Web.ASPxNavBar;
using ASPWebClock.Infrastructure.Repository;

namespace ASPWebclock.Operator
{
    public partial class TrafficRequestOperator : System.Web.UI.Page
    {
        public JavaScriptSerializer JsSerializer
        {
            get
            {
                return new JavaScriptSerializer();
            }
        }
        public BPerson personBusiiness
        {
            get
            {
                return new BPerson();
            }
        }
        public BRequest requestbusiness
        {
            get
            {
                return new BRequest();
            }
        }
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
        public BPishcard pishcardBussines
        {
            get
            {
                return new BPishcard();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            SessionHandler.CheckSessionTimeOut(Page);
            decimal webPassID = Convert.ToDecimal(Session["PostID"]);
            IList<decimal> ListPostIDInsteadMan = (IList<decimal>)Session["ListPostIDInsteadMan"];
            if (!IsPostBack)
            {
                Person personObj = (Person)Session["PersonObj"];
                

                FillGridPersonnelDaily(webPassID,ListPostIDInsteadMan);
                FillGridPersonnelHourlyPermit(webPassID, ListPostIDInsteadMan);
                FillGridPersonnelHourlyTraffic(webPassID, ListPostIDInsteadMan);
                FillComboPishCardHourlyPermit(personObj.Barcode);
                FillComboPishCardDaily(personObj.Barcode);
                FillComboPishCardHourlyTraffic(personObj.Barcode);
                FillYearMonthDatesControlstoCurrentDate();
                ValidateAccessControls();
            }
            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelDaily.FindControl("ASPxGridViewPersonnelDaily")).IsCallback)
                FillGridPersonnelDaily(webPassID, ListPostIDInsteadMan);
            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelHourlyPermit.FindControl("ASPxGridViewPersonnelHourlyPermit")).IsCallback)
                FillGridPersonnelHourlyPermit(webPassID, ListPostIDInsteadMan);
            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownPersonnelHourlyTraffic.FindControl("ASPxGridViewPersonnelHourlyTraffic")).IsCallback)
                FillGridPersonnelHourlyTraffic(webPassID, ListPostIDInsteadMan);
            if (ASPxDropDownEditPersonnelDaily.IsCallback)
                FillGridTrafficDaily();
            if (ASPxGridViewRequestHourlyPermit.IsCallback)
                FillGridTrafficHourlyPermit();
            if (ASPxGridViewRequestHourlyTraffic.IsCallback)
                FillGridTrafficHourlyTraffic();
            if (ASPxGridViewRequestDaily.IsCallback)
                FillGridTrafficDaily();
            if (ASPxGridViewRequestHourlyPermit.IsCallback)
                FillGridTrafficHourlyPermit();
            if (ASPxGridViewRequestHourlyTraffic.IsCallback)
                FillGridTrafficHourlyTraffic();
        }
        private void ValidateAccessControls()
        {
            int userStatus = userBussines.GetUserStatusBywebPassId(Convert.ToDecimal(Session["PostID"]));
            PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), userStatus.ToString());
            DataTable dtResult = roleBusiness.GetAccessRoleNavbarByUserRoleName(US.ToString());
            
            for (int i = 0; i < dtResult.Rows.Count; i++)
            {
                for (int j = 0; j < ASPxMenuHeaderDaily_TrafficRequestOperator.Items.Count; j++)
                {
                    if (ASPxMenuHeaderDaily_TrafficRequestOperator.Items[j].Name == dtResult.Rows[i]["navbar_Name"].ToString())
                    {
                        ASPxMenuHeaderDaily_TrafficRequestOperator.Items.FindByName(dtResult.Rows[i]["navbar_Name"].ToString()).Enabled = true;
                    }
                    if (ASPxMenuHeaderHourlyPermit_TrafficRequestOperator.Items[j].Name == dtResult.Rows[i]["navbar_Name"].ToString())
                    {
                        ASPxMenuHeaderHourlyPermit_TrafficRequestOperator.Items.FindByName(dtResult.Rows[i]["navbar_Name"].ToString()).Enabled = true;
                    }
                    if (ASPxMenuHeaderHourlyTraffic_TrafficRequestOperator.Items[j].Name == dtResult.Rows[i]["navbar_Name"].ToString())
                    {
                        ASPxMenuHeaderHourlyTraffic_TrafficRequestOperator.Items.FindByName(dtResult.Rows[i]["navbar_Name"].ToString()).Enabled = true;
                    }
                }

               
                
            }
           
        }
 public void FillYearMonthDatesControlstoCurrentDate()
        {
            string currentYear=ASPWebClock.Infrastructure.Utility.PersianDateTime.ShamsiDate(DateTime.Now).Substring(0, 4);
            string currentMonth=ASPWebClock.Infrastructure.Utility.PersianDateTime.ShamsiDate(DateTime.Now).Substring(5, 2);
            ASPxComboBoxYearDaily.Value =currentYear ;
            ASPxComboBoxMonthDaily.Value =currentMonth ;
            ASPxComboBoxYearHourlyPermit.Value = currentYear;
            ASPxComboBoxMonthHourlyPermit.Value = currentMonth;
            ASPxComboBoxYearHourlyTraffic.Value = currentYear;
            ASPxComboBoxMonthHourlyTraffic.Value = currentMonth;
        }


        protected void ASPxGridViewRequestDaily_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            Dictionary<string, object> RequestSerachParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameters);
            string barcode = RequestSerachParamsDic["Barcode"].ToString();
            string month = RequestSerachParamsDic["Month"].ToString();
            string year = RequestSerachParamsDic["Year"].ToString();
            Session.Add("CurrentDatatSourceGridViewRequestDaily",requestbusiness.GetPersonnelTrafficDailyByDate(barcode, month, year));

            ASPxGridViewRequestDaily.DataSource = (System.Data.DataTable)Session["CurrentDatatSourceGridViewRequestDaily"];
            ASPxGridViewRequestDaily.DataBind();

        }
        private void FillGridTrafficDaily()
        {
            if (Session["CurrentDatatSourceGridViewRequestDaily"] != null)
            {
                ASPxGridViewRequestDaily.DataSource = (System.Data.DataTable)Session["CurrentDatatSourceGridViewRequestDaily"];
                ASPxGridViewRequestDaily.DataBind();

            }
        }
        private void FillGridTrafficHourlyPermit()
        {
            if (Session["CurrentDatatSourceGridViewRequestHourlyPermit"] != null)
            {
                ASPxGridViewRequestHourlyPermit.DataSource = (System.Data.DataTable)Session["CurrentDatatSourceGridViewRequestHourlyPermit"];
               ASPxGridViewRequestHourlyPermit.DataBind();

            }
        }
        private void FillGridTrafficHourlyTraffic()
        {
            if (Session["CurrentDatatSourceGridViewRequestHourlyTraffic"] != null)
            {
                ASPxGridViewRequestHourlyTraffic.DataSource = (System.Data.DataTable)Session["CurrentDatatSourceGridViewRequestHourlyTraffic"];
                ASPxGridViewRequestHourlyTraffic.DataBind();

            }
        }
        private void FillGridPersonnelDaily(decimal webPassID,IList<decimal> listInsteadMan)
        {
            List<Person> personList = new BPerson().GetUnderManagmentPersonnel(webPassID, listInsteadMan);
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelDaily.FindControl("ASPxGridViewPersonnelDaily")).DataSource = personList;
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelDaily.FindControl("ASPxGridViewPersonnelDaily")).DataBind();

        }
        private void FillGridPersonnelHourlyPermit(decimal webPassID, IList<decimal> listInsteadMan)
        {
            List<Person> personList = new BPerson().GetUnderManagmentPersonnel(webPassID, listInsteadMan);
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelHourlyPermit.FindControl("ASPxGridViewPersonnelHourlyPermit")).DataSource = personList;
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelHourlyPermit.FindControl("ASPxGridViewPersonnelHourlyPermit")).DataBind();
        }
        private void FillGridPersonnelHourlyTraffic(decimal webPassID, IList<decimal> listInsteadMan)
        {
            List<Person> personList = new BPerson().GetUnderManagmentPersonnel(webPassID, listInsteadMan);
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownPersonnelHourlyTraffic.FindControl("ASPxGridViewPersonnelHourlyTraffic")).DataSource = personList;
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownPersonnelHourlyTraffic.FindControl("ASPxGridViewPersonnelHourlyTraffic")).DataBind();
        }
        protected void ASPxGridViewRequestHourly_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            Dictionary<string, object> RequestSearchParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameters);
            string barcode = RequestSearchParamsDic["Barcode"].ToString();
            string month = RequestSearchParamsDic["Month"].ToString();
            string year = RequestSearchParamsDic["Year"].ToString();
            Session.Add("CurrentDatatSourceGridViewRequestHourlyPermit", requestbusiness.GetPersonnelTrafficHourlyPermitByDate(barcode, month, year));

            ASPxGridViewRequestHourlyPermit.DataSource = (System.Data.DataTable)Session["CurrentDatatSourceGridViewRequestHourlyPermit"];
            ASPxGridViewRequestHourlyPermit.DataBind();
        }

        
        private void FillComboPishCardDaily(string barcode)
        {
            
            ASPxComboBoxTrafficTypeDaily.TextField = "Name";
            ASPxComboBoxTrafficTypeDaily.ValueField = "Code";
            ASPxComboBoxTrafficTypeDaily.DataSource = pishcardBussines.GetPishCardDailyPerson(barcode);
            ASPxComboBoxTrafficTypeDaily.DataBind();
            ASPxComboBoxTrafficTypeDaily.SelectedIndex = 0;

            ASPxComboBoxTrafficTypeEditDaily.TextField = "Name";
            ASPxComboBoxTrafficTypeEditDaily.ValueField = "Code";
            ASPxComboBoxTrafficTypeEditDaily.DataSource = pishcardBussines.GetPishCardDailyPerson(barcode);
            ASPxComboBoxTrafficTypeEditDaily.DataBind();
        }

      
        private void FillComboPishCardHourlyPermit(string barcode)
        {
            ASPxComboBoxTrafficTypeHourlyPermit.TextField = "Name";
            ASPxComboBoxTrafficTypeHourlyPermit.ValueField = "Code";
            ASPxComboBoxTrafficTypeHourlyPermit.DataSource = pishcardBussines.GetPishCardHourlyPermitPerson(barcode);
            ASPxComboBoxTrafficTypeHourlyPermit.DataBind();
            ASPxComboBoxTrafficTypeHourlyPermit.SelectedIndex = 0;
        }
        private void FillComboPishCardHourlyTraffic(string barcode)
        {
            ASPxComboBoxTrafficTypeHourlyTraffic.TextField = "Name";
            ASPxComboBoxTrafficTypeHourlyTraffic.ValueField = "Code";
            ASPxComboBoxTrafficTypeHourlyTraffic.DataSource = pishcardBussines.GetPishCardHourlyTrafficPerson(barcode);
            ASPxComboBoxTrafficTypeHourlyTraffic.DataBind();
            ASPxComboBoxTrafficTypeHourlyTraffic.SelectedIndex = 0;
        }
        
        protected void ASPxCallbackInsertRequestDaily_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {


                Dictionary<string, object> InsertRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = InsertRequestParamsDic["Barcode"].ToString();
                string pishID = InsertRequestParamsDic["PishID"].ToString();
                string fromdate = InsertRequestParamsDic["FromDate"].ToString();
                string todate = InsertRequestParamsDic["ToDate"].ToString();
                string comment = InsertRequestParamsDic["Comment"].ToString();
                string barcodeOperator = new WebpassUserRepository().GetPersonByUserName(this.User.Identity.Name).Family;
                int Change = 2;
                int Readers = 0;
                int time = 720;
                
                string mode = InsertRequestParamsDic["Mode"].ToString();
                switch (mode)
                {
                    case "InsertOne":
                        {
                            RetMessage = requestbusiness.InsertRequestDialyByOperator(barcode, pishID, fromdate, comment, barcodeOperator, Change, Readers, time);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            break;
                        }
                    case "InsertAll":
                        {
                            fromdate = FromDateDaily.Text;
                            todate = ToDateDaily.Text;
                            RetMessage = requestbusiness.InsertAllRequestDialyByOperator(barcode, pishID, fromdate,todate, comment, barcodeOperator, Change, Readers, time);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            
                            break;
                        }
                    case "Edit":
                        {
                            int indexGrid = Convert.ToInt32(InsertRequestParamsDic["IndexGrid"]);
                            string oldPishId = ASPxGridViewRequestDaily.GetRowValues(indexGrid, "PishID").ToString();
                            string oldDate = ASPxGridViewRequestDaily.GetRowValues(indexGrid, "Dates").ToString();
                            RetMessage = requestbusiness.EditRequestDialyByOperator(barcode, pishID, fromdate,comment, barcodeOperator, Change, Readers, time,oldPishId,oldDate);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            break;
                        }
                    default:
                        break;
                }
               
            }
            catch (Exception ex)
            {

                messageHandler.Type = MessageType.Error.ToString();
                messageHandler.Message = ex.Message;
                e.Result = this.JsSerializer.Serialize(messageHandler);
            }


        }

       

        protected void ASPxComboBoxDateDaily_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
                        ASPxComboBoxDateDaily.Items.Clear();
           
                        if (FromDateDaily.Text == "")
                            throw new Exception("فیلدهای تاریخ را تکمیل نمایید");
                        if (ToDateDaily.Text == "")
                            throw new Exception("فیلدهای تاریخ را تکمیل نمایید");
                       
                        string fromDate = FromDateDaily.Text;
                        string toDate = ToDateDaily.Text;
                        DateTime enfromDate = ASPWebClock.Infrastructure.Utility.PersianDateTime.Shamsi2Miladi(fromDate);
                        DateTime entoDate = ASPWebClock.Infrastructure.Utility.PersianDateTime.Shamsi2Miladi(toDate);
                        for (var i = enfromDate.Date; i.Date <= entoDate.Date; i = i.AddDays(1))
                        {
                            ASPxComboBoxDateDaily.Items.Add(ASPWebClock.Infrastructure.Utility.PersianDateTime.MiladiToShamsi(i), ASPWebClock.Infrastructure.Utility.PersianDateTime.MiladiToShamsi(i));
                        }
                        ASPxComboBoxDateDaily.SelectedIndex = 0;
                    
             
            
        }

        protected void ASPxGridViewRequestSelectedDateDaily_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            Dictionary<string, object> GridParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameters);
            string date = GridParamsDic["Date"].ToString();
            string barcode = GridParamsDic["Barcode"].ToString();
            ASPxGridViewRequestSelectedDateDaily.DataSource = requestbusiness.GetTrafficPersonnelBySelectedDate(barcode, date);
            ASPxGridViewRequestSelectedDateDaily.DataBind();
        }

        protected void ASPxCallbackDeleteRequestDaily_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {


                Dictionary<string, object> DeleteRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = DeleteRequestParamsDic["Barcode"].ToString();
                string pishID = DeleteRequestParamsDic["PishID"].ToString();
                string date = DeleteRequestParamsDic["Date"].ToString();
                string time = DeleteRequestParamsDic["Time"].ToString();
                string reader = DeleteRequestParamsDic["Reader"].ToString();
                
                
                RetMessage = requestbusiness.DeleteRequestDialyByOperator(barcode, pishID, date, time, reader);
                messageHandler.Type = MessageType.Success.ToString();
                messageHandler.Message = RetMessage;
                e.Result = this.JsSerializer.Serialize(messageHandler);

            }
            catch (Exception ex)
            {

                messageHandler.Type = MessageType.Error.ToString();
                messageHandler.Message = ex.Message;
                e.Result = this.JsSerializer.Serialize(messageHandler);
            }
        }

        protected void ASPxCallbackInsertRequestHourly_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {

                
                Dictionary<string, object> InsertRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = InsertRequestParamsDic["Barcode"].ToString();
                string pishID = InsertRequestParamsDic["PishID"].ToString();
                int fromHour = Convert.ToInt32(InsertRequestParamsDic["FromHour"]);
                int toHour =Convert.ToInt32(InsertRequestParamsDic["ToHour"]);
                string comment = InsertRequestParamsDic["Comment"].ToString();
                //string Operator = new ASPWebClock.DAL.Repository.UserRepository().GetPersonByUserName(this.User.Identity.Name).Family;
                string Operator = new ASPWebClock.Infrastructure.Business.BWebpassUser().GetPersonByUserName(this.User.Identity.Name).Family;
                int Change = 1;
                int Readers = 0;
                string date = DateHourlyPermit.Text;
                string mode = InsertRequestParamsDic["Mode"].ToString();
                
                switch (mode)
                {
                    case "Add":
                        {
                            RetMessage = requestbusiness.InsertRequestHourlyPermitByOperator(barcode, pishID, date, comment, Operator, Change, Readers, fromHour, toHour);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            break;
                        }
                    case "Edit":
                        {
                            int indexGrid = Convert.ToInt32(InsertRequestParamsDic["IndexGrid"].ToString());
                            string oldPishId = ASPxGridViewRequestHourlyPermit.GetRowValues(indexGrid,"PishID").ToString();
                            int oldFromTime = (Convert.ToInt32(ASPxGridViewRequestHourlyPermit.GetRowValues(indexGrid, "FromTime").ToString().Substring(0, 2)) * 60) + Convert.ToInt32(ASPxGridViewRequestHourlyPermit.GetRowValues(indexGrid, "FromTime").ToString().Substring(3, 2));
                            int oldToTime = (Convert.ToInt32(ASPxGridViewRequestHourlyPermit.GetRowValues(indexGrid, "ToTime").ToString().Substring(0, 2)) * 60) + Convert.ToInt32(ASPxGridViewRequestHourlyPermit.GetRowValues(indexGrid, "ToTime").ToString().Substring(3, 2));
                            string oldDate = ASPxGridViewRequestHourlyPermit.GetRowValues(indexGrid, "Dates").ToString();
                            RetMessage = requestbusiness.EditRequestHourlyPermitByOperator(barcode, pishID, date, comment, Operator, Change, Readers, fromHour, toHour,oldPishId,oldFromTime,oldToTime,oldDate);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            break;
                        }
                    default:
                        break;
                }   
                     
              

            }
            catch (Exception ex)
            {

                messageHandler.Type = MessageType.Error.ToString();
                messageHandler.Message = ex.Message;
                e.Result = this.JsSerializer.Serialize(messageHandler);
            }
        }

        protected void ASPxCallbackDeleteRequestHourlyPermit_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {


                Dictionary<string, object> DeleteRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = DeleteRequestParamsDic["Barcode"].ToString();
                string pishID = DeleteRequestParamsDic["PishID"].ToString();
                string date = DeleteRequestParamsDic["Date"].ToString();
                string fromTime = DeleteRequestParamsDic["FromTime"].ToString();
                string toTime = DeleteRequestParamsDic["ToTime"].ToString();
                
                            RetMessage = requestbusiness.DeleteRequestHourlyPermitByOperator(barcode, pishID, date, fromTime, toTime);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                   

                

            }
            catch (Exception ex)
            {

                messageHandler.Type = MessageType.Error.ToString();
                messageHandler.Message = ex.Message;
                e.Result = this.JsSerializer.Serialize(messageHandler);
            }
        }

        protected void ASPxGridViewRequestHourlyTraffic_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            Dictionary<string, object> RequestSearchParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameters);
            string barcode = RequestSearchParamsDic["Barcode"].ToString();
            string month = RequestSearchParamsDic["Month"].ToString();
            string year = RequestSearchParamsDic["Year"].ToString();
            Session.Add("CurrentDatatSourceGridViewRequestHourlyTraffic", requestbusiness.GetPersonnelTrafficHourlyTrafficByDate(barcode, month, year));

            ASPxGridViewRequestHourlyTraffic.DataSource = (System.Data.DataTable)Session["CurrentDatatSourceGridViewRequestHourlyTraffic"];
            ASPxGridViewRequestHourlyTraffic.DataBind();
        }

        protected void ASPxCallbackInsertRequestHourlyTraffic_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {
                Dictionary<string, object> InsertRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = InsertRequestParamsDic["Barcode"].ToString();
                string pishID = InsertRequestParamsDic["PishID"].ToString();
                int fromHour = Convert.ToInt32(InsertRequestParamsDic["FromHour"]);
                int toHour = Convert.ToInt32(InsertRequestParamsDic["ToHour"]);
                string comment = InsertRequestParamsDic["Comment"].ToString();
                string Operator = new WebpassUserRepository().GetPersonByUserName(this.User.Identity.Name).Family;
                int Change = 1;
                int Readers = 0;
                string date = DateHourlyTraffic.Text;
                string mode = InsertRequestParamsDic["Mode"].ToString();
                

                switch (mode)
                {
                    case "Add":
                        {
                            RetMessage = requestbusiness.InsertRequestHourlyTrafficByOperator(barcode, pishID, date, comment, Operator, Change, Readers, fromHour, toHour);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            break;
                        }
                    case "Edit":
                        {
                            int indexGrid = Convert.ToInt32(InsertRequestParamsDic["IndexGrid"].ToString());
                            string oldPishId = ASPxGridViewRequestHourlyTraffic.GetRowValues(indexGrid, "PishID").ToString();
                            int oldTime = (Convert.ToInt32(ASPxGridViewRequestHourlyTraffic.GetRowValues(indexGrid, "Times").ToString().Substring(0, 2)) * 60) + Convert.ToInt32(ASPxGridViewRequestHourlyTraffic.GetRowValues(indexGrid, "Times").ToString().Substring(3, 2));
                            string oldDate = ASPxGridViewRequestHourlyTraffic.GetRowValues(indexGrid, "Dates").ToString();
                            RetMessage = requestbusiness.EditRequestHourlyTrafficByOperator(barcode, pishID, date, comment, Operator, Change, Readers, fromHour,oldPishId,oldTime,oldDate);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);

                            break;
                        }
                    default:
                        break;
                }


                



            }
            catch (Exception ex)
            {

                messageHandler.Type = MessageType.Error.ToString();
                messageHandler.Message = ex.Message;
                e.Result = this.JsSerializer.Serialize(messageHandler);
            }
        }

        protected void ASPxCallbackDeleteRequestHourlyTraffic_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {
                Dictionary<string, object> InsertRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = InsertRequestParamsDic["Barcode"].ToString();
                string pishID = InsertRequestParamsDic["PishID"].ToString();
                string date = InsertRequestParamsDic["Date"].ToString();
                string time = InsertRequestParamsDic["Time"].ToString();
                string reader = InsertRequestParamsDic["Reader"].ToString();


                RetMessage = requestbusiness.DeleteRequestHourlyTrafficByOperator(barcode, pishID, date, time, reader);
                messageHandler.Type = MessageType.Success.ToString();
                messageHandler.Message = RetMessage;
                e.Result = this.JsSerializer.Serialize(messageHandler);

            }
            catch (Exception ex)
            {

                messageHandler.Type = MessageType.Error.ToString();
                messageHandler.Message = ex.Message;
                e.Result = this.JsSerializer.Serialize(messageHandler);
            }
        }

        
    }
}