using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using Model;


namespace DAL
{
    public class ParameterFileDAL
    {
        string parameterFileAddress = string.Empty;
        Dictionary<string, string> parameterDic;
        public ParameterFileDAL()
        {
            try
            {


                parameterFileAddress = System.Configuration.ConfigurationManager.AppSettings["ParameterFileAddress"].ToString();
                StreamReader reader = new StreamReader(parameterFileAddress);
                parameterDic = new Dictionary<string, string>();
                string line;
                int i = 1;
                while ((line=reader.ReadLine())!=null)
                {
                   

                    ParameterEnum paramEnum = (ParameterEnum)Enum.Parse(typeof(ParameterEnum), i.ToString());
                    parameterDic.Add(paramEnum.ToString(), line);
                    i++;

                }
                
                reader.Close();
                reader.Dispose();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public Dictionary<string, string> GetParameterDics()
        {
            try
            {
                return parameterDic;
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
                return parameterDic[key];
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



    }
}
