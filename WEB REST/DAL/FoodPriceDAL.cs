using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;

namespace DAL
{
   public class FoodPriceDAL
    {
       FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
       public foodpric GetFoodPriceByFoodCode(short? foodCode)
       {
           try
           {
              
               foodpric foodPriceObj = new foodpric();
               foodPriceObj = contextFoodReserve.foodprics.Where(fp => fp.FP_FoodCode == foodCode).OrderByDescending(f => f.FP_Date).FirstOrDefault();
               
               return foodPriceObj;
           }catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public List<foodpric> GetAllFoodPrice()
       {
           try
           {

               List<foodpric> foodListObj = new List<foodpric>();
               foodListObj = contextFoodReserve.foodprics.ToList();
               
               return foodListObj;
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }

    }
}
