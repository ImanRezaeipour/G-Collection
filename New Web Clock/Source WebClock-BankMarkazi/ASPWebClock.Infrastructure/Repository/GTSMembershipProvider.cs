using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Text;
using ASPWebClock.Infrastructure.Model;
using System.Data.SqlClient;
using System.Configuration;
using ASPWebClock.Infrastructure.Repository;
using ASPWebClock.Infrastructure.Utility;
using ASPWebClock.Infrastructure.Model;

namespace ASPWebClock.Infrastructure.Repository
{
    
    public class GTSMembershipProvider : MembershipProvider
    {
        dbConnection connection = new dbConnection();
        #region Variables
        //Minimun password length
        private int minRequiredPasswordLength = 6;
        //Minium non-alphanumeric char required
        private int minRequiredNonAlphanumericCharacters = 0;
        //Enable - disable password retrieval
        private bool enablePasswordRetrieval = true;
        //Enable - disable password reseting
        private bool enablePasswordReset = false;
        //Require security question and answer (this, for instance, is a functionality which not many people use)
        private bool requiresQuestionAndAnswer = true;
        //Application name
        private string applicationName = "MYAPP";
        //Max number of failed password attempts before the account is blocked, and time to reset that counter
        private int maxInvalidPasswordAttempts = 3;
        private int passwordAttemptWindow = 10;
        //Require email to be unique
        private bool requiresUniqueEmail = true;
        //Password format
        private MembershipPasswordFormat passwordFormat = new MembershipPasswordFormat();
        //Regular expression the password should match (empty for none)
        private string passwordStrengthRegularExpression = String.Empty;
        #endregion
        public GTSMembershipProvider()
        {
           
            //
            // TODO: Add constructor logic here
            //
        }
        private readonly string ConnStrKey = "cnn";
        #region Override properties
       
        public override string ApplicationName
        { 
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
  

        }
        public override bool EnablePasswordReset
        {
            get { throw new NotImplementedException(); }
        }
        public override bool EnablePasswordRetrieval
        {
            get { throw new NotImplementedException(); }
        }
        public override int MaxInvalidPasswordAttempts
        {
            get { throw new NotImplementedException(); }
        }
        public override int MinRequiredNonAlphanumericCharacters
        {
            get { throw new NotImplementedException(); }
        }
        public override int MinRequiredPasswordLength
        {
            get { throw new NotImplementedException(); }
        }
        public override int PasswordAttemptWindow
        {
            get { throw new NotImplementedException(); }
        }
        public override MembershipPasswordFormat PasswordFormat
        {
            get { throw new NotImplementedException(); }
        }
        public override string PasswordStrengthRegularExpression
        {
            get { throw new NotImplementedException(); }
        }
        public override bool RequiresQuestionAndAnswer
        {
            get { throw new NotImplementedException(); }
        }
        public override bool RequiresUniqueEmail
        {
            get { throw new NotImplementedException(); }
        }
        #endregion

        #region override methods

