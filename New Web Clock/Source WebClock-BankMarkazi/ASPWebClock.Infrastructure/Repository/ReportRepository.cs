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
   public class ReportRepository
    {

       public Role role
       {
           get
           {
               return new Role();
           }
       }

       SqlDataAdapter myAdapter;
       logRepository logger = new logRepository();
       dbConnection connection = new dbConnection();

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
                       AccessReports_ID = (decimal)dtResult.Rows[i]["AccessReports_ID"],
                       Report_ID = (decimal)dtResult.Rows[i]["Report_ID"],
                       Role_Title = (string)dtResult.Rows[i]["Role_Title"],
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

       public List<Report> LoadAllReportsByPerson(Person prc)
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {

               string commandText = @"SELECT NW_Report.Report_Name , NW_Report.Report_FileAddress , NW_Report.Report_ID , NW_Report.Report_IsCalculate 
                                    FROM NW_Report join NW_AccessReports on NW_Report.Report_ID = NW_AccessReports.Report_ID 
                                    WHERE NW_AccessReports.Role_Title = @prc";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter prcParam = new SqlParameter("@id" , prc.Name);
               paramArray[0] = prcParam;
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در همه گزارشات.لطفا مجددا سعی نمایید.");
               }
               List<Report> listReprts = new List<Report>();
               for (int i = 0; i < dtResult.Rows.Count; i++)
               {
                   Report rpt = new Report()
                   {
                       Report_ID = (decimal)dtResult.Rows[i]["Report_ID"],
                       Report_Name = dtResult.Rows[i]["Report_Name"].ToString(),
                       Report_FileAddress = dtResult.Rows[i]["Report_FileAddress"].ToString(),
                       Report_IsCalculate = (bool)dtResult.Rows[i]["Report_IsCalculate"]
                   };
                   listReprts.Add(rpt);
               }

               return listReprts;
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

       public List<Report> LoadAllReports()
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {

               string commandText = @"select * from NW_Report order by Report_Name";
               SqlParameter[] paramArray = new SqlParameter[0];
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در همه گزارشات.لطفا مجددا سعی نمایید.");
               }
               List<Report> listReprts = new List<Report>();
               for (int i = 0; i < dtResult.Rows.Count; i++)
               {
                   Report rpt = new Report()
                   {
                       Report_ID = (decimal)dtResult.Rows[i]["Report_ID"],
                       Report_Name = dtResult.Rows[i]["Report_Name"].ToString(),
                       Report_FileAddress = dtResult.Rows[i]["Report_FileAddress"].ToString(),
                       Report_IsCalculate = (bool)dtResult.Rows[i]["Report_IsCalculate"]
                   };
                   listReprts.Add(rpt);
               }

               return listReprts;
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
       public Report GetReportByID(decimal id)
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {
               string commandText = @"select * from NW_Report where Report_ID=@id";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter idParam = new SqlParameter("@id", id);
               paramArray[0] = idParam;
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت  گزارش با ID= " + id + ".لطفا مجددا سعی نمایید.");
               }
               Report rpt;
               if (dtResult.Rows.Count > 0)
               {
                   rpt = new Report()
                   {
                       Report_ID = (decimal)dtResult.Rows[0]["Report_ID"],
                       Report_Name = dtResult.Rows[0]["Report_Name"].ToString(),
                       Report_FileAddress = dtResult.Rows[0]["Report_FileAddress"].ToString(),
                       Report_IsCalculate = (bool)dtResult.Rows[0]["Report_IsCalculate"]
                   };

               }
               else
               {
                   rpt = new Report();
               }

               return rpt;
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
               logObj.Comment = string.Format("خطا در وا کشی گزارش با ID {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool result = logger.InsertToLogTable(logObj);
               throw new MyExceptionHandler("خطا در دریافت  گزارش با ID= " + id + ".لطفا مجددا سعی نمایید.");
           }
       }
       public DataTable GetAccessReports()
       {
           try
           {
               SqlCommand myCommand = new SqlCommand();
               DataSet ds = new DataSet();

               DataTable dtResult = new DataTable();
               DataTable dtAccessReport = new DataTable();
               DataTable dtReport = new DataTable();
               IList<Role> roleList = new RoleRepositpry().GetAllRoles();
               IList<Report> reportList = new ReportRepository().LoadAllReports();
               IList<AccessReport> accessList = new ReportRepository().GetAll();
               dtResult.Columns.Add("Report_Name");
               dtResult.Columns.Add("Report_ID");
               dtResult.Columns.Add("Role_ID");

               for (int i = 0; i < roleList.Count; i++)
               {
                   dtResult.Columns.Add(roleList[i].Name.ToString());
               }

               int temp = roleList.Count + 3;
               foreach (Report report in reportList)
               {

                   DataRow dr = dtResult.NewRow();
                   dr[0] = report.Report_Name;
                   dr[1] = report.Report_ID;
                   dr[2] = role.Title;
                   for (int i = 3; i < temp; i++)
                   {
                       if (accessList.Where(x => x.Report_ID == report.Report_ID && x.Role_Title == roleList[i-3].Name).Count() > 0)
                       {
                           dr[i] = true;
                       }
                       else
                           dr[i] = false;
                   }
                   dtResult.Rows.Add(dr);
               }

               #region Comment
               //for (int i = 0; i < dtReport.Rows.Count; i++)
               //{
               //    dtResult.Rows.Add(dtReport.Rows[i].ToString());
               //    for (int j = 0; j < RoleList.Count; j++)
               //    {

               //        for (int k = 0; k < dtAccessReport.Columns.Count ; k++)
               //        {
               //            if(dtResult.Rows[i][j] != dtAccessReport.Rows[k] )
               //                break;
               //            for (int m = 0; m < dtAccessReport.Rows.Count; m++)
               //            {
               //                if(dtResult.Rows[i][j]==dtAccessReport.Rows[k][m])

               //            }
               //        }

               //    }
               //}

               #endregion               


               return dtResult;
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {
               ASPWebClock.Infrastructure.Model.Log logObj = new ASPWebClock.Infrastructure.Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در جدول دسترسی های لاگ {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool BoolResult = new logRepository().InsertToLogTable(logObj);
               throw new MyExceptionHandler("خطا در جدول دسترسی های گزارشات");
           }
       }
       public bool DeleteAccessReports(int reportId)
       {
           try
           {
               string commandText = @" DELETE FROM NW_AccessReports WHERE Report_ID = @Report_ID  ";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter param = new SqlParameter("Report_ID", reportId);
               paramArray[0] = param;
               bool result = connection.executeDeleteQuery(commandText, paramArray);
               return result;
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {
               ASPWebClock.Infrastructure.Model.Log logObj = new ASPWebClock.Infrastructure.Model.Log();
               logObj.Action = "Delete";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در حذف دسترسی های گزارشات {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool BoolResult = new logRepository().InsertToLogTable(logObj);
               throw new MyExceptionHandler("خطا در حذف دسترسی های گزارشات");
           }
       }
       public string InsertAccessReports(string reportId, Dictionary<string, bool> dicNewValue)
       {
           int repoId = int.Parse(reportId) ;
           bool resultInsert = false;
           bool result = false;
           result = DeleteAccessReports(repoId);
           if (result == true)
           {
               foreach (string reportS in dicNewValue.Keys)
               {
                   string commandTextInsert = @"Insert Into NW_AccessReports (Report_ID,Role_Title) Values (@Report_ID,@role_Title)";
                   SqlParameter[] paramArrayInsert = new SqlParameter[2];
                   SqlParameter report = new SqlParameter("@Report_ID", repoId);
                   SqlParameter role = new SqlParameter("@role_Title", reportS);
                   paramArrayInsert[0] = report;
                   paramArrayInsert[1] = role;
                   resultInsert = connection.executeInsertQuery(commandTextInsert, paramArrayInsert);
               }
               if (resultInsert == true)
               {
                   return "اطلاعات با موفقیت ثبت شد.";
               }
               else
               {
                   return "خطا در ثبت اطلاعات .مجددا سعی نمایید";
               }
           }
           else
           {
               return "خطا در ثبت اطلاعات .مجددا سعی نمایید";
           }
       }
    }
}
