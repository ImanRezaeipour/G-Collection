using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;

namespace CCWindowsService.Repository
{
   
   public class PersonRepository
    {
        private SqlConnection conn;
        private readonly string ConnStrKey = "cnn";
        private SqlDataAdapter myAdapter;
       public PersonRepository()
       {
           myAdapter = new SqlDataAdapter();
           conn = new SqlConnection(ConfigurationManager.ConnectionStrings[this.ConnStrKey].ConnectionString);
       }

       private SqlConnection openConnection()
       {
           if (conn.State == ConnectionState.Closed || conn.State == ConnectionState.Broken)
               conn.Open();
           return conn;
       }

       public DataTable GetAllPersonBarcode()
       {
           try
           {
               DataTable dataTable = new DataTable();
               dataTable = null;
               DataSet ds = new DataSet();
               string commandText = "select P_BarCode,P_Name,P_Family from persons";
               SqlParameter[] paramArray = new SqlParameter[0];

               SqlCommand myCommand = new SqlCommand();


               myCommand.Connection = openConnection();
               myCommand.CommandText = commandText;
               myCommand.Parameters.AddRange(paramArray);
               myCommand.ExecuteNonQuery();
               myAdapter.SelectCommand = myCommand;
               myAdapter.Fill(ds);
               dataTable = ds.Tables[0];
               conn.Close();
               return dataTable;
           }
           catch (Exception ex)
           {
               EventLog eventLog1 = new EventLog();
               eventLog1.Source = "CCLogSourse";
               eventLog1.Log = "CCLog";
               eventLog1.WriteEntry(ex.Message);
               DataTable dtResult=null;
               return dtResult;
           }
       }
    }
}
