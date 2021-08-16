using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using System.Reflection;
using System.Data.SqlClient;

namespace DAL
{

   public class PrgPrsDAL
    {
       FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
       public List<prgpr> GetProgramFoodPersonByDate(string barcode,string date)
       {
           try
           {
              var prgPrsObj = contextFoodReserve.prgprs.Where(prg=>prg.PP_PCode==barcode && prg.PP_Date==date);
               return prgPrsObj.ToList();
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       
       }
       public int GetProgramFoodPersonCountInDateRange(string barcode,string fromDate, string toDate)
       {
           try
           {
               int resultCount = 0;
               string query=@"select Count(*) from prgprs where PP_Date>={0} and PP_Date<={1} and PP_PCode={2}";
               
               var resultList = contextFoodReserve.ExecuteQuery<int>(query, fromDate, toDate,barcode);
               resultCount= resultList.First();
               return resultCount;

           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public int GetprgPrsRegisteredCountInDate(string date,int type)
       {
           try
           {
               //int resultCount = 0;
               //string query = @"select Count(*) from prgprs where PP_Date={0} and PP_Type={1} ";

               //var resultList = contextFoodReserve.ExecuteQuery<int>(query, date,type);
               var result = contextFoodReserve.prgprs.Count(c => c.PP_Date == date && c.PP_Type == type);
               //resultCount = resultList.First();
               return Convert.ToInt32(result);

           }
           catch (Exception ex)
           {

               throw ex;
           }
       }
       public bool InsertProgramFoodPerson(prgpr prgPrsObj)
       {
           try
           {
               
                bool result= new GenerateAdoNetQuery().InsertQuery(prgPrsObj.tableName,prgPrsObj);
                
               
               return true;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }

       public bool DeleteProgramFoodPerson(prgpr prgPrsObj)
       {
           try
           {
               Dictionary<string ,string> paramDic=new Dictionary<string,string>();
               paramDic.Add("PP_Date",prgPrsObj.PP_Date);
               paramDic.Add("PP_PCode",prgPrsObj.PP_PCode);
               paramDic.Add("PP_Type", prgPrsObj.PP_Type.ToString());
               bool result = new GenerateAdoNetQuery().DeleteQuery(prgPrsObj.tableName, paramDic);
               return result;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }

       

    }
}
