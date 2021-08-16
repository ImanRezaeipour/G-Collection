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
    public partial class AdminDefineUsers : System.Web.UI.Page
    {
        enum LoadState
        {
            View,
            Add,
            Edit,
            Delete
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
        public BWrUsers wrUserBusiness
        {

            get
            {
                return new BWrUsers();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
          
            App_Code.RefererValidation.CheckReferer();
            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).IsCallback)
                FillPersonnelSearchBoxesFromNewKeySearch("","Callback");
        }


        

        private void FillPersonnelSearchBoxesFromNewKeySearch(string searchKey,string state)
        {
            switch (state)
            {
                case "Load":
                    {
                        Session["CurrentDataSourceFeatures_GridResultSearchPersonnel"] = null;
                        IList<person> personList = personBusiness.SearchPersonInfoBayBarcodeNameFamily(createString.CreateString(searchKey));
                        Session.Add("CurrentDataSourceFeatures_GridResultSearchPersonnel", personList);
                        break;
                    }
                case "Callback":
                    {
                      
                       
                        break;
                    }
                default:
                    break;
            }
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataSource = (IList<person>)Session["CurrentDataSourceFeatures_GridResultSearchPersonnel"];
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataBind();
            

        }

        protected void ASPxGridViewPersonnelSearch_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            FillPersonnelSearchBoxesFromNewKeySearch(e.Parameters,"Load");
        }
        protected void ASPxCallback1_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {

            string RetMessage = string.Empty;
           
            MessageHandler messageHandler = new MessageHandler();
            try
            {
                Dictionary<string, object> obj = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string UserName = createString.CreateString(obj["UserName"].ToString());
                string Password = createString.CreateString(obj["Password"].ToString());
                string PasswordRepeat = createString.CreateString(obj["PasswordRepeat"].ToString());
                string ID = obj["ID"].ToString();
                string Barcode = createString.CreateString(obj["Barcode"].ToString());
                string Mode = obj["Mode"].ToString();
               
                
                if (wrUserBusiness.CheckUserNameExist(UserName, Barcode))
                    throw new Exception("این نام کاربری قبلا ثبت شده است.");
                switch (Mode)
                {
                      
                    case "Add":
                        {
                            if (UserName == "")
                            {
                                throw new Exception("فیلد نام کاربری را تکمیل نمایید.");
                            }
                            if (Password != PasswordRepeat)
                            {
                                throw new Exception("کلمه های عبور وارد شده یکسان نمی باشد.");
                            }
                            wr_User wrUserObj=new wr_User();
                            wrUserObj.lgn_barcode = Barcode;
                            wrUserObj.lgn_UserName = UserName;
                            wrUserObj.lgn_Password = Password;
                            bool result =false;
                            if (wrUserBusiness.CheckPersonHaveUser(Barcode))
                                throw new Exception("برای این پرسنل قبلا کاربر ثبت شده است.");
                                
                            else
                            result = wrUserBusiness.InsertNewUser(wrUserObj);
                            if (result == true)
                            {
                                messageHandler.Type = MessageType.Success.ToString();
                                RetMessage = "اطلاعات با موفقیت ثبت شد.";
                                messageHandler.Message = RetMessage;
                            }
                            else
                            {
                                messageHandler.Type = MessageType.Error.ToString();
                                RetMessage= "خطا در ثبت اطلاعات مجددا سعی نمایید.";
                                messageHandler.Message = RetMessage;
                            }
                            e.Result = this.JsSerializer.Serialize(messageHandler);

                            break;
                        }
                    case "Edit":
                        {
                            if (ID == "")
                            {
                                throw new Exception("کاربری جهت ویرایش انتخاب نشده است.");
                            }
                            if (UserName == "")
                            {
                                throw new Exception("فیلد نام کاربری را تکمیل نمایید.");
                            }
                            if (Password != PasswordRepeat)
                            {
                                throw new Exception("کلمه های عبور وارد شده یکسان نمی باشد.");
                            }
                           
                            wr_User wrUserObj = new wr_User();
                            wrUserObj.lgn_barcode = Barcode;
                            wrUserObj.lgn_UserName = UserName;
                            wrUserObj.lgn_Password = Password;
                            bool result = wrUserBusiness.UpdateUserOfPerson(wrUserObj,ID);
                            if (result == true)
                            {
                                messageHandler.Type = MessageType.Success.ToString();
                                RetMessage = "اطلاعات با موفقیت ویرایش شد.";
                                messageHandler.Message = RetMessage;
                            }
                            else
                            {
                                messageHandler.Type = MessageType.Error.ToString();
                                RetMessage = "خطا در ویرایش اطلاعات مجددا سعی نمایید.";
                                messageHandler.Message = RetMessage;
                            }
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            break;
                        }
                    case "Delete":
                        {
                            if (ID == "")
                                throw new Exception("کاربری جهت حذف وجود ندارد.");
                            bool result = wrUserBusiness.DeleteUserOfPersonByID(ID);
                            if (result == true)
                            {
                                messageHandler.Type = MessageType.Success.ToString();
                                RetMessage = "اطلاعات با موفقیت حذف شد.";
                                messageHandler.Message = RetMessage;
                            }
                            else
                            {
                                messageHandler.Type = MessageType.Error.ToString();
                                RetMessage = "خطا در حذف اطلاعات مجددا سعی نمایید.";
                                messageHandler.Message = RetMessage;
                            }
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



        protected void ASPxCallbackPanelUserofPersonnel_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            bool result = wrUserBusiness.CheckPersonHaveUser(e.Parameter);
            if (result)
            {
                wr_User wrUserObj = wrUserBusiness.GetUserOfPerson(e.Parameter);
                ASPxTextBoxUserName.Text = wrUserObj.lgn_UserName;
                if (ASPxHiddenFieldID.Contains("ID"))
                    ASPxHiddenFieldID.Set("ID", wrUserObj.ID);

                else
                    ASPxHiddenFieldID.Add("ID", wrUserObj.ID);
                ASPxTextBoxUserName.Text = wrUserObj.lgn_UserName;


                if (ASPxHiddenFieldID.Contains("Barcode"))
                    ASPxHiddenFieldID.Set("Barcode", wrUserObj.lgn_barcode);

                else
                    ASPxHiddenFieldID.Add("Barcode", wrUserObj.lgn_barcode);
            }
            else
            {
                ASPxTextBoxUserName.Text = "";
                ASPxTextBoxPassword.Text = "";
                ASPxTextBoxConfirmPassword.Text = "";
                if (ASPxHiddenFieldID.Contains("ID"))
                    ASPxHiddenFieldID.Set("ID", "");
                else

                    ASPxHiddenFieldID.Add("ID", "");
                if (ASPxHiddenFieldID.Contains("Barcode"))
                    ASPxHiddenFieldID.Set("Barcode", "");
                else

                    ASPxHiddenFieldID.Add("Barcode", "");
            }
        }

       
    }
}