using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;

namespace DAL
{
    public class GroupDAL
    {
        FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
        public group GetPersonShiftGroupByBarcode(string barcode)
        {

            try
            {
                group groupObj = new group();
                groupObj = contextFoodReserve.groups.SingleOrDefault(g => g.Grp_Code == contextFoodReserve.persons.SingleOrDefault(p => p.P_BarCode == barcode).P_ShiftGroup);
                //if (groupObj == null)
                //    throw new Exception("گروهی برای این پرسنل انتخاب نشده است.");
                return groupObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
