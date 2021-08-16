using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ASPWebClock.Infrastructure.Business;
using System.Web.Script.Serialization;
using ASPWebclock.AppCode;
using ASPWebClock.Infrastructure.Model;
namespace ASPWebclock.Admin
{
    public partial class DefineAdminOperator : System.Web.UI.Page
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
                return new ASPWebClock.Infrastructure.Business.BPerson();
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
        enum LoadState
        {
            View,
            Add,
            Edit,
            Delete
        }




        enum PishcardsLoadState
        {
            Load,
            All
        }
        enum GridLoadState
        {
            Load,
            Filter
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionHandler.CheckSessionTimeOut(this.Page);
            RefererValidation.CheckReferer();
            if (!IsPostBack)
                ASPxTreeViewFilterGrid.Nodes[0].Checked = true;
            if (ASPxGridViewUserManagerStatus.IsCallback)
            {
                FillASPxGridViewViewUserOfPerson();

            }
            if (ASPxGridViewPostOfPerson.IsCallback)
            {
                if (ASPxHiddenFieldBarcode.Contains("Barcode"))

                    this.FillASPxGridViewPostOfPerson(ASPxHiddenFieldBarcode.Get("Barcode").ToString());
            }
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
        private void FillASPxGridViewViewUserOfPerson()
        {


            if (Session["ASPxGridViewUserManagerStatus"] != null)
            {
                ASPxGridViewUserManagerStatus.DataSource = Session["ASPxGridViewUserManagerStatus"];
                ASPxGridViewUserManagerStatus.DataBind();
            }

        }

       

        protected void cbResultSearchUsers_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            try
            {


                IList<WebpassUserProxy> webPassUserProxyList = userBussines.GetPostOfPerson(e.Parameter);
                Session.Add("CurrentDataSourceFeatures_GridResultSearchPersonnelUsers", webPassUserProxyList);
                cbResultSearchUsers.TextField = "PersonPost";
                cbResultSearchUsers.ValueField = "ID";
                cbResultSearchUsers.DataSource = Session["CurrentDataSourceFeatures_GridResultSearchPersonnelUsers"];
                cbResultSearchUsers.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void ASPxCallbackPostOfPerson_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string RetMessage = string.Empty;
            MessageHandler messageHandler = new MessageHandler();
            try
            {
                Dictionary<string, object> obj = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string barcode = createString.CreateString(obj["Barcode"].ToString());
                string postName = createString.CreateString(obj["Post"].ToString());


                RetMessage = userBussines.AddNewPostToPerson(barcode, postName);
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

        protected void ASPxCallbackPanelOverTime_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            DataTable dtResult = userBussines.GetOverTimeUserAccess(e.Parameter);
            if (dtResult.Rows.Count > 0)
            {
                int resultAddWork = 0;
                int resultOverTime = 0;
                ASPxCheckBoxAgreeAddWork.Checked = (bool)dtResult.Rows[0]["AgreeAddWork"];
                ASPxCheckBoxAgreeOverTime.Checked = (bool)dtResult.Rows[0]["AgreeOverTime"];
                ASPxSpinAddWorkHour.Value = Math.DivRem(Convert.ToInt32(dtResult.Rows[0]["MaxTimeReq"]), 60, out resultAddWork);
                ASPxSpinAddWorkMinute.Value = resultAddWork;
                ASPxSpinAgreeOverTimeHour.Value = Math.DivRem(Convert.ToInt32(dtResult.Rows[0]["MaxOverTime"]), 60, out resultOverTime);
                ASPxSpinAgreeOverTimeMinute.Value = resultOverTime;
                ASPxComboBoxTopMan.ValueField = "TopManID";
                ASPxComboBoxTopMan.DataSource = dtResult;
                ASPxComboBoxTopMan.DataBind();
            }
        }



        protected void ASPxCallbackPanelUserStatus_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            WebpassUserProxy webpassUserProxyObj=userBussines.GetWebPassUserByID(Convert.ToDecimal(e.Parameter));
            int status = webpassUserProxyObj.Status;
            PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), status.ToString());
            int enumValue = (int)US;
            LoadChild(ASPxTreeViewStatusUser.Nodes, enumValue);

            if (nodeSelected.Text != "Node")
            {
                ASPxTreeViewStatusUser.SelectedNode = nodeSelected;
                ASPxTreeViewStatusUser.SelectedNode.Parent.Expanded = true;
                
            }

