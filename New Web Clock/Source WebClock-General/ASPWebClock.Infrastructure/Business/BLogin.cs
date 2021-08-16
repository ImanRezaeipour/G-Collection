using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Repository;
using ASPWebClock.Infrastructure.Utility;
using System.Web;
using ASPWebClock.Infrastructure.Model;


namespace ASPWebClock.Infrastructure.Business
{
    public class BLogin
    {
        #region Properties
    
        /// <summary>
        /// اطلاعات مربوط به دامین تعریف شده را برمیگرداند
        /// </summary>
        public string GetDomainInfo
        { 
            get
            {
                return "";// Utility.Utility.ReadAppSetting("DomainInfo");
            }
        }
        public string EncryptStaticPass
        {
            get
            {
                return EncryptPassword("*&^%!@#$");
            }
        }
        /// <summary>
        /// کاربری که درحال حاضر وارد شده است را برمیگرداند
        /// </summary>
        
        public string CurentUserName 
        {
            get
            {
                if (System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
                    return System.Web.HttpContext.Current.User.Identity.Name;
                return "";
            }
        }

        /// <summary>
        /// آیا کاربری وارد شده است
        /// </summary>
        public bool IsAuthenticated
        {
            get
            {
                return System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
            }
        }
     
        #endregion

        #region Methods

        /// <summary>
        ///  باید پروایدر آن تغییر کنداگر شخص قرار است از اکتیو دایرکتوری استفاده کند 
        /// </summary>
        /// <param name="username"></param>
        public MembershipProviders GetDefaultAuthenticationProvider(string username)
        {
            //if (this.ActiveDirectoryISAllowed(username))
            //{
            //    return MembershipProviders.ADMembershipProvider;
            //}
            return MembershipProviders.GTSMembershipProvider;
        }

        /// <summary>
        /// تنظیم نام کاربری کامل در دامین
        /// </summary>
        /// <param name="username"></param>
        public string GetCompleteDoaminUsername(string username)
        {
            
            return username;
        }

        /// <summary>
        /// حذف علامتهای اضافی در نام کاربری تا در دیتابیس قابل استفاده شود
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public string GetSimpleUserName(string username)
        {            
            if (username.Contains("@"))
            {
                username = username.Remove(username.IndexOf("@"));
            }
            return username;
        }
        public bool ChangePassword(string username, string oldPassword, string newPassword, string confromNewPassword)
        {
           
            try
            {
                
                if (new ASPWebClock.Infrastructure.Repository.GTSMembershipProvider().ChangeOldPasswordIsTrue(username,EncryptPassword(oldPassword)) == true)
                {
                    bool result = new ASPWebClock.Infrastructure.Repository.GTSMembershipProvider().ChangePassword(username, EncryptPassword(oldPassword),EncryptPassword(newPassword));
                    return result;
                }
                else
                {
                   throw new MyExceptionHandler("کلمه عبور قبلی اشتباه می باشد");
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در تغییر کلمه عبور  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تغییر کلمه عبور");
            }

        }
        private bool validatePassword(string newPassword, string confirmNewPassword)
        {
            try
            {
                if (newPassword.Length != confirmNewPassword.Length)
                {
                    throw new MyExceptionHandler("عدم مطابقت طول رمز");
                }
                if (newPassword != confirmNewPassword)
                {
                    throw new MyExceptionHandler("عدم مطابقت رمز");
                }
                return true;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در تغییر کلمه عبور  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تغییر کلمه عبور");
            }

        }
        public string EncryptPassword(string password)
        {
            try
            {
                StringBuilder encriptPass = new StringBuilder();
                foreach (char ch in password)
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
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در پنهان کردن کلمه عبور  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در پنهان کردن کلمه عبور  ");
            }
        }

        #endregion
    }
}