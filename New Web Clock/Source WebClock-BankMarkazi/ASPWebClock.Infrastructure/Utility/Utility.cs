using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.Configuration;
using System.Linq.Expressions;
using System.Text.RegularExpressions;
using System.Globalization;

using System.Data;

namespace ASPWebClock.Infrastructure.Utility
{
    /// <summary>
    ///  برای اتصال شروط در کوئری استفاده میشود 
    /// </summary>
    public enum ConditionOperations
    {
        AND, OR
    }

    /// <summary>
    ///  برای اتصال عملوندها در شروط استفاده میشود 
    /// </summary>
    public enum CriteriaOperation
    {
        Equal, NotEqual, GreaterThan, LessThan, GreaterEqThan, LessEqThan, Like, IsNull, IsNotNull, IS, IN
    }

    public struct CriteriaStruct
    {
        public string PropertyName;
        public object Value;
        public CriteriaOperation Operation;

        public CriteriaStruct(string propertyName, object value)
        {
            PropertyName = propertyName;
            Value = value;
            Operation = CriteriaOperation.Equal;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="propertyName"></param>
        /// <param name="value"></param>
        /// <param name="operation">برای اتصال به عملوند قبلی استفاده میشود </param>
        public CriteriaStruct(string propertyName, object value, CriteriaOperation operation)
        {
            PropertyName = propertyName;
            Value = value;
            Operation = operation;
        }
    }

    public static class Utility
    {
        static PerformanceCounter counter = null;
        static int MinutPerDay = 1440;
        static int MinutePerHour = 60;

        /// <summary>
        /// حداقل مقدار تاریخ جهت اعتبارسنجی تاریخ های ورودی در واسط کاربر
        /// </summary>
        public static DateTime GTSMinStandardDateTime
        {
            get
            {
                return new DateTime(1900, 1, 1);
            }
        }

        /// <summary>
        /// حداقل مقدار تاریخ شمسی جهت اعتبارسنجی تاریخ های ورودی در واسط کاربر
        /// </summary>
        public static string GTSMinStandardShamsiDateTime
        {
            get
            {
                return ToPersianDate(GTSMinStandardDateTime);
            }
        }
        public static string MiladiToShamsiDate(DateTime date)
        {
            System.Globalization.PersianCalendar persian = new System.Globalization.PersianCalendar();
            string year = persian.GetYear(date).ToString();
            string month = persian.GetMonth(date).ToString();
            string day = persian.GetDayOfMonth(date).ToString();
            if (persian.GetMonth(date) < 10)
                month = "0" + month;
            if (persian.GetDayOfMonth(date) < 10)
                day = "0" + day;

            return year + "/" + month + "/" + day;
        }
        /// <summary>
        /// Get Page Count Used in GridView
        /// </summary>
        public static int GetPageCount(int itemCount, int pagesize)
        {
            int pageCount = 0;


            int remainder = 0;
            int quotient = (int)Math.DivRem(itemCount, pagesize, out remainder);
            if (remainder == 0)
            {
                if (itemCount == 0)
                    return 0;
                else if (itemCount < pagesize)
                    pageCount = 1;
                else
                    pageCount = quotient;
            }
            else
            {
                quotient++;
                pageCount = quotient;
            }

            return pageCount;
        }

        /// <summary>
        /// نام خصوصیت را برمی گرداند
        /// </summary>
        /// <remarks>var propertyName = GetPropertyName(() => myObject.AProperty); // returns "AProperty"</remarks>
        public static string GetPropertyName<T>(Expression<Func<T>> propertyExpression)
        {
            return (propertyExpression.Body as MemberExpression).Member.Name;
        }

        /// <summary>
        /// System CPU Usage
        /// used in ELE Helper Class
        /// </summary>
        public static float CpuUsage
        {
            get
            {
                if (counter == null)
                {
                    counter = new PerformanceCounter("Processor", "% Processor Time", "_Total");
                }
                return (counter.NextValue());
            }
        }

