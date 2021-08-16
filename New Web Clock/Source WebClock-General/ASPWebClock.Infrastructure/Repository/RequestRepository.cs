using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using ASPWebClock.Infrastructure.Model;
using System.Configuration;
using ASPWebClock.Infrastructure.Utility;
using System.Data;



namespace ASPWebClock.Infrastructure.Repository
{
    public class RequestRepository : RepositoryBase
    {
        logRepository logger = new logRepository();

        #region SQLCmds

        #region SelectPersonelRequest
        private readonly string cmdSelectReq1 = "SELECT Id_PK, Clock_User, dbo.person_name(Clock_User) name"
                                                      + " ,Clock_Date"
                                                      + " ,Clock_SendDate"
                                                      + " ,substring(Clock_AgreeDate,1,10) FirstAgreeDate"
                                                      + " ,substring(Clock_AgreeDate,11,10) SeconderyAgreeDate"
                                                      + " ,substring(Clock_AgreeDate,21,10) FinalyAgreeDate"
                                                      + " ,dbo.MToH(Clock_Time) Clock_Time"
                                                      + " ,dbo.MToH(Clock_eTime) Clock_eTime"
                                                      + " ,Clock_RdrCode"
                                                      + " ,Clock_Chg"
                                                      + " ,Clock_RecState"
                                                      + " ,dbo.pish_lastname(Clock_User,Clock_RecState) pish_name"
                                                      + " ,WebPassId"
                                                      + " ,dbo.person_name(Clock_User) clock_user_name"
                                                      + " ,Clock_RecDes"
                                                      + " ,Clock_FirstlyAgree"
                                                      + " ,Clock_SeconderyAgree"
                                                      + " ,Clock_FirstlyAgree_BarCode"
                                                      + " ,dbo.person_name(substring(Clock_FirstlyAgree_barcode,1,8)) FirstlyAgree_name"
                                                      + " ,dbo.person_name(substring(Clock_FirstlyAgree_barcode,9,8)) SeconderyAgree_name"
                                                      + " ,dbo.person_name(substring(Clock_FirstlyAgree_barcode,17,8)) FinallyAgree_name"
                                                      + " ,Clock_FinallyAgree"
            
                                                      + ",dbo.MToH(timeValue) timeValue"
                                            + " FROM NW_Requests"
                                            + " WHERE Clock_User IN ({0})"
                                            + " {1}"
                                            + " {2}"
                                            + " and (Clock_RecState in ({3}))";

        #endregion

        #region SelectRequest
        private readonly string cmdSelectReq2 = "SELECT top 100 Id_PK, Clock_User"
                                                      + " ,Clock_Date"
                                                      + " ,Clock_AgreeDate"
                                                      + " ,Clock_Time"
                                                      + " ,Clock_eTime"
                                                      + " ,Clock_RdrCode"
                                                      + " ,Clock_Chg"
                                                      + " ,Clock_RecState"
                                                      + " ,Clock_FirstlyAgree"
                                                      + " ,Clock_SeconderyAgree"
                                                      + " ,Clock_FirstlyAgree_BarCode"
                                                      + " ,dbo.person_name(substring(Clock_FirstlyAgree_barcode,1,8)) FirstlyAgree_name"
                                                      + " ,dbo.person_name(substring(Clock_FirstlyAgree_barcode,9,8)) SeconderyAgree_name"
                                                      + " ,dbo.person_name(substring(Clock_FirstlyAgree_barcode,17,8)) FinallyAgree_name"
                                                      + " ,Clock_FinallyAgree"
                                            + " FROM NW_Requests"
                                            + " WHERE Id_PK IN ({0})";
        #endregion

        #region UpdateRequest
        private readonly string cmdUpdateReq = "UPDATE NW_Requests"
                                             + " SET Clock_FirstlyAgree = {0},"
                                             + " Clock_SeconderyAgree = {1},"
                                                + " Clock_FinallyAgree = {2},"
                                                + " Clock_AgreeDate =Clock_AgreeDate + '{3}',"
                                                + " Clock_FirstlyAgree_barcode =  Clock_FirstlyAgree_barcode + '{4}'"
                                             + " WHERE Id_PK IN ({5})";
        
        #endregion

        #region SelectT
        private readonly string cmdSelectT = "SELECT Clock_BarCode,"
                                              + " clock_date,"
                                              + " clock_time,"
                                              + " clock_etime,"
                                              + " clock_RecState"
                                          + " FROM T{0}"
                                          + " WHERE Clock_BarCode = '{1}'"
                                                + " AND clock_date = '{2}'"
                                                + " AND clock_time = {3}"
                                                + " AND clock_etime = {4}"
                                                + " AND clock_RecState = {5}";
        #endregion

        #region InsertC

        private readonly string cmdInsertC = "INSERT INTO C{0} ([Clock_BarCode]"
                                                          + " ,[Clock_BDate]"
                                                          + " ,[Clock_BTime]"
                                                          + " ,[Clock_BRdrCode]"
                                                          + " ,[Clock_BRecState]"
                                                          + " ,[Clock_Date]"
                                                          + " ,[Clock_Time]"
                                                          + " ,[Clock_RdrCode]"
                                                          + " ,[Clock_RecState]"
                                                          + " ,[Clock_Chg]"
                                                          + " ,[Clock_User])"
                                         + " VALUES('{1}', '{2}', {3}, {4}, {5}, '{6}', {7}, {8}, {9}, {10}, '{11}')";
        #endregion

        #region InsertT

        private readonly string cmdInsertT = "INSERT INTO T{0} ([clock_barcode]"
                                                          + " ,[clock_date]"
                                                          + " ,[clock_time]"
                                                          + " ,[clock_etime]"
                                                          + " ,[clock_RecState]"
                                                          + " ,[clock_User]"
                                                          + " ,[Clock_Remark])"
                                         + " VALUES('{1}', '{2}', {3}, {4}, {5}, '{6}', '{7}')";
        #endregion

        #region UpdateT

        private readonly string cmdUpdateT = "UPDATE T{0}"
                                        + " SET [clock_barcode] = {1}"
                                        + " ,[clock_date] = {2}"
                                        + " ,[clock_time] = {3}"
                                        + " ,[clock_etime] = {4}"
                                        + " ,[clock_RecState] = {5}"
                                        + " ,[clock_User] = {6}"
                                        + " ,[Clock_Remark]) = {7}"
                                        + " WHERE clock_barcode = '{1}'"
                                            + " AND clock_date = '{2}',"
                                            + " AND clock_time = {3},"
                                            + " AND clock_etime = {4},"
                                            + " AND clock_RecState = {5}";

        #endregion

        #endregion

