using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ASPWebClock.Infrastructure.Model
{
   public class Pishcard
    {

        public int Code { get; set; }
        public string Name { get; set; }
        public bool Active { get; set; }
        public bool ActiveWeb { get; set; }
        public int InitCode { get; set; }
        public bool IsPermit { get; set; }
        public bool IsDaily { get; set; }
    }
}
