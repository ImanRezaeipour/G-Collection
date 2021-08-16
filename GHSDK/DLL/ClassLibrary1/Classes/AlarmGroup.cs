using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

    namespace Ghadir_UI
    {
        public class AlarmGroup
        {
            public enum AlarmGroupStatus
            {
                AlarmGroupIsValid = 0,
                AlarmGroupIsInvalid
            }

            private ArrayList alarms = new ArrayList();
            private AlarmGroupStatus group_status;

            private void initial()
            { 
                alarms.Clear();
                group_status = AlarmGroupStatus.AlarmGroupIsValid; 
            }

            public AlarmGroup()
            {
                initial();              
            }

            public Boolean Add(UInt64 Hour,UInt64 Minute,UInt64 Duration)
            {
                if (alarms.Count >= 15)
                    return false;
                if (Hour > 24 || Minute >60 || Duration >0xffff)
                {
                    alarms.Add(0);
                    group_status = AlarmGroupStatus.AlarmGroupIsInvalid;
                }
                else
                {
                    UInt64 temp;
                    temp=Hour*256*256*256 + Minute*256*256+Duration;
                    alarms.Add(temp);
                }
                return true; ;
            }

            public ArrayList GetGroup()
            {
                ArrayList temp = new ArrayList();
                temp = (ArrayList)alarms.Clone();
                int cnt = alarms.Count;
                for (int t = 0; t < 15 - cnt; t++)
                    temp.Add(0);
                return temp;                
            }

            public void EmptyGroup()
            {
                initial();
            }
            public AlarmGroupStatus Status
            {
                get
                {
                    return group_status;
                }
            }


        }
    }


