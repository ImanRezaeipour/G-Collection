using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using ASPWebClock.Infrastructure.Repository;
using System.Drawing;

namespace ASPWebclock.Admin
{
    public partial class AdminChangePassword : System.Web.UI.Page
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

        }
        protected void saveBtn_Click(object sender, EventArgs e)
        {
            try
            {
                if (validate())
                {
                    GTSMembershipProvider mem = new GTSMembershipProvider();
                    if (mem.ChangePassword(Username, this.CodedPass(currentPassword.Text), this.CodedPass(newPassword.Text)))
                    {
                        lblMessage.Text = "عملیات تغییر رمزعبور با موفقیت پایان پذیرفت";
                        lblMessage.ForeColor = Color.Green;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = ex.Message;
            }
        }

        private bool validate()
        {
            if (this.newPassword.Text.Length != this.confirmNewPassword.Text.Length)
            {
                throw new Exception("عدم مطابقت طول رمز");
            }
            if (this.newPassword.Text != this.confirmNewPassword.Text)
            {
                throw new Exception("عدم مطابقت رمز");
            }
            return true;
        }

        private string CodedPass(string pass)
        {

            StringBuilder encriptPass = new StringBuilder();
            foreach (char ch in pass)
            {
                if (ch.Equals('v'))
                {
                    encriptPass.Append(ch);
                }
                else
                {
                    int chVal = ((int)((int)ch) ^ 118);
                    encriptPass.Append((char)chVal);
                }
            }
            return encriptPass.ToString();
        }
    }
}