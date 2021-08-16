using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public class Z84Frame
    {
        [Flags]
        public enum Z84PacketErrors
        {
            NoError = 0,
            BCCError = 0x01,
            LenghtError = 0x02,
            STXError = 0x04,
            ETXError = 0x08
        }

        private enum Z84FrameConst
        {
            STX = 2,
            ETX = 3
        }

        public Z84Frame()
        {
        }

        public Z84Frame(UInt32 TerminalAddress)
        {
            Address = (Byte)TerminalAddress;
        }

        public Byte GetByte(int Location)
        {
            if (Location > FieldData.Length)
                return 0;
            return FieldData[Location];
        }

        private Z84PacketErrors packet_error;
        private Byte FieldStart = (Byte)Z84FrameConst.STX;
        private Byte FieldLenght = 0;
        private Byte FieldAddress = 0;
        private Byte FieldCommand = 0;
        private Byte FieldStatus = 0;
        private Byte FieldBCC = 0;
        private Byte FieldEnd = (Byte)Z84FrameConst.ETX;
        private Byte[] FieldData = new Byte[1];

        private ArrayList frame = new ArrayList();

        public Z84PacketErrors PacketError
        {
            get
            {
                return packet_error;
            }
        }
        
        private void AddToData(Byte Data)
        {
            Array.Resize(ref FieldData, FieldData.Length + 1);
            FieldData[FieldData.Length - 1] = Data;
        }

            
        public void EmptyDataField()
        {
            Array.Resize(ref FieldData, 0);
        }
    
        public void AddToDataField(Byte Data)
        {
            AddToData(Data);            
        }

        public void AddToDataField(Char Data)
        {
            AddToData(Convert.ToByte(Data));
        }

        public void AddToDataField(int Data)
        {
            int Counter,Temp=Data,Size;
            for (Size = 0; Data > 0; Size++)
                Data /= 256;
            Byte[] t = new Byte[Size];
            Data = Temp;
            for (Counter = 0; Counter < Size; Counter++)
            {
                t[Size-Counter-1] = Convert.ToByte(Data % 256);
                Data /= 256;
            }
            AddToDataField(t);            
        }

        public void AddToDataField(int Data , int Width)
        {
            int Counter, Temp = Data, Size;
            for (Size = 0; Data > 0; Size++)
                Data /= 256;
            Byte[] t = new Byte[Size];
            Data = Temp;
            for (Counter = 0; Counter < Size; Counter++)
            {
                t[Size - Counter - 1] = Convert.ToByte(Data % 256);
                Data /= 256;
            }
            Array.Resize(ref t, Width);
            if (t.Length > Size)
            {
                for (int y = t.Length - 1; y >= Size; y--)
                    t[y] = t[y - Size];
                for (int y = 0; y < Size; y++)
                    t[y] = 0;
            }
            AddToDataField(t);
        }

        public void AddToDataField(UInt64 Data)
        {
            int Counter, Size;
            UInt64 Temp = Data;
            for (Size = 0; Data > 0; Size++)
                Data /= 256;
            Byte[] t = new Byte[Size];
            Data = Temp;
            for (Counter = 0; Counter < Size; Counter++)
            {
                t[Size - Counter - 1] = Convert.ToByte(Data % 256);
                Data /= 256;
            }
            AddToDataField(t);            
        }
        public void AddToDataField(UInt64 Data , int Width)           
        {
            int  Size;
            UInt64 Temp = Data;
            for (Size = 0; Data > 0; Size++)
                Data /= 256;
            if (Temp == 0) Size = 1;
            if (Size > Width)
                return;
            Byte[] t = new Byte[Width];
            Data = Temp;  
            if (Width > Size)
            {
                for (int y = 0; y <= Width-Size; y++)
                    t[y] = 0;
            }
            for (int y = Width -1 ;y>= Width-Size ; y--)
            {
                t[y] = Convert.ToByte(Data % 256);
                Data /= 256;
            }
          
            
            AddToDataField(t);
        }

        public void AddToDataFieldPBCD(Byte HighNibble, Byte LowNibble)
        {
            AddToData(MakePBCDByte(HighNibble, LowNibble));
        }
       
        public void AddToDataField(Byte[] Data)
        {
            int counter;
            for (counter = 0; counter < Data.Length; counter++)
                AddToData(Data[counter]);
        }

         public void AddToDataField(string Data)
        {
             int counter = 0;
             for (counter = 0; counter < Data.Length; counter++)
                AddToData(Convert.ToByte(Data[counter]));
        }

        public void AddToDataField(string Data,int Width)
        {
            int tt = Data.Length;
            if (Data.Length > Width)
                Data = Data.Substring(0, Width );            
            else if (Data.Length < Width)
                for (int temp = 0; temp < Width - tt;temp++ )
                    Data += " ";
            AddToDataField(Data);
        }

        public void AddToDataField(string Data, int Width ,string WhiteSpace)
        {
            int tt = Data.Length;
            WhiteSpace = WhiteSpace.Substring(0, 1);
            if (Data.Length > Width)
                Data = Data.Substring(0, Width);
            else if (Data.Length < Width)
                for (int temp = 0; temp < Width - tt; temp++)
                    Data += WhiteSpace;
            AddToDataField(Data);
        }

        public Boolean AddToDataField(ArrayList Data)
         {
             int counter ;
             for (counter = 0; counter < Data.Count; counter++)
             {
                 if (Data[counter].GetType() == typeof(Byte))
                     AddToDataField(Convert.ToByte(Data[counter]));
                 else if (Data[counter].GetType() == typeof(Char))
                     AddToDataField(Convert.ToChar(Data[counter]));
                 else if (Data[counter].GetType() == typeof(int))
                     AddToDataField(Convert.ToInt32(Data[counter]));
                 else if (Data[counter].GetType() == typeof(UInt64))
                     AddToDataField(Convert.ToUInt64(Data[counter]));
                 else if (Data[counter].GetType() == typeof(string))
                     AddToDataField(Convert.ToString(Data[counter]));
                 else return false;             
             }
             return true;            
         }

        public Boolean AddToDataField(ArrayList Data,int Width)
        {
            int counter;
            for (counter = 0; counter < Data.Count; counter++)
            {
                if (Data[counter].GetType() == typeof(int))
                    AddToDataField(Convert.ToInt32(Data[counter]),Width);
                else if (Data[counter].GetType() == typeof(UInt64))
                    AddToDataField(Convert.ToUInt64(Data[counter]),Width);
                else if (Data[counter].GetType() == typeof(string))
                    AddToDataField(Convert.ToString(Data[counter]), Width);
                else return false;
            }
            return true;
        }

        
            private Byte MakePBCDByte(Byte HighNibble, Byte LowNibble)
        {
            Byte Temp;
            Temp = LowNibble;
            Temp &= 0x0f;
            Temp <<= 4;
            HighNibble &= 0x0f;
            Temp |= HighNibble;
            return Temp;
        }

        public void SetEntireFrame(ArrayList p)
        {   
            if (p.Count>0)
                FieldStart = Convert.ToByte(p[0]);
            if (p.Count > 1)
                FieldLenght = Convert.ToByte(p[1]);
            if (p.Count > 2)
                FieldAddress = Convert.ToByte(p[2]);
            if (p.Count > 3)
                FieldCommand = Convert.ToByte(p[3]);
            if (p.Count > 4)
                FieldStatus = Convert.ToByte(p[4]);
            if (p.Count > 5)
            {
                Array.Resize(ref FieldData, p.Count - 7);
                for (int t = 5; t < p.Count - 2; t++)
                    FieldData[t - 5] = Convert.ToByte(p[t]);
                FieldBCC = Convert.ToByte(p[p.Count - 1]);
                FieldEnd = Convert.ToByte(p[p.Count - 2]);
            }
            frame = p;
            packet_error = Z84PacketErrors.NoError;
            if (FieldStart != Convert.ToByte(Z84FrameConst.STX))
                packet_error |= Z84PacketErrors.STXError;
            if (FieldEnd != Convert.ToByte(Z84FrameConst.ETX))
                packet_error |= Z84PacketErrors.ETXError;
            if (FieldLenght + 3 != p.Count)
                packet_error |= Z84PacketErrors.LenghtError;
            if (CalcucclateBCC() != 0)
                packet_error |= Z84PacketErrors.BCCError;            
        }

        public ArrayList GetEntireFrame()
        {
            ArrayList Temp = new ArrayList();
            Temp = frame;
            return Temp;
        }

        public UInt64 GetFrameDataAsNumber()
        {
            UInt64 Temp = 0;
            for (int counter = 0; counter < FieldData.Length; counter++)
            {
                Temp *= 256;
                Temp += Convert.ToUInt64(FieldData[counter]);
            }
            return Temp;
        }

        public UInt64 GetFrameDataAsNumber(int Start)
        {
            UInt64 Temp = 0;
            for (int counter = Start; counter < FieldData.Length; counter++)
            {
                Temp *= 256;
                Temp += Convert.ToUInt64(FieldData[counter]);
            }
            return Temp;
        }

        public UInt64 GetHighNibbleData(int Location)
        {
            Byte temp;
            temp = FieldData[Location];
            temp >>= 4;
            return Convert.ToUInt64(temp);
        }

        public UInt64 GetLowNibbleData(int Location)
        {
            Byte temp;
            temp = FieldData[Location];
            temp &= 0x0f;
            return Convert.ToUInt64(temp);
        }
        public Char GetHighNibbleSymbolData(int Location)
        {
            Byte temp;
            temp = FieldData[Location];
            temp >>= 4;
            if (temp >=0 && temp<=9)
                return Convert.ToChar(48 + temp);
          //  if (temp >= 10 && temp <= 15)
                return Convert.ToChar(55 + temp);
        }

        public Char GetLowNibbleSymbolData(int Location)
        {
            Byte temp;
            temp = FieldData[Location];
            temp &= 0x0f;
            if (temp >= 0 && temp <= 9)
                return Convert.ToChar(48 + temp);
           // if (temp >= 10 && temp <= 15)
                return Convert.ToChar(55 + temp);
        }

        public enum DataType
        {
            BigEndian,
            LittleEndian
        }
        public UInt64 GetFrameDataAsNumber(int Start,int Size/*,DataType Type*/)
        {
            UInt64 Temp = 0;
            for (int counter = Start; (counter < FieldData.Length) && (counter < Start + Size); counter++)
            {
                Temp *= 256;
                //if 
                Temp += Convert.ToUInt64(FieldData[counter]);
            }
            return Temp;
        }



        public string GetFrameDataAsString()
        {
            string Temp = string.Empty;
            for (int counter = 0; counter < FieldData.Length; counter++)
                Temp += Convert.ToChar(FieldData[counter]);
            return Temp;           
        }

        public string GetFrameDataAsString(int Start)
        {
            string Temp = string.Empty;
            for (int counter = Start; counter < FieldData.Length; counter++)
                Temp += Convert.ToChar(FieldData[counter]);
            return Temp;
        }

        public string GetFrameDataAsString(int Start,int Size)
        {
            string Temp = string.Empty;
            for (int counter = Start; (counter < FieldData.Length) && (counter < Start + Size); counter++)
                Temp += Convert.ToChar(FieldData[counter]);
            return Temp;
        }
       
        public Byte[] GetFrameDataAsBytes()
        {
            return FieldData;
        }

        public ArrayList GetFrameDataAsArraylist()
        {
            ArrayList Temp = new ArrayList();
            Temp.Clear();
            for (int counter = 0; counter < FieldData.Length; counter++)
                Temp.Add(FieldData[counter]);
            return Temp;
        }


        private void FrameUpdate()
        {
            frame.Clear();
            frame.Add(FieldStart);
            FieldLenght = (Byte)(FieldData.Length + 4);
            frame.Add(FieldLenght);
            frame.Add(FieldAddress);
            frame.Add(FieldCommand);
            frame.Add(FieldStatus);
            if (FieldData.Length != 0)
            {
                foreach (Byte data in FieldData)
                    frame.Add(data);     
            }  
            frame.Add(FieldEnd);
            FieldBCC=CalcucclateBCC();
            frame.Add(FieldBCC);
        }

        private Byte CalcucclateBCC()
        {
            Byte res = 0;
            foreach (Object data in frame)
                res = Convert.ToByte(res ^ Convert.ToByte(data));
            res = (Convert.ToByte(res ^ FieldStart ^ FieldEnd));
            return res;
        }

        public ArrayList MakeFrame()
        {
            FrameUpdate();
            return frame;
        }

        public UInt64 Command
        {
            set
            {
                FieldCommand = (Byte)value;
            }
            get
            {
                return FieldCommand;
            }
        }

        public UInt64 Status
        {
            set
            {
                FieldStatus = (Byte)value;
            }
            get
            {
                return FieldStatus;
            }
        }

        public UInt64 Address
        {
            set
            {
                FieldAddress = (Byte)value;
            }
            get
            {
                return FieldAddress;
            }
        }
       
      

    }
}
