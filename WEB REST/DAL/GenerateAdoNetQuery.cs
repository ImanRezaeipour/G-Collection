using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Data.SqlClient;

namespace DAL
{
    internal class GenerateAdoNetQuery
    {
        
        dbConnection connection = new dbConnection();
        
        
        public SqlCommand GetSqlCommandInsertQuery(object obj)
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
                    if (propertyInfoList[i].CanWrite)
                    {
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
                string tblName = typeOfObj.GetField("tableName").GetValue(obj).ToString();
                query = @"Insert Into " + tblName + fieldQuery + "Values" + valueQuery;
                SqlParameter[] paramArray = GenerateParameterForInsert(propertyInfoList, obj);
                return connection.GetSqlCommandQuery(query, paramArray);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
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
                    if (propertyInfoList[i].CanWrite)
                    {
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
                bool result = connection.executeInsertQuery(query, paramArray);

                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        internal SqlCommand GetSqlCommandDeleteQuery(Dictionary<string, string> paramDic, object obj)
        {
            try
            {
                string query = string.Empty;
                string whereQuery = string.Empty;
                Type typeOfObj = obj.GetType();
                foreach (KeyValuePair<String, String> item in paramDic)
                {
                    if (whereQuery == string.Empty)
                        whereQuery += " (" + item.Key + "=@" + item.Key + ")";
                    else
                        whereQuery += " and (" + item.Key + "=@" + item.Key + ")";
                }



                string tblName = typeOfObj.GetField("tableName").GetValue(obj).ToString();
                if (whereQuery != "")
                    query = @"Delete From " + tblName + " Where " + whereQuery;
                else
                    query = @"Delete From " + tblName;
                SqlParameter[] paramArray = GenerateParameterForDelete(paramDic);
                return connection.GetSqlCommandQuery(query, paramArray);
            }
            catch (Exception ex)
            {

                throw ex;
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
                bool result = connection.executeDeleteQuery(query, paramArray);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        internal SqlCommand GetSqlCommnadUpdateQuery(Dictionary<string, string> parametersDic, object obj)
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
                    if (propertyInfoList[i].CanWrite)
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

                string tblName = typeOfObj.GetField("tableName").GetValue(obj).ToString();
                if (whereQuery != "")
                    query = @"Update " + tblName + " Set " + fieldQuery + " Where " + whereQuery;
                else
                    query = @"Update " + tblName + " Set " + fieldQuery;
                SqlParameter[] paramFieldArray = GenerateParameterForInsert(propertyInfoList, obj);
                SqlParameter[] paramWhereArray = GenerateParameterForDelete(newParameterDic);
                SqlParameter[] mergeParamArray = new SqlParameter[paramFieldArray.Length + paramWhereArray.Length];
                Array.Copy(paramFieldArray, 0, mergeParamArray, 0, paramFieldArray.Length);
                Array.Copy(paramWhereArray, 0, mergeParamArray, paramFieldArray.Length, paramWhereArray.Length);
                return connection.GetSqlCommandQuery(query, mergeParamArray);
            }
            catch (Exception ex)
            {

                throw ex;
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
                    if (propertyInfoList[i].CanWrite)
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

                bool result = connection.executeUpdateQuery(query, mergeParamArray);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
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
        public bool executeNonQueryWithTransaction(params SqlCommand[] sqlCommands)
        {
            try
            {
               return connection.executeNonQueryWithTransaction(sqlCommands);
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
