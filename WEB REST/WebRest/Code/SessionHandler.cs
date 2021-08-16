using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebRest.App_Code
{
    public class SessionHandler
    {
        public static void CheckSessionTimeOut()
        {
            if (HttpContext.Current.Session["Athenticated"] == null)
            {
                try
                {
                    
                    HttpContext.Current.Session.Clear();
                    HttpContext.Current.Session.Abandon();
                    System.Web.Security.FormsAuthentication.SignOut();
                    HttpContext.Current.Response.Redirect("~/Account/Login.aspx");

                }
                catch (Exception)
                {


                }
            }
        }
    }
}