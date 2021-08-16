using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace HelpNWClock
{
    public partial class HelpContent : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["formKeyHelp"] != null)
            {
                string queryS = Request.QueryString["formKeyHelp"].ToString();
                LoadHelp(queryS);
            }

        }
        private void LoadHelp(string formkey)
        {
            DAL.BHelp bhelp = new DAL.BHelp();
            DAL.ModelHelp help = new DAL.ModelHelp();
            help = bhelp.GetHelpByFormKey(formkey);
            LiteralContent.Text = help.Help_FaHTMLContent;
        }
    }
}