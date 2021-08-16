using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;


namespace DAL
{
    public class FoodDAL
    {
        FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
        public foodlist  GetFoodByID(short? ID)
        {
            try
            {
                if (ID == null)
                    ID = 0;
                foodlist foodListObj = new foodlist();
                foodListObj = contextFoodReserve.foodlists.SingleOrDefault(f => f.Food_Code == ID);
                if (foodListObj == null)
                    throw new Exception("غذایی با کد " + ID + " وجود ندارد" );
                return foodListObj;
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

                List<foodlist> foodList = new List<foodlist>();
                foodList = contextFoodReserve.foodlists.ToList();
                return foodList;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
      
    }
}
