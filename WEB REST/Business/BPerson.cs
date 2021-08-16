using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using Model;

namespace Business
{
   public class BPerson
    {
       private PersonDAL personDAL
       {

           get
           {
               return new PersonDAL();
           }
       }
       public person GetPersonByBarocde(string barcode)
       {
           try
           {
               return personDAL.GetPersonByBarocde(barcode);
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
      
       public void GetPersonMealListByDate(string barcode,string date)
       {
           try
           {

           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public IList<person> SearchPersonInfoBayBarcodeNameFamily(string searchKey)
       {
           try
           {


               return (new PersonDAL().SearchPersonInfoBayBarcodeNameFamily(searchKey));
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }

       public bool ChangeCreditPerson(CreditStateEnum state,decimal? price,person personObj)
       {
           try
           {
               bool result = false;
               
               switch (state)
               {
                   case CreditStateEnum.Increase:
                       personObj.P_Credit = (personObj.P_Credit == null ? 0 : personObj.P_Credit) + price;
                       result= personDAL.UpdatePerson(personObj);
                       break;
                   case CreditStateEnum.Decrease:
                       personObj.P_Credit = (personObj.P_Credit == null ? 0 : personObj.P_Credit) - price;
                       result = personDAL.UpdatePerson(personObj);
                       break;
                   default:
                       break;
               }
               return result;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public bool IsPersonChangeCredit(person personObj)
       {
           try
           {
               bool result = false;
               if (personObj.P_Pricable == true)
               {

                   if (personObj.P_PrePaid == true)
                   {
                       result = true;
                   }
               }
               return result;
           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }
       public bool checkPersonHaveCredit(person personObj, decimal? foodPrice, Dictionary<string, string> paramDic)
       {
           try
           {

               int minCreditOrg = Convert.ToInt32(paramDic["minCredit"]);
               if (personObj.P_Pricable == true)
               {
                   if (personObj.P_PrePaid == true)
                   {
                       if (personObj.P_Credit - foodPrice > minCreditOrg)
                       {
                           return true;
                       }
                       else
                       {
                           return false;
                       }
                   }
                   else
                   {
                       return true;
                   }
               }
               else
               {
                   return true;
               }
           }
           catch (Exception ex)
           {

               throw ex;
           }
       }
    }
}
