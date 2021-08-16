using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using ASPWebClock.Infrastructure.Business;
using System.Diagnostics;
using ASPWebClock.Infrastructure.Business;

namespace ASPWebclock
{
    public partial class Login : System.Web.UI.Page
    {
        BLogin businessLogin = new BLogin();

        protected void Login_Click(object sender, System.EventArgs e)
        {
          
            //string username = theLogincontrol.UserName.PadLeft(8, '0');
            string username = theLogincontrol.UserName;
            //theLogincontrol.MembershipProvider = businessLogin.GetDefaultAuthenticationProvider(username).ToString("G");
            //theLogincontrol.UserName = businessLogin.GetCompleteDoaminUsername(username);
            
            
            Session["LoginUserCode"] = username;
            Session["pcode"] = username;
           
        }
        
        protected void Page_Load(object sender, System.EventArgs e)
        {
            
            
            if (!Page.IsPostBack) 
            {
                if(Request.QueryString.Count>0)
                Response.Redirect("~/auth/Login.aspx");
                if (Request["ReturnUrl"] != null) 
                {
                    string returnUrl = Request["ReturnUrl"];
                    if (returnUrl.Contains("?"))
                    {
                        returnUrl = returnUrl.Remove(returnUrl.IndexOf('?'));
                        Response.Redirect("~/auth/Login.aspx?ReturnUrl=" + returnUrl);
                    }
                }
            }
            ((TextBox)theLogincontrol.FindControl("UserName")).Focus();
            ((TextBox)theLogincontrol.FindControl("UserName")).Attributes.Add("onfocus", "this.select()");
        }

        protected void theLogincontrol_LoggedIn(object sender, System.EventArgs e)
        {
            Session["Athenticated"] = true;
        }

        

       


     
    }
}
