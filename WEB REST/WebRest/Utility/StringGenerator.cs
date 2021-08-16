using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebRest.Utility
{
    public class StringGenerator
    {
        public string CreateString(string str)
        {
            try
            {
                str = str.Replace("//", "/");
                string[] KeyCodeArray = str.Split('/');
                string RetString = string.Empty;
                for (int i = 0; i < KeyCodeArray.Length; i++)
                {
                    if (KeyCodeArray[i] != string.Empty)
                    {
                        ///ي = 1610  , ئ = 1574  , ی = 1740
                        if (KeyCodeArray[i] == "1740" || KeyCodeArray[i] == "1574")
                            KeyCodeArray[i] = "1610";
                        ///ك = 1603 , ک = 1705
                        if (KeyCodeArray[i] == "1603")
                            KeyCodeArray[i] = "1705";
                        RetString += Convert.ToChar(Convert.ToInt32(KeyCodeArray[i]));
                    }
                }
                return RetString;
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }
        public string TruePersianKeyboard(string str)
        {
            try
            {

                string RetString = string.Empty;
                List<char> keyCodeList = new List<char>();
                for (int i = 0; i < str.Length; i++)
                {

                    keyCodeList.Add(str[i]);

                }
                char[] keyCodeArray = keyCodeList.ToArray();
                for (int j = 0; j < str.Length; j++)
                {
                    if (keyCodeArray[j].ToString() != string.Empty)
                    {
                        ///ي = 1610  , ئ = 1574  , ی = 1740
                        if ((int)keyCodeArray[j] == 1740 || (int)keyCodeArray[j] == 1574)
                            keyCodeArray[j] = Convert.ToChar(1610);
                        ///ك = 1603 , ک = 1705
                        //if ((int)keyCodeArray[j] == 1603)
                        //    keyCodeArray[j] = Convert.ToChar(1705);
                        RetString += keyCodeArray[j].ToString();
                    }
                }
                return RetString;
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }

    }
}