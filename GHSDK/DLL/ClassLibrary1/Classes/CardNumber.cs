using System;
using System.Collections.Generic;
using System.Text;

namespace Ghadir_UI
{
    public class CardNumber
    {
        public enum CardNumberStatus
        {
            CardNumberIsValid=0,
            CardNumberIsInvalid
        }
        private void initial()
        {
            card_number = 0x0;
            card_status = CardNumberStatus.CardNumberIsValid;
        }

        public CardNumber()
        {
            initial();
        }

        public CardNumber(UInt64 CardNumber)
        {
            Number = CardNumber;
        }

        private CardNumberStatus card_status;
        private UInt64 card_number;

        public UInt64 Number
        {
            set
            {
                if (card_number > 0xffffffff)
                {
                    card_number = 0;
                    card_status = CardNumberStatus.CardNumberIsInvalid;
                }
                else
                {
                    card_status = CardNumberStatus.CardNumberIsValid;
                    card_number = value;
                }
            }
            get
            {
                return card_number;
            }
        }

        public CardNumberStatus Status
        {
            get
            {
                return card_status;
            }
        }
    }
}
