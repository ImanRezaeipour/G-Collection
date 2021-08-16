using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxClasses;
using System.Web.UI.HtmlControls;
using ASPWebClock.Infrastructure;
using ASPWebClock.DAL;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.DAL.Repository;
using ASPWebClock.Infrastructure.Business;
using System.Collections;
using ASPWebClock.DAL.Business;
using System.Data;
using System.Web.Security;

namespace ASPWebclock
{
    public partial class MainForm : System.Web.UI.Page
    {
        public BRole roleBusiness
        {
            get
            {
                return new BRole();
            }
        }
        public BUser userBussines
        {
            get
            {
                return new BUser();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.Name == "admin")
            {
                Response.Redirect("~/Admin/AdminMain.aspx");
            }
            if (Session["PostID"] == null)
            {
                Session.Abandon();
                FormsAuthentication.SignOut();
                FormsAuthentication.RedirectToLoginPage();
                
            }
            else
            {
               
                List<int> listUserInsteadManStatus = new List<int>();
                IList<decimal> ListPostIDInsteadMan = (IList<decimal>)Session["ListPostIDInsteadMan"];
                if (!ListPostIDInsteadMan.Contains(Convert.ToDecimal(Session["PostID"])))
                     ListPostIDInsteadMan.Add(Convert.ToDecimal(Session["PostID"]));
                for (int i = 0; i < ListPostIDInsteadMan.Count; i++)
                {
                    int userStatus = userBussines.GetUserStatusBywebPassId(ListPostIDInsteadMan[i]);
                    if(!listUserInsteadManStatus.Any(status=>status==userStatus))
                    listUserInsteadManStatus.Add(userStatus);
                }
                
                for (int i = 0; i < listUserInsteadManStatus.Count; i++)
                {
                    PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), listUserInsteadManStatus[i].ToString());
                    
                    DataTable dtResult = roleBusiness.GetAccessRoleNavbarByUserRoleName(US.ToString());
                    for (int k = 0; k < dtResult.Rows.Count; k++)
                    {
                        for (int j = 0; j < ASPxNavBar.Items.Count; j++)
                        {
                            if (ASPxNavBar.Items[j].Name == dtResult.Rows[k]["navbar_Name"].ToString())
                            {
                                ASPxNavBar.Items[j].Visible = true;
                                ASPxNavBar.Items[j].Group.Visible = true;
                            }
                        }


                    }
                }
                
            }

        }
    }
}