using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;
using ASPWebClock.Infrastructure.Utility;
using System.Web;


namespace ASPWebClock.Infrastructure.Business
{
  public  class BStation
    {
      public List<Station> GetAllStations()
      {
          try
          {
              return new StationRepository().GetAllStations();
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
              LogObj.Comment = string.Format("خطا در دریافت همه ی ایستگاه ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
              bool BoolResult = new logRepository().InsertToLogTable(LogObj);
              throw new MyExceptionHandler("خطادر دریافت همه ی ایستگاه ها  ");
          }
      }
    }
}
