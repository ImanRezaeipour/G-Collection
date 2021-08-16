using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using Model;

namespace Business
{
   public  class BFish
    {
       public FishDAL fishDAL
       {
           get
           {
               return new FishDAL();
           }
       }
       public List<ReportFishModel> GetFishFoodPerson(person personObj, string fromDate, string toDate, string mealType)
       {
           try
           {
               List<ReportFishModel> reportFishModelList=fishDAL.GetFishFoodPerson(personObj, fromDate, toDate,mealType);
               for (int i = 0; i < reportFishModelList.Count; i++)
               {
                   switch (reportFishModelList[i].Fish_Type)
                   {
                       case 1:
                           {
                               reportFishModelList[i].Fish_TypeName = "صبحانه";
                               break;
                           }
                       case 2:
                           {
                               reportFishModelList[i].Fish_TypeName = "ناهار";
                               break;
                           }
                       case 3:
                           {
                               reportFishModelList[i].Fish_TypeName = "شام";
                               break;
                           }
                       default:
                           break;
                   }
                   reportFishModelList[i].Fish_FoodPriceInt =Convert.ToInt32(reportFishModelList[i].Fish_FoodPrice);
               }
               return reportFishModelList;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public fish GetFishFoodPersonByDateByType(person personObj, string date, short type)
       {
           try
           {
               return new FishDAL().GetFishFoodPersonByDateByType(personObj, date, type);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
