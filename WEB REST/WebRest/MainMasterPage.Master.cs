using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Model;
using Business;

namespace WebRest
{
    public partial class MainMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (HttpContext.Current.User.Identity.Name != "admin")
                {
                    Session["ParameterDic"] = new BParameter().GetParametersDic();
                    Session["PersonObj"] =new BPerson().GetPersonByBarocde(new BWrUsers().GetBarcodePersonByUsername(HttpContext.Current.User.Identity.Name).ToString());
                    lblBarcode.Text =((person)Session["PersonObj"]).P_BarCode;
                    lblName.Text = ((person)Session["PersonObj"]).P_Name + " " + ((person)Session["PersonObj"]).P_Family;
                }
                else
                {
                    lblBarcode.Text = "admin";
                    lblName.Text = "مدیر سیستم";
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
            
            
        }

        protected void ImageButtonLogOut_Click(object sender, ImageClickEventArgs e)
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }
    }
}