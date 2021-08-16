using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;

namespace Business
{
   public class BDatabaseCreator
    {

       public bool ExistWebRestTablesInDatabse()
       {
           try
           {
               return new DatabaseCreatorDAL().ExistWebRestTablesInDatabse();
           }
           catch (Exception ex)
           {
               
               throw;
           }
       }
       public bool CreateWebRestTablesInDatabase()
       {

           try
           {
               return new DatabaseCreatorDAL().CreateWebRestTablesInDatabase();
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
