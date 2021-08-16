using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using Model;


namespace DAL
{
    
    public class WebRestMembershipProvider : MembershipProvider
    {
        dbConnection connection = new dbConnection();
        FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
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
        public WebRestMembershipProvider()
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
                if (ChangeOldPasswordIsTrue(username, oldPassword) == true)
                {
                    System.Data.DataTable dtResult = new System.Data.DataTable();
                    string commandText = "update wr_Users set  lgn_Password=@lgn_Password  where (lgn_UserName=@lgn_UserName)";
                    SqlParameter[] paramArray = new SqlParameter[2];
                    SqlParameter userNameParam = new SqlParameter("@lgn_UserName", username);
                    SqlParameter passwordParam = new SqlParameter("@lgn_Password", newPassword);
                    paramArray[0] = userNameParam;
                    paramArray[1] = passwordParam;
                    bool result = connection.executeUpdateQuery(commandText, paramArray);
                    return result;
                }
                else
                {
                    throw new Exception("کلمه عبور قبلی اشتباه می باشد.");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        private  bool ChangeOldPasswordIsTrue(string username, string oldPassword)
        {

            try
            {

                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select   lgn_Password from wr_Users  where (lgn_UserName=@lgn_UserName)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter userNameParam = new SqlParameter("@lgn_UserName", username);
                
                paramArray[0] = userNameParam;

                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult.Rows.Count > 0)
                {
                    if (dtResult.Rows[0]["lgn_Password"].ToString() == oldPassword)
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
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            throw new NotImplementedException();
        }
        public override string ResetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }
        public override string GetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }
        public override bool UnlockUser(string userName)
        {
            throw new NotImplementedException();
        }
        protected override byte[] DecryptPassword(byte[] encodedPassword)
        {
            return base.DecryptPassword(encodedPassword);
        }
        protected override byte[] EncryptPassword(byte[] password)
        {
            return base.EncryptPassword(password);
        }
       
        #endregion

        #region Create Update Delete

        public wr_User CreateUser(decimal personId, decimal roleId, string username, string password, out MembershipCreateStatus status)
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
        public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            throw new NotImplementedException();
        }
        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            throw new NotImplementedException();
        }
        public override void UpdateUser(MembershipUser user)
        {
            throw new NotImplementedException();
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

             
                if (username != null && username.Length > 0 && password != null )
                {
                    try
                    {
                        wr_User wrPersonObj = new wr_User();
                        wrPersonObj = contextFoodReserve.wr_Users.FirstOrDefault(wr => wr.lgn_UserName == username && wr.lgn_Password == encriptPass.ToString());
                        
                        
                        if (wrPersonObj !=null)
                            return true;
                        else
                            return false;
                    }


                    catch (Exception ex)
                    {

                        throw ex;
                    }
                    
                }

                return false;
            
        }
        public override string GetUserNameByEmail(string email)
        {
            throw new NotImplementedException();
        }
        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            throw new NotImplementedException();
            //User user = new UserRepository().GetByUserName(username);
            //return User.ToMemershipUser(user);

        }
        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            throw new NotImplementedException();
        }
        public override int GetNumberOfUsersOnline()
        {
            throw new NotImplementedException();
            //TimeSpan onlineSpan = new TimeSpan(0, System.Web.Security.Membership.UserIsOnlineTimeWindow, 0);
            //DateTime compareTime = DateTime.Now.Subtract(onlineSpan);
            //return new UserRepository().GetNumberOfOnlineUSers(compareTime);
        }
        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }
        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }
        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
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
        #endregion

        #endregion
    }
}