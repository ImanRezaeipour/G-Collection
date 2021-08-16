using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using DAL;

namespace Business
{
  public  class BFood
    {
      private FoodDAL foodDAL
      {

          get
          {
              return new FoodDAL();
          }
      }
      public foodlist GetFoodByID(short? ID)
      {

          try
          {
              return foodDAL.GetFoodByID(ID);
          }
          catch (Exception ex)
          {
              
              throw ex;
          }
      }
      public List<foodlist> GetAllFoodList()
      {
          try
          {
              return foodDAL.GetAllFoodList();
          }
          catch (Exception ex)
          {
              
              throw ex;
          }
      }
    }
}
