using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;
using ASPWebClock.Infrastructure.Utility;
using System.Web;

namespace ASPWebClock.Infrastructure.Business
{
   public class BReport
    {
       public List<Report> LoadAllReportsByPerson(Person prc)
       {
           try
           {
               return new Repository.ReportRepository().LoadAllReportsByPerson(prc);
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
               LogObj.Comment = string.Format("خطا در دریافت همه ی گزارش ها با نقش پرسنل {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت همه ی گزارش ها با نقش پرسنل");
           }
       }

       public List<Report> LoadAllReports()
       {
           try
           {
               return new ReportRepository().LoadAllReports();
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
               LogObj.Comment = string.Format("خطا در دریافت همه ی گزارش ها {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت همه ی گزارش ها");
           }
       }
       public Report GetReportByID(decimal id)
       {
           try
           {
               return new ReportRepository().GetReportByID(id);
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
               LogObj.Comment = string.Format("خطا در دریافت گزارش {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت گزارش");
           }
       }
       public DataTable GetAccessReports()
       {
           try
           {
               return new Repository.ReportRepository().GetAccessReports();
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
               LogObj.Comment = string.Format("خطا در دریافت دسترسی گزارش {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت دسترسی گزارش");
           }
       }
       public string InsertAccessReports(string reportId, Dictionary<string, bool> dicNewValue)
       {
           try
           {
               return new Repository.ReportRepository().InsertAccessReports(reportId, dicNewValue);
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
               LogObj.Comment = string.Format("خطا در ثبت دسترسی گزارش ها {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در ثبت دسترسی گزارش ها");
           }
       }
    }
}
