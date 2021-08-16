using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Data.SqlClient;
using System.Configuration;
using System.ComponentModel;

namespace ConvertorDataFromOWCToNWC.DAL
{
    internal class GenerateAdoNetQuery
    {
        private string connectionString = string.Empty;
        private SqlConnection sqlConnection = null;
        private SqlCommand myCommand = null;
        public GenerateAdoNetQuery()
        {
            connectionString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        }



       
        internal bool InsertQuery(string tblName, object obj)
        {
            try
            {


                Type typeOfObj = obj.GetType();
                string query = string.Empty;
                string fieldQuery = string.Empty;
                string valueQuery = string.Empty;
                PropertyInfo[] propertyInfoList = typeOfObj.GetProperties();
                

                for (int i = 0; i < propertyInfoList.Count(); i++)
                {
                    bool isIdentity = false;
                    DataObjectFieldAttribute att = propertyInfoList[i].GetCustomAttributes(typeof(DataObjectFieldAttribute), false).Cast<DataObjectFieldAttribute>().FirstOrDefault();
                    if(att!=null)
                    isIdentity = att.IsIdentity;
                    
                    if (isIdentity==false)
                    {
                        
                        var pro = typeOfObj.GetProperty("ID");
                        if (propertyInfoList[i].GetValue(obj, null) != null)
                        {
                            if (fieldQuery == string.Empty)
                                fieldQuery += " (" + propertyInfoList[i].Name;
                            else
                                fieldQuery += "," + propertyInfoList[i].Name;

                            if (valueQuery == string.Empty)
                                valueQuery += " (@" + propertyInfoList[i].Name;
                            else
                                valueQuery += "," + "@" + propertyInfoList[i].Name;
                        }
                    }
                }

                fieldQuery += ") ";
                valueQuery += ") ";
                query = @"Insert Into " + tblName + fieldQuery + "Values" + valueQuery;
                SqlParameter[] paramArray = GenerateParameterForInsert(propertyInfoList, obj);


                sqlConnection = new SqlConnection(connectionString);
                myCommand = new SqlCommand();
                myCommand.Connection = sqlConnection;
                myCommand.CommandText = query;
                myCommand.Parameters.AddRange(paramArray);
                myCommand.Connection.Open();
                int resultExecute = myCommand.ExecuteNonQuery();
                if (resultExecute > 0)
                    return true;
                else return false;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }
        
        internal bool DeleteQuery(string tblName, Dictionary<string, string> paramDic)
        {
            try
            {
                string query = string.Empty;
                string whereQuery = string.Empty;

                foreach (KeyValuePair<String, String> item in paramDic)
                {
                    if (whereQuery == string.Empty)
                        whereQuery += " (" + item.Key + "=@" + item.Key + ")";
                    else
                        whereQuery += " and (" + item.Key + "=@" + item.Key + ")";
                }




                if (whereQuery != "")
                    query = @"Delete From " + tblName + " Where " + whereQuery;
                else
                    query = @"Delete From " + tblName;
                SqlParameter[] paramArray = GenerateParameterForDelete(paramDic);
                sqlConnection = new SqlConnection(connectionString);
                myCommand = new SqlCommand();
                myCommand.Connection = sqlConnection;
                myCommand.CommandText = query;
                myCommand.Parameters.AddRange(paramArray);
                myCommand.Connection.Open();
                int resultExecute = myCommand.ExecuteNonQuery();
                if (resultExecute > 0)
                    return true;
                else return false;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }
        
        internal bool UpdateQuery(string tblName, Dictionary<string, string> parametersDic, object obj)
        {
            try
            {
                string query = string.Empty;
                string whereQuery = string.Empty;
                Type typeOfObj = obj.GetType();

                string fieldQuery = string.Empty;

                PropertyInfo[] propertyInfoList = typeOfObj.GetProperties();

                for (int i = 0; i < propertyInfoList.Count(); i++)
                {
                    bool isIdentity = false;
                    DataObjectFieldAttribute att = propertyInfoList[i].GetCustomAttributes(typeof(DataObjectFieldAttribute), false).Cast<DataObjectFieldAttribute>().FirstOrDefault();
                    if (att != null)
                        isIdentity = att.IsIdentity;

                    if (isIdentity == false)
                    {
                        if (propertyInfoList[i].GetValue(obj, null) != null)
                        {
                            if (fieldQuery == string.Empty)
                                fieldQuery += propertyInfoList[i].Name + "=@" + propertyInfoList[i].Name;
                            else
                                fieldQuery += "," + propertyInfoList[i].Name + "=@" + propertyInfoList[i].Name;

                        }
                    }
                }


                Dictionary<string, string> newParameterDic = new Dictionary<string, string>();
                foreach (KeyValuePair<String, String> item in parametersDic)
                {
                    if (whereQuery == string.Empty)
                        whereQuery += " (" + item.Key + "=@" + item.Key + "1)";
                    else
                        whereQuery += " and (" + item.Key + "=@" + item.Key + "1)";
                    newParameterDic.Add(item.Key + "1", item.Value);
                }
                

                if (whereQuery != "")
                    query = @"Update " + tblName + " Set " + fieldQuery + " Where " + whereQuery;
                else
                    query = @"Update " + tblName + " Set " + fieldQuery;
                SqlParameter[] paramFieldArray = GenerateParameterForInsert(propertyInfoList, obj);
                SqlParameter[] paramWhereArray = GenerateParameterForDelete(newParameterDic);
                SqlParameter[] mergeParamArray = new SqlParameter[paramFieldArray.Length + paramWhereArray.Length];
                Array.Copy(paramFieldArray, 0, mergeParamArray, 0, paramFieldArray.Length);
                Array.Copy(paramWhereArray, 0, mergeParamArray, paramFieldArray.Length, paramWhereArray.Length);

                sqlConnection = new SqlConnection(connectionString);
                myCommand = new SqlCommand();
                myCommand.Connection = sqlConnection;
                myCommand.CommandText = query;
                myCommand.Parameters.AddRange(mergeParamArray);
                myCommand.Connection.Open();
                int resultExecute = myCommand.ExecuteNonQuery();
                if (resultExecute > 0)
                    return true;
                else return false;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }
        private SqlParameter[] GenerateParameterForInsert(PropertyInfo[] propertyInfoList, object obj)
        {
            try
            {

               
                List<SqlParameter> paramArray = new List<SqlParameter>();
                
                for (int i = 0; i < propertyInfoList.Count(); i++)
                {
                    if (propertyInfoList[i].CanWrite)
                    {
                        if (propertyInfoList[i].GetValue(obj, null) != null)
                        {
                            SqlParameter paramSQL = new SqlParameter("@" + propertyInfoList[i].Name, propertyInfoList[i].GetValue(obj, null));
                            paramArray.Add(paramSQL);
                           
                        }
                    }
                }
                return paramArray.ToArray();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
       
        private SqlParameter[] GenerateParameterForDelete(Dictionary<string, string> paramDic)
        {
            try
            {
                int i = 0;
                SqlParameter[] paramArray = new SqlParameter[paramDic.Count];
                foreach (KeyValuePair<String, String> item in paramDic)
                {
                    SqlParameter paramSQL = new SqlParameter("@" + item.Key, item.Value);
                    paramArray[i] = paramSQL;
                    i++;
                }
                return paramArray;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

    }
}