        #region ChangeUSerInfo
        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            
            try
            {
               
                    System.Data.DataTable dtResult = new System.Data.DataTable();
                    string commandText = "update NW_weblogin set  lgn_password=@lgn_password  where (lgn_userName=@lgn_userName)";
                    SqlParameter[] paramArray = new SqlParameter[2];
                    SqlParameter userNameParam = new SqlParameter("@lgn_username", username);
                    SqlParameter passwordParam = new SqlParameter("@lgn_password", newPassword);
                    paramArray[0] = userNameParam;
                    paramArray[1] = passwordParam;
                    bool result = connection.executeUpdateQuery(commandText, paramArray);
                    return result;
               
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                 ASPWebClock.Infrastructure.Model.Log LogObj = new Log();
                 LogObj.Action = "Update";
                 LogObj.date = DateTime.Now;
                 LogObj.UserName = HttpContext.Current.User.Identity.Name;
                 LogObj.Status = false;
                 LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                 LogObj.p_barcode = username;
                 LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                 LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                 LogObj.Comment = string.Format( "خطا در تغییر رمز شخص با barcode="+ username + ex.Message);
                 bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                 throw new MyExceptionHandler("خطا در تغییر رمز شخص با barcode=" + username);
            }
        }
        public  bool ChangeOldPasswordIsTrue(string username, string oldPassword)
        {

            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select   lgn_password from NW_weblogin  where (lgn_userName=@lgn_userName)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter userNameParam = new SqlParameter("@lgn_userName", username);
                
                paramArray[0] = userNameParam;

                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult.Rows.Count > 0)
                {
                    if (dtResult.Rows[0]["lgn_password"].ToString() == oldPassword)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
                //Exception ex = new Exception();
                //ex.Data.Add("sql", "false");
                //if (result == false)
                //    throw ex;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                ASPWebClock.Infrastructure.Model.Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.p_barcode = username;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در شناسایی رمز شخص با barcode="+ username+ ex.Message);
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler ("خطا در شناسایی رمز شخص با barcode=" + username);
            }
        }
        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در تعویض سوال امنیتی و جواب {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تعویض سوال امنیتی و جواب  ");
            }
        }
        public override string ResetPassword(string username, string answer)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در بازنشاندن کلمه عبور {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر بازنشاندن کلمه عبور  ");
            }
        }
        public override string GetPassword(string username, string answer)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت کلمه عبور {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت کلمه عبور  ");
            }
        }
        public override bool UnlockUser(string userName)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در گشودن کاربر {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در گشودن کاربر  ");
            }
        }
        protected override byte[] DecryptPassword(byte[] encodedPassword)
        {
            try
            {
                return base.DecryptPassword(encodedPassword);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در آشکار سازی کلمه عبور {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در آشکار سازی کلمه عبور  ");
            }
        }
        protected override byte[] EncryptPassword(byte[] password)
        {
            try
            {
                return base.EncryptPassword(password);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در پنهان کردن کلمه عبور {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر پنهان کردن کلمه عبور  ");
            }
        }
       
        #endregion

        #region Create Update Delete

        public WebpassUserProxy CreateUser(decimal personId, decimal roleId, string username, string password, out MembershipCreateStatus status)
        {
            try
            {
                throw new NotImplementedException();
                /* if (this.GetUser(username, false).UserName.Length>0) 
                 {
                     throw new Exception("این نام کاربری تکراری است");
                 }
                 Role role = new RoleRepository().GetById(roleId, false);
                 GTS.Clock.Model.Person person = new PersonRepository(false).GetById(personId, false);

                 User user = new User();
                 user.Password = password;
                 user.UserName = username;
                 user.Active = true;
                 user.Person = person;
                 user.Role = role;
                 role.UserList.Add(user);
                 person.UserList.Add(user);

                 UserRepository ur = new UserRepository();
                 ur.Save(user);
                 status = MembershipCreateStatus.Success;
                 return user;*/
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در به وجود اوردن کاربر {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در به وجود اوردن کاربر  ");
            }
        }
        public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در به وجود اوردن کاربر {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در به وجود اوردن کاربر  ");
            }
        }
        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف کاربر {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف کاربر  ");
            }
        }
        public override void UpdateUser(MembershipUser user)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در به روز رسانی کاربر {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در به روز رسانی کاربر  ");
            }
        }
        #endregion

        #region Private Methods

        #endregion

        #region Authenticate
        public override bool ValidateUser(string username, string password)
        {
            
                // password=password.ToUpper();
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
               SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[this.ConnStrKey].ConnectionString);
                if (username != null && username.Length > 0 && password != null )
                {
                    try
                    {
                        System.Data.DataTable dtResult = new System.Data.DataTable();
                        string commandText = "select lgn_userName  from NW_weblogin where (lgn_userName=@lgn_userName) and (lgn_password=@lgn_password)";
                        SqlParameter[] paramArray = new SqlParameter[2];
                        SqlParameter userNameParam = new SqlParameter("lgn_userName", username);
                        SqlParameter passwordParam = new SqlParameter("lgn_password", encriptPass.ToString());
                        paramArray[0] = userNameParam;
                        paramArray[1] = passwordParam;
                        dtResult = connection.executeSelectQuery(commandText, paramArray);
                        //*********************
                        if (dtResult == null)
                        {
                            throw new MyExceptionHandler("خطا در اعتبار سنجی کاربر با barcode=" + username);
                        }
                        if (dtResult.Rows.Count > 0)
                            return true;
                        else
                            return false;
                    }
                    catch (MyExceptionHandler ex)
                    {
                        throw ex;
                    }

                    catch (Exception ex)
                    {
                        ASPWebClock.Infrastructure.Model.Log LogObj = new Log();
                        LogObj.Action = "Select";
                        LogObj.date = DateTime.Now;
                        LogObj.UserName = HttpContext.Current.User.Identity.Name;
                        LogObj.Status = false;
                        LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                        LogObj.p_barcode = username;
                        LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                        LogObj.Comment = string.Format("خطا در لاگین کاربر  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));

                        bool BoolResult = new logRepository().InsertToLogTable(LogObj);

                        throw new MyExceptionHandler("خطا در اعتبار سنجی کاربر با barcode=" + username);
                    }
                   
                  
                    
                }

                return false;
            
        }
        public override string GetUserNameByEmail(string email)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت کاربر با نام {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت کاربر با نام  ");
            }
        }
        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            try
            {
                throw new NotImplementedException();
                //User user = new UserRepository().GetByUserName(username);
                //return User.ToMemershipUser(user);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت کاربر {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت کاربر  ");
            }
        }
        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت کاربر {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت کاربر  ");
            }
        }
        public override int GetNumberOfUsersOnline()
        {
            try
            {
                throw new NotImplementedException();
                //TimeSpan onlineSpan = new TimeSpan(0, System.Web.Security.Membership.UserIsOnlineTimeWindow, 0);
                //DateTime compareTime = DateTime.Now.Subtract(onlineSpan);
                //return new UserRepository().GetNumberOfOnlineUSers(compareTime);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت کاربران آنلاین {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت کاربران آنلاین  ");
            }
        }
        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت کاربر با ایمیل {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت کاربر با ایمیل  ");
            }
        }
        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت کاربر با نام {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت کاربر با نام  ");
            }
        }
        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            try
            {
                throw new NotImplementedException();
                //MembershipUserCollection collection = new MembershipUserCollection();
                //IList<User> userList = new UserRepository().GetAll();
                //totalRecords = userList.Count;        
                //foreach (User user in userList)
                //{
                //    collection.Add(user);
                //}
                //return collection;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت همه ی کاربران {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر دریافت همه ی کاربران  ");
            }
        }
        #endregion

        #endregion
    }
}