using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace ConvertorDataFromOWCToNWC.Model
{
   public class NW_WebLogin
    {
       [DataObjectField(true, true, false)]
       public decimal ID { get; set; }
        public string lgn_barcode { get; set; }
        public string lgn_UserName { get; set; }
        public string lgn_Password { get; set; }
    }
}
