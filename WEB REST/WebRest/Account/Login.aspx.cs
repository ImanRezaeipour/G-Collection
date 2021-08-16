using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business;

namespace WebRest
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            theLogincontrol.MembershipProvider = new BLogin().GetDefualtMemberShipProvider();
            if (!Page.IsPostBack)
            {
                
            }
            ((TextBox)theLogincontrol.FindControl("UserName")).Focus();
            ((TextBox)theLogincontrol.FindControl("UserName")).Attributes.Add("onfocus", "this.select()");

            bool result = new BDatabaseCreator().ExistWebRestTablesInDatabse();
            if (result == false)
            {
                bool resultCreate = new BDatabaseCreator().CreateWebRestTablesInDatabase();
            }
            
            FillPublicMessage();

        }
        public void FillPublicMessage()
        {
            try
            {
                if (new BWrPublicMessage().GetLastPublicMessage() != null)
                    HiddenFieldPublicMessage.Value = string.IsNullOrEmpty(new BWrPublicMessage().GetLastPublicMessage().Message) ? "" : new BWrPublicMessage().GetLastPublicMessage().Message;
                else
                    HiddenFieldPublicMessage.Value = "";
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}