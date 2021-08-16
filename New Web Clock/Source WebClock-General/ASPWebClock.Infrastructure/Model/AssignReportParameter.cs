using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace ASPWebClock.Infrastructure.Model
{
   public  class AssignReportParameter
    {
        [DataObjectField(true,true,false)]
        public  int AssignReportParameter_ID { get; set; }
        public  int AssignReportParameter_ReportID { get; set; }
        public  int AssignReportParameter_ReportParameterID { get; set; }
    }
}
