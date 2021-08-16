using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Globalization;
using ASPWebClock.Infrastructure.Repository;
using System.Web;
using ASPWebClock.Infrastructure.Utility;
using ASPWebClock.Infrastructure.Model;

namespace ASPWebClock.Infrastructure.Business
{
   public class BValidations
    {
       public bool checkExistTableP(string year, string month)
       {
           try
           {
               return new ValidationRepository().checkExistTableP(year, month);
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در چک کردن جدول پی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در چک کردم جدول پی");
           }
       }
       public int checkSumLeaveHourlyInWeek(int requestValue, string date, string barcode)
       {
           try
           {
               return new ValidationRepository().checkSumLeaveHourlyInWeek(requestValue, Utility.Utility.ToMildiDate(date).ToShortDateString(), barcode);
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در جمع مرخصی ساعتی هفته {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در جمع مرخصی ساعتی هفته");
           }
       }
       public bool CheckPersonHaveTakhirGheirMojaz(string date, string barcode)
       {
           try
           {
               return new ValidationRepository().CheckPersonHaveTakhirGheirMojaz(date, barcode);
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در کنترول تاخیر غیر مجاز شخص {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در کنترول تاخیر غیر مجاز شخص");
           }
       }
       public int GetFirstInPerson(string date, string barcode)
       {
           try
           {
               return new ValidationRepository().GetFirstInPerson(date, barcode);
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در دریافت اولین ورود شخص  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت اولین ورود شخص");
           }
       }
       public int GetValuesMorkhasiEzterarToDayOfEndMonth(string dateNow, string barcode)
       {
           try
           {
               int year = int.Parse(dateNow.Substring(0, 4));
               int month = int.Parse(dateNow.Substring(5, 2));
               int sumMorkhasiEzterarInYear = 0;
               for (int i = 1; i <= month; i++)
               {
                   string monthValue = "";
                   if (i < 10)
                       monthValue = "0" + i.ToString();
                   else
                       monthValue = i.ToString();
                   int sumMorkhasiEzterarInMonth = new ValidationRepository().GetValuesMorkhasiEzteraPermitedInMonth(year.ToString(), monthValue, barcode);
                   sumMorkhasiEzterarInYear += sumMorkhasiEzterarInMonth;
               }
               string currentFirstDayYear = year.ToString() + "/01" + "/01";
               string currentEndDayMonth = dateNow.Substring(0, 7) + "/31";
               sumMorkhasiEzterarInYear += new ValidationRepository().GetValuesMorkhasiEzterarRequestedInDateRange(currentFirstDayYear, currentEndDayMonth, barcode);
               return sumMorkhasiEzterarInYear;
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در کنترول مجوز مرخصی اظطراری تا اخر ماه {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در کنترول مجوز مرخصی اظطراری تا اخر ماه");
           }


       }
       public int GetRemainLeaveWithRequestAndPermittedToDayOfEndCurrentMonth(string dateNow, string barcode)
       {
           try
           {
               int year = int.Parse(dateNow.Substring(0, 4));
               int month = int.Parse(dateNow.Substring(5, 2));
               string currentFirstDayYear = year.ToString() + "/01" + "/01";
               string currentEndDayMonth = dateNow.Substring(0, 7) + "/31";
               int sumRemainLeave = 0;
               //string PreMonth = "";
               string monthValue = "";
               if (month < 10)
               {

                   monthValue = "0" + month.ToString();

               }
               else
                   monthValue = month.ToString();

               //if ((month - 1) < 10)
               //{
               //    if (month == 1)
               //        PreMonth = "0" + month.ToString();
               //    else
               //        PreMonth = "0" + (month - 1).ToString();
               //}
               //else
               //{
               //    PreMonth = (month - 1).ToString();
               //}


               sumRemainLeave = new ValidationRepository().GetAllRemainLeaveToMonthInMinute(year.ToString(), (monthValue).ToString(), barcode);
               //int sumDailyUsedLeaveInMonth = new ValidationRepository().GetSumDailyUsedToDayOfEndMonthInMinute(year.ToString(), monthValue, barcode);
               //int sumHourlyUsedLeaveInMonth = new ValidationRepository().GetSumHourlyUsedToDayOfEndMonthInMinute(year.ToString(), monthValue, barcode);
               int sumDailyRequestedLeaveInCurrentMonth = new ValidationRepository().GetSumLeaveDailyRequestedInDateRange(currentFirstDayYear, currentEndDayMonth, barcode);
               int sumHourlyRequestedLeaveInCurrentMonth = new ValidationRepository().GetSumLeaveHourlyRequestedInDateRange(currentFirstDayYear, currentEndDayMonth, barcode);
               //sumRemainLeave = sumRemainLeave - sumDailyUsedLeaveInMonth - sumHourlyUsedLeaveInMonth - sumDailyRequestedLeaveInCurrentMonth - sumHourlyRequestedLeaveInCurrentMonth;
               sumRemainLeave = sumRemainLeave - sumDailyRequestedLeaveInCurrentMonth - sumHourlyRequestedLeaveInCurrentMonth;
               return sumRemainLeave;
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در دریافت مانده مرخصی تا پایان ماه {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت مانده مرخصی تا پایان ماه");
           }

       }
       public int GetPersonValueDailyLeaveToMinute(string barcode)
       {
           try
           {
               int result = new ValidationRepository().GetPersonValueDailyLeaveToMinute(barcode);
               if (result == 0)
                   throw new MyExceptionHandler("");
               return result;
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در دریافت مجوز مرخصی روزانه به دقیقه  {0}، متن پیغام {1}.خطا",barcode,Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت مجوز مرخصی روزانه به دقیقه با barcode = " + barcode);
           }
       }
       public int GetRemainLeaveToDayOfEndCurrentMonth(string year,string month, string barcode)
       {
           try
           {
               //int year = int.Parse(dateNow.Substring(0, 4));
               //int month = int.Parse(dateNow.Substring(5, 2));
               string currentFirstDayYear = year.ToString() + "/01" + "/01";
               //string currentEndDayMonth = dateNow.Substring(0, 7) + "/31";
               string currentEndDayMonth = year + "/" + month + "/31";
               int sumRemainLeave = 0;
               //string PreMonth = "";
               string monthValue = month;
              // string monthValue = "";
               //if (month < 10)
               //{

               //    monthValue = "0" + month.ToString();

               //}
               //else
               //    monthValue = month.ToString();

               //if ((month - 1) < 10)
               //{
               //    if (month == 1)
               //        PreMonth = "0" + month.ToString();
               //    else
               //        PreMonth = "0" + (month - 1).ToString();
               //}
               //else
               //{
               //    PreMonth = (month - 1).ToString();
               //}


               sumRemainLeave = new ValidationRepository().GetAllRemainLeaveToMonthInMinute(year.ToString(), (monthValue).ToString(), barcode);
               //int sumDailyUsedLeaveInMonth = new ValidationRepository().GetSumDailyUsedToDayOfEndMonthInMinute(year.ToString(), month.ToString(), barcode);
               //int sumHourlyUsedLeaveInMonth = new ValidationRepository().GetSumHourlyUsedToDayOfEndMonthInMinute(year.ToString(), month.ToString(), barcode);
               //sumRemainLeave = sumRemainLeave - sumDailyUsedLeaveInMonth - sumHourlyUsedLeaveInMonth;
               return sumRemainLeave;
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در دریافت روز های باقی مانده ی ماه {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت مرخصی های باقی مانده ی ماه");
           }
       }
       public bool CheckUserIsPermitOverTimeBeforeTime(string barcode)
       {
           try
           {
               return new ValidationRepository().CheckUserIsPermitOverTimeBeforeTime(barcode);
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در دریافت مجوز اضافه کار قبل و بعد از وقت  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در دریافت مجوز اضافه کار قبل و بعد از وقت  با barcode = " + barcode);
           }
          
       }

       public bool addmojazdatetimepart(string barcode, string mdate)
       {
           try
           {
               return new ValidationRepository().addmojazdatetimepart(barcode, mdate);
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
               LogObj.LayerName = Model.Log.LayerNameEnum.Business.ToString();
               LogObj.UserName = HttpContext.Current.User.Identity.Name;
               LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               LogObj.Comment = string.Format("خطا در تخصیص اضافه ماری مجاز به بخش  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
               bool BoolResult = new logRepository().InsertToLogTable(LogObj);
               throw new MyExceptionHandler("خطا در تخصیص اضافه ماری مجاز به بخش  با barcode = " + barcode);
           }
       }
       
    }
}
