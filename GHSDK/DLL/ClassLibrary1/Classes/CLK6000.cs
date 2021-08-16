using System;
using System.Collections.Generic;
using System.Text;
namespace Ghadir_UI
{
    public class CLK6000 : Z84Family
    {
        public override void FastCollection()
        {
            last_command = DeviceCommand.FastCollection;
            send_frame(2, 0x55);
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

        public override void SetCardLimit(UInt64 Location, CardNumber Start, CardNumber End)
        {
            last_command = DeviceCommand.SetCardLimit;
            frame_to_send.Command = 0x36;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Location, 1);
            frame_to_send.AddToDataField(Start.Number,4);
            frame_to_send.AddToDataField(End.Number,4);
            //ST;
            //ST = Utility.ChangeToHex(Start.Number, 8);
            //ST = Utility.StrToBCD(ST, 0).ToString() + Utility.StrToBCD(ST, 2).ToString() + Utility.StrToBCD(ST, 4).ToString() + Utility.StrToBCD(ST, 6).ToString();
            //frame_to_send.AddToDataField(ST.);
            //ST = Utility.ChangeToHex(End.Number, 8);
            //ST = Utility.StrToBCD(ST, 0).ToString() + Utility.StrToBCD(ST, 2).ToString() + Utility.StrToBCD(ST, 4).ToString() + Utility.StrToBCD(ST, 6).ToString();
            //frame_to_send.AddToDataField(Convert.ToByte(ST));
            send_frame();
        }
        
        public override void GetOnlyCardList()
        {
            last_command = DeviceCommand.GetOnlyCardList;
            send_frame(0x3d);
        }

        public override void ClearOnlyCardList()
        {
            last_command = DeviceCommand.ClearOnlyCardList;
            frame_to_send.Command = 0x3d;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(0xffffffff);
            send_frame();
        }

        public override void SetOnlycardlist(CardListGroup Group)
        {
            last_command = DeviceCommand.SetOnlycardlist;
            frame_to_send.Command = 0x3d;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Group.GetGroup(), 4);

            send_frame();
        }

        public override void SetOnlycardlist(AuthorityListGroup Group)
        {
            last_command = DeviceCommand.SetOnlycardlist;
            frame_to_send.Command = 0x3d;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();

            frame_to_send.AddToDataField(Group.GetGroup(), 4);
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

        public override void MultiBeep(UInt64 Count)
        {
            last_command = DeviceCommand.MultiBeep;
            frame_to_send.Command = 0x4b;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Count, 1);
            send_frame();
        }

        public override void GetAuthorityList()
        {
            last_command = DeviceCommand.GetAuthorityList;
            frame_to_send.Command = 0x4c;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            send_frame();
        }

        public override void ClearAuthorityList()
        {
            last_command = DeviceCommand.ClearAuthorityList;
            frame_to_send.Command = 0x4c;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(0xffffffff, 4);
            send_frame();
        }

        public override void SetAuthorityList(AuthorityListGroup Group)
        {
            last_command = DeviceCommand.SetAuthorityList;
            frame_to_send.Command = 0x4c;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Group.GetGroup(), 4);
            send_frame();
        }

        public override void SetPreCard(UInt64 Locatin, CardNumber CardNumber, UInt64 Code)
        {
            last_command = DeviceCommand.SetPreCard;
            frame_to_send.Command = 0x57;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            if (Locatin > 12)
                return;
            frame_to_send.AddToDataField(Locatin, 1);
            frame_to_send.AddToDataField(CardNumber.Number, 4);
            frame_to_send.AddToDataField(Code, 1);
            send_frame();
        }

        public override void GetPreCard(UInt64 Location)
        {
            last_command = DeviceCommand.GetPreCard;
            frame_to_send.Command = 0x58;
            frame_to_send.Status = 0;
            frame_to_send.EmptyDataField();
            frame_to_send.AddToDataField(Location, 1);
            send_frame();
        }
    }
}
