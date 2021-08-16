using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Model;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class PersonDAL
    {

        FoodReserveDataContext contextFoodReserve = new FoodReserveDataContext();
        
       
        public person GetPersonByBarocde(string barcode)
        {
            try
            {
                
                
                person personObj = new person();
                personObj = contextFoodReserve.persons.SingleOrDefault(p => p.P_BarCode == barcode);
                return personObj;
               
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        public IList<person> SearchPersonInfoBayBarcodeNameFamily(string SearchKey)
        {
            List<person> personList = new List<person>();
           
            try
            {
                personList = contextFoodReserve.persons.Where(p => p.P_BarCode.Contains(SearchKey) || p.P_Name.Contains(SearchKey) || p.P_Family.Contains(SearchKey)).ToList();

              




                return personList;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

       
        public bool UpdatePerson(person personObj)
        {
            try
            {
               
                Dictionary<string, string> paramDic = new Dictionary<string, string>();
                paramDic.Add("P_Barcode", personObj.P_BarCode);
                bool result = new GenerateAdoNetQuery().UpdateQuery(personObj.tableName, paramDic, personObj);
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
