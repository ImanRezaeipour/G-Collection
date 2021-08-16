using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Drawing;
using DevExpress.Web.ASPxGridView;
using ASPWebClock.Infrastructure.Business;
using ASPWebclock.AppCode;
using ASPWebClock.DAL.Business;
using System.Web.Script.Serialization;
using System.Data;
using ASPWebClock.Infrastructure.Model;

namespace ASPWebclock.Operation
{
    public partial class DashboardUser : System.Web.UI.Page
    {
        public string ShamsiDate(DateTime MiladiDate)
        {
            PersianCalendar jc = new PersianCalendar();

            DateTime thisDate = MiladiDate;
            return jc.GetYear(thisDate).ToString() + "/" + (jc.GetMonth(thisDate) < 10 ? "0" : "") + jc.GetMonth(thisDate).ToString() + "/" + (jc.GetDayOfMonth(thisDate) < 10 ? "0" : "") + jc.GetDayOfMonth(thisDate).ToString();
        }
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
        public BUser userBussines
        {
            get
            {
                return new BUser();
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            if (!IsPostBack)
            {
                string userBarcode=new BUser().GetBarcodeByUserName(User.Identity.Name);
                FillYearMonthDate(DateTime.Today);
                FillComboPishCardHourly(userBarcode);
                FillComboPishCardDaily(userBarcode);
                FillRemainLeave(ShamsiDate(DateTime.Now),userBarcode);
            }
            FillGridViewRequestsRegistered(ASPxComboBoxYear.SelectedItem.Value.ToString() , ASPxComboBoxMonth.SelectedItem.Value.ToString() ,  ASPxCheckBoxDaily.Checked, ASPxCheckBoxHourly.Checked, ASPxCheckBoxOverTime.Checked);
            ValidateAccessControls();
        }
        private void FillRemainLeave(string dateNow,string barcode)
        {
            int remainLeave=new BValidations().GetRemainLeaveToDayOfEndCurrentMonth(dateNow,barcode);
            int valueDailyToMinute= new BValidations().GetPersonValueDailyLeaveToMinute(barcode);

            int dayRemainLeave = 0;
            int remRemainLeave = 0;
            int hourRemainLeave = 0;
            int MinuteRemainLeave = 0;
            if (valueDailyToMinute != 0)
            {
                 dayRemainLeave = (remainLeave / valueDailyToMinute);
                 remRemainLeave = (remainLeave % valueDailyToMinute);
                 hourRemainLeave = (remRemainLeave / 60);
                 MinuteRemainLeave = (remRemainLeave % 60);
            }
            
            lblRemainLeave.Text = "مانده مرخصی : " + dayRemainLeave + " روز و " + hourRemainLeave + " ساعت و " + MinuteRemainLeave + " دقیقه می باشد. " ;
        }
        private void ValidateAccessControls()
        {
            int userStatus = userBussines.GetUserStatusBywebPassId(Convert.ToInt32(Session["PostID"]));
            PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), userStatus.ToString());
          
            DataTable dtResult = roleBusiness.GetAccessRoleNavbarByUserRoleName(US.ToString());


            for (int i = 0; i < dtResult.Rows.Count; i++)
            {


                if (dtResult.Rows[i]["navbar_Name"].ToString() == "AddNewRequest_DashboardUser")
                {
                    ASPxMenuHeader_DashboardUser.Items.FindByName("AddNewRequest_DashboardUser").Enabled = true;
                }
                if (dtResult.Rows[i]["navbar_Name"].ToString() == "DeleteRequest_DashboardUser")
                {
                    ASPxGridViewRequestsRegistered.Columns["Delete"].Visible = true;
                }

            }
        }
        private void FillComboPishCardDaily(string barcode)
        {

            ASPxComboBoxTrafficTypeDaily.TextField = "Pish_Name";
            ASPxComboBoxTrafficTypeDaily.ValueField = "Pish_Code";
            ASPxComboBoxTrafficTypeDaily.DataSource = requestbusiness.GetPishCardDaily(barcode);
            ASPxComboBoxTrafficTypeDaily.DataBind();
            ASPxComboBoxTrafficTypeDaily.SelectedIndex = 0;

        }


        private void FillComboPishCardHourly(string barcode)
        {
            ASPxComboBoxTrafficTypeHourly.TextField = "Pish_Name";
            ASPxComboBoxTrafficTypeHourly.ValueField = "Pish_Code";
            ASPxComboBoxTrafficTypeHourly.DataSource = requestbusiness.GetPishCardHourly(barcode);
            ASPxComboBoxTrafficTypeHourly.DataBind();
            ASPxComboBoxTrafficTypeHourly.SelectedIndex = 0;
        }
       
