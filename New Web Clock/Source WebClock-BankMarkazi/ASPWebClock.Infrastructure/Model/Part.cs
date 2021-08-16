using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ASPWebClock.Infrastructure.Model
{
    public class Part
    {

        public virtual string P_Code
        {
            get;
            set;
        }
        public virtual string P_CustomCode
        {
            get;
            set;
        }
        public virtual string P_Name
        {
            get;
            set;
        }
        public virtual string P_LChild
        {
            get;
            set;
        }
        public virtual string P_RSibling
        {
            get;
            set;
        }
        public virtual string P_Father
        {
            get;
            set;
        }

    }
}
