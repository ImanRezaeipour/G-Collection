using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ASPWebClock.Infrastructure.Model
{
   public class ReportParameterProxy 
    {
        public int AssignReportParameter_ID { get; set; }
        public int AssignReportParameter_ReportID { get; set; }
        public int ReportParameterType_ID { get; set; }
        public string ReportParameterType_Value { get; set; }
    }
}
