using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using Model;
using Business;

namespace WebRest.Admin
{
    public partial class AdminSettings : System.Web.UI.Page
    {
        public JavaScriptSerializer JsSerializer
        {
            get
            {
                return new JavaScriptSerializer();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            App_Code.RefererValidation.CheckReferer();
            if (!IsPostBack)
            {
                FillSettingsPanel();
            }
        }
         public void FillSettingsPanel()
         {
             try
             {
                 wr_ReserveRange wrReserveRangeObj = new BReserveRange().GetReserveRange();
                 if (wrReserveRangeObj != null)
                 {
                     ASPxTextBoxEndDateCount_AdminSettings.Text = wrReserveRangeObj.ReservRange_EndDateCount.ToString();
                     ASPxComboBoxEndDateType_AdminSettings.Items.FindByValue(wrReserveRangeObj.ReservRange_EndDateType.ToString()).Selected=true;
                     ASPxCheckBoxSupplement_AdminSettings.Checked = wrReserveRangeObj.ReservRange_Mokhalafat ?? false;
                     ASPxTextBoxMaxCountReserve_AdminSettings.Text = wrReserveRangeObj.ReservRange_SAGHFRESERVE.ToString();
                 }
                 wr_DynamicReserveRange wrDynamicReserveRange = new BDynamicReservRange().GetDynamicReservRange();
                 if (wrDynamicReserveRange != null)
                 {
                     ASPxTextBoxFromDateCount_AdminSettings.Text = wrDynamicReserveRange.DynamicReservRange_FromDateCount.ToString();
                     ASPxComboBoxFromDateType_AdminSettings.Items.FindByValue(wrDynamicReserveRange.DynamicReservRange_FromDateType.ToString()).Selected=true;
                 }

             }
             catch (Exception ex)
             {
                 
                 throw ex;
             }
         }
        protected void ASPxCallbackUpdateSetting_AdminSettings_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            try
            {

            
            Dictionary<string, object> paramDic = (Dictionary<string, object>) JsSerializer.DeserializeObject(e.Parameter);
            int fromDateCount = Convert.ToInt32(string.IsNullOrEmpty(paramDic["FDCount"].ToString()) ? "0" : paramDic["FDCount"]);
            int fromDateType = Convert.ToInt32(string.IsNullOrEmpty(paramDic["FDType"].ToString()) ? "0" :paramDic["FDType"]);
            int endDateCount = Convert.ToInt32(string.IsNullOrEmpty(paramDic["EDCount"].ToString()) ? "0" :paramDic["EDCount"]);
            int endDateType = Convert.ToInt32(string.IsNullOrEmpty(paramDic["EDType"].ToString()) ? "0" :paramDic["EDType"]);
            bool supplement = Convert.ToBoolean(paramDic["Supplement"]);
            int maxCountReserve = Convert.ToInt32(string.IsNullOrEmpty(paramDic["MaxReserve"].ToString()) ? "0" : paramDic["MaxReserve"]);

            wr_ReserveRange wrReserveRangeObj = new wr_ReserveRange();
            wrReserveRangeObj.ReservRange_EndDateCount = endDateCount;
            wrReserveRangeObj.ReservRange_EndDateType = endDateType;
            wrReserveRangeObj.ReservRange_Mokhalafat = supplement;
            wrReserveRangeObj.ReservRange_SAGHFRESERVE = maxCountReserve;
            bool resultReserveRange = new BReserveRange().InsertReserveRange(wrReserveRangeObj);


            wr_DynamicReserveRange wrDynamicReserveRange = new wr_DynamicReserveRange();
            wrDynamicReserveRange.DynamicReservRange_FromDateCount = fromDateCount;
            wrDynamicReserveRange.DynamicReservRange_FromDateType = fromDateType;
            bool resultDynamicReserveRange = new BDynamicReservRange().InsertDynamicReserveRange(wrDynamicReserveRange);
            MessageHandler messageHandler = new MessageHandler();
            string RetMessage = string.Empty;
            if (resultDynamicReserveRange == true && resultReserveRange == true)
            {
                messageHandler.Type = MessageType.Success.ToString();
                RetMessage = "اطلاعات با موفقیت ثبت شد.";
                messageHandler.Message = RetMessage;
            }
            else
            {
                messageHandler.Type = MessageType.Error.ToString();
                RetMessage = "خطا در ثبت اطلاعات .مجددا سعی نمایید.";
                messageHandler.Message = RetMessage;
            }
            e.Result = this.JsSerializer.Serialize(messageHandler);
            }
            catch (Exception ex)
            {
                MessageHandler messageHandler = new MessageHandler();
                string RetMessage = string.Empty;
                messageHandler.Type = MessageType.Error.ToString();
                RetMessage = ex.Message;
                messageHandler.Message = RetMessage;
                e.Result = this.JsSerializer.Serialize(messageHandler);
                
            }
        }

        protected void ASPxCallbackUpdatePublicMessage_AdminSettings_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            try
            {
                wr_PublicMessage wrPublicMessageObj = new wr_PublicMessage();
                wrPublicMessageObj.Message = e.Parameter;
                wrPublicMessageObj.DateMessage = DateTime.Now;
                bool result = new BWrPublicMessage().InsertNewPublicMessage(wrPublicMessageObj);

                 MessageHandler messageHandler = new MessageHandler();
                string RetMessage = string.Empty;
                if (result == true)
                {
                    messageHandler.Type = MessageType.Success.ToString();
                    RetMessage = "اطلاعات با موفقیت ثبت شد.";
                    messageHandler.Message = RetMessage;
                }
                else
                {
                    messageHandler.Type = MessageType.Error.ToString();
                    RetMessage = "خطا در ثبت اطلاعات .مجددا سعی نمایید.";
                    messageHandler.Message = RetMessage;
                }
                e.Result = this.JsSerializer.Serialize(messageHandler);
            }
            catch (Exception ex)
            {
                MessageHandler messageHandler = new MessageHandler();
                string RetMessage = string.Empty;
                messageHandler.Type = MessageType.Error.ToString();
                RetMessage = ex.Message;
                messageHandler.Message = RetMessage;
                e.Result = this.JsSerializer.Serialize(messageHandler);
                throw ex;
            }
        }
    }
}