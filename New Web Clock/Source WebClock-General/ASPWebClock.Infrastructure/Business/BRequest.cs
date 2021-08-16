using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Repository;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;


using System.Web;


namespace ASPWebClock.Infrastructure.Business
{
    public class BRequest
    {
        public DateTime Shamsi2Miladi(string _date)
        {

            try
            {
                int year = int.Parse(_date.Substring(0, 4));
                int month = int.Parse(_date.Substring(5, 2));
                int day = int.Parse(_date.Substring(8, 2));
                PersianCalendar p = new PersianCalendar();
                DateTime date = p.ToDateTime(year, month, day, 0, 0, 0, 0);
                return date;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;

            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در تبدیل شمسی به میلادی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تبدیل شمسی به میلادی ");
            }
        }
        public DataTable GetColorsTraffic()
        {
            try
            {
                return (new RequestRepository().GetColorsTraffic());
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا دریافت رنگ ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا دریافت رنگ ها ");
            }
        }
        public int GetTrafficCountByDate(string date, string barcode)
        {
            try
            {
                string tableName = "C" + date.Substring(0, 4) + date.Substring(5, 2);
                return (new RequestRepository().GetTrafficCountByDate(date, barcode, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت تردد ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت تردد ها ");
            }
        }
        public DataTable GetPersonRequest(bool UnderReview, bool Confirmed, bool Rejected, string FromDate, string ToDate, decimal postID, IList<decimal> listPostIDInsteadMan, string selectedBarcodePerson, string selectedPishCard)
        {
            DataTable dtResult = new DataTable();
            try
            {


                Person prsCurrentUser = (new BWebpassUser()).GetPersonByPostID(postID);
                for (int i = 0; i < listPostIDInsteadMan.Count; i++)
                {

                    Person prs = (new BWebpassUser()).GetPersonByPostID(listPostIDInsteadMan[i]);
                    DataTable dtResult2 = new RequestRepository().GetPersonRequstSQL(prs, prsCurrentUser, UnderReview, Confirmed, Rejected, FromDate, ToDate, listPostIDInsteadMan[i], selectedBarcodePerson, selectedPishCard);
                    dtResult2.Columns.Add("Status");
                    dtResult2.Columns.Add("ManagerID");
                    for (int j = 0; j < dtResult2.Rows.Count; j++)
                    {

                        dtResult2.Rows[j]["ManagerID"] = listPostIDInsteadMan[i];
                        switch ((PersonStatus)prs.Status)
                        {
                            case PersonStatus.unKnown:
                                break;
                            case PersonStatus.TAManagment:
                                switch (dtResult2.Rows[j]["Clock_FinallyAgree"].ToString())
                                {
                                    case "0":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/wait.png";
                                            break;
                                        }
                                    case "1":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/save.png";
                                            break;
                                        }
                                    case "2":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/cancel.png";
                                            break;
                                        }

                                    default:
                                        break;
                                }
                                break;
                            case PersonStatus.FinalManagment:
                                switch (dtResult2.Rows[j]["Clock_FinallyAgree"].ToString())
                                {
                                    case "0":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/wait.png";
                                            break;
                                        }
                                    case "1":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/save.png";
                                            break;
                                        }
                                    case "2":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/cancel.png";
                                            break;
                                        }

                                    default:
                                        break;
                                }

                                break;
                            case PersonStatus.EarlyManagment:
                                switch (dtResult2.Rows[j]["Clock_FirstlyAgree"].ToString())
                                {
                                    case "0":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/wait.png";
                                            break;
                                        }
                                    case "1":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/save.png";
                                            break;
                                        }
                                    case "2":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/cancel.png";
                                            break;
                                        }

