using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using System.Security.Cryptography;

/// <summary>
/// Summary description for CryptData
/// </summary>
/// 
namespace CCServiceLibary
{
    public class CryptData
    {
        private byte[] IV = new byte[8] { 2, 5, 2, 7, 0, 2, 1, 7 };
        private string cryptoKey = "NewWebClock7";
        private TripleDESCryptoServiceProvider des = new TripleDESCryptoServiceProvider();
        private MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();

        public CryptData()
        {
            des.Key = md5.ComputeHash(System.Text.ASCIIEncoding.ASCII.GetBytes(cryptoKey));
            des.IV = IV;
        }
        public string EncryptData(string dataValue)
        {

            byte[] buffer = System.Text.Encoding.ASCII.GetBytes(dataValue);
            byte[] codedBuffer = des.CreateEncryptor().TransformFinalBlock(buffer, 0, buffer.Length);
            string encryptedData = Convert.ToBase64String(codedBuffer, 0, codedBuffer.Length);
            return encryptedData.Replace("+", "2B%");

        }
        public string DecryptData(string dataValue)
        {
            if (dataValue != null)
            {
                byte[] buffer = Convert.FromBase64String(dataValue.Replace("2B%", "+"));
                byte[] decodedBuffer = des.CreateDecryptor().TransformFinalBlock(buffer, 0, buffer.Length);
                string decryptedData = System.Text.Encoding.ASCII.GetString(decodedBuffer);
                return decryptedData;
            }
            else
            {
                return null;
            }
        }
    }
}