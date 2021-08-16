using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;

namespace ASPWebClock.Infrastructure.Model
{
    public class Person
    {
        #region Properties

        public virtual string Barcode
        {
            get;
            set;
        }

        public virtual int Status
        {
            get;
            set;
        }
        public string Name
        {
            get;
            set;
        }
        public string Family
        {
            get;
            set;
        }
        public Int16 Param
        {
            get;
            set;
        }
        #endregion

       


    }
}