                                    default:
                                        break;
                                }
                                break;
                            case PersonStatus.Operator:
                                break;
                            case PersonStatus.Reporter:
                                break;
                            case PersonStatus.SecondManagment:
                                switch (dtResult2.Rows[j]["Clock_SeconderyAgree"].ToString())
                                {
                                    case "0":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/wait.png";
                                            break;
                                        }
                                    case "1":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/save.png";
                                            break;
                                        }
                                    case "2":
                                        {
                                            dtResult2.Rows[j]["Status"] = "~/img/cancel.png";
                                            break;
                                        }

                                    default:
                                        break;
                                }
                                break;
                            case PersonStatus.User:
                                break;
                            default:
                                break;
                        }
                    }
                    dtResult.Merge(dtResult2, true);

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
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت درخواست های پرسنل  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت درخواست های پرسنل");
            }



        }
        public string InsertRequestPerson(string Clock_Date, string Clock_SendDate, string Clock_AgreeDate, int Clock_Time, int Clock_eTime, int Clock_RdrCode, int Clock_Chg
                                                  , int Clock_RecState, string Clock_User, string Clock_RecDes, int Clock_FirstlyAgree, int Clock_SeconderyAgree, string Clock_FirstlyAgree_BarCode
                                                  , int Clock_FinallyAgree, string webPassId, int timeValue, int CountRequest)
        {
            try
            {
                int requestValue = Clock_eTime - Clock_Time;
                //*******************Validations Requests bank markazi
                CheckRequestValidations(Clock_RecState, requestValue, Clock_Date, Clock_User, Clock_Time, Clock_eTime, CountRequest, Clock_RecDes);

                bool result = (new RequestRepository().InsertRequestPerson(Clock_Date, Clock_SendDate, Clock_AgreeDate, Clock_Time, Clock_eTime, Clock_RdrCode, Clock_Chg
                                                      , Clock_RecState, Clock_User, Clock_RecDes, Clock_FirstlyAgree, Clock_SeconderyAgree, Clock_FirstlyAgree_BarCode
                                                      , Clock_FinallyAgree, webPassId, timeValue));
                if (result == true)
                {

                    //Log LogObj = new Log();
                    //LogObj.Action = "Insert";
                    //LogObj.date = DateTime.Now;
                    //LogObj.Status = true;
                    //LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    //LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    //LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    //LogObj.Comment = " درخواست با کد پیش کارت " + Clock_RecState.ToString()  +  " برای پرسنل " +  Clock_User + " با تاریخ درخواست " + Clock_Date + " از ساعت "  + Utility.Utility.IntTimeToRealTime( Clock_Time) + " تا ساعت " + Utility.Utility.IntTimeToRealTime(Clock_eTime) + " توسط نام کاربری " + HttpContext.Current.User.Identity.Name + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + DateTime.Now.TimeOfDay.ToString() + " ثبت گردید." ;
                    //bool BoolResult = new logRepository().InsertToLogTable(LogObj);

                    return "اطلاعات با موفقیت ثبت گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ثبت درخواست پرسنل " + Clock_User);
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت درخواست پرسنل {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ثبت درخواست پرسنل");
            }
        }


        public string DeleteRequestByManagerByID(string id)
        {
            try
            {
                Request requestObj = GetRequestByID(id);
                bool ResultQuery = new RequestRepository().DeleteRequestByManagerByID(id);
                if (ResultQuery == true)
                {
                    
                    Log LogObj = new Log();
                    LogObj.Action = "";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = true;
                    LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                    LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    LogObj.Comment = " درخواست با کد پیش کارت " + requestObj.RecState.ToString() + " برای پرسنل " + requestObj.barcode + " با تاریخ درخواست " + requestObj.Date + " از ساعت " + Utility.Utility.IntTimeToRealTime(requestObj.Time) + " تا ساعت " + Utility.Utility.IntTimeToRealTime(requestObj.eTime) + " توسط پرسنل " + new BWebpassUser().GetPersonByUserName(HttpContext.Current.User.Identity.Name).Barcode + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + " در ساعت " + (DateTime.Now.TimeOfDay.Hours.ToString() + ":" + DateTime.Now.TimeOfDay.Minutes.ToString() + ":" + DateTime.Now.TimeOfDay.Seconds.ToString()) + " حذف گردید.";
                    bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                    return "اطلاعات با موفقیت حذف گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در حذف درخواست  با ID= " + id);
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف درخواست پرسنل به وسیله ی مدیر {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف درخواست پرسنل به وسیله ی مدیر");
            }
        }
        public string DeleteRequestByID( string id)
        {
            try
            {
                bool resultCheck = new RequestRepository().CheckAccessDeleteRequestByID(id);
                if (resultCheck == false)
                    throw new MyExceptionHandler("شما مجوز حذف این درخواست را ندارید");
                Request requestObj = GetRequestByID(id);
                bool ResultQuery = new RequestRepository().DeleteRequestByID(id);
                if (ResultQuery == true)
                {
                    
                    WebpassUserProxy webPass = new Infrastructure.Repository.WebpassUserRepository().GetWebPassUserByID(decimal.Parse( id));
                    Log LogObj = new Log();
                    LogObj.Action = "Delete";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = true;
                    LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                    LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    LogObj.Comment = " درخواست با کد پیش کارت " + requestObj.RecState.ToString() + " برای پرسنل " + requestObj.barcode + " با تاریخ درخواست " + requestObj.Date + " از ساعت " + Utility.Utility.IntTimeToRealTime(requestObj.Time) + " تا ساعت " + Utility.Utility.IntTimeToRealTime(requestObj.eTime) + " توسط پرسنل " + new BWebpassUser().GetPersonByUserName(HttpContext.Current.User.Identity.Name).Barcode + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + " در ساعت " + (DateTime.Now.TimeOfDay.Hours.ToString() + ":" + DateTime.Now.TimeOfDay.Minutes.ToString() + ":" + DateTime.Now.TimeOfDay.Seconds.ToString()) + " حذف گردید." ;
                    bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                    return "اطلاعات با موفقیت حذف گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در حذف درخواست  با ID= " + id);
                }

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف درخواست پرسنل  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف درخواست پرسنل ");
            }
        }

        public string ConfirmPersonRequest(Person prs, List<ConfirmRequestInfo> confirmRequestInfo, decimal webPassID)
        {
            try
            {


                string RetMessage = string.Empty;
                string resultvalidateOverTime = "";
                List<decimal> reqList = new List<decimal>();
                if (confirmRequestInfo == null || confirmRequestInfo.Count == 0)
                    return "هیج درخواستی انتخاب نشده است";

                foreach (ConfirmRequestInfo item in confirmRequestInfo)
                {
                    DataTable dtResult = new RequestRepository().GetRequestTimePishcardByID(item.RequestID);
                    string date = dtResult.Rows[0]["Clock_Date"].ToString();
                    string barcode = dtResult.Rows[0]["Clock_User"].ToString();
                    int fromTime = Convert.ToInt32(dtResult.Rows[0]["Clock_Time"]);
                    int toTime = Convert.ToInt32(dtResult.Rows[0]["Clock_eTime"]);
                    int pishcard = Convert.ToInt32(dtResult.Rows[0]["Clock_RecState"]);
                    int minusTime = toTime - fromTime;
                    switch (pishcard)
                    {
                        case 3:
                            {
                                int maxAccessOverTimeManager = new BWebpassUser().GetRequestOverTimeValue(Convert.ToInt32(item.ManagerID));
                                int sumOverTimeDaily = new RequestRepository().GetSumRequestOverTimeDaily(barcode, date);
                                if (maxAccessOverTimeManager < sumOverTimeDaily)
                                {
                                    resultvalidateOverTime = ". درخواست های مجوز اضافه کاری تایید نشده بیش از حد مجاز می باشند. ";
                                    RetMessage = resultvalidateOverTime;
                                }
                                else
                                {
                                    reqList.Add(item.RequestID);
                                }

                                break;
                            }

                        default:
                            {
                                reqList.Add(item.RequestID);
                                break;
                            }
                    }
                    CheckConfirmValidations(pishcard, fromTime, toTime, barcode, date);



                }

                string RqstIds = ConcatIds(reqList);
                RequestRepository RequestRps = new RequestRepository();
                if (reqList.Count > 0)
                {
                    for (int i = 0; i < reqList.Count; i++)
                    {



                        PersonStatus PS = (PersonStatus)Enum.Parse(typeof(PersonStatus), confirmRequestInfo.Single(req => req.RequestID == reqList[i]).StatusID.ToString());
                        bool isFinalManager = new BWebpassUser().UserisFinalManager(confirmRequestInfo.Single(req => req.RequestID == reqList[i]).ManagerID.ToString());

                        switch (PS)
                        {
                            case PersonStatus.EarlyManagment:
                                if (isFinalManager == false)
                                {
                                    RequestRps.UpdateRequest(reqList[i].ToString(), 1, 0, 0, PersianDateTime.MiladiToShamsi(DateTime.Now), prs.Barcode);
                                    RetMessage = "تایید درخواست با موفقیت انجام پذیرفت" + resultvalidateOverTime;
                                }
                                else
                                {
                                    prs.Status = Convert.ToInt32(PersonStatus.TAManagment);
                                    RetMessage = this.InsertPermit(prs, reqList) + resultvalidateOverTime;
                                }
                                break;
                            case PersonStatus.SecondManagment:
                                if (isFinalManager == false)
                                {
                                    RequestRps.UpdateRequest(reqList[i].ToString(), 1, 1, 0, PersianDateTime.MiladiToShamsi(DateTime.Now), prs.Barcode);
                                    RetMessage = "تایید درخواست با موفقیت انجام پذیرفت" + resultvalidateOverTime;
                                }
                                else
                                {

                                    prs.Status = Convert.ToInt32(PersonStatus.TAManagment);
                                    RetMessage = this.InsertPermit(prs, reqList) + resultvalidateOverTime;
                                }
                                break;
                            case PersonStatus.FinalManagment:
                                RetMessage = this.InsertPermit(prs, reqList) + resultvalidateOverTime;
                                break;
                            case PersonStatus.TAManagment:
                                RetMessage = this.InsertPermit(prs, reqList) + resultvalidateOverTime;
                                break;
                            case PersonStatus.Operator:
                                break;
                            case PersonStatus.unKnown:
                                break;
                            default:
                                {
                                    throw new MyExceptionHandler(string.Format("امکان تایید درخواست توسط کاربر با دسترسی {0} وجود ندراد", prs.Status.ToString()));
                                }
                        }
                    }
                }
                else
                {
                    //  RetMessage = "هیج درخواستی انتخاب نشده است";
                }
                return RetMessage;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در تایید درخواست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در تایید درخواست ");
            }
        }
        public bool CheckRequestIsRejected(decimal requestID)
        {
            try
            {
                return (new RequestRepository().CheckRequestIsRejected(requestID));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در چک کردن رد درخواست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در چک کردن رد درخواست");
            }
        }
        public string RejectPersonRequest(Person prs, List<ConfirmRequestInfo> confirmRequestInfo)
        {
            try
            {

                string RetMessage = string.Empty;
                if (confirmRequestInfo == null || confirmRequestInfo.Count == 0)
                    return "هیج درخواستی انتخاب نشده است";



                for (int i = 0; i < confirmRequestInfo.Count; i++)
                {
                    DataTable dtResult = new RequestRepository().GetRequestByID(confirmRequestInfo[i].RequestID);
                    CheckRejectedValidations(dtResult.Rows[0]["Clock_Date"].ToString());
                    bool isFinalManager = new BWebpassUser().UserisFinalManager(confirmRequestInfo.Single(req => req.RequestID == confirmRequestInfo[i].RequestID).ManagerID.ToString());
                    RequestRepository RequestRps = new RequestRepository();
                    PersonStatus PS;
                    if (isFinalManager == false)
                        PS = (PersonStatus)Enum.Parse(typeof(PersonStatus), confirmRequestInfo[i].StatusID.ToString());
                    else
                        PS = (PersonStatus)Enum.Parse(typeof(PersonStatus), "1");
                    switch (PS)
                    {
                        case PersonStatus.EarlyManagment:

                            RequestRps.UpdateRequest(confirmRequestInfo[i].RequestID.ToString(), 2, 2, 2, PersianDateTime.MiladiToShamsi(DateTime.Now), prs.Barcode);
                            RetMessage = "رد درخواست با موفقیت انجام پذیرفت";

                            break;
                        case PersonStatus.SecondManagment:
                            RequestRps.UpdateRequest(confirmRequestInfo[i].RequestID.ToString(), 1, 2, 2, PersianDateTime.MiladiToShamsi(DateTime.Now), prs.Barcode);
                            RetMessage = "رد درخواست با موفقیت انجام پذیرفت";
                            break;
                        case PersonStatus.FinalManagment:
                            RequestRps.UpdateRequest(confirmRequestInfo[i].RequestID.ToString(), 1, 1, 2, PersianDateTime.MiladiToShamsi(DateTime.Now), prs.Barcode);
                            RetMessage = "رد درخواست با موفقیت انجام پذیرفت";
                            break;
                        case PersonStatus.TAManagment:
                            RequestRps.UpdateRequest(confirmRequestInfo[i].RequestID.ToString(), 2, 2, 2, PersianDateTime.MiladiToShamsi(DateTime.Now), prs.Barcode);
                            RetMessage = "رد درخواست با موفقیت انجام پذیرفت";
                            break;
                        case PersonStatus.Operator:
                            break;
                        case PersonStatus.unKnown:
                            break;
                        default:
                            {
                                throw new Exception(string.Format("امکان تایید درخواست توسط کاربر با دسترسی {0} وجود ندراد", prs.Status.ToString()));
                            }
                    }
                }
                return RetMessage;

            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در رد درخواست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در رد درخواست");
            }
        }
        private string ConcatIds(IList<decimal> Ids)
        {
            try
            {
                string Result = "";
                for (int i = 0; i < Ids.Count; i++)
                {
                    Result += Ids[i].ToString();
                    if (i != Ids.Count - 1)
                        Result += ',';
                }
                return Result;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا   {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا ");
            }
        }

        private string InsertPermit(Person prs, IList<decimal> RequestIds)
        {
            // there is no log here
            string Result = "تایید درخواست با موفقیت انجام پذیرفت";
            IList<Request> Requests = (new RequestRepository()).GetRequest(this.ConcatIds(RequestIds));
            foreach (Request req in Requests)
            {
                try
                {
                    if (req.FinalyAgree == 1)
                        continue;
                    if (req.RecState != 99)
                    {
                        if (Enumerable.Range(31, 19).Contains(req.RecState) ||
                            Enumerable.Range(61, 19).Contains(req.RecState) ||
                            req.RecState == 91 ||
                            req.RecState == 50 ||
                            req.RecState == 4 ||
                            req.RecState == 5 ||
                            req.RecState == 10 ||
                            req.RecState == 0)
                        {
                            InsertPermitToC(prs, req);
                        }
                        else
                        {
                            InsertPermitToT(prs, req);
                        }
                    }
                    else
                    {
                        DataTable dtResult = new RequestRepository().GetRequestTimePishcardByID(req.ID);
                        string barcode = dtResult.Rows[0]["Clock_User"].ToString();
                        string pishID = dtResult.Rows[0]["Clock_RecState"].ToString();
                        string date = dtResult.Rows[0]["Clock_Date"].ToString();
                        string year = date.Substring(0, 4);
                        string month = date.Substring(5, 2);
                        string time = dtResult.Rows[0]["timeValue"].ToString();
                        new RequestRepository().InsertAgreeOverTime(barcode, pishID, year, month, time);
                        new RequestRepository().UpdateRequest(req.ID.ToString(), 1, 1, 1, PersianDateTime.MiladiToShamsi(DateTime.Now), prs.Barcode);
                    }
                }
                catch (MyExceptionHandler ex)
                {
                    Result += ", error:" + ex.Message;
                    continue;
                }
                catch (Exception ex)
                {
                    Result += ", error:" + ex.Message;
                    continue;
                }
            }
            return Result;
        }

        private void InsertPermitToT(Person prs, Request req)
        {
            try
            {
                RequestRepository ReqRepsitory = new RequestRepository();
                TerminalRec ClkRec = GetTerminalRec(prs, req);

                #region PrepareRequest

                string ShamsiDate = PersianDateTime.MiladiToShamsi(DateTime.Now);
                switch ((PersonStatus)prs.Status)
                {
                    case PersonStatus.TAManagment:
                        if (req.FirstlyAgree == 1 && req.SeconderyAgree == 0)
                        {
                            req.AgreeBarcode = prs.Barcode + prs.Barcode;
                            req.AgreeDate = ShamsiDate + ShamsiDate;
                        }
                        else
                            if (req.FirstlyAgree == 1 && req.SeconderyAgree == 1 && req.FinalyAgree == 0)
                            {
                                req.AgreeBarcode = prs.Barcode;
                                req.AgreeDate = ShamsiDate;
                            }
                            else
                            {
                                req.AgreeBarcode = prs.Barcode + prs.Barcode + prs.Barcode;
                                req.AgreeDate = ShamsiDate + ShamsiDate + ShamsiDate;
                            }
                        req.FinalyAgree = 1;
                        req.SeconderyAgree = 1;
                        req.FirstlyAgree = 1;
                        break;
                    case PersonStatus.FinalManagment:
                        if (req.FirstlyAgree == 1 && req.SeconderyAgree == 1 && req.FinalyAgree == 0)
                        {
                            req.AgreeBarcode = prs.Barcode;
                            req.AgreeDate = ShamsiDate;
                        }
                        req.FinalyAgree = 1;
                        break;
                }

                #endregion

                if (ReqRepsitory.HasTRow(req.user.Barcode, req.Date, req.Time, req.eTime, req.RecState))
                {
                    throw new MyExceptionHandler("درخواست تکراری است");

                }
                else
                {
                    ReqRepsitory.InsertToT(prs, ClkRec, req);
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت مجوز  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ثبت مجوز ");
            }
        }

        private void InsertPermitToC(Person prs, Request req)
        {
            try
            {
                RequestRepository ReqRepsitory = new RequestRepository();
                TerminalRec ClkRec = GetTerminalRec(prs, req);

                #region PrepareRequest

                string ShamsiDate = PersianDateTime.MiladiToShamsi(DateTime.Now);
                switch ((PersonStatus)prs.Status)
                {
                    case PersonStatus.TAManagment:
                        if (req.FirstlyAgree == 1 && req.SeconderyAgree == 0)
                        {
                            req.AgreeBarcode = prs.Barcode + prs.Barcode;
                            req.AgreeDate = ShamsiDate + ShamsiDate;
                        }
                        else
                            if (req.FirstlyAgree == 1 && req.SeconderyAgree == 1 && req.FinalyAgree == 0)
                            {
                                req.AgreeBarcode = prs.Barcode;
                                req.AgreeDate = ShamsiDate;
                            }
                            else
                            {
                                req.AgreeBarcode = prs.Barcode + prs.Barcode + prs.Barcode;
                                req.AgreeDate = ShamsiDate + ShamsiDate + ShamsiDate;
                            }
                        req.FinalyAgree = 1;
                        req.SeconderyAgree = 1;
                        req.FirstlyAgree = 1;
                        break;
                    case PersonStatus.FinalManagment:
                        if (req.FirstlyAgree == 1 && req.SeconderyAgree == 1 && req.FinalyAgree == 0)
                        {
                            req.AgreeBarcode = prs.Barcode;
                            req.AgreeDate = ShamsiDate;
                        }
                        req.FinalyAgree = 1;
                        req.SeconderyAgree = 1;
                        req.FirstlyAgree = 1;
                        break;
                }

                #endregion

                if (ClkRec.rdrTime != 0 && ClkRec.rdrStatus == 0)
                {
                    ReqRepsitory.InsertToC(prs, ClkRec, req);
                }
                if (!(Enumerable.Range(31, 5).Contains(req.RecState) ||
                      Enumerable.Range(41, 9).Contains(req.RecState) ||
                      Enumerable.Range(61, 5).Contains(req.RecState) ||
                        Enumerable.Range(70, 6).Contains(req.RecState) ||
                        Enumerable.Range(91, 9).Contains(req.RecState)) ||
                        (req.RecState == 0))
                {
                    if (req.RecState == 10)
                    {
                        ClkRec.rdrStatus = 0;
                    }

                    ClkRec.rdrTime = ClkRec.rdreTime;
                    ClkRec.rdrBTime = ClkRec.rdreTime;
                    if (ClkRec.rdrTime != 0)
                    {
                        ReqRepsitory.InsertToC(prs, ClkRec, req);
                    }

                }
                else
                {

                    ReqRepsitory.InsertToC(prs, ClkRec, req);
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت در جدول سی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ثبت در جدول سی ");
            }
        }

        private TerminalRec GetTerminalRec(Person prs, Request req)
        {
            try
            {
                TerminalRec ClkRec = new TerminalRec();
                if (Enumerable.Range(31, 5).Contains(req.RecState) ||
                    Enumerable.Range(41, 9).Contains(req.RecState) ||
                    Enumerable.Range(61, 5).Contains(req.RecState) ||
                    Enumerable.Range(70, 6).Contains(req.RecState) ||
                    Enumerable.Range(91, 9).Contains(req.RecState)
                    )
                {
                    ClkRec.rdrChng = 2;
                    ClkRec.rdrTime = 720;
                    ClkRec.rdrBTime = 720;

                }
                else
                {
                    if (req.RecState == 5)
                    {
                        ClkRec.rdrTime = 0;
                    }
                    else
                    {
                        ClkRec.rdrTime = req.Time;
                    }
                    ClkRec.rdrChng = 1;
                    ClkRec.rdrBTime = req.Time;
                    ClkRec.rdreTime = req.eTime;
                }

                ClkRec.rdrCardCode = req.user.Barcode;

                ClkRec.rdrDate = req.Date;



                ClkRec.rdrCode = 0;
                ClkRec.rdrStatus = req.RecState;
                ClkRec.rdrBStatus = req.RecState;
                ClkRec.rdrBDate = req.Date;
                ClkRec.rdrUser = prs.Barcode;
                return ClkRec;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا ارتباط با ترمینال  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا ارتباط با ترمینال ");
            }
        }
        public DataTable GetPersonnelTrafficDailyByDate(string barcode, string month, string year)
        {
            try
            {

                if (month == "")
                    throw new MyExceptionHandler("ماه مورد نظر انتخاب نشده است.");

                if (year == "")
                    throw new MyExceptionHandler("سال مورد نظر انتخاب نشده است.");
                if (barcode == "")
                    throw new MyExceptionHandler("پرسنل مورد نظر انتخاب نشده است.");
                string tableName = "C" + year + month;
                return (new RequestRepository().GetPersonnelTrafficDailyByDate(barcode, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت تردد  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت تردد ");
            }
        }



        public DataTable GetPersonnelTrafficHourlyPermitByDate(string barcode, string month, string year)
        {
            try
            {
                if (month == "")
                    throw new MyExceptionHandler("ماه مورد نظر انتخاب نشده است.");

                if (year == "")
                    throw new MyExceptionHandler("سال مورد نظر انتخاب نشده است.");
                if (barcode == "")
                    throw new MyExceptionHandler("پرسنل مورد نظر انتخاب نشده است.");
                string tableName = "t" + year + month;
                return (new RequestRepository().GetPersonnelTrafficHourlyPermitByDate(barcode, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت ترددساعتی با تاریخ  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت ترددساعتی با تاریخ ");
            }
        }
        public DataTable GetPersonnelTrafficHourlyTrafficByDate(string barcode, string month, string year)
        {
            try
            {
                if (month == "")
                    throw new MyExceptionHandler("ماه مورد نظر انتخاب نشده است.");

                if (year == "")
                    throw new MyExceptionHandler("سال مورد نظر انتخاب نشده است.");
                if (barcode == "")
                    throw new MyExceptionHandler("پرسنل مورد نظر انتخاب نشده است.");
                string tableName = "C" + year + month;
                return (new RequestRepository().GetPersonnelTrafficHourlyTrafficByDate(barcode, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت ترددساعتی با تاریخ  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطادر دریافت ترددساعتی با تاریخ ");
            }
        }
        public DataTable GetTrafficPersonnelBySelectedDate(string barcode, string Date)
        {
            try
            {
                string tableName = "C" + Date.Substring(0, 4) + Date.Substring(5, 2);
                return (new RequestRepository().GetTrafficPersonnelBySelectedDate(barcode, Date, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت تردد تاریخ انتخاب شده  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت تردد تاریخ انتخاب شده ");
            }
        }
        public string InsertRequestDialyByOperator(string barcode, string pishID, string fromdate, string comment, string barcodeOperator, int change, int Readers, int time)
        {
            try
            {
                if (fromdate == "")
                    throw new MyExceptionHandler("تاریخی برای ثبت وجود ندارد.");
                string tableName = "C" + fromdate.Substring(0, 4) + fromdate.Substring(5, 2);
                CheckRequestValidations(Convert.ToInt32(pishID), 0, fromdate, barcode, 0, 0, 1, comment);
                CheckConfirmValidations(Convert.ToInt32(pishID), 0, 0, barcode, fromdate);
                return (new RequestRepository().InsertRequestDialyByOperator(barcode, pishID, fromdate, comment, barcodeOperator, change, Readers, time, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت درخواست روزانه به وسیله ی اپراتور  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ثبت درخواست روزانه به وسیله ی اپراتور ");
            }
        }


        public string InsertAllRequestDialyByOperator(string barcode, string pishID, string fromdate, string toDate, string comment, string barcodeOperator, int change, int Readers, int time)
        {
            string currentDate = "";
            try
            {


                DateTime enFromDate = ASPWebClock.Infrastructure.Utility.PersianDateTime.Shamsi2Miladi(fromdate);
                DateTime enToDate = ASPWebClock.Infrastructure.Utility.PersianDateTime.Shamsi2Miladi(toDate);
                TimeSpan ts = enToDate - enFromDate;
                CheckRequestValidations(Convert.ToInt32(pishID), 0, fromdate, barcode, 0, 0, ts.Days + 1, comment);
                CheckConfirmValidations(Convert.ToInt32(pishID), 0, 0, barcode, fromdate);
                string message = "";

                for (var i = enFromDate.Date; i.Date <= enToDate.Date; i = i.AddDays(1))
                {
                    currentDate = ASPWebClock.Infrastructure.Utility.PersianDateTime.MiladiToShamsi(i.Date);
                    string tableName = "C" + currentDate.Substring(0, 4) + currentDate.Substring(5, 2);
                    message = new RequestRepository().InsertRequestDialyByOperator(barcode, pishID, currentDate, comment, barcodeOperator, change, Readers, time, tableName);

                }
                return (message);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت اطلاعات  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler(ex + "خطا در ثبت اطلاعات از تاریخ " + currentDate + "به بعد");
            }
        }
        public string EditRequestDialyByOperator(string barcode, string pishID, string date, string comment, string barcodeOperator, int change, int Readers, int time, string oldPishID, string oldDate)
        {
            try
            {
                string newDateYear = date.Substring(0, 4);
                string newDateMonth = date.Substring(5, 2);
                string oldDateYear = oldDate.Substring(0, 4);
                string oldDateMonth = oldDate.Substring(5, 2);
                string resulMessage;
                if (newDateYear == oldDateYear && newDateMonth == oldDateMonth)
                {
                    string tableName = "C" + newDateYear + newDateMonth;
                    resulMessage = (new RequestRepository().EditRequestDialyByOperator(barcode, pishID, date, comment, barcodeOperator, change, tableName, oldPishID, oldDate));
                }
                else
                {
                    string tableName = "C" + oldDateYear + oldDateMonth;
                    bool res = new RequestRepository().DeleteRequestDialyByOperator(barcode, oldPishID, oldDate, time.ToString(), Readers.ToString(), tableName);
                    tableName = "C" + newDateYear + newDateMonth;
                    resulMessage = new RequestRepository().InsertRequestDialyByOperator(barcode, pishID, date, comment, barcodeOperator, change, Readers, time, tableName).Replace("ثبت", "ویرایش");

                }
                Log LogObj = new Log();

                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = true;
                LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                string newChanges = "";
                newChanges += oldPishID != pishID ? " به پیش کارت " + pishID + " ، " : "";
                newChanges += oldDate != date ? " به تاریخ " + date + " ، " : "";
                LogObj.Comment = " مجوز با کد پیش کارت " + oldPishID + " برای پرسنل " + barcode + " با تاریخ درخواست " + oldDate + " توسط پرسنل " + new BWebpassUser().GetPersonByUserName(HttpContext.Current.User.Identity.Name).Barcode + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + " در ساعت " + (DateTime.Now.TimeOfDay.Hours.ToString() + ":" + DateTime.Now.TimeOfDay.Minutes.ToString() + ":" + DateTime.Now.TimeOfDay.Seconds.ToString()) + newChanges + " ویرایش گردید.";
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                return resulMessage;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت اطلاعات  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler(ex + "خطا در ,ویرایش اطلاعات در تاریخ " + date);
            }
        }
        public string InsertRequestHourlyPermitByOperator(string barcode, string pishID, string date, string comment, string Operator, int change, int Readers, int fromHour, int toHour)
        {
            try
            {
                if (date == "")
                    throw new MyExceptionHandler("تاریخی برای ثبت وجود ندارد.");
                if (fromHour >= toHour)
                    throw new MyExceptionHandler("مقدار ساعت پایان می بایست بیشتر از ساعت شروع باشد.");
                if (fromHour == 0)
                    throw new MyExceptionHandler("فیلد های ساعت را تکمیل نمایید.");
                if (toHour == 0)
                    throw new MyExceptionHandler("فیلد های ساعت را تکمیل نمایید.");
                CheckRequestValidations(Convert.ToInt32(pishID), 0, date, barcode, fromHour, toHour, 1, comment);
                CheckConfirmValidations(Convert.ToInt32(pishID), fromHour, toHour, barcode, date);
                string tableName = "t" + date.Substring(0, 4) + date.Substring(5, 2);
                return (new RequestRepository().InsertRequestHourlyPermitByOperator(barcode, pishID, date, comment, Operator, change, Readers, fromHour, toHour, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت درخواست ساعتی به وسیله ی اپراتور  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ثبت درخواست ساعتی به وسیله ی اپراتور ");
            }
        }
        public string EditRequestHourlyPermitByOperator(string barcode, string pishID, string date, string comment, string Operator, int change, int Readers, int fromHour, int toHour, string oldPishID, int oldFromTime, int oldToTime, string oldDate)
        {
            try
            {
                if (date == "")
                    throw new MyExceptionHandler("تاریخی برای ثبت وجود ندارد.");
                if (fromHour >= toHour)
                    throw new MyExceptionHandler("مقدار ساعت پایان می بایست بیشتر از ساعت شروع باشد.");
                if (fromHour == 0)
                    throw new MyExceptionHandler("فیلد های ساعت را تکمیل نمایید.");
                if (toHour == 0)
                    throw new MyExceptionHandler("فیلد های ساعت را تکمیل نمایید.");
                string tableName = "t" + date.Substring(0, 4) + date.Substring(5, 2);
                bool ResultQuery = (new RequestRepository().EditRequestHourlyPermitByOperator(barcode, pishID, date, comment, Operator, change, Readers, fromHour, toHour, tableName, oldPishID, oldFromTime, oldToTime, oldDate));
                if (ResultQuery == true)
                {
                    Log LogObj = new Log();
                    LogObj.Action = "";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = true;
                    LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                    LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    string newChanges = "";
                    newChanges += oldPishID != pishID ? " به پیش کارت " + pishID + " ، " : "";
                    newChanges += oldDate != date ? " به تاریخ " + date + " ، " : "";
                    newChanges += oldFromTime != fromHour ? " به ساعت شروع " + Utility.Utility.IntTimeToRealTime(Convert.ToInt16(fromHour)) + " ، " : "";
                    newChanges += oldToTime != toHour ? " به ساعت پایان " + Utility.Utility.IntTimeToRealTime(Convert.ToInt16(toHour)) + " ، " : "";

                    return "اطلاعات با موفقیت ویرایش گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ویرایش مجوز ساعتی پرسنل " + barcode);
                }


            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا   {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش مجوز ساعتی اپراتور ");
            }
        }
        public string InsertRequestHourlyTrafficByOperator(string barcode, string pishID, string date, string comment, string Operator, int change, int Readers, int fromHour, int toHour)
        {
            try
            {


                if (date == "")
                {
                    throw new MyExceptionHandler("تاریخی برای ثبت وجود ندارد.");
                }
                if (fromHour >= toHour && toHour != 0)
                {
                    throw new MyExceptionHandler("مقدار ساعت پایان می بایست بیشتر از ساعت شروع باشد.");
                }
                if (fromHour == 0 && toHour == 0)
                {
                    throw new MyExceptionHandler("فیلد های ساعت را تکمیل نمایید.");
                }
                CheckRequestValidations(Convert.ToInt32(pishID), 0, date, barcode, fromHour, toHour, 1, comment); ;
                CheckConfirmValidations(Convert.ToInt32(pishID), fromHour, toHour, barcode, date);
                string tableName = "C" + date.Substring(0, 4) + date.Substring(5, 2);
                string retMessage = string.Empty;
                if (fromHour != 0)
                    retMessage = (new RequestRepository().InsertRequestHourlyTrafficByOperator(barcode, pishID, date, comment, Operator, change, Readers, fromHour, tableName));
                if (toHour != 0)
                    retMessage = (new RequestRepository().InsertRequestHourlyTrafficByOperator(barcode, pishID, date, comment, Operator, change, Readers, toHour, tableName));

                return retMessage;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ثبت در خواست تردد ساعتی به وسیله ی اپراتور  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ثبت در خواست تردد ساعتی به وسیله ی اپراتور ");
            }
        }
        public string EditRequestHourlyTrafficByOperator(string barcode, string pishID, string date, string comment, string Operator, int change, int Readers, int time, string oldPishID, int oldTimes, string oldDate)
        {

            try
            {


                if (date == "")
                {

                    throw new MyExceptionHandler("تاریخی برای ثبت وجود ندارد.");
                }

                if (time == 0)
                {

                    throw new MyExceptionHandler("فیلد ساعت را تکمیل نمایید.");
                }
                string tableName = "C" + date.Substring(0, 4) + date.Substring(5, 2);


                bool ResultQuery = (new RequestRepository().EditRequestHourlyTrafficByOperator(barcode, pishID, date, comment, Operator, change, Readers, time, tableName, oldPishID, oldTimes, oldDate));
                if (ResultQuery == true)
                {
                    Log LogObj = new Log();
                    LogObj.Action = "";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = true;
                    LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                    LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    string newChanges = "";
                    newChanges += oldPishID != pishID ? " به پیش کارت " + pishID + " ، " : "";
                    newChanges += oldDate != date ? " به تاریخ " + date + " ، " : "";
                    newChanges += oldTimes != time ? " به ساعت پایان " + Utility.Utility.IntTimeToRealTime(Convert.ToInt16(time)) + " ، " : "";
                    LogObj.Comment = " مجوز با کد پیش کارت " + oldPishID + " برای پرسنل " + barcode + " با تاریخ درخواست " + oldDate + " در ساعت " + Utility.Utility.IntTimeToRealTime(Convert.ToInt16(oldTimes)) + " توسط پرسنل " + new BWebpassUser().GetPersonByUserName(HttpContext.Current.User.Identity.Name).Barcode + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + " در ساعت " + (DateTime.Now.TimeOfDay.Hours.ToString() + ":" + DateTime.Now.TimeOfDay.Minutes.ToString() + ":" + DateTime.Now.TimeOfDay.Seconds.ToString()) + newChanges + " ویرایش گردید.";
                    bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                    return "اطلاعات با موفقیت ویرایش گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در ویرایش تردد  پرسنل " + barcode);
                }



            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در ویرایش در خواست تردد ساعتی به وسیله ی اپراتور  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ویرایش در خواست تردد ساعتی به وسیله ی اپراتور ");
            }
        }
        public string DeleteRequestCartable(Person prs, List<ConfirmRequestInfo> confirmRequestInfo)
        {
            try
            {

                if (confirmRequestInfo != null)
                {
                    foreach (ConfirmRequestInfo item in confirmRequestInfo)
                    {
                        DataTable dtResult = new RequestRepository().GetRequestByID(item.RequestID);
                        string AgreeBarcode = dtResult.Rows[0]["Clock_FirstlyAgree_BarCode"].ToString();
                        string AgreeDate = dtResult.Rows[0]["Clock_AgreeDate"].ToString();
                        Int16 eTime = (Int16)dtResult.Rows[0]["Clock_eTime"];
                        Int16 FinalyAgree = (Int16)dtResult.Rows[0]["Clock_FinallyAgree"];
                        Int16 FirstlyAgree = (Int16)dtResult.Rows[0]["Clock_FirstlyAgree"];
                        decimal ID = (decimal)dtResult.Rows[0]["Id_PK"];
                        Int16 RecState = (Int16)dtResult.Rows[0]["Clock_RecState"];
                        Int16 SeconderyAgree = (Int16)dtResult.Rows[0]["Clock_SeconderyAgree"];
                        Int16 Time = (Int16)dtResult.Rows[0]["Clock_Time"];
                        string userBarcode = dtResult.Rows[0]["Clock_User"].ToString();
                        string Clock_Date = dtResult.Rows[0]["Clock_Date"].ToString();
                        //بستن درخواست ها و محاسبات
                        if (CheckTimeInsertRequestIsExpired(Clock_Date, 2) == true)
                        {
                            throw new MyExceptionHandler("زمان حذف درخواست برای ماه های گذشته به پایان رسیده است.");
                        }


                        if (FinalyAgree != 0)
                        {
                            if (Enumerable.Range(31, 19).Contains(RecState) ||
                                           Enumerable.Range(61, 19).Contains(RecState) ||
                                           RecState == 91 ||
                                           RecState == 50 ||
                                           RecState == 4 ||
                                           RecState == 5 ||
                                           RecState == 10 ||
                                           RecState == 0)
                            {
                                if (Time == 0 && eTime == 0)
                                    Time = 720;
                                string result = DeleteRequestCartableFromTableC(userBarcode, RecState.ToString(), Clock_Date, Time.ToString());
                                if (eTime > 0)
                                    result = DeleteRequestCartableFromTableC(userBarcode, RecState.ToString(), Clock_Date, eTime.ToString());
                            }
                            else
                            {

                                string result = DeleteRequestCartableFromTableT(userBarcode, RecState.ToString(), Clock_Date, Time.ToString(), eTime.ToString());

                            }
                            if (RecState == 99)
                            {
                                string result = DeleteAgreeOverTime(userBarcode, RecState.ToString(), Clock_Date, Time.ToString());

                            }
                        }
                        string result2 = DeleteRequestByManagerByID(ID.ToString());


                    }
                    return "درخواست ها با موفقیت حذف گردید.";
                }

                else
                {
                    return "هیچ درخواستی انتخاب نشده است.";
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف کارتابل درخواست ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف کارتابل درخواست ها ");
            }
        }
        public string DeleteAgreeOverTime(string barcode, string pishID, string date, string time)
        {
            try
            {
                string year = date.Substring(0, 4);
                string month = date.Substring(5, 2);
                return new RequestRepository().DeleteAgreeOverTime(barcode, pishID, year, month, time);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در حذف تایید اضافه کار  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در حذف تایید اضافه کار ");
            }

        }
        public string DeleteRequestCartableFromTableT(string barcode, string pishID, string date, string fromTime, string toTime)
        {
            try
            {


                string tableName = "T" + date.Substring(0, 4) + date.Substring(5, 2);
                return (new RequestRepository().DeleteRequestCartableFromTableT(barcode, pishID, date, fromTime, toTime, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا حذف کارتابل درخواست ها از جدول تی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا حذف کارتابل درخواست ها از جدول تی ");
            }
        }
        public string DeleteRequestCartableFromTableC(string barcode, string pishID, string date, string time)
        {
            try
            {
                string tableName = "C" + date.Substring(0, 4) + date.Substring(5, 2);
                return (new RequestRepository().DeleteRequestCartableFromTableC(barcode, pishID, date, time, tableName));
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا حذف کارتابل درخواست ها از جدول سی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا حذف کارتابل درخواست ها از جدول سی ");
            }
        }
        public string DeleteRequestDialyByOperator(string barcode, string pishID, string date, string time, string reader)
        {
            try
            {
                if (barcode == "")
                    throw new MyExceptionHandler("ترددی جهت حذف انتخاب نگردیده است");
                if (barcode == "null")
                    throw new MyExceptionHandler("ترددی جهت حذف انتخاب نگردیده است");

                string tableName = "C" + date.Substring(0, 4) + date.Substring(5, 2);
                bool ResultQuery = (new RequestRepository().DeleteRequestDialyByOperator(barcode, pishID, date, time, reader, tableName));
                if (ResultQuery == true)
                {
                    Log LogObj = new Log();
                    LogObj.Action = "";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = true;
                    LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                    LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    LogObj.Comment = " مجوز با کد پیش کارت " + pishID + " برای پرسنل " + barcode + " با تاریخ درخواست " + date + " توسط پرسنل " + new BWebpassUser().GetPersonByUserName(HttpContext.Current.User.Identity.Name).Barcode + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + " در ساعت " + (DateTime.Now.TimeOfDay.Hours.ToString() + ":" + DateTime.Now.TimeOfDay.Minutes.ToString() + ":" + DateTime.Now.TimeOfDay.Seconds.ToString()) + " حذف گردید.";
                    bool BoolResult = new logRepository().InsertToLogTable(LogObj);
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
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا حذف درخواست روزانه به وسیله ی اپراتور  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا حذف درخواست روزانه به وسیله ی اپراتور ");
            }
        }
        public string DeleteRequestHourlyTrafficByOperator(string barcode, string pishID, string date, string time, string reader)
        {
            try
            {
                if (barcode == "")
                    throw new MyExceptionHandler("ترددی جهت حذف انتخاب نگردیده است");
                if (barcode == "null")
                    throw new MyExceptionHandler("ترددی جهت حذف انتخاب نگردیده است");

                string tableName = "C" + date.Substring(0, 4) + date.Substring(5, 2);
                bool ResultQuery = (new RequestRepository().DeleteRequestHourlyTrafficByOperator(barcode, pishID, date, time, reader, tableName));
                if (ResultQuery == true)
                {
                    Log LogObj = new Log();
                    LogObj.Action = "";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = true;
                    LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                    LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    LogObj.Comment = " مجوز با کد پیش کارت " + pishID + " برای پرسنل " + barcode + " با تاریخ درخواست " + date + " در ساعت " + Utility.Utility.IntTimeToRealTime(Convert.ToInt16(time)) + " توسط پرسنل " + new BWebpassUser().GetPersonByUserName(HttpContext.Current.User.Identity.Name).Barcode + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + " در ساعت " + (DateTime.Now.TimeOfDay.Hours.ToString() + ":" + DateTime.Now.TimeOfDay.Minutes.ToString() + ":" + DateTime.Now.TimeOfDay.Seconds.ToString()) + " حذف گردید.";
                    bool BoolResult = new logRepository().InsertToLogTable(LogObj);
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
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا حذف درخواست تردد ساعتی به وسیله ی اپراتور  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطاحذف درخواست تردد ساعتی به وسیله ی اپراتور ");
            }
        }
        public string DeleteRequestHourlyPermitByOperator(string barcode, string pishID, string date, string fromTime, string toTime)
        {
            try
            {
                if (barcode == "")
                    throw new MyExceptionHandler("ترددی جهت حذف انتخاب نگردیده است");
                if (barcode == "null")
                    throw new MyExceptionHandler("ترددی جهت حذف انتخاب نگردیده است");

                string tableName = "t" + date.Substring(0, 4) + date.Substring(5, 2);
                bool ResultQuery = (new RequestRepository().DeleteRequestHourlyPermitByOperator(barcode, pishID, date, fromTime, toTime, tableName));
                if (ResultQuery == true)
                {
                    Log LogObj = new Log();
                    LogObj.Action = "";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = true;
                    LogObj.UserWebPassID = HttpContext.Current.Session["PostID"] != null ? decimal.Parse(HttpContext.Current.Session["PostID"].ToString()) : 0;
                    LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    LogObj.Comment = " مجوز با کد پیش کارت " + pishID + " برای پرسنل " + barcode + " با تاریخ درخواست " + date + " از ساعت " + Utility.Utility.IntTimeToRealTime(Convert.ToInt16(fromTime)) + " تا ساعت " + Utility.Utility.IntTimeToRealTime(Convert.ToInt16(toTime)) + " توسط پرسنل " + new BWebpassUser().GetPersonByUserName(HttpContext.Current.User.Identity.Name).Barcode + " در تاریخ " + Utility.Utility.ToPersianDate(DateTime.Now) + " در ساعت " + (DateTime.Now.TimeOfDay.Hours.ToString() + ":" + DateTime.Now.TimeOfDay.Minutes.ToString() + ":" + DateTime.Now.TimeOfDay.Seconds.ToString()) + " حذف گردید.";
                    bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                    return "اطلاعات با موفقیت حذف گردید";
                }
                else
                {
                    throw new MyExceptionHandler("خطا در حذف مجوز  پرسنل " + barcode);
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا حذف مجوز درخواست ساعتی به وسیله ی اپراتور  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطاحذف مجوز درخواست ساعتی به وسیله ی اپراتور ");
            }
        }

        public DataTable GetAllTerminal()
        {
            try
            {
                return new RequestRepository().GetAllTerminal();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت همه ترمینال ها  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت همه ترمینال ها ");
            }
        }

        public DataTable GetRequestsByBarcodeDate(string date, string barcode, bool Daily, bool Hourly, bool OverTime)
        {
            try
            {
                string startDate = date + "01";
                string endDate = date + "31";
                DataTable dtResultTemp = new DataTable();
                DataTable dtResult = new DataTable();
                dtResult.Columns.Add("prc_date");
                dtResult.Columns.Add("Clock_SendDate");
                dtResult.Columns.Add("Clock_Time");
                dtResult.Columns.Add("Clock_eTime");
                dtResult.Columns.Add("pish_name");
                dtResult.Columns.Add("agree");
                dtResult.Columns.Add("Clock_RecDes");
                dtResult.Columns.Add("ID_PK");
                dtResult.Columns.Add("Clock_User");
                dtResult.Columns.Add("Operator");
                dtResult.Columns.Add("timeValue");
                if (Daily == true)
                {
                    dtResultTemp = new RequestRepository().GetRequestsDailyByBarcodeDate(startDate, endDate, barcode);
                    for (int i = 0; i < dtResultTemp.Rows.Count; i++)
                    {
                        dtResult.ImportRow(dtResultTemp.Rows[i]);
                    }
                    dtResultTemp = null;
                }
                if (Hourly == true)
                {
                    dtResultTemp = new RequestRepository().GetRequestsHourlyByBarcodeDate(startDate, endDate, barcode);
                    for (int i = 0; i < dtResultTemp.Rows.Count; i++)
                    {
                        dtResult.ImportRow(dtResultTemp.Rows[i]);
                    }
                    dtResultTemp = null;
                }
                if (OverTime == true)
                {
                    dtResultTemp = new RequestRepository().GetRequestsOverTimeByBarcodeDate(startDate, endDate, barcode);
                    for (int i = 0; i < dtResultTemp.Rows.Count; i++)
                    {
                        dtResult.ImportRow(dtResultTemp.Rows[i]);
                    }
                    dtResultTemp = null;
                }
                DataView dvResult = new DataView(dtResult);
                dvResult.Sort = "prc_date";
                return dvResult.Table;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا   {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت درخواست با تاریخ ");
            }


        }
        public Request GetRequestByID(string id)
        {
            try
            {
                return new RequestRepository().GetRequestByID(id);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت درخواست با ID=  {0}، متن پیغام {1}.خطا", id, Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت درخواست با ID= " + id);
            }
        }
        private void CheckRequestIsOverLap(string barcode, string date, int fromTime, int toTime, int RecState)
        {

            try
            {
                DataTable dtResult = new RequestRepository().GetRequestByBarcodeDate(barcode, date);
                if (dtResult.Rows.Count > 0)
                {
                    for (int i = 0; i < dtResult.Rows.Count; i++)
                    {

                        int RegisterdRequestRecState = Convert.ToInt32(dtResult.Rows[i]["Clock_RecState"]);
                        if (Enumerable.Range(31, 5).Contains(RegisterdRequestRecState) ||
                        Enumerable.Range(41, 9).Contains(RegisterdRequestRecState) ||
                        Enumerable.Range(61, 5).Contains(RegisterdRequestRecState) ||
                        Enumerable.Range(70, 6).Contains(RegisterdRequestRecState) ||
                        Enumerable.Range(91, 9).Contains(RegisterdRequestRecState))
                        {

                            throw new MyExceptionHandler("مجاز به ثبت این درخواست نمی با شید.درخواستی در این روز قبلا به ثبت رسیده است.");
                        }
                        else
                        {
                            if ((fromTime > (Int16)dtResult.Rows[i]["Clock_Time"] && fromTime < (Int16)dtResult.Rows[i]["Clock_eTime"]) || (toTime > (Int16)dtResult.Rows[i]["Clock_Time"] && toTime < (Int16)dtResult.Rows[i]["Clock_eTime"]) || (fromTime < (Int16)dtResult.Rows[i]["Clock_Time"] && toTime > (Int16)dtResult.Rows[i]["Clock_eTime"]) || fromTime == (Int16)dtResult.Rows[i]["Clock_Time"] || toTime == (Int16)dtResult.Rows[i]["Clock_eTime"])
                            {
                                if (!((Enumerable.Range(51, 5).Contains(RecState) && RegisterdRequestRecState == 3) || (Enumerable.Range(51, 5).Contains(RegisterdRequestRecState) && RecState == 3)))
                                {

                                    throw new MyExceptionHandler("مجاز به ثبت این درخواست نمی با شید.درخواست شما با درخواست های ثبت شده قبلی تداخل دارد.");
                                }


                            }
                        }

                    }
                }


            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترول تداخل درخواست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترول تداخل درخواست ");
            }

        }
        private void CheckRequestValidations(int Clock_RecState, int requestValue, string Clock_Date, string Clock_User, int Clock_Time, int Clock_eTime, int CountRequest, string Clock_RecDes)
        {
            try
            {




                //درخواست ها هم پوشانی نداشته باشد.

                CheckRequestIsOverLap(Clock_User, Clock_Date, Clock_Time, Clock_eTime, Clock_RecState);

                //بستن درخواست ها و محاسبات
                if (CheckTimeInsertRequestIsExpired(Clock_Date, 2) == true)
                {

                    throw new MyExceptionHandler("زمان ثبت درخواست برای ماه های گذشته به پایان رسیده است.");
                }
                switch (Clock_RecState)
                {
                    case 41:
                        {
                            //چک کردن مرخصی روزانه بیشتر از مانده مرخصی نباشد
                            int sumRemainLeave = new BValidations().GetRemainLeaveWithRequestAndPermittedToDayOfEndCurrentMonth(Utility.Utility.MiladiToShamsiDate(DateTime.Now), Clock_User);
                            int valueDailyToMinute = new BValidations().GetPersonValueDailyLeaveToMinute(Clock_User);
                            //int sumRemainLeaveAndCurrentMonthBudget = sumRemainLeave + (2 * valueDailyToMinute) + 80;
                            int sumRemainLeaveAndCurrentMonthBudget = sumRemainLeave;
                            if (CountRequest * valueDailyToMinute > sumRemainLeave)
                            {

                                throw new MyExceptionHandler(" درخواست شما ثبت نگردید . مقدار باقیمانده از مرخصی استحقاقی  شما" + (sumRemainLeave / valueDailyToMinute) + " روز و " + ((sumRemainLeave % valueDailyToMinute) / 60) + ":" + ((sumRemainLeave % valueDailyToMinute) % 60) + "ساعت" + " می باشد . ");
                            }
                            break;
                        }
                    default:
                        break;
                }

                //CheckRequestValidateBankMarkazi(Clock_RecState, requestValue, Clock_Date, Clock_User, Clock_Time, Clock_eTime, CountRequest, Clock_RecDes);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در بانک مرکزی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا ");
            }
        }
        private void CheckRequestValidateBankMarkazi(int Clock_RecState, int requestValue, string Clock_Date, string Clock_User, int Clock_Time, int Clock_eTime, int CountRequest, string Clock_RecDes)
        {

            try
            {

                //validations Ruye Pishcardha makhsuse banke markazi
                #region validationBankeMarkazi
                switch (Clock_RecState)
                {

                    case 27:
                        {

                            //چک کردن مرخصی ساعتی در هفته کمتر از 120 دقیقه باشد.
                            int result = new BValidations().checkSumLeaveHourlyInWeek(requestValue, Clock_Date, Clock_User);
                            if (result > 120)
                            {
                                int remainLeaveInWeek = 0;
                                if (120 - (result - requestValue) > 0)
                                    remainLeaveInWeek = 120 - (result - requestValue);
                                else
                                    remainLeaveInWeek = 0;

                                throw new MyExceptionHandler("مقدار مجاز باقیمانده  مرخصی ساعتی شما در این هفته  " + remainLeaveInWeek.ToString() + " دقیقه می باشد.");
                            }
                            break;
                        }
                    case 51:
                        {
                            //ماموریت ساعتی کمتر از 30 دقیقه اول صبح نباشد
                            if (new BValidations().CheckPersonHaveTakhirGheirMojaz(Clock_Date, Clock_User) && (Clock_eTime - Clock_Time < 30) && new BValidations().GetFirstInPerson(Clock_Date, Clock_User) > Clock_Time)
                            {

                                throw new MyExceptionHandler("ماموریت ساعتی کمتر از 30 دقیقه نمی تواند ثبت شود.");
                            }
                            //توضیحات ماموریت ساعتی خالی نباشد
                            if (Clock_RecDes == "")
                            {

                                throw new MyExceptionHandler("لطفا فیلد توضیحات را تکمیل نمایید.");
                            }
                            break;
                        }
                    case 52:
                        {
                            //توضیحات ماموریت ساعتی خالی نباشد
                            if (Clock_RecDes == "")
                            {

                                throw new MyExceptionHandler("لطفا فیلد توضیحات را تکمیل نمایید.");
                            }
                            break;
                        }
                    case 53:
                        {
                            //توضیحات ماموریت ساعتی خالی نباشد
                            if (Clock_RecDes == "")
                            {

                                throw new MyExceptionHandler("لطفا فیلد توضیحات را تکمیل نمایید.");
                            }
                            break;
                        }

                    case 21:
                        {
                            //مرخصی اضطرار بیشتر از 48 ساعت نباشد

                            int usedMorkhasiEzterar = new BValidations().GetValuesMorkhasiEzterarToDayOfEndMonth(Utility.Utility.MiladiToShamsiDate(DateTime.Now), Clock_User);
                            int validateMorkhasiEzterarInMinute = (48 * 60);


                            if (usedMorkhasiEzterar > validateMorkhasiEzterarInMinute)
                            {

                                throw new MyExceptionHandler("درخواست شما ثبت نگردید.سقف میزان مرخصی اضطرار شما به پایان رسیده است. ");
                            }
                            else
                            {
                                int remainMorkhasiEzterarrr = validateMorkhasiEzterarInMinute - usedMorkhasiEzterar;
                                if (usedMorkhasiEzterar + requestValue > validateMorkhasiEzterarInMinute)
                                {
                                    string hourRemainMorkhasiEzterar = (remainMorkhasiEzterarrr / 60).ToString() + ":" + (remainMorkhasiEzterarrr % 60).ToString();

                                    throw new MyExceptionHandler(" درخواست شما ثبت نگردید . مقدار باقیمانده از مرخصی اضطرار شما" + hourRemainMorkhasiEzterar + " می باشد . ");
                                }
                            }
                            break;
                        }
                    case 41:
                        {

                            break;
                        }
                    case 42:
                        {
                            //چک کردن مرخصی روزانه استعلاجی بیشتر از 60 روز نباشد
                            if (CountRequest > 60)
                            {

                                throw new MyExceptionHandler("تعداد روزهای درخواست بیشتر از 60 روز می باشد.");
                            }
                            break;
                        }
                    case 3:
                        {
                            //اضافه کار قبل از وقت بین 30 تا 60 دقیقه باشد.
                            if (Clock_eTime <= 480)
                            {
                                if (new BValidations().CheckUserIsPermitOverTimeBeforeTime(Clock_User) == false)
                                    throw new MyExceptionHandler("شما مجوز اضافه کاری قبل از وقت را ندارید.");
                                if ((Clock_eTime - Clock_Time) < 30 || (Clock_eTime - Clock_Time) > 60)
                                {

                                    throw new MyExceptionHandler("مقدار درخواست شما می بایست بین 30 الی 60 دقیقه باشد.");
                                }


                            }
                            else
                            {
                                if (Clock_Time < 480)
                                {

                                    throw new MyExceptionHandler("درخواست می بایست قبل از ساعت 8 باشد.");
                                }
                            }

                            break;
                        }
                    default:
                        break;
                }
                #endregion
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در بانک مرکزی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا ");
            }
        }
        public bool CheckTimeInsertRequestIsExpired(string Clock_Date, Int16 initCode)
        {
            try
            {


                string initValue = new RequestRepository().GetInitValueArchiveDayRequest(initCode);
                if (initValue == "0")
                    return false;
                string initValueCorrect = string.Empty;
                if (Convert.ToInt32(initValue) < 10)
                    initValueCorrect = "0" + initValue;
                else
                    initValueCorrect = initValue;
                DateTime reqDate = Utility.Utility.ToMildiDate(Clock_Date.Substring(0, 8) + initValueCorrect);
                //DateTime reqDate = Utility.Utility.ToMildiDate(Clock_Date);
                string strInitDate = Utility.Utility.ToPersianDate(reqDate.AddMonths(1)).Substring(0, 8) + initValueCorrect;
                DateTime InitDate = Utility.Utility.ToMildiDate(strInitDate);
                DateTime currentDate = DateTime.Now;
                if (InitDate < currentDate)
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
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترول زمان ثبت درخواست  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترول زمان ثبت درخواست ");
            }
        }
        private void CheckConfirmValidations(int pishcard, int fromTime, int toTime, string barcode, string date)
        {
            try
            {
                //بستن درخواست ها و محاسبات
                if (CheckTimeInsertRequestIsExpired(date, 2) == true)
                {

                    throw new MyExceptionHandler("زمان تایید درخواست برای ماه های گذشته به پایان رسیده است.");
                }
                //CheckConfirmValidateBankMarkazi(pishcard,fromTime,toTime,barcode,date);
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترل زمان تایید  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترل زمان تایید ");
            }
        }
        private void CheckConfirmValidateBankMarkazi(int pishcard, int fromTime, int toTime, string barcode, string date)
        {

            try
            {


                switch (pishcard)
                {
                    case 3:
                        {

                            //اضافه کار 18 تا 20 بانک مرکزی

                            if ((fromTime >= 1080 && fromTime <= 1200) || (toTime > 1080 && toTime <= 1200) || (fromTime < 1080 && toTime > 1200))
                            {

                                if (!new BValidations().addmojazdatetimepart(barcode, date))
                                {

                                    throw new MyExceptionHandler("ظرفیت حضور کارکنان بین 18 تا 20 در روز  " + date + "تکمیل گردیده است.");
                                }
                            }
                            break;
                        }

                    default:
                        {

                            break;
                        }
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترول زمان تاییید  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترل زمان تایید ");
            }
        }
        private void CheckDeleteValidateBankMarkazi(int pishcard, int fromTime, int toTime, string barcode, string date)
        {
            try
            {

                //بستن درخواست ها و محاسبات
                if (CheckTimeInsertRequestIsExpired(date, 2) == true)
                {
                    throw new MyExceptionHandler("زمان حذف درخواست برای ماه های گذشته به پایان رسیده است.");
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترول زمان حذف  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترول زمان حذف ");
            }
        }
        private void CheckRejectedValidations(string date)
        {

            try
            {

                //بستن درخواست ها و محاسبات
                if (CheckTimeInsertRequestIsExpired(date, 2) == true)
                {

                    throw new MyExceptionHandler("زمان رد درخواست برای ماه های گذشته به پایان رسیده است.");
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در کنترل زمان رد کردن  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در کنترل زمان رد کردن ");
            }
        }
    }
}
