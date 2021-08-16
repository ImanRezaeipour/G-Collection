using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using Model;

namespace Business
{
    

   public class BReserveRange
    {
       private ReserveRangeDAL reserveRangeDAL
       {
           get
           {
               return new ReserveRangeDAL();
           }
       }


       public wr_ReserveRange GetReserveRange()
       {

           try
           {
               return reserveRangeDAL.GetReserveRange();
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
               bool resultDelete = reserveRangeDAL.DeleteAllReserveRange();
               if (resultDelete == true)
               {
                   return reserveRangeDAL.InsertReserveRange(wrReserveRangeObj);
               }
               else
               {
                   throw new Exception("خطا در ثبت اطلاعات.مجددا سعی نمایید.");
               }
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
