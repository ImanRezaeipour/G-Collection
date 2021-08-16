using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace ConvertorDataFromOWCToNWC.Model
{
   public class NW_WebpassPersons
    {
       [DataObjectField(true, true, false)]
       public decimal ID { get; set; }
        public string PersonBarCode { get; set; }
        public bool isKarkardfrm { get; set; }
        public bool isRequestfrm { get; set; }
        public bool isOperatorfrm { get; set; }
        public bool isKeeperfrm { get; set; }
        public bool isOverTimefrm { get; set; }
        public bool isPerson { get; set; }
        public bool isPart { get; set; }
        public bool isSubPart { get; set; }
        public bool AccessType { get; set; }
        public decimal WebPassId { get; set; }
    }
}
