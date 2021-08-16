using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;
using System.Data;
namespace ASPWebClock.Infrastructure.Repository
{
    public class WebpassUserRepository
    {

        dbConnection connection = new dbConnection();
        logRepository logger = new logRepository();

        
        public bool CheckPersonIsInsteadMan(string insteadManBarcode, DateTime fromdate,DateTime todate)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select * fromNW_webpass where HasInsteadMan=True and InsteadMan=@insteadMan and  FromDateIMan>=@fromDate and ToDateIMan<=@todate";
                SqlParameter[] paramArray = new SqlParameter[3];
                SqlParameter fromDateParam = new SqlParameter("@fromDate", fromdate);
                SqlParameter toDateParam = new SqlParameter("@toDate", fromdate);
                SqlParameter barcodeParam = new SqlParameter("@insteadMan", insteadManBarcode);
                paramArray[0] = fromDateParam;
                paramArray[1] = toDateParam;
                paramArray[2] = barcodeParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در چک کردن جانشین بودن شخص");
                }
                if (dtResult.Rows.Count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }

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
                LogObj.Comment = string.Format("خطا در چک کردن جانشین بودن شخص  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در چک کردن جانشین بودن شخص");

            }
        }
        public DataTable GetInsteadManOfPerson(string personBarcode,  DateTime date)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select ID,nw_webpass.p_barcode as Barcode,InsteadMan,FromDateIMan,ToDateIMan,PersonPost,(P_Name + ' ' + P_Family) as NameFamily from NW_webpass inner join persons on InsteadMan=Persons.P_BarCode where HasInsteadMan='True' and nw_webpass.p_barcode=@barcode  and ToDateIMan>=@date and p_status in (1,2,3,6)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter dateParam = new SqlParameter("@date", date.Date);

                SqlParameter personBarcodeParam = new SqlParameter("@barcode", personBarcode);

                paramArray[0] = dateParam;

                paramArray[1] = personBarcodeParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت شخص جانشین");
                }
                return dtResult;

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
                LogObj.Comment = string.Format("خطا در دریافت شخص جانشین  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت شخص جانشین");

            }
        }
        public IList<decimal> GetWebpassIDInsteadMans(string personBarcode, DateTime date)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select ID from NW_webpass  where HasInsteadMan='True' and InsteadMan=@barcode  and FromDateIMan<=@date  and ToDateIMan>=@date ";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter dateParam = new SqlParameter("@date", date);

                SqlParameter personBarcodeParam = new SqlParameter("@barcode", personBarcode);

                paramArray[0] = dateParam;

                paramArray[1] = personBarcodeParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پست فرد جانشین");
                }
                List<decimal> listIDs = new List<decimal>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    listIDs.Add((decimal)dtResult.Rows[i]["ID"]);
                }
                return listIDs;

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
                LogObj.Comment = string.Format("خطا در دریافت پست فرد جانشین  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پست فرد جانشین");


            }
        }
        
        public bool CheckAddOverTimeAccess(string postID)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select isnull(AgreeOverTime,'False') as AgreeOverTime  from NW_webpass where (ID=@id)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter postIDParam = new SqlParameter("@id", postID);

                paramArray[0] = postIDParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در چک کردن اضافه شدن زمان دسترسی");
                }
                if (dtResult.Rows.Count > 0)
                {
                    return Convert.ToBoolean(dtResult.Rows[0]["AgreeOverTime"]);
                }
                else
                {
                    return false;
                }

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
                LogObj.Comment = string.Format("خطا در چک کردن اضافه شدن زمان دسترسی  {0}، متن پیغام {1}.خطا", postID, Utility.Utility.GetExecptionMessage(ex));

                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در چک کردن اضافه شدن زمان دسترسی");

            }
        }
        public int GetRequestOverTimeValue(int webPassid)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select isnull(MaxTimeReq,0) as overTime from NW_webpass where id=@id";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id", webPassid);
                paramArray[0] = idParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در  دریافت درخواست بر زمان دسترسی");
                }
                return Convert.ToInt32(dtResult.Rows[0]["overTime"]);
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
                LogObj.Comment = string.Format("خطا در  دریافت درخواست بر زمان دسترسی  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webPassid;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در  دریافت درخواست بر زمان دسترسی");
                


            }


        }


        public bool UserisFinalManager(string webPassID)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select isnull(FinalManager,'False') as FinalManager from NW_webpass where ID=@webPassID";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter webPassIDParam = new SqlParameter("@webPassID", webPassID);
                paramArray[0] = webPassIDParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در کنترول مدیر نهایی بودن فرد");
                }
                return Convert.ToBoolean(dtResult.Rows[0]["FinalManager"]);

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
                LogObj.Comment = string.Format("خطا در کنترول مدیر نهایی بودن فرد  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترول مدیر نهایی بودن فرد");


            }


        }
        public int GetUserStatusBywebPassId(decimal webPassId)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select isnull(p_status,0)  as Status from NW_webpass where id=@id";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter userNameParam = new SqlParameter("@id", webPassId);
                paramArray[0] = userNameParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت وضعیت کاربر به وسیله ی آی دی پست");
                }
                if (dtResult.Rows.Count > 0)
                {
                    return Convert.ToInt32(dtResult.Rows[0]["Status"]);
                }
                else
                {
                    return 0;
                }
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت وضعیت کاربر به وسیله ی آی دی پست  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webPassId;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت وضعیت کاربر به وسیله ی آی دی پست");


            }


        }
        public string GetWebPassIDByUserName(string barcode,string post)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select (webpass.ID) as ID from NW_webpass where (PersonPost=@post) and (p_barcode=@barcode)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter postParam = new SqlParameter("@post", post);
                SqlParameter barcodeParam = new SqlParameter("@barcode", post);
                paramArray[0] = postParam;
                paramArray[1] = barcodeParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت آی دی پست به وسیله ی نام کاربری با barcode = "+ barcode);
                }
                return dtResult.Rows[0]["ID"].ToString();
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت آی دی پست به وسیله ی نام کاربری  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت آی دی پست به وسیله ی نام کاربری با barcode = " + barcode);


            }


        }
        public DataTable GetWebPassPersonsByID(decimal webpassId)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"(select ID,(P_Name + '(' + P_Code + ')') as Name,PersonBarCode,isKarkardfrm,isRequestfrm,isOperatorfrm,isKeeperfrm,isOverTimefrm,isPerson,isPart,isSubPart,AccessType,WebPassId from NW_webpasspersons
                                        join parts on PersonBarCode=P_Code
                                        where (WebPassId=@WebPassId) and (ispart='True')
                                         union
                                         select ID,(P_Name + ' ' + P_Family + '(' + P_BarCode + ')' ) as Name,PersonBarCode,isKarkardfrm,isRequestfrm,isOperatorfrm,isKeeperfrm,isOverTimefrm,isPerson,isPart,isSubPart,AccessType,WebPassId from NW_webpasspersons
                                        join (select persons.P_Name,persons.P_Family,persons.P_BarCode from persons)webpassInfo
                                         on NW_webpasspersons.PersonBarCode=webpassInfo.p_barcode
                                         where (WebPassId=@WebPassId) and (isperson='True')) order by ID";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter webPassIdParam = new SqlParameter("@WebPassId", webpassId);
                paramArray[0] = webPassIdParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پست به وسیله ی آی دی شخص");
                }
                return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت پست به وسیله ی آی دی شخص  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webpassId;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پست به وسیله ی آی دی شخص");


            }


        }

        public WebpassUserProxy GetWebPassUserByID(decimal id)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select (NW_webpass.ID) as ID,(persons.P_BarCode) as Barcode,(NW_webpass.PersonPost) as PersonPost,HasInsteadMan,InsteadMan,isSaveAccept,isAcceptOwner,FinalManager,FromDateIman,ToDateIman,p_status,Haspart,Hasperson,TopMan,MaxTimeReq,MaxOverTime,AgreeAddWork,AgreeOverTime ,ROW_NUMBER() OVER (order by NW_webpass.PersonPost)as RowNumber from persons join NW_webpass on persons.P_BarCode=NW_webpass.p_barcode where (NW_webpass.ID=@id)";

                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@id", id);
                paramArray[0] = barcodeParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler(" خطا در دریافت پست پرسنل با id = " + id);
                }
                WebpassUserProxy webPassUserProxyObj = null;
                if(dtResult.Rows.Count>0)
                {
                    webPassUserProxyObj = new WebpassUserProxy(); ;
                    webPassUserProxyObj.ID = Convert.ToDecimal(dtResult.Rows[0]["ID"]);
                    webPassUserProxyObj.Barcode = dtResult.Rows[0]["Barcode"].ToString();
                    webPassUserProxyObj.PersonPost = dtResult.Rows[0]["PersonPost"].ToString();

                    webPassUserProxyObj.AgreeAddWork = Convert.ToBoolean(dtResult.Rows[0]["AgreeAddWork"] == DBNull.Value ? false : dtResult.Rows[0]["AgreeAddWork"]);
                    webPassUserProxyObj.AgreeOverTime = Convert.ToBoolean(dtResult.Rows[0]["AgreeOverTime"] == DBNull.Value ? false : dtResult.Rows[0]["AgreeOverTime"]);
                    webPassUserProxyObj.FinalManager = Convert.ToBoolean(dtResult.Rows[0]["FinalManager"] == DBNull.Value ? false : dtResult.Rows[0]["FinalManager"]);
                    webPassUserProxyObj.HasInsteadMan = Convert.ToBoolean(dtResult.Rows[0]["HasInsteadMan"] == DBNull.Value ? false : dtResult.Rows[0]["HasInsteadMan"]);
                    webPassUserProxyObj.Haspart = Convert.ToBoolean(dtResult.Rows[0]["Haspart"] == DBNull.Value ? false : dtResult.Rows[0]["Haspart"]);
                    webPassUserProxyObj.Hasperson = Convert.ToBoolean(dtResult.Rows[0]["Hasperson"] == DBNull.Value ? false : dtResult.Rows[0]["Hasperson"]);
                    webPassUserProxyObj.InsteadMan = dtResult.Rows[0]["InsteadMan"].ToString();
                    webPassUserProxyObj.isAcceptOwner = Convert.ToBoolean(dtResult.Rows[0]["isAcceptOwner"] == DBNull.Value ? false : dtResult.Rows[0]["isAcceptOwner"]);
                    webPassUserProxyObj.MaxOverTime = Convert.ToInt32(dtResult.Rows[0]["MaxOverTime"] == DBNull.Value ? 0 : dtResult.Rows[0]["MaxOverTime"]);
                    webPassUserProxyObj.MaxTimeReq = Convert.ToInt32(dtResult.Rows[0]["MaxTimeReq"] == DBNull.Value ? 0 : dtResult.Rows[0]["MaxTimeReq"]);
                    webPassUserProxyObj.Status = Convert.ToInt32(dtResult.Rows[0]["p_status"] == DBNull.Value ? 0 : dtResult.Rows[0]["p_status"]);
                    webPassUserProxyObj.ToDateIman = Convert.ToDateTime(dtResult.Rows[0]["ToDateIman"] == DBNull.Value ? new DateTime() : dtResult.Rows[0]["ToDateIman"]);
                    webPassUserProxyObj.TopMan = Convert.ToDecimal(dtResult.Rows[0]["TopMan"] == DBNull.Value ? 0 : dtResult.Rows[0]["TopMan"]);
                    webPassUserProxyObj.FromDateIman = Convert.ToDateTime(dtResult.Rows[0]["FromDateIman"] == DBNull.Value ? new DateTime() : dtResult.Rows[0]["FromDateIman"]);

                   
                }
                return webPassUserProxyObj;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت پست به وسیله ی آی دی کاربر  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = id;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پست به وسیله ی آی دی کاربر");


            }
        }
        public IList<WebpassUserProxy> GetPostOfPerson(string barcode)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select (NW_webpass.ID) as ID,(persons.P_BarCode) as Barcode,(NW_webpass.PersonPost) as PersonPost,HasInsteadMan,InsteadMan,isSaveAccept,isAcceptOwner,FinalManager,FromDateIman,ToDateIman,p_status,Haspart,Hasperson,TopMan,MaxTimeReq,MaxOverTime,AgreeAddWork,AgreeOverTime ,ROW_NUMBER() OVER (order by NW_webpass.PersonPost)as RowNumber from persons join NW_webpass on persons.P_BarCode=NW_webpass.p_barcode where (persons.P_BarCode = @barcode)";

                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = barcodeParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler(" خطا در دریافت پست پرسنل با barcode = " + barcode);
                }
                List<WebpassUserProxy> webPassUserProxyList = new List<WebpassUserProxy>();
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    WebpassUserProxy webPassUserProxyObj = new WebpassUserProxy();
                    webPassUserProxyObj.ID = Convert.ToDecimal(dtResult.Rows[i]["ID"]);
                    webPassUserProxyObj.Barcode = dtResult.Rows[i]["ID"].ToString();
                    webPassUserProxyObj.PersonPost = dtResult.Rows[i]["PersonPost"].ToString();

                    webPassUserProxyObj.AgreeAddWork = Convert.ToBoolean(dtResult.Rows[i]["AgreeAddWork"] == DBNull.Value ? false : dtResult.Rows[i]["AgreeAddWork"]);
                    webPassUserProxyObj.AgreeOverTime = Convert.ToBoolean(dtResult.Rows[i]["AgreeOverTime"] == DBNull.Value ? false : dtResult.Rows[i]["AgreeOverTime"]);
                    webPassUserProxyObj.FinalManager = Convert.ToBoolean(dtResult.Rows[i]["FinalManager"] == DBNull.Value ? false : dtResult.Rows[i]["FinalManager"]);
                    webPassUserProxyObj.HasInsteadMan = Convert.ToBoolean(dtResult.Rows[i]["HasInsteadMan"] == DBNull.Value ? false : dtResult.Rows[i]["HasInsteadMan"]);
                    webPassUserProxyObj.Haspart = Convert.ToBoolean(dtResult.Rows[i]["Haspart"] == DBNull.Value ? false : dtResult.Rows[i]["Haspart"]);
                    webPassUserProxyObj.Hasperson = Convert.ToBoolean(dtResult.Rows[i]["Hasperson"] == DBNull.Value ? false : dtResult.Rows[i]["Hasperson"]);
                    webPassUserProxyObj.InsteadMan = dtResult.Rows[i]["InsteadMan"].ToString();
                    webPassUserProxyObj.isAcceptOwner = Convert.ToBoolean(dtResult.Rows[i]["isAcceptOwner"] == DBNull.Value ? false : dtResult.Rows[i]["isAcceptOwner"]);
                    webPassUserProxyObj.MaxOverTime = Convert.ToInt32(dtResult.Rows[i]["MaxOverTime"] == DBNull.Value ? 0 : dtResult.Rows[i]["MaxOverTime"]);
                    webPassUserProxyObj.MaxTimeReq = Convert.ToInt32(dtResult.Rows[i]["MaxTimeReq"] == DBNull.Value ? 0 : dtResult.Rows[i]["MaxTimeReq"]);
                    webPassUserProxyObj.Status = Convert.ToInt32(dtResult.Rows[i]["p_status"] == DBNull.Value ? 0 : dtResult.Rows[i]["p_status"]);
                    webPassUserProxyObj.ToDateIman = Convert.ToDateTime(dtResult.Rows[i]["ToDateIman"] == DBNull.Value ? new DateTime() : dtResult.Rows[i]["ToDateIman"]);
                    webPassUserProxyObj.TopMan = Convert.ToDecimal(dtResult.Rows[i]["TopMan"] == DBNull.Value ? 0 : dtResult.Rows[i]["TopMan"]);
                    webPassUserProxyObj.FromDateIman = Convert.ToDateTime(dtResult.Rows[i]["FromDateIman"] == DBNull.Value ? new DateTime() : dtResult.Rows[i]["FromDateIman"]);
                   
                    webPassUserProxyList.Add(webPassUserProxyObj);
                }
                return webPassUserProxyList;
                
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت پست پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler(" خطا در دریافت پست پرسنل با barcode = " + barcode);


            }


        }

        
        public DataTable GetPostExistForEditPersonnal(string barcode,string postName,int id)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select ID  from NW_webpass  where (p_barcode = @barcode) and (PersonPost=@post) and (ID<>@id)";
                SqlParameter[] paramArray = new SqlParameter[3];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter postParam = new SqlParameter("@post", postName);
                SqlParameter idParam = new SqlParameter("@id", id);
                paramArray[0] = barcodeParam;
                paramArray[1] = postParam;
                paramArray[2] = idParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در واکشی پست موجود برای شخص با barcode = "+ barcode);
                }
                return dtResult;

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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی پست موجود برای شخص  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;

                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در واکشی پست موجود برای شخص با barcode = " + barcode);

            }
        }
        public string DeletePostOfPersonnal(int id)
        {
            try
            {
                string commandText = "delete from NW_webpasspersons  where (WebPassId = @id)";
                SqlParameter[] paramArraywebpasspersons = new SqlParameter[1];

                SqlParameter idwebpasspersonsParam = new SqlParameter("@id", id);

                paramArraywebpasspersons[0] = idwebpasspersonsParam;
                bool result = connection.executeDeleteQuery(commandText, paramArraywebpasspersons);
                //*******************
                string commandText2 = "delete from NW_webpass  where (ID = @id)";
                SqlParameter[] paramArray = new SqlParameter[1];

                SqlParameter idParam = new SqlParameter("@id", id);

                paramArray[0] = idParam;
                bool result2 = connection.executeDeleteQuery(commandText2, paramArray);
                //*********************
                if (result == false)
                {
                    throw new MyExceptionHandler("خطا در حذف پست شخص");
                }
                else
                {
                    return "پست با موفقیت حذف شد";
                }


            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در حذف پست شخص {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف پست شخص");


            }
        }
        public string DeleteInsteadManOfPerson(decimal id)
        {
            try
            {
                string commandText = "Update NW_webpass set HasInsteadMan='False'  where (Id = @id)";
                SqlParameter[] paramArraywebpass = new SqlParameter[1];

                SqlParameter idwebpassParam = new SqlParameter("@id", id);

                paramArraywebpass[0] = idwebpassParam;
                bool result = connection.executeUpdateQuery(commandText, paramArraywebpass);
                //*******************

                //*********************
                if (result == false)
                {
                    throw new MyExceptionHandler("خطا در حذف جانشین شخص");
                }
                else
                {
                    return "جانشین با موفقیت حذف شد";
                }


            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Update";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در حذف جانشین شخص {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف جانشین شخص");

            }
        }

        public DataTable GetAllUsersInformationStatusPartManager(string status)
        {
            try
            {
                string commandText = string.Empty;
                System.Data.DataTable dtResult = new System.Data.DataTable();

                commandText = @"select NW_webpass.id as ID,NW_webpass.p_barcode as Barcode,NW_webpass.PersonPost as UserName,
                            isnull(NW_webpass.p_status,0) as UserStatus,persons.P_Name as Name,persons.P_Family as Family,part.P_Name as PartName,part.id as idWPPerson
                            from NW_webpass join persons on NW_webpass.p_barcode=persons.P_BarCode 
                             left outer join 
                             (select parts.P_Code,parts.P_Name,WebPassId,id from parts join NW_webpasspersons 
                             on parts.P_Code=NW_webpasspersons.PersonBarCode and NW_webpasspersons.isPart='True')part
                            on NW_webpass.id=part.WebPassId
                            where NW_webpass.p_status in (@status)
                            order by NW_webpass.p_barcode";


                commandText = commandText.Replace("@status", status);


                SqlParameter[] paramArrayFilter = new SqlParameter[0];



                dtResult = connection.executeSelectQuery(commandText, paramArrayFilter);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در واکشی همه ی اطلاعات وضعیت کاربران");
                }
                return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی همه ی اطلاعات وضعیت کاربران {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در واکشی همه ی اطلاعات وضعیت کاربران");

            }
        }
      
        
        
       
        public DataTable GetOverTimeUserAccess(string webPassId)
       {
           try
           {
               System.Data.DataTable dtResult = new System.Data.DataTable();
               string commandText = @"SELECT WP.ID,isnull(TopManWebPass.ID,0) as TopManID ,isnull(WP.MaxTimeReq,0) as MaxTimeReq, isnull(WP.MaxOverTime,0) as MaxOverTime
                                    ,isnull(WP.AgreeAddWork,'False') as AgreeAddWork, isnull(WP.AgreeOverTime,'False') as AgreeOverTime, WP.TopMan,
                                      TopManWebPass.PersonPost as TopManUserName ,p.P_Name AS TopManName, p.P_Family AS TopManFamily
                                    FROM NW_webpass AS WP
                                    left outer JOIN NW_webpass AS TopManWebPass
                                    ON TopManWebPass.ID = WP.TopMan
                                    left outer JOIN persons AS p
                                    ON TopManWebPass.P_BarCode = p.p_barcode
                                    WHERE (WP.ID=@id)";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter webPassIdParam = new SqlParameter("@id", webPassId);
               paramArray[0] = webPassIdParam;
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               //*********************
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت  مجوز اضافه کاری پرسنل");
               }
               return dtResult;
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
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.Comment = string.Format("خطا در واکشی مجوز های اضافه کاری پرسنل {0}، متن پیغام {1}.خطا", webPassId, Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت  مجوز اضافه کاری پرسنل");

           }
       }
        public bool CheckAgreeOverTimeAccess(string webPassId)
       {
           try
           {
               System.Data.DataTable dtResult = new System.Data.DataTable();
               string commandText = @"select isnull(AgreeOverTime,'False') as AgreeOverTime from NW_webpass where (ID=@id)";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter webPassIdParam = new SqlParameter("@id", webPassId);
               paramArray[0] = webPassIdParam;
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               //*********************
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در واکشی مجوز های اضافه کاری پرسنل");
               }
               if (dtResult.Rows.Count > 0)
                   return Convert.ToBoolean(dtResult.Rows[0]["AgreeOverTime"]);
               else
                   return false;
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
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.Comment = string.Format("خطا در واکشی مجوز های اضافه کاری پرسنل {0}، متن پیغام {1}.خطا", webPassId, Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در واکشی مجوز های اضافه کاری پرسنل");

           }
       }
       
        public bool EditUserAccessToStatusToOverTime(decimal id, int status, int topMan, int maxTimeReq, int maxOverTime, bool agreeAddWork, bool agreeOverTime,bool isAcceptOwner,bool isFinalManager,List<int> pishCardItems)
       {
           bool ResultQuery=false;
           try
           {



               string commandText = @"update NW_webpass set p_status=@status,TopMan=@topMan,MaxTimeReq=@maxTimeReq,
                                    MaxOverTime=@maxOverTime,AgreeAddWork=@agreeAddWork,AgreeOverTime=@agreeOverTime,
                                    isAcceptOwner=@isAcceptOwner,FinalManager=@finalManager where (ID=@id)";
               SqlParameter[] paramArray = new SqlParameter[9];
               SqlParameter idParam = new SqlParameter("@id", id);
               SqlParameter statusParam = new SqlParameter("@status", status);
               SqlParameter topManParam = new SqlParameter("@topMan", topMan);
               SqlParameter maxTimeReqParam = new SqlParameter("@maxTimeReq", maxTimeReq);
               SqlParameter maxOverTimeParam = new SqlParameter("@maxOverTime", maxOverTime);
               SqlParameter agreeAddWorkParam = new SqlParameter("@agreeAddWork", agreeAddWork);
               SqlParameter agreeOverTimeParam = new SqlParameter("@agreeOverTime", agreeOverTime);
               SqlParameter isAcceptOwnerParam = new SqlParameter("@isAcceptOwner", isAcceptOwner);
               SqlParameter isFinalManagerParam = new SqlParameter("@finalManager", isFinalManager);
               paramArray[0] = idParam;
               paramArray[1] = statusParam;
               paramArray[2] = topManParam;
               paramArray[3] = maxTimeReqParam;
               paramArray[4] = maxOverTimeParam;
               paramArray[5] = agreeAddWorkParam;
               paramArray[6] = agreeOverTimeParam;
               paramArray[7] = isAcceptOwnerParam;
               paramArray[8] = isFinalManagerParam;
               ResultQuery = EditAccessUserToPishCards(pishCardItems, id);
               if(ResultQuery==true)
               ResultQuery = connection.executeInsertQuery(commandText, paramArray);
               else
                   return false;

               return ResultQuery;
               

           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {
               Log LogObj = new Log();
               LogObj.Action = "Update";
               LogObj.date = DateTime.Now;
               LogObj.Status = false;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.Comment = string.Format("خطا در ویرایش دسترسی به اضافه کار  {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در ویرایش دسترسی به اضافه کار");

           }

       }
        public bool DeleteUserAccessToStatusToOverTime(decimal webpassId)
       {
           bool ResultQuery = false;
           try
           {
               string commandText = @"delete from nw_webpass where (ID=@id)";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter idParam = new SqlParameter("@id", webpassId);
               paramArray[0] = idParam;
               ResultQuery = DeleteAccessUserToPishCards(webpassId);
               if (ResultQuery == true)
                   ResultQuery = DeleteAccessUserToMangerPersons(webpassId);
               else return false;
               if (ResultQuery == true)
                   ResultQuery = connection.executeUpdateQuery(commandText, paramArray);
               else return false;
               return ResultQuery;
               

           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {
               Log LogObj = new Log();
               LogObj.Action = "Delete";
               LogObj.date = DateTime.Now;
               LogObj.Status = false;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.Comment = string.Format("خطا در حذف دسترسی به اضافه کار {0}، متن پیغام {1}.خطا", webpassId, Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در حذف دسترسی به اضافه کار");

           }
       }
        public bool EditAccessUserToPishCards(List<int> pishCardItems,decimal webPassId)
        {
            string commandText = string.Empty;
            bool ResultQuery=false;
            try
            {

                SqlParameter[] paramArrayDelete = new SqlParameter[1];
                System.Data.DataTable dtResult = new System.Data.DataTable();

                commandText = "delete from NW_agree where (WebPassId=@id)";
                SqlParameter webPassIdParamDelete = new SqlParameter("@id", webPassId);
                paramArrayDelete[0] = webPassIdParamDelete;
                ResultQuery = connection.executeDeleteQuery(commandText,paramArrayDelete);
                
                
                foreach (int item in pishCardItems)
                {
                    commandText = @"insert into NW_agree  (PishCard_No,WebPassId) values (@pishCardId,@id)";
                        SqlParameter[] paramArrayInsert = new SqlParameter[2];
                        SqlParameter webPassIdParamInsert = new SqlParameter("@id", webPassId);
                        SqlParameter pishCardParam = new SqlParameter("@pishCardId", item);
                        paramArrayInsert[0] = webPassIdParamInsert;
                        paramArrayInsert[1] = pishCardParam;
                        ResultQuery = connection.executeInsertQuery(commandText, paramArrayInsert);
                    
                }
                return ResultQuery;
          
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Delete and Insert";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در ویرایش دسترسی کاربر به پیش کارت {0} به پیش کارت ها، متن پیغام {1}.خطا", webPassId, Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webPassId;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش دسترسی کاربر به پیش کارت");

            }
        }
        private bool DeleteAccessUserToPishCards(decimal id)
        {
            string commandText = string.Empty;
            bool ResultQuery = true;
            try
            {

                SqlParameter[] paramArrayDelete = new SqlParameter[1];
                System.Data.DataTable dtResult = new System.Data.DataTable();
                commandText = "delete from NW_agree where (WebPassId=@ID)";
                SqlParameter webPassIdParamDelete = new SqlParameter("@ID", id);
                paramArrayDelete[0] = webPassIdParamDelete;
                ResultQuery = connection.executeDeleteQuery(commandText, paramArrayDelete);

                return ResultQuery;

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در حذف دسترسی کاربر به پیش کارت  {0} به پیش کارت ها، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف دسترسی کاربر به پیش کارت");

            }
        }
        private bool DeleteAccessUserToMangerPersons(decimal id)
        {
            string commandText = string.Empty;
            bool ResultQuery = true;
            try
            {

                SqlParameter[] paramArrayDelete = new SqlParameter[1];
                System.Data.DataTable dtResult = new System.Data.DataTable();
                commandText = "delete from NW_webpasspersons where (WebPassId=@ID)";
                SqlParameter webPassIdParamDelete = new SqlParameter("@ID", id);
                paramArrayDelete[0] = webPassIdParamDelete;
                ResultQuery = connection.executeDeleteQuery(commandText, paramArrayDelete);

                return ResultQuery;

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در حذف دسترسی کاربر به مدیر  {0} به پیش کارت ها، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف دسترسی کاربر به مدیر");

            }
        }
        public bool AddNewUserToPerson(string barcode, string username, string password)
        {

            try
            {
                string commandText = "insert into NW_webLogin (lgn_barcode,lgn_userName,lgn_Password) values (@barcode,@username,@password)";
                SqlParameter[] paramArray = new SqlParameter[3];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter usernameParam = new SqlParameter("@userName", username);
                SqlParameter passwordParam = new SqlParameter("@Password", password);
                paramArray[0] = barcodeParam;
                paramArray[1] = usernameParam;
                paramArray[2] = passwordParam;
                bool ResultQuery = connection.executeInsertQuery(commandText, paramArray);
                return ResultQuery;
               

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Insert";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در تخصیص نام کاربری جدید به شخص {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تخصیص نام کاربری جدید به شخص با userName = " + barcode);

            }

        }
        public bool EditUserOfPerson(string id, string username, string password)
        {

            try
            {

                string commandText = string.Empty;
                SqlParameter[] paramArray;

                if (password != "")
                {
                    commandText = "update NW_weblogin set lgn_userName=@username,lgn_Password=@password where (ID=@id)";
                    paramArray = new SqlParameter[3];
                    SqlParameter barcodeParam = new SqlParameter("@id", id);
                    SqlParameter usernameParam = new SqlParameter("@username", username);
                    SqlParameter passwordParam = new SqlParameter("@password", password);
                    paramArray[0] = barcodeParam;
                    paramArray[1] = usernameParam;
                    paramArray[2] = passwordParam;
                }
                else
                {
                    commandText = "update NW_weblogin set lgn_userName=@username where (ID=@id)";
                    paramArray = new SqlParameter[2];
                    SqlParameter barcodeParam = new SqlParameter("@ID", id);
                    SqlParameter usernameParam = new SqlParameter("@username", username);
                    paramArray[0] = barcodeParam;
                    paramArray[1] = usernameParam;

                }


                bool ResultQuery = connection.executeUpdateQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Update";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در ویرایش نام کاربری شخص {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));

                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش نام کاربری شخص با userName = " + username);
            }

        }
        public bool DeleteUserToPerson(string id)
        {

            try
            {



                string commandText = "delete from NW_weblogin where (ID=@id)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@id", id);
                paramArray[0] = barcodeParam;

                bool ResultQuery = connection.executeDeleteQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در حذف  نام کاربری شخص {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));

                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف  نام کاربری شخص");
            }

        }
        public string InsertWebPassPerson(string barcode, bool person, bool part, int webPassID)
        {
            try
            {
                string commandText = "insert into NW_webpasspersons (PersonBarCode,isPerson,isPart,WebPassId,isKarkardfrm,isRequestfrm,isOperatorfrm,isKeeperfrm,isOverTimefrm,isSubPart,AccessType) values (@PersonBarCode,@isPerson,@isPart,@WebPassId,@isKarkardfrm,@isRequestfrm,@isOperatorfrm,@isKeeperfrm,@isOverTimefrm,@isSubPart,@AccessType)";
                SqlParameter[] paramArray = new SqlParameter[11];
                SqlParameter barcodeParam = new SqlParameter("@PersonBarCode", barcode);
                SqlParameter personParam = new SqlParameter("@isPerson", person);
                SqlParameter partParam = new SqlParameter("@isPart", part);
                SqlParameter webPassIDParam = new SqlParameter("@WebPassId", webPassID);
                SqlParameter isKarkardfrmParam = new SqlParameter("@isKarkardfrm", false);
                SqlParameter isRequestfrmParam = new SqlParameter("@isRequestfrm", false);
                SqlParameter isOperatorfrmParam = new SqlParameter("@isOperatorfrm", false);
                SqlParameter isKeeperfrmParam = new SqlParameter("@isKeeperfrm", false);
                SqlParameter isOverTimefrmParam = new SqlParameter("@isOverTimefrm", false);
                SqlParameter isSubPartParam = new SqlParameter("@isSubPart", false);
                SqlParameter AccessTypeParam = new SqlParameter("@AccessType", false);
                paramArray[0] = barcodeParam;
                paramArray[1] = personParam;
                paramArray[2] = partParam;
                paramArray[3] = webPassIDParam;
                paramArray[4] = isKarkardfrmParam;
                paramArray[5] = isRequestfrmParam;
                paramArray[6] = isOperatorfrmParam;
                paramArray[7] = isKeeperfrmParam;
                paramArray[8] = isOverTimefrmParam;
                paramArray[9] = isSubPartParam;
                paramArray[10] = AccessTypeParam;


                bool ResultQuery = connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ثبت گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ثبت پست به کاربر با barcode = "+barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Insert";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در ثبت پست به کاربر {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ثبت پست به کاربر با barcode = " + barcode);

            }
        }
        public Person GetPersonByUserName(string userName)
        {
            System.Data.DataTable dtResult = new System.Data.DataTable();
            try
            {


                string commandText = "select P_BarCode,P_Name,P_Family from persons where P_BarCode=(select lgn_barcode from NW_webLogin where (lgn_UserName=@userName))";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter userNameParam = new SqlParameter("@userName", userName);
                paramArray[0] = userNameParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت شخص به وسیله ی نام کاربری با  userName= "+ userName);
                }

                Person person = null;
                if (dtResult.Rows.Count > 0)
                {
                    person = new Person()
                    {
                        Barcode = dtResult.Rows[0]["P_BarCode"].ToString(),
                        Name = dtResult.Rows[0]["P_Name"].ToString(),
                        Family = dtResult.Rows[0]["P_Family"].ToString(),


                    };
                }


                return person;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.p_barcode = userName;
                LogObj.Comment = string.Format("خطا در دریافت شخص به وسیله ی نام کاربری {0}، متن پیغام {1}.خطا", userName, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت شخص به وسیله ی نام کاربری با  userName= " + userName);
            }
        }
        
        public Person GetPersonByPostID(decimal postID)
        {

            System.Data.DataTable dtResult = new System.Data.DataTable();
            try
            {


                string commandText = @"select (NW_webpass.p_barcode) as barcode,isnull(p_status,0) as pstatus,(PersonPost) as ppost,(P_Name) as name ,(P_Family) as family 
                                        from NW_webpass join persons
                                        on NW_webpass.p_barcode=persons.P_BarCode
                                        where (NW_webpass.ID=@postID)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter postIdParam = new SqlParameter("@postID", postID);

                paramArray[0] = postIdParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در  دریافت شخص به وسیله ی آی دی پست");
                }
                Person prs = new Person();
                if (dtResult.Rows.Count > 0)
                {
                    
                        prs.Barcode = dtResult.Rows[0]["barcode"].ToString();
                        prs.Name = dtResult.Rows[0]["name"].ToString();
                        prs.Family = dtResult.Rows[0]["family"].ToString();
                        prs.Status = Convert.ToInt32(dtResult.Rows[0]["pstatus"]);
                    
                }

                return prs;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در  دریافت شخص به وسیله ی آی دی پست {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در  دریافت شخص به وسیله ی آی دی پست");

            }
        }
        public bool EditWebPassPerson(bool isKarkardfrm, bool isRequestfrm, bool isOperatorfrm, bool isKeeperfrm, bool isOverTimefrm, bool isSubPart, bool AccessType, int id)
        {
            try
            {
                string commandText = "update NW_webpasspersons set isKarkardfrm=@karkard,isRequestfrm=@request,isOperatorfrm=@operator,isKeeperfrm=@keeper,isOverTimefrm=@overtime,isSubPart=@subpart,AccessType=@AccessType  where ID=@id";
                SqlParameter[] paramArray = new SqlParameter[8];
                SqlParameter karkardParam = new SqlParameter("@karkard", isKarkardfrm);
                SqlParameter requestParam = new SqlParameter("@request", isRequestfrm);
                SqlParameter operatorParam = new SqlParameter("@operator", isOperatorfrm);
                SqlParameter keeperParam = new SqlParameter("@keeper", isKeeperfrm);
                SqlParameter overtimeParam = new SqlParameter("@overtime", isOverTimefrm);
                SqlParameter subpartParam = new SqlParameter("@subpart", isSubPart);
                SqlParameter accessTypeParam = new SqlParameter("@AccessType", AccessType);
                SqlParameter idParam = new SqlParameter("@id", id);
                paramArray[0] = karkardParam;
                paramArray[1] = requestParam;
                paramArray[2] = operatorParam;
                paramArray[3] = keeperParam;
                paramArray[4] = overtimeParam;
                paramArray[5] = subpartParam;
                paramArray[6] = accessTypeParam;
                paramArray[7] = idParam;

                bool ResultQuery = connection.executeUpdateQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Update";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در ویرایش پست شخص {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش پست شخص");

            }
        }
        public string UpdateInsteadManPerson(decimal webPassID,string insteadManBarcode,DateTime fromDate,DateTime toDate)
        {
            try
            {
                string commandText = "update NW_webpass set HasInsteadMan='True',InsteadMan=@imBarcode,FromDateIMan=@fromDate,ToDateIMan=@toDate  where ID=@id";
                SqlParameter[] paramArray = new SqlParameter[4];
                SqlParameter insteadManParam = new SqlParameter("@imBarcode", insteadManBarcode);
                SqlParameter fromDateParam = new SqlParameter("@fromDate", fromDate);
                SqlParameter toDateParam = new SqlParameter("@toDate", toDate);
                SqlParameter idParam = new SqlParameter("@id", webPassID);
                paramArray[0] = insteadManParam;
                paramArray[1] = fromDateParam;
                paramArray[2] = toDateParam;
                paramArray[3] = idParam;


                bool ResultQuery = connection.executeUpdateQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ثبت گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در به روز رسانی شخص جانشین");
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Update";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در به روز رسانی شخص جانشین {0}، متن پیغام {1}.خطا", webPassID, Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webPassID;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در به روز رسانی شخص جانشین");

            }
        }
        public bool DeleteWebPassPerson(int id)
        {

            try
            {



                string commandText = "delete from NW_webpasspersons where (ID=@id)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@id", id);
                paramArray[0] = barcodeParam;

                bool ResultQuery = connection.executeDeleteQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در حذف پست شخص {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف پست شخص");

            }

        }
        public DataTable GetWebPassPersonExist(string barcode,int webPassID)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select ID from NW_webpasspersons  where (PersonBarCode = @barcode) and (WebPassId=@webPassId)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter webPassIdParam = new SqlParameter("@webPassId", webPassID);
                paramArray[0] = barcodeParam;
                paramArray[1] = webPassIdParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت آی دی پست موجود برای شخص با barcode =" + barcode);
                }
                return dtResult;

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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت آی دی پست موجود برای شخص  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.UserWebPassID = webPassID;
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت آی دی پست موجود برای شخص با barcode =" + barcode);

            }
        }
        public string AddNewPostToPerson(string barcode, string post) 
        {


            try
            {

                string commandText = "insert into NW_webpass (p_barcode,PersonPost) values (@barcode,@post)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter postParam = new SqlParameter("@post", post);
                paramArray[0] = barcodeParam;
                paramArray[1] = postParam;

                bool ResultQuery = connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ثبت گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در تخصیص پست جدید به شخص جدید با barcode = "+barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Insert";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در تخصیص پست جدید به شخص جدید {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تخصیص پست جدید به شخص جدید با barcode = " + barcode);

            }


        }
        public string AddDefaultUserToNewPerson(string barcode,string userName,string password,int status,string post)
        {
            try
            {


                string commandText = "insert into NW_webLogin (lgn_barcode,lgn_UserName,lgn_Password) values (@barcode,@userName,@password)";
                SqlParameter[] paramArray = new SqlParameter[3];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter usernameParam = new SqlParameter("@userName", userName);
                SqlParameter passwordParam = new SqlParameter("@password", password);
                paramArray[0] = barcodeParam;
                paramArray[1] = usernameParam;
                paramArray[2] = passwordParam;

                bool ResultQuery = connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    string commandText3 = "Delete from NW_webpass where (p_barcode=@barcode) and (PersonPost=@post) and (p_status=@status)";
                    SqlParameter[] paramArray3 = new SqlParameter[3];
                    SqlParameter[] paramArray2 = new SqlParameter[3];
                    SqlParameter barcodeParam3 = new SqlParameter("@barcode", barcode);
                    SqlParameter postParam3 = new SqlParameter("@post", post);
                    SqlParameter statusParam3 = new SqlParameter("@status", status);
                    paramArray3[0] = barcodeParam3;
                    paramArray3[1] = postParam3;
                    paramArray3[2] = statusParam3;
                    bool result = connection.executeDeleteQuery(commandText3, paramArray3);

                    string commandText2 = "insert into NW_webpass (p_barcode,PersonPost,p_status) values (@barcode,@post,@status)";
                    SqlParameter barcodeParam2 = new SqlParameter("@barcode", barcode);
                    SqlParameter postParam2 = new SqlParameter("@post", post);
                    SqlParameter statusParam2 = new SqlParameter("@status", status);
                    paramArray2[0] = barcodeParam2;
                    paramArray2[1] = postParam2;
                    paramArray2[2] = statusParam2;
                    bool ResultQuery2 = connection.executeInsertQuery(commandText2, paramArray2);
                    if (ResultQuery2 == true)
                    {
                        return "اطلاعات با موفقیت ثبت گردید";
                    }
                    else
                    {
                        throw new MyExceptionHandler("خطا در تخصیص نام کاربری پیش فرض به کاربر جدید با barcode = "+barcode);
                    }

                }
                else
                {
                    throw new MyExceptionHandler("خطا در تخصیص نام کاربری پیش فرض به کاربر جدید با barcode = " + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Insert And Delete";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در تخصیص نام کاربری پیش فرض به کاربر جدید {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تخصیص نام کاربری پیش فرض به کاربر جدید با barcode = " + barcode);

            }


        }
        public string AddDefaultUserToEditPerson(string barcode, string userName, string password, int status, string post)
        {
            try
            {


                string commandText = "update NW_webLogin set lgn_UserName=@userName,lgn_Password=@password where (lgn_barcode=@barcode)";
                SqlParameter[] paramArray = new SqlParameter[3];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter usernameParam = new SqlParameter("@userName", userName);
                SqlParameter passwordParam = new SqlParameter("@password", password);
                paramArray[0] = barcodeParam;
                paramArray[1] = usernameParam;
                paramArray[2] = passwordParam;

                bool ResultQuery = connection.executeUpdateQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    string commandText3 = "Delete from NW_webpass where (p_barcode=@barcode) and (PersonPost=@post) and (p_status=@status)";
                    SqlParameter[] paramArray3 = new SqlParameter[3];
                    SqlParameter[] paramArray2 = new SqlParameter[3];
                    SqlParameter barcodeParam3 = new SqlParameter("@barcode", barcode);
                    SqlParameter postParam3 = new SqlParameter("@post", post);
                    SqlParameter statusParam3 = new SqlParameter("@status", status);
                    paramArray3[0] = barcodeParam3;
                    paramArray3[1] = postParam3;
                    paramArray3[2] = statusParam3;
                    bool result = connection.executeDeleteQuery(commandText3, paramArray3);

                    string commandText2 = "insert into NW_webpass (p_barcode,PersonPost,p_status) values (@barcode,@post,@status)";
                    SqlParameter barcodeParam2 = new SqlParameter("@barcode", barcode);
                    SqlParameter postParam2 = new SqlParameter("@post", post);
                    SqlParameter statusParam2 = new SqlParameter("@status", status);
                    paramArray2[0] = barcodeParam2;
                    paramArray2[1] = postParam2;
                    paramArray2[2] = statusParam2;
                    bool ResultQuery2 = connection.executeInsertQuery(commandText2, paramArray2);
                    if (ResultQuery2 == true)
                    {
                        return "اطلاعات با موفقیت ثبت گردید";
                    }
                    else
                    {
                        throw new MyExceptionHandler(" خطا در تخصیص نام کاربری پیش فرض به کاربر با barcode= "+ barcode);
                    }

                }
                else
                {
                    throw new MyExceptionHandler(" خطا در تخصیص نام کاربری پیش فرض به کاربر با barcode= " + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Update and Delete And Insert";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در تخصیص نام کاربری پیش فرض به کاربر  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler(" خطا در تخصیص نام کاربری پیش فرض به کاربر با barcode= " + barcode);

            }


        }
        public string EditPostofPerson(int id, string post)
        {


            try
            {

                string commandText = "update NW_webpass set PersonPost=@post where (ID=@id)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter idParam = new SqlParameter("@id", id);
                SqlParameter postParam = new SqlParameter("@post", post);
                paramArray[0] = idParam;
                paramArray[1] = postParam;
                bool ResultQuery = connection.executeUpdateQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ویرایش گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ویرایش پست شخص");
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Update";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در ویرایش پست کاربر پرسنل {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش پست شخص");

            }


        }
        public DataTable GetPostExistForPersonnel(string barcode, string postName)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select p_barcode,PersonPost from NW_webPass  where (p_barcode = @barcode) and (PersonPost=@Post)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter postParam = new SqlParameter("@Post", postName);
                paramArray[0] = barcodeParam;
                paramArray[1] = postParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت پست  موجود برای شخص با barcode= "+barcode);
                }
                return dtResult;

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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت پست  موجود برای شخص  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پست  موجود برای شخص با barcode= " + barcode);

            }
        }
    }

}