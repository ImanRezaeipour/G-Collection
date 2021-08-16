using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public class AcccessCodeGroup
    {
        public enum AccessCodeGroupStatus
        {
            AccessGroupIsValid = 0,
            AccessGroupIsInvalid
        }

        private ArrayList access_codes = new ArrayList();
        private AccessCodeGroupStatus group_status;

        

        private void initial()
        {
            access_codes.Clear();
            group_status = AccessCodeGroupStatus.AccessGroupIsValid;
        }

        public AcccessCodeGroup()
        {
            initial();          
        }

        public Boolean AddDecimal(UInt64 Code)
        {
            if (access_codes.Count >= 5)
                return false;
            if (Code > 0xffff)
            {
                access_codes.Add(0);
                group_status = AccessCodeGroupStatus.AccessGroupIsInvalid;
            }
            else
            {
                access_codes.Add(Code);
            }
            return true; ;
        }

        public Boolean AddHex(UInt64 Code)
        {
            if (access_codes.Count >= 5)
                return false;
            if (Code > 0xffff)
            {
                access_codes.Add(0);
                group_status = AccessCodeGroupStatus.AccessGroupIsInvalid;
            }
            else
            {
                access_codes.Add(Code);
            }
            return true; ;
        }
        public ArrayList GetGroup()
        {
           ArrayList temp = new ArrayList();
           temp.Clear();
           temp = (ArrayList)access_codes.Clone();
           int tt = access_codes.Count;
           for (int t = 0; t < 5 - tt; t++)
                temp.Add(0);
           return temp;            
        }

        public void EmptyGroup()
        {
            initial();
        }
        public AccessCodeGroupStatus Status
        {
            get
            {
                return group_status;
            }
        }

    }
}
