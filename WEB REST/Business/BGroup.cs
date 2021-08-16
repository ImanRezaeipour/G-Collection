using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using Model;

namespace Business
{
   public class BGroup
    {
       public group GetPersonShiftGroupByBarcode(string barcode)
       {

           try
           {
               return new GroupDAL().GetPersonShiftGroupByBarcode(barcode);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }

       public Dictionary<int, string> GetPersonMealByShiftGroupByDate(string barcode, string date, Dictionary<string, string> paramDic)
       {

           try
           {
               group personGroup = GetPersonShiftGroupByBarcode(barcode);
               string year = date.Substring(0, 4);
               string month = date.Substring(5, 2);
               string day = date.Substring(8, 2);
               Dictionary<int, string> MealPersonDic = new Dictionary<int, string>();
               string personMealGroupInMonth = string.Empty;
               string personMealGroupInDay = string.Empty;
               if (personGroup != null)
               {
                   switch (month)
                   {
                       case "01":
                           {
                               personMealGroupInMonth = personGroup.Grp_M1;
                               break;
                           }
                       case "02":
                           {
                               personMealGroupInMonth = personGroup.Grp_M2;
                               break;
                           }
                       case "03":
                           {
                               personMealGroupInMonth = personGroup.Grp_M3;
                               break;
                           }
                       case "04":
                           {
                               personMealGroupInMonth = personGroup.Grp_M4;
                               break;
                           }
                       case "05":
                           {
                               personMealGroupInMonth = personGroup.Grp_M5;
                               break;
                           }
                       case "06":
                           {
                               personMealGroupInMonth = personGroup.Grp_M6;
                               break;
                           }
                       case "07":
                           {
                               personMealGroupInMonth = personGroup.Grp_M7;
                               break;
                           }
                       case "08":
                           {
                               personMealGroupInMonth = personGroup.Grp_M8;
                               break;
                           }
                       case "09":
                           {
                               personMealGroupInMonth = personGroup.Grp_M9;
                               break;
                           }
                       case "10":
                           {
                               personMealGroupInMonth = personGroup.Grp_M10;
                               break;
                           }
                       case "11":
                           {
                               personMealGroupInMonth = personGroup.Grp_M11;
                               break;
                           }
                       case "12":
                           {
                               personMealGroupInMonth = personGroup.Grp_M12;
                               break;
                           }

                       default:
                           break;
                   }
                   personMealGroupInDay = personMealGroupInMonth[int.Parse(day) - 1].ToString();
               }
               else
               {
                   int mealGroup = 0;
                   if (paramDic["MB_SOBH"] == "1")
                       mealGroup = 1;
                   if (paramDic["MB_NAHAR"] == "1")
                       mealGroup = 2;
                   if (paramDic["MB_SHAM"] == "1")
                       mealGroup = 3;
                   if (paramDic["MB_SOBH"] == "1" && paramDic["MB_NAHAR"] == "1")
                       mealGroup = 4;
                   if (paramDic["MB_NAHAR"] == "1" && paramDic["MB_SHAM"] == "1")
                       mealGroup = 5;
                   if (paramDic["MB_SOBH"] == "1" && paramDic["MB_SHAM"] == "1")
                       mealGroup = 6;
                   if (paramDic["MB_SOBH"] == "1" && paramDic["MB_NAHAR"] == "1" && paramDic["MB_SHAM"] == "1")
                       mealGroup = 7;
                   personMealGroupInDay = mealGroup.ToString();
               }
             
             MealGroupEnum mealPerson=(MealGroupEnum)Enum.Parse(typeof(MealGroupEnum), personMealGroupInDay);
             MealPersonDic = GetDicMealByType(mealPerson);
             return MealPersonDic;
              
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }

       public Dictionary<int, string> GetDicMealByType(MealGroupEnum meal)
       {
           Dictionary<int, string> mealDic = new Dictionary<int, string>();
           switch (meal)
           {
               case MealGroupEnum.Rest:
                   mealDic.Add(0,"استراحت");
                   break;
               case MealGroupEnum.Breakfast:
                   mealDic.Add(1, "صبحانه");
                   break;
               case MealGroupEnum.Launch:
                   mealDic.Add(2, "ناهار");
                   break;
               case MealGroupEnum.Dinner:
                   mealDic.Add(3, "شام");
                   break;
               case MealGroupEnum.BreakfastLaunch:
                   mealDic.Add(1, "صبحانه");
                   mealDic.Add(2, "ناهار");
                   break;
               case MealGroupEnum.LaunchDinner:
                   mealDic.Add(2, "ناهار");
                   mealDic.Add(3, "شام");
                   break;
               case MealGroupEnum.DinnerBreakfast:
                   mealDic.Add(3, "شام");
                   mealDic.Add(1, "صبحانه");
                   break;
               case MealGroupEnum.BreakfastLaunchDinner:
                   mealDic.Add(1, "صبحانه");
                   mealDic.Add(2, "ناهار");
                   mealDic.Add(3, "شام");
                   break;
               default:
                   break;
           }
           return mealDic;
       }

    }
}
