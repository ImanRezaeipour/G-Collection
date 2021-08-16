using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Configuration;
using ASPWebClock.Infrastructure.Utility;
using System.Web;
using ASPWebClock.Infrastructure.Model;





namespace ASPWebClock.Infrastructure.Repository
{

    public class logRepository
    {

       
        private SqlConnection conn;
        SqlDataAdapter myAdapter;
        private readonly string ConnStrKey = "cnn";

        public logRepository()
        {
            try
            {
                myAdapter = new SqlDataAdapter();
                conn = new SqlConnection(ConfigurationManager.ConnectionStrings[this.ConnStrKey].ConnectionString);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در لاگ {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا  ");
            }
        }


        /// <method>
        /// Open DataBase connection if closed or Broken
        /// </method> 
        private SqlConnection openConnection()
        {
            if (conn.State == ConnectionState.Closed || conn.State == ConnectionState.Broken)
                conn.Open();
            return conn;
        }

        public bool InsertToLogTable(Model.Log logObj)
        {
            try
            {
                string commandText = @"Insert Into NW_Log (UserName,UserWebPassID,p_barcode,Action,Status,date,Comment,LayerName,MethodName)
                                       Values (@UserName,@UserWebPassID,@p_barcode,@Action,@Status,@date,@comment,@layerName,@MethodName)";

                SqlParameter[] paramArray = new SqlParameter[9];

                ///null check

                SqlParameter usernameParam = new SqlParameter("@UserName", logObj.UserName);
                object obj_w = DBNull.Value;
                if (logObj.UserWebPassID != null)
                    obj_w = logObj.UserWebPassID;

                SqlParameter userwebpassidParam = new SqlParameter("@UserWebPassID", obj_w);
                object obj_p = DBNull.Value;
                if (logObj.p_barcode != null)
                    obj_p = logObj.p_barcode;

                SqlParameter p_barcodeParam = new SqlParameter("@p_barcode", obj_p);
                SqlParameter ActionParam = new SqlParameter("@Action", logObj.Action);
                SqlParameter StatusParam = new SqlParameter("@Status", logObj.Status);
                SqlParameter dateParam = new SqlParameter("@date", logObj.date);
                SqlParameter commentParam = new SqlParameter("@comment", logObj.Comment);
                SqlParameter layerNameParam = new SqlParameter("@layerName", logObj.LayerName);
                SqlParameter methodName = new SqlParameter("@MethodName", logObj.MethodName);
                paramArray[0] = usernameParam;
                paramArray[1] = userwebpassidParam;
                paramArray[2] = p_barcodeParam;
                paramArray[3] = ActionParam;
                paramArray[4] = StatusParam;
                paramArray[5] = dateParam;
                paramArray[6] = commentParam;
                paramArray[7] = layerNameParam;
                paramArray[8] = methodName;




                SqlCommand myCommand = new SqlCommand();


                myCommand.Connection = openConnection();
                myCommand.CommandText = commandText;
                myCommand.Parameters.AddRange(paramArray);
                myAdapter.InsertCommand = myCommand;
                myCommand.ExecuteNonQuery();
                conn.Close();
                return true;


            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                
                throw new MyExceptionHandler("خطا در ثبت در جدول لاگ  ");
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="toDate"></param>
        /// <param name="fromDate"></param>
        /// <param name="searchKey"></param>
        /// <param name="searchField"></param>
        /// <returns></returns>
        public List<LogProxy> GetLog(DateTime toDate, DateTime fromDate, string searchKey, LogSearchFields searchField)
        {
            DataTable dtResult = new DataTable();
            SqlCommand myCommand = new SqlCommand();
            DataSet ds = new DataSet();
            try
            {
                string commandText = @"SELECT NW_log.ID as ID,NW_log.UserName as UserName ,userWebpassId, NW_log.p_barcode as barcode , Action , Status , date , Comment , PersonPost
                                            FROM NW_log left join NW_webpass on (NW_log.UserWebPassID = NW_webpass.ID)
                                            WHERE date >=@fromDate  and date <= @toDate ";

                List<SqlParameter> paramArray = new List<SqlParameter>();

                paramArray.Add(new SqlParameter("@fromDate", fromDate));
                paramArray.Add(new SqlParameter("@toDate", toDate));
                if (searchKey == null)
                    searchKey = "";
                switch (searchField)
                {
                    case LogSearchFields.Action:
                        commandText += " AND Action =@Action ";
                        SqlParameter action = new SqlParameter("@Action", searchKey);
                        paramArray.Add(action);
                        break;
                    case LogSearchFields.p_barcode:
                        commandText += " AND NW_log.p_barcode = @Barcode";
                        SqlParameter barcode = new SqlParameter("@Barcode", searchKey);
                        paramArray.Add(barcode);
                        break;
                    case LogSearchFields.UserName:
                        commandText += " AND NW_log.UserName = @UserName";
                        SqlParameter username = new SqlParameter("@UserName", searchKey);
                        paramArray.Add(username);
                        break;
                    case LogSearchFields.Comment:
                        commandText += "AND Comment LIKE @Comment";
                        SqlParameter comment = new SqlParameter("@Comment", "%" + searchKey + "%");
                        paramArray.Add(comment);
                        break;
                    case LogSearchFields.Status:
                        commandText += "AND Status = @Status";
                        SqlParameter status = new SqlParameter("@Status", searchKey);
                        paramArray.Add(status);
                        break;
                }

                myCommand.Connection = openConnection();
                myCommand.CommandText = commandText;
                myCommand.Parameters.AddRange(paramArray.ToArray());
                myCommand.ExecuteNonQuery();
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(ds);
                dtResult = ds.Tables[0];

                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در ارتباط با جدول لاگ");
                }

                List<LogProxy> logList = new List<LogProxy>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    LogProxy logObj = new LogProxy();
                    logObj.ID = Convert.ToDecimal(dtResult.Rows[i]["ID"] == DBNull.Value ? 0 : dtResult.Rows[i]["ID"]);
                    logObj.Action = dtResult.Rows[i]["Action"] == DBNull.Value ? "" : dtResult.Rows[i]["Action"].ToString();
                    logObj.Comment = dtResult.Rows[i]["Comment"] == DBNull.Value ? "" : dtResult.Rows[i]["Comment"].ToString();
                    logObj.date = Convert.ToDateTime(dtResult.Rows[i]["date"] == DBNull.Value ? new DateTime() : dtResult.Rows[i]["date"]);
                    logObj.barcode = dtResult.Rows[i]["barcode"] == DBNull.Value ? "" : dtResult.Rows[i]["barcode"].ToString();
                    logObj.PersonPost = dtResult.Rows[i]["personPost"] == DBNull.Value ? "" : dtResult.Rows[i]["personPost"].ToString();
                    logObj.Status = Convert.ToBoolean(dtResult.Rows[i]["status"] == DBNull.Value ? false : dtResult.Rows[i]["status"]);
                    logObj.UserName = dtResult.Rows[i]["UserName"] == DBNull.Value ? "" : dtResult.Rows[i]["UserName"].ToString();
                    logObj.UserWebPassID = Convert.ToDecimal(dtResult.Rows[i]["userWebpassId"] == DBNull.Value ? 0 : dtResult.Rows[i]["userWebpassId"]);
                    logList.Add(logObj);
                }

                return logList;
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
                //logObj.p_barcode = p_barcode;
                logObj.Status = false;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.Comment = string.Format("خطا در ارتباط با جدول لاگ {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool BoolResult = new logRepository().InsertToLogTable(logObj);

                throw new MyExceptionHandler("خطا در ارتباط با جدول لاگ");
            }
        }

        public List<LogProxy> GetLogNothing(DateTime toDate, DateTime fromDate)
        {
            DataTable dtResult = new DataTable();
            SqlCommand myCommand = new SqlCommand();
            DataSet ds = new DataSet();
            try
            {
                string commandText = @"SELECT NW_log.ID as ID,NW_log.UserName as UserName ,userWebpassId, NW_log.p_barcode as barcode , Action , Status , date , Comment , PersonPost
                                            FROM NW_log left join NW_webpass on (NW_log.UserWebPassID = NW_webpass.ID)
                                            WHERE date >= @fromDate   and date <= @toDate  ";

                List<SqlParameter> paramArray = new List<SqlParameter>();

                paramArray.Add(new SqlParameter("@fromDate", fromDate));
                paramArray.Add(new SqlParameter("@toDate", toDate));


                myCommand.Connection = openConnection();
                myCommand.CommandText = commandText;
                myCommand.Parameters.AddRange(paramArray.ToArray());
                myCommand.ExecuteNonQuery();
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(ds);
                dtResult = ds.Tables[0];

                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در ارتباط با جدول لاگ");
                }

                List<LogProxy> logList = new List<LogProxy>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    LogProxy logObj = new LogProxy();
                    logObj.ID = Convert.ToDecimal(dtResult.Rows[i]["ID"] == DBNull.Value ? 0 : dtResult.Rows[i]["ID"]);
                    logObj.Action = dtResult.Rows[i]["Action"] == DBNull.Value ? "" : dtResult.Rows[i]["Action"].ToString();
                    logObj.Comment = dtResult.Rows[i]["Comment"] == DBNull.Value ? "" : dtResult.Rows[i]["Comment"].ToString();
                    logObj.date = Convert.ToDateTime(dtResult.Rows[i]["date"] == DBNull.Value ? new DateTime() : dtResult.Rows[i]["date"]);
                    logObj.barcode = dtResult.Rows[i]["barcode"] == DBNull.Value ? "" : dtResult.Rows[i]["barcode"].ToString();
                    logObj.PersonPost = dtResult.Rows[i]["personPost"] == DBNull.Value ? "" : dtResult.Rows[i]["personPost"].ToString();
                    logObj.Status = Convert.ToBoolean(dtResult.Rows[i]["status"] == DBNull.Value ? false : dtResult.Rows[i]["status"]);
                    logObj.UserName = dtResult.Rows[i]["UserName"] == DBNull.Value ? "" : dtResult.Rows[i]["UserName"].ToString();
                    logObj.UserWebPassID = Convert.ToDecimal(dtResult.Rows[i]["userWebpassId"] == DBNull.Value ? 0 : dtResult.Rows[i]["userWebpassId"]);
                    logList.Add(logObj);
                }

                return logList;
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
                //logObj.p_barcode = p_barcode;
                logObj.Status = false;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.Comment = string.Format("خطا در ارتباط با جدول لاگ {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool BoolResult = new logRepository().InsertToLogTable(logObj);

                throw new MyExceptionHandler("خطا در ارتباط با جدول لاگ");
            }
        }


        public bool DeleteLog(decimal id)
        {
            SqlCommand myCommand = new SqlCommand();
            try
            {

                string CommandText = @"DELETE FROM NW_log
                                      WHERE ID = @ID";

                myCommand.Connection = openConnection();
                myCommand.CommandText = CommandText;
                SqlParameter idparam = new SqlParameter("@ID", id);
                myCommand.Parameters.Add(idparam);
                myAdapter.UpdateCommand = myCommand;
                myCommand.ExecuteNonQuery();
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
                //logObj.p_barcode = p_barcode;
                logObj.Status = false;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.Comment = string.Format("خطا در حذف جدول لاگ {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool BoolResult = new logRepository().InsertToLogTable(logObj);
                return false;
                throw new MyExceptionHandler("خطا در حذف جدول لاگ");

            }
            return true;
        }



    }
}
