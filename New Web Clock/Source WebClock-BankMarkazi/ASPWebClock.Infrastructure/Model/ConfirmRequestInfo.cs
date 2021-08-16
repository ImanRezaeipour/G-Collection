using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ASPWebClock.Infrastructure.Model
{
  public  class ConfirmRequestInfo
    {
        public decimal RequestID { get; set; }
        public decimal ManagerID { get; set; }
        public int StatusID { get; set; }
    }
}
