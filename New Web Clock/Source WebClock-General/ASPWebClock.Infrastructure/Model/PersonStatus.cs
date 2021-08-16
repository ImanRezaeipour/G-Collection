using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;


namespace ASPWebClock.Infrastructure.Model
{
    public enum PersonStatus
    {
        unKnown=0,
        TAManagment = 1,
        FinalManagment = 2,
        EarlyManagment = 3,
        Operator = 4,
        Reporter = 5,
        SecondManagment = 6,
        User = 7
    }
}