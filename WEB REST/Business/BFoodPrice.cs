using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using DAL;

namespace Business
{
   public class BFoodPrice
    {
       private FoodPriceDAL foodPriceDAL
       {

           get
           {
               return new FoodPriceDAL();
           }
       }
       public foodpric GetFoodPriceByFoodCode(short? foodCode)
       {

           try
           {
               return foodPriceDAL.GetFoodPriceByFoodCode(foodCode);
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }
       public foodPriceProxy GetFoodPricePersonByFoodCode(short? foodCode,person personObj,Dictionary<string,string> paramDic)
       {

           try
           {
               foodpric foodPriceObj = foodPriceDAL.GetFoodPriceByFoodCode(foodCode);
               foodPriceProxy foodPriceProxyObj = null;
               switch (personObj.P_CashType)
               {
                   case 0:
                       {
                           foodPriceProxyObj = new foodPriceProxy() { FP_Date = foodPriceObj.FP_Date, FP_FoodCode = foodPriceObj.FP_FoodCode, FP_Price = paramDic["foodPriceType"] == "0" ? foodPriceObj.FP_PricePerson : foodPriceObj.FP_PriceFee };
                           break;
                       }
                   case 1:
                       {
                           foodPriceProxyObj = new foodPriceProxy() { FP_Date = foodPriceObj.FP_Date, FP_FoodCode = foodPriceObj.FP_FoodCode, FP_Price =foodPriceObj.FP_PricePerson };
                           break;
                       }
                   case 2:
                       {
                           foodPriceProxyObj = new foodPriceProxy() { FP_Date = foodPriceObj.FP_Date, FP_FoodCode = foodPriceObj.FP_FoodCode, FP_Price = foodPriceObj.FP_PriceFee };
                           break;
                       }
                   default:
                       foodPriceProxyObj = new foodPriceProxy() { FP_Date = foodPriceObj.FP_Date, FP_FoodCode = foodPriceObj.FP_FoodCode, FP_Price = foodPriceObj.FP_PricePerson };
                       break;
               }
               return foodPriceProxyObj;
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }
       public List<foodpric> GetAllFoodPrice()
       {
           try
           {
               return foodPriceDAL.GetAllFoodPrice();
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }

    }
}
