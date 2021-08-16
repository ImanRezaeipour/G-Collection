using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;
using System.Web;

namespace ASPWebClock.Infrastructure.Repository
{
   public class StationRepository
    {
       logRepository logger = new logRepository();
       dbConnection connection = new dbConnection();

       public List<Station> GetAllStations()
       {
           try
           {
               System.Data.DataTable dtResult = new System.Data.DataTable();
               string commandText = "select * from stations";
               SqlParameter[] paramArray = new SqlParameter[0];
               List<Station> stationsList = new List<Station>();
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت ایستگاه ها");
               }
               for (int i = 0; i < dtResult.Rows.Count; i++)
               {
                   Station stationObj = new Station()
                   {
                       st_Code = Convert.ToInt16(dtResult.Rows[i]["st_Code"]),
                       st_Name = dtResult.Rows[i]["st_Name"].ToString()

                   };
                   stationsList.Add(stationObj);
               }

               //*********************

               return stationsList;
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
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.Comment = string.Format("خطا در دریافت ایستگاه ها {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
               bool result = logger.InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت ایستگاه ها");
           }
       }
    }
}
