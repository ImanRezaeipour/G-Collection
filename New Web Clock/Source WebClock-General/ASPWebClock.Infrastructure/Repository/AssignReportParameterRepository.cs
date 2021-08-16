using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using ASPWebClock.Infrastructure.Utility;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;

namespace ASPWebClock.Infrastructure.Model
{
    public class AssignReportParameterRepository
    {
        logRepository logger = new logRepository();
        dbConnection connection = new dbConnection();
        public List<ReportParameterProxy> GetReportParametersByID(decimal reportID)
        {
            System.Data.DataTable dtResult = new System.Data.DataTable();
            try
            {
                string commandText = @"select * from NW_AssignReportParameter
                                                inner join NW_ReportParameterType
                                                on AssignReportParameter_ReportParameterID=ReportParameterType_ID 
                                                where AssignReportParameter_ReportID=@id";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id", reportID);
                paramArray[0] = idParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پارامترهای  گزارش با ID= " + reportID + ".لطفا مجددا سعی نمایید.");
                }
                else
                {
                    List<ReportParameterProxy> reportParameterList = new List<ReportParameterProxy>();
                    for (int i = 0; i < dtResult.Rows.Count; i++)
                    {
                        ReportParameterProxy reportParameterObj = new ReportParameterProxy()
                        {
                            AssignReportParameter_ID=Convert.ToInt32(dtResult.Rows[i]["AssignReportParameter_ID"]),
                            AssignReportParameter_ReportID = Convert.ToInt32(dtResult.Rows[i]["AssignReportParameter_ReportID"]),
                            ReportParameterType_ID = Convert.ToInt32(dtResult.Rows[i]["AssignReportParameter_ReportParameterID"]),
                            ReportParameterType_Value =dtResult.Rows[i]["ReportParameterType_Value"].ToString()
                        };
                        reportParameterList.Add(reportParameterObj);
                    }
                    return reportParameterList;
                }
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
                logObj.Comment = string.Format("خطا در وا کشی گزارشات  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                bool result = logger.InsertToLogTable(logObj);
                throw new MyExceptionHandler("خطا در دریافت پارامترهای گزارش با ID= " + reportID + ".لطفا مجددا سعی نمایید.");
            }
        }
    }
}
