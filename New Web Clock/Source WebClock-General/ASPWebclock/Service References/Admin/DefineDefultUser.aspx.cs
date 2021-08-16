using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using ASPWebClock.Infrastructure.Business;
using ASPWebclock.AppCode;
using System.Data;
using DevExpress.Data.Filtering;

namespace ASPWebclock.Admin
{
    public partial class DefineDefultUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            SessionHandler.CheckSessionTimeOut();
            FillGridViewDefaultUser();
        }

        protected void ASPxGridViewDefaultUser_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            switch (e.Parameters)
            {
                case "Usertrue":
                    {
                        for (int i = 0; i < ASPxGridViewDefaultUser.VisibleRowCount; i++)
                        {
                            if (ASPxGridViewDefaultUser.GetRowValues(i, "UserName").ToString() != "")
                            {

                              ASPxGridViewDefaultUser.Selection.SelectRow(i);
                                
                            }
                        }
                        break;
                    }
                case "Userfalse":
                    {
                        for (int i = 0; i < ASPxGridViewDefaultUser.VisibleRowCount; i++)
                        {
                            if (ASPxGridViewDefaultUser.GetRowValues(i, "UserName").ToString() != "")
                            {

                                ASPxGridViewDefaultUser.Selection.UnselectRow(i);

                            }
                        }
                        break;
                    }
                case "NoUsertrue":
                    {
                        for (int i = 0; i < ASPxGridViewDefaultUser.VisibleRowCount; i++)
                        {
                            if (ASPxGridViewDefaultUser.GetRowValues(i, "UserName").ToString() == "")
                            {

                                ASPxGridViewDefaultUser.Selection.SelectRow(i);

                            }
                        }
                        break;
                    }
                case "NoUserfalse":
                    {
                        for (int i = 0; i < ASPxGridViewDefaultUser.VisibleRowCount; i++)
                        {
                            if (ASPxGridViewDefaultUser.GetRowValues(i, "UserName").ToString() == "")
                            {

                                ASPxGridViewDefaultUser.Selection.UnselectRow(i);

                            }
                        }
                        break;
                    }
                
                default:
                    break;
            }
        }

        private void FillGridViewDefaultUser()
        {
            ASPxGridViewDefaultUser.DataSource = new BWebLoginUser().GetAllUsers();
            ASPxGridViewDefaultUser.DataBind();
        }

        protected void ASPxMenu1_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
        {
            
            string result = "";
            if (ASPxGridViewDefaultUser.Selection.Count > 0)
            {
                for (int i = 0; i < ASPxGridViewDefaultUser.VisibleRowCount; i++)
                {
                    if (ASPxGridViewDefaultUser.Selection.IsRowSelected(i))
                    {
                        string barcode = ASPxGridViewDefaultUser.GetRowValues(i, "Barcode").ToString();
                        string userName = ASPxGridViewDefaultUser.GetRowValues(i, "UserName").ToString();
                        if (userName == "")
                        {
                             result = new BWebpassUser().AddDefaultUserToNewPerson(barcode);
                        }
                        else
                        {
                             result = new BWebpassUser().AddDefaultUserToEditPerson(barcode);
                        }
                    }
                }
                FillGridViewDefaultUser();
            }
            else
            {
                result = "هیچ پرسنلی انتخاب نشده است";
            }
            Response.Write("<script>alert('"+ result +"');</script>");
            
        }

        protected void ASPxGridViewDefaultUser_ProcessColumnAutoFilter(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewAutoFilterEventArgs e)
        {
            if (Session["valFilter_ASPxGridViewDefaultUser_DefaultDefineUser"] == null)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                Session["valFilter_ASPxGridViewDefaultUser_DefaultDefineUser"] = dic;

            }
            if (e.Kind == DevExpress.Web.ASPxGridView.GridViewAutoFilterEventKind.CreateCriteria)
            {

                string newVal = "%" + e.Value + "%";
                e.Criteria = new BinaryOperator(e.Column.FieldName, new StringGenerator().TruePersianKeyboard(newVal), BinaryOperatorType.Like);
                if (!((Dictionary<string, string>)Session["valFilter_ASPxGridViewDefaultUser_DefaultDefineUser"]).ContainsKey(e.Column.FieldName.ToString()))
                {
                    ((Dictionary<string, string>)Session["valFilter_ASPxGridViewDefaultUser_DefaultDefineUser"]).Add(e.Column.FieldName, e.Value);

                }
                else
                {
                    ((Dictionary<string, string>)Session["valFilter_ASPxGridViewDefaultUser_DefaultDefineUser"])[e.Column.FieldName] = e.Value;
                }
            }
            if (e.Kind == DevExpress.Web.ASPxGridView.GridViewAutoFilterEventKind.ExtractDisplayText)
            {
                e.Value = ((Dictionary<string, string>)Session["valFilter_ASPxGridViewDefaultUser_DefaultDefineUser"])[e.Column.FieldName].ToString();
            }
        }
    }
}