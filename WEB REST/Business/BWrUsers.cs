using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using Model;

namespace Business
{
    public class BWrUsers
    {
        public WrUsersDAL wrUserDAL
        {
            get
            {
                return new WrUsersDAL();
            }
        }
        public bool InsertNewUser(wr_User wrUserObj)
        {

            try
            {
                wrUserObj.lgn_Password= new BLogin().EncryptPassword(wrUserObj.lgn_Password);
                return wrUserDAL.InsertNewUser(wrUserObj);
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
                return wrUserDAL.DeleteUserOfPersonByID(id);
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
                return wrUserDAL.DeleteUserOfPersonByBarcode(barcode);
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
                return wrUserDAL.CheckUserNameExist(userName, barcode);
            }
            catch (Exception ex)
            {
                
                throw ex ;
            }
        }
        public bool UpdateUserOfPerson(wr_User wrUserObj,string id)
        {
            try
            {
                
                wrUserObj.lgn_Password = new BLogin().EncryptPassword(wrUserObj.lgn_Password);
                return wrUserDAL.UpdateUserOfPerson(wrUserObj,id);
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
                return wrUserDAL.GetAllUsers();
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
                return wrUserDAL.GetBarcodePersonByUsername(username);
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
                return wrUserDAL.CheckPersonHaveUser(barcode);
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
                return wrUserDAL.GetUserOfPerson(barcode);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
    }
}
