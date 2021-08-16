using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Business;
using System.Data;
using DevExpress.Web.ASPxGridView;
using ASPWebclock.AppCode;

namespace ASPWebclock.Admin
{
    public partial class AdminAccessRoleNavbar : System.Web.UI.Page
    {
        public BRole roleBusiness
        {
            get
            {
                return new BRole();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            SessionHandler.CheckSessionTimeOut();
            if (!IsPostBack)
            {
              
                DevExpress.Web.ASPxGridView.GridViewDataColumn colnavbar = new DevExpress.Web.ASPxGridView.GridViewDataColumn();
                colnavbar.Name = "navbar_Title";
                colnavbar.FieldName = "navbar_Title";
                colnavbar.Caption = "نام صفحه";
                colnavbar.ReadOnly = true;
                ASPxGridViewAccessRoleNavbar.Columns.Add(colnavbar);
                //*********************
                IList<Role> roleList = roleBusiness.GetAllRoles();
                foreach (Role role in roleList)
                {
                    DevExpress.Web.ASPxGridView.GridViewDataColumn colRole = new DevExpress.Web.ASPxGridView.GridViewDataColumn();
                    colRole.Name = role.ID.ToString();
                    colRole.FieldName = role.Name;
                    colRole.Caption = role.Title;
                    colRole.ReadOnly = false;
                    ASPxGridViewAccessRoleNavbar.Columns.Add(colRole);
                }
                ASPxGridViewAccessRoleNavbar.KeyFieldName = "navbar_Name";
                fillGridAccessRoleNavbar();


                //******************************
                
            }

            if (ASPxGridViewAccessRoleNavbar.IsCallback)
                fillGridAccessRoleNavbar();
            if (Session["GridViewAccessControls_VisibleIndex"] == null)
                Session["GridViewAccessControls_VisibleIndex"] = 0;
            if (Session["GridViewAccessControls_navbarName"] == null)
                Session["GridViewAccessControls_navbarName"] = "";
            if (ASPxGridViewAccessRoleNavbar.IsRowExpanded(Convert.ToInt32(Session["GridViewAccessControls_VisibleIndex"])))
            {
                if (((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(Convert.ToInt32(Session["GridViewAccessControls_VisibleIndex"]), "AspxGridViewAccessControls")).IsCallback)
                {
                    CreateGridViewAccessControls(Convert.ToInt32(Session["GridViewAccessControls_VisibleIndex"]));
                    FillGridViewAccessControls(Session["GridViewAccessControls_navbarName"].ToString(), Convert.ToInt32(Session["GridViewAccessControls_VisibleIndex"]));
                    
                }
            }
           
        }
        public void CreateGridViewAccessControls(int visibleIndex)
        {
            DevExpress.Web.ASPxGridView.GridViewDataColumn colNaghsh = new DevExpress.Web.ASPxGridView.GridViewDataColumn();
            colNaghsh.Name = "Ctrl_Title";
            colNaghsh.FieldName = "Ctrl_Title";
            colNaghsh.Caption = "نام کنترل";
            colNaghsh.ReadOnly = true;
            ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(visibleIndex, "AspxGridViewAccessControls")).Columns.Add(colNaghsh);
            //*********************
            IList<Role> roleList = roleBusiness.GetAllRoles();
            foreach (Role role in roleList)
            {
                DevExpress.Web.ASPxGridView.GridViewDataColumn colRole = new DevExpress.Web.ASPxGridView.GridViewDataColumn();
                colRole.Name = role.ID.ToString();
                colRole.FieldName = role.Name;
                colRole.Caption = role.Title;
                colRole.ReadOnly = false;
                ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(visibleIndex, "AspxGridViewAccessControls")).Columns.Add(colRole);
            }
            ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(visibleIndex, "AspxGridViewAccessControls")).KeyFieldName = "Ctrl_Name";
        }
        public void fillGridAccessRoleNavbar()
        {
           
            ASPxGridViewAccessRoleNavbar.DataSource = roleBusiness.GetAccessRoleNavbar();
            ASPxGridViewAccessRoleNavbar.DataBind();
        }
        
        protected void ASPxGridViewAccessRoleNavbar_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            string role_Name = ASPxGridViewAccessRoleNavbar.GetRowValues(ASPxGridViewAccessRoleNavbar.FocusedRowIndex, "navbar_Name").ToString();
            System.Collections.Specialized.OrderedDictionary newValuesEditedRowsDic = e.NewValues;
            System.Collections.Specialized.OrderedDictionary ValueEditedRowKeysDic = e.Keys;
            Dictionary<string, bool> dicNewValue = new Dictionary<string, bool>();

