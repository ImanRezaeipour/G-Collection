using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;

namespace DAL
{
   public  class FishDAL
    {

       FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();

       public List<ReportFishModel> GetFishFoodPerson(person personObj,string fromDate,string toDate,string mealType)
       {
           try
           {
               string whereMealType = string.Empty;
               List<ReportFishModel> reportFishModelList;
               if (mealType == "All")
               {
                   string query = @"select fish_date , fish_type,fish_no,fish_pcode as fish_barcode,ff_food as fish_foodCode,ff_price as fish_foodPrice,Food_Name as fish_foodName from fish 
                                join fishfood on fish.Fish_Date=fishfood.FF_Date and  fish.Fish_No=fishfood.FF_FishNo and fish.Fish_Type=fishfood.FF_Type
                                join foodlist on FF_Food=foodlist.Food_Code
                            where Fish_PCode={0} and Fish_Date>={1} and Fish_Date<={2} " + whereMealType + " order by Fish_Date ,fish_Type ";
                    reportFishModelList = contextFoodReserve.ExecuteQuery<ReportFishModel>(query, personObj.P_BarCode, fromDate, toDate).ToList();
                   whereMealType = string.Empty;
               }
               else
               {
                   string query = @"select fish_date , fish_type,fish_no,fish_pcode as fish_barcode,ff_food as fish_foodCode,ff_price as fish_foodPrice,Food_Name as fish_foodName from fish 
                                join fishfood on fish.Fish_Date=fishfood.FF_Date and  fish.Fish_No=fishfood.FF_FishNo and fish.Fish_Type=fishfood.FF_Type
                                join foodlist on FF_Food=foodlist.Food_Code
                            where Fish_PCode={0} and Fish_Date>={1} and Fish_Date<={2} " + whereMealType;
                   reportFishModelList = contextFoodReserve.ExecuteQuery<ReportFishModel>(query, personObj.P_BarCode, fromDate, toDate, mealType).ToList();
                   whereMealType = " and Fish_Type={3}";
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
               string whereMealType = string.Empty;
               fish fishObj = null;
               fishObj = contextFoodReserve.fishes.SingleOrDefault(f=>f.Fish_Date==date && f.Fish_PCode==personObj.P_BarCode && f.Fish_Type==type);
               

               return fishObj;
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }
    }
}
