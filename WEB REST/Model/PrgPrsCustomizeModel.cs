using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model
{
    public class PrgPrsCustomizeModel
    {
        public PrgPrsCustomizeModel()
        {
            sumAllSupplementsPrice=0;
            PP_FoodPricePerson=0;
            PP_sumAllFoodSupplementPrice=0;
            

        }
        public class Supplements
        {
            public Supplements()
            {
                PP_SupplementPricePerson = 0;
            }
            public short? PP_SupplementsKeyID { get; set; }
            public bool? PP_SupplementsKeyValue { get; set; }
            public string PP_SupplementsName { get; set; }
            public short PP_SupplementCode { get; set; }
            public decimal? PP_SupplementPricePerson { get; set; }

        }
       
        
        public short? PP_KeyID { get; set; }
        public bool? PP_KeyValue { get; set; }
        public string PP_FoodName { get; set; }
        public short PP_FoodCode { get; set; }
        public string PP_Date { get; set; }
        public short? PP_Type { get; set; }
        public string  PP_PCode { get; set; }
        public string PP_MealName { get; set; }
        public int? PP_Building { get; set; }
        public string PP_BuildingName { get; set; }
        public string PP_strAllSupplements { get; set; }
        public decimal? sumAllSupplementsPrice { get; set; }
        public string PP_strAllFoods { get; set; }
        public decimal? PP_FoodPricePerson { get; set; }
        public Int64? PP_sumAllFoodSupplementPrice { get; set; }
        public List<Supplements> PP_SupplementsList { get; set; }
        
    }
}
