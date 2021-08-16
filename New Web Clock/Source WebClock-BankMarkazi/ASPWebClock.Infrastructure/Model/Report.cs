using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace ASPWebClock.Infrastructure.Model
{
   public class Report
    {
       [DataObjectField(true,true,false)]
       public decimal Report_ID { get; set; }
       
       public string Report_Name { get; set; }
        
        public string Report_FileAddress { get; set; }
        public bool Report_IsCalculate { get; set; }
    }
}
