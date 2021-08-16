using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using ASPWebClock.Infrastructure.Repository;
using System.Drawing;
using ASPWebclock.AppCode;
using ASPWebClock.Infrastructure.Business;
using ASPWebClock.Infrastructure.Utility;
using ASPWebClock.Infrastructure.Model;

namespace ASPWebclock
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
            SessionHandler.CheckSessionTimeOut(this.Page);
            RefererValidation.CheckReferer();
            if (!Page.IsPostBack)
            {
                
            }
        }

        protected void saveBtn_Click(object sender, EventArgs e)
        {
            try
            {


                if (new BLogin().ChangePassword(Username, this.currentPassword.Text, this.newPassword.Text,confirmNewPassword.Text))
                {
                    lblMessage.Text = "عملیات تغییر رمزعبور با موفقیت پایان پذیرفت";
                    lblMessage.ForeColor = Color.Green;

                }
                else
                {
                    lblMessage.ForeColor = Color.Red;
                    lblMessage.Text = "خطا در انجام عملیات.لطفا مجددا سعی نمایید.";
                }
                
            }

            catch (MyExceptionHandler ex)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = ex.Message;
            }
            catch (Exception ex)
            {
                ASPWebClock.Infrastructure.Model.Log LogObj = new ASPWebClock.Infrastructure.Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.UI.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در تغییر کلمه عبور  {0}، متن پیغام {1}.خطا", Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تغییر کلمه عبور");
            }
        }

       

        



    }
}
