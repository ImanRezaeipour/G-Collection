using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;

namespace DAL
{
   public class ReserveRangeDAL
    {

       FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();

       public wr_ReserveRange GetReserveRange()
       {
           try
           {
               wr_ReserveRange reserveRangeObj = new wr_ReserveRange();
               reserveRangeObj = contextFoodReserve.wr_ReserveRanges.FirstOrDefault();
               return reserveRangeObj;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       
       }
       public bool InsertReserveRange(wr_ReserveRange wrReserveRangeObj)
       {
           try
           {
               return new GenerateAdoNetQuery().InsertQuery("wr_ReserveRange", wrReserveRangeObj);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public bool DeleteAllReserveRange()
       {
           try
           {
               Dictionary<string,string> paramDic=new Dictionary<string,string>();
               return new GenerateAdoNetQuery().DeleteQuery("wr_ReserveRange", paramDic);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }

    }
}
