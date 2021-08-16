using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;


namespace ASPWebClock.Infrastructure.Repository
{
   public class WebLoginUserRepository
    {
        logRepository logger = new logRepository();
        dbConnection connection = new dbConnection();
       public IList<WebLoginUserProxy> GetAllUsers()
       {
           try
           {
               System.Data.DataTable dtResult = new System.Data.DataTable();
               string commandText = "select ID,p_barcode as Barcode,isnull(p_name,'') as Name,isnull(p_family,'') as Family,isnull(lgn_UserName,'') as UserName from persons left join NW_webLogin on p_barcode=lgn_barcode order by p_barcode";
               SqlParameter[] paramArray = new SqlParameter[0];
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               //*********************
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت همه ی کاربران");
               }

               IList<WebLoginUserProxy> webLoginUserProxyList = new List<WebLoginUserProxy>();
               for (int i = 0; i < dtResult.Rows.Count; i++)
               {
                   WebLoginUserProxy webLoginProxyObj = new WebLoginUserProxy();
                       webLoginProxyObj.Barcode = dtResult.Rows[i]["Barcode"] == DBNull.Value ? "" : dtResult.Rows[i]["Barcode"].ToString();
                       webLoginProxyObj.UserName =dtResult.Rows[i]["UserName"]==DBNull.Value ? "" :  dtResult.Rows[i]["UserName"].ToString();
                       webLoginProxyObj.Name =dtResult.Rows[i]["Name"]==DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                       webLoginProxyObj.Family =dtResult.Rows[i]["Family"]==DBNull.Value ? "" : dtResult.Rows[i]["Family"].ToString();
                       webLoginProxyObj.ID = Convert.ToDecimal(dtResult.Rows[i]["ID"] == DBNull.Value ? 0 : dtResult.Rows[i]["ID"]);
                       webLoginProxyObj.NameFamily = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                       webLoginProxyObj.NameFamily += " ";
                       webLoginProxyObj.NameFamily +=dtResult.Rows[i]["Family"] == DBNull.Value ? "" : dtResult.Rows[i]["Family"].ToString();
                    
                 
                   webLoginUserProxyList.Add(webLoginProxyObj);
               }
               return webLoginUserProxyList;
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در دریافت همه ی کاربران  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت همه ی کاربران");


           }
       }
       public WebLoginUserProxy GetUserByID(decimal id)
       {
           try
           {
               System.Data.DataTable dtResult = new System.Data.DataTable();
               string commandText = "select ID, (lgn_barcode) as Barcode,(lgn_userName) as UserName,(lgn_password) as Password from NW_webLogin where (ID=@id)";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter idParam = new SqlParameter("@id", id);
               paramArray[0] = idParam;
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               //*********************
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت نام کاربری پرسنل با ID = " + id);
               }
               WebLoginUserProxy webLoginUserProxyObj = null;
               if (dtResult.Rows.Count > 0)
               {
                   webLoginUserProxyObj = new WebLoginUserProxy();
                   webLoginUserProxyObj.ID = Convert.ToDecimal(dtResult.Rows[0]["ID"]);
                   webLoginUserProxyObj.Barcode = dtResult.Rows[0]["ID"].ToString();
                   webLoginUserProxyObj.UserName = dtResult.Rows[0]["UserName"].ToString();
               }
               return webLoginUserProxyObj;

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
               LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.Comment = string.Format("خطا در دریافت نام کاربری پرسنل {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
               LogObj.p_barcode = "";
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت نام کاربری پرسنل با id = " + id);


           }


       }
       public WebLoginUserProxy GetUserOfPersonnel(string barcode)
       {
           try
           {
               System.Data.DataTable dtResult = new System.Data.DataTable();
               string commandText = "select ID, (lgn_barcode) as Barcode,(lgn_userName) as UserName,(lgn_password) as Password from NW_webLogin where (lgn_barcode=@barcode)";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
               paramArray[0] = barcodeParam;
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               //*********************
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت نام کاربری پرسنل با barcode = " + barcode);
               }
               WebLoginUserProxy webLoginUserProxyObj = null;
               if (dtResult.Rows.Count > 0)
               {
                   webLoginUserProxyObj = new WebLoginUserProxy();
                   webLoginUserProxyObj.ID = Convert.ToDecimal(dtResult.Rows[0]["ID"]);
                   webLoginUserProxyObj.Barcode = dtResult.Rows[0]["ID"].ToString();
                   webLoginUserProxyObj.UserName = dtResult.Rows[0]["UserName"].ToString();
               }
               return webLoginUserProxyObj;

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
               LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.Comment = string.Format("خطا در دریافت نام کاربری پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
               LogObj.p_barcode = barcode;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت نام کاربری پرسنل با barcode = " + barcode);


           }


       }
       public WebLoginUserProxy GetUserNameExist(string userName)
       {
           try
           {
               System.Data.DataTable dtResult = new System.Data.DataTable();
               string commandText = "select ID,lgn_userName,lgn_Barcode from NW_webLogin  where (lgn_username = @userName)";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter barcodeParam = new SqlParameter("@userName", userName);
               paramArray[0] = barcodeParam;
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               //*********************
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در واکشی کاربر موجود با  username = " + userName);
               }
               WebLoginUserProxy webLoginUserProxy = null;
               if (dtResult.Rows.Count > 0)
               {
                   webLoginUserProxy=new WebLoginUserProxy();
                   webLoginUserProxy.Barcode = dtResult.Rows[0]["lgn_Barcode"].ToString();
                   webLoginUserProxy.UserName = dtResult.Rows[0]["lgn_userName"].ToString();
                   webLoginUserProxy.ID = Convert.ToDecimal(dtResult.Rows[0]["ID"]);
               }
               return webLoginUserProxy;

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
               LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در واکشی کاربر موجود  {0}، متن پیغام {1}.خطا", userName, Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در واکشی کاربر موجود با  username = " + userName);


           }
       }
       
    }
}
