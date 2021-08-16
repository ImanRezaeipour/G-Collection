using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public class AuthorizedCardGroup
    {
         public enum AuthorizedCardStatus
        {
            AuthorizedGroupIsValid = 0,
            AuthorizedGroupIsInvalid
        }

        private ArrayList card_list = new ArrayList();
        private AuthorizedCardStatus group_status;

        private void initial()
        {
            group_status = AuthorizedCardStatus.AuthorizedGroupIsValid;
            card_list.Clear();
        }

        public AuthorizedCardGroup()
        {
            initial();
        }

        public Boolean Add(UInt64 Card)
        {
            if (card_list.Count >= 10)
                return false;
            CardNumber temp = new CardNumber(Card);
            if (temp.Status == CardNumber.CardNumberStatus.CardNumberIsInvalid)
            {
                group_status = AuthorizedCardStatus.AuthorizedGroupIsInvalid;
                temp.Number = 0;
            }
            card_list.Add(temp.Number);
            return true; ;
        }
        public ArrayList GetGroup()
        {
           ArrayList temp = new ArrayList();
           temp = (ArrayList) card_list.Clone();
           int tt = card_list.Count;
           for (int t = 0; t < 10 - tt; t++)
               temp.Add(0);
           return temp;
        }
      

        public void EmptyGroup()
        {
            initial();
        }
        public AuthorizedCardStatus Status
        {
            get
            {
                return group_status; ;
            }
        }

    }
}
