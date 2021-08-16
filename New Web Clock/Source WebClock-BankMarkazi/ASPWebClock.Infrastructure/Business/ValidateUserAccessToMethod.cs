using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Model;
using System.Data;
using ASPWebClock.Infrastructure.Business;
using ASPWebClock.Infrastructure.Utility;
using System.Web;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;

namespace ASPWebClock.Infrastructure.Business
{
   public class ValidateUserAccessToMethod
    {
       public BRole roleBusiness
        {
            get
            {
                return new BRole();
            }
        }
        public BWebpassUser userBussines
        {
            get
            {
                return new BWebpassUser();
            }
        }
        public bool ValidateMethod(decimal postID)
        {
            try
            {
                int userStatus = userBussines.GetUserStatusBywebPassId(postID);
                PersonStatus US = (PersonStatus)Enum.Parse(typeof(PersonStatus), userStatus.ToString());
                DataTable dtResult = roleBusiness.GetAccessRoleNavbarByUserRoleName(US.ToString());
                bool result = false;
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {

                }
                return result;
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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در معتبر ساختن متد  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا  ");
            }
        }
    }
}
