using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;

namespace DAL
{
    public class BuildingDAL
    {
        FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
        public List<building> GetAllBuildings()
        {
            try
            {
                List<building> buildingObj = contextFoodReserve.buildings.ToList();
                return buildingObj;
              
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        public building GetBuildingByID(short id)
        {
            try
            {
                building buildingObj = contextFoodReserve.buildings.SingleOrDefault(b => b.Building_Code == id);
                return buildingObj;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
    }
}
