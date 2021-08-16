using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.DAL.Repository;
using System.Web.Script.Serialization;
using ASPWebClock.Infrastructure.Business;
using ASPWebclock.AppCode;
using System.Data;
using System.Diagnostics;

namespace ASPWebclock
{
    public partial class SelectPost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            if (User.Identity.Name == "admin")
            {
                Response.Redirect("~/Admin/AdminMain.aspx");
            }
            if (!IsPostBack)
            {
                string barcode = new UserRepository().GetBarcodeByUserName(User.Identity.Name);
                DataTable dtResult = new UserRepository().GetPostOfPerson(barcode);
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    ASPxRadioButtonListPosts.Items.Add(dtResult.Rows[i]["PersonPost"].ToString(), dtResult.Rows[i]["ID"].ToString());
                }
                ASPxRadioButtonListPosts.SelectedIndex = -1;
                if (ASPxRadioButtonListPosts.Items.Count == 1)
                {
                    
                    
                    FillUserInformation(ASPxRadioButtonListPosts.Items[0].Value.ToString(),ASPxRadioButtonListPosts.Items[0].Text,User.Identity.Name);
                    Response.Redirect("~/MainForm.aspx");
                }
              
            }
        }
        
        private void FillUserInformation(string postID, string postName,string userName)
        {
            ASPWebClock.Infrastructure.Model.Person person = new UserRepository().GetPersonByUserName(userName);
            Session["PostID"] = postID;
            Session["PostName"] = postName;
            Session["NameFamily"] = person.Name + " " + person.Family;
            Session["Barcode"] = person.BarCode;
            IList<decimal> listInsteadManPostId=  new BUser().GetWebpassIDInsteadMans(person.BarCode, DateTime.Now.Date);
            Session["ListPostIDInsteadMan"] = listInsteadManPostId;
            
        }
        protected void ASPxRadioButtonListPosts_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillUserInformation(ASPxRadioButtonListPosts.SelectedItem.Value.ToString(), ASPxRadioButtonListPosts.SelectedItem.Text, User.Identity.Name);
            Response.Redirect("~/MainForm.aspx");
        }

        
    }
}