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
    public partial class AdminAccessReports : System.Web.UI.Page
    {
        public BReport reportBusiness
        {
            get
            {
                return new BReport();
            }
        }
        public BRole roleBusiness
        {
            get
            {
                return new BRole();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionHandler.CheckSessionTimeOut(this.Page);
            RefererValidation.CheckReferer();
            if (!IsPostBack)
            {
                IList<ASPWebClock.Infrastructure.Model.Report> reportList = reportBusiness.LoadAllReports();

                GridViewDataColumn colReNa = new GridViewDataColumn();
                colReNa.Caption = "نام گزارش";
                colReNa.FieldName = "Report_Name";
                colReNa.ReadOnly = true;
                ASPxGridViewAccessReports.Columns.Add(colReNa);
                
                GridViewDataColumn colReId = new GridViewDataColumn();
                colReId.Caption = "آی دی گزارش";
                colReId.FieldName = "Report_ID";
                colReId.ReadOnly = true;
                colReId.Visible = false;
                ASPxGridViewAccessReports.Columns.Add(colReId);

                GridViewDataColumn colRoId = new GridViewDataColumn();
                colRoId.Caption = "آی دی نقش";
                colRoId.FieldName = "Role_ID";
                colRoId.ReadOnly = true;
                colRoId.Visible = false;
                ASPxGridViewAccessReports.Columns.Add(colRoId);
                //*********************
                
                IList<Role> roleList = roleBusiness.GetAllRoles();
                foreach (Role role in roleList)
                {
                    DevExpress.Web.ASPxGridView.GridViewDataCheckColumn colRole = new DevExpress.Web.ASPxGridView.GridViewDataCheckColumn();
                    colRole.Name = role.ID.ToString();
                    colRole.FieldName = role.Name;
                    colRole.Caption = role.Title;
                    colRole.ReadOnly = false;
                    if (role.Name == "unKnown")
                        colRole.Visible = false;
                    ASPxGridViewAccessReports.Columns.Add(colRole);
                }

                ASPxGridViewAccessReports.KeyFieldName = "Report_ID";
                FillAccessReports();
            }
            if(ASPxGridViewAccessReports.IsCallback)
                FillAccessReports();
        }
        protected void ASPxGridViewAccessReports_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            string report_ID = ASPxGridViewAccessReports.GetRowValues(ASPxGridViewAccessReports.FocusedRowIndex, "Report_ID").ToString();
            System.Collections.Specialized.OrderedDictionary newValuesEditedRowsDic = e.NewValues;
            System.Collections.Specialized.OrderedDictionary ValueEditedRowKeysDic = e.Keys;

            Dictionary<string, bool> dicNewValue = new Dictionary<string, bool>();

            foreach (var item in newValuesEditedRowsDic)
            {
                bool resultTryParseBool = false;
                bool.TryParse(((DictionaryEntry)item).Value.ToString(), out resultTryParseBool);
                if (resultTryParseBool == true)
                {
                    if (resultTryParseBool == true)
                    {
                        dicNewValue.Add(((DictionaryEntry)item).Key.ToString(), resultTryParseBool);
                    }
                }
            }
            string result = new ASPWebClock.Infrastructure.Business.BReport().InsertAccessReports(report_ID, dicNewValue);

            ASPxGridViewAccessReports.CancelEdit();
            e.Cancel = true;
            FillAccessReports();
        }

        protected void ASPxGridViewAccessRoleNavbar_DetailRowExpandedChanged(object sender, ASPxGridViewDetailRowEventArgs e)
        { }
        protected void ASPxGridViewAccessRoleNavbar_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        { }
        protected void ASPxGridViewAccessReports_DetailRowExpandedChanged(object sender, ASPxGridViewDetailRowEventArgs e)
        { }
        protected void ASPxGridViewAccessReports_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        { }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        { }
        public void FillAccessReports()
        {
            ASPxGridViewAccessReports.DataSource = new ASPWebClock.Infrastructure.Business.BReport().GetAccessReports();
            ASPxGridViewAccessReports.DataBind(); 
        }
    }
}