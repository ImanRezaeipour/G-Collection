using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;
using System.Data;
using System.Collections.Specialized;
using System.Web;
using ASPWebClock.Infrastructure.Utility;

namespace ASPWebClock.Infrastructure.Business
{
   public class BRole
    {
        public IList<Role> GetAllRoles()
        {
            return (new RoleRepositpry().GetAllRoles());
        }
        public DataTable GetAllNavbar()
        {
            try
            {
                return (new RoleRepositpry().GetAllNavbar());
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت همه ی منو ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر دریافت همه ی منو ها  ");
            }
        }
        public Navbar GetNavbarByName(string nameNavbar)
        {
            try
            {
                return (new RoleRepositpry().GetNavbarByName(nameNavbar));
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت  منو  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر دریافت  منو   ");
            }
        }
        public WebControl GetControlByName(string nameControl)
        {
            try
            {
                return (new RoleRepositpry().GetControlByName(nameControl));
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت  کنترل ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر دریافت  کنترل ها   ");
            }
        }
        public DataTable GetAccessRoleNavbar()
        {
            try
            {


                return (new RoleRepositpry().GetAccessRoleNavbar());
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت منو  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر دریافت  منو   ");
            }
        }
        public DataTable GetAccessControls(string navbarName)
        {
            try
            {

            
            return (new RoleRepositpry().GetAccessControls(navbarName));
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت دسترسی منو  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر دریافت دسترسی منو   ");
            }
        }
        public bool DeleteAccessRoleNavbar(string roleName)
        { 
        return (new RoleRepositpry().DeleteAccessRoleNavbar(roleName));
        }
        public string InsertAccessRoleNavbar(string navbarName, Dictionary<string, bool> dicRoleName)
        {
            try
            {


                bool result = (new RoleRepositpry().InsertAccessRoleNavbar(navbarName, dicRoleName));
                if (result == true)
                {
                    Log LogObj = new Log();

                    LogObj.Action = "";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = true;
                    LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                    LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    string newChanges = "";
                    foreach (KeyValuePair<string, bool> item in dicRoleName)
                    {
                        newChanges += new DicStatus().GetTitleStatus(item.Key) + "=" + item.Value + ",";
                    }
                    string objName = "";
                    Navbar navbarObj = GetNavbarByName(navbarName);
                    if (navbarObj != null)
                        objName = navbarObj.navbar_Title;
                    WebControl webControlObj = GetControlByName(navbarName);
                    if (webControlObj != null)
                        objName = webControlObj.Ctrl_Title;
                    LogObj.Comment = "دسترسی نقش برای کنترل " + objName + " توسط کاربر " + HttpContext.Current.User.Identity.Name + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + " در ساعت " + (DateTime.Now.TimeOfDay.Hours.ToString() + ":" + DateTime.Now.TimeOfDay.Minutes.ToString() + ":" + DateTime.Now.TimeOfDay.Seconds.ToString()) + newChanges + " ویرایش گردید.";
                    bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                    return "اطلاعات با موفقیت ثبت شد.";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ثبت اطلاعات .مجددا سعی نمایید");
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در ثبت درخواست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر ثبت درخواست   ");
            }
        }
        public string InsertAccessControls(string controlName, Dictionary<string, bool> dicControlName)
        {
            try
            {
                return (new RoleRepositpry().InsertAccessControls(controlName, dicControlName));
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در ثبت  دسترسی کنترل  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر ثبت  دسترسی کنترل   ");
            }
        }
        public DataTable GetAccessRoleNavbarByUserRoleName(string roleName)
        {
            try
            {
                return (new RoleRepositpry().GetAccessRoleNavbarByUserRoleName(roleName));
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در ثبت  دسترسی کنترل  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر ثبت  دسترسی کنترل   ");
            }
        }
    }
}
