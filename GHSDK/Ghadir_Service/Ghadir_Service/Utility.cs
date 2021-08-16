using System;
using System.Collections.Generic;
using System.Text;
using System.Net;

namespace Ghadir_Service
{
    public class Utility
    {
        public static Boolean IsDateString(string Date)
        {
            if (Date.Length != 8)
                return false;
            if (Date[2] != '/' || Date[5] != '/')
                return false;
           
            for (int t = 0; t < Date.Length; t++)
            {
                if (t == 2 || t == 5)
                    continue;
                if (!Char.IsNumber(Convert.ToChar(Date[t])))
                    return false;
            }
            try
            {
                if (Convert.ToInt32(Date.Substring(3, 2)) > 12)
                    return false;
                if (Convert.ToInt32(Date.Substring(6, 2)) > 31)
                    return false;
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static Boolean IsTimeString(string time)
        {
            if (time.Length != 5)
                return false;
            if (time[2] != ':')
                return false;

            for (int t = 0; t < time.Length; t++)
            {
                if (t == 2 || t == 5)
                    continue;
                if (!Char.IsNumber(Convert.ToChar(time[t])))
                    return false;
            }

            if (Convert.ToInt32(time.Substring(0, 2)) > 23)
                return false;
            if (Convert.ToInt32(time.Substring(3, 2)) > 59)
                return false;
            return true;
        }

        public static DateTime GenerateDateTime(string Date, string Time)
        {
            DateTime r = new DateTime(1, 1, 1, 1, 1, 1);

            r = r.AddHours(Convert.ToInt32(Time.Substring(0, 2)) - 1);
            r = r.AddMinutes(Convert.ToInt32(Time.Substring(3, 2)) - 1);

            r = r.AddYears(Convert.ToInt32(Date.Substring(0, 2)) - 1);
            r = r.AddMonths(Convert.ToInt32(Date.Substring(3, 2)) - 1);
            r = r.AddDays(Convert.ToInt32(Date.Substring(6, 2)) - 1);

            return r;
        }

        public static String ChangeToHex(UInt64 Number)
        {
            string temp = string.Empty;
            if (Number == 0)
                return "0";
            UInt64 uint_temp = 0;
            for (; Number > 0; )
            {
                uint_temp = Number % 16;
                if (uint_temp < 10)
                   temp = temp.Insert(0, Convert.ToString(Convert.ToChar(uint_temp + 48)));
                else
                    temp = temp.Insert(0,Convert.ToString( Convert.ToChar(uint_temp + 55)));
                Number /= 16;
            }
            return temp;
        }

        public static String ChangeToHex(UInt64 Number,UInt64 FixedSize)
        {
            string temp = string.Empty;
            if (Number == 0) 
                return "0";

            UInt64 uint_temp = 0;
            for (; Number > 0; )
            {
                uint_temp = Number % 16;
                if (uint_temp < 10)
                    temp = temp.Insert(0, Convert.ToString(Convert.ToChar(uint_temp + 48)));
                else
                    temp = temp.Insert(0, Convert.ToString(Convert.ToChar(uint_temp + 55)));
                Number /= 16;
            }
            for (int t = temp.Length; t <(int) FixedSize; t++)
                temp = temp.Insert(0, "0");

            return temp;
        }

        public static UInt64 ChangeToDecimal(string Number)
        {
            UInt64 temp = 0;
            Char char_temp;
            Number = Number.ToUpper();

            for (int t = 0; t < Number.Length; t++)
                if (!(Number[t] >= 48 && Number[t] <= 57 || Number[t] >= 65 && Number[t] <= 70))
                    return 0;

            for (int t=0;t<Number.Length;t++)
            {
                temp *=16;
                char_temp = Number[t];
                if (Char.IsNumber(char_temp))
                    temp += Convert.ToUInt64(char_temp - 48);
                else
                    temp += Convert.ToUInt64(char_temp - 55);
                }



            return temp;

        }

        public static Byte GetHighNibble(Byte Data)
        {
            Byte temp;
            temp = Convert.ToByte(Data & 0xf0);
            temp >>= 4;
            return temp;
        }

        public static Byte GetLowNibble(Byte Data)
        {
            Byte temp;
            temp = Convert.ToByte(Data & 0x0f);           
            return temp;
        }

        public static Byte SwapNibbles(Byte Data)
        {
            Byte temp = Convert.ToByte(GetLowNibble(Data) * 16 + GetHighNibble(Data));
            return temp;
        }

        public static IPEndPoint GetEndPoint(string IP, int Port)
        {
            string[] str = new string[4];
            IPEndPoint temp = new IPEndPoint(0,0);

            for (int t = 0; t < 4; t++)
            {
                if ( t != 3 && IP.IndexOf('.') == -1)
                    return temp;
                if (t != 3)
                {
                    str[t] = IP.Substring(0, IP.IndexOf('.'));
                    IP = IP.Remove(0, IP.IndexOf('.') + 1);
                }
                else 
                    str[t] = IP;
                if (str[t].Length > 3)
                    return temp;
                try
                {
                    if (Convert.ToInt32(str[t]) > 255) 
                        return temp;
                }
                catch
                {
                    return temp;
                }
            }

            UInt32 u = Convert.ToUInt32(str[3]) * 256 * 256 * 256 + Convert.ToUInt32(str[2]) * 256 * 256 + Convert.ToUInt32(str[1]) * 256 + Convert.ToUInt32(str[0]);
            temp.Address = new IPAddress(u);
            temp.Port = Port; 
            return temp;
        }

        public static IPAddress GetIPAddress(string IP)
        {
            string[] str = new string[4];
            IPEndPoint temp = new IPEndPoint(0, 0);

            for (int t = 0; t < 4; t++)
            {
                if (t != 3 && IP.IndexOf('.') == -1)
                    return temp.Address;
                if (t != 3)
                {
                    str[t] = IP.Substring(0, IP.IndexOf('.'));
                    IP = IP.Remove(0, IP.IndexOf('.') + 1);
                }
                else
                    str[t] = IP;
                if (str[t].Length > 3)
                    return temp.Address;
                try
                {
                    if (Convert.ToInt32(str[t]) > 255)
                        return temp.Address;
                }
                catch
                {
                    return temp.Address;
                }
            }

            UInt32 u = Convert.ToUInt32(str[3]) * 256 * 256 * 256 + Convert.ToUInt32(str[2]) * 256 * 256 + Convert.ToUInt32(str[1]) * 256 + Convert.ToUInt32(str[0]);
            temp.Address = new IPAddress(u);
            return temp.Address;
        }
    }
}
