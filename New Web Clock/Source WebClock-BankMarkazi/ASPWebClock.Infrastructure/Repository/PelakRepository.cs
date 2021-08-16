using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace ASPWebClock.Infrastructure.Repository
{
    public class PelakRepository
    {
       


        public string Barcode { get; set; }
        public string Pelak1 { get; set; }
        public string Pelak2 { get; set; }

        public void InsertOrUdate() 
        {
            //Validate();
            //anprTable = pelakTA.GetDataByBarcode(Barcode);
            //if (anprTable.Rows.Count == 0) 
            //{
            //    pelakTA.InsertQuery(Barcode, Pelak1, Pelak2);
            //}
            //else if (anprTable.Rows.Count == 1)
            //{
            //    pelakTA.UpdateQuery(Pelak1, Pelak2, Barcode);
            //}
            //else if (anprTable.Rows.Count >1) 
            //{
            //    throw new Exception("برای یک بارکد بیش از یک رکورد موجود است");
            //}
        }

        //public PelakRepository GetByBarcode(string _barcode) 
        //{
        //    PelakRepository pelakRep = new PelakRepository();
        //    anprTable = pelakTA.GetDataByBarcode(_barcode);
        //    if (anprTable.Rows.Count == 1)
        //    {
        //        pelakRep.Barcode = Convert.ToString(anprTable.Rows[0]["P_BarcodeID"]);
        //        pelakRep.Pelak1 = Convert.ToString(anprTable.Rows[0]["P_PlateNo"]);
        //        pelakRep.Pelak2 = Convert.ToString(anprTable.Rows[0]["P_PlateNo2"]);
        //    }
        //    else if (anprTable.Rows.Count > 1)
        //    {
        //        throw new Exception("برای یک بارکد بیش از یک رکورد موجود است");
        //    }
        //    return pelakRep;
        //}
       
        private void Validate() 
        {
            if (Pelak1.Length !=0 && Pelak1.Length != 8)
                throw new Exception("فرمت پلاک نامعتبر است");
            if (Pelak2.Length != 0 && Pelak2.Length != 8)
                throw new Exception("فرمت پلاک نامعتبر است");
        }
    }
}
