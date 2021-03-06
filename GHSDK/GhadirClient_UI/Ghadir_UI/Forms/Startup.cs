//#define iooc
//#define Payvast
//#define Rash
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using System.IO;
using System.ServiceProcess;
using Microsoft.Win32;
using System.Data.SqlClient;

namespace Ghadir_UI
{
    public partial class Startup : Form
    {
      //  SqlConnection myConnection;     

        CLK6000 aa = new CLK6000();

        private enum send_mode
        {
            none,
            send_to_one_device,
            sned_to_selected_device,
            send_to_all_device
        }

        private enum comp_command
        {
            none,
            recovery,
            permanent_recovery,
            collection,
            fast_collection
        }
        
        RawData form_raw_data = new RawData();
        Collection form_collection = new Collection();
        Collection form_recovery = new Collection();

        private send_mode mode = send_mode.none;
        private comp_command complicate_command = comp_command.none;

        ArrayList device_detail = new ArrayList();
        int current_device_index = -1;
        Z84Family.DeviceCommand current_command;

        AcccessCodeGroup access_codes = new AcccessCodeGroup();
        AlarmGroup alarms = new AlarmGroup();
        AuthorizedCardGroup none_authorized_cards = new AuthorizedCardGroup();
        AuthorityListGroup authorized_cards = new AuthorityListGroup();     
        CardListGroup only_cards = new CardListGroup();
     
        CardNumber card_number = new CardNumber();
        CardNumber card_number_for_message = new CardNumber();
        CardNumber card_limit_start = new CardNumber(0);
        CardNumber card_limit_end = new CardNumber(0xFFFFFFFF);
        CardNumber precard_card_number = new CardNumber();

        Z84Family.TerminalError terminal_error_type = Z84Family.TerminalError.RamError;
        Z84Family.TerminalBaudRate boud_rate = Z84Family.TerminalBaudRate.BaudRaate_38400;
        Z84Family.TerminalPrinter printer = Z84Family.TerminalPrinter.LQ_Printer;
        Z84Family.TerminalFunctionKeyMode function_key_mode = Z84Family.TerminalFunctionKeyMode.DisableFunctionKey;
        Z84Family.TerminalBuzzerDoor door_buzzer = Z84Family.TerminalBuzzerDoor.Enable;

        DateTime set_date_time = new DateTime();
        DateTime recovery_date_time = new DateTime();
        

        UInt32 terminal_address = 1;        
        UInt32 beep_count = 1;
        UInt32 text_location_x = 1;
        UInt32 text_location_y = 1;
        UInt32 duration = 1;
        UInt32 card_limit_location = 1;
        UInt32 precard_location = 1;
        UInt32 precard_code = 1;
        int max_error = 3;
        int current_eror = 0;

        int records = 0;


        string kb_pw = "6000";
        string row_message = "Message";
        string short_message = "Message";
        byte[] printable_data;//= "Message";
        string message_for_card = "Message";

        Boolean promptClose = true;
        static string userName = "";
        private static System.Data.SqlClient.SqlConnection logConnection;

        public delegate void fill_cell_in_dataview(string str, Color col);
        fill_cell_in_dataview fill_cell;

        public delegate void do_somting_on_finish();
        do_somting_on_finish change_form_on_finish;


        public delegate void Fill_AccessCode_list(string Group1, string Group2, string Group3, string Group4, string Group5);
        public Fill_AccessCode_list UpdateAccessCodeList;

        public delegate void Fill_NoneAuthorized_card_list(ArrayList Data);
        public Fill_NoneAuthorized_card_list UpdateNonAuthorizedCardList;

        public delegate void Fill_Pre_Card_List(UInt64 location, UInt64 cardnumber, UInt64 code);
        public Fill_Pre_Card_List UpdatePrecardList;

        public delegate void Fill_Only_Card_List(ArrayList Data);
        public Fill_Only_Card_List UpdateOnlyCardList;

        public delegate void add_to_list(ArrayList Data);
        public add_to_list AlarmListUpdate;

        public delegate void sending_marker();
        public sending_marker show_sending_on_appropriate_row;

        Z84Family Device = new Z84Family();


        private Boolean is_CLK6000_command(Z84Family.DeviceCommand command)
        {
            if (command == Z84Family.DeviceCommand.ShortMessage)
                return false;

            if (command == Z84Family.DeviceCommand.DisplayRowMessage)
                return false;

            if (command == Z84Family.DeviceCommand.PrintData)
                return false;

            if (command == Z84Family.DeviceCommand.SetPrinter)
                return false;

            if (command == Z84Family.DeviceCommand.GetTableSpecification)
                return false;

            if (command == Z84Family.DeviceCommand.DownloadBlockData)
                return false;

            if (command == Z84Family.DeviceCommand.DownloadLastBlock)
                return false;

            if (command == Z84Family.DeviceCommand.GetTable)
                return false;

            if (command == Z84Family.DeviceCommand.SetDoorBuzzer)
                return false;

            return true;
        }

        private Boolean is_MTT5000_command(Z84Family.DeviceCommand command)
        {
            if (command == Z84Family.DeviceCommand.ShortMessage)
                return false;

            if (command == Z84Family.DeviceCommand.DisplayRowMessage)
                return false;

            if (command == Z84Family.DeviceCommand.SetFunctionKeys)
                return false;

            if (command == Z84Family.DeviceCommand.SetOnlycardlist)
                return false;

            if (command == Z84Family.DeviceCommand.GetOnlyCardList)
                return false;

            if (command == Z84Family.DeviceCommand.ClearOnlyCardList)
                return false;

            if (command == Z84Family.DeviceCommand.ClearAllMessage)
                return false;

            if (command == Z84Family.DeviceCommand.SetMessage)
                return false;

            if (command == Z84Family.DeviceCommand.ClearOneCardMessage)
                return false;

            if (command == Z84Family.DeviceCommand.MultiBeep)
                return false;

            if (command == Z84Family.DeviceCommand.SetAuthorityList)
                return false;

            if (command == Z84Family.DeviceCommand.DownloadBlockData)
                return false;

            if (command == Z84Family.DeviceCommand.DownloadLastBlock)
                return false;

            if (command == Z84Family.DeviceCommand.GetTable)
                return false;

            if (command == Z84Family.DeviceCommand.SetDoorBuzzer)
                return false;

            if (command == Z84Family.DeviceCommand.SetPreCard)
                return false;

            if (command == Z84Family.DeviceCommand.GetPreCard)
                return false;

            if (command == Z84Family.DeviceCommand.FastCollection)
                return false;

            return true;
        }

        private Boolean is_ACC1000_command(Z84Family.DeviceCommand command)
        {
            if (command == Z84Family.DeviceCommand.PrintData)
                return false;

            if (command == Z84Family.DeviceCommand.ReadOneRecord)
                return false;

            if (command == Z84Family.DeviceCommand.SetOnlycardlist)
                return false;

            if (command == Z84Family.DeviceCommand.GetOnlyCardList)
                return false;

            if (command == Z84Family.DeviceCommand.ClearOnlyCardList)
                return false;

            if (command == Z84Family.DeviceCommand.SetParameter)
                return false;

            if (command == Z84Family.DeviceCommand.GetParameter)
                return false;

            if (command == Z84Family.DeviceCommand.MultiBeep)
                return false;

            if (command == Z84Family.DeviceCommand.SetAuthorityList)
                return false;

            if (command == Z84Family.DeviceCommand.GetAuthorityList)
                return false;

            if (command == Z84Family.DeviceCommand.SetPreCard)
                return false;

            if (command == Z84Family.DeviceCommand.GetPreCard)
                return false;

            if (command == Z84Family.DeviceCommand.FastCollection)
                return false;

            return true;
        }

        void do_appropriate_change_on_start_sending()
        {
            splitContainer1.Enabled = false;
            button1.Enabled = false;
            button2.Enabled = false;
            button18.Enabled = false;            
        }

        void do_appropriate_change_on_finish_sending()
        {
            splitContainer1.Enabled = true;
            //c1OutBar1.Enabled = true;
            button1.Enabled = true;
            button2.Enabled = true;
            button18.Enabled = true;
        }


        private void show_sending()
        {
            try
            {
                select_row_on_dgv(current_device_index);
                fill_result_in_DGV_to_current_index("...", Color.Black);
            }
            catch
            {
            }
        }


        private Boolean send_to_multiple_device_finished()
        {
            if (current_device_index == device_detail.Count)
                return true;
            return false;
        }

        void select_row_on_dgv(int row)
        {
            if (DataView.Rows.Count == 0)
                return;
            for (int t = 0; t < DataView.Rows.Count; t++)
                DataView.Rows[t].Selected = false;

            DataView.Rows[row].Selected = true;
        }

        private Boolean prepare_current_media()
        {
            if (!creat_appropriate_media())
                return false;
            else
                return true;
        }

        private void show_can_not_create_media()
        {
            fill_result_in_DGV_to_current_index("اشكال در ايجاد كانال ارتباطي", Color.Green);
        }

       /* void prepare_next_device()
        {
            while (!creat_appropriate_media())
            {
                
                current_device_index++;
                if (send_to_multiple_device_finished())
                {
                    do_appropriate_change_on_finish_sending();
                    return;
                }
            }
        }*/

        void execute_current_command()
        {            
            execute_command(current_command);
        }

