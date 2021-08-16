using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using DAL;

namespace Business
{
   public class BLogin
    {
       public string GetDefualtMemberShipProvider()
       {
           try
           {
               return "WebRestMembershipProvider";
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public string EncryptPassword(string password)
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

       public bool ChangePassword(string userName,string password, string newPassword, string confirmNewPassword)
       {
           try
           {
               if (validatePassword(newPassword, confirmNewPassword))
               {
                   WebRestMembershipProvider mem = new WebRestMembershipProvider();
                   if (mem.ChangePassword(userName, this.EncryptPassword(password), this.EncryptPassword(newPassword)))
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
       private bool validatePassword(string newPassword, string confirmNewPassword)
       {
           try
           {

          
           if (newPassword.Length != confirmNewPassword.Length)
           {
               throw new Exception("عدم مطابقت طول رمز");
           }
           if (newPassword != confirmNewPassword)
           {
               throw new Exception("عدم مطابقت رمز");
           }
           return true;
           }
           catch (Exception ex)
           {

               throw ex;
           }
        
       }
    }
}
