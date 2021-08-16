using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public class AuthorityListGroup
    {
        public enum AuthorizedListStatus
            {
                AuthorizedGroupIsValid = 0,
                AuthorizedGroupIsInvalid
            }

            private ArrayList card_list = new ArrayList();
            private AuthorizedListStatus group_status;

            private void initial()
            {
                group_status = AuthorizedListStatus.AuthorizedGroupIsValid;
                card_list.Clear();
            }

            public AuthorityListGroup()
            {
                initial();
            }

            public Boolean Add(UInt64 Card)
            {
                if (card_list.Count >= 17)
                    return false;
                CardNumber temp = new CardNumber(Card);
                if (temp.Status == CardNumber.CardNumberStatus.CardNumberIsInvalid)
                {
                    group_status = AuthorizedListStatus.AuthorizedGroupIsInvalid;
                    temp.Number = 0;
                }
                card_list.Add(temp.Number);
                return true; 
            }
            public ArrayList GetGroup()
            {
                ArrayList temp = new ArrayList();
                temp = (ArrayList)card_list.Clone();
                return temp;
            }


            public void EmptyGroup()
            {
                initial();
            }
            public AuthorizedListStatus Status
            {
                get
                {
                    return group_status;
                }
            }

        }
    
}
