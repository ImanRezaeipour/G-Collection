using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Globalization;

namespace ASPWebclock.AppCode
{
    public class PersianDateTime
    {
        public static DateTime Shamsi2Miladi(string _date)
        {
            int year = int.Parse(_date.Substring(0, 4));
            int month = int.Parse(_date.Substring(5, 2));
            int day = int.Parse(_date.Substring(8, 2));
            PersianCalendar p = new PersianCalendar();
            DateTime date = p.ToDateTime(year, month, day, 0, 0, 0, 0);
            return date;
        }

        public static string ShamsiDate(DateTime MiladiDate)
        {
            PersianCalendar jc = new PersianCalendar();

            DateTime thisDate = MiladiDate;
            return jc.GetYear(thisDate).ToString() + "/" + (jc.GetMonth(thisDate) < 10 ? "0" : "") + jc.GetMonth(thisDate).ToString() + "/" + (jc.GetDayOfMonth(thisDate) < 10 ? "0" : "") + jc.GetDayOfMonth(thisDate).ToString();
        }
        public static string GetMonthName(string month)
        {
            string result = "";
            switch (month)
            {
                case "01":
                    {
                        result = "فروردین";
                        break;
                    }
                case "02":
                    {
                        result = "اردیبهشت";
                        break;
                    }
                case "03":
                    {
                        result = "خرداد";
                        break;
                    }
                case "04":
                    {
                        result = "تیر";
                        break;
                    }
                case "05":
                    {
                        result = "مرداد";
                        break;
                    }
                case "06":
                    {
                        result = "شهریور";
                        break;
                    }
                case "07":
                    {
                        result = "مهر";
                        break;
                    }
                case "08":
                    {
                        result = "آبان";
                        break;
                    }
                case "09":
                    {
                        result = "آذر";
                        break;
                    }
                case "10":
                    {
                        result = "دی";
                        break;
                    }
                case "11":
                    {
                        result = "بهمن";
                        break;
                    }
                case "12":
                    {
                        result = "اسفند";
                        break;
                    }
                default:
                    break;
            }
            return result;
        }
    }
}