            ASPxCheckBoxisAcceptOwner.Checked = webpassUserProxyObj.isAcceptOwner;
            ASPxCheckBoxisFinalManager.Checked = webpassUserProxyObj.FinalManager;
        }
        DevExpress.Web.ASPxTreeView.TreeViewNode nodeSelected = new DevExpress.Web.ASPxTreeView.TreeViewNode();
        private void LoadChild(DevExpress.Web.ASPxTreeView.TreeViewNodeCollection nodeItem, int indexNode)
        {
            DevExpress.Web.ASPxTreeView.TreeViewNodeCollection nodeCollection = new DevExpress.Web.ASPxTreeView.TreeViewNodeCollection();

            foreach (DevExpress.Web.ASPxTreeView.TreeViewNode node in nodeItem)
            {
                if (indexNode.ToString() == node.Name)
                {

                    nodeSelected = node;
                }
                else
                {
                    if (!node.Nodes.IsEmpty)
                    {
                        LoadChild(node.Nodes, indexNode);
                    }
                }

            }
        }

        protected void ASPxCallbackDefineAdminOperator_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            MessageHandler messageHandler = new MessageHandler();
            string RetMessage = string.Empty;
            try
            {
                Dictionary<string, object> userInfoParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                int webPassID = Convert.ToInt32(userInfoParamsDic["WebPassID"].ToString());
                int userStatus = Convert.ToInt32(userInfoParamsDic["UserStatus"]);
                bool acceptOwner = Convert.ToBoolean(userInfoParamsDic["AcceptOwner"]);
                bool finalManager = Convert.ToBoolean(userInfoParamsDic["FinalManager"]);
                bool agreeAddWork = Convert.ToBoolean(userInfoParamsDic["AgreeAddWork"]);
                bool agreeOverTime = Convert.ToBoolean(userInfoParamsDic["AgreeOverTime"]);
                int topManWebPassID = Convert.ToInt32(userInfoParamsDic["TopManWebPassID"]);
                int addWorkHour = Convert.ToInt32(userInfoParamsDic["AddWorkHour"]);
                int addWorkMinute = Convert.ToInt32(userInfoParamsDic["AddWorkMinute"]);
                int overTimeHour = Convert.ToInt32(userInfoParamsDic["OverTimeHour"]);
                int overTimeMinute = Convert.ToInt32(userInfoParamsDic["OverTimeMinute"]);
                int maxTimeReq = 0;
                int maxOverTime = 0;
                if (agreeAddWork == true)
                    maxTimeReq = (addWorkHour * 60) + addWorkMinute;
                else
                    maxTimeReq = 0;
                if (agreeOverTime == true)
                    maxOverTime = (overTimeHour * 60) + overTimeMinute;
                else
                    maxOverTime = 0;
                List<int> pishCardListItems = CreatePishCardKListItems(userInfoParamsDic["PishCardList"].ToString());
                LoadState LS = (LoadState)Enum.Parse(typeof(LoadState), userInfoParamsDic["Mode"].ToString());

                switch (LS)
                {
                    case LoadState.Edit:
                        RetMessage = userBussines.EditUserAccessToStatusToOverTime(webPassID, userStatus, topManWebPassID, maxTimeReq, maxOverTime, agreeAddWork, agreeOverTime, acceptOwner, finalManager, pishCardListItems);
                        break;
                    case LoadState.Delete:

                        break;
                    default:
                        break;
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

        protected void CallbackPanelAllowPishcards_onCallBack(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            Dictionary<string, object> PishCardPersonnelAllowParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
            try
            {


                this.Fill_lbPishCardPersonnelAllow((PishcardsLoadState)Enum.Parse(typeof(PishcardsLoadState), PishCardPersonnelAllowParamsDic["LS"].ToString()),Convert.ToDecimal(PishCardPersonnelAllowParamsDic["WebPassID"]));

            }
            catch (Exception ex)
            {
                lbPishCardPersonnelAllow.Items.Clear();


            }
        }

        private void Fill_lbPishCardPersonnelAllow(PishcardsLoadState PLS, decimal WebPassID)
        {
            List<Pishcard> pishcardList = null;
            switch (PLS)
            {
                case PishcardsLoadState.Load:
                    pishcardList = pishcardBussines.GetActivePishCardUserAccessAllowed(WebPassID);
                    break;
                case PishcardsLoadState.All:
                    pishcardList = pishcardBussines.GetAllActivePishCardPersons(WebPassID);
                    break;
            }
            lbPishCardPersonnelAllow.TextField = "Name";
            lbPishCardPersonnelAllow.ValueField = "Code";
            lbPishCardPersonnelAllow.DataSource = pishcardList;
            lbPishCardPersonnelAllow.DataBind();
            this.CreateStrPishcardsList(pishcardList);
        }
        private List<int> CreatePishCardKListItems(string PishCardList)
        {

            List<string> strPishCardItems = new List<string>();
            string itmPishCard = string.Empty;
            for (int i = 0; i < PishCardList.Count(); i++)
            {
                itmPishCard = itmPishCard + PishCardList[i];
                if (PishCardList[i] == '@')
                {

                    strPishCardItems.Add(itmPishCard.Replace("@", ""));
                    itmPishCard = string.Empty;

                }
            }
            strPishCardItems.RemoveAt(0);

            List<int> pishCardItems = strPishCardItems.ConvertAll<int>(Convert.ToInt32);
            return pishCardItems;
        }
        private void CreateStrPishcardsList(List<Pishcard> pishcardList)
        {
            string StrPishcardsList = "@";
            string splitter = "@";
            foreach (Pishcard pishcardObj in pishcardList)
            {
                StrPishcardsList = StrPishcardsList + pishcardObj.Code.ToString() + splitter;
            }
            this.hfAllowedPishcards.Value = StrPishcardsList;
            ASPxHiddenFieldAllowedPishcards["PishCardList"] = StrPishcardsList;
        }

        protected void CallbackPanelDeniedPishcards_onCallback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            Dictionary<string, object> PishCardPersonnelDenyParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
            try
            {


                this.Fill_lbPishCardPersonnelDeny((PishcardsLoadState)Enum.Parse(typeof(PishcardsLoadState), PishCardPersonnelDenyParamsDic["LS"].ToString()),Convert.ToDecimal(PishCardPersonnelDenyParamsDic["WebPassID"]));
            }
            catch (Exception ex)
            {
                lbPishCardPersonnelDeny.Items.Clear();


            }
        }

        private void Fill_lbPishCardPersonnelDeny(PishcardsLoadState PLS, decimal WebPassID)
        {
            try
            {


                List<Pishcard> pishcardList = null;
                switch (PLS)
                {
                    case PishcardsLoadState.Load:
                        pishcardList = pishcardBussines.GetActivePishCardUserAccessDeneid(WebPassID);
                        break;
                    case PishcardsLoadState.All:
                        pishcardList = pishcardBussines.GetAllActivePishCardPersons(WebPassID);
                        break;
                }
                lbPishCardPersonnelDeny.TextField = "Name";
                lbPishCardPersonnelDeny.ValueField = "Code";
                lbPishCardPersonnelDeny.DataSource = pishcardList;
                lbPishCardPersonnelDeny.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void ASPxCallbackDeleteRowsSelectedGrid_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            MessageHandler messageHandler = new MessageHandler();
            string RetMessage = string.Empty;
            try
            {
                decimal webpassID = Convert.ToDecimal(ASPxGridViewUserManagerStatus.GetRowValues(Convert.ToInt32(e.Parameter), "ID"));
                RetMessage = userBussines.DeleteUserAccessToStatusToOverTime(webpassID);
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



        protected void ASPxGridViewUserManagerStatus_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {
                FillGridUsersStatusManager(e.Parameters);
            }
            catch (Exception ex)
            {
                DataTable dtResult = null;
                ASPxGridViewUserManagerStatus.DataSource = dtResult;
                ASPxGridViewUserManagerStatus.DataBind();
                ASPxGridViewUserManagerStatus.SettingsText.EmptyDataRow = ex.Message;

            }


        }


        private void FillGridUsersStatusManager(string objItems)
        {
            MessageHandler messageHandler = new MessageHandler();
            Dictionary<string, object> GridParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(objItems);
            string status = GridParamsDic["Status"].ToString();
            GridLoadState stateGrid = (GridLoadState)Enum.Parse(typeof(GridLoadState), GridParamsDic["State"].ToString());
            if (stateGrid == GridLoadState.Filter)
            {
                Session["ASPxGridViewUserManagerStatus"] = null;
            }
            try
            {


                if (Session["ASPxGridViewUserManagerStatus"] == null)
                {


                    DataTable dtResult = userBussines.GetAllUsersInformationStatusPartManager(status);
                    dtResult.Columns.Add("UserStatusName");
                    for (int i = 0; i < dtResult.Rows.Count; i++)
                    {
                        string nameStatus = "";
                        PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), dtResult.Rows[i]["UserStatus"].ToString());
                        switch (US)
                        {
                            case PersonStatus.unKnown:
                                nameStatus = "تعریف نشده";
                                break;
                            case PersonStatus.TAManagment:
                                nameStatus = "مدیر حضور غیاب";
                                break;
                            case PersonStatus.Operator:
                                nameStatus = "اپراتور";
                                break;
                            case PersonStatus.Reporter:
                                nameStatus = "گزارش گیر";
                                break;
                            case PersonStatus.User:
                                nameStatus = "کاربر";
                                break;
                            case PersonStatus.EarlyManagment:
                                nameStatus = "مدیر واحد - تایید اولیه";
                                break;
                            case PersonStatus.SecondManagment:
                                nameStatus = "مدیر واحد - تایید ثانویه";
                                break;
                            case PersonStatus.FinalManagment:
                                nameStatus = "مدیر واحد - تایید نهایی";
                                break;
                            default:
                                break;
                        }
                        dtResult.Rows[i]["UserStatusName"] = nameStatus;
                    }
                    Session.Add("ASPxGridViewUserManagerStatus", dtResult);
                }
                ASPxGridViewUserManagerStatus.DataSource = (System.Data.DataTable)Session["ASPxGridViewUserManagerStatus"];
                ASPxGridViewUserManagerStatus.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void ASPxGridViewViewUserOfPerson_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            Dictionary<string, object> callBackParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameters);
            string barcode = callBackParamsDic["BarCode"].ToString();
            LoadState LS = (LoadState)Enum.Parse(typeof(LoadState), callBackParamsDic["LS"].ToString());
            try
            {
                //Session.Add("CurrentDataSourceFeatures_ASPxGridViewViewUserOfPerson", userBussines.GetPostOfPerson(barCode));

            }
            catch (Exception ex)
            {
                DataTable dtResult = null;
                ASPxGridViewPostOfPerson.DataSource = dtResult;
                ASPxGridViewPostOfPerson.DataBind();
                ASPxGridViewPostOfPerson.SettingsText.EmptyDataRow = ex.Message;

            }
            this.FillASPxGridViewPostOfPerson(barcode);
            switch (LS)
            {
                case LoadState.Add:
                    this.ASPxGridViewPostOfPerson.PageIndex = this.ASPxGridViewPostOfPerson.PageCount - 1;
                    break;
                case LoadState.Edit:
                    break;
                case LoadState.Delete:
                    break;
                default:
                    this.ASPxGridViewPostOfPerson.PageIndex = 0;
                    break;
            }
        }


        private void FillASPxGridViewPostOfPerson(string barcode)
        {

            ASPxGridViewPostOfPerson.DataSource = userBussines.GetPostOfPerson(barcode); ;
            ASPxGridViewPostOfPerson.DataBind();



        }

        protected void ASPxGridViewViewUserOfPerson_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {

            try
            {
                int idEditedRow = Convert.ToInt32(ASPxGridViewPostOfPerson.GetRowValues(ASPxGridViewPostOfPerson.FocusedRowIndex, "ID"));
               // string barcode = cbResultSearchPersonnel.SelectedItem.Text[0].ToString();
                string barcode = ASPxHiddenFieldBarcode.Get("Barcode").ToString();
                System.Collections.Specialized.OrderedDictionary newValuesEditedRowsDic = e.NewValues;
                System.Collections.Specialized.OrderedDictionary ValueEditedRowKeysDic = e.Keys;
                string postName = newValuesEditedRowsDic["PersonPost"].ToString();
                int id = Convert.ToInt32(ValueEditedRowKeysDic["ID"]);
                string resultMessage = userBussines.EditPostOfPerson(id, postName, barcode);
                ASPxGridViewPostOfPerson.CancelEdit();
                e.Cancel = true;
                FillASPxGridViewPostOfPerson(barcode);
                FillASPxGridViewViewUserOfPerson();

            }

            catch (Exception ex)
            {

                throw ex;
            }
        }


        protected void ASPxCallbackDeletePostOfPerson_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {

            MessageHandler messageHandler = new MessageHandler();
            string RetMessage = string.Empty;
            try
            {
                int idRowSelected = Convert.ToInt32(ASPxGridViewPostOfPerson.GetRowValues(Convert.ToInt32(e.Parameter), "ID"));
                RetMessage = userBussines.DeletePostOfPerson(idRowSelected);
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
