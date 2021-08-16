using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using ASPWebClock.Infrastructure.Business;
using ASPWebClock.Infrastructure.Model;
using ASPWebclock.AppCode;
using System.Data;
using System.Diagnostics;
using ASPWebClock.Infrastructure.Utility;

namespace ASPWebclock
{
    public partial class SelectPost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            
            RefererValidation.CheckReferer();
            if (User.Identity.Name == "admin")
            {

                Response.Redirect("~/Admin/AdminMain.aspx");
            }
            if (!IsPostBack)
            {
                Person personObj = (Person)Session["PersonObj"];
                IList<WebpassUserProxy> webassUserProxyList = new BWebpassUser().GetPostOfPerson(personObj.Barcode);
                
                for (int i = 0; i < webassUserProxyList.Count; i++)
                {
                    ASPxRadioButtonListPosts.Items.Add(webassUserProxyList[i].PersonPost, webassUserProxyList[i].ID);
                }
                ASPxRadioButtonListPosts.SelectedIndex = -1;
                if (ASPxRadioButtonListPosts.Items.Count == 1)
                {


                    FillUserInformation(ASPxRadioButtonListPosts.Items[0].Value.ToString(), ASPxRadioButtonListPosts.Items[0].Text, User.Identity.Name);
                    Response.Redirect("~/MainForm.aspx");
                }
              
            }
        }
        
        private void FillUserInformation(string postID, string postName,string userName)
        {
            try
            {

            
                Person person = new BWebpassUser().GetPersonByUserName(userName);
                Session["PostID"] = postID;
                
                Session["PostName"] = postName;
                IList<decimal> listInsteadManPostId = new BWebpassUser().GetWebpassIDInsteadMans(person.Barcode, DateTime.Now.Date);
                Session["ListPostIDInsteadMan"] = listInsteadManPostId;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                throw ex;
            }

            
        }
        protected void ASPxRadioButtonListPosts_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {


                FillUserInformation(ASPxRadioButtonListPosts.SelectedItem.Value.ToString(), ASPxRadioButtonListPosts.SelectedItem.Text, User.Identity.Name);
                Response.Redirect("~/MainForm.aspx");
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        
    }
}