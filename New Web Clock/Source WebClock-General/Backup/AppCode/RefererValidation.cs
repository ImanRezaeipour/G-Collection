using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASPWebclock.AppCode
{
    public class RefererValidation
    {
        public static void CheckReferer()
        {
            if (HttpContext.Current.Request.UrlReferrer == null)
                HttpContext.Current.Response.Redirect("~/MainForm.aspx");
            
        }
       
    }
}