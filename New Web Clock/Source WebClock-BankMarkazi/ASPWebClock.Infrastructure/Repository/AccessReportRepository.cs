using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;
using System.Web;

namespace ASPWebClock.Infrastructure.Repository
{
    public class AccessReportRepository
    {
       logRepository logger = new logRepository();
       dbConnection connection = new dbConnection();

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
       public List<AccessReport> GetAll()
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {

               string commandText = @"select * from NW_AccessReports";
               SqlParameter[] paramArray = new SqlParameter[0];
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت دسترسی گزارشات.لطفا مجددا سعی نمایید.");
               }
               List<AccessReport> accessListReprts = new List<AccessReport>();
               for (int i = 0; i < dtResult.Rows.Count; i++)
               {
                   AccessReport rpt = new AccessReport()
                   {
                       AccessReports_ID= (decimal)dtResult.Rows[i]["AccessReports_ID"],
                       Report_ID = (decimal)dtResult.Rows[i]["Report_ID"],
                       Role_ID = (decimal)dtResult.Rows[i]["Role_ID"],
                   };
                   accessListReprts.Add(rpt);
               }

               return accessListReprts;
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {
               Model.Log logObj = new Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در وا کشی گزارشات  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool result = logger.InsertToLogTable(logObj);
               throw new MyExceptionHandler("خطا در دریافت همه گزارشات.لطفا مجددا سعی نمایید.");
           }
       }
       
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
       // public AccessReport GetByID(decimal id)
       //{
       //    throw new NotImplementedException();
       //    System.Data.DataTable dtResult = new System.Data.DataTable();
       //    try
       //    {
       //        string commandText = @"select * from NW_Report where Report_ID=@id";
       //        SqlParameter[] paramArray = new SqlParameter[1];
       //        SqlParameter idParam = new SqlParameter("@id", id);
       //        paramArray[0] = idParam;
       //        dtResult = connection.executeSelectQuery(commandText, paramArray);
       //        if (dtResult == null)
       //        {
       //            throw new MyExceptionHandler("خطا در دریافت  گزارش با ID= " + id + ".لطفا مجددا سعی نمایید.");
       //        }
       //        Report rpt;
       //        if (dtResult.Rows.Count > 0)
       //        {
       //            rpt = new Report()
       //            {
       //                Report_ID = (decimal)dtResult.Rows[0]["Report_ID"],
       //                Report_Name = dtResult.Rows[0]["Report_Name"].ToString(),
       //                Report_FileAddress = dtResult.Rows[0]["Report_FileAddress"].ToString(),
       //                Report_IsCalculate = (bool)dtResult.Rows[0]["Report_IsCalculate"]
       //            };

       //        }
       //        else
       //        {
       //            rpt = new Report();
       //        }

       //        return rpt;
       //    }
       //    catch (MyExceptionHandler ex)
       //    {
       //        throw ex;
       //    }
       //    catch (Exception ex)
       //    {

       //        Model.Log logObj = new Model.Log();
       //        logObj.Action = "Select";
       //        logObj.date = DateTime.Now;
       //        logObj.UserName = HttpContext.Current.User.Identity.Name;
       //        logObj.Status = false;
       //        logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
       //        logObj.Comment = string.Format("خطا در وا کشی گزارش با ID {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
       //        logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
       //        bool result = logger.InsertToLogTable(logObj);
       //        throw new MyExceptionHandler("خطا در دریافت  گزارش با ID= " + id + ".لطفا مجددا سعی نمایید.");
       //    }
       //}
       
      
    }
}
