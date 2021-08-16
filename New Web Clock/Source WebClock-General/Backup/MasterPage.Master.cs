using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Business;
using ASPWebclock.AppCode;

namespace ASPWebclock
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Response.Cache.SetCacheability(HttpCacheability.NoCache);
               if(Session["PostID"]!=null)
               {
                   lblPost.Text=Session["PostName"].ToString();
                   lblName.Text = Session["NameFamily"].ToString();
                   lblBarcode.Text = Session["Barcode"].ToString();

               }

      
            if(!this.IsPostBack)
            {
                CacheSettingsProvider.ClearCache();
            }
            if (HttpContext.Current.User.Identity.Name.ToString().ToLower() == "admin")
            {
                ImageButtonChangePost.Visible = false;
                ASPxRoundPanelUserInformation.Visible = false;
            }
           
            
        }

     

        protected void ImageButtonLogOut_Click(object sender, ImageClickEventArgs e)
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void ImageButtonChangePost_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/SelectPost.aspx");
        }

        
    }
}