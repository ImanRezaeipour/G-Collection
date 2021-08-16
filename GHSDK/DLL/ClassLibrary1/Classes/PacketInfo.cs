using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public class PacketInfo
    {
        UInt64 command_id;
        string command_name;
        string description;
        ArrayList data = new ArrayList();
        private int index = 0;
        UInt32 data_cluster = 0;
        UInt32 data_cell=0;

        public UInt32 DataCluster
        {
            get
            {
                return data_cluster;
            }
            set
            {
                data_cluster = value;
            }
        }

        public UInt32 DataCell
        {
            get
            {
                return data_cell;
            }
            set
            {
                data_cell = value;
            }
        }

        public Object GetFirsrObject()
        { 
            index = 0;
            return data[0];           
        }

        public Object GetNextObject()
        {
            if (index < data.Count)
            {
                index++;
                return data[index];
            }
            return 0;
        }

        public PacketInfo()
        {
            Reset();
        }

        public UInt64 Command
        {
            set
            {
                command_id = Convert.ToUInt64(value);
            }
            get
            {
                return command_id;
            }
        }

        public string Description
        {
            set
            {
                description = value;
            }
            get
            {
                return description;
            }
        }

        public string Name
        {
            set
            {
                command_name = value;
            }
            get
            {
                return command_name;
            }
        }

        public void Reset()
        {
            data_cell = 0;
            data_cluster = 0;
            index = 0;
            command_name = string.Empty;
            command_id = 0;
            description = string.Empty;
            data.Clear();
        }
        public void AddData(Object Data)
        {
            data.Add(Data);
        }
        public ArrayList GetEntireData()
        {
            ArrayList temp = new ArrayList();
            temp = data;
            return data;
        }





    }
}
