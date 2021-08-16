using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model
{
   public class ReportFishModel
    {

        public string Fish_Date { get; set; }
        public Int16 Fish_Type { get; set; }
        public string Fish_TypeName { get; set; }
        public Int16 Fish_No { get; set; }
        public string Fish_Barcode { get; set; }
        public Int16 Fish_FoodCode { get; set; }
        public decimal Fish_FoodPrice { get; set; }
        public int Fish_FoodPriceInt { get; set; }
        public string Fish_FoodName { get; set; }

    }
}
