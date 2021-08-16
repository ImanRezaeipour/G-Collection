using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ASPWebClock.Infrastructure.Model
{
     
     public class WebLoginUserProxy
    {
         
        public decimal ID { get; set; }
        public string Barcode { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public string Family { get; set; }
        public string NameFamily { get; set; }
    }
}
