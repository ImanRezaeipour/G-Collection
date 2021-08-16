using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASPWebclock.AppCode
{
    public  class AuthenticatedUser
    {
        public static void CheckUser()
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                HttpContext.Current.Response.Redirect("~/auth/Login.aspx");
               
            }

        }

    }
}