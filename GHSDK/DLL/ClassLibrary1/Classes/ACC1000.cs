using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public class ACC1000 : Z84Family
    {
        

        public override void ShortMessage(UInt64 BeepCount, string Message)
        {
            last_command = DeviceCommand.ShortMessage;
            if (Message.Length > 16)
                Message = Message.Substring(0, 16);
            frame_to_send.Command = 0x16;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(BeepCount, 1);
            frame_to_send.AddToDataField(Message);
            send_frame();
        }

        public override void SetFunctionKeys(Char Mode)
        {
            last_command = DeviceCommand.SetFunctionKeys;
            Mode = Char.ToUpper(Mode);
            frame_to_send.Command = 0x34;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Mode);
            send_frame();
        }

        public override void SetFunctionKeys(TerminalFunctionKeyMode Mode)
        {
            last_command = DeviceCommand.SetFunctionKeys;
            frame_to_send.Command = 0x34;
            frame_to_send.Status = 0;
            if (Mode == TerminalFunctionKeyMode.EnableFunctionKey)
                frame_to_send.AddToDataField('E');
            if (Mode == TerminalFunctionKeyMode.DisableFunctionKey)
                frame_to_send.AddToDataField('D');
            send_frame();
        }

        public override void ClearAllMessage()
        {
            last_command = DeviceCommand.ClearAllMessage;
            send_frame(0x40);
        }

        public override void SetMessage(CardNumber CardNumber, string Message)
        {
            last_command = DeviceCommand.SetMessage;
            frame_to_send.Command = 0x41;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(CardNumber.Number, 4);
            frame_to_send.AddToDataField(Message, 64);
            send_frame();
        }

        public override void GetMessage(CardNumber Number)
        {
            last_command = DeviceCommand.GetMessage;
            frame_to_send.Command = 0x41;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Number.Number, 4);
            send_frame();
        }

        public override void ClearOneCardMessage(CardNumber Number)
        {
            last_command = DeviceCommand.ClearOneCardMessage;
            frame_to_send.Command = 0x47;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Number.Number, 4);
            send_frame();
        }

        public override void SetParameter(char MealType, char Status, char FoodCode, char len, string data, char defaultFood)
        {
            last_command = DeviceCommand.SetParameter;
            frame_to_send.Command = 0x48;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            string Data = MealType.ToString() + Status.ToString() + FoodCode.ToString() + data;
            frame_to_send.AddToDataField(Data, Data.Length);
            send_frame();
        }

        public override void SetTimeLimit(string From1, string To1, string From2, string To2, string From3, string To3)
        {
            string ST = "";
            ST = ST + Utility.StrToBCD(From1, 0) + Utility.StrToBCD(From1, 3) + Utility.StrToBCD(To1, 0) + Utility.StrToBCD(To1, 3);
            ST = ST + Utility.StrToBCD(From2, 0) + Utility.StrToBCD(From2, 3) + Utility.StrToBCD(To2, 0) + Utility.StrToBCD(To2, 3);
            ST = ST + Utility.StrToBCD(From3, 0) + Utility.StrToBCD(From3, 3) + Utility.StrToBCD(To3, 0) + Utility.StrToBCD(To3, 3);
            SetParameter((char)1, 'L', (char)12, '0', ST, '0');
        }

        public override void GetParameter(char MealType, char Status, char FoodCode)
        {
            last_command = DeviceCommand.GetParameter;
            frame_to_send.Command = 0x49;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            string Data = MealType.ToString() + Status.ToString() + FoodCode.ToString();
            frame_to_send.AddToDataField(Data, Data.Length);
            send_frame();
        }
        public override void GetTimeLimit()
        {
            GetParameter((char)1, 'L', (char)12);
        }
        public override void GetStartAddressTable()
        {
            last_command = DeviceCommand.GetStartAddressTable;
            send_frame(0x4e);
        }

        public override void GetTableSpecification(TerminalTableSpecification Data)
        {
            last_command = DeviceCommand.GetTableSpecification;
            frame_to_send.Command = 0x52;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Convert.ToByte(Data));
            send_frame();
        }

        public override void DownloadBlockData(UInt64 BlockNumber, Byte[] Data)
        {
            last_command = DeviceCommand.DownloadBlockData;
            frame_to_send.Command = 0x53;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(BlockNumber);
            frame_to_send.AddToDataField(Data);
            send_frame();
        }

        public override void DownloadBlockData(UInt64 BlockNumber, ArrayList Data)
        {
            last_command = DeviceCommand.DownloadBlockData;
            frame_to_send.Command = 0x53;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(BlockNumber);
            frame_to_send.AddToDataField(Data);
            send_frame();
        }

        public override void DownloadBlockData(UInt64 BlockNumber, string Data)
        {
            last_command = DeviceCommand.DownloadBlockData;
            frame_to_send.Command = 0x53;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(BlockNumber);
            frame_to_send.AddToDataField(Data);
            send_frame();
        }

        public override void DownloadLastBlock(UInt64 BlockNumber, Byte[] Data)
        {
            last_command = DeviceCommand.DownloadLastBlock;
            frame_to_send.Command = 0x54;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(BlockNumber);
            frame_to_send.AddToDataField(Data);
            send_frame();
        }

        public override void DownloadLastBlock(UInt64 BlockNumber, string Data)
        {
            last_command = DeviceCommand.DownloadLastBlock;
            frame_to_send.Command = 0x54;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(BlockNumber);
            frame_to_send.AddToDataField(Data);
            send_frame();
        }

        public override void DownloadLastBlock(UInt64 BlockNumber, ArrayList Data)
        {
            last_command = DeviceCommand.DownloadLastBlock;
            frame_to_send.Command = 0x54;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(BlockNumber);
            frame_to_send.AddToDataField(Data);
            send_frame();
        }

        public override void DownloadLastBlock(UInt64 BlockNumber)
        {
            last_command = DeviceCommand.DownloadLastBlock;
            frame_to_send.Command = 0x54;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(BlockNumber);
            send_frame();
        }

        public override void GetTable()
        {
            last_command = DeviceCommand.GetTable;
            send_frame(0x55);
        }

        public override void SetDoorBuzzer(Char Buzzer)
        {
            last_command = DeviceCommand.SetDoorBuzzer;
            Buzzer = Char.ToUpper(Buzzer);
            frame_to_send.Command = 0x56;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Buzzer);
            send_frame();
        }

        public override void SetDoorBuzzer(TerminalBuzzerDoor Buzzer)
        {
            last_command = DeviceCommand.SetDoorBuzzer;
            frame_to_send.Command = 0x56;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            if (Buzzer == TerminalBuzzerDoor.Disable)
                frame_to_send.AddToDataField('D');
            if (Buzzer == TerminalBuzzerDoor.Enable)
                frame_to_send.AddToDataField('E');
            send_frame();
        }
    }
}
