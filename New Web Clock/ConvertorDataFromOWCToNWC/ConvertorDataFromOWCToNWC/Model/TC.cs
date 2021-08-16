using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConvertorDataFromOWCToNWC.Model
{
   public class TC
    {
        public string Clock_BarCode { get; set; }
        public string Clock_Date { get; set; }
        public string Clock_SendDate { get; set; }
        public string Clock_AgreeDate { get; set; }
        public int Clock_Time { get; set; }
        public int Clock_eTime { get; set; }
        public int Clock_RdrCode { get; set; }
        public int Clock_Chg { get; set; }
        public int Clock_RecState { get; set; }
        public string Clock_User { get; set; }
        public string Clock_RecDes { get; set; }
        public int Clock_FirstlyAgree { get; set; }
        public string Clock_FirstlyAgree_BarCode { get; set; }
        public int Clock_FinallyAgree { get; set; }
    }
}