        public bool InsertRequestPerson(string Clock_Date, string Clock_SendDate, string Clock_AgreeDate, int Clock_Time, int Clock_eTime, int Clock_RdrCode, int Clock_Chg
                                                  , int Clock_RecState, string Clock_User, string Clock_RecDes, int Clock_FirstlyAgree, int Clock_SeconderyAgree, string Clock_FirstlyAgree_BarCode
                                                  , int Clock_FinallyAgree, string webPassId,int timeValue)
        {

            try
            {
                


                string commandText = @"insert into  NW_Requests 
                                                   (Clock_Date
                                                  ,Clock_SendDate
                                                  ,Clock_AgreeDate
                                                  ,Clock_Time
                                                  ,Clock_eTime
                                                  ,Clock_RdrCode
                                                  ,Clock_Chg
                                                  ,Clock_RecState
                                                  ,Clock_User
                                                  ,Clock_RecDes
                                                  ,Clock_FirstlyAgree
                                                  ,Clock_SeconderyAgree
                                                  ,Clock_FirstlyAgree_BarCode
                                                  ,Clock_FinallyAgree
                                                  ,WebPassId
                                                  ,timeValue)
                                            values( 
                                                  @Clock_Date
                                                  ,@Clock_SendDate
                                                  ,@Clock_AgreeDate
                                                  ,@Clock_Time
                                                  ,@Clock_eTime
                                                  ,@Clock_RdrCode
                                                  ,@Clock_Chg
                                                  ,@Clock_RecState
                                                  ,@Clock_User
                                                  ,@Clock_RecDes
                                                  ,@Clock_FirstlyAgree
                                                  ,@Clock_SeconderyAgree
                                                  ,@Clock_FirstlyAgree_BarCode
                                                  ,@Clock_FinallyAgree
                                                  ,@WebPassId
                                                  ,@timeValue)";

                SqlParameter[] paramArray = new SqlParameter[16];

                SqlParameter Clock_DateParam = new SqlParameter("@Clock_Date", Clock_Date);
                SqlParameter Clock_SendDateParam = new SqlParameter("@Clock_SendDate", Clock_SendDate);
                SqlParameter Clock_AgreeDateParam = new SqlParameter("@Clock_AgreeDate", Clock_AgreeDate);
                SqlParameter Clock_TimeParam = new SqlParameter("@Clock_Time", Clock_Time);
                SqlParameter Clock_eTimefrmParam = new SqlParameter("@Clock_eTime", Clock_eTime);
                SqlParameter Clock_RdrCodeParam = new SqlParameter("@Clock_RdrCode", Clock_RdrCode);
                SqlParameter Clock_ChgParam = new SqlParameter("@Clock_Chg", Clock_Chg);
                SqlParameter Clock_RecStateParam = new SqlParameter("@Clock_RecState", Clock_RecState);
                SqlParameter Clock_UserParam = new SqlParameter("@Clock_User", Clock_User);
                SqlParameter Clock_RecDesParam = new SqlParameter("@Clock_RecDes", Clock_RecDes);
                SqlParameter Clock_FirstlyAgreeParam = new SqlParameter("@Clock_FirstlyAgree", Clock_FirstlyAgree);
                SqlParameter Clock_SeconderyAgreeParam = new SqlParameter("@Clock_SeconderyAgree", Clock_SeconderyAgree);
                SqlParameter Clock_FirstlyAgree_BarCodeParam = new SqlParameter("@Clock_FirstlyAgree_BarCode", Clock_FirstlyAgree_BarCode);
                SqlParameter Clock_FinallyAgreeParam = new SqlParameter("@Clock_FinallyAgree", Clock_FinallyAgree);
                SqlParameter WebPassIdParam = new SqlParameter("@WebPassId", webPassId);
                SqlParameter timeValueParam = new SqlParameter("@timeValue", timeValue);
                paramArray[0] = Clock_DateParam;
                paramArray[1] = Clock_SendDateParam;
                paramArray[2] = Clock_AgreeDateParam;
                paramArray[3] = Clock_TimeParam;
                paramArray[4] = Clock_eTimefrmParam;
                paramArray[5] = Clock_RdrCodeParam;
                paramArray[6] = Clock_ChgParam;
                paramArray[7] = Clock_RecStateParam;
                paramArray[8] = Clock_UserParam;
                paramArray[9] = Clock_RecDesParam;
                paramArray[10] = Clock_FirstlyAgreeParam;
                paramArray[11] = Clock_SeconderyAgreeParam;
                paramArray[12] = Clock_FirstlyAgree_BarCodeParam;
                paramArray[13] = Clock_FinallyAgreeParam;
                paramArray[14] = WebPassIdParam;
                paramArray[15] = timeValueParam;



                bool ResultQuery = Connection.executeInsertQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Insert";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = Clock_User;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.UserWebPassID =Convert.ToDecimal(webPassId);
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ثبت درخواست پرسنل {0}، متن پیغام {1}.خطا", Clock_User, Utility.Utility.GetExecptionMessage(ex));
                
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در ثبت درخواست پرسنل " + Clock_User);
            }
        }
        
        public DataTable GetPersonRequstSQL(Person prs,Person prsCurrentUser, bool UnderReview, bool Confirmed, bool Rejected, string FromDate, string ToDate, decimal postID,string selectedPersonBarcode,string selectedPishcard)
        {
            try
            {
                string cmdSelectedPersons = string.Empty;
                if (selectedPersonBarcode == "All")
                    cmdSelectedPersons = "SELECT (Sub_BarCode) as barcode FROM NW_ManagerPersons('" + postID + "') where sub_barcode not in ("+ prs.Barcode +")  union select (p_barcode) as barcode from NW_webpass where (id='" + postID + "') and (isAcceptOwner='True')";
                else
                    cmdSelectedPersons = selectedPersonBarcode;

                string cmdSelectedPishcard=string.Empty;
                if (selectedPishcard == "All")
                    cmdSelectedPishcard = GetPishcardAllowed(postID);
                else
                    cmdSelectedPishcard = selectedPishcard;
                string cmd = string.Format(cmdSelectReq1,
                                     cmdSelectedPersons,
                                     GetPersonStatusFilter(prs, prsCurrentUser, UnderReview, Confirmed, Rejected),
                                     GetRequestDateFilter(FromDate, ToDate),
                                     cmdSelectedPishcard);
                DataTable dtResult= base.Connection.executeSelectQuery(cmd, new SqlParameter[0]);
                if (dtResult == null)
                    throw new MyExceptionHandler("خطا در دریافت درخواست های پرسنل تحت مدیریت   " + postID);
                    return dtResult;
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
                LogObj.UserWebPassID = postID;
                LogObj.p_barcode = selectedPersonBarcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت درخواست های پرسنل تحت مدیریت {0}، متن پیغام {1}.خطا", postID, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت درخواست های پرسنل تحت مدیریت   " + postID);
                
            }
        }
        public string GetPishcardAllowed(decimal postID)
        {
            try
            {
                string result = "";
                return result = "SELECT PishCard_No FROM NW_agree where WebPassId='" + postID + "'";
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در دریافت پیش کارت های مجاز {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پیش کارت های مجاز  ");
            }
        }
        public void UpdateRequest(string RequestIds, short FirstlyAgree, short SeconderyAgree, short FinallyAgree, string AgreeDate, string Agree_barcode)
        {
            if (RequestIds.Length == 0)
                return;
            string Cmd = String.Format(cmdUpdateReq, FirstlyAgree, SeconderyAgree, FinallyAgree, AgreeDate, Agree_barcode, RequestIds);
            try
            {
               bool result= base.Connection.executeUpdateQuery(Cmd, new SqlParameter[0]);
                if(result==false)
                    throw new MyExceptionHandler("خطا در ویراش درخواست با ID= " + RequestIds);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ویراش درخواست با {0}، متن پیغام {1}.خطا", RequestIds, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویراش درخواست با ID= " + RequestIds);
            }

        }

