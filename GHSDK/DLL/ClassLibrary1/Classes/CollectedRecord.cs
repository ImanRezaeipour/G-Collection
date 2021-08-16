using System;
using System.Collections.Generic;
using System.Text;

namespace Ghadir_UI
{
    public class OneRecord
    {
        private string terminal_adress;
        private string card_status;
        private string date;
        private string time;
        private string card_number;

        public string TerminalAddress
        {
            get
            {
                return terminal_adress;
            }
            set
            {
                terminal_adress = value;
            }
        }
        public string CardStstus
        {
            get
            {
                return card_status;
            }
            set
            {
                card_status = value;
            }
        }
        public string Date
        {
            get
            {
                return date;
            }
            set
            {
                date = value;
            }
        }
        public string Time
        {
            get
            {
                return time;
            }
            set
            {
                time = value;
            }
        }
        public string CardNumber
        {
            get
            {
                return card_number;
            }
            set
            {
                card_number = value;
            }
        }
    }
}
