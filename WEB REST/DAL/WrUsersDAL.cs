using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using System.Data;

namespace DAL
{
   public class WrUsersDAL
    {
       FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
       public bool InsertNewUser(wr_User wrUserObj)
       {
           try
           {
               return new GenerateAdoNetQuery().InsertQuery("wr_Users", wrUserObj);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public bool DeleteUserOfPersonByID(string id)
       {
           try
           {
               Dictionary<string ,string> paramDic=new Dictionary<string,string>();
               paramDic.Add("ID", id);
               return new GenerateAdoNetQuery().DeleteQuery("wr_Users",paramDic);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public bool DeleteUserOfPersonByBarcode(string barcode)
       {
           try
           {
               Dictionary<string, string> paramDic = new Dictionary<string, string>();
               paramDic.Add("lgn_barcode", barcode);
               return new GenerateAdoNetQuery().DeleteQuery("wr_Users", paramDic);
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }
       public bool UpdateUserOfPerson(wr_User wrUserObj,string id)
       {
           try
           {
               Dictionary<string, string> paramDic = new Dictionary<string, string>();
               paramDic.Add("ID", id);
               return new GenerateAdoNetQuery().UpdateQuery("wr_Users", paramDic, wrUserObj);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public object GetAllUsers()
       {
           try
           {
               var usersObj = from  p in contextFoodReserve.persons
                              join u in contextFoodReserve.wr_Users on
                                 p.P_BarCode equals u.lgn_barcode into up
                              from userPerson in up.DefaultIfEmpty()
                              select new { UserName = userPerson.lgn_UserName ?? "",Barcode=p.P_BarCode, Name = p.P_Name, Family = p.P_Family };
               return usersObj;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public string GetBarcodePersonByUsername(string username)
       {
           try
           {
               string barcode = contextFoodReserve.wr_Users.SingleOrDefault(wr=>wr.lgn_UserName==username).lgn_barcode;
               return barcode;
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }
       public bool CheckUserNameExist(string userName, string barcode)
       {
           try
           {
               int countResult= contextFoodReserve.wr_Users.Where(u => u.lgn_UserName == userName && u.lgn_barcode != barcode).Count();
               if (countResult > 0)
                   return true;
               else
                   return false;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public bool CheckPersonHaveUser(string barcode)
       {
           try
           {
               int countResult= contextFoodReserve.wr_Users.Where(u => u.lgn_barcode == barcode).Count();
               if (countResult > 0)
                   return true;
               else
                   return false;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public wr_User GetUserOfPerson(string barcode)
       {
           try
           {
               wr_User wrUserObj = new wr_User();
               wrUserObj = contextFoodReserve.wr_Users.SingleOrDefault(u => u.lgn_barcode == barcode);
               return wrUserObj;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
    }
}
