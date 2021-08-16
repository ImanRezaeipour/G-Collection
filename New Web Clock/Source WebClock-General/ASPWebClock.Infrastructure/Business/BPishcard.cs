using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;
using ASPWebClock.Infrastructure.Utility;

namespace ASPWebClock.Infrastructure.Business
{
   public class BPishcard
    {
       public Pishcard GetPishcardByCode(int pishCode, int initCode)
       {
           try
           {


               return (new PishcardRepository().GetPishcardByCode(pishCode, initCode));
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
               LogObj.Comment = string.Format("خطا در دریافت  پیش کارت با کد  {0}، متن پیغام {1}.خطا", pishCode.ToString(), Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت  پیش کارت با کد  " + pishCode.ToString());
           }
       }
       public List<Pishcard> GetAllActivePishCard()
       {
           try
           {


               return (new PishcardRepository().GetAllActivePishCard());
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
               LogObj.Comment = string.Format("خطا در دریافت همه پیش کارت ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت همه پیش کارت ها  ");
           }
       }
       public List<Pishcard> GetAllActivePishCardPersons(decimal webPassId)
       {
           try
           {


               return (new PishcardRepository().GetAllActivePishCardPersons(webPassId));
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
               LogObj.Comment = string.Format("خطا در دریافت همه ی پیش کارت های فعال  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت همه ی پیش کارت های فعال  ");
           }
       }
       public List<Pishcard> GetActivePishCardUserAccessDeneid(decimal webPassId)
       {
           try
           {


               return (new PishcardRepository().GetActivePishCardUserAccessDeneid(webPassId));
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
               LogObj.Comment = string.Format("خطا در عدم دسترسی کاربر به پیش کارت  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در عدم دسترسی کاربر به پیش کارت  ");
           }
       }
       public List<Pishcard> GetActivePishCardUserAccessAllowed(decimal webPassId)
       {
           try
           {


               return (new PishcardRepository().GetActivePishCardUserAccessAllowed(webPassId));
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
               LogObj.Comment = string.Format("خطا در اجازه دسترسی کاربر به پیش کارت  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در اجازه دسترسی کاربر به پیش کارت  ");
           }
       }
       public List<Pishcard> GetPishCardDailyPerson(string barcode)
       {
           try
           {
               return (new PishcardRepository().GetPishCardDailyPerson(barcode));
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
               LogObj.Comment = string.Format("خطا در دریافت پیش کارت روزانه {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت پیش کارت روزانه ");
           }
       }
       public List<Pishcard> GetPishCardHourlyPermitPerson(string barcode)
       {
           try
           {
               return (new PishcardRepository().GetPishCardHourlyPermitPerson(barcode));
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
               LogObj.Comment = string.Format("خطا در دریافت پیش کارت ساعتی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطادر دریافت پیش کارت ساعتی ");
           }
       }
       public List<Pishcard> GetPishCardHourlyPerson(string barcode)
       {
           try
           {


               return (new PishcardRepository().GetPishCardHourlyPerson(barcode));
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
               LogObj.Comment = string.Format("خطا در دریافت پیش کارت ساعتی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت پیش کارت ساعتی ");
           }
       }
       public List<Pishcard> GetAllPishCardPerson(string barcode)
       {
           try
           {
               return new PishcardRepository().GetAllPishCardPerson(barcode);
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
               LogObj.Comment = string.Format("خطا در دریافت همه پیش کارت ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت همه پیش کارت ها ");
           }
       }
       public List<Pishcard> GetPishCardHourlyTrafficPerson(string barcode)
       {
           try
           {
               return (new PishcardRepository().GetPishCardHourlyTrafficPerson(barcode));
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
               LogObj.Comment = string.Format("خطا در دریافت پیش کارت تردد ساعتی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطادر دریافت پیش کارت تردد ساعتی ");
           }
       }
    }
}
