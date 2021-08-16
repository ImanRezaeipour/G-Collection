using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using ASPWebClock.Infrastructure;

using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;
using ASPWebClock.Infrastructure.Utility;
using System.Web;
namespace ASPWebClock.Infrastructure.Business
{
    public class BWebpassUser
    {
        
        public bool CheckPersonIsInsteadMan(string barcode, DateTime fromdate, DateTime todate)
        {
            try
            {
                return (new WebpassUserRepository().CheckPersonIsInsteadMan(barcode, fromdate, todate));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترول جانشین بودن شخص  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترول جانشین بودن شخص  ");
            }
        }
        public DataTable GetInsteadManOfPerson(string personBarcode, DateTime date)
        {
            try
            {
                DataTable dtResult = new WebpassUserRepository().GetInsteadManOfPerson(personBarcode, date);
                dtResult.Columns.Add("fromDate");
                dtResult.Columns.Add("toDate");

                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    dtResult.Rows[i]["fromDate"] = Utility.Utility.MiladiToShamsiDate(((DateTime)dtResult.Rows[i]["FromDateIMan"]));
                    dtResult.Rows[i]["toDate"] = Utility.Utility.MiladiToShamsiDate(((DateTime)dtResult.Rows[i]["ToDateIMan"]));
                }
                return dtResult;
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت شخص جانشین  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت شخص جانشین  ");
            }
        }
        public string DeleteInsteadManOfPerson(decimal id)
        {
            try
            {
                return (new WebpassUserRepository().DeleteInsteadManOfPerson(id));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف شخص جانشین  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر حذف شخص جانشین  ");
            }
        }
        public string UpdateInsteadManPerson(decimal webPassID, string insteadManBarcode, DateTime fromDate, DateTime toDate)
        {
            try
            {
                return (new WebpassUserRepository().UpdateInsteadManPerson(webPassID, insteadManBarcode, fromDate, toDate));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در به روز رسانی شخص جانشین  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در به روز رسانی شخص جانشین  ");
            }
        }
        public int GetRequestOverTimeValue(int webPassid)
        {
            try
            {
                return (new WebpassUserRepository().GetRequestOverTimeValue(webPassid));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مجوز درخواست اضافه کاری  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مجوز درخواست اضافه کاری  ");
            }
        }
        public bool CheckAddOverTimeAccess(string postID)
        {
            try
            {
                return (new WebpassUserRepository().CheckAddOverTimeAccess(postID));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترول دسترسی به اضافه کار  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترول دسترسی به اضافه کار  ");
            }
        }
        public WebLoginUserProxy GetUserOfPersonnel(string barcode)
        {
            try
            {
                return (new WebLoginUserRepository().GetUserOfPersonnel(barcode));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت نام کاربری شخص  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت نام کاربری شخص  ");
            }
        }
        public string AddDefaultUserToNewPerson(string barcode)
        {
            ASPWebClock.Infrastructure.Business.BLogin login = new Infrastructure.Business.BLogin();
            try
            {
                string userName = "";
                string password = "";
                for (int i = 0; i < barcode.Count(); i++)
                {
                    char ch = barcode[i];
                    if (ch != '0')
                    {
                        userName = barcode.Substring(i);
                        password = barcode.Substring(i);
                        break;
                    }
                }
                int status = 7;
                string post = "کارمند";
                return (new WebpassUserRepository().AddDefaultUserToNewPerson(barcode,userName,login.EncryptPassword(password),status,post));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در تخصیص نام کاربری پیشفرض به کاربر جدید  {0}، متن پیغام {1}.خطا",barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر تخصیص نام کاربری پیشفرض به کاربر جدید  ");
            }
        }
        public string AddDefaultUserToEditPerson(string barcode)
        {
            ASPWebClock.Infrastructure.Business.BLogin login = new Infrastructure.Business.BLogin();
            try
            {
                string userName = "";
                string password = "";
                for (int i = 0; i < barcode.Count(); i++)
                {
                    char ch = barcode[i];
                    if (ch != '0')
                    {
                        userName = barcode.Substring(i);
                        password = barcode.Substring(i);
                        break;
                    }
                }
                int status = 7;
                string post = "کارمند";
                return (new WebpassUserRepository().AddDefaultUserToEditPerson(barcode, userName,login.EncryptPassword(password), status, post));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در تخصیص نام کاربری پیشفرض به کاربر  {0}، متن پیغام {1}.خطا",barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تخصیص نام کاربری پیشفرض به کاربر  ");
            }
        }
        public IList<WebpassUserProxy> GetPostManagersOfPerson(string barcode)
        {
            try
            {
                IList<WebpassUserProxy> webpassUserProxyList=new WebpassUserRepository().GetPostOfPerson(barcode).Where(w=>w.Status==1 || w.Status==2 || w.Status==3 || w.Status==6).ToList<WebpassUserProxy>();

                return (webpassUserProxyList);
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مدیر پست کاربر  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مدیر پست کاربر  ");
            }
        }
        public IList<decimal> GetWebpassIDInsteadMans(string personBarcode, DateTime date)
        {
            try
            {
                return (new WebpassUserRepository().GetWebpassIDInsteadMans(personBarcode, date));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت آی دی پست فرد جانشین  {0}، متن پیغام {1}.خطا",personBarcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت آی دی پست فرد جانشین  ");
            }
        }
        public IList<WebpassUserProxy> GetPostOfPerson(string barcode)
        {
            try
            {

            
            return (new WebpassUserRepository()).GetPostOfPerson(barcode);
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت پست شخص  {0}، متن پیغام {1}.خطا",barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پست شخص  ");
            }
        }
        public Person GetPersonByUserName(string userName)
        {
            try
            {
                return (new WebpassUserRepository().GetPersonByUserName(userName));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت کاربر با نام کاربری  {0}، متن پیغام {1}.خطا",userName, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت کاربر با نام کاربری  ");
            }
        }
        public int GetUserStatusBywebPassId(decimal webPassId)
        {
            try
            {
                return (new WebpassUserRepository().GetUserStatusBywebPassId(webPassId));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دسترسی ب هوضعیت کاربر با آی دی پست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دسترسی ب هوضعیت کاربر با آی دی پست  ");
            }
        }
        public string DeleteUserAccessToStatusToOverTime(decimal webpassID)
        {
            try
            {


                return (new WebpassUserRepository().DeleteUserAccessToStatusToOverTime(webpassID));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف دسترسی کاربر به وضعیت اضافه کار  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف دسترسی کاربر به وضعیت اضافه کار  ");
            }
        }
        public string GetBarcodeByUserName(string userName)
        {
            //ASPWebClock.DAL.ClockDataSet.webpassDataTable WebPassTbl = WebPassTA.GetByBarcode(Barcode.PadLeft(8, '0'));
            //return new Person() { BarCode = WebPassTbl[0].p_barcode, Status = WebPassTbl[0].p_status };
            try
            {
                string barcode = new WebpassUserRepository().GetBarcodeByUserName(userName);
                return barcode;
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت بارکد با نام کاربری  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت بارکد با نام کاربری  ");
            }
        }
        public Person GetPersonByPostID(decimal postId)
        {
            try
            {
                return (new WebpassUserRepository().GetPersonByPostID(postId));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت شخص با آی دی پست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت شخص با آی دی پست  ");
            }
        }
        public bool UserisFinalManager(string webPassID)
        {
            try
            {
                return (new WebpassUserRepository().UserisFinalManager(webPassID));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترول مدیر نهایی بودن کاربر  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترول مدیر نهایی بودن کاربر  ");
            }
        }
        public string EditUserAccessToStatusToOverTime(int id, int status, int topMan, int maxTimeReq, int maxOverTime, bool agreeAddWork, bool agreeOverTime, bool isAcceptOwner, bool isFinalManager, List<int> pishCardItems)
        {
            try
            {

           
            return (new WebpassUserRepository().EditUserAccessToStatusToOverTime( id,  status, topMan,  maxTimeReq, maxOverTime, agreeAddWork, agreeOverTime, isAcceptOwner,isFinalManager,pishCardItems));

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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ویرایش دسترسی کاربر به وضعیت اضافه کار  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش دسترسی کاربر به وضعیت اضافه کار  ");
            }
         }
       
        
       
        public bool CheckAgreeOverTimeAccess(string webPassId)
        {
            try
            {
                return (new WebpassUserRepository().CheckAgreeOverTimeAccess(webPassId));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترول تایید مجوز اضافه کاری  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترول تایید مجوز اضافه کاری  ");
            }
        }
        public DataTable GetOverTimeUserAccess(string webPassId)
        {
            try
            {

            
            return (new WebpassUserRepository().GetOverTimeUserAccess(webPassId));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مجوز اضافه کاری  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مجوز اضافه کاری  ");
            }
        }
        
        
        public DataTable GetAllUsersInformationStatusPartManager(string status)
        {
            try
            {

            
            return (new WebpassUserRepository().GetAllUsersInformationStatusPartManager(status));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت تمام اطلاعات مدیر بخش  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت تمام اطلاعات مدیر بخش  ");
            }
        }
        public int GetUserStatus(decimal webPassId)
        {
            try
            {

           
            return (new WebpassUserRepository().GetWebPassUserByID(webPassId).Status);
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت وضعیت  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت وضعیت  ");
            }
        }

        public string AddNewUserToPerson(string barcode, string userName, string Password, string PasswordRepeat)
       {
           try
           {
               if (userName == "")
               {
                   throw new MyExceptionHandler("فیلد نام کاربری را تکمیل نمایید.");
               }
               if (Password == "")
               {
                   throw new MyExceptionHandler("فیلد کلمه عبور را تکمیل نمایید.");
               }
               if (PasswordRepeat == "")
               {
                   throw new MyExceptionHandler("فیلد تکرار کلمه عبور را تکمیل نمایید.");
               }

               if (Password != PasswordRepeat)
               {
                   throw new MyExceptionHandler("کلمه های عبور وارد شده یکسان نمی باشد.");
               }
               if (barcode == string.Empty)
               {
                   throw new MyExceptionHandler("پرسنل جهت ایجاد کاربر انتخاب نشده است.");
               }
               

               WebLoginUserProxy webPassUserProxyObj = new WebLoginUserRepository().GetUserNameExist(userName);



               if (webPassUserProxyObj!=null)
               {
                   
                   throw new MyExceptionHandler("نام کاربری انتخاب شده تکراری می باشد.لطفا نام دیگری انتخاب نمایید.");
               }
               
               webPassUserProxyObj=null;
               webPassUserProxyObj = new WebLoginUserRepository().GetUserOfPersonnel(barcode);


               if (webPassUserProxyObj!=null)
               {
                   throw new MyExceptionHandler("برای این پرسنل نام کاربری وجود دارد.امکان ایجاد کاربر جدید نمی باشد.");
               }
               ASPWebClock.Infrastructure.Business.BLogin login = new Infrastructure.Business.BLogin();

               return (new WebpassUserRepository()).AddNewUserToPerson(barcode, userName, login.EncryptPassword(Password));
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
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در افزودن نام کاربری جدید  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در افزودن نام کاربری جدید  ");
           }
       }
        public string AddNewPostToPerson(string barcode, string post)
        {
            try
            {
                if (barcode == "")
                {
                    throw new MyExceptionHandler("پرسنل جهت ایجاد پست انتخاب نشده است.");
                }
                if (post == "")
                {
                    throw new MyExceptionHandler("لطفا فیلد نام پست را تکمیل نمایید.");
                }
                DataTable dtResult = new WebpassUserRepository().GetPostExistForPersonnel(barcode, post);
                if (dtResult.Rows.Count > 0)
                {
                    throw new MyExceptionHandler("این نام تکراری می باشد.لطفا نام دیگری را انتخاب نمایید.");
                }
                return (new WebpassUserRepository().AddNewPostToPerson(barcode, post));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در افزودن پست جدید  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در افزودن پست جدید  ");
            }
        }
        public string DeletePostOfPerson(int id)
        {
            try
            {
                if (id < 1)
                {
                    throw new MyExceptionHandler("پرسنل جهت ایجاد پست انتخاب نشده است.");
                }


                string Result = new WebpassUserRepository().DeletePostOfPersonnal(id);
                return Result;
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف پست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف پست  ");
            }
        }
        public string EditPostOfPerson(int id, string post,string barcode)
        {
            try
            {
                if (id < 1)
                {
                    throw new MyExceptionHandler("پرسنل جهت ایجاد پست انتخاب نشده است.");
                }
                if (post == "")
                {

                    throw new MyExceptionHandler("لطفا فیلد نام پست را تکمیل نمایید.");
                }

                DataTable dtResult = new WebpassUserRepository().GetPostExistForEditPersonnal(barcode, post, id);
                if (dtResult.Rows.Count > 0)
                {
                    throw new MyExceptionHandler("این نام تکراری می باشد.لطفا نام دیگری را انتخاب نمایید.");
                }
                return (new WebpassUserRepository().EditPostofPerson(id, post));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ویرایش پست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش پست  ");
            }
        }
        public string EditUserOfPerson(string id, string userName, string password, string passwordRepeat)
        {
            try
            {
                ASPWebClock.Infrastructure.Business.BLogin login = new Infrastructure.Business.BLogin();
                string EncryptStaticPassword = login.EncryptStaticPass;
                if (userName == "")
                {
                    throw new MyExceptionHandler("فیلد نام کاربری را تکمیل نمایید.");
                }
                //if (password == "")
                //{
                //    throw new Exception("فیلد کلمه عبور را تکمیل نمایید.");
                //}
                //if (passwordRepeat == "")
                //{
                //    throw new Exception("فیلد تکرار کلمه عبور را تکمیل نمایید.");
                //}
                if (password != passwordRepeat)
                {
                    throw new MyExceptionHandler("کلمه های عبور وارد شده یکسان نمی باشد.");
                }
                if (id == "")
                {
                    throw new MyExceptionHandler("کاربری جهت ویرایش انتخاب نشده است.");
                }
                
                WebLoginUserProxy webLoginUserProxyObj = new WebLoginUserRepository().GetUserNameExist(userName);

                if (webLoginUserProxyObj!=null)
                {
                    if (webLoginUserProxyObj.ID.ToString() != id)
                    {
                        throw new MyExceptionHandler("نام کاربری انتخاب شده تکراری می باشد.لطفا نام دیگری انتخاب نمایید.");
                    }
                }
                if (password == "")
                {
                    return (new WebpassUserRepository()).EditUserOfPerson(id, userName, password);
                }
                else
                {
                    return (new WebpassUserRepository()).EditUserOfPerson(id, userName, login.EncryptPassword(password));
                }
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ویرایش نام کاربری  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش نام کاربری  ");
            }
            
        }
        public string DeleteUserOfPerson(string id)
        {
            try
            {
                if (id == "")
                {
                    throw new MyExceptionHandler("کاربری جهت حذف انتخاب نشده است.");
                }

                return (new WebpassUserRepository()).DeleteUserToPerson(id);
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف نام کاربری  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف نام کاربری  ");
            }
        }

        public string InsertWebPassPerson(string barcode, bool person, bool part, int webPassId)
        {
            try
            {
                if (webPassId == 0)
                {
                    throw new MyExceptionHandler("هیچ پستی انتخاب نشده است.");
                }
                if (barcode == "0")
                {
                    throw new MyExceptionHandler("هیچ گزینه ای جهت اضافه کردن انتخاب نشده است.");
                }
                DataTable dtResult = new WebpassUserRepository().GetWebPassPersonExist(barcode, webPassId);
                if (dtResult.Rows.Count > 0)
                {
                    throw new MyExceptionHandler("این آیتم قبلا اضافه شده است.");
                }

                return (new WebpassUserRepository().InsertWebPassPerson(barcode, person, part, webPassId));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت پست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ثبت پست  ");
            }
        }
        public WebpassUserProxy GetWebPassUserByID(decimal webPassId)
        {
            try
            {
                if (webPassId == 0)
                {
                    throw new MyExceptionHandler("هیچ نام کاربری انتخاب نشده است.");
                }

                return (new WebpassUserRepository().GetWebPassUserByID(webPassId));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت پست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پست  ");
            }
        }
        public DataTable GetWebPassPersonsByID(decimal webpassId)
        {
            try
            {
                return new WebpassUserRepository().GetWebPassPersonsByID(webpassId);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        public string GetWebPassIDByUserName(string userName,string post)
        {
            try
            {

            
            return (new WebpassUserRepository().GetWebPassIDByUserName(userName,post));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت آی دی پست با نام کاربری  {0}، متن پیغام {1}.خطا",userName,  Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت آی دی پست با نام کاربری  ");
            }
        }
        public string EditWebPassPerson(bool isKarkardfrm, bool isRequestfrm, bool isOperatorfrm, bool isKeeperfrm, bool isOverTimefrm, bool isSubPart, bool AccessType, int id)
        {
            try
            {

           
            return (new WebpassUserRepository().EditWebPassPerson(isKarkardfrm, isRequestfrm, isOperatorfrm, isKeeperfrm, isOverTimefrm, isSubPart,AccessType, id));

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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ویرایش پست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش پست  ");
            }
        }
        public string DeleteWebPassPerson(int id)
        {
            try
            {

           
            return (new WebpassUserRepository().DeleteWebPassPerson(id));
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف پست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف پست  ");
            }
        }
    }
}
