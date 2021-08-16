using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;
using System.Data;
using System.Web;


namespace ASPWebClock.Infrastructure.Repository
{
      
    public class partRepository
    {
        dbConnection connection = new dbConnection();
        private logRepository logger = new logRepository();
        public string GetPartsType()
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select count(*) as countchiled from parts  where P_Father<>'-1' ";
                SqlParameter[] paramArray = new SqlParameter[0];
                Part partRoot = new Part();
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (Convert.ToInt32(dtResult.Rows[0]["countchiled"]) > 0)
                    return "ByRoot";
                    
                else
                    
                return "NoRoot";
            }
            catch (MyExceptionHandler ex)
            {

                throw ex;
            }
            catch (Exception ex)
            {
                
                ASPWebClock.Infrastructure.Model.Log logObj = new Log();
                logObj.Action = "Select";
                logObj.date = DateTime.Now;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.Status = false;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.Comment = string.Format("خطا در وا کشی نوع  بخش ها {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(logObj);

                throw new MyExceptionHandler("خطا در دریافت نوع بخش ها .لطفا مجددا سعی نمایید");
            }
        }
        public Part GetPartsRoot()
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select * from parts  where P_Code='01' ";
                SqlParameter[] paramArray = new SqlParameter[0];
                Part partRoot = new Part();
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت ریشه بخش ها .لطفا مجددا سعی نمایید");
                }
                if (dtResult.Rows.Count > 0)
                {
                    partRoot.P_Code = dtResult.Rows[0]["P_Code"].ToString();
                    partRoot.P_CustomCode = dtResult.Rows[0]["P_CustomCode"].ToString();
                    partRoot.P_Name = dtResult.Rows[0]["P_Name"].ToString();
                    partRoot.P_LChild = dtResult.Rows[0]["P_LChild"].ToString();
                    partRoot.P_RSibling = dtResult.Rows[0]["P_RSibling"].ToString();
                    partRoot.P_Father = dtResult.Rows[0]["P_Father"].ToString();
                }
                //*********************

                return partRoot;
            }

            catch (MyExceptionHandler ex)
            {
                
                throw ex;
            }
            catch (Exception ex)
            {

                ASPWebClock.Infrastructure.Model.Log logObj = new Log();
                logObj.Action = "Select";
                logObj.date = DateTime.Now;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.Status = false;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.Comment = string.Format("خطا در وا کشی ریشه بخش ها {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(logObj);

                throw new MyExceptionHandler("خطا در دریافت ریشه بخش ها .لطفا مجددا سعی نمایید");
            }
        }
        public IList<Part> GetNodeChild(string nodeFatherCode)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select distinct top(3) * from parts  where P_Father=@nodeFather ";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter nodeFatherParam = new SqlParameter("@nodeFather", nodeFatherCode);
                paramArray[0] = nodeFatherParam;
                List<Model.Part> partList = new List<Model.Part>();

                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت فرزندان بخش ها با کد " + nodeFatherCode + ".لطقا مجددا سعی نمایید.");
                }
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Model.Part part = new Model.Part()
                    {
                        P_Code = dtResult.Rows[0]["P_Code"].ToString(),
                        P_CustomCode = dtResult.Rows[0]["P_CustomCode"].ToString(),
                        P_Name = dtResult.Rows[0]["P_Name"].ToString(),
                        P_LChild = dtResult.Rows[0]["P_LChild"].ToString(),
                        P_RSibling = dtResult.Rows[0]["P_RSibling"].ToString(),
                        P_Father = dtResult.Rows[0]["P_Father"].ToString()
                    };
                    partList.Add(part);
                }

                //*********************

                return partList;
            }

            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                ASPWebClock.Infrastructure.Model.Log logObj = new Log();
                logObj.Action = "Select";
                logObj.date = DateTime.Now;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.Status = false;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.Comment = string.Format("خطا در وا کشی فرزندان بخش ها با کد {0}، متن پیغام {1}.خطا", nodeFatherCode, Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(logObj);

                throw new MyExceptionHandler("خطا در دریافت فرزندان بخش ها با کد " + nodeFatherCode + ".لطقا مجددا سعی نمایید.");
            }
        }
        public List<Part> GetAllParts()
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select * from parts ";
                SqlParameter[] paramArray = new SqlParameter[0];
                dtResult = connection.executeSelectQuery(commandText, paramArray);
               

                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت همه بخش ها .لطفا مجددا سعی نمایید.");
                }
                List<Part> partList = new List<Part>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Part partObj = new Part();
                    partObj.P_Code = dtResult.Rows[i]["P_Code"].ToString();
                    partObj.P_CustomCode = dtResult.Rows[i]["P_CustomCode"].ToString();
                    partObj.P_Name = dtResult.Rows[i]["P_Name"].ToString();
                    partObj.P_LChild = dtResult.Rows[i]["P_LChild"].ToString();
                    partObj.P_RSibling = dtResult.Rows[i]["P_RSibling"].ToString();
                    partObj.P_Father = dtResult.Rows[i]["P_Father"].ToString();
                    partList.Add(partObj);
                }
                return partList;
            }

            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                ASPWebClock.Infrastructure.Model.Log logObj = new Log();
                logObj.Action = "Select";
                logObj.date = DateTime.Now;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.Status = false;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.Comment = string.Format("خطا در وا کشی  بخش ها  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(logObj);

                throw new MyExceptionHandler("خطا در دریافت همه بخش ها .لطفا مجددا سعی نمایید.");
            }
        }
        public List<Part> GetChildPartByCustomCode(string code)
        {
            try
            {
                DataTable dtResult = new DataTable();
                ASPWebClock.Infrastructure.Model.Part modelHelp = new ASPWebClock.Infrastructure.Model.Part();
                string commandText = "select * from parts where P_Father=@customCode";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter customCodeParam = new SqlParameter("@customCode", code);
                paramArray[0] = customCodeParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت زیر بخش های بخش با کد" + code + " .لطفا مجددا سعی نمایید.");
                }
                List<Model.Part> listChildPart = new List<Model.Part>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {



                    Model.Part part = new Model.Part()
                    {
                        P_Code = dtResult.Rows[i]["P_Code"].ToString(),
                        P_CustomCode = dtResult.Rows[i]["P_CustomCode"].ToString(),
                        P_Name = dtResult.Rows[i]["P_Name"].ToString(),
                        P_LChild = dtResult.Rows[i]["P_LChild"].ToString(),
                        P_RSibling = dtResult.Rows[i]["P_RSibling"].ToString(),
                        P_Father = dtResult.Rows[i]["P_Father"].ToString()
                    };
                    listChildPart.Add(part);
                }


                return listChildPart;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                ASPWebClock.Infrastructure.Model.Log logObj = new Log();
                logObj.Action = "Select";
                logObj.date = DateTime.Now;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.Status = false;
                logObj.Comment = ex.Message;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(logObj);

                throw new MyExceptionHandler("خطا در دریافت زیر بخش های بخش با کد" + code + " .لطفا مجددا سعی نمایید.");
            }
        }

        public IList<Part> GetAllChildPart(string code)
        {
            try
            {
                DataTable dtResult = new DataTable();
                Part modelHelp = new Part();
                string commandText = "select *  from parts where P_Father!='-1'";
                SqlParameter[] paramArray = new SqlParameter[0];
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت زیر بخش های بخش با کد" + code + " .لطفا مجددا سعی نمایید.");
                }
                IList<Part> listChildPart = new List<Part>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {



                    Model.Part part = new Model.Part()
                    {
                        P_Code = dtResult.Rows[i]["P_Code"].ToString(),
                        P_CustomCode = dtResult.Rows[i]["P_CustomCode"].ToString(),
                        P_Name = dtResult.Rows[i]["P_Name"].ToString(),
                        P_LChild = dtResult.Rows[i]["P_LChild"].ToString(),
                        P_RSibling = dtResult.Rows[i]["P_RSibling"].ToString(),
                        P_Father = dtResult.Rows[i]["P_Father"].ToString()
                    };
                    listChildPart.Add(part);
                }


                return listChildPart;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                ASPWebClock.Infrastructure.Model.Log logObj = new Log();
                logObj.Action = "Select";
                logObj.date = DateTime.Now;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.Status = false;
                logObj.Comment = ex.Message;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(logObj);

                throw new MyExceptionHandler("خطا در دریافت زیر بخش های بخش با کد" + code + " .لطفا مجددا سعی نمایید.");
            }
        }

    }
}
