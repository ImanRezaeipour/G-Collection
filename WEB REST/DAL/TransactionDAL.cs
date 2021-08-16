using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Model;

namespace DAL
{
   public class TransactionDAL
    {
       
      
       public bool ExecuteTransaction(List<TransactionProxy> transModelList )
       {
           try
           {
               List<SqlCommand> sqlCommandList = new List<SqlCommand>();
               foreach (TransactionProxy item in transModelList)
               {
                   SqlCommand command=new SqlCommand();
                   switch (item.TypeQuery)
                   {
                       case TransactionProxy.TypeQueryEnum.Insert:
                           command = new GenerateAdoNetQuery().GetSqlCommandInsertQuery(item.Object);
                           sqlCommandList.Add(command);
                           break;
                       case TransactionProxy.TypeQueryEnum.Update:

                           command = new GenerateAdoNetQuery().GetSqlCommnadUpdateQuery(item.WhereParametersDic, item.Object);
                           sqlCommandList.Add(command);
                           break;
                       case TransactionProxy.TypeQueryEnum.Select:
                           
                           break;
                       case TransactionProxy.TypeQueryEnum.Delete:
                           command = new GenerateAdoNetQuery().GetSqlCommandDeleteQuery(item.WhereParametersDic, item.Object);
                           sqlCommandList.Add(command);
                           break;
                       default:
                           break;
                   }
               }

               bool result= new GenerateAdoNetQuery().executeNonQueryWithTransaction(sqlCommandList.ToArray());
               return result;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
