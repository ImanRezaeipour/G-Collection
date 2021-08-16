using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;
using System.Data;

namespace Business
{
   public static class Utility
    {
       public static DateTime ShamsiToMiladi(string _date)
       {
           int year = int.Parse(_date.Substring(0, 4));
           int month = int.Parse(_date.Substring(5, 2));
           int day = int.Parse(_date.Substring(8, 2));
           PersianCalendar p = new PersianCalendar();
           DateTime date = p.ToDateTime(year, month, day, 0, 0, 0, 0);
           return date;
       }
       public static string MiladiToShamsi(DateTime miladiDate)
       {
           try
           {
               PersianDateTime pDate = new PersianDateTime(miladiDate);

               return pDate.PersianDate;
           }
           catch (Exception e)
           {
               throw new Exception(String.Format("Sended date: {0} {1}", miladiDate, e.Message));
           }
       }
       public static string GetEndDayOfMonth(string date)
       {
           try
           {
           System.Globalization.PersianCalendar pCalendar = new System.Globalization.PersianCalendar();
           int month = Convert.ToInt32(date.Substring(5, 2));
           int year = Convert.ToInt32(date.Substring(0, 4));
           int endDayOfMonth = pCalendar.GetDaysInMonth(year, month);
           return endDayOfMonth.ToString();
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
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
       public static string NumberToCurrencyFormat(string number)
       {
           string currencyNumber = string.Empty;
           int counter = 0;
           for (int i = number.Length - 1; i >= 0; i--)
           {
               if (counter == 3)
               {
                   currencyNumber = "," + currencyNumber; ;
                   currencyNumber = number[i] + currencyNumber;
                   counter = 1;
               }
               else
               {
                   currencyNumber = number[i] + currencyNumber;
                   counter += 1;
               }

           }
           return currencyNumber;
       }
    }
}
