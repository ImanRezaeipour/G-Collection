using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public class MTT5000 : Z84Family
    {
       
        public override void SetWorkMode(Char Mode)
        {
            last_command = DeviceCommand.SetWorkMode;
            Mode = Char.ToUpper(Mode);
            frame_to_send.Command = 0x11;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Convert.ToByte(Mode));
            send_frame();
        }

        public override void SetWorkMode(TerminalWorkMode Mode)
        {
            last_command = DeviceCommand.SetWorkMode;
            frame_to_send.Command = 0x11;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            if (Mode == TerminalWorkMode.OffLine)
                frame_to_send.AddToDataField(Convert.ToByte('I'));
            if (Mode == TerminalWorkMode.OnLine)
                frame_to_send.AddToDataField(Convert.ToByte('S'));
            send_frame();
        }

        public override void PrintData(byte[] Message)
        {
            last_command = DeviceCommand.PrintData;
            //if (Message.Length > 68)
                //Message = Message.Substring(0, 68);
            frame_to_send.Command = 0x1c;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Message);
            send_frame();
        }

        public override void PrintData(string Message)
        {
            last_command = DeviceCommand.PrintData;
            //if (Message.Length > 68)
            //Message = Message.Substring(0, 68);
            frame_to_send.Command = 0x1c;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Message);
            send_frame();
        }

        public override void DirectPrint(ArrayList Buffer)
        {
            last_command = DeviceCommand.DirectPrint;
            send_directprintframe(Buffer);
        }

        public override void ReadOneRecord()
        {
            last_command = DeviceCommand.ReadOneRecord;
            send_frame(0x31);
        }

        public override void SetCardLimit(UInt64 Location, CardNumber Start, CardNumber End)
        {
            last_command = DeviceCommand.SetCardLimit;
            frame_to_send.Command = 0x36;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Location, 1);
            frame_to_send.AddToDataField(Start.Number);
            frame_to_send.AddToDataField(End.Number);
            send_frame();
        }

        public override void SetPrinter(TerminalPrinter Printer)
        {
            last_command = DeviceCommand.SetPrinter;
            frame_to_send.Command = 0x3a;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Convert.ToByte(Printer));
            send_frame();
        }

        public virtual void SetParameter(byte MealType, char Status, byte FoodCOde, char len, string data, char defaultFood)
        {
            last_command = DeviceCommand.SetParameter;
            frame_to_send.Command = 0x48;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            data = MealType.ToString() + Status + FoodCOde.ToString() + len.ToString() + data + defaultFood.ToString();
            frame_to_send.AddToDataField(data, 1);
            send_frame();
        }
        public override void GetParameter(char MealType, char Status, char FoodCode)
        {
            last_command = DeviceCommand.GetParameter;
            /*
             * */
        }
    }
}
