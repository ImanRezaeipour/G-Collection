using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASPWebclock.AppCode
{
    public class SessionHandler
    {
        public static void CheckSessionTimeOut(System.Web.UI.Page page)
        {
            if (HttpContext.Current.Session["Athenticated"] == null)
            {
                try
                {

                    HttpContext.Current.Session.Clear();
                    HttpContext.Current.Session.Abandon();
                    System.Web.Security.FormsAuthentication.SignOut();

                    if (!page.IsCallback)
                    HttpContext.Current.Response.Redirect("~/auth/Login.aspx",true);
                    else
                    DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("~/auth/Login.aspx");
                }
                catch (Exception ex)
                {

                   
                }
            }
        }
    }
}