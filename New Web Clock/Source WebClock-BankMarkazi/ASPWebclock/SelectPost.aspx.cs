using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using ASPWebClock.Infrastructure.Business;
using ASPWebClock.Infrastructure.Model;
using ASPWebclock.AppCode;
using System.Data;
using System.Diagnostics;

namespace ASPWebclock
{
    public partial class SelectPost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionHandler.CheckSessionTimeOut(this.Page);
            RefererValidation.CheckReferer();
            if (User.Identity.Name == "admin")
            {
                Response.Redirect("~/Admin/AdminMain.aspx");
            }
            if (!IsPostBack)
            {
                string barcode = new ASPWebClock.Infrastructure.Business.BWebpassUser().GetBarcodeByUserName(User.Identity.Name);
                IList<WebpassUserProxy> webassUserProxyList = new BWebpassUser().GetPostOfPerson(barcode);
                //string barcode = new UserRepository().GetBarcodeByUserName(User.Identity.Name);
                //DataTable dtResult = new UserRepository().GetPostOfPerson(barcode);
                for (int i = 0; i < webassUserProxyList.Count; i++)
                {
                    ASPxRadioButtonListPosts.Items.Add(webassUserProxyList[i].PersonPost, webassUserProxyList[i].ID);
                }
                ASPxRadioButtonListPosts.SelectedIndex = -1;
                if (ASPxRadioButtonListPosts.Items.Count == 1)
                {


                    FillUserInformation(ASPxRadioButtonListPosts.Items[0].Value.ToString(), ASPxRadioButtonListPosts.Items[0].Text, User.Identity.Name);
                    Response.Redirect("~/MainForm.aspx");
                }
              
            }
        }
        
        private void FillUserInformation(string postID, string postName,string userName)
        {
            ASPWebClock.Infrastructure.Model.Person person = new ASPWebClock.Infrastructure.Business.BWebpassUser().GetPersonByUserName(userName);
            //ASPWebClock.Infrastructure.Model.Person person = new UserRepository().GetPersonByUserName(userName);
            Session["PostID"] = postID;
            Session["PostName"] = postName;
            Session["NameFamily"] = person.Name + " " + person.Family;
            Session["Barcode"] = person.Barcode;
            IList<decimal> listInsteadManPostId=  new BWebpassUser().GetWebpassIDInsteadMans(person.Barcode, DateTime.Now.Date);
            Session["ListPostIDInsteadMan"] = listInsteadManPostId;
            
        }
        protected void ASPxRadioButtonListPosts_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillUserInformation(ASPxRadioButtonListPosts.SelectedItem.Value.ToString(), ASPxRadioButtonListPosts.SelectedItem.Text, User.Identity.Name);
            Response.Redirect("~/MainForm.aspx");
        }

        
    }
}