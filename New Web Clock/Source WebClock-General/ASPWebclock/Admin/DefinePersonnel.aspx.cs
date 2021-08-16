﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using ASPWebClock.Infrastructure.Business;
using ASPWebclock.AppCode;
using System.Data;
using ASPWebClock.Infrastructure.Model;

namespace ASPWebclock.Admin
{
    public partial class DefinePersonnel : System.Web.UI.Page
    {
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
        public BWebpassUser userBussines
        {
            get
            {
                return new BWebpassUser();
            }
        }

        enum LoadState
        {
            View,
            Add,
            Edit,
            Delete
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            SessionHandler.CheckSessionTimeOut(Page);
            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).IsCallback)
                FillPersonnelSearchBoxesFromPosBackPaging();
        }

        
        private void FillPersonnelSearchBoxesFromPosBackPaging()
        {
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataSource = (IList<ASPWebClock.Infrastructure.Model.Person>)Session["CurrentDataSourceFeatures_GridResultSearchPersonnel"];
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataBind();

        }

        private void FillPersonnelSearchBoxesFromNewKeySearch(string keySearch)
        {
            Session["CurrentDataSourceFeatures_GridResultSearchPersonnel"] = null;
            IList<ASPWebClock.Infrastructure.Model.Person> persons = personBusiness.GetPersonBySearchKey(createString.CreateString(keySearch));
            Session.Add("CurrentDataSourceFeatures_GridResultSearchPersonnel", persons);
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataSource = (IList<ASPWebClock.Infrastructure.Model.Person>)Session["CurrentDataSourceFeatures_GridResultSearchPersonnel"];
            ((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).DataBind();

        }
        
        protected void ASPxGridViewPersonnelSearch_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            FillPersonnelSearchBoxesFromNewKeySearch(e.Parameters);
        }
        protected void ASPxCallback1_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {
                Dictionary<string, object> obj = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string UserName =createString.CreateString(obj["UserName"].ToString());
                string Password =createString.CreateString(obj["Password"].ToString());
                string PasswordRepeat =createString.CreateString( obj["PasswordRepeat"].ToString());
                string ID =obj["ID"].ToString();
                string Barcode =createString.CreateString( obj["Barcode"].ToString());
                string Mode =obj["Mode"].ToString();
                switch (Mode)
                {
                    case "Add":
                        {
                            RetMessage = userBussines.AddNewUserToPerson(Barcode, UserName, Password, PasswordRepeat);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            
                            break;
                        }
                    case "Edit":
                        {
                            RetMessage = userBussines.EditUserOfPerson(ID, UserName, Password, PasswordRepeat);
                            messageHandler.Type = MessageType.Success.ToString();
                            messageHandler.Message = RetMessage;
                            e.Result = this.JsSerializer.Serialize(messageHandler);
                            break;
                        }
                    case "Delete":
                        {
                            RetMessage = userBussines.DeleteUserOfPerson(ID);
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

     

        protected void ASPxCallbackPanelUserofPersonnel_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            WebLoginUserProxy webLoginUserProxyObj = new BWebLoginUser().GetUserOfPersonnel(e.Parameter);
            if (webLoginUserProxyObj!=null)
            {
                ASPxTextBoxUserName.Text = webLoginUserProxyObj.UserName;
                if (ASPxHiddenFieldID.Contains("ID"))
                    ASPxHiddenFieldID.Set("ID", webLoginUserProxyObj.ID);
               
                else
                    ASPxHiddenFieldID.Add("ID", webLoginUserProxyObj.ID);
                ASPxTextBoxUserName.Text = webLoginUserProxyObj.UserName;


                if (ASPxHiddenFieldID.Contains("Barcode"))
                    ASPxHiddenFieldID.Set("Barcode", webLoginUserProxyObj.Barcode);

                else
                    ASPxHiddenFieldID.Add("Barcode", webLoginUserProxyObj.Barcode);
            }
            else
            {
                ASPxTextBoxUserName.Text = "";
                ASPxTextBoxPassword.Text ="";
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