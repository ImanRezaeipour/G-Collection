using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using System.Data.SqlClient;
using System.Data;

namespace DAL
{
   public class WeekDAL
    {
       dbConnection connection=new dbConnection();
       FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
       public week GetFoodWeekByDateByType(string date,short type)
       {
           try
           {
               
        

               week weekObj = new week();
              weekObj = contextFoodReserve.weeks.SingleOrDefault(w => w.Week_Date == date && w.Week_Type == type);

              return weekObj;


              
           }
           catch (Exception ex)
           {

               throw new Exception("ارتباط با پایگاه داده برقرار نمی باشد.لطفا مجددا سعی نمایید" +  ex);
           }
       }
    }
}
