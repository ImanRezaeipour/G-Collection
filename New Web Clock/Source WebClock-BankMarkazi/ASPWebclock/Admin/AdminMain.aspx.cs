using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebclock.AppCode;

namespace ASPWebclock.Admin
{
    public partial class AdminMain : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionHandler.CheckSessionTimeOut(this.Page);
            RefererValidation.CheckReferer();
            if(User.Identity.Name!="admin")
            {
                Response.Redirect("~/MainForm.aspx");
            }
            
        }
    }
}