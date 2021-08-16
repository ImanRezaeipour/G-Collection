using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using Model;

namespace Business
{
    public class BDynamicReservRange
    {
        private DynamicReservRangeDAL dynamicReservRangeDAL
        {

            get
            {
                return new DynamicReservRangeDAL();
            }
        }

        public wr_DynamicReserveRange GetDynamicReservRange()
        {
            try
            {
                return dynamicReservRangeDAL.GetDynamicReservRange();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public bool InsertDynamicReserveRange(wr_DynamicReserveRange wrDynamicReserveRange)
        {
            try
            {
                bool resultDelete = dynamicReservRangeDAL.DeleteAllDunamicReserveRange();
                if (resultDelete == true)
                {
                    return dynamicReservRangeDAL.InsertDynamicReserveRange(wrDynamicReserveRange);
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
