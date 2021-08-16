using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure;

using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;
using System.Data;
using ASPWebClock.Infrastructure.Utility;
using System.Web;


namespace ASPWebClock.Infrastructure.Business
{
    public class BPerson
    {
        #region Properties




        #endregion

        #region Methods

        /// <summary>
        ///  براساس شماره پرسنل ورودی یک پرسنل را برمی گرداند
        /// </summary>
        /// <param name="username"></param>

        public List<Person> GetUnderManagmentPersonnel(decimal webPassID, IList<decimal> listPostIDInsteadMan)
        {
            try
            {


                Person prsCurrentUser = (new BWebpassUser()).GetPersonByPostID(webPassID);
                List<Person> personList = new List<Person>();
                for (int i = 0; i < listPostIDInsteadMan.Count; i++)
                {
                    Person prs = (new BWebpassUser()).GetPersonByPostID(listPostIDInsteadMan[i]);
                    List<Person> personListTemp = new PersonRepository().GetUnderManagmentPersonnel(listPostIDInsteadMan[i], prs, prsCurrentUser);
                    personList.AddRange(personListTemp);
                }

                List<Person> personDistinctList = personList.Distinct().OrderBy(o => o.Barcode).ToList<Person>();

                return personDistinctList;
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
                LogObj.Comment = string.Format("خطا در دریافت پرسنل تهت مدیریت  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پرسنل تهت مدیریت");
            }


        }
        public List<Person> GetUnderManagmentPersonnelAndCurrentUser(decimal webPassID, IList<decimal> listPostIDInsteadMan)
        {
            try
            {


                Person prsCurrentUser = (new BWebpassUser()).GetPersonByPostID(webPassID);
                List<Person> personList = new List<Person>();
                for (int i = 0; i < listPostIDInsteadMan.Count; i++)
                {
                    Person prs = (new BWebpassUser()).GetPersonByPostID(listPostIDInsteadMan[i]);
                    List<Person> personTempList = new PersonRepository().GetUnderManagmentPersonnel(listPostIDInsteadMan[i], prs, prsCurrentUser);
                    personList.AddRange(personTempList);
                }
                personList.Add(prsCurrentUser);
                List<Person> personDistinctList = personList.Distinct().OrderBy(o => o.Barcode).ToList<Person>();
                return personDistinctList;
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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت پرسنل تهت مدیریت و کاربر فعلی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پرسنل تهت مدیریت و کاربر فعلی");
            }


        }
        public int GetUnderManagmentPersonnelPersentNowCount(decimal webPassID, IList<decimal> listPostIDInsteadMan, string dateNow)
        {
            try
            {


                string tableName = "C" + dateNow.Substring(0, 4) + dateNow.Substring(5, 2);
                DataTable dtResult = new DataTable();
                for (int i = 0; i < listPostIDInsteadMan.Count; i++)
                {
                    DataTable dtResult2 = new PersonRepository().GetUnderManagmentPersonnelTaradodCount(listPostIDInsteadMan[i], tableName, dateNow);
                    dtResult.Merge(dtResult2, true);
                }

                DataView dvResult = new DataView(dtResult);
                string[] strColumns = { "Last_Clock", "clock_count", "Clock_BarCode", "Clock_Date", "P_Name", "P_Family", "FARSI_WEEK_DAY" };
                DataTable dtResultFinal = dvResult.ToTable(true, strColumns);
                int persentCount = 0;
                for (int i = 0; i < dtResultFinal.Rows.Count; i++)
                {
                    if (Convert.ToInt32(dtResultFinal.Rows[i]["clock_count"]) % 2 != 0)
                    {
                        persentCount++;
                    }
                }

                return persentCount;

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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت پرسنل تهت مدیریت حاظر در لحظه  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت پرسنل تهت مدیریت حاظر در لحظه");
            }

        }
        public DataTable GetReportMonthlyPerson(string barcode, string year, string month)
        {
            try
            {
                string tableName = "p" + year + month;
                DataTable dtResultReportMonthly = new PersonRepository().GetReportMonthlyPerson(barcode, tableName);
                DataTable dtDayOfMonth = Utility.Utility.GetDayOfMonth(Convert.ToInt32(year), Convert.ToInt32(month));
                DataTable dtResult = new DataTable();

                for (int i = 0; i < dtResultReportMonthly.Columns.Count; i++)
                {
                    dtResult.Columns.Add(dtResultReportMonthly.Columns[i].ColumnName, dtResultReportMonthly.Columns[i].DataType);
                }
                for (int i = 0; i < dtResultReportMonthly.Rows.Count; i++)
                {
                    dtResult.Rows.Add(dtResultReportMonthly.Rows[i].ItemArray);
                }
                for (int i = 0; i < dtDayOfMonth.Rows.Count; i++)
                {
                    bool checkDateExist = false;
                    for (int j = 0; j < dtResultReportMonthly.Rows.Count; j++)
                    {

                        if (dtResultReportMonthly.Rows[j]["prc_date"].ToString() == dtDayOfMonth.Rows[i]["Date"].ToString())
                        {
                            checkDateExist = true;
                        }
                    }
                    if (checkDateExist == false)
                    {
                        dtResult.Rows.Add("", 0, 0, "", dtDayOfMonth.Rows[i]["Date"].ToString(), dtDayOfMonth.Rows[i]["Date"].ToString(), dtDayOfMonth.Rows[i]["DayOfWeek"].ToString(), 0, Convert.ToInt32(dtDayOfMonth.Rows[i]["Date"].ToString().Substring(8, 2)));
                    }

                }
                DataView dvResult = new DataView(dtResult);

                dvResult.Sort = "NSort";
                DataTable dtSorted = dvResult.ToTable();
                return dtSorted;

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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت گزارش ماهانه پرسنل  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت گزارش ماهانه پرسنل");
            }
        }