            foreach (var item in newValuesEditedRowsDic)
            {
                bool resultTryParseBool=false;
                bool.TryParse(((DictionaryEntry)item).Value.ToString(), out resultTryParseBool);
                if (resultTryParseBool == true)
                {
                    if ((bool)((DictionaryEntry)item).Value == true)
                    {
                        dicNewValue.Add(((DictionaryEntry)item).Key.ToString(), (bool)((DictionaryEntry)item).Value);
                    }
                }
            }
           string result= roleBusiness.InsertAccessRoleNavbar(role_Name, dicNewValue);
            
            ASPxGridViewAccessRoleNavbar.CancelEdit();
            e.Cancel = true;
            fillGridAccessRoleNavbar();
           
        }
       
        protected void ASPxGridViewAccessRoleNavbar_DetailRowExpandedChanged(object sender, ASPxGridViewDetailRowEventArgs e)
        {
            if (e.Expanded == true)
            { 
            DevExpress.Web.ASPxGridView.GridViewDataColumn colNaghsh = new DevExpress.Web.ASPxGridView.GridViewDataColumn();
            colNaghsh.Name = "Ctrl_Title";
            colNaghsh.FieldName = "Ctrl_Title";
                colNaghsh.Caption = "نام کنترل";
                colNaghsh.ReadOnly = true;
                ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(e.VisibleIndex,"AspxGridViewAccessControls")).Columns.Add(colNaghsh);
                //*********************
                IList<Role> roleList = roleBusiness.GetAllRoles();
                foreach (Role role in roleList)
                {
                    DevExpress.Web.ASPxGridView.GridViewDataColumn colRole = new DevExpress.Web.ASPxGridView.GridViewDataColumn();
                    colRole.Name = role.ID.ToString();
                    colRole.FieldName = role.Name;
                    colRole.Caption = role.Title;
                    colRole.ReadOnly = false;
                    ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(e.VisibleIndex, "AspxGridViewAccessControls")).Columns.Add(colRole);
                }
                ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(e.VisibleIndex, "AspxGridViewAccessControls")).KeyFieldName = "Ctrl_Name";
                string ControlNameSelected = ASPxGridViewAccessRoleNavbar.GetRowValues(e.VisibleIndex, "navbar_Name").ToString();
                Session["GridViewAccessControls_VisibleIndex"] = e.VisibleIndex;
                Session["GridViewAccessControls_navbarName"] = ControlNameSelected;
                FillGridViewAccessControls(ControlNameSelected,e.VisibleIndex);
            }
        }
        public void FillGridViewAccessControls(string navbarName,int visibleIndex)
        {

            
            ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(visibleIndex, "AspxGridViewAccessControls")).DataSource = roleBusiness.GetAccessControls(navbarName);
            ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(visibleIndex, "AspxGridViewAccessControls")).DataBind();
        }

        protected void AspxGridViewAccessControls_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            string role_Name = ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(Convert.ToInt32(Session["GridViewAccessControls_VisibleIndex"]), "AspxGridViewAccessControls")).GetRowValues(((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(Convert.ToInt32(Session["GridViewAccessControls_VisibleIndex"]), "AspxGridViewAccessControls")).FocusedRowIndex, "Ctrl_Name").ToString();
            System.Collections.Specialized.OrderedDictionary newValuesEditedRowsDic = e.NewValues;
            System.Collections.Specialized.OrderedDictionary ValueEditedRowKeysDic = e.Keys;
            Dictionary<string, bool> dicNewValue = new Dictionary<string, bool>();

            foreach (var item in newValuesEditedRowsDic)
            {
                bool resultTryParseBool = false;
                bool.TryParse(((DictionaryEntry)item).Value.ToString(), out resultTryParseBool);
                if (resultTryParseBool == true)
                {
                    if ((bool)((DictionaryEntry)item).Value == true)
                    {
                        dicNewValue.Add(((DictionaryEntry)item).Key.ToString(), (bool)((DictionaryEntry)item).Value);
                    }
                }
            }
            string result = roleBusiness.InsertAccessRoleNavbar(role_Name, dicNewValue);

            ((ASPxGridView)ASPxGridViewAccessRoleNavbar.FindDetailRowTemplateControl(Convert.ToInt32(Session["GridViewAccessControls_VisibleIndex"]), "AspxGridViewAccessControls")).CancelEdit();
            e.Cancel = true;
            FillGridViewAccessControls(Session["GridViewAccessControls_navbarName"].ToString(),Convert.ToInt32(Session["GridViewAccessControls_VisibleIndex"]));
           
            
        }

        protected void ASPxGridViewAccessRoleNavbar_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            ASPxGridViewAccessRoleNavbar.DetailRows.CollapseAllRows();
        }

       

       


        
      
       


       

        

        
    }
}