using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;

namespace ASPWebClock.Infrastructure.Repository
{
   public class PishcardRepository
    {

        dbConnection connection = new dbConnection();
        logRepository logger = new logRepository();
        public Pishcard GetPishcardByCode(int pishCode,int initCode)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"SELECT  (Pish_Code) as Code,case
                                        when isnull(Pish_LastName,'')='' then Pish_Name 
                                        when isnull(Pish_LastName,'') !='' then Pish_LastName
                                        end as Name,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily FROM pishcard WHERE (Pish_code=@pishCode) and (init_Code=@initCode)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter codeParam = new SqlParameter("@pishCode", pishCode);
                SqlParameter initParam = new SqlParameter("@initCode", initCode);
                paramArray[0] = codeParam;
                paramArray[1] = initParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پیش کارت با کد " + pishCode);
                }
                Pishcard pishcardObj = null;
                if (dtResult.Rows.Count > 0)
                {
                    pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[0]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[0]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[0]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[0]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[0]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[0]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[0]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[0]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[0]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[0]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[0]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[0]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[0]["Name"] == DBNull.Value ? "" : dtResult.Rows[0]["Name"].ToString();
                }
                

                return pishcardObj;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت همه ی پیش کارت های فعال پرسنل {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت همه ی پیش کارت های فعال پرسنل");

            }
        }
        public List<Pishcard> GetAllActivePishCard()
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"SELECT (Pish_Code) as Code,case
                                        when isnull(Pish_LastName,'')='' then Pish_Name 
                                        when isnull(Pish_LastName,'') !='' then Pish_LastName
                                        end as Name,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily FROM pishcard WHERE (Pish_activeWeb='True')";
                SqlParameter[] paramArray = new SqlParameter[0];
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت همه ی پیش کارت های فعال پرسنل");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }

                return pishcardList;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت همه ی پیش کارت های فعال پرسنل {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت همه ی پیش کارت های فعال پرسنل");

            }
        }
        public List<Pishcard> GetAllActivePishCardPersons(decimal webPassId)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"SELECT (Pish_Code) as Code,
                                         case
                                        when isnull(Pish_LastName,'')='' then Pish_Name 
                                        when isnull(Pish_LastName,'') !='' then Pish_LastName
                                        end as Name,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily FROM pishcard WHERE (Pish_activeWeb='True') and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode=(select p_barcode from NW_webpass where id=@webPassId))";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter webPssIdParam = new SqlParameter("@webPassId", webPassId);
                paramArray[0] = webPssIdParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت همه ی پیش کارت های پرسنل");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }
                return pishcardList;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت همه ی پیش کارت های پرسنل {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webPassId;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت همه ی پیش کارت های پرسنل");

            }
        }
        public List<Pishcard> GetActivePishCardUserAccessDeneid(decimal webPassId)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select Pish_Code  as Code,
                                    case
                                     when isnull(Pish_LastName,'')='' then Pish_Name 
                                     when isnull(Pish_LastName,'') !='' then Pish_LastName
                                      end as Name ,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily 
                                       from pishcard where Pish_activeWeb='True' 
                                    and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode=(select p_barcode from NW_webpass where id=@webPassId))
                                    and Pish_Code  not in  (SELECT PishCard_No FROM NW_agree where WebPassId=@webPassId)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter webPassIdParam = new SqlParameter("@webPassId", webPassId);
                paramArray[0] = webPassIdParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در واکشی پیش کارت های پرسنل ");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }
                return pishcardList;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی پیش کارت های پرسنل {0}، متن پیغام {1}.خطا", webPassId, Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webPassId;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در واکشی پیش کارت های پرسنل ");
            }
        }
        public List<Pishcard> GetActivePishCardUserAccessAllowed(decimal webPassId)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select Pish_Code as Code,
                                    case
                                        when isnull(Pish_LastName,'')='' then Pish_Name  
                                        when isnull(Pish_LastName,'') !='' then Pish_LastName
                                        end as Name ,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily  
                                        from pishcard where Pish_activeWeb='True' 
                                        and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode=(select p_barcode from NW_webpass where id=@webPassId))
                                        and Pish_Code  in (SELECT PishCard_No FROM NW_agree where WebPassId=@webPassId)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter webPassIdParam = new SqlParameter("@webPassId", webPassId);
                paramArray[0] = webPassIdParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پیش کارت های فعال");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }
                return pishcardList;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت پیش کارت های فعال {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webPassId;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پیش کارت های فعال");

            }
        }
        public List<Pishcard> GetPishCardDailyPerson(string barcode)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select Pish_Code as Code,case
                                        when isnull(Pish_LastName,'')='' then Pish_Name
                                        when isnull(Pish_LastName,'') !=''then Pish_LastName end as Name ,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily  
                                        from pishcard 
                                        where isdaily='True' and Pish_activeWeb='True' and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode=@barcode)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = barcodeParam;


                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پیش کارت های روزانه");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }
                return pishcardList;
            }

            catch (MyExceptionHandler ex)
            {

                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت پیش کارت های روزانه {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت پیش کارت های روزانه");
            }
        }
        public List<Pishcard> GetPishCardHourlyPermitPerson(string barcode)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select Pish_Code as Code,case
                                        when isnull(Pish_LastName,'')='' then Pish_Name
                                        when isnull(Pish_LastName,'') !=''then Pish_LastName end as Name ,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily 
                                        from pishcard 
                                        where isdaily='False' and Pish_activeWeb='True' and isPermit='True' and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode=@barcode)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = barcodeParam;

                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پیش کارت های ساعتی");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }
                return pishcardList;
            }

            catch (MyExceptionHandler ex)
            {

                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت پیش کارت های ساعتی {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت پیش کارت های ساعتی");
            }
        }
        public List<Pishcard> GetPishCardHourlyPerson(string barcode)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select Pish_Code as Code,case
                                        when isnull(Pish_LastName,'')='' then Pish_Name
                                        when isnull(Pish_LastName,'') !=''then Pish_LastName end as Name ,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily  
                                        from pishcard 
                                        where isdaily='False' and Pish_activeWeb='True'  and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode=@barcode)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = barcodeParam;

                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پیش کارت های ساعتی");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }
                return pishcardList;
            }

            catch (MyExceptionHandler ex)
            {

                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت پیش کارت های ساعتی {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت پیش کارت های ساعتی");
            }
        }

        public List<Pishcard> GetAllPishCardPerson(string barcode)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select Pish_Code as Code,case
                                        when isnull(Pish_LastName,'')='' then Pish_Name
                                        when isnull(Pish_LastName,'') !=''then Pish_LastName end as Name ,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily  
                                        from pishcard 
                                        where Pish_activeWeb='True' and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode=@barcode)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = barcodeParam;

                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت همه پیش کارت ها");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }
                return pishcardList;
            }

            catch (MyExceptionHandler ex)
            {

                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت همه پیش کارت ها  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت همه پیش کارت ها");
            }
        }
        public List<Pishcard> GetPishCardHourlyTrafficPerson(string barcode)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select Pish_Code as Code,case
                                        when isnull(Pish_LastName,'')='' then Pish_Name
                                        when isnull(Pish_LastName,'') !=''then Pish_LastName end as Name ,Pish_active,Pish_activeWeb,Pish_InitCode,IsPermit,IsDaily  
                                        from pishcard 
                                        where isdaily='False' and Pish_activeWeb='True' and isPermit='False' and Pish_InitCode=(select ISNULL(P_Param,0) as initParam from persons where persons.P_BarCode=@barcode)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = barcodeParam;

                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پیش کارت تردد");
                }
                List<Pishcard> pishcardList = new List<Pishcard>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    Pishcard pishcardObj = new Pishcard();
                    pishcardObj.IsDaily = dtResult.Rows[i]["IsDaily"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsDaily"]);
                    pishcardObj.IsPermit = dtResult.Rows[i]["IsPermit"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["IsPermit"]);
                    pishcardObj.Active = dtResult.Rows[i]["Pish_active"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_active"]);
                    pishcardObj.ActiveWeb = dtResult.Rows[i]["Pish_activeWeb"] == DBNull.Value ? false : Convert.ToBoolean(dtResult.Rows[i]["Pish_activeWeb"]);
                    pishcardObj.Code = dtResult.Rows[i]["Code"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Code"]);
                    pishcardObj.InitCode = dtResult.Rows[i]["Pish_InitCode"] == DBNull.Value ? 0 : Convert.ToInt32(dtResult.Rows[i]["Pish_InitCode"]);
                    pishcardObj.Name = dtResult.Rows[i]["Name"] == DBNull.Value ? "" : dtResult.Rows[i]["Name"].ToString();
                    pishcardList.Add(pishcardObj);
                }
                return pishcardList;
            }

            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت  پیش کارت های تردد  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new Exception("خطا در دریافت پیش کارت تردد");
            }
        }

    }
}