        void execute_command(Z84Family.DeviceCommand command)
        {
            if (jump_if_necessory())
            {               
                mode_investigate_and_do_appropriate_action();
                return;
            }
            switch (command)
            {
                case Z84Family.DeviceCommand.LinkTest:
                    if (!logSave("Link Test - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.LinkTest();
                    break;

                case Z84Family.DeviceCommand.Collection:
                    complicate_command = comp_command.collection;
                    if (!logSave("Collection All Records - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.CollectionAllRecords();
                    break;

                case Z84Family.DeviceCommand.Acknowledge:
                    if (!logSave("Send Acknowledge - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.Acknowledge();
                    break;

                case Z84Family.DeviceCommand.SetAccessCode:
                    if (!logSave("Set Access Code - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetAccessCode(access_codes);
                    break;

                case Z84Family.DeviceCommand.ClearAccessCode:
                    if (!logSave("Clear Access Code - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearAccessCode();
                    break;

                case Z84Family.DeviceCommand.SetTimeAndDate:
                    if (!logSave("Set Time And Date - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetTimeAndDate(set_date_time);
                    break;

                case Z84Family.DeviceCommand.Reset:
                    if (!logSave("Reset - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.Reset();
                    break;

                case Z84Family.DeviceCommand.GetAccessCode:
                    if (!logSave("Get Access Code - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetAccessCode();
                    break;

                case Z84Family.DeviceCommand.ReadVersion:
                    if (!logSave("Read Version - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ReadVersion();
                    break;

                case Z84Family.DeviceCommand.SetTerminalAddress:
                    if (!logSave("Set Terminal Address - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Old Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "] - New Address: [" + Convert.ToString(terminal_address) + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetTerminalAddress(terminal_address);
                    try
                    {
                        string qry = "UPDATE readers " +
                                     "SET R_Code = " + Convert.ToString(terminal_address) + " " +
                                     "WHERE R_Code = " + ((DeviceDetail)device_detail[current_device_index]).Address;
                        SqlCommand myCommand = new SqlCommand(qry, myConnection);
                        myCommand.ExecuteNonQuery();
                        myCommand.Dispose();
                        update_device_detail_list();
                        update_data_grid_view();                     
                        if (DataView.Rows.Count != 0)
                            DataView.Rows[0].Selected = true;

                    }
                    catch (Exception e)
                    {
                        update_device_detail_list();
                        update_data_grid_view();
                        if (DataView.Rows.Count != 0)
                            DataView.Rows[0].Selected = true;
                    }
                    break;

                case Z84Family.DeviceCommand.DisplayRowMessage:
                    if (!logSave("Display Row Message - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.DisplayRowMessage(text_location_x, text_location_y, Z84Family.TerminalFontType.Font8_16, row_message);
                    break;

                case Z84Family.DeviceCommand.ClearScreen:
                    if (!logSave("Clear Screen - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearScreen();
                    break;

                case Z84Family.DeviceCommand.NoneAcknowledge:
                    if (!logSave("Send None Acknowledge - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.NoneAcknowledge();
                    break;

                case Z84Family.DeviceCommand.ShortMessage:
                    if (!logSave("Short Message - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ShortMessage(beep_count, short_message);
                    break;

                case Z84Family.DeviceCommand.ChangeKeypadPassword:
                    if (!logSave("Change Keypad Password - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ChangeKeypadPassword(kb_pw);
                    break;

                case Z84Family.DeviceCommand.EnterSelfPrograming:
                    if (!logSave("Enter Self Programing - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.EnterSelfPrograming();
                    break;

                case Z84Family.DeviceCommand.PrintData:
                    if (!logSave("Print Data - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.PrintData(printable_data);
                    break;

                case Z84Family.DeviceCommand.ClearErrorBuffer:
                    if (!logSave("Clear Error Buffer - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearErrorBuffer(terminal_error_type);
                    break;

                case Z84Family.DeviceCommand.ReInitialization:
                    if (!logSave("ReInitialization - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ReInitialization();
                    break;

                case Z84Family.DeviceCommand.GetTimeAndDate:
                    if (!logSave("Get Time And Date - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetTimeAndDate();
                    break;

                case Z84Family.DeviceCommand.SetAlarms:
                    if (!logSave("Set Alarms - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetAlarms(alarms);
                    break;

                case Z84Family.DeviceCommand.ClearAlarms:
                    if (!logSave("Clear Alarms - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearAlarms();
                    break;

                case Z84Family.DeviceCommand.GetAlarms:
                    if (!logSave("Get Alarms - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetAlarms();
                    break;

                case Z84Family.DeviceCommand.SetNoneAuthorizeCards:
                    if (!logSave("Set NonAuthorize Cards - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetNoneAuthorizeCards(none_authorized_cards);
                    break;

                case Z84Family.DeviceCommand.ClearNonAuthorizeCards:
                    if (!logSave("Clear NonAuthorize Cards - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearNonAuthorizeCards();
                    break;

                case Z84Family.DeviceCommand.GetNonAuthorizeCards:
                    if (!logSave("Get NonAuthorize Cards - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetNonAuthorizeCards();
                    break;

                case Z84Family.DeviceCommand.ClearAllMessage:
                    if (!logSave("Clear All Message - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearAllMessage();
                    break;

                case Z84Family.DeviceCommand.SetMessage:
                    if (!logSave("Set Message - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetMessage(card_number, message_for_card);
                    break;

                case Z84Family.DeviceCommand.GetMessage:
                    if (!logSave("Get Message - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetMessage(card_number);
                    break;

                case Z84Family.DeviceCommand.ClearOneCardMessage:
                    if (!logSave("Clear One Card Message - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearOneCardMessage(card_number);
                    break;

                case Z84Family.DeviceCommand.SetParameter:
                    //if (!logSave(" - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //
                    break;

                case Z84Family.DeviceCommand.GetParameter:
                    //if (!logSave(" - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //
                    break;

                case Z84Family.DeviceCommand.MultiBeep:
                    if (!logSave("Multi Beep - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.MultiBeep(beep_count);
                    break;

                case Z84Family.DeviceCommand.SetAuthorityList:
                    if (!logSave("Set Authority List - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetAuthorityList(authorized_cards);
                    break;

                case Z84Family.DeviceCommand.OpenDoor:
                    if (!logSave("Open Door - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.OpenDoor(duration);
                    break;

                case Z84Family.DeviceCommand.LockDoor:
                    if (!logSave("Lock Door - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.LockDoor(duration);
                    break;

                case Z84Family.DeviceCommand.UnLockDoor:
                    if (!logSave("UnLock Door - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.UnLockDoor(duration);
                    break;

                case Z84Family.DeviceCommand.SetBaudRate:
                    if (!logSave("Set Baud Rate - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetBaudRate(boud_rate);
                    break;

                case Z84Family.DeviceCommand.RecoveryByDate:
                    complicate_command = comp_command.recovery;
                    if (!logSave("Recovery By Date - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.RecoveryByDate(recovery_date_time);
                    break;

                case Z84Family.DeviceCommand.GetImage:
                    if (!logSave("Get Image - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetImage();
                    break;

                case Z84Family.DeviceCommand.PermanentRecovery:
                    complicate_command = comp_command.permanent_recovery;
                    if (!logSave("Permanent Recovery - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.PermanentRecovery(recovery_date_time);
                    break;

                case Z84Family.DeviceCommand.ReadOneRecord:
                    if (!logSave("Read One Record - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ReadOneRecord();
                    break;

                case Z84Family.DeviceCommand.Setpolling:
                    //if (!logSave(" - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //
                    break;

                case Z84Family.DeviceCommand.SetFunctionKeys:
                    if (!logSave("Set Function Keys - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetFunctionKeys(function_key_mode);
                    break;

                case Z84Family.DeviceCommand.SetCardLimit:
                    if (!logSave("Set Card Limit - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetCardLimit(card_limit_location, card_limit_start, card_limit_end);
                    break;

                case Z84Family.DeviceCommand.SetPrinter:
                    if (!logSave("Set Printer - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetPrinter(printer);
                    break;

                case Z84Family.DeviceCommand.SetOnlycardlist:
                    if (!logSave("Set Only Card List - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetOnlycardlist(only_cards);
                    break;

                case Z84Family.DeviceCommand.GetOnlyCardList:
                    if (!logSave("Get Only Card List - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetOnlyCardList();
                    break;

                case Z84Family.DeviceCommand.ClearOnlyCardList:
                    if (!logSave("Clear Only Card List - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearOnlyCardList();
                    break;

                case Z84Family.DeviceCommand.GetTableSpecification:
                    //if (!logSave(" - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //
                    break;

                case Z84Family.DeviceCommand.DownloadBlockData:
                    //if (!logSave(" - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //
                    break;

                case Z84Family.DeviceCommand.DownloadLastBlock:
                    //if (!logSave(" - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //
                    break;

                case Z84Family.DeviceCommand.GetTable:
                    //if (!logSave(" - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //
                    break;

                case Z84Family.DeviceCommand.SetDoorBuzzer:
                    if (!logSave("Set Door Buzzer - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetDoorBuzzer(door_buzzer);
                    break;

                case Z84Family.DeviceCommand.SetPreCard:
                    if (!logSave("Set PreCard - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetPreCard(precard_location, precard_card_number, precard_code);
                    break;

                case Z84Family.DeviceCommand.GetPreCard:
                    if (!logSave("Get PreCard - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetPreCard(precard_location);
                    break;

                case Z84Family.DeviceCommand.FastCollection:
                    complicate_command = comp_command.fast_collection;
                    if (!logSave("Fast Collection - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.FastCollection();
                    break;

               /// case Z84Family.DeviceCommand.SetAuthorityList:
                //    if (!logSave("Set Authority List - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                //    Device.SetAuthorityList(authorized_cards);
                //    break;

                case Z84Family.DeviceCommand.GetAuthorityList:
                    if (!logSave("Get Authority List - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetAuthorityList();
                    break;

                case Z84Family.DeviceCommand.ClearAuthorityList:
                    if (!logSave("Clear Authority List - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.ClearAuthorityList();
                    break;
                case Z84Family.DeviceCommand.SetTimeLimit:
                    if (!logSave("Set Time Limit - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.SetTimeLimit(txt_Limit_From1.Text, txt_Limit_To1.Text, txt_Limit_From2.Text, txt_Limit_To2.Text, txt_Limit_From3.Text, txt_Limit_To3.Text);
                    break;
                case Z84Family.DeviceCommand.GetTimeLimit:
                    if (!logSave("Get Time Limit - Device: [" + ((DeviceDetail)device_detail[current_device_index]).Name + "] - Address: [" + ((DeviceDetail)device_detail[current_device_index]).Address + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Device.GetTimeLimit();
                    break;
            }
        }

        private Boolean  jump_if_necessory()
        {
            if (((DeviceDetail)(device_detail[current_device_index])).Type == DeviceDetail.DeviceType.CLK6000)
                if (!is_CLK6000_command(current_command))
                {
                    fill_result_in_DGV_to_current_index("دستور انتخابي با نوع دشتگاه منطبق نمي باشد", Color.Blue);
                    return true ;
                }

            if (((DeviceDetail)(device_detail[current_device_index])).Type == DeviceDetail.DeviceType.MTT5000)
                if (!is_MTT5000_command(current_command))
                {
                    fill_result_in_DGV_to_current_index("دستور انتخابي با نوع دشتگاه منطبق نمي باشد", Color.Blue);
                    return true ;
                }

            if (((DeviceDetail)(device_detail[current_device_index])).Type == DeviceDetail.DeviceType.ACC1000)
                if (!is_ACC1000_command(current_command))
                {
                    fill_result_in_DGV_to_current_index("دستور انتخابي با نوع دشتگاه منطبق نمي باشد", Color.Blue);
                    return true ;
                }

            return false;
            }

        private Boolean is_group_command(Z84Family.DeviceCommand command)
        {
            switch (command)
            {
                case Z84Family.DeviceCommand.Collection:
                case Z84Family.DeviceCommand.FastCollection:
                case Z84Family.DeviceCommand.RecoveryByDate:
                case Z84Family.DeviceCommand.PermanentRecovery:
                case Z84Family.DeviceCommand.GetAccessCode:
                case Z84Family.DeviceCommand.GetAlarms:
                case Z84Family.DeviceCommand.GetNonAuthorizeCards:
                case Z84Family.DeviceCommand.GetOnlyCardList:
                case Z84Family.DeviceCommand.GetAuthorityList:
                case Z84Family.DeviceCommand.GetPreCard:
                case Z84Family.DeviceCommand.ChangeKeypadPassword: 
                case Z84Family.DeviceCommand.SetTerminalAddress:
                    return false;                   
            }
            return true;
        }


        private Boolean creat_appropriate_media()
        {
            Boolean temp = true;
            System.Net.IPEndPoint net_address;

            if (!(current_device_index >= 0 && current_device_index < device_detail.Count))
                return false;

            Device.DestroyMedia();

            switch (((DeviceDetail)device_detail[current_device_index]).Type)
            {
                case DeviceDetail.DeviceType.CLK6000:
                    Device = new CLK6000();
                    break;

                case DeviceDetail.DeviceType.MTT5000:
                    Device = new MTT5000();
                    break;

                case DeviceDetail.DeviceType.ACC1000:
                    Device = new ACC1000();
                    break;
            }

            switch (((DeviceDetail)device_detail[current_device_index]).ConnectionType)
            {
                case DeviceDetail.DeviceCommunicationType.SERIAL:
                    if (!Device.CreateSerialMedia(((DeviceDetail)device_detail[current_device_index]).COMPort, ((DeviceDetail)device_detail[current_device_index]).BaudRate))
                        temp = false;
                    break;
                case DeviceDetail.DeviceCommunicationType.NETWORK:
                    net_address = new System.Net.IPEndPoint(((DeviceDetail)device_detail[current_device_index]).IP, ((DeviceDetail)device_detail[current_device_index]).Port);
                    if (!Device.CreateNetworkMedia(net_address))
                        temp = false;
                    break;
            }

            Device.TerminalAddress = ((DeviceDetail)device_detail[current_device_index]).Address;

            Device.BadReceivePacket += new Z84Family.ErrorOnReceiveEvent(Device_BadReceivePacket);
            Device.CommandDone += new Z84Family.ReceiveSuccessEvent(Device_CommandDone);
            Device.NotResponse += new Z84Family.NotResponceEvent(Device_NotResponse);
            Device.CollectFinish += new Ghadir_UI.Z84Family.CollectFinishEvent(Device_CollectFinish);
            Device.ReceiveComplete += new Z84Family.ReceiveEvent(Device_ReceiveComplete);
            Device.SendComplete += new Z84Family.SendEvent(Device_SendComplete);
//            Device.Media.LogPath = "d:";
//            Device.Media.LogFileOption = LogPacket.LogFileMode.LogInOutRecords;
            return temp;
        }

        public Startup()
        {
            InitializeComponent();
            if (!Directory.Exists(Constant.ConfigFileDirectory))
                Directory.CreateDirectory(Constant.ConfigFileDirectory);

            string[] detail;
            string ConnStr;

            if (!File.Exists(Constant.DBConfigFilePath))
            {

                //label29.Text = "تنظیمات بانک اطلاعاتی";
                DB p = new DB();
                if (p.ShowDialog() == DialogResult.OK)
                {
                    if (!Directory.Exists(Constant.ConfigFileDirectory))
                        Directory.CreateDirectory(Constant.ConfigFileDirectory);

                    if (!File.Exists(Constant.DBConfigFilePath))
                        return;
                    detail = File.ReadAllLines(Constant.DBConfigFilePath);
                    ConnStr = "Trusted_Connection=no;connection timeout=10;";
                    for (int t = 0; t < detail.Length; t++)
                    {
                        if (detail[t].Equals("Server Name:"))
                            ConnStr = ConnStr + "server=" + detail[t + 1].Trim() + ";";
                        if (detail[t].Equals("Database Name:"))
                            ConnStr = ConnStr + "database=" + detail[t + 1].Trim() + ";";
                        if (detail[t].Equals("User Name:"))
                            ConnStr = ConnStr + "user id=" + detail[t + 1].Trim() + ";";
                        if (detail[t].Equals("Password:"))
                        {
                            DB.Encryption64 oEs = new DB.Encryption64();
                            string txtPassText;
                            txtPassText = oEs.Decrypt(detail[t + 1].Trim(), Constant.encryptKey);
                            ConnStr = ConnStr + "password=" + txtPassText + ";";
                        }
                    }

                    if (myConnection.State != ConnectionState.Open)
                        myConnection.ConnectionString = ConnStr;
                    else
                    {
                        myConnection.Close();
                        myConnection.ConnectionString = ConnStr;
                    }
                    //if (logConnection.State != ConnectionState.Open)
                    logConnection = new SqlConnection(ConnStr);
                    //logConnection.ConnectionString = ConnStr;
                    //else
                    //{
                    //    logConnection.Close();
                    //    logConnection.ConnectionString = ConnStr;
                    //}
                    try
                    {
                        if (myConnection.State != ConnectionState.Open)
                            myConnection.Open();
                        //update_device_detail_list();
                        //update_data_grid_view();
                        //if (device_detail.Count > 0)
                        //    DataView.Rows[0].Selected = true;
                    }
                    catch (Exception ex)
                    {
                        //device_detail.Clear();
                        //DataView.Rows.Clear();
                        MessageBox.Show(ex.Message, "مشکل ارتباط با بانک اطلاعاتی");
                    }

                }

                //return;
            }
            else
            {
                detail = File.ReadAllLines(Constant.DBConfigFilePath);
                ConnStr = "Trusted_Connection=no;connection timeout=10;";
                for (int t = 0; t < detail.Length; t++)
                {
                    if (detail[t].Equals("Server Name:"))
                        ConnStr = ConnStr + "server=" + detail[t + 1].Trim() + ";";
                    if (detail[t].Equals("Database Name:"))
                        ConnStr = ConnStr + "database=" + detail[t + 1].Trim() + ";";
                    if (detail[t].Equals("User Name:"))
                        ConnStr = ConnStr + "user id=" + detail[t + 1].Trim() + ";";
                    if (detail[t].Equals("Password:"))
                    {
                        DB.Encryption64 oEs = new DB.Encryption64();
                        string txtPassText;
                        txtPassText = oEs.Decrypt(detail[t + 1].Trim(), Constant.encryptKey);
                        ConnStr = ConnStr + "password=" + txtPassText + ";";
                        //                    ConnStr = ConnStr + "password=" + detail[t + 1].Trim() + ";";
                    }
                }
                myConnection = new SqlConnection(ConnStr);
                logConnection = new SqlConnection(ConnStr);
                try
                {
                    myConnection.Open();
                }
                catch (Exception e)
                {
                    MessageBox.Show(e.Message, "مشکل ارتباط با بانک اطلاعاتی");
                    //label29.Text = "تنظیمات بانک اطلاعاتی";
                    DB p = new DB();
                    if (p.ShowDialog() == DialogResult.OK)
                    {
                        if (!Directory.Exists(Constant.ConfigFileDirectory))
                            Directory.CreateDirectory(Constant.ConfigFileDirectory);

                        if (!File.Exists(Constant.DBConfigFilePath))
                            return;
                        detail = File.ReadAllLines(Constant.DBConfigFilePath);
                        ConnStr = "Trusted_Connection=no;connection timeout=10;";
                        for (int t = 0; t < detail.Length; t++)
                        {
                            if (detail[t].Equals("Server Name:"))
                                ConnStr = ConnStr + "server=" + detail[t + 1].Trim() + ";";
                            if (detail[t].Equals("Database Name:"))
                                ConnStr = ConnStr + "database=" + detail[t + 1].Trim() + ";";
                            if (detail[t].Equals("User Name:"))
                                ConnStr = ConnStr + "user id=" + detail[t + 1].Trim() + ";";
                            if (detail[t].Equals("Password:"))
                            {
                                DB.Encryption64 oEs = new DB.Encryption64();
                                string txtPassText;
                                txtPassText = oEs.Decrypt(detail[t + 1].Trim(), Constant.encryptKey);
                                ConnStr = ConnStr + "password=" + txtPassText + ";";
                            }
                        }

                        if (myConnection.State != ConnectionState.Open)
                            myConnection.ConnectionString = ConnStr;
                        else
                        {
                            myConnection.Close();
                            myConnection.ConnectionString = ConnStr;
                        }
                        if (logConnection.State != ConnectionState.Open)
                            logConnection.ConnectionString = ConnStr;
                        else
                        {
                            logConnection.Close();
                            logConnection.ConnectionString = ConnStr;
                        }
                        try
                        {
                            if (myConnection.State != ConnectionState.Open)
                                myConnection.Open();
                            //update_device_detail_list();
                            //update_data_grid_view();
                            //if (device_detail.Count > 0)
                            //    DataView.Rows[0].Selected = true;
                        }
                        catch (Exception ex)
                        {
                            //device_detail.Clear();
                            //DataView.Rows.Clear();
                            MessageBox.Show(ex.Message, "مشکل ارتباط با بانک اطلاعاتی");
                        }
                    }
                    //return;
                }
            }
        }
        void Device_CollectFinish(Ghadir_UI.Z84Family.CollectFinishState state, int Count)
        {
            Device_Save(Device.collected_data.Records);
        }
        string Get_Person_Code(string Proxi)
        {
            string res = "";
            if (myConnection.State == ConnectionState.Open)
            {
                try
                {
                    SqlDataReader myReader = null;
                    SqlCommand myCommand = new SqlCommand("select p_Barcode from Persons where p_Proxi = '" + Proxi.PadLeft(8, '0') + "'", myConnection);
                    myReader = myCommand.ExecuteReader();
                    while (myReader.Read())
                    {
                        res = Convert.ToString(myReader["p_Barcode"].ToString()).PadLeft(8, '0');
                    }
                    myReader.Close();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
                }

            }
            if (res == "")
                res = Proxi.PadLeft(8, '0');
            return res;
        }
    
/*        string Milady2Shamsi(string MDate)
        {
//            var
            //byte p;
            int p, y, m, d;
            string s;
//            begin
            s = "";
            y = 0;
            m = 0;
            d = 0;
            if(MDate != "")
            {
                //p = pos('/', MDate);
                p = MDate.IndexOf('/');
                if(p > 0)
                {
                    y = Convert.ToInt32(MDate.Substring(0,p-1));
                       // StrToInt(Copy(MDate, 1, p));
                    MDate.Remove(0, p);
                    //Delete(MDate, 1, p);
                }
                //p = pos('/', MDate);
                p = MDate.IndexOf('/');
                if (p > 0)
                {
                    m = Convert.ToInt32(MDate.Substring(0, p - 1));                  
                    //m = StrToInt(Copy(MDate, 1, p));
                    MDate.Remove(0, p);
                    //Delete(MDate, 1, p);
                }

                if(MDate != "")
                    d = Convert.ToInt32(MDate);
                    //d = StrToInt(MDate);
            }

            s = MToSh(y, m, d);
            s = BeautifulDate(IntToStr(y) + '/' + IntToStr(m) + '/' + IntToStr(d));
            return s;
        }

        string MToSh(int Y, int M, int D)
        {
            byte[] A = {0, 10, 11, 9, 11, 10, 10, 9, 9, 9, 8, 9, 9, 10, 11, 9};
            byte[] B = {0, 20, 19, 20, 20, 21, 21, 22, 22, 22, 22, 21, 21, 20, 19, 20};
                        
            if((Y % 4 == 0) && (M > 2) || (Y % 4 == 1) && (M <= 2))
                D++;

            if(D > B[M])
            {
                D = D - B[M];
                M++;
            }
            else
            {
                D = D + A[M];
                if(M == 3)
                    if(Y % 4 == 1)
                        D++; /* ALSO 2001,2005, ... , 2001+K*4  
            }
            M = M + 9;
            if (M > 12)
            {
                M = M - 12;
                Y++;
            }

            if(Y >= 1000)
                Y = Y - 622;
            else if (Y >= 22)
                Y = Y - 22;
            else
                Y = Y + 78;
            return (Convert.ToString(Y) + Convert.ToString(M) + Convert.ToString(D));
        }*/

        string Shamsi2Milady(string MDate)
        {
            //byte p;
            int p, y, m, d;
            string s;
            s = "";
            y = 0;
            m = 0;
            d = 0;
            if (MDate != "")
            {
                p = MDate.IndexOf('/');
                //p := pos('/', MDate);
                if (p > 0)
                {
                    y = Convert.ToInt32(MDate.Substring(0,p));
                    MDate = MDate.Substring(p + 1, MDate.Length - (p + 1));
                    //MDate.Remove(0, p);
                    //y = StrToInt(Copy(MDate, 1, p-1));
                    //Delete(MDate, 1, p);
                }
                p = MDate.IndexOf('/');
                //p := pos('/', MDate);
                if (p > 0)
                {
                    m = Convert.ToInt32(MDate.Substring(0,p));
                    MDate = MDate.Substring(p + 1, MDate.Length - (p + 1));
                    //MDate.Remove(0, p);
                    //m := StrToInt(Copy(MDate, 1, p-1));
                    //Delete(MDate, 1, p);
                }

                if (MDate != "")
                    d = Convert.ToInt32(MDate);
                    //d := StrToInt(MDate);
            }
            s = ShToM(y, m, d);
            s = s.Substring(0, 4) + '/' + s.Substring(4, 2) + '/' + s.Substring(6, 2);
            return s;
        }
      
        string ShToM(int Y,int M,int D)
        {
            string y, m, d;
            byte[] A = { 0, 10, 11, 9, 11, 10, 10, 9, 9, 9, 8, 9, 9, 10, 11, 9 };
            byte[] B = { 0, 20, 19, 20, 20, 21, 21, 22, 22, 22, 22, 21, 21, 20, 19, 20 };
            if (Y % 4 == 3)
                D--;
            if (Y % 4 == 2)
                A[15] = 10;
            M = M + 3;
            if (D > A[M])
                D = D - A[M];
            else
            {
                M--;
                D = D + B[M];
            }
            if (M > 12)
                M = M - 12;
            else
                Y--;
            if (Y < 1000)
                Y = (Y + 22) % 100;
            else
                Y = Y + 622;
            y = Convert.ToString(Y);
            if (M < 10)
                m = "0" + Convert.ToString(M);
            else
                m = Convert.ToString(M);
            if (D < 10)
                d = "0" + Convert.ToString(D);
            else
                d = Convert.ToString(D);
            return (y + m + d);
            //A[15] = 9;
        }

        void Device_Save(Ghadir_UI.OneRecord[] recs)
        {
            if (myConnection.State == ConnectionState.Open)
            {
                try
                {
                    string cmnd;
                    string TableName;
                    SqlCommand myCommand;
                    foreach (Ghadir_UI.OneRecord rec in recs)
                    {
                        #if iooc
                        #warning iooc is defined; only use for Iranian Offshore Oil Co.
                                                TableName = "Ciooc"; // + rec.Date.Substring(0, 2) + rec.Date.Substring(3, 2);
                        #elif Payvast
                        #warning Payvast is defined; only use for Payvast Co.
                                                TableName = "__TshOnlineClockInfo__"; 
                        #elif Rash
                        #warning Rash is defined; only use for Rash Co.
                                                TableName = "tbl_ClockRecord"; 
                        #else
                        #warning iooc, Payvast and Rash NOT defined; don't use for Iranian Offshore Oil Co or Payvast Co or Rash Co.
                                                TableName = "C13" + rec.Date.Substring(0, 2) + rec.Date.Substring(3, 2);
                        #endif
                        #if Payvast //Region for Payvast Co.
                        cmnd = "IF not EXISTS(SELECT name " +
                               "FROM sysobjects " +
                               "WHERE (name = '" + TableName + "'))" +
                               "create table " + TableName +
                               "(Code bigint, PreCart int, tDate DateTime," +
                               " tHour int, IO bit, prsID bigint, status int," +
                               " ClockCode int)";
                        myCommand = new SqlCommand(cmnd, myConnection);
                        myCommand.ExecuteNonQuery();
                        myCommand.Dispose(); 
                        rec.CardNumber = Get_Person_Code(rec.CardNumber); 
                        rec.Time = Convert.ToString(60 * Convert.ToInt32(rec.Time.Substring(0, 2)) + Convert.ToInt32(rec.Time.Substring(3, 2)));// Convert.ToString(60 * ((Convert.ToInt32(rec.Time[0]) - 48) * 10 + (Convert.ToInt32(rec.Time[1]) - 48)) + ((Convert.ToInt32(rec.Time[3]) - 48) * 10 + (Convert.ToInt32(rec.Time[4]) - 48)));
                        rec.Date = "13" + rec.Date;
                        rec.CardStstus = String.Format("{0:x}", Convert.ToInt32(rec.CardStstus));                        

/*                        cmnd = "SELECT prsID, IO from " + TableName +
                               " where (Code = ( SELECT max(code) as mCode  From " + TableName + " WHERE prsID = " + rec.CardNumber + " ))";
                        SqlDataReader myReader = null;
                        myCommand = new SqlCommand(cmnd, myConnection);
                        myReader = myCommand.ExecuteReader();
                        Boolean io = false;
                        while (myReader.Read())
                        {
                            io = !(Convert.ToBoolean(myReader["IO"].ToString()));
                        }
                        myReader.Close();
                        myCommand.Dispose(); */

                        //cmnd = "IF not EXISTS(SELECT prsID " +
                        //       "FROM " + TableName + " " +
                        //       "WHERE  prsID = " + rec.CardNumber/*.PadLeft(8, '0')*/ + " " +
                        //       "AND tDate = " + rec.Date + " " +
                        //       "AND tHour = " + rec.Time + " ) ";
                        cmnd = /*cmnd +*/ "if (select max(Code) from " + TableName+ " ) is not null "   
                               + "INSERT into " + TableName + " (Code, PreCart, tDate, tHour, IO, prsID, status,  ClockCode) "
                               + "SELECT max(Code)+1, " //  from " + TableName + " , "
                               + rec.CardStstus + ", "
                               + "convert(datetime, '" + Shamsi2Milady(rec.Date) + "'), "
                               + rec.Time + ", "
                               + "0, " // Convert.ToByte(io) + ", " 
                               + Convert.ToInt64(rec.CardNumber, 16) + ", "
                               + "0, " 
                               + rec.TerminalAddress + " from " + TableName + " " 
                               + "else INSERT into " + TableName + " (Code, PreCart, tDate, tHour, IO, prsID, status,  ClockCode) "
                               + "Values ( 1, "
                               + rec.CardStstus + ", "
                               + "convert(datetime, '" + Shamsi2Milady(rec.Date) + "'), "
                               + rec.Time + ", "
                               + "0, " // Convert.ToByte(io) + ", " 
                               + Convert.ToInt64(rec.CardNumber, 16) + ", "
                               + "0, " 
                               + rec.TerminalAddress + " )"; 
                        //end Region for Payvast Co.
                        #else
                        cmnd = "IF not EXISTS(SELECT name " +
                               "FROM sysobjects " +
                               "WHERE (name = '" + TableName + "'))" +
                               "create table " + TableName +
                               "(Clock_BarCode varchar(8), Clock_BDate varchar(10)," +
                               " Clock_BTime smallint, Clock_BRdrCode smallint," +
                               " Clock_BRecState smallint, Clock_Date varchar(10)," +
                               " Clock_Time smallint, Clock_RdrCode smallint," +
                               " Clock_Chg smallint, Clock_RecState smallint," +
                               " Clock_User varchar(15))";
                        myCommand = new SqlCommand(cmnd, myConnection);
                        myCommand.ExecuteNonQuery();
                        myCommand.Dispose();                                                
                        #if Rash //Region for Rash Co.
                        //rec.CardNumber = Get_Person_Code(rec.CardNumber);
                        //end Region for Rash Co.
                        #else
                        rec.CardNumber = Get_Person_Code(rec.CardNumber);
                        #endif
                        rec.Time = Convert.ToString(60 * Convert.ToInt32(rec.Time.Substring(0, 2)) + Convert.ToInt32(rec.Time.Substring(3, 2)));// Convert.ToString(60 * ((Convert.ToInt32(rec.Time[0]) - 48) * 10 + (Convert.ToInt32(rec.Time[1]) - 48)) + ((Convert.ToInt32(rec.Time[3]) - 48) * 10 + (Convert.ToInt32(rec.Time[4]) - 48)));
                        rec.Date = "13" + rec.Date;
                        rec.CardStstus = String.Format("{0:x}", Convert.ToInt32(rec.CardStstus));
                        cmnd = "IF not EXISTS(SELECT Clock_BarCode " +
                              "FROM " + TableName + " " +
                              "WHERE Clock_BarCode = '" + rec.CardNumber.PadLeft(8, '0') + "' " +
                              "AND Clock_Date = '" + rec.Date + "' ";
                        cmnd = cmnd + "AND Clock_Time = " + rec.Time + ") ";
                        cmnd = cmnd + "INSERT into " + TableName + " (clock_barcode ,clock_bdate,clock_btime,clock_brdrCode,clock_brecState, clock_date,clock_time,clock_rdrCode,clock_recState,clock_chg,clock_user) " +
                                     "VALUES('" + rec.CardNumber + "', " +
                                            "'" + rec.Date + "', "
                                                 + rec.Time + "  , "
                                                 + rec.TerminalAddress + "  , "
                                                 + rec.CardStstus + "  , " +
                                            "'" + rec.Date + "', "
                                                 + rec.Time + "  , "
                                                 + rec.TerminalAddress + "  , "
                                                 + rec.CardStstus + "  , "
                                                 + " 0  , "
                                                 + "'serviceUI') ";
                        #endif
                        //cmnd = "insert into c13" + rec.Date.Substring(0, 2) + rec.Date.Substring(3, 2) + " (clock_barcode ,clock_bdate,clock_btime,clock_brdrCode,clock_brecState, clock_date,clock_time,clock_rdrCode,clock_recState,clock_chg,clock_user) values ('" + rec.CardNumber + "','13" + rec.Date + "'," + rec.Time + "," + rec.TerminalAddress + "," + rec.CardStstus + ",'13" + rec.Date + "'," + rec.Time + "," + rec.TerminalAddress + "," + rec.CardStstus + ",0, 'service')";
                        myCommand = new SqlCommand(cmnd, myConnection);
                        myCommand.ExecuteNonQuery();
                        myCommand.Dispose();
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
                }
            }
        }

        string codingPassword(String pass)
        {
            string rPass = "";
            for (int i = 0; i <= pass.Length - 1; i++)
            {
                if (pass[i] != 'v')
                    rPass += Convert.ToString(Convert.ToChar(pass[i] ^ 118));
                else
                    rPass += 'v';
            }
            return rPass;
        }

        Boolean accessMenus(int relationMenuVal)
        {
            try
            {
                if ((Convert.ToInt32(Math.Pow(2, 1)) & relationMenuVal) == 0)
                    buttonBar2.Groups[0].Items[1].Enabled = false;
                else
                    buttonBar2.Groups[0].Items[1].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 2)) & relationMenuVal) == 0)
                    buttonBar2.Groups[1].Items[0].Enabled = false;
                else
                    buttonBar2.Groups[1].Items[0].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 8)) & relationMenuVal) == 0)
                    buttonBar2.Groups[1].Items[1].Enabled = false;
                else
                    buttonBar2.Groups[1].Items[1].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 3)) & relationMenuVal) == 0)
                    buttonBar2.Groups[1].Items[2].Enabled = false;
                else
                    buttonBar2.Groups[1].Items[2].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 9)) & relationMenuVal) == 0)
                    buttonBar2.Groups[1].Items[3].Enabled = false;
                else
                    buttonBar2.Groups[1].Items[3].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 6)) & relationMenuVal) == 0)
                    buttonBar2.Groups[2].Items[0].Enabled = false;
                else
                    buttonBar2.Groups[2].Items[0].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 5)) & relationMenuVal) == 0)
                    buttonBar2.Groups[2].Items[1].Enabled = false;
                else
                    buttonBar2.Groups[2].Items[1].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 4)) & relationMenuVal) == 0)
                    buttonBar2.Groups[2].Items[2].Enabled = false;
                else
                    buttonBar2.Groups[2].Items[2].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 7)) & relationMenuVal) == 0)
                    buttonBar2.Groups[2].Items[3].Enabled = false;
                else
                    buttonBar2.Groups[2].Items[3].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 10)) & relationMenuVal) == 0)
                    buttonBar2.Groups[2].Items[4].Enabled = false;
                else
                    buttonBar2.Groups[2].Items[4].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 18)) & relationMenuVal) == 0)
                    buttonBar2.Groups[3].Items[0].Enabled = false;
                else
                    buttonBar2.Groups[3].Items[0].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 17)) & relationMenuVal) == 0)
                    buttonBar2.Groups[3].Items[1].Enabled = false;
                else
                    buttonBar2.Groups[3].Items[1].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 21)) & relationMenuVal) == 0)
                    buttonBar2.Groups[4].Items[0].Enabled = false;
                else
                    buttonBar2.Groups[4].Items[0].Enabled = true;
                //chapgar ?!?!
                buttonBar2.Groups[4].Items[1].Enabled = false;
/*                if ((Convert.ToInt32(Math.Pow(2, ?)) & relationMenuVal) == 0)
                    buttonBar2.Groups[4].Items[1].Enabled = false;
                else
                    buttonBar2.Groups[4].Items[1].Enabled = true;*/
                if ((Convert.ToInt32(Math.Pow(2, 19)) & relationMenuVal) == 0)
                    buttonBar2.Groups[4].Items[2].Enabled = false;
                else
                    buttonBar2.Groups[4].Items[2].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 22)) & relationMenuVal) == 0)
                    buttonBar2.Groups[5].Items[0].Enabled = false;
                else
                    buttonBar2.Groups[5].Items[0].Enabled = true;
                //baziabi ?!?!
                buttonBar2.Groups[5].Items[1].Enabled = false;
/*                if ((Convert.ToInt32(Math.Pow(2, 23)) & relationMenuVal) == 0)
                    buttonBar2.Groups[5].Items[1].Enabled = false;
                else
                    buttonBar2.Groups[5].Items[1].Enabled = true;*/
                if ((Convert.ToInt32(Math.Pow(2, 13)) & relationMenuVal) == 0)
                    buttonBar2.Groups[6].Items[0].Enabled = false;
                else
                    buttonBar2.Groups[6].Items[0].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 20)) & relationMenuVal) == 0)
                    buttonBar2.Groups[6].Items[1].Enabled = false;
                else
                    buttonBar2.Groups[6].Items[1].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 11)) & relationMenuVal) == 0)
                    buttonBar2.Groups[6].Items[2].Enabled = false;
                else
                    buttonBar2.Groups[6].Items[2].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 15)) & relationMenuVal) == 0)
                    buttonBar2.Groups[6].Items[3].Enabled = false;
                else
                    buttonBar2.Groups[6].Items[3].Enabled = true;
                if ((Convert.ToInt32(Math.Pow(2, 14)) & relationMenuVal) == 0)
                    buttonBar2.Groups[6].Items[4].Enabled = false;
                else
                    buttonBar2.Groups[6].Items[4].Enabled = true;
            }
            catch (Exception e)
            {
                return false;
            }
            return true;
        }

        public static Boolean logSave(string logDetail)
        {
            string cmnd = "";
            string machineName = "";
            //SqlDataReader myReader = null;
            SqlCommand myCommand;

            try
            {
                if (logConnection.State != ConnectionState.Open)
                    logConnection.Open();
                System.Globalization.PersianCalendar pc = new System.Globalization.PersianCalendar();                
                DateTime DT =  DateTime.Now;
                if (userName.Length > 15)
                    userName = userName.Substring(0, 15);
                if (logDetail.Length > 100)
                    logDetail = logDetail.Substring(0, 100);

                machineName = System.Environment.MachineName;
                if (machineName.Length > 50)
                    machineName = machineName.Substring(0, 50);

                cmnd = "INSERT INTO GSLog (User_Name, User_UI, User_MachineName, User_LogDetail, User_Date, User_Time) " +
                       "VALUES('" + userName + "', "
                                  + "'client', "
                                  + "'" + machineName + "', "
                                  + "'" + logDetail + "', "
                                  + "'" + pc.GetYear(DT).ToString() + "/" + pc.GetMonth(DT).ToString() + "/" + pc.GetDayOfMonth(DT).ToString() + "', "
                                  + "'" + DT.Hour.ToString() + ":" + DT.Minute.ToString() + "') ";
                myCommand = new SqlCommand(cmnd, logConnection);
                myCommand.ExecuteNonQuery();
                myCommand.Dispose();
                if (logConnection.State != ConnectionState.Closed)
                    logConnection.Close();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
            
        }

        private void Startup_Load(object sender, EventArgs e)
        {
            string cmnd;
            SqlDataReader myReader = null;
            SqlCommand myCommand;
            int MnuBarVal = 0;
            int RelationMenuVal = 0;
            try
            {
                Login login = new Login();
                promptClose = true;
                cmnd = "SELECT UserName " +
                       "FROM users " +
                       "ORDER BY UserName ";

                myCommand = new SqlCommand(cmnd, myConnection);
                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    login.Users_list.Items.Add(myReader["UserName"].ToString());
                }
                myCommand.Dispose();
                myReader.Dispose();

                if (login.Users_list.Items.Count > 0)
                {
                    if (login.Users_list.Items.Contains("Admin"))
                        login.Users_list.SelectedIndex = login.Users_list.Items.IndexOf("Admin");
                    else if (login.Users_list.Items.Contains("admin"))
                        login.Users_list.SelectedIndex = login.Users_list.Items.IndexOf("admin");
                    else if (login.Users_list.Items.Contains("ADMIN"))
                        login.Users_list.SelectedIndex = login.Users_list.Items.IndexOf("ADMIN");
                    else
                        login.Users_list.SelectedIndex = 0;
                }


                cmnd = "IF not EXISTS(SELECT name " +
                       "FROM sysobjects " +
                       "WHERE (name = 'GSLog' ))" +
                       "CREATE TABLE GSLog " +
                       "(ID bigint IDENTITY (1, 1) NOT NULL," +
                       " User_Name nvarchar(15)," +
                       " User_UI nvarchar(6)," +
                       " User_MachineName nvarchar(50)," +
                       " User_LogDetail nvarchar(100)," +
                       " User_Date nvarchar(10)," +
                       " User_Time nvarchar(5))";
                myCommand = new SqlCommand(cmnd, myConnection);
                myCommand.ExecuteNonQuery();
                myCommand.Dispose();

                if (login.ShowDialog() != DialogResult.OK)
                {
                    promptClose = false;
                    this.Close();
                    return;
                }
                else if (login.DialogResult == DialogResult.OK)
                {
                    userName = login.Users_list.Text;
                    cmnd = "SELECT users.UserName, users.UserPassword, security.MenuBar, security.RelationMenu " +
                           "FROM users INNER JOIN " +
                           "security ON users.SecurityCode = security.Code " +
                           "where (users.UserName = '" + userName + "' and users.UserPassword = '" + codingPassword(login.txtUserPass.Text) + "') ";

                    myCommand = new SqlCommand(cmnd, myConnection);
                    myReader = myCommand.ExecuteReader();
                    if (!myReader.Read())
                    {
                        myCommand.Dispose();
                        myReader.Dispose();
                        if (!logSave("Username or Password failed")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        MessageBox.Show("! نام کاربر یا کلمه عبور اشتباه است", "خطا در اجرا", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        promptClose = false;
                        this.Close();
                        return;
                    }
                    userName = myReader["UserName"].ToString();//login.Users_list.SelectedItem.ToString();
                    MnuBarVal = Convert.ToInt32(myReader["MenuBar"].ToString());
                    RelationMenuVal = Convert.ToInt32(myReader["RelationMenu"].ToString());
                    myCommand.Dispose();
                    myReader.Dispose();
                    if ((Convert.ToInt32(Math.Pow(2, 4)) & MnuBarVal) == 0)
                    {
                        if (!logSave("Access denied")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        MessageBox.Show("! شما دسترسی لازم برای اجرای این برنامه را ندارید", "خطا در دسترسی", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        promptClose = false;
                        this.Close();
                        return;
                    }
                    if(!accessMenus(RelationMenuVal))
                    {
                        if (!logSave("Start program failed")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        MessageBox.Show("! اشکال در اجرای صحیح برنامه", "خطا در اجرا", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        promptClose = false;
                        this.Close();
                        return;
                    }
                }
            }
            catch (Exception e2)
            {
                if (!logSave("Start program failed")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                MessageBox.Show("! اشکال در اجرای صحیح برنامه", "خطا در اجرا", MessageBoxButtons.OK, MessageBoxIcon.Error);
                promptClose = false;
                this.Close();
                return;
            }
            if(!logSave("Login")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            try
            {
                string machineName = "";
                if (File.Exists(Constant.DBConfigFilePath))
                {
                    string[] detail = File.ReadAllLines(Constant.DBConfigFilePath);
                    
                    for (int t = 0; t < detail.Length; t++)
                    {
                        if (detail[t].Equals("GS_MachineName:"))
                            machineName = detail[t + 1].ToString();
                    }
                }
                ServiceController[] se = ServiceController.GetServices(machineName);
                foreach (ServiceController ff in se)
                    if (ff.DisplayName.Equals("GhadirService"))
                        if (ff.Status == ServiceControllerStatus.Running)
                        {
                            ff.Stop();
                            if (!logSave("Service stopped from [" + System.Environment.MachineName + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            MessageBox.Show("سرويس جمع آوري متوقف شد", "توقف سرويس", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        }
            }
            catch (Exception e2)
            {
                if (!logSave("Service stopping from [" + System.Environment.MachineName + "] failed (" + e2.InnerException.Message + ")")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                MessageBox.Show(e2.InnerException.Message, "اشکال در توقف سرويس", MessageBoxButtons.OK, MessageBoxIcon.Error);
                MessageBox.Show("اشکالی در متوقف نمودن سرویس جمع آوری رخ داد", "اشکال در توقف سرويس", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            show_sending_on_appropriate_row = new sending_marker(show_sending);
            UpdateAccessCodeList = new Fill_AccessCode_list(update_accescode_list);
            UpdateNonAuthorizedCardList = new Fill_NoneAuthorized_card_list(update_non_authorized_card_list);
            UpdatePrecardList = new Fill_Pre_Card_List(update_precard_list);
            UpdateOnlyCardList = new Fill_Only_Card_List(update_only_card_list);
            AlarmListUpdate = new add_to_list(update_alarm_list);

            form_recovery.Text = "Recovery";

            fill_cell = new fill_cell_in_dataview(fill_result_in_DGV_to_current_index);
            change_form_on_finish = new do_somting_on_finish(do_appropriate_change_on_finish_sending);
            update_device_detail_list();
            update_data_grid_view();

            for (int r = 0; r < device_detail.Count; r++)
                DataView.Rows[r].Cells[0].Value = false ;
            if (device_detail.Count > 0)
                DataView.Rows[0].Selected = true;

            show_no_data_panel();
            init_lbx();
        }

        private void update_accescode_list(string Group1, string Group2, string Group3, string Group4, string Group5)
        {
            lbx_access_code.Items.Clear();
            lbx_access_code.Items.Add(Group1);
            lbx_access_code.Items.Add(Group2);
            lbx_access_code.Items.Add(Group3);
            lbx_access_code.Items.Add(Group4);
            lbx_access_code.Items.Add(Group5);

        }

        private void update_non_authorized_card_list(ArrayList data)
        {
            lbx_non_authorized_card.Items.Clear();
            foreach (Object o in data)
                lbx_non_authorized_card.Items.Add(o.ToString());
        }

        private void update_alarm_list(ArrayList Data)
        {
            lbx_alarm.Items.Clear();
           
            string temp_string = "";
           
            for (int r=0;r<Data.Count;r++)
            {
                
                temp_string = string.Empty;
                temp_string += " Ins:  ";
                temp_string += Data[r].ToString(); 
                    r++;
                temp_string += "  Dur:  ";
                temp_string += Data[r].ToString();
                lbx_alarm.Items.Add(temp_string);
            }
        }

        private void update_only_card_list(ArrayList data)
        {
            lbx_only_card.Items.Clear();

            foreach (Object o in data)
                lbx_only_card.Items.Add(o.ToString());
        }

        private void update_precard_list(UInt64 location, UInt64 cardnumber, UInt64 code)
        {
            inp_precard_card_number.Text = cardnumber.ToString();
            inp_pre_card_code.Value = code;
            inp_pre_card_location.Value = location;
        }

        private void init_lbx()
        {

            ArrayList temp = access_codes.GetGroup();
            foreach (Object o in temp)
                lbx_access_code.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));

            temp = new ArrayList();
            temp = authorized_cards.GetGroup();
            foreach (Object o in temp)
                lbx_authority_card.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));

            temp = new ArrayList();
            temp = none_authorized_cards.GetGroup();
            foreach (Object o in temp)
                lbx_non_authorized_card.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));

            temp = new ArrayList();
            temp = alarms.GetGroup();
            string temp_string = "";
            UInt64 temp_uint64 = 0;
            UInt64 tt = 0;
            foreach (Object ttt in temp)
            {
                tt = Convert.ToUInt64(ttt);
                temp_string = string.Empty;
                temp_string += " Ins:  ";
                temp_uint64 = tt / (256 * 256 * 256);
                temp_string += temp_uint64.ToString();
                temp_string += ":";
                temp_uint64 = tt % (256 * 256 * 256);
                temp_uint64 /= (256 * 256);
                temp_string += temp_uint64.ToString();
                temp_uint64 = tt % (256 * 256);
                temp_string += "  Dur:  ";
                temp_string += temp_uint64.ToString();
                lbx_alarm.Items.Add(temp_string);
            }

           temp = new ArrayList();
           temp = only_cards.GetGroup();
           foreach (Object o in temp)
               lbx_only_card.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {


        }

        private void createDeviceConnectionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PhisycalLayer ph = new PhisycalLayer();
            ph.update_form(PhisycalLayer.FormType.Create);
            ph.ShowDialog();
            update_device_detail_list();
            update_data_grid_view();




        }

        public void update_data_grid_view()
        { 
            DataView.Rows.Clear();
            if (device_detail.Count == 0)
                return;

           
            DataView.Rows.Add(device_detail.Count);
            for (int ctr = 0; ctr < device_detail.Count; ctr++)
            {
                DataGridViewRow t = new DataGridViewRow();
                t = DataView.Rows[ctr];
                t.Cells[1].Value = ((DeviceDetail)device_detail[ctr]).Name;
                t.Cells[2].Value = ((DeviceDetail)device_detail[ctr]).Address;
                if (((DeviceDetail)device_detail[ctr]).ConnectionType == DeviceDetail.DeviceCommunicationType.SERIAL)
                    t.Cells[3].Value = ((DeviceDetail)device_detail[ctr]).Type + "-" + ((DeviceDetail)device_detail[ctr]).COMPort + "-" + ((DeviceDetail)device_detail[ctr]).BaudRate;
                if (((DeviceDetail)device_detail[ctr]).ConnectionType == DeviceDetail.DeviceCommunicationType.NETWORK)
                    t.Cells[3].Value = ((DeviceDetail)device_detail[ctr]).Type + "-" + ((DeviceDetail)device_detail[ctr]).IP + "-" + ((DeviceDetail)device_detail[ctr]).Port;
            }
            for (int y = 0; y < device_detail.Count; y++)
                DataView.Rows[y].Cells[0].Value = false;
        }

        private void update_device_detail_list_FromDB()
        {
            if (myConnection.State == ConnectionState.Open)
            {
                try
                {
                    SqlCommand myCommand;
                    SqlDataReader myReader = null;
                    string cmnd = "SELECT name " +
                                  "FROM sysobjects " +
                                  "WHERE (name = 'readers')";
                    myCommand = new SqlCommand(cmnd, myConnection);
                    myReader = myCommand.ExecuteReader();
                    myReader.Read();
                    if (!myReader.HasRows)
                    {
                        myReader.Dispose(); 
                        //DialogResult mBoxResult = ;
                        if (MessageBox.Show("                     !عدم وجود جدول اطلاعات دستگاهها" + Environment.NewLine + "آيا مايل به ایجاد جدول اطلاعات دستگاهها هستید؟", "جدول اطلاعات دستگاهها", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == DialogResult.Yes)
                        {
                            cmnd = "create table readers " +
                                          "([R_Code] [smallint] NOT NULL , " +
                                          "PRIMARY KEY  CLUSTERED ( [R_Code] ) , " +
                                          "[R_Name] [nvarchar] (20) COLLATE Arabic_CI_AI NULL , " +
                                          "[R_Station] [smallint] NULL , " +
                                          "[R_Active] [nvarchar] (1) COLLATE Arabic_CI_AI NULL , " +
                                          "[R_Port] [smallint] NULL , " +
                                          "[R_BaudNo] [smallint] NULL , " +
                                          "[R_Type] [smallint] NULL , " +
                                          "[R_Modem] [bit] NULL , " +
                                          "[R_IP] [nvarchar] (15) COLLATE Arabic_CI_AI NULL , " +
                                          "[R_TCP] [bit] NULL , " +
                                          "[R_IsCOM] [bit] NULL , " +
                                          "[R_COMType] [smallint] NULL , " +
                                          "[R_VideoDevice] [smallint] NULL , " +
                                          "[R_FrameRate] [smallint] NULL , " +
                                          "[R_LastFrame] [smallint] NULL )";
                            myCommand = new SqlCommand(cmnd, myConnection);
                            myCommand.ExecuteNonQuery();
                            myCommand.Dispose();
                        }
                        else
                            return;
                    }
                    else
                        myReader.Dispose(); 

                   
//                    SqlDataReader myReader = null;
                    int[] bauds={2400,4800,9600,19200,38400};
//                    SqlCommand myCommand = new SqlCommand("select * from Readers", myConnection);
                    myCommand = new SqlCommand("select * from readers where (R_Type = 2)", myConnection);
                    myReader = myCommand.ExecuteReader();

                    DeviceDetail temp = new DeviceDetail();
                    device_detail.Clear();
                    while (myReader.Read())
                    {
                        temp = new DeviceDetail();
                        temp.Address = Convert.ToUInt32(myReader["R_Code"].ToString());
                        temp.Name = myReader["R_Name"].ToString();
                        temp.Type = DeviceDetail.DeviceType.CLK6000;
//871215                        if (Convert.ToBoolean(myReader["R_IsCom"].ToString()))
                        switch (myReader["R_COMType"].ToString())
                        {
                            case "0": //COM
                                temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                                temp.BaudRate = bauds[Convert.ToInt32(myReader["R_BaudNo"].ToString())];
                                temp.COMPort = "COM" + myReader["R_Port"].ToString();
                                break;
                            case "1": //Network
                                temp.ConnectionType = DeviceDetail.DeviceCommunicationType.NETWORK;
                                temp.IP = Utility.GetIPAddress(myReader["R_IP"].ToString());
                                temp.Port = 1001;
                                break;
                        }
/*                            if (myReader["R_COMType"].ToString()=='0')
                            {
                            temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                            temp.BaudRate = bauds[Convert.ToInt32(myReader["R_BaudNo"].ToString())];
                            temp.COMPort = "COM" + myReader["R_Port"].ToString();
                            }
                            else
                            {
                            temp.ConnectionType = DeviceDetail.DeviceCommunicationType.NETWORK;
                            temp.IP = Utility.GetIPAddress(myReader["R_IP"].ToString());
                            temp.Port = 1001;
                            }*/      
                        device_detail.Add(temp);
                    }
                    myCommand.Dispose();
                    myReader.Dispose();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
                }
            }
        }

        private void update_device_detail_list()
        {
            update_device_detail_list_FromDB();
            return;
            DeviceDetail temp = new DeviceDetail();
            device_detail.Clear();

            if(!Directory.Exists(Constant.ConfigFileDirectory))
                Directory.CreateDirectory(Constant.ConfigFileDirectory);

            if (!File.Exists(Constant.ConfigFilePath))
                return;
            string[] detail = File.ReadAllLines(Constant.ConfigFilePath);

            if (detail.Length < 11)
                return;

            for (int t = 0; t < detail.Length; t++)
            {
                if (detail[t].Equals("NEW DEVICE DETAIL START"))
                    temp = new DeviceDetail();
                if (detail[t].Equals("TYPE:"))
                    if (detail[t + 1] == DeviceDetail.DeviceType.CLK6000.ToString())
                        temp.Type = DeviceDetail.DeviceType.CLK6000;
                    else if (detail[t + 1] == DeviceDetail.DeviceType.MTT5000.ToString())
                        temp.Type = DeviceDetail.DeviceType.MTT5000;
                    else if (detail[t + 1] == DeviceDetail.DeviceType.ACC1000.ToString())
                        temp.Type = DeviceDetail.DeviceType.ACC1000;
                if (detail[t].Equals("NAME:"))
                    temp.Name = detail[t + 1];
                if (detail[t].Equals("Address:"))
                    temp.Address = Convert.ToUInt32(detail[t + 1]);
                if (detail[t].Equals("SERIAL:"))
                {
                    temp.ConnectionType = DeviceDetail.DeviceCommunicationType.SERIAL;
                    temp.COMPort = detail[t + 1];
                    temp.BaudRate = Convert.ToInt32(detail[t + 2]);
                }
                if (detail[t].Equals("NETWORK:"))
                {
                    temp.ConnectionType = DeviceDetail.DeviceCommunicationType.NETWORK;
                    temp.IP = Utility.GetIPAddress(detail[t + 1]);
                    temp.Port = Convert.ToInt32(detail[t + 2]);
                }
                if (detail[t].Equals("NEW DEVICE DETAIL END"))
                    device_detail.Add(temp);
            }
        }

        private void splitContainer1_Panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void DataView_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex > -1)
            {
                PhisycalLayer ph = new PhisycalLayer();
                ph.dd = (DeviceDetail)device_detail[e.RowIndex];
                ph.update_form(PhisycalLayer.FormType.Edit);
                ph.ShowDialog();
                update_device_detail_list();
                update_data_grid_view();
            }

        }

        private void DataView_CellClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void fill_result_in_DGV_to_current_index(string str, Color col)
        {
            if (DataView.Rows.Count == 0)
                return;
            DataView.Rows[current_device_index].Cells[4].Style.ForeColor = col;
            DataView.Rows[current_device_index].Cells[4].Value = str;
        }

        void Device_NotResponse(ArrayList LastSentCommand)
        {
            object[] temp = new object[] { "عدم دريافت پاسخ از پايانه", Color.Red };
            DataView.Invoke(fill_cell, temp);
            complicate_command = comp_command.none;
            mode_investigate_and_do_appropriate_action();
        }

        void Device_CommandDone(PacketInfo Info, ulong PacketCount, ulong PacketLenght)
        {
            object[] temp = new object[] { string.Empty };

            switch (Info.Command)
            {
                case 0x01:
                    temp = new object[] { "ارتباط برقرار ميباشد", Color.Black };
                    DataView.Invoke(fill_cell, temp);
                    break;

                case 0x03:
                    
                    try
                    {
                        if (complicate_command == comp_command.collection || complicate_command == comp_command.fast_collection)
                        {
                            if ( records.ToString() == "0")
                                temp = new object[] {"هیچ رکورد جدیدی وجود ندارد", Color.Black };
                            else
                                temp = new object[] {records.ToString() + " رکورد بطور کامل جمع آوری شد", Color.Black };
                            DataView.Invoke(fill_cell, temp);
                            temp = new object[] { "0", "0", "0", "0", "0" };
                            form_collection.Invoke(form_collection.AddToViewList, temp);
                        }
                        if (complicate_command == comp_command.recovery || complicate_command == comp_command.permanent_recovery)
                        {
                            temp = new object[] { records.ToString(), Color.Black };
                            DataView.Invoke(fill_cell, temp);
                            temp = new object[] { "0", "0", "0", "0", "0" };
                            form_recovery.Invoke(form_recovery.AddToViewList, temp);
                        }
                        
                    }
                    catch
                    {
                    }
                    complicate_command = comp_command.none;
                    this.Invoke(change_form_on_finish);
                    break;

                case 0x04:
                 
                     try
                     {
                         if (complicate_command == comp_command.collection || complicate_command == comp_command.fast_collection)
                         {
                             records++;
                             records++;
                             temp = new object[] { records.ToString(), Color.Black };
                             DataView.Invoke(fill_cell, temp);
                             temp = new object[] { Info.GetFirsrObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString() };
                             form_collection.Invoke(form_collection.AddToViewList, temp);
                            
                         }

                         if (complicate_command == comp_command.recovery || complicate_command == comp_command.permanent_recovery)
                         {
                             records++;
                             temp = new object[] { records.ToString(), Color.Black };
                             DataView.Invoke(fill_cell, temp);
                             temp = new object[] { Info.GetFirsrObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString() };
                             form_recovery.Invoke(form_recovery.AddToViewList, temp);
                            
                         }
                     }
                     catch
                     {                     }

                    
                     break;                 

                case 0x06:
                        temp = new object[] { "دستور با موفقيت انجام گرديد", Color.Black };
                        DataView.Invoke(fill_cell, temp);
                    break;

                case 0x0d:
                    temp = new object[] { Info.GetFirsrObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString() };
                    pnl_access_code.Invoke(UpdateAccessCodeList, temp);
                    break;

                case 0x0e:
                    temp = new object[] { Info.GetFirsrObject().ToString(), Color.Black };
                    DataView.Invoke(fill_cell, temp);
                    break;
                    
                case 0x21:
                    temp = new object[] { Info.GetFirsrObject().ToString() + " | " + Info.GetNextObject().ToString(), Color.Black };
                    DataView.Invoke(fill_cell, temp);
                    break;

                case 0x25:
                    temp = new object[] { Info.GetEntireData() };
                    pnl_alarms.Invoke(AlarmListUpdate, temp);
                    break;

                case 0x29:
                    temp = new object[] { Info.GetEntireData() };
                    pnl_non_authority_codes.Invoke(UpdateNonAuthorizedCardList, temp);
                    break;

                case 0x3e:
                    temp = new object[] { Info.GetEntireData() };
                    pnl_only_card.Invoke(UpdateOnlyCardList, temp);
                    break;
                case 0x46:
                    temp = new object[] { Info.GetEntireData() };
                    DataView.Invoke(fill_cell, temp);
                    break;
                case 0x57:
                    temp = new object[] { Convert.ToUInt64(Info.GetFirsrObject()), Convert.ToUInt64(Info.GetNextObject()), Convert.ToUInt64(Info.GetNextObject()) };
                    pnl_precard.Invoke(UpdatePrecardList, temp);
                    break;

                case 0x5a:                    
                    if (Device.LastSentPacket.Command == 0x02 || Device.LastSentPacket.Command == 0x06)
                    {
                        try
                        {
                            temp = new object[] { Info.GetFirsrObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString() };
                            form_collection.Invoke(form_collection.AddToViewList, temp);
                            records++;
                            for (UInt64 t = 0; t < PacketCount - 1; t++)
                            {
                                records++;
                                temp = new object[] { records.ToString(), Color.Black };
                                DataView.Invoke(fill_cell, temp);
                                temp = new object[] { Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString(), Info.GetNextObject().ToString() };
                                form_collection.Invoke(form_collection.AddToViewList, temp);
                            }
                        }
                        catch
                        {
                        }
                        
                    }
                    break;

            }  

            mode_investigate_and_do_appropriate_action();
           

        }



        private void mode_investigate_and_do_appropriate_action()
        {

            switch (mode)
            {
                case send_mode.send_to_one_device:
                    switch (complicate_command)
                    {
                        case comp_command.none:
                            this.Invoke(change_form_on_finish);
                            mode = send_mode.none;
                            break; 
                        case comp_command.collection:
                        case comp_command.fast_collection:
                        case comp_command.permanent_recovery:
                        case comp_command.recovery:
                            execute_command(Z84Family.DeviceCommand.Acknowledge);
                            break;
                    }
                    break;

                case send_mode.send_to_all_device:

                    while (true)
                    {
                        current_device_index++;
                        if (send_to_multiple_device_finished())
                        {
                            mode = send_mode.none;
                            DataView.Invoke(change_form_on_finish);
                            if (device_detail.Count > 0)
                                select_row_on_dgv(0);
                            return;
                        }
                        DataView.Invoke(show_sending_on_appropriate_row);
                        if (prepare_current_media())
                            break;
                        else
                            show_can_not_create_media();
                    }
                    execute_current_command();
                    break;

                case send_mode.sned_to_selected_device: 
                    while (true)
                    {
                        current_device_index++;
                        if (send_to_multiple_device_finished())
                        {
                            mode = send_mode.none;
                            DataView.Invoke(change_form_on_finish);
                            if (device_detail.Count > 0)
                                select_row_on_dgv(0);
                            break; ;
                        }
                        if ((bool)(DataView.Rows[current_device_index].Cells[0].Value) == true)
                        {
                            DataView.Invoke(show_sending_on_appropriate_row);
                            if (prepare_current_media())
                            {
                                execute_current_command();
                                break;
                            }
                            else
                                show_can_not_create_media();
                        }                        
                    }                    
                    break;
            }
            
        }
        
        void Device_ReceiveComplete(ArrayList ReceivePacket)
        {
            try
            {
                Object[] temp = new object[] { ReceivePacket, RawData.PaketType.ReceivedPacket };
                form_raw_data.Invoke(form_raw_data.AddToRawDataList, temp);
            }
            catch
            {
            }

        }

        void Device_BadReceivePacket(Z84Frame.Z84PacketErrors Error)
        {
            object[] temp;
           
            if (current_eror > max_error)
            {
                temp = new object[] { "اشكال در چند فريم متوالي", Color.Blue };
                DataView.Invoke(fill_cell, temp);
                mode = send_mode.none;
                do_appropriate_change_on_finish_sending();
            }

            temp = new object[] { "اشكال در فريم گرفته شده", Color.Blue };
            DataView.Invoke(fill_cell, temp);
            if (complicate_command == comp_command.none)
                mode_investigate_and_do_appropriate_action();
            else
            {
                current_eror++;
                execute_command(Z84Family.DeviceCommand.NoneAcknowledge);
            }
        }

        void Device_SendComplete(Z84Frame SendPacket)
        {
            try
            {
                Object[] temp = new object[] { SendPacket.GetEntireFrame(), RawData.PaketType.SentPacket };
                form_raw_data.Invoke(form_raw_data.AddToRawDataList, temp);
            }
            catch
            {
            }
        }

        private void clearResultFieldsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            for (int ctr = 0; ctr < device_detail.Count; ctr++)
            {
                DataView.Rows[ctr].Cells[4].Style.ForeColor = Color.Black;
                DataView.Rows[ctr].Cells[4].Value = string.Empty;
                DataView.Rows[ctr].Selected = false;
            }
            DataView.Rows[DataView.CurrentRow.Index].Selected = true;
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            records = 0;
            
            int t;
            Boolean haveSelected = false;
            for (t = 0; t < device_detail.Count; t++)
                if (DataView.Rows[t].Selected)
                {
                    haveSelected = true;
                    break;
                }
            if (haveSelected)
                current_device_index = t;
            else
                current_device_index = -1;
            
            do_appropriate_change_on_start_sending();
            mode = send_mode.send_to_one_device;

            DataView.Invoke(show_sending_on_appropriate_row);
            if (!prepare_current_media())
            {
                show_can_not_create_media();
                do_appropriate_change_on_finish_sending();
            }
            else
                execute_current_command();

        }

        private void show_no_data_panel()
        {
            pnl_nodata.BringToFront();
            splitContainer1.SplitterDistance = 50;
        }

        private void DataView_CellClick_1(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex>=0)
                DataView.Rows[e.RowIndex].Selected = true;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            mode = send_mode.none;
            do_appropriate_change_on_finish_sending();
        }        

        private void button18_Click(object sender, EventArgs e)
        {
            for (int ctr = 0; ctr < device_detail.Count; ctr++)
            {
                DataView.Rows[ctr].Cells[4].Style.ForeColor = Color.Black;
                DataView.Rows[ctr].Cells[4].Value = string.Empty;
                DataView.Rows[ctr].Selected = false;
            }

            if (!is_group_command(current_command))
            {
                MessageBox.Show("پخش گروهي براي اين دستور امكان پذير نمي باشد");
                select_row_on_dgv(0);
                return;
            }
            do_appropriate_change_on_start_sending();
            mode = send_mode.send_to_all_device;
            current_device_index = -1;
            mode_investigate_and_do_appropriate_action();
        }

      
        void show_panel_set_address()
        {
            current_command = Z84Family.DeviceCommand.SetTerminalAddress;
            pnl_terminal_address.BringToFront();
            splitContainer1.SplitterDistance = 40;
        }

        
        void show_panel_set_baud()
        {
            current_command = Z84Family.DeviceCommand.SetBaudRate;
            pnl_boud_rate.BringToFront();
            splitContainer1.SplitterDistance = 40;
        }

        void show_panel_set_time()
        {
            pnl_date_time.BringToFront();
            splitContainer1.SplitterDistance = 75;
            rdb_ged_date_and_time.Checked = true;
            current_command = Z84Family.DeviceCommand.GetTimeAndDate;
        }


        void show_panel_kb_pw()
        {
            pnl_pass_word.BringToFront();
            current_command = Z84Family.DeviceCommand.ChangeKeypadPassword;
            splitContainer1.SplitterDistance = 40;
        }

        void show_panel_access_code()
        {
            pnl_access_code.BringToFront();
            splitContainer1.SplitterDistance = 160;
            current_command = Z84Family.DeviceCommand.GetAccessCode;
            rdb_get_access_code.Checked = true;
        }


        void show_panel_alarm()
        {
            pnl_alarms.BringToFront();
            splitContainer1.SplitterDistance = 160;
            current_command = Z84Family.DeviceCommand.GetAlarms;
            rdb_get_alarm.Checked = true;
        }


        void show_panel_nonauthorized_codes()
        {
            pnl_non_authority_codes.BringToFront();
            splitContainer1.SplitterDistance = 160;
            current_command = Z84Family.DeviceCommand.GetNonAuthorizeCards;
            rdb_get_nonauthorized_code.Checked = true;
        }


        void show_panel_only_card()
        {
            pnl_only_card.BringToFront();
            splitContainer1.SplitterDistance = 160;
            current_command = Z84Family.DeviceCommand.GetOnlyCardList;
            rdb_get_only_card.Checked = true;
        }


        void show_panel_door()
        {
            pnl_door.BringToFront();
            splitContainer1.SplitterDistance = 110;
            current_command = Z84Family.DeviceCommand.OpenDoor;
            rdb_open_door.Checked = true;
        }


        void show_panel_printer()
        {
            pnl_printer.BringToFront();
            splitContainer1.SplitterDistance = 80;
            current_command = Z84Family.DeviceCommand.SetPrinter;
            rdb_setprinter.Checked = true;
        }

        
        void show_panel_screen()
        {
            pnl_display.BringToFront();
            splitContainer1.SplitterDistance = 160;
            rdb_clean_screen.Checked = true;
            current_command = Z84Family.DeviceCommand.ClearScreen;
        }

        
        void show_panel_collection()
        {
            pnl_collection.BringToFront();
            splitContainer1.SplitterDistance = 70;
            current_command = Z84Family.DeviceCommand.Collection;
            complicate_command = comp_command.collection;
            form_collection.Show();
            form_collection.Hide();
//          inp_collection_detail.Checked = false;
            rdb_collection.Checked = true;
        }

        
        void show_panel_recovery()
        {
            pnl_recovery.BringToFront();
            splitContainer1.SplitterDistance = 70;
            current_command = Z84Family.DeviceCommand.RecoveryByDate;
            complicate_command = comp_command.recovery;
            form_recovery.Show();
            form_recovery.Hide();
//            inp_recovery_detail.Checked = false;
            rdb_recovery_by_date.Checked = true;
        }

        
        void show_panel_precard()
        {
            pnl_precard.BringToFront();
            current_command = Z84Family.DeviceCommand.GetPreCard;
            splitContainer1.SplitterDistance=110;
            rdb_get_pre_card.Checked = true;
        }

        void show_panel_card_message()
        {
            pnl_ard_message.BringToFront();
            splitContainer1.SplitterDistance = 140;
            current_command = Z84Family.DeviceCommand.GetMessage;
            rdb_get_card_message.Checked = true;
        }

        
        void show_panel_card_limit()
        {
            pnl_card_limit.BringToFront();
            splitContainer1.SplitterDistance = 110;
            rdb_getcardlimit.Checked = true;
            //current_command = Z84Family.DeviceCommand.getcar

        }

        void show_panel_Time_limit()
        {
            pnl_Time_Limit.BringToFront();
            splitContainer1.SplitterDistance = 110;
            rdb_GetTimelimit.Checked = true;
            current_command = Z84Family.DeviceCommand.GetTimeLimit;

        }
        
        void show_panel_authirity_cards()
        {
            pnl_authorized_card.BringToFront();
            splitContainer1.SplitterDistance = 160;
        }

        private void inp_date_Leave(object sender, EventArgs e)
        {
            if (!Utility.IsDateString(inp_date.Text))
            {
                MessageBox.Show("لطفا تاريخ را تصحيح كنيد");
                inp_date.Focus();
            }
            else
                set_date_time = Utility.GenerateDateTime(inp_date.Text, inp_time.Text);


        }

        private void rdb_set_alarm_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetAlarms;
        }

        private void rdb_get_alarm_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetAlarms;
        }

        private void rdb_clear_alarm_CheckedChanged(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ClearAlarms;
        }

        private void rdb_set_card_message_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetMessage;
        }

        private void rdb_get_card_message_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetMessage;
        }

        private void rdb_clear_one_card_message_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ClearOneCardMessage;
        }

        private void rdb_clear_all_card_message_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ClearAllMessage;
        }

        private void rdb_set_nonauthorized_code_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetNoneAuthorizeCards;
        }

        private void rdb_get_nonauthorized_code_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetNonAuthorizeCards;
        }

        private void rdb_clear_nonauthorized_code_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ClearNonAuthorizeCards;
        }

        private void rdb_set_precard_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetPreCard;
        }

        private void rdb_get_pre_card_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetPreCard;
        }

        private void rdb_set_only_card_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetOnlycardlist;
        }

        private void rdb_get_only_card_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetOnlyCardList;
        }

        private void rdb_clear_only_card_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ClearOnlyCardList;
        }

        private void rdb_open_door_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.OpenDoor;
        }

        private void rdo_lock_door_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.LockDoor;
        }

        private void rdo_unlock_door_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.UnLockDoor;
        }

        private void rdo_buzzer_off_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetDoorBuzzer;
            door_buzzer = Z84Family.TerminalBuzzerDoor.Enable;
        }

        private void rdo_buzzer_on_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetDoorBuzzer;
            door_buzzer = Z84Family.TerminalBuzzerDoor.Disable;
        }

        private void rdb_send_date_and_time_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetTimeAndDate;
        }

        private void rdb_ged_date_and_time_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetTimeAndDate;
        }

        private void rdb_clean_screen_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ClearScreen;
        }

        private void rdb_show_message_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.DisplayRowMessage;
        }

        private void rdb_show_short_message_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ShortMessage;
        }

        private void rdb_beep_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.MultiBeep;
        }

        private void rdb_set_access_code_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetAccessCode;
        }

        private void rdb_get_access_code_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetAccessCode;
        }

        private void rdb_clear_access_code_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ClearAccessCode;
        }

        private void inp_time_Leave(object sender, EventArgs e)
        {
            if (!Utility.IsTimeString(inp_time.Text))
            {
                MessageBox.Show("لطفا زمان را تصحيح كنيد");
                inp_time.Focus();
            }
            else
                set_date_time = Utility.GenerateDateTime(inp_date.Text, inp_time.Text);

        }

        private void inp_buod_rate_Leave(object sender, EventArgs e)
        {
            if (inp_buod_rate.Text.Equals("38400"))
                boud_rate = Z84Family.TerminalBaudRate.BaudRaate_38400;
            else if (inp_buod_rate.Text.Equals("19200"))
                boud_rate = Z84Family.TerminalBaudRate.BaudRaate_19200;
            else if (inp_buod_rate.Text.Equals("9600"))
                boud_rate = Z84Family.TerminalBaudRate.BaudRaate_9600;
            else if (inp_buod_rate.Text.Equals("4800"))
                boud_rate = Z84Family.TerminalBaudRate.BaudRaate_4800;
            else if (inp_buod_rate.Text.Equals("2400"))
                boud_rate = Z84Family.TerminalBaudRate.BaudRaate_2400;
            else
            {
                MessageBox.Show("لطفا سرعت را تصحيح كنيد");
                inp_buod_rate.Focus();
            }

        }

        private void textBox1_Leave(object sender, EventArgs e)
        {
            
            if (txb_new_password.Text.Length > 5)
            {
                MessageBox.Show("لطفا رمز عبور را تصحيح نماييد");
                txb_new_password.Focus();
                return;
            }
           try
            {
                Convert.ToUInt16(txb_new_password.Text);
                kb_pw = txb_new_password.Text;
            }
            catch
            {
                MessageBox.Show("لطفا رمز عبور را تصحيح نماييد");
                txb_new_password.Focus();
            }
        
        }

        private void inp_door_DURATION_Leave(object sender, EventArgs e)
        {
            duration = Convert.ToUInt32(inp_door_DURATION.Value);
        }

        private void inp_terminal_address_Leave(object sender, EventArgs e)
        {
            terminal_address = Convert.ToUInt32(inp_terminal_address.Value);
        }

        private void inp_row_message_Leave(object sender, EventArgs e)
        {
            row_message = inp_row_message.Text;
        }

        private void inp_beep_count_Leave(object sender, EventArgs e)
        {
            beep_count =Convert.ToUInt32( inp_beep_count.Value);

        }

        private void inp_text_location_y_Leave(object sender, EventArgs e)
        {
            text_location_y = Convert.ToUInt32(inp_text_location_y.Value);

        }

        private void inp_text_location_x_Leave(object sender, EventArgs e)
        {
            text_location_x = Convert.ToUInt32(inp_text_location_x);
        }

        private void inp_card_number_for_message_Leave(object sender, EventArgs e)
        {
            if (Utility.ChangeToDecimal(inp_card_number_for_message.Text) == 0 || inp_card_number_for_message.Text.Length > 8)
            {
                MessageBox.Show("لطفا شماره كارت را تصحيح نماييد");
                inp_card_number_for_message.Focus();
            }
            else
                card_number_for_message = new CardNumber(Utility.ChangeToDecimal(inp_card_number_for_message.Text));
           
        }

        private void inp_message_for_card_Leave(object sender, EventArgs e)
        {
            message_for_card = inp_message_for_card.Text;
        }

        private void inp_precard_card_number_Leave(object sender, EventArgs e)
        {
            if (Utility.ChangeToDecimal(inp_precard_card_number.Text) == 0 || inp_precard_card_number.Text.Length > 8)
            {
                MessageBox.Show("لطفا شماره كارت را تصحيح نماييد");
                inp_precard_card_number.Focus();
            }
            else
                precard_card_number = new CardNumber(Utility.ChangeToDecimal(inp_precard_card_number.Text));
        
        }

        private void inp_pre_card_code_Leave(object sender, EventArgs e)
        {
            precard_location =Convert.ToUInt32( inp_pre_card_location.Value);
        }

        private void inp_pre_card_location_Leave(object sender, EventArgs e)
        {
            precard_code =Convert.ToUInt32( inp_pre_card_code.Value);
        }

        private void button6_Click(object sender, EventArgs e)
        {
            alarms.Add(Convert.ToUInt32(inp_alarm_hour.Value),Convert.ToUInt32( inp_alarm_minute.Value),Convert.ToUInt32( inp_alarm_duration.Value));

            lbx_alarm.Items.Clear();
            ArrayList temp = alarms.GetGroup();
            string temp_string = "";
            UInt64 temp_uint64 = 0;
            UInt64 tt = 0;
            foreach (Object ttt in temp)
            {
                tt = Convert.ToUInt64(ttt);
                temp_string = string.Empty;
                temp_string += " Ins:  ";
                temp_uint64 = tt / (256 * 256 * 256);
                temp_string += temp_uint64.ToString();
                temp_string += ":";
                temp_uint64 = tt % (256 * 256 * 256);
                temp_uint64 /= (256 * 256);
                temp_string += temp_uint64.ToString();
                temp_uint64 = tt % (256 * 256);
                temp_string += "  Dur:  ";
                temp_string += temp_uint64.ToString();
                lbx_alarm.Items.Add(temp_string);
            }

        }

        private void button9_Click(object sender, EventArgs e)
        {
            alarms.EmptyGroup();
            lbx_alarm.Items.Clear();
            ArrayList temp = alarms.GetGroup();
            string temp_string = "";
            UInt64 temp_uint64 = 0;
            UInt64 tt = 0;
            foreach (Object ttt in temp)
            {
                tt = Convert.ToUInt64(ttt);
                temp_string = string.Empty;
                temp_string += " Ins:  ";
                temp_uint64 = tt / (256 * 256 * 256);
                temp_string += temp_uint64.ToString();
                temp_string += ":";
                temp_uint64 = tt % (256 * 256 * 256);
                temp_uint64 /= (256 * 256);
                temp_string += temp_uint64.ToString();
                temp_uint64 = tt % (256 * 256);
                temp_string += "  Dur:  ";
                temp_string += temp_uint64.ToString();
                lbx_alarm.Items.Add(temp_string);
            }


        }

        private void button8_Click(object sender, EventArgs e)
        {
            access_codes.AddDecimal(Convert.ToUInt32(inp_access_code.Value));

            lbx_access_code.Items.Clear();
            ArrayList temp = access_codes.GetGroup();
            foreach (Object a in temp)
                lbx_access_code.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(a)));
        }

        private void button10_Click(object sender, EventArgs e)
        {
            access_codes.EmptyGroup();
            lbx_access_code.Items.Clear();
            ArrayList temp = access_codes.GetGroup();
            foreach (Object a in temp)
                lbx_access_code.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(a)));

        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (Utility.ChangeToDecimal(inp_non_authorize_card.Text) == 0 || inp_non_authorize_card.Text.Length > 8)
            {
                MessageBox.Show("لطفا شماره كارت را تصحيح نماييد");
                inp_non_authorize_card.Focus();
            }
            else
            {
                none_authorized_cards.Add(Convert.ToUInt32(Utility.ChangeToDecimal(inp_non_authorize_card.Text)));

                lbx_non_authorized_card.Items.Clear();
                ArrayList temp = none_authorized_cards.GetGroup();
                foreach (Object o in temp)
                    lbx_non_authorized_card.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));

            }
                
        }

        private void button11_Click(object sender, EventArgs e)
        {
            none_authorized_cards.EmptyGroup();
            lbx_non_authorized_card.Items.Clear();
            ArrayList temp = none_authorized_cards.GetGroup();
            foreach (Object o in temp)
                lbx_non_authorized_card.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));

        }

        private void rdb_set_authority_cars_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetAuthorityList;
        }

        private void rdb_get_authoriity_cars_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetAuthorityList;

        }

        private void rdb_clear_authority_card_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.ClearAuthorityList;
        }

        private void button13_Click(object sender, EventArgs e)
        {
            if (Utility.ChangeToDecimal(inp_authority_card.Text) == 0 || inp_authority_card.Text.Length > 8)
            {
                MessageBox.Show("لطفا شماره كارت را تصحيح نماييد");
                inp_authority_card.Focus();
            }
            else
            {

                authorized_cards.Add(Utility.ChangeToDecimal(inp_authority_card.Text));

                lbx_authority_card.Items.Clear();

                ArrayList temp = authorized_cards.GetGroup();
                foreach (Object o in temp)
                    lbx_authority_card.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));
            }
        }

        private void button12_Click(object sender, EventArgs e)
        {
            authorized_cards.EmptyGroup();
            lbx_authority_card.Items.Clear();

            ArrayList temp = authorized_cards.GetGroup();
            foreach (Object o in temp)
                lbx_authority_card.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));

        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (Utility.ChangeToDecimal(inp_only_card.Text) == 0 || inp_only_card.Text.Length > 8)
            {
                MessageBox.Show("لطفا شماره كارت را تصحيح نماييد");
                inp_only_card.Focus();
            }
            else
            {
                only_cards.Add(Utility.ChangeToDecimal(inp_only_card.Text));

                lbx_only_card.Items.Clear();

                ArrayList temp = only_cards.GetGroup();

                foreach (object o in temp)
                    lbx_only_card.Items.Add(Utility.ChangeToHex(Convert.ToUInt64(o)));
            }
        }
       
      

        private void inp_collection_detail_CheckedChanged(object sender, EventArgs e)
        {
            if (inp_collection_detail.Checked)
                form_collection.Show();
            else
                form_collection.Hide();

        }

        private void inp_recovery_detail_CheckedChanged(object sender, EventArgs e)
        {
            if (inp_recovery_detail.Checked)
                form_recovery.Show();
            else
                form_recovery.Hide();
            
        }

        private void exit_Click(object sender, EventArgs e)
        {
            this.Close();           
        }

        private void row_data_Click(object sender, EventArgs e)
        {
         //   if (row_data.Checked)
                form_raw_data.Show();
          //  else
            //    form_raw_data.Hide();
        }

        private void Startup_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (promptClose)
            {
                if (MessageBox.Show("آيا مايل به خروج از برنامه هستيد؟", "خروج", MessageBoxButtons.YesNo, MessageBoxIcon.Stop) == DialogResult.Yes)
                {
                    if (!logSave("Logout")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    try
                    {
                        string machineName = "";
                        if (File.Exists(Constant.DBConfigFilePath))
                        {
                            string[] detail = File.ReadAllLines(Constant.DBConfigFilePath);

                            for (int t = 0; t < detail.Length; t++)
                            {
                                if (detail[t].Equals("GS_MachineName:"))
                                    machineName = detail[t + 1].ToString();
                            }
                        }
                        ServiceController[] se = ServiceController.GetServices(machineName);
                        foreach (ServiceController ff in se)
                            if (ff.DisplayName.Equals("GhadirService"))
                            {
                                ff.Start();
                                if (!logSave("Service started from [" + System.Environment.MachineName + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                MessageBox.Show("سرويس جمع آوري راه اندازي شد", "راه اندازي سرويس", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            }
                    }
                    catch(Exception e2)
                    {
                        if (!logSave("Service starting from [" + System.Environment.MachineName + "] failed (" + e2.InnerException.Message + ")")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        MessageBox.Show(e2.InnerException.Message, "اشکال در راه اندازی سرويس", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        MessageBox.Show("اشکالی در راه اندازی سرویس جمع آوری رخ داد", "اشکال در راه اندازی سرويس", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                    Application.ExitThread();
                }
                else
                    e.Cancel = true;
            }
        }

        private void rdb_collection_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.Collection;
            complicate_command = comp_command.collection;
        }

        private void rdb_fast_collection_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.FastCollection;
            complicate_command = comp_command.fast_collection;
        }

        private void rdb_recovery_by_date_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.RecoveryByDate;
            complicate_command = comp_command.recovery;
        }

        private void rdb_permanent_recovery_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.PermanentRecovery;
            complicate_command = comp_command.permanent_recovery;
        }

        private void new_device_Click(object sender, EventArgs e)
        {
            PhisycalLayer p = new PhisycalLayer();
            p.update_form(PhisycalLayer.FormType.Create);
            p.ShowDialog();
            update_device_detail_list();
            update_data_grid_view();            
        }

        private void cmn_clear_current_row_Click(object sender, EventArgs e)
        {
            int t;
            for (t = 0; t < device_detail.Count; t++)
                if (DataView.Rows[t].Selected)
                    break;
            DataView.Rows[t].Cells[4].Style.ForeColor = Color.Black;
            DataView.Rows[t].Cells[4].Value = string.Empty;          
        }
        private void delete_device_From_DB()
        {
            SqlCommand myCommand = new SqlCommand("Delete from readers where r_code = " + DataView.SelectedRows[0].Cells[2].Value, myConnection);
            myCommand.ExecuteNonQuery();
            if (!Startup.logSave("Device Deleted - Device: [" + DataView.SelectedRows[0].Cells[1].Value + "] - Address: [" + DataView.SelectedRows[0].Cells[2].Value + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            
            update_device_detail_list();
            update_data_grid_view();
            if (device_detail.Count > 0)
                select_row_on_dgv(0);
        }
        private void cmn_delete_device_Click(object sender, EventArgs e)
        {
            delete_device_From_DB();
            return;
            if (!File.Exists(Constant.ConfigFilePath))
                return;


            string[] temp = File.ReadAllLines(Constant.ConfigFilePath);

            if (temp.Length < 14)
            {
                File.Delete(Constant.ConfigFilePath);
                update_device_detail_list();
                update_data_grid_view();
                return;
            }

            int yy;
            for (yy = 0; yy < device_detail.Count; yy++)
                if (DataView.Rows[yy].Selected)
                    break;

            for (int t=yy*13; t < temp.Length-13; t++)
                temp[t] = temp[t + 13];

            Array.Resize(ref temp, temp.Length - 13);


                  File.WriteAllLines(Constant.ConfigFilePath, temp);

            update_device_detail_list();
            update_data_grid_view();
            if(device_detail.Count>0)
                select_row_on_dgv(0);
        }

        private void cmn_edit_device_Click(object sender, EventArgs e)
        {
            PhisycalLayer p = new PhisycalLayer();
       
            p.dd = (DeviceDetail) device_detail[DataView.CurrentRow.Index];
                p.update_form(PhisycalLayer.FormType.Edit);
            p.ShowDialog();
            update_device_detail_list();
            update_data_grid_view();
            if (device_detail.Count > 0)
                select_row_on_dgv(0);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            for (int ctr = 0; ctr < device_detail.Count; ctr++)
            {
                DataView.Rows[ctr].Cells[4].Style.ForeColor = Color.Black;
                DataView.Rows[ctr].Cells[4].Value = string.Empty;
                DataView.Rows[ctr].Selected = false;
            }

            if (!is_group_command(current_command))
            {
                MessageBox.Show("پخش گروهي براي اين دستور امكان پذير نمي باشد");
                select_row_on_dgv(0);
                return;
            }
            do_appropriate_change_on_start_sending();
            mode = send_mode.sned_to_selected_device;
 
            current_device_index = -1;
            mode_investigate_and_do_appropriate_action();
        }

        private void DataView_CellDoubleClick_1(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
                DataView.Rows[e.RowIndex].Selected = true;
        }

        private void pnl_card_limit_Paint(object sender, PaintEventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void numericUpDown3_ValueChanged(object sender, EventArgs e)
        {

        }

        private void comboBox1_Leave(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem.ToString() == Z84Family.TerminalPrinter.LQ_Printer.ToString())
                printer = Z84Family.TerminalPrinter.LQ_Printer;
            if (comboBox1.SelectedItem.ToString() == Z84Family.TerminalPrinter.LX_Printer.ToString())
                printer = Z84Family.TerminalPrinter.LX_Printer;
            if (comboBox1.SelectedItem.ToString() == Z84Family.TerminalPrinter.Star_Printer.ToString())
                printer = Z84Family.TerminalPrinter.Star_Printer;
        }

        private void radioButton4_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetPrinter;
        }

        private void radioButton1_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.PrintData;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            lbx_only_card.Items.Clear();
            update_only_card_list(only_cards.GetGroup());
        }

        private void rdb_clear_all_card_message_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void radioButton3_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetCardLimit;
        }

        private void radioButton2_Click(object sender, EventArgs e)
        {
            //current_command = Z84Family.DeviceCommand.getcardlimi
        }

        private void inp_cardlimit_from_Leave(object sender, EventArgs e)
        {
            if (inp_cardlimit_from.Text.Length > 8)
            {
                MessageBox.Show("لطفا شماره كارت را تصحيح نماييد");
                inp_cardlimit_from.Focus();
            }
            else
                card_limit_start = new CardNumber(Utility.ChangeToDecimal(inp_cardlimit_from.Text));
           
            
        }

        private void inp_cardlimit_to_Leave(object sender, EventArgs e)
        {
            if (inp_cardlimit_to.Text.Length > 8)
            {
                MessageBox.Show("لطفا شماره كارت را تصحيح نماييد");
                inp_cardlimit_to.Focus();
            }
            else
                card_limit_end = new CardNumber(Utility.ChangeToDecimal(inp_cardlimit_to.Text));
           
        }

        private void inp_recovery_date_Leave(object sender, EventArgs e)
        {
            if (!Utility.IsDateString(inp_recovery_date.Text))
            {
                MessageBox.Show("لطفا تاريخ را تصحيح نماييد");
                inp_recovery_date.Focus();
            }
            else            
                recovery_date_time = Utility.GenerateDateTime(inp_recovery_date.Text , "10:10:10");
                    
        }

        private void inp_recovery_date_TextChanged(object sender, EventArgs e)
        {

        }
        
        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            DB p = new DB();
            if (p.ShowDialog() == DialogResult.OK)
            {
                update_device_detail_list_FromDB();
                update_data_grid_view();
            }
        }
     

        private void buttonBar2_ItemClick(object sender, Janus.Windows.ButtonBar.ItemEventArgs e)
        {
            int i = 0, j = 0;
            i = e.Item.Index;
            j = e.Item.Group.Index;
            switch (j)
            {


                case 0:
                    {
                        if (i == 0)
                        {
                            label29.Text = "تنظیمات بانک اطلاعاتی";
                            DB p = new DB();
                            if (p.ShowDialog() == DialogResult.OK)
                            {
//                                InitializeComponent();
                                if (!Directory.Exists(Constant.ConfigFileDirectory))
                                    Directory.CreateDirectory(Constant.ConfigFileDirectory);

                                if (!File.Exists(Constant.DBConfigFilePath))
                                    return;
                                string[] detail = File.ReadAllLines(Constant.DBConfigFilePath);
                                string ConnStr = "Trusted_Connection=no;connection timeout=10;";
                                for (int t = 0; t < detail.Length; t++)
                                {
                                    if (detail[t].Equals("Server Name:"))
                                        ConnStr = ConnStr + "server=" + detail[t + 1].Trim() + ";";
                                    if (detail[t].Equals("Database Name:"))
                                        ConnStr = ConnStr + "database=" + detail[t + 1].Trim() + ";";
                                    if (detail[t].Equals("User Name:"))
                                        ConnStr = ConnStr + "user id=" + detail[t + 1].Trim() + ";";
                                    if (detail[t].Equals("Password:"))
                                    {
                                        DB.Encryption64 oEs = new DB.Encryption64();
                                        string txtPassText;
                                        txtPassText = oEs.Decrypt(detail[t + 1].Trim(), Constant.encryptKey);
                                        ConnStr = ConnStr + "password=" + txtPassText + ";";
                                        //                    ConnStr = ConnStr + "password=" + detail[t + 1].Trim() + ";";
                                    }
                                }

                                if (myConnection.State != ConnectionState.Open)
                                    myConnection.ConnectionString = ConnStr;
                                else
                                {
                                    myConnection.Close();
                                    myConnection.ConnectionString = ConnStr;
                                }
                                if (logConnection.State != ConnectionState.Open)
                                    logConnection.ConnectionString = ConnStr;
                                else
                                {
                                    logConnection.Close();
                                    logConnection.ConnectionString = ConnStr;
                                }
//                                myConnection = new SqlConnection(ConnStr);
//                                logConnection = new SqlConnection(ConnStr);
                                try
                                {
                                    if (myConnection.State != ConnectionState.Open)
                                        myConnection.Open();
                                    update_device_detail_list();
                                    update_data_grid_view();
                                    if (device_detail.Count > 0)
                                        DataView.Rows[0].Selected = true;
                                }
                                catch (Exception ex)
                                {
                                    device_detail.Clear();
                                    DataView.Rows.Clear();
                                    MessageBox.Show(ex.Message, "مشکل ارتباط با بانک اطلاعاتی");
//                                    update_device_detail_list();
//                                    update_data_grid_view();
                                }

//                                    update_device_detail_list();
//                                    update_data_grid_view();
                            }
//                            p.ShowDialog();
                        }
                        if (i == 1)
                        {
                            label29.Text = "تعريف دستگاه";
                            PhisycalLayer p = new PhisycalLayer();
                            p.update_form(PhisycalLayer.FormType.Create);
                            p.ShowDialog();
                            update_device_detail_list();
                            update_data_grid_view();
                            if (DataView.Rows.Count != 0)
                                DataView.Rows[0].Selected = true;

                        }

                        if (i == 2)
                        {
                            label29.Text = "نمايش اطلاعات خام";
                            //  if (row_data.Checked)
                            form_raw_data.Show();
                            // else
                            //    form_raw_data.Hide();
                        }

                        if (i == 3)

                            this.Close();

                    }
                    break;




                case 1:
                    {
                        if (i == 0)
                        {
                            label29.Text = "تست ارتباط";
                            current_command = Z84Family.DeviceCommand.LinkTest;
                            show_no_data_panel();
                        }
                        if (i == 1)
                        {
                            label29.Text = "راه اندازی دستگاه";
                            current_command = Z84Family.DeviceCommand.Reset;
                            show_no_data_panel();
                        }

                        if (i == 2)
                        {
                            label29.Text = "خواندن نسخه";
                            current_command = Z84Family.DeviceCommand.ReadVersion;
                            show_no_data_panel();
                        }

                        if (i == 3)
                        {
                            label29.Text = "مقدار دهی اولیه";
                            current_command = Z84Family.DeviceCommand.ReInitialization;
                            show_no_data_panel();
                        }
                    }
                    break;



                case 2:
                    {
                        if (i == 0)
                        {
                            show_panel_set_address();
                            label29 .Text ="تنظیم آدرس";
                        }
                        if (i == 1)
                        {
                            label29 .Text ="تنظیم سرعت";
                            show_panel_set_baud();
                        }

                        if (i == 2)
                        {
                            label29 .Text ="زمان پایانه";
                            show_panel_set_time();
                            set_date_time = Utility.GenerateDateTime(inp_date.Text, inp_time.Text);

                        }

                        if (i == 3)
                        {
                            label29 .Text ="رمز عبور";
                            show_panel_kb_pw();
                        }
                        if (i == 4)
                        {
                            label29.Text = "محدوده زمانی فعالیت کارتخوانها";
                            show_panel_Time_limit();
                        }

                    }
                    break;






                case 3:
                    {
                        if (i == 0)
                        {
                            label29 .Text ="کد دسترسی";
                            show_panel_access_code();
                        }
                        if (i == 1)
                        {
                            label29 .Text ="زنگ";
                            show_panel_alarm();
                        }
                    }
                    break;





                case 4:
                    {
                        if (i == 0)
                        {
                            label29 .Text ="صفحه نمایش";
                            show_panel_screen();
                        }
                        if (i == 1)
                        {
                            label29 .Text ="چاپگر";
                            show_panel_printer();
                        }
                        if (i == 2)
                        {
                            label29.Text ="درب";
                            show_panel_door();
                        }


                    }
                    break;

                case 5:
                    {
                        if (i == 0)
                        {
                            label29 .Text ="جمع آوری";
                            show_panel_collection();
                        }
                        if (i == 1)
                        {
                         label29 .Text ="بازیابی";
                            show_panel_recovery();
                        }
                    }
                    break;


                case 6:

                    if (i == 0)
                    {
                        label29 .Text ="پیش کارت ها";
                        show_panel_precard();
                    }
                    if (i == 1)
                    {
                        label29 .Text ="پیام";
                        show_panel_card_message();
                    }

                    if (i == 2)
                    {
                        label29 .Text ="محدوده کارت";
                        show_panel_card_limit();
                    }
                    if (i == 3)
                    {
                        label29 .Text ="کارت های مجاز";
                        show_panel_authirity_cards();
                        current_command = Z84Family.DeviceCommand.GetAuthorityList;
                        rdb_get_authoriity_cars.Checked = true;
                    }
                    if (i == 4)
                    {
                        label29 .Text ="کارت های غیر مجاز";
                        show_panel_nonauthorized_codes();
                    }

                    break;

            }           
            
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button14_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void rdb_sendcardlimit_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void rdb_getcardlimit_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void rdb_recovery_by_date_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void rdb_setTimeLimit_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.SetTimeLimit;
        }

        private void rdb_GetTimelimit_Click(object sender, EventArgs e)
        {
            current_command = Z84Family.DeviceCommand.GetTimeLimit;
        }

        private void textBox6_TextChanged(object sender, EventArgs e)
        {

        }

        private void DataView_Enter(object sender, EventArgs e)
        {
//            update_device_detail_list_FromDB();
//            update_data_grid_view();
        }
        
    }

}