        public IList<Request> GetRequest(string RequestIds)
        {
            IList<Request> Result = new List<Request>();
            if (string.IsNullOrEmpty(RequestIds))
                return Result;

            string Cmd = String.Format(cmdSelectReq2, RequestIds);
            try
            {
                DataRowCollection DataRowColl = base.Connection.executeSelectQuery(Cmd, new SqlParameter[0]).Rows;
                if (DataRowColl == null)
                    throw new MyExceptionHandler("خطا در دریافت درخواست  ها با ID= " + RequestIds);
                foreach (DataRow dr in DataRowColl)
                {
                    Result.Add(new Request()
                    {
                        ID = (decimal)dr["Id_PK"],
                        user = new WebpassUserProxy() { Barcode = (string)dr["Clock_User"] },
                        Date = (string)dr["Clock_Date"],
                        RecState = (short)dr["Clock_RecState"],
                        Time = (short)dr["Clock_Time"],
                        eTime = (short)dr["Clock_eTime"],
                        FirstlyAgree = (short)dr["Clock_FirstlyAgree"],
                        SeconderyAgree = (short)dr["Clock_SeconderyAgree"],
                        FinalyAgree = (short)dr["Clock_FinallyAgree"],
                        AgreeBarcode = (string)dr["Clock_FirstlyAgree_BarCode"],
                        AgreeDate = (string)dr["Clock_AgreeDate"]
                    });
                }

                return Result;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت درخواست  ها با {0}، متن پیغام {1}.خطا", RequestIds, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت درخواست  ها با ID= " + RequestIds);
            }
        }

        private string GetPersonStatusFilter(Person prs,Person prsCurrentUser, bool UnderReview, bool Confirmed, bool Rejected)
        {
            try
            {
                string Result = "";
                #region UnderReview
                if (UnderReview)
                {
                    PersonStatus PS = (PersonStatus)Enum.Parse(typeof(PersonStatus), prs.Status.ToString());
                    Result = "AND ((";
                    switch (PS)
                    {
                        case PersonStatus.EarlyManagment:
                            Result += "Clock_FirstlyAgree = 0 AND Clock_SeconderyAgree=0 AND Clock_FinallyAgree = 0)";
                            break;
                        case PersonStatus.SecondManagment:
                            Result += "Clock_FirstlyAgree = 1 AND Clock_SeconderyAgree=0 AND Clock_FinallyAgree = 0)";
                            break;
                        case PersonStatus.FinalManagment:
                            Result += "Clock_FirstlyAgree = 1 AND Clock_SeconderyAgree=1 AND Clock_FinallyAgree = 0)";
                            break;

                        case PersonStatus.TAManagment:
                            Result += "Clock_FinallyAgree = 0)";
                            break;

                        case PersonStatus.Operator:
                        case PersonStatus.Reporter:
                        case PersonStatus.unKnown:
                        case PersonStatus.User:
                        default:
                            Result += "1 = 2)";
                            break;
                    }
                }
                #endregion
                #region Confirmed
                if (Confirmed)
                {
                    PersonStatus PS = (PersonStatus)Enum.Parse(typeof(PersonStatus), prs.Status.ToString());
                    if (UnderReview)
                        Result += " OR(";
                    else
                        Result = "AND ((";
                    switch (PS)
                    {
                        case PersonStatus.EarlyManagment:
                            Result += "Clock_FirstlyAgree = 1 )";
                            break;
                        case PersonStatus.SecondManagment:
                            Result += "Clock_SeconderyAgree = 1 )";
                            break;
                        case PersonStatus.FinalManagment:
                            Result += "Clock_FinallyAgree = 1 )";
                            break;

                        case PersonStatus.TAManagment:
                            Result += "Clock_FirstlyAgree = 1 AND Clock_SeconderyAgree = 1 AND  Clock_FinallyAgree = 1)";
                            break;
                        case PersonStatus.Operator:
                        case PersonStatus.Reporter:
                        case PersonStatus.unKnown:
                        case PersonStatus.User:
                        default:
                            Result += "1 = 2)";
                            break;
                    }


                }
                #endregion
                #region Rejected
                if (Rejected)
                {
                    PersonStatus PS = (PersonStatus)Enum.Parse(typeof(PersonStatus), prs.Status.ToString());
                    if (UnderReview || Confirmed)
                        Result += " OR(";
                    else
                        Result = "AND ((";
                    switch (PS)
                    {
                        case PersonStatus.EarlyManagment:
                            Result += "Clock_FirstlyAgree = 2 )";
                            break;
                        case PersonStatus.SecondManagment:
                            Result += "Clock_SeconderyAgree = 2 )";
                            break;
                        case PersonStatus.FinalManagment:
                            Result += "Clock_FinallyAgree = 2 )";
                            break;

                        case PersonStatus.TAManagment:
                            Result += "Clock_FirstlyAgree = 1 AND Clock_FinallyAgree = 2 )";
                            break;
                        case PersonStatus.Operator:
                        case PersonStatus.Reporter:
                        case PersonStatus.unKnown:
                        case PersonStatus.User:
                        default:
                            Result += "1 = 2)";
                            break;
                    }

                }
                #endregion
                Result += Result.Length > 0 ? ")" : "";
                return Result;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در دریافت فیلتر وضعیت شخص {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت فیلتر وضعیت شخص  ");
            }
        }

        private string GetRequestDateFilter(string FromDate, string ToDate)
        {
            try
            {
                if (!string.IsNullOrEmpty(FromDate) && string.IsNullOrEmpty(ToDate))
                    return string.Format(" AND Clock_Date >= '{0}'", FromDate);
                if (string.IsNullOrEmpty(FromDate) && !string.IsNullOrEmpty(ToDate))
                    return string.Format(" AND Clock_Date <= '{0}'", ToDate);
                if (!string.IsNullOrEmpty(FromDate) && !string.IsNullOrEmpty(ToDate))
                    return string.Format(" AND Clock_Date BETWEEN '{0}' AND '{1}'", FromDate, ToDate);
                return "";
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در دریافت فیلتر درخواست ها {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت فیلتر درخواست ها  ");
            }
        }

        internal void InsertToC(Person prs, TerminalRec ClkRec, Request req)
        {
            try
            {

            if (string.IsNullOrEmpty(ClkRec.rdrCardCode) || string.IsNullOrEmpty(ClkRec.rdrDate))
                throw new NotImplementedException();

            string Cmd = String.Format(cmdInsertC, ClkRec.rdrDate.Split('/')[0] + ClkRec.rdrDate.Split('/')[1],
                                                    ClkRec.rdrCardCode,
                                                    ClkRec.rdrBDate,
                                                    ClkRec.rdrBTime,
                                                    ClkRec.rdrBRdrCode,
                                                    ClkRec.rdrBStatus,
                                                    ClkRec.rdrDate,
                                                    ClkRec.rdrTime,
                                                    ClkRec.rdrCode,
                                                    ClkRec.rdrStatus,
                                                    ClkRec.rdrChng,
                                                    ClkRec.rdrUser);
            if (!CheckIsCompleteWorkFlowRequest(req.ID))
            {
                string Cmd2 = String.Format(cmdUpdateReq, req.FirstlyAgree,
                                                          req.SeconderyAgree,
                                                          req.FinalyAgree,
                                                          req.AgreeDate,
                                                          req.AgreeBarcode,
                                                          req.ID);
                base.Connection.executeNonQueryWithTransaction(Cmd, Cmd2);
            }
            else
            {
                base.Connection.executeNonQueryWithTransaction(Cmd);
            }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در انجام ترانزاکشن درخواست ها {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در انجام ترانزاکشن درخواست ها");
            }
           
        }
        public DataTable GetRequestByBarcodeDate(string barcode,string date)
        {
            try
            {
                DataTable dtResult = new DataTable();
                string commandText = @"select * from nw_requests where (Clock_User=@barcode) and (Clock_Date=@date)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@date", date);

                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;


                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت درخواست  های پرسنل  " + barcode);
                }
                return dtResult;


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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در واکشی درخواست های پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت درخواست  های پرسنل  " + barcode);
            }
        }
        private bool CheckIsCompleteWorkFlowRequest(decimal id)
        {
            try
            {
                DataTable dtResult = new DataTable();
                string commandText = @"select * from nw_requests where (id_pk=@id)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id", id);
                
                paramArray[0] = idParam;
                

                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت جریان کامل درخواست.");
                }
                if (dtResult.Rows[0]["Clock_FirstlyAgree_BarCode"].ToString().Length==24)
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
                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت جریان کامل درخواست با {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت جریان کامل درخواست با ID=" + id);
            }
        }
        internal bool HasTRow(string Barcode, string Date, short Time, short eTime, short RecState)
        {
            if (string.IsNullOrEmpty(Barcode) || string.IsNullOrEmpty(Date))
                throw new NotImplementedException();

            string Cmd = String.Format(cmdSelectT, Date.Split('/')[0] + Date.Split('/')[1],
                                                Barcode,
                                                Date,
                                                Time,
                                                eTime,
                                                RecState);
            try
            {

                bool result = base.Connection.executeSelectQuery(Cmd, new SqlParameter[0]).Rows.Count > 0;
                return result;
               
            }
                catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت مجوز پرسنل {0}، متن پیغام {1}.خطا", Barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت مجوز پرسنل  " + Barcode);
            }
        }

        internal void InsertToT(Person prs, TerminalRec ClkRec, Request req)
        {
            if (string.IsNullOrEmpty(ClkRec.rdrCardCode) || string.IsNullOrEmpty(ClkRec.rdrDate))
                throw new NotImplementedException();
            try
            {

            
            string Cmd = String.Format(cmdInsertT, ClkRec.rdrDate.Split('/')[0] + ClkRec.rdrDate.Split('/')[1],
                                                ClkRec.rdrCardCode,
                                                ClkRec.rdrDate,
                                                ClkRec.rdrTime,
                                                ClkRec.rdreTime,
                                                ClkRec.rdrStatus,
                                                ClkRec.rdrUser,
                                                "");

            string Cmd2 = String.Format(cmdUpdateReq, req.FirstlyAgree,
                                                      req.SeconderyAgree,
                                                      req.FinalyAgree,
                                                      req.AgreeDate,
                                                      req.AgreeBarcode,
                                                      req.ID);

            bool result= base.Connection.executeNonQueryWithTransaction(Cmd, Cmd2);
                if(result==false)
                    throw new MyExceptionHandler("خطا در انجام ترانزاکشن درخواست ها   " + ClkRec.rdrUser);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در انجام ترانزاکشن درخواست ها {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در انجام ترانزاکشن درخواست ها   " + ClkRec.rdrUser);
            }
        }

        internal void UpdateT(Person prs, TerminalRec ClkRec, Request req)
        {
            if (string.IsNullOrEmpty(ClkRec.rdrCardCode) || string.IsNullOrEmpty(ClkRec.rdrDate))
                throw new NotImplementedException();
            try
            {

           
            string Cmd = String.Format(cmdUpdateT, ClkRec.rdrDate.Split('/')[0] + ClkRec.rdrDate.Split('/')[1],
                                                    ClkRec.rdrCardCode,
                                                    ClkRec.rdrDate,
                                                    ClkRec.rdrTime,
                                                    ClkRec.rdreTime,
                                                    ClkRec.rdrStatus,
                                                    ClkRec.rdrUser,
                                                    "");
            string Cmd2 = String.Format(cmdUpdateReq, req.FirstlyAgree,
                                                      req.SeconderyAgree,
                                                      req.FinalyAgree,
                                                      req.AgreeDate,
                                                      req.AgreeBarcode,
                                                      req.ID);

            bool result= base.Connection.executeNonQueryWithTransaction(Cmd, Cmd2);
             
                    if (result == false)
                        throw new MyExceptionHandler("خطا در انجام ترانزاکشن ویرایش درخواست ها   " + ClkRec.rdrUser);
            }
            catch (MyExceptionHandler ex)
            {

                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در انجام ترانزاکشن ویرایش درخواست ها {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در انجام ترانزاکشن ویرایش درخواست ها   " + ClkRec.rdrUser);
            }
        }
        public DataTable GetPersonnelTrafficDailyByDate(string barcode,string tableName)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select (Clock_BarCode) Barcode,(Clock_Date) as Dates,isnull(R_Name,'') as Station,Clock_time as Times,(Clock_RecState) as PishID,(Clock_RdrCode) as Reader,
                                    case
                                    when Clock_Chg=0 then ''
                                    when Clock_Chg=1 then 'دستی'
                                    end as  Change,
                                    (Clock_RecState) as PishID,Clock_User as Operator,
                                    case
                                    when Pish_LastName='' then Pish_Name 
                                    when Pish_LastName !='' then Pish_LastName
                                    end as PishName from " + tableName + @" join pishcard 
                                    on Clock_RecState=Pish_Code and 
                                    isDaily='True' and Pish_InitCode=(select p_param from persons where P_BarCode=@barcode)
                                    
                                    left outer join readers on Clock_RdrCode=R_Code
                                    where Clock_BarCode=@barcode order by Clock_Date";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                
                paramArray[0] = barcodeParam;
                
                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت مجوز های روزانه پرسنل" + barcode);
                }
                dtResult.Columns.Add("Day");
                dtResult.Columns.Add("ID");
                int count=0;
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                   string ShamsiDay= Utility.PersianDateTime.GetPershianDayName(Utility.PersianDateTime.Shamsi2Miladi(dtResult.Rows[i]["Dates"].ToString()));
                   dtResult.Rows[i]["Day"] = ShamsiDay;
                   dtResult.Rows[i]["ID"] = count;
                   count++;
                }
               return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت مجوز های روزانه پرسنل {0}، متن پیغام {1}.خطا",barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مجوز های روزانه پرسنل" + barcode);
               
            }
        }
        public DataTable GetPersonnelTrafficHourlyPermitByDate(string barcode, string tableName)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select (clock_barcode) as Barcode, (clock_date) as Dates,isnull(clock_time,0) as clock_time,isnull(clock_etime,0) as clock_etime,
                                       (Clock_RecState) as PishID,clock_User as Operator,
                                        case
                                        when Pish_LastName='' then Pish_Name 
                                        when Pish_LastName !='' then Pish_LastName
                                        end as PishName from " + tableName + @" join pishcard 
                                        on clock_RecState=Pish_Code  
                                        and isDaily = 'false' and isPermit='True' and Pish_InitCode=(select p_param from persons where P_BarCode=@barcode)
                                        where clock_barcode=@barcode order by Clock_Date";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);

                paramArray[0] = barcodeParam;

                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت مجوز های ساعتی پرسنل" + barcode);
                }
                
                dtResult.Columns.Add("Day");
                dtResult.Columns.Add("ID");
                dtResult.Columns.Add("FromTime");
                dtResult.Columns.Add("ToTime");
                int count = 0;
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    string ShamsiDay = Utility.PersianDateTime.GetPershianDayName(Utility.PersianDateTime.Shamsi2Miladi(dtResult.Rows[i]["Dates"].ToString()));
                    dtResult.Rows[i]["Day"] = ShamsiDay;
                    dtResult.Rows[i]["FromTime"] = Utility.PersianDateTime.IntTimeToRealTime(Convert.ToInt32(dtResult.Rows[i]["clock_time"]));
                    dtResult.Rows[i]["ToTime"] = Utility.PersianDateTime.IntTimeToRealTime(Convert.ToInt32(dtResult.Rows[i]["clock_etime"]));
                    dtResult.Rows[i]["ID"] = count;
                    count++;
                    
                }
                return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت مجوز های ساعتی پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت مجوز های ساعتی پرسنل" + barcode);
            }
        }
        public DataTable GetPersonnelTrafficHourlyTrafficByDate(string barcode, string tableName)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select (clock_barcode) as Barcode, (clock_date) as Dates,isnull(R_Name,'') as Station,isnull(Clock_Time,0) as Clock_Time,(Clock_RdrCode) as Reader,
                                     case
                                    when Clock_Chg=0 then ''
                                    when Clock_Chg=1 then 'دستی'
                                    end as  Change,                                       
                                        (Clock_RecState) as PishID,clock_User as Operator,
                                        case
                                        when Pish_LastName='' then Pish_Name 
                                        when Pish_LastName !='' then Pish_LastName
                                        end as PishName from " + tableName + @" join pishcard 
                                        on clock_RecState=Pish_Code  
                                        and isDaily = 'false' and isPermit='False' and Pish_InitCode=(select p_param from persons where P_BarCode=@barcode)
                                        left join readers on Clock_RdrCode=R_Code
                                        where clock_barcode=@barcode order by Clock_Date";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);

                paramArray[0] = barcodeParam;

                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت تردد های ساعتی پرسنل" + barcode);
                }

                dtResult.Columns.Add("Day");
                dtResult.Columns.Add("ID");
                dtResult.Columns.Add("Times");
                
                int count = 0;
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    string ShamsiDay = Utility.PersianDateTime.GetPershianDayName(Utility.PersianDateTime.Shamsi2Miladi(dtResult.Rows[i]["Dates"].ToString()));
                    dtResult.Rows[i]["Day"] = ShamsiDay;
                    dtResult.Rows[i]["Times"] = Utility.PersianDateTime.IntTimeToRealTime(Convert.ToInt32(dtResult.Rows[i]["Clock_Time"]));
                    
                    dtResult.Rows[i]["ID"] = count;
                    count++;

                }
                return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت مجوز های ساعتی پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت تردد های ساعتی پرسنل" + barcode);
            }
        }
        
        
        
        
        public DataTable GetAllTerminal()
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select R_Code,R_Name from readers order by R_Name";
                SqlParameter[] paramArray = new SqlParameter[0];
                

                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت همه ترمینال ها");
                }
                return dtResult;
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت همه ترمینال ها  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت همه ترمینال ها");
            }
        }
        
        public DataTable GetTrafficPersonnelBySelectedDate(string barcode,string Date,string tableName)
        {
            try
            {
                
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = @"select (Clock_Date) as Dates,dbo.MToH(Clock_Time) as Times,
                                        case
                                        when Pish_LastName='' then Pish_Name
                                        when Pish_LastName!='' then Pish_LastName
                                        end as PishName from " + tableName + @" left outer join pishcard 
                                       on Clock_RecState=Pish_Code  and Pish_activeWeb='True' and isDaily='True'
                                        where Clock_Date=@date and Clock_BarCode=@barcode";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter barcodeParam = new SqlParameter("@barcode",barcode);
                SqlParameter dateParam = new SqlParameter("@date", Date);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت مجوز های روزانه");
                }
                return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت  پیش کارت های مجوز  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت مجوز های روزانه");
            }
        }
        public string InsertRequestDialyByOperator(string barcode,string pishID, string date, string comment, string barcodeOperator,int change,int Readers,int time,string tableName)
        {
           
            try
            {
               

                string commandText = @"insert into " + tableName + @" (Clock_BarCode, Clock_BDate ,Clock_BTime ,Clock_BRdrCode ,Clock_BRecState, Clock_Date ,Clock_Time ,Clock_RdrCode ,Clock_Chg ,Clock_RecState ,Clock_User) 
                                      values (@Clock_BarCode,@Clock_BDate,@Clock_BTime,@Clock_BRdrCode,@Clock_BRecState,@Clock_Date,@Clock_Time,@Clock_RdrCode,@Clock_Chg,@Clock_RecState,@Clock_User)";
                 SqlParameter[] paramArray = new SqlParameter[11];
                 SqlParameter barcodeParam = new SqlParameter("@Clock_BarCode", barcode);
                 SqlParameter BdateParam = new SqlParameter("@Clock_BDate", date);
                 SqlParameter BtimeParam = new SqlParameter("@Clock_BTime", time);
                 SqlParameter BreadersParam = new SqlParameter("@Clock_BRdrCode", Readers);
                 SqlParameter BpishIDParam = new SqlParameter("@Clock_BRecState", pishID);
                 SqlParameter dateParam = new SqlParameter("@Clock_Date", date);
                 SqlParameter timeParam = new SqlParameter("@Clock_Time", time);
                 SqlParameter readersParam = new SqlParameter("@Clock_RdrCode", Readers);
                 SqlParameter changeParam = new SqlParameter("@Clock_Chg", change);
                 SqlParameter pishIDParam = new SqlParameter("@Clock_RecState", pishID);
                 SqlParameter userParam = new SqlParameter("@Clock_User", barcodeOperator);

                 paramArray[0] = barcodeParam;
                 paramArray[1] = BdateParam;
                 paramArray[2] = BtimeParam;
                 paramArray[3] = BreadersParam;
                 paramArray[4] = BpishIDParam;
                 paramArray[5] = dateParam;
                 paramArray[6] = timeParam;
                 paramArray[7] = readersParam;
                 paramArray[8] = changeParam;
                 paramArray[9] = pishIDParam;
                 paramArray[10] = userParam;

                bool ResultQuery = Connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ثبت گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ثبت مجوز روزانه توسط اپراتور" + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "insert";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name ;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ثبت مجوز روزانه توسط اپراتور  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در ثبت مجوز روزانه توسط اپراتور" + barcode);
            }
        }
        public string InsertAgreeOverTime(string barcode, string pishID, string year, string month, string time)
        {

            try
            {
                string commandText = @"insert into addfree (Add_PCode, Add_Year ,Add_Month ,Add_Time ,Add_TimeOK) 
                                      values (@Add_PCode,@Add_Year,@Add_Month,@Add_Time,@Add_TimeOK)";
                SqlParameter[] paramArray = new SqlParameter[5];
                SqlParameter barcodeParam = new SqlParameter("@Add_PCode", barcode);
                SqlParameter yearParam = new SqlParameter("@Add_Year", year);
                SqlParameter monthParam = new SqlParameter("@Add_Month", month);
                SqlParameter timeParam = new SqlParameter("@Add_Time", time);
                SqlParameter timeOKParam = new SqlParameter("@Add_TimeOK", time);
                paramArray[0] = barcodeParam;
                paramArray[1] = yearParam;
                paramArray[2] = monthParam;
                paramArray[3] = timeParam;
                paramArray[4] = timeOKParam;
               

                bool ResultQuery = Connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ثبت گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ثبت اضافه کار" + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Insert";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ثبت اضافه کار  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در ثبت اضافه کار" + barcode);
            }
        }
        public string DeleteAgreeOverTime(string barcode, string pishID, string year, string month, string time)
        {

            try
            {


                string commandText = @"delete from addfree where Add_PCode=@Add_PCode and Add_Year=@Add_Year and Add_Month=@Add_Month
                                    and Add_Time=@Add_Time";
                SqlParameter[] paramArray = new SqlParameter[4];
                SqlParameter barcodeParam = new SqlParameter("@Add_PCode", barcode);
                SqlParameter yearParam = new SqlParameter("@Add_Year", year);
                SqlParameter monthParam = new SqlParameter("@Add_Month", month);
                SqlParameter timeParam = new SqlParameter("@Add_Time", time);
                
                paramArray[0] = barcodeParam;
                paramArray[1] = yearParam;
                paramArray[2] = monthParam;
                paramArray[3] = timeParam;
             


                bool ResultQuery = Connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت حذف گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در حذف اضافه کار" + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در حذف اضافه کار  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف اضافه کار" + barcode);
            }
        }
        public string EditRequestDialyByOperator(string barcode, string pishID, string date, string comment, string barcodeOperator, int change, string tableName,string oldPishID,string oldDate)
        {

            try
            {


                string commandText = @"update " + tableName + @" set Clock_Date=@Clock_Date ,Clock_Chg=@Clock_Chg ,Clock_RecState=@Clock_RecState ,Clock_User=@Clock_User 
                                      where (Clock_BarCode=@Clock_BarCode) and (Clock_Date=@oldDate) and (Clock_BRecState=@oldPishId)";
                SqlParameter[] paramArray = new SqlParameter[7];
                SqlParameter barcodeParam = new SqlParameter("@Clock_BarCode", barcode);
                SqlParameter oldDateParam = new SqlParameter("@oldDate", oldDate);
                SqlParameter oldPishIDParam = new SqlParameter("@oldPishId", oldPishID);
                SqlParameter dateParam = new SqlParameter("@Clock_Date", date);
                SqlParameter changeParam = new SqlParameter("@Clock_Chg", change);
                SqlParameter pishIDParam = new SqlParameter("@Clock_RecState", pishID);
                SqlParameter userParam = new SqlParameter("@Clock_User", barcodeOperator);

                paramArray[0] = barcodeParam;
                paramArray[1] = oldDateParam;
                paramArray[2] = oldPishIDParam;
                paramArray[3] = dateParam;
                paramArray[4] = changeParam;
                paramArray[5] = pishIDParam;
                paramArray[6] = userParam;

                bool ResultQuery = Connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ویرایش گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ویرایش مجوز روزانه توسط اپراتور" + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Update";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ویرایش مجوز روزانه توسط اپراتور  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در ویرایش مجوز روزانه توسط اپراتور " + barcode);
            }
        }
        public string DeleteRequestCartableFromTableC(string barcode, string pishID, string date, string time,string tableName)
        {

            try
            {
                string commandText = @"delete from " + tableName + @" where (Clock_BarCode=@barcode) and (Clock_Date=@date) and (Clock_Time=@time) 
                                        and  (Clock_RecState=@pishID)";
                SqlParameter[] paramArray = new SqlParameter[4];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@date", date);
                SqlParameter timeParam = new SqlParameter("@time", time);
                
                SqlParameter pishIDParam = new SqlParameter("@pishID", pishID);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                paramArray[2] = timeParam;
               
                paramArray[3] = pishIDParam;

                bool ResultQuery = Connection.executeDeleteQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت حذف گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در حذف مجوز پرسنل " + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در حذف مجوز پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف مجوز پرسنل " + barcode);
            }
        }
        public string DeleteRequestCartableFromTableT(string barcode, string pishID, string date, string fromTime, string toTime, string tableName)
        {

            try
            {
                string commandText = @"delete from " + tableName + @" where (Clock_BarCode=@barcode) and (Clock_Date=@date) and (clock_time=@fromTime) 
                                       and (clock_etime=@toTime) and (Clock_RecState=@pishID)";
                SqlParameter[] paramArray = new SqlParameter[5];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@date", date);
                SqlParameter fromTimeParam = new SqlParameter("@fromTime", fromTime);
                SqlParameter toTimeParam = new SqlParameter("@toTime", toTime);
                SqlParameter pishIDParam = new SqlParameter("@pishID", pishID);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                paramArray[2] = fromTimeParam;
                paramArray[3] = pishIDParam;
                paramArray[4] = toTimeParam;

                bool ResultQuery = Connection.executeDeleteQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت حذف گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در حذف مجوز پرسنل " + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در حذف مجوز پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف مجوز پرسنل " + barcode);
            }
        }
        public bool DeleteRequestDialyByOperator(string barcode, string pishID, string date, string time, string reader,string tableName)
        {

            try
            {
                string commandText = @"delete from " + tableName + @" where (Clock_BarCode=@barcode) and (Clock_Date=@date) and (Clock_Time=@time) 
                                        and (Clock_RdrCode=@reader) and (Clock_RecState=@pishID)";
                SqlParameter[] paramArray = new SqlParameter[5];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@date", date);
                SqlParameter timeParam = new SqlParameter("@time", time);
                SqlParameter readerParam = new SqlParameter("@reader", reader);
                SqlParameter pishIDParam = new SqlParameter("@pishID", pishID);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                paramArray[2] = timeParam;
                paramArray[3] = readerParam;
                paramArray[4] = pishIDParam;

                bool ResultQuery = Connection.executeDeleteQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در حذف مجوز پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف مجوز پرسنل " + barcode);
            }
        }
        public bool DeleteRequestHourlyTrafficByOperator(string barcode, string pishID, string date, string time, string reader, string tableName)
        {

            try
            {
                string commandText = @"delete from " + tableName + @" where (Clock_BarCode=@barcode) and (Clock_Date=@date) and (Clock_Time=@time) 
                                        and (Clock_RdrCode=@reader) and (Clock_RecState=@pishID)";
                SqlParameter[] paramArray = new SqlParameter[5];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@date", date);
                SqlParameter timeParam = new SqlParameter("@time", time);
                SqlParameter readerParam = new SqlParameter("@reader", reader);
                SqlParameter pishIDParam = new SqlParameter("@pishID", pishID);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                paramArray[2] = timeParam;
                paramArray[3] = readerParam;
                paramArray[4] = pishIDParam;

                bool ResultQuery = Connection.executeDeleteQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در حذف مجوز پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف مجوز پرسنل " + barcode);
            }
        }
        public string InsertRequestHourlyPermitByOperator(string barcode, string pishID, string date, string comment, string Operator, int change, int Readers, int fromHour,int toHour, string tableName)
        {

            try
            {
                string commandText = @"insert into " + tableName + @" (clock_barcode, clock_date ,clock_time ,clock_etime ,clock_RecState, clock_Remark ,clock_User) 
                                      values (@clock_barcode,@clock_date,@clock_time,@clock_etime,@clock_RecState,@clock_Remark,@clock_User)";
                SqlParameter[] paramArray = new SqlParameter[7];
                SqlParameter barcodeParam = new SqlParameter("@clock_barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@clock_date", date);
                SqlParameter sTimeParam = new SqlParameter("@clock_time", fromHour);
                SqlParameter eTimeParam = new SqlParameter("@clock_etime", toHour);
                SqlParameter PishIDParam = new SqlParameter("@clock_RecState", pishID);
                SqlParameter OperatorParam = new SqlParameter("@clock_User", Operator);
                SqlParameter RemarkParam = new SqlParameter("@clock_Remark", comment);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                paramArray[2] = sTimeParam;
                paramArray[3] = eTimeParam;
                paramArray[4] = PishIDParam;
                paramArray[5] = OperatorParam;
                paramArray[6] = RemarkParam;
                

                bool ResultQuery = Connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ثبت گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ثبت مجوز ساعتی پرسنل " + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "insert";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ثبت مجوز ساعتی پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در ثبت مجوز ساعتی پرسنل " + barcode);
            }
        }
        public bool EditRequestHourlyPermitByOperator(string barcode, string pishID, string date, string comment, string Operator, int change, int Readers, int fromHour, int toHour, string tableName,string oldPishID,int oldFromTime,int oldToTime,string oldDate)
        {

            try
            {
                string commandText = @"update " + tableName + @" Set clock_date=@clock_date ,clock_time=@clock_time ,clock_etime=@clock_etime ,clock_RecState=@clock_RecState, clock_Remark=@clock_Remark ,clock_User=@clock_User where (clock_barcode=@clock_barcode) and (clock_RecState=@oldclock_RecState) and (clock_time=@oldclock_time) and (clock_etime=@oldclock_etime) and (clock_date=@oldclock_date)";
                SqlParameter[] paramArray = new SqlParameter[11];
                SqlParameter barcodeParam = new SqlParameter("@clock_barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@clock_date", date);
                SqlParameter sTimeParam = new SqlParameter("@clock_time", fromHour);
                SqlParameter eTimeParam = new SqlParameter("@clock_etime", toHour);
                SqlParameter PishIDParam = new SqlParameter("@clock_RecState", pishID);
                SqlParameter OperatorParam = new SqlParameter("@clock_User", Operator);
                SqlParameter RemarkParam = new SqlParameter("@clock_Remark", comment);
                SqlParameter oldPishIdParam = new SqlParameter("@oldclock_RecState", oldPishID);
                SqlParameter oldFromTimeParam = new SqlParameter("@oldclock_time", oldFromTime);
                SqlParameter oldToTimeParam = new SqlParameter("@oldclock_etime", oldToTime);
                SqlParameter oldDateParam = new SqlParameter("@oldclock_date", oldDate);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                paramArray[2] = sTimeParam;
                paramArray[3] = eTimeParam;
                paramArray[4] = PishIDParam;
                paramArray[5] = OperatorParam;
                paramArray[6] = RemarkParam;
                paramArray[7] = oldPishIdParam;
                paramArray[8] = oldFromTimeParam;
                paramArray[9] =oldToTimeParam;
                paramArray[10] = oldDateParam;


                bool ResultQuery = Connection.executeUpdateQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Update";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ویرایش مجوز ساعتی پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در ویرایش مجوز ساعتی پرسنل " + barcode);
            }
        }
        public string InsertRequestHourlyTrafficByOperator(string barcode, string pishID, string date, string comment, string Operator, int change, int Readers, int time, string tableName)
        {

            try
            {
                string commandText = @"insert into " + tableName + @" (Clock_BarCode, Clock_BDate ,Clock_BTime ,Clock_BRdrCode ,Clock_BRecState, Clock_Date ,Clock_Time ,Clock_RdrCode ,Clock_Chg ,Clock_RecState ,Clock_User) 
                                      values (@Clock_BarCode,@Clock_BDate,@Clock_BTime,@Clock_BRdrCode,@Clock_BRecState,@Clock_Date,@Clock_Time,@Clock_RdrCode,@Clock_Chg,@Clock_RecState,@Clock_User)";
                SqlParameter[] paramArray = new SqlParameter[11];
                SqlParameter barcodeParam = new SqlParameter("@Clock_BarCode", barcode);
                SqlParameter BdateParam = new SqlParameter("@Clock_BDate", date);
                SqlParameter BtimeParam = new SqlParameter("@Clock_BTime", time);
                SqlParameter BreadersParam = new SqlParameter("@Clock_BRdrCode", Readers);
                SqlParameter BpishIDParam = new SqlParameter("@Clock_BRecState", pishID);
                SqlParameter dateParam = new SqlParameter("@Clock_Date", date);
                SqlParameter timeParam = new SqlParameter("@Clock_Time", time);
                SqlParameter readersParam = new SqlParameter("@Clock_RdrCode", Readers);
                SqlParameter changeParam = new SqlParameter("@Clock_Chg", change);
                SqlParameter pishIDParam = new SqlParameter("@Clock_RecState", pishID);
                SqlParameter userParam = new SqlParameter("@Clock_User", Operator);

                paramArray[0] = barcodeParam;
                paramArray[1] = BdateParam;
                paramArray[2] = BtimeParam;
                paramArray[3] = BreadersParam;
                paramArray[4] = BpishIDParam;
                paramArray[5] = dateParam;
                paramArray[6] = timeParam;
                paramArray[7] = readersParam;
                paramArray[8] = changeParam;
                paramArray[9] = pishIDParam;
                paramArray[10] = userParam;


                bool ResultQuery = Connection.executeInsertQuery(commandText, paramArray);
                if (ResultQuery == true)
                {
                    return "اطلاعات با موفقیت ثبت گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ثبت تردد  پرسنل " + barcode);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "insert";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ثبت تردد  پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در ثبت تردد  پرسنل " + barcode);
            }
        }
        public bool EditRequestHourlyTrafficByOperator(string barcode, string pishID, string date, string comment, string Operator, int change, int Readers, int time, string tableName, string oldPishID, int oldTimes, string oldDate)
        {

            try
            {
                string commandText = @"update " + tableName + @" set Clock_Date=@Clock_Date ,Clock_Time=@Clock_Time ,Clock_Chg=@Clock_Chg ,Clock_RecState=@Clock_RecState ,Clock_User=@Clock_User
                                     where  (Clock_BarCode=@Clock_BarCode) and (Clock_RecState=@oldPishID) and (Clock_Date=@oldDate) and (Clock_Time=@oldTime)";
                SqlParameter[] paramArray = new SqlParameter[10];
                SqlParameter barcodeParam = new SqlParameter("@Clock_BarCode", barcode);
                SqlParameter dateParam = new SqlParameter("@Clock_Date", date);
                SqlParameter timeParam = new SqlParameter("@Clock_Time", time);
                SqlParameter readersParam = new SqlParameter("@Clock_RdrCode", Readers);
                SqlParameter changeParam = new SqlParameter("@Clock_Chg", change);
                SqlParameter pishIDParam = new SqlParameter("@Clock_RecState", pishID);
                SqlParameter userParam = new SqlParameter("@Clock_User", Operator);
                SqlParameter oldDateParam = new SqlParameter("@oldDate", oldDate);
                SqlParameter oldTimeParam = new SqlParameter("@oldTime", oldTimes);
                SqlParameter oldPishIDParam = new SqlParameter("@oldPishID", oldPishID);

                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                paramArray[2] = timeParam;
                paramArray[3] = readersParam;
                paramArray[4] = changeParam;
                paramArray[5] = pishIDParam;
                paramArray[6] = userParam;
                paramArray[7] = oldDateParam;
                paramArray[8] = oldTimeParam;
                paramArray[9] = oldPishIDParam;


                bool ResultQuery = Connection.executeUpdateQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Update";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در ویرایش تردد  پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در ویرایش تردد  پرسنل " + barcode);
            }
        }
        public bool DeleteRequestHourlyPermitByOperator(string barcode, string pishID, string date, string fromTime,string toTime, string tableName)
        {

            try
            {
                string commandText = @"delete from " + tableName + @" where (Clock_BarCode=@barcode) and (Clock_Date=@date) and (clock_time=@fromTime) 
                                       and (clock_etime=@toTime) and (Clock_RecState=@pishID)";
                SqlParameter[] paramArray = new SqlParameter[5];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@date", date);
                SqlParameter fromTimeParam = new SqlParameter("@fromTime", fromTime);
                SqlParameter toTimeParam = new SqlParameter("@toTime", toTime);
                SqlParameter pishIDParam = new SqlParameter("@pishID", pishID);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;
                paramArray[2] = fromTimeParam;
                paramArray[3] = pishIDParam;
                paramArray[4] = toTimeParam;

                bool ResultQuery = Connection.executeDeleteQuery(commandText, paramArray);
                return ResultQuery;
                

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.p_barcode = barcode;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در حذف مجوز  پرسنل  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف مجوز  پرسنل " + barcode);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool CheckAccessDeleteRequestByID(string id)
        {

            try
            {

                string commandText = @"select * from NW_requests where (id_pk=@id)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id", id);

                paramArray[0] = idParam;


                DataTable ResultQuery = Connection.executeSelectQuery(commandText, paramArray);
                if (ResultQuery.Rows.Count > 0)
                {
                    if (ResultQuery.Rows[0]["Clock_FirstlyAgree"].ToString()=="0")
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                return false;

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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در تعیین دسترسی جهت حذق درخواست با  {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در تعیین دسترسی جهت حذق درخواست با ID=" + id);
            }
        }
        public Request GetRequestByID(string id)
        {

            try
            {

                string commandText = @"select * from NW_requests where (id_pk=@id)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id", id);

                paramArray[0] = idParam;


                DataTable dtResult = Connection.executeSelectQuery(commandText, paramArray);
                Request requestObj = null;
                if (dtResult.Rows.Count > 0)
                {
                    requestObj = new Request();
                    requestObj.AgreeBarcode = dtResult.Rows[0]["Clock_FirstlyAgree_BarCode"] == DBNull.Value ? "" : dtResult.Rows[0]["Clock_FirstlyAgree_BarCode"].ToString();
                    requestObj.AgreeDate = dtResult.Rows[0]["Clock_AgreeDate"] == DBNull.Value ? "" : dtResult.Rows[0]["Clock_AgreeDate"].ToString();
                    requestObj.Date = dtResult.Rows[0]["Clock_Date"] == DBNull.Value ? "" : dtResult.Rows[0]["Clock_Date"].ToString();
                    requestObj.eTime =Convert.ToInt16(dtResult.Rows[0]["Clock_eTime"] == DBNull.Value ? 0 : dtResult.Rows[0]["Clock_eTime"]);
                    requestObj.FinalyAgree = Convert.ToInt16(dtResult.Rows[0]["Clock_FinallyAgree"] == DBNull.Value ? 0 : dtResult.Rows[0]["Clock_FinallyAgree"]);
                    requestObj.FirstlyAgree = Convert.ToInt16(dtResult.Rows[0]["Clock_FirstlyAgree"] == DBNull.Value ? 0 : dtResult.Rows[0]["Clock_FirstlyAgree"]);
                    requestObj.ID = Convert.ToDecimal(dtResult.Rows[0]["Id_PK"] == DBNull.Value ? 0 : dtResult.Rows[0]["Id_PK"]);
                    requestObj.RecState = Convert.ToInt16(dtResult.Rows[0]["Clock_RecState"] == DBNull.Value ? 0 : dtResult.Rows[0]["Clock_RecState"]);
                    requestObj.SeconderyAgree = Convert.ToInt16(dtResult.Rows[0]["Clock_SeconderyAgree"] == DBNull.Value ? 0 : dtResult.Rows[0]["Clock_SeconderyAgree"]);
                    requestObj.Time = Convert.ToInt16(dtResult.Rows[0]["Clock_Time"] == DBNull.Value ? 0 : dtResult.Rows[0]["Clock_Time"]);
                    requestObj.barcode = dtResult.Rows[0]["Clock_User"] == DBNull.Value ? "" : dtResult.Rows[0]["Clock_User"].ToString();
                }
                return requestObj;

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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در تعیین دسترسی جهت حذق درخواست با  {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در تعیین دسترسی جهت حذق درخواست با ID=" + id);
            }
        }
        public bool DeleteRequestByID(string id)
        {

            try
            {
                
                string commandText = @"delete from NW_requests where (id_pk=@id)"; 
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id", id);
                paramArray[0] = idParam;

               
                    bool ResultQuery = Connection.executeDeleteQuery(commandText, paramArray);
                    return ResultQuery;
                    
               

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در حذف درخواست  {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف درخواست  با ID= " + id);
            }
        }
        public bool DeleteRequestByManagerByID(string id)
        {

            try
            {
                
                string commandText = @"delete from NW_requests where (id_pk=@id)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id", id);
                paramArray[0] = idParam;

                    bool ResultQuery = Connection.executeDeleteQuery(commandText, paramArray);
                    return ResultQuery;
                    
               

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در حذف درخواست  {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف درخواست  با ID= " + id);
            }
        }
        public string GetInitValueArchiveDayRequest(Int16 initCode)
        {

            try
            {
                DataTable dtResult = new DataTable();
                string commandText = @"select Init_Value from init where (Init_Title='archiveday') and (Init_Code=@initCode)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter initCodeParam = new SqlParameter("@initCode", initCode);
                paramArray[0] = initCodeParam;
                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت تنظیمات کد " + initCode);
                }
                if (dtResult.Rows.Count == 0)
                    return "0";
                return dtResult.Rows[0]["Init_Value"].ToString();
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت تنظیمات کد  {0}، متن پیغام {1}.خطا", initCode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت تنظیمات کد " + initCode);
            }
        }
        public DataTable GetRequestTimePishcardByID(decimal id)
        {

            try
            {
                DataTable dtResult = new DataTable();
                string commandText = @"select Clock_Date,Clock_Time,Clock_eTime,Clock_RecState,Clock_User,timeValue from NW_requests where Id_PK=@id";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id",id);
                paramArray[0] = idParam;

                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت درخواست با ID= " + id);
                }
                return dtResult;
                
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت درخواست  {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت درخواست با ID= " + id);
            }
        }
        public DataTable GetRequestByID(decimal id)
        {

            try
            {
                
                DataTable dtResult = new DataTable();
                string commandText = @"select * from NW_requests where Id_PK=@id";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter idParam = new SqlParameter("@id", id);
                paramArray[0] = idParam;

                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت درخواست با ID= " + id);
                }
                
                    
                    
	
                    
                
                return dtResult;

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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در دریافت درخواست   {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت درخواست با ID= " + id);
            }
        }
        public int GetSumRequestOverTimeDaily(string barcode, string date)
        {

            try
            {
                DataTable dtResult = new DataTable();
                string commandText = @"select Clock_Time,Clock_eTime from NW_requests where (Clock_Date=@date) and (Clock_User=@barcode) and (Clock_RecState='3')";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                SqlParameter dateParam = new SqlParameter("@date", date);
                paramArray[0] = barcodeParam;
                paramArray[1] = dateParam;

                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت درخواست با barcode=" + barcode);
                }
                int valueHourly = 0;
                int valueDaliy = 0;
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    valueHourly = Convert.ToInt32(dtResult.Rows[i]["Clock_eTime"]) - Convert.ToInt32(dtResult.Rows[i]["Clock_Time"]);
                    valueDaliy += valueHourly;
                }
                return valueDaliy;

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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در واکشی مجموع اضافه کار روزانه {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت درخواست با barcode=" + barcode);
            }
        }
        public DataTable GetColorsTraffic()
        {

            try
            {
                DataTable dtResult = new DataTable();
                string commandText = @"select * from NW_webcolor  where (WebColor_Active='True') order by WebColor_Order";
                SqlParameter[] paramArray = new SqlParameter[0];
                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت رنگ تردد ");
                }
                return dtResult;
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.Comment = string.Format("خطا در واکشی رنگ های مفاهیم {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت رنگ تردد");
            }
        }
        public int GetTrafficCountByDate(string date,string barcode,string tableName)
        {

            try
            {

                DataTable dtResult = new DataTable();
                string commandText = @"select count(*) as countTraffic from " + tableName + " where (Clock_BDate=@date) and (Clock_BarCode=@barcode)";
                SqlParameter[] paramArray = new SqlParameter[2];
                SqlParameter dateParam = new SqlParameter("@date", date);
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = dateParam;
                paramArray[1] = barcodeParam;


                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت تعداد تردد پرسنل با barcode=" + barcode);
                }
                return Convert.ToInt32(dtResult.Rows[0]["countTraffic"]);
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در واکشی تعداد تردد های پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت تعداد تردد پرسنل با barcode=" + barcode);
            }
        }
        public bool CheckRequestIsRejected(decimal requestID)
        {

            try
            {

                DataTable dtResult = new DataTable();
                string commandText = @"select * from NW_Requests where id_pk=@id and (Clock_FirstlyAgree='2' or Clock_SeconderyAgree='2' or Clock_FinallyAgree='2')";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter requestIDParam = new SqlParameter("@id", requestID);
                paramArray[0] = requestIDParam;
                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت درخواست درخواست های رد شده");
                }
                if (dtResult.Rows.Count > 0)
                    return true;
                else
                    return false;
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
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در بررسی درخواست رد شده {0}، متن پیغام {1}.خطا", requestID, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت درخواست درخواست های رد شده");
            }
        }
        public DataTable GetRequestsDailyByBarcodeDate(string Startdate,string EndDate, string barcode)
        {

            try
            {

                DataTable dtResult = new DataTable();
                string commandText = @"SELECT Clock_Date as prc_date
                                          ,Clock_SendDate
                                          ,dbo.MToH(Clock_Time) Clock_Time
                                          ,dbo.MToH(Clock_eTime) Clock_eTime
                                          ,dbo.pish_lastname(Clock_User,Clock_RecState) pish_name
                                          ,convert(nvarchar(10), Clock_FirstlyAgree) + convert(nvarchar(10), Clock_SeconderyAgree) + convert(nvarchar(10),Clock_FinallyAgree) as agree
                                          ,Clock_RecDes,ID_PK,Clock_User,(p_name + ' ' + p_family) as Operator,timeValue
                                        FROM NW_Requests join nw_webpass on webpassid=id join persons on nw_webpass.p_barcode=persons.p_barcode where Clock_date between @startDate and @endDate  and clock_User=@barcode
                                        and Clock_RecState in (select Pish_Code from pishcard where isDaily='True')";
                SqlParameter[] paramArray = new SqlParameter[3];
                SqlParameter startDateParam = new SqlParameter("@startDate", Startdate);
                SqlParameter endDateParam = new SqlParameter("@endDate", EndDate);
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = startDateParam;
                paramArray[1] = endDateParam;
                paramArray[2] = barcodeParam;


                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت درخواست های روزانه با barcode=" + barcode);
                }
                return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در واکشی درخواست های روزانه پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت درخواست های روزانه با barcode=" + barcode);
            }
        }
        public DataTable GetRequestsHourlyByBarcodeDate(string Startdate, string EndDate, string barcode)
        {

            try
            {

                DataTable dtResult = new DataTable();
                string commandText = @"SELECT Clock_Date as prc_date
                                          ,Clock_SendDate
                                          ,dbo.MToH(Clock_Time) Clock_Time
                                          ,dbo.MToH(Clock_eTime) Clock_eTime
                                          ,dbo.pish_lastname(Clock_User,Clock_RecState) pish_name
                                          ,convert(nvarchar(10), Clock_FirstlyAgree) + convert(nvarchar(10), Clock_SeconderyAgree) + convert(nvarchar(10),Clock_FinallyAgree) as agree
                                          ,Clock_RecDes,ID_PK,Clock_User,(p_name + ' ' + p_family) as Operator,timeValue
                                        FROM NW_Requests join nw_webpass on webpassid=id join persons on nw_webpass.p_barcode=persons.p_barcode where Clock_date between @startDate and @endDate  and clock_User=@barcode
                                        and Clock_RecState in (select Pish_Code from pishcard where isDaily='False')";
                SqlParameter[] paramArray = new SqlParameter[3];
                SqlParameter startDateParam = new SqlParameter("@startDate", Startdate);
                SqlParameter endDateParam = new SqlParameter("@endDate", EndDate);
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = startDateParam;
                paramArray[1] = endDateParam;
                paramArray[2] = barcodeParam;


                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت درخواست های ساعتی با barcode=" + barcode);
                }
                return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در واکشی تعداد درخواست های ساعتی {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت درخواست های ساعتی با barcode=" + barcode);
            }
        }
        public DataTable GetRequestsOverTimeByBarcodeDate(string Startdate, string EndDate, string barcode)
        {

            try
            {

                DataTable dtResult = new DataTable();
                string commandText = @"SELECT Clock_Date as prc_date
                                          ,Clock_SendDate
                                          ,dbo.MToH(Clock_Time) Clock_Time
                                          ,dbo.MToH(Clock_eTime) Clock_eTime
                                          ,dbo.pish_lastname(Clock_User,Clock_RecState) pish_name
                                          ,convert(nvarchar(10), Clock_FirstlyAgree) + convert(nvarchar(10), Clock_SeconderyAgree) + convert(nvarchar(10),Clock_FinallyAgree) as agree
                                          ,Clock_RecDes,ID_PK,Clock_User,(p_name + ' ' + p_family) as Operator,timeValue
                                        FROM NW_Requests join nw_webpass on webpassid=id join persons on nw_webpass.p_barcode=persons.p_barcode where Clock_date between @startDate and @endDate  and clock_User=@barcode
                                        and Clock_RecState in (99)";
                SqlParameter[] paramArray = new SqlParameter[3];
                SqlParameter startDateParam = new SqlParameter("@startDate", Startdate);
                SqlParameter endDateParam = new SqlParameter("@endDate", EndDate);
                SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);
                paramArray[0] = startDateParam;
                paramArray[1] = endDateParam;
                paramArray[2] = barcodeParam;


                dtResult = Connection.executeSelectQuery(commandText, paramArray);
                if (dtResult == null)
                {

                    throw new MyExceptionHandler("خطا در دریافت درخواست با barcode= " + barcode);
                }
                return dtResult;
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
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.Comment = string.Format("خطا در واکشی درخواست های اضافه کاری پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت درخواست با barcode= " + barcode);
            }
        }
    }
}
