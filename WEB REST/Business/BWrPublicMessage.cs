using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using DAL;
namespace Business
{
   public class BWrPublicMessage
    {
       public WrPublicMessageDAL wrPublicMessageDAL
       {
           get
           {
               return new WrPublicMessageDAL();
           }
       }
       public bool InsertNewPublicMessage(wr_PublicMessage wrPublicMessageObj)
       {
           try
           {
               return wrPublicMessageDAL.InsertNewPublicMessage(wrPublicMessageObj);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public wr_PublicMessage GetLastPublicMessage()
       {
           try
           {
               return wrPublicMessageDAL.GetLastPublicMessage();
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
