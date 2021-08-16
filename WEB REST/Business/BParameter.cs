using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
namespace Business
{
   public class BParameter
    {
       public ParameterFileDAL paramDAL
       {
           get
           {
               return new ParameterFileDAL();
           }
       }
       public Dictionary<string, string> GetParametersDic()
       {
           try
           {
               Dictionary<string, string> paramDic = paramDAL.GetParameterDics();
               return paramDic;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public string GetParameterValueByKey(string key)
       {
           try
           {
             return  paramDAL.GetParameterValueByKey(key);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
