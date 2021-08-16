using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Model;
using System.Data.SqlClient;
using ASPWebClock.Infrastructure.Utility;
using System.Web;

namespace ASPWebClock.Infrastructure.Repository
{
   public  class JobTypeRepository
    {
       logRepository logger = new logRepository();
       dbConnection connection = new dbConnection();
       public List<JobType> GetAllJobType()
       {
           try
           {
               System.Data.DataTable dtResult = new System.Data.DataTable();
               string commandText = "select * from jobType";
               SqlParameter[] paramArray = new SqlParameter[0];
               List<JobType> jobTypeList = new List<JobType>();
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت نوع شغل");
               }
               for (int i = 0; i < dtResult.Rows.Count; i++)
               {
                   JobType jobTypeObj = new JobType()
                   {
                       Job_Code = Convert.ToInt16(dtResult.Rows[i]["Job_Code"]),
                       Job_Name = dtResult.Rows[i]["Job_Name"].ToString()

                   };
                   jobTypeList.Add(jobTypeObj);
               }

               //*********************

               return jobTypeList;
           }

           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {
               Log LogObj = new Model.Log();
               LogObj.Action = "Select";
               LogObj.date = DateTime.Now;
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.Status = false;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               LogObj.Comment = string.Format("خطا در واکشی درخواست های اضافه کاری پرسنل {0}، متن پیغام {1}.خطا",  Utility.Utility.GetExecptionMessage(ex));
               bool result = logger.InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت نوع شغل");
           }
       }
    }
}
