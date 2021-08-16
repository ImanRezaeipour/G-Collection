using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace DAL
{
    public class dbConnection
    {
        private SqlDataAdapter myAdapter;
        private SqlConnection conn;


        private readonly string ConnStrKey = "cnnWebRest";


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
            catch (SqlException e)
            {
                //logger.Error("Error - Connection.executeSelectQuery - Query: " + _query + " \nException: " + e.StackTrace.ToString(), e);
                return null;
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
            bool result = true;
            try
            {

                myCommand.Connection = openConnection();
                myCommand.CommandText = _query;
                myCommand.Parameters.AddRange(sqlParameter);
                myAdapter.InsertCommand = myCommand;
                int resultExecute = myCommand.ExecuteNonQuery();
                if (resultExecute > 0)
                    result = true;
                else
                    result = false;
            }
            catch (SqlException e)
            {
                Console.Write("Error - Connection.executeInsertQuery - Query: " + _query + " \nException: \n" + e.StackTrace.ToString());
                result = false;
            }
            finally
            {
                closeConnection();
            }
            return result;
        }
        internal SqlCommand GetSqlCommandQuery(String _query, SqlParameter[] sqlParameter)
        {
            try
            {
                SqlCommand myCommand = new SqlCommand();

                try
                {


                    myCommand.CommandText = _query;
                    myCommand.Parameters.AddRange(sqlParameter);


                }
                catch (SqlException e)
                {
                    Console.Write("Error - Connection.executeInsertQuery - Query: " + _query + " \nException: \n" + e.StackTrace.ToString());
                    myCommand = null;
                }
                finally
                {
                    closeConnection();
                }
                return myCommand;
            }
            catch (Exception ex)
            {

                throw ex;
            }
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
            catch (SqlException e)
            {
                Console.Write("Error - Connection.executeUpdateQuery - Query: " + _query + " \nException: " + e.StackTrace.ToString());
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
            bool result = true;
            try
            {
                myCommand.Connection = openConnection();
                myCommand.CommandText = _query;
                myCommand.Parameters.AddRange(sqlParameter);
                myAdapter.UpdateCommand = myCommand;
                int resultExecute = myCommand.ExecuteNonQuery();
                if (resultExecute > 0)
                    result = true;
                else
                    result = false;

            }
            catch (SqlException e)
            {
                Console.Write("Error - Connection.executeDeleteQuery - Query: " + _query + " \nException: " + e.StackTrace.ToString());
                result = false;
            }
            finally
            {
                closeConnection();
            }
            return result;
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
                catch (SqlException e)
                {
                    SqlTran.Rollback();
                    Console.Write("Error - Connection.executeInsertQuery - Query: " + _queries.ToString() + " \nException: \n" + e.StackTrace.ToString());
                    return false;
                }
                finally
                {
                    closeConnection();
                }
                return true;

            }
        }
        public bool executeNonQueryWithTransaction(params SqlCommand[] sqlCommands)
        {
            using (SqlTransaction SqlTran = openConnection().BeginTransaction())
            {
                try
                {



                    foreach (SqlCommand myCommand in sqlCommands)
                    {
                        myCommand.Connection = conn;
                        myCommand.Transaction = SqlTran;

                        int result = myCommand.ExecuteNonQuery();
                        if (result == 0)
                            throw new Exception();
                    }
                    SqlTran.Commit();
                }
                catch (SqlException e)
                {
                    SqlTran.Rollback();
                    Console.Write("Error - Connection.executeInsertQuery - Query:  \nException: \n" + e.StackTrace.ToString());
                    return false;
                }
                catch (Exception ex)
                {
                    SqlTran.Rollback();
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