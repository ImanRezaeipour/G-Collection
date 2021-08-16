using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;

namespace DAL
{
   public class WrPublicMessageDAL
    {

       FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();

       public bool InsertNewPublicMessage(wr_PublicMessage wrPublicMessageObj)
       {
           try
           {
               return new GenerateAdoNetQuery().InsertQuery("wr_PublicMessage", wrPublicMessageObj);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public wr_PublicMessage GetLastPublicMessage()
       {
           try
           {
               wr_PublicMessage wrPublicMessage = new wr_PublicMessage();
               wrPublicMessage = contextFoodReserve.wr_PublicMessages.OrderByDescending(f => f.id).FirstOrDefault();
               return wrPublicMessage;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
