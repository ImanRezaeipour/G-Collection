using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using DAL;

namespace Business
{
   public class BBuilding
    {
       private BuildingDAL buildingDAL
       {
           get
           {
               return new BuildingDAL();
           }
       }
       public List<building> GetAllBuildings()
       {
           try
           {
               return buildingDAL.GetAllBuildings();
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
               return buildingDAL.GetBuildingByID(id);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
