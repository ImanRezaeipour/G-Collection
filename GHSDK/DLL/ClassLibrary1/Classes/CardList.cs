using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public class CardListGroup
    {
         public enum CardListGroupStatus
        {
            CardListGroupIsValid = 0,
            CardListGroupIsInvalid
        }

        private ArrayList card_list = new ArrayList();
        private CardListGroupStatus group_status;
      
        public CardListGroup()
        {
            initial();           
        }

        private void initial()
        {
            group_status = CardListGroupStatus.CardListGroupIsValid;
            card_list.Clear();
        }
        
        public void Add(UInt64 Card)
        {
            CardNumber temp = new CardNumber(Card);
            if (temp.Status == CardNumber.CardNumberStatus.CardNumberIsInvalid)
            {
                group_status = CardListGroupStatus.CardListGroupIsInvalid;
                temp.Number = 0;
            }
            card_list.Add(temp.Number);
        }

        public ArrayList GetGroup()
        {
            ArrayList temp = new ArrayList();
            temp = card_list;
            return temp;
        }

        public void EmptyGroup()
        {
            initial();
        }
        public CardListGroupStatus Status
        {
            get
            {
                return group_status; ;
            }
        }
    }
}