        /// <summary>
        /// یک استثنا میگیرد و پیام آن بهمراه تمام استثنا های داخلی را برمیگرداند
        /// </summary>
        /// <param name="ex"></param>
        /// <returns></returns>
        public static string GetExecptionMessage(Exception ex)
        {
            string message = ex.Message;

            while (ex.InnerException != null)
            {
                message += String.Format(" ---> {0}", ex.InnerException.Message);
                ex = ex.InnerException;
            }
            return message;
        }

        /// <summary>
        /// Appsetting خواندن از
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static string ReadAppSetting(string key)
        {
            string value = ConfigurationSettings.AppSettings[key];
            if (value != null)
            {
                return value;
            }
            return "";
        }

        public static string[] Spilit(string source, char ch)
        {
            if (IsEmpty(source))
            {
                return new string[1];
            }
            return source.Split(new char[] { ch });
        }

        /// <summary>
        /// حذف علامتهای اضافی در نام کاربری تا در دیتابیس قابل استفاده شود
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public static string GetSimpleUsername(string username)
        {
            if (username.Contains("@"))
            {
                username = username.Remove(username.IndexOf("@"));
            }
            return username;
        }
        public static DataTable GetDayOfMonth(int year, int month)
        {
            System.Globalization.PersianCalendar pCalendar = new System.Globalization.PersianCalendar();

            int endDayOfMonth = pCalendar.GetDaysInMonth(year, month);

            string strMonth = "";
            if (month < 10)
                strMonth = "0" + month.ToString();
            else
                strMonth = month.ToString();
            DataTable dtResult = new DataTable();
            dtResult.Columns.Add("Date");
            dtResult.Columns.Add("DayOfWeek");
            for (int i = 1; i <= endDayOfMonth; i++)
            {
                string strDay = "";
                if (i < 10)
                    strDay = "0" + i.ToString();
                else
                    strDay = i.ToString();


                DateTime enDate = pCalendar.ToDateTime(year, month, i, 0, 0, 0, 0);
                string nameDayPersian = "";
                switch (enDate.DayOfWeek)
                {
                    case DayOfWeek.Friday:
                        nameDayPersian = "جمعه";
                        break;
                    case DayOfWeek.Monday:
                        nameDayPersian = "دوشنبه";
                        break;
                    case DayOfWeek.Saturday:
                        nameDayPersian = "شنبه";
                        break;
                    case DayOfWeek.Sunday:
                        nameDayPersian = "یکشنبه";
                        break;
                    case DayOfWeek.Thursday:
                        nameDayPersian = "پنجشنبه";
                        break;
                    case DayOfWeek.Tuesday:
                        nameDayPersian = "سه شنبه";
                        break;
                    case DayOfWeek.Wednesday:
                        nameDayPersian = "چهارشنبه";
                        break;
                    default:
                        break;
                }

                dtResult.Rows.Add(year.ToString() + "/" + strMonth + "/" + strDay, nameDayPersian);

            }
            return dtResult;
        }
        public static IList<T> Clone<T>(this IList<T> listToClone) where T : ICloneable
        {
            return listToClone.Select(item => (T)item.Clone()).ToList();
        }

        /// <summary>
        /// Write to ASP.NET cache
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        /// <param name="durationMinutes">دقیقه</param>
        public static void CatchWrite(string key, object value, int durationMinutes)
        {
            if (System.Web.HttpContext.Current != null && System.Web.HttpContext.Current.Cache[key] == null)
            {
                System.Web.HttpContext.Current.Cache.Insert(key, value, null, DateTime.Now.AddMinutes(durationMinutes), TimeSpan.Zero);
            }
        }

        /// <summary>
        /// Read From ASP.NET cache
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static object CatchRead(string key)
        {
            if (System.Web.HttpContext.Current != null && System.Web.HttpContext.Current.Cache[key] != null)
            {
                return System.Web.HttpContext.Current.Cache[key];
            }
            return null;
        }

        #region Converts

