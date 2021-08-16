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
using DevExpress.Data.Filtering;
using ASPWebClock.Infrastructure.Model;

namespace ASPWebclock.Admin
{
    public partial class DefineManagerPersonnel : System.Web.UI.Page
    {
        public JavaScriptSerializer JsSerializer
        {
            get
            {
                return new JavaScriptSerializer();
            }
        }
        public BPart partBussines
        {
            get
            {
                return new BPart();
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
        public BPerson personBussines
        {
            get
            {
                return new BPerson();
            }
        }
        enum LoadGridwebPassPerson
        {
            Load,
            newLoad
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            SessionHandler.CheckSessionTimeOut(Page);
            if (!IsPostBack)
            {
                try
                {

                    FillTreeViewParts();
                }
                catch (Exception ex)
                {

                    throw ex;
                }
                try
                {
                    FillASPxGridViewPersonnels();

                }
                catch (Exception ex)
                {
                    DataTable dtResult = null;
                    ASPxGridViewPersonnels.DataSource = dtResult;
                    ASPxGridViewPersonnels.DataBind();
                    ASPxGridViewPersonnels.SettingsText.EmptyDataRow = ex.Message;

                }


            }

            if (ASPxGridViewPersonnels.IsCallback)
            {
                FillASPxGridViewPersonnels();

            }
            if (ASPxGridViewEditWebPassPerson.IsCallback)
            {
                FillASPxGridViewEditWebPassPersononLoad();

            }
            if (((DevExpress.Web.ASPxGridView.ASPxGridView)ASPxDropDownEditPersonnelSearch.FindControl("ASPxGridViewPersonnelSearch")).IsCallback)
                FillPersonnelSearchBoxesFromPosBackPaging();

        }
        private void FillTreeViewParts()
        {
            string typePart = new BPart().GetPartsType();
            switch (typePart)
            {
                case "ByRoot":
                    {
                        Part partRoot = new ASPWebClock.Infrastructure.Business.BPart().GetPartsRoot();

                        DevExpress.Web.ASPxTreeView.TreeViewNode nodeRoot = new DevExpress.Web.ASPxTreeView.TreeViewNode();

                        nodeRoot.Text = partRoot.P_Name;
                        nodeRoot.Name = partRoot.P_Code.ToString();

                        IList<Part> iListpartNodes = new ASPWebClock.Infrastructure.Business.BPart().GetAllChildPart(nodeRoot.Name);
                        LoadChildTreeViewParts(nodeRoot, iListpartNodes);
                        ASPxTreeViewParts.Nodes.Add(nodeRoot);

                        if (nodeRoot.Nodes.Count > 0)

                            ASPxTreeViewParts.DataBind();
                        ASPxTreeViewParts.Nodes.FindByName(nodeRoot.Name).Expanded = true;
                        break;
                    }

                case "NoRoot":
                    {
                        List<Part> partList = new BPart().GetAllParts();
                        foreach (Part item in partList)
                        {
                            DevExpress.Web.ASPxTreeView.TreeViewNode node = new DevExpress.Web.ASPxTreeView.TreeViewNode();

                            node.Text = item.P_Name;
                            node.Name = item.P_Code.ToString();
                            ASPxTreeViewParts.Nodes.Add(node);
                        }

                        break;
                    }


                default:
                    break;
            }
        }
        private void LoadChildTreeViewParts(DevExpress.Web.ASPxTreeView.TreeViewNode nodRoot, IList<Part> iListPartNodes)
        {
            IList<Part> iListChilds = iListPartNodes.Where(x => x.P_Father == nodRoot.Name).ToList();


            foreach (var item in iListChilds)
            {
                DevExpress.Web.ASPxTreeView.TreeViewNode itemchild = new DevExpress.Web.ASPxTreeView.TreeViewNode();
                itemchild.Text = item.P_Name;
                itemchild.Name = item.P_Code.ToString();

                nodRoot.Nodes.Add(itemchild);
                LoadChildTreeViewParts(itemchild, iListPartNodes);
            }


        }
        private void FillASPxGridViewEditWebPassPersononLoad()
        {


            if (Session["ASPxGridViewEditWebPassPerson"] != null)
            {
                ASPxGridViewEditWebPassPerson.DataSource = Session["ASPxGridViewEditWebPassPerson"];
                ASPxGridViewEditWebPassPerson.DataBind();
            }
            else
            {

            }

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

        protected void cbResultSearchUsers_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            IList<WebpassUserProxy> webPassUserProxyList = userBussines.GetPostOfPerson(e.Parameter);
            Session.Add("CurrentDataSourceFeatures_GridResultSearchPersonnelUsers", webPassUserProxyList);
            cbResultSearchUsers.TextField = "PersonPost";
            cbResultSearchUsers.ValueField = "ID";
            cbResultSearchUsers.DataSource = Session["CurrentDataSourceFeatures_GridResultSearchPersonnelUsers"];
            cbResultSearchUsers.DataBind();
        }




        private void FillASPxGridViewPersonnels()
        {

            try
            {


                if (Session["ASPxGridViewPersonnels_DefineManagerPersonnel"] == null)
                {

                    IList<Person> personList = personBusiness.GetAllPersonnel();
                    Session.Add("ASPxGridViewPersonnels_DefineManagerPersonnel", personList);




                }
                ASPxGridViewPersonnels.DataSource = Session["ASPxGridViewPersonnels_DefineManagerPersonnel"];
                ASPxGridViewPersonnels.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void ASPxGridViewPersonnels_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {
                FillASPxGridViewPersonnels();
            }
            catch (Exception ex)
            {
                DataTable dtResult = null;
                ASPxGridViewPersonnels.DataSource = dtResult;
                ASPxGridViewPersonnels.DataBind();
                ASPxGridViewPersonnels.SettingsText.EmptyDataRow = ex.Message;

            }

        }


        protected void ASPxCallbackUpdateWebpassPerson_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            MessageHandler messageHandler = new MessageHandler();
            string RetMessage = string.Empty;
            try
            {


                Dictionary<string, object> webPassParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                int webPassID = Convert.ToInt32(webPassParamsDic["WebPassID"].ToString());
                bool person = Convert.ToBoolean(webPassParamsDic["Person"]);
                bool part = Convert.ToBoolean(webPassParamsDic["Part"]);
                string barcode = webPassParamsDic["Barcode"].ToString();

                RetMessage = userBussines.InsertWebPassPerson(barcode, person, part, webPassID);
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

        protected void ASPxGridViewEditWebPassPerson_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            Dictionary<string, object> GridParamsDic = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameters);
            int webPassID = Convert.ToInt32(GridParamsDic["WebPassID"].ToString());
            LoadGridwebPassPerson stateGrid = (LoadGridwebPassPerson)Enum.Parse(typeof(LoadGridwebPassPerson), GridParamsDic["State"].ToString());
            try
            {
                FillASPxGridViewEditWebPassPerson(webPassID, stateGrid);
            }
            catch (Exception ex)
            {

                DataTable dtResult = null;
                ASPxGridViewEditWebPassPerson.DataSource = dtResult;
                ASPxGridViewEditWebPassPerson.DataBind();
                ASPxGridViewEditWebPassPerson.SettingsText.EmptyDataRow = ex.Message;
            }

        }
        private void FillASPxGridViewEditWebPassPerson(decimal webPassID, LoadGridwebPassPerson stateGrid)
        {

            try
            {


                if (stateGrid == LoadGridwebPassPerson.newLoad)
                {
                    Session["ASPxGridViewEditWebPassPerson"] = null;
                }
                if (Session["ASPxGridViewEditWebPassPerson"] == null)
                {
                    DataTable dtResult = userBussines.GetWebPassPersonsByID(webPassID);
                    Session.Add("ASPxGridViewEditWebPassPerson", dtResult);

                }
                ASPxGridViewEditWebPassPerson.DataSource = (System.Data.DataTable)Session["ASPxGridViewEditWebPassPerson"];
                ASPxGridViewEditWebPassPerson.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        protected void ASPxGridViewEditWebPassPerson_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            try
            {
                int idEditedRow = Convert.ToInt32(ASPxGridViewEditWebPassPerson.GetRowValues(ASPxGridViewEditWebPassPerson.FocusedRowIndex, "ID"));
                System.Collections.Specialized.OrderedDictionary newValuesEditedRowsDic = e.NewValues;
                System.Collections.Specialized.OrderedDictionary ValueEditedRowKeysDic = e.Keys;
                bool isKarkardfrm = Convert.ToBoolean(newValuesEditedRowsDic["isKarkardfrm"]);
                bool isRequestfrm = Convert.ToBoolean(newValuesEditedRowsDic["isRequestfrm"]);
                bool isOperatorfrm = Convert.ToBoolean(newValuesEditedRowsDic["isOperatorfrm"]);
                bool isKeeperfrm = Convert.ToBoolean(newValuesEditedRowsDic["isKeeperfrm"]);
                bool isOverTimefrm = Convert.ToBoolean(newValuesEditedRowsDic["isOverTimefrm"]);
                bool isSubPart = Convert.ToBoolean(newValuesEditedRowsDic["isSubPart"]);
                bool accessType = Convert.ToBoolean(newValuesEditedRowsDic["AccessType"]);
                int id = Convert.ToInt32(ValueEditedRowKeysDic["ID"]);
                string resultMessage = userBussines.EditWebPassPerson(isKarkardfrm, isRequestfrm, isOperatorfrm, isKeeperfrm, isOverTimefrm, isSubPart, accessType, id);
                ASPxGridViewEditWebPassPerson.CancelEdit();
                e.Cancel = true;
                int webPassId = Convert.ToInt32(ASPxGridViewEditWebPassPerson.GetRowValues(ASPxGridViewEditWebPassPerson.FocusedRowIndex, "WebPassId"));
                LoadGridwebPassPerson stateGrid = (LoadGridwebPassPerson)Enum.Parse(typeof(LoadGridwebPassPerson), "newLoad");
                FillASPxGridViewEditWebPassPerson(webPassId, stateGrid);


            }

            catch (Exception ex)
            {

                throw ex;
            }
        }



        protected void ASPxCallbackDeleteWebpassPerson_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            MessageHandler messageHandler = new MessageHandler();
            string RetMessage = string.Empty;
            try
            {
                int idRowSelected = Convert.ToInt32(ASPxGridViewEditWebPassPerson.GetRowValues(Convert.ToInt32(e.Parameter), "ID"));
                RetMessage = userBussines.DeleteWebPassPerson(idRowSelected);
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

        protected void ASPxGridViewPersonnels_ProcessColumnAutoFilter(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewAutoFilterEventArgs e)
        {
            if (Session["valFilter_ASPxGridViewPersonnels_DefineManagerPersonnel"] == null)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                Session["valFilter_ASPxGridViewPersonnels_DefineManagerPersonnel"] = dic;

            }

            if (e.Kind == DevExpress.Web.ASPxGridView.GridViewAutoFilterEventKind.CreateCriteria)
            {

                string newVal = "%" + e.Value + "%";
                e.Criteria = new BinaryOperator(e.Column.FieldName, new StringGenerator().TruePersianKeyboard(newVal), BinaryOperatorType.Like);
                if (!((Dictionary<string, string>)Session["valFilter_ASPxGridViewPersonnels_DefineManagerPersonnel"]).ContainsKey(e.Column.FieldName.ToString()))
                {
                    ((Dictionary<string, string>)Session["valFilter_ASPxGridViewPersonnels_DefineManagerPersonnel"]).Add(e.Column.FieldName, e.Value);

                }
                else
                {
                    ((Dictionary<string, string>)Session["valFilter_ASPxGridViewPersonnels_DefineManagerPersonnel"])[e.Column.FieldName] = e.Value;
                }
            }
            if (e.Kind == DevExpress.Web.ASPxGridView.GridViewAutoFilterEventKind.ExtractDisplayText)
            {

                e.Value = ((Dictionary<string, string>)Session["valFilter_ASPxGridViewPersonnels_DefineManagerPersonnel"])[e.Column.FieldName].ToString();
            }
        }














    }
}