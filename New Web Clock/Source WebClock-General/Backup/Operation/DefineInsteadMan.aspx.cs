using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.Infrastructure.Business;
using System.Web.Script.Serialization;
using System.Data;
using ASPWebclock.AppCode;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.DAL.Business;


namespace ASPWebclock.Operation
{
    public partial class DefineInsteadMan : System.Web.UI.Page
    {
        public BRole roleBusiness
        {
            get
            {
                return new BRole();
            }
        }
        public JavaScriptSerializer JsSerializer
        {
            get
            {
                return new JavaScriptSerializer();
            }
        }
        public StringGenerator createString
        {

            get
            {
                return new StringGenerator();
            }
        }
        public BPerson personBusiness
        {
            get
            {
                return new BPerson();
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
            if (!IsPostBack)
            {
                FillPostOfPerson();
                FillGridViewInsteadMan();
            }
            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).IsCallback)
                FillPersonnelSearchBoxesFromPosBackPaging();
            ValidateAccessControls();
        }
        private void ValidateAccessControls()
        {
            int userStatus = userBussines.GetUserStatusBywebPassId(Convert.ToInt32(Session["PostID"]));
            PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), userStatus.ToString());
            if (Session["ValidateAccessControls_DefineIsteadMan"] == null)
                Session["ValidateAccessControls_DefineIsteadMan"] = roleBusiness.GetAccessRoleNavbarByUserRoleName(US.ToString());
            DataTable dtResult = (DataTable)Session["ValidateAccessControls_DefineIsteadMan"];


            for (int i = 0; i < dtResult.Rows.Count; i++)
            {


                if (dtResult.Rows[i]["navbar_Name"].ToString() == "SaveMenuHeader_DefineInsteadMan")
                {
                    ASPxMenuHeader.Enabled = true;
                }

            }
        }
        
        private void FillPostOfPerson()
        {
            DataTable dtResult = userBussines.GetPostManagersOfPerson(userBussines.GetBarcodeByUserName(User.Identity.Name));
            ASPxComboBoxPostOfPerson.TextField = "PersonPost";
            ASPxComboBoxPostOfPerson.ValueField = "ID";
            ASPxComboBoxPostOfPerson.DataSource = dtResult;
            ASPxComboBoxPostOfPerson.DataBind();
            ASPxComboBoxPostOfPerson.Items.Insert(0,new DevExpress.Web.ASPxEditors.ListEditItem("همه پست ها", "All"));
            ASPxComboBoxPostOfPerson.SelectedItem = ASPxComboBoxPostOfPerson.Items.FindByValue("All");
        }
        private void FillPersonnelSearchBoxesFromPosBackPaging()
        {
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataSource = (IList<ASPWebClock.Infrastructure.Model.Person>)Session["CurrentDataSourceFeatures_GridResultSearchPersonnel"];
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataBind();

        }

        private void FillPersonnelSearchBoxesFromNewKeySearch(string keySearch)
        {
            Session["CurrentDataSourceFeatures_GridResultSearchPersonnel"] = null;
            IList<ASPWebClock.Infrastructure.Model.Person> persons = personBusiness.SearchPersonInfoBayBarcodeNameFamily(createString.CreateString(keySearch));
            Session.Add("CurrentDataSourceFeatures_GridResultSearchPersonnel", persons);
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataSource = (IList<ASPWebClock.Infrastructure.Model.Person>)Session["CurrentDataSourceFeatures_GridResultSearchPersonnel"];
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataBind();

        }
        
        private void FillGridViewInsteadMan()
        {
          
           
           
            ASPxGridViewInsteadMan.DataSource = userBussines.GetInsteadManOfPerson(userBussines.GetBarcodeByUserName(User.Identity.Name), DateTime.Now);
            ASPxGridViewInsteadMan.DataBind();
        }

        protected void ASPxGridViewPersonnelSearch_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            FillPersonnelSearchBoxesFromNewKeySearch(e.Parameters);
        }
        protected void ASPxCallbackUpdateInsteadMan_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            MessageHandler messageHandler = new MessageHandler();
            Dictionary<string, object> obj = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
            string barcode = obj["Barcode"].ToString();
            string postsID = obj["Post"].ToString();
            DateTime fromDate = GTS.Clock.Infrastructure.Utility.Utility.ToMildiDate(JQDatePickerFromDate.Text);
            DateTime toDate = GTS.Clock.Infrastructure.Utility.Utility.ToMildiDate(JQDatePickerToDate.Text);
            try
            {
                string RetMessage = string.Empty;

                if (postsID == "All")
                {
                    DataTable dtResult = userBussines.GetPostManagersOfPerson(userBussines.GetBarcodeByUserName(User.Identity.Name));
                    if (dtResult.Rows.Count == 0)
                        throw new Exception("پستی جهت اختصاص دادن جانشین وجود ندارد.");
                    for (int i = 0; i < dtResult.Rows.Count; i++)
                    {

                        RetMessage = userBussines.UpdateInsteadManPerson(Convert.ToDecimal(dtResult.Rows[i]["ID"].ToString()), barcode, fromDate, toDate);
                    }
                }
                else
                {
                     RetMessage = userBussines.UpdateInsteadManPerson(Convert.ToDecimal(postsID), barcode, fromDate, toDate);
                }
                messageHandler.Type = MessageType.Success.ToString();
                messageHandler.Message = RetMessage;
                e.Result = this.JsSerializer.Serialize(messageHandler);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void ASPxCallbackDeleteInsteadMan_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            MessageHandler messageHandler = new MessageHandler();
            string RetMessage = string.Empty;
            try
            {
                int idRowSelected = Convert.ToInt32(ASPxGridViewInsteadMan.GetRowValues(Convert.ToInt32(e.Parameter), "ID"));
                RetMessage = userBussines.DeleteInsteadManOfPerson(idRowSelected);
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

        protected void ASPxGridViewInsteadMan_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            FillGridViewInsteadMan();
        }

       
    }
}