using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ASPWebClock.Infrastructure.Model
{
   public class LogProxy
    {
        public decimal ID { get; set; }
        public string UserName { get; set; }
        public decimal UserWebPassID { get; set; }
        public string barcode { get; set; }
        public string Action { get; set; }
        public bool Status { get; set; }
        public DateTime date { get; set; }
        public string Time { get; set; }
        public string PersianDate { get; set; }
        public string Comment { get; set; }
        public string LayerName { get; set; }
        public string MethodName { get; set; }
        public string PersonPost { get; set; }
    }
}