        /// <summary>
        /// دقیقه را به زمان واقعی تبدیل میکند
        /// </summary>
        /// <param name="time"></param>
        /// <returns></returns>
        /// <example>
        /// IntTimeToRealTime(130); --> 2:10
        /// IntTimeToRealTime(1450); --> +0:10
        /// </example>/// 
        public static string IntTimeToRealTime(int Minute)
        {
            try
            {
                if (Minute == -1000) return "";
                if (Minute == 0) return "";
                int day = 0;
                string temp = "";
                day = Minute / MinutPerDay;
                for (int i = 1; i <= day; i++)
                    temp += "+";
                Minute -= MinutPerDay * day;
                temp += (Minute / MinutePerHour).ToString().PadLeft(2, '0') + ":" + (Minute % MinutePerHour).ToString().PadLeft(2, '0');
                return temp;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// دقیقه را به زمان واقعی تبدیل میکند
        /// </summary>
        /// <param name="time"></param>
        /// <returns></returns>
        /// <example>
        /// IntTimeToRealTimeWithZero(130); --> 2:10
        /// IntTimeToRealTimeWithZero(1450); --> +0:10
        /// /// IntTimeToRealTimeWithZero(0); --> 00:00
        /// </example>/// 
        public static string IntTimeToRealTimeWithZero(int Minute)
        {
            try
            {
                if (Minute == -1000) return "";
                int day = 0;
                string temp = "";
                day = Minute / MinutPerDay;
                for (int i = 1; i <= day; i++)
                    temp += "+";
                Minute -= MinutPerDay * day;
                temp += (Minute / MinutePerHour).ToString().PadLeft(2, '0') + ":" + (Minute % MinutePerHour).ToString().PadLeft(2, '0');
                return temp;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// دقیقه را به زمان واقعی تبدیل میکند
        /// </summary>
        /// <param name="time"></param>
        /// <returns></returns>
        /// <example>
        /// IntTimeToRealTime(130); --> 2:10
        /// IntTimeToRealTime(1450); --> +0:10
        /// </example>/// 
        public static string IntTimeToRealTime(decimal Minute)
        {
            try
            {
                return IntTimeToRealTime(Convert.ToInt32(Minute));
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// .تبدیل دقیقه به زمان
        /// </summary>
        /// <param name="Minute">.میزان دقیقه ای که به زمان تبدیل می شود</param>
        /// <returns>زمان محاسبه شده</returns>
        /// <example>
        /// MinuteToTime(130); --> 2:10
        /// MinuteToTime(1450); --> 24:10
        /// </example>
        public static string IntTimeToTime(int Minute)
        {
            try
            {
                if (Minute == -1000) return "     ";
                if (Minute == 0) return "     ";
                return (Minute / MinutePerHour).ToString().PadLeft(2, '0') + ":" + (Minute % MinutePerHour).ToString().PadLeft(2, '0');
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// .تبدیل دقیقه به زمان
        /// </summary>
        /// <param name="Minute">.میزان دقیقه ای که به زمان تبدیل می شود</param>
        /// <param name="withoutSpace">اگر زمان صفر باشد فاصله قرار نمیدهد</param>
        /// <returns>زمان محاسبه شده</returns>
        /// <example>
        /// MinuteToTime(130); --> 2:10
        /// MinuteToTime(1450); --> 24:10
        /// </example>
        public static string IntTimeToTime(int Minute,bool withoutSpace)
        {
            try
            {
                string time = Utility.IntTimeToTime(Minute);
                if (withoutSpace) 
                {
                    time = time.Replace(" ", "");
                }
                return time;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// .تبدیل دقیقه به زمان
        /// </summary>
        /// <param name="Minute">.میزان دقیقه ای که به زمان تبدیل می شود</param>
        /// <returns>زمان محاسبه شده</returns>
        /// <example>
        /// MinuteToTime(130); --> 2:10
        /// MinuteToTime(1450); --> 24:10
        /// </example>
        public static string IntTimeToTime(decimal Minute)
        {
            try
            {
                return IntTimeToTime(Convert.ToInt32(Minute));
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// زمان را به دقیقه تبدیل میکند
        /// </summary>
        /// <param name="time"></param>
        /// <returns></returns>
        /// <example>
        /// TimeToMinute("2:10") --> 130
        /// TimeToMinute("+0:10") --> 1450
        /// </example>
        public static int RealTimeToIntTime(string time)
        {
            try
            {
                if (IsEmpty(time)) return -1000;
                int temp = 0;
                if (time.Contains(':'))
                {
                    switch (time[time.Length - 1])
                    {
                        case '+': temp += MinutPerDay; time = time.Remove(time.Length - 1, 1); break;
                        case '-': temp -= MinutPerDay; time = time.Remove(time.Length - 1, 1); break;
                    }
                    temp += Convert.ToInt32((time.Split(':')[0])) * MinutePerHour + Convert.ToInt32((time.Split(':')[1]));
                    return temp;
                }
                else 
                {
                    throw new Exception("فرمت زمان نادرست است -- RealTimeToIntTime");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// تبدیل شمسی به میلادی
        /// </summary>
        /// <param name="persianDate">تاریخ شمسی</param>
        /// <returns></returns>
        public static DateTime ToMildiDate(string persianDate)
        {
            try
            {
                if (!Utility.IsEmpty(persianDate))
                {
                    string[] strs = persianDate.Split('/');
                    if (strs[0].Length == 4)
                    {
                        persianDate = strs[0] + "/" + strs[1].PadLeft(2, '0') + "/" + strs[2].PadLeft(2, '0');
                    }
                    else
                    {
                        persianDate = strs[2] + "/" + strs[1].PadLeft(2, '0') + "/" + strs[0].PadLeft(2, '0');
                    }

                    PersianDateTime p = PersianDateTime.Parse(persianDate);
                    return p.GregorianDate;
                }
                return GTSMinStandardDateTime;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// تبدیل میلادی متنی به میلادی
        /// </summary>
        /// <param name="miladiDate">تاریخ میلادی</param>
        /// <returns></returns>
        public static DateTime ToMildiDateTime(string miladiDate)
        {
            try
            {
                if (!Utility.IsEmpty(miladiDate))
                {
                    miladiDate = miladiDate.Replace("-", "/");
                    string[] strs = miladiDate.Split('/');
                    if (strs.Length == 3)
                    {
                        if (strs[0].Length == 4)
                        {
                            return new DateTime(Utility.ToInteger(strs[0]), Utility.ToInteger(strs[1]), Utility.ToInteger(strs[2]));
                        }
                        else if (strs[2].Length == 4)
                        {
                            return new DateTime(Utility.ToInteger(strs[2]), Utility.ToInteger(strs[1]), Utility.ToInteger(strs[0]));
                        }
                    }
                }
                else
                    return Utility.GTSMinStandardDateTime;
                throw new Exception("فرمت تاریخ جهت تبدیل شمسی به میلادی صحیح نمیباشد");
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// تبدیل شمسی متنی به میلادی متنی
        /// </summary>
        /// <param name="miladiDate">تاریخ میلادی</param>
        /// <returns></returns>
        public static string ToMildiDateString(string persianDate)
        {
            try
            {
                if (!Utility.IsEmpty(persianDate))
                {
                    DateTime date = Utility.ToMildiDate(persianDate);
                    return String.Format("{0}/{1}/{2}", date.Year, date.Month, date.Day);
                }
                else
                {
                    DateTime date = GTSMinStandardDateTime;
                    return String.Format("{0}/{1}/{2}", date.Year, date.Month, date.Day);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// تبدیل میلادی به شمسی
        /// </summary>
        /// <param name="date">تاریخ میلادی</param>
        /// <returns></returns>
        public static string ToPersianDate(DateTime miladiDate)
        {
            try
            {
                return PersianDateTime.MiladiToShamsi(Utility.ToString(miladiDate));
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// تبدیل میلادی به شمسی
        /// </summary>
        /// <param name="date">تاریخ میلادی</param>
        /// <returns></returns>
        public static string ToPersianDate(string miladiDate)
        {
            try
            {
                if (!Utility.IsEmpty(miladiDate))
                {
                    return PersianDateTime.MiladiToShamsi(miladiDate);
                }
                return PersianDateTime.MiladiToShamsi(Utility.ToString(GTSMinStandardDateTime));
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// تبدیل میلادی به شمسی
        /// </summary>
        /// <param name="date">تاریخ میلادی</param>
        /// <returns></returns>
        public static PersianDateTime ToPersianDateTime(DateTime miladiDate)
        {
            try
            {
                PersianDateTime pd = new PersianDateTime(miladiDate);
                return pd;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// تاریخ را با فرمت سال/ماه/روز برمیگرداند
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static string ToString(DateTime date)
        {
            string str = date.ToString("u");
            str = str.Replace("-", "/");
            str = str.Remove(10);
            return str;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="enumration"></param>
        /// <returns></returns>
        public static string ToString(Enum enumration)
        {
            return enumration.ToString("G");
        }

        /// <summary>
        /// اگر تهی باشد خالی برمیگرداند
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static string ToString(object obj) 
        {
            if (obj != null)
                return obj.ToString();
            return String.Empty;

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static int ToInteger(string obj)
        {
            if (obj == null) return 0;
            int val = 0;
            if (Int32.TryParse(obj, out val))
            {
                return val;
            }
            return 0;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static int ToInteger(object obj)
        {
            if (obj == null) return 0;
            int val = 0;
            if (Int32.TryParse(obj.ToString(), out val))
            {
                return val;
            }
            return 0;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="bit"></param>
        /// <returns></returns>
        public static bool ToBoolean(char bit)
        {
            bool flag = false;
            if (bit.Equals('0'))
                flag = false;
            else if (bit.Equals('1'))
                flag = true;            
            return flag;
        }

        /// <summary>
        /// دوره محاسبات از روز و ماه تشکیل شده است که برای راحتی کار در مقایسه ها 
        /// کلیدی ایجاد شده است که از ماه و روز یک عدد میسازد
        /// این عدد 5 رقمی است و با فرمت زیر ساخته میشود
        /// '2'+(MM).ToString()+(DD).ToString()
        /// اگر ماه مربوط به سال قبل بود بجای 2 عدد یک و اگر مربوط به سال بعد عدد سه را میگزاریم
        /// </summary> 
        /// <param name="month">ماه </param>
        /// <param name="day">روز </param>
        /// <param name="yearStatus"> یک یعنی سال قبل - 2 یعنی سال جاری - 3 یعنی سال بعد </param>
        /// <returns></returns>
        public static int ToDateRangeIndex(int month, int day, int yearStatus)
        {
            if (yearStatus < 1 || yearStatus > 3)
                throw new Exception("وضعیت سال باید بین یک و سه باشد");
            string index = String.Format("{0}{1}{2}", yearStatus, month.ToString().PadLeft(2, '0'), day.ToString().PadLeft(2, '0'));
            return ToInteger(index);
        }

        /// <summary>
        /// اعداد را به پارسی تبدیل میکند
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public static String ToParsiCharacter(string text)
        {
            return text;
            string str =
                text.Replace('0', '٠')
                .Replace('1', '١')
                .Replace('2', '٢')
                .Replace('3', '٣')
                .Replace('4', '٤')
                .Replace('5', '٥')
                .Replace('6', '٦')
                .Replace('7', '٧')
                .Replace('8', '٨')
                .Replace('9', '٩');
            return str;
        }

        #region Perisan Date

        /// <summary>
        /// تعداد روز ماههای شمسی را برمیگرداند
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public static int GetEndOfPersianMonth(int year, int month)
        {
            int endOfMonth = new PersianCalendar().GetDaysInMonth(year, month);
            return endOfMonth;
        }

        /// <summary>
        /// ابتدای ماه شمسی را باتوجه به تاریخ میلادی برمیگرداند
        /// </summary>
        /// <param name="miladiDate"></param>
        /// <returns></returns>
        public static DateTime GetStartOfPersianMonth(DateTime miladiDate)
        {
            DateTime monthStart = new DateTime();
            PersianDateTime date = Utility.ToPersianDateTime(miladiDate);
            monthStart = Utility.ToMildiDate(String.Format("{0}/{1}/{2}", date.Year, date.Month, 1));
            return monthStart;
        }

        /// <summary>
        /// انتهای ماه شمسی را باتوجه به تاریخ میلادی برمیگرداند
        /// </summary>
        /// <param name="miladiDate"></param>
        /// <returns></returns>
        public static DateTime GetEndOfPersianMonth(DateTime miladiDate)
        {
            DateTime monthEnd = new DateTime();
            PersianDateTime date = Utility.ToPersianDateTime(miladiDate);
            int endOfMonth = new PersianCalendar().GetDaysInMonth(date.Year, date.Month);
            monthEnd = Utility.ToMildiDate(String.Format("{0}/{1}/{2}", date.Year, date.Month, endOfMonth));
            return monthEnd;
        }

        #endregion

        #region Miladi Date

        /// <summary>
        /// تعداد روزهای ماههای میلادی را برمیگرداند
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public static int GetEndOfMiladiMonth(int year, int month)
        {
            int endOfMonth = DateTime.DaysInMonth(year, month);
            return endOfMonth;
        }

        /// <summary>
        /// ابتدای ماه میلادی را باتوجه به تاریخ میلادی برمیگرداند
        /// </summary>
        /// <param name="miladiDate"></param>
        /// <returns></returns>
        public static DateTime GetStartOfMiladiMonth(DateTime miladiDate)
        {
            return new DateTime(miladiDate.Year, miladiDate.Month, miladiDate.Day);
        }

        /// <summary>
        /// انتهای ماه میلادی را باتوجه به تاریخ میلادی برمیگرداند
        /// </summary>
        /// <param name="miladiDate"></param>
        /// <returns></returns>
        public static DateTime GetEndOfMiladiMonth(DateTime miladiDate)
        {
            return new DateTime(miladiDate.Year, miladiDate.Month, Utility.GetEndOfMiladiMonth(miladiDate.Year, miladiDate.Month));
        }

        #endregion

        public static int GetCurrentYear() 
        {
            return new PersianDateTime(DateTime.Now).Year;
        }
        #endregion

        #region Checkers

        public static int CharOccuranceCount(string source,string sign)
        {
            if (Utility.IsEmpty(source) || Utility.IsEmpty(sign))
                return 0;
            int len1 = source.Length;
            source=source.Replace(sign,"");
            int len2 = source.Length;
            return len1 - len2;
        } 

        /// <summary>
        /// obj==null || obj.Length==0
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static bool IsEmpty(string obj)
        {
            if (obj == null || obj.Length == 0)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// obj==null 
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static bool IsEmpty(object obj)
        {
            if (obj == null)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// obj==null 
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static bool IsEmpty(bool obj)
        {
            if (obj == null)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// obj==null || obj == 0
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static bool IsEmpty(decimal? obj)
        {
            if (obj == null || obj == 0)
            {
                return true;
            }
            return false;
        }


        /// <summary>
        /// obj==null || obj == '0001/01/01'
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static bool IsEmpty(DateTime obj)
        {
            if (obj == null || (obj.Year == 1 && obj.Month == 1 && obj.Day == 1) || obj.Date == GTSMinStandardDateTime)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// list==null || list.count == 0
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static bool IsEmpty<T>(IList<T> list)
        {
            if (list == null || list.Count == 0)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// آیا رشته ورودی یک شماره است
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static bool IsNumber(string value)
        {
            if (Utility.IsEmpty(value))
                return false;
            Regex regex = new Regex(@"\d{" + ((int)(value.Length - 1)).ToString() + "}");
            return regex.IsMatch(value);
        }

        #endregion

    }
}
