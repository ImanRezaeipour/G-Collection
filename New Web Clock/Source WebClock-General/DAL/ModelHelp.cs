using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAL
{
    public class ModelHelp
    {

        public decimal Help_ID { get; set; }
        public decimal Help_ParantID { get; set; }
        public string Help_FaName { get; set; }
        public string Help_EnName { get; set; }
        public string Help_FaHTMLContent { get; set; }
        public string Help_EnHTMLContent { get; set; }
        public string Help_FormKey { get; set; }
        public int Help_LevelOrder { get; set; }
    }
}
