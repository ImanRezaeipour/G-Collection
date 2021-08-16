using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using ASPWebClock.Infrastructure.Utility;
using System.Web;


namespace ASPWebClock.Infrastructure.Repository
{
    public class dbConnection
    {
        private SqlDataAdapter myAdapter;
        private SqlConnection conn;
        //private BaseLog logger = new BaseLog();
        private logRepository logger = new logRepository();
        private readonly string ConnStrKey = "cnn";


        /// <constructor>
        /// Initialise Connection
        /// </constructor>
        public dbConnection()
        {
            myAdapter = new SqlDataAdapter();
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings[this.ConnStrKey].ConnectionString);
        }

        /// <method>
        /// Open Database Connection if Closed or Broken
        /// </method>
        private SqlConnection openConnection()
        {
            if (conn.State == ConnectionState.Closed || conn.State == ConnectionState.Broken)
            {
                conn.Open();
            }
            return conn;
        }

        /// <method>
        /// Close Database Connection
        /// </method>
        private SqlConnection closeConnection()
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            return conn;
        }

        /// <method>
        /// Select Query
        /// </method>
        public DataTable executeSelectQuery(String _query, SqlParameter[] sqlParameter)
        {
            SqlCommand myCommand = new SqlCommand();
            DataTable dataTable = new DataTable();
            dataTable = null;
            DataSet ds = new DataSet();
            
            try
            {
                myCommand.Connection = openConnection();
                myCommand.CommandText = _query;
                myCommand.Parameters.AddRange(sqlParameter);
                myCommand.ExecuteNonQuery();
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(ds);
                dataTable = ds.Tables[0];
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (SqlException e)
            {
                Model.Log logObj=new Model.Log();
                logObj.Action="Select";
                logObj.date=DateTime.Now;
                logObj.Status=false;
                logObj.Comment=e.Message;
                logObj.UserName=HttpContext.Current.User.Identity.Name;
                logObj.LayerName = Model.Log.LayerNameEnum.DBConnection.ToString();
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                bool result= logger.InsertToLogTable(logObj);
                return dataTable;
            }
            finally
            {
                closeConnection();
            }
            return dataTable;
        }


        public DataTable executeSelectQuery(String _query, List<SqlParameter> sqlParameter)
        {
            SqlCommand myCommand = new SqlCommand();
            DataTable dataTable = new DataTable();
            dataTable = null;
            DataSet ds = new DataSet();

            try
            {
                myCommand.Connection = openConnection();
                myCommand.CommandText = _query;
                myCommand.Parameters.AddRange(sqlParameter.ToArray());
                myCommand.ExecuteNonQuery();
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(ds);
                dataTable = ds.Tables[0];
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (SqlException e)
            {
                Model.Log logObj = new Model.Log();
                logObj.Action = "Select";
                logObj.date = DateTime.Now;
                logObj.Status = false;
                logObj.Comment = e.Message;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.LayerName = Model.Log.LayerNameEnum.DBConnection.ToString();
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                bool result = logger.InsertToLogTable(logObj);
                return dataTable;
            }
            finally
            {
                closeConnection();
            }
            return dataTable;
        }


        /// <method>
        /// Insert Query
        /// </method>
        public bool executeInsertQuery(String _query, SqlParameter[] sqlParameter)
        {
            SqlCommand myCommand = new SqlCommand();
            try
            {
                myCommand.Connection = openConnection();
                myCommand.CommandText = _query;
                myCommand.Parameters.AddRange(sqlParameter);
                myAdapter.InsertCommand = myCommand;
                myCommand.ExecuteNonQuery();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (SqlException e)
            {
                Model.Log logObj = new Model.Log();
                logObj.Action = "Insert";
                logObj.date = DateTime.Now;
                logObj.Status = false;
                logObj.Comment = e.Message;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.LayerName = Model.Log.LayerNameEnum.DBConnection.ToString();
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                bool result = logger.InsertToLogTable(logObj);
                return false;
            }
            finally
            {
                closeConnection();
            }
            return true;
        }

        /// <method>
        /// Update Query
        /// </method>
        public bool executeUpdateQuery(String _query, SqlParameter[] sqlParameter)
        {
            SqlCommand myCommand = new SqlCommand();
            try
            {
                myCommand.Connection = openConnection();
                myCommand.CommandText = _query;
                myCommand.Parameters.AddRange(sqlParameter);
                myAdapter.UpdateCommand = myCommand;
                myCommand.ExecuteNonQuery();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception e)
            {
                Model.Log logObj = new Model.Log();
                logObj.Action = "Update";
                logObj.date = DateTime.Now;
                logObj.Status = false;
                logObj.Comment = e.Message;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.LayerName = Model.Log.LayerNameEnum.DBConnection.ToString();
                bool result = logger.InsertToLogTable(logObj);
               
                return false;
            }
            finally
            {
                closeConnection(); 
            }
            return true;
        }
        public bool executeDeleteQuery(String _query, SqlParameter[] sqlParameter)
        {
            SqlCommand myCommand = new SqlCommand();
            try
            {
                myCommand.Connection = openConnection();
                myCommand.CommandText = _query;
                myCommand.Parameters.AddRange(sqlParameter);
                myAdapter.UpdateCommand = myCommand;
                myCommand.ExecuteNonQuery();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (SqlException e)
            {
                Model.Log logObj = new Model.Log();
                logObj.Action = "Delete";
                logObj.date = DateTime.Now;
                logObj.Status = false;
                logObj.Comment = e.Message;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.LayerName = Model.Log.LayerNameEnum.DBConnection.ToString();
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                bool result = logger.InsertToLogTable(logObj);
                //Console.Write("Error - Connection.executeDeleteQuery - Query: " + _query + " \nException: " + e.StackTrace.ToString());
                return false;
            }
            finally
            {
                closeConnection();
            }
            return true;
        }
        public bool executeDeleteQuery(String _query, List<SqlParameter> sqlParameter)
        {
            SqlCommand myCommand = new SqlCommand();
            try
            {
                myCommand.Connection = openConnection();
                myCommand.CommandText = _query;
                myCommand.Parameters.AddRange(sqlParameter.ToArray());
                myAdapter.UpdateCommand = myCommand;
                myCommand.ExecuteNonQuery();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (SqlException e)
            {
                Model.Log logObj = new Model.Log();
                logObj.Action = "Delete";
                logObj.date = DateTime.Now;
                logObj.Status = false;
                logObj.Comment = e.Message;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.LayerName = Model.Log.LayerNameEnum.DBConnection.ToString();
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                bool result = logger.InsertToLogTable(logObj);
                //Console.Write("Error - Connection.executeDeleteQuery - Query: " + _query + " \nException: " + e.StackTrace.ToString());
                return false;
            }
            finally
            {
                closeConnection();
            }
            return true;
        }
        public bool executeNonQueryWithTransaction(params string[] _queries)
        {
            using (SqlTransaction SqlTran = openConnection().BeginTransaction())
            {
                try
                {
                    foreach (string query in _queries)
                    {
                        SqlCommand myCommand = new SqlCommand(query, openConnection(), SqlTran);
                        myCommand.ExecuteNonQuery();
                    }
                    SqlTran.Commit();
                }
                catch (MyExceptionHandler ex)
                {
                    throw ex;
                }
                catch (SqlException e)
                {

                    Model.Log logObj = new Model.Log();
                    logObj.Action = "Transaction";
                    logObj.date = DateTime.Now;
                    logObj.Status = false;
                    logObj.Comment = "Error - Connection.executeInsertQuery - Query: " + _queries.ToString() + " \nException: \n" + e.StackTrace.ToString();
                    logObj.UserName = HttpContext.Current.User.Identity.Name;
                    logObj.LayerName = Model.Log.LayerNameEnum.DBConnection.ToString();
                    logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    bool result = logger.InsertToLogTable(logObj);

                    SqlTran.Rollback();
                    //Console.Write("Error - Connection.executeInsertQuery - Query: " + _queries.ToString() + " \nException: \n" + e.StackTrace.ToString());
                    return false;
                }
                finally
                {
                    closeConnection();
                }
                return true;

            }
        }
    }
}