        private void FillYearMonthDate(DateTime dateSelected)
        {

            ASPxComboBoxYear.Value =ShamsiDate(dateSelected).Substring(0, 4);
            ASPxComboBoxMonth.Value = ShamsiDate(dateSelected).Substring(5, 2);
        }
        protected void ASPxGridViewRequestsRegistered_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
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
        protected void ASPxCallbackInsertRequestDaily_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {

                if (FromDateDaily.Text == "")
                    throw new Exception("فیلدهای تاریخ را تکمیل نمایید");
                if (ToDateDaily.Text == "")
                    throw new Exception("فیلدهای تاریخ را تکمیل نمایید");
                Dictionary<string, object> InsertRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = userBussines.GetBarcodeByUserName(User.Identity.Name);
                int pishID =Convert.ToInt32( InsertRequestParamsDic["PishID"].ToString());
                string comment = InsertRequestParamsDic["Comment"].ToString();
                string fromdate = FromDateDaily.Text;
                string todate = ToDateDaily.Text;
                            DateTime fromDateMiladi = GTS.Clock.Infrastructure.Utility.Utility.ToMildiDate(fromdate);
                            DateTime toDateMiladi = GTS.Clock.Infrastructure.Utility.Utility.ToMildiDate(todate);
                            TimeSpan ts = toDateMiladi - fromDateMiladi;
                            int countRequest = ts.Days + 1;
                
                            if (ts.Days < 0)
                                throw new Exception("بازه تاریخ اشتباه است.");
                            for (var day = fromDateMiladi; day.Date <= toDateMiladi; day = day.AddDays(1))
                            {
                                RetMessage = requestbusiness.InsertRequestPerson(ShamsiDate(day),ShamsiDate(DateTime.Now) , "", 0, 0, 0, 2, pishID, barcode, comment, 0, 0, "", 0, Session["PostID"].ToString(), 0,countRequest);
                                if (countRequest != 0)
                                    countRequest -= 1;
                                else
                                    countRequest = 0;
                            }
                            
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

                if (DateHourly.Text == "")
                    throw new Exception("فیلد تاریخ را تکمیل نمایید");
                Dictionary<string, object> InsertRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = userBussines.GetBarcodeByUserName(User.Identity.Name);
                int pishID =Convert.ToInt32(InsertRequestParamsDic["PishID"].ToString());
                int fromHour = Convert.ToInt32(InsertRequestParamsDic["FromHour"]);
                int toHour = Convert.ToInt32(InsertRequestParamsDic["ToHour"]);
                string comment = InsertRequestParamsDic["Comment"].ToString();
                string date = DateHourly.Text;
                RetMessage = requestbusiness.InsertRequestPerson(date, ShamsiDate(DateTime.Now), "", fromHour,toHour, 0, 2, pishID, barcode, comment, 0, 0, "", 0, Session["PostID"].ToString(), 0,0);

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
        protected void ASPxCallbackInsertRequestOvertime_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {
                bool resultAgreeOverTime = new BUser().CheckAgreeOverTimeAccess(Session["PostID"].ToString());
                if (resultAgreeOverTime == false)
                {

                    throw new Exception("شما مجوز دسترسی به این قسمت را ندارید.");
                }

                if (DateOverTime.Text == "")
                    throw new Exception("فیلد تاریخ را تکمیل نمایید");
                Dictionary<string, object> InsertRequestParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = userBussines.GetBarcodeByUserName(User.Identity.Name);
                int pishID = Convert.ToInt32(InsertRequestParamsDic["PishID"].ToString());
                int value = Convert.ToInt32(InsertRequestParamsDic["Hour"]);
               string comment = InsertRequestParamsDic["Comment"].ToString();
               string date = DateOverTime.Text;
                if(value==0)
                    throw new Exception("فیلد زمان را تکمیل نمایید");
                RetMessage = requestbusiness.InsertRequestPerson(date, ShamsiDate(DateTime.Now), "", 0, 0, 0, 2, pishID, barcode, comment, 0, 0, "", 0, Session["PostID"].ToString(),value,0);
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
        protected void ASPxGridViewRequestsRegistered_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (ASPxGridViewRequestsRegistered.VisibleRowCount > 0)
            {
                string agreestat = e.GetValue("agree").ToString();

                int firstAgree = Convert.ToInt32(agreestat.ToString().Substring(0, 1));
                int secondAgree = Convert.ToInt32(agreestat.ToString().Substring(1, 1));
                int finalAgree = Convert.ToInt32(agreestat.ToString().Substring(2, 1));
                switch (firstAgree)
                {
                    case 0:
                        e.Row.BackColor = ColorTranslator.FromHtml("#8CA9FF");
                        break;
                    case 1:

                        switch (secondAgree)
                        {
                            case 0:
                                
                                break;
                            case 1:
                                switch (finalAgree)
                                {
                                    case 0:
                                        
                                        break;
                                    case 1:
                                        e.Row.BackColor = ColorTranslator.FromHtml("#9DFF9D");
                                        break;
                                    case 2:
                                        e.Row.BackColor = ColorTranslator.FromHtml("#FFFF6C");
                                        break;
                                    default:
                                        break;
                                }

                                break;
                            case 2:
                                e.Row.BackColor = ColorTranslator.FromHtml("#FFFF6C");
                                break;
                            default:
                                break;
                        }
                        break;
                    case 2:
                        e.Row.BackColor = ColorTranslator.FromHtml("#FFFF6C");
                        break;

                }

            }
            


        }
        private void FillGridViewRequestsRegistered(string year,string month,bool daily,bool Hourly,bool overTime)
        {
            ASPxGridViewRequestsRegistered.DataSource = new BRequest().GetRequestsByBarcodeDate(year + "/" + month + "/",new BUser().GetPersonByUserName(User.Identity.Name).BarCode,daily,Hourly,overTime);
            ASPxGridViewRequestsRegistered.DataBind();

        }

        protected void ASPxGridViewRequestsRegistered_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] DSParams = e.Parameters.Split(';');
            string year = DSParams[0];
            string month = DSParams[1];
            bool daily = Convert.ToBoolean(DSParams[2]);
            bool hourly = Convert.ToBoolean(DSParams[3]);
            bool overTime = Convert.ToBoolean(DSParams[4]);
            FillGridViewRequestsRegistered(year, month, daily, hourly, overTime);
        }
        protected void ASPxCallbackDeleteRequest_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            MessageHandler messageHandler = new MessageHandler();
            string RetMessage = string.Empty;
            try
            {
                string idRowSelected = ASPxGridViewRequestsRegistered.GetRowValues(Convert.ToInt32(e.Parameter), "ID_PK").ToString();
                RetMessage = requestbusiness.DeleteRequestByID(idRowSelected);
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