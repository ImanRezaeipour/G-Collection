using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business;
using System.Drawing;

namespace WebRest.Account
{
    public partial class ChangePassword : System.Web.UI.Page
    {
         public string Username
        {
            get
            {
                return this.User.Identity.Name;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            if (!Page.IsPostBack)
            {

            }
        }

        

        protected void ASPxButtonSave_Click(object sender, EventArgs e)
        {
            try
            {


                if (new BLogin().ChangePassword(User.Identity.Name, currentPassword.Text, newPassword.Text, confirmNewPassword.Text))
                {
                    lblMessage.Text = "عملیات تغییر رمزعبور با موفقیت پایان پذیرفت";
                    lblMessage.ForeColor = Color.Green;
                }

            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = ex.Message;
            }
        }

       

       



    }
    
}