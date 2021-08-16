using System;
using ASPWebClock.Infrastructure.Repository;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Utility;
using ASPWebClock.Infrastructure.Model;
using System.Web;
using System.Data.SqlClient;


namespace ASPWebClock.Infrastructure.Business
{
   public class BLog
    {
        public List<LogProxy> GetLog(DateTime ToDate,DateTime FromDate , string SearchKey,LogSearchFields SearchField)
        {
            try
            {
                if (SearchField == LogSearchFields.Nothing)
                    if ((ToDate - FromDate).Days <= 31)
                    {
                        List<LogProxy> logProxyListNothing = new logRepository().GetLogNothing(ToDate, FromDate);
                        for (int i = 0; i < logProxyListNothing.Count; i++)
                        {
                            logProxyListNothing[i].PersianDate = Utility.Utility.MiladiToShamsiDate(logProxyListNothing[i].date);
                            logProxyListNothing[i].Time = logProxyListNothing[i].date.ToShortTimeString();
                        }
                        return (logProxyListNothing);
                    }
                    else
                        throw new MyExceptionHandler("بازه ی زمانی بیش از 1 ماه است ، لطفا مجددا تنظیم کنید");


                List<LogProxy> logProxyList = new logRepository().GetLog(ToDate, FromDate, SearchKey, SearchField);
                for (int i = 0; i < logProxyList.Count; i++)
                {
                    logProxyList[i].PersianDate=Utility.Utility.MiladiToShamsiDate(logProxyList[i].date);
                    logProxyList[i].Time = logProxyList[i].date.ToShortTimeString();
                }
                return (logProxyList);
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
                LogObj.Comment = string.Format("خطا در دریافت وقایع  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت وقایع  ");
            }
        }
        public bool DeleteLog(List<object> ObjctList)
        {
            try
            {
                //return (new logRepository().DeleteLog(ObjctList));
                SqlParameter SqlParam = new SqlParameter();
                foreach (var id in ObjctList)
                {
                    new logRepository().DeleteLog(Convert.ToDecimal(id));
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
                LogObj.Comment = string.Format("خطا در حذف وقایع  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                return false;
                throw new MyExceptionHandler("خطا در حذف وقایع  ");
            }
            return true;
        }
    }
}
