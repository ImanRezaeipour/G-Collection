using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;

namespace DAL
{
    
   public class DynamicReservRangeDAL
    {
       FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();

       public wr_DynamicReserveRange GetDynamicReservRange()
       {

           try
           {
               wr_DynamicReserveRange dynamicReservRangeObj = new wr_DynamicReserveRange();
               dynamicReservRangeObj = contextFoodReserve.wr_DynamicReserveRanges.FirstOrDefault();
               return dynamicReservRangeObj;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }

       public bool InsertDynamicReserveRange(wr_DynamicReserveRange wrDynamicReserveRange)
       {
           try
           {
               return new GenerateAdoNetQuery().InsertQuery("wr_DynamicReserveRange", wrDynamicReserveRange);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public bool DeleteAllDunamicReserveRange()
       {
           try
           {
               Dictionary<string,string> paramDic=new Dictionary<string,string>();
               return new GenerateAdoNetQuery().DeleteQuery("wr_DynamicReserveRange", paramDic);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }

    }
}