        public int GetUnderManagmentPersonnelLeaveDailyCount(decimal webPassID, IList<decimal> listPostIDInsteadMan, string dateNow)
        {
            try
            {
                string tableName = "C" + dateNow.Substring(0, 4) + dateNow.Substring(5, 2);
                DataTable dtResult = new DataTable();
                int countPerson = 0;
                for (int i = 0; i < listPostIDInsteadMan.Count; i++)
                {
                    countPerson += new PersonRepository().GetUnderManagmentPersonnelLeaveDailyCount(webPassID, tableName, dateNow);
                }
                return countPerson;
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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مرخصی روزانه پرسنل تحت مدیریت  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مرخصی روزانه پرسنل تحت مدیریت");
            }
        }
        public int GetUnderManagmentPersonnelLeaveHourlyCount(decimal webPassID, IList<decimal> listPostIDInsteadMan, string dateNow)
        {
            try
            {
                string tableName = "T" + dateNow.Substring(0, 4) + dateNow.Substring(5, 2);
                DataTable dtResult = new DataTable();
                int countPerson = 0;
                for (int i = 0; i < listPostIDInsteadMan.Count; i++)
                {
                    countPerson += new PersonRepository().GetUnderManagmentPersonnelLeaveHourlyCount(webPassID, tableName, dateNow);
                }
                return countPerson;

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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مرخصی ساعتی پرسنل تحت مدیریت  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مرخصی ساعتی پرسنل تحت مدیریت");
            }
        }
        public IList<Person> GetPersonByPart(string part)
        {
            try
            {
                return new PersonRepository().GetPersonByPart(part);
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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت بخش  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت بخش");
            }
        }
        public IList<Person> GetAllPersonnel()
        {
            try
            {
                return (new PersonRepository().GetAllPersonnel());
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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت همه ی پرسنل  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت همه ی پرسنل");
            }
        }
        public IList<Person> GetPersonBySearchKey(string searchKey)
        {
            try
            {


                return (new PersonRepository().GetPersonBySearchKey(searchKey));
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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در جستجو پرسنل {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler(" خطا در دریافت جستجو پرسنل");
            }
        }

        #endregion
    }
}