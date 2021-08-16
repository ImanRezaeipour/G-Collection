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
   public class BAssignReportParameter
    {
       public List<ReportParameterProxy> GetReportParametersByID(decimal id)
       {
           try
           {
               return new AssignReportParameterRepository().GetReportParametersByID(id);
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
               LogObj.Comment = string.Format("خطا در دریافت گزارش  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت گزارش");
           }
       }
    }
}