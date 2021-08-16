using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using ASPWebClock.Infrastructure.Utility;

namespace ASPWebClock.Infrastructure.Repository
{
    public class RepositoryBase
    {
        protected dbConnection Connection = new dbConnection();
        
    }

